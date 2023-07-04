Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F4747A19
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 00:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGDWTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jul 2023 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGDWTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jul 2023 18:19:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC29E7B
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jul 2023 15:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtiqLeu8Q2UkmSKA0Ldo0VRls+7wnMwMqamMQSlPq97QAeHuq9qVYrVNgLJMPpNEFbB1su3giCMIYQzkxZziq+KUeV/mIHy82kA8siFf4zIiQL+zAlMx1ZzQ+l6Su0T3lRJt8rKjzNALXUQ/ecUlrb4Xj2ZSlPkIDCTBTJY/b3O8CjL3vlQJdB3aUSJE3obMMfeDkjRffO8DHeXCXKcJHa2IXJ41wOJIbfVkv/IT/12tgXcBNpKvWY7nG+cztu3tI1l3X/ZF4jco5jVPESFSqX4erdu04f1f+hBW1kR81d/8rVaEQf/ptpfD/l25pg/x+83Cv5KEO73N+6QGealXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX6+fgNQ+LSdtF4OfKwmavFYXELqcdCS369Wh7IC7Cc=;
 b=mXffhJ7c3AB7RZm3rhyU8sYCoWHIkRfpXHXhyziImzVrx7hz6lu1ddefE1pEbV7ctC/7ZUG7/UBWi7MF5gI+EStqmLYYy2MN2YMDtukX/Qn4kkWX8ZaZVZlTq1BtKZ4ANPvSHzPCVZikjZ9HfAmoUlqoBDIXUTZiQcv6QS3omCaj/2OeVWqle7/mhrgb1Wpc6dU6Te0s7gCEdfgge2brrY7O9hJxaUZrNqilPMh3y9QNs0qJQQXHCCMMmBBNrqtkYb1YRvuGVt/RQMiUmvh9T3iIqWRr8yZ4BIXw5KkIVjF/gtYXKpnoPJCdAcJOzd+xU0oLA7Cv7Cx90/H++Ip67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX6+fgNQ+LSdtF4OfKwmavFYXELqcdCS369Wh7IC7Cc=;
 b=VkYbL245HcIIl2o1E2JBnE1r8P1EuUqUd0c+FNfSjlco3hrlcjhp8qpX0iazzK61qz1A+aUa97h3f6StV46hyCSMdyXvKfavJ5q5UIQqxuKqGek6yd3Bac3fmI2Y4KNMdT6Hfw6Gi2v+Z3mAc0siWo2eN3Qk4KRNxYBrDMOA2j3ybqXhC/ZXb4oFjeIFQ5n7llRsPT0ec9ZbNJReiucxptlE6WJCZKrdm6somdoUpmGVUa7gakBkVeiJ1CGIw4+i5AfTD540ZgSwozqlVVIPoamx0N92l7mNKtKpd206RGbGviU/5IEXT7Pkf3Uj4ExRhGbeS9BcmSSIE/+1ZdrHRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 22:19:10 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 22:19:10 +0000
