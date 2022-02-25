Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123E4C41F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 11:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiBYKJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 05:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiBYKJH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 05:09:07 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403E71AAFCD
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645783713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GeQVeSSv6hGuX/GW7NEBgyGnOVZQudO6LVmuxYhvvRs=;
        b=kH+echIfZd5m70xfZAtrJcQFv/McnMAkDD3583n4mwXOS+NigQs9MunXIE3F+BlSKmvJmQ
        29wkCbM7L8C6mRz9dDTyMa0efv4u11k0uXNtBQD/LMO5q3c9FRIXim+XAUvTb1i9Ukqnv1
        XeV4xHSMydAu81VtAl7sEroYrXAz2Xg=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-U6NP9GEVPZGO1YY1GNI12Q-1; Fri, 25 Feb 2022 11:08:32 +0100
X-MC-Unique: U6NP9GEVPZGO1YY1GNI12Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJHcOkA9kFEMRKeae8RkC/XO1ARfojoxjwVAdzlhmFyrr0JfLC3T8eDkQnbFG01Zuh9FMA9mouNE23j3pjSuFF08/xbDD79RlM9nhBA4U9P/fs5SNkyBNHBkwDR/O2uZqHzJSgLxNvojC/+qRdbyFDQblCHIJnC3HNl56U0Hftm381+3czgIUgzPisyEvANEylPrSb9QPRfqJr3TkWWGW2IH2Cg2Ajmb3OfGUTPgZbjm0XsPS6veW/PkqNz2PC9IqOYjxQHKJ7ab3UnJ0QX9nOSgiYbpLBsJCxb/VzvRP7IF214IOPiZKWGBcapSsXe3UUG+CF4jZAJM/ipe4ef3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeQVeSSv6hGuX/GW7NEBgyGnOVZQudO6LVmuxYhvvRs=;
 b=NTqkrFndiYmZNC5xAYxt677a+mkJnP6O34d1L2CbzU7R1KuN8icP9l3hgK1uhKww2bc1RKl2Kj3xJ43Gtuoy+qdGYTNi2Mj+lICZM9RVU/1N+u4rnmYOQy2IzDHnL2BdnTnz2K/7L2GUrlUNQRLRHGsS4a+m3JfWeFNWGeH3VoylsEcVTA0jZ1DZFhlQkiTZKkfISYtWIIKltTq+SGBQrd/MDtGRkKJjMPLJyCRo3F4yWAmlYnbV4fHr4SzN+IgF83IrAunVjq9kmAtN5z8k+y7n0irEWBBiudBgNBphs9iGkFB69tt6JKWRMETfdgB1sjAd2CJcA5Ipi3fcNoV5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB4159.eurprd04.prod.outlook.com (2603:10a6:803:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 10:08:29 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 10:08:29 +0000
Message-ID: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
Date:   Fri, 25 Feb 2022 18:08:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <wqu@suse.com>
Subject: Seed device is broken, again.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f7f4952-bf33-4948-755e-08d9f846c55c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4159:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB415956F95BDAD666A13DCC8FD63E9@VI1PR04MB4159.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkqGanOmQ7xmSyWYiCLV3z0fpfTVKEQxGtnFyQru26AJN8BpXgI/8vV3frqlCsQw9/f19YBXmrmAOArdepNUZwFVSTsid1/8GaPFY1WB1bsvEgtP96i7ChlhsKIaT/UzM1ChET33g/ICl821s7BncYr2e5OoIy16uOwoNECg+2bXe+kwFqrmiZ1PgBiw8RSxsfXtrcMl5v82gVlBjH56P2jjaivp5qztQ5CJ+0VKD8liJmQ7GIrkGdvaVT/DD5NSvOAhNjydAcMdupLt+u19m4g7PIOADN3zo7ILfGIvxMzDwxLDYTYmFH7L9UMPIcEbVG4xbXZqk3dh4zXGVlQjDaMf9m+Vfj0Hj6mIJsIgt1Y58xKIgrdBeFQC8VeEMXd9OfyjWE5HXnDIVU8U64jGZUFzr/WTlSn/qzyT5DYe7/KoKiM0SqJTJH0YP83TwFCgTuGJJegnKzWH5MghHdemuDQVpUh9e0mFfi+GecnVQUFh6UdfHuenbXNP73z4C+Ij3h0u60cnU4CseM/O1z2I7befpzzbg5WzKkmvHickp4YpRH6mt7zPu00irIBYe89zMuuqw7ei+MC/y572vjsuQWyDh29LnxucqQrGumIsQmZBj6Tj1ABhMlYANlMUvTBw7eRk33HwGjy7sN36Gs1hARz3BBrEqfc496jXYquKjisxjXBsrYhbuZCTTvSyGCZk6HoyCIhzdtH7xwW1L5ieUuZi0W4Z3PMb7XenIAy3KnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31696002)(2906002)(8936002)(86362001)(5660300002)(316002)(6916009)(36756003)(6666004)(2616005)(8676002)(45080400002)(508600001)(6486002)(6506007)(6512007)(31686004)(66946007)(66476007)(66556008)(186003)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JudkFVTEFqK2Q1eXlpeFdaeWJZQm52aDRuQ2hZWG1JcVV6UUdHckZDYzJL?=
 =?utf-8?B?NTZrcERJNnRDUE1BTWxVYTBROG83Y0FweWNENkl4ODI4V2pDM05wREoxc21j?=
 =?utf-8?B?NWV2S0xtczJPM1BNZmNwUm5JNnRDcnpVZU02bENSM0V5RWRLYlY1MGtGUTJB?=
 =?utf-8?B?RmJWMnd1bEhPeXN6ZEEyeWNFRmdpdmtRUDA2bjVVVTV5RVBOaEdGY3lCSFU4?=
 =?utf-8?B?c3FEclVhbFRYUmxiZ0Q3dGQ3R3hBR2FtbWxBc2xzQXhoQW1iaktaSFIyMmlm?=
 =?utf-8?B?WjIxSW9qSER3M1lxZG1ieVZ4TWVsVWk1eVorTWo1dnQyQXpqMmtxNmwzQmtq?=
 =?utf-8?B?eXZ5am5jWGdUZjVUSUVjcmVWMjVYa05sV2tpVnJGQ1E5cWxYQ0Z0djEveXRz?=
 =?utf-8?B?dzB6WmNqL2d1RSs2WWtERlVFckloMG5OTG5UdCtsa0VEakZBTnQwZGVXc05Q?=
 =?utf-8?B?N1hhdTAzTTN3U1ZuMXhjTUdMeVpRM1hPVFBYZVBKS2FBZjd1dXhNZjZPQ3R1?=
 =?utf-8?B?Qnk5VVY4TlVTSXI3ak1xcmQ3cmlRcHhLUHBqRmd4K0tkNTFqRVY5VVk3RFVT?=
 =?utf-8?B?N0QxZHBtTXBEUFg1ZTZuU3p2TGxnc1NGcHI3TTlVMFR0RkI5MGloWi9jVlJI?=
 =?utf-8?B?K1B1akwyMXEyaFoxcmVPTVlCL0FPSnZvOE1iVi9XTks2NUZadWV0aDZORnNt?=
 =?utf-8?B?ZFJrMXVuazJSTTFQUkRrUWpjZXhjeDVvQzFBcThDV09KSVQ0NmQzbU5WYnU0?=
 =?utf-8?B?aHJ2aHhNWVVFWVQ0WnJTd1Y5OHY0aWxmQnNwNi9FOVJFQnpjWDJiMWpqeTlD?=
 =?utf-8?B?MGRlQUlLSC9IS3NlS3lNOHpUNU01enRrVXRJRlVueDMvMU5sNzJ1YVZtbjUy?=
 =?utf-8?B?MjVJY2piQ1RIai9QL2g2V2tNMlNCTmlZQ1dMaUl6QXN6TFJBYlFPMldHQjh6?=
 =?utf-8?B?S2RwYU9PNktxUUsybkkxa1JCZ20xM0lQdmthTU5UMlErQUFiamFvOUljc3A0?=
 =?utf-8?B?Q2NlQStRMmpEMDdlWlRFc3ZKa0pWWVBtQkx3RWtpYnNWazBlNndjYVc1c2Ny?=
 =?utf-8?B?YnVNckE1LzFRNUF4SFI3OC9TNG1GWU1hRXlGRmkwVEM4R1orQ0VqN0hzZFRG?=
 =?utf-8?B?ODdjdGc1QVNydFhZQ3hEN3YyUVpLNThmYU4yby9MbFhJeUxJMjhibnA0bE1C?=
 =?utf-8?B?c25tRVRQSm5rdit3TU9HZTBGbU4xR1I0alpybWdpVm1GbTlrM1IzNEVLK1lF?=
 =?utf-8?B?Nks0Yng5STBGMHFzeDVBRFBLbXFOSlNVclZDbHNkbFhBdE91SDJtQzVhaXJt?=
 =?utf-8?B?bE94VlZ3RERuaERsd1Qyd0VtSzc4V0JZazBFa0UyZ3Ryd1NRUjhwMHI4SHU5?=
 =?utf-8?B?SG41cTFyUFRLSThnYVhPZTRlaWdCSklCbGl0VDllYzRjbXNUUGtLdlFzSXhS?=
 =?utf-8?B?NnhZZmZTSlFyK3VsY2c4SGxZU0tzK3JBZHJGM2JBNERRZUxBcnViYmthMEhU?=
 =?utf-8?B?S3NvQldpVmxNNmtYaGkyNlJjUkVMSVJ2cXRGTnRQdkJXbFBRZDRvS1lJMUM1?=
 =?utf-8?B?UnA0aFp5d09FQk5JMFRpYnhXbE5EQldoSHhiTXh1dXJiVXJqWkw1YzZvN01Q?=
 =?utf-8?B?VkpZdEFmUzQxSGN6TTZqUC9Fd2NtbjM4M0NFZWZIYWIyRjNOUjlIdzFDOXdU?=
 =?utf-8?B?YVcvOVh2QjhBK0kvbU9rWFZpbjB0Qk1uK3llb2lUMXN0bGRxMHVxZDdMaGRw?=
 =?utf-8?B?ejZiVk15Zk5kNGtUcXYyc0FiVGtzd0VLK04xRzFjVmt3Zkh5UmFqQUJEY0NG?=
 =?utf-8?B?d2c5dC9iUCtPbUxTdUthYjZDVHpETnA5a1lnOVUvbUMwYVk3NVorZzR0dmJ3?=
 =?utf-8?B?Y0ZkcjNaZ2NUR1BSZkFncVNySWhyUGl6bXBDVnVsTDByNVBQWnFPN0p3K1ky?=
 =?utf-8?B?aDExcGMvYnYwZUE0eGJRbk9pUHJRUTdqY0hVUFVndGYvblRSVUl2bm5wa0dl?=
 =?utf-8?B?RGU1U2FJVk1JSVg1Njc5MXVwdW4xL1hrZE9YcEZ2bHdOOHJPdVQ3blFuRlgz?=
 =?utf-8?B?ZlBLSGVsdzQrWW1mbGRoZlN0QzNEZTRISkpEWW0xUmNjdU1qM2VTaHhPYzY5?=
 =?utf-8?Q?k7L4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7f4952-bf33-4948-755e-08d9f846c55c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 10:08:29.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbQRgu78wjZjylVCvZvIhmR0GUUmgeoR+sltni3l2DHpD2u/9Ii1IqyiiEWgXnGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4159
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

