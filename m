Return-Path: <linux-btrfs+bounces-1605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD3836A22
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 17:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A47B2CF47
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EB12DD86;
	Mon, 22 Jan 2024 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NaXQ/EwX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Crg+79r6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E312CD8B
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936352; cv=fail; b=GY6/t25/gjqUQg/hgoa/xVZpmBDAJYBmkmwN3NubsR54tSClRbIJELjR4NJf5V54MdtonJbpOhp1D0G0MeHhfhnZSro5Syw+V9ustESjY0nbMZ9orax1VXvTic50+Sgr9nw7Z1haauVbRZd/H1vM3cIJ+8KyNi7rn1Rw2fz6A64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936352; c=relaxed/simple;
	bh=n+hOHWk8X5wwLnH+nxBYU2pvi2Evny1/OmhK6LGeSSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NTWTMDgdXB7R/P2oXE8agq+PY1+hLc8Yhjsa21eLQ2zzH1lRRA/IjuHYAHgVpJaWhZ4/MNCYVJk5lM9WQ62enYY7b/yVMZNb8I7bPwUypaW6G7VU0Cg8TYD0XBL0T8ubUdrGRt+OWW2dKbb4sQJN38Vy5s9K5NpGvHPmJaZJyr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NaXQ/EwX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Crg+79r6; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705936350; x=1737472350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n+hOHWk8X5wwLnH+nxBYU2pvi2Evny1/OmhK6LGeSSc=;
  b=NaXQ/EwXt2P6y9k1b2WAuw/l8zlQL9wEh11OKq4nREeaLNDRfPfnGU+S
   WvH2H6l4va2hCNaIolSoa+CnJHV5ePYYGK0na75HIeDgCvEo+31RD9gtV
   8JttdIOIbk9HHUn6AkXRuT616ehHuykAz+VtomqycnMKXK7amgNrbHPO/
   +ahy9FmhwSrzPe1RDciGuHNwU7SwB7rXKXSpE82kHNJH/yy+M9EKjZkWI
   d8NXl3MfVCGVkfwFuoAjmbntqzqOrIoBeGutFwOHpirZL2rZOoLNEcLFK
   WDqHAOwNN1FTijfkn/SpagQ2In8ncxgfUorf36uv6SvohFbmNoaTiB5Yy
   g==;
