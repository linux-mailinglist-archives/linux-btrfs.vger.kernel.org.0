Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684274027EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhIGLkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:40:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5254 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIGLkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631014757; x=1662550757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=invKp0jLPjk5vR1D0ry0bqU3CHUG9pJzVajSfqDqeuc=;
  b=r3wFAkPqwNQEErZCvm3etczrKaIV7sGmQU0TJvu6GF0YTsf7N8T+Mfpj
   A+dyTqXVt6uCCYj5ynK/KiXr4cMJL8DvtntGndOeJkT6+a+NfIkOipIxp
   P2xq5XcrH4UPQLkvMYmgtb4w4oOptj+A22i0viz+uTbPPJ3AcTbly79Nx
   tk+k9GNnYzJJyyR0PXednEVjNGq21zUuSWIqyfD/wQ5C9nWFYi7k/jjLC
   of7houYxqdzmKOcFh1LS/X9YOnyMAM5wJqPb95IYLgudFJfaYaw4VyKIy
   RYursgVa778yR39yZM1tNa032M0tnb2oOoiurOM8r3z2x+4dBrIQxr1X0
   g==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184151852"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 19:39:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPPqG9+PTyxzFD0qymoZEgcci/kY8iIalZeO7/kSStnl4gkwIJzD3JI0wiRfeqkSZs2xH18s+hJEiIVxtnifyw0VJAmmfZJ/x0pJVJJfakpBMPuBROF9tPxV16+cqtsFUl29hJSXYRPj7PlO1Z8qzUTgvMzFN0ec61aKSbnFpl8GDir7pZtGEwQUzakUdgGW8NdMXihJ7CU4P6HkueQ5Rhgee+7OJ5CBjQ+yn96nDGDzsGQ8c7H683aJVPsxQBwtgoAdIbknAG+Kh52eCE7XsenBumopDFUrvU7XkWw11bNS7ZYH8xgKhSOZ0G7Xs+rJARM13gRHLZ3cFDe+/Q97Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uVp+JjzB7UY6+Mg83rjhBGR8Ooz33Bn4OgOO4YwJN/U=;
 b=ZOfE9FuOU8btb2dYalJk7j6H9jOcPzG3xabznUzYp2OzKwnBPV6XHn3e66cmLnUTz4MpjQ9f2tbL0Yv5GtJC1/jGIrI6PDdIqMkHibWFkfP3SjfgFPOpc5AgJIY8HQE4X5LWZu4wxBSTFewedrWsTuTnDoukg7jwTFZKp32KWahDo5u5gBz/DnOBIUKUvjGBd7TQCXbAmQMgStvRL8R3k0UF4jBenqOjT9WO+6vMStRjVao+Oo9kaH3V9ydKpYxCMHMNsQRwIcbTN+9D2VvV3fzo0eCxF3zD3T/gY4JTuGA+KrGN8JvkYCwU5vvL2wyBfArh4e1X5rIkq0UyKODQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVp+JjzB7UY6+Mg83rjhBGR8Ooz33Bn4OgOO4YwJN/U=;
 b=IPNU5N3cgw8/QtV2DVq9zRsxFnb2bEApqBujKmGcYH5aluSjCfW5uxy4oOXgciD3iLfW05UtbKhJ0YV8l2E+dWdmpUBEe2oQyJZ+vxmCNY+ax+3K0FawwUTe1dK14ydHx/pDJAP+Q1AavfJl8N/46NbOqr/o+x6sTN2DXmXZW0Y=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8344.namprd04.prod.outlook.com (2603:10b6:a03:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 11:39:17 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%8]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 11:39:17 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 3/6] btrfs: zoned: use regular writes for relocation
Thread-Topic: [PATCH 3/6] btrfs: zoned: use regular writes for relocation
Thread-Index: AQHXoNJMxJpgYjInxEiVISe4t1kgXauYeFQA
Date:   Tue, 7 Sep 2021 11:39:17 +0000
Message-ID: <20210907113916.lgujekdfeed3t466@naota-xeon>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
 <ac0fb08cbaada419c4e7a65a78793401ac557e55.1630679569.git.johannes.thumshirn@wdc.com>