Message-ID: <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
Date:   Wed, 5 Jul 2023 06:19:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: b387dac0-2e43-4843-2103-08db7cdcb048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvVnlMPu/+aC1tKXen6/DA58GzauMhgPtOft1LZy5M3l0LZhySywosJ1t+TYKBiPGS3blZGAQy/o+LgjDj6vO8IMLjJk3Ux+GlmHfQRrTKCvgqSfpD6k2Uz4Ct4tY5FZR8JHRILiJNEN5R/Ef8E8l7S1iexjxLeVtAb8CpcR6UJoX6IFyeIcJlalc2Szg4Sm3w1IcO67Eg9emPy7AO5jFriiQt3Hare9hjrJSkkRFYlo3NbQmKOwQwc22V7sNbNYEzlmcd8U02sOJ3EvMzhK8fGgBWPaw65sgb+v4DAGSEfts1OnIi1z1iin3y4fiBEscva4qU3OJjlUde88WLj9W9u6b61mhhrmyHCjG9XKyorA4zqJe/KR+EBCf1CXVrL7yVFb/ikjNDLJ8/HSMW+2Ekr2Jxa3zGKzhSGeW3Jo3f6npc7JYEixQ8Gxz4b90wMIq2pZn+silAyh19rWXwE2vtGcIQHPIE9Fib3MLKeHekGYVYwdyL5HNL6Pl8Me+UO2WkXYa4eJjLW+PPKoJEGJu3qOl05HJO3EWAd76/h8KVA3TuZCIdFx0DsgOXLHgSAxKGX+eTa4VVp1aB1G5dIw5o/i5ssP2PiV6ZV1TiaWiyu3IQ7Gl/yxdFK/eCjaH+8LVkR/D4NCIbXWQCGAnuzusE4ts9RbLgopgq+FkMf7Nq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(316002)(2616005)(66946007)(66556008)(8936002)(83380400001)(86362001)(66574015)(2906002)(31696002)(5660300002)(66476007)(8676002)(41300700001)(3480700007)(6486002)(966005)(31686004)(186003)(53546011)(6506007)(478600001)(6512007)(36756003)(110136005)(6666004)(38100700002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZZMlJTaytiZ2lWS1p6dkVuREFacm10d3h3TytqTWRBbW9aeWhpT0JNYzFV?=
 =?utf-8?B?QzlWbnUxT3E0TU8rZSszajZkb1RHOE9GOHdCVG0weWpxS1o3RlpQb2o4aS95?=
 =?utf-8?B?RlpxMUZ6M2JWK085YVZaZFpsb3RGMmIvaFVPZUxWSzVlOXo0cWZTZ1ZGcUVD?=
 =?utf-8?B?YU5DRElFdlhmS0RBMXpHRTBCMEtvVXFWcTN5OWVXMnNHNWlIRVZ0TFJZZnZ3?=
 =?utf-8?B?S2dickxkUFlNaHg1SEpQb25pRnIxek4xY3J0V3B2MGpJbXRIUGlhb1R5M2xs?=
 =?utf-8?B?em1kV0xzVGZkTWN0Ynp4bjM1QWdINlQySHB6K0tFZDZtQTl4akhmRkJiSE5M?=
 =?utf-8?B?UEdGQmNWNU13eXhCWVJXVEtxWGtPdE9RRG92RGpKamp2dWhUd3FvVFFiS0pK?=
 =?utf-8?B?SVE3dncxZ0poeHJ3aTBoL0tBRkRQSGg3OG92d0lSUlBuR2lNRmJKOTZ6UUV2?=
 =?utf-8?B?dUVnZlNDMk11ZXc4aGpFMW1ZK0w1cEpuUThDUFgwQnN1N3NNTjd5UTZ1dkZp?=
 =?utf-8?B?MWZEOGFCa0ZybTF2R1JXdTNLK21IM29QOWNGY0cwTEI0eVFKR0hEbVJTMTFp?=
 =?utf-8?B?VjJ4VVZYKzhtVlhjMG5ZMFpJVSs4aW1nSWJRWk9Qc1FwUWVuaXZGQVptMi9h?=
 =?utf-8?B?SytiM2x6ZUJLbzd1Y0o3QWRYV1JHQkVFVkp2ZlZnZ1ZzYm5SRlZWdVFzVjd5?=
 =?utf-8?B?SzJKKy81S2pnWmxpRXdiSFI3ZzkzejdlM0xYOGV0eWZSenlhdlB0Q1NwMVFV?=
 =?utf-8?B?UVRXdm1KTkRSMWp6SlRVWUo3SEV2LzVvNHY0d3pKZCtHK0xqeUU0VUhhZUlp?=
 =?utf-8?B?b29XK2hLK09tYTkwckEyWmlPOTVvRy9tRFVvYlJWT04rRDAzVUpQR2FmRG5i?=
 =?utf-8?B?ck4rUVFRYnNkNUgxYkljQXpOUFUvTmg4NG94aDZQdjQ2VUNCdWd4S2ZjaGpU?=
 =?utf-8?B?NG1lYkJtTU00NHlKeUdwNDkwR1VUREZDeFd5ZjcrVGFVVDYrcmNjRk1hM0s3?=
 =?utf-8?B?SVdtdTNrZkJqcVVPL24rUDNQWUs0Z2QxWTdYdmxVWFhBTnlEUU1MQzc5a2lz?=
 =?utf-8?B?MzZyMUZzVjMvcWpmSUM0QWxocG5ZZHU2NFJqbERpWlFxdjRrb2VYd0VNalRC?=
 =?utf-8?B?Rm50aDN5SWh4UmpjZjloUDlmTngxQ3RMdDJDelg1LzFtQ0hReGljTzI2R2cz?=
 =?utf-8?B?UmpWbEFTWEl4aFdOUEZ0WHBzcUVTMEN4a01uK1I5Y2tnSUVsZHVybTgxdDVV?=
 =?utf-8?B?cGg4aldRVFBteis1YXYvSEpnZlZNOGNrdFNSM3RnWm9xV0k2aWsyZ0FLdU9v?=
 =?utf-8?B?TDN3aENYYzlpMURoQ0xianh3VlYrRTMxMm5HTVRocWdzRldSYm9FTDRnSEZO?=
 =?utf-8?B?NUk5WlJLV284VmVnemlFUGZSL0JGNjVUeGpXT0RRcmF4YUwra0FleWFqU1E1?=
 =?utf-8?B?SlhMMEp5WXFMVjhNKzRBdU5tTzJRMHNwWjlpcVc3NXlIQ1FnUllVcVNYVXBr?=
 =?utf-8?B?MFl5MmdoQ3pqRXNMY0RSU1Rqd0VmeG5ST1U1SmFzM0ZaRHMvcnk4M3pJY3M0?=
 =?utf-8?B?ZWQwYW5EYUUrSjBLSU9tZXBlN3h3S0hITDJ3NmJLelo5ZDQvUlRoWDQ0QURN?=
 =?utf-8?B?NHN1Y1NYck9wN1R0WWpMVWNQLytHT0dDV0Y2VlRkNnpmWDJaTUlTZ3I0RVdO?=
 =?utf-8?B?amhEQ2JPVU9qSnZ2L1JqUjNrMWdkZ1dndWxHZXNaWUxwMFJRTHpJRHZyVnFQ?=
 =?utf-8?B?MFlJWkdLbEk2TW1WOTNNNjJzb3E5ejhwM0lDOGszVVcrMEJ1Yk5nQURxc3JO?=
 =?utf-8?B?NkxsVG9La3BwZ1lzQll6WmRwcEo5YjM0cGUxM1Z1Y09mSzBiUkE0YWdkVFFM?=
 =?utf-8?B?MjA0NGFDSTI4WU5LZTRyYmV4eldQSVVnR3dQREM0bnFheUhqQ0gwamhzcWwx?=
 =?utf-8?B?VVRmR0loeVRXVStOUDBRSUh5MThDUVFQc2NiSjJaSk1GSXJjWGZRK05WcklS?=
 =?utf-8?B?WFNHT2F5eUZvcFlqSGNnaXlwMEpZd0NxcXdmWjFpdmN1NC9JM3l3V3pNSkdv?=
 =?utf-8?B?cEs0UWkwMmlFVXhtQlRyV21FUXhoSWc0eFlTYzJiaHMwLzN6Q09rT09GRzUr?=
 =?utf-8?Q?1nG09bmx9t4PzazXnaNxQW5mX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b387dac0-2e43-4843-2103-08db7cdcb048
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 22:19:09.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANo9kY4zl5NAgFaZFJ9T+1EM0tRhbe0PD2Or/2GGE6Flj16uNDvobCC0YfRt6ceE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/5 00:03, Bernd Lentes wrote:
> 
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: Friday, June 30, 2023 12:17 PM
>> To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>; linux-btrfs <linux-
>> btrfs@vger.kernel.org>
>> Subject: Re: question to btrfs scrub
>>
>>
>>
>>
>> And I don't want to go that path unless there are enough evidence to indicate
>> that.
>>
>> Have you figured out which file(s) are affected and what's the workload of
>> them?
> 
> Yes. Several images from virtual machines.
> 
> I made a btrfs check on the image and on the volume itself:
> 
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # btrfs check -p /dev/vg_san/lv_domains
> Opening filesystem to check...
> Checking filesystem on /dev/vg_san/lv_domains
> UUID: bbcfa007-fb2b-432a-b513-207d5df35a2a
> [1/7] checking root items                      (0:00:36 elapsed, 6900134 items checked)
> [2/7] checking extents                         (0:01:58 elapsed, 484995 items checked)
> [3/7] checking free space cache                (0:00:13 elapsed, 5184 items checked)
> [4/7] checking fs roots                        (0:02:39 elapsed, 65549 items checked)
> [5/7] checking csums (without verifying data)

Notice the quote "without verifying data".

That's why it doesn't report the csum error, and we need 
"--check-data-csum" to verify data csum.

   (0:00:10 elapsed, 3236328 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 13 items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 5396770611200 bytes used, no error found
> total csum bytes: 5263001424
> total tree bytes: 7945863168
> total fs tree bytes: 1077493760
> total extent tree bytes: 828391424
> btree space waste bytes: 1124143787
> file data blocks allocated: 127704684556288
>   referenced 8084906622976
> 
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # btrfs check -p /dev/loop0
> Opening filesystem to check...
> Checking filesystem on /dev/loop0
> UUID: bbcfa007-fb2b-432a-b513-207d5df35a2a
> [1/7] checking root items                      (0:01:24 elapsed, 6900131 items checked)
> [2/7] checking extents                         (0:04:28 elapsed, 484992 items checked)
> [3/7] checking free space cache                (0:00:46 elapsed, 5184 items checked)
> [4/7] checking fs roots                        (0:02:45 elapsed, 65549 items checked)
> [5/7] checking csums (without verifying data)  (0:00:10 elapsed, 3236328 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 13 items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 5396770562048 bytes used, no error found
> total csum bytes: 5263001424
> total tree bytes: 7945814016
> total fs tree bytes: 1077493760
> total extent tree bytes: 828342272
> btree space waste bytes: 1124095211
> file data blocks allocated: 127704684556288
>   referenced 8084906622976
> 
> Strange. No error found. I expected errors because of what btrfs scrub said.
> I checked the logical volume with badblocks - no error:
> ha-idg-1:~ # badblocks -sv -b 4096 /dev/vg_san/lv_domains
> Checking blocks 0 to 1664303103
> Checking for bad blocks (read-only test): ^[[A^[[Bdone
> Pass completed, 0 bad blocks found. (0/0/0 errors)
> 
> Now I'm a bit confused. badblocks and btrfs check no error, but btrfs scrub a lot of errors:
> 
> ha-idg-1:/mnt/sdc1/ha-idg-1/image # btrfs scrub start -B /mnt/image/
> scrub done for bbcfa007-fb2b-432a-b513-207d5df35a2a
> Scrub started:    Tue Jun 27 20:47:26 2023
> Status:           finished
> Duration:         35:39:48
> Total to scrub:   5.07TiB
> Rate:             40.16MiB/s
> Error summary:    csum=1052
>    Corrected:      0
>    Uncorrectable:  1052
>    Unverified:     0
> ERROR: there are uncorrectable errors
> 
> What can I do ? I'm afraid I have to reformat.'

Nope, you don't need to reformat at all.

> But what be the culprit for the errors ?

It can be a problem of the VM workload on btrfs.

As a workaround, you can easily disable datacow for the VM directory 
using the following command:

# chattr +C <VM images directory>

And then just delete the VM image file causing the problem.

Thanks,
Qu
> 
> Bernd
> 
> Bernd
> 
> Helmholtz Zentrum München – Deutsches Forschungszentrum für Gesundheit und Umwelt (GmbH)
> Ingolstädter Landstraße 1, D-85764 Neuherberg, https://www.helmholtz-munich.de
> Geschäftsführung: Prof. Dr. med. Dr. h.c. Matthias Tschöp, Daniela Sommer (komm.) | Aufsichtsratsvorsitzende: MinDir’in Prof. Dr. Veronika von Messling
> Registergericht: Amtsgericht München HRB 6466 | USt-IdNr. DE 129521671
