Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3E6971F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 00:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjBNXoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 18:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBNXoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 18:44:04 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451AC2914A
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 15:44:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTOPcGTSazhVW0if9/lbL3/6eBLvnA9fBGtimKp6s/xoCaJOGvyhRlTtb555yNjvUEVU0zVhLv7mvHHeiC3LfRq8iUoATO7w5UkXVOTqMBAk5s1FXDCiJzxB88EkRi3gElIrY2Hf8NM9/tIpE3tKd2QQ87huwzscB5/F0bS6B47msgHTc3eSZ3N4eNNBileV3qkjeWqjW8+WDfN3GCSCpX8dqN/beto/ItODlQ5GnTreiBVi6wRhGsRbUWv4emF70SvGUrbMFqBN8jAcJgK11DBfe2z3Rk5g0qw4B2hRqaWrzy6gnXIAUZGItPj7vhe7Z4PgHU7Sz6OJRFj5hPsQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/pElQ3agQ0Gc/iyeJXPxqfvRxnwwWVnNDm5WL18WU4=;
 b=Vd3vshpeoURwrelmASIo25LRMRZpVuq49ptvzVNM8seqxOIwbdmLf0fVJvb3W7owM4V1VxmJ1J6qIfG6LVtiTbLmptJCHISU1vC11cgfs5lr9fGaNwWZUdjSoOnHl+ZMlhhRuLE71xLIFH6l2eKMM2aF9GA8BdaXY4otAHJgN4DrwsPDirq8qorCUzG3AGc/3kXjLcZY3GsTEWIO15ZMh0WhwubwQG+el0y0XFmMRR9tqUv8PzHrMOrYC8iC902R/uuK7aMqo1NywGpUxwdKWuQk7+u4wTJFwYRq1m4v5pQeRG6CeaeRlG0zu0N1RS8S4tvnI3/61+PCgok8pdtLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/pElQ3agQ0Gc/iyeJXPxqfvRxnwwWVnNDm5WL18WU4=;
 b=bQBlIDJnOC1sKvxx2L3tey9gH4mCLpaxYoZ5wbCz8Px5vZjARbvOShAsNL76rTb2M8bdonMthr8BP7G865Bp+arl/3WPT9CFla4YfIlS+oZeMO099jFltl4/JXJQcm8eW2vcr8NSoJZlwhSNamB6KvHd1FrEHEk0F7IBzeueKOue2N+jM/HeKbGJRro5MIw6ierGMEC9fzbic9vo6jUToFVfJhrcDL7s14ics8xXzSmCt2/FN52rvcqfSa/uV/5ZLKfeJo9bc59tO4qGkVCD9OFGaTIjibDN881njHrS4hF5vnPN7bA5kdYlJ7dzesII/VKenu6/J0skIkliTGok4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 23:44:00 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 23:43:59 +0000
