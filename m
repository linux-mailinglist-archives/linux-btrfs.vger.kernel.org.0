Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411E041C2AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbhI2K1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:27:09 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:45671 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245324AbhI2K1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632911127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrkwmNogxBqRpk3UVpqO7gkh7giwHR8L64sQyFhT9wY=;
        b=NhE3Kte0tR1wDCA0f0akmdp//QE3t1qUXKBnADDHdenyzkbEs7wXba6Q0UuMIQIP4K+BYv
        mnWwgauuOSmGDoN6pW6RE5UfKYeXDyR8gWaKspixhur5rea1qyCpUME0d3aAyq7Z3Diwnj
        5f/rMOMD2bqZyKWb/CEeV5uLcJOjM18=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-RGA7HwoONrmSlc2Z9Nperg-1; Wed, 29 Sep 2021 12:25:25 +0200
X-MC-Unique: RGA7HwoONrmSlc2Z9Nperg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVYHYervZB+wtpaYBikMzHcNdKQ2JWoIHNWGVAG7iZ00Ak9Tv56sMcogmqT7Am7HaR4IqESteczMed+q+WJa47OkYqxSi/41C7rw9rjNS3po3D+onlX7zHCb7488DRqhQX/zARKchdp5FVhFj5YpT0PISlnOr/vzLgdd7lU1+1nS3GJTzFTccu5V/upF5inhuddYBejUxsSHbmwoWFJFpqnX5cCcuBkN5vyRGByVsmGczoWZ5k5Mf71nbTGOkpEnoN0DQKhxiGZreopYCU3u9nr9ssyZlTnEqm9xXCbBIx0pfMLCuzSIa4ZBcfs3CRErWqdk9MwlHIenpZHo2FkXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FrkwmNogxBqRpk3UVpqO7gkh7giwHR8L64sQyFhT9wY=;
 b=dNNedMx9+IL4purFrKMyRDmhppg6u7ja9P/R74NOGYA6T9wVtX1rIxl4xtiUHQD0LwhGge5pd7OYcaf6JhoWfueDe0RZU62OtHQRQGrbYcGztOD0y13jICMhKAgVtGrz8Ldi/DAaclLg6jyNkvFrDqyV70wHKLWz4cTmLDa9MewOFMsIQyrYrPcohJgk7/Q8Q31BWWeXKb6GH8XA3hg++z3G96DPdKjHZfshtCFxJabYU2b9SbxxZQ/q0mEWpbQYkiUb7Gm/mh7h40MISktwZzKCps1I7XLh5HZG1dzqaBhfcdb5PWvJJ0+DIRDEY2LA8qFPHjPjXWVNdc1LV9ByHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5702.eurprd04.prod.outlook.com (2603:10a6:20b:b0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 10:25:24 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 10:25:23 +0000
Message-ID: <bec618cc-4373-9fd6-b34b-683c565772c9@suse.com>
Date:   Wed, 29 Sep 2021 18:25:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH RFC] btrfs-progs: receive: fallback to buffered copy if
 clone failed
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210928235159.9440-1-wqu@suse.com>
 <CAL3q7H4OqEpAEWhGUH4okvOedhdK0dChYHdJkYrv-1vsAqKAow@mail.gmail.com>
 <99b58a1c-7cae-5311-1747-d51c4b5415a5@gmx.com>
 <CAL3q7H7doRb75LRJGbuyEJu5V+DDhaq8qytWTnYr1wQ7Z-b_yA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAL3q7H7doRb75LRJGbuyEJu5V+DDhaq8qytWTnYr1wQ7Z-b_yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 10:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2f4372-69c5-4996-f65c-08d983337282
