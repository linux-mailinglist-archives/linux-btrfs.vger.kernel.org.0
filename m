Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACA2158D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGFNux convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 6 Jul 2020 09:50:53 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:60788 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728961AbgGFNuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 09:50:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-exdOW2bKM0iwuA6ww89OEg-1;
 Mon, 06 Jul 2020 15:50:45 +0200
X-MC-Unique: exdOW2bKM0iwuA6ww89OEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCjQ9y+Gb2y85uEesAi/zSVAzlSybvSm2pPMJY9WzSG98dWa6vlk11doPzAJAFG09rbYcM+2Q7dJfboGtXj11L9Fg7XgZt4B/yI/NXQh2Ew+kU+hZZA62BPHbwSXIAS5fgwJ5E4ZEUy/DAs5cPVLOG0y/7rEXAyGPfI0Ygke73y4HlyC47lpw6rGuU4wbQnUAWcWtAF3TUFGrd9ieZMZkR2d95VAS++1+iouM3vT4MsbXk87pxWSqKJ/u2ZGOXZ4Ly0Kl5nUszY4I2MjtZSmlDuJyYg7NACkD9Y5I2bgiwlRCDfCNQ4l+v1aChzzKynxKC9gYzoUxfh/eibchP3Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWENY7R7rmM3DY8uDsIZW9DJRKBK1EPP/SUr/oshTl4=;
 b=eJOUvq9gZSUYHqF/8NO+FiBX+wl+mx/ikBeU8Q8afJXNY7Clb1L6JA0ZkD045Itv2O7riqegrL6krpRZVgN03ZqEAwH3d+XxPIS98XYTVoPlDdjvrtqL7QAHCymRkF3qMbt63s86qKLm4YbNpnPuZXKNK4qrReOYLaB/WsdlD/FTQaUjZYZO4ZSXvBadzXjFv2RjM37NpiaZLweRF7a5qyCCbd1La4/yf7jGUdMwZGh1+Sv4ST77JxEbqzckBRH6WfORw6nwO8MEXdCv1tBiBVDHVG9DNbJSYbKeaBXr5+3aWlg1h+NjVW6FlFtzDcT+VsOO2DdadZQeMIaFJ8dXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: knorrie.org; dkim=none (message not signed)
 header.d=none;knorrie.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3843.eurprd04.prod.outlook.com (2603:10a6:208:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 13:50:44 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:50:44 +0000
Subject: Re: [PATCH RFC 2/2] btrfs: space-info: Don't allow signal to
 interrupt ticket waiting
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
CC:     Hans van Kranenburg <hans@knorrie.org>
References: <20200706074435.52356-1-wqu@suse.com>
 <20200706074435.52356-3-wqu@suse.com>
 <9ca1e526-6149-c5f2-402f-6e7331ac02ea@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <8f742315-6f47-771e-234e-98d7428c2f5b@suse.com>
Date:   Mon, 6 Jul 2020 21:50:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <9ca1e526-6149-c5f2-402f-6e7331ac02ea@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:217::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 13:50:42 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad98e11-7ca9-41d9-4148-08d821b39428
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3843:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB38437AD88702470E7B81F4AAD6690@AM0PR0402MB3843.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HW0xKohGjV/lfcSFPeMC8bheqZtzPHYzQUrDloDqY7xeMY015nFFZLSK9s3qjfLTJiGxOivLCxKTVeyfz3Vuct0ZRJMAFjKogFqdQVQeyrRiiOQy+i7o0gTAj8l1j2ILmO6407SFhahvW7Vef8+XiMkZY4o575GH39Md+ojp1q/j5t+kjrKpYam1NYYjDlUPeNcHQh4kQamtlxlorB5s2iP7tA60O1guZ5Pq8EN+rNJKpb4irDj0a0tAX7qXA4XwRwa1VHCEg1giUt1XAny0Kw/WCNx9iU2egyrFlRGMKomYKT+rV1c1rUchcWSeMOFdFqpYKHr77SAPaWck2V2Re+XPntZw+RHDecalK9FXelVOQuCysAmyWE/tgUfbkSXODwje/DjzfIEX3T50lFUWwsHyJvmbZ5kKxOyOJ0QFXcIVe6IUn/YJqnXWVciy4ZT3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(6666004)(16576012)(6486002)(31686004)(2906002)(83380400001)(6706004)(8676002)(2616005)(52116002)(4326008)(53546011)(26005)(956004)(316002)(16526019)(8936002)(36756003)(186003)(31696002)(5660300002)(478600001)(86362001)(66556008)(66476007)(66946007)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qyJA9Z7c68eSPpR0HuuAmK80Ca7ytJ+YV+Ym9u3xGzt0kmHL43NDLdJCRhwUD3fsSAbEceyeL8w0FgeAIoJwpTCDOiLdcjh6hvUlK7GCH4eLosvsDYBegIngghZGoFdaXooqU7V7LB3uQypvDnzbMJkDuNTrs/OZCOaushBqvIGic/zGI8Z1XusUk/d5TKa3ngbvCH29glfU+tLmq1AzmtgHReDW1ukJE5yPSPz2uGGu5FqhBSmtEvlwtvUBTuRagz3nUI2j2u5WetFMeG6wU/lbYzxaSUcrTmE6pPJ3AgM64POfyS/hMRRhtiGD16rHJE2ad2k+G7ZL810r60LZ2eih/PMBTdRb24i3n92sTnB0HjAh3VUjqDENCbhUHtFDJLTXFKj8oKReXuliIgOEe3TPgr6PSqrTsVCPXOEDYzrMOscyYAvXxGb+dzYB/qnIF+b3iYhZ5e7rS+7NNqbYeG4VFDq/jSCabHei0OvNsec=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad98e11-7ca9-41d9-4148-08d821b39428
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 13:50:44.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HVVGY8Zt6nsvLP/MF2+tr+DK6sYui9sO4AkO72/VSLzZLrigIGTeqyXnp4P31nw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3843
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/6 下午9:45, Josef Bacik wrote:
> On 7/6/20 3:44 AM, Qu Wenruo wrote:
>> [BUG]
>> When balance receive a fatal signal, it can make the fs to read-only
>> mode if the timing is unlucky enough:
>>
>>    BTRFS info (device xvdb): balance: start -d -m -s
>>    BTRFS info (device xvdb): relocating block group 73001861120 flags
>> metadata
>>    BTRFS info (device xvdb): found 12236 extents, stage: move data
>> extents
>>    BTRFS info (device xvdb): relocating block group 71928119296 flags
>> data
>>    BTRFS info (device xvdb): found 3 extents, stage: move data extents
>>    BTRFS info (device xvdb): found 3 extents, stage: update data pointers
>>    BTRFS info (device xvdb): relocating block group 60922265600 flags
>> metadata
>>    BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4
>> unknown
>>    BTRFS info (device xvdb): forced readonly
>>    BTRFS info (device xvdb): balance: ended with status: -4
>>
>> [CAUSE]
>> This is caused by the fact that btrfs ticketing space system can be
>> interrupted, and cause all kind of -EINTR returned to various critical
>> section, where we never thought of -EINTR at all.
>>
>> Even for things like btrfs_start_transaction() can be affected by
>> signal:
>>   btrfs_start_transaction()
>>   |- start_transaction(flush = FLUSH_ALL)
>>      |- btrfs_block_rsv_add()
>>         |- btrfs_reserve_metadata_bytes()
>>            |- __reserve_metadata_bytes()
>>               |- handle_reserve_ticket()
>>                  |- wait_reserve_ticket()
>>                     |- prepare_to_wait_event(TASK_KILLABLE)
>>                     |- ticket->error = -EINTR;
>>
>> And all related callers get -EINTR error.
>>
>> In fact, there are really very limited call sites can really handle that
>> -EINTR properly, above btrfs_drop_snapshot() is one case.
>>
>> [FIX]
>> Things like metadata allocation is really a critical section for btrfs,
>> we don't really want it to be that killable by some impatient users.
>>
>> In fact, for really long duration calls, it should have their own checks
>> on signal, like balance, reflink, generic fiemap calls.
>>
>> So this patch will make ticket waiting uninterruptible, relying on each
>> long duration calls to handle their signals more properly.
>>
> 
> Nope, everybody that calls start_transaction() should be able to handle
> -EINTR, so we need to find those callsites and fix them, not make it so
> we hang the box because we don't like fixing error paths.  Thanks,

Then we also need to handle btrfs_delalloc_reserve_metadata(),
btrfs_block_rsv_refill(), btrfs_use_block_rsv(), btrfs_block_rsv_add().

Are you really willing to go to that rabbit hole?

To me, there are only limited call sites would benefit from signal
checking, while we need to handle tons of unnecessary possible -EINTR
errors just for no obvious benefits for other calls sites?

That doesn't sound sane to me.

Thanks,
Qu

> 
> Josef
> 

