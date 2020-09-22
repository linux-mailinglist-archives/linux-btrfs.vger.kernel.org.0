Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E930B274D2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIVXRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 19:17:18 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:32397 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIVXRS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 19:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600816635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=D3ebVKDUtlt2U1CQylJx0Tzbnawpr+mvBp/vp1mpDsA=;
        b=aspowW+D5bxtezm8OyNcBxguDRnMWmDShbCHj3jM1Tnz0PqVkR87u28+r4zCpSF8w9c6iL
        jM17FYBpeeeK/un9r0reu3M4gE67q19J/roAAx/GaU0ZtGloSLP2ANT00AyaUiirJt0DfW
        /uH8KMkhBux45Lmx1JWF1S6g2pPriqA=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-WjneE87lONeSxzFnB1SJ8w-1;
 Wed, 23 Sep 2020 01:17:12 +0200
X-MC-Unique: WjneE87lONeSxzFnB1SJ8w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIhBUiLtTJd4zXNLxCexxhErjXwy5Izn+ZCARa7JZ1fgrvZ8VvYNaf2J7kaeoDTzSzq+1vOegx1MvxLwvGmAk9IMq3J0xSNTVwgSN3xao7QGdLg1slb2u33xHKlWMjEeyAs1Ahct/zWVKlUs0nETp+BO9m7yPW6TTI2dy3REkB8/JY0aa6LHelqggnpIxWJC/r/YwTqKpnl5+mXluaHx/XbEhKGoQnmf07h/RWo7b1+rNhVDE02a7Ej5Oj1CSqcXJkRoekWK1IyaBsPat9WLaFz2GBVZNSYeB00jTm9WluCS3s4QOCU602dGlIRnL3BH3vH0HgmQEj5iHyss2qGoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNAZlKjaMSTmOV2H+vt8AactlZUZkyUbShBPH4ycQns=;
 b=DN8IJlsphRPBNyKUlb5rmcN3iebLu2FnEPnbQwYqqEC41EYA+1Oz6FlcRaBLfAENNBlNeuyUm3Sy2RZUc/sKUuVxIXb1pYDzpjprV77GgpmyosA4NvAsJGr5ZCFFqvbKuGoOc+cqy7zeGglyFXA8hbtUqqthLpLvgLP/fp70k7fXn93K3kynnRFTn1aqS1yrnUek7nxdQj9pN+ZjLOe7+UFWYpTjbWTW2twBztbJFPqQkn5gjLm6olSwjuWh0235AjnJeMT35zdMS7Q1oVSwJNf+4Gi743sOGdBBpRRtOhTN9A83qt2dk0EayqmQBV1Ek9rQrT7Fmtef5aB0gj+3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5939.eurprd04.prod.outlook.com (2603:10a6:208:111::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 23:17:11 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 23:17:10 +0000
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20200922023701.32654-1-wqu@suse.com> <4591966.Q0mfgpEauH@merkaba>
 <6db35b15-1f16-dfd8-368c-b03e428eba08@gmx.com> <8998433.IpVEtotQbC@merkaba>
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
Message-ID: <ec3a5769-a847-6b3d-d502-b96c053b070f@suse.com>
Date:   Wed, 23 Sep 2020 07:17:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <8998433.IpVEtotQbC@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 23:17:09 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a836eed-0332-4de9-0d58-08d85f4da1eb
X-MS-TrafficTypeDiagnostic: AM0PR04MB5939:
X-Microsoft-Antispam-PRVS: <AM0PR04MB5939AF9A9EFA83BDC9AEE002D63B0@AM0PR04MB5939.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPp9ZSGeg/x8hToUvSlWcKFTV9eGyaIGpJtYciVVwOJVyGVK5LojDDaI1keOtzkGeL+4BCXs3L0WSW5nxOm5gU4nSiuJYvbRTDXNoCSif6kSBiSicUBDaoMSOhWc5sutNLhJ1I6QFTF1N4aygVnALI0othd23wI/ueAEQLTNpHJmZfiTor1ZnKvzdAgD4mxkigrIvsZfaBHBbq5o3effeXCFmQnO6M2N5EcFoKP/d1RBVWRi3EDkAAsJvNxfbWvTF1uxwY/ns48H4vZSkuWz/g0HydvS7vg/yK1p45mECOt+ie7MzepcW6H6Qun2NFarvLuLFvdgqOV7UgXswiyUIDp3uUugBfrselr00KcT6QPLTs7qz8PBZROoDB9e/LmUrlZi6sMRK/k+RaC2cOLpvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(8936002)(2906002)(8676002)(956004)(2616005)(31686004)(6706004)(478600001)(66476007)(6666004)(52116002)(66946007)(66556008)(16576012)(83380400001)(5660300002)(6486002)(26005)(86362001)(110136005)(16526019)(316002)(186003)(31696002)(36756003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kLQ1i9SVFSpcHV9qfG7cYNCBY9lMYZ2Ku7TPQxBEGrlk8/FchdvtOj6fZ62NUYXLGW9iR0Fp4BY5O3NpgiQWuKRtIuCP6ijns4yrZrg+VKjj9iqCljuI3ROoR8TrieffutpRvp1g3HBiOot+cj/9C9yzaFQQ8eVMjiASGIgSdMoCzIS1qnJvmk8g+V//xCIWoEez9PsAMUUcMJUOcQ/KnDXr6Av6T6VDpY6GWz3NosGAnFCWgXcHJHQn7FB15YTtnZVC8/q+SV/rXvFjmSuYq/Ydo2GcvqpTktiVxmNsplCAIWDG09vI5MTLGe8wZiV2x9TAfZ2vDoKhzTXPlIEzn2TktFA2zknb5QQhBI6aUcFJE9AWgNd5ODw1jo2klzGg4osCPHrrq8Lpid+fJeNKeXIZfw+E79UEOY1myo5aBLzIBb3PCIiwo6+DDY8kD+MNZaEmhPU5v0kuXLort0l2y8u3mbhxPyR/TYEJXNMRFy6X7BNTqGrYWdf2qXR47LX1QDQONZVl2e+I2Izwi0V+1iRtJ6x94BxZ9flnzwjwP9pUDHAWHAHFWD3kho+6mGz7sXniq+UWqMNrxdl8+/RwAXVCRQhdd6Bvf6ldEuAAQnd+rbpo7G3d3jzcm1mzDYqAt7j+Vxmr7ORYzI1ph1TEHA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a836eed-0332-4de9-0d58-08d85f4da1eb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:17:10.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bLn2BIFvTOznf5Cd548QmzyI6zQuyvwXPpQKi6VfAyGgQz9VI2i1l0/GR2wTrIg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5939
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/22 =E4=B8=8B=E5=8D=8811:48, Martin Steigerwald wrote:
> Qu Wenruo - 22.09.20, 12:34:18 CEST:
>> On 2020/9/22 =E4=B8=8B=E5=8D=886:20, Martin Steigerwald wrote:
>>> Instead of the tool, can I also patch my kernel with the patch below
>>> to have it automatically fix it?
>>
>> Sure, this one is a little safer than the tool.
>=20
> Thanks.
>=20
>>> If so, which approach would you prefer for testing?
>>>
>>> I can apply the patch as I compile kernels myself.
>>
>> That's great.
>>
>> That should solve the problem.
>>
>> And if you don't like the legacy root item, just do a balance (no
>> matter data or metadata), and that legacy root item will be converted
>> to current one, and even affected kernel won't report any error any
>> more.
>=20
> Can I get away with a minimal balance? Or does it need to be a full one?

Minimal is enough.
You just need to balance one chunk.

You can confirm it with "btrfs ins dump-tree -t root <device>".
If DATA_RELOC_TREE item size is still 249, it's legacy one.
If it's 429, then it's the current one.

Thanks,
Qu
>=20
> Best,
> Martin
>=20
>>> Qu Wenruo - 22.09.20, 04:37:01 CEST:
>>>> Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>>>> introduced btrfs root item size check, however btrfs root item has
>>>> two format, the legacy one which just ends before generation_v2
>>>> member, is smaller than current btrfs root item size.
>>>>
>>>> This caused btrfs kernel to reject valid but old tree root leaves.
>>>>
>>>> Fix this problem by also allowing legacy root item, since kernel
>>>> can
>>>> already handle them pretty well and upgrade to newer root item
>>>> format
>>>> when needed.
>>>>
>>>> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
>>>> Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>
>>>>  fs/btrfs/tree-checker.c         | 17 ++++++++++++-----
>>>>  include/uapi/linux/btrfs_tree.h |  9 +++++++++
>>>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>>> index 7b1fee630f97..6f794aca48d3 100644
>>>> --- a/fs/btrfs/tree-checker.c
>>>> +++ b/fs/btrfs/tree-checker.c
>>>> @@ -1035,7 +1035,7 @@ static int check_root_item(struct
>>>> extent_buffer
>>>> *leaf, struct btrfs_key *key, int slot)
>>>>
>>>>  {
>>>> =20
>>>>  	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>>>>
>>>> -	struct btrfs_root_item ri;
>>>> +	struct btrfs_root_item ri =3D { 0 };
>>>>
>>>>  	const u64 valid_root_flags =3D BTRFS_ROOT_SUBVOL_RDONLY |
>>>>  =09
>>>>  				     BTRFS_ROOT_SUBVOL_DEAD;
>>>>  =09
>>>>  	int ret;
>>>>
>>>> @@ -1044,14 +1044,21 @@ static int check_root_item(struct
>>>> extent_buffer *leaf, struct btrfs_key *key, if (ret < 0)
>>>>
>>>>  		return ret;
>>>>
>>>> -	if (btrfs_item_size_nr(leaf, slot) !=3D sizeof(ri)) {
>>>> +	if (btrfs_item_size_nr(leaf, slot) !=3D sizeof(ri) &&
>>>> +	    btrfs_item_size_nr(leaf, slot) !=3D
>>>
>>> btrfs_legacy_root_item_size())
>>>
>>>> { generic_err(leaf, slot,
>>>> -			    "invalid root item size, have %u expect %zu",
>>>> -			    btrfs_item_size_nr(leaf, slot), sizeof(ri));
>>>> +			    "invalid root item size, have %u expect %zu or
>>>
>>> %zu",
>>>
>>>> +			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
>>>> +			    btrfs_legacy_root_item_size());
>>>>
>>>>  	}
>>>>
>>>> +	/*
>>>> +	 * For legacy root item, the members starting at generation_v2
>>>
>>> will
>>>
>>>> be +	 * all filled with 0.
>>>> +	 * And since we allow geneartion_v2 as 0, it will still pass the
>>>> check. +	 */
>>>>
>>>>  	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
>>>>
>>>> -			   sizeof(ri));
>>>> +			   btrfs_item_size_nr(leaf, slot));
>>>>
>>>>  	/* Generation related */
>>>>  	if (btrfs_root_generation(&ri) >
>>>>
>>>> diff --git a/include/uapi/linux/btrfs_tree.h
>>>> b/include/uapi/linux/btrfs_tree.h index 9ba64ca6b4ac..464095a28b18
>>>> 100644
>>>> --- a/include/uapi/linux/btrfs_tree.h
>>>> +++ b/include/uapi/linux/btrfs_tree.h
>>>> @@ -644,6 +644,15 @@ struct btrfs_root_item {
>>>>
>>>>  	__le64 reserved[8]; /* for future */
>>>> =20
>>>>  } __attribute__ ((__packed__));
>>>>
>>>> +/*
>>>> + * Btrfs root item used to be smaller than current size.
>>>> + * The old format ends at where member generation_v2 is.
>>>> + */
>>>> +static inline size_t btrfs_legacy_root_item_size(void)
>>>> +{
>>>> +	return offsetof(struct btrfs_root_item, generation_v2);
>>>> +}
>>>> +
>>>>
>>>>  /*
>>>> =20
>>>>   * this is used for both forward and backward root refs
>>>>   */
>=20
>=20

