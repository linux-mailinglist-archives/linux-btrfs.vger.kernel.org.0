Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607403404AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCRLd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 07:33:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:54861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhCRLdA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 07:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616067174;
        bh=pVZcL652aD3mRP9WKN/hcPcZT1rHw80yfArU5c3BHKM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ApfPhL+CDPsGdgMWGfiXuMaqykD0m5tGvvlRi1gGv0P4YVKCO77ySNlUWNaL2XEJH
         EeC4ccUYf8ACIRwbNds5f9InIGB2TTbtOkndjIUT6rZXZJOS2Z7clA29bopa4357h9
         JDKxhV0498WLceu1TGsxqRNl+a7obWC/HoDk969Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1m3YdM1YTt-00q9GM; Thu, 18
 Mar 2021 12:32:53 +0100
Subject: Re: [PATCH] btrfs: fix sleep while in non-sleep context during qgroup
 removal
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <206d121e2e2b609ffe31217e6d90bfabe1c4e121.1616066404.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7fe296bd-db33-9a43-6bb2-472ad216c3b7@gmx.com>
Date:   Thu, 18 Mar 2021 19:32:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <206d121e2e2b609ffe31217e6d90bfabe1c4e121.1616066404.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y02M5rklUH0R1sLwlJMLADhDYviYJUGkjh/3bHX4wGLK0pbdSkh
 1mR3FuUsS+RZtRRbpdS0dRRWLB3kIMOICIhJK4lYUTDajkmlPND95ZcQqyj71gRUS0VE3wv
 nlfMRx6zFHb81IsQW55R4U4cX1uKE9rDRol7kIVSGSP8Yg7SQUALMpxhoqyEfrmzp0aw2j5
 UPvmK5FVKStQjgRw5pmag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:98+u3NJP50I=:P3LmjwFSeaQUq8qlLH5Shv
 eX+sl78hOAxMhbRMi/b9HNAmUMkgF3gxYNTUmIf4/G60BziDU/gk7Ik7gWlcKVJ7sbvLbK2aF
 mivH3NpXbn6C9ZK1GU3VntKU/KiRSW2TTPYzdK/MDM5ddi06azyyn8w1EOIolXuJbtkWtBzws
 JPUxisn2Rvg09q6hK3ZlUQP6jzt51az2KwTMynfZINHsBwsgDYipqzYSR85Lcs3yOQs3RNxWK
 QaSKvQC4Dk9Rs9upuw0wONj9AWYnIKqWW1ukMyfVTUv1McG+9UYcZqnCayKc8Ej8cTqMwoEkH
 T3MH/sDGhCt/IRjHA88pE78dQznSoPZftnY7ms8nHHhFowPVL9IaesA+NzDA4HoJyh8osre3V
 z9ncqeWTlfYh1iVuwtoSqGupLiWeLgjoEFD7Pon4t8NQ7+xdR9eIwYZIpaoChokxbwcWf7eiO
 xdLqGU3t6FdlnXNC20twLmG2d5zLKFsQhHCG6Jtm93LueUgerbwRdHh8BBg0BS61xxvRL3C5n
 cKPPrQIyZNBSdELLAbxR73B2V74FR9Xi3QhQ9XaiU4w2UycxZ/IKGA5Vx9rfNQWlRiBSyhrr0
 OIf9D9wOY+KN9fg/GV4+8AaR3SbZ69H7ACtEb+mGySTpJ2xssp0MJkhJS79QAQVeZmDvmpLhu
 0j0+0ANYI28v61gtQI5dK5UOWU7i79sr2h1GBhGis/WFCOxG3dXDe8wg+JN4qkwcfHoPfwcRc
 tHL1GdJSLIBnqKjvSLuVM+jX1qH6waV+cAQapo1UVT4ZATPKvGDbQ6XmXJKwCyttbk93+ASbi
 X02BmM6aK89Zyyo5+OiG0ibcD7502ucLWvSiT0/iAT7SqXH1V8WVL6fdixv66JOK6UejiteHh
 awSJAKnD8jHkodczqbwlNbBZkJFJfCbqr0/QmQR+dlrxa2lzbWG2W5F9eJ3+tDh1G7NGoVoTC
 juKC3eUQ/CbQVKNwOQb/Lt+CZ5rv4uffQUMyHR4n/HJZoR7QBAGEGogpyLERbJfCpdwL+9bpF
 gdFzxIRAFmOv1moHzH89ANCV5O0ANWcpVCgKIX9ksYPtkPjGzcYmEYePYpcY34PWHDHhG6amN
 NcwRUu5zFPDpUIxjZ2sRRXeP+2hBIVrPxsWI3rJbI4hnokGSC1R9iz+k97/my+CEXJC1uAvRK
 V4/gfQnO0hKyUBFiJIRvTKOh0xEKt+mQqe6Iy7V082W84DiCFQyRAR/uwqLDLNiVox8rIHlVp
 /Ww23s3Z1h8ZD6DFe
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/18 =E4=B8=8B=E5=8D=887:22, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> While removing a qgroup's sysfs entry we end up taking the kernfs_mutex,
> through kobject_del(), while holding the fs_info->qgroup_lock spinlock,
> producing the following trace:
>
> [  821.843637] BUG: sleeping function called from invalid context at ker=
nel/locking/mutex.c:281
> [  821.843641] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 28=
214, name: podman
> [  821.843644] CPU: 3 PID: 28214 Comm: podman Tainted: G        W       =
  5.11.6 #15
