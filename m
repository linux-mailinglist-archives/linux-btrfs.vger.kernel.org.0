Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E969E254
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjBUOb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjBUOb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:31:28 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1BE29424
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:31:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 243B968AFE; Tue, 21 Feb 2023 15:31:22 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:31:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/12] btrfs: remove a bogus submit_one_bio call in
 read_extent_buffer_subpage
Message-ID: <20230221143121.GB29949@lst.de>
References: <20230216163437.2370948-1-hch@lst.de> <20230216163437.2370948-3-hch@lst.de> <6754b78a-ee58-9054-1494-335f062dd620@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6754b78a-ee58-9054-1494-335f062dd620@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 07:14:09PM +0800, Qu Wenruo wrote:
>
>
> On 2023/2/17 00:34, Christoph Hellwig wrote:
>> The first call to submit_one_bio call in read_extent_buffer_subpage is
>> for a btrfs_bio_ctrl structure that has just been initialized and thus
>> can't have a non-NULL bio, so remove it.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> This new submit_one_bio() is mostly caused by the previous patch.
>
> Can we just fold this one into the previous patch?

I don't think mixing a change in behavior (even if it is a no-op
for the I/O pattern) into a pure refactoring is a good idea.  I've
been arguing about doing this patch first before patch 1 as I've
been expecting this argument, but the current order seems more
obvious to review.  I could switch it around if strongly preferred.

