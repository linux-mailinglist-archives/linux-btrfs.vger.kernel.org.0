Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9642C0A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhJMM5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:57:30 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:54675 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231516AbhJMM53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634129725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7eX72m+emFxIisRpHoMVCdKWUeh8R7rmRoO0B1Vr/A=;
        b=SykngGStL7LKAS+MlGAX100JyhJL4jeRRa6hA73H2UkEPsI1vT/hYWT7rVb9aFQ/41pgl5
        QzJfbF/HPwVERXd/Mu3i82G/fq1WQqTSoU9GqQRddJQa+dU4C9wgyJVoCMAanGxJfCHVeV
        Q8YAnYRgR7JQ/N5Vtn1evBlOkXi1CIw=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2052.outbound.protection.outlook.com [104.47.6.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-EeCApclTMU6K25zkHgraDg-1; Wed, 13 Oct 2021 14:55:24 +0200
X-MC-Unique: EeCApclTMU6K25zkHgraDg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4PSKhS2rENFR/mn2J/63quaBpbfNXMTV5pPtcdHXsKKyb4Hgb7nkEXMMCa4vfW9SIl3g3brus3/NTOESh9L95efcmsqxj4+3ZdRP388X1mw/563lPJ1umc3q85wAX8GOIYHlJQO4iBycelsrvZdTVXewXPLDZvpV4bY/FDGTtcyLectkMdSA7t5nQ0e3H8H6LACtTAFPuvO+X/BM6Mx4IOJsUB/MoTrnpMpeg0C7gOOab+0nd09q5YejBmPN1rMVe4IFwLZ9/2hlfxXxwv54om/Dk8i+pfGWt+jHZszyq6L1T9szXaOEx18TRj0BvHm21qrf9qc1nYheC/uofbAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7eX72m+emFxIisRpHoMVCdKWUeh8R7rmRoO0B1Vr/A=;
 b=H6APxc/27+xiel1vuyX0JYKEpO37jFFr+Wp5BERIewblyWI0tu1Qiqy1Q6qZXryARx9ebNvtuIQlvb7CwDP+bioCLeUe11ivxSJWso8GG9vCC/IOEunu29lZWk4lgsslUQ6hGICi2DgzqrbuwZxvLPCnpl9vziuj4xOETzcboU2pDaJFah//dWhJ8DG82DykseOzNQlhEcQ6S09togfBJtHxN3g9TKYJg3WEPcRW9A9H66SWnwKdR0l+bomn2Vb3ximdGk1A0b7WFXzm2c463oF7yL8QoR+dMaRsrh6XUr7qB5eEz0TvzsckYuXr5jhgeZ6CAgAivyFQGfRRz6gD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3333.eurprd04.prod.outlook.com (2603:10a6:209:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26; Wed, 13 Oct
 2021 12:55:23 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 12:55:21 +0000
Message-ID: <56076b9f-ced2-7043-e575-26e94db909c2@suse.com>
Date:   Wed, 13 Oct 2021 20:55:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: parse-utils: allow single number qgroup id
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20211011070937.32419-1-wqu@suse.com>
 <20211011132132.GH9286@twin.jikos.cz>
 <bf23e581-e03a-7254-b6d7-b9d67efaadc0@gmx.com>
 <20211013124226.GE9286@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211013124226.GE9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:33f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend Transport; Wed, 13 Oct 2021 12:55:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aa3c744-21e4-4a22-699c-08d98e48b719
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3333:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB33332D20FFA409E3D8D46F40D6B79@AM6PR0402MB3333.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpePoBVBHve8ZXGw2optehsBxrAkW6vfGYBVSIBNK3MpWsx6SG+bJ7p47x/8QyLzPmUe6A+9sNRQTrwg8+fDo+lqkQNXaHHkArCpmdDL9SURRLiB8PnT2JmPdKvjYRxtSW1H0HT//3p8AyQlSdwZhAanbaHKccytsP35e2MV+63YCgHZW8TOfjq35Z/SAwf7NS4q8Wy0pYLGhJIsmkP+7hUmdzJ1O0uB5cQRP2m4G7UYQNUF2iOaT7HAN/o65PQw6ufmgQubfOvP9XW4ZXcUxx7tms3cA3+upzsSI9cFgwpUu3a7JQ7couxbOqyXKrZroq19QIpO21sO7jbmTGsJP954A1pD8PA0p8Aoam8D8BgkGt4xQNBOrq8GxUQqr+oKNqe7zC7P44/G02F4PW69d0uJ26jOpVohprNuzeGNQzS1rI0LKYOK2pIdI0IKZCvpCAFqXdCObz5gDTeHKXDpBbFJe0ul7YZQCSXGIaOJlER1gnzgPGjymS7+rAEQnwCm5nfSUAF9UvccrICDYdjBwP1xKJdLE7fEASFM3GDDXj4ofscdNfrHi0pt9T3cHlRtfu44rpTPmh8kJLsGg6XJ6obftQq5oeDDe45MzSd1oG3dECOjXhbNeAfiUTo5vrhK1bGhQxfbSDArsmgAr3ZU2iPCAwv2KPSh07NMqFOtD1iI1LOww0STM77JwDGxHNkFOzbwHsalHIM7CLHa4T6XhRa70QI0iKbVk87YmvWERjiQ5/603NlpwEmxJ6eUGxRs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(53546011)(186003)(2616005)(83380400001)(956004)(26005)(86362001)(16576012)(66476007)(31696002)(8676002)(508600001)(66556008)(66946007)(6666004)(316002)(8936002)(6486002)(6706004)(5660300002)(2906002)(31686004)(36756003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5NT05DL25UVzJ1WCtrcWpFRnplSXBjYVlmTjI3SUdzaW9uZk9qcGxoQldK?=
 =?utf-8?B?b1ZWb1BEdldtbUprZ2VMbUNIL2QvNEJETTNGaDF2VVFUekIvQ1RnMzJMcVVw?=
 =?utf-8?B?VUZabk1hY3ZOV25wM1hzZTdxQUZTRnA4bDhmVllLb0dEczVEMjNEK2oxc2VF?=
 =?utf-8?B?Z1lORzBFSHVuOXhmRVowZnFlSldKRzlRSWFUZHBQSElram1oa0NvUzYzbTZI?=
 =?utf-8?B?b0FWdUZjelpGcG02eHQ1Y3hxcWNBbDdYUEdrYmdXaTdkQ3VLcHVtRzZTajBa?=
 =?utf-8?B?NkVpTzZnb3Z1TVRxcVVtTWhUY1hUb05wYTB1TW5WVFpLRGJrNFc1cXBscm4z?=
 =?utf-8?B?bm9RYzY5SktxbXpSbkhNT3dNcm1GVEF4a2puaWlBbG9nQkk4bWhvd2FiTTd1?=
 =?utf-8?B?V09jMnUrTGFEaWEyMUJMTnkzZXNZeTN5eXorVW5EOWNLMElaem9nWWZ3UnB6?=
 =?utf-8?B?cFA0dUdOeEJ3b3NYTFhkTis4cm1mbFdRMkczcDVJVW1ZcTViWWxpMmh0cC9y?=
 =?utf-8?B?UjI1TW5sNG5zdjl3NGpHMks2eTR0N29zYmV6UGo0VVJFaXVEcUE0TnYyOUNI?=
 =?utf-8?B?RE1ZTkRzNmxSTmN1cjJnS2p4OC9NZGhKdmwvSEVzdldHeklQeDBBWWkyeENZ?=
 =?utf-8?B?YlJzN0N2NldqSUpjT1FSYWlNbnlDT2dEZkdwMWpMNnpYL0xDVnV3TG5PVytX?=
 =?utf-8?B?dGFNbDBFeDIrZGttVjJMQXJKYWM4bVZCODc0TEJlKzR2cFJYVk94TlpHeUUz?=
 =?utf-8?B?L2VYWm9Dck0yMUp2RUpETmo4bS9RUnFWbUpialZKWVh3cGxjcUo3SXpuQUZa?=
 =?utf-8?B?MlhUazhDM2I2eW94M1pLVVRUOUlFUzduRHVpSFJUUmpuV0RWa3lFNENTK0lh?=
 =?utf-8?B?UXVMZmdsci8zTWxlRTBpRTA5c0E4a3JFZm9mdVlXcEIxaDg3V0JadWtEaWZO?=
 =?utf-8?B?M292eHowZC9KKzd2ZmlQMnBwK3lLdU5ZNGVsSlI1L3dhQjBDcEk5emg4bXNR?=
 =?utf-8?B?TDNNR2FGcFlVOE1vUU9iUmF1YnVxeEJiSTdqRWQwdkdrZStnMVQyZkN6TEdO?=
 =?utf-8?B?VGd5SU5rN2orWU9FcW5QNksvdEZUeW5lRUI2eWY1U0pVNDMvOE1ucXJHdTBq?=
 =?utf-8?B?ZGI3NGFDV092ZjdJUEZFOW5qczZrTFZXcFY4NUpzSFVKaERDUUFqUXhLY3JE?=
 =?utf-8?B?N1Z5ZVFBUUYvMzErT014clc0Ti9zcGNackRZMzFGdDhBemtzWElKU0ZxcTNt?=
 =?utf-8?B?ZkxVTEZFYkloQkhlYTNPbGtTMGlFS2tCZW1nb2ZJSm9pTFg4NGcybm40QnV2?=
 =?utf-8?B?Z0Uzb2xPSTRJN0pvdEFCWi9WK3RPbWlIeS83c2dndzg2bEdIQkdMTWZ4amJZ?=
 =?utf-8?B?T1VlV0dZZ1R6VE00RG5WR1QwN1FJSGpWVGo3U2Q1VytSYmRFU3JTUDJKMFVn?=
 =?utf-8?B?aVV2UVB0Z0JJVU16K3ZOR0I4SU5ZNlgwNmJyR3k1THI2a01zbVorbUZ4c3lu?=
 =?utf-8?B?MUNZSURXTWMvMWJuNEVBTXlwSk1TODZBUFdTNy9QOVBUUEp6RmphcEhLZnVz?=
 =?utf-8?B?djhncElEenU1TEs3emZlUnlvaWlJQTJmNjVlTWJJODJYZEU1eXV6aUp1aWJG?=
 =?utf-8?B?a3lJTnFwcERFV3hYU21jQ1pKcHgvNUVTK0liSHBkNU1kMTZkTDhxcWRWTVJB?=
 =?utf-8?B?WkZZWEJIM2x4bWpZcnRXMVlnVjIwQVJiOHFSQ0hKeVBFcDh1Q3lLZGl5VlR1?=
 =?utf-8?Q?BEufYLMd3Pe9j9Y/1uOS7ZhO8x1hPlxgbGP93RV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa3c744-21e4-4a22-699c-08d98e48b719
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:55:21.2730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGSICfBJYDyWGx9Hdc6F4fQdQsKkY4w+ssUW8OtBqD/kmJAj/FmRTtjxci1tepm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3333
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/13 20:42, David Sterba wrote:
> On Tue, Oct 12, 2021 at 06:59:30PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/10/11 21:21, David Sterba wrote:
>>> On Mon, Oct 11, 2021 at 03:09:37PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> Since btrfs-progs v5.14, fstests/btrfs/099 always fail with the
>>>> following output in 099.full:
>>>>
>>>>     ...
>>>>     # /usr/bin/btrfs quota enable /mnt/scratch
>>>>     # /usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch
>>>>     ERROR: invalid qgroupid or subvolume path: 5
>>>>     failed: '/usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch'
>>>>
>>>> [CAUSE]
>>>> Since commit cb5a542871f9 ("btrfs-progs: factor out plain qgroupid
>>>> parsing"), btrfs qgroup parser no longer accepts single number qgroup id
>>>> like "5" used in that test case.
>>>>
>>>> That commit is not a plain refactor without functional change, but
>>>> removed a simple feature.
>>>>
>>>> [FIX]
>>>> Add back the handling for single number qgroupid.
>>>
>>> This unfortunately breaks something else, as it's changing the whole
>>> parse_qgroupid helper to accept single value id, which is also used for
>>> 'qgroup create'.
>>
>> For 'qgroup create' I think it's OK to accept single value id.
>>
>> It's a handy shortcut for '0/<subvolid>'.
> 
> The 0/subvolid qgroup cannot be created manually IIRC.
> 

They can, even with current kernel/progs.

Thanks,
Qu

