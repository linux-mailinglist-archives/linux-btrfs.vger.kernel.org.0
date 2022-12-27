Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE636569A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 12:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiL0LDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 06:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0LDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 06:03:12 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA9766F;
        Tue, 27 Dec 2022 03:03:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5+Y1Vb8NV13QHvfCfwNNWJ7c7aU3x5azThhdVExupZaNAo4xShKgESHPQ4zMCCdx+rdzdxbsvlmtBdkahqVO1y2wEPLGIsN1zwSyXZFWdhdkIh7LU1yE2fvuf0Jag3/mZvn+pB2jo1rI2sQsnZLTxqIR3W79AAJZr61gCPTHLjOxB7nU7Ryii+EuCTuIZf+RMRKKF/HgLYV9MKVbHuoLXyFwrCwSRPXSitBeP8wB5+ee4TE11brnXppfStaTDxH6/4zv5Fx5TdI8CpL/lA40IaWWIJ5h7LnzUd8FT07qjqUPcunOEMDkvYd+p/V2MXt4P5luqYeBpDBGoxwYZc8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYhZQ5krNVcShi3mwhlFA1OGMUa6K1U4i4okKwv5fiE=;
 b=OH9KLxq3TA1YLXW+S5NR2Gp0awbg4ukEUfd1UQ5aDE9kixsbBCPVvvBNmW0kHAT63x1z18IKId0P7kMqbzpMJUG7oU/JyWfy2q3bnpcsMo+3zlaqyTZuGXvL8jP05CGQ//ZF8/2ESeSBvBY8CX6o9NnvWFx4FA/lcfCza9FNnrE40oiAp1rrDK490t6vsbG+E+CR241mhiHExlKpZfZCwbZzjY5rsa+UOuPD/Yqep1Le5R7HEUEZUqdxC4qiibAi1MBkW5TLWjJPNr+m6DPmj2EVAQxQzCUpsVD+8fwtIH/ZTRW1/6JpOs8IIEQNZxF+KOCwrHyqHabNFis1jdR1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYhZQ5krNVcShi3mwhlFA1OGMUa6K1U4i4okKwv5fiE=;
 b=UcZLytaGwCVz2m21o1lhsBtScORJCvnEbZbJyILWquN3+n8KZqtck7PDheOm8zQK9/C4wGGqqfisewVSpe4EbJpmm1zqQ8fiGDtaOFcudP5jcrKijHvnptD1mwuC3EEcng7jU5gHavG7zlIxap62oZqJ5m9wuV7ZYbhQclO96nhLawGMqnb8WRskzePR8zXl5eMan8ZmK6fNNED80FYQtYn1Nm6wRQBqQ/dU4QktYSWG9aZ+zvoqiS2kloXKZpszbWPyK9gk0gAVezdZWkq7Xd8+ZURj3CijtMBycg/ClFYmAp9DdFJ9TvuASqYxVZ2JHPtYcQ0JZMgEBdk4gIsTIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 11:03:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%8]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 11:03:07 +0000
