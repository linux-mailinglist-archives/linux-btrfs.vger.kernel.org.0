Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACD15D2D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 08:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgBNHbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 02:31:33 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:47525 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgBNHbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 02:31:33 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Fri, 14 Feb 2020 07:29:15 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 14 Feb 2020 07:25:57 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 14 Feb 2020 07:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfPPyUpIEVfBfkkUgYAYXiPkCgFAo/IMa4dUt4ztWMKpOkxzZjTybXgwLO3lUQJy5Q90zmNurSP/GRoCAXTUVqgSxw7a7hlfqDr640WPCNEXXswxVsMFByXSzSQeyHkQKzEt11A4bzPPsCZ609gk6FQLxrr7RtrHLTVtowFsCF3eVYzAHb17VgKqj3GePevI5ShlHulVrp+0Gzm2zwlq9Gv/MkYRRMZKXTibx0kV+cG0+Fe7thOi07DpaGKl9bnARrlF5NSPn3uwk17ETXN/tLI6Z55+E5kpWq1xH+Qvyr2rvmescT0HmC5cdUokHW/2ozJeO6/4iRWdTDnLGYtN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qtKcN6GYPXFUphsAKZL7jH+3f+0NqiySup2jZq8Z9A=;
 b=OLsXREoINygUQ9PPKinVNJqy5CpWJPcWuM5eXB/FX1IXeA/TS2e8u74YxD7TaMDOKP61oPBifSaF4aqIllJzXe3aiLDFxXgTbIA367tWtJr889TkJM5m2fCKGD5CS+EOhnAxDif1uG81ATcz4gG0bsAHWbU25ZwIFKVawDo+oXQzDEUrSso5MQo3HPQ2riU0Po3w2yUdj8zhkYslaVeHcLTq73cT0Jfd/UsiQvArBcigLGyKqWlBp8HzOK7RwUmXrATwwaoDxUo0yAM4XCst1WqeviXE70gJyHJu5tIGy+tU/kZtczvIjXwg+x/UediWaVFdacq+IjyenJjNy/DNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3122.namprd18.prod.outlook.com (10.255.139.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 07:25:53 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 07:25:53 +0000
Subject: Re: [PATCH 2/3] btrfs: backref: Implement
 btrfs_backref_iterator_next()
From:   Qu Wenruo <wqu@suse.com>
To:     <linux-btrfs@vger.kernel.org>
References: <20200214063302.47388-1-wqu@suse.com>
 <20200214063302.47388-3-wqu@suse.com>
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
Message-ID: <b1fefe8e-644b-0b25-1a70-79c98024de9f@suse.com>
Date:   Fri, 14 Feb 2020 15:25:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200214063302.47388-3-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="lgIsyLlVRCiFmqqD0AbIaDshsUDB3qC9I"
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0057.namprd07.prod.outlook.com (2603:10b6:a03:60::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Fri, 14 Feb 2020 07:25:51 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d33eeffb-fc12-4514-e6eb-08d7b11f1fe2
X-MS-TrafficTypeDiagnostic: BY5PR18MB3122:
X-Microsoft-Antispam-PRVS: <BY5PR18MB3122F4B171093AC011992203D6150@BY5PR18MB3122.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(199004)(189003)(5660300002)(31686004)(8936002)(81166006)(478600001)(36756003)(8676002)(235185007)(6706004)(2906002)(6916009)(81156014)(6486002)(86362001)(52116002)(316002)(16576012)(33964004)(31696002)(16526019)(186003)(26005)(2616005)(956004)(66476007)(66556008)(6666004)(66946007)(21480400003)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3122;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PPh6Q4cEI2/dTtGP3pRfe9EjHN7oBI5DVuWQjQWaHyps/ESlPNaB5OpnYpgh9w6QclLBWJxTDy/2rX8cO15ZDjHsnbUq4+a5OkUHor2cyfhKv+3v/gi5lqjoji34c0peAubkuHweyO5wIy8XCz7eCDRQvVhj7kDJc2jvcJl2x4AFWhNv21YYcNgj/cZZSlfErZFeE7ZBnxxCCpdTD3y/vhSIEVyhYWomTgNgmHJ6ZLur+ESAy1tERBpWbjtd7Fx4a7UY8//Qu48PkZUDEFZtavopEoW3c6Vt5NbI5Hm2dHUDB/UrxJ/yR6fd04fsgzHBbLL9jj8wuANzNuWgtLGc/604YAe4ucnJ2jAjcF33pKIO1touzNc6wcP7QwousPRkwrEOA/SuWpITgQA47Wz2sUongeiZ2QSlX3/VQYWeuRCH9IPUg+mwdMnc59L/P3H/xDSV8D5WCyyOjCIN6E9ejPAq64vFe88BTvUjrZTRXrO2BsQ9tykkAFC/1BgAO5ICYQbQypu9EigjU+IaQ/+hw==
X-MS-Exchange-AntiSpam-MessageData: q3Uk4uOTqX/B+7I8tzq+e2azdKC7YlU/5fGJizDQMrfU+xFug0bczOaje4i8P618fjv0qHIjvQoAzfYK5w7LMVx0abkOkW+Mb4so9n9usJM3rJr6YGBaEFopkVx5Q9TtUqSZR+RmzdSUrd27XAW0yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d33eeffb-fc12-4514-e6eb-08d7b11f1fe2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 07:25:53.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qxzzX6hIzQDfAg5Q4VisJdMVfZUZasoDPz2/VR0vetP4y/u8i6EqJYxUh46OBcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3122
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--lgIsyLlVRCiFmqqD0AbIaDshsUDB3qC9I
Content-Type: multipart/mixed; boundary="J1GeLEcghCdUzt0rsXBpjEuOAHOiiSCgS"

--J1GeLEcghCdUzt0rsXBpjEuOAHOiiSCgS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/14 =E4=B8=8B=E5=8D=882:33, Qu Wenruo wrote:
> This function will go next inline/keyed backref for
> btrfs_backref_iterator infrastructure.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/backref.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 48 insertions(+)
>=20
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 73c4829609c9..0f231cd69675 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2310,3 +2310,51 @@ int btrfs_backref_iterator_start(struct btrfs_ba=
ckref_iterator *iterator,
>  	btrfs_release_path(path);
>  	return ret;
>  }
> +
> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterato=
r)
> +{
> +	struct extent_buffer *eb =3D btrfs_backref_get_eb(iterator);
> +	struct btrfs_path *path =3D iterator->path;
> +	struct btrfs_extent_inline_ref *iref;
> +	int ret;
> +	u32 size;
> +
> +	if (iterator->cur_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> +	    iterator->cur_key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> +		/* We're still inside the inline refs */
> +		if (btrfs_backref_has_tree_block_info(iterator)) {
> +			/* First tree block info */
> +			size =3D sizeof(struct btrfs_tree_block_info);
> +		} else {
> +			/* Use inline ref type to determine the size */
> +			int type;
> +
> +			iref =3D (struct btrfs_extent_inline_ref *)
> +				(iterator->cur_ptr);
> +			type =3D btrfs_extent_inline_ref_offset(eb, iref);

Oh, I'm blindly complete the function name without checking the last word=
=2E

> +
> +			size =3D btrfs_extent_inline_ref_size(type);
> +		}
> +		iterator->cur_ptr +=3D size;
> +		if (iterator->cur_ptr < iterator->end_ptr)
> +			return 0;
> +
> +		/* All inline items iterated, fall through */
> +	}
> +	/* We're at keyed items, there is no inline item, just go next item *=
/
> +	ret =3D btrfs_next_item(iterator->fs_info->extent_root, iterator->pat=
h);
> +	if (ret > 0 || ret < 0)
> +		return ret;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &iterator->cur_key,
> +			      path->slots[0]);
> +	if (iterator->cur_key.objectid !=3D iterator->bytenr ||
> +	    (iterator->cur_key.type !=3D BTRFS_TREE_BLOCK_REF_KEY &&
> +	     iterator->cur_key.type !=3D BTRFS_SHARED_BLOCK_REF_KEY))
> +		return 1;
> +	iterator->item_ptr =3D btrfs_item_ptr_offset(path->nodes[0],
> +						   path->slots[0]);
> +	iterator->cur_ptr =3D iterator->item_ptr;
> +	iterator->end_ptr =3D btrfs_item_end_nr(path->nodes[0], path->slots[0=
]);
> +	return 0;
> +}
>=20


--J1GeLEcghCdUzt0rsXBpjEuOAHOiiSCgS--

--lgIsyLlVRCiFmqqD0AbIaDshsUDB3qC9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5GS3kACgkQwj2R86El
/qhIAQf/ZWqzM9A39llYby4AAeY5olK2uP91llCUWlfI6b+XDmFzI0Q6eBV0DvE7
OorQRwwqypxOh7bdX5a6QSuLQxfvoD4KgD2qTPASRJXfXwtw2L8+DgExq0RM6OeE
LeuRg25dKo0JWwHNp3OsESuvEi9L2AyTiaj4TcJiWM/8zaeYWYK1gL5aLcS7k6GX
TfuxRSWjHKhWvzuiIU95oEmmHXNfICqL8n4Smgr7vlgQu1IXJy447oFs1bzi0QBi
HedRB4/ef0WpP+QhiF3Hq9pnHX85RTXJCTHEG5kyMpjLTr7WYTVnVOlllTYHADzJ
aFiZ94H1pIsDxG1YrMSCt9h0L5BNYQ==
=Xi8m
-----END PGP SIGNATURE-----

--lgIsyLlVRCiFmqqD0AbIaDshsUDB3qC9I--