> [  821.843646] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS 2.11=
.0 12/08/2020
> [  821.843647] Call Trace:
> [  821.843650]  dump_stack+0xa1/0xfb
> [  821.843656]  ___might_sleep+0x144/0x160
> [  821.843659]  mutex_lock+0x17/0x40
> [  821.843662]  kernfs_remove_by_name_ns+0x1f/0x80
> [  821.843666]  sysfs_remove_group+0x7d/0xe0
> [  821.843668]  sysfs_remove_groups+0x28/0x40
> [  821.843670]  kobject_del+0x2a/0x80
> [  821.843672]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
> [  821.843685]  __del_qgroup_rb+0x12/0x150 [btrfs]
> [  821.843696]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
> [  821.843707]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
> [  821.843717]  ? __mod_lruvec_page_state+0x5e/0xb0
> [  821.843719]  ? page_add_new_anon_rmap+0xbc/0x150
> [  821.843723]  ? kfree+0x1b4/0x300
> [  821.843725]  ? mntput_no_expire+0x55/0x330
> [  821.843728]  __x64_sys_ioctl+0x5a/0xa0
> [  821.843731]  do_syscall_64+0x33/0x70
> [  821.843733]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  821.843736] RIP: 0033:0x4cd3fb
> [  821.843739] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb =
55 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05=
 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [  821.843741] RSP: 002b:000000c000906b20 EFLAGS: 00000206 ORIG_RAX: 000=
0000000000010
> [  821.843744] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: 00000000=
004cd3fb
> [  821.843745] RDX: 000000c000906b98 RSI: 000000004010942a RDI: 00000000=
0000000f
> [  821.843747] RBP: 000000c000907cd0 R08: 000000c000622901 R09: 00000000=
00000000
> [  821.843748] R10: 000000c000d992c0 R11: 0000000000000206 R12: 00000000=
0000012d
> [  821.843749] R13: 000000000000012c R14: 0000000000000200 R15: 00000000=
00000049
>
> Fix this by removing the qgroup sysfs entry while not holding the spinlo=
ck,
> since the spinlock is only meant for protection of the qgroup rbtree.
>
> Reported-by: Stuart Shelton <srcshelton@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/7A5485BB-0628-419D-A4D3-27B1AF=
47E25A@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9d8d1ac86962..2319c923c9e6 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -227,7 +227,6 @@ static void __del_qgroup_rb(struct btrfs_fs_info *fs=
_info,
>   {
>   	struct btrfs_qgroup_list *list;
>
> -	btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
>   	list_del(&qgroup->dirty);
>   	while (!list_empty(&qgroup->groups)) {
>   		list =3D list_first_entry(&qgroup->groups,
> @@ -244,7 +243,6 @@ static void __del_qgroup_rb(struct btrfs_fs_info *fs=
_info,
>   		list_del(&list->next_member);
>   		kfree(list);
>   	}
> -	kfree(qgroup);
>   }
>
>   /* must be called with qgroup_lock held */
> @@ -570,6 +568,8 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *=
fs_info)
>   		qgroup =3D rb_entry(n, struct btrfs_qgroup, node);
>   		rb_erase(n, &fs_info->qgroup_tree);
>   		__del_qgroup_rb(fs_info, qgroup);
> +		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
> +		kfree(qgroup);
>   	}
>   	/*
>   	 * We call btrfs_free_qgroup_config() when unmounting
> @@ -1579,6 +1579,14 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
>   	spin_lock(&fs_info->qgroup_lock);
>   	del_qgroup_rb(fs_info, qgroupid);
>   	spin_unlock(&fs_info->qgroup_lock);
> +
> +	/*
> +	 * Remove the qgroup from sysfs now without holding the qgroup_lock
> +	 * spinlock, since the sysfs_remove_group() function needs to take
> +	 * the mutex kernfs_mutex through kernfs_remove_by_name_ns().
> +	 */
> +	btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
> +	kfree(qgroup);
>   out:
>   	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>   	return ret;
>
