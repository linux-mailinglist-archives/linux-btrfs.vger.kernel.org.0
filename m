Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308CC52D0A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiESKhi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiESKhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 06:37:36 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C342644F1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652956653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTi4Umq2Gjt4b8kingcT8Zj7vUajeSrhZmGh4Dz1HkE=;
        b=A06UzTI24dHRj1YwuhZDvz9U0giC1VJx05DtdS6qyQFUX6rAdO8vnGrQLBFWdkeYJiwpMa
        pEmH4wFAAz0R7Rp2wwCgK5MyBcXQShT5NLd/NMtJxHyZgYKcxygiuHSRFEU+W88xUACIWY
        8wSODfL1EnxVGxDDbh4mNlfsFMX2c8I=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-F7omVBK3Odeu0X2UH6Z_xw-1; Thu, 19 May 2022 12:37:31 +0200
X-MC-Unique: F7omVBK3Odeu0X2UH6Z_xw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F94wUn0rmQsZr9ZObAVsugm7SlBIhiyzWMfBwatnUfPzjzP7XIXtlDAGPiCqnTaNMzTj+XTKx+Cl9Gpa9DpW/masrapQLi0rPCm0+NV3o6r7sLJTkgKO3dlGTm1iQW5MYi+/Qf8I5ztiOm8ZnIzoDRZXkVJ949LsWE4c/x60m6Tg0hKol0bqVTpA8BtsvFtDDDSmmMjvuQpEDFB1eHZ+/F+PV5ikeFv/78oazgu2kz1X8AWPYr6D3g4bPXVn2V5kqnrIhPEbj49w+KLwUSWWfEmnh7qMZvDoc2hfzs3MPd1ibDzngukZzZtc6mqNCvlONTPItt2Gozo/UZakK8uNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTi4Umq2Gjt4b8kingcT8Zj7vUajeSrhZmGh4Dz1HkE=;
 b=QpH7LFe8AS15aC3AJUvXXjHqSB4qA1Dcsxw6mhxAQkJPR2bJmgOoCqGc1aZTKpWUBR+g+ib8aeoMdn/X46u0p0nnNKr1mN9kd8W7G/QiIsEuksUBNlIKwte3Fl2uFX1jZwtTHz59JHRh4CrPEV57HwANmyTVEAf2+u9KpkVx21PHEHMnFPhIRIaXeRWeGlb9Vhf2CYdJUXwE3hgvCLFbCgzB/cr5VpD8L28mWcXfdKpetWLpIwtM8QMsVxwwsA0uh1+7DK8wIBdNfc67ftpk8aMlfNJ1f1RWxYbxYj3108IrX9SoVSy06aS979jRERdnMWJ3gJxAkW4YeMplQa7gAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 10:37:29 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 10:37:29 +0000
