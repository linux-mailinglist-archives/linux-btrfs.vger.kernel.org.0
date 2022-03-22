Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA64E3CED
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 11:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiCVKtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiCVKtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 06:49:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C617E21
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647946084;
        bh=8WY0dJUDUWWyvMDOpm6MpRV+RrrJ7jZnD9Au2JJ2hFw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k1g5f64HNPYqPKKik67Gi+luLImL5jJBCObqUa5UGaA4D0cdNDSPqw1SSi6AzkxZO
         Srqeca1ACcl34rOyhGh1E1AbSmZ4s9ZrXGJrCCOVBjbMqBA4vpaA4f97Gh1+CwDWyy
         y3tl7BcuCs8TDsMTFimsshpPz9sHJ2W1vuZpfXiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GQs-1oA7md1t0S-014Dsu; Tue, 22
 Mar 2022 11:48:04 +0100
Message-ID: <b1c66869-2920-9055-faa1-a84b05958289@gmx.com>
Date:   Tue, 22 Mar 2022 18:47:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: prevent subvol with swapfile from being deleted
Content-Language: en-US
To:     Kaiwen Hu <kevinhu@synology.com>, linux-btrfs@vger.kernel.org
Cc:     robbieko@synology.com, cccheng@synology.com, seanding@synology.com
References: <20220322102705.1252830-1-kevinhu@synology.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220322102705.1252830-1-kevinhu@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5jnkKdfX21mADYq0i2lkrm/OzPJAvrtB/HDKuxJOzzIhBEgceP
 q+M270maJB1DgRpTzKYMMJVqFV/IhFY5GuhUDfZBRrskhQZ5TloQo1dYjH5Ivbb7GIKM2yd
 EVrn0Whj6zSgOMSFBe7Ke0DQu2320+NQFkiLPnVhjuY3oswZhsFOo9OD/BSH6G3+ocwUwcb
 N7lt5QXScDhq1TYMVGaUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyTR99Ttlfk=:TmkTUg/NsGEF7TZWWjjdDj
 YNpajAVrXFLZqJQOilu44fcHQNCCWZfHM2J5UnwQQYUm7FOlo1nn0qniUXodKGhJGtUDldb+R
 Lu6jIZSKIy6rg8iKGJ937oRfIgaGBybcxQTLMmdFwl4BhFQJUoJPm9Kydjh12VRgHfst2g5DO
 fkAsTgCmhlHYF3l8Gi5cCgMk5iOniu3xQY34tZ7XSE4NkNBzwTnQoESiLZOYd3S12M85/WY/9
 AF4JLuvtzLh47uSxbwuV9Up5YOWAzmGZSKvs/rf7zEYAF70Ja3rEwkHmf2TLMqeq6XbK3XoqM
 BEkya+nhhxINpyJYxdebF0xJ7bLhhkXbSq5aQk5tIUvQOUo8FZYTJeQN2HWLs5zBfP0ahAUIs
 CC9uCu2LBvFzt9JBpdriEMoFr035J+Dkf5a6Zm5FzDK9Aw6WmAYj5FYmGPvN+vIhBper/KFmF
 INGjVmB3TrgpufAU3qQgaahyzSsXfXmliNN9AxTccF4N7j/s/NRWxGN0agrnM1PZX3J/5G/N9
 JeYU8a0eckLnZqX4A+JpLrEYZDBrwEd65B1P3Aw8b9OoeYgwz79IbY4TyvcXHWnhJ0my4Zsqc
 Kv6egeMq3aV9uSM3H/Mnn5pTv+VALmlSdglTG/QI5GDEtBXAOxNjFbFFphi8E1oozqd8pwx5D
 TPWCX6QIwNQyrjXilZ1/BWm7MXIUJTWpe51z1NSFhCAJLOlFuRFvwoyDLi+2zLLP6vk4HW/d5
 DkgD8u7RL7RGTSYpbEXZwjcg18LmIuzdkog/N/ROILDtEH0at6APD/X9gk5/pYBtnLR2U8iND
 5xLl2IW57pMgKPsFPOPhBo8SZclSMSTNioerUF68Wh86g8w2Ff8e93GON2rug8gnx5ZGYaDhm
 JVzbDwpVGUW1DRVRAZU6L5wwlaL88V9k5MU0lenKgVAWzM6ysLEpa+Uvv9yyNVT46GhK74ro0
 5+WyzYaTHtl5gsLZMYU0Y6qh9D891iLkYtzOHZnmIJ56uNLnJukxXQeC3e89L1IJf/N14QpNZ
 LDJPdIqkpowt2NiT884/HEB9F1YTdHm4Nbx0mq8goty1qNWqQQhbSwyDxB+n6M0aIvoEmH4ta
 twLSY2tKTUVDGw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/22 18:27, Kaiwen Hu wrote:
