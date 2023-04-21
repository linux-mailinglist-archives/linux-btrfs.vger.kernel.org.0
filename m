Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8996EB547
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Apr 2023 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjDUW4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjDUW4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 18:56:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C294D1730
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 15:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5ZavJjPVvJinLm6l+8fs7hgTAN99KLSfhcikwL/5hiLn1SZu62iQEsZretSI6fM/DrzsBn54giH5hSs7dMW6QBttL3EAmfvz2l7a2V6cMlktGXmHbg+ez4Q+iwQLJKLv2+OMnHmRnQU/osIHB2PRikVtnOamMO8kdn4U3Shjz4rTLzgii5o8LDkE6mvwcCAaq8s/aCG1ESG90y89ShbRGOh8HaHimOZhCtvegvbE9MCZKpgTMPr+AT4jyvlzn6RDn3aHAWfulKDdmENPymxiBQVJUerd13l1kdrUcBGhbpH5WUUUoZploXk+xW9Xk7kwgjlwwLaddPGpXpe/ToAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLVTFMOVsrlU9xbxdEyNULPxwAFRW1xtmuO2h1x3io4=;
 b=dBm1aX00kNo8QGChhUtN7X6vjVK46LhVAKmNTevoxO6H/3d6SE0uIX/BBgYoGtMQJJBUm7bGEIkgER6d+x4Bx2G/z66V/PURxWGwnACP3gSlVhU2wvXJNf1R73H7ynNyROIpMKYXbQqKeFi5KL3j3rYsq/3SV8T1G+wN5+w0e+AiRu7Qpu2SZ9jxk3ozuBgvlf7h2L0Y7/TVD6zZCo+LNM9BReFlcG9cLsiZ2FM+EwRFaZFrdD9tOKBKtMUXNEA8jKaVG8gOhEPcrHF07O2tiMH9yf5RY54nZCYBRaGDFKyyKQFmaQSV31ihLdNr0oOgJTG5gpYVxJM8J40fI7Qb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLVTFMOVsrlU9xbxdEyNULPxwAFRW1xtmuO2h1x3io4=;
 b=MgY4A60Y0xr4lRiuNnXrKIt2KtIlpylWvq4bm3ro6cAjDCt+7fA13thA58jHUXlxnicVAs345P5TDslI7/Ci33VBd4irHrIu9+d+b7wy8fvSzmH6hD4iQp4gI07I/FUK9ERtxG8r822kz1WI5PxPGmTBnynpEvvyBeNIj85iZeDIrwXWp9EM8BhgL0yzJpiyNc6olfH0exKJaTPLaWLO5s8a3OKoX5iPp8+T0q/lq9vHfUma7KkNSuxPe995NQhu8OlSX/vOrH5MVpLpG9jVY9PuaK890Q2gJ56bEnByjCrNdpnWGsTCNMHTkOS/GcUp8+niPHmw+rYDtzFvuQS9ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 22:56:01 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 22:56:01 +0000
