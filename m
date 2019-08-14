Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78238C58A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfHNB1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:27:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58806 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHNB1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:27:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7E1NNhC028156;
        Wed, 14 Aug 2019 01:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=oBfxM4iCmSZODUpKGv0CHTKHbExeLlmu3eXJ6JOW/oI=;
 b=YjUh1nEAY/vvBl9SDCz943NLVwuVaqC91cyYanvm0WXgbsvOsmwodmec9c9j15Zq/vyV
 3WduVStYaNFkyaGFhc5OFwG0qY8w9rvZASTcizmW222L2f7r6Gj+OvCTDCbBj8CzbSB4
 2/FR6oa+CEAzlGb8nM9GPJHi84BSe9UlQq5PJTOUEHiWTH/ospXXzA2sbOi9C7EUyT0J
 QqiWmKmvZWRg9rpeS9azZD1x/FXmFJFF+5S1LQ2Pf9zYGGL7+FMi2CWAixMzew+qjA0r
 KwQvb5CekEfaMeo6wFj7F/YRXHCMAPkswjx90tjSMVNcQQSksiCc3nwOEk/D9wLfUzg3 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u9nbthn7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 01:27:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7E1NLXO162768;
        Wed, 14 Aug 2019 01:27:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ubwqsgqgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 01:27:02 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7E1R0JE028243;
        Wed, 14 Aug 2019 01:27:01 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 18:27:00 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] Btrfs: fix use-after-free when using the tree
 modification log
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190812181429.11444-1-fdmanana@kernel.org>
Message-ID: <a9d48955-ef27-1ed5-cf47-4df8ef65d1d2@oracle.com>
Date:   Wed, 14 Aug 2019 09:26:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190812181429.11444-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140012
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/8/19 2:14 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At ctree.c:get_old_root(), we are accessing a root's header owner field
> after we have freed the respective extent buffer. This results in an
> use-after-free that can lead to crashes, and when CONFIG_DEBUG_PAGEALLOC
> is set, results in a stack trace like the following:
> 
>    [ 3876.799331] stack segment: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>    [ 3876.799363] CPU: 0 PID: 15436 Comm: pool Not tainted 5.3.0-rc3-btrfs-next-54 #1
>    [ 3876.799385] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>    [ 3876.799433] RIP: 0010:btrfs_search_old_slot+0x652/0xd80 [btrfs]
>    (...)
>    [ 3876.799502] RSP: 0018:ffff9f08c1a2f9f0 EFLAGS: 00010286
>    [ 3876.799518] RAX: ffff8dd300000000 RBX: ffff8dd85a7a9348 RCX: 000000038da26000
>    [ 3876.799538] RDX: 0000000000000000 RSI: ffffe522ce368980 RDI: 0000000000000246
>    [ 3876.799559] RBP: dae1922adadad000 R08: 0000000008020000 R09: ffffe522c0000000
>    [ 3876.799579] R10: ffff8dd57fd788c8 R11: 000000007511b030 R12: ffff8dd781ddc000
>    [ 3876.799599] R13: ffff8dd9e6240578 R14: ffff8dd6896f7a88 R15: ffff8dd688cf90b8
>    [ 3876.799620] FS:  00007f23ddd97700(0000) GS:ffff8dda20200000(0000) knlGS:0000000000000000
>    [ 3876.799643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 3876.799660] CR2: 00007f23d4024000 CR3: 0000000710bb0005 CR4: 00000000003606f0
>    [ 3876.799682] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [ 3876.799703] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [ 3876.799723] Call Trace:
>    [ 3876.799735]  ? do_raw_spin_unlock+0x49/0xc0
>    [ 3876.799749]  ? _raw_spin_unlock+0x24/0x30
>    [ 3876.799779]  resolve_indirect_refs+0x1eb/0xc80 [btrfs]
>    [ 3876.799810]  find_parent_nodes+0x38d/0x1180 [btrfs]
>    [ 3876.799841]  btrfs_check_shared+0x11a/0x1d0 [btrfs]
>    [ 3876.799870]  ? extent_fiemap+0x598/0x6e0 [btrfs]
>    [ 3876.799895]  extent_fiemap+0x598/0x6e0 [btrfs]
>    [ 3876.799913]  do_vfs_ioctl+0x45a/0x700
>    [ 3876.799926]  ksys_ioctl+0x70/0x80
>    [ 3876.799938]  ? trace_hardirqs_off_thunk+0x1a/0x20
>    [ 3876.799953]  __x64_sys_ioctl+0x16/0x20
>    [ 3876.799965]  do_syscall_64+0x62/0x220
>    [ 3876.799977]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>    [ 3876.799993] RIP: 0033:0x7f23e0013dd7
>    (...)
>    [ 3876.800056] RSP: 002b:00007f23ddd96ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 3876.800078] RAX: ffffffffffffffda RBX: 00007f23d80210f8 RCX: 00007f23e0013dd7
>    [ 3876.800099] RDX: 00007f23d80210f8 RSI: 00000000c020660b RDI: 0000000000000003
>    [ 3876.800626] RBP: 000055fa2a2a2440 R08: 0000000000000000 R09: 00007f23ddd96d7c
>    [ 3876.801143] R10: 00007f23d8022000 R11: 0000000000000246 R12: 00007f23ddd96d80
>    [ 3876.801662] R13: 00007f23ddd96d78 R14: 00007f23d80210f0 R15: 00007f23ddd96d80
>    (...)
>    [ 3876.805107] ---[ end trace e53161e179ef04f9 ]---
> 
> Fix that by saving the root's header owner field into a local variable
> before freeing the root's extent buffer, and then use that local variable
> when needed.
> 
> Fixes: 30b0463a9394d9 ("Btrfs: fix accessing the root pointer in tree mod log functions")
> CC: stable@vger.kernel.org # 3.10+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
