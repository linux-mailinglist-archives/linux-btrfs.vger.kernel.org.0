Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6E43DB9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1HBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 03:01:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:36845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1HBU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 03:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635404331;
        bh=Brq78Mkb4gMb5TGWVuBoemDTWk5hVfPPHx4sAQuGNtI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=UOeIdecpaZ7NAMprkdjCCtcXFhhbafxDB2aot3qQi+yqVQufjmTyvEB/iSeGIXoY7
         /3Uow1ROQWfYat3ePQfETwdZs72EFFJrHGq04o7A5lKkJqITaQjDuUfTPZJr97LqOd
         sF7xQhRddj65hd6UqivY6wPgl3iCzcJOw3RPeOcQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNsw4-1mHjMI15su-00OEio; Thu, 28
 Oct 2021 08:58:50 +0200
Message-ID: <984ea4d2-c943-cdc9-232d-2f11b3d256c7@gmx.com>
Date:   Thu, 28 Oct 2021 14:58:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] btrfs: fix deadlock between quota enable and other quota
 operations
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <3df4731012ac6dc17f9f3a33c519735fbe89fc84.1635355240.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3df4731012ac6dc17f9f3a33c519735fbe89fc84.1635355240.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WW0xQO8GJFQ20MMw3emMDbMhlLhpQDIwLn/EuPNgVGzJ8EalOzS
 YSaSouqFeLLDu/Qh0bUxVVaX90FYqzCXgUUCDqfJRP2/r+1ZXg6zMgkIPu7EBVxorQxABRD
 eWdOWTQZQGdzBh7ZeT6DBWoaMjs8qv5PLkaouB13WSqvWK++6CiDOqke0HBVVnFGwtauNVX
 Fh8ZEBFn22lRvNSoLF8Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m0AN+O5boyM=:0nj/Gqb9RckdokgZU3B0Dm
 cA2zXef7YkgIvR1isRLKd/sCDP1UT2+GKLiDc9ScZcKhjLdvozjP5/zlOZM87gulVAv5RkVjL
 vhUAgLwRAcf/57XpWV+IifrD5CUpeutYHjq6iipj637gyhHEFIyPqSa+Y87gF2mEUZcREfJla
 lTnSJ6zDvfwN4dVzAOfPrud4KHfIH99YLea7/ahWhbOYBQ5+yQMs2XqqHjgh3cdBRLxA3eNwk
 3rIeD90JErtdK40Xh67tV+4QZDsM7vDf5sLzw5M7dYm9rhxNfWVgqNUfVTUXQrQP40Kb+BdQO
 NL+Frv2zKkkvjq3r7ibbJz95emWkZq2e9+EilBUPJTELriCL8W0UHtd61JDbjEXiel0GqBzDH
 fTKBiVXE5rkUJ0q9dv8Nty6vakwdPDOLDBzaRGridQ6VFF+DbVHcWviYCo7RCQ1EvQqBpnHOz
 SkUTQvxDKDAU34mEYhs3l4TrmQkUvKGxcnnDzo+EzyhawlNjZ0vtRbO6COgoMEC8lYOW8aMxB
 SfVQ5xDNhntRL2ZtlkyT6C19qdONDLrRBRn4AcPB/lHl55IeNn2CzVxY2+dgOHNHg8aGyuD+H
 qX6u6dU9+yxOHBf97heoX//n5KcbJRa7iyfRsW6d2S+GIhMbhpYZCMPkhqaJasRUG7BNNny8w
 O9yndSX+/2blKCJFSJ8ulqdz5d+/sf3/6/VbokbsohpnPGGgqAFq9/6gojaY9rwF/giySUEpZ
 D1E60Nt52Cg4nsHP9NWUhI5QrbFGQtaMC1k2zSv6TcT2GdPFzMJk4LmT4UUH/7cTXoq1UWKhI
 ViEo5AtnrpncOyOcuUBYZ+7F69D05/mxP2kBu81Y4ppG7ATbCspukDl8rlpnLpRV9zzTFOGiY
 ZhPC71mg66CcrQRU2+AfF+WnO/z4VIwkrew7wE185yD02ANEbvciEPBikGOmGIQ9/jQXQ8Iop
 LqAayQR5s8KgX7M9kWpreQZCVsj5vJqM11hJ9BQdz7qiHSSzzHeS6Wc6Ar92/WumJ9OlhoqzY
 BgckHTJQRUp3DkrBrXLPuZRivetC/5+IoGgDJ6XnwKDuvGGkRQXt6YbjIM90a8bUKlzDHqtQv
 v+b8vSWyNPHhDQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/28 01:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When enabling quotas, we attempt to commit a transaction while holding t=
