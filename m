Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1977A1EB0B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgFAVIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 17:08:54 -0400
Received: from mail-mw2nam12olkn2087.outbound.protection.outlook.com ([40.92.23.87]:6314
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727875AbgFAVIu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 17:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUQpT6AFlKV+1KHnRsMivrNaRalD5WWL7WLLxb1bzRBRyukmZc1vZE+mC/7jaXkSEqW1qJtlBLFOpY5GlxVzG5BM6R1YmtLejKOdPAvqdUxb5ZZ/fn6Ut9vA6al0vtR42VL52ibpL6EfPq/oLSJCHbRnKroTYCTzhW1QTkV31mxuCCPPCK2UZHroOBu05AR+J73SpsPAERR8jHyA9xuFxoVB3yblWwc6UuB3OGfhxxJnTgSbpYpuQRrp7KiW7/TPCYgcN3mAJfkJ3NlG+cwX9Dl5XMfinVu/Bs0+/fDLI0ec8snvKvxwDMpQhGoMMaoQJwuc/4q4lSiwH8G2jNXkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRMOQoPQlBa5TnSwk/HWVOEoqZ1JX5YYqBwbaaOVkYA=;
 b=Tl0bfjM2gmuoSVyYp0ocLcFBPQMO5zkPPxy/ms8/I9WRp4dZ8jmechM2SkhkpsQzPLs2PcehUSgpDGPt/lJund4PfzXGNfPZzQ9VMbWAElKPNBGusBnqtia1LV+nS1QUE/LfbIFM71Fu9C50XW8nnmIneFH45R1pBW5yuX058RU80ejl1rli7DJusXer8SldXGHQKOma2lLaglwEMDdMkKOIVlbcq9MrZ0/Bzb+0uZjnuZeNW1ITB8K1LrteNFqxBKELBT7rdcQh0bxNXSDsod2wwqVPgleB2r7zYUFHYv7/uy5sWvHCnoOrOpjK9As6S/f0epRKXHcSwx+x1eo4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::42) by
 DM6NAM12HT174.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::321)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8; Mon, 1 Jun
 2020 21:08:48 +0000
