Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF14A28B2F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgJLKuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 06:50:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44910 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387757AbgJLKuZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 06:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602499825; x=1634035825;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=n4xcUU9zz3K3CrZpf+DZu0L9MJ6cMyDLrcLZ2PDbpb8=;
  b=av9pqaZCehxtcsB3+rb/Hqr2Ba9r4micr8K15pKdNJIC7qDAq6gDy9cc
   dVyf2yhkWcDWKlRdHgGrHWL6M+Ay2jLwJr3LZ7ZEZhH+livgS5fxIgmBD
   IwPVn6Nxgunn/JO7SibmllKZ2bUgYOJdW1dBssWo50u/IhFbWC5Jkl7fJ
   99jV2/9adNvxjfjJmUVjBI8oq60tn+VLTrmYyAzYUxEc17BzjJoW2RH8O
   yYgp7laTgdv7mGHa9yGCrMcX/sR+cwP6Sa5AF9+NcMngF5CIZFof9Zdj1
   SuYNJByIcdykVbJkBHqRdsuxoWTsf3+KqubXh58mNfGQlYphhM8oIydwm
   w==;
IronPort-SDR: V5PcpTUbVKc43g9KsUMqxfrDAt8MLv06THHf3BV9xbXoKBpHCvW7yhDb/YTi5JpdprlylY3F5R
 FtJLQvI8iWNnTFaOc9vg7wYd74vxJYC1gjt/gWuHXqXWlQ/amvHwg2LJdLgDemJFq/vcBnpY0T
 Z2UwIIXeEBw3rrFw0OL27pU4tw+OA9hthZ5z4KN6LOkmiCceVNxvL6sj7dov9wqYEcIj7s8X9Z
 +MqAubDNpesiJMSgxMZl+2EAL3vjnns3VWOI+NYPlUoz9fVP21wgExGGH4IpEtWkToso80U1A9
 f0g=
X-IronPort-AV: E=Sophos;i="5.77,366,1596470400"; 
   d="scan'208";a="150844112"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2020 18:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbriY4BLBJNMOwivrKAOVKzN2CxOdYNiAznJXPXqcZJNzLsUX6PGI6HdOjAuwgd2T6llQxwsU0i+OSZSoDzzWW5xD89zpCg4Jd0Z6d4Mu3Qwlwx7m9REO9pPLqe/Z38sih2ghCVgR3mHd+6CZnjlBZFN9zMHGNFJ3r+VFxvZ5fYc3vdw6/AfbnHE42XWLZcNNo0Qhz1gncXcvB5QV9S4ASw5tDznQqIvl+Tg0XY40TD9kVt5AABzpIn+X1EG5Htr6yg46uC1jkW0WZW2z4yk3EA10ETpjb7kXWQef/3MJhzQz7pmq+EtST2epi2GNU3RXScctYlRYgGhgpivapB8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKcniRfEuDLIBA/wWPb6+f7lshzfPZIhMjsbcBHcrWc=;
 b=TZ69LAwuydxBO9HwIVgmbSxAUS3RJSVW/3F/AQNGTT5+tHsG7Lufl5tlJ4qHqU/gZu5SiH8BC2veCCyckiGnkdKtvE9CSdL0BF/fgq6fUKx7aXxuHfj5bUBEAXMrEr80Ew+scAh7LqocedNELq+P/hp8BthAB4m+vONM2q3iV91xYSu2iRP6IzGMMEn2Z3Sn2GHWoaRfKjpMlqqBK+QSwMdryU+NiW+9atbrLkKabKCvQfc/mjUnVH0NMqEnLUhNJsyNXgIUfuI8FTw38SMRA2bzn93tH+RACaFELEojW9Kn4vuAXiJ2fswRER98x/a8s3QZ/jadGk9RluGbIDtJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKcniRfEuDLIBA/wWPb6+f7lshzfPZIhMjsbcBHcrWc=;
 b=UqywAM55ieLWavtKGEn/lsoEdzEtKMz0eNWBnEGUxVoYBvSpdrW/4eY6sPES/Q+DFR8Ahu9r6Q5eGAV6tnJ6gFq9jlZxqyz7e9/qlw8RpjrdQ6IIx/Y4PvdSbElMURNamcmN86ZhuwQ+Yt7vOdnaAH8nV+xYScmQthf9BLKw5tM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 10:50:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 10:50:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 4/8] btrfs: add a helper to print out rescue= options
