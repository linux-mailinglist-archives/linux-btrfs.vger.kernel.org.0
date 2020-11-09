Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51B62AB79E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 12:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgKIL5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 06:57:52 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:46567 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgKIL5w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 06:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604923069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=0DfM2qFNL1BGAL5hDmCBstCme3WoOHIxuPFp10sogDI=;
        b=djAUq4u9Oz2kcjezG0ovA/GgNTKEW7oRIYNaHJzPUs+ZPHhtsL4FxWgE7hBME1R+jMcmG1
        iXBf/aTV5kGKUk0l24cioq9Z4mkmnb9M8UYLkkV4UVGt0fREw23zsl0L0gSFPIWJpcdxW0
        f6WM5PzqudQYPP77VIS8QP37asqEFJA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-rXKEAEadOEq15DEqVsOgiA-1; Mon, 09 Nov 2020 12:57:47 +0100
X-MC-Unique: rXKEAEadOEq15DEqVsOgiA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTb3ml3xDrRshGvKokcWbDrd6gVMdGse/FQKpckpY+Jh4nwoZFrv/P9SXiE+pyO5riNitFMKMEdH4M6mfmUvj5bzT4o4iTsDfm8z5PoQ6VGzQl6EzJF6U82ZDypT3BAy+Zwv8QmeKW6T3vb85PZzl2EXXYm/aXx842uGUFDLXC1RrUgVz/PgN0JLAl7nnlSHQTfDCjhMMe4b7zeRa9gIW38qWCmfp/nCFqhxINSK2jsHcj9znRuvs8bbF1nzRpCthPegyMBPSbCd0X2QTotAtWXmal2Ju8O9SKsDo8yHQbBxPmwBfEqSBMNGDX8XbZLdownC3/HoIISDCmt3W9maxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DfM2qFNL1BGAL5hDmCBstCme3WoOHIxuPFp10sogDI=;
 b=G8UCQwvro742z1MR9mbt8FCSfM+ne3gcS58GHRHpxY7s+/7gg0Tt6YxLmIhfxqSiAMUH1ki8POpV+1O6auyP/C04BDwQ0QgWOir0b5OxYfOVsSds3E6JkLiEzll0HUv6StFPbb7li7nBTkJkgieys3Udg4WyLuSDkaInVPssXb8+vk//tOEEcWDveZcxj2Pea2g7Edq8kWQq45pnnuHl7ACA4je/QT16CEOEM513fOw7kSV4d0BirjKXJ99lSMQRqdq9WgMpOZsjYpbtjcONWWWSGekOgg/TdwZqKgwuUgNXcvBLixKdrpQXtktEiJC9skv6A8wUG8G4ntllsp2XLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB8030.eurprd04.prod.outlook.com (2603:10a6:102:cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 11:57:46 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 11:57:46 +0000
