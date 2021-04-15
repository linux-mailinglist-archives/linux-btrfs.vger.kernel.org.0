Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84953360CB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhDOOyT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 10:54:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234230AbhDOOwk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 10:52:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FEY9Ip032164;
        Thu, 15 Apr 2021 10:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=A8m9LWtKt3J3U7Fa59pcZrjHhG7REkywpKGOl4qVtzY=;
 b=sCEEJgg70ztdmBOcI4Tg1L5l8PpoVxHbzTFwCPC9SEYyIbun0AeRoz+GNh5eLEMw+ukr
 igTAo4yXnp2EK2ob593r061bpVqxZVj/BAe2Bw4MzU3a9Bt6xgUh13is0Fsl9ilXZmuI
 17rqnbPICRAN8RE4uujiMf1iSWpGMEtOcN/K//sqHFppCHqzq4QlsXT9wgjWvZVfjIWs
 soGAro539iom9SF1+MTCvJ8kPWAupGoqEc5FolMx0AXTLqpsUMuZLnQrhWM5Da8jMyNE
 4NSAEWTxD+AaQ74cA5mjoYvW55A+T434N92hAMYLassbSzgNHNpz+F2pNdmQ43Pz8xk9 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xbqbbk3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 10:52:13 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13FEZ2SH036051;
        Thu, 15 Apr 2021 10:52:13 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xbqbbk2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 10:52:12 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13FEq5kP021066;
        Thu, 15 Apr 2021 14:52:11 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 37u3n8j48x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 14:52:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13FEpkXN30671274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:51:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A78CA11C04A;
        Thu, 15 Apr 2021 14:52:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50A4411C052;
        Thu, 15 Apr 2021 14:52:08 +0000 (GMT)
Received: from localhost (unknown [9.85.70.169])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 14:52:08 +0000 (GMT)
Date:   Thu, 15 Apr 2021 20:22:07 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
References: <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
 <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vsJPp_LWefv0XYN5eU92cA62R2SpqRmf
X-Proofpoint-ORIG-GUID: zauXfHiGE8vcXF_Ga6u8IpM4kZ-7Wobi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_06:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1015 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150097
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/15 09:14AM, riteshh wrote:
> On 21/04/12 07:33PM, Qu Wenruo wrote:
> > Good news, you can fetch the subpage branch for better test results.
> >
> > Now the branch should pass all generic tests, except defrag and known
> > failures.
> > And no more random crash during the tests.
>
> Thanks, let me test it on PPC64 box.

I do see some failures remaining with the patch series.
However the one which is blocking my testing is the tests/generic/095
I see kernel BUG hitting with below signature.

Please let me know if this a known failure?

<xfstests config>
#:~/work-tools/xfstests$ sudo ./check -g auto
SECTION       -- btrfs_4k
FSTYP         -- btrfs
PLATFORM      -- Linux/ppc64le qemu 5.12.0-rc7-02316-g3490dae50c0 #73 SMP Thu Apr 15 07:29:23 CDT 2021
MKFS_OPTIONS  -- -f -s 4096 -n 4096 /dev/loop3
MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch


<kernel logs>
[ 6057.560580] BTRFS warning (device loop3): read-write for sector size 4096 with page size 65536 is experimental
[ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
[ 6058.345127] BTRFS info (device loop2): disk space caching is enabled
[ 6058.348910] BTRFS info (device loop2): has skinny extents
[ 6058.351930] BTRFS warning (device loop2): read-write for sector size 4096 with page size 65536 is experimental
[ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5ddbbd devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
[ 6060.225107] BTRFS info (device loop3): disk space caching is enabled
[ 6060.226213] BTRFS info (device loop3): has skinny extents
[ 6060.227084] BTRFS warning (device loop3): read-write for sector size 4096 with page size 65536 is experimental
[ 6060.234537] BTRFS info (device loop3): checking UUID tree
[ 6061.375902] assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:171
[ 6061.378296] ------------[ cut here ]------------
[ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
    pc: c000000000a9370c: assertfail.constprop.11+0x34/0x48
    lr: c000000000a93708: assertfail.constprop.11+0x30/0x48
    sp: c0000000260d7730
   msr: 800000000282b033
  current = 0xc0000000260c0080
  paca    = 0xc00000003fff8a00   irqmask: 0x03   irq_happened: 0x01
    pid   = 739712, comm = fio
kernel BUG at fs/btrfs/ctree.h:3403!
Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
enter ? for help
[c0000000260d7790] c000000000a90280 btrfs_subpage_assert.isra.9+0x70/0x110
[c0000000260d77b0] c000000000a91064 btrfs_subpage_set_uptodate+0x54/0x110
[c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
[c0000000260d7880] c0000000009c7298 btrfs_buffered_write+0x488/0x7f0
[c0000000260d79d0] c0000000009cbeb4 btrfs_file_write_iter+0x314/0x520
[c0000000260d7a50] c00000000055fd84 do_iter_readv_writev+0x1b4/0x260
[c0000000260d7ac0] c00000000056114c do_iter_write+0xdc/0x2c0
[c0000000260d7b10] c0000000005c2d2c iter_file_splice_write+0x2ec/0x510
[c0000000260d7c30] c0000000005c1ba0 do_splice_from+0x50/0x70
[c0000000260d7c50] c0000000005c37e8 do_splice+0x5a8/0x910
[c0000000260d7cd0] c0000000005c3ce0 sys_splice+0x190/0x300
[c0000000260d7d60] c000000000039ba4 system_call_exception+0x384/0x3d0
[c0000000260d7e10] c00000000000d45c system_call_common+0xec/0x278
--- Exception: c00 (System Call) at 00007ffff72ef170


-ritesh