The very basic seed device usage is broken again:

	mkfs.btrfs -f $dev1 > /dev/null
	btrfstune -S 1 $dev1
	mount $dev1 $mnt
	btrfs dev add $dev2 $mnt
	umount $mnt


I'm not sure how many guys are really using seed device.

But I see a lot of weird operations, like calling a definite write 
operation (device add) on a RO mounted fs.

Can we make at least the seed sprouting part into btrfs-progs instead?

And can seed device even support the upcoming extent-tree-v2?

Personally speaking I prefer to mark seed device deprecated completely.

The call trace:

  assertion failed: sb_write_started(fs_info->sb), in 
fs/btrfs/volumes.c:3244
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3556!
  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 11 PID: 626 Comm: btrfs Not tainted 5.17.0-rc5-custom+ #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
  Code: 87 ff ff 4c 89 e1 4c 89 ea 48 c7 c6 68 5f b2 c0 eb e4 89 f1 48 
c7 c2 8f cb b1 c0 48 89 fe 48 c7 c7 90 5f b2 c0 e8 c8 cd e0 c8 <0f> 0b 
49 8b 85 28 11 00 00 48 c7 c6 00 60 b2 c0 4c 89 ef 8b 90 fc
  RSP: 0018:ffffbaa04148bc78 EFLAGS: 00010246
  RAX: 000000000000004b RBX: ffff97cb45671000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffff97cbbd0e1aa0 RDI: ffff97cbbd0e1aa0
  RBP: ffff97cb4478c000 R08: 0000000000000000 R09: ffffbaa04148bab0
  R10: ffffbaa04148baa8 R11: ffffffff8a4e6968 R12: 0000000000000002
  R13: 0000000021d00000 R14: ffff97cb4478dfe0 R15: ffff97cb44dfc770
  FS:  00007fc02f8fb2c0(0000) GS:ffff97cbbd0c0000(0000) 
knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000056327627ac88 CR3: 0000000008938000 CR4: 0000000000750ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   btrfs_relocate_chunk.cold+0x42/0x67 [btrfs]
   btrfs_init_new_device+0x11e5/0x1780 [btrfs]
   ? btrfs_ioctl+0x1f20/0x32c0 [btrfs]
   btrfs_ioctl+0x1f20/0x32c0 [btrfs]
   ? find_held_lock+0x2b/0x80
   ? mntput_no_expire+0x7c/0x480
   ? lock_release+0xca/0x2d0
   ? __x64_sys_ioctl+0x82/0xb0
   __x64_sys_ioctl+0x82/0xb0
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x7fc02f9fc59b
  Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c 
c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 
01 f0 ff ff 73 01 c3 48 8b 0d a5 a8 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007fffc2620878 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 0000556ccf6be870 RCX: 00007fc02f9fc59b
  RDX: 00007fffc26208d0 RSI: 000000005000940a RDI: 0000000000000003
  RBP: 00007fffc26208d0 R08: 0000000000000010 R09: 00007fffc261e6c0
  R10: 0000000000000031 R11: 0000000000000202 R12: 00007fffc2621a90
  R13: 00007fffc2621a98 R14: 0000000000000000 R15: 0000000000000000
   </TASK>
  Modules linked in: target_core_user uio target_core_mod btrfs 
blake2b_generic xor intel_rapl_msr iTCO_wdt raid6_pq iTCO_vendor_support 
snd_hda_codec_generic snd_hda_intel intel_rapl_common snd_intel_dspcfg 
crct10dif_pclmul snd_hda_codec crc32_pclmul ghash_clmulni_intel 
snd_hwdep aesni_intel nls_iso8859_1 snd_hda_core crypto_simd cryptd 
joydev vfat snd_pcm fat psmouse mousedev snd_timer pcspkr i2c_i801 snd 
i2c_smbus soundcore lpc_ich intel_agp intel_gtt qemu_fw_cfg agpgart drm 
fuse ip_tables x_tables xfs libcrc32c crc32c_generic dm_mod virtio_rng 
virtio_scsi virtio_blk rng_core virtio_console virtio_balloon virtio_net 
net_failover failover crc32c_intel serio_raw virtio_pci 
virtio_pci_legacy_dev virtio_pci_modern_dev usbhid
  Dumping ftrace buffer:
     (ftrace buffer empty)
  ---[ end trace 0000000000000000 ]---

Thanks,
Qu