Subject: Re: [PATCH 0/2] btrfs: paramater refactors for data and metadata
 endio call backs
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20201109115410.605880-1-wqu@suse.com>
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
Message-ID: <7c86d1d7-8736-1558-6fe3-dbf96a5acd44@suse.com>
Date:   Mon, 9 Nov 2020 19:57:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201109115410.605880-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TLfgXGOnF7zh2a3za2kMgKPED2OfWIc5V"
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 11:57:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2f172b-32cd-4b91-acf9-08d884a6ac48
X-MS-TrafficTypeDiagnostic: PA4PR04MB8030:
X-Microsoft-Antispam-PRVS: <PA4PR04MB8030F7F063108A051BC98B0FD6EA0@PA4PR04MB8030.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgA2+GXU6Atxc7M7jTYz7/44H6rpmtLW7kXGrThPZftPIPlujCoHYzRvV9EQflCObnx72zIyxclETB1negtx4fg9UliXLL1ahD/2E0NJGLbb7nw6PZ4FVrRYlNk0Sy7qXpgUeySSypCnvTdfiFVtHV+2itZKzKM8UhWpItWd8cXyAHymqis8pGRBdofFDOgI8k8EdBm/M+Q1/SOCIkSndIDJSYU4QpQuT0fG7SAoEypGf5hx/IfJ2t+EvGw4jSvCfufLwoW7lrBw/kMekE5htzIhMsYytYUIfK7RnSCkxkhdywlEgnCFzni9UVohHv9HJcaHYk5z02djqSn1gQmZUGFWT8x1tsP2z+6ssb6cVlDGDa1nNw1dLtCWajIK46x9daYyL3Pj2MuaMHaND0E+KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(66946007)(2906002)(66476007)(6666004)(66556008)(31686004)(478600001)(316002)(956004)(2616005)(6486002)(33964004)(5660300002)(8676002)(235185007)(16576012)(52116002)(186003)(16526019)(8936002)(83380400001)(21480400003)(86362001)(36756003)(31696002)(6916009)(26005)(6706004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2d4vpwrAFOVmxyqX7VgPy6D/r4GUO1Ig2zdu24vo2thv6FtjYwSm6y9RkIdOnBcSc5q6mDJSEvM7iLcCggZOw2JC5OZdoVJf34hcIEfSjDD//gWbcIw+dQhDK2+pYAfq+MdBIJZd9dyQXD6EoPn4HTXTCpEya44dBDBCgEjNqixYBFxftGFqQwhI77Xdp87zVZZSQH4eFGjIgtlZthuRRkf+mfX6gK61iH92ilzzutwBN/kGH+xSJglG2JI7Xxkvl4go+exzU9Pr8zpwDSFM6ZKBKxQpst4HA66rQZglxeAfhn0K8Yi7+T9f9MyVpC4jRKJbe10bNEU1sjWpJUUUcSvE5+J285gDw0MWOAe42+j2xEkzU3D4zm6uOgPu30cEDZH39vjKJzfzKPNhLhJGBMDjAgUFiuoTXRffRqWLZJNXAemDjPGZ7rRIKuQdzf5yGetg/m3HThZAo+8KKhUDZ+cRlnQfU5MAZ/kZJpyBJu/YlBe0dAk/4nug5u8yxQ7jpuA6ilm31OcSEiwlSMhI8hxDXI7Q/Qa47SVTaxuNz5cG0ypEo3lqWd06P3DKgCLdSTIC3DXrjeqaoXe1wNp+p2S3O/vy1naxOoYAzEJxlVRF4bXuzv6DaohxJ2WLedsAzuzmp/dCR+rU3Is+F+oHZw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2f172b-32cd-4b91-acf9-08d884a6ac48
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 11:57:46.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF8/NVxtfAzk75DOAuIzQb6Khx5tBoVU4+LJdO+7nfwoZRZ5bs81sO3ThvDGALLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8030
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--TLfgXGOnF7zh2a3za2kMgKPED2OfWIc5V
Content-Type: multipart/mixed; boundary="3AItqgYOe5x0dXQX7PNq46ZylZLnxznC9"

--3AItqgYOe5x0dXQX7PNq46ZylZLnxznC9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/9 =E4=B8=8B=E5=8D=887:54, Qu Wenruo wrote:
> This is another cleanup exposed when I'm fixing my subpage patchset.
>=20
> Dating back to the old time where we still have hooks for data/metadata=

> endio, we have a parameter called @phy_offset for both hooks.
>=20
> That @phy_offset is the number of sectors compared to the bio on-disk

Well, phy_offset is the number of *bytes*, other than sectors.

I guess the mistake has already prove the point, it's really easy to get
screwed up for the @phy_offset and @icsum bad naming.

Thanks,
Qu

> bytenr, and is used to grab the csum from btrfs_io_bio.
>=20
> This is far from straightforward, and costs reader tons of time to gras=
p
> the basic.
>=20
> This patchset will change it by:
> - Remove phy_offset completely for metadata
>   Since metadata doesn't use btrfs_io_bio::csums[] at all, there is no
>   need for it.
>=20
> - Use @disk_bytenr to replace @phy_offset/@icsum
>   Let the callee, check_data_csum() to calculate the offset from
>   @disk_bytenr and bio to get the csum offset.
>=20
> Also, since we know the @disk_bytenr should alwasy be inside the bio
> range, add ASSERT() to check such assumption.
>=20
> Qu Wenruo (2):
>   btrfs: remove the phy_offset parameter for
>     btrfs_validate_metadata_buffer()
>   btrfs: use more straightforward disk_bytenr to replace icsum for
>     check_data_csum()
>=20
>  fs/btrfs/disk-io.c   |  2 +-
>  fs/btrfs/disk-io.h   |  2 +-
>  fs/btrfs/extent_io.c | 16 +++++++++-------
>  fs/btrfs/inode.c     | 35 ++++++++++++++++++++++++++---------
>  4 files changed, 37 insertions(+), 18 deletions(-)
>=20


--3AItqgYOe5x0dXQX7PNq46ZylZLnxznC9--

--TLfgXGOnF7zh2a3za2kMgKPED2OfWIc5V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+pLqsACgkQwj2R86El
/qh77Qf/Rhj1Ym0VWim634cQvubcQ16OOI+UpLDWye8G4ZhfzgkzHV3mPVdjoGMr
FKh/An4ty/2a2lBkn/UjNT2P6VDf2vcmRBZ71vN5ltLYq618a+32CM3O+xvskW+f
CSKxxqEfm+zwUnUIxbN2vwPY9w4lFQ+XzhkQ7GrMtZZS0wO0UE6uGIUWjvXup+N1
8RuERp8DV+OfKivQw2QCxQ+oZLowP49mUgwNxJeYtMJxH+yCKKpwQLNtDzybFOJo
LX8Y+7eOmZ4UnJk8290AyNHGYsatiezE1W0WKZ5eDNT1TJmA93DFOS9XYECj8eRc
CI0JBXD7VXpkVo5D98gg3mmSXdS6bA==
=qCH2
-----END PGP SIGNATURE-----

--TLfgXGOnF7zh2a3za2kMgKPED2OfWIc5V--

