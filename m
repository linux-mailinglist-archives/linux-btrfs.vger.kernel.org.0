Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCB5F7184
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiJFXDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 19:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiJFXDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 19:03:44 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10082.outbound.protection.outlook.com [40.107.1.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760F4E41E
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 16:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwSwGkcw2innAJqrv4+nbI1i1fS968MvxxUmydne2FehzTcVdI+LOrFhPCDTboEyVLnPolRxBDcqry6lkCOJpHB6P/wB03D2cUxBIzlG0zYAAA2YULWmjpD1ZDD3kFVMTJmZwiDBiIS8vrpeNic/4rC0U1XftKLNSqq8zz69HOfzJBmnAE90wLcWLvok+NQQVBn4QMogAXjphe6aoGBzAm0v/Ovh21yWGABL077N2j2YdHCfIx3rgmW0vsQ7eccX2c6WhIykfMN+pSLM4F+XPyPMik5Ju2j8GmE1r3/8984c+IPAyKTIdLJXBjbdb9Y5XygLIHVQPbQVIDaGSpamFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra1tLkPc0thaRdRAHDAOTWBfHJ1k85NE6PVY1XFSSgk=;
 b=g30pMKpIfFBPTy7cefWOu6qwQw3OaXE62Sps/6o94v2r+PU9Xk8aoW7vYWZ7ik0/ooHR1JAsWfqBG2DmwPcSjnHc/entPqBqy+sl7pp/9c1Qdn9BMz+Z5sSI+hb4rbSx8sURYZodBx3kMWzNduZ69AF1WKBoCC26iNM/mgH20lLD6W3HK4U9LAIrvKskCSHtvTRg9wG4l5o7VPU3FLlKY1aFeEcEmSwXy7MSNSSwWSTRx/XLgtkKubVWB/KPWvn5gPMfx/PXu9ueASoJZgMVSEWGN/nIu4cbOOTJ1wh4jU5/9PDIAIRiFfROsggC9Q8yXPTSlWIgLpNp2tikuWb3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra1tLkPc0thaRdRAHDAOTWBfHJ1k85NE6PVY1XFSSgk=;
 b=PivlS7ME3g/Zw0SrfyCPlAOER6MV4lcd+1kJ0kl/Mt4wnsy2cpF2PBYQMOpBEztATQUil8GWdY1/TolzvoKhxbeUdoELTzXrzmgYSobgpFk1LlulTBkmeFcHKhIbO4vfXBY7WJIDHoFMkrqwLpBz45wPVlSkKjoUDgWli8UYu8dVZprLZMZymtMkFZaMiHvdhk00T9QKTygLKwX/Isp2UpVoYPpPZlX9F4GnfwPujq85V8xOeRkCADcWzukeJLC8nM+unnrinAZvUhtZZvMV/du7LoOUdMprOG47w50dBrsSOueoRzx2KCAY5VptHLuSvRv8VXIc6IkOmPjAoDGJeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 23:03:38 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%7]) with mapi id 15.20.5676.038; Thu, 6 Oct 2022
 23:03:38 +0000
Message-ID: <47b5dc14-bb70-7e89-ef94-1c73f2877277@suse.com>
Date:   Fri, 7 Oct 2022 07:03:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com>
 <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
 <Yz8gq6ErCqeMGUO1@zen>
 <CAL3q7H6Bn47CFL0tOsjCZ3iLgEPRm9_ZXV7duUSMZ2H-g0JhgQ@mail.gmail.com>
 <Yz89fEqWnh+iwA9/@zen>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