Message-ID: <83b2c936-f233-7425-e735-553b9809bf5e@suse.com>
Date:   Wed, 15 Feb 2023 07:43:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: a problem of 'clear_cache,space_cache=v2' when block-group-tree
 is enabled
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20230214193518.E569.409509F4@e16-tech.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230214193518.E569.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dac5b7-7cd6-4891-816e-08db0ee5584e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rylMoL0qvWm2XQId1wgg2sFx0yTicm3nY2jR2DDq6nqBIonFvgrOj+hW3TuBIfPoO3+HO6rSxZoLfnG4pxSNvI4ePYiR6NMyfOjIpKIIYkzYIEgWYOVCJYzcc9a/dT5Lf6v3W3iLgOtwi7uTflcN9ZrgUT5HvCKzMrX0JY0VxzSrennuTTiKHRZ2yQUcZi0yRq8EqTt6Vmaq0GeugPuxSqlb5HSESgTgB/43KmvgEIO82v4o3H9WvZEatI7fWdF44VsUtibd6AqfGpP7J1IbbYaBt8xnEiUzgpvHpjN0bYYNsSJnsDFT+mXAaDu5ytlFFYJV2POF4xLENGnNpz5Q0xCY8p4D9sEClekQahcxK4SXNw3IECVWpXcdbnl0FYuPAlceCydLyP7ojSQczipgZtZHxGhaT90KbDWpPhHppjsdEj85bk/D8M/VnIotOO4lupLbp3a1fxwWRGz7ftU6wxEO4snyWpKx8rhVQdYCm/UjwetrXNr+uP7zpAdWYu+T/zMY2m4S9mwuWKypje1qCo/rSxEtaNNedowrLLJivcpPmFolwt1H1FFLDeMHYfa7F/ht83P9JUGY3jB70bVOB6wQq3eK6IUeGtu21frSEZI71o+mHNcQ0XFTY2OmC+Dyy+W8a3TJwIcecq7SM/fZ3s5nD/Sq2JcO8AGRZXNOVc+qstsfdAUnFHMSNuXC66pHoABomkDwjWApqbuVQeCJOfZBdT6NetKcw8omjqLyZdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199018)(31686004)(83380400001)(31696002)(2906002)(36756003)(186003)(86362001)(6512007)(6506007)(5660300002)(478600001)(53546011)(45080400002)(6666004)(8936002)(6486002)(41300700001)(2616005)(66476007)(66556008)(38100700002)(66946007)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjkyaEsrZ2ZWbmtYdEtEdnVMa0l3eUZ5dVg5d2tNeEhGR2l1aENLZWZQbTNN?=
 =?utf-8?B?a1NsWE9xUERVTlArcW1tZkJWU1Yyb0VxdThKZGt2MXZhYzRUclVjSUVWZmxk?=
 =?utf-8?B?S2dxbGg0Vmc1c2MzRGwrTVJSN1kzSUFpcmliRGg0S3h6czU0cVlNVkg5d1U4?=
 =?utf-8?B?aUZ3K205bC93SXhDQkxMQllJVDFyaVd4UzluSnVKdURuVjdqYkdrUE1sRzR1?=
 =?utf-8?B?Uk4vYXNJSlNVR3RrYkFqT0p6bVhVWE5YTTJVUzY1UlJuVWNvMWJlazNmSXdh?=
 =?utf-8?B?NDJlS1dZMHk3YVpyZjhQWlY5U200UUlRVnViRS8ySW9UNVBzZk5YYllmOTdp?=
 =?utf-8?B?dHZKU2VyRlZWYzZkeENSZ2tKcGQ0OE5VcjdWRzI5OUZyTmY2Skwrb3F4bUlC?=
 =?utf-8?B?NTdZa2NrK0NoTjJ6QkJ4Zm44Z3J3Q01GUkdCTENqd3dFNXJLeStHSGVYZitK?=
 =?utf-8?B?VVM4MXlFd3FUU2NBVWRNamZaUWdiRDhZU3c3dWFZVjJKRTBFanUxOFpwNFR1?=
 =?utf-8?B?bS83UytwQTBzQzBPRHNQN3ZuVEFRQm43bVpGZ1UxMG9haFcrM2V5M1VyVm8v?=
 =?utf-8?B?dWMvZlMrYUNtQnpHNjVHWHpUeXYxRWVHdXByWXh2L3FQekFhZ2VoOWY3ckov?=
 =?utf-8?B?SUd5ZTNxcjh2UUxZdzlkVTJZaEZIdlhweDUxMVVZQzhCd2lJQ0x2UW9pT3ZI?=
 =?utf-8?B?U0s0ZG9xMjJHN1NyM0NUY0wxbTZUbFJ0bkJSbGFXd0RrTTM0eWx2Zzl1Nmtu?=
 =?utf-8?B?TEUvNUdoZS9DL1VpSEd3RkhFQTlFa0t4aThJUUYvK083ZklVVDl3VUlZZjh0?=
 =?utf-8?B?d0NwK1h3QnRldWs3SXBRWDBWZXVDM1oxZWRTZW9EZEgyWjZjQWtKWUczWnlZ?=
 =?utf-8?B?VUpNQWg2anlNNW42REVJNkd0dXJlWUtyQmYwQnZ1K2M5NjM3ejhGRlV6VG9X?=
 =?utf-8?B?VHhjditaSnhpOEQ3MDMvTHdwU29qUDB1NGw4Nk53ZDE3L2p2TDI5cnQ0WnIr?=
 =?utf-8?B?Z3RZNXVXMDIzWWczQUdsWXR6REdKa0gvL0lwYUlSc0RzS0V4ZVhzemE3TmFF?=
 =?utf-8?B?WkZoQXM1YUorcHpZUjZVVWRxcFdQRlcwb3JFUXdUSGV4eGl5bXFOWXFMSG9E?=
 =?utf-8?B?UzNmZ1ZxN3BjN0VzVUcwNmxDTnZxVTBEY2VwaTZiUGo1TjNsaW16ZC93WEgw?=
 =?utf-8?B?Q2NBTHpPWTVEbkRpOHpxbnF0WkhURGNzWTZOZWdzaUlQMU9NQ0N3NksyVXVh?=
 =?utf-8?B?ajN1KzRxbXhYVS8vNDNjT1RmL3R2NUhZZmwyb1VDbWJWeDZkTDRmTFVBNVBo?=
 =?utf-8?B?OFMwcFl0MzlBblVMQmVsblJRSTVxOTdRSnVFNVJHUzc4ZmFRVGJEOUorRmUv?=
 =?utf-8?B?S0NUK3ZmMnVVcktJNFd0UGw0SGtnM1JaOHkzVWozaEZvc3Jsa0VFZ2czbU9q?=
 =?utf-8?B?WFVCUE8yZWJTWFpJS2loVy8zQ29LSE5MdlVlQXNEdk5ON1NhRDRLTzg1MUVF?=
 =?utf-8?B?VGR3cXN2YXZtTTQ4WXBFeTFjNjVobForNnpXYy9UdG1tU0RGcFZFSk1NNGIv?=
 =?utf-8?B?VzVNdGkrWmNYbTM1UG9hK2REWjFPNVFLL0k4SDMyRm5ES0h2aEZIbkQ0U3Ex?=
 =?utf-8?B?TytLQk1OTGJkb1E4aFpVWHh2Q3phRTlQRXVmRm9scTJiWFYvcFRjZTZxYUJL?=
 =?utf-8?B?d2g3dHBOZUpFaEk3d0lOSHBYdFRpbUpFVmxmN0FIUlBJUzh5eVRaaUNyUEE4?=
 =?utf-8?B?UGJEMm95Mjg4ZjhueGV2eG9OZ3ZnQnRBQzE2SERRVGprRHJMdXlVa2x5NUtM?=
 =?utf-8?B?aU1pL3RMYklmWjRNb3VOVGFSSzVCSFo1MEkyMzZiYVdyTnpTUVQrN1M3WDEz?=
 =?utf-8?B?clprQmdQS1JpaGh3U2V1WDJCUndSRmFSeEN5VTk1UGgyblh2alYvOVdnNWFh?=
 =?utf-8?B?d1BrSjdncVBIM2FKK1J6ZzFudVZNdzIyaFBGcVpuaDU4ak03elBKZW40SGh4?=
 =?utf-8?B?ZkcvUUk5Z21WcSt1em55dnkyaG5OdzVOY1ZVdG5IU205c2VscWlxVG1hNDNH?=
 =?utf-8?B?UDBEWGFMZFA5eHdoZTRmQnUxM3U3OGljM0J4NGZkTW9PdkdtTWRpUEVoNEFn?=
 =?utf-8?B?SUM2SXB6cWJWakx2SFN3b3U1eW9SWnliTXcycUNsMnBSb0tTMk1XQzM2eDg5?=
 =?utf-8?Q?vSx2Th8/AtWkzBa9G9oHqhY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dac5b7-7cd6-4891-816e-08db0ee5584e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 23:43:59.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYg79RqtmfO+mZroAvT3mHyb9pGJliYz2jPWf24a6OgJLvQPs7gF1O+wo0eYk/xH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/14 19:35, Wang Yugui wrote:
