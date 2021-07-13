Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C793C7981
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 00:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhGMWTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 18:19:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:49961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236133AbhGMWTG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 18:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626214572;
        bh=+53UVZGBNVA77nRwclDpNbCEwEHBqhKKB/u7K1SRy38=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jvSPOaUh/YRMjlowXk2u7dd9dYP8MoHqUZVB8V6b3yYIQytG9O39jWiIgWaP5Uw0o
         wtrUvG/O5oYpPL2rM5lyZR1NXZ75CbtfTjsyyEMJnjRqTh4+xs2HvUAZnbrfRf/Cou
         PDas2mDU2DN5wo2ISq0B1OhF9YSL4mCoCNhsMeYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5VDE-1l5iWv2MZu-016vl4; Wed, 14
 Jul 2021 00:16:12 +0200
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
To:     Sidong Yang <realwakka@gmail.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210711161007.68589-1-realwakka@gmail.com>
 <PH0PR04MB7416299F37110AAD9FC7131E9B159@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210713165444.GB71156@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2c0484ff-670d-5a26-0a96-e396289a784f@gmx.com>
Date:   Wed, 14 Jul 2021 06:16:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713165444.GB71156@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DOFPMmXHkSqE6aZsXc7x0chgK3SOFTQGF0icuRVyRRvRXwLYKya
 g6XQ7bmBLlZb7Co635bxi+ahXk7Eynx0RXETSiJyr1mAoWQbtM2Y+q/BUqjTFUOgJqDoSCf
 FRpEpBLeYvyRSf7tgE24hIN6Ppz7ISOSA1e2w24Kl9SRVDPS23CtyOk4vRoyKHX3emXP208
 OXiH50NdoBHlUIfvBFMLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:olLnS3DwQ58=:KWu4FUs6cQe5o7+mAZzN3O
 dDniijUgdO3iOCT4Yn0DWCsEHswjkMoc8W3sfGOrYG/pLyZcIvtqtKsb6AwReYQnIjr7uuQJF
 fWjtZGTa8AwjRzrtxKIEjdKEH0tulNvRGzGZFP++LGCOZEYTLoZR/AuBr37leQvBbOCY8HuSO
 iAOHa+BpsZBylLOBB2VXmMZB6rsIkgcqMNfqIIj1/js2KwXyNX6XGBV5a1L/+2M17c6RT1T1b
 Z53jEMF/DkQLrZVyJ/8ApP6ORKAjchbK6bFYdHO655EjL15Jn6PxGba7LPswWcXu8iVEyTurT
 GRx6g3j1DsKW1rABlQEPDdNzljYlDo66Zt24908SI2AO3nZXzEIxRoyJAJ6pCmdwM/WLoNGE4
 BQwcpmKhxYFlhqn5c+LEbEDVody5fXdsxi4dQ4llm24nt1hlBetN5YuTu5Mw2yTWYy7voCOxq
 wLbVpaltbbpRY4WLHrBmd/KPuJ7w3BXtoMUz9DWxpgVH+fNLLZ6iCrFOQU5ex6vyW7PMNichR
 eWNtkDCCe7mBvx6yGo/enAK4JBnlVzNnOe2gQMp6i/tKTTdPZrqDvwCAzusGg2bljqEHQ61he
 PI3rXoVUIgy+MIkEJS3pjWrT1q0nEqLuTgqoWg3aq+AzTXIbEDDe/pBoNqYIEJI9qlaYOKY/V
 EKlnqK78dKQWPRpkynGyNe6YwvyeR7K6blANbfvUfLlKjskLGR9aMWtjLgbnFZADvxIt6zthC
 RIpsx9EsUYIv/fwZNDniDyaj3czrHfhiwLfj7Ahal4+E3KCh1Kw3N24mkCH7/usW85BimQV/R
 u9E7QB638QhZrLoSeuORy0QslEPuEC6OOmkhhp4ABt+cH6irk7558dbxVcAzHWCnrl6YNAeLV
 5ee4vlqZHX83sHHYvEqp7khHLI6u4JOuKj/Mmu3W4s0/+74d5ppno0bpx9uTf41oymkYGfzl0
 rIjHAJidQ7rsGQZ8fjtCAgr3JrLwSOKCKHqiPzAU/lRjJbli3kpn8XTkENaruqXvSGSIl71qA
 yBgCaqNALdBkWDvH4+UBeDRih1QH+RDPoLLDG9n7KXR6gTeDlzSzmJhjQBYHp/USXccUGsqdm
 Da6kCQR+7bIkOvZgCB0nt0l7GQcT3nLbQr5m00DVX0l6yiHae6QpQYuvA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8A=E5=8D=8812:54, Sidong Yang wrote:
> On Mon, Jul 12, 2021 at 06:52:28AM +0000, Johannes Thumshirn wrote:
>
> Hi, Thanks for review!
>
>> On 11/07/2021 18:10, Sidong Yang wrote:
>>> +static void compress_type_to_str(u8 compress_type, char *ret)
>>> +{
>>> +	switch (compress_type) {
>>> +	case BTRFS_COMPRESS_NONE:
>>> +		strcpy(ret, "none");
>>> +		break;
>>> +	case BTRFS_COMPRESS_ZLIB:
>>> +		strcpy(ret, "zlib");
>>> +		break;
>>> +	case BTRFS_COMPRESS_LZO:
>>> +		strcpy(ret, "lzo");
>>> +		break;
>>> +	case BTRFS_COMPRESS_ZSTD:
>>> +		strcpy(ret, "zstd");
>>> +		break;
>>> +	default:
>>> +		sprintf(ret, "UNKNOWN.%d", compress_type);
>>> +	}
>>> +}
>>
>> [....]
>>> +	char compress_str[16];
>>
>> [...]
>>
>>> +					compress_type_to_str(extent_item->compression, compress_str);
>>
>> While this looks safe at a first glance, can we change this to:
>>
>> #define COMPRESS_STR_LEN 5
>>
>> [...]
>>
>> switch (compress_type) {
>> case BTRFS_COMPRESS_NONE:
>> 	strncpy(ret, "none", COMPRESS_STR_LEN);
>>
>> [...]
>>
>> char compress_str[COMPRESS_STR_LEN];
>>
>> One day someone will factor out 'compress_type_to_str()' and make it pu=
blic, read user
>> supplied input and then it's a disaster waiting to happen.
>
> This can be happen when @ret is too short? If it so, I think it also has
> problem when @ret is shorter than COMPRESS_STR_LEN. I wonder that I
> understood this problem you said.

I guess Johannes means that, if we support more and more new compression
algos, it can go beyond your original 16 bytes length for the
compression algo name.

While using strncpy, it will never go beyond COMPRESS_STR_LEN forever.
(Although it will truncating the output, but that would be easier to
spot the problem and then enlarge the macro)

Thanks,
Qu

>
> Thanks,
> Sidong
>
>>
>> Thanks,
>> 	Johannes