In-Reply-To: <Yz89fEqWnh+iwA9/@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 056ccc82-ef30-4535-3d50-08daa7ef013c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeGHg8uHEFh6HlzK/aFe8xxpy4r45vXuKcsyFXjhDn6ZeDU5Zj+yvioZV72LWd+xu6cfP5USQg3GhbWQywWSLvYleI+i16e+erq0rD7CsF8Qy0ms69Y+Nn+7RqE44ZVx9y9WkMxCZyXBusDeyC+uCxDigQzL7ju1iLe820622ACYhCShITf6ZtuDQ0TZ37p5lqijeBN+1yuKSbU4+1MbeAid208w/9Vm5RSmqxYz/uDP9ZoG0q/UkFKDhqmDaWuWGdJ9c3e+y8UuAhIGk08yvYZEa5lmswrugGEhX2g2amhEwaixxzbxw5czoXwTLF2Y8GgepjwXTfQm4nBPcrDFLjKHKFFJ4k3I7G+Dp4yj9R1150AfSyCcu+sFN7AiYt/zreXtyjA0/8ChVbLVcwfYUwdEuvFTRAGwsNEkD8BPu6guuaxWslhAtB5jps0rAdWCBYcMvCdJSbmNpR9hDM8Rm42EybdJIv8hSxrQqO0pNQQnYTa02yJ/kdd5aPHCrqnuMKbiNHvO0fWL7Lq+jVrVrnxd6gaJtPv/Fo9mG3tFIHHHCUuP/EHTlv7F2RT5RFtvgiyJ/+KJo/buG/VQJxXgplJeFFBi7pB/6UtGjifxQLlclehS/dCVCmE3o2aXORyncjQaU3xV3j48yUQMmgyPNMIaTQGve15h1RKkRn2A4MdXpv1j1Xiuno3QDHfhosmcFdHYge+uuXkpKplrrasV6WzQ6tvW2CgA3cHsE20mntq4IFXeq/wJmJ2mmzyhl7OhVzg67K2EuOqvTNqkngqqNj+hjQvFWLQ4dzMZMT2wQFIqZZ/3Dd7RiZXUYULlVEt4JW+CWBZ6qupWgtaScAOffucswJHsUF7r9emqPr1U5sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(41300700001)(110136005)(478600001)(6486002)(38100700002)(36756003)(2906002)(5660300002)(316002)(8936002)(66946007)(8676002)(4326008)(66556008)(66476007)(83380400001)(6506007)(86362001)(6512007)(6666004)(186003)(31696002)(2616005)(53546011)(31686004)(21314003)(518174003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXN4YkZxajdqZ292ck9FbnRBbUlkdWFKbnU4UkFGOVZSWXduSUNVcm1VS2RM?=
 =?utf-8?B?cDZsd0ZleWRQb1VkeE1HYnVqbG5zaWttQndrS05qTEl1alZFeCtDTE4vbnBh?=
 =?utf-8?B?OCtVNktoeVhYRDJIMi9uTi82K0VMTTcxVWloQjNUV0tkRGVpTkhRNEJCVm0x?=
 =?utf-8?B?M3RQRDlhZ3pzbUF4bHRFVFhmM0lycFE4c3diSTdLTHpBUGRGVFB0b0V1YVFJ?=
 =?utf-8?B?VUt2YU1wa0NmbHlIdXdrVk4rOGx6ZkRtMWV6Q2hvbElWM1NyUm5SSUdRbWVF?=
 =?utf-8?B?NzVMUDdnbkFIRmt2WmpHdm9kdTQ0Zi9keENwUGE2UkJSbkorSDZERmVGR2or?=
 =?utf-8?B?bGlZTmV0Nzh1d3k2L1RJTFk2TzVNTXRqZ3ptd1BJcWRQRWREb1ZEWXJ4Nk41?=
 =?utf-8?B?dkxNakttdXdLaG5VSGtsMTBjRmNEYkdJa0gyek53czA3WDRJU1JLb2x5Yy9B?=
 =?utf-8?B?bkUwY2swc2pWazBEMjZycmFoNldueVZUYzZHQnFJaUxOMUlmaXpHem1YbGFa?=
 =?utf-8?B?b3lnaFpoTzd6NUg3YXN5SHpTblk0S3N4UGtaUDdhcGxLKzA2VTJBNWdIOGlu?=
 =?utf-8?B?WHlXQzE5bUdPZjQ2eGZOdjFmL1FwNmF2eWQvY3BSN3RtU1BibHYvZnNHUytp?=
 =?utf-8?B?RGhYdzJ6L3c3R2tUaWFRWDZGUXV5dEQ4Um1kOXlLMis5V1d3KzB4Rm1YeFlW?=
 =?utf-8?B?cmtzWTUwR0o1Rm1FL3QyUzlLcUI3dEExVWpWb2h1L0lJZ3pudU1neFpqdmls?=
 =?utf-8?B?Vm1jVU9vSVRRS3ovTUtOTkd0YUZ1azN2WTZNOEYzd2Z2bUlXRDh5NEFCY08y?=
 =?utf-8?B?dGcwSHNqWjk1RXRDRGFhU1FyL0V0NDFzT3dERUdNRUtqa21mR1JNbUNPdmVU?=
 =?utf-8?B?ZWV2MjBXRnZuOWdJZ09id1NRNEVPY0ViQ2pyK1B5UGYxQWlEK3c1V1A5ZXNZ?=
 =?utf-8?B?MGs4Z2FSc0FUaXZ6TWl2cTNGaXNZaTVVM1BJNHdqZjQ4d3ZVUWpQUEw2d3Bm?=
 =?utf-8?B?NFYrb2ROQi8vMTZibVZQcnFiWWUyYnFuZEd3S2phY3ZhS3lib2l5S3Q1amlk?=
 =?utf-8?B?WDJzTzgydVhaREx1eitHUThkSTFNM0ZZSmRucVdoaDYzSFhXU25nM0dsckdi?=
 =?utf-8?B?VWJGMFBoRld3bGJzcWhvNnB1bEZTTWxQWTBOdWpXdm0wVlBYRGdKcWE2Vm5n?=
 =?utf-8?B?eVNleHRjNXk5cDI5T3YyaDFyTll2ek5ZMy82SlNaZGJldG1IL1lUMGVya2NI?=
 =?utf-8?B?S0JUZFhTeU5BWkxoL2ZrMEwrR3AzN3JNSnc5ZG9xNlNrUVQ2dDhXc3UwN2NQ?=
 =?utf-8?B?MlNsSmV4ckpENDcreFB2cnY5QUtTVFZsVzlpdGRtNXU0RmNVQzAyZmxKR3Fs?=
 =?utf-8?B?cmlsSzNxS1J2dnFxdnVVNU9aZ0tEU3ArTjQ3d0U5U2l3V1NPd25xWlhUT25r?=
 =?utf-8?B?Q0Z3dW1YalUrcGF3bnFzVjdjZ0xNU3AzR2ZrQVVvMS9rQVluY3QzbktpSTJZ?=
 =?utf-8?B?V1IrUnR6QkNZRExBVE5CaVdYbGJaby85ZnRDOFVLdFptYSsxMGNSNHE5VHU3?=
 =?utf-8?B?cXhOcnZ4aFFkbWovdmxremZCZE5XbU01aExYdldPTDJUWEE2VkVzM0wvVVJ1?=
 =?utf-8?B?WllrdFI0bm14OHQ3R05JeHN0MStzNXJlakFJTXhMcjVOQVR6RGpkNlZjekxX?=
 =?utf-8?B?V0c0TmNCUDBZRDZUdTdzMXBRUDZva2lDNDZqYmJGVVUvOGhGOFVHMDZ2UnBR?=
 =?utf-8?B?VERpUWJJMlA3cXNiS3J2MWRraTcySjFJNjZvK294OEhCYVBBTURwNGt3aEhk?=
 =?utf-8?B?Vkw0UGIxUGt1cElaNDhjc0ZjNTFRODJNRXdNUGV4L01iYXNtNlFNa0MxQThp?=
 =?utf-8?B?bE5PZFF1TkQrUXUvRTN6cEM1MWdyL1R4MGFKcW9sYzlUNzUrSzlhb0xKelFD?=
 =?utf-8?B?dUlhNkJRMEQ3WktYditpVWVjQTZQcWVDV1dZQWFrRWFuclkzanV4SnVENmhC?=
 =?utf-8?B?cHJmalJNdmxzb3hWa3p4d2NxYjY1YTBXTW5tczk0L2tQbG5NM3Q3QTZsL2l3?=
 =?utf-8?B?b0tqU293aVF0dGh3d1ViMlNJMzJUZHJjQ2JUcXZNQWJuYzVMTzZkUlU4bHFl?=
 =?utf-8?B?dkdGa3RvdkVrdC90eTBwSHoxZkZrblFzZW40c3k2VWROeXNOcmVQeURLdldL?=
 =?utf-8?Q?jCEYYCwezDVy2Ser4IDbB04=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056ccc82-ef30-4535-3d50-08daa7ef013c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 23:03:38.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUYHjxfMlOG8CZZeWOzsafP32a2aB52J4r64h5h62dXzA3gEkpNrp2DnC/eR4jf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/7 04:41, Boris Burkov wrote:
> On Thu, Oct 06, 2022 at 08:56:03PM +0100, Filipe Manana wrote:
>> On Thu, Oct 6, 2022 at 7:38 PM Boris Burkov <boris@bur.io> wrote:
>>>
>>> On Thu, Oct 06, 2022 at 10:48:33AM +0100, Filipe Manana wrote:
>>>> On Thu, Oct 6, 2022 at 9:06 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2022/10/6 03:49, Boris Burkov wrote:
>>>>>> When doing a large fallocate, btrfs will break it up into 256MiB
>>>>>> extents. Our data block groups are 1GiB, so a more natural maximum size
>>>>>> is 1GiB, so that we tend to allocate and fully use block groups rather
>>>>>> than fragmenting the file around.
>>>>>>
>>>>>> This is especially useful if large fallocates tend to be for "round"
>>>>>> amounts, which strikes me as a reasonable assumption.
>>>>>>
>>>>>> While moving to size classes reduces the value of this change, it is
>>>>>> also good to compare potential allocator algorithms against just 1G
>>>>>> extents.
>>>>>
>>>>> Btrfs extent booking is already causing a lot of wasted space, is this
>>>>> larger extent size really a good idea?
>>>>>
>>>>> E.g. after a lot of random writes, we may have only a very small part of
>>>>> the original 1G still being referred.
>>>>> (The first write into the pre-allocated range will not be COWed, but the
>>>>> next one over the same range will be COWed)
>>>>>
>>>>> But the full 1G can only be freed if none of its sectors is referred.
>>>>> Thus this would make preallocated space much harder to be free,
>>>>> snapshots/reflink can make it even worse.
>>>>>
>>>>> So wouldn't such enlarged preallocted extent size cause more pressure?
>>>>
>>>> I agree, increasing the max extent size here does not seem like a good
>>>> thing to do.
>>>>
>>>> If an application fallocates space, then it generally expects to write to all
>>>> that space. However future random partial writes may not rewrite the entire
>>>> extent for a very long time, therefore making us keep a 1G extent for a very
>>>> long time (or forever in the worst case).
>>>>
>>>> Even for NOCOW files, it's still an issue if snapshots are used.
>>>>
>>>
>>> I see your point, and agree 1GiB is worse with respect to bookend
>>> extents. Since the patchset doesn't really rely on this, I don't mind
>>> dropping the change. I was mostly trying to rule this out as a trivial
>>> fix that would obviate the need for other changes.
>>>
>>> However, I'm not completely convinced by the argument, for two reasons.
>>>
>>> The first is essentially Qu's last comment. If you guys are right, then
>>> 256MiB is probably a really bad value for this as well, and we should be
>>> reaping the wins of making it smaller.
>>
>> Well, that's not a reason to increase the size, quite the opposite.
> 
> Agreed. My point was more: why is it 256MiB? There is something we would
> tradeoff against bookend waste (based on your later comment, I take it
> to be performance for the big files). I believe that with 256MiB we have
> already crossed the bookend rubicon, so we might as well accept it.

Yep, I believe the initial 256M for reallocated file extent limits (and 
128M for regular extents) are already too large.

But I also understand that, too small limits would cause way more 
backref items, thus can also be a problem.

Thus I believe we need to discuss on the file extent size limit more deeply.

> 
>>
>>>
>>> The second is that I'm not convinced of how the regression is going to
>>> happen here in practice.
>>
>> Over the years, every now and then there are users reporting that
>> their free space is mysteriously
>> going away and they have no clue why, even when not using snapshots.
>> More experienced users
>> provide help and eventually notice it's caused by many bookend
>> extents, and the given workaround
>> is to defrag the files.
>>
>> You can frequently see such reports in threads on this mailing list or
>> in the IRC channel.
> 
> That's not what I was asking, really. Who overwrites 256MiB but not
> 1GiB? Is that common? Overwriting <256MiB (or not covering an extent)
> in the status quo is exactly as bad, as far as I can see.

The situation is not about only over-write full 256MiB but not the full 1G.

It's about chance. If there are random writes into the preallocated 
extent, the larger the extent is, the harder to reclaim the extent.
(aka, we're talking about the worst case)

Sure for random writes it's already hard to reclaim the original 256M 
extent, but it would way harder to reclaim the 1G one.

> 
>>
>>> Let's say someone does a 2GiB falloc and writes
>>> the file out once. In the old code that will be 8 256MiB extents, in the
>>> new code, 2 1GiB extents. Then, to have this be a regression, the user
>>> would have to fully overwrite one of the 256MiB extents, but not 1GiB.
>>> Are there a lot of workloads that don't use nocow, and which randomly
>>> overwrite all of a 256MiB extent of a larger file? Maybe..
>>
>> Assuming that all or most workloads that use fallocate also set nocow
>> on the files, is quite a big stretch IMO.
> 
> Agreed. I won't argue based on nocow.
> 
>> It's true that for performance critical applications like traditional
>> relational databases, people usually set nocow,
>> or the application or some other software does it automatically for them.
>>
>> But there are also many applications that use fallocate and people are
>> not aware of and don't set nocow, nor
>> anything else sets nocow automatically on the files used by them.
>> Specially if they are not IO intensive, in which
>> case they may not be noticed and therefore space wasted due to bookend
>> extents is more likely to happen.
>>
>> Having a bunch of very small extents, say 4K to 512K, is clearly bad
>> compared to having just a few 256M extents.
>> But having a few 1G extents instead of a group of 256M extents,
>> probably doesn't make such a huge difference as
>> in the former case.
>>
>> Does the 1G extents benefit some facebook specific workload, or some
>> well known workload?
> 
> I observed that we have highly fragmented file systems (before
> autorelocate) and that after a balance, they regress back to fragmented
> in a day or so. The frontier of new block group allocations is all from
> large fallocates (mostly from installing binary packages for starting or
> updating services, getting configuration/data blobs, etc..)

I guess it would be something to improve from the package 
management/container side.

For btrfs, fallocate provides way less guarantee than non-COW filesystems.
In fact, btrfs fallocate can not even ensure the following write after 
fallocate won't cause ENOSPC.
(Just fallocate, make a snapshot, then write into the original subv).

Thus would it be more effective to just delete the fallocate call from 
the package management/container code?

Thanks,
Qu

> 
> If you do two 1GiB fallocates in a fs that looks like:
>         BG1                BG2            BG3
> |xxx.............|................|................|
> you get something like:
> |xxxxAAAABBBBCCCC|DDDDEEEEFFFFGGGG|HHHH............|
> then you do some random little writes:
> |xxxxAAAABBBBCCCC|DDDDEEEEFFFFGGGG|HHHHy...........|
> then you delete the second fallocate because you're done with that
> container:
> |xxxxAAAABBBBCCCC|DDDD............|HHHHy...........|
> then you do another small write:
> |xxxxAAAABBBBCCCC|DDDDz...........|HHHHy...........|
> then you fallocate the next package:
> |xxxxAAAABBBBCCCC|DDDDzIIIIJJJJ...|HHHHyKKKK.......|
> and so on until you blow through 100 block groups in a day.
> 
> I don't think this is particularly Facebook specific, but does seem
> specific to a "installs/upgrades lots of containers" type of workload.
> 
>>
>>
>>>
>>> Since I'm making the change, it's incumbent on me to prove it's safe, so
>>> with that in mind, I would reiterate I'm fine to drop it.
>>>
>>>>>
>>>>> In fact, the original 256M is already too large to me.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>>>>> ---
>>>>>>    fs/btrfs/inode.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>>>> index 45ebef8d3ea8..fd66586ae2fc 100644
>>>>>> --- a/fs/btrfs/inode.c
>>>>>> +++ b/fs/btrfs/inode.c
>>>>>> @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
>>>>>>        if (trans)
>>>>>>                own_trans = false;
>>>>>>        while (num_bytes > 0) {
>>>>>> -             cur_bytes = min_t(u64, num_bytes, SZ_256M);
>>>>>> +             cur_bytes = min_t(u64, num_bytes, SZ_1G);
>>>>>>                cur_bytes = max(cur_bytes, min_size);
>>>>>>                /*
>>>>>>                 * If we are severely fragmented we could end up with really
