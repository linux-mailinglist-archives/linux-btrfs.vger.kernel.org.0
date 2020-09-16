Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808C826BB50
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 06:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIPEUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 00:20:37 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:30857 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgIPEUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 00:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600230027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=rpLzUgVLnhDtyUwqr+e4ZAddxB7JT0e4vYpvME2VtgA=;
        b=ZnkPi9dGxAxf7Usjb/mT/n58OjB5FkGUTqb3LWvllNIDXFrFkyuc9cXfMDqdriwHAeO+eZ
        +rdhHuHo5uP1cDSkSQHOylbzD2cL7oablZC75pGISmNQQN2oToEtkY6hVev9RvsY11h5Vw
        DFrxtOduYFvczinhIoJKl+c05pB9fJY=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-V21tk9pcMt-kdFkIFchPtg-1; Wed, 16 Sep 2020 06:20:26 +0200
X-MC-Unique: V21tk9pcMt-kdFkIFchPtg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWBJMqxtWy5huvQ1JFM6Xr+zdPovERQQuU93SUJ/iDc44LIuCu1K0i2V0/j4YrC2XioCngn2rEgXV627nTqgD9IYpn4DGOXg9zvbGrJJc9FPUgiGHXI1I0sHUljRAC07+ajrNpW/2OlEx/w68xXipqr6cscedmLcElhPvkM2AmRHLktocNLS9vfuB9aBXg6Va4Ij2Cppiyn+CormAK/Tfwe56ieNpSUSEMqw6yAlSzBzDlK2DdEmDGX1R5Ex3isy3af8yLU6GfLcIaTnFlDxGrEsFRb3wEZA5hcGg2a8FB2PMdmlzu98wxiE/4jqRW7/hczgodqS5EHAyqcrw/za0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61OBlK3j9ye8GjpoJzVteoYs+XIT5nN+i+cdQ6hg5d8=;
 b=ROoK8OSUdQgpKZxLv735XaBdzlUCWhY6ZaHQlrNEO6S3Oj/RSeWHXwoUSEGY67FiyrxqOuFuAkvpakkLIfz/8Iy0kP58rn4TYfdw8MHYHLxyVC/vsJdBwz1fy/FwkumiO1hoSaYQt5tOYK0QoKy1azwmxqpsbb98+qDztoyUUCYrZirgaL8PUlsRsIXqh4bCRqbqQoz5vJyDM6DySAK2XHlO1/syqI6f0dY2bMJRzJ0YuMVwqoAGjTAD6QlK7eBsrFD7hWfGgLuT7NoRgGg9LREQCZg69xpF/J8AKudJWfJy2maXOgeOysG4fOECdwXKc9jRntfdSD8kfx1Zyp4yVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5251.eurprd04.prod.outlook.com (2603:10a6:208:ce::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 04:20:24 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 04:20:24 +0000
Subject: Re: [btrfs] 3b54a0a703:
 WARNING:at_fs/btrfs/inode.c:#btrfs_finish_ordered_io[btrfs]
To:     Oliver Sang <oliver.sang@intel.com>
CC:     linux-btrfs@vger.kernel.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200909070857.GA25950@xsang-OptiPlex-9020>
 <29350c54-fb8e-433e-404c-d72c83f3989a@suse.com>
 <20200915055411.GC17463@xsang-OptiPlex-9020>
 <4ea5f2ba-df33-114a-3cfa-4d7dd35c04c3@suse.com>
 <4d3b8b3a-31b7-4476-e83c-e9894ceed0d3@suse.com>
 <20200916033233.GA31649@xsang-OptiPlex-9020>
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
Message-ID: <15b3efac-3e69-a212-6fbe-179df3cc6a11@suse.com>
Date:   Wed, 16 Sep 2020 12:20:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200916033233.GA31649@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0076.namprd11.prod.outlook.com (2603:10b6:a03:f4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 04:20:21 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464ad880-a9ed-4e25-2c44-08d859f7d4f4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5251:
X-Microsoft-Antispam-PRVS: <AM0PR04MB525125501F0A1BC6ED208CEBD6210@AM0PR04MB5251.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFaGZ0KEE0ZVwKWf/S4hjvseMW3RS5FtIfDoOe7bE+qiw871vVCvpKQjMLf4AqGo0wKU/AImZKI03y6grAtqzeiTjXRor5Rkabt/GMytmmRSwzUq+QecN4VygmsOWTg6tCIyRGC7Pmq9/637HD8/ZIVQaRAh0B4aT4z7dfsCnOQZVVAsA+7IhEx8eMvXhOY1NefbuaBXtf0ZFvNxhyR7A3x8wE7epA83WjPRnvPEln4diznHZbsQ3YNVSLDPyqPgQpEk1SV6nvjzCZ2RSuJW+WUng3K/nh/KcORgmaNnbdnzV/sT+1fcS//y6fhM0drREF+Qe06jk2DzBN1lr+q6JPBZoW8p/+diOMS8H8OnutBsydnumX/bftDLQY/PwtBLy/XbNSbVIOjOHiZYSg6lcN0xl0GeXtLtfWjpA9dUqEkGHwf9U0WvCUCBluVb+WbA8dfLV2ZHu9ldDWtcKYul5XcfVEWzs1EVaJiyul2AI4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(54906003)(26005)(16526019)(8936002)(186003)(8676002)(52116002)(16576012)(45080400002)(36756003)(66556008)(966005)(316002)(66946007)(478600001)(66476007)(4326008)(31686004)(6706004)(6916009)(6666004)(30864003)(83380400001)(6486002)(86362001)(31696002)(5660300002)(956004)(2906002)(2616005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eGvpt6VcTpkLprQamp0Rba1uiqdXgffRATeGD6/O0pI6jL+kTsfy+Rph6PQ09MZ6l7oumYPdVzINNVoFidOMoD0Jq8mUwi8Vr3pLZ/XROIXMZv3gcNH2id8uU7wgi/z1++zHpdyM0BAfDa+qmvn5XDIX+gPOBxybugWbQ9miL8HccOwPrNpkMBufRQjvBZ1T+5FyM3w/3Gkd5pPhBc2wRGpa+c7BZgB8ltKF5VyKs68hzH3/jb4ENwDlym7+TxgWCV6r5nWs4VovsQemfzqRi0TGAMjLnsbKAWSDvejXfRzA0W9Fla5z0XUgeoWb4eGhBehuP7J+wGUiNMtY5kB3OvbTmfpu7jGz/FReZIKIUhimRzeQfC0xZLDA+QV28k5mtXfeHQuEw5dtX/yI1+pbs9vKy5OggMSGLjE5VG9fNVDWd7FAbVkg9Bq5La5nEiVkyoBsPnMahQvdmD1UOkZ/cKLYmcf5zbsrwmvfpBHZwp2mp19ftJZBJvk85VH1jdGMqddIiQ0p8J5pislUXRyyr+iVV2iFa9R7JTS4kvjAuTm+dHbyd4fOvg5WHu7njIfW6MxWjZZobOyoNtl3k/1u5F2OgVsN6xV0FVz7/4GceMmsfjTK8aVhqxku8aFJXubWaJ8kFadu7MCIr8A09fKPYw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ad880-a9ed-4e25-2c44-08d859f7d4f4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 04:20:24.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Xga5xF9sJfwJInF4VvJN6lQhO+h5/k8mAnLMJC3knbzWn7QC+OWdFTZ9maFPen/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5251
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/16 =E4=B8=8A=E5=8D=8811:32, Oliver Sang wrote:
> On Tue, Sep 15, 2020 at 04:00:40PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/15 =E4=B8=8B=E5=8D=883:40, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/9/15 =E4=B8=8B=E5=8D=881:54, Oliver Sang wrote:
>>>> On Wed, Sep 09, 2020 at 03:49:30PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2020/9/9 =E4=B8=8B=E5=8D=883:08, kernel test robot wrote:
>>>>>> Greeting,
>>>>>>
>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>
>>>>>> commit: 3b54a0a703f17d2b1317d24beefcdcca587a7667 ("[PATCH v3 3/5] bt=
rfs: Detect unbalanced tree with empty leaf before crashing btree operation=
s")
>>>>>> url: https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-Enhanc=
ed-runtime-defence-against-fuzzed-images/20200809-201720
>>>>>> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git f=
or-next
>>>>>>
>>>>>> in testcase: fio-basic
>>>>>> with following parameters:
>>>>>>
>>>>>> 	runtime: 300s
>>>>>> 	disk: 1SSD
>>>>>> 	fs: btrfs
>>>>>> 	nr_task: 100%
>>>>>> 	test_size: 128G
>>>>>> 	rw: write
>>>>>> 	bs: 4k
>>>>>> 	ioengine: sync
>>>>>> 	cpufreq_governor: performance
>>>>>> 	ucode: 0x400002c
>>>>>> 	fs2: nfsv4
>>>>>>
>>>>>> test-description: Fio is a tool that will spawn a number of threads =
or processes doing a particular type of I/O action as specified by the user=
.
>>>>>> test-url: https://github.com/axboe/fio
>>>>>>
>>>>>>
>>>>>> on test machine: 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.=
40GHz with 128G memory
>>>>>>
>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire=
 log/backtrace):
>>>>>>
>>>>>>
>>>>>> +-------------------------------------------------------------------=
---------+------------+------------+
>>>>>> |                                                                   =
         | 2703206ff5 | 3b54a0a703 |
>>>>>> +-------------------------------------------------------------------=
---------+------------+------------+
>>>>>> | boot_successes                                                    =
         | 9          | 0          |
>>>>>> | boot_failures                                                     =
         | 4          |            |
>>>>>> | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-bl=
ock(#,#) | 4          |            |
>>>>>> +-------------------------------------------------------------------=
---------+------------+------------+
>>>>>>
>>>>>>
>>>>>> If you fix the issue, kindly add following tag
>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>>
>>>>>>
>>>>>
>>>>> According to the full dmesg, it's invalid nritems causing transaction=
 abort.
>>>>>
>>>>> I'm not sure if it's caused by corrupts fs or something else.
>>>>>
>>>>> If intel guys can reproduce it reliably, would you please add such de=
bug
>>>>> diff to output extra info?
>>>>
>>>> Hi Qu, sorry for late. we double confirmed the issue can be reproduced=
 reliably.
>>>> The error will only occur on fbc but not parent commit.
>>>>
>>>> below from applying your path for extra info
>>>> [   42.539443] [task_0]$
>>>> [   42.539445]~$
>>>> [   42.546125] rw=3Dwrite$
>>>> [   42.546126]~$
>>>> [   42.551637] directory=3D/fs/nvme1n1p1$
>>>> [   42.551638]~$
>>>> [   42.559135] numjobs=3D96' | fio --output-format=3Djson -$
>>>> [   42.559136]~$
>>>> [   42.574513] perf version 5.9.rc4.g34d4ddd359db$
>>>> [   42.574518]~$
>>>> [   56.152662] BTRFS error (device nvme1n1p1): invalid tree nritems, b=
ytenr=3D13238272 owner=3D7 level=3D0 first_key=3D(18446744073709551606 128 =
96941895680) nritems=3D0
>>>>  expect >0$
>>>
>>> Just as expected, this is indeed csum tree.
>>> And it looks like it's indeed still valid.
>>>
>>> The csum root can still have its key from previous not emptry csum.
>>
>> Wait for a minute, if it's csum root empty, we shouldn't have first_key
>> passed in.
>>
>> So this still has something wrong.
>>
>> Would you please try this diff to provide more debug info?
>> (Better to remove the existing diff)
>=20
> Hi Qu, please find the attached kmsg-debug-2.xz.
> also since I found two identical section in 3b54a0a703,
> so I applied below patch to both places.
> I also attached the final patch as 0001-debug-version-2.patch,
> for you to check if there's problem.

Oh, that's the problem.

The patch I submitted has a bug that the check should only be after that
generation check.

For live tree blocks (newer than last committed) tree blocks can be
empty temporary.

The upstream has already merged the correct fix 62fdaa52a3d0 ("btrfs:
Detect unbalanced tree with empty leaf before crashing btree operations").

Sorry for the false alert and inconvience.

Thanks,
Qu


>=20
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 75bbe879ed18..6f29a3c38b56 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -400,10 +400,17 @@ int btrfs_verify_level_key(struct extent_buffer
>> *eb, int level,
>>
>>         /* We have @first_key, so this @eb must have at least one item *=
/
>>         if (btrfs_header_nritems(eb) =3D=3D 0) {
>> +               pr_info("%s: eb start=3D%llu gen=3D%llu last_committed=
=3D%llu\n",
>> +                       __func__, eb->start, btrfs_header_generation(eb)=
,
>> +                       fs_info->last_trans_committed);
>>                 btrfs_err(fs_info,
>>                 "invalid tree nritems, bytenr=3D%llu nritems=3D0 expect =
>0",
>>                           eb->start);
>> -               WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +               pr_info("%s: csum tree commit root:\n", __func__);
>> +               btrfs_print_tree(fs_info->csum_root->commit_root, true);
>> +               pr_info("%s: csum tree current root:\n", __func__);
>> +               btrfs_print_tree(fs_info->csum_root->node, true);
>> +               WARN_ON(1);
>>                 return -EUCLEAN;
>>         }
>>
>>
>>>
>>> In that case, the check is indeed too strict and causes false alert.
>>>
>>> I'll soon send out a fix with Intel reported-by.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> [   56.152664] BTRFS error (device nvme1n1p1): invalid tree nritems, b=
ytenr=3D13238272 owner=3D7 level=3D0 first_key=3D(18446744073709551606 128 =
96941895680) nritems=3D0
>>>>  expect >0$
>>>> [   56.152666] ------------[ cut here ]------------$
>>>> [   56.168263] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered=
_io:2687: errno=3D-117 Filesystem corrupted$
>>>> [   56.168264] BTRFS info (device nvme1n1p1): forced readonly$
>>>> [   56.205009] BTRFS: Transaction aborted (error -117)$
>>>> [   56.210368] WARNING: CPU: 71 PID: 537 at fs/btrfs/inode.c:2687 btrf=
s_finish_ordered_io+0x70a/0x820 [btrfs]$
>>>> [   56.220466] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver n=
fsd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem_c=
ore btrfs blak
>>>> e2b_generic sr_mod xor cdrom sd_mod zstd_decompress sg zstd_compress r=
aid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_pkg_temp_th=
ermal intel_po
>>>> werclamp coretemp kvm_intel ipmi_ssif kvm irqbypass ast drm_vram_helpe=
r crct10dif_pclmul drm_ttm_helper crc32_pclmul ttm crc32c_intel ghash_clmul=
ni_intel rapl
>>>> drm_kms_helper acpi_ipmi syscopyarea intel_cstate sysfillrect ahci sys=
imgblt nvme libahci fb_sys_fops intel_uncore mei_me nvme_core ioatdma t10_p=
i drm mei liba
>>>> ta joydev ipmi_si dca wmi ipmi_devintf ipmi_msghandler nfit libnvdimm =
ip_tables$
>>>> [   56.285795] CPU: 71 PID: 537 Comm: kworker/u193:28 Not tainted 5.8.=
0-rc7-00166-g6e85ab8532a52 #1$
>>>> [   56.295218] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]$
>>>> [   56.302044] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]$
>>>> [   56.308762] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00 0=
0 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 a0 9c 2c c1 e8 58 2e ec b=
f <0f> 0b 44 8
>>>> 9 f9 ba 7f 0a 00 00 48 c7 c6 50 c7 2b c1 48 89 df e8 15$
>>>> [   56.328846] RSP: 0018:ffffc90007babd58 EFLAGS: 00010282$
>>>> [   56.334755] RAX: 0000000000000000 RBX: ffff888fb85984e0 RCX: 000000=
0000000000$
>>>> [   56.342577] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff88=
90401d7f60$
>>>> [   56.350415] RBP: ffff889007e2e4c0 R08: 0000000001200000 R09: 000000=
0000000000$
>>>> [   56.358255] R10: 0000000000000001 R11: ffffffffc00bd060 R12: 000000=
0010e7e000$
>>>> [   56.366121] R13: 0000000010e7efff R14: ffff888fb86622a8 R15: 000000=
00ffffff8b$
>>>> [   56.373983] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000) k=
nlGS:0000000000000000$
>>>> [   56.382806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033$
>>>> [   56.389291] CR2: 00007fa44c4cc448 CR3: 0000005eac7c0006 CR4: 000000=
00007606e0$
>>>> [   56.397176] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000$
>>>> [   56.405065] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400$
>>>> [   56.412952] PKRU: 55555554$
>>>> [   56.416419] Call Trace:$
>>>> [   56.419631]  ? update_curr+0xc0/0x200$
>>>> [   56.424060]  ? newidle_balance+0x232/0x3e0$
>>>> [   56.428958]  btrfs_work_helper+0xc9/0x400 [btrfs]$
>>>> [   56.434441]  ? __schedule+0x378/0x860$
>>>> [   56.438895]  process_one_work+0x1b5/0x3a0$
>>>> [   56.443690]  worker_thread+0x50/0x3c0$
>>>> [   56.446698] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-e=
ncoding=3DUTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=
=3D/lkp/jobs/scheduled/
>>>> lkp-csl-2sp3/fio-basic-4k-performance-1SSD-btrfs-nfsv4-sync-100%25-300=
s-write-128G-ucode=3D0x400002c-monitor=3Da122c70f-debian-10.4-x86_64-202006=
03-20200915-84129-
>>>> 1i8kzyy-0.yaml&job_state=3Dpost_run -O /dev/null$
>>>> [   56.446700]~$
>>>> [   56.448144]  ? process_one_work+0x3a0/0x3a0$
>>>> [   56.491886]  kthread+0x114/0x160$
>>>> [   56.495986]  ? kthread_park+0xa0/0xa0$
>>>> [   56.500522]  ret_from_fork+0x1f/0x30$
>>>> [   56.504966] ---[ end trace fbe43e164e851f97 ]---$
>>>> [   56.510432] BTRFS: error (device nvme1n1p1) in btrfs_finish_ordered=
_io:2687: errno=3D-117 Filesystem corrupted$
>>>>
>>>>
>>>> I also attached full dmesg 'dmesg-with-debug' for your reference.
>>>>
>>>>>
>>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>>> index b1a148058773..b050d6fcb90a 100644
>>>>> --- a/fs/btrfs/disk-io.c
>>>>> +++ b/fs/btrfs/disk-io.c
>>>>> @@ -406,8 +406,9 @@ int btrfs_verify_level_key(struct extent_buffer *=
eb,
>>>>> int level,
>>>>>         /* We have @first_key, so this @eb must have at least one ite=
m */
>>>>>         if (btrfs_header_nritems(eb) =3D=3D 0) {
>>>>>                 btrfs_err(fs_info,
>>>>> -               "invalid tree nritems, bytenr=3D%llu nritems=3D0 expe=
ct >0",
>>>>> -                         eb->start);
>>>>> +               "invalid tree nritems, bytenr=3D%llu owner=3D%llu lev=
el=3D%d
>>>>> first_key=3D(%llu %u %llu) nritems=3D0 expect >0",
>>>>> +                         eb->start, btrfs_header_owner(eb),
>>>>> btrfs_header_level(eb),
>>>>> +                         first_key->objectid, first_key->type,
>>>>> first_key->offset);
>>>>>                 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>>>>>                 return -EUCLEAN;
>>>>>         }
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>> [   50.226906] WARNING: CPU: 71 PID: 500 at fs/btrfs/inode.c:2687 bt=
rfs_finish_ordered_io+0x70a/0x820 [btrfs]
>>>>>> [   50.236913] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver=
 nfsd auth_rpcgss dm_mod dax_pmem_compat nd_pmem device_dax nd_btt dax_pmem=
_core btrfs sr_mod blake2b_generic xor cdrom sd_mod zstd_decompress sg zstd=
_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common skx_edac x86_=
pkg_temp_thermal ipmi_ssif intel_powerclamp coretemp kvm_intel kvm irqbypas=
s ast crct10dif_pclmul drm_vram_helper crc32_pclmul crc32c_intel acpi_ipmi =
drm_ttm_helper ghash_clmulni_intel ttm rapl drm_kms_helper intel_cstate sys=
copyarea sysfillrect nvme sysimgblt intel_uncore fb_sys_fops nvme_core ahci=
 libahci t10_pi drm mei_me ioatdma libata mei ipmi_si joydev dca wmi ipmi_d=
evintf ipmi_msghandler nfit libnvdimm ip_tables
>>>>>> [   50.301669] CPU: 71 PID: 500 Comm: kworker/u193:5 Not tainted 5.8=
.0-rc7-00165-g3b54a0a703f17 #1
>>>>>> [   50.310904] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs=
]
>>>>>> [   50.317626] RIP: 0010:btrfs_finish_ordered_io+0x70a/0x820 [btrfs]
>>>>>> [   50.324255] Code: 48 0a 00 00 02 72 25 41 83 ff fb 0f 84 f2 00 00=
 00 41 83 ff e2 0f 84 e8 00 00 00 44 89 fe 48 c7 c7 70 1c 2b c1 e8 58 ae ed=
 bf <0f> 0b 44 89 f9 ba 7f 0a 00 00 48 c7 c6 50 47 2a c1 48 89 df e8 15
>>>>>> [   50.344116] RSP: 0018:ffffc90007a83d58 EFLAGS: 00010282
>>>>>> [   50.349923] RAX: 0000000000000000 RBX: ffff888a93ca5ea0 RCX: 0000=
000000000000
>>>>>> [   50.357656] RDX: ffff8890401e82a0 RSI: ffff8890401d7f60 RDI: ffff=
8890401d7f60
>>>>>> [   50.365385] RBP: ffff8890300ab8a8 R08: 0000000000000bd4 R09: 0000=
000000000000
>>>>>> [   50.373133] R10: 0000000000000001 R11: ffffffffc0714060 R12: 0000=
00000f83e000
>>>>>> [   50.381060] R13: 000000000f83ffff R14: ffff888fb6c39968 R15: 0000=
0000ffffff8b
>>>>>> [   50.388824] FS:  0000000000000000(0000) GS:ffff8890401c0000(0000)=
 knlGS:0000000000000000
>>>>>> [   50.397545] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [   50.404300] CR2: 00007feacc500f98 CR3: 0000000f74422006 CR4: 0000=
0000007606e0
>>>>>> [   50.412477] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
>>>>>> [   50.420281] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
>>>>>> [   50.428082] PKRU: 55555554
>>>>>> [   50.431451] Call Trace:
>>>>>> [   50.434570]  ? update_curr+0xc0/0x200
>>>>>> [   50.438919]  ? newidle_balance+0x232/0x3e0
>>>>>> [   50.443700]  ? __wake_up_common+0x80/0x180
>>>>>> [   50.448491]  btrfs_work_helper+0xc9/0x400 [btrfs]
>>>>>> [   50.453880]  ? __schedule+0x378/0x860
>>>>>> [   50.458218]  process_one_work+0x1b5/0x3a0
>>>>>> [   50.462917]  worker_thread+0x50/0x3c0
>>>>>> [   50.467262]  ? process_one_work+0x3a0/0x3a0
>>>>>> [   50.472148]  kthread+0x114/0x160
>>>>>> [   50.476084]  ? kthread_park+0xa0/0xa0
>>>>>> [   50.480445]  ret_from_fork+0x1f/0x30
>>>>>> [   50.484731] ---[ end trace cc096c1a2068030e ]---
>>>>>>
>>>>>>
>>>>>> To reproduce:
>>>>>>
>>>>>>         git clone https://github.com/intel/lkp-tests.git
>>>>>>         cd lkp-tests
>>>>>>         bin/lkp install job.yaml  # job file is attached in this ema=
il
>>>>>>         bin/lkp run     job.yaml
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Oliver Sang
>>>>>>
>>>>>
>>

