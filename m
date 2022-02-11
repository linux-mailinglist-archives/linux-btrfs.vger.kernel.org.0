Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7474B2AB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351641AbiBKQnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 11:43:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbiBKQnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 11:43:31 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C07C102
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 08:43:26 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id A6A8D9B8C1; Fri, 11 Feb 2022 16:43:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644597804;
        bh=P/T36sMiLcw9fcBKmUvnbZ+hSWWL691TbbR73F/I1G4=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=h4Ce9Fx81jiPaNAZdbFRhFzfzcN4MG0PmiP9fF+xf2ZPvPg6jwM+bYdFgvy9BFHTD
         AtiXDBH4aEsfGRwK6OTrGI/OWSbT+QqDY6T4clt5F0emAflf2xzLXjBNozT9BxxxFO
         7j8nswoVEZg/0hPYFk4kSuxbyNmVt0Ibfj8e5wIIFsstVZgioBpVfgQoDiQ76uA9Pz
         EKA94OFuS/fYDinYITkDr7YO5K7Hlg6e+wautZU4dRaI5ftEdqrNdQXvFKTBGcJcQd
         N7paLAE0iOO0/WfmkoYMxxU/aPtshCg0MEpkFqK67msZRw6LckoQRUp9wm8dvhzSI/
         pprmVF6YklieQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A830F9B89E;
        Fri, 11 Feb 2022 16:42:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644597778;
        bh=P/T36sMiLcw9fcBKmUvnbZ+hSWWL691TbbR73F/I1G4=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=KITo/a+rQN492ftNDtsfZEwQNjUP117OsHU4nc+1Pncxd0GVwhUaPpuWmU4GFtlLM
         2moMIYE6+BUOBa/U0SGqdbrGF42u1FSAhNSg+fKVHVrBoepo7/FmfHrsK9RSM7+JYZ
         6jBUrLq4DguXzufPa2ZMtnmARrwgkn4zENIu4LwqFhLbUFaPrTIpnZKaI2ygNxmfkj
         OLwJ+7qndD04PwTwV+f534t5d665613KRPZYk9DEA/0Zt4ysTnfZakr7nSX81JFkLI
         1fq5Bpne1OCvrnFQdNa/d8d5Oyye2dddNMrnq4+ipIHqkrIW3iJwWs2VO9uWtKW9T8
         gcQjHy4pahm/A==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 5B08D11F5C1;
        Fri, 11 Feb 2022 16:42:57 +0000 (GMT)
Message-ID: <3c5b83dc-86f5-bedf-d1ba-71b05d0f19fa@cobb.uk.net>
Date:   Fri, 11 Feb 2022 16:42:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH v2] btrfs: Fix subvol turns RO if root is remounted RO
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
References: <20220211140918.c6wpmh3pgzjuytve@fiona>
In-Reply-To: <20220211140918.c6wpmh3pgzjuytve@fiona>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 11/02/2022 14:09, Goldwyn Rodrigues wrote:
> If a read-write root mount is remounted as read-only, the subvolume
> is also set to read-only.
> 
> Use a rw_mounts counter to check the number of read-write mounts, and change
> superblock to read-only only in case there are no read-write subvol mounts.
> Disable SB_RDONLY in flags passed so superblock does not change
> read-only.
> 
> 
> Test case:
> DEV=/dev/vdb
> mkfs.btrfs -f $DEV
> mount $DEV /mnt
> btrfs subvol create /mnt/sv
> mount -o remount,ro /mnt
> mount -o subvol=/sv $DEV /mnt/sv
> findmnt # /mnt is RO, /mnt/sv RW
> mount -o remount,ro /mnt
> findmnt # /mnt is RO, /mnt/sv RO as well
> umount /mnt{/sv,}
> 
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a2991971c6b5..2bb6869f15af 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
>  	spinlock_t zone_active_bgs_lock;
>  	struct list_head zone_active_bgs;
>  
> +	/* Count of subvol mounts read-write */
> +	int rw_mounts;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 33cfc9e27451..2072759d5f22 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
>  	/* mount_subvol() will free subvol_name and mnt_root */
>  	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
>  
> +	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
> +		fs_info->rw_mounts++;
> +	}
> +
>  out:
>  	return root;
>  }
> @@ -1958,6 +1963,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		goto out;
>  
>  	if (*flags & SB_RDONLY) {
> +
> +		if (--fs_info->rw_mounts > 0) {
> +			*flags &= ~SB_RDONLY;
> +			goto out;
> +		}
>  		/*
>  		 * this also happens on 'umount -rf' or on shutdown, when
>  		 * the filesystem is busy.
> @@ -2057,6 +2067,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  		if (ret)
>  			goto restore;
>  
> +		fs_info->rw_mounts++;
> +
>  		btrfs_clear_sb_rdonly(sb);
>  
>  		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
> 

I'm sorry my earlier email wasn't clear. I still believe this is an
unacceptable change in behaviour, unless I am misunderstanding.

Let me provide a short testcase to clarify my understanding and my
objection:

Assume we have a device /dev/test.

Current behaviour:

  mkfs.btrfs /dev/test
  mkdir /mnt /mnt/1 /mnt/2
  mount /dev/test /mnt/1
  btrfs subv create /mnt/1/a
  btrfs subv create /mnt/1/b
  btrfs subv create /mnt/1/a/aa
  mount -o subvol=a /dev/test /mnt/2

  touch /mnt/1/a/x /mnt/1/b/x /mnt/1/a/aa/x /mnt/2/xx /mnt/2/aa/xx

All 5 files can be created. I can create files in all three subvolumes
accessed as /mnt/1/a, /mnt/1/b, /mnt/1/a/aa, /mnt/2 or /mnt/2/aa.

  mount -o remount,ro /mnt/1
(or "mount -o remount,ro /mnt/2" the result is the same)

  touch /mnt/1/a/x /mnt/1/b/x /mnt/1/a/aa/x /mnt/2/xx /mnt/2/aa/xx

I cannot now create files in any of the three subvolumes accessed as
/mnt/1/a, /mnt/1/b, /mnt/1/a/aa, /mnt/2 or /mnt/2/aa.

New behaviour:

It is not immediately clear to me what your proposed change will do.
Will it result in all access via /mnt/1 (for example to /mnt/1/a/x)
being read-only but access via /mnt/2 to the same file (for example
/mnt/2/x) being read-write?

Or will it result in access to the directory /mnt/1 itself being
read-only but access to the (subvolume) directories /mnt/1/a,
/mnt/1/a/aa and /mnt/1/b will be read-write? Please explain. [I think
this point is worth clarifying in the patch if it goes ahead - it is not
obvious whether the counter is a count of mount points or subvolumes]

I think either would be unacceptable changes - existing systems, scripts
and procedures have been created around the assumption that changing
*any* mount point to readonly makes the whole volume readonly. This may
not be ideal but it is existing behaviour, and is very simple to understand.

I would also like to understand how the system manager would make the
whole volume go readonly with your patch. Taking into account that there
may have also been mounts in other namespaces, associated with
containers and not directly visible.

Graham