Content-Type: multipart/mixed; boundary="------------5191fERIl5RaybdDbaitkB0P"
Message-ID: <7d2edc1d-922b-763c-3122-0a6f81c3454e@suse.com>
Date:   Tue, 27 Dec 2022 19:02:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
 <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
 <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
 <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
 <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
 <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com>
 <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
 <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com>
 <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: fac13818-f7da-424f-2ddf-08dae7f9ef49
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiM7gYB1D+ydTKUW+92w27ByMMgjVozouwIcbTNljZxvudJSR7CCE7k0PQvAe5RHhmC1GFEE0+c53D9Ou8gePHq66ilgCn9oojP1tQYpRll3u9kg7TEq2m1rmALSXOxkhEJNgylSZEJmybH3MfZ6B7TypvQkZm9LvI33pgUsyzLBa1p4ipcMRO0/kg6IscmoilQOSlCkeZF0+sTKRZhyRsTnHUJ/Z+UcW10kD0Aizgs7w7mOo05IxMSnMmkB48s3o3xM0P0MvX3NWWIrrA/ydkGZbXawmv5dmZMIfl6kqg3sptxcLp788PAk/HNLiaqgOA/r0TBEVsrJ7xvKKtqQYTYF6uxm8C2LcQJ7FrWDQ7X/AjEpwmctcjRv53eyjXF06ym6vEJf9D2eUbBDTdmO9ZxpyTOliQfCmnv8dU19vz/1gWbxmUYD+V/MQ2vEsRng6q5yuGtkS3dLCoR9OjWJGSu3G4S0nwX9LKTesDsiCufFhsKM/hysC2IZF5YqghIStgWz6JLWTtLLYmCTb1Ux8jUifYUPH3KpAq83IYxaP2ubYU7lTLSMzok39vlkiSHwvVxzRnxsDZrOTdhrGbKuur4GSGJdzv55sflyA7IR0v0F/J+LLMq8O9hxuYCVaVGVonjX40Z6Lgi8YypvQvINvEqw2HRckLUqov6lDb277jWmaPqP+RYxJIHfVktD37NIinIKiZ3qACwW8iCkaIn+C4jlI1bmpykkuq8fH3s/ERp+2whoZF2s6vCw1Vo+20uW6EgXf7vsa9IPmxyuD0VQXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(478600001)(6666004)(6512007)(33964004)(186003)(966005)(53546011)(6486002)(6506007)(83380400001)(2616005)(235185007)(41300700001)(4326008)(8676002)(54906003)(38100700002)(110136005)(36756003)(31696002)(86362001)(8936002)(31686004)(66556008)(66476007)(5660300002)(316002)(2906002)(66946007)(518174003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TStHTHYyL0czQzFWdlJGUnh6QkhCYkQzeEdNRE9pTUxVMTJhcWtSODNvemlI?=
 =?utf-8?B?WFE5N256MmllRU90Z2FwQW01RzRReWF2YVFHWStKRUw2WWMvTk9VVHkwV1pu?=
 =?utf-8?B?YkhHUmljdXNVdXN1cWVFK2c3SVVqSXFrQUhMRUNyQW83R3dkMXVyT2ZTWmNJ?=
 =?utf-8?B?QUhEdjFSWHVvaWhDMDRXc1FQZmpoSTRHcUxmbklyQlI4NTVqUlJTejc2K3c0?=
 =?utf-8?B?UkZPS1BZMXViNHlmUEExbktMQmNsKzlnNkx1YlVuVnUwTytuT1ZLQUdDazFQ?=
 =?utf-8?B?cUY5WGxUZHdHbmc1ZGd6WFFHRXJKVEhYMWZWN3FJYmpsSEFyMkE0dHU0WS9W?=
 =?utf-8?B?c1NyOWpwc0xLZTJNc1huT1FVWWgzbE9ReVdUUnhwR3RGRWdhVnB1aHhDSnhM?=
 =?utf-8?B?RDZvcVZLMUJpRnBPTURzaFpvM3E4Zlk2bWl5UVdiM2tyVy8rQS9BMEtIRTBu?=
 =?utf-8?B?VEFNWlgwRWhkenNiY29EbFBMemZjelhjditxTWNNWVlObE1BVzJSUXpJSGpM?=
 =?utf-8?B?THBOd3puZkdXNTRjQUFzTW5WTmVXNm1iUEcxL2JFWjRaQ1M2Uk5mdE0wRXVs?=
 =?utf-8?B?SHVJOGtKdUpKTCtxYUpyVit2bDFjYWFtbXFCM3F0NHEvaFJjRTZuQ0w3RXBs?=
 =?utf-8?B?VHJ2eFdlK0oxa2d4QTZCcURiOGd4NTA1L283cFkwWDlkdkQwRkhaZUJ6T3Fs?=
 =?utf-8?B?cmczVmg4dHd6TDhMaVM5aVVWUWhZZVRjUU9hdFZhcHlMd1hGOUxyQVRsVUlR?=
 =?utf-8?B?VmxKRmRDMVU4RzFnRG5aQktscS85SWY3K3RWbTQxUzJUY0RkaFdyMWJPa3NN?=
 =?utf-8?B?b1ZWeUwxdjdSZVpsenFiNS9EWTlYMUF1Znhia3U5TnhNSVN1ZFZFcXljN0VU?=
 =?utf-8?B?eWMrMEE3bCtwUlhiYk5HbUxJR2RpZlk5UCtScDQxMUZjUktNRVJzbUkzSVRn?=
 =?utf-8?B?cXBFVGR5alVIVWpZR2RYR0t4MUJpWVEvQmdwVVBpYVBpWUhaeXkvVnVkblBH?=
 =?utf-8?B?Y1I5WC9NNXh0K3ByTUNpQ0xGNEdlTksrZDZKelFSaWVZRzhXNXYzenpFNFo2?=
 =?utf-8?B?VExsL2dLVkpXcERXVWdmSmpEdXV2bGhRWUJVNVl3ZkFiQTNnTnFNcmxzOXBW?=
 =?utf-8?B?djc5Vnpld1RoWFlodUlsck95UkxhU1JPa1k1ZCtsSEIvSncvR2NaMkxtOHdk?=
 =?utf-8?B?S2hBWHdla1BnMFdlYjVjYzJRVlp1dUQ2Rk5MdHErbzZ0V3VXMjQxczVEQzV4?=
 =?utf-8?B?dUZIbkZHTVBha2RHUmVYSjRTbFhtdFRtdC95UURIVStPdFp0c2t5dk83WVha?=
 =?utf-8?B?bWROVFZsdSsvb2dEMGswQU1vYUZUelZkRzdWQ1ZPUHppL3RsbEFCZTVONXNz?=
 =?utf-8?B?WUlsQnRtejR5L0l6SUV0YzhsVGozWEJzTTcxZDY5MkNoZXgzZUJaLzg5WkNS?=
 =?utf-8?B?UVZVUm1aU1JtZ2ZiMTVTbGtvcEdPSG9BckdQdXBvMDJGbGJ5aC9Rd3RxT0t6?=
 =?utf-8?B?RDNxUVhVdk40dHoxTTJyRStQSnZRVkRpSTB6enVPTEZHKzNzbThSdGtCVGJC?=
 =?utf-8?B?VUYxY1QzNDdtWmloaFFPQkl2NXVha21vVE9wL3AvczRNdUlsQ1Q5SUgzczho?=
 =?utf-8?B?T2RqZ3VEa0M0Q3VBWDJ5VjM5YmkwNzlyOEx5V1NYQVlzVC8rcXpXYVBlZVlw?=
 =?utf-8?B?bUlEV2NTVDIzVGhXbGZuaVZWQnh5VUc1Njg2Tkk3MkFGSzByR3g5RlRXUTRX?=
 =?utf-8?B?Zm1JT3N5K1A3OHI0TWdXSGVROVFMaDlCbEU4NkloYlhjR0h4WllibHErLzBw?=
 =?utf-8?B?dk8xVnlnY2d0TS81SjBuRy9XdU5hbTYyNXo5WTEwNWVRVEtJZ3UzcnBkY3Jr?=
 =?utf-8?B?SldySExKWlBiOWlLd1l1TXF6Mm9FVDBtZk53WjlwYlhUeDBxeHhCT2JvcS8y?=
 =?utf-8?B?UVY1NGhqK2w2YVMzN1lWd3MvbzdDRlN5cEhqWjdseXliaDF6ekNEZXV6MEoy?=
 =?utf-8?B?aXFUbE81WkVDTWo2L05ZSU0rR2o5ZG9RbkF2S2t1WGRkU0p5VFh2clRvTHVC?=
 =?utf-8?B?d0gyU0JyV0RlQVd2czZPOVRaNTBWR0xqVnJ3RDk4NVJIRGk0U016YldOQmJT?=
 =?utf-8?B?ckY0dmZJS29sUEkvSWRsa2swaWN3RnNGYk1aUTl0SjZtZHppOFVQNWtVV2Np?=
 =?utf-8?Q?uo8DmsdlfRPvbjLyZAn9WCQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac13818-f7da-424f-2ddf-08dae7f9ef49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 11:03:07.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhSV040WFCZrliqcydC3r8caMPwdzwLDza5PcqA+DeG5vCqQiTe9K5Ihr5tMwjpi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------5191fERIl5RaybdDbaitkB0P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/12/27 18:19, Mikhail Gavrilov wrote:
> On Tue, Dec 27, 2022 at 10:13 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> The result doesn't make sense...
>>
>> A lot of read_block_for_search() and btrfs_read_node_slot() are
>> triggering the warning.
>>
>> But inside both functions, we have just set the numbers before the call:
>>
>> In read_block_for_search() we got:
>>
>>           check.has_first_key = true;
>>           check.level = parent_level - 1;
>>           check.transid = gen;
>>           check.owner_root = root->root_key.objectid;
>>
>> Thus at least check.has_first_key is always true, and the WARN_ON()
>> should never get triggered.
>> The same applies to btrfs_read_node_slot().
>>
>> It looks like something involved in memory barrier.
>>
>> Anyway, the latest debug patch has extra mb to be sure.
>>
>> And despite the possible fix, could you provide extra info of your
>> build? Include:
> Kernel log is attached. All answers are below.
> 
>> - Hardware (mostly CPU and RAM spec)
> This is laptop ASUS ROG Strix G15 Advantage Edition G513QY-HQ007
> with CPU AMD Ryzen 9 5900HX and GPU Radeon RX 6800M

I have a similar laptop (G14), only GPU is different (RTX3060), and I 
failed to reproduce this so far...

> I upgraded RAM to Crucial CT32G4SFD832A DDR4 - 32GB x 2 (64GB) and SSD
> to Seagate FireCuda 530 ZP4000GM3A013 4TB x 2 (8TB)
> https://linux-hardware.org/?probe=0e063e5fd5
> 
>> - Toolchain used to compile the kernel (include compiler and its version)
> $ rpm -q binutils
> binutils-2.39-6.fc38.x86_64
> 
> $ ld --version
> GNU ld version 2.39-6.fc38
> 
> $ rpm -q gcc
> gcc-12.2.1-4.fc38.x86_64

My gcc is only a small version behind (12.2.0).

Thus none of the hardware seems suspicious at all...

Anyway I have attached my last struggle for the weird problem.
For now, I have no idea why this can even happen...

Thanks,
Qu

> 
> $ gcc --version
> gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
> 
> $ rpm -q make
> make-4.3-11.fc37.x86_64
> 
> $ make --version
> GNU Make 4.3
> 
>> - Kernel config
> Attached with debug logs.
> 
--------------5191fERIl5RaybdDbaitkB0P
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Transfer-Encoding: base64

RnJvbSA1ODY0MzBjOWE1Y2E5Zjg0MjYyNmJhY2NkYjVmY2QxYmU2Mjk0YmJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NTg2NDMwYzlhNWNhOWY4NDI2MjZiYWNjZGI1ZmNk
MWJlNjI5NGJiZi4xNjcyMTM4NjU3LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1IFdlbnJ1byA8
d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI2IERlYyAyMDIyIDE2OjQ0OjA4ICswODAwClN1Ympl
Y3Q6IFtQQVRDSCB2NV0gYnRyZnM6IGFkZCBleHRyYSBkZWJ1ZyBmb3IgbGV2ZWwgbWlzbWF0Y2gK
CkN1cnJlbnRseSBJIGFzc3VtZSB0aGVyZSBpcyBzb21lIHJhY2Ugb3IgdW5pbml0aWFsaXplZCB2
YWx1ZSBmb3IKY2hlY2s6OmxldmVsLgoKVGhlIGV4dHJhIG91dHB1dCBhcmUgZm9yIHR3byBsb2Nh
dGlvbnM6CgotIHZhbGlkYXRlX2V4dGVudF9idWZmZXIoKQogIE91dHB1dCB0aGUgZXJyb3IgbWVz
c2FnZSBmb3IgcmVhZCBlcnJvciBhbmQgdGhlIG1lbWJlcnMgb2YgY2hlY2suCgotIHJlYWRfZXh0
ZW50X2J1ZmZlcl9wYWdlcygpCiAgVGhpcyB3aWxsIGR1bXAgdGhlIHN0YWNrIGZvciB1cyB0byBj
YXRjaCB0aGUgb2ZmZW5kZXIuCgpTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNv
bT4KLS0tCkNoYW5nZWxvZzoKdjI6Ci0gRXh0cmEgc3VibWlzc2lvbiB0aW1lIG91dHB1dAogIFRo
aXMgd291bGQgZ3JlYXRlbHkgZW5sYXJnZSB0aGUgZG1lc2cgc2l6ZQoKLSBFeHRyYSB3YXJuaW5n
IHdoZW4gc3VibWl0dGluZyBhIG1ldGFkYXRhIGJpbwogIElmIHdlIGhhdmUgYW4gdW5pbml0aWFs
aXplZCBjaGVjayBzdHJ1Y3R1cmUsIGRvIGEgd2FybmluZyBhbmQgc3RhY2sKICBkdW1wIHRvIHNo
b3cgdGhlIG9mZmVuZGluZyBjYWxsIHRyYWNlLgoKdjM6Ci0gRml4IGEgY29tcGlsaW5nIGVycm9y
Cgp2NDoKLSBBZGQgZXh0cmEgbWIgZm9yIHRlc3QKCnY1OgotIEluaXRpYWxpemUgY2hlY2sgc3Ry
dWN0dXJlIGVhcmx5Ci0gTW92ZSBtYiB0byB0aGUgY2FsbCBzaXRlIHdlIGluaXRpYWxpemUgdGhl
IGNoZWNrIHN0cnVjdHVyZQotIFVzZSBzaXplb2Yoc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2No
ZWNrKSBpbnN0ZWFkIG9mIHNpemVvZigqc2l6ZSkKLSBBZGQgZXh0cmEgZGVidWcgb3V0cHV0IGZv
ciBzaXplb2YoKmNoZWNrKSBqdXN0IGluIGNhc2UuCgpPdmVyYWxsIEkgaGF2ZSBubyBpZGVhIGhv
dyB0aGlzIGNhbiBnbyB3cm9uZy4uLgotLS0KIGZzL2J0cmZzL2N0cmVlLmMgICAgIHwgMzEgKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogZnMvYnRyZnMvZGlzay1pby5jICAgfCAxOSAr
KysrKysrKysrKysrKysrKy0tCiBmcy9idHJmcy9leHRlbnRfaW8uYyB8IDIwICsrKysrKysrKysr
KysrKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2N0cmVlLmMgYi9mcy9idHJmcy9jdHJlZS5jCmlu
ZGV4IDQ3NTRjOTEwMWE0Yy4uZDg1ODIxOWM4ODg2IDEwMDY0NAotLS0gYS9mcy9idHJmcy9jdHJl
ZS5jCisrKyBiL2ZzL2J0cmZzL2N0cmVlLmMKQEAgLTk1OCw3ICs5NTgsMTIgQEAgc3RydWN0IGV4
dGVudF9idWZmZXIgKmJ0cmZzX3JlYWRfbm9kZV9zbG90KHN0cnVjdCBleHRlbnRfYnVmZmVyICpw
YXJlbnQsCiAJCQkJCSAgIGludCBzbG90KQogewogCWludCBsZXZlbCA9IGJ0cmZzX2hlYWRlcl9s
ZXZlbChwYXJlbnQpOwotCXN0cnVjdCBidHJmc190cmVlX3BhcmVudF9jaGVjayBjaGVjayA9IHsg
MCB9OworCXN0cnVjdCBidHJmc190cmVlX3BhcmVudF9jaGVjayBlbXB0eSA9IHsgMCB9OworCXN0
cnVjdCBidHJmc190cmVlX3BhcmVudF9jaGVjayBjaGVjayA9IHsKKwkJLmxldmVsID0gbGV2ZWwg
LSAxLAorCQkudHJhbnNpZCA9IGJ0cmZzX25vZGVfcHRyX2dlbmVyYXRpb24ocGFyZW50LCBzbG90
KSwKKwkJLm93bmVyX3Jvb3QgPSBidHJmc19oZWFkZXJfb3duZXIocGFyZW50KSwKKwl9OwogCXN0
cnVjdCBleHRlbnRfYnVmZmVyICplYjsKIAogCWlmIChzbG90IDwgMCB8fCBzbG90ID49IGJ0cmZz
X2hlYWRlcl9ucml0ZW1zKHBhcmVudCkpCkBAIC05NjYsMTIgKzk3MSwxMiBAQCBzdHJ1Y3QgZXh0
ZW50X2J1ZmZlciAqYnRyZnNfcmVhZF9ub2RlX3Nsb3Qoc3RydWN0IGV4dGVudF9idWZmZXIgKnBh
cmVudCwKIAogCUJVR19PTihsZXZlbCA9PSAwKTsKIAotCWNoZWNrLmxldmVsID0gbGV2ZWwgLSAx
OwotCWNoZWNrLnRyYW5zaWQgPSBidHJmc19ub2RlX3B0cl9nZW5lcmF0aW9uKHBhcmVudCwgc2xv
dCk7Ci0JY2hlY2sub3duZXJfcm9vdCA9IGJ0cmZzX2hlYWRlcl9vd25lcihwYXJlbnQpOwogCWNo
ZWNrLmhhc19maXJzdF9rZXkgPSB0cnVlOwogCWJ0cmZzX25vZGVfa2V5X3RvX2NwdShwYXJlbnQs
ICZjaGVjay5maXJzdF9rZXksIHNsb3QpOworCXNtcF9tYigpOwogCisJV0FSTl9PTighbWVtY21w
KCZjaGVjaywgJmVtcHR5LAorCQlzaXplb2Yoc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNr
KSkpOwogCWViID0gcmVhZF90cmVlX2Jsb2NrKHBhcmVudC0+ZnNfaW5mbywgYnRyZnNfbm9kZV9i
bG9ja3B0cihwYXJlbnQsIHNsb3QpLAogCQkJICAgICAmY2hlY2spOwogCWlmIChJU19FUlIoZWIp
KQpAQCAtMTUzMSwyNCArMTUzNiwyNiBAQCByZWFkX2Jsb2NrX2Zvcl9zZWFyY2goc3RydWN0IGJ0
cmZzX3Jvb3QgKnJvb3QsIHN0cnVjdCBidHJmc19wYXRoICpwLAogCQkgICAgICBzdHJ1Y3QgZXh0
ZW50X2J1ZmZlciAqKmViX3JldCwgaW50IGxldmVsLCBpbnQgc2xvdCwKIAkJICAgICAgY29uc3Qg
c3RydWN0IGJ0cmZzX2tleSAqa2V5KQogeworCXU2NCBnZW4gPSBidHJmc19ub2RlX3B0cl9nZW5l
cmF0aW9uKCplYl9yZXQsIHNsb3QpOworCXU4IHBhcmVudF9sZXZlbCA9IGJ0cmZzX2hlYWRlcl9s
ZXZlbCgqZWJfcmV0KTsKIAlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IHJvb3QtPmZz
X2luZm87Ci0Jc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrIGNoZWNrID0geyAwIH07CisJ
c3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrIGVtcHR5ID0geyAwIH07CisJc3RydWN0IGJ0
cmZzX3RyZWVfcGFyZW50X2NoZWNrIGNoZWNrID0geworCQkudHJhbnNpZCA9IGdlbiwKKwkJLmxl
dmVsID0gcGFyZW50X2xldmVsIC0gMSwKKwkJLm93bmVyX3Jvb3QgPSByb290LT5yb290X2tleS5v
YmplY3RpZCwKKwl9OwogCXU2NCBibG9ja25yOwotCXU2NCBnZW47CiAJc3RydWN0IGV4dGVudF9i
dWZmZXIgKnRtcDsKIAlpbnQgcmV0OwotCWludCBwYXJlbnRfbGV2ZWw7CiAJYm9vbCB1bmxvY2tf
dXA7CiAKIAl1bmxvY2tfdXAgPSAoKGxldmVsICsgMSA8IEJUUkZTX01BWF9MRVZFTCkgJiYgcC0+
bG9ja3NbbGV2ZWwgKyAxXSk7CiAJYmxvY2tuciA9IGJ0cmZzX25vZGVfYmxvY2twdHIoKmViX3Jl
dCwgc2xvdCk7Ci0JZ2VuID0gYnRyZnNfbm9kZV9wdHJfZ2VuZXJhdGlvbigqZWJfcmV0LCBzbG90
KTsKLQlwYXJlbnRfbGV2ZWwgPSBidHJmc19oZWFkZXJfbGV2ZWwoKmViX3JldCk7CiAJYnRyZnNf
bm9kZV9rZXlfdG9fY3B1KCplYl9yZXQsICZjaGVjay5maXJzdF9rZXksIHNsb3QpOwogCWNoZWNr
Lmhhc19maXJzdF9rZXkgPSB0cnVlOwotCWNoZWNrLmxldmVsID0gcGFyZW50X2xldmVsIC0gMTsK
LQljaGVjay50cmFuc2lkID0gZ2VuOwogCWNoZWNrLm93bmVyX3Jvb3QgPSByb290LT5yb290X2tl
eS5vYmplY3RpZDsKKwlzbXBfbWIoKTsKIAogCS8qCiAJICogSWYgd2UgbmVlZCB0byByZWFkIGFu
IGV4dGVudCBidWZmZXIgZnJvbSBkaXNrIGFuZCB3ZSBhcmUgaG9sZGluZyBsb2NrcwpAQCAtMTU4
Nyw2ICsxNTk0LDggQEAgcmVhZF9ibG9ja19mb3Jfc2VhcmNoKHN0cnVjdCBidHJmc19yb290ICpy
b290LCBzdHJ1Y3QgYnRyZnNfcGF0aCAqcCwKIAkJCWJ0cmZzX3VubG9ja191cF9zYWZlKHAsIGxl
dmVsICsgMSk7CiAKIAkJLyogbm93IHdlJ3JlIGFsbG93ZWQgdG8gZG8gYSBibG9ja2luZyB1cHRv
ZGF0ZSBjaGVjayAqLworCQlXQVJOX09OKCFtZW1jbXAoJmNoZWNrLCAmZW1wdHksCisJCQlzaXpl
b2Yoc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrKSkpOwogCQlyZXQgPSBidHJmc19yZWFk
X2V4dGVudF9idWZmZXIodG1wLCAmY2hlY2spOwogCQlpZiAocmV0KSB7CiAJCQlmcmVlX2V4dGVu
dF9idWZmZXIodG1wKTsKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Rpc2staW8uYyBiL2ZzL2J0cmZz
L2Rpc2staW8uYwppbmRleCBmOGI1OTU1ZjAwM2YuLjQ5YjA3N2FjZjM1OSAxMDA2NDQKLS0tIGEv
ZnMvYnRyZnMvZGlzay1pby5jCisrKyBiL2ZzL2J0cmZzL2Rpc2staW8uYwpAQCAtNTMwLDYgKzUz
MCwxMCBAQCBzdGF0aWMgaW50IHZhbGlkYXRlX2V4dGVudF9idWZmZXIoc3RydWN0IGV4dGVudF9i
dWZmZXIgKmViLAogCX0KIAogCWlmIChmb3VuZF9sZXZlbCAhPSBjaGVjay0+bGV2ZWwpIHsKKwkJ
YnRyZnNfZXJyKGViLT5mc19pbmZvLAorImxldmVsIHZlcmlmeSBmYWlsZWQgb24gbG9naWNhbCAl
bGx1IG1pcnJvciAldSB3YW50ZWQgJXUgZm91bmQgJXUiLAorCQkJICBlYi0+c3RhcnQsIGViLT5y
ZWFkX21pcnJvciwgY2hlY2stPmxldmVsLAorCQkJICBmb3VuZF9sZXZlbCk7CiAJCXJldCA9IC1F
SU87CiAJCWdvdG8gb3V0OwogCX0KQEAgLTU4MSwxMyArNTg1LDIwIEBAIHN0YXRpYyBpbnQgdmFs
aWRhdGVfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsCiAJaWYgKGZvdW5k
X2xldmVsID4gMCAmJiBidHJmc19jaGVja19ub2RlKGViKSkKIAkJcmV0ID0gLUVJTzsKIAorb3V0
OgogCWlmICghcmV0KQogCQlzZXRfZXh0ZW50X2J1ZmZlcl91cHRvZGF0ZShlYik7Ci0JZWxzZQor
CWVsc2UgewogCQlidHJmc19lcnIoZnNfaW5mbywKIAkJInJlYWQgdGltZSB0cmVlIGJsb2NrIGNv
cnJ1cHRpb24gZGV0ZWN0ZWQgb24gbG9naWNhbCAlbGx1IG1pcnJvciAldSIsCiAJCQkgIGViLT5z
dGFydCwgZWItPnJlYWRfbWlycm9yKTsKLW91dDoKKwkJYnRyZnNfZXJyKGViLT5mc19pbmZvLAor
ImNoZWNrIG93bmVyX3Jvb3Q9JWxsdSB0cmFuc2lkPSVsbHUgZmlyc3Rfa2V5PSglbGx1ICV1ICVs
bHUpIGhhc19maXJzdF9rZXk9JWQgbGV2ZWw9JXUiLAorCQkJICBjaGVjay0+b3duZXJfcm9vdCwK
KwkJCSAgY2hlY2stPnRyYW5zaWQsIGNoZWNrLT5maXJzdF9rZXkub2JqZWN0aWQsCisJCQkgIGNo
ZWNrLT5maXJzdF9rZXkudHlwZSwgY2hlY2stPmZpcnN0X2tleS5vZmZzZXQsCisJCQkgIGNoZWNr
LT5oYXNfZmlyc3Rfa2V5LCBjaGVjay0+bGV2ZWwpOworCX0KIAlyZXR1cm4gcmV0OwogfQogCkBA
IC02NTIsNiArNjYzLDcgQEAgaW50IGJ0cmZzX3ZhbGlkYXRlX21ldGFkYXRhX2J1ZmZlcihzdHJ1
Y3QgYnRyZnNfYmlvICpiYmlvLAogCWludCByZWFkc19kb25lOwogCiAJQVNTRVJUKHBhZ2UtPnBy
aXZhdGUpOworCVdBUk5fT04oIWJiaW8tPmlzX21ldGFkYXRhKTsKIAogCWlmIChidHJmc19zYihw
YWdlLT5tYXBwaW5nLT5ob3N0LT5pX3NiKS0+bm9kZXNpemUgPCBQQUdFX1NJWkUpCiAJCXJldHVy
biB2YWxpZGF0ZV9zdWJwYWdlX2J1ZmZlcihwYWdlLCBzdGFydCwgZW5kLCBtaXJyb3IsCkBAIC04
MzMsMTIgKzg0NSwxNSBAQCB2b2lkIGJ0cmZzX3N1Ym1pdF9tZXRhZGF0YV9iaW8oc3RydWN0IGJ0
cmZzX2lub2RlICppbm9kZSwgc3RydWN0IGJpbyAqYmlvLCBpbnQgbQogewogCXN0cnVjdCBidHJm
c19mc19pbmZvICpmc19pbmZvID0gaW5vZGUtPnJvb3QtPmZzX2luZm87CiAJc3RydWN0IGJ0cmZz
X2JpbyAqYmJpbyA9IGJ0cmZzX2JpbyhiaW8pOworCXN0cnVjdCBidHJmc190cmVlX3BhcmVudF9j
aGVjayBjaGVjayA9IHswfTsKIAlibGtfc3RhdHVzX3QgcmV0OwogCiAJYmlvLT5iaV9vcGYgfD0g
UkVRX01FVEE7CiAJYmJpby0+aXNfbWV0YWRhdGEgPSAxOwogCiAJaWYgKGJ0cmZzX29wKGJpbykg
IT0gQlRSRlNfTUFQX1dSSVRFKSB7CisJCVdBUk5fT04oIW1lbWNtcCgmY2hlY2ssICZiYmlvLT5w
YXJlbnRfY2hlY2ssCisJCQlzaXplb2Yoc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrKSkp
OwogCQlidHJmc19zdWJtaXRfYmlvKGZzX2luZm8sIGJpbywgbWlycm9yX251bSk7CiAJCXJldHVy
bjsKIAl9CmRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRlbnRfaW8uYyBiL2ZzL2J0cmZzL2V4dGVu
dF9pby5jCmluZGV4IDgzZGQzYWE1OTY2My4uZTFlZTE5NDAxMzJjIDEwMDY0NAotLS0gYS9mcy9i
dHJmcy9leHRlbnRfaW8uYworKysgYi9mcy9idHJmcy9leHRlbnRfaW8uYwpAQCAtNDg3OCw3ICs0
ODc4LDggQEAgc3RhdGljIGludCByZWFkX2V4dGVudF9idWZmZXJfc3VicGFnZShzdHJ1Y3QgZXh0
ZW50X2J1ZmZlciAqZWIsIGludCB3YWl0LAogCQkgKi8KIAkJYXRvbWljX2RlYygmZWItPmlvX3Bh
Z2VzKTsKIAl9Ci0JbWVtY3B5KCZidHJmc19iaW8oYmlvX2N0cmwuYmlvKS0+cGFyZW50X2NoZWNr
LCBjaGVjaywgc2l6ZW9mKCpjaGVjaykpOworCW1lbWNweSgmYnRyZnNfYmlvKGJpb19jdHJsLmJp
byktPnBhcmVudF9jaGVjaywgY2hlY2ssCisJICAgICAgIHNpemVvZihzdHJ1Y3QgYnRyZnNfdHJl
ZV9wYXJlbnRfY2hlY2spKTsKIAlzdWJtaXRfb25lX2JpbygmYmlvX2N0cmwpOwogCWlmIChyZXQg
fHwgd2FpdCAhPSBXQUlUX0NPTVBMRVRFKSB7CiAJCWZyZWVfZXh0ZW50X3N0YXRlKGNhY2hlZF9z
dGF0ZSk7CkBAIC00OTk2LDcgKzQ5OTcsOCBAQCBpbnQgcmVhZF9leHRlbnRfYnVmZmVyX3BhZ2Vz
KHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwgaW50IHdhaXQsIGludCBtaXJyb3JfbnVtLAogCQl9
CiAJfQogCi0JbWVtY3B5KCZidHJmc19iaW8oYmlvX2N0cmwuYmlvKS0+cGFyZW50X2NoZWNrLCBj
aGVjaywgc2l6ZW9mKCpjaGVjaykpOworCW1lbWNweSgmYnRyZnNfYmlvKGJpb19jdHJsLmJpbykt
PnBhcmVudF9jaGVjaywgY2hlY2ssCisJICAgICAgIHNpemVvZihzdHJ1Y3QgYnRyZnNfdHJlZV9w
YXJlbnRfY2hlY2spKTsKIAlzdWJtaXRfb25lX2JpbygmYmlvX2N0cmwpOwogCiAJaWYgKHJldCB8
fCB3YWl0ICE9IFdBSVRfQ09NUExFVEUpCkBAIC01MDA1LDggKzUwMDcsMjAgQEAgaW50IHJlYWRf
ZXh0ZW50X2J1ZmZlcl9wYWdlcyhzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIGludCB3YWl0LCBp
bnQgbWlycm9yX251bSwKIAlmb3IgKGkgPSAwOyBpIDwgbnVtX3BhZ2VzOyBpKyspIHsKIAkJcGFn
ZSA9IGViLT5wYWdlc1tpXTsKIAkJd2FpdF9vbl9wYWdlX2xvY2tlZChwYWdlKTsKLQkJaWYgKCFQ
YWdlVXB0b2RhdGUocGFnZSkpCisJCWlmICghUGFnZVVwdG9kYXRlKHBhZ2UpKSB7CiAJCQlyZXQg
PSAtRUlPOworCQkJYnRyZnNfZXJyKGViLT5mc19pbmZvLAorInJlYWQgZmFpbGVkLCBieXRlbnI9
JWxsdSBjaGVjayBvd25lcl9yb290PSVsbHUgdHJhbnNpZD0lbGx1IGhhc19maXJzdF9rZXk9JWQg
Zmlyc3Rfa2V5PSglbGx1ICV1ICVsbHUpIGxldmVsPSV1IHNpemU9JXp1IiwKKwkJCQkgIGViLT5z
dGFydCwKKwkJCQkgIGNoZWNrLT5vd25lcl9yb290LCBjaGVjay0+dHJhbnNpZCwKKwkJCQkgIGNo
ZWNrLT5oYXNfZmlyc3Rfa2V5LAorCQkJCSAgY2hlY2stPmZpcnN0X2tleS5vYmplY3RpZCwKKwkJ
CQkgIGNoZWNrLT5maXJzdF9rZXkudHlwZSwKKwkJCQkgIGNoZWNrLT5maXJzdF9rZXkub2Zmc2V0
LAorCQkJCSAgY2hlY2stPmxldmVsLAorCQkJCSAgc2l6ZW9mKCpjaGVjaykpOworCQkJZHVtcF9z
dGFjaygpOworCQl9CiAJfQogCiAJcmV0dXJuIHJldDsKLS0gCjIuMzkuMAoK

--------------5191fERIl5RaybdDbaitkB0P--
