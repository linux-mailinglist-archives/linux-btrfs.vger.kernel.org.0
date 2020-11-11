Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB62AE653
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 03:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgKKCVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 21:21:44 -0500
Received: from de-smtp-delivery-52.mimecast.com ([62.140.7.52]:33847 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731900AbgKKCVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 21:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1605061299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+dc2UeAzkaUEGgGxJS3PwKezdcSgfMy0mv9dSuca4hk=;
        b=cW5WDnEDfTxq0RIXcOl3yUsDtdl/xiIyaVJnC5gAMw4YZGzQRDz1xFGI3lSmiDLh7r/qwc
        VEAkIZL7zTQNf85dC/tojiG3XsWsUcvERrphyfHXM7AwR28C7EhP6G4M5wGTW2m3VaUBQx
        QrtenDq8TdV7BPed6K1BbHSB6dIC9B0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-OyhlrFiQMhGBYDANVlLNiA-1; Wed, 11 Nov 2020 03:21:37 +0100
X-MC-Unique: OyhlrFiQMhGBYDANVlLNiA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbeC41NQjqrPKu8OcoLvZRp6/rNRQ5OPspgoiUq52KhQXVhx6Ix1T9P1Vnzp6tHFJoIyiZrY742ETruAKpPGTxGeYH22znaGFI4vnajFNyN4MRIibIzv5rFFejtXRTAQ8hg0NBVOvW80+x+zOSN5Noa//7lNq1weT8HTa/TjDSiOS6TKnbfNOyaCuYseHvcUQzsXaWyjDJJqIV6NIwcPRCnHoklWj/n0cGTsqzYnIr1KV8XW+o7Rp+JLHacplVo38rV7MEN4IAc4nmD6CgPQqdSKpqHwx4zoUSdQUrG/b+9G3TBOF8cwY08DbfkipJIwp9kNTb4vqviQQYoOtlrmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Br9Puww+yb89GUUmVIziVHEapmGCuiegad1VbVi4A=;
 b=TX94xNiQgbjpicjIKjzEE3SEHTF39C+IjfIGiumaeBCLeX7ZGK8FrHBwS7TP5tHZ8qhZXAKgUR+0JnjqoPb54RGEunzMxkMx1Y5ziDeuk6pENI2l88KZp+s9AtIudL5N+wiudSgycimwD6fz2vOJyokksUNZ8OwT/qfaF279WRhR/UdamGZLjs82YFAh9FH+rIoBO6wXQaNr5xGjlh2GNFe8jD/EhoIX+W3AIFY/AjEj1LaTyBz8JnYnHFIEBy26CftEAWjOf2dUNMRzs5gzGSceD2D+DQvdlT/qkxiNhRYbNwl0juGsGqn1ML2yHF6Nlvo0i1pZ2ALBdyf45blCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 02:21:35 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 02:21:35 +0000
Subject: Re: [PATCH 15/32] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-16-wqu@suse.com>
 <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
 <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
 <20201106172816.GQ6756@twin.jikos.cz>
 <8633b9b2-42f3-4916-b252-c9f9a23382a0@gmx.com>
 <20201110145348.GJ6756@twin.jikos.cz>
 <22f2ce66-e586-f84e-caa2-f5176725b3bc@gmx.com>
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
Message-ID: <beb406ff-0dce-c6fe-bc3a-96a11da09ca6@suse.com>
Date:   Wed, 11 Nov 2020 10:21:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <22f2ce66-e586-f84e-caa2-f5176725b3bc@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0201.namprd13.prod.outlook.com (2603:10b6:a03:2c3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Wed, 11 Nov 2020 02:21:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b4f669-e573-4bb2-028e-08d885e882de
X-MS-TrafficTypeDiagnostic: PR3PR04MB7417:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB74173FD0F121654C098A0784D6E80@PR3PR04MB7417.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0l6/RitdcBg8V6YZ1yG7zpix1dQzgFMWdl2DAfhzXyqIBvcAIKz/xAeqFEA11Zl+eMfBZeHj1j08HLRjVDtnJYMZn8Fd616vWpzF1xnaVt1Y9zQpkfN/t5P9M3CNEgRXLEL/m1PVuqHeUbg+eaaaRpkdZdH8M6raYOS4cTBC7MgCA4euEZAZzcgyDAbyaaJq8BbE0y85A5kUjcxIo8TSJOJYa3bRwChpZUOH8VHWacxCTDDyH/tPUg3z3ScJQqIGNvFUQoyHvqEzM8o6M+M147rXrVnuW2OUh2eAoCpSwX/lnq+mfHK60WFhtMUyp1PExS/porsZ8dM1z6t2RgX3265C5uUH1FzWjlXAOqyJ30dW3q1Vz9wUj1iWWkCKhqt67udZu4bZryqMS9gvNzGyUIOvjhDkPKl/1S5CmDH1U2xw89bQgs+nsNM8vvj2hE9elf38l/aXqEaITG3T/gt0SKDshF8IlMvPegXXV7VzYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(2616005)(16576012)(956004)(8676002)(316002)(86362001)(6706004)(66476007)(26005)(8936002)(36756003)(31686004)(5660300002)(186003)(52116002)(66556008)(6666004)(66946007)(31696002)(6486002)(478600001)(966005)(83380400001)(2906002)(110136005)(16526019)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hembA9NK6ihePvtC9RaQCTuMBAGSlmVHLlpXLxKxcKht2sDL4wQqcS/0hmAHrxEy8/QP7R9i65Uh3s1xuUf4PWDCW4OqY4t+fp8HfImJBCcDPPQgGgHhQzbgBx7f7avVbg32z9SjFUUqTmgRgHj7o1GoZoPxYa1wxCobd0ckj7qfy0Cw2UxH7yOOCr0G8TrCxlKlMH8V6mXkKALkAvICiTFaHwaCYAR2t7YMrfVoMXQQv1jCsz/vZt3cS/TQ0K4NHb7dI+BuKVOW1fPWjh1pgS/fU8slofHz8GEuiNmID2GfxX1ExjdgcLtew0AreJIfHJLMJ9kFnw3iSWUsc4YvUwBnceINHaeYVgOnxGF8mOc4k770HlMMwuBOrtOfK+zjG9LmZ99OGbKVtYuNqYhe96C+tPFSJdJvZAU5B7lWYDLuCXzHjA8yRTbYAS8ELjJ+O0rdXAdPM5NRdzdCGsf2bZtX2tF9vvTxVkfQCwJakhKdcjqu5JbO/ie8sYyPBx4HqnVktDPUOmzbrk/3toeTIT6HBploG1ZRg83Knn4MRe5oUFQ6cc0wwFo3AI1s4hbZ8JP/k1BQUqdsNT5sBcJkh/Ri9IT3Rz39mA09xYSclUJ25Wq/3/WqzHTZNqTjjc/ubOCm3Qno1qGVxlJpPW41jnPHGrbvFfloz5DOXlqecROZGykEfq248wzKJwuvjiKDAXEpbbPkpHdy1KtaLiIZtkEGhDnfRWfpTy3phph2sWcVuNIkqkHkdfMkf5i2synAGQDLfSxsT/D2RFpLzY4QPgsK5EjGGQrhGnnt8GSVGYBsCoSZkbHzuQlIEzYEwWsM3Yil8+G/L3UU3A+Slq5lav6PaHNu+cX4NX6/1ZIxwXQlvVHoe4R85XH8HBzomxL1TWIU6wfimXlFTF5NuGosPg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b4f669-e573-4bb2-028e-08d885e882de
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 02:21:35.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fBPotSAdoq/ySItCTxuZHo/ridyY4sTGk8A4BbmKM3Ts7lErDilmc7wDNW9tQyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/11 =E4=B8=8A=E5=8D=889:34, Qu Wenruo wrote:
>=20
>=20
> On 2020/11/10 =E4=B8=8B=E5=8D=8810:53, David Sterba wrote:
>> On Sat, Nov 07, 2020 at 08:00:26AM +0800, Qu Wenruo wrote:
>>>>>>> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
>>>>>>> +{
>>>>>>> +	return (fs_info->sectorsize < PAGE_SIZE);
>>>>>>> +}
>>>>>>
>>>>>> This is conceptually wrong. The filesystem shouldn't care whether we=
 are
>>>>>> diong subpage blocksize io or not. I.e it should be implemented in s=
uch
>>>>>> a way so that everything " just works". All calculation should be
>>>>>> performed based on the fs_info::sectorsize and we shouldn't care wha=
t
>>>>>> the value of PAGE_SIZE is. The central piece becomes sectorsize.
>>>>>
>>>>> Nope, as long as we're using things like bio, we can't avoid the
>>>>> restrictions from page.
>>>>>
>>>>> I can't get your point at all, I see nothing wrong here, especially w=
hen
>>>>> we still need to handle page lock for a lot of things.
>>>>>
>>>>> Furthermore, this thing is only used inside btrfs, how could this be
>>>>> *conectpionally* wrong?
>>>>
>>>> As Nik said, it should be built around sectorsize (even if some other
>>>> layers work with pages or bios). Conceptually wrong is adding special
>>>> cases instead of generalizing or abstracting the code so it also
>>>> supports pagesize !=3D sectorsize.
>>>>
>>> Really? For later patches you will see some unavoidable difference anyw=
ay.
>>
>> Yeah some of the new sector/page combinations will need some thinking
>> how to handle them without sacrificing code quality.
>>
>>> One example is page->private for metadata.
>>> For regular case, page-private is a pointer to eb, which is never
>>> feasible for subpage case.
>>>
>>> It's OK to be ideal, but not OK to be too ideal.
>>
>> I'm always trying to take the practical approach because with a long
>> development period and with many people contributing and with doing too
>> many compromises the code becomes way below the ideal. You may have
>> heared yourself or others bitching about some old code, but we have
>> enough group knowledge and experience not to let bad coding patterns
>> continue coming back once painfully cleaned up.
>>
> Yeah, I totally understand that.
>=20
> But here we have to do trade-off call for page->private anyway.
>=20
> Either we:
> - Do special handling for btrfs subpage support
>   This means, for subpage, page->private will be handled specially,
>   while regular page size will stay mostly the same.
>   This doesn't touch the existing behavior, except one extra if () check
>   on certain low-level functions.
>=20
>   For subpage, page->private will be used for extra info, like various
>   bitmap, and reader/writer counts. Just like iomap_page.
>   This would be the "code quality" impact.
>=20
> - Do no special handling, unifying to subpage behavior
>   This means, we will allocate extra memory for each data page no matter
>   the page size/sector size combination.
>   Obviously, it would cost extra memory usage for each data page.
>   And if we had any bug in subpage support, no one can survive.
>=20
> Thus I take the poison of the first method.
> Also to reduce the impact, all btrfs_is_subpage() check is in some lower
> level function.
> You won't see much btrfs_is_subpage() check in some common functions,
> but all hidden in some helpers.
>=20
> I doubt if this would really impact the code quality.

The current example for such btrfs_is_subpage() usage can be found here:
https://github.com/adam900710/linux/commit/887779f8c0a64a6c7ad6f34911aaf88c=
9f6901bb

The related functions, begin_page_read() and end_page_read() are the the
main function to handle subpage and regular cases differently.

Please take a look at it to see if it's acceptable or not.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20

