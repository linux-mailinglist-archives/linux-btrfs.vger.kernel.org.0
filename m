Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619C0F5DD2
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 08:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfKIHg3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 02:36:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:54067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfKIHg3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 Nov 2019 02:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573284983;
        bh=Craf9bgSeHKK+mK8psdgcn4URoAghZ3CQJKWMLGqy7A=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iHfL3z0JUcWzX38iIpDkm04g65ii7kpVPNyZTsMkVpUCV91u4ywqTh1qsWT9bd9nn
         R5bhgE06ogl/1E9pOyzdX4ByHLJBn+keXsAXE2Uo0tpXqLE/1wwgowdxAaFpe6ttLI
         Ho69DLZ5DkEzuxhX7FeLg8skIVSRxkyZ+deKqkwQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.164] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvPD-1iJbxj2Boj-00RpQv; Sat, 09
 Nov 2019 08:36:23 +0100
Subject: Re: [PATCH] Btrfs: fix log context list corruption after rename
 exchange operation
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20191108161156.2342-1-fdmanana@kernel.org>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <7f2cfcee-4a06-d2db-7703-a26eb89cda50@gmx.com>
Date:   Sat, 9 Nov 2019 15:36:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191108161156.2342-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EwAysbEPqSdeCtLKpCoJgR73LSecbbLOCjtKXlBg6C9PBIY6WVi
 g74deomH0mmCyjqIqQe4/EzXcKltsJDpcyVMlZJZEs2XKeIY2VaD8e94lZ3t1bXOerKMs0i
 nMuEouMcq88RMqLRqyQlSusJq145ii0f7mhzofZ7gWhrPsE7dVkzWDbXHChSF/sfymlSNfI
 35o6UZ5nNLblB7vs9P+GQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rnT8a8ew95s=:Hbr4HXnyIVajFUNEtYWZ1K
 3+sMpnl74Nmxi5Ukdk5FlUAz19HnFMimL9NfiJloqtY14JCcUNpXP4gLHCe5gbMh8eNdaPj++
 K10dlVR08Ytn+0IKdb5IE3X7IyENIMacfuNFw+9t3yOZRGwlpklJLx7FbchAjWA0EaqpYopqC
 7Zd8s1mEGxe08npSzWk4cX4+ofln4kKhbhk8GuLUflXTBteYNSjpu6P9tz8txPmFVoHzMFXta
 aoPRf5v2HtPmaxj6913DBTgZ3TjSjC3Ukyb5SdDDRkKqtULDHN0DMuBR5cmSgZr7NgFGu4cua
 urFPOVu+6oil2paE8jUmXaQdpYZ6CWoVpJJTu91e6VqNQP53hG2gYt5+Qo0Ni0ihii7HCvHz2
 iou8d8CItx/42cGHfzjf+fUWFx1N9Yc7NOQY5xvIUqUMUQL+Gdu4p4xj3tjB7G18/2cxd4Vz6
 t3ZLKzluRO7EAxb2WvlI92zyo8B41WSmGcKtu4vvYGab8nfRLrEGJp8BJGRjePH/IeX+UIm2C
 kvmji/vBq8cjagh82gFPPdYxS1t1H1+t1Z4MqG9xhXHM1MbkqzFIIMKVVjZ2F+ykuSN7aG7Dv
 GY0ZmWzob2x3e6eMiCzTIOhRY1IXaUoZk6spahLQY/0/rdhUzx2ZGEngQKGaP+ZOLgbYO/U9I
 8EyaEc3/IfpwPAtMlpqTNZ/ns/vjY9bZRJJasVG6j7CKo8B8cwpM3OQCMeu4uwRolhCXtW4T7
 qau1aSHUCMaJqKAHe1MmhWDXRJd4gR3dRXgBYetg8aFvKPfh0IspGT+Vt8RxiQqrAqKwLD8vJ
 aEQiuVahKiIg9je1RLE8wa1V0KFBoI4CluSMAUGyg9PQOfyvrFpMg+95/3Zk+Dqc0iqR/OKSO
 nrWnpaPT+tIezqFqv3OPwJOKfFl7WUGFtGsK2sfiqUJAvrRgRlR+RiXtu+3Saa6NDeiVzFHRx
 gWiSZPDFwFNpD0OUk3i//n0p5bPA0N9qYnNWhWhtLRKr9/RLVP2vkhvJTBp2Q371P/LfUhJKS
 /sF6kPEwpf5s9ZfnKF48wCV9mJJZ3yAO1dlGTmn0WCoW84ErzcxPhEdZj6NsIM/vHNymzNu6p
 4nEhoK8t0xwc1Zc8YbsebC3ZvBmgD/Ej94UrqtdUXDAil1LyaFackAWeexmOcCbNYyPcNH9AO
 iNpRh1aFwN8hd+Qg95quP0OppJOS3KxaLenqF5SJRWMXohbBJUQLc9/cyyC+WIXprgZwaNHsH
 0UBiDaZd751e5fWVg2YSS3L0HYNzCJS1V+ja+2tAshjGyskK9B4X51WANMQU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/9 12:11 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> During rename exchange we might have successfully log the new name in th=
