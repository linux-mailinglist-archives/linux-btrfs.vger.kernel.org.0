Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0731501D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 08:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBCHGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 02:06:55 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:41854 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgBCHGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 02:06:55 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Mon,  3 Feb 2020 07:05:26 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 07:06:53 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 07:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1x3vqVZIiHnzBv1YXAka+VlZeJLgLO0gI8jmZp0WIgxLchj5LDy6QQ4JBLZ3V6vBse/pItKihoG+QrqqdARBiCl91YRUxAeHJXT5uuG6OwfgTPWI4YLvGGE98QYEtNwkV+GOxF/BIjo0TdWBEpLgXcg3/uXBErAFCoRJsRuGytyF4AXip1exm4v0HrCv07WC3re08docKDpi9retbOORkQGBXi7l/GYAWk2PJezk/EfDYYQs/KvT5A5IgV0sndIiWmmHsgkVo2eYLqLFYmx2mAv0FyhibDogsJOseoX+8pKwhEAQmkjaDomlRiha5YErFVG+DnyVmzweXve7/FMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCbwJk4MwwB8YRKAn/JnDUpPt58varZZl4/E0cZR4kY=;
 b=jXsPz2OitimDaX+vSZ2ZgvQ7YTUTYJfBwR7GrAytFQ1+Ua8Q3h5Jyvdeu5NNRqmLja5RALihQ68Yk+L8wAw5WAD+xzivdl+GApSmj+Eer4V+VROu/xYmYRC2ReimEL2UscMIh3fIS7eoSlhj63Y2+VDk5wuW3jLfDIVcPorP04ekTSBud/W8T+OED724PISVPpd/NNIIuzOkisHPpTCtyDxW6by5M94kw8hRXcGQhCrChqB901NEUHovT9Wg0ITFs/0d+y/zaA6rY4yOCFw4bqRH/p1EvV243EKXdTtMWyTC8lU+FFqpjU75uKtEMiE5FhabSgGejBl/Uj72E3wvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3346.namprd18.prod.outlook.com (10.255.137.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 07:06:51 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 07:06:50 +0000
Subject: Re: [PATCH] btrfs: qgroup: Automatically remove qgroup item when
 dropping a subvolume
From:   Qu Wenruo <wqu@suse.com>
To:     <linux-btrfs@vger.kernel.org>
References: <20191017073659.37687-1-wqu@suse.com>
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
Message-ID: <48d1a93a-e836-3d21-d19e-9e5f8d15e969@suse.com>
Date:   Mon, 3 Feb 2020 15:06:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20191017073659.37687-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="a8rOvRBl7tJlhoTYCUjMioQpA2Q4Rapu8"
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR16CA0010.namprd16.prod.outlook.com (2603:10b6:a03:1a0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 07:06:48 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32a7ae0e-4418-4661-ad0d-08d7a877a365
X-MS-TrafficTypeDiagnostic: BY5PR18MB3346:
X-Microsoft-Antispam-PRVS: <BY5PR18MB33467963DA2B36002FE5D501D6000@BY5PR18MB3346.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(6916009)(21480400003)(6706004)(66476007)(31686004)(235185007)(66556008)(66946007)(6486002)(2906002)(52116002)(36756003)(956004)(2616005)(81156014)(31696002)(8676002)(86362001)(186003)(16526019)(16576012)(316002)(6666004)(8936002)(5660300002)(81166006)(478600001)(33964004)(26005)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3346;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /iYmxznuG1PI9QxdSanpIpuJSa2YMs+aA74GiG8Wbel+Bh1SUlGhDy5HwYU6cX8rrfaPe1WS6f4g+X3A9oBFu717wFjKD+tStLYisnawfWSlS0iVun5bcP6KfirBefJaPF4Okxhg4GMJ6Cqs3J5D1y2u1903vhaCKCJUrbXO/NC5tNLOcAMGp6+Sybn+uDglxtocplZ98g//XqiZIg5Y2MJ51v2UEqCHVp8B31m0ZM+XfNzOxT/TQjvcZc8Wnp+xGFsy6gzIpeq5IJZKNTm9x8Is7WXvyB/hNaDLt20rkB1x0GSHQ/nnbaD1GTu/mS8geyckWqBFIJNzOjvrq7o/8mpi32X56DULrKGhucMxPTqNhL1LAk8IKTKsG1RSa5cHIQY/g2Kpt4P5J8wiB7NTvQz6lglIlaJ5O1ufa2seEL7sgEi/u/RM2ZMlH8lCgl/AohQ1tcHQ2zHkjdtmbXUUl9EiUlJGB6s1hJ+Hhk2avYi6v62P3sppmusIiY31NTEc549xwHr7CeCye/kLD1vX8zqs+LvdsJuHwKNcuq9ErtU=
X-MS-Exchange-AntiSpam-MessageData: kUFTSThEWOGhQGuet7c7aV04DNNqjx2cYmJb+ya1Un1NeZbeW+w6FujEXQxh6YK3as0H6N2+NFoeRC2DwQ32ycw+jBwnnVT0NbmoGlSKSJ4AA0j4fKxsKDqRWCJsndwPVGyicET3hM8QVtqH8f2srw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a7ae0e-4418-4661-ad0d-08d7a877a365
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 07:06:50.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXaZUWWy6odG+gtldXk5OidXjGdwPdF0Axudm/o+WfKph0wbpSnjuSGGZ8O9bpEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3346
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--a8rOvRBl7tJlhoTYCUjMioQpA2Q4Rapu8
Content-Type: multipart/mixed; boundary="gk9cRUDBtAIHmFBlvVSQjH88bZiWkAoyz"

--gk9cRUDBtAIHmFBlvVSQjH88bZiWkAoyz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping?

On 2019/10/17 =E4=B8=8B=E5=8D=883:36, Qu Wenruo wrote:
> [BUG]
> When a subvolume is created, we automatically create a level 0 qgroup
> for it, but don't remove it when the subvolume is dropped.
>=20
> Although it's not a big deal, it can easily pollute the output of
> "btrfs qgroup show" and make it pretty annoying.
>=20
> [FIX]
> For btrfs_drop_snapshot(), if it's a valid subvolume (not a reloc tree)=

> and qgroup is enabled, we do the following work to remove the qgroup:
> - Commit transaction
>   This is to ensure that the qgroup numbers of that subvolume is update=
d
>   properly (all number of that subvolume should be 0).
>=20
> - Start a new transaction for later operation
>=20
> - Call btrfs_remove_qgroup()
>=20
> So that qgroup can be automatically removed when the subvolume get full=
y
> dropped.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 49cb26fa7c63..5e8569cad16d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5182,6 +5182,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
>  	struct btrfs_root_item *root_item =3D &root->root_item;
>  	struct walk_control *wc;
>  	struct btrfs_key key;
> +	u64 rootid =3D root->root_key.objectid;
>  	int err =3D 0;
>  	int ret;
>  	int level;
> @@ -5384,6 +5385,30 @@ int btrfs_drop_snapshot(struct btrfs_root *root,=

>  	}
>  	root_dropped =3D true;
>  out_end_trans:
> +	/* If qgroup is enabled, also try to remove the qgroup */
> +	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) && root_dropped=
 &&
> +	    is_fstree(rootid) && !for_reloc) {
> +		/* Commit transaction so qgroup numbers get updated to all 0 */
> +		ret =3D btrfs_commit_transaction(trans);
> +		if (ret < 0) {
> +			btrfs_end_transaction_throttle(trans);
> +			err =3D ret;
> +			goto out_free;
> +		}
> +		trans =3D btrfs_start_transaction(fs_info->quota_root, 1);
> +		if (IS_ERR(trans)) {
> +			err =3D PTR_ERR(trans);
> +			goto out_free;
> +		}
> +
> +		/*
> +		 * Here we ignore the return value of btrfs_remove_qgroup(),
> +		 * as there is no critical error could happen.
> +		 * Error like EINVAL (quota disabled) or ENOENT (no such qgroup)
> +		 * are all safe to ignore.
> +		 */
> +		btrfs_remove_qgroup(trans, rootid);
> +	}
>  	btrfs_end_transaction_throttle(trans);
>  out_free:
>  	kfree(wc);
>=20


--gk9cRUDBtAIHmFBlvVSQjH88bZiWkAoyz--

--a8rOvRBl7tJlhoTYCUjMioQpA2Q4Rapu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl43xoUACgkQwj2R86El
/qgKqwf/YookZ8Snfs2fN4QoJHu+/lSwebQYsszBY+IrOiKLs3BTp/4f9MEDIjbl
v+L46t2FFimUDrMAxdqz+I/BnwDQrwfkeX8I/go4WirxUl9+3tdQAyrmjz0KVzVY
Yypa3dG2echW/6+u9CrxZ7oHaLMQAXujkxFOL8DWPNFrTFzad9/NzI1gBFwYSRsS
aDcQHtQ0loONA/8KNyrIO4nLgJvRMMbjutwYGeTWKfDd8ftFgdrxQmsdiBUVbOc9
fIrYfEXhGH8Fymcjz4TeuUkUqxDpT+oDG8RZrYZYs6ZCICiuT2GVxmieohJ6gUPD
j82m4smpDgzmLg5pQnohU9MwQ5TsKQ==
=Gpap
-----END PGP SIGNATURE-----

--a8rOvRBl7tJlhoTYCUjMioQpA2Q4Rapu8--