> This patch prevent subvol being deleted when the subvol contains
> any active swapfile.
>
> Since the subvolume is deleted, we cannot swapoff the swapfile in
> this deleted subvolume.  However, the swapfile is still active,
> we unable to unmount this volume.  Let it into some deadlock
> situation.
>
> The test looks like this:
> 	mkfs.btrfs -f $dev > /dev/null
> 	mount $dev $mnt
>
> 	btrfs sub create $mnt/subvol
> 	touch $mnt/subvol/swapfile
> 	chmod 600 $mnt/subvol/swapfile
> 	chattr +C $mnt/subvol/swapfile
> 	dd if=3D/dev/zero of=3D$mnt/subvol/swapfile bs=3D1K count=3D4096
> 	mkswap $mnt/subvol/swapfile
> 	swapon $mnt/subvol/swapfile
>
> 	btrfs sub delete $mnt/subvol
> 	swapoff $mnt/subvol/swapfile  // failed: No such file or directory
> 	swapoff --all
>
> 	unmount $mnt  // target is busy.
>
> To prevent above issue, we simply check that whether the subvolume
> contains any active swapfile, and stop the deleting process.  This
> behavior is like snapshot ioctl dealing with a swapfile.
>
> Signed-off-by: Kaiwen Hu <kevinhu@synology.com>
> ---
>   fs/btrfs/inode.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5bbea5ec31fc..e388b9043710 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4460,6 +4460,12 @@ int btrfs_delete_subvolume(struct inode *dir, str=
uct dentry *dentry)
>   			   dest->root_key.objectid);
>   		return -EPERM;
>   	}
> +	if (atomic_read(&dest->nr_swapfiles)) {
> +		spin_unlock(&dest->root_item_lock);
> +		btrfs_warn(fs_info,
> +			   "attempt to delete subvolume with active swapfile");
> +		return -ETXTBSY;
> +	}

This part looks fine to me.

>   	root_flags =3D btrfs_root_flags(&dest->root_item);
>   	btrfs_set_root_flags(&dest->root_item,
>   			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
> @@ -10419,7 +10425,17 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
>   	 * before walking the extents because we don't want a concurrent
>   	 * snapshot to run after we've already checked the extents.
>   	 */
> +	spin_lock(&root->root_item_lock);
> +	if (btrfs_root_dead(root)) {

This looks a little weird to me.

If the root is already dead, it means we should not be able to access
any file inside the subvolume.

How could we go into btrfs_swap_activate() while the root is already dead?

Or is there some special race I missed?

Thanks,
Qu

> +		spin_unlock(&root->root_item_lock);
> +		btrfs_exclop_finish(fs_info);
> +		btrfs_warn(fs_info,
> +	   "cannot activate swapfile because subvolume is marked for deletion"=
);
> +		return -EINVAL;
> +	}
>   	atomic_inc(&root->nr_swapfiles);
> +	spin_unlock(&root->root_item_lock);
> +
>
>   	isize =3D ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
>
