Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7A36EBE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbhD2OF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 10:05:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46173 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbhD2OF1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619705081; x=1651241081;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M/13wU16qtVfA2N/BPhGexrA5w8SHAxJnCu1jOOH7GA=;
  b=HSNHWUK3C+rw/kv8znEqDhqXw/Qql8ehn4lGRTa8nfmHsyi5ztV+8Kph
   GyTI4Uc3ZS4YNl6oeaguZuu6IsjJ7DC72OL8W1m2MqPvf7Z2MXD4KEJ4r
   l2PvUZuNuKN2mH9MreDMUrkU3Np2p2Mdc5i4k9wlW7HyN/4OfmO0wVC2s
   HZwSpbgVOgpCz6ttRmGZTeME2o/zoQh22L4S0BEJpJ1PiOEPH4A/uvBTk
   PTAAf74RKQGtHROHwopdYh0hig2am0uHjFmMyLFcKdTsjt55wh6TDhxrQ
   M5YNsuKE1DCQ8L3UcFxH0/QlRECLoNl8CKejhoGKHhyPYg9ht5wytqtBd
   A==;
IronPort-SDR: uoYbfWJNoDg10lXV1hr5iMxfeOa69ovDr9zJO+M7QhqpeuN2VAiFTiCTG7ox6SsTF6tpTGlKkk
 CIPHDrE1Sic5YNuxLwCjNJblq9bqdRWkQvVOjeFwOtC0820XOeLrU7ekCAuod0CvsT2SNncDot
 ozrH3Ow7mZ2dDuEGhjxLaEZq4VnABQyhRqWS9hx1jKn44QyUn63WGX3ZaWyLMLtO8RB4BUn6hf
 9lwXSQXOj47AbHEp/FjKdYYA7UJ9fxpF5OUlRQqWkM7FFa9zCRlaIazDAgeBRMK98oyOdWNFJ/
 Bok=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="277697175"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 22:04:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF3NyPQBAFzz4OsB6EvIIEjdIG78zvnMGthzuaJnsTrTm2ncZZgBYtQCjQcHONd4Bpbo22ArDfTsObuqy0oTTioZuLx/15NJSsnyBfoWEfQdv4UIaT7CbuDOPTRe0cH9eVJdtEcMteM9jwcVF04RT02JRYhOD9pe5dOip42Bk9jARcT5MUFipZflMACMqYn9MxN6UN2477xSghmnEFnu+5F0lAhsKYlH9Mz0o0N8wi8gZ9E1KP79cqxDWTijhMpju2f4TCPZUXi3ckMgzKMNOAFLPZVSIXz3966Qr7jcItAxiL2OFI5yl6Y06xGeTcQ2XP1ZYuLu/JsIZQnC3SraEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnj/uZR6HV5jtC12LpPNdgEi/uGNGZ5EjDUwBZy4RjE=;
 b=IlAmXZuodl4UliQmXZThh3bv5Hm1xkcyZr55be1Kt3ah42r6h0EmzNDYcEiEXjI4kGZdQlDfQsZeSJS8SoDm3+IJ7+b/LJx0qRGXAOKrBaa07ys25RLSxzruOqkFFVkjYG1cOHc0eE8yXNIwvqYiX6uzNOgbdO0QYtxzBuUx7DEaj3DaNV5WaCK4eqST8oU8p3uJdqnM5ZcPjLhF3qIN+9ViIfkpQSQ1Do1RhK83nMNIjKISDNDvI69KkSUKLu/2UZcHRnCdpPMepTIpd6SSdlR+WriZHgI0lRTDCyH662YCF2I5SBZxg1PcEyhTEOKCIitFo3F0HACXBLsdeTOc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnj/uZR6HV5jtC12LpPNdgEi/uGNGZ5EjDUwBZy4RjE=;
 b=OEanWTvHxZdZ8RZulqkxU0SzglhP4a2sTYTiJk579t9GW0LC1R4l/9BO6u4i5fQxmp3/DBffX8lN6UX9TRtMfgkXkU3/M2vdv6IY00i9iFWG5JCY+T0lACD5BzD5VsiFQiLOXOSLUke7vf4hZOmqeBjHzANlBM09/xw0nd1J+D0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7317.namprd04.prod.outlook.com (2603:10b6:510:1e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 14:04:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:04:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 4/7] btrfs: use the global rsv size in the preemptive
 thresh calculation
