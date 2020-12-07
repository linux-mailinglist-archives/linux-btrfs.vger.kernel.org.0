Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B112D17F3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 18:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgLGRz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 12:55:58 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:35041
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgLGRz6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 12:55:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAqMBELTkoVbVC56WtzEgL24t0xKeQkAGi82IUGe3t6IKwNQ0vTqKTtW6XpAuiz9qtm4ARp5CsZgD2mr65N0uI/ckQflevdhXho0WXvqQgoueOJ5KQ37klgT8xyJ9uV29/Ejdq+PlqYGpcqMIRZoAI2SapaVd9HWnGnKlsllFGo1fxP/o9GqQRZIUyZ3A7LkbFs0Z/Xv6AcN4PUxydQQuaoZRXm9Ll1jC7NoNq50csPdplaKXpyHZ+tCuxIUy3IjeQHyCZV/Q76skFGnBukJwBUDPdIH14tprmZHmVO9n2NO56SzT2RcfXnhensk47JQuTCllwopWYDok67w1s+BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3L5SAoiFePf01j7uMJH8tMoqCe6UjQDRVb2tIT8YW8=;
 b=C/a3tY8ondVO5IEkPEnECGTNkpxgoTxOFTWZatV6/TY0mbrGxOWJ7oIbEHC0ljVruinK7cuw9+dyBXm/GQJ78myuEt1/OiIdJ0n+r3Fk6k8nEp/VpDWJ7rQxB1Og5mYiuMYwOay+35tX6/Qe6nZfleS7GjUD3/XONN7scn2jG91qqmJRPZWxlnSL8ahuERnQwu76lyqBUHln/TCmAdxJam2FwrhoGf6/F64uHVLpKcxIpgESAy7HLlq+f3+Nd3nyCluzIdZwuvVc5d1/TAxx/4Atog6iFCgvHfYYVO87ZUslUjbPonLOlVLu151yD5SFT8vQiauGWnLdovzjqfTTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3L5SAoiFePf01j7uMJH8tMoqCe6UjQDRVb2tIT8YW8=;
 b=goHImJO7zaocVTrt6yDNBtz7UCVjPencyTGP1QoWVkzuTosq8kOBuDHCnC36yyPkKaFTI9v4yzz2UThEmhIJpK4rtLVc8Yi+64zCla9j/sWfi3wZbrgc6Eib5VmloW23wEQ3vT9sggIeANxqsoPhu03WfUV/tf9T08zZTTagE7I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5207.namprd08.prod.outlook.com (2603:10b6:a03:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.22; Mon, 7 Dec
 2020 17:55:03 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 17:55:03 +0000
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Subject: Assertion in tree-log.c
Message-ID: <7ffdf22e-352c-70e3-eb7c-86c591febe7c@panasas.com>
Date:   Mon, 7 Dec 2020 12:55:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [96.236.219.216]
X-ClientProxiedBy: BL1PR13CA0426.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::11) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (96.236.219.216) by BL1PR13CA0426.namprd13.prod.outlook.com (2603:10b6:208:2c3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 17:55:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a0dfb6-9a3b-42cf-491d-08d89ad93942
X-MS-TrafficTypeDiagnostic: BYAPR08MB5207:
X-Microsoft-Antispam-PRVS: <BYAPR08MB52073CC781FC45B2C2FFA9C7C2CE0@BYAPR08MB5207.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55n1ZkD3k8V8kK5yVf4IS5PS6h4L7IhjefUjoY93IlIWsGedKHLpu508OVpJF7JU9R4F3sx+QMWCuFTnO9oElb+gbyjXVq/L3JKzMXrc7HzUPujeQM8EGi9bGqUfxED2kn5TI1dtKh1HegicICaA1ccCHYFNERpT72BZ2zYs6JIWdUhZdSd+LTPNlpSX1L50ujgiBSyJ0d21+HeEgv9J0ZrtZulrtczqlvM67hLHt6jVs+LQeR+z7yZS1pcMvO7yKGDgUO/0oo1MPwWYjYWNigyJOWZH9jp8J9L+wCpd7lBS1tmM/FSJEm7vkCHhip1Zm5IgRYltYRay3xbdydSGxMlX85isd9PYlMxIend03G2xNjpjb9CPmjjkBztmnLWxihatiEN/UFTmSncytsUIjbAyUAPO/gWEvhIVCd1TGoGpS+LAtQfSpiw9L5zrhSsHSUKRSEnzdQ+BGSRqxofyWeGe6KUtp15xM1CuU6/gsGBH2Rb2dXkXQ0apdSSSklz8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39840400004)(316002)(31696002)(86362001)(66946007)(66556008)(186003)(45080400002)(16576012)(26005)(966005)(16526019)(8936002)(6916009)(956004)(83380400001)(5660300002)(6486002)(2616005)(52116002)(478600001)(66476007)(31686004)(36756003)(2906002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkhMRHk2NGtJUVpoUGJlc0Y4b2pwVS9BcGh0ZXhmVVI4bDJSd20vTGt2Vk8y?=
 =?utf-8?B?MFYvNlJKNW4zMTcvQ3ZQbXZZNmZEOTZzejFjaS9NcVpodU1aencveG1oMmZk?=
 =?utf-8?B?ZnB2OWpXdU9zbGZQUHQyOVB3NjA5ajhvQmFRRkxWdTJoajVnbU55eW0ySkF0?=
 =?utf-8?B?ZzNGOVd4RlVFVytQQWJrQnFZWGNkNnB1aUltb3ZVaEhpWXNMNTNJN09GLy90?=
 =?utf-8?B?dExzenJiSGdqU0tQRHJPZlZOMVdtNUcwRnBDYisrZUpnTVo0NU5VazdRaGht?=
 =?utf-8?B?TUNNVGxzVnMwZExwM05pcGpuUURGdkVFOVRmVVpMV2YrS0crR2dhdHNjWkho?=
 =?utf-8?B?RUUvVmNVdENDV1l4aHVQeWFXQ3l1aEJGVWtLMHJYM3VBNzdMb3FjbXZsYUsr?=
 =?utf-8?B?NmVodWMzenZVbytJanh3Nmd3WWljVzc5dDhtSnAzQ0dqR0QzWFhua001MUpp?=
 =?utf-8?B?OTZCbnp4NGVsc28rZlhGd1hFZGtwYnNwbS9tSmlUem8xOEdkelF5ek1nZDVD?=
 =?utf-8?B?SUQySzJSVytWTWhCNmJvU094UnJ5bkQxdUJXSGwxMk9YZ1NpTTlXVjVHOUQw?=
 =?utf-8?B?TjdQdjZndnA2WEhOaCtJSmVJM3FrV2syTFp5V1pzbmFlZnFFQjd6aVo0N1cz?=
 =?utf-8?B?cmtWUHJzbHQ3dGtGbGdtUUlFMkF3QzBWSDNRVCswbHgvWGFDSk1nZDNYSm92?=
 =?utf-8?B?VnpYRWViODRKb3ZuSExXUjhzY2g1ZUkxeGF3WEJoWXF3c21qeTBDd29SdkF1?=
 =?utf-8?B?QzZPUC9ncVRFN2o1cjFCa2tpRVlmM09xeTZaclIzUU1ObllNcmZIdWZPVDRK?=
 =?utf-8?B?bmtqa2xPQmM5SUlDci9NVThBWjJqWldRN2tON3RNSHUva2pZc014ejlnaGhH?=
 =?utf-8?B?ZDlXYlYzUlE4VjBwM1E3ZlN0cURGbWJyNFNvOGtQNkgyRWVUUEZiK1NLT2JJ?=
 =?utf-8?B?Y0I5NmxmcGoyTmhMVCttK3J0ajVuOUFES3dwWWR1ZFAvaStBSlRpNHNlNmEz?=
 =?utf-8?B?S2FobTJhOHhSYXZ4VFpuWmFRN3dqbzFzSkJiVDdSUExvaFh2TWJmU1ZWNTh6?=
 =?utf-8?B?aDlvYXVhU3ZTbE03MEhPOVk2QkNXb25xb1hscVFZb1VMWEpxZUpzWU1QenE4?=
 =?utf-8?B?V0ZZeU11WmdsY0tmUytCbnZHM2dBdlFsdUdNQW1mUytpQ0d3R0R4L3BkVzN2?=
 =?utf-8?B?eHg1NXBEZlRXMFVzUnVBbnBVOUVObjN0WnZLMHE5cEw1VjZYdnFEZzF4K0JQ?=
 =?utf-8?B?bm1HcEpXM1dEZE5CTkVtTmIwTEZnWXk3K2t3K1ovdjRDSVpjVlRGTWFIYS9k?=
 =?utf-8?Q?j9aQSec6TCx0HewJxoTlm2Vj7QguBUhD4j?=
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 17:55:03.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a0dfb6-9a3b-42cf-491d-08d89ad93942
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+nblyoq52ptRwPKePYVdkrtPUw+HRzYhlR95hC0HWSij3fhDYsZ9XecO0r1WyKDeJUXuwBrbVC5NNlB0HBLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5207
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

We've hit this assertion a few times, and I wanted to know if it was a 
known issue:

Dec 05 08:53:51 6afa1e4331fa46 kernel: assertion failed: ret == 0, file: 
fs/btrfs/tree-log.c, line: 4286
Dec 05 08:53:51 6afa1e4331fa46 kernel: ------------[ cut here ]------------
Dec 05 08:53:51 6afa1e4331fa46 kernel: kernel BUG at fs/btrfs/ctree.h:3295!
Dec 05 08:53:51 6afa1e4331fa46 kernel: invalid opcode: 0000 [#1] SMP PTI
Dec 05 08:53:51 6afa1e4331fa46 kernel: Modules linked in: af_packet_diag 
netlink_diag sctp_diag sctp libcrc32c tcp_diag udp_diag raw_diag 
inet_diag unix_diag af_packet binfmt_misc bonding iscsi_ibft 
iscsi_boot_sysfs msr nls_iso8859_1 nls_cp437 vfat fat dax_pmem btrfs(O)
ipmi_ssif xor iTCO_wdt nd_pmem device_dax nd_btt raid6_pq 
iTCO_vendor_support intel_rapl ib_core skx_edac x86_pkg_temp_thermal 
intel_powerclamp coretemp raid0 kvm_intel kvm irqbypass crct10dif_pclmul 
crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc aesni_intel 
aes_x86_64 crypto_simd glue_helper cryptd ioatdma md_mod ipmi_si nfit 
i2c_i801 lpc_ich mei_me shpchp ipmi_devintf mei dca pcspkr wmi joydev 
ipmi_msghandler libnvdimm acpi_pad button hid_generic usbhid ast 
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt xhci_pci 
i40e(O) fb_sys_fops xhci_hcd
Dec 05 08:53:52 6afa1e4331fa46 kernel:  ttm ptp pps_core nvme drm ahci 
drm_panel_orientation_quirks nvme_core usbcore libahci sg dm_multipath 
dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
Dec 05 08:53:52 6afa1e4331fa46 kernel: CPU: 2 PID: 6897 Comm: iopathv4 
Tainted: G           O     4.12.14-lp150.11-default #1 openSUSE Leap 
15.0 (unreleased)
Dec 05 08:53:52 6afa1e4331fa46 kernel: task: ffff8808351146c0 
task.stack: ffffc90008704000
Dec 05 08:53:52 6afa1e4331fa46 kernel: RIP: 
0010:assfail.constprop.28+0x18/0x1a [btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel: RSP: 0018:ffffc90008707b08 
EFLAGS: 00010296
Dec 05 08:53:52 6afa1e4331fa46 kernel: RAX: 0000000000000041 RBX: 
ffff880117eb0990 RCX: 0000000000000000
Dec 05 08:53:52 6afa1e4331fa46 kernel: RDX: ffff88085c09fd40 RSI: 
ffff88085c097a68 RDI: ffff88085c097a68
Dec 05 08:53:52 6afa1e4331fa46 kernel: RBP: 0000000000000ef2 R08: 
0000000000002dde R09: 0000000000000003
Dec 05 08:53:52 6afa1e4331fa46 kernel: R10: 0000000000000189 R11: 
0000000000000001 R12: 0000160000000000
Dec 05 08:53:52 6afa1e4331fa46 kernel: R13: 0000000000000096 R14: 
ffff880000000000 R15: ffff880141d39690
Dec 05 08:53:52 6afa1e4331fa46 kernel: FS:  00007f7ca3d96700(0000) 
GS:ffff88085c080000(0000) knlGS:0000000000000000
Dec 05 08:53:52 6afa1e4331fa46 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Dec 05 08:53:52 6afa1e4331fa46 kernel: CR2: 00007f296c031c20 CR3: 
000000083120a003 CR4: 00000000007606e0
Dec 05 08:53:52 6afa1e4331fa46 kernel: DR0: 0000000000000000 DR1: 
0000000000000000 DR2: 0000000000000000
Dec 05 08:53:52 6afa1e4331fa46 kernel: DR3: 0000000000000000 DR6: 
00000000fffe0ff0 DR7: 0000000000000400
Dec 05 08:53:52 6afa1e4331fa46 kernel: PKRU: 55555554
Dec 05 08:53:52 6afa1e4331fa46 kernel: Call Trace:
Dec 05 08:53:52 6afa1e4331fa46 kernel:  copy_items+0x9b4/0xbe0 [btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel:  btrfs_log_inode+0x775/0xe00 [btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel: 
btrfs_log_inode_parent+0x249/0xd30 [btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? kmem_cache_alloc+0x1a8/0x510
Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? 
__filemap_fdatawrite_range+0xa3/0xe0
Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? 
__filemap_fdatawrite_range+0xb1/0xe0
Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? wait_current_trans+0x1f/0xd0 
[btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? join_transaction+0x22/0x3f0 
[btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel:  btrfs_log_dentry_safe+0x58/0x80 
[btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel:  btrfs_sync_file+0x2dc/0x420 [btrfs]
Dec 05 08:53:52 6afa1e4331fa46 kernel:  do_fsync+0x38/0x60
Dec 05 08:53:52 6afa1e4331fa46 kernel:  SyS_fsync+0xc/0x10
Dec 05 08:53:52 6afa1e4331fa46 kernel:  do_syscall_64+0x7b/0x140
Dec 05 08:53:52 6afa1e4331fa46 kernel: 
entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Dec 05 08:53:52 6afa1e4331fa46 kernel: RIP: 0033:0x7f7caaf8f5fc
Dec 05 08:53:52 6afa1e4331fa46 kernel: RSP: 002b:00007f7ca3d93990 
EFLAGS: 00000293 ORIG_RAX: 000000000000004a
Dec 05 08:53:52 6afa1e4331fa46 kernel: RAX: ffffffffffffffda RBX: 
0000000000000000 RCX: 00007f7caaf8f5fc
Dec 05 08:53:52 6afa1e4331fa46 kernel: RDX: 0000000000000000 RSI: 
0000000000080002 RDI: 0000000000000111
Dec 05 08:53:52 6afa1e4331fa46 kernel: RBP: 0000000000000000 R08: 
0000000000001777 R09: 00000000eddb1d58
Dec 05 08:53:52 6afa1e4331fa46 kernel: R10: fffffffffffffa88 R11: 
0000000000000293 R12: 00007f7ca3d93a50
Dec 05 08:53:52 6afa1e4331fa46 kernel: R13: 0000000001bea4e0 R14: 
00000000eddb1d58 R15: f5402026a5ae13a5
Dec 05 08:53:52 6afa1e4331fa46 kernel: Code: 80 a0 48 89 fe 48 c7 c7 30 
27 81 a0 e8 61 70 9a e0 0f 0b 89 f1 48 c7 c2 3e bf 80 a0 48 89 fe 48 c7 
c7 00 29 81 a0 e8 47 70 9a e0 <0f> 0b 0f 1f 44 00 00 41 57 41 56 41 be 
f4 ff ff ff 41 55 41 54
Dec 05 08:53:52 6afa1e4331fa46 kernel: RIP: 
assfail.constprop.28+0x18/0x1a [btrfs] RSP: ffffc90008707b08
Dec 05 08:53:52 6afa1e4331fa46 kernel: ---[ end trace 13cc0fa206f6ac86 ]---


The closest thing I can find to it is this patch, which appears to be 
archived and open:

https://lore.kernel.org/linux-btrfs/20190916151307.GB1645163@kroah.com/T/

Sorry if my search-engine-skills are failing me and there is a better 
matching bug that's been fixed already for this.

Best,

ellis