he
> mutex fs_info->qgroup_ioctl_lock. This can result on a deadlock with oth=
er
> quota operations such as:
>
> - qgroup creation and deletion, ioctl BTRFS_IOC_QGROUP_CREATE;
>
> - adding and removing qgroup relations, ioctl BTRFS_IOC_QGROUP_ASSIGN.
>
> This is because these operations join a transaction and after that they
> attempt to lock the mutex fs_info->qgroup_ioctl_lock. Acquiring that mut=
ex
> after joining or starting a transaction is a pattern followed everywhere
> in qgroups, so the quota enablement operation is the one at fault here,
> and should not commit a transaction while holding that mutex.
>
> Fix this by making the transaction commit while not holding the mutex.
> We are safe from two concurrent tasks trying to enable quotas because
> we are serialized by the rw semaphore fs_info->subvol_sem at
> btrfs_ioctl_quota_ctl(), which is the only call site for enabling
> quotas.
>
> When this deadlock happens, it produces a trace like the following:
>
>    INFO: task syz-executor:25604 blocked for more than 143 seconds.
>    Not tainted 5.15.0-rc6 #4
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
>    task:syz-executor state:D stack:24800 pid:25604 ppid: 24873 flags:0x0=
0004004
>    Call Trace:
>    context_switch kernel/sched/core.c:4940 [inline]
>    __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
>    schedule+0xd3/0x270 kernel/sched/core.c:6366
>    btrfs_commit_transaction+0x994/0x2e90 fs/btrfs/transaction.c:2201
>    btrfs_quota_enable+0x95c/0x1790 fs/btrfs/qgroup.c:1120
>    btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:4229 [inline]
>    btrfs_ioctl+0x637e/0x7b70 fs/btrfs/ioctl.c:5010
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:874 [inline]
>    __se_sys_ioctl fs/ioctl.c:860 [inline]
>    __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>    RIP: 0033:0x7f86920b2c4d
>    RSP: 002b:00007f868f61ac58 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
>    RAX: ffffffffffffffda RBX: 00007f86921d90a0 RCX: 00007f86920b2c4d
>    RDX: 0000000020005e40 RSI: 00000000c0109428 RDI: 0000000000000008
>    RBP: 00007f869212bd80 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86921d90a0
>    R13: 00007fff6d233e4f R14: 00007fff6d233ff0 R15: 00007f868f61adc0
>    INFO: task syz-executor:25628 blocked for more than 143 seconds.
>    Not tainted 5.15.0-rc6 #4
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
>    task:syz-executor state:D stack:29080 pid:25628 ppid: 24873 flags:0x0=
0004004
>    Call Trace:
>    context_switch kernel/sched/core.c:4940 [inline]
>    __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
>    schedule+0xd3/0x270 kernel/sched/core.c:6366
>    schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
>    __mutex_lock_common kernel/locking/mutex.c:669 [inline]
>    __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
>    btrfs_remove_qgroup+0xb7/0x7d0 fs/btrfs/qgroup.c:1548
>    btrfs_ioctl_qgroup_create fs/btrfs/ioctl.c:4333 [inline]
>    btrfs_ioctl+0x683c/0x7b70 fs/btrfs/ioctl.c:5014
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:874 [inline]
>    __se_sys_ioctl fs/ioctl.c:860 [inline]
>    __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CACkBjsZQF19bQ1C6=3DyetF3BvL10=
OSORpFUcWXTP6HErshDB4dQ@mail.gmail.com/

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/qgroup.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index db680f5be745..7f6a05e670f5 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -940,6 +940,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_inf=
o)
>   	int ret =3D 0;
>   	int slot;
>
> +	/*
> +	 * We need to have subvol_sem write locked, to prevent races between
> +	 * concurrent tasks trying to enable quotas, because we will unlock
> +	 * and relock qgroup_ioctl_lock before setting fs_info->quota_root
> +	 * and before setting BTRFS_FS_QUOTA_ENABLED.
> +	 */
> +	lockdep_assert_held_write(&fs_info->subvol_sem);
> +
>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
>   	if (fs_info->quota_root)
>   		goto out;
> @@ -1117,8 +1125,19 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_i=
nfo)
>   		goto out_free_path;
>   	}
>
> +	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> +	/*
> +	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoi=
d
> +	 * a deadlock with tasks concurrently doing other qgroup operations, s=
uch
> +	 * adding/removing qgroups or adding/deleting qgroup relations for exa=
mple,
> +	 * because all qgroup operations first start or join a transaction and=
 then
> +	 * lock the qgroup_ioctl_lock mutex.
> +	 * We are safe from a concurrent task trying to enable quotas, by call=
ing
> +	 * this function, since we are serialized by fs_info->subvol_sem.
> +	 */
>   	ret =3D btrfs_commit_transaction(trans);
>   	trans =3D NULL;
> +	mutex_lock(&fs_info->qgroup_ioctl_lock);
>   	if (ret)
>   		goto out_free_path;
>
>
