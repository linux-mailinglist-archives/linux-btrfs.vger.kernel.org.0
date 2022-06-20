Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED955174C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 13:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiFTLXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbiFTLXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 07:23:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5713613CF0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 04:23:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C56C068AA6; Mon, 20 Jun 2022 13:23:37 +0200 (CEST)
Date:   Mon, 20 Jun 2022 13:23:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Message-ID: <20220620112337.GA16136@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-11-hch@lst.de> <bc18e270-371c-98ee-28c2-fd4305206d7a@suse.com> <20220620085340.GA13344@lst.de> <8b478441-ab11-575b-5dba-1136a26cfc35@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b478441-ab11-575b-5dba-1136a26cfc35@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 20, 2022 at 12:34:48PM +0300, Nikolay Borisov wrote:
> write to a RAID1 fs. So we have to do 2 writes - 1 of the orig bio, 1 of a 
> stripe bio so we make 1 clone of the orig bio, call bio_inc_remaining and 
> orig_bio->__bi_remaining is 2. So the 2 bios get submitted.

Yes.

> If the stripe bio is completed first 'if (bio != orig_bio) {' check in 
> btrfs_end_bio ensures that the function is really a noop. Subsequently when 
> orig_bio is completed it proceeds to executed:
>
> orig_bio->bi_end_io(orig_bio);

Yes.

> Consider the same scenario, but this time if orig_bio is completed first 
> then we proceed directly calling orig_bio->bi_end_io(orig_bio);

No, it doesn't.  When the low-level block driver calls bio_endio for
orig_bio, bio_endio calls bio_remaining_done which does an atomic
atomic_dec_and_test, which returns false because __bi_remaining is still
1 after the call.  That causes bio_endio to just return and not call
->bi_end_io.  Only when the cloned bio completes and calls bio_endio on
orig_bio again (from btrfs_end_bio) that atomic_dec_and_test now
returns true and ->bi_end_io is called on the orig_bio.

> bypassing 
> bio_endio and the __bi_remaining checks etc. So shouldn't this
> orig_bio->bi_end_io(orig_bio);  be converted to bio_endio call ?

The orig_bio->bi_end_io(orig_bio) from btrfs_end_bio and
btrfs_end_bio_work is weird.  It used to be a bio_endio call before
this series, but that is actualy wrong as the bio has already been
completed.  The bio is done and we just need to propagate it to the
submitter of the original btrfs_bio.  The right thing would be to
call this as:

	bioc->end_io(orig_bio);

but doing so would break the repair code that has way too much
magic behavior for its own sake.