X-MS-TrafficTypeDiagnostic: AM6PR04MB5702:
X-Microsoft-Antispam-PRVS: <AM6PR04MB57025882952BF89C1846A248D6A99@AM6PR04MB5702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JXHBQURO4NG5rNO11cEUCIjkRWhpZ0LOnL7EbgTLYawh6SOjVSNnQ6jr/ahz+7d9QRhFbQ6zXPNDvEvEh0UCXS8Rl5sPiISLdnqZEWHchJ/85i+7DwdHoaCskZJBRKUIUBZdyS2mj9BNK+Ws6+yvJygVSFGNbAWCp07oIj8s+qCQrqR49l3L/2DxIYUwlL+dLZkCkUCHVjHCQE/hztk5c1Co4H0TeN6H5oQ3CThXkp0nsP1j2x/6qJpcsx998/NQXXnHgktqYR00ATb6vaBLDfjdwwV6SIGYAO1oc/WXUF+/mKe9aqpr4qqjDbGi6NWFK7IKhnfqMi5ULgPlaAEvTHxBgDGvn9ghKY2XOn++wmdDoHLcdSKQF62+E+5SEsrgz7oUtaQ5H37GSwisiOFBdVGYgOIHOct8Or30DqR2mcVStBgjwQBb8xd9Y1eErAKIosmi8sbnahKLabn6qyrbZnS0fRSl9iqsqW8yfGd/Qq23PL94rEFNzSHIFOlISHeo+WfdcZZCDonpNW4FLVMyU9NTu1yN7xrbazMJgYfLCjspSYz+nGYobAg3CpjmY/SrmzlsZm+gXDRsNyxO/ikJq5zptk5s7qGqsZ1mmMQUsVIcdSJRjRkKfTiSARDDnWa0mf1e7kczjU9w9GQP8jbpXtnSKNAm3+NTEjcM63iM39ny+PakATH1rAyy1ribwSyMVQgC5ZSVOgEFCOeLEPAL1taydWOWPt87BkjqprIeyjZUeBinZ9z9ZJ77NGKyGAZw1AQXJqFoIXC+NcJZ2HNYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(83380400001)(2906002)(2616005)(956004)(6666004)(31686004)(8676002)(508600001)(53546011)(6706004)(316002)(36756003)(186003)(86362001)(6486002)(5660300002)(66946007)(16576012)(4326008)(66476007)(38100700002)(31696002)(8936002)(26005)(66556008)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0IwVTVjYSs2b21XRmNIU3JhUTF3bU1lNTNyQ3hoSDJpYjhUaldQbk5xOU5U?=
 =?utf-8?B?Tnl0MisrRDRIMW1HUVZwUVNQSzVTVFZMU2RsU1BOSkVoem9hZElvSWV5amlq?=
 =?utf-8?B?L2tEemlRa3ZBWW1JYUxHbDg2ZW8zODlsWWx5bVhtSjhkaXhnQ25DQ2w2c2My?=
 =?utf-8?B?bnpOQ01SSW5wU1lYVjc0aFpMVlVZQUF6OEh3dEhHS3R6ZnFtUWJpWGF5T0FT?=
 =?utf-8?B?QWg4UXBFcCtabXJLUHVZR1NqZ04vK3VIblNrQiswcklvR01MaEdwbWp1U0t4?=
 =?utf-8?B?UFFGQzducnFSUVdLUlhTUE5DcUp6cVBGMVdac0hzTm9kVmcrOFd4eWNBVVZT?=
 =?utf-8?B?eGs0K0t2b0p1SlNiK3ZlMUo0WVplT2toeHFGTkhnUUp6cDh2bUVRRkxOb0s0?=
 =?utf-8?B?Y1MxVVRDWGsxMTZFclFhUURXaGV4NHVQOEN5YnppS0E0VDlTWkVSem9nYTJM?=
 =?utf-8?B?REFYZlEzbFVxR3lMV1hCUkVCWE5wc2hjS1owQ2F5cU93QUNDUXRkcDlQS0Rz?=
 =?utf-8?B?YU9ZU2V6eDNJWGJBRlN3WTJlNGxxeWpnbENMZC9XRGh4ZFU1ZlBRMHFNa2x2?=
 =?utf-8?B?bFRTSW91Ymx0Q2hrOUpvNXZPaC8vekdaallmbkNBbUFGWGxFZVdUU0NSTG0z?=
 =?utf-8?B?a0dWeXpkaTV2NUg4WXFRb2lzbm10QmtFN0wzY3h3RTE2ZzJybmxsQ0RkUWhY?=
 =?utf-8?B?V0w5YjdOSi9ZSnhwSHhGRzdOSUkwSDlaMGNFakRzZ3B6blhLV1JuVCtPam9q?=
 =?utf-8?B?Wno2VU92N2thVWxwV2ozWXVaYzVXZkNIMlhoekNUR25GbU9zWGYzdW5RZ0ky?=
 =?utf-8?B?OUJjV3hKbUFKdnZkc0NnT3FQNDRCb3VJSnVabTZSczdEM2lxMVdNQjZzTFUv?=
 =?utf-8?B?SVl3T3hMdlUzMHlmVjI2NGhpQVRhWnZaMVUxZ3J1ajVlNC80NGUzbnlkYXZL?=
 =?utf-8?B?SkwxZGNhSzFUYXFzTi9IVXdCWDlRSWxFMUlpZWZwRTFMYTBtWHlxQ0VtcVRC?=
 =?utf-8?B?UE94L0czWER1S2dtNUFjczV1aSt4NlB2R2dnNEs5d2xHbm9RMUFjQ0pPWjFT?=
 =?utf-8?B?Q2R0OVExQkFmMnRNNmZoOTVvQXdDMXRLb3BhQU1CcTY1M3Bna1VCaVFSVGIx?=
 =?utf-8?B?SmFZODRleUdIQWloNE1kaXdkZ0JtR2M5WVpWZlFWa2tqNUhnbkZqVnJtenVs?=
 =?utf-8?B?MkNEaWUwWHhZNHRBZmpvSUNVaVZLZzRwQlFSRUlTSnR3OTFhUS80UU5TajBu?=
 =?utf-8?B?QllZSmg3c21pcnBDOUpGNFRXelpjenBjY3J0RUgyZFU2dk0xeWRBK1Zwc0R3?=
 =?utf-8?B?cGRjY3Q0bnRmQm1XWVFDN0RHVjNDRTBoVXh2L0l6WkhGbTBZUXhnK3VtUk1O?=
 =?utf-8?B?eWZRSzRaVWdIWTZlcmxkWUZUREVrc21xVjhTUm1vUHh2bVN6R0Z0OXBVcktU?=
 =?utf-8?B?TllNL1o4SEEvYWFyNTR3UVNyS2JVT1RMekt6anpBNW55T2lad0VvRUFkTUVG?=
 =?utf-8?B?blJJN0hNM3paQzg1VHl3N2txV2htRXBZOVVrOGV6aGJWQk9VNWdwMlBhckxq?=
 =?utf-8?B?SFNOWTIwT01TeGgwUDJhNTlsUFRKc3NpaUxYVG1kdUpCSEV0TEJYVnkrQUNY?=
 =?utf-8?B?ekFzbFRPK01TaXFyZC9RUm0yZHBMMmZSejU0OXorbUx6bm9qT0VVQzRwUGVl?=
 =?utf-8?B?cFg0b1dTTE5OLzVRSzdxNEpHSnArVUZKSUFzVUFBTTdDdHNIakU5b2t3bS9L?=
 =?utf-8?Q?RwAaN8/dhuXNOTas1V7cUd1ULu7bAkUEr6KhMby?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2f4372-69c5-4996-f65c-08d983337282
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 10:25:23.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPUasdrTDdx5/I0TA1PaaMAr0ArNZunUTfkVwUlHYYfiKfEEEkK9Xem0cj+/G0nw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5702
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/29 17:59, Filipe Manana wrote:
[...]
>>> Normally we should only exit if errno is not EINTR, and retry
>>> (continue) on the EINTR case.
>>
>> For this, I'm a little concerned.
>>
>> EINTR means the operation is interrupted (by signal).
>> In that case, doesn't it mean the user want to stop the receive?
> 
> There will be plenty of opportunities to be interrupted and still be responsive.
> But ok, you can leave it as it is.
> 
>>
[...]
>>>
>>> What if we have thousands of clone operations?
>>> Is there any rate limited print() in progs like there is for kernel?
>>
>> Unfortunately we don't yet have.
>>
>> But the good news (that I didn't catch at time of writing) is, we now
>> have global verbose/quite switch, so that we can easily hide those
>> warning by default and only output such warning for verbose run.
> 
> The problem with this is that it will possibly hide future bugs with
> the kernel sending incorrect clone operations.
> 
> Having this fallback-to-read-write behaviour by default would hide
> some bugs we had in the past on the kernel side, and unless users
> start running receive with the verbose switch, we won't know about it.
> Even if they do run with the verbose switch, some might not notice the
> warnings at all, and for those who notice it they might not bother to
> report the warnings since the receive succeeded and they didn't find
> any data corruption/loss.
> 
> Or we might start receiving reports about send/receive doing less
> cloning/extent sharing than before, and we won't easily know that the
> receive side has fallen back to this read-write behaviour due to some
> bug on kernel.
> 
> That's why making the behaviour explicit through a new command line
> flag would cause less surprises and make it harder to miss regressions
> on the kernel. And add some documentation explaining on which cases
> the flag is useful.

This sounds indeed better, handling both cases well.

I'll try to add a new option to receive, maybe something called 
--clone-fallback.

Any advice on the option name would be very helpful.

Thanks,
Qu

> 
> Thanks.
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> That's one reason why my proposal had in mind an optional flag to
>>> trigger this behaviour.
>>>
>>> Thanks for doing it, I was planning on doing something similar soon.
>>>
>>>> +               ret = buffered_copy(clone_fd, rctx->write_fd, clone_offset,
>>>> +                                   len, offset);
>>>>           }
>>>>
>>>>    out:
>>>> --
>>>> 2.33.0
>>>>
>>>
>>>
> 
> 
> 

