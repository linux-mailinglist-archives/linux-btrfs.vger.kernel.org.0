Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B471784F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 22:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbgCCVfn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 16:35:43 -0500
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:9606
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732667AbgCCVfm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 16:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf22ckke0h4khE8SgUQPfaOxEtRlGZuOBhMtOCM7zS3+bcnTWZOJJTU0g0QH65hfaZWLrY9jOueVM3V/U/wUzfsx+ejGAWXyTrOTr/fccSZTLHkcyWBvY6b13gZh6bSXTuaRNTOSWk9nqen6MBaAT8ZVV84cesyb6LJdRkviTGwVdRyNOzznpFweRwcC54FQuXO/SE5jISEsiGaZ1xGsPGuoAF1QkMWBfrZpbFzHN+Y/z8mTU15/dTsFXKWHQNXawUVlJqfW/WyWCdNaqLkKKDRLWtRthRENOmXd7KuIWLZIb+Xc+H4fvmYV+ZSheZHC1zOT+M3/M584wrEHDPJtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCYyyL3dYWAj1XjPAzvdYHHcFSTjgXIgroUNpxaTzRM=;
 b=BxUseLV4xCSTqJ6Yg6h9Ba/brTX9Tk6YPR4JPlM+ZvDGQWR0YzM3FXNiZBYLQpWDdN9l2+/Q18QRhcAUmToUZ5gK9tFDZxUsz5zlmwfBKVMqxPKA6cFUJxMiXBUW80/6hZ3pl4fQHO8ED8agmtUT8PBntUyNXTPTdriOgLA4j4S8wmcVhxj9EqDuZ851AVdycUNm8VA1RS6gg94GSl6Uy/wOFmDk7fXl78xTuucP3x67eFUF52lgQn1QjpStsjfYvqq9aIDs4/cJ+kfHm6f1xHmGrER5/KojBgwNJQC1I9UKQg9esCAXo6XleIZfPuoJy7EFlVF2FP9e8QYl5xYbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=panasas.onmicrosoft.com; s=selector2-panasas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCYyyL3dYWAj1XjPAzvdYHHcFSTjgXIgroUNpxaTzRM=;
 b=LJWeGicT8nrkjLESwLQcqI4EoyUXzcuiCaA0/Dv7fit9X9IvQPaFksWLwLOO1xzdSs66dCwL5HHpHRH1g7fh8UI3i9EJ6/3h/cNOqRGKWhxguyDlfFLnljbXjOBVH6GDE+ZD3DSrQG3jF96d6jO0vhrZj5FPfKQ7sVZ8y53dVNo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ellisw@panasas.com; 
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5269.namprd08.prod.outlook.com (2603:10b6:a03:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 21:33:02 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::a101:5ced:24e2:c7cc]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::a101:5ced:24e2:c7cc%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 21:33:01 +0000
To:     BTRFS <linux-btrfs@vger.kernel.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Subject: FS Remounted RO due to false-positive for OOS?
Message-ID: <bd2903fd-0939-357b-e22a-ef425ac48f32@panasas.com>
Date:   Tue, 3 Mar 2020 16:32:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.3.107] (65.205.22.243) by MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Tue, 3 Mar 2020 21:33:01 +0000
X-Originating-IP: [65.205.22.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 445de649-9f41-4bc8-c43d-08d7bfba7337
X-MS-TrafficTypeDiagnostic: BYAPR08MB5269:
X-Microsoft-Antispam-PRVS: <BYAPR08MB5269D37CC3C6C44F7A4D5DE2C2E40@BYAPR08MB5269.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39840400004)(136003)(199004)(189003)(478600001)(86362001)(31696002)(8676002)(45080400002)(81156014)(31686004)(8936002)(81166006)(16576012)(316002)(2906002)(6666004)(6916009)(5660300002)(6486002)(36756003)(2616005)(186003)(66476007)(26005)(956004)(66556008)(66946007)(52116002)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB5269;H:BYAPR08MB5109.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: panasas.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKuX/h7xg1CNH2D1MttNXaIbfkq0Vd8O1FPUxV+p6XlV0NoWkzfNSNL1NqIFYEIYP9pa3qQz+ze0SLBFNjqDk1H//Mku4ewZK5C649xFU/g9plcsP0iko3TjsFc/lNxPS+K9xYMTx+69+5yd9jA0Kz8Jc3nzN+NLS5rCnsp+Ocq8t3YEKtwRyxUb7lPLkHPu5TYXF1vwJldZses3MQrB7me7KZMuWaASPkpydi3zfZAEKRzohalmAcOMfxAeSREblUoNO4X8nt7mR/JHSscxqNNiy80yjfCtOPnUzezBWzEFe3PEnbj0Z46CZg3CsWpv1NXZ7Jv2mY6weuy4a+0cca497SlnHtcFGDQZ98d94dp6iwaI1nfnMiuD4yUmV7AD4qH2FYXVtJrgOjvLaqtHQX3HwS/CFy23YwMWPXFbLewz3usPBIYhyWVnrOtVvx+N
X-MS-Exchange-AntiSpam-MessageData: FkVwql/mJflarO6RtiZhi5mfrFZCVAkQBFmTK2O0ApvGM+Rj41itH+MUeSjOlHbcfIIlxWlYS36jxC/8lXVkwBxVZfX6D2E5pCSpn2tMBmYSOWNm9lWmHSMAzowxCBqanb5vnBtYBmW4q3eTFY8n8g==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445de649-9f41-4bc8-c43d-08d7bfba7337
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 21:33:01.5920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMbd5vDPJcyi8oOcCvqe8QC67RTp2uoGnbW7hO/zqQk5ThZLFjTA5yJV7ouuwG6iqjfNHwm54cK85YQHC993AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5269
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I encountered the following issue and wasn't sure if it was known or not 
yet.  I'll be glad to hear it matches a fingerprint of a known or fixed 
bug as I'm admittedly running an older kernel, but my searching skills 
have failed me.

