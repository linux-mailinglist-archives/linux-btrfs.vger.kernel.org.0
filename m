Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7F37FDED
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 21:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEMTOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 15:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230394AbhEMTOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 15:14:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DJ5H76058834;
        Thu, 13 May 2021 15:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=hyyAN7LLA65HUrSEKLgHKdiWudqEPxmoBqPVuAkT3GY=;
 b=ZIaRkgB0+DjUY839fxW2kIF+e13jBw4TN84g8CYaM0xFcwPZ2adk0dIl2qRSBUoSlFLV
 DLh8kENoSwZ4+ZJGcflVjdPO/E6TegTNti9uac+iU4rVYbWGsGlQmHOojahkloHb2tKu
 JQBVcpWWlQyYyCcx/TK2sJNNRmPXuyh6oGr0qLsg42zCWsxdA6c0pYNUtph2S+LUaV0X
 MDXpNmkNFIYsQEtHIpTWRnQacuFrOGEXQ0jOZFczC6KxEOFCO2X2tzoLbuS8omeDOZ68
 NiWQPa95tuLWxsOMhn6Pa5G83xmfbF9PNcY3Itiw5aI0kBwhHi+0/cxVpEVhmca177da wA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38h8wbhteu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 15:13:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14DJDL52028483;
        Thu, 13 May 2021 19:13:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj98av22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 19:13:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14DJDJ7a29491626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 19:13:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1056F5204E;
        Thu, 13 May 2021 19:13:19 +0000 (GMT)
Received: from localhost (unknown [9.77.196.130])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B336A52054;
        Thu, 13 May 2021 19:13:18 +0000 (GMT)
Date:   Fri, 14 May 2021 00:43:18 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs/232 crashing on 5.13-rc1?
Message-ID: <20210513191318.t36ivziw27cstfpl@riteshh-domain>
References: <20210513190355.GA9610@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513190355.GA9610@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x8RjcgrCsTPrgN3v515OiMXjKcWSTplr
X-Proofpoint-ORIG-GUID: x8RjcgrCsTPrgN3v515OiMXjKcWSTplr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_12:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130132
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/13 12:03PM, Darrick J. Wong wrote:
> Hi everyone,
>
> Sorry if this has already been fixed somewhere else, but I noticed the
> following crash in btrfs/232 on 5.13-rc1.  It's not quite vanilla, but
> the only changes to the kernel source are some unexciting xfs realtime
> bug fixes:

Below is the fix for that.
https://patchwork.kernel.org/project/linux-btrfs/patch/f24fb4c9f8613fe76f5a7201752152637647f8ba.1619797915.git.riteshh@linux.ibm.com/

-ritesh

>
>  run fstests btrfs/232 at 2021-05-12 19:53:40
>  BTRFS info (device sda3): disk space caching is enabled
>  BTRFS info (device sda3): has skinny extents
>  BTRFS: device fsid 83eea612-5b69-486e-9e29-b1e46742d469 devid 1 transid 5 /dev/sda4 scanned by mkfs.btrfs (1783608)
>  BTRFS info (device sda4): disk space caching is enabled
>  BTRFS info (device sda4): has skinny extents
>  BTRFS info (device sda4): flagging fs with big metadata feature
>  BTRFS info (device sda4): checking UUID tree
>  BTRFS warning (device sda4): qgroup rescan is already in progress
>  BTRFS info (device sda4): qgroup scan completed (inconsistency flag cleared)
>  BUG: unable to handle page fault for address: ffffffffffffff86
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 43f010067 P4D 43f010067 PUD 43f012067 PMD 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 0 PID: 1783648 Comm: fsstress Not tainted 5.13.0-rc1-xfsx #rc1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
>  RIP: 0010:btrfs_update_root_times+0x3a/0x90 [btrfs]
>  Code: 8d a3 98 04 00 00 48 83 ec 18 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31 c0 48 89 e7 e8 be d0 b7 e0 4c 89 e7 e8 76 c1 19 e1 <48> 8b 45 00 4c 89 e7 48 89 83 4f 01 00 00 48 8b 04 24 48 89 83 6f
>  RSP: 0018:ffffc90002e57d88 EFLAGS: 00010246
>  RAX: ffff888102513e80 RBX: ffff888142406000 RCX: 0000000000000017
>  RDX: 0000000000000001 RSI: 00000000001623ac RDI: ffff888142406498
>  RBP: ffffffffffffff86 R08: 0017b8ff80000000 R09: 0000000000000005
>  R10: 0000000000000000 R11: ffff88810479ee30 R12: ffff888142406498
>  R13: ffffffffffffff86 R14: ffff8882f393e548 R15: 0000000000000000
>  FS:  00007f3872c9d740(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffffffffffff86 CR3: 000000016afce000 CR4: 00000000001506b0
>  Call Trace:
>   btrfs_update_inode+0x8e/0x100 [btrfs]
>   btrfs_fileattr_set+0x282/0x470 [btrfs]
>   vfs_fileattr_set+0x21e/0x260
>   do_vfs_ioctl+0xc9/0x920
>   __x64_sys_ioctl+0x3d/0xa0
>   do_syscall_64+0x3a/0x70
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f3872db750b
>  Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff626c66b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f3872db750b
>  RDX: 00007fff626c6770 RSI: 00000000401c5820 RDI: 0000000000000004
>  RBP: 0000000000000004 R08: 0000000000000048 R09: 0000000000000001
>  R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000002de
>  R13: 0000000000000000 R14: 00007fff626c6770 R15: 000055df450225e0
>  Modules linked in: ext4 mbcache jbd2 dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey btrfs xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip_set_hash_ip ip_set_hash_net auth_rpcgss oid_registry xt_tcpudp xt_set ip_set_hash_mac blake2b_generic xor zstd_decompress zstd_compress lzo_compress lzo_decompress zlib_deflate ip_set nfnetlink ip6table_filter ip6_tables raid6_pq libcrc32c iptable_filter sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  CR2: ffffffffffffff86
>  ---[ end trace 4d6b79bcb0d4bd5f ]---
>
> --D
