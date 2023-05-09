Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10CD6FD2EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjEIXD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEIXD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:03:58 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CB2125
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 16:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOL3OaEYNLhOD6cKqhcAy4l5kHZrNJ64REjYle2NxDi4ujY3ui9vdEtrdrt5dAgy1+jmpeeYeZZN5MdHEf39/JeVXv08t8gAXwTNxGHkMA4PjiMwg4i5HHo8AhRtXqGbpblnCrP0nxLVvptP1/YlS0ZS13TrBsu2ZlZsoUtU0W0iq6KXPkEqTHHxN0wgko0CY0WhyE7ELJOQST9aJbFx9nfJ/73wz2n/2WuzjihlwgTZAP2ht2bXTqjECkvBToQDfdq2Ws9en9cugqJtnufrf7IzTI9+uVV8dz0SNiMVqaf30zeSeVScPWzoIiA7vjqMXlcI9bbYAECBUPMvkjALyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLXpGIabhtDhC4/KyGWFuExMt7tT2qd5jKmV1Ejolxs=;
 b=hiTneUzaykrfUKQbv2nnu/EW3lP92mM4h1oc6prYWPr6SLjpGs0w99Cpfwru8RFksnwdQxl8CTNUnwC5pNdhhty8tbmB7s2ab79hV6UQy2ynK05DgLvZrggNK+/rkYeNN4YTWB1lPke3I8yxlEalTX26fXSneZMmqFyzZOLMojDuaODkpyfV5Hy821uNnHLneI8lJYu8VzXUKt1UjMnMhvS7Pu/2uLnT+t7ELseS5+LPWC1wZ4elvby7M6NAJB3tRiXS+2BlFFX2pau17TocRxJPHSrS15Z2BXPDf1eSv8224usMeUyhbwDCfHRE9FjQiW/3boFMH/dFK4cIBcXAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLXpGIabhtDhC4/KyGWFuExMt7tT2qd5jKmV1Ejolxs=;
 b=UEjFeT0lwFJkbO+hhmUIlYKmcMAItIY/6PV0iUJh2nbPcsLzQFqMhksNBH9K3A3NqPqPqyHuhZPFuNr1UdXTOkijX0RMJAjS2YQn6iIqY6Hr6zOC0GLH2KkthTZKdybC/LXralYCK7Opr0iDFQZMtO0ayqxfL74AHASTY5nPUBfJsRRQ2qsqnppeSbOHZJWPf2CbS3E3QhOodhbVvEUgta6B3LTHPZMl3/3yxwX/K/YqFjDSu3lYE24gmz9+jTiDsaT1RBh9SdtfZVPvDTajW8oR66I3/eQOCSJOmMNzAAxLru4z9gofDlA+gl9x4mSY1kmGEq11kE1fb4TTZ9A9Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:03:52 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6387.019; Tue, 9 May 2023
 23:03:52 +0000
