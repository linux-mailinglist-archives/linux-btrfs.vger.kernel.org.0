Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D322A96FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKFNZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 08:25:34 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:43936 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbgKFNZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 08:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604669130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1Y03qqxS0gZeuRLMTBZMoW9UavmT9TT90amjRrF10Fo=;
        b=K3T+Wcv4GkoumNih2Ov2s9JIZLxEQks3iYyat4lVlklmEtZn1g3gScnIPEZ5H738X/cV06
        fD22t7pf5GpLmTDQaw19yQAAcHHUvq2ACVvEGAtx2mX7JnXt4yaRvvYNAsmVFoYelrVdcn
        pOa3OyNHDG5BymBfqnM4EAiASJgC5QU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-ACtvWt9TMj6nBK-URaXIaA-1; Fri, 06 Nov 2020 14:25:29 +0100
X-MC-Unique: ACtvWt9TMj6nBK-URaXIaA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIvpUMXKYwQKA50s8hGkjVkxKbJj+DMWP62wi9qb2klKU68EBteimXGJzyx1b3q546Fk+ldV6kyoyE9E1I/ouO27twtecEf/jBgMun9er8bBwEas1zXjl5LYYEeluG0BqZ4zmD7p/SGOPZqRp/ZC21rtVCotMwrkAHg+RiRoxI8WjGlQbqlf8BhHsi7xJhm2w4Ae1KgmSYE16J8mfUNDXCVuPCQX/otrw0UAJQgobqfSLtsj6k1urGJyulfV7GiTmaqU0qjNDvSnx6ez7XzpIy3BNtrMtde0T6NkcEhDtiig+iNTnI9IeveAievEEzgV2y1EhucHCQ1Slpln8KL6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzI3epNGkwy2Fg31eLgkPTmuQaFjrbHSAD97N/ZrnTQ=;
 b=lSp99hoKr5edEIzTBxlKdqji/i+HewJSUMRwCwaWi8/1EAluSMBskwJh/OEO7SewZ4N/Asl5In9aTW9nKdqsdNX+QtIz5WZX/80adZFweuenvsF9+jQ9wHf1Es5z8booHb/Q1KjJpoKYkcp6pjtu/FS/Y27jN624791OSMYzAcJm6hKgGgonTZLvYf8Hs3CQTZXBEGbvp/RrPOs1agDYcW80LBAbHl5i4aFR6AOpFEVPM+DhOvlBD+i7GjqqPuDJ6uF1kHnUVEJ9ylCdj79u7yu245JL2j+8XcqLBd4IEohuNqFX0JiuZZfBSD0inp+g7rsTV6hYhhEU/ii1/FVKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7483.eurprd04.prod.outlook.com (2603:10a6:102:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 13:25:28 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.022; Fri, 6 Nov 2020
 13:25:28 +0000
Subject: Re: [PATCH 17/32] btrfs: extent_io: don't allow tree block to cross
 page boundary for subpage support
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-18-wqu@suse.com>
 <bec6ae39-0a10-e4c4-8e4d-06577057e6f5@suse.com>
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
Message-ID: <981350a6-77f9-6419-7a2e-22110364a55b@suse.com>
Date:   Fri, 6 Nov 2020 21:25:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <bec6ae39-0a10-e4c4-8e4d-06577057e6f5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 6 Nov 2020 13:25:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d8120d-f124-485f-ee9c-08d882576d59
X-MS-TrafficTypeDiagnostic: PR3PR04MB7483:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB74831EDDFB99E512DF79CF72D6ED0@PR3PR04MB7483.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dav/ppW3l47BTrAWkauvjTcVbJ1ZDB1ixuRF5/MitixI6klm1bSDI/w2fnjwUcFx/wqGQfzaXNkXaALpurAgYp02I3hJ5sQsrn187pShcpsa++duadvtECA/wnNByNjQ81yeQpaA7avYxIhJjCy1BXgMqbMZPnu6ffJ+TbkX2V5CdwWtQLwR1odqzvQ2NHHNFhYU0nr1VbTCBc7OWWiQjFm9f+5gwGg5R44HqjeDcfcH6S+M+PAMSlP92Qpse+CDeUPWVDUlbegvDn7vviVHeoRxqK9wfGeqAVrHvMx+Xh24eyBcJEnqi1+VWC0ycwGeYefppsJwon9vPeSMsx1vytFtFDrwe0LrQy+8FPzPhNGs+2C2g+vB9gBX6n+z3mrtw2HzRTjB38/w8Agrr1tBMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(16576012)(316002)(8676002)(86362001)(6666004)(2616005)(956004)(52116002)(478600001)(31696002)(26005)(83380400001)(8936002)(66946007)(66556008)(66476007)(6486002)(186003)(2906002)(36756003)(5660300002)(31686004)(16526019)(6706004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0gqQKp1ViSJgNOJnXn+F9BvR3pp7rfW97KmYVv6Nj7SjGFUFzUhblSp8VdVBFuxqqOPGt8R3pAnjLUBf2uNrimH/21+Aj4vaOJduOfPc9NrKpWj9wZ3FvCkrrTAVYB8J0jBDvs2CkOAG5uFKKNL6T3PaxRdMUAHCqJFa4N1j6xtG97mVO81Mcxqz41zWlOGTEDMGgX0C0boOvwEihYHFu5qOPUNv+AWDU14MEgjTCBcC5Nt+hOIjgFA4zwFbzfP5THZfvG8jrq1zaMBK3z5qCPY5tkVEWIwiOQtZUsRPoRcTYNhRzdhlI0XR1R4kQwfOju1c2nH3KdA51F51XLnxqolRGzMD9La/pK+5A2r0DNMTw/HrZqAZys+SYoix6HdABW7/BxO+GNbAD3z6ZsmoSLhXlBw3zgxEabUWoY68mblpefDni4jsgW0sZzSLDzFLhlKmZWlv21FuCarVHHMBlfYh2KL3HS8y4omVLW3Dd2srro0M0bDEwhhSNEk4dYaGXXYQ1mGDbjkfLXYtJVnQokHeCMpYZJjr92EwimFxNelctHL7fKwCQTaBjN/mK6Nas83Ow6659rXxGMrKZM/BYK5JrfOJ+9tOMvx0xnvhfeh6Y03FzOjSrSLvD383gfVXdm2YrQqrkrBYDnMY8HQgTQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d8120d-f124-485f-ee9c-08d882576d59
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 13:25:28.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oiMmWq8BPBrGuf2O+W1Lf8OSdZCqtF7sEK8jBIZTOO1arsqTmkmzgbKV6sf9D6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7483
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/6 =E4=B8=8B=E5=8D=887:54, Nikolay Borisov wrote:
>=20
>=20
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> As a preparation for subpage sector size support (allowing filesystem
>> with sector size smaller than page size to be mounted) if the sector
>> size is smaller than page size, we don't allow tree block to be read if
>> it crosses 64K(*) boundary.
>>
>> The 64K is selected because:
>> - We are only going to support 64K page size for subpage for now
>> - 64K is also the max node size btrfs supports
>>
>> This ensures that, tree blocks are always contained in one page for a
>> system with 64K page size, which can greatly simplify the handling.
>>
>> Or we need to do complex multi-page handling for tree blocks.
>>
>> Currently the only way to create such tree blocks crossing 64K boundary
>> is by btrfs-convert, which will get fixed soon and doesn't get
>> wide-spread usage.
>=20
> So filesystems with subpage blocksize which have been created as a
> result of a convert operation would eventually fail to read some block
> am I correct in my understanding? If that is the case then can't we
> simply land subpage support in userspace tools _after_ the convert has
> been fixed and turn this check into an assert?

My bad, after I checked the convert code, at least from 2016 that all
free space convert can utilized is already 64K aligned.

So there isn't much thing to be done in convert already.

Thanks,
Qu

>=20
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 30768e49cf47..30bbaeaa129a 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5261,6 +5261,13 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>>  		btrfs_err(fs_info, "bad tree block start %llu", start);
>>  		return ERR_PTR(-EINVAL);
>>  	}
>> +	if (btrfs_is_subpage(fs_info) && round_down(start, PAGE_SIZE) !=3D
>> +	    round_down(start + len - 1, PAGE_SIZE)) {
>> +		btrfs_err(fs_info,
>> +		"tree block crosses page boundary, start %llu nodesize %lu",
>> +			  start, len);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> =20
>>  	eb =3D find_extent_buffer(fs_info, start);
>>  	if (eb)
>>
>=20

