Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CE748009
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjGEIqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGEIqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 04:46:13 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4501133
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 01:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdh4grzwYWpNnnCCCnXeMfZ83KDXV0vWpXi0qeeYDTyRQ+vQUt7nfpmybPiCPZpZvG0AIyLOuaMcDdJsfdQjGhz6oHvqEJ4yFm0hkiS6qouBou0grBf8vRChbgx0DhIPHHSUg7dQEVwlewgsW3NWFLEVErgb8CkrU062RHHyyDSktoahFHQGOebmxXOnajXg+SJMhcwwu70bEDlzavI+xoePmLr7bYcr+BDdo8dyZ+D2Lcddf+P0YhsxSorOothdmuODqfAqbQ32aWy/C+KrH7cC7pbpMU3UfcnWWM0XqD32IwqM1Sx1w6Xdty6Oc5fyIVqRqedfyreZ2K8XnS/axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIew3wXKp0ELIDZeo4K7tvsTbAhZ+ekdr673tSKbdAs=;
 b=B4qiT2r3l7MZgxjmk2QFJsyBDPD51fF1bo93TJzt3GwAvgMNtW7tGlATPadQreHPgaFNzMlb/iAMMkojeN1C18JlkYc6ZsuhzIUNmpypgnGCjNV9seZJSJR4KQfbH+nUuXvttQymvj9Lvoy2l3S9m7Z/2QUv264QEsLczTLGhP4I9dTRdqnDrkv9vjKRJomCut8hUlHblR0Zw2PbPNX6IDhLNzgxKP5JtFy6RRglQ0APMRkxaCAfxkiWWcNrz6of3cntnwaNda7l+2ctkZ1tAt5DHaQBsQ9ygJ8spjmK+9bwn3envuCR5FR835myaHhZwcIMDCRO9ZmNV451GQB6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIew3wXKp0ELIDZeo4K7tvsTbAhZ+ekdr673tSKbdAs=;
 b=5dIBjq4Ph5efksvRJ8Iyh17VltG0V81673v2XymZWE0MPjlqsRkNS0S8hCbA5ZcXjOyYQC+SZB11Q3QLMc5eeIXTkdKUGylckK8JMDAKhkITFhh3bTJ9RJPM3bVqdqaA8P0fZiQzZFT0crgtuOdi0n44EX1/npDo1Z3UUQ4ez7jedlbECwiaMXTgfBCWj0LjUoqaBgtBMYvqT8tH9MUUwUjSkUNJsCF4rGKX6QleZAPXKyOIh6+WCUljvJW1zRZngzQEyBMmzgJJU+BPicuZ3vJGPG4dMJOEN4EBK6UlWbxzXV3AkSsOGpv8AfMS7ypmApmlqZ4X7clExKR14c4ouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS5PR04MB10017.eurprd04.prod.outlook.com (2603:10a6:20b:67c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:46:08 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:46:08 +0000
Message-ID: <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
Date:   Wed, 5 Jul 2023 16:45:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
Content-Language: en-US
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS5PR04MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: acd0ce29-faa3-440d-fb87-08db7d344669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVA930u19vDINiVhDVqqkbb7n8PNnJq87hCg2jUKAklMRH85reRq0XLuMlpPt588MEpZvJ5AITrBEFfcu2kZ/aSMlXHMcr1G2O9St3tR+xZbD3n0w5atvYThkN9fuPtqErne1UFJGiuqstT5apc8p4GKhyz/LT9XgAMQV/8DEpc8sIXXV04EPmqr0oCyLm9eC6Xys+DSNXzRKNARJV+E1dFdVb2mtYundWusr9L/QRIyxILwUVfL3jtZTiIVJPfUGUSk/OhT232kyFYjzlUO2pMHk5L4OBZzsCpo+GdW3955mWhK6Q43/48cQ5V0idQrRnpWRK9FDh8jkPySh1U9q23WtpNEjI2URfgnRb48nHJFyjubKKic1oWFNBhnj4529HJXYN/FOCSP6zBTYBc88ZhuGFT6KHYiD2fkZhNWhA3KfSfnXu8DHKsmK3dlIflhcrnvpKQOTd5c27lFJE4kMXVfhh7uwHJsOSImDtGT8u9m1JVhyfd9OYqAp9wGecgg6Q9MbrLJIp1A10EjwBIRvN6AIiiQxtgnk1eU8Av4ns+Ny+nY2+2GklvaaTPHHZ6WUBxH6uAvViu01XODBDCoQUKANaoeaKXcCP4gFmg/BPAd7Qf1ld4Kay3zByZkr75KTs2Hq2wkO/+nqY5mAP3fcoBtWTmz69uhbS03oxYFufg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(38100700002)(6506007)(66476007)(66556008)(66946007)(2616005)(186003)(86362001)(6666004)(966005)(31696002)(6486002)(6512007)(36756003)(53546011)(478600001)(110136005)(8936002)(8676002)(3480700007)(5660300002)(31686004)(2906002)(41300700001)(316002)(83380400001)(66574015)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBOcEwrTXEwSEVjUi9Yb1p6Tkx6QXJmeE52TU14K21EV0d6VUNaUnZCc1FN?=
 =?utf-8?B?RjVzT1dObTlIWHBIbmw0UUhUaU9sdHI1dlIzTFlpQ0gyOEZ1a2xDd3FSSnVM?=
 =?utf-8?B?Z05JamhvOU1iclBMUlRnMzBBazZYNXZDZ3AxQ3RpNGNEK2Y5L1FFVFI1bkFM?=
 =?utf-8?B?VW1sbGptKzR5L1NyQkNhaW5BeTVIV1ZBaitRcE96cFJJeHgzd01XNENNMnRW?=
 =?utf-8?B?Z1JoOXg1NmFuVnkrdEtSWXpWYms1K1ZYVnROV215emZkWXVCUUxBNVFkdTJE?=
 =?utf-8?B?U01ONko0UFpSamtWMGJCN0thcmZ4ZGZNZEVCdllqRVBoczl2RjNSL3VUZkRH?=
 =?utf-8?B?UnA1ZWdRaTczd1NiRnBMU2pOWHUrZW1rQU82b3EzU1Y3NW9UZm4ySEFqYVBF?=
 =?utf-8?B?Q3VZY3luUUp3VnN3NnBkTGk3VitLeG0wN2NZd1dMYk9GeUZVY1VNR0tCMWVr?=
 =?utf-8?B?UlovTDlMeHQxTnF0UjhZKytEYXZsVTJCRzUrQ1JtUThpcjJ2Vk81UjhqTUxr?=
 =?utf-8?B?SW13Tjc3TjY1NVZTMHVZa3VsWGppRlNkQy9XLzRYZ3QrbTFPZHdONmhYQldj?=
 =?utf-8?B?TTJ4bHRPYTV3MFdTSlJjSGlzQTR0OGZoNXRXZHR0SndaNUJsT3hXQmpDd0FG?=
 =?utf-8?B?bHZYUTVMdFNKRHJDVWV6dUZ6NGxBNGpaOWtCMEdyajEzdWhKaXl5d1dsdXlO?=
 =?utf-8?B?R2RiTHo0MnBManQwNmZBQlBLOXZXcGJBYmpQOFFRUWU4R1ZLQ2dieTVEV0FQ?=
 =?utf-8?B?cHVnYkViVHRYcDl0Tm45dzkrWTdIeUxVZUlOeTVKTG9VVHlla0JKMmhHcVQ5?=
 =?utf-8?B?ajFQY0JrVGZvaHhha0ZOenFkRTRKRE1XMDFWakF6Yy9tWDV5SVNWQUdhVjJW?=
 =?utf-8?B?ekJweXlreU9TV3A5Y0NDWlAwZ2NxV1dFNGdPcTNjWUs3Y3pSQTdWWXVtRm54?=
 =?utf-8?B?bHRSb08xcm40ZGJaTjBKNTNXU2RhVFkwQjZ3RW9KQjV4TDdQUURzQlVzelpj?=
 =?utf-8?B?WXdJWndrdUdUSEUrUngxQmZiaDJWTGxkam5uYjFjcUl6TjMxNHA4bzNoMzJO?=
 =?utf-8?B?YUdvRUxsbm1wMER3UWNFdE5vM05ZSVplSWlFM1J0RkcwK0RSYWJyZW4wZ0NO?=
 =?utf-8?B?L2Q3b0pRV1RKVEt5YVkyUDVjZVJWZUgyZkZqVmJwMnBiSG1vVTNxdTMvTDFV?=
 =?utf-8?B?bldDeFZHWHkrTXREZXY2cXpXZkdjV2hFQk0zcTQzRXBRbW9lY2Q4YUQ4dGFG?=
 =?utf-8?B?RHFEb0VTbFBVMXdQVy9ib0d5TDZYdlZsQlc5akx0STkyN0tUSmg4WThQWklO?=
 =?utf-8?B?alh0cXZMSnE2cno3MDh2MlZXTllMaFNGT1BHOXZLMHA5Wk9iYWxsWmpiVm9L?=
 =?utf-8?B?UzlpK00wU2dVci8vdkR2RlVNazk1M21rOFRwZEZGajNBL0xVRFYwbDlRYVBr?=
 =?utf-8?B?azV1UWpsZ1hEbzVkMFVHQjYvaXdRNkF2NDB3VElSTEc2ai9TRmZNbjAvS3ly?=
 =?utf-8?B?dzIyT0E4THNPOU9wL29WQzJqWE1DQXhSZ3p4ckJ2Sjh0ZjlKaC9JRWFoQnFE?=
 =?utf-8?B?RE44MU1mNHY4R0tucVVMUklSVUk3T1h2Yk9yait2Njk2ejFFazNMWDJjM3pv?=
 =?utf-8?B?NGgyZGk5NldIb0ZwNkZ1U0V0QTgxSGQ4WE1tQ0tsQUVCUEVmUzFWL3AzTUFV?=
 =?utf-8?B?akN0c1BjaGhtQzFGQlpGUElSMXJhYTZYT1BHMTY2TFhrYk0zMVBBQU5PalhQ?=
 =?utf-8?B?TytXOVdNVjhlUElkUHZ3b0hENWc4bEg0bWF6UzNLeTREcW1sRDZFWGk0dFJW?=
 =?utf-8?B?L1M2OFRmSkI2NGMvK2RIOVkyZCtkZmNqZkE5a0VxU2pKaG00WnBnQzFFT0t5?=
 =?utf-8?B?TlpSVHlRekV0Ym1QOTdXRHlDWVh3dWxoejRUeWNJemNuSWhuNE9GOUxNWFlP?=
 =?utf-8?B?Z1JVT1NTN2dYL3dsV2dHMUNub3Q0MGpxSS90TW5rR1hzY2JTZGM0cWRyaFRo?=
 =?utf-8?B?OU1xSW00WFBrWGpvUjFBdFdnN2xVamVkc3E1SjJRYUlCbkhDMmJXWVFVTU9y?=
 =?utf-8?B?MHdCZk5McHZPVTBKMEJsNnpBeWNTVFJGSEkvMnBHcWR2R044ZGFMZEZTMDVQ?=
 =?utf-8?Q?6ziwLROJrd+Kw52msy78boxcU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd0ce29-faa3-440d-fb87-08db7d344669
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:46:07.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3V5gHvsWSrbFyPO2kkdLdPNqwKGuBD7FzAEHuk1GInL2zu7vhiNYpOS7ucnVLoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10017
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/5 16:39, Bernd Lentes wrote:
> 
>> -----Original Message-----
>> From: Qu Wenruo <wqu@suse.com>
>> Sent: Wednesday, July 5, 2023 12:19 AM
>> To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>; Qu Wenruo
>> <quwenruo.btrfs@gmx.com>; linux-btrfs <linux-btrfs@vger.kernel.org>
>> Subject: Re: question to btrfs scrub
>>
>> That's why it doesn't report the csum error, and we need "--check-data-csum"
>> to verify data csum.
> 
> OK. I started it. But isn't that the same as "btrfs scrub" ?
> The man page gives a hint:
> --check-data-csum
> verify checksums of data blocks
> This expects that the filesystem is otherwise OK, and is basically an offline scrub that does not repair data from spare copies.

Btrfs check has way more comprehensive checks on metadata, but it by 
default not check data csums.

Which is quite the opposite of btrfs scrub, which only checks data csum, 
and metadata checks are very lightweight.

> 
>>> What can I do ? I'm afraid I have to reformat.'
>>
>> Nope, you don't need to reformat at all.
>>
>>> But what be the culprit for the errors ?
>>
>> It can be a problem of the VM workload on btrfs.
> My VM's are not under heavy load.
>>
>> As a workaround, you can easily disable datacow for the VM directory using
>> the following command:
>>
>> # chattr +C <VM images directory>
> 
> No. I use btrfs to make snapshots from the images from the VM's.

NodataCOW would still work with snapshot.

It would still do COW when there are snapshots involved.

The main thing here is, nodatacow implies nodatacsum, thus it would not 
generate any csum nor verify it.

Thanks,
Qu

> 
> Thanks.
> 
> Bernd
> 
> 
> Helmholtz Zentrum München – Deutsches Forschungszentrum für Gesundheit und Umwelt (GmbH)
> Ingolstädter Landstraße 1, D-85764 Neuherberg, https://www.helmholtz-munich.de
> Geschäftsführung: Prof. Dr. med. Dr. h.c. Matthias Tschöp, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir’in Prof. Dr. Veronika von Messling
> Registergericht: Amtsgericht München HRB 6466 | USt-IdNr. DE 129521671
