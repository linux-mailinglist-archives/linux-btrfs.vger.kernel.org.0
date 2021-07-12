Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2E3C4B1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbhGLGzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 02:55:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23671 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhGLGzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 02:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626072750; x=1657608750;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AXbVvy1wnbgW+NYs34BOGQaRlctY9W0V9xIdoXaB+20=;
  b=mbuiP3omDp7eyY9myjko7YLM4pa2F9+aZ36GnbLgEh6reendF13RmddS
   GJSCtVobkS8R1ngp6iDLoXstzkW+ixmC8IsYZZg1HTKN7Q3FNk8vc1ItR
   c0HDAcshCX7dlPifeMNx5AwC8GwTJhu4jO/qEEyK+3dfNmuv/dFdhR2ew
   lNdzpuDRPSThvZmZGkJ789ruTCMiH3/Z2slufL/GvcUdAk5bcFpIXYy99
   O5PGUak4n6A/5KfVMru3NsPYLwgr8U1Gk/Wdqq+EcI7LsALebYTzS2mtl
   frWtx0ITfpIfpBPeSfI5daeF/rnOfpCyoAXfQ3ATFcGWxG3n0IIeEpjH1
   w==;
IronPort-SDR: YdQBICx5JGwT/KhY9qWAkuNK1XcZx24B9UXaAsv7H+oBK+lqesplzN6ZKqXzgqD8XZD2/61gnG
 4si9AbkVdbqq+QgXbVxvsHY9LMnwmaTmt5+dzQ1X8KZ+kgB0LflbwiDVTCrXS3aERZnHWHP6x2
 +TyCrr5Chi/OlmmCmJaoLVBcrmKeHE124VZ3HAx/3HejDEkeE1/UlwmbxE3no3nZREuKZg0Yf6
 j9bguL/fJ1wRLsN5ybJaCaR+VSEXm699mw2cbsnd86pWPWSV41CXI82T1eFdte0rhyX2sk7muO
 02k=
X-IronPort-AV: E=Sophos;i="5.84,232,1620662400"; 
   d="scan'208";a="285863969"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2021 14:52:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJjFH9C88I32eIVO6zrEFdNCQAOnHX+Byc2v8NV3ifchszl7hoCDxp9wCZRl8yErrX9Vac/UZB0dO+o0q1qBN4CnWdUkrwR3cT17al0aNtg8FMSjK+gfKm8cb1a1V7DQTR30DIJYxyuTKQo8XbrZ8/q1KI/gCetAJ9oEdMfzjkCKnN+oZPx9X9tTKJcrPEp7LlY75AmwRUcYvUMLWmtpEE5phglSrPuP0W1AHtUb6ev16ixRG+M2V07RbJQZPSHFAUm/oKInyxsIIMPcS2iCqXXWLkvp+ds13aKs5DmWhxJJap+kBSjlPt37QMFyFD2AOmcb6LsuzVAHeg5M+Q37EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6C+mRfxpE6tk5ttjmokz+/nGK5IoLSA1VygopaACgg=;
 b=YYFNclXOW44Lb/BxIvWRcYZ4W576vz7O/y8XtEMEladeXdutGwVHTREFfa4Ms/JOKjf1+3jhXoOh4YErtgKQ4yAUpxxkOedU78xnv5GCInHnwFPKPe2yl7NCkKCVx237Si6sQsk1b1+cjOZ1RPvFgKjTJYmPTVGzNsaZvQF/+mvsDo7HwIwFUoy8A2J94X7O5QEVqmQn+LU40f0mk/ZgMuI+NBxKriSs6zv/fTuxLglYmFNK5ni6nbwjZrnLF8RLlIiW/r7e2BhoMhoT7u52LZ+4IZ4K/C66OG3xnLxh2L0PYUxXxbtgkaKDkAmn4tLVxWLlcuZ+WNBbwQ8w0MQwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6C+mRfxpE6tk5ttjmokz+/nGK5IoLSA1VygopaACgg=;
 b=rjXW9KqLANWI8wGAMpZSw8v/hYgMkMLLSZUPUVPP1tUHS7W1C2Xgikwa7OX8gMXkrqBkQdOqB8BlenG8u/vLtTSp4Vpe66GBQNHfJ4QIXgL+dvl6h6B+dBo5//0otQzHnlfTtBxsj8eeWQim62dzfFWBmYqPUOClBAujSXaizrM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7144.namprd04.prod.outlook.com (2603:10b6:510:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 06:52:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d978:d61e:2fc4:b8a3%8]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 06:52:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Thread-Topic: [PATCH v2] btrfs-progs: cmds: Add subcommand that dumps file
 extents