> Hi,
> 
> a problem of 'clear_cache,space_cache=v2' when block-group-tree is enabled.
> 
> reproducer:
> # mkfs.btrfs -R quota,block-group-tree /dev/nvme0n1p1 -f
> # mount /dev/nvme0n1p1  /mnt/test/  #OK
> # umount /mnt/test
> # dmesg -C
> # mount -o clear_cache,space_cache=v2 /dev/nvme0n1p1 /mnt/test/  #failed
> 
> 'mount -o clear_cache,space_cache=v2' failed with the dmesg output.
> 
> Should we check block-group-tree feature status before 'clearing free space tree'?
> 
> [  661.709894] BTRFS: device fsid f89d03fb-860c-4822-acc0-b18b7dbabd98 devid 1 transid 11 /dev/nvme0n1p1 scanned by mount (2113)
> [  661.721643] BTRFS info (device nvme0n1p1): using crc32c (crc32c-intel) checksum algorithm
> [  661.729981] BTRFS info (device nvme0n1p1): force clearing of disk cache
> [  661.736726] BTRFS info (device nvme0n1p1): using free space tree
> [  661.750885] BTRFS info (device nvme0n1p1): enabling ssd optimizations
> [  661.757672] BTRFS info (device nvme0n1p1): clearing free space tree
> [  661.764076] BTRFS info (device nvme0n1p1): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
> [  661.773288] BTRFS info (device nvme0n1p1): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
> [  661.783397] BTRFS error (device nvme0n1p1): block-group-tree feature requires fres-space-tree and no-holes
> [  661.793128] BTRFS error (device nvme0n1p1): super block corruption detected before writing it to disk
> [  661.802418] BTRFS: error (device nvme0n1p1) in write_all_supers:4454: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)

