Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD222A22A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 02:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgKBBGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Nov 2020 20:06:52 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:58450 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbgKBBGw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Nov 2020 20:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604279207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+qUxkaGtAOtG3+8g5aY3++04FOXG5B78BmvVlhS7Ku8=;
        b=dA5DlKpJ1ftoBuBMMlnFirrqqkoC9BRwWq+iJYxFpJ47CnuCqeCAhKN15OoQuOm0IPKTyH
        +GUMP5Zo8naRI/+Av+LNSpOoOk6IpPh7twPZfkM+LIdzjDiBPxz49cZdiFhsLFKR8e4M0O
        OanCSRNkHb4onPf3VCqjEfIHoe4F/tk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-zF0hcyygPSGOqJcwbKJH0A-1; Mon, 02 Nov 2020 02:06:45 +0100
X-MC-Unique: zF0hcyygPSGOqJcwbKJH0A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhn8HWk//KZRagdXfEtjkZScoLhrHoK83i1YjRXJODs+cqX6FOhu4OGHTHq3/fG5D6ZFJQRkeSpLKVP6BYM1nqblf2PPYmnomZ+o3PVMeJYUoBKtx/P60Ept1APT40v4Adtb4LahG9d2kmDao03MtMhtLL8qhnOVEIAK4PEmnJgL6GcCpKSp0lnbe/cWnYJjfrM6ETPd5aFWWbecNHeBzW+i/o9RSTA5vrjrJv0ptit9Vo4knmb+EF5VMi/zBXWB+Jqz3v0tXKgVFb15DiNbRnwAa7p/RmM7ZfUXIMHRRYfkdo+qHbageACuNL17vNtCj3adMDRMgunq/K+qY5iz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qUxkaGtAOtG3+8g5aY3++04FOXG5B78BmvVlhS7Ku8=;
 b=bjC/YvYrkGZ7X55tolwZYPKmIVNH2B5UmLgOBqDAktZVtXS13ko7WcKclUregF1VNYrGATNuY2zvTaqQhCoOO4wl8JsImXmQp6JFCrWJscNUiqWM94j3H3awE5uoCIXv4qjlHMj9qYoBetsGcLriRz+chBPIzOHYFnqmeGDgsF0vrUEVrY+SsdTlO4uselSfFyCKxdR+FdG/8l7FHc8cBqic7G9usccUvph/55yI9BD3SxsRLH2tuPbnj3PFV5MAYLyN1Ws+3FYyf7oJlnK3FslpRPeYdTiH5Ubne9flHuUXpfsuvu8jtJhRZMebSgbhB7C0pz5SscfKHbWWkXJCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM9PR04MB7665.eurprd04.prod.outlook.com (2603:10a6:20b:283::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 01:06:43 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e147:582c:8301:4b7f]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e147:582c:8301:4b7f%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 01:06:43 +0000
