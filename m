Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5B269FF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIOHkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 03:40:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:53198 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgIOHk1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 03:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600155622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fIEDqXM3N+QvmcRWQuU0u2kFJ0CRo43rb0bH3/TDI34=;
        b=jhbq5azzZbkPfHxjz4zjF1RYkPoCkrJbufXpJ1y1GBgySczCPPT+rpzn5+5me1njk4yHoi
        /pX+zoHqI7qsC99ktLoWDZS2BqVgVlGWVs0h2ZVDhAB2scarymz+0FLIwU3WpUdeqVC/y+
        /h70qa7mCpFTgvsIC2U/RhC1XSRBi1U=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-pJ8NtIp-Nf-oLH9O05XCDQ-1; Tue, 15 Sep 2020 09:40:20 +0200
X-MC-Unique: pJ8NtIp-Nf-oLH9O05XCDQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJdbpCqJL9LJdK/7aWPTJXeqc1K6gzOajLSoyJoD4xVc/D+Tdq0JM1yoCGfvxwYfVOP4Pn349EP/+6Yq7VdJs4H05BYU7xlvo/ZH6DP2brIjqbDgDSAuFTAGYWXyTC3bZNs7kioq7KG/01JQJL5a/DbqcXHq9AAymOuVIHfcPZPovHXTtpF2AcS1Wodp+hn1BrsNqmpNaYJuGy2CyU796466tu6d0C+sbhORdmMPK/AQuAsk1UgXUVRNpp2kp+Det5/IZGfbNaWlcUwh3Aseq3hDrbQTZ0G5QX3WIKGHMD5RJVbfOZnnNQJBaUKwEUgXu35r1donUaD5eDnvySkMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywejpjAHd3yPSaCanWllTXq6Tx8+RBSxgFOJ7x6f/Ok=;
 b=MTkiCa+LPzrf2sPfCM5Wp/Em92bPOx0eTdVO8VhxzJipmvtMiocLdN5MDmvRLZM1N7g7ZJgBMy9gRcysDApc6rTY87ynpRP9+IBELHCZtRK8engpproXJjdSM8wJ/vgffKYBpdVtp0LqdWzuUBTnWP//vmSrIEY9dZmwQVUpPEFV+Llq+HPVjdHm/dHsvEWXAicbPH20YH9F9kxjK7KgEc3co/xiaWULIkbwYWC/tdhsUZ64ya8xdAAXgTW/J5AaizSXS43MJ70Ye7RHj+2JBS1RWimoeTeJwdigjjF5ENIqLWXaAKiHGW5QkcrM+022AdSE0d0Kbk6fwsuKPiaYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 07:40:17 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 07:40:17 +0000
Subject: Re: [btrfs] 3b54a0a703:
 WARNING:at_fs/btrfs/inode.c:#btrfs_finish_ordered_io[btrfs]
To:     Oliver Sang <oliver.sang@intel.com>
CC:     linux-btrfs@vger.kernel.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200909070857.GA25950@xsang-OptiPlex-9020>
 <29350c54-fb8e-433e-404c-d72c83f3989a@suse.com>
 <20200915055411.GC17463@xsang-OptiPlex-9020>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <4ea5f2ba-df33-114a-3cfa-4d7dd35c04c3@suse.com>
