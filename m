Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947D426B93A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgIPBLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 21:11:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgIPBLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 21:11:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G18x1J072949;
        Wed, 16 Sep 2020 01:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Uv3TZFJL1BpRYBxYeWAKRSht/ZzkBHPEtEa8vTRwluw=;
 b=t07P7W+RgREc9jOAOfliEgPjXWGkD5Wzoxx/u5aUKM4kQb8iVbnWkVL4u+WfUDI2bTrQ
 lBrU44mWbwwqAe/8zqOuDWIiNpn2IJ3HJj09kVpp7Pd/laOyExP/8vSOLKKblkFSBYyM
 qg443F0HfGs1tXpYr5kemjUNpVXvR1P8ZkkizTmNjx3VU1j3/0fH3IPIReqoqEuSLENs
 WwElY2V6MA6Kkr5A0yYw3H4Y2ZmWEoq2YQSzL1rpCoP2TAoV6YfSqbaru8Q7XlZDiCQ3
 MkMs0jvPD+QpG/i4MJlWB8hMjhDFHzSmAzX576JPHEyAkNeZQ1kLoZidhH7VvyxvNVsx yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33gp9m884a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 01:11:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G0xwbI171698;
        Wed, 16 Sep 2020 01:09:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33h7wq0k0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 01:09:02 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08G191oe000718;
        Wed, 16 Sep 2020 01:09:01 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 01:09:01 +0000
Subject: Re: [PATCH] btrfs: fix overflow when copying corrupt csums
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
References: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2c4bc253-9941-0f81-0c3a-cf22b8b9dadb@oracle.com>
Date:   Wed, 16 Sep 2020 09:08:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160005
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/9/20 10:49 pm, Johannes Thumshirn wrote:
> Syzkaller reported a buffer overflow in btree_readpage_end_io_hook() when
> loop mounting a crafted image:
> 
> detected buffer overflow in memcpy
> ------------[ cut here ]------------
> kernel BUG at lib/string.c:1129!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 26 Comm: kworker/u4:2 Not tainted 5.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: btrfs-endio-meta btrfs_work_helper
> RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
> Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
> RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
> RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
> RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
> R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
> R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557335f440d0 CR3: 000000009647d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   memcpy include/linux/string.h:405 [inline]
>   btree_readpage_end_io_hook.cold+0x206/0x221 fs/btrfs/disk-io.c:642
>   end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854
>   bio_endio+0x3cf/0x7f0 block/bio.c:1449
>   end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1695
>   btrfs_work_helper+0x221/0xe20 fs/btrfs/async-thread.c:318
>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace b68924293169feef ]---
> RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
> Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
> RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
> RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
> RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
> R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
> R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f95b7c4d008 CR3: 000000009647d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> The overflow happens, because in btree_readpage_end_io_hook() we assume that
> we have found a 4 byte checksum instead of the real possible 32 bytes we
> have for the checksums.
> 
> With the fix applied:
> 
> BTRFS: device fsid 815caf9a-dc43-4d2a-ac54-764b8333d765 devid 1 transid 5 /dev/loop0 scanned by syz-repro (214)
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): has skinny extents
> BTRFS warning (device loop0): loop0 checksum verify failed on 1052672 wanted fc35c0f9 found 4b0bbc71 level 0
> BTRFS error (device loop0): failed to read chunk root
> BTRFS error (device loop0): open_ctree failed
> 
> Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
> Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The size is fixed.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

nit below.

> ---
>   fs/btrfs/disk-io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 160b485d2cc0..28b962840972 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -587,15 +587,15 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
>   
>   	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
>   		u32 val;
> -		u32 found = 0;
> +		u8 found[BTRFS_CSUM_SIZE] = { };


u8 found[BTRFS_CSUM_SIZE] = {0}; not required?

Thanks, Anand

>   
>   		memcpy(&found, result, csum_size);
>   
>   		read_extent_buffer(eb, &val, 0, csum_size);
>   		btrfs_warn_rl(fs_info,
> -		"%s checksum verify failed on %llu wanted %x found %x level %d",
> +		"%s checksum verify failed on %llu wanted %x found %*pH level %d",
>   			      fs_info->sb->s_id, eb->start,
> -			      val, found, btrfs_header_level(eb));
> +			      val, csum_size, found, btrfs_header_level(eb));
>   		ret = -EUCLEAN;
>   		goto err;
>   	}
> 