Message-ID: <6a175825-67a5-89f5-8456-6ffcf492ee9f@suse.com>
Date:   Wed, 10 May 2023 07:03:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Scrub errors unable to fixup (regular) error
To:     hendrik@friedels.name, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <25249f22-7e1b-43bf-9586-91c9803e4c28@email.android.com>
 <f941dacc-89f0-a9bc-a81a-aaf18d4fad47@gmail.com>
 <em3a7de55d-2b2b-45f6-9ecd-0725bd9bbace@59307873.com>
 <760e7198-4360-d68f-83fd-5ff27be57db5@gmx.com>
 <20230508205117.Horde.RK1QaW1dK8JHObLzII7D9cs@webmail.friedels.name>
 <6528e2b3-cc84-2faa-29e5-9a26fe1685a7@gmx.com>
 <20230509192639.Horde.QxWaLhyEPB3pLQHuBQtufoy@webmail.friedels.name>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230509192639.Horde.QxWaLhyEPB3pLQHuBQtufoy@webmail.friedels.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: f7270dba-0425-4609-d667-08db50e1a7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0A4AGkpfxfRtb+ktE9DsYZQVWp9tk1ipRrV+IPehFRFng1gXYGoAj1/LH5g82KNW8jTd6CMi5jdFJDMsLczc/rwAKIfw8ILWOqSwsODBeO4wFxHzxEcvqM/omNe+JoUBL/8yDLTLeF/S/5l14UySkZlu6rliB3V6vkxlgpj6mTtlLt3rJNGxgnITvUGwPqa+QwiON/4Q59D2u2cefntUJuW0fa+ZPwbEWUeZKE9SoC1hqTGIIITarLVhhkr/R49g1jaXA5s5GER0Af/aU0YySMDTuw1O7vzYRZteEfJCF8oM2iJrLSXU9Pq6fplXhjHLkrCg207Nrqf0PNlBigf4ZC4gKp/ZHsc0BPXUdPQcsn1t8PSjkU3DmuQ3lrbDRhUoN8pghBNciwbfTZA01vR0d69MfF08ZpnY/xlSp7547WWFIMIgc7kdPQ4w8u4YTopJUaIdup59E2HE8Rq2+D3UllUVL+946Br13sZDjgdD3t/qfOXZ0vp+yX0eranc7kGTKy1GVCRy+/BQqM6PkTVC4VVnPhbUsxhxJ/SMuNEPVWKV5+cidL0sGlqk0KpP+bPGTeHVRf6etTHTQrqcfrzuqUyDHn6I6pqThaNtuRIx9UdgpuLoI+f84RnSq1699QP9G47euAmM3QdDAUMBR9uUrjV6AZcUpxM4W8SyOw2+dx2ujPrrqfQ6zKp+OTQkZKelBpVsQYhfJhaXyJeRZqdeAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(6506007)(53546011)(6512007)(186003)(478600001)(31686004)(83380400001)(2616005)(6666004)(8676002)(966005)(6486002)(316002)(86362001)(41300700001)(5660300002)(38100700002)(36756003)(6916009)(66946007)(66476007)(8936002)(66556008)(30864003)(4326008)(31696002)(2906002)(518174003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2tBYzJ0RXFydkk0NUUxQmNiSEt5aXk2Y0s5SFg2SlFCeEdXY2ZoQW16NEdk?=
 =?utf-8?B?OEJ4MEplWXA4NmRSOUFZRG5BTVB0eS9NaVF0YUgvMElPK3N4NHJPRENZamQ1?=
 =?utf-8?B?UlN1RExjK3AxbWJ4ZDgzTnM0QVRWUXRSQ1JLY0hQRTVnbDhyT0o5cy9GdEcr?=
 =?utf-8?B?NkwyUThkWHJZck4wWXl2RzBWWjRWSE5IU0JhNUxTSTRDNStqVm9JVmhnREw0?=
 =?utf-8?B?bHNCVU11ZVhUTWk2YXd3RjdpYVRCNXozMDMzVmdlYStpWHlSK1M1SktVRExq?=
 =?utf-8?B?UWZ1K0tVajBGYUtRWjJ4dTB5SHhvVnJUc1NyWkI1Q0RWZVp0clVIS0hIbG1j?=
 =?utf-8?B?TnpPTFZDY1VUdG9OcHM0SWhpVUxOMmQvYklwQmlTc2dpdENKdGxhS0h2L28x?=
 =?utf-8?B?a2pieE9qSDl0akZFSjhYM2ZOdnR1YUdYR25rOXAyVlpyOTVGNjYyZ0ZLLzdN?=
 =?utf-8?B?aUE5QUJXa3ZTTDRaNytpLzV0N2RBV2NySW9Ba1FBaDVTOCtYdkU1Z1dPZmM3?=
 =?utf-8?B?MUpXYmdoM05GZEVCUVRNUitJYkpHYkFzMElWTnM5R2VxKzRzQ3RONnZtd01V?=
 =?utf-8?B?RitTdUVMRFhzcExNN3pHRzA1Nm1SeGFPMVd3aUtSSDRoamNZeStHdmVEZGhi?=
 =?utf-8?B?SUtKa2ZLYlcwdXhxUm5sQUs5c1hGOGNhaUxqVGtjSE11bFNZYnJ4bWRINm1O?=
 =?utf-8?B?SVhNblRLbEt4OThxMlVNQ2I3bnV3ckJFRHVMYldyZEVwUitLbXJuU2xuZlc4?=
 =?utf-8?B?MjhWVnJsaEdPNytUM2xLK2RpRUp1cDdqOU5sY29pcWpxY1JrV3gxcmxjdURo?=
 =?utf-8?B?dFU2WER0ajJxa1VQL2FRTy9WcnVsaHJxN2pzb092NTNQOTRIeWZneWpGQ3Ro?=
 =?utf-8?B?ZGRNcWk2QmttZEMyb1RRNVpBait1aW5Qb0NzQWhXSVUwSjFUZ2xxM3VuODJn?=
 =?utf-8?B?Q0ttZkMvWjR0VVNoM0c0V2hoR0hQVUlDdS9pek55Ri80Vld2WVdYc2huSURT?=
 =?utf-8?B?b291cndTTGw5NXdMRkVud2VNTkVMNUVKWHBoOS83RkxCN0xWelpJQ0Z3RWha?=
 =?utf-8?B?Yi9jMEZXMndjU3F1MXdLVlFvWWZDQ0hRSEFBUFJPdTJJbTdzYVZRL1djaXJu?=
 =?utf-8?B?VmFWbldQTTR1QTVSQ2hDZ05ZbVcrdjE1K3BXZi9wT1F5WWtPT2VTc3FxVjFU?=
 =?utf-8?B?TmJ2RytDUnUvMmFOajFDMGtINUF2Rnlra2cxVWcyODBoVmMzbVF2M0labmd3?=
 =?utf-8?B?bEtJcG5LbC9qV3p6UndQNWtXR092NFBsVVlsTElPVkZNR1dTQ0hJVkpJbjB5?=
 =?utf-8?B?dGliK3UwaXpiS21CK0kxR0Z0UUk1Q3B4WTBkMTFpRGY2RUxkaE9sZ3dtRERZ?=
 =?utf-8?B?eTk3a0ZsTUZraVZlckprT0htYktSSWlDZmZOUThMQ2lldFp6VVRMK0NjdDJ4?=
 =?utf-8?B?bm1LUDJyS0VEV3ZZRERKdm10N2ZKVUhoZkZRTHhraS9vQnpHU1ZpeTdOdHR1?=
 =?utf-8?B?WmZUanBRaHVqS1FkNkFvZGQ4TE1FNUxWU01RQTR0eDRHeWlmeGNnQlAxbVhw?=
 =?utf-8?B?SjM3V2hNcXZPMVJDMmF0cExRZXV5MGxpSGROVXArS3E0eVJYK0YzaW9ySGNO?=
 =?utf-8?B?VGxRNVBQRW5zYWZTcFFqUWRYenh6bUNEeG0wYUV0UHljbUpjWHJCS25rQWxr?=
 =?utf-8?B?WTY3MHNyN1NLZGY2bnZUOS9zWUpiZFNNczlBVmNoUnN2WVR1amJuYlFzeG0z?=
 =?utf-8?B?ZE91NjFoOGNkQWU1WmhFdXpBck41NUFsRlY3U2phbkZyNGN2V0dBcWkzcFh6?=
 =?utf-8?B?aVFaY3pZNUhsdHJPRlM1TkFhQkpOTHRaV0gwSFRqQWljTXhlQmd5VnV5UFNp?=
 =?utf-8?B?dVZCS3NKYXk3S09HWk1ac2lKd0xRTEVseml6SUxVTTZYVzY3TFpiR2RUVVF4?=
 =?utf-8?B?eWZlMzRaeUtZdGhrOXRhSzZ1bzh0dGdHTFUyYkMva0lNcWhEbXlUc04xQm1n?=
 =?utf-8?B?eVpWNG44OXVGMXo4bHVyeDdQVUxRRzhkSGUwM0drYTBNUzFXTldkOENYTWdk?=
 =?utf-8?B?OHhiM1lhU2Jpc0VkY0pMVnFMc1VFNmF2dEFsaFVxRUNkbzVzY1V1d09UUk9m?=
 =?utf-8?B?YjJwaDBxczhuaU1uT1c1MG56RkFkMjJOTDlzM0RRcVFVdDdMd0N4ZEFyMWpV?=
 =?utf-8?Q?I3+VIhp12P5lcdbwTf6FF3I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7270dba-0425-4609-d667-08db50e1a7e3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 23:03:51.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiqXE+xRLebRR0j1ojF4SkXCsgLRerBH3ZLwg3Bwhy+hQO1x8T+XdoOZd1ct1pj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/10 01:26, hendrik@friedels.name wrote:
> Hi Qu,
> 
> thanks for your reply.
> 
> I feel a bit helpless:
> wget 
> https://github.com/kdave/btrfs-progs/archive/16f9a8f43a4ed6984349b502151049212838e6a0.zip
> unpack, change into dir
> patch --dry-run -ruN --strip 1 < ../patch
> 
> checking file Documentation/btrfs-inspect-internal.rst
> checking file cmds/inspect.c
> Hunk #1 FAILED at 167.
> Hunk #2 FAILED at 216.
> Hunk #3 FAILED at 258.
> 3 out of 3 hunks FAILED
> checking file common/utils.c
> Hunk #1 FAILED at 424.
> Hunk #2 succeeded at 528 with fuzz 1.
> 1 out of 2 hunks FAILED
> checking file tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
> Hunk #1 FAILED at 51.
> 1 out of 1 hunk FAILED
> 
> What am I doing wrong?

Please grab this branch directly:

https://github.com/adam900710/btrfs-progs/tree/logic_resolve

You can go git command to fetch that branch or through the webUI to 
download the zip.

Thanks,
Qu
> 
> Best regards,
> Hendrik
> 
> 
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
> 
>> On 2023/5/9 02:51, hendrik@friedels.name wrote:
>>> Dear Qu,
>>>
>>> great, thank you!
>>> Can you tell me, where to find the basis for this patch?
>>>
>>> I tried to patch against master of 
>>> https://github.com/kdave/btrfs-progs, but that seems wrong:
>>>
>>> checking file Documentation/btrfs-inspect-internal.rst
>>> checking file cmds/inspect.c
>>> Hunk #1 FAILED at 167.
>>> Hunk #2 FAILED at 216.
>>> Hunk #3 FAILED at 258.
>>> 3 out of 3 hunks FAILED
>>> checking file common/utils.c
>>> Hunk #1 FAILED at 424.
>>> Hunk #2 succeeded at 528 with fuzz 1.
>>> 1 out of 2 hunks FAILED
>>> checking file 
>>> tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
>>> Hunk #1 FAILED at 51.
>>> 1 out of 1 hunk FAILED
>>>
>>> I have also tried to patch against v6.3 also with failed Hunks.
>>
>> It needs to be applied to David's devel branch.
>>
>> I applied against 16f9a8f43a4ed6984349b502151049212838e6a0 
>> btrfs-progs: build: enable -Wmissing-prototypes, and it works as 
>> expected.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Best regards,
>>> Hendrik
>>>
>>>
>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>> On 2023/4/5 16:41, Hendrik Friedel wrote:
>>>>> Hello Andrei,
>>>>>
>>>>> this partially works:
>>>>> root@homeserver:/home/henfri# btrfs inspect-internal 
>>>>> logical-resolve 254530580480
>>>>
>>>> The user interface of logical-resolve is a total mess, it requires 
>>>> every subvolume to be mounted.
>>>>
>>>> You can apply this patch, and mount the subvolid 5, then 
>>>> logical-resolve would properly handle all the path lookup:
>>>>
>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/7ccf52d35fdcdf743a254f3c93065f9334d878f8.1681971385.git.wqu@suse.com/
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>> inode 22214605 subvol dockerconfig/.snapshots/582/snapshot could 
>>>>> not be accessed: not mounted
>>>>> inode 22214605 subvol dockerconfig/.snapshots/586/snapshot could 
>>>>> not be accessed: not mounted
>>>>> inode 22214605 subvol dockerconfig/.snapshots/583/snapshot could 
>>>>> not be accessed: not mounted
>>>>> inode 22214605 subvol dockerconfig/.snapshots/584/snapshot could 
>>>>> not be accessed: not mounted
>>>>> inode 22214605 subvol dockerconfig/.snapshots/581/snapshot could 
>>>>> not be accessed: not mounted
>>>>> inode 22214605 subvol dockerconfig/.snapshots/585/snapshot could 
>>>>> not be accessed: not mounted
>>>>> root@homeserver:/home/henfri# btrfs inspect-internal 
>>>>> logical-resolve 224457719808 
>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>> root@homeserver:/home/henfri# btrfs inspect-internal 
>>>>> logical-resolve 196921389056 
>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>> root@homeserver:/home/henfri# btrfs inspect-internal 
>>>>> logical-resolve 254530899968 
>>>>> /srv/dev-disk-by-id-ata-Micron_1100_MTFDDAV256TBN_17501A32891E-part3/
>>>>>
>>>>> I do not quite understand, why it complains of the subvol not being 
>>>>> mounted, as I have mounted the root-volume...
>>>>>
>>>>> However, it already shows that some of the files (all that I found) 
>>>>> are in snapshots, which are read only...
>>>>>
>>>>> I am not sure, what the best way would be to get rid of the errors. 
>>>>> Do you have any suggestion?
>>>>>
>>>>> Best regards,
>>>>> Hendrik
>>>>>
>>>>> ------ Originalnachricht ------
>>>>> Von "Andrei Borzenkov" <arvidjaar@gmail.com>
>>>>> An "Hendrik Friedel" <hendrik@friedels.name>
>>>>> Cc linux-btrfs@vger.kernel.org
>>>>> Datum 04.04.2023 21:07:42
>>>>> Betreff Re: Scrub errors unable to fixup (regular) error
>>>>>
>>>>>> On 03.04.2023 09:44, Hendrik Friedel wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> thanks.
>>>>>>> Can you Tell ne, how I identify the affected files?
>>>>>>>
>>>>>>
>>>>>> You could try
>>>>>>
>>>>>> btrfs inspect-internal logical-resolve NNNNN /btrfs/mount/point
>>>>>>
>>>>>> where NNNNN is logical address from kernel message
>>>>>>
>>>>>>> Best regards,
>>>>>>> Hendrik
>>>>>>>
>>>>>>> Am 03.04.2023 08:41 schrieb Andrei Borzenkov <arvidjaar@gmail.com>:
>>>>>>>
>>>>>>>      On Sun, Apr 2, 2023 at 10:26 PM Hendrik Friedel 
>>>>>>> <hendrik@friedels.name> wrote:
>>>>>>>       >
>>>>>>>       > Hello,
>>>>>>>       >
>>>>>>>       > after a scrub, I had these errors:
>>>>>>>       > [Sa Apr  1 23:23:28 2023] BTRFS info (device sda3): 
>>>>>>> scrub: started on
>>>>>>>       > devid 1
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev 
>>>>>>> /dev/sda3
>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): 
>>>>>>> unable to fixup
>>>>>>>       > (regular) error at logical 2244718592 on dev /dev/sda3
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev 
>>>>>>> /dev/sda3
>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): 
>>>>>>> unable to fixup
>>>>>>>       > (regular) error at logical 2260582400 on dev /dev/sda3
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev 
>>>>>>> /dev/sda3
>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev 
>>>>>>> /dev/sda3
>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): 
>>>>>>> unable to fixup
>>>>>>>       > (regular) error at logical 2260054016 on dev /dev/sda3
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): 
>>>>>>> unable to fixup
>>>>>>>       > (regular) error at logical 2259877888 on dev /dev/sda3
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev 
>>>>>>> /dev/sda3
>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): 
>>>>>>> unable to fixup
>>>>>>>       > (regular) error at logical 2259935232 on dev /dev/sda3
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev 
>>>>>>> /dev/sda3
>>>>>>>       > errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
>>>>>>>       > [Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): 
>>>>>>> unable to fixup
>>>>>>>       > (regular) error at logical 2264600576 on dev /dev/sda3
>>>>>>>       >
>>>>>>>       >
>>>>>>>       > root@homeserver:~# btrfs scrub status /dev/sda3
>>>>>>>       > UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>       > Scrub started:    Sat Apr  1 23:24:01 2023
>>>>>>>       > Status:           finished
>>>>>>>       > Duration:         0:09:03
>>>>>>>       > Total to scrub:   146.79GiB
>>>>>>>       > Rate:             241.40MiB/s
>>>>>>>       > Error summary:    csum=239
>>>>>>>       >    Corrected:      0
>>>>>>>       >    Uncorrectable:  239
>>>>>>>       >    Unverified:     0
>>>>>>>       > root@homeserver:~# btrfs fi show /dev/sda3
>>>>>>>       > Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>       >          Total devices 1 FS bytes used 146.79GiB
>>>>>>>       >          devid    1 size 198.45GiB used 198.45GiB path 
>>>>>>> /dev/sda3
>>>>>>>       >
>>>>>>>       >
>>>>>>>       > Smartctl tells me:
>>>>>>>       > SMART Attributes Data Structure revision number: 16
>>>>>>>       > Vendor Specific SMART Attributes with Thresholds:
>>>>>>>       > ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
>>>>>>>       > UPDATED  WHEN_FAILED RAW_VALUE
>>>>>>>       >    1 Raw_Read_Error_Rate     0x002f   100   100   000   
>>>>>>>  Pre-fail  Always
>>>>>>>       >        -       2
>>>>>>>       >    5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010   
>>>>>>>  Old_age   Always
>>>>>>>       >        -       2
>>>>>>>       >    9 Power_On_Hours          0x0032   100   100   000   
>>>>>>>  Old_age   Always
>>>>>>>       >        -       4930
>>>>>>>       >   12 Power_Cycle_Count       0x0032   100   100   000   
>>>>>>>  Old_age   Always
>>>>>>>       >        -       1864
>>>>>>>       > 171 Program_Fail_Count      0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 172 Erase_Fail_Count        0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 173 Ave_Block-Erase_Count   0x0032   049   049   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       769
>>>>>>>       > 174 Unexpect_Power_Loss_Ct  0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       22
>>>>>>>       > 183 SATA_Interfac_Downshift 0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 184 Error_Correction_Count  0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 187 Reported_Uncorrect      0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 194 Temperature_Celsius     0x0022   068   051   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       32 (Min/Max 9/49)
>>>>>>>       > 196 Reallocated_Event_Count 0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       2
>>>>>>>       > 197 Current_Pending_ECC_Cnt 0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 198 Offline_Uncorrectable   0x0030   100   100   000    
>>>>>>> Old_age
>>>>>>>       > Offline      -       0
>>>>>>>       > 199 UDMA_CRC_Error_Count    0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 202 Percent_Lifetime_Remain 0x0030   049   049   001    
>>>>>>> Old_age
>>>>>>>       > Offline      -       51
>>>>>>>       > 206 Write_Error_Rate        0x000e   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       > 246 Total_LBAs_Written      0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       146837983747
>>>>>>>       > 247 Host_Program_Page_Count 0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       4592609183
>>>>>>>       > 248 FTL_Program_Page_Count  0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       4948954393
>>>>>>>       > 180 Unused_Reserve_NAND_Blk 0x0033   000   000   000    
>>>>>>> Pre-fail  Always
>>>>>>>       >        -       2050
>>>>>>>       > 210 Success_RAIN_Recov_Cnt  0x0032   100   100   000    
>>>>>>> Old_age   Always
>>>>>>>       >        -       0
>>>>>>>       >
>>>>>>>       > What would you recommend wrt. the health of the drive 
>>>>>>> (ssd) and to fix
>>>>>>>       > these errors?
>>>>>>>       >
>>>>>>>
>>>>>>>      Scrub errors can only be corrected if the filesystem has 
>>>>>>> redundancy.
>>>>>>>      You have a single device which in the past defaulted to dup for
>>>>>>>      metadata and single for data. If errors are in the data 
>>>>>>> part, then the
>>>>>>>      only way to fix it is to delete files containing these blocks.
>>>>>>>
>>>>>>>      Scrub error means data written to stable storage is bad. It is
>>>>>>>      unlikely caused by SSD error, could be software bug, could 
>>>>>>> be faulty
>>>>>>>      RAM.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 
