Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE93E232C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 08:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242359AbhHFGSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 02:18:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17989 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhHFGST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 02:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628230683; x=1659766683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KP41NrXSrNUybH2rcN/yyXHInPafjcwfcVXSCBDDzGQ=;
  b=C5Wbp5HUN+82lxWJRCsriNpEMKlcjiBp6QJ0xNqJ30C2zMAP/tm2CFrC
   FNXedwk9c6FVlLXMWQKIKPTM1k5KVvby9AatJksne5hMXTxx3cR1BWGOb
   lGw3Vl7WZ3lH+w8BzpwIomJ5ERU5wE5Due7usTq4rDeJ3Bj98OIwyEh7z
   DJ1ojNbWRLSSMf1gbsSzJqqIVUCSRLv94zl+OGLw+r0n4bL4f/uRSfy8l
   R7fhkfJpuT8jnr6xc40r9pBEXQdlekDPSWgCmTVxDShR7HsxVSKy13d79
   OYbUY1ps8B1nm3CaRntIPlmJHQiNz9IjkGmvwadDMtb1Oj38q0O5aunLF
   A==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="181289641"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 14:18:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2eDDAxuQsYfuTQkhWz+k3cDgGPAHfJYVp0DAAtr1TO4hAu1Lxnd5H6pEKNgQCPAyL20lb9MPl2UR23KEBxHtAs4cvQ+BzpMNEZ+GqQoKPiYiI0u2oNz05PLKr5v3ybB3UZ6iL4r4Hs8QSac9zlZYixpMPXDTb59ehI0t1mQmwrFvmn6bbaEZUxX3cATQYG5+crFDjnY5djNB63REmODVEiP+xNOjsDvEM8W3LPBuaIE1UWu7dOwEnAp3GHXGEqXq9eldRhFsjJ2fXgsx9w6seGLsogd+cVX5V84mRX75pFH7dUmFzGSpwsotK2SqGCRs7Li1hH1TR60uaRk0tzdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLrQ+UlH/18gnlgSW2WjW4ZW69YFMPW85U7DKvfQamk=;
 b=R/wJjc3ULSEKJN+pSHtlQQeBr+7+5b/GyQYArAQUg9jNRd9pPMf6nKkaZAnaIZZy8W3ozKammeavR+L6BD3DuB5Fzpmd7Bjea0EYpP8L4qXJl8WSCZ9oZEBLVGNNtqwDl+TNFNVe/zlwGsfTEjNv/4wHBRR6TPH31LDK7TmYDG9lf1h3iborffdW6P2CWFMSWUacMwKU72fwK4rmzqYrecTT6x7/qTJrmJRMRiqAaKMlGSe8CII8KNLdPf5ivfwvAW+4mysGcfcWe8URw6e62dRgoKbcTI3i3WCOBbXdjScbZFBKpfGABCVkhdKpmHreVacCpzT9vBvxuZ/6XksMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLrQ+UlH/18gnlgSW2WjW4ZW69YFMPW85U7DKvfQamk=;
 b=Frt3I81gM2JybE5uf91hIiopWyHN5IQXibFuh356DvlCC3zhsGN8yly686YNakpcFKmCicTJ3zhgneVwtopuvukTwuL1ankdHeMhZS4uZYG1Wo0xA68Yw4ZNoHlKcR4lpxWIdeDVi2VHZv1HJHUkGKS5OLot3t/BXaLgM5tLL9I=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7837.namprd04.prod.outlook.com (2603:10b6:a03:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 06:18:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%5]) with mapi id 15.20.4394.017; Fri, 6 Aug 2021
 06:18:01 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in
 calculate_emulated_zone_size
Thread-Topic: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in
 calculate_emulated_zone_size
