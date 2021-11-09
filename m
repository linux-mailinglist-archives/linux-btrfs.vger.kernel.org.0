Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6236E44A00D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhKIA7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 19:59:21 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:57000 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236348AbhKIA7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 19:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636419394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FgTA+NIs4lJXwdQFMLOAGiLJoeDJ5opXt5YcoSiEdE=;
        b=fpvrNoe3F/a+SaUmII2ktC83kj5sldkvrc8hGNUuqjnSrpKYNS8OYRRhx7iXWX1yPFsvCm
        MkEoOLriC+JGkvUGVX52nJqN4UdiCmGuNA3GVvzG/eeIY9/GfQXJqyLIOdojVBhdg6Pko4
        ouzus1LBPD/uZBpPOYi/DDtZ2PcGD4M=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-mdzsBuwaO_u2Mv5dT2zeew-1; Tue, 09 Nov 2021 01:56:33 +0100
X-MC-Unique: mdzsBuwaO_u2Mv5dT2zeew-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G88gM/8fAct0gMJD7KhosiJ5WghifxD3wvQKi/6xUVZ7nrWBLXCl2zH51cGs1n/f+mvK2Z1NIYf7xBcwfaIWzNnIQ/NHaFUa0DoNTzoiRN8r2dcDHJyzleFdawsvjBCQggntJYQU2KUqs85bk5ob1bYJkpSXAJGxQAxAPW1BxJUb9o9KXCXkUOBcpdAWv2o1VBeddBfiyDWl2rr9BTS23z95ElRbbRObxES6R6/mY0ZYBt8zB4Jm4ynB7dtocoJSQDg1kYt7/ILFV5bwMmm30zrvDw2e/I88dG6SM98PzoaUj2rUbe/obDd+Nwt8YaZXV6poe6c71ozWulG1zIs99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FgTA+NIs4lJXwdQFMLOAGiLJoeDJ5opXt5YcoSiEdE=;
 b=MhVdOm1J4/jjNju0BfuCPONXZWgUzm0u/SRzaGSCr+h6eVRO1Zr9fT5jwbDVePkRH+NMKQgGVM4qe5qm4b97KavKFsROZQ8GvBZ6/mF+eWJMk8FjC3uSnA1HxNBkK+9Vt1XAgwsBYwO5ybFSINXcKPJTA9SGgYXUkeaOMYAMXBGJHGm2TnD32xRMLbLjdfFy4Ml27b+qk4562PKaowucUmBAmr0IkDxBkC2CtBCMMH6x1/3B3h9kZfBQrtOmvdisG8Q+uVH514+oQzpTvaWDV3vGmA4ZX5eDMMROoJt1grENa/raiKm5ovODNa5Tns11VK8LCexXolafy3erx1bPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 00:56:31 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 00:56:31 +0000
Message-ID: <1b783139-e769-9beb-1af3-a284aef543b2@suse.com>
Date:   Tue, 9 Nov 2021 08:56:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 07/20] btrfs-progs: stop accessing ->csum_root directly
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <9785c0745f91699cb45ab398d6a32b44645ace39.1636143924.git.josef@toxicpanda.com>
 <8a4a9842-fbc4-f652-d4ca-842ff63b571f@gmx.com>
 <YYl4SrAlHE44Os7h@localhost.localdomain>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <YYl4SrAlHE44Os7h@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 00:56:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f7b69b1-4a4e-4d00-c789-08d9a31bc4a3
