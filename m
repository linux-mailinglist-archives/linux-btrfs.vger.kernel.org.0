Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F20C7AB0B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjIVLa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjIVLa1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 07:30:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34791
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 04:30:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1B621FDA9;
        Fri, 22 Sep 2023 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695382220;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+DrrDg4cj1O9CLREi6WmU1HBZa7EzY67UGJ2ChuZ+M=;
        b=FivOIkPHqtxPcsvoYuo/tHpmF8mdHUGormAGKg3CpVnmIkVWVju/8mYfah3g6JKYBzbnEL
        p3OiPGR/7TKDbol5WbXpdz7IvQ0gRK32sKJhPAXKdY2H2OOWRgWAN6eHfyHOAHB/wUQQ2C
        agrscn7g8A0aKy2sfNZwAemV990iBR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695382220;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+DrrDg4cj1O9CLREi6WmU1HBZa7EzY67UGJ2ChuZ+M=;
        b=CE04ZzlElb/MWBd6oQIgVcc21lpaP84GD6Ax9LGNsWCQrhlZOmORjrC2K2mZMAfjQ4ahZL
        G1MUK/kyPpGxkwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1A5313478;
        Fri, 22 Sep 2023 11:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id toqBLct6DWVNHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 11:30:19 +0000
Date:   Fri, 22 Sep 2023 13:23:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: reject device with CHANGING_FSID_V2
Message-ID: <20230922112344.GC13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695244296.git.anand.jain@oracle.com>
 <83e6a50ea2040a27e0dc05a09a9213b79e8938c8.1695244296.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e6a50ea2040a27e0dc05a09a9213b79e8938c8.1695244296.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 05:51:13AM +0800, Anand Jain wrote:
> The BTRFS_SUPER_FLAG_CHANGING_FSID_V2 flag indicates a transient state
> where the device in the userspace btrfstune -m|-M operation failed to
> complete changing the fsid.
> 
> This flag makes the kernel to automatically determine the other
> partner devices to which a given device can be associated, based on the
> fsid, metadata_uuid and generation values.
> 
> btrfstune -m|M feature is especially useful in virtual cloud setups, where
> compute instances (disk images) are quickly copied, fsid changed, and
> launched. Given numerous disk images with the same metadata_uuid but
> different fsid, there's no clear way a device can be correctly assembled
> with the proper partners when the CHANGING_FSID_V2 flag is set. So, the
> disk could be assembled incorrectly, as in the example below:
> 
> Before this patch:
> 
> Consider the following two filesystems:
>    /dev/loop[2-3] are raw copies of /dev/loop[0-1] and the btrsftune -m
> operation fails.
> 
> In this scenario, as the /dev/loop0's fsid change is interrupted, and the
> CHANGING_FSID_V2 flag is set as shown below.
> 
>   $ p="device|devid|^metadata_uuid|^fsid|^incom|^generation|^flags"
> 
>   $ btrfs inspect dump-super /dev/loop0 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop0
>   flags			0x1000000001
>   fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		9
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	1
> 
>   $ btrfs inspect dump-super /dev/loop1 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop1
>   flags			0x1
>   fsid			11d2af4d-1b71-45a9-83f6-f2100766939d
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		10
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	2
> 
>   $ btrfs inspect dump-super /dev/loop2 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop2
>   flags			0x1
>   fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		8
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	1
> 
>   $ btrfs inspect dump-super /dev/loop3 | egrep '$p'
>   superblock: bytenr=65536, device=/dev/loop3
>   flags			0x1
>   fsid			7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
>   metadata_uuid		bb040a9f-233a-4de2-ad84-49aa5a28059b
>   generation		8
>   num_devices		2
>   incompat_flags	0x741
>   dev_item.devid	2
> 
> It is normal that some devices aren't instantly discovered during
> system boot or iSCSI discovery. The controlled scan below demonstrates
> this.
> 
>   $ btrfs device scan --forget
>   $ btrfs device scan /dev/loop0
>   Scanning for btrfs filesystems on '/dev/loop0'
>   $ mount /dev/loop3 /btrfs
>   $ btrfs filesystem show -m
>   Label: none  uuid: 7d4b4b93-2b27-4432-b4e4-4be1fbccbd45
> 	Total devices 2 FS bytes used 144.00KiB
> 	devid    1 size 300.00MiB used 48.00MiB path /dev/loop0
> 	devid    2 size 300.00MiB used 40.00MiB path /dev/loop3
> 
> /dev/loop0 and /dev/loop3 are incorrectly partnered.
> 
> This kernel patch removes functions and code connected to the
> CHANGING_FSID_V2 flag.
> 
> With this patch, now devices with the CHANGING_FSID_V2 flag are rejected.
> And its partner will fail to mount with the extra -o degraded option.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Moreover, a btrfs-progs patch (below) has eliminated the use of the
> CHANGING_FSID_V2 flag entirely:
> 
>    [PATCH] btrfs-progs: btrfstune -m|M remove 2-stage commit
> 
> And we solve the compatability concerns as below:
> 
>   New-kernel new-progs - has no CHANGING_FSID_V2 flag.
>   Old-kernel new-progs - has no CHANGING_FSID_V2 flag, kernel code unused.
>   Old-kernel old-progs - bug may occur.
>   New-kernel old-progs - Should use host with the newer btrfs-progs to fix.
> 
> For legacy systems to help fix such a condition in the userspace instead
> we have the below patchset which ports of kernel's CHANGING_FSID_V2 code.
> 
>    [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
> 
> And if it couldn't fix in some cases, users can use manually reunite,
> with the patchset:
> 
>    [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options
> 
>  fs/btrfs/disk-io.c | 10 ----------
>  fs/btrfs/volumes.c |  7 +++++++
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index dc577b3c53f6..95746ddf7dc3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3173,7 +3173,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	u32 nodesize;
>  	u32 stripesize;
>  	u64 generation;
> -	u64 features;
>  	u16 csum_type;
>  	struct btrfs_super_block *disk_super;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> @@ -3255,15 +3254,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  
>  	disk_super = fs_info->super_copy;
>  
> -
> -	features = btrfs_super_flags(disk_super);
> -	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
> -		features &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
> -		btrfs_set_super_flags(disk_super, features);
> -		btrfs_info(fs_info,
> -			"found metadata UUID change in progress flag, clearing");
> -	}

This is removed from the mount path but it's still rejected because at
some point the device scanning will be called and will return -EINVAL.

> -
>  	memcpy(fs_info->super_for_commit, fs_info->super_copy,
>  	       sizeof(*fs_info->super_for_commit));
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bc8d46cbc7c5..c845c60ec207 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -791,6 +791,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>  					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
>  
> +	if (fsid_change_in_progress) {
> +		btrfs_err(NULL,
> +"device %s has incomplete FSID changes please use btrfstune to complete",

This could say it's specifically metadata_uuid.

> +			  path);
> +		return ERR_PTR(-EINVAL);

We could probably return -EAGAIN as it's not a hard error.

Please let me know if you agree with the changes, I'll fix it in the
commit.