Message-ID: <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
Date:   Thu, 19 May 2022 18:37:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec537bc-28c8-4b86-280d-08da398392f0
X-MS-TrafficTypeDiagnostic: PA4PR04MB9269:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB926934D11850342D30D32BF7D6D09@PA4PR04MB9269.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuP8BFCrNxUvsE9eLR/c2/MvWI3kEsh9q6ZtYxRnkvqqFNzxC5cO0ZABDNKfqo10mu8I2WJ8USNS8ytUm3IxEjdAMLL2U3GbpU97CNU5woSC7cNLkUDYxdrx0CmUEGKWF0NmPFnaCrUS6DhHSa+ruF/6oArgjD9JgTtqn+CPXePALPU41VvXIwdivrz86wmim4BtsDmDyEndEtdS7Fcf8qE+k+xWy5GnprBVBRqs2uCGAMsFpp1m/RcmpyrrCLs+atNWlAMzM6PpZ/hjE6g6wA9A4k+diTU0G3d6uc0x9OrDX6p+0w5cyrVTkit1ab+4jL4Hwycxh5Y17Fkcf8uhoBjcMdtWFo8oAslahwmSwc7LFfSE+WZIawyksLX6NVuNBZHedw4D/ukkDtcRKn9qy0HRB7TU98E566HxzRWCnsUag6mnPJrIqewFelBKyhtOPMG0zk56B6M5MW06Fgv4K6+7Kbi0nY8kzGw8rFYYObRtRVmyn0sgHqaKAAPGJyX7tDMb9BcI253wh4CNqh4dbTW4+tU3VU8cFrXXVaa5PBdr2rEPPtoVCkRtMhxOpmlrnga9UofT6p92uLGXzfA1hus0GbsN7iknp6w/IJYpgqAUtB1yrq2h/fbDuZCIH+ABNOFBAgIfv3jTR5Q5QmgQTTP4w8H/eYt1pwlui/8EtXjGU16TKLDVdhTCiqOdxpZBI5cfeI64lwO5BZGVHkXAH7wnczF21pYCYu8Q1VEWb00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(6666004)(31696002)(316002)(2906002)(6512007)(6506007)(53546011)(8936002)(2616005)(66946007)(8676002)(31686004)(36756003)(38100700002)(186003)(6486002)(66556008)(66476007)(83380400001)(110136005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZXUTh5eDErL1llMk5rcWxpQUdwS21lQ2ZpOFNxRWowdkRwTjFzM0dVV05I?=
 =?utf-8?B?ZkZ4cDVKOVlZR2NZZys1UWFBc0JDNFNWeC9YVUFPSFZBLzBtT1dUN2Z0bEpk?=
 =?utf-8?B?WkMxY2RFRXpJK1RmVWRZTUVwMUcvTllDbk93UTVXdXlRcUJsL0lJV0ZBMmFz?=
 =?utf-8?B?ZmZ3Ym9IWUJxMFZGRnk5YTEwWVlMTzZIL3JvMjFEemFLVWlkR2ZSbi9RVEJ6?=
 =?utf-8?B?bHM1YmlSZm1EZGFlMXRuRUhxczVWdytvVXEza2VpSWdhekNxZG9tTzBxKzR2?=
 =?utf-8?B?OGZLY3dhZlpFdTRUbFZ3WWFrSGxJcmVmOTZMSjhIUThBR1luQWo0WjFLckpN?=
 =?utf-8?B?bDdqbFUySGVIVzFOUVlYWEZzQldYV1htZmwrcE1TQW8wNi9qSENBVXFteEtV?=
 =?utf-8?B?UXpqNTBtZmp0Yk5yYjNxQm5SbVA2Z0JQQjMyckhCeURXbVJYekx0cS9qUmNX?=
 =?utf-8?B?TlJSYXhuK0FFcCtHL2FxZEhHMWJrbFp3MWloQ25FMFk4amEzVTBFbVA0THZV?=
 =?utf-8?B?S1RoNlVaMldiclRUWGRESzB5WUJDcVh0aEFNNlZqUnovUFRVMFVqVEJTcW5L?=
 =?utf-8?B?TjhGTkVVQW5WWURBY3N2MElVb0FPVVpBaFh3NU1oTVdGRTlFVTFtU1ltamwr?=
 =?utf-8?B?QlJaVUNoRG1zQ2prT2FHOUd0TldpNnRiWUoySXZaelRzSjNQZTZmME52ektZ?=
 =?utf-8?B?M3lJU2FUejdOT09GdWQrazRLQkt6T1NMK1ZWOWUwTFdqc3BTVW4vK28zWDND?=
 =?utf-8?B?Q2pmQzZFOUU3Q1V1OUE2bDFJRm8rKzM5TmR0OENxVjlDSE5mSmd2bFNNbjZs?=
 =?utf-8?B?Uldsa2xXNDVGbkZzV1Vsakl3d3JIWjYzc0xsSko1MnE1UzlTZWdQRWRuSGRR?=
 =?utf-8?B?a0tPZXNxb290YlhRVWQyK2I2emYrSVFORjdjOU9PUFE0bm5zTU9mbEhGSU1E?=
 =?utf-8?B?ZEJ6OWhnVERPWEphOFpuQXNKcUVETi9ZSFVSalFFT3R1Q1Q4aEF0bXpRVnhZ?=
 =?utf-8?B?QVR0aTRoNXVuckk2YzhkcDhlWFdDd0VLWjhHSTA3SXk5LzA4L3JZRkl2WmU2?=
 =?utf-8?B?K1VsWDZabVFKZkxNUmpscisvVURsUGttMkVYYk1CNDN2cVcrZzI1aldpZm9V?=
 =?utf-8?B?cWZMTW1NcnhrNXZpTTVNN05EdVdrR0tkMm9UZ3ZYN2hIajZWREVweHh3T01F?=
 =?utf-8?B?bUU3eWMrZFhwQ0czYkFxSjg4cmhpVEFSVjk1cHVZaGVnTmthbnk1aVN0aHUy?=
 =?utf-8?B?Y2NEa3pPVk5VM1BDUkw0bzNBNXBtWUN6QnZia0FUV3duN2ljTThDVUptQ3Vv?=
 =?utf-8?B?UWtFNnk0RjlPM3FScUx5UWFibkI0a1J4VTdXS2FSbHk4YWlCb1pXbGpUWEZv?=
 =?utf-8?B?emZRNytCUWNZTXZBM3FzM1U4d3JoZXFuMmpTNXZwdHY4VFV5bDlwNTFTRHJ1?=
 =?utf-8?B?TngxSzBtU0hYWjJjTkpMRGFyZ0x2c1Zyc0UxVFlCaWQvUVBha01CVlZPcDBq?=
 =?utf-8?B?bU9MMytNOVEwSk5QMHFyeWZEdG5ERE5Nd2FrNHgrSXIxN2hUb0JCTDZra3d1?=
 =?utf-8?B?emtpRVAza0dPMGQvMXRLaklINzhQVFU3ODU5aDhpOUhvM0NlQ2tWSnlBRlp5?=
 =?utf-8?B?SWs1NnU3Nk53NDhoSUJSbVdlenlIczdGYlJmK0pZU24wTFdsbTl5WlZFeW83?=
 =?utf-8?B?aS9DY2V1bnFDM2I4czU1RTJ4TEVCMEVqL010dWplckROL0VOdDhpYnd6QnpL?=
 =?utf-8?B?ZXp0TzViUkR3S0tLV0h5Nit5OHJhREFzRWlUbGp3MjFSNlk1T3ZoVThXdlR4?=
 =?utf-8?B?RnVydGkzZG44YVBzb05qVTVaYTQ4QmVZMVlnSnpwZEpsOFRJNTJrWUF4emxM?=
 =?utf-8?B?aythOXlUM2IxVnZ3SUhuMjVsS253b2RhWkcwNXpVd0hocTkrYlNiSE56SGVR?=
 =?utf-8?B?MVFiRzNZb3Uxajh4VFZLMERGSzQ3ZjVMcDZROFFHOFZkRS94aW5QQU5XV2Iv?=
 =?utf-8?B?OVl6NmtZR2M5RkluK3JtSlprUFh2U3UzRHlxWmNZYSs0Y24xRnZRWEovUmZI?=
 =?utf-8?B?NUdVQkRIMHk1WEQ2YUVvSVBmdWE4WTBqY1YxT1hyRlo2eEFhNGwyN3R1dGJ0?=
 =?utf-8?B?OXlVQzZtYWc3Q1ZhdE5EN1dXWk56cVprUDh0TlVjK0w4NklTblIwWEdobWRG?=
 =?utf-8?B?NWRCT29XODF3NkE5cXk5TFlBS0dXMEJmSkloQjRlQk5VKzBsSXh4L0N2VkRD?=
 =?utf-8?B?MEpqa25qVG5EcmNudHdoSFpHNFQ3bnZuNmJvendmbmJud0VyUmJvNnoxUUJV?=
 =?utf-8?B?ZFpUN29PQ0ZIZkUxVXgrd2FLaUZHcmNraFhkdS9LT1JqVHdLTHNIdU9ETGYv?=
 =?utf-8?Q?wSyF1TWWz8NCU/hG1R040qGGqyFywybd9BZtn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec537bc-28c8-4b86-280d-08da398392f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:37:29.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ca3DplyGKi+qgWNng6uolMyhACW7VOIHN6gITzvkEpwBEM3vwaLFh1UlGJxvAGkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 16:39, Johannes Thumshirn wrote:
> On 19/05/2022 10:36, Qu Wenruo wrote:
>>
>>
>> On 2022/5/18 19:29, Johannes Thumshirn wrote:
>>> On 17/05/2022 10:28, Qu Wenruo wrote:
>>>>>
>>>>> Metadata on the stripe tree really is the main blocker right now.
>>>>
>>>> That's no doubt.
>>>
>>> What could be done and I think this is the only way forward, is to have
>>> the stripe tree in the system block group
>>
>> This behavior itself has its problems, unfortunately.
>>
>> Currently the system chunks are pretty small, in fact system chunks has
>> the minimal stripe size for current code base.
>> (Data: 1G, Meta: 1G/256M, sys: 32M)
>>
>> This means, if we put stripe tree (which can be as large as extent tree
>> afaik), we need way much larger system chunks.
> 
> I know, but IIRC (need to look this up again) Josef increased the max size
> of sys chunks to 2G
> 
>>
>> And this can further increase the possibility on ENOSPC due to
>> unbalanced data/metadata/sys usage.
>>
>> Although this is really the last problem we need to bother.
>>
>>> and force system to be RAID1 on a fs with stripe tree.
>>
>> Then the system RAID1 chunks also need stripe tree for zoned devices.
>>
>> This means we're unable to bootstrap at all.
>>
>> Or did you mean, make system chunks RAID1 but not using stripe tree?
>> That can solve the boot strap problem, but it doesn't really look
>> elegant to me...
> 
> RAID1 on zoned only needs a stripe tree for data, not for meta-data/system,
> so it will work and we can bootstrap from it.
> 
That sounds good.

And in that case, we don't need to put stripe tree into system chunks at 
all.

So this method means, stripe tree is only useful for data.
Although it's less elegant, it's much saner.

Thanks,
Qu

