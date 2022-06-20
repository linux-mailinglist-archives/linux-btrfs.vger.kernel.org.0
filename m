Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B217551199
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiFTHha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiFTHha (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 03:37:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80939EE32
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 00:37:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D9CE68AA6; Mon, 20 Jun 2022 09:37:26 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:37:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
Message-ID: <20220620073725.GA11832@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-7-hch@lst.de> <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 19, 2022 at 06:45:11PM +0800, Qu Wenruo wrote:
>> Transfer the bio counter reference acquired by btrfs_submit_bio to
>> raid56_parity_write and raid56_parity_recovery together with the bio that
>> the reference was acuired for instead of acquiring another reference in
>> those helpers and dropping the original one in btrfs_submit_bio.
>
> Btrfs_submit_bio() has called btrfs_bio_counter_inc_blocked(), then call
> btrfs_bio_counter_dec() in its out_dec: tag.
>
> Thus the bio counter is already paired.
>
> Then why we want to dec the counter again in RAID56 path?
>
> Or did I miss some patches in the past modifying the behavior?

The behviour before this patch is:

btrfs_submit_bio does:

	btrfs_bio_counter_inc_blocked
	call raid56_parity_write / raid56_parity_recover
	btrfs_bio_counter_dec

raid56_parity_write / raid56_parity_recover then do:

	btrfs_bio_counter_inc_noblocked
	btrfs_bio_counter_dec on error only

The new behavior is:

btrfs_submit_bio does:

	btrfs_bio_counter_inc_blocked
	call raid56_parity_write / raid56_parity_recover
	return

raid56_parity_write / raid56_parity_recover then do:

	btrfs_bio_counter_dec on error only

so no change in the final number of reference, but on less inc/dec
pair for the successful submission fast path.