Thread-Index: AQHXdm9EHlPaAOJvPEyD5OqEOntJUA==
Date:   Mon, 12 Jul 2021 06:52:28 +0000
Message-ID: <PH0PR04MB7416299F37110AAD9FC7131E9B159@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210711161007.68589-1-realwakka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b9bb828-42d3-41c4-4988-08d945019d8d
x-ms-traffictypediagnostic: PH0PR04MB7144:
x-microsoft-antispam-prvs: <PH0PR04MB7144775BD60B39BF74AC0D419B159@PH0PR04MB7144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWAXv6eK0xYElPJmWrcGJ2K8bJcVr4LsxhCj5wr+oygdXQnV4VMPIHTzIeyl5PPWH7YOjqhJVd5WjUDfSvfuc+RSGCT6etH25hmhHydqbu6jY6YDbn6RBflMSge2BNW50Cy4pxzS0Cbx2YTZaWopkNIF1/Ol/C3GSJwZPx0xJZuiFFJOtgPKxzdfiYRIFztUB6MW3T0woAb7h+mY32l6NyqI5LdTP7FXNzzXvuPPFJZ/2QQwWO8ksvAAlCIYTc8fQdbg32YQ+1SuTrSZsgyvdqClgqe6p3bGygHoIr8HQZMkCff0dmSR+TExleJGIMRmEz+WuPxessG4aizlg8arPPLMgDKzs7tsbJAJBgL/kOgby1voFHLEJ1TkWBTbJCjJfVa345JL54A/HdMCYdfiLZSOX9QZpo78FxRKXJuYPtOH5053NYzebN7y6ECfkMsbITIaYS6JGAxBRizG0fKPy3/AF7EnUPZib3TotBK2g2eO83vOwFDSG0Z7+PWUoE9/qhgfJBD5PuSXhaaGXkPnNjW77n2LecTzxCmh0MCXQxtZfVHJASa8yjoRfgNVbFVUjOxtPZARrdQbN0Z5woAwMXmUKgiXKS9TJmuPJ2rOk2eDcKILNutkdzzBpvavdScI4pRBE+X1Jsgr6UdYIt4b3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(71200400001)(186003)(52536014)(8676002)(53546011)(33656002)(316002)(110136005)(9686003)(122000001)(86362001)(38100700002)(8936002)(66946007)(6506007)(4744005)(5660300002)(91956017)(76116006)(7696005)(66446008)(64756008)(478600001)(66556008)(66476007)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4EEX0HZklmJJ8blJBWBMUV5a9FeHU0rICNFtt2Q1KGgymQddICUQtoXp5eWv?=
 =?us-ascii?Q?N8mPm8uXxcORxtrFlBfk0crTl/QCkur4fqIR7f1zEAelqj7ClgrThgp/o9ix?=
 =?us-ascii?Q?DDOlVYiEm0YpGm+egBjHa70Vpij88ohO+W7hvPlfJiITq3jjocejURQJ1o0T?=
 =?us-ascii?Q?mbVsRxdO8bgN869E4oQN6Xd6XzkmXBIYRCZcnPbOT4G3bObCt56aNxZxH8Ia?=
 =?us-ascii?Q?YPY49vNEKVkTj/dIPknrCIDa482YQLJmVCE6nYSLo7vaAxx+MP9s/OJF2KII?=
 =?us-ascii?Q?r3fiVHPh2Fgu00aLXBE1Mn64XFvOKwvEaj8OfrQ9j2b4ONyNiBXWIspXWmJ2?=
 =?us-ascii?Q?N4KywsMsoans+V/RLxJKEWdGePaQ3ZuXXMl9QsqpcDa2wOCV/D7PxBg2eTHu?=
 =?us-ascii?Q?9C2fWqnTzfyXXTDYw3jDPVnAGYXMETultP81r4icQvH0Ml17sxBYrUiS+RF0?=
 =?us-ascii?Q?pSWVG07jLMDYG/b1NEflBsaoUmbqyWGdwXVMxyyBFdPLqF/PFyyysShihqCa?=
 =?us-ascii?Q?Rw5zSBw9JCifKIlqZgqhni3bROfHScPjdF2Pzpnzo7vnegyUeKmO/ff9hJOi?=
 =?us-ascii?Q?DKoTQBwfTf/RZV0k2kUkwuyCh/+FqsurHaHn5ytWy5dk5d5/mOvRZhZ6NDMl?=
 =?us-ascii?Q?ZLXw3KWikwPs/78V3Y77HHyVD58navQQRZ4UCtyl3OefgEPm920iqeO18dLh?=
 =?us-ascii?Q?1ip9WsE99aDSwno/bZZ+I6J4pCYUSi69ZgCAPXH8NhDYLsMyAW67pKYPvdki?=
 =?us-ascii?Q?d4GulXOMlTO5tmHr77rJpqDGMpKvNApqV1NpXSLbTkPOgktEJaUV/1+iLalk?=
 =?us-ascii?Q?Ro7GHx0zqhJlkcfg9zEjuUAJIjpqzf/X1Riy1LDVv0OxI1KWJUJNXgRsQJbC?=
 =?us-ascii?Q?96J2Q46NiJqOC5nyKT5GPztsDzEpjCJ/oF5lYa16CnT1ygBTcD0/mTyAHY92?=
 =?us-ascii?Q?8P0dpK5DJL2dU73Z5m2GbTUClq4gcweTJ/mtgit37IV8pOp77Sn8tipkJ5Ly?=
 =?us-ascii?Q?Y12zINJs6BS+V2rFrwC7czVjxFdgjSD5oTBw2kOaOtohh26N4BcH4PCkfekh?=
 =?us-ascii?Q?ft1XuZis7NLSM0LtAK3YNx8I+zsxBz6XyF0svutUBp7BIsdJXqEJj7ToC7Qd?=
 =?us-ascii?Q?Qu1i3emnfKxHOsMTMs9pY/dpLAnY9FukqVpm6BpVqKc9F08Az6onDo5gQ3cI?=
 =?us-ascii?Q?2iqu/F2Pxwl7Mx+EC+UaykRAyyvKQp9Wp/5tVz0BaRq92nF+WWo0dc/6Aqg2?=
 =?us-ascii?Q?o4d0K0Cj8ueSqhkWZcUHUksq9moHtAipJvplsYpnLszLH24OIxuNqnO0Jajw?=
 =?us-ascii?Q?mpiYAsYMJusSMuV1C9xrKLw5fsGXcGlslLwNaE+mk92jxK50jvxsvK7BNZoT?=
 =?us-ascii?Q?mc5LDZfJHU2Rfec/MVbPFEv1QIimuvx9QNnDz6aF0W2ORXC6ow=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9bb828-42d3-41c4-4988-08d945019d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 06:52:28.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjP4o6DTOrs4CjMvSaJw2LYVikD14XzULPSFvs+sdiWnLTmeojLvPRDCPzwv0N46jH7548B5fwpuYKERiqIKgdlyCfUyEb7k+SS1jgF7PnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7144
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/07/2021 18:10, Sidong Yang wrote:=0A=
> +static void compress_type_to_str(u8 compress_type, char *ret)=0A=
> +{=0A=
> +	switch (compress_type) {=0A=
> +	case BTRFS_COMPRESS_NONE:=0A=
> +		strcpy(ret, "none");=0A=
> +		break;=0A=
> +	case BTRFS_COMPRESS_ZLIB:=0A=
> +		strcpy(ret, "zlib");=0A=
> +		break;=0A=
> +	case BTRFS_COMPRESS_LZO:=0A=
> +		strcpy(ret, "lzo");=0A=
> +		break;=0A=
> +	case BTRFS_COMPRESS_ZSTD:=0A=
> +		strcpy(ret, "zstd");=0A=
> +		break;=0A=
> +	default:=0A=
> +		sprintf(ret, "UNKNOWN.%d", compress_type);=0A=
> +	}=0A=
> +}=0A=
=0A=
[....]=0A=
> +	char compress_str[16];=0A=
=0A=
[...]=0A=
=0A=
> +					compress_type_to_str(extent_item->compression, compress_str);=0A=
=0A=
While this looks safe at a first glance, can we change this to:=0A=
=0A=
#define COMPRESS_STR_LEN 5=0A=
=0A=
[...]=0A=
=0A=
switch (compress_type) {=0A=
case BTRFS_COMPRESS_NONE:=0A=
	strncpy(ret, "none", COMPRESS_STR_LEN);=0A=
=0A=
[...]=0A=
=0A=
char compress_str[COMPRESS_STR_LEN];=0A=
=0A=
One day someone will factor out 'compress_type_to_str()' and make it public=
, read user=0A=
supplied input and then it's a disaster waiting to happen.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