Subject: Re: [PATCH 2/4] fs: btrfs: volumes: prevent overflow for multiplying
From:   Qu Wenruo <wqu@suse.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20201031010752.23974-1-wqu@suse.com>
 <20201031010752.23974-3-wqu@suse.com> <20201102000256.6ca75cb9@nic.cz>
 <405beba4-a461-41ad-9da7-809498cb6e16@suse.com>
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
Message-ID: <71fd30e0-f02f-5a9c-893a-1e7e835e3320@suse.com>
Date:   Mon, 2 Nov 2020 09:06:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <405beba4-a461-41ad-9da7-809498cb6e16@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vvFUI5El99a4tVzkPdTcnIfuxxx3GogJy"
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 01:06:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c46c6faa-4ca7-4322-0657-08d87ecb8fbd
X-MS-TrafficTypeDiagnostic: AM9PR04MB7665:
X-Microsoft-Antispam-PRVS: <AM9PR04MB7665B67C53364537824F3834D6100@AM9PR04MB7665.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qW8Z4M6XQ3h8RW64Mze8t7P5Ya6rSUmNd1GP1uffTiXrvXqLXcFtrhmSQnZacqG8eA9gzQ9923JNPijre9ffOOU4hceob4Os8aSDiLx3nABTDgGEPFAkjJ/S9owfxwhw454ybZFA6oX3HZ7j1e8UPA/xZ6DkLJEH9rv7fAK7i6d6JeG64OymE+Xm2AbNcNyT54nHsljq0Jw0DMaCPSm9FQ/ZnTaUwfv8W2Sk39yW5ossNLFr8H3qOkfBFUoHwSLW6WmFFrIP1WBNDimajcPJsdPvCJ3yf0JeS30nVrx48tdaOWpfxFoAQvHTCNJ2+TeMVaHDqAPBTzsDwo8F1hLBCFb8QPyMEk527LjSSnwBOAQECkpfCdm4mYIc4XQCNN9aLEDOgM0S6xSA1da7IpesFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(21480400003)(186003)(36756003)(5660300002)(33964004)(52116002)(235185007)(4326008)(83380400001)(6486002)(31686004)(86362001)(6916009)(31696002)(66946007)(2906002)(478600001)(8936002)(16526019)(956004)(2616005)(8676002)(6666004)(16576012)(26005)(66476007)(66556008)(6706004)(316002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dPRpqZw9YcILzybQIbaHBYTWy7A2IxdgNeIKJrNAhpjDIDlsTsNolK7PxNCeorFY5U9FHWisBhqIoGjemLKfGnTxYEerdzHBUYFWJ6s/kCZEVOSlQO+eltLwA7GkDjhNCVyYyyHem1ZzqkVzbOhBzpzTGJCDnVSGSVsfQLH6vZB/PG6uz4k/jMVzq5XMdLjhMaR9Novq2te+55imQ6JH+EJ4Erk2g51tw5zOgap6QK6yAU8ipe8R+/Lo5AVAjniFVu3xCudLfNp03M4X56vCu+2aCsu1GWHG+7jy+IaqJJSDdCtG/1d1hO5ceqaE0fbgHHJq0mQgTx3Db0xjMRwHPrXVfIua9MpaOyzrUENQBcdhgc0yafQManlgC4BBZTccNwh79hMzhXaNQ0b8OErL7S/EB3y8bkGvwt4MpkTe9/SLWCwbEeomjSHAB5pCJJoWxUpgHz2t4cGFCzOFIQolMMde9nXr5O2HNhC3dulPNZaaNstWKRfmkx/jbh1+XbGWva+HFaBKzFA/DuPkXNC62IXW+aTwRcp1tfYhWm0VN9InProbJ1xAVSnUt29Jw3bIL2amc/iUwvV/JVshv+EwAx8LeCVCJgcDO3UBujFMTj3ZCGf0UNq9NOzHKwPag9kjL/2dLYvWFPfSM75HCKBfSw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46c6faa-4ca7-4322-0657-08d87ecb8fbd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 01:06:43.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdziRLLFBEze/CyC0WYgMUrijfO0TlHNulSNxgl++jXrJPvod9LdtYSpQQguGmKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7665
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--vvFUI5El99a4tVzkPdTcnIfuxxx3GogJy
Content-Type: multipart/mixed; boundary="pEUyZQRvyxOf8aPaMYOcqC17snxnKKzMK"

--pEUyZQRvyxOf8aPaMYOcqC17snxnKKzMK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/2 =E4=B8=8A=E5=8D=888:20, Qu Wenruo wrote:
>=20
>=20
> On 2020/11/2 =E4=B8=8A=E5=8D=887:02, Marek Behun wrote:
>> On Sat, 31 Oct 2020 09:07:50 +0800
>> Qu Wenruo <wqu@suse.com> wrote:
>>
>>> In real world, this should not cause problem as we have device number=

>>> limit thus it won't go beyond 4G for a single stripe.
>>
>> So we can't run into this overflow in U-Boot because only one device i=
s
>> supported? But in Linux we can run into this issue?
>>
> In kernel, we have device number check, IIRC for default nodesize is
> just several donzens of devices.
> And since each stripe is only 64K fixed in btrfs, you can see it won't
> go beyond 4G even in kernel.

Sorry, the 64K stripe_len is only for RAID56, and for kernel, we always
use u64 for stripe_len, thus we won't hit the problem.

The problem is in btrfs-progs, where the code comes from, we use int,
other than u64.

Thanks for the hint for the root cause, would related values to be u64
for both btrfs-progs and u-boot to follow the kernel scheme.

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20


--pEUyZQRvyxOf8aPaMYOcqC17snxnKKzMK--

--vvFUI5El99a4tVzkPdTcnIfuxxx3GogJy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+fW5kACgkQwj2R86El
/qjWTQgAipOq5HF3CmQI13eKaSyqXQvBBgzr59HHkhLojrOEi+1kPIbvTEyYrFfT
CbvX1nAUuYAPElro9C+4GCBiQnB1DL6QoyPf/gQsrQ9r/mBX9zR+l6FYeEUVoJsu
kgXaZ29acbzXxwSOELeD12PnlDdlCfytnbIMKTmD5sTFC6sPM0ErZxfSJ22E1m28
aZNNK6y8rJ9WPTkOSJX3xJkrLWOTS0xhnweWF3GvHORQ/1cl2A4uvJHTaIh57EPt
74lKEg+QawKh+tJxDKP+jaqb0cBe/Kd437AlJ+rO/kcghFJmlkfuIkR25QbsNVgO
cBRKOW0DSciGaelCDkr+5Pl7dRHm9Q==
=E7pu
-----END PGP SIGNATURE-----

--vvFUI5El99a4tVzkPdTcnIfuxxx3GogJy--

