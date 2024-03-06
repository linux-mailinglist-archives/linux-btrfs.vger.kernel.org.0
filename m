Return-Path: <linux-btrfs+bounces-3041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B085873BBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 17:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08B228324D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BA1361D6;
	Wed,  6 Mar 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SZ1WZKpU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HoqTIHUc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E901350DB
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Mar 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741416; cv=fail; b=HjQJSD4+9l8Fl3fmFB26Kvg5OMpg7E4MxM1cBqJLYUzfrZhDDApYX0SONnQGFEIy3QdaOKB0Dds2EVB9sKYaJs0kYe2/X8hkwatL5Wht/kcev0FVFHdOThPGD9YAw/E3l70lR0wV+3zcYE1VX08dyVp153tK8QGU8B8EpmLmP0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741416; c=relaxed/simple;
	bh=/e2PjwMjgg3lc4G9LljhfCXIqMTn4ttCPDBSLk0Wkjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRAuc5uGcVknkEWqC9kF2Fj7K7VqC1RrxbeDXZBEPrrndD50bO0NzTAFedSuQUxtasPDO3nf6TpQqI0GnsAbua5H4r9LSAZQHxgG5zRknONJ483GJxTvWZe+iLW9FEWvMs/WMi3u6n5/mVYrPNBeezrgm4Kwb6S6tWppzqLJilA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SZ1WZKpU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HoqTIHUc; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709741413; x=1741277413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/e2PjwMjgg3lc4G9LljhfCXIqMTn4ttCPDBSLk0Wkjc=;
  b=SZ1WZKpUf7kHOTuyM5oaoPN1H1CIqDSybjiw5lbUnaVr7YGzNEK3RQGI
   xsWt8LJ/CN4u6ng7Sk8p6iGMRoqOfcd9pbcLV5Vxs/U+jBCqOZpCH6+gF
   ESj6B9qCunpwrpuybObrYjdG5bdsEWnUtWLu0Uy5XwMGfQ+tjGLC/8d0Y
   NF9VCKt35gp8Nc6FgblPRPQLFu5yel6c6BTZFcNCn1c7LKI6k7FmzmgpP
   4+M0HCce41QacJ0akt5mTu4dElnkfiLemxb+M9A/Cu9MoGWs5hhNNcfp/
   SRCurG2EPwjJWdfqRCqZqy2iRX6TfEBx8FC5Mj8r9pnWV07MmblkXm/Qo
   w==;
