Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1666E38B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jan 2023 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjAQQ1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Jan 2023 11:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjAQQ12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Jan 2023 11:27:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3353FF32
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jan 2023 08:27:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15F783895B;
        Tue, 17 Jan 2023 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673972764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aOXQT7wuSha7tbs1gi/X6QNCe98QcFDbwWFhtp5+N9o=;
        b=judBzSJ6b36sQRgPCGyKWoOAyYJ+rmFdtZkzYfW4YqG71efzGPRjofiCDYgVWF04H9Lfpn
        Db6R45+wN6p3/d0xBgmTZ4n/H8lTXSn7YEo9/NPg5FuJWhu6wKNdVTLgWYEvTv4hcQeacZ
        b6bof3CImP/Okh6ICvEXfHnJJ5LpdtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673972764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aOXQT7wuSha7tbs1gi/X6QNCe98QcFDbwWFhtp5+N9o=;
        b=xySnGIKYaua+hHOiM1lhbxYtsv1JV8CBjhrV/Pb3uUaTg/RhWq13wevwuGuk/BYbbYhCOE
        jfYnvhvNTKCyfAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E548513357;
        Tue, 17 Jan 2023 16:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C7sCNxvMxmPHbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 Jan 2023 16:26:03 +0000
Date:   Tue, 17 Jan 2023 17:20:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: update fs features sysfs directory
 asynchronously
Message-ID: <20230117162025.GB11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c750a14702a842dcd359b05ee79700ae0d0f550f.1673608117.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c750a14702a842dcd359b05ee79700ae0d0f550f.1673608117.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 13, 2023 at 07:11:39PM +0800, Qu Wenruo wrote:
> [BUG]
> >From the introduction of per-fs feature sysfs interface
> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
> updated.
> 
> Thus for the following case, that directory will not show the new
> features like RAID56:
> 
>  # mkfs.btrfs -f $dev1 $dev2 $dev3
>  # mount $dev1 $mnt
>  # btrfs balance start -f -mconvert=raid5 $mnt
>  # ls /sys/fs/btrfs/$uuid/features/
>  extended_iref  free_space_tree  no_holes  skinny_metadata
> 
> While after unmount and mount, we got the correct features:
> 
>  # umount $mnt
>  # mount $dev1 $mnt
>  # ls /sys/fs/btrfs/$uuid/features/
>  extended_iref  free_space_tree  no_holes  raid56 skinny_metadata
> 
> [CAUSE]
> Because we never really try to update the content of per-fs features/
> directory.
> 
> We had an attempt to update the features directory dynamically in commit
> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
> files"), but unfortunately it get reverted in commit e410e34fad91
> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
> 
> The exported by never utilized function, btrfs_sysfs_feature_update() is
> the leftover of such attempt.
> 
> The problem in the original patch is, in the context of
> btrfs_create_chunk(), we can not afford to update the sysfs group.
> 
> As even if we go sysfs_update_group(), new files will need extra memory
> allocation, and we have no way to specify the sysfs update to go
> GFP_NOFS.

We do have a way now, the memalloc_nofs_save/_restore interface that was
not available back then.

> [FIX]
> This patch will address the old problem by doing asynchronous sysfs
> update in cleaner thread.
> 
> This involves the following changes:
> 
> - Make __btrfs_(set|clear)_fs_(incompat|compat_ro) helpers to set
>   BTRFS_FS_FEATURE_CHANGED flag when needed
> 
> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>   And drop unnecessary arguments.
> 
> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>   If we have the BTRFS_FS_FEATURE_CHANGED flag set.
> 
> - Wake up cleaner_kthread in btrfs_commit_transaction if we have
>   BTRFS_FS_FEATURE_CHANGED flag
> 
> By this, all the previously dangerous call sites like
> btrfs_create_chunk() need no new changes, as above helpers would
> have already set the BTRFS_FS_FEATURE_CHANGED flag.
> 
> The real work happens at cleaner_kthread, thus we pay the cost of
> delaying the update to sysfs directory, but the delayed time should be
> small enough that end user can not distinguish.

Cleaner is not a bad first choice, though it can get busy with a lot of
work with cleanings subvolumes and defrag, so the actual change in sysfs
cannot be predicted. The transaction kthread can also try to check for
the presence of the BTRFS_FS_FEATURE_CHANGED bit and do the change
there.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -130,6 +130,12 @@ enum {
>  	BTRFS_FS_32BIT_ERROR,
>  	BTRFS_FS_32BIT_WARN,
>  #endif
> +
> +	/*
> +	 * Indicate if we have some features changed, this is mostly for
> +	 * cleaner thread to update the sysfs interface.
> +	 */
> +	BTRFS_FS_FEATURE_CHANGED,

Please keep the BTRFS_FS_32BIT_ last so they don't mix up with the other
bits. Updated.

>  };
>  
>  /*
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..b9f5d1052c0c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2272,36 +2272,23 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>   * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>   * values in superblock. Call after any changes to incompat/compat_ro flags
>   */
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set)
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_fs_devices *fs_devs;
>  	struct kobject *fsid_kobj;
> -	u64 __maybe_unused features;
> -	int __maybe_unused ret;
> +	int ret;
>  
>  	if (!fs_info)
>  		return;
>  
> -	/*
> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
> -	 * safe when called from some contexts (eg. balance)
> -	 */
> -	features = get_features(fs_info, set);
> -	ASSERT(bit & supported_feature_masks[set]);
> -
> -	fs_devs = fs_info->fs_devices;
> -	fsid_kobj = &fs_devs->fsid_kobj;
> -
> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>  	if (!fsid_kobj->state_initialized)
>  		return;
>  
> -	/*
> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
> -	 * to use sysfs_update_group but some refactoring is needed first.
> -	 */
> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
> +	if (ret < 0)
> +		btrfs_err(fs_info,
> +			  "failed to update /sys/fs/btrfs/%pU/features: %d",
> +			  fs_info->fs_devices->fsid, ret);

Is the error level necessary? It's not a serious problem, I'd rather
make it a warning.

Otherwise OK, the stale status wrt features is finally fixed, thanks. I
checked the fix I'd worked on. It built on top of the (now removed)
pending operations, your approach is similar and just moves the unsafe
part to the cleaner.

A stable backport would be good too, but I see that this patch fails
even on 6.1 due to the moved code in 6.2.
