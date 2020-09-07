Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3326074F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 01:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIGX66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 19:58:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgIGX64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 19:58:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087NnlH2149438;
        Mon, 7 Sep 2020 23:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6CFb0BRsXdlAJnXE+I/Y2v5GbooOgc4n36IGMvJK+zI=;
 b=yXGzJddZe3QEVEDc6KMI2/qizcQwbfBW1qI/1vHVWxVWZUSFYL84oHI0xrBSh4SGcyIw
 cJY0Qqfja0U3jv1b+t/5wg0szOtk+Wrxz2WOyiyriRSh0u3wfcHEjVBf+deM3IjqMHkm
 HFsrmAQQXwiHlPiK/7fqdGU/HyoIPvKB7obG7rgaBg9bvAag3YswlV3JVuoC4zLq8CXj
 WyTSIKw3PkJgP2J+6znN7+Z0pJcD5/ua0y6kZW0xB1PZkvHSBeUx0uwhdJHCkpcoDiXX
 jGD5F4tjgi5xwYwQbAyXNlm5RbeaNHjgYDMttdiiJMuZZNwRZ6htoGbUSc7AC6DsF5Hq 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33c23qrdjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 23:58:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087NtWl5027777;
        Mon, 7 Sep 2020 23:56:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33dach42u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 23:56:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 087Nuphw005028;
        Mon, 7 Sep 2020 23:56:51 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Sep 2020 16:56:51 -0700
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference after failure to
 create snapshot
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200904162257.123893-1-fdmanana@kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <37402255-fc3d-cd6a-5360-cf2ee9acccc7@oracle.com>
Date:   Tue, 8 Sep 2020 07:56:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200904162257.123893-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070233
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=2 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070232
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/9/20 12:22 am, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When trying to get a new fs root for a snapshot during the transaction
> at transaction.c:create_pending_snapshot(), if btrfs_get_new_fs_root()
> fails we leave "pending->snap" pointing to an error pointer, and then
> later at ioctl.c:create_snapshot() we dereference that pointer, resulting
> in a crash:
> 
> [12264.614689] BUG: kernel NULL pointer dereference, address: 00000000000007c4
> [12264.615650] #PF: supervisor write access in kernel mode
> [12264.616487] #PF: error_code(0x0002) - not-present page
> [12264.617436] PGD 0 P4D 0
> [12264.618328] Oops: 0002 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [12264.619150] CPU: 0 PID: 2310635 Comm: fsstress Tainted: G        W         5.9.0-rc3-btrfs-next-67 #1
> [12264.619960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [12264.621769] RIP: 0010:btrfs_mksubvol+0x438/0x4a0 [btrfs]
> [12264.622528] Code: bc ef ff ff (...)
> [12264.624092] RSP: 0018:ffffaa6fc7277cd8 EFLAGS: 00010282
> [12264.624669] RAX: 00000000fffffff4 RBX: ffff9d3e8f151a60 RCX: 0000000000000000
> [12264.625249] RDX: 0000000000000001 RSI: ffffffff9d56c9be RDI: fffffffffffffff4
> [12264.625830] RBP: ffff9d3e8f151b48 R08: 0000000000000000 R09: 0000000000000000
> [12264.626413] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffff4
> [12264.626994] R13: ffff9d3ede380538 R14: ffff9d3ede380500 R15: ffff9d3f61b2eeb8
> [12264.627582] FS:  00007f140d5d8200(0000) GS:ffff9d3fb5e00000(0000) knlGS:0000000000000000
> [12264.628176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12264.628773] CR2: 00000000000007c4 CR3: 000000020f8e8004 CR4: 00000000003706f0
> [12264.629379] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [12264.629994] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [12264.630594] Call Trace:
> [12264.631227]  btrfs_mksnapshot+0x7b/0xb0 [btrfs]
> [12264.631840]  __btrfs_ioctl_snap_create+0x16f/0x1a0 [btrfs]
> [12264.632458]  btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
> [12264.633078]  btrfs_ioctl+0x1864/0x3130 [btrfs]
> [12264.633689]  ? do_sys_openat2+0x1a7/0x2d0
> [12264.634295]  ? kmem_cache_free+0x147/0x3a0
> [12264.634899]  ? __x64_sys_ioctl+0x83/0xb0
> [12264.635488]  __x64_sys_ioctl+0x83/0xb0
> [12264.636058]  do_syscall_64+0x33/0x80
> [12264.636616]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> (gdb) list *(btrfs_mksubvol+0x438)
> 0x7c7b8 is in btrfs_mksubvol (fs/btrfs/ioctl.c:858).
> 853		ret = 0;
> 854		pending_snapshot->anon_dev = 0;
> 855	fail:
> 856		/* Prevent double freeing of anon_dev */
> 857		if (ret && pending_snapshot->snap)
> 858			pending_snapshot->snap->anon_dev = 0;
> 859		btrfs_put_root(pending_snapshot->snap);
> 860		btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
> 861	free_pending:
> 862		if (pending_snapshot->anon_dev)
> 
> So fix this by setting "pending->snap" to NULL if we get an error from the
> call to btrfs_get_new_fs_root() at transaction.c:create_pending_snapshot().
> 
> Fixes: 2dfb1e43f57dd3 ("btrfs: preallocate anon block device at first phase of snapshot creation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/transaction.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 8e4cd2d782c6..52ada47aff50 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1639,6 +1639,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>   	pending->snap = btrfs_get_new_fs_root(fs_info, objectid, pending->anon_dev);
>   	if (IS_ERR(pending->snap)) {
>   		ret = PTR_ERR(pending->snap);
> +		pending->snap = NULL;
>   		btrfs_abort_transaction(trans, ret);
>   		goto fail;
>   	}
> 


Looks good to fix the bug. But I wonder, isn't it better to check for 
IS_ERR_OR_NULL as below, because %pending_snapshot->snap is pointer 
carrying error.

-----------------------------------
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5f06aeb71823..15ece0628965 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -854,7 +854,7 @@ static int create_snapshot(struct btrfs_root *root, 
struct inode *dir,
         pending_snapshot->anon_dev = 0;
  fail:
         /* Prevent double freeing of anon_dev */
-       if (ret && pending_snapshot->snap)
+       if (ret && !IS_ERR_OR_NULL(pending_snapshot->snap))
                 pending_snapshot->snap->anon_dev = 0;
         btrfs_put_root(pending_snapshot->snap);
         btrfs_subvolume_release_metadata(root, 
&pending_snapshot->block_rsv);
-----------------------------------

Anyway as patch looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