X-CSE-ConnectionGUID: JgEpYTdyQbOUp1vyekk6rw==
X-CSE-MsgGUID: Y4ZL9hl+RrCY20znCIAj7w==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7442749"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 23:12:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTu8T+TIAfPbMVx19Zq5urM0U20ArHwWISWcRmssPc9NODNH6RZAhmM6aeQRs6GMqpyF+Y3e6IFWCmKWLhEMedck9+e+NNvZaRCBteCt7BuZzjhxsrT7SS0O40o13l47dUOZ+7unFy7diHHaA9g8ZPMs+AT8tCT+HEvtnB7OGiKl/oi3uipgRe7FDGkdAj8dZLJDhisfVRVtkfQ7qT8CuKtJA4F4sQyXJr5EUtLfy40EsQDKmJXD0q5smnvLazyIv7XGRxg34rIJe40iFtTp/75ltq7UKCAhfpV+aC/lsL3y6VqqsqPST5J3zklyKYbrSH6eE7rAJw87OcCsF4NoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+hOHWk8X5wwLnH+nxBYU2pvi2Evny1/OmhK6LGeSSc=;
 b=JKlA0w7KaGoQLwNCXG4ZnTlFpHPOH15crpeBJOjc+e75U3gn283nBnrn23fmhX40CW8kZ7fedR3kSlf4Hw0mJbA3Y52ke7Lr98rRiuNhYBczLO+200q+JbD6rz8XWySmLn+uCAJy4ag1fmM7knH1EVexU7Wz4rOd3raQflRo+T5xS7W7ZsKmu/RaOJcj4tdoVeVEEvyi53Md1Btz0qZKnUZ0V+J9jCfi51EMdp660MsS13IU6wY0NCqtIAg9wbiXX3iZVaoCzCWkG2PhALfvWu+x4KbZJ3DbrqZjvtoF25mXKsrVpXnqHTgutCJq5aORRhQZvW+oY39YHtpFlwvnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+hOHWk8X5wwLnH+nxBYU2pvi2Evny1/OmhK6LGeSSc=;
 b=Crg+79r64wh2a7CqjmD2FNwP54bLL5NFOd7dzAijAMceWnciv2pCy+Lzvtu5p2QhJvK846LT22hxZsvGDEneLlfqQWeuGMmwkFfeyxX2sg6WKgv9ubxQmZmm0ytTObxAyOgSZbSnvQ0uivFtnXwU7WSVICTPS5XTwjQXYw/2Bfo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ2PR04MB8847.namprd04.prod.outlook.com (2603:10b6:a03:541::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 15:12:27 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:12:27 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>
Subject: Re: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Thread-Topic: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Thread-Index: AQHaSewVbT8W0k+HTU2pfeXHKHnXkLDhTY2AgASpawA=
Date: Mon, 22 Jan 2024 15:12:27 +0000
Message-ID: <yr52hylpfmflnh6qpmzij5u2jgfj472srovdbl7uajlpwsrpry@sbeltaqj6ubn>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <20240119160101.GT31555@twin.jikos.cz>
In-Reply-To: <20240119160101.GT31555@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ2PR04MB8847:EE_
x-ms-office365-filtering-correlation-id: 28ffad3f-5638-47e4-8ccc-08dc1b5c8b98
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G/hiK+XJZ/+BYIbZU7PlwayUK9WLgm2DJY9uReZuo/zjXhHUukGARFeq+CPUTD60+FJa3evSSjSaMsVLLMmth81+guATAgRYKVYhAdMnx49WQJILmjeB7T0MtOTcZfp8jkdhhpm9DerERIUe0D2EKInf5n5r55YBCcjXK9EUZHKzlGKruD40i28pTy4RxBYvLU0VejTJSt6DiwmO4h3xQRNQ3gvQbsiSJEkCw7zZxRTsTs95j12NDQ4vQDjFFkFBhBOkirDfPugkxwHf0eQWgm4dV86tk2QQ45cmw1k7EUVvn6OEr+/Vn519NEuCq6JG+Ni/l1IZdgcgvPS5cm5TS/MLyZXfKcWMwbd8VwlrDfLeQqWZJlkQKZC2veUmwXd4PAA+XfQn6PCbpImxSzXVOPMXl0H3RUIAtRbQVTiNq9WDmSegU8M8M+6D1PXkZOFDdKziOBV7/Zg0z+ZN2cNCldracxSFU8vM/nI7Yrpu3EyTCGnjX1Fcrto39HEZTUP9mZRMM7CDmmFFooRO3ngz1JH4q1nyarxlpnSPTBMyBXRgIics63OW54X8KM6QLqLbOFbo3KkmNxb/eoOhG6nDIN7Z97DLjAHofk2fCeyRL8k5PCAiBMxQOYTZd4PS21mYYo+nqn5hxCsYUrOavL9tCg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(2906002)(38100700002)(122000001)(38070700009)(33716001)(41300700001)(86362001)(4326008)(8936002)(8676002)(66574015)(71200400001)(6486002)(966005)(83380400001)(9686003)(6512007)(26005)(6506007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(54906003)(6916009)(316002)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NYXKOej7AmWJqvIQC+5uVyQvKopBnJ/B3f0qK24bUHDaPqZglEuRdlJN8oVf?=
 =?us-ascii?Q?DcLGH01Notmi6VqrX3ilt15x8Snz+Xf6dQ+PeataAwA1OtcV+bH8jeLP4Lso?=
 =?us-ascii?Q?HxfW/lznaEDLH5ySru8U2ywIG2FdM84RiieNmnMJbEhtKqPuVgTTBdrb14eQ?=
 =?us-ascii?Q?P6P9eadCrcIfWsIno0exK69ZJ/Z/KftBfIamlVWkxsB50MGa9cx/7+HSr2wu?=
 =?us-ascii?Q?azLORGyfF2Xsz2jW7Jpqxu+VrrJ0Fp69cegw/M5SaLvbE/RgzVZFPpbR0fkT?=
 =?us-ascii?Q?iYMkTOonWl9o8SShcWfoy2m9Jj0pVIhEYoudqsIQlaRD4l1mwbX6Xv9J86IK?=
 =?us-ascii?Q?A/z6f9He2htvuen07UqP+kjuPQA756UqhhsK+cCYoEqLhxYQL1oX5bctIVwe?=
 =?us-ascii?Q?MafNpPaI/tHQD2mTncBE8FXux4Lh0npQ+6pU8Bj6Bo3sWwtr5Yu2iU4Xsp1B?=
 =?us-ascii?Q?llUlQdb6YDoCYkOWCbmebVeuGxQDT9x5J/KF8pyvQFmoIV9sDfwXUBR4DjcG?=
 =?us-ascii?Q?bbptO7XZ1puIbq2OXcLBUY+WbDs+4UrETRjvsHJfXCq8vbsfV5RG46svX3rc?=
 =?us-ascii?Q?Gl4+WDh6rGjSgh7AyFtidY6spilDiZSuxcOgPmOKjp/nOaFgAwu1hDCbA9Qu?=
 =?us-ascii?Q?YNc17q6QQetjSq8PKrMdT0Hn+2G7Y2s2PmfXHbRT4+KadZGffAufBBe9x9pd?=
 =?us-ascii?Q?XEB5gYwbjMUuVpjgjJ8Ngt+iYfCb3yhlflvcaIBVyUEMomkNsqB5ZcNTWPsK?=
 =?us-ascii?Q?lI+nf2lfNi7rK+vnXJZRkGoXl6UvYB5OrmJuQycV5dQlluHMBBUWb0J0pZx3?=
 =?us-ascii?Q?3IUWdt1+R3I6uXo43dwcZarw8GXAuriCaeoC1rB/KyPEtX8myik3HS+BZ9lp?=
 =?us-ascii?Q?OCBHlOrRNMmZjyfTwvcYe9Beyl7WwUNCt0V3qyaarOrazUAJBWDkHOkwOEXi?=
 =?us-ascii?Q?Iwbh/emxHBqOhL5PAOZVnGhCYKPGedYYgBO3dhGaroGrtrk2K+4+M52QxT83?=
 =?us-ascii?Q?Nob7KlvANYau2PIFB3mWXJC68IEJadWnQpElx9214FSV2dpRp+mcrBn2p0EF?=
 =?us-ascii?Q?I1FNG04yIROM2BZvcGNHl5E+5KE3iGK1jmzmwIxVgi/X8l6kBgjXOzAgoGBj?=
 =?us-ascii?Q?TXXzNRQwwGQ/dEd0zDiW6c020eUeM0l1K1klhJMjUHaw5Jp4R06WtgrlLAUu?=
 =?us-ascii?Q?of0MMkz/nAHCaydaD2zYPpwp2R+pnUh7QzFXP6nZkzlpaAxANMRaaCSQj+7R?=
 =?us-ascii?Q?W2PSIBwvF2MZAEQ/IG3DASPUMSsUT00J4SzEa1HV6Us0V7CcWUmh84KQEszJ?=
 =?us-ascii?Q?BKDeujf7DZNAVC+YR0/BsnRnNmUmhbAN+YWwRIHgrcbjNLKOIjmj7vKaGQGi?=
 =?us-ascii?Q?9TPTIYG4v5sNeVZoEGgyWlrX1mIXWIsyz9iAHPGtHds8sVsocYBIK17kSVa4?=
 =?us-ascii?Q?8z5Bye4cdNmqhU4kTCGb/rx1ILDBKtuhtRLE8oWHlhHWSCSnap8oeNniT5Uw?=
 =?us-ascii?Q?DYPwT9Ej/z5DWkhpDSxPNNkPQgRrljS35QS7bKUJkca2nQ31cDstFYhvobqB?=
 =?us-ascii?Q?dKKQffzIocw/qHHGqRQCgg1xUHbasXwvRAmPvZWCSqvvMsoslhGJdKBNLYfx?=
 =?us-ascii?Q?zA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4175F499464FB14F83C9BA9A36140B99@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YwI5+O3DSduEv+UUxNyH/WIoP6tKAXC4evaUMxDNQnD3cE6SoqGbyWERP0MCcW222rWmq/KQ6VN9g8gmtEDaYEZhONm9hrViwjdU9kR9jw3IyAGSV1s7yv0w5C+awHmmctIoAnB6PBSYGIGF+4SiQ3ekEeb0S5Swk94A5lCehkSe7BK9ZKbPw65Mg/wke7vXvQ5qh7JyFH777uexrLwDBjbP+uCXn8zGEIu3KI5gBufoL0w38OfnBg83uB6X9VbVCD2tBoGwPGk1WGHayfwdDM6R2lYE1Gjn0Tpv9YAtcovn2OJNPbCsslgR1CgdHUE9jOZl25OHn1fl4qN/qZsXF565dblqglSqX1BUyq2T0dIoe/yP1M/pjyqZoTRnF5EocMCgyv7YnpK8eAKw5tkr9vrfWsRpIxHsEGDxpaclUJd1f5bQAWgcYPVjjF6y9+quZ1b9ApwUTAf1FnP/wqnOpW6PeU0YrQv3D3+aqvRhP3K4fCfGLRiRlvgN7QvwMUA0g4QR8M9Ut5kSsSiiJkKq5KouUpSth5UFmpS4Oc80NYUNN44yFJc1xov5co7vvtxwm2fSUxJ1QB7udxYpU94wQs4gLHSOomqR+Ugsj5Eisc5CuieMCc0Vgz7NWm4nw9w7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ffad3f-5638-47e4-8ccc-08dc1b5c8b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 15:12:27.2641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBJsP0Ta7GAMPtkldHE+nH5vjrTfWpc5W9qc/VyDFKkDbq26nbtc+O1ZYFCDRzSpFDh/oEEkhE6ojNYnQySQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8847

On Fri, Jan 19, 2024 at 05:01:01PM +0100, David Sterba wrote:
> On Thu, Jan 18, 2024 at 05:54:49PM +0900, Naohiro Aota wrote:
> > There was a report of write performance regression on 6.5-rc4 on RAID0
> > (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> > and doing the checksum inline can be bad for performance on RAID0
> > setup [2].=20
>=20
> First, please don't name it 'inline checksum', it's so confusing because
> we have 'inline' as inline files and also the inline checksums stored in
> the b-tree nodes.

Sure. Sorry for the confusing naming. Is it OK to call it "sync checksum"?
and "workqueue checksum" for the opposite?

>=20
> > [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e1=
6-tech.com/
> > [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vj=
tcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> >=20
> > While inlining the fast checksum is good for single (or two) device,
> > but it is not fast enough for multi-device striped writing.
> >=20
> > So, this series first introduces fs_devices->inline_csum_mode and its
> > sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> > it disables inline checksum when it find a block group striped writing
> > into multiple devices.
>=20
> How is one supposed to know if and how the sysfs knob should be set?
> This depends on the device speed(s), profiles and number of devices, can
> the same decision logic be replicated inside btrfs? Such tuning should
> be done automatically (similar things are done in other subystems like
> memory management).

Yeah, I first thought it was OK to turn sync checksum off automatically on
e.g, RAID0 case. But, as reported in [1], it becomes difficult. It might
depend also on CPUs.

[1] https://lore.kernel.org/linux-btrfs/irc2v7zqrpbkeehhysq7fccwmguujnkrktk=
nl3d23t2ecwope6@o62qzd4yyxt2/T/#u

> With such type of setting we'll get people randomly flipping it on/off
> and see if it fixes performance, without actually looking if it's
> relevant or not. We've seen this with random advice circling around
> internet how to fix enospc problems, it's next to impossible to stop
> that so I really don't want to allow that for performance.

Yes, I agree it's nasty to have a random switch.

But, in [1], I can't find a setup that has a better performance on sync
checksum (even for SINGLE setup). So, I think, we need to rethink and
examine the effectiveness of sync checksum vs workqueue checksum. So, for
the evaluation, I'd like to leave the sysfs knob under CONFIG_BTRFS_DEBUG.=