In-Reply-To: <ac0fb08cbaada419c4e7a65a78793401ac557e55.1630679569.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 243d6f2e-5154-4ee2-a19e-08d971f4202e
x-ms-traffictypediagnostic: SJ0PR04MB8344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB8344F61DD79056807D07A1B68CD39@SJ0PR04MB8344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dRa+O9kwmLQqZjjmA5yw+b0zQw3+zzr6c1s0qgnYD1/GCppSadJjBVuVt/LauEyZG87yGBQrw4QOcqnMvk0Zxc6k+fqMNhZVODfsN8iQ+mb8ri4Z17+b2vy7e1Bjc5RnLZTkJk5ilFTfmaKvNgdJ2SLheWJFbEZJrW64vAB+526H/99n8p8S7iQA2U/tz6MjqExLjfXmeOHEfrLGYkqrWhPbdTfCGST9kUiE/Pt7TJZB8AvsbSWz16cVrE/1Vb/aYA9tR7dC8LJ+NKFcWbaRKt9aeV1VrRXAIxl1e207LTlajFGjEjKltxDVPLhykqqArYR0FsPqRmWsXfGuZ/1UcVNRua8WdTnVkOrgyWKUoYf1zKW8t655zljue9FVTedNOuMdxQwpUuNmsNFKkBirVJXWYC6ui8Wcx4vrIXeZW3/fKB+QzUQuAFh8otfGAQ04ogrwt6zepfJEjI2qqGo8uS+RX35pV7WfL5jS77a+kb3hoOxVqueJBkk0fVC6/OLqpHZLvFPGy7qbl5YYt/kcBnFyfLZpMWjYPPqvR3JI8Q591GA3tZLvd1W6FofsGU/M7zju2bdxgJ9teRfF8aiV2hmpa2nmFXKENNqlP9WFRFjWQRZ2/8TnoBGw20tHpjFY9dVnCo3vWp+nAkGwgeFImt/Y+Z6/k5sDvKfbAJ+APA5w8hHcDDdgyCIij1QYgMEEyy7AbdE0liGK3QuZYMTfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(33716001)(9686003)(478600001)(6512007)(66446008)(38070700005)(5660300002)(8936002)(4326008)(122000001)(91956017)(38100700002)(76116006)(66556008)(66476007)(66946007)(6862004)(316002)(6486002)(71200400001)(54906003)(86362001)(6636002)(83380400001)(64756008)(4744005)(6506007)(186003)(26005)(1076003)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d5eGNegiOwehj7vx6UpeSKC2QatmjsQZFZCvTGECbo3/X6bwHpVgN20hcEzE?=
 =?us-ascii?Q?QWndf1AtOi2OvaKw1cQefCo5OzHwOzebqN9/2KYD9Z1GNBrzCarn8/8A4ca7?=
 =?us-ascii?Q?pVGM7l+5Ik/sEUkLPHjDzJoeYC/EVNwZEPFWsi4R09k0QrGvudogxujrvtUq?=
 =?us-ascii?Q?UBiq8k6ZB3khLdtr1LEfCpfylzLOtCjR29zpE2ZmdH9Sw5+TYyp8EBuHCuV0?=
 =?us-ascii?Q?SkLJqKegOo1emN9I/MnwB7F3m8AfgHnPtr7d+RgTE0d1eMvaPcYWf/H6i2XQ?=
 =?us-ascii?Q?OqQJXjyWPyWMusLx7n7OJel5gCMVJTQvZ/MMON0HYMBWPScv3sSpQ3zwD1zN?=
 =?us-ascii?Q?BsXSIAeUC0/S0yBeVvwMP89Hjb4u214S1fnXU0z1uZ2Tb01PYb7cONtpfiUJ?=
 =?us-ascii?Q?iWhGSQ8d6Kye1zveMMswY4gjEqRU5XDh2Rr14jtWnT2+2FRdn6SGZJ4w9dKB?=
 =?us-ascii?Q?QO9UTePBJ3U9wRnrStEBfD34DmO5SjQ1/+UFLMAqAxrCT+1aWeYuxsaqMGKi?=
 =?us-ascii?Q?K0wcQwjZ2peko9n8wOBpI0V9Bsnjhqval1H7dVYwLDaLlX44Mt5/0+70PBSe?=
 =?us-ascii?Q?k75Rb+uUHbeZUK95Ng9bp0kfgKLOSn/smKHGWSwddpRvhe1tX6FGLpBeY9yT?=
 =?us-ascii?Q?NA3HgcUSnXEb6B3r9ijHTaea3erB7Xuf40HMJ8QogwYWgzkbspYlNetfyGrn?=
 =?us-ascii?Q?a18JkXovnWpp9L1Cd3GeK9GYldybsiwCz8bsDIF00mtF2j+3szwrCQsqSnAg?=
 =?us-ascii?Q?hQs2XNfiT5Bi9u3w2Mi8DNUDwAUNTQGg1O/JKN3xv3LnMX9RwlU1/Q0WVGv2?=
 =?us-ascii?Q?4W9BS+OB/Bb2CCxNyWiYTPQs1HNP3VnseCae4WyaoVhRHjoFq9CII14bZVtY?=
 =?us-ascii?Q?8x95VRdrXaq7aOQOs/HJ0W7IE4wyoXSBOGWRcrKK0htNlJEHUXBvAb07J2hE?=
 =?us-ascii?Q?F8oNYgJLG35HGH6RNElgXjtAvhHPC7G3bzGrdY9kGYT2TmAR2tsDx3OKfEUN?=
 =?us-ascii?Q?p6hL/ll+xtEa4aSBHFZUKTxCBHLON86c71azkm8B+A10z/i8j1xgjWIKH+a6?=
 =?us-ascii?Q?rmyIjgYJ5ldTEANHQIQvmGPzfXH/9LcKsCFRklSjQa/VnLeVQa23yfXMv+04?=
 =?us-ascii?Q?ySSuWsN97Sy/dKstbC/qOPwQUVSMUY014BOEJGT4/f4XNAkUg4LQGbgRSrBF?=
 =?us-ascii?Q?dxXvHFa49hiUMqNR7rMYzMXxYpwnVwQlM/mCTWO9WwQkS9ZP9nb4CFkM6tj6?=
 =?us-ascii?Q?NZ9bRgLVDHiEgDJespeCNrD87KlE+8HDNXS575Yb5mEExNO7l3TRL3T2y/8h?=
 =?us-ascii?Q?SblrsZ+o8iep37r6MKFM316ROIhh4AjjlP3icy9PrTMUPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB05E3C247369840B8FC9E965F368481@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d6f2e-5154-4ee2-a19e-08d971f4202e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 11:39:17.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kk6/iRn6i4BFhfyjrWkZpro73Lj6T9obtHIjMRoTq4QYVCtdsT6QX8IWE90e7r9pq0Mr3lYDUbYV56/HQV9SsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8344
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 11:44:44PM +0900, Johannes Thumshirn wrote:
> Now that we have a dedicated block group for relocation, we can use
> REQ_OP_WRITE instead of  REQ_OP_ZONE_APPEND for writing out the data on
> relocation.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 28a06c2d80ad..be82823c9b16 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1490,6 +1490,9 @@ bool btrfs_use_zone_append(struct btrfs_inode *inod=
e, u64 start)
>  	if (!is_data_inode(&inode->vfs_inode))
>  		return false;
> =20
> +	if (btrfs_is_data_reloc_root(inode->root))
> +		return false;
> +

Not using zone append for data relocation is not straight forward. So,
I'd like to have a comment why we need to use WRITE here.

Apart from that looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  	cache =3D btrfs_lookup_block_group(fs_info, start);
>  	ASSERT(cache);
>  	if (!cache)
> --=20
> 2.32.0
> =