X-MS-TrafficTypeDiagnostic: DB9PR04MB9283:
X-Microsoft-Antispam-PRVS: <DB9PR04MB928363C1611C6D3B6A91386CD6929@DB9PR04MB9283.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUpneykkM2VkobM/x7WDTYk70Kkg5t6y8mcJfz5NJ87gCmPKkCiIi3kB4LHhxABfl+05DKwfIHtfSTro00t5rELg4XVBErtR2yX7GjS9uSyavlNwFLgwCt6U8v33QrIVd3I53eWExQlmKTL7n+ztkSL1zrflbFAHkHRE5krrw2n8nP9/sLxmS+6uqtn2nQMMPVjhgkky9AY8AJUaDuvCcigB56x9r/3xXUZ4z2qdKU7VQVrniL50Qd9wt2krclcbSJOtgTjtmPwyymrWX/7MxeNqjJLOCFiQYpPWR07ON5Tzg9EI706DYLch+cys3vypz+IO6gbUqbdZUosvFmv4esjANrUaOmnikeJaNdZnc+ERWehaMpCwTI2UMuQ95fXCI126ea/D58UiUWC+VSkPICI2XSyDzCxRKxocJHNnmFfqWef512+7EsWg3kooWIZdfUBQe+2UCKm9Jv2sPMKSQd2zW3Ie6gOwWbtX3U0xM3rkd4H/+/BZbwdhgy5A7IXyx9joVE1pVIFjM304ptArspQpkUXXa0/2Qn5uEdCXlG3vByaIDs+PgWQxOZHqaR+/sbWdt2fZ8GO8Zdh8YAf68LSIHWN4FwaCHRuTRxQ66l7AOHEGO7+kNTLoQMlAFd67WD9V87fDCqAEhp+PtYuqEUJEa9DJ9eG8gmI6uZkCyly2SoWTQ2G69ph472jr/oYyI/R+0t5AaXMGayAYlVyXdb7L4uvCqFA/19Aj2NzJNUg92UsluKLRw2T/2V49nwse
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66556008)(8936002)(6666004)(66476007)(508600001)(956004)(26005)(4326008)(53546011)(6486002)(8676002)(66946007)(6706004)(2906002)(36756003)(316002)(38100700002)(16576012)(5660300002)(86362001)(31686004)(110136005)(31696002)(186003)(2616005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTNvNVhYNUZISEtaK2p5OG1MQnFQNmVlS0RsemViSGhjdUZ6TTZjaDJCdTMv?=
 =?utf-8?B?c29qSUlMTXQyQnA0bThZakUvdEZWQnI1empFUmxBU1Z5d09HM3U0U1ZvYlBZ?=
 =?utf-8?B?UVM3emRJeUxSYXd0VS80ZlErejVubmxnRXY5QS9CQW1zZmxVSnpXdENlaVpq?=
 =?utf-8?B?ajU2aklyQkt6SjBjZlpReU1ZYWRPdUJhSDhkOHUzaXVsbWdkSE1XNWZvVXZE?=
 =?utf-8?B?ZHl1OUxsS25ZcmFNV2tsM211NEwwb3Framx6ZlZpVHFwL3dsTDRqOHBmTzJl?=
 =?utf-8?B?U3YxaEtQSVNKR3ZJWTRzRG9EOEpRYkRFTHlHNEF2cnlkV0JOd1V2T2YreTdP?=
 =?utf-8?B?NmlOYVQ3QXgrWTFYbXVPRlptVk1SbUkyaG5Va05sQTFWNG9MSkdOZWd5bU9t?=
 =?utf-8?B?cHhFU1pHSU9MMUlyeEtwR2VrWUxJOFMxMjU2TlJ0MHptMVdKNUJMRVdwc2pv?=
 =?utf-8?B?b3J5OHJWWjRmb2ZLNW5QODZnRkhiNnpJcnpuMTJXMCtRQnZRMGdyaGxNcXQx?=
 =?utf-8?B?eWx5aHVBNXBJT0hZeEd2Nmg1eFNOWFM0MXhFNlBOcVhza2ZIU014ak1CdFh1?=
 =?utf-8?B?MjduSjZkdEEwMk02ZkUxT2lUZU10ZnlPa01hemRIbmJIZEtEd1FkUlV3Ym4y?=
 =?utf-8?B?QnB1YWNQeXVpVXprWW5PMVFZZURMbXVMSC9qanM0TjhDbTdSbHRnWmdKK2dH?=
 =?utf-8?B?Ti9nZkVML3ZDUmZtdHphWnhLTXYxT0NBWUhvWVp4VnJlLzNLa09wSmRoQm9t?=
 =?utf-8?B?QVZ6MURZMy84R2p0VXY3eHBlRklmT1YzQmRoSzBtY0hsRi9LU0ZhL3RVWURG?=
 =?utf-8?B?VFFlaGRYV3o0eVpDYWFmK0swYTUrbmp4VW1PcjJKOC9wVnVvSkxVWWpOdFRq?=
 =?utf-8?B?ZXNwZFJmQ2dqN0hPK3FpeW9Mb1hISzJBTnpibTFmRkFyOFk2ci9DTU1ITjU5?=
 =?utf-8?B?WXhTWW1jN2xzdEtvYUJQeEN1amJaMlRLQmpGTDVza3hiZzM1WWFqblVqSHZh?=
 =?utf-8?B?QkpWNUhySjNBdTZzbE5GTWZ2c29KckU1K3Z3QnhHTWx6ck1ZQnhyUGFnVlpC?=
 =?utf-8?B?K2I2WGo1VmZmWkVnNUFXS2J6d0xlYkYxS0V5Qm1wSWNJWWdwS2F0K2xhYm1X?=
 =?utf-8?B?cmJWaUR6eFVxdlp4YWIwTlVTRUVyRnBuazlNYXZwOFdqMmVtQitXanlLL3NG?=
 =?utf-8?B?QXlOSzF1Y09rTDBpNUtMK1g5MU5xYVpta20xbjJiNTdZb1V0cHVrRHlsM3Ar?=
 =?utf-8?B?MkwxcExXVEZTYkc3M0lUaU5QeGVTSWw1UWtOR0E2cStNUjd3aUxyOStFOVI0?=
 =?utf-8?B?REgrTkIxZXlURzVGSlNlbGptSDhvTTRMTWJsblhXWVNZK0FjOEZ5QTRkZTNC?=
 =?utf-8?B?Qll1cmhXR3hDWmxOTmFSRURsYmpobXVWdWJwa0xFZ2owUWJETnBud1ByNXNo?=
 =?utf-8?B?aGJGWklGaTRibDFmSEJZaVRKVmgrTDgrTHg1ZHd2SG5sVVBoRjBMd29WWHNG?=
 =?utf-8?B?YkVwZW9rbHlzdnhyVTlwcXlJOGdaL0VXM0Y5dHgxV01Ub1JRdUpuODVaTFh2?=
 =?utf-8?B?VUlUcHNVakhiUTFGQ2RJem8ybkdQQnBQK2xVVnlFcWd1V1VpdXhqaEVsRkhQ?=
 =?utf-8?B?ODJIQkxoUFltdW9UU3FydkhVbit6OFRwdkZZYmZuaHlYTEJTQmNqZ3psRGkv?=
 =?utf-8?B?bENCLzZpSnBPUEUvQnJ1bTR3WE51R0JQVCsyeWdqUTc3M1czd0ZaZzNBeFNo?=
 =?utf-8?B?c1JDRGU4S1R1a0UrVncyTUVGejVuQzRtMDdoOWRhUzhRNGtaNVJScmRMR1dK?=
 =?utf-8?B?WEhzRTNlUDdHcElmMHJ4djQ1VStQdVBGbVlEWWtOSzBsb2lFQzJzUnIzWnFQ?=
 =?utf-8?B?UjMwZUN6ZmFRaXFyUmVvQVBLTzhHd1pvZ2l6T2dscnFDeHZuR0RMaDB6MHVX?=
 =?utf-8?B?MVFMZisvN0VPMmpwbzRBS0g3Tzc5K0ZLRlFyVForeU8rbzlYQTJlQUJlNjlO?=
 =?utf-8?B?QlNYTEFIcG9OS1ZvNVgxb2ZDWTZ4clhMeWZPSVQ5c2t4T0syRVhzamlkN3RG?=
 =?utf-8?B?WDhwMjFEbU9La0JacTBtYy9OZWVwa2RGdjlQM2lYUVZMdHpneFFub29PdWFP?=
 =?utf-8?Q?Q2Bo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7b69b1-4a4e-4d00-c789-08d9a31bc4a3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 00:56:31.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/vmJKskmWcmTvXs6+6XfjyC1Q27arNPBkjYhmYxjcHW7TUlV5EARTiyducTYojx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/9 03:19, Josef Bacik wrote:
> On Sat, Nov 06, 2021 at 08:23:46AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/6 04:28, Josef Bacik wrote:
>>> With extent tree v2 we will have per-block group checksums,
>>
>> I guess you mean per block group checksum tree?
>>
>>> so add a
>>> helper to access the csum root and rename the fs_info csum_root to
>>> _csum_root to catch all the places that are accessing it directly.
>>> Convert everybody to use the helper except for internal things.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>
>> Currently a lot of locations are still passing 0 to btrfs_csum_root(),
>> which would need to be converted later.
>>
>> Thus it doesn't look correct to be in the preparation patchset.
>>
>> Mind to move this patch into the real extent-tree-v2 patchset?
>>
> 
> I explained this in another reply, but I wanted to talk about this specific
> style of request here as well.
> 
> I did it this way because it's changing a lot of callsites to use a helper.
> This is kind of a complex change as a whole, because I'm taking us from having a
> fs_info->extent_root to having a rb tree with the extent root, csum root, and
> free space tree root.
> 
> Once I get to the actual extent tree v2 stuff there's going to be a whole host
> of more complicated changes.
> 
> So, in order to make it easier to review, I've put this relatively large concept
> in the prep patches.  It's easier to look at because its a clear
> s/->whatever_root/btrfs_whatever_root/ change.  It's easy to spot check and wrap
> your head around.
> 
> Then I do the work to actually load it into the rb-tree, and then change the
> helpers to access the rb-tree.  Those two changes are contained and easy to wrap
> your head around.
> 
> Then in the extent-tree-v2 series I actually change the helpers to do the new
> crazy stuff, and then go through the places where we do
> btrfs_whatever_root(fs_info, 0) and convert those to be compatible with the new
> world order.  I do that because each of those spots is it's own deal to convert,
> so they need to be reasoned within their context.

Oh my god, there would be crazier stuff?!

I guess I need to check the design doc more carefully then...

Then I guess although it's not ideal, but it would still be acceptable 
for now.

Thanks,
Qu

> 
> I could probably move this around, but we're at like 20 patches per groups of
> series, so I did it this way to keep the logical separation as clean as
> possible, and drastically reduce the amount of complex things you guys are
> needing to look at individually.  Thanks,
> 
> Josef
> 