e
> source root's log tree, in which case we leave our log context (allocate=
d
> on stack) in the root's list of log contextes. However we might fail to
> log the new name in the destination root, in which case we fallback to
> a transaction commit later and never sync the log of the source root,
> which causes the source root log context to remain in the list of log
> contextes. This later causes invalid memory accesses because the context
> was allocated on stack and after rename exchange finishes the stack gets
> reused and overwritten for other purposes.
>
> The kernel's linked list corruption detector (CONFIG_DEBUG_LIST=3Dy) can
> detect this and report something like the following:
>
>    [  691.489929] ------------[ cut here ]------------
>    [  691.489947] list_add corruption. prev->next should be next (ffff88=
819c944530), but was ffff8881c23f7be4. (prev=3Dffff8881c23f7a38).
>    [  691.489967] WARNING: CPU: 2 PID: 28933 at lib/list_debug.c:28 __li=
st_add_valid+0x95/0xe0
>    (...)
>    [  691.489998] CPU: 2 PID: 28933 Comm: fsstress Not tainted 5.4.0-rc6=
-btrfs-next-62 #1
>    [  691.490001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>    [  691.490003] RIP: 0010:__list_add_valid+0x95/0xe0
>    (...)
>    [  691.490007] RSP: 0018:ffff8881f0b3faf8 EFLAGS: 00010282
>    [  691.490010] RAX: 0000000000000000 RBX: ffff88819c944530 RCX: 00000=
00000000000
>    [  691.490011] RDX: 0000000000000001 RSI: 0000000000000008 RDI: fffff=
fffa2c497e0
>    [  691.490013] RBP: ffff8881f0b3fe68 R08: ffffed103eaa4115 R09: ffffe=
d103eaa4114
>    [  691.490015] R10: ffff88819c944000 R11: ffffed103eaa4115 R12: 7ffff=
fffffffffff
>    [  691.490016] R13: ffff8881b4035610 R14: ffff8881e7b84728 R15: 1ffff=
1103e167f7b
>    [  691.490019] FS:  00007f4b25ea2e80(0000) GS:ffff8881f5500000(0000) =
knlGS:0000000000000000
>    [  691.490021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [  691.490022] CR2: 00007fffbb2d4eec CR3: 00000001f2a4a004 CR4: 00000=
000003606e0
>    [  691.490025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
>    [  691.490027] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
>    [  691.490029] Call Trace:
>    [  691.490058]  btrfs_log_inode_parent+0x667/0x2730 [btrfs]
>    [  691.490083]  ? join_transaction+0x24a/0xce0 [btrfs]
>    [  691.490107]  ? btrfs_end_log_trans+0x80/0x80 [btrfs]
>    [  691.490111]  ? dget_parent+0xb8/0x460
>    [  691.490116]  ? lock_downgrade+0x6b0/0x6b0
>    [  691.490121]  ? rwlock_bug.part.0+0x90/0x90
>    [  691.490127]  ? do_raw_spin_unlock+0x142/0x220
>    [  691.490151]  btrfs_log_dentry_safe+0x65/0x90 [btrfs]
>    [  691.490172]  btrfs_sync_file+0x9f1/0xc00 [btrfs]
>    [  691.490195]  ? btrfs_file_write_iter+0x1800/0x1800 [btrfs]
>    [  691.490198]  ? rcu_read_lock_any_held.part.11+0x20/0x20
>    [  691.490204]  ? __do_sys_newstat+0x88/0xd0
>    [  691.490207]  ? cp_new_stat+0x5d0/0x5d0
>    [  691.490218]  ? do_fsync+0x38/0x60
>    [  691.490220]  do_fsync+0x38/0x60
>    [  691.490224]  __x64_sys_fdatasync+0x32/0x40
>    [  691.490228]  do_syscall_64+0x9f/0x540
>    [  691.490233]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>    [  691.490235] RIP: 0033:0x7f4b253ad5f0
>    (...)
>    [  691.490239] RSP: 002b:00007fffbb2d6078 EFLAGS: 00000246 ORIG_RAX: =
000000000000004b
>    [  691.490242] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007=
f4b253ad5f0
>    [  691.490244] RDX: 00007fffbb2d5fe0 RSI: 00007fffbb2d5fe0 RDI: 00000=
00000000003
>    [  691.490245] RBP: 000000000000000d R08: 0000000000000001 R09: 00007=
fffbb2d608c
>    [  691.490247] R10: 00000000000002e8 R11: 0000000000000246 R12: 00000=
000000001f4
>    [  691.490248] R13: 0000000051eb851f R14: 00007fffbb2d6120 R15: 00005=
635a498bda0
>
> This started happening recently when running some test cases from fstest=
s
> like btrfs/004 for example, because support for rename exchange was adde=
d
> last week to fsstress from fstests.
>
> So fix this by deleting the log context for the source root from the lis=
t
> if we have logged the new name in the source root.
>
> Reported-by: Su Yue <Damenly_Su@gmx.com>
> Fixes: d4682ba03ef618 ("Btrfs: sync log after logging new name")
> CC: stable@vger.kernel.org # 4.19+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Great, thanks for the fix.

Tested-by: Su Yue <Damenly_Su@gmx.com>
> ---
>   fs/btrfs/inode.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2750ae6e907d..28080f0803a1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9734,6 +9734,18 @@ static int btrfs_rename_exchange(struct inode *ol=
d_dir,
>   			commit_transaction =3D true;
>   	}
>   	if (commit_transaction) {
> +		/*
> +		 * We may have set commit_transaction when logging the new name
> +		 * in the destination root, in which case we left the source
> +		 * root context in the list of log contextes. So make sure we
> +		 * remove it to avoid invalid memory accesses, since the context
> +		 * was allocated in our stack frame.
> +		 */
> +		if (sync_log_root) {
> +			mutex_lock(&root->log_mutex);
> +			list_del_init(&ctx_root.list);
> +			mutex_unlock(&root->log_mutex);
> +		}
>   		ret =3D btrfs_commit_transaction(trans);
>   	} else {
>   		int ret2;
> @@ -9747,6 +9759,9 @@ static int btrfs_rename_exchange(struct inode *old=
_dir,
>   	if (old_ino =3D=3D BTRFS_FIRST_FREE_OBJECTID)
>   		up_read(&fs_info->subvol_sem);
>
> +	ASSERT(list_empty(&ctx_root.list));
> +	ASSERT(list_empty(&ctx_dest.list));
> +
>   	return ret;
>   }
>
>