Thread-Topic: [PATCH 4/7] btrfs: use the global rsv size in the preemptive
 thresh calculation
Thread-Index: AQHXPFWSLIoGMVoIlEukUigQx6+8/w==
Date:   Thu, 29 Apr 2021 14:04:38 +0000
Message-ID: <PH0PR04MB741630B03D3693142C46EF639B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
 <31114026fc63ffebcdc43197fded45da7731ef03.1619631053.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:a91f:c11b:e39c:d980]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3747afeb-1d13-4d83-7905-08d90b17ba40
x-ms-traffictypediagnostic: PH0PR04MB7317:
x-microsoft-antispam-prvs: <PH0PR04MB7317436D734F94A8EB19BF989B5F9@PH0PR04MB7317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3go9d9B2vWU2prHe+XJCFOj2vJqqKXfAWs+D3p8PPxs128dm3R7D/Qd98CWHhVoIkLfyOwXlltmFdMe9pRXbeQbrHjQ+f2rly+yvblyRPAyRXZ9hpOBWTNUADzh273Yciuvl00rNB8uWd9EPzbpewDrtJ3juav6bX13WWwQVUxbRyQMEjD3Nu3ndNr77qgraEqK/ghs87aAl/BywUZnR7Vf5hObntPnJ5xsHTtpXuy0UBErVxCIg33wuS68/bqBwlpnByfcoPz1U873VvZVjVOJJjDoPIRdM731H0ivYqMH3YeFovmprp9xbZBMzR6uD1Z+dYu9r3mDV773h3x1ZepsIhHm4bj6ZRwWKCtwImfQqWzUP64UkrJVGKE5dHrz1qt7t+l+pTl8wGIv74ItT/RTnjtczTZscvnnTccgq28HnqE53hbtgqz8JcTuIuhlcRmm/z06b6qBEwdxt1dG3kKsT71HR37YZGNt7R3m1GTA5cBFLJMaspKa5x8/QlI1WQFlpKCjHJrtTJowQVdK7YFBXv72+yn57RBhukQHL0RNjgFKd5jKEUIPXBOdWqCv5vG/OoaAQgo9V7YepoinLdfr0wkt/ME96j1mKLN+qK9g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(66556008)(7696005)(5660300002)(53546011)(64756008)(8676002)(66476007)(55016002)(9686003)(2906002)(76116006)(66946007)(4744005)(91956017)(316002)(122000001)(66446008)(33656002)(52536014)(38100700002)(71200400001)(6506007)(86362001)(186003)(110136005)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SK3c6KfcFDfJoxKV+M+u4aWWCGsp4bvKa842I/CqLVD2qYWLl6YtB3Fwq5B2?=
 =?us-ascii?Q?k21CPPN4ybn1XO/9hsZNaTPG0PnEhyrbVTZZgD4s9hAFZ8aV3vhXmmqhjDd9?=
 =?us-ascii?Q?3UMYlGg6LiETzhmqRZGyshJ93SnpcLzhbWfX5+Nn0n1QXIhAOftBXAHlWFOa?=
 =?us-ascii?Q?1XGfo4gQzoTOpYGq1Tj58yUS6oN10Aupd697tW9YQAqlvICPtklznrWzO8nz?=
 =?us-ascii?Q?Ya0+USSrC/yM53CYi6F3IQUEEeApu4nYRix0lRqMTLbW+/UHGIU/5hovPyVm?=
 =?us-ascii?Q?tHKzebUAbarvDFwU02znh/4+M3+cDpzqdzrjR8jgHYgievseSS5WdNK/S4SW?=
 =?us-ascii?Q?ogPcYRCJh7ZTjZgnU3Wo+c6K+bW3LBPoJEZxmqSYuNBlsrln60eGEu8pImfT?=
 =?us-ascii?Q?SWReIvc/SbWJ7Hhgfr8Wc7sVUWCeljSt/0cQUYoMTW/WKj6jfza707G7ap1r?=
 =?us-ascii?Q?Z1bjT+cyh32a8XcJIZ87VredQMVSpIbbqD5y5ygvVCbsGKWe69aFq2c9HqAl?=
 =?us-ascii?Q?RQdgEdMb2y/OKVo3Z89JHAcTeB1lxdFlCwhlKRqjWIyiCGMDSfAXIZe70sWl?=
 =?us-ascii?Q?U54KDJiMSSeA+mEiCeHrGlJyO+sU3PsecynF4mEdPWkfxx5nDxOhmt7Ccdhg?=
 =?us-ascii?Q?wStShVGb2+D3lu0PjoAq1BhXE0PhYShwFkFeh7W0qBoc8LJONoQK4JCjSSVN?=
 =?us-ascii?Q?G23pMhGkFuyYYFqCcdCQFEr3Vb+JzpZyh0USVBic0iB6z1p/IkSh0GzO59TR?=
 =?us-ascii?Q?Ze2IYQ25iRBdB/caeHJELAqUl3RBQusH7kdLL3RCegB82wiCIAhu1L/rrNEt?=
 =?us-ascii?Q?yIM+MNxf8LzOALzoWRxOJsrY+fEB3EG/nbolJ4IPZ48z0oBwGZrzIx1yExK2?=
 =?us-ascii?Q?eE2zX5LncIubnL1i0X22polPWfzvsu6zAomQ0mITMpIjX0riSx0gFSlvaEp0?=
 =?us-ascii?Q?LyIJK2PbdZ9BTtSHEmKDTiQ2ib4bQ2uLA7U5UzuTxSi4Oe8fMADdorfEjBMi?=
 =?us-ascii?Q?wekIOtfGBTbMmvXtWTzaCSngW+dDY0wcpHmQxBG6jTioawUDfGkB11YrOT7k?=
 =?us-ascii?Q?Y2lRtYb3RyWSluLKAJGy55kYj29uVTjJjlLvf4Le8YvC4Fsa/pl9Ff24VQ03?=
 =?us-ascii?Q?BvcUbCVXDsRCpVFt0uz+cy4ReCWfk+kfQyT2gm0B1tnVEqQqUREQ2v7kH9NL?=
 =?us-ascii?Q?fxrh8m/9L6+rXk4pocb5X6DwV5MSmDIGlotDMfxUHjczjFrX04Dv+Bf0Krjy?=
 =?us-ascii?Q?mZkVg0TbEDpfrhQB15WyqctP4dUoDHd9mtvV+QDAb5Qu17xOMQPSpIxJ3x5N?=
 =?us-ascii?Q?Kj0ZydGzsG4rl0BqK2qq2HUoCOI2Wg9IbEO0Vp4pcw6gO+5EmHYeM7MO8r25?=
 =?us-ascii?Q?HTl6CVCpXByK3U7g4rySd8iT4gt4/tkFFQv1HpaDRvV6aMgzkQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3747afeb-1d13-4d83-7905-08d90b17ba40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 14:04:38.5630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNs1+YecdxsOVReMpS20ywbCAHCDXstNwurscl/jLmOlonA/SsoqLSu864Lv/HLw6LtkJBapkI34Nye/PDkHntXp6jldH/K70/YDHbm2zNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7317
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/04/2021 19:40, Josef Bacik wrote:=0A=
> -	thresh +=3D (space_info->total_bytes - space_info->bytes_used -=0A=
> -		   space_info->bytes_reserved - space_info->bytes_readonly);=0A=
> +	used =3D space_info->bytes_used + space_info->bytes_reserved +=0A=
> +		space_info->bytes_readonly + global_rsv_size;=0A=
> +	if (used < space_info->total_bytes)=0A=
> +		thresh +=3D space_info->total_bytes - used;=0A=
>  	thresh >>=3D space_info->clamp;=0A=
=0A=
=0A=
I don't quite understand why you introduced the 'if' here. Now we're only=
=0A=
adding the new free space to the threshold if we're using less than our=0A=
total free space, which kinda makes sense that we're not going over our=0A=
total free space.=0A=