Received: from DM6PR02MB4427.namprd02.prod.outlook.com
 (2a01:111:e400:fc64::51) by DM6NAM12FT019.mail.protection.outlook.com
 (2a01:111:e400:fc64::84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8 via Frontend
 Transport; Mon, 1 Jun 2020 21:08:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5E3B88AB89454266F266AC13D3A3DB3A84904D7A4D4D64958D1F9A29918994D1;UpperCasedChecksum:185A6150F0D2CDF505888EA0858503A84AC5327BE1FA84BA3CE42A505FCD6E6E;SizeAsReceived:8641;Count:46
Received: from DM6PR02MB4427.namprd02.prod.outlook.com
 ([fe80::1910:a162:220e:24e8]) by DM6PR02MB4427.namprd02.prod.outlook.com
 ([fe80::1910:a162:220e:24e8%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 21:08:48 +0000
Message-ID: <DM6PR02MB44274C6B16F173291A82C4A8C98A0@DM6PR02MB4427.namprd02.prod.outlook.com>
Subject: Massive filesystem corruption, potentially related to
 eCryptfs-on-btrfs
From:   Xuanrui Qi <me@xuanruiqi.com>
To:     linux-btrfs@vger.kernel.org
Date:   Tue, 02 Jun 2020 06:08:42 +0900
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:404:a::34) To DM6PR02MB4427.namprd02.prod.outlook.com
 (2603:10b6:5:29::20)
X-Microsoft-Original-Message-ID: <32042f1e664522c598ddedcf9aff1e38f07f2e96.camel@xuanruiqi.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xuanruiwork (2402:6b00:36b2:c000:d0:7f49:f7b4:c27b) by TY2PR01CA0022.jpnprd01.prod.outlook.com (2603:1096:404:a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 21:08:47 +0000
X-Microsoft-Original-Message-ID: <32042f1e664522c598ddedcf9aff1e38f07f2e96.camel@xuanruiqi.com>
X-TMN:  [sR0+rKKrHS0oxAPIhHOXQWa7mZ2L2ICP3bNiczj3WgWqtBqPetSBI2WCtGJzbh4a]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2ccc5bb2-b8a9-4cfe-a1e2-08d8066ffa12
X-MS-TrafficTypeDiagnostic: DM6NAM12HT174:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0Pl/Vjk0qgoHxgB1cnXRp4+05B6wCho9mJzGagFb0Rpij8nPFEALup0aaMH/yTdVm+D9Z5Sxqbo2HPcywAkbZPfmUFG5Xi5hrTiMjuT9dcxnrD/edk1Y5Js3pjlV7z+gS4iu+5eM/xojGVD9r3cizCE85nL7bFScQpMC6gqpr9h93ckDX1YAGwLS6BgifJVBdL5ldJwJ6PXaKffl8+4zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4427.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: jpMyz9gbouFqgFhQyUeVYjxhPVpmMvcSSFmeJSeRgUgIc4SVEmZmxhRol5ygXarMomuSr+ePOMEgZfPrtjRRECOOaJbY1vZXtFg6l6Ky/x8cfVfbDzvu/H98k9lHgax/33JzrXS6S65Xx162lTn5+J9YeJiLAz5aH4+nJBtNm+qYFA6seQGYA3jM4E60hd0tqcq6YTamfGSdJaKsG8OY/Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc5bb2-b8a9-4cfe-a1e2-08d8066ffa12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 21:08:48.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT174
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

I have just recovered from a massive filesystem corruption problem
which turned out to be a total nightmare, and I have strong reason to
suspect that it is related to eCryptfs-encrypted folders on btrfs.

I run Arch Linux and have my /home directory as a btrfs partition. My
user's home directory (/home/xuanrui) is encrypted using eCryptFS.

I ran into a massive filesystem corrpution issue a while ago. When
reading certain files or occasionally writing to files, I encounter FS
errors (mainly checksum errors, but also other I/O errors). Then my
file system becomes read-only because errors were encountered.

A `btrfs scrub` identified a dozen of checksum errors which were "not
correctable", and `btrfs check --repair` (and `btrfs check --repair --
init-csum-tree`) also failed to fix anything. The former crashed in a
segfault, and the latter refused to write anything because of an "I/O
error".

Unfortunately, I don't have any logs because I had to nuke (wipe & re-
make) my filesystem as the solution. However, after the reformatting I
gave up using eCryptFs, and the file corruption bugs have not
reappeared since. Initially I suspected that it was a hardware issue,
but I did a SMART test and no errors were detected; I strongly suspect
that it is related to eCryptFS.

System info:

uname -a:

Linux xuanruiwork 5.6.15-3-clear #1 SMP Sun, 31 May 2020 19:57:42 +0000
x86_64 GNU/Linux

btrfs --version:
btrfs-progs v5.6.1

(the rest is from after the reformat, but the setup is identical to
before the reformat sans eCryptFS)

btrfs fi show:
Label: none  uuid: 823961e1-6b9e-4ab8-b5a7-c17eb8c40d64
	Total devices 1 FS bytes used 57.58GiB
	devid    1 size 332.94GiB used 60.02GiB path /dev/sda3

btrfs fi df /home:
Data, single: total=59.01GiB, used=57.26GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=1.01GiB, used=328.25MiB
GlobalReserve, single: total=75.17MiB, used=0.00B

Some output from dmesg (note that /dev/sda1 is not the corrupted
filesystem; these corruptions seem to have been self-corrected by
btrfs):

[    3.434351] BTRFS: device fsid 823961e1-6b9e-4ab8-b5a7-c17eb8c40d64
devid 1 transid 79 /dev/sda3 scanned by systemd-udevd (519)
[    3.440896] BTRFS: device fsid a3892669-1ad8-4ff3-9747-0f8c405c0e6a
devid 1 transid 4769881 /dev/sda1 scanned by systemd-udevd (487)
[    3.461539] BTRFS info (device sda1): disk space caching is enabled
[    3.461540] BTRFS info (device sda1): has skinny extents
[    3.464079] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
0, flush 0, corrupt 14, gen 0
[    3.510991] BTRFS info (device sda1): enabling ssd optimizations
[    5.938153] BTRFS info (device sda1): disk space caching is enabled
[    7.072974] BTRFS info (device sda3): enabling ssd optimizations
[    7.072977] BTRFS info (device sda3): disk space caching is enabled
[    7.072978] BTRFS info (device sda3): has skinny extents
[ 3710.968433] BTRFS warning (device sda3): qgroup rescan init failed,
qgroup is not enabled
[ 7412.459332] BTRFS info (device sda1): scrub: started on devid 1
[ 7545.641724] BTRFS info (device sda1): scrub: finished on devid 1
with status: 0
[ 8244.846830] BTRFS info (device sda3): scrub: started on devid 1
[ 8369.651774] BTRFS info (device sda3): scrub: finished on devid 1
with status: 0

If anyone could look into the issue, it would be greatly appreciated.

Best,
Xuanrui