Date:   Tue, 15 Sep 2020 15:40:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200915055411.GC17463@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 07:40:14 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4280eec2-bf3d-4e54-0e85-08d8594a9710
X-MS-TrafficTypeDiagnostic: AM8PR04MB7249:
X-Microsoft-Antispam-PRVS: <AM8PR04MB7249E4C154D31A882C24143FD6200@AM8PR04MB7249.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyuiJo+z2x+zw6fhQX7YbU2FKUPbdCC9EY3122FbwQVYLWaXA+6gsxVetpSB0ADqf82ZGCveXnigcso0Gys8G/Wm8vp5zVwa282pXipAvtwcRvFU+v5LT9zGUo10gjpYLsgYV5fSLMb/Is+WjL1NhEo1Wy4iOKU6zp7jnD1q8g6hDxxqCJxfE+yug6gpPtbjd6EQ3Nywa+MCZpLkZSLYR2DXiBT1LUSAPQc+YtXiHfZPclMLeAc1QohocJN0bLL4g47KWIlR0ekbmfwrJRQiRxcp1yqcNa1Kpbo0W2eSNAf0DHwMUhEz7ptirWauRJ7FzVYJA3BGx3XGWNScTGu1rqYo2+yYN36MdVH6fgGYS+y/Wk5fcJXa7lEz5MtIP9SR+gYhZ+Gk2lKdO82ubN2TRVMcrobOpvCgQ1VF1hN/WIUtkUGpl2We5ELhLvT1LshH3dXUInvHlxxhCgcZK85u+NM/DGIYNyx9OZ84j83A7j4K2bLFsbC5cxvYKlIzoVRFKjGEwRhiLxRRkunQvTYlQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(6486002)(36756003)(26005)(478600001)(16576012)(31686004)(4326008)(2616005)(30864003)(5660300002)(45080400002)(956004)(316002)(66556008)(66946007)(8676002)(54906003)(66476007)(6706004)(6916009)(86362001)(2906002)(52116002)(31696002)(186003)(16526019)(6666004)(966005)(8936002)(83380400001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eb8ENH+1T3ivyMsFewY9VwE4fEnK0AX95LSxS+FARNufWSY7pokNff5iub9VnWHWhltPm1OqYqPTjFjJS4g0Y37bI4UgfBGBFIl/pejaTAzfd6bR1XRJnzKg6FjVLI505TpKL7178vQ1WkCsjWqmWMO74boFvGHgyUWI3ze/VXn9Jj1g5g29a4FLr3T1p/1RAS4IsmybTFQvEPEF9JSDO/kuE/YnBvcldRubN8nBGvZtVTgKnR4SaaGXzrAy/Ikn6qo5dqm5Ppaf3xHBO+EdAwv27URsCTryXn560mLIFhXKGqsgIogq14KwB2j1iy/mmIuewVoj9FDNnQvV8whvDXQm8xHWoLQ8JsvFwOuM2pjnza8U/rkqH9yQSfovkhKfFPnfLY2idMOf7DI1lD7WELHs/0HNBShXIniBSFrloKGv/hli0NrF1JxdZ0ZOQYyPYKUipwCRbDVHp2E5v3owu0UpYJYLI/E92qp2g4xZjO3ckOzw8ekj1f7JGDLDtfqTyAEMybWPU6RQnoOEaR7eME4iN55K8np7SRmi4UK53aaH9/MURIO8HtTOi3+1FcTdD2XFSDXyneoDKtV10ezXguKAZY3Olf53YAoFDduqzvduWq7FGVKOmY491/1umOyA7VMBuUkNhWmCLzQ4PpToPw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4280eec2-bf3d-4e54-0e85-08d8594a9710
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 07:40:17.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9QQeWxhX3xi+MhgXerGGtx6bpYU1zD0MJ0j1NRt+eyUeWQ1pS20nY99xmX5d+up
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/15 =E4=B8=8B=E5=8D=881:54, Oliver Sang wrote:
> On Wed, Sep 09, 2020 at 03:49:30PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/9 =E4=B8=8B=E5=8D=883:08, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 3b54a0a703f17d2b1317d24beefcdcca587a7667 ("[PATCH v3 3/5] btrfs=
: Detect unbalanced tree with empty leaf before crashing btree operations")
>>> url: https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-Enhanced-=
runtime-defence-against-fuzzed-images/20200809-201720
>>> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-=
next
>>>
>>> in testcase: fio-basic
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	disk: 1SSD
>>> 	fs: btrfs
>>> 	nr_task: 100%
>>> 	test_size: 128G
>>> 	rw: write
>>> 	bs: 4k
>>> 	ioengine: sync
>>> 	cpufreq_governor: performance
>>> 	ucode: 0x400002c
>>> 	fs2: nfsv4
>>>
>>> test-description: Fio is a tool that will spawn a number of threads or =
processes doing a particular type of I/O action as specified by the user.
>>> test-url: https://github.com/axboe/fio
>>>
>>>
>>> on test machine: 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40G=
Hz with 128G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
>>>
>>>
>>> +----------------------------------------------------------------------=
------+------------+------------+
>>> |                                                                      =
      | 2703206ff5 | 3b54a0a703 |
>>> +----------------------------------------------------------------------=
------+------------+------------+
>>> | boot_successes                                                       =
      | 9          | 0          |
>>> | boot_failures                                                        =
      | 4          |            |
>>> | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block=
(#,#) | 4          |            |
>>> +----------------------------------------------------------------------=
------+------------+------------+
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>
>> According to the full dmesg, it's invalid nritems causing transaction ab=
ort.
>>
>> I'm not sure if it's caused by corrupts fs or something else.
>>
>> If intel guys can reproduce it reliably, would you please add such debug
>> diff to output extra info?
>=20
> Hi Qu, sorry for late. we double confirmed the issue can be reproduced re=
liably.
> The error will only occur on fbc but not parent commit.
>=20
> below from applying your path for extra info
> [   42.539443] [task_0]$
> [   42.539445]~$
> [   42.546125] rw=3Dwrite$
> [   42.546126]~$
> [   42.551637] directory=3D/fs/nvme1n1p1$
> [   42.551638]~$
> [   42.559135] numjobs=3D96' | fio --output-format=3Djson -$
> [   42.559136]~$
> [   42.574513] perf version 5.9.rc4.g34d4ddd359db$
> [   42.574518]~$
> [   56.152662] BTRFS error (device nvme1n1p1): invalid tree nritems, byte=
nr=3D13238272 owner=3D7 level=3D0 first_key=3D(18446744073709551606 128 969=
41895680) nritems=3D0
>  expect >0$

Just as expected, this is indeed csum tree.
And it looks like it's indeed still valid.

The csum root can still have its key from previous not emptry csum.

In that case, the check is indeed too strict and causes false alert.

I'll soon send out a fix with Intel reported-by.

Thanks,
Qu

> [   56.152664] BTRFS error (device nvme1n1p1): invalid tree nritems, byte=
nr=3D13238272 owner=3D7 level=3D0 first_key=3D(18446744073709551606 128 969=
41895680) nritems=3D0
>  expect >0$
> [   56.152666] ------------[ cut here ]------------$
> [   56.168263] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io=
:2687: errno=3D-117 Filesystem corrupted$
> [   56.168264] BTRFS info (device nvme1n1p1): forced readonly$
> [   56.205009] BTRFS: Transaction aborted (error -117)$
> [   56.210368] WARNING: CPU: 71 PID: 537 at fs/btrfs/inode.c:2687 btrfs_f=
inish_ordered_io+0x70a/0x820 [btrfs]$
> [   56.220466] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsd=
 auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_core=
 btrfs blak
> e2b_generic sr_mod xor cdrom sd_mod zstd_decompress sg zstd_compress raid=
6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_therm=
al intel_po
> werclamp coretemp kvm_intel ipmi_ssif kvm irqbypass ast drm_vram_helper c=
rct10dif_pclmul drm_ttm_helper crc32_pclmul ttm crc32c_intel ghash_clmulni_=
intel rapl
> drm_kms_helper acpi_ipmi syscopyarea intel_cstate sysfillrect ahci sysimg=
blt nvme libahci fb_sys_fops intel_uncore mei_me nvme_core ioatdma t10_pi d=
rm mei liba
> ta joydev ipmi_si dca wmi ipmi_devintf ipmi_msghandler nfit libnvdimm ip_=
tables$
> [   56.285795] CPU: 71 PID: 537 Comm: kworker/u193:28 Not tainted 5.8.0-r=
c7-00166-g6e85ab8532a52 #1$
> [   56.295218] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]$
> [   56.302044] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]$
> [   56.308762] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00 4=
1 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 a0 9c 2c c1 e8 58 2e ec bf <=
0f> 0b 44 8
> 9 f9 ba 7f 0a 00 00 48 c7 c6 50 c7 2b c1 48 89 df e8 15$
> [   56.328846] RSP: 0018:ffffc90007babd58 EFLAGS: 00010282$
> [   56.334755] RAX: 0000000000000000 RBX: ffff888fb85984e0 RCX: 000000000=
0000000$
> [   56.342577] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff88904=
01d7f60$
> [   56.350415] RBP: ffff889007e2e4c0 R08: 0000000001200000 R09: 000000000=
0000000$
> [   56.358255] R10: 0000000000000001 R11: ffffffffc00bd060 R12: 000000001=
0e7e000$
> [   56.366121] R13: 0000000010e7efff R14: ffff888fb86622a8 R15: 00000000f=
fffff8b$
> [   56.373983] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) knlG=
S:0000000000000000$
> [   56.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033$
> [   56.389291] CR2: 00007fa44c4cc448 CR3: 0000005eac7c0006 CR4: 000000000=
07606e0$
> [   56.397176] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000$
> [   56.405065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400$
> [   56.412952] PKRU: 55555554$
> [   56.416419] Call Trace:$
> [   56.419631]  ? update_curr+0xc0/0x200$
> [   56.424060]  ? newidle_balance+0x232/0x3e0$
> [   56.428958]  btrfs_work_helper+0xc9/0x400 [btrfs]$
> [   56.434441]  ? __schedule+0x378/0x860$
> [   56.438895]  process_one_work+0x1b5/0x3a0$
> [   56.443690]  worker_thread+0x50/0x3c0$
> [   56.446698] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-enco=
ding=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/=
lkp/jobs/scheduled/
> lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-sync-100%25-300s-w=
rite-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x86_64-20200603-=
20200915-84129-
> 1i8kzyy-0.yaml&job_state=3Dpost_run -O /dev/null$
> [   56.446700]~$
> [   56.448144]  ? process_one_work+0x3a0/0x3a0$
> [   56.491886]  kthread+0x114/0x160$
> [   56.495986]  ? kthread_park+0xa0/0xa0$
> [   56.500522]  ret_from_fork+0x1f/0x30$
> [   56.504966] ---[ end trace fbe43e164e851f97 ]---$
> [   56.510432] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered_io=
:2687: errno=3D-117 Filesystem corrupted$
>=20
>=20
> I also attached full dmesg 'dmesg-with-debug' for your reference.
>=20
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index b1a148058773..b050d6fcb90a 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -406,8 +406,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
>> int level,
>>         /* We have @first_key, so this @eb must have at least one item *=
/
>>         if (btrfs_header_nritems(eb) =3D=3D 0) {
>>                 btrfs_err(fs_info,
>> -               "invalid tree nritems, bytenr=3D%llu nritems=3D0 expect =
>0",
>> -                         eb->start);
>> +               "invalid tree nritems, bytenr=3D%llu owner=3D%llu level=
=3D%d
>> first_key=3D(%llu %u %llu) nritems=3D0 expect >0",
>> +                         eb->start, btrfs_header_owner(eb),
>> btrfs_header_level(eb),
>> +                         first_key->objectid, first_key->type,
>> first_key->offset);
>>                 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>                 return -EUCLEAN;
>>         }
>>
>> Thanks,
>> Qu
>>
>>> [   50.226906] WARNING: CPU: 71 PID: 500 at fs/btrfs/inode.c:2687 btrfs=
_finish_ordered_io+0x70a/0x820 [btrfs]
>>> [   50.236913] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nf=
sd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_co=
re btrfs sr_mod blake2b_generic xor cdrom sd_mod zstd_decompress sg zstd_co=
mpress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg=
_temp_thermal ipmi_ssif intel_powerclamp coretemp kvm_intel kvm irqbypass a=
st crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel acpi_ipmi drm=
_ttm_helper ghash_clmulni_intel ttm rapl drm_kms_helper intel_cstate syscop=
yarea sysfillrect nvme sysimgblt intel_uncore fb_sys_fops nvme_core ahci li=
bahci t10_pi drm mei_me ioatdma libata mei ipmi_si joydev dca wmi ipmi_devi=
ntf ipmi_msghandler nfit libnvdimm ip_tables
>>> [   50.301669] CPU: 71 PID: 500 Comm: kworker/u193:5 Not tainted 5.8.0-=
rc7-00165-g3b54a0a703f17 #1
>>> [   50.310904] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
>>> [   50.317626] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
>>> [   50.324255] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 00=
 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 70 1c 2b c1 e8 58 ae ed bf=
 <0f> 0b 44 89 f9 ba 7f 0a 00 00 48 c7 c6 50 47 2a c1 48 89 df e8 15
>>> [   50.344116] RSP: 0018:ffffc90007a83d58 EFLAGS: 00010282
>>> [   50.349923] RAX: 0000000000000000 RBX: ffff888a93ca5ea0 RCX: 0000000=
000000000
>>> [   50.357656] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff889=
0401d7f60
>>> [   50.365385] RBP: ffff8890300ab8a8 R08: 0000000000000bd4 R09: 0000000=
000000000
>>> [   50.373133] R10: 0000000000000001 R11: ffffffffc0714060 R12: 0000000=
00f83e000
>>> [   50.381060] R13: 000000000f83ffff R14: ffff888fb6c39968 R15: 0000000=
0ffffff8b
>>> [   50.388824] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) kn=
lGS:0000000000000000
>>> [   50.397545] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   50.404300] CR2: 00007feacc500f98 CR3: 0000000f74422006 CR4: 0000000=
0007606e0
>>> [   50.412477] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>>> [   50.420281] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>>> [   50.428082] PKRU: 55555554
>>> [   50.431451] Call Trace:
>>> [   50.434570]  ? update_curr+0xc0/0x200
>>> [   50.438919]  ? newidle_balance+0x232/0x3e0
>>> [   50.443700]  ? __wake_up_common+0x80/0x180
>>> [   50.448491]  btrfs_work_helper+0xc9/0x400 [btrfs]
>>> [   50.453880]  ? __schedule+0x378/0x860
>>> [   50.458218]  process_one_work+0x1b5/0x3a0
>>> [   50.462917]  worker_thread+0x50/0x3c0
>>> [   50.467262]  ? process_one_work+0x3a0/0x3a0
>>> [   50.472148]  kthread+0x114/0x160
>>> [   50.476084]  ? kthread_park+0xa0/0xa0
>>> [   50.480445]  ret_from_fork+0x1f/0x30
>>> [   50.484731] ---[ end trace cc096c1a2068030e ]---
>>>
>>>
>>> To reproduce:
>>>
>>>         git clone https://github.com/intel/lkp-tests.git
>>>         cd lkp-tests
>>>         bin/lkp install job.yaml  # job file is attached in this email
>>>         bin/lkp run     job.yaml
>>>
>>>
>>>
>>> Thanks,
>>> Oliver Sang
>>>
>>