Thread-Topic: [PATCH v3 4/8] btrfs: add a helper to print out rescue= options
Thread-Index: AQHWnngsp+QMWU7oDU+8pJWr9N7BUw==
Date:   Mon, 12 Oct 2020 10:50:22 +0000
Message-ID: <SN4PR0401MB359897C75AFC8DC45ECC4B239B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
 <9519d52d87d0cd2d65ba651a8a1282106d988d76.1602273837.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e00acdc-ab95-47ab-f03e-08d86e9c9e7f
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB4045A1A2ECAEC201E8386FE89B070@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCTRUJeplTdLIjSt9uZolqly3TNopVY4SsD+kQtYWSVQUXU4QA69mR/IEyq172FTyrxXrf0T7t5nugi8M8lDhVwm7kcAM+hcELf02uq8ghGVRKaTd3J/hWhi4bnn8gDvdjWWEFp7yD9dAXStcKvYe54gJVcvs4EVW5RpUOt07S1Qk30zNWHgy4PmhPdLZwqqzNw89HFf8N92Bq8RP2IhgPtsd+zBej4MKdrhBkPJXQs7wiCZaEiScSfx4ETG03ZbIKRlSU9iF4QL78nBdvydsmZHvVELjceWYe7M7jNN21I8iR27twqIuYvi7sGyg3vrkXpOjH0cwG338oZ02DL9xFcaMbF5agHCkn6u09xIQ/2UpjnTY1qS5uv29tY4m+Tq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(110136005)(52536014)(2906002)(9686003)(7696005)(316002)(8676002)(71200400001)(26005)(86362001)(55016002)(91956017)(76116006)(478600001)(4744005)(186003)(5660300002)(8936002)(64756008)(66946007)(53546011)(66556008)(66446008)(66476007)(6506007)(33656002)(151823002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8Ayo+JsJ1BkhKO6h/7HXbOXjsrlx7bK/VGZpfRAxFwL/MVWqERobsa3CFBThl/5FeE6ctwm5sqVvzxRyAjAQZ2KJiliiv8/DsIplQk6ZthihOn4GizhgT4+MOVOBaIrER/ywmgtkvpRpIjggqKb9xfEo6QKHIsKeViRg3QS+sEQrmq1zQoGzXsjIlKsgP9RT038+Id60mSvNiuCyocGCMHgKphCJPmoOPB4vYAvfobJFoGCS+JIleoxfHRkPQf7q/F6Y+U8lRimFlAfG3msSXRnosxJGS86Bh8WwIfR+9t8aozMPH6vaQHbydz66OoRE/tzOKttPkcPTjUCrXJ1eEetnPd6aPGllJ43TRsnp3CtT0VJYwDDjyxKL7RepGtl2ssy48HMW6WHXSgC3ArZCqouwAhg/EF1MAPeEZ9CfIHhshiccZiOcT5kDUSMiCTYXSjBAN9VcKV4OMn82cykwVDycitgMxupWJ9rBC7q03XB0QPaMXVDm++YdU6FKiVGFv/8D1xbNNF9EjTeZ6tDqbT3vbVls81OZYLKudM+4YS4joHS0uiwVp4YZ/luyr365jxUlx8Rvv/jZsw/hhfvWPurjEncMXqOAHtYFlSj4U4+M0cASrVG7tOsmBAntQ88PMnbfRIMUe7gzK0WNVkKn3Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e00acdc-ab95-47ab-f03e-08d86e9c9e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 10:50:22.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDcNqeNXPeZVQqutK5xTw9UDa8OBibcuGVjl/KYsBPaGZVyGiD69HxSBtuME5pC6TmhampLV67RqVByZvgIAUoKF51+LtcUyAB3S3nLRnyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/10/2020 22:10, Josef Bacik wrote:=0A=
> +#define print_rescue_option(opt, name)						\=0A=
> +	if (btrfs_test_opt(info, opt)) {					\=0A=
> +		seq_printf(seq, "%s%s", printed ? ":" : ",rescue=3D",  name);	\=0A=
> +		printed =3D true;							\=0A=
> +	}									\=0A=
> +=0A=
>  static int btrfs_show_options(struct seq_file *seq, struct dentry *dentr=
y)=0A=
>  {=0A=
>  	struct btrfs_fs_info *info =3D btrfs_sb(dentry->d_sb);=0A=
>  	const char *compress_type;=0A=
>  	const char *subvol_name;=0A=
> +	bool printed =3D false;=0A=
>  =0A=
>  	if (btrfs_test_opt(info, DEGRADED))=0A=
>  		seq_puts(seq, ",degraded");=0A=
=0A=
Hmm I don't quite like that print_rescue_options() is relying on the local =
=0A=
variable printed from btrfs_show_options().=0A=
=0A=
I personally would prefer if you'd either pass in 'printed' or define the=
=0A=
macro inside the function's body.=0A=