Thread-Index: AQHXiWF8ceku70HQVU+E20D6AbX226tmAtqA
Date:   Fri, 6 Aug 2021 06:18:01 +0000
Message-ID: <20210806061745.3h2a54vwthlrlx52@naota-xeon>
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-4-mpdesouza@suse.com>
In-Reply-To: <20210804184854.10696-4-mpdesouza@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7591df9-b712-4dc7-e9f5-08d958a1f1aa
x-ms-traffictypediagnostic: SJ0PR04MB7837:
x-microsoft-antispam-prvs: <SJ0PR04MB7837E88C132F5C1706FBB99F8CF39@SJ0PR04MB7837.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXVMeF7QPDrVBUBm28C8SCJj+Te/V/vlJkRSGE20wULycdzZM59wD5z6lRUPL9bp1h+U7FrMoXZ1hK676s9ZBrscDbJ/BeqKGOwkGF3Oj7AmExU59KCSUgvdvVMypc6DdiuDWBZlaZQtt1IgtOVPBtuXM//fvBFcAAdlgLNlM9NEUqG5+DuY7DzDi+Y1yeiZ07kAY/fKkhVshySNsJfSeqH5Nz8HrrtGSZm2HtW0b5x6m4AMhG7efmqxxcs9EiI4rxP+v4wq4O21nxRkatFbj51rPy1o8xAdQFyc5SzNGfOjpWm5s2IasgIfK9GzeGs+ruKbFkeDaUju4Cl5vGeHSYlWqmKcgLQehOZAkFjFL6BU5+mEOCVAloR4I1qtdln2iFD/oK/FrGz01F3WsHyPowrTB2Kzt9QPSjEIrqocWKHsriW/ByUPdJwtFaqj7I3jPE9NlTqJNVLiexTkedQGIzM9ik5eTf0dQSIjh4KbAOh1tpt78FhnNV7i6bCXtj0ZFBxJphQAgPEbEjcYhY+VV8NwV4RbkajJdcJhxD1y0G0c7O4UdxHgNronPxtVuAW2AxOHngvo68tZsyhxHBjBYR5qQRPFsVX+e5GO72ofbey3dYuviMDhZe3VKudj30oCkA6su/8KzUO6J81AJ/jU9ORBtNwlmmCLpRjjkEL178z2xdExrOqQ0x5OgXwvsGKLLBmOnI1HkSAFZuCqPm7dkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(26005)(8936002)(186003)(33716001)(6486002)(64756008)(4326008)(54906003)(91956017)(66946007)(76116006)(66476007)(66556008)(66446008)(6512007)(5660300002)(86362001)(316002)(9686003)(2906002)(83380400001)(71200400001)(1076003)(38100700002)(122000001)(478600001)(8676002)(6916009)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6o7KVcwEiqfl4ngxO39EJfxVMm6p9zZs3zX+NhCQCAMLBS2PMazXVCd4v5+u?=
 =?us-ascii?Q?eKJMJtlofUGKgK0hbuB/IXphGocAaAqe1GylYrgf+jk4Jq6mcl8HPuD9WuGZ?=
 =?us-ascii?Q?9CLq8OOpHIBdjsCClGlEElERGU5jd9igH5PxAK8PkwfK2rRueBU/9yUbXNub?=
 =?us-ascii?Q?P4xJS7nsUO0F5eIWagzLLPKLhZeYG/HrgB8+bpMlVXt85VPj5LDtYphjYg2w?=
 =?us-ascii?Q?3rRVZs1qaLpyC1yd1O/lpKAKH4YxSnpaH9CEbbBcQOcO8SBQ9BVo6EsPrUBL?=
 =?us-ascii?Q?7ftZq0EFF8ZMFMc6B1WKfcobns4ZzlAmQilLl+KcZNsJao+QnsZaWP1edOZW?=
 =?us-ascii?Q?Xm4LtGDqUV56pMwdwNEokCfefSrSlTG+ixVPuz+KVhjZyrFCfUj9fHUOVqMz?=
 =?us-ascii?Q?r2PFS8REbzAxoaX6Qds70A6QkmwCoYqmJg+DAFSQQEJr/oZD/kzFxg6XpGz+?=
 =?us-ascii?Q?Uf9onW/GQUNkhqv5UnJN/w4ffHS/dmCyA7zSvfNyOqUfzOXksk01Mt+Ip9wS?=
 =?us-ascii?Q?i6fsXg2z3C29+8NiqfjnU+1ewNOFyylilcQaj8SOhMUAYY6nOtxL/4b6rN7G?=
 =?us-ascii?Q?ePVYXA0bbnYCO8iRyby+ox9ppbw2m2cW9rUP6E7rdFWM6cBoYLB4uh2SNtC1?=
 =?us-ascii?Q?765EUPOn0vAvljlh5d43JUkbLUk7RFHe/VgQY218vzLh0CwxOMmBSCvugI7E?=
 =?us-ascii?Q?2OH/VXv6wnku92Ka8nSLoUWTcAg/YVWjEQv4uj1SJqa5AEYGASzj/RDwel6w?=
 =?us-ascii?Q?YSnRz0Jh/6qofDw84koPuddBxG8lFl+TkGf5mrxImU3qtofAp+2wgB1cRjtl?=
 =?us-ascii?Q?eXTbmrH1rhEsouYaXwMLivvwe2u6XzctctOZxA4cDIj1OsH4fQ1eNBxg85jk?=
 =?us-ascii?Q?0UsTrSMQWmoP7WA276ZzzbjLa3fpPqPocp3Q7ivwoR6XrFYIipHgBCGGkQe7?=
 =?us-ascii?Q?P+7h2PHBz9AjMqkg7wINBCSY6eXY9U5vtLJyiXp2sPL+01C3s9RezhT7eSV5?=
 =?us-ascii?Q?J00prV5S5rPDlgOCoGLu1tay6HvCMUOs4G2yuYHDrQC0WIVkBEmvKT2i6/oo?=
 =?us-ascii?Q?jJjjAnOODbVeLky3K/ytI0xW+nrqx8jDuEumgwROGL+g1K8fqdL983p3fGxG?=
 =?us-ascii?Q?OsWhhtu0N06rBQGBwpFkrej3qTYqEy1ambhHMclrfDrW2lRVKND3duTMwTwl?=
 =?us-ascii?Q?CSwfJ5vdFVafVJyAJCHjoMaIf0n4LMueX4xTCDMLSnwmR6onEMS12+1qN4fH?=
 =?us-ascii?Q?Uu+G1ApGRawJDmNVRyQ6lsLXLvho1RVG/39GLlpFsxf/V87cRSkhBoOxaJU2?=
 =?us-ascii?Q?apSr9crWHXQLaoJLat0J41tds5j7pfukjVEIGJ4j4Q3Cbg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F29F735DF44AB1419D97B916805A0B36@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7591df9-b712-4dc7-e9f5-08d958a1f1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 06:18:01.5482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rl8+6lW+FMVlTNUouLZBGsAY8B6A2p7dgSxM2nvnjO9iOzkegjOpyGooWmzrYFoynRvoJl936cRmFfU7U7RMUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7837
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 04, 2021 at 03:48:50PM -0300, Marcos Paulo de Souza wrote:
> calculate_emulated_zone_size can be simplified by using btrfs_find_item, =
which
> executes btrfs_search_slot and calls btrfs_next_leaf if needed.
>=20
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/zoned.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 47af1ab3bf12..d344baa26de0 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -230,29 +230,20 @@ static int calculate_emulated_zone_size(struct btrf=
s_fs_info *fs_info)
>  	struct btrfs_key key;
>  	struct extent_buffer *leaf;
>  	struct btrfs_dev_extent *dext;
> -	int ret =3D 0;
> -
> -	key.objectid =3D 1;
> -	key.type =3D BTRFS_DEV_EXTENT_KEY;
> -	key.offset =3D 0;
> +	int ret;
> =20
>  	path =3D btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> =20
> -	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	ret =3D btrfs_find_item(root, path, 1, BTRFS_DEV_EXTENT_KEY, 0, &key);
>  	if (ret < 0)
>  		goto out;
> =20
> -	if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0])) {
> -		ret =3D btrfs_next_leaf(root, path);
> -		if (ret < 0)
> -			goto out;
> -		/* No dev extents at all? Not good */
> -		if (ret > 0) {
> -			ret =3D -EUCLEAN;
> -			goto out;
> -		}
> +	/* No dev extents at all? Not good */
> +	else if (ret > 0) {
> +		ret =3D -EUCLEAN;
> +		goto out;
>  	}

As I wrote in a reply to Qu, we want to find the minimal DEV_EXTENT
item here (somewhat like btrfs_verify_dev_extents()).
btrfs_find_item() returns 1 if the objectid is different. So, it cause
-EUCLEAN when a device with devid =3D 1 is removed.

> =20
>  	leaf =3D path->nodes[0];
> --=20
> 2.31.1
> =