I have an mdraid array formatted with BTRFS.  6x12TB drives in raid0. 
Only about 240GB of 72TB consumed at the time of OOS.

/etc/fstab mount options:

/dev/md0        /pandata/0      btrfs   defaults,space_cache=v2,noauto  0 0

uname:

Linux 4d00fa3d419078 4.12.14-lp150.11-default #1 SMP Fri May 11 08:28:30 
UTC 2018 (a9fee09) x86_64 x86_64 x86_64 GNU/Linux

dmesg output:

[17939.536301] BTRFS: Transaction aborted (error -28)
[17939.536331] ------------[ cut here ]------------
[17939.542058] WARNING: CPU: 7 PID: 3372 at 
../fs/btrfs/extent-tree.c:6988 __btrfs_free_extent.isra.64+0xb9d/0xd40 
[btrfs]
[17939.553779] Modules linked in: binfmt_misc af_packet bonding 
iscsi_ibft iscsi_boot_sysfs msr nls_iso8859_1 nls_cp437 vfat intel_rapl 
fat skx_edac x86_pkg_temp_thermal btrfs intel_powerclamp coretemp xor 
ipmi_ssif kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul 
crc32c_intel raid0 iTCO_wdt iTCO_vendor_support ghash_clmulni_intel pcbc 
dax_pmem ixgbe device_dax md_mod ptp nd_pmem pps_core mdio nd_btt 
aesni_intel aes_x86_64 raid6_pq crypto_simd glue_helper cryptd i2c_i801 
lpc_ich ioatdma ipmi_si pcspkr mei_me mei nfit ipmi_devintf shpchp dca 
wmi ipmi_msghandler libnvdimm acpi_pad button joydev hid_generic usbhid 
ast i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt 
fb_sys_fops xhci_pci ttm xhci_hcd nvme drm ahci 
drm_panel_orientation_quirks nvme_core usbcore libahci sg dm_multipath 
dm_mod
[17939.631713]  scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
[17939.638341] CPU: 7 PID: 3372 Comm: btrfs-transacti Not tainted 
4.12.14-lp150.11-default #1 openSUSE Leap 15.0 (unreleased)
[17939.650466] Hardware name: Supermicro SYS-F629P3-RTB/X11DPFR-S, BIOS 
3.0c_PI021_2e 11/26/2019
[17939.660095] task: ffff88083b975680 task.stack: ffffc9000a238000
[17939.667128] RIP: 0010:__btrfs_free_extent.isra.64+0xb9d/0xd40 [btrfs]
[17939.674653] RSP: 0018:ffffc9000a23bc78 EFLAGS: 00010296
[17939.680953] RAX: 0000000000000026 RBX: 0000000000000000 RCX: 
0000000000000000
[17939.689172] RDX: ffff88085c1dfd40 RSI: ffff88085c1d7a68 RDI: 
ffff88085c1d7a68
[17939.697386] RBP: 00000012b9a5c000 R08: 0000000000000511 R09: 
0000000000000007
[17939.705602] R10: 0000000000000001 R11: 0000000000000001 R12: 
ffff8808530ae000
[17939.713803] R13: 00000000ffffffe4 R14: ffff8802edf64870 R15: 
ffff8801368c0230
[17939.722017] FS:  0000000000000000(0000) GS:ffff88085c1c0000(0000) 
knlGS:0000000000000000
[17939.731203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[17939.738051] CR2: 00007f12998bea08 CR3: 000000000200a003 CR4: 
00000000007606e0
[17939.746292] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[17939.754525] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[17939.762735] PKRU: 55555554
[17939.766521] Call Trace:
[17939.770075]  __btrfs_run_delayed_refs+0x5b9/0x1300 [btrfs]
[17939.776682]  btrfs_run_delayed_refs+0x68/0x250 [btrfs]
[17939.782948]  btrfs_commit_transaction+0x2df/0x900 [btrfs]
[17939.789462]  ? wait_woken+0x80/0x80
[17939.794087]  transaction_kthread+0x186/0x1a0 [btrfs]
[17939.800201]  ? btrfs_cleanup_transaction+0x4e0/0x4e0 [btrfs]
[17939.806983]  kthread+0x11a/0x130
[17939.811308]  ? kthread_create_on_node+0x40/0x40
[17939.816939]  ret_from_fork+0x1f/0x40
[17939.821591] Code: 00 00 48 c7 c6 c0 07 8e a0 4c 89 f7 41 bd ea ff ff 
ff e8 4d d0 09 00 e9 a0 f5 ff ff 44 89 ee 48 c7 c7 18 71 8e a0 e8 d9 95 
96 e0 <0f> 0b e9 73 f5 ff ff 49 8b 46 60 f0 0f ba a8 30 17 00 00 02 72
[17939.842686] ---[ end trace 179787a3004a4525 ]---
[17939.848482] BTRFS: error (device md0) in __btrfs_free_extent:6988: 
errno=-28 No space left
[17939.857923] BTRFS info (device md0): forced readonly
[17939.864081] BTRFS: error (device md0) in btrfs_run_delayed_refs:3016: 
errno=-28 No space left
[17939.873811] BTRFS warning (device md0): Skipping commit of aborted 
transaction.
[17939.882319] BTRFS: error (device md0) in cleanup_transaction:1876: 
errno=-28 No space left
[17940.192941] BTRFS error (device md0): pending csums is 334954496

fsyncs for a running application immediately began to return "fileio: no 
more space" following the above.  The mount went RO.

btrfs check output:

4d00fa3d419078:~ # btrfs check -p /dev/md0
Checking filesystem on /dev/md0
UUID: 2a71b152-ade6-4be6-9b2f-8db1e736455a
checking extents [O]
checking free space cache [o]
checking fs roots [.]
checking csums
checking root refs
found 242851065856 bytes used, no error found
total csum bytes: 234919228
total tree bytes: 2293776384
total fs tree bytes: 910114816
total extent tree bytes: 998359040
btree space waste bytes: 440673068
file data blocks allocated: 450663858176
  referenced 236223201280

A remount following btrfs check worked just fine.

btrfs usage fi reports:

# btrfs fi usage /pandata/0/
Overall:
     Device size:                  65.48TiB
     Device allocated:            276.02GiB
     Device unallocated:           65.21TiB
     Device missing:                  0.00B
     Used:                        227.67GiB
     Free (estimated):             65.26TiB      (min: 32.65TiB)
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:268.00GiB, Used:223.57GiB
    /dev/md0      268.00GiB

Metadata,DUP: Size:4.00GiB, Used:2.05GiB
    /dev/md0        8.00GiB

System,DUP: Size:8.00MiB, Used:48.00KiB
    /dev/md0       16.00MiB

Unallocated:
    /dev/md0       65.21TiB

I suspect this is a free space cache issue, and a bug that false reports 
up the chain that there is no more space and then locks the FS out in RO 
mode.  But why it doesn't hit on check or remount is unclear to me.

Any and all thoughts are greatly appreciated,

ellis