X-CSE-ConnectionGUID: aCPFaWmzTDmHPcWAZH+7qg==
X-CSE-MsgGUID: ImZuBUHyTL6ZpNZxCxwt9A==
X-IronPort-AV: E=Sophos;i="6.06,208,1705334400"; 
   d="scan'208";a="10493507"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2024 00:10:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5jsJle9YgxOvnS4lV5eifTZrfI7DTYIbtQ0MmVC/c1GszUp3NJsBuhRGjRIyNpAeKTAaZ83I5NrYqC953y1DWdqTjwHMd8upb4ZrJ+E++MvSQmgCtR+Pe+oZdPhUiny4h6E6qfluH9RJgNm597U3u1Xqm6im6K+QimaHiWTr/KhfUh9FZvuFCjZO1f1hrWBs1nYINBnBfkvkM2CqiejWEGFXI6zMI2jJxf7zOiWbuYmuVPgjABW1Roe+1wmssJ/zPQ6hRS9EOMewxZEewDUdcDOP0MM81QUb2yQY0nBsmj8l/+OZL0M0DJM8xEzbh6aPMZ9sLxUJq0k35EJd78nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OkFB6M13RxwYYoNwOs2mkavNyTgm2PCTaOCC1Udu0E=;
 b=IUccJv0a5v26RPSzsbZicQBuWWy1BWbOwEMfaszOgDFVxkdOYJvi5ssiPeuYGI22vdhVnFOsOxWAhL3hqT2ZX2iP/Mb+MjHWiNXijvO2UA4YRXLByLgFco3kscJyFAAlyIgqb0wlC2tOoS5RjCXROIzk520RM7xMhOtMr9vj67vFfLSkMjiAxctJQPQSm7KSZSeRFYwrkJAxJDOqiXTQ/gE6E2hFYY0OuGeuLt79IL8cji46ATm5fBAKpHzV1LA9Sp81gvLdlvwpU3bhiXqTbKjMYwMja7m4tENTnqtEOIHuWSMhnqZuYLYeD3CzgUj5xyERhqWM3qvuVbKFB9RbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OkFB6M13RxwYYoNwOs2mkavNyTgm2PCTaOCC1Udu0E=;
 b=HoqTIHUcRVa2FUQZTrLr7hvIuYtpgbGgW4IpagoD1OsJ4pG/8Upzgs8vAiqMY7b+7J3KdrHdQSRiaJbNknVWkVWm8BF2OuuBRb1GxXs4DH3lq0gfHH4RSmDZzkT4747eF+OZRqNmu2OxufuIQIBC073GMxRYVr+fMNIa/EyjU88=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7530.namprd04.prod.outlook.com (2603:10b6:806:14b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 6 Mar
 2024 16:10:09 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7339.040; Wed, 6 Mar 2024
 16:10:09 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: prevent extent buffer header to be cleared
Thread-Topic: [PATCH] btrfs: zoned: prevent extent buffer header to be cleared
Thread-Index: AQHaakUdCXHqX4MHOk+djGt97CXB0LEfveiAgAkCaYCAAiyoAA==
Date: Wed, 6 Mar 2024 16:10:08 +0000
Message-ID: <hwiqgbcrr6mudd5ctu6l4degugpno7o2jgajhv7bibkdudacnl@domckppo4o5q>
References:
 <3f4f2a0ff1a6c818050434288925bdcf3cd719e5.1709124777.git.naohiro.aota@wdc.com>
 <20240228132249.GJ17966@twin.jikos.cz>
 <dtdsgmky6x7nziaaz7piiceexsc5gds5nzrbsmvhnpp4vbjbwg@i4e6ktyt2sdz>
In-Reply-To: <dtdsgmky6x7nziaaz7piiceexsc5gds5nzrbsmvhnpp4vbjbwg@i4e6ktyt2sdz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7530:EE_
x-ms-office365-filtering-correlation-id: 9d048943-154c-4cfe-ac48-08dc3df7e519
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cEWCZsOom9x0G7DkldknC9pEFUY16/cydhd3WB5jd9lUlE8mW3JKbvN+WaKdqY9yerrTw6ifMKFFNNHBCQ7S40GXxbFzX66BpLBOtaR3+Z1KNX6HAT/m7qSk5MWILecSy8h/TnewvV2RgPzxq0N8eVurFpd/WT+WNwC3MNNHBUNdY6I35ufuoPW7pBgRYfqnaZnovnTFvBNd+4bCJic90d+PDm4vPt3RFXzGpv0CDARh3nfukerDzDVHbN86azv9SEsmfA3np2ctBHs2bVFhtpkKi6hd1cUmxFcqyjqDVndTeouGJ1Kc1RWr+JjnUh2u8ZIQN1Sc47o9xdDTs+pAUki+NtYx+mFY39em3Tktv7+fMA46UR+AelH5yYFTmc6Sja1zYaFu2DfFqvArBHTAFXPiIm3+wjDKQGz4H05JBhntEY627XZUFVkZw8txJ7q/2SKw+HgEHyM+y5AshN6FV+1lau0lslADJypdWRsu6mJ7kJeTHEiiykfHkQuROJCd/MFSmBJkFvJXqxnTHu2o/kErfn8qo0GaoLxBHVR/KDS0771D1Lw1kwnbkyaSAd4YNsP4Vfj2Iv4EgS6zRkwxn1hJyWDiEnbTgEnAXIrNku36elUF4GlqnJofDkl7dnI0Cfl2NVBsvmz7aMDnjYWdW706Z+Tg07T5iOYnEU503mA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZMmCLM5F+2tbh4XBnPotxiI1KWjCAI0Q7pIkcyURvhpCa/2O85azDFJ18Ixj?=
 =?us-ascii?Q?G8j9I9/oWKozZsrfx0+v/K6lT+Ksfbocy5TCNJbnpZvrpZ1Hnlbky4+fH9AW?=
 =?us-ascii?Q?Bd6qUwy50PHgq7UCFH3x7881xKV7RW7d2l1wcnS7emeG7BFyH9sjhiIME+Pk?=
 =?us-ascii?Q?FgggjUwiuwxy+Th5hxeWLalaDW7tC95XwpQ/xONobnYxr/CVXf4HJJiDcTkg?=
 =?us-ascii?Q?rLdJ6qJULq39P3lidH7ZoepEUIepdA+Ctc0ivrlYgbGB6vyQZ3whAci+ewO1?=
 =?us-ascii?Q?MOFMWO6Vlu404sHSujd+4d1HQAVJ6DaSGNVLopmOH4ai7+W8b5cVS3w4AT9O?=
 =?us-ascii?Q?yfOSExCoOsPaMXccTtPzal8UYdQHA3GzYlpLzqmuFz/o/aG/G58UXO9EBbej?=
 =?us-ascii?Q?Ix4c7ijgYQNZ0I4vofw9RVkZUmLPtRpaQACvP9QXlO46LmPXiufDRGWJJi5x?=
 =?us-ascii?Q?zajZNftSrOmfGrimtA4OJWE3yaxyCgKkd4ItGT24GwohQhEeoo7O+iC1WXIU?=
 =?us-ascii?Q?glQ2Av9U7HmCHdAUB62rwkdzmTRtDLnGbMjIUgot+orFbdBNlEmjgBaQrRna?=
 =?us-ascii?Q?IK5fJLuargpwy9eIblEIHU5ETVEtvxGPCkg/TjXPTjg0knsOcXnPchcOmxMc?=
 =?us-ascii?Q?tIzURE0bvPt4mfuV7PFZNR1aHa0kEx2hpE5t+4ctH6mOsKlOYkcW9LwjM9AA?=
 =?us-ascii?Q?ZTC0ztQaoC6G5xxj993pG5YOHPW9+U2LbJWOCwnvNxYHa7EKDRaAPkEMG3Tm?=
 =?us-ascii?Q?VrAh+ZtOHR/o3XJfYwErL+VuyPfsRJv/4btLFQa5sFIrW4GUyArs8j36NVHX?=
 =?us-ascii?Q?wBbLbGa4UojVmIJVglE1sfCXFKJsZuUIDLQ0wxITd2VOkpXUAu9wNf3a71wO?=
 =?us-ascii?Q?i/5EN53Z1XiIT4dA335bf69t7SZOiw4zuA7kaXtGBgywwC7jwNdeaHLM0RFl?=
 =?us-ascii?Q?SVTEBWmsZc0gVsptK7gF9o0k0zAmL1bbMl0lpzUuNcPG7RcdpOXdF61cuIOr?=
 =?us-ascii?Q?0X9aVsunXZ+5rO3PYd22hUJXvMN9MZn4AmkLIKJIM72k6xtW4tQyST59lhW2?=
 =?us-ascii?Q?5Uj/8N4x4cOkN2fTauuU84/XHGU2XvHWNgX2lpE6PCR/nYJy0YEdymujpXyu?=
 =?us-ascii?Q?0VzQkzpnBp5WP0YmVCALegESZzmARdrgs5RakNwHppuS9ylzyyft9f90m5V5?=
 =?us-ascii?Q?U1Udv2B8/BtdFqCsRaRCqhruoY8yO+DEzxiYt8OSQXWi6cPWt3TJmY+HleZe?=
 =?us-ascii?Q?qAPmlyyiJEj9Tz4tAzhvEfiXZ9uiaAYzrMTCxg54mhgBmNrL1JfB4dyQDrLm?=
 =?us-ascii?Q?JR1Mh6pOEZZotBCMu4gGHAEXU/J3p18vb1wLzRsTGkTwwgakgmk7NEVwZ+ct?=
 =?us-ascii?Q?2RoPP+4Lq3Sw6u1fouEiregER05FNhbWRYpvC6VZTDq890UDkaJToFNmD946?=
 =?us-ascii?Q?r54qXGU7NgsiZfYCdK16T3X6LW5j2R5B2PFdSBui4FwjE4cSR7Pku1nGDxes?=
 =?us-ascii?Q?STIavl54zBgztr/CFUXogl7Vq5jmVjHslx7GPKs6rRwXJ/J6Qw/1ZGLT1rJ6?=
 =?us-ascii?Q?WbTNm6oQgsQB+k6CowZ5yehBSlveMqtieH3cr8AyNZViaC3RNft/z7LqWg0t?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B59D7101978CB34C8C6BB677D211541E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n6Yl7+Nrdzch3/TBtcdUBu87jjHH7N5eALP5VIcchpy+VQ8hnCuiORVBCr0r8jmPkPs7QJmsp/f4yifVfew7EXe7qsl+qli1a69646fxwqUL900pFjnHI1oBL15DUWXzTaUhviOlnAf4oh1UFCv39zubnTF6wTk7QbWCTTZ+HEXrFclcPxKuocS4i7JE/IRYqqb3bXJN4xRrimN6IF9B/elXdT9vjO4H2EtNPzQKqEu5t2dpJYjLHNu3aIlQwYMqRMQUmGgv5cOb/bdEwD9jR5kx2C1hbumGAZXqKp704ADgP89/b6a/SetbZePHQSbfgHSsZ6JhnjUVsG7lc8i4MS/vYKSys4IenhwPNDX80zGwkSmtAwU68oDZsX3Ep4isHwvNq307FNxZQHintNYTq6xGIYYEBdeSba7qIqthw9V2bWUNyuiRpaz97cFkUJqZIeOFrcpjj2oKA8O06/QZeV/rciZNfRN20FSGes3+/Zs+Smti4xhwR/akVpzqxRrF7q29b3u5CjXttT63J9snWFpjjU62FLazX1JPhqA9zK8ycXOanvPn6He9ffhxZifEdtY0YwlDH2c+OqZTYhz3A2bglbkeqsfo+Z+Yal9FWIlEOgC2qFj73vUEwN+qPCYq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d048943-154c-4cfe-ac48-08dc3df7e519
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 16:10:08.9202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqZJwUVGYmwpUPBQwhnP7RQIpneq3Ha+RliqNabpBWf9zEklTfxgLHjw99R6vDe07OTQYMhLGmCQRh3l5Z5vTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7530

On Tue, Mar 05, 2024 at 06:57:48AM +0000, Naohiro Aota wrote:
> On Wed, Feb 28, 2024 at 02:22:49PM +0100, David Sterba wrote:
> > On Wed, Feb 28, 2024 at 09:53:03PM +0900, Naohiro Aota wrote:
> > > Btrfs clears the content of an extent buffer marked as
> > > EXTENT_BUFFER_ZONED_ZEROOUT before the bio submission. This mechanism=
 is
> > > introduced to prevent a write hole of an extent buffer, which is once
> > > allocated, marked dirty, but turns out unnecessary and cleaned up wit=
hin
> > > one transaction operation.
> > >=20
> > > However, btrfs_free_tree_block() can be called on an extent buffer af=
ter
> > > its content is cleared. Then, it inserts a faulty delayed reference e=
ntry,
> > > which makes the FS corrupted.
> > >=20
> > > This bug can be triggered running generic/013 several (~200) times. I=
t
> > > failed as following:
> > >=20
> > >     ------------[ cut here ]------------
> > >     WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-tree.c:3248 __btrfs=
_free_extent.isra.0+0x604/0x1330 [btrfs]
> > >     Modules linked in: dm_flakey algif_hash af_alg xt_conntrack xt_MA=
SQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_=
defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilte=
r bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rapl acpi_cpufreq ipm=
i_ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ipmi_devintf xor ipm=
i_msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn=
1_decoder public_key oid_registry fuse msr ipv6
> > >     CPU: 9 PID: 29834 Comm: fsstress Not tainted 6.8.0-rc4-BTRFS-ZNS+=
 #403
> > >     Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/=
2021
> > >     RIP: 0010:__btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> > >     Code: 8b 3f e8 bf 69 00 00 48 8b 7d 60 45 8b 4f 40 49 89 d8 8b 54=
 24 40 4c 89 e9 48 c7 c6 30 64 65 a0 e8 61 fb 0d 00 e9 8f fd ff ff <0f> 0b =
f0 48 0f ba 28 02 41 b8 00 00 00 00 0f 83 86 04 00 00 b9 8b
> > >     RSP: 0018:ffffc900090cfb80 EFLAGS: 00010246
> > >     RAX: ffff888365c719d8 RBX: 0000000f9677c000 RCX: 0000000000000001
> > >     RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> > >     RBP: ffff8889a044b220 R08: 0000000000000000 R09: 0000000000000004
> > >     R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000001
> > >     R13: ffff888ad87a4c98 R14: 0000000000000005 R15: ffff888a0c7d2a80
> > >     FS:  00007f823f5f7740(0000) GS:ffff889fcea40000(0000) knlGS:00000=
00000000000
> > >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >     CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4: 0000000000350ef0
> > >     Call Trace:
> > >      <TASK>
> > >      ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> > >      ? __warn+0x81/0x170
> > >      ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> > >      ? report_bug+0x18d/0x1c0
> > >      ? handle_bug+0x3c/0x70
> > >      ? exc_invalid_op+0x13/0x60
> > >      ? asm_exc_invalid_op+0x16/0x20
> > >      ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? rcu_is_watching+0xd/0x40
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? lock_release+0x1e5/0x280
> > >      __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
> > >      ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
> > >      btrfs_run_delayed_refs+0x92/0x130 [btrfs]
> > >      btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? rcu_is_watching+0xd/0x40
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? lock_release+0x1e5/0x280
> > >      btrfs_sync_file+0x532/0x660 [btrfs]
> > >      __x64_sys_fsync+0x37/0x60
> > >      do_syscall_64+0x79/0x1a0
> > >      entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > >     RIP: 0033:0x7f823f6f8400
> > >     Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d =
00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> > >     RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORIG_RAX: 00000000000=
0004a
> > >     RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f823f6f8400
> > >     RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI: 0000000000000003
> > >     RBP: 00000000000002e6 R08: 0000000000000007 R09: 00007ffe3c26ea0c
> > >     R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe3c26ea10
> > >     R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000560cdfcd7180
> > >      </TASK>
> > >     irq event stamp: 0
> > >     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > >     hardirqs last disabled at (0): [<ffffffff810e5e0e>] copy_process+=
0xb0e/0x1e00
> > >     softirqs last  enabled at (0): [<ffffffff810e5e0e>] copy_process+=
0xb0e/0x1e00
> > >     softirqs last disabled at (0): [<0000000000000000>] 0x0
> > >     ---[ end trace 0000000000000000 ]---
> > >     ------------[ cut here ]------------
> > >     BTRFS: Transaction aborted (error -117)
> > >     WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-tree.c:3249 __btrfs=
_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> > >     Modules linked in: dm_flakey algif_hash af_alg xt_conntrack xt_MA=
SQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_=
defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilte=
r bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rapl acpi_cpufreq ipm=
i_ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ipmi_devintf xor ipm=
i_msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn=
1_decoder public_key oid_registry fuse msr ipv6
> > >     CPU: 9 PID: 29834 Comm: fsstress Tainted: G        W          6.8=
.0-rc4-BTRFS-ZNS+ #403
> > >     Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/=
2021
> > >     RIP: 0010:__btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> > >     Code: 48 c7 c6 40 5d 65 a0 e8 f0 f1 0d 00 c7 44 24 18 01 00 00 00=
 e9 ed f7 ff ff be 8b ff ff ff 48 c7 c7 68 5d 65 a0 e8 52 69 c1 e0 <0f> 0b =
e9 30 fb ff ff 48 8b 45 60 48 05 d8 19 00 00 f0 48 0f ba 28
> > >     RSP: 0018:ffffc900090cfb80 EFLAGS: 00010282
> > >     RAX: 0000000000000000 RBX: 0000000f9677c000 RCX: 0000000000000000
> > >     RDX: 0000000000000002 RSI: ffffffff82464302 RDI: 00000000ffffffff
> > >     RBP: ffff8889a044b220 R08: 0000000000009ffb R09: 00000000ffffdfff
> > >     R10: 00000000ffffdfff R11: ffffffff8264dd80 R12: 0000000000000001
> > >     R13: ffff888ad87a4c98 R14: 0000000000000005 R15: ffff888a0c7d2a80
> > >     FS:  00007f823f5f7740(0000) GS:ffff889fcea40000(0000) knlGS:00000=
00000000000
> > >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >     CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4: 0000000000350ef0
> > >     Call Trace:
> > >      <TASK>
> > >      ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> > >      ? __warn+0x81/0x170
> > >      ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> > >      ? report_bug+0x18d/0x1c0
> > >      ? tick_nohz_tick_stopped+0x12/0x30
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? handle_bug+0x3c/0x70
> > >      ? exc_invalid_op+0x13/0x60
> > >      ? asm_exc_invalid_op+0x16/0x20
> > >      ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? rcu_is_watching+0xd/0x40
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? lock_release+0x1e5/0x280
> > >      __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
> > >      ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
> > >      btrfs_run_delayed_refs+0x92/0x130 [btrfs]
> > >      btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? rcu_is_watching+0xd/0x40
> > >      ? srso_return_thunk+0x5/0x5f
> > >      ? lock_release+0x1e5/0x280
> > >      btrfs_sync_file+0x532/0x660 [btrfs]
> > >      __x64_sys_fsync+0x37/0x60
> > >      do_syscall_64+0x79/0x1a0
> > >      entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > >     RIP: 0033:0x7f823f6f8400
> > >     Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00=
 00 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d =
00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> > >     RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORIG_RAX: 00000000000=
0004a
> > >     RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f823f6f8400
> > >     RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI: 0000000000000003
> > >     RBP: 00000000000002e6 R08: 0000000000000007 R09: 00007ffe3c26ea0c
> > >     R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe3c26ea10
> > >     R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000560cdfcd7180
> > >      </TASK>
> > >     irq event stamp: 0
> > >     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > >     hardirqs last disabled at (0): [<ffffffff810e5e0e>] copy_process+=
0xb0e/0x1e00
> > >     softirqs last  enabled at (0): [<ffffffff810e5e0e>] copy_process+=
0xb0e/0x1e00
> > >     softirqs last disabled at (0): [<0000000000000000>] 0x0
> > >     ---[ end trace 0000000000000000 ]---
> > >     BTRFS: error (device nvme1n2: state A) in __btrfs_free_extent:324=
9: errno=3D-117 Filesystem corrupted
> > >     BTRFS info (device nvme1n2: state EA): forced readonly
> > >     BTRFS info (device nvme1n2: state EA): leaf 66957836288 gen 3873 =
total ptrs 203 free space 1102 owner 2
> > >     BTRFS info (device nvme1n2: state EA): refs 2 lock_owner 29834 cu=
rrent 29834
> > >             item 0 key (63394947072 168 40960) itemoff 16230 itemsize=
 53
> > >                     extent refs 1 gen 3835 flags 1
> > >                     ref#0: extent data backref root 5 objectid 552 of=
fset 1802240 count 1
> > > (snip)...
> > >             item 164 key (66948923392 169 0) itemoff 8229 itemsize 33
> > >                     extent refs 1 gen 3872 flags 2
> > >                     ref#0: tree block backref root 2
> > >             item 165 key (66948939776 169 1) itemoff 8196 itemsize 33
> > >                     extent refs 1 gen 3873 flags 2
> > >                     ref#0: tree block backref root 5
> > >             item 166 key (68719476736 168 110592) itemoff 8143 itemsi=
ze 53
> > >                     extent refs 1 gen 3841 flags 1
> > >                     ref#0: extent data backref root 5 objectid 440 of=
fset 3100672 count 1
> > > (snip)...
> > >             item 202 key (68722249728 168 110592) itemoff 6177 itemsi=
ze 53
> > >                     extent refs 1 gen 3842 flags 1
> > >                     ref#0: extent data backref root 5 objectid 953 of=
fset 5431296 count 1
> > >     BTRFS critical (device nvme1n2: state EA): unable to find ref byt=
e nr 66948939776 parent 66948939776 root 5 owner 0 offset 0 slot 166
> > >     BTRFS error (device nvme1n2: state EA): failed to run delayed ref=
 for logical 66948939776 num_bytes 16384 type 182 action 2 ref_mod 1: -2
> > >     BTRFS: error (device nvme1n2: state EA) in btrfs_run_delayed_refs=
:2246: errno=3D-2 No such entry
> > >     BTRFS warning (device nvme1n2: state EA): Skipping commit of abor=
ted transaction.
> > >     BTRFS: error (device nvme1n2: state EA) in cleanup_transaction:20=
06: errno=3D-2 No such entry
> > >=20
> > > This happens maybe because clearing the contents is too early. It sho=
uld
> > > clear the content after all the reference to the node is dropped.
> >=20
> > If you have such suspicion you can add assertions to validate the state=
,
> > bits and other constraints.
>=20
> It is difficult to assert the node-to-node reference because we need to
> query the tree. But, I'm going to add other assertion to check if the
> delayed ref is not faulty.
>

I added the following assert (currently, it's WARN to make my debug session
easy)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index beedd6ed64d3..eb0918df047e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3464,6 +3464,14 @@ void btrfs_free_tree_block(struct btrfs_trans_handle=
 *trans,
 	if (root_id !=3D BTRFS_TREE_LOG_OBJECTID) {
 		struct btrfs_ref generic_ref =3D { 0 };
=20
+		/*
+		 * Assert that the extent buffer is not cleared due to
+		 * EXTENT_BUFFER_ZONED_ZEROOUT. Please refer
+		 * btrfs_clear_buffer_dirty() and btree_csum_one_bio() for
+		 * detail.
+		 */
+		WARN_ON_ONCE(btrfs_header_bytenr(buf) =3D=3D 0);
+
 		btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
 				       buf->start, buf->len, parent,
 				       btrfs_header_owner(buf));

> >=20
> > > Addressing that root cause needs more time. Until that, leave the ext=
ent
> > > buffer header intact, so that we can add a proper delayed reference e=
ntry.
> > >=20
> > > Fixes: aa6313e6ff2b ("btrfs: zoned: don't clear dirty flag of extent =
buffer")
> > > Link: https://lore.kernel.org/linux-btrfs/oadvdekkturysgfgi4qzuemd57z=
udeasynswurjxw3ocdfsef6@sjyufeugh63f/
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/disk-io.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index a2e45ed6ef14..8aaed8719394 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -278,7 +278,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio =
*bbio)
> > >  	 * ordering of I/O without unnecessarily writing out data.
> > >  	 */
> > >  	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
> > > -		memzero_extent_buffer(eb, 0, eb->len);
> > > +		const unsigned long header_size =3D sizeof(struct btrfs_header);
> > > +
> > > +		memzero_extent_buffer(eb, header_size, eb->len - header_size);
> >=20
> > So this means anything that finds the buffer will have to rely on the
> > state in the header and if it's with ZONED_ZEROOUT then stop processing
> > it. btree_csum_one_bio() is the only function that checks the bit
> > AFAICS.
>=20
> Yes, indeed it's cumbersome to check the flag for every btrfs_header_*
> usage. So, I found another solution and I'm testing it. It looks like
> adding EXTENT_BUFFER_ZONED_ZEROOUT even when an extent buffer is not DIRT=
Y
> is causing the bug.

And, tested this solution like diff below. It survives generic/013 100
times without hitting the WARN above. However, generic/561 hit the WARN as
below. So, there is some other reason (than clearing non-dirty extent
buffer) causing the issue.

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c7ecfcac34fc..70f23f51fda7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4152,7 +4152,9 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_hand=
le *trans,
 	 * The actual zeroout of the buffer will happen later in
 	 * btree_csum_one_bio.
 	 */
 	if (btrfs_is_zoned(fs_info)) {
+		if (!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
+			return;
 		set_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags);
 		return;
 	}


[ 9014.582049] ------------[ cut here ]------------
[ 9014.598804] WARNING: CPU: 10 PID: 1716009 at fs/btrfs/extent-tree.c:3473=
 btrfs_free_tree_block+0x26b/0x2e0 [btrfs]
[ 9014.621665] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_pr=
ison dm_snapshot dm_bufio dm_flakey algif_hash af_alg xt_conntrack xt_MASQU=
ERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilter b=
ridge stp llc overlay sunrpc kvm_amd kvm irqbypass ipmi_ssif acpi_cpufreq r=
apl ipmi_si i2c_piix4 btrfs k10temp ipmi_devintf blake2b_generic ipmi_msgha=
ndler xor raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn1_d=
ecoder public_key oid_registry fuse msr ipv6
[ 9014.730793] CPU: 10 PID: 1716009 Comm: fsstress Not tainted 6.8.0-rc7-BT=
RFS-ZNS+ #408
[ 9014.751296] Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 0=
2/22/2021
[ 9014.771359] RIP: 0010:btrfs_free_tree_block+0x26b/0x2e0 [btrfs]
[ 9014.789863] Code: 0b e9 07 ff ff ff 8b 4b 08 48 89 f2 48 89 ef 41 b8 01 =
00 00 00 4c 89 e6 e8 d2 80 ff ff 4c 89 e7 e8 7a bb 0c 00 e9 e3 fe ff ff <0f=
> 0b e9 1c fe ff ff 0f 0b 65 8b 05 71 63 b8 5f 89 c0 48 0f a3 05
[ 9014.833425] RSP: 0018:ffffc90023ea7a70 EFLAGS: 00010246
[ 9014.851277] RAX: ffff888c4a4fb000 RBX: ffff88925d774c08 RCX: 00000000000=
00000
[ 9014.871007] RDX: 0000000000000000 RSI: 00000003324b0000 RDI: ffffc90023e=
a7ab8
[ 9014.890724] RBP: ffff889cf09cad98 R08: 0000000000000001 R09: 00000000000=
00000
[ 9014.910381] R10: 0000000000000008 R11: 0000000000000000 R12: 00000000000=
00002
[ 9014.929861] R13: ffffc90023ea7a70 R14: ffff889d6443c000 R15: 00000000000=
00001
[ 9014.949121] FS:  00007f3cb82e1740(0000) GS:ffff88a04e880000(0000) knlGS:=
0000000000000000
[ 9014.969242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9014.986837] CR2: 00007f8d3da345f0 CR3: 0000000111b0c000 CR4: 00000000003=
50ef0
[ 9015.005852] Call Trace:
[ 9015.020105]  <TASK>
[ 9015.033830]  ? btrfs_free_tree_block+0x26b/0x2e0 [btrfs]
[ 9015.050743]  ? __warn+0x81/0x170
[ 9015.065306]  ? btrfs_free_tree_block+0x26b/0x2e0 [btrfs]
[ 9015.082059]  ? report_bug+0x18d/0x1c0
[ 9015.096896]  ? handle_bug+0x3a/0x70
[ 9015.111278]  ? exc_invalid_op+0x13/0x60
[ 9015.125813]  ? asm_exc_invalid_op+0x16/0x20
[ 9015.140616]  ? btrfs_free_tree_block+0x26b/0x2e0 [btrfs]
[ 9015.156645]  btrfs_del_leaf+0xc4/0xe0 [btrfs]
[ 9015.171612]  btrfs_del_items+0x467/0x520 [btrfs]
[ 9015.186613]  __btrfs_free_extent.isra.0+0x927/0x1370 [btrfs]
[ 9015.202561]  __btrfs_run_delayed_refs+0x40c/0x1280 [btrfs]
[ 9015.218280]  ? srso_untrain_ret+0x2/0x2
[ 9015.232261]  ? srso_return_thunk+0x5/0x5f
[ 9015.246289]  ? srso_return_thunk+0x5/0x5f
[ 9015.260043]  ? rcu_is_watching+0xd/0x40
[ 9015.273399]  ? srso_return_thunk+0x5/0x5f
[ 9015.286705]  ? lock_release+0x1e5/0x280
[ 9015.299739]  ? btrfs_start_dirty_block_groups+0x105/0x5a0 [btrfs]
[ 9015.315198]  btrfs_run_delayed_refs+0x33/0x120 [btrfs]
[ 9015.329620]  btrfs_start_dirty_block_groups+0x3aa/0x5a0 [btrfs]
[ 9015.344660]  ? srso_return_thunk+0x5/0x5f
[ 9015.357546]  ? btrfs_commit_transaction+0x3e/0x12c0 [btrfs]
[ 9015.372148]  btrfs_commit_transaction+0xec/0x12c0 [btrfs]
[ 9015.386520]  ? srso_return_thunk+0x5/0x5f
[ 9015.399364]  ? btrfs_attach_transaction_barrier+0x1e/0x60 [btrfs]
[ 9015.414306]  ? __pfx_sync_fs_one_sb+0x10/0x10
[ 9015.427232]  iterate_supers+0x7a/0xe0
[ 9015.439191]  ksys_sync+0x60/0xa0
[ 9015.450453]  __do_sys_sync+0xa/0x20
[ 9015.461714]  do_syscall_64+0x77/0x1a0
[ 9015.472886]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[ 9015.485376] RIP: 0033:0x7f3cb83e2487


>=20
> > Otherwise, if this is a sufficient fix we'd need it for 6.8.=

