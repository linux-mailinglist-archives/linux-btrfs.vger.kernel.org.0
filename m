Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC9730A78
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFNWO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbjFNWOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 18:14:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF519B5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 15:14:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 453731FD9B;
        Wed, 14 Jun 2023 22:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686780893;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKJm7SIIe6u0aO0Q0o0EnbL0JMpuhY7hkiIuDd08wJE=;
        b=OrgOxdkajuvpaX24OJjEJnVbxasYK0uxHNKTa8UG/xG2R/74ZMGW6DVROMXeGeGWaKRsdE
        4jzrCoxcb1vCMIqeCpo4b4kLujKQQZQGQW5mAsCrrakV8o77OQzxwXwZdsp7/JE9bgxgNw
        M4lTh6tts9ojvIumDp47j+kyna91nFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686780893;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKJm7SIIe6u0aO0Q0o0EnbL0JMpuhY7hkiIuDd08wJE=;
        b=FK8AkenGZ8qJHskbg0wgJSfSBktsuDM8BaEqs08xhZ2mcfx526GfdFQYtIBvkKh6kCdPGj
        iteP0pxS9BLPEECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DF1C1357F;
        Wed, 14 Jun 2023 22:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Fh7Bt07imQNQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 22:14:53 +0000
Date:   Thu, 15 Jun 2023 00:08:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Message-ID: <20230614220833.GR13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
 <2ctiwte5bw2mbb3z66tg4lidzrd6qrgcjhewvklc7kq5eqdy65@kwvnoh6ekae4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ctiwte5bw2mbb3z66tg4lidzrd6qrgcjhewvklc7kq5eqdy65@kwvnoh6ekae4>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 02:05:48AM +0000, Naohiro Aota wrote:
> On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> > There is an issue writing out huge buffered data with the compressed mount
> > option on zoned mode. For example, when you buffered write 16GB data and
> > call "sync" command on "mount -o compress" file-system on a zoned device,
> > it takes more than 3 minutes to finish the sync, invoking the hung_task
> > timeout.
> > 
> > Before the patch:
> > 
> >     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
> >     wrote 17179869184/17179869184 bytes at offset 0
> >     16.000 GiB, 2048 ops; 0:00:23.74 (690.013 MiB/sec and 86.2516 ops/sec)
> > 
> >     real    0m23.770s
> >     user    0m0.005s
> >     sys     0m23.599s
> >     + sync
> > 
> >     real    3m55.921s
> >     user    0m0.000s
> >     sys     0m0.134s
> > 
> > After the patch:
> > 
> >     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
> >     wrote 17179869184/17179869184 bytes at offset 0
> >     16.000 GiB, 2048 ops; 0:00:28.11 (582.648 MiB/sec and 72.8311 ops/sec)
> > 
> >     real    0m28.146s
> >     user    0m0.004s
> >     sys     0m27.951s
> >     + sync
> > 
> >     real    0m12.310s
> >     user    0m0.000s
> >     sys     0m0.048s
> > 
> > This slow "sync" comes from inefficient async chunk building due to
> > needlessly limited delalloc size.
> > 
> > find_lock_delalloc_range() looks for pages for the delayed allocation at
> > most fs_info->max_extent_size in its size. For the non-compress write case,
> > that range directly corresponds to num_bytes at cow_file_range() (= size of
> > allocation). So, limiting the size to the max_extent_size seems no harm as
> > we will split the extent even if we can have a larger allocation.
> > 
> > However, things are different with the compression case. The
> > run_delalloc_compressed() divides the delalloc range into 512 KB sized
> > chunks and queues a worker for each chunk. The device of the above test
> > case has 672 KB zone_append_max_bytes, which is equal to
> > fs_info->max_extent_size. Thus, one run_delalloc_compressed() call can
> > build only two chunks at most, which is really smaller than
> > BTRFS_MAX_EXTENT_SIZE / 512KB = 256, making it inefficient.
> > 
> > Also, as 672 KB is not aligned to 512 KB, it is creating ceil(16G / 672K) *
> > 2 = 49934 async chunks for the above case. OTOH, with BTRFS_MAX_EXTENT_SIZE
> > delalloced, we will create 32768 chunks, which is 34% reduced.
> > 
> > This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
> > not directly corresponds to the size of one extent. Instead, this patch
> > will limit the allocation size at cow_file_range() for the zoned mode.
> > 
> > As shown above, with this patch applied, the "sync" time is reduced from
> > almost 4 minutes to 12 seconds.
> > 
> > Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
> > CC: stable@vger.kernel.org # 6.1+
> > ---
> >  fs/btrfs/extent-tree.c |  3 +++
> >  fs/btrfs/extent_io.c   | 11 ++++++++---
> >  fs/btrfs/inode.c       |  5 ++++-
> >  3 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 911908ea5f6f..e6944c4db18b 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -4452,6 +4452,9 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
> >  	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
> >  	bool for_data_reloc = (btrfs_is_data_reloc_root(root) && is_data);
> >  
> > +	if (btrfs_is_zoned(fs_info))
> > +		ASSERT(num_bytes <= fs_info->max_extent_size);
> > +
> 
> BTW, this ASSERT is problematic when it is called from the direct IO
> context. So, we need to rework this patch anyway. Sorry for a confusion.

Ok, patch removed from misc-next.
