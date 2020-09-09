Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CBC262930
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 09:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIHty (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 03:49:54 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:36413 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgIIHtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 03:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599637785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egE+7qjtZeUdbgc52M6aF39vfi6ux/3rOfY710Lqi88=;
        b=MOvESqC+u18FqncZl94MQtc9Q8u8BJ3e1KmRMhE4rA2pLbXxUgjUFNkwfRtVZ69OPBRSld
        Bh4OsPpTR+Ij1DWMhQECP1CtA0YCF8cyEoovcz7mI2tS9nHU/KjyG4gqeg6hMVBSZKL5hG
        EBITRNfWhoC4EDcJI0hplc5KnB44Dfk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-Rw6YgcimNwipOc83Eg1d1A-1;
 Wed, 09 Sep 2020 09:49:44 +0200
X-MC-Unique: Rw6YgcimNwipOc83Eg1d1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWP9tC8MU6cc8FE7WAClJw9ff6UUtbTbJSLKWnY4VC37zyxrD6HQkVp1AInCH/yCdk9i77Ckl4rA5PGuFFwpfI7mABOW+lRcL+a610LKA/CFRO7/+5ZWC32eHNVdB/YKMtZT53t104Lq2qE/dFxtk8eDP41jncTUrU6+qXPXgW8yoc5ZUQR+z20k+H3rb+d7BQsRa3X8thxLRloh2DVTQrRuzYtqFyDO/WYU+EPoOTzmLal7rFaus8fN38hRWrZA7HjteFwflDJOavg7YcpF8mnoGxD9JEecIGGwrsSjW+RZoaiQwkROy99OBaWnJBuGJihRLJ2pv5NGBwBXqpEFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9c7H9LnBT2pPXNuAE5MSFPM9Lg5rRYEjVUOHGJqapM=;
 b=Z7/GKt6iUVwl3du6iUUMOnHNR7AhK7KQG3fJ7qaHK0iRmdsve7Q42L6ruhkr8qx2zCwKfJCu7gzjV5TY8sBK/GSJSIvTNtuYjGSNJS/FbDpJNfN57QvClu1PLdcfi+pMfywVr96anZPMbKaqnfth2o8PUyeDRTrJLKqGxXVyP4LJ8JBr12t5Aj9M0uapF0S/JP9aiGjNGZaMrk3Daa/snGlnVeQvL4jeJ2/JrhihkTgHStarSbOtLsVUD9Z03alAjs6ySvkm3WqPFUjZEaSoxBb216BuuIW/j0g2gbewXAzztT9zdWFD2GCX7vGV3JI6u/JJ+ZfxUZWAUQpznYKvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4977.eurprd04.prod.outlook.com (2603:10a6:208:c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 07:49:43 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 07:49:43 +0000
Subject: Re: [btrfs] 3b54a0a703:
 WARNING:at_fs/btrfs/inode.c:#btrfs_finish_ordered_io[btrfs]
To:     kernel test robot <oliver.sang@intel.com>
CC:     linux-btrfs@vger.kernel.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200909070857.GA25950@xsang-OptiPlex-9020>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <29350c54-fb8e-433e-404c-d72c83f3989a@suse.com>
Date:   Wed, 9 Sep 2020 15:49:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200909070857.GA25950@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::26) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:a03:1b8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 07:49:38 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26881959-776a-4509-d699-08d85494e9a7
X-MS-TrafficTypeDiagnostic: AM0PR04MB4977:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4977129109E1F0A095713D2AD6260@AM0PR04MB4977.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IIa+Cvh2RNEQQDvZeaulUJKKb4RucvM120P9KPfWXwWMw4FskLGfmQWxyNNUB/TzYS8yBTqyWCVkZEGBJ4rQQC7RHZEVX60B2/VFphxzXOvwT2ky0HFxpZQWHM/sih5rWZxjYK3n+aQKXua5vkVOWD92Z91sEn63mZMs4jrWg0/48lZrraPP3EggefngTFaDn5Q5NPSutkk8gdFU6U+fSLai1Hdytk8wga+wcd3UJQd6kB79sTQJPfFXAC+SsWMI7Ra6lanGUNC6fB9BbSFP5l1Rkd938ca7Q0IIWgcMIjzSH20QCkzlGRmTChXBCC9dCq+KzpTyCZgucajJP5BamWBW2Yc884fDcrDvR46a9pEo2KrwO4biilHj1g3B5RIUOp+QjbyRvSb7U/c9khZkPz/1qVZH7nyulrKs9tZrr/1jW0H+TDNKaoJtx1hQF4ALrc6tj9xKQc9NHH2pH46P+70QQO1mx9nSuEAoMvBaPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(16526019)(966005)(83380400001)(26005)(6486002)(316002)(52116002)(16576012)(4326008)(31696002)(956004)(2616005)(5660300002)(86362001)(8936002)(66556008)(66946007)(66476007)(6916009)(54906003)(478600001)(45080400002)(36756003)(186003)(6706004)(8676002)(6666004)(31686004)(2906002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EVpqzq+88uoB9V7FcvSg0XaeC845owtIsbC579OfxfVFJdMBNgcgAIwjAO2316xQui+dazYvesZgRbcjg3VFQdYr0p19qNe96hyTvJobKb6YFpy/5Dp5dWyHDJflnS6sEI8O2XUIwZSwxn/6bwTSR9t6kGg8AgKN3pVf095WfcyXhjKVbSU6FV9VEt+FG3zTg4NU7elDUwTM6JMT6azoSHimR1FtdGcRtLkZpr4sToXfsYTyqlLT6REbq6wnRKqWg0I23wCi7/y0/IVuyqZ9w2knYjxyB8iv9BVVOIlJEJO0ezLA3NxZM+WHnfbWEO3p9takw5OouE7q2knKUlg6PR6UHi5KsubyCdl5yCVHVqoeS0Nep281as+UA7GJwg3PirRvrnF17Rp+cFpPF7GGKr6M//UYJFMSaJGGtX7OO8DiaJ8ayp+YnhhibxA49XyCnHnWP07vAIgtmSwiU3Gjp2QsO+x2/0IG35HneeCxiJAdKs2TEA42ECFcanDGFnIjd9028u4ZsFQUB4AldMifield4C8eQc3dZbXghXpdlfO9/AKZCK3Uh4oI7RKkwoBc4iuzsXh5hqPK5EW6LGQoo6BvIgNnIHP1MSJxdXi1LvMxkcDFvoi8ait6NRvleTH5LKDHSm2/BEYxG0tIG6VWdg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26881959-776a-4509-d699-08d85494e9a7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 07:49:42.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYIgqryskdCI33kyGq9fHeMs+w8N/DUv+z3JdZcegAWN+5UxMJ65nNGCAtHdGYqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4977
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/9 =E4=B8=8B=E5=8D=883:08, kernel test robot wrote:
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: 3b54a0a703f17d2b1317d24beefcdcca587a7667 ("[PATCH v3 3/5] btrfs: =
Detect unbalanced tree with empty leaf before crashing btree operations")
> url: https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-Enhanced-ru=
ntime-defence-against-fuzzed-images/20200809-201720
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-ne=
xt
>=20
> in testcase: fio-basic
> with following parameters:
>=20
> 	runtime: 300s
> 	disk: 1SSD
> 	fs: btrfs
> 	nr_task: 100%
> 	test_size: 128G
> 	rw: write
> 	bs: 4k
> 	ioengine: sync
> 	cpufreq_governor: performance
> 	ucode: 0x400002c
> 	fs2: nfsv4
>=20
> test-description: Fio is a tool that will spawn a number of threads or pr=
ocesses doing a particular type of I/O action as specified by the user.
> test-url: https://github.com/axboe/fio
>=20
>=20
> on test machine: 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz=
 with 128G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> +------------------------------------------------------------------------=
----+------------+------------+
> |                                                                        =
    | 2703206ff5 | 3b54a0a703 |
> +------------------------------------------------------------------------=
----+------------+------------+
> | boot_successes                                                         =
    | 9          | 0          |
> | boot_failures                                                          =
    | 4          |            |
> | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#=
,#) | 4          |            |
> +------------------------------------------------------------------------=
----+------------+------------+
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20

According to the full dmesg, it's invalid nritems causing transaction abort=
.

I'm not sure if it's caused by corrupts fs or something else.

If intel guys can reproduce it reliably, would you please add such debug
diff to output extra info?

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b1a148058773..b050d6fcb90a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -406,8 +406,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
int level,
        /* We have @first_key, so this @eb must have at least one item */
        if (btrfs_header_nritems(eb) =3D=3D 0) {
                btrfs_err(fs_info,
-               "invalid tree nritems, bytenr=3D%llu nritems=3D0 expect >0"=
,
-                         eb->start);
+               "invalid tree nritems, bytenr=3D%llu owner=3D%llu level=3D%=
d
first_key=3D(%llu %u %llu) nritems=3D0 expect >0",
+                         eb->start, btrfs_header_owner(eb),
btrfs_header_level(eb),
+                         first_key->objectid, first_key->type,
first_key->offset);
                WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
                return -EUCLEAN;
        }

Thanks,
Qu

> [   50.226906] WARNING: CPU: 71 PID: 500 at fs/btrfs/inode.c:2687 btrfs_f=
inish_ordered_io+0x70a/0x820 [btrfs]
> [   50.236913] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd=
 auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core=
 btrfs sr_mod blake2b_generic xor cdrom sd_mod zstd_decompress sg zstd_comp=
ress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_t=
emp_thermal ipmi_ssif intel_powerclamp coretemp kvm_intel kvm irqbypass ast=
 crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel acpi_ipmi drm_t=
tm_helper ghash_clmulni_intel ttm rapl drm_kms_helper intel_cstate syscopya=
rea sysfillrect nvme sysimgblt intel_uncore fb_sys_fops nvme_core ahci liba=
hci t10_pi drm mei_me ioatdma libata mei ipmi_si joydev dca wmi ipmi_devint=
f ipmi_msghandler nfit libnvdimm ip_tables
> [   50.301669] CPU: 71 PID: 500 Comm: kworker/u193:5 Not tainted 5.8.0-rc=
7-00165-g3b54a0a703f17 #1
> [   50.310904] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [   50.317626] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
> [   50.324255] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 4=
1 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 70 1c 2b c1 e8 58 ae ed bf <=
0f> 0b 44 89 f9 ba 7f 0a 00 00 48 c7 c6 50 47 2a c1 48 89 df e8 15
> [   50.344116] RSP: 0018:ffffc90007a83d58 EFLAGS: 00010282
> [   50.349923] RAX: 0000000000000000 RBX: ffff888a93ca5ea0 RCX: 000000000=
0000000
> [   50.357656] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff88904=
01d7f60
> [   50.365385] RBP: ffff8890300ab8a8 R08: 0000000000000bd4 R09: 000000000=
0000000
> [   50.373133] R10: 0000000000000001 R11: ffffffffc0714060 R12: 000000000=
f83e000
> [   50.381060] R13: 000000000f83ffff R14: ffff888fb6c39968 R15: 00000000f=
fffff8b
> [   50.388824] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlG=
S:0000000000000000
> [   50.397545] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.404300] CR2: 00007feacc500f98 CR3: 0000000f74422006 CR4: 000000000=
07606e0
> [   50.412477] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   50.420281] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   50.428082] PKRU: 55555554
> [   50.431451] Call Trace:
> [   50.434570]  ? update_curr+0xc0/0x200
> [   50.438919]  ? newidle_balance+0x232/0x3e0
> [   50.443700]  ? __wake_up_common+0x80/0x180
> [   50.448491]  btrfs_work_helper+0xc9/0x400 [btrfs]
> [   50.453880]  ? __schedule+0x378/0x860
> [   50.458218]  process_one_work+0x1b5/0x3a0
> [   50.462917]  worker_thread+0x50/0x3c0
> [   50.467262]  ? process_one_work+0x3a0/0x3a0
> [   50.472148]  kthread+0x114/0x160
> [   50.476084]  ? kthread_park+0xa0/0xa0
> [   50.480445]  ret_from_fork+0x1f/0x30
> [   50.484731] ---[ end trace cc096c1a2068030e ]---
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>=20
>=20
>=20
> Thanks,
> Oliver Sang
>=20