Yeah, I made the dependency too restrict.

But I can not find a better way to force v2 cache with bg tree otherwise.

So I guess we need to allow bg tree without v2 cache, and convert this 
to warning, until the day we deprecated v1 cache.

> [  661.815482] BTRFS warning (device nvme0n1p1: state E): Skipping commit of aborted transaction.
> [  661.824170] ------------[ cut here ]------------
> [  661.828906] BTRFS: Transaction aborted (error -117)
> [  661.833942] WARNING: CPU: 2 PID: 2113 at fs/btrfs/transaction.c:1984 btrfs_commit_transaction.cold.41+0xd4/0x330 [btrfs]
> [  661.844908] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill ib_core dm_multipath intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp nouveau snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi kvm_intel ledtrig_audio btrfs snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec mxm_wmi video kvm snd_hda_core snd_hwdep mei_wdt snd_seq drm_display_helper snd_seq_device blake2b_generic xor irqbypass cec snd_pcm raid6_pq dcdbas mei_me iTCO_wdt iTCO_vendor_support rapl drm_ttm_helper dell_smm_hwmon zstd_compress intel_cstate snd_timer i2c_i801 dm_mod pcspkr i2c_smbus snd intel_uncore soundcore ttm mei lpc_ich ses enclosure auth_rpcgss fuse sunrpc xfs sd_mod sg nvme ahci crct10dif_pclmul crc32_pclmul crc32c_intel nvme_core libahci ata_generic ghash_clmulni_intel nvme_common libata e1000e smartpqi scsi_transport_sas t10_pi wmi i2c_dev
> [  661.928933] CPU: 2 PID: 2113 Comm: mount Tainted: G        W          6.1.12-0.1.el7.x86_64 #1
> [  661.937644] Hardware name: Dell Inc. Precision T3610/09M8Y8, BIOS A19 09/11/2019
> [  661.945152] RIP: 0010:btrfs_commit_transaction.cold.41+0xd4/0x330 [btrfs]
> [  661.952107] Code: f0 48 0f ba ad 20 0a 00 00 03 72 60 44 89 ff e8 fc a7 ff ff 41 89 c5 84 c0 74 56 44 89 fe 48 c7 c7 98 d2 e5 c0 e8 f5 fd b0 d8 <0f> 0b 44 89 f9 45 0f b6 c5 ba c0 07 00 00 4c 89 e7 48 c7 c6 f0 b8
> [  661.971525] RSP: 0018:ffffaf8c0358fa80 EFLAGS: 00010282
> [  661.976895] RAX: 0000000000000000 RBX: ffff8e67b5272600 RCX: 0000000000000000
> [  661.984150] RDX: ffff8e6ecf92c300 RSI: ffff8e6ecf91f860 RDI: ffff8e6ecf91f860
> [  661.991405] RBP: ffff8e678ade9000 R08: 0000000000000000 R09: c0000000fffdffff
> [  661.998684] R10: 0000000000000001 R11: ffffaf8c0358f918 R12: ffff8e67abfa09c0
> [  662.005962] R13: 0000000000000001 R14: ffff8e67abfa0900 R15: 00000000ffffff8b
> [  662.013224] FS:  00007efec3c4f540(0000) GS:ffff8e6ecf900000(0000) knlGS:0000000000000000
> [  662.021446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  662.027342] CR2: 000055bbc7de5398 CR3: 000000011e45c005 CR4: 00000000001706e0
> [  662.034622] Call Trace:
> [  662.037273]  <TASK>
> [  662.039568]  ? release_extent_buffer+0x4c/0xb0 [btrfs]
> [  662.044945]  btrfs_clear_free_space_tree+0x234/0x250 [btrfs]
> [  662.050829]  btrfs_start_pre_rw_mount.cold.83+0x7e/0xfd [btrfs]
> [  662.056974]  open_ctree+0x12eb/0x1548 [btrfs]
> [  662.061577]  btrfs_mount_root.cold.76+0x13/0x136 [btrfs]
> [  662.067123]  ? legacy_parse_param+0x26/0x220
> [  662.071584]  ? vfs_parse_fs_string+0x5b/0xb0
> [  662.076060]  legacy_get_tree+0x24/0x50
> [  662.079987]  vfs_get_tree+0x22/0xc0
> [  662.083660]  fc_mount+0xe/0x40
> [  662.086936]  vfs_kern_mount.part.44+0x5c/0x90
> [  662.091461]  btrfs_mount+0x128/0x3c0 [btrfs]
> [  662.095936]  ? vfs_parse_fs_param_source+0xa0/0xa0
> [  662.100875]  ? legacy_parse_param+0x26/0x220
> [  662.105302]  legacy_get_tree+0x24/0x50
> [  662.109211]  vfs_get_tree+0x22/0xc0
> [  662.112858]  path_mount+0x696/0x9b0
> [  662.116507]  do_mount+0x79/0x90
> [  662.119813]  __x64_sys_mount+0xd0/0xf0
> [  662.123709]  do_syscall_64+0x58/0x80
> [  662.127460]  ? syscall_exit_to_user_mode+0x12/0x30
> [  662.132392]  ? do_syscall_64+0x67/0x80
> [  662.136285]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  662.141466] RIP: 0033:0x7efec3a3f7be
> [  662.145189] Code: 48 8b 0d 65 a6 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 a6 1b 00 f7 d8 64 89 01 48
> [  662.164638] RSP: 002b:00007ffd2892e258 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [  662.172343] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efec3a3f7be
> [  662.179589] RDX: 000055bbc7ddbc20 RSI: 000055bbc7dd74a0 RDI: 000055bbc7dd5670
> [  662.186862] RBP: 000055bbc7dd53b0 R08: 000055bbc7dd5610 R09: 0000000000000000
> [  662.194127] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  662.201397] R13: 000055bbc7ddbc20 R14: 000055bbc7dd5670 R15: 000055bbc7dd53b0
> [  662.208672]  </TASK>
> [  662.211063] ---[ end trace 0000000000000000 ]---
> [  662.215836] BTRFS: error (device nvme0n1p1: state EA) in cleanup_transaction:1984: errno=-117 Filesystem corrupted
> [  662.226329] BTRFS warning (device nvme0n1p1: state EA): failed to clear free space tree: -117
> [  662.235036] BTRFS error (device nvme0n1p1: state EA): commit super ret -30
> [  662.242615] BTRFS error (device nvme0n1p1: state EA): open_ctree failed
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/02/14
> 
> 