Message-ID: <d73d6032-fd56-e544-d011-3a5fb4f70a43@suse.com>
Date:   Sat, 22 Apr 2023 06:55:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
To:     joshua <joshua@mailmag.net>, waxhead@dirtcellar.net
Cc:     Remi Gauvin <remi@georgianit.com>, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <3d-64430280-9-3e3db080@90317688>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <3d-64430280-9-3e3db080@90317688>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::13) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: cafd0862-c444-453d-a1d4-08db42bb9388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlX+zCat6B3uMZCTZ325oLTdFplvuJXxSchVcSjkF64hFHwYToO8vvl+0Q/PLiw4ES07Fxom84gME/5krqYuLRzgzNri2RTNe8DzP5fNcoBw/y3GWjMwzIh4U6l+sxGUCwoz9vjKDif3SIo9rXBJJrqtVBLOSC72tKD/Bz4KX9mSEgjDWvFKimcEwpvKveLJU6tHB8ndwU4XSSt2Lqy/KhEAm1540lD7o6gVXIl6XrYz2Woy6MTyoiZdlrQ6L/N7FN8mJQAMYXVxaj2AxQLL7OJGgguJ43w3+qez4q7UQquRgjHiVIfVW888qwnQvQj3dUSx8T3mNWH+ykD/M6HSpq7gbQhicuZoZGoJ8rCya1GPQjkmdAC196mVq3/XT7O68swXN5q7eoVPcYes1WFukwCoMRO0UWUgODhGLX3YGED1bNaXeztHJ5tCNF/a/VsrJT6lCyiolqGbkNP9ubEiKhhd0vZz+0z1jHjM95a5SKd6VypeS8mwx10sHxuQuikRoZUAYidfex6tM+iqdx5QuHHkgwZV+wR98umKvpF/pX23eJ14BZrYBtgnt69yTg0C8Lxwbjm4IX5kzANnzHHuL1Opd/RxS1gx6RE0srBHiouHRii52JHjC1KcqkmukidppxBqz+zZ7EpzuUnNbT8i9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(186003)(6506007)(6512007)(53546011)(6486002)(6666004)(38100700002)(5660300002)(41300700001)(66946007)(2616005)(66556008)(4326008)(8676002)(8936002)(66476007)(54906003)(478600001)(2906002)(316002)(86362001)(31696002)(36756003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRnUHRtM1pFY1o0ZmdtWVBIdXB6SjIyN1ZTeHBlWVZuaDk5RTFZY05iaGZK?=
 =?utf-8?B?U1BKbjB6a1dSOE95ZHZzZFdYdjZRc01VVEVNNW95VWZRbEkyalg5TG5XcVFa?=
 =?utf-8?B?ZVZNMDYyNzJjcHRtYndBaEJvLzNSVURWYmxPRktuVlVBZXlEaWR4V1NzalpX?=
 =?utf-8?B?T0ZFOUdZeXM2ZUNIY3BsdGpuRlpNWTJZckp4YXVZeGVraTY5MUJoazhjNkpk?=
 =?utf-8?B?bksyL0NnRFhPMFo2cTg0Q1V6YW9IdlljZzFDbGFscWJBZGNaaFE0cUtGTlli?=
 =?utf-8?B?NnBCVU12TFhTbWRpRXozYTlnQnFmY3dZTmlXQzg5Q3Z6dmpZbHpTTTBRa3dG?=
 =?utf-8?B?cTRDcFdTT1EvbUw2L0VtQS9LUkRpaTFMeHNhdUxzRWRsN3FxNU01VGlDUncw?=
 =?utf-8?B?dG1HMzBLd2JNLzd0Vm1Ibk4wSWtUYU1kb3NraE1JYWowUU4vaE9CTXl5OUxp?=
 =?utf-8?B?Z2FtK0taVTRnRmhuSHNGaXUwNWVaTzdaWm0yVkpxUE4ydkQ5MnhzSGMvdlY3?=
 =?utf-8?B?SVF5UnppSm1lcDVZSVQwTEJ5emVVVnNMTlVLSll5eC8xNmpwaC9JMW1Zd1k2?=
 =?utf-8?B?Z1lOdmpERTlwUzJGTjBvMExBQk1jaFFUSkNHUlFCNGhJL0FkaXhyUG1UcXpR?=
 =?utf-8?B?K3Y4K21FU3NOK2ZlL2czOUhvSHR3MWJzNFhhZ3hOb2l0UnJqUWVRR0Y5dEwx?=
 =?utf-8?B?TldLbU12TzM0Qzg2cXBuSEFiZHZBenNKVFRJandzTDZjbkppeTFCMElKRjR3?=
 =?utf-8?B?RDJOYkZnRlhYT3dLM2pXa1IzZ1RJOEI0U2VFaFZNZUYzVHgzcUducVJ5cmVk?=
 =?utf-8?B?Um9FL3R2MVFWaHBEc1ZLbVFrSDBZSlJVRU9lSzMwbk1FSEYrNkcrVGlteVlY?=
 =?utf-8?B?SG5pU2lXY0gzWmdiek1ja3JNaUZEbzJja1pqVmZHYWgxNklVM1BXRElWV0VT?=
 =?utf-8?B?T3VzcHQybmRtOGMzdms5UjBTMWRKTTdCNFpTT1JERDRwcDZ1Nlp6WmJyYWhm?=
 =?utf-8?B?bEM4QnBjc2duRkdMb2tIS0JSYnJKalIyOEt6RXIzTDc5UFBOTDBwTEhZYjBa?=
 =?utf-8?B?anVya0QyV21SY1JCblRrRGpxT0hwNEpkcnBuVVhHZGtUT1Zjc1NiTTErZGlq?=
 =?utf-8?B?NTFxNlJJVzM2WFVVbHdwbGFFZDB0VW92WUlXYlVyTGtDQm9UV3RNQ1RWOER1?=
 =?utf-8?B?S2ZINXJuNkpneWRUeUE0SGg5bXdrVWFaalFZSFZHUW90QlJUMGxhYnlVTVc3?=
 =?utf-8?B?aitieFdNUlFJdVJuMDc5QlpiYWJINGJaaFp1WXR6ekFPaTFZeXJpY09JRlg4?=
 =?utf-8?B?WGZnNnM2V1ZtTmxBTy84WVNsWVdGdzhsVDNXcWdMM1JXYnkxVC9YcC9ZZyth?=
 =?utf-8?B?dlZXUXBZVk1Ia2JjQjNQUk83d2xmRDJWakdLTzBhUUtzSTNZVFpGQlhzT3NI?=
 =?utf-8?B?N25Sb05EMkFRMENwTWQvNUNYNklZV1MzaWdNUjAwRFpHOWJ3YWppQ0luajFy?=
 =?utf-8?B?ZDBOYS8wNytxS216a0hzMEhaMGxIbWl2TWZYU1BnRWNzQ0RQTGs4N1VmNEkr?=
 =?utf-8?B?aGk4L1k2UjN2ZHFjUUdZZStmNDZwVmtwWlNUL1JWaVM2dnFPUTY3TnFmN0ov?=
 =?utf-8?B?a1Blamp6Tkt0UXFlU0xiZXNOWktzSVp5b2RPMitWWWF4Tk85VkhTZVhUVll3?=
 =?utf-8?B?eUZXWU5xQjN0QTN5bFkzZDZjRWhBT0dwMGhmYTJudXUzcnp3NmNuc2FUbGlY?=
 =?utf-8?B?OWtYVjBJMkJXQ2VMMnY1NkVDazBUcUdWMHBXM2ZSOXh6eGxRY0hCclN4Z09Z?=
 =?utf-8?B?R1pBeWdvdjA1dUtOc1N1VW95TFc2TmlmNTM4S2JsSzR3UjJyUTIxdm12Kzk5?=
 =?utf-8?B?NmdmL3RKL2hhZWhyOTgreVpDbUhUVkl0c0ViVHMwOXlOLzNvZUZ3SEY5ejR3?=
 =?utf-8?B?T3lHTlRDd3R3Zld0dEkvV3NVK2NFNG04QktuNFJSZjFiQ3BBWnJCbC9YVHNl?=
 =?utf-8?B?SkFzakJ3OEpoc1F4a2ZwUUhiUmdsRzMxVjRVd0h0MUp2R0dIenRKdVpGeEdY?=
 =?utf-8?B?MkdDZnlQenNuSlluc3M4NXBpbTA3OWdVQkRCWmwwMk1yS0F5ZDNYZEdpUUJq?=
 =?utf-8?B?ckxNaDNPbXQxZldaeHhyeHBMMFB2d0QySy9nenJLL2xWSEtRQkdqQ09ldHdr?=
 =?utf-8?Q?iojYt6/utK6MTW7sc8Ig9yU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd0862-c444-453d-a1d4-08db42bb9388
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 22:56:00.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdK/DmT/Nt+eFIr7Zk76iLAdqf309yXFMYELZRi1cvdMVSAfGBSSh9X2UD9WvJyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/22 05:40, joshua wrote:
> On Friday, April 21, 2023 10:41 PDT, waxhead <waxhead@dirtcellar.net> wrote:
> 
>>> On 2023-04-21 3:57 a.m., Qu Wenruo wrote:
>>>>
>>>
>>>>
>>>> I did a quick glance, btrfs_defrag_root() only defrags the target
>>>> subvolume, thus there is no way to defrag internal trees.
>>>>
>>>
>>> It did *something* that allows Nautilus and Nemo to navigate a large
>>> directory structure without stalling for > 10 seconds when moving back
>>> and forth between subdirectories.
>>>
>> Are you sure that it is not just files being cached?
>>
>> If you run something like find -type f | parallel md5sum{} on the
>> directory/subvolume you can see if it has the same effect.
> 
> It's definitely not ONLY files being cached.
> 
> I have a large array with 13 HDD's in it, and a total of 53GB of metadata.
> I constantly have issues with the mount time being so long that Linux times out and drops to recovery mode.

Then bg tree would be the ultimate solution.

> 
> However, if I regularly run `btrfs fi defrag` on each of my sub-volumes and the root volume, it makes a noticeable difference to mount time.  (Though still bad enough I gave up trying to have systemd mount my array and start my services.)
> 
