Return-Path: <linux-btrfs+bounces-3039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF64873A96
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8283C283AA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Mar 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D73135415;
	Wed,  6 Mar 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qpLR2sCU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y3PpF8aE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F31353F3
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Mar 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738627; cv=fail; b=dAVFg4c1wk9JzM0Wduj90xZRThloQlTDbRDMPuw3ulNS2siVGlXHOY9QqjuUWDmomxLSQOWu2gdGE1Hn6vWBeiD/y7Y5afXHQhnxns0/47ucVgZyUaU3V6qNapFc3IcshYdXPwVopP2qyQrskCaauH6kAPMeqFmCAkNfCnemAXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738627; c=relaxed/simple;
	bh=7uID5IDEikr9h2u25s4DKFBNVm8+URoSm6RULHBwOY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C5cIVjsqs7lS9joiclUcQ41jzWgilVOdvrq6v2wSKC/q8jNSZ63uxYGPZuVpcOjle38WLsnmDBC8MLN4SrNAeA3dzQSPYjdqJ0RaJHH27lrqehWZSMjvHrKkx2+X0KwW+Z46jVpP8TOlUlA8coJ/mddnJf92utNuCdTDEN7xw/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qpLR2sCU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Y3PpF8aE; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709738625; x=1741274625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7uID5IDEikr9h2u25s4DKFBNVm8+URoSm6RULHBwOY8=;
  b=qpLR2sCUz6yfwQjr/bjvl3Nk7W3+MD3od1bsvCim9vnpGjwx//m6Qcs5
   Pd+mfcbEEnbAJBTqZPE/LsVUrw1AFMumit23ekyWabiTtiwuRC7pwdpsZ
   HB831Nyc6YLDI8MtbyX2zRa+uv3IHcYySkt/7qk4jdrmjWOlpZvEUj1fd
   WSKjHdOmOVzcFfr/YiIbfO/Qvt+rZJsTT8i2Qf+APqpRqYGQuUVsJ6JMq
   Lzo20trJqGa+LFcEChqSDlrZK8lua5M44jMTqsO7wm5FKvDK4+X1RekU5
   H8uHquMjGfhAvFCdSH49Eh9Wi7sJhK6KsOQ+LOIbh/NSjLypKyT3PLEI9
   w==;
X-CSE-ConnectionGUID: S/O2noVXTI+kzuzOmWXjMQ==
X-CSE-MsgGUID: 5dqs5aUJQbuRjdwszQd/Og==
X-IronPort-AV: E=Sophos;i="6.06,208,1705334400"; 
   d="scan'208";a="10924570"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 23:23:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfYeU7yJBF1WF9awvBIN+fHqRSFP1bvpDABZEIpd9pNSfXRspZeAsaL7lkQj/8Psgy2oSbaScitiQhhYaIVS4EkYUznF9vOdj8jDh+XqdLlz7aDntUR69klc2IRWm+nIzear/rsVgkeBN4LSL0KLbV5Ii7IDHNMK3UIj6Owf4Eeac5XbJy82h3RBPV1Lg6OtUBPSs5XmZuy4FsG+PUdmKg8HzSeW1mhqaNmmpfBUxFu8NIq2BHAS5Si1EgVFY2USQq+OPDP88ZTDiuGOXyWrbRf1Zbjkpeyh/K++dXaHXH5rQWUGDa4GV3ZMZxusqb5sTT1om6LRpIlC8vQCWMfpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ljv9r0/gc03RYMhw9tFnyNfNCRw/98ApLFzY6dr19E=;
 b=Bltw9xC5vASES7JW6wSivPQahVqWx/HTjbYqPi4qOEfUPkGlPcYyI51sVpHmeljILvVFjjpiCuFyQ4hxD09sEqBEt4Bvn6Xk0x+eqMi+CtIoiia1XuX5yjGSvIieNlQVwsDtrmHOj0ODy2s29DdR3dh3Pv1P+L7VBXlhog9sYLLGZn5qqMVHD/cj5dJ4BjVF3fDU1Vc6f+mWI+rpcEwUOUklglbx3URrWY/ewQB+Kh8hYRFDPcPuDs1ts9AJRZImI/0ZGb6wir1WdLGYuF7d9ga54OtaAj04+VtRL9wHqsH4KKLRh2sOty6g1VQ0gXrGhEQ8E8hshOp/NeI/2lxaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ljv9r0/gc03RYMhw9tFnyNfNCRw/98ApLFzY6dr19E=;
 b=Y3PpF8aE8xoF3H2HV0MtqUxkEFse07U0WHjzDy5/K2Rw2ZIQx/yCQ+rmk75UfdKbpbolyfeVmIKkDoooGiP+IkaWGSSWreneVlth7cEITI2KiAmMZDwsOh9iD4iwaH85utQsos/OPVvMC+/zi3XKfoeJJLAgHZFzFS00dnux27A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8363.namprd04.prod.outlook.com (2603:10b6:303:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 15:23:42 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7339.040; Wed, 6 Mar 2024
 15:23:41 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH RFC] btrfs: make extent_write_locked_range() to handle
 subpage dirty correctly
Thread-Topic: [PATCH RFC] btrfs: make extent_write_locked_range() to handle
 subpage dirty correctly
Thread-Index: AQHabtXlKHCxUZ86aE+NqwNik2vobbEq1twA
Date: Wed, 6 Mar 2024 15:23:41 +0000
Message-ID: <3medpvju2zv5p6p2a6qyu3qmh74a6poggtfgc2cujdzkk5qfee@i2lpjrufiqgv>
References:
 <7737c2e976c0bb2d36339ed0563cdbd07d846363.1709626757.git.wqu@suse.com>
In-Reply-To:
 <7737c2e976c0bb2d36339ed0563cdbd07d846363.1709626757.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB8363:EE_
x-ms-office365-filtering-correlation-id: 9095ccd8-2cc3-4036-4043-08dc3df167cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AfslOxXC7hIMdF5zX6lSowVGp7cw+n8gMqiWXesH4cymNPTK6fsgcEBBbK7F21OSH9Zwf4+Knqqzaqy9c3gqzb2tUiQpTFLtN7SO230x3kxdUr7/Ejzn9SjKMfE490PRqrP7gRLUnWX1aYY/tR4VTomzLypmM2OZRgCKSjnmukf/QiJVCf5ktIaAuENflSRP++fZobm/t733Z8SjYQj8naRFT+OjCo48vTugdY45zX2CsY5L2JOds2i2GrWLZMXqElgWB2QIKP0KAYxSggLY2O5WjjnFpj9uWlkyW4SVRYsJuysR1OHJhdyen+t6bbKVOhUrHrSFjP3a8xsLmDvVxDiboRnUW4m2HdFhejqp4pFOjgE2gYPIsnCwKkoXw+Lny4VEWtUo8AMyXmTdXSAzsfdudCsQu53ASzY7plcFZHClxQWq1OQT5a/ILsTzYZCNIIKbxmDNNNWrFHkxhWmTJU/WwapvL6XRn/QpnHtm2koPGAQkLy9BWd7bUwo6ou93+tQvAbf9KRTQV2DKg2RFSvnZAj3Mmafn/ptQH/BFTcUc7TkVoabCBvjPalW2sAl9V5SNrGbFFVZjCcH9UgH5M8y87tGnID49k3ZOcgccbtdcwxncGGbYyQo5hGuo0hKOUpNNv7n8Gk+aYjhpoZx1+/bmqfEu7erNzKeneIFLKZKGA3DjuWdfgsjyyd+cqLcuihwgqIbhPJaip1iGORCspJo3AqRI0inswd2EddVswxM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VpVLRju8nZATXtaEBExJLFkEYHaFwn0L1048f8OHMWof7yuVTHRmPQsO1qTT?=
 =?us-ascii?Q?2aJSIb26z8t4EmASRneeTCPvo/ji0umJb84H6V/pY15FD2ymVkA+NOcGPnKm?=
 =?us-ascii?Q?cmPncZ782aKdWjjydqM+wv1klMZ6v0HEgYIAq8wGlWnNcEST7JIyo3PeuC4C?=
 =?us-ascii?Q?2xg0hEv200f5J5UJbRO+RiYIPz7VbX1T6QYjtPleMGJGgYyhvJWBKY+eoPK0?=
 =?us-ascii?Q?5803D+yGN7hS5ZbkGF2CkWuk8zl7QOlx6yP8SdA7hdCw8PGZc1mIBiAX8uW5?=
 =?us-ascii?Q?a9SqodMVdjl89Xpa/3YOGv8zSLXiZVP9AN7VW+HQNaCHA9ROVP8rj0ohiEGQ?=
 =?us-ascii?Q?/idRJVoLAYADQDzAERJUAADFxS1GmNvWa2b+31VT8QDXRB7dpQo1rkaABYLT?=
 =?us-ascii?Q?gTdkGingKFqY/86dsECcEGJoSfZzxL3PQVEKWxXRmMNDqkamHeKqg9kcYUZ3?=
 =?us-ascii?Q?k3JAj683N19yzlK2y5hlecYRvXbBZ3ONBDJ0DEZ4kTV+E2L5iZGPGnLMoSgD?=
 =?us-ascii?Q?V7hRiC9UErT3KSwBo5aMOeAp5+UC8EoLTm37g/pTO/m7gZiWPlQBnsc9aQk0?=
 =?us-ascii?Q?Emz8AuEl7sM3fbycZna0Q0qVAtopO4Vv55ZjsotCwmQ8ySpgFdcZBKhWPsXx?=
 =?us-ascii?Q?SLv6Lv855LVlVl/clKmzONP80/VIAWRcZ0/2A3XGX3Bj/T0pIzJd8x/DYN2R?=
 =?us-ascii?Q?992qVzke3hF9v9xLcGzH726Eu0qDImSJAVipNEK3bKxqOyOEZEMr20U+i1ry?=
 =?us-ascii?Q?LF/osbJwI9YNUdWETpcS/aq4JlprmngvXvKky/awa8f20/ERySPX4zP6ckIM?=
 =?us-ascii?Q?F31evQN81c9cqcrdFxew7wGKykwPq06sshx7W+kZaTXYpVum6ZqUevyelL8t?=
 =?us-ascii?Q?RAgigUa32jvZcIQvQUsIg0LlI0imZVRvz4fl/VY+oixdDBeuHefAqe4uhkrK?=
 =?us-ascii?Q?h9QvzC40e5aD5QOvfmyYU3b4RAGC78WfAkPC+IypYCeX1UayCO/nCIrHGU8q?=
 =?us-ascii?Q?TUhDxtPiKYS+mbVw34uM3kN0DRm0jEQA/1rnyMDIotXD1C89kZHEaGr8PrEU?=
 =?us-ascii?Q?qxzNZ5nGIyOVLTyQVn/xp4+3GyX35ACU4VYcNcMEVO8xZUKw5r2LE+8yy8pe?=
 =?us-ascii?Q?uuSl8dCAgVc+aBHXQd9U6IjmZM5BMb/Kzd0g3BHF/qoEqUWejSuIq2eLTXlz?=
 =?us-ascii?Q?SjBZF/FPP5Dapxh7cCYjLhr6qRhmTxmB+YfBg9AZzx314qOXhoBenqLWbSag?=
 =?us-ascii?Q?yhQoeAzE+SmdFrocuACm4+sbiPNO5GbTIdZ0hDrx6h8dELjR0BpT9qaxvRVt?=
 =?us-ascii?Q?ZHQRS8Q7d+8o6akOVQtskqyLrmGz42vTaOkXxopLkALlvlfQ+4XqekXQzc52?=
 =?us-ascii?Q?CRQnmU5Vn1PMEvBf0gc/+cNSA8Xul9+dcagKEQGuPC/jXdpidhgUKvoyl4AL?=
 =?us-ascii?Q?NzZk6PnxESg7k7LcC3AW4IHH1JW6n5ogRY0KsEr/BhtmHRkin6NYf/8HMwLE?=
 =?us-ascii?Q?mvpxXCcK5dkJLm+GRoF0T/lInRgkdZ3Poa4kFiS9irTaqkStO001egtkkEmz?=
 =?us-ascii?Q?BSo1G8jBtWWMNdf4wrygSMDT+CaCS2Ue0mhcXDop2ftKNOUef1DS3ZCr0aIt?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B5038187EB52B41A84366568FC0E329@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M1KIlN78PC1X39OPEXzr6EQJ6/gvEUGZjtKul57tDp4wpXnOLrt0xeFYVqWXD7/LmDC4RGM8ntpq7JvUO1AfnCT8cwo5i5JmPgylYq4+CG7Lt4BrX2YyVjJdyhRqN3Y1OoO0Teos5YRclau2n2EdH+kuKY4W03qnZGwU1fprc1rFkh3gJOZqrTtpCwYfjImYvDxgFDEKFJd6FbV1St3guNFnhuNZ/SG6pxF8jKsEdyWhoDKblfNVQa97FUdIHiWnMo4rVMepSKZkDsIZtX3RZTISeSRKrbx36fOEqO6fBo7/+4SXXiBSFqqm4VEC321mc1dqSK7q6uQuWWxeYJW+05I4vjsvkM2XFjPNzvbDVpi/9tgEWdxGK8WDjG7X6ObkNkAayFzbGFwfXVIw34OIBfQ3huekbOYprU4uyqhzSsfJH5oNMWaDdz5sLvyZlhgxVLwiJvLeK4AJwU1FiUD3XlTte0fW6G6osAHyO4XXRL8fFXVPsKLKZP7+nU+S7RQPlsvGdm26lzGFXR5b6OgYA4mxTwaSpDql+EMnrd3Hp6c01HruikojamJXPn6OdTWdIWORO/mS/i2yPFsZjlTMjzfeBbPzB26dtIq9ua0u+4IhC0JpgYVEuSYjZ82n9O7L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9095ccd8-2cc3-4036-4043-08dc3df167cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 15:23:41.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcEeAHZvwPoXahqybYe/p/oSqDG4Ks4P8YfEf+Y2ZpeYUTKo35KYjM802iErSMCotWkRD2oNXivbi3pZngRumg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8363

On Tue, Mar 05, 2024 at 06:49:25PM +1030, Qu Wenruo wrote:
> [BUG]
> Even with my previous subpage delalloc rework, the following workload
> can easily lead to leaked reserved space:
>=20
>  # mkfs.btrfs -f $dev -s 4k > /dev/null
>  # mount $dev $mnt
>  # fsstress -v -w -n 8 -d $mnt -s 1709539240
>  0/0: fiemap - no filename
>  0/1: copyrange read - no filename
>  0/2: write - no filename
>  0/3: rename - no source filename
>  0/4: creat f0 x:0 0 0
>  0/4: creat add id=3D0,parent=3D-1
>  0/5: writev f0[259 1 0 0 0 0] [778052,113,965] 0
>  0/6: ioctl(FIEMAP) f0[259 1 0 0 224 887097] [1294220,2291618343991484791=
,0x10000] -1
>  0/7: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 224 887097] return 25=
, fallback to stat()
>  0/7: dwrite f0[259 1 0 0 224 887097] [696320,102400] 0
>  # umount $mnt
>=20
> The $dev is a tcmu-runner emulated zoned HDD, with 80 zones, and append
> max size is 64K.
>=20
> [CAUSE]
> Before the dwrite(), writev() would dirty the following 3 pages:
>=20
>     720896           +64K           +128K             +192K
>     |            |///|//////////////|/////|           |
>                  +52K                     +164K
>=20
> Then the dwrite() would try to drop the page caches for the first two
> pages starting at 720896.
>=20
> Now we trigger delalloc for the above two pages.
> Firstly find_lock_delalloc_range() would return the range
> [774144, 774144 +64K], not the full dirty range as non-zoned case.
>=20
> This is due to find_lock_delalloc_range() is using the max zone append
> size (64K).
> The range would end in the 2nd page.
>=20
> Then we start writeback through extent_write_locked_range(), which for
> the range in the second patch [+52K, +116K), it would clear the page
> dirty for the whole page.
>=20
>     720896           +64K           +128K             +192K
>     |            |///|//////////|   |/////|           |
>                  +52K           +116K     +164K
>=20
> This is due to the fact that extent_write_locked_range() is using the
> non-subpage compatible call to clear the folio dirty flags.
>=20
> Now at this stage,we leak reserved space for the remaining dirty part
> inside the second page.
>=20
> [PREMATURE FIX]
> For now, just change all the page/folio flag operations to subpage
> version.
>=20
> But this would not fully solve the problem, as we still have other
> problems, like triggering the BUG_ON() inside mm/truncate on the second
> page of the above range:
>=20
>  ------------[ cut here ]------------
>  kernel BUG at mm/truncate.c:577!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Dumping ftrace buffer:
>  ---------------------------------
>     <...>-2055      1d..2. 16142us : invalidate_inode_pages2_range: !!! f=
olio=3D786432 !!!
>  ---------------------------------
>  Call trace:
>   invalidate_inode_pages2_range+0x378/0x430
>   kiocb_invalidate_pages+0x60/0x98
>   __iomap_dio_rw+0x350/0x5d8
>   btrfs_dio_write+0x50/0x88 [btrfs]
>   btrfs_direct_write+0x128/0x328 [btrfs]
>   btrfs_do_write_iter+0x174/0x1e8 [btrfs]
>   btrfs_file_write_iter+0x1c/0x30 [btrfs]
>   vfs_write+0x258/0x380
>   ksys_write+0x80/0x120
>   __arm64_sys_write+0x24/0x38
>   invoke_syscall+0x78/0x100
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x3c/0x138
>   el0t_64_sync_handler+0x120/0x130
>   el0t_64_sync+0x194/0x198
>  Code: 97fbf380 f9400380 f271041f 54fff7e0 (d4210000)
>  ---[ end trace 0000000000000000 ]---
>=20
> [REASON FOR RFC]
> I really want a formal answer why zoned buffered writes need such
> a dedicated (while completely incompatible with subpage)
> run_dealloc_cow().
>=20
> It looks like we have already more than enough infrastructure for zoned
> devices, as find_lock_delalloc_range() would already return a range
> no larger than max zone append size.

Yes, and basically it is to ensure one extent =3D one bio rule.

But, I'd like to lift that limitation. Even if one extent is handled
by multiple bios, the current extent split code (in end_bio path) should
keep it merged if they are written sequentially. So, there is an
opportunity to have a larger extent =3D=3D less metadata. However, I hit a =
bug
when I lifted the restriction, so that's not done yet.

>=20
> Thus it looks to me that, we're fine to go without a dedicated
> run_delalloc_cow() just for zoned.
>=20
> And since the delalloc range would be locked during
> find_lock_delalloc_range(), the content of all the pages won't be
> changed, thus I didn't see much reason why we can not go the regular
> cow_file_range() + __extent_writepage_io() path.

While the delalloc range is locked, pages except the first page are
unlocked in cow_file_range() -> extent_clear_unlock_delalloc(). That allows
another thread to grab the unlocked pages and send a bio from that thread.
That will break one extent =3D=3D one bio rule.

Well, as I said above, current end_bio can handle that case well (not
tested, though). So, it's more meant for optimization nowadays, to have
less extent split.

>=20
> Of course I'll try to dig deeper to fully solve all the subpage + zoned
> bugs, but if we have more shared code paths, it would make our lives
> much easier.
>=20
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fb63055f42f3..e9850be26bb7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2286,13 +2286,15 @@ void extent_write_locked_range(struct inode *inod=
e, struct page *locked_page,
>  		u64 cur_end =3D min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
>  		u32 cur_len =3D cur_end + 1 - cur;
>  		struct page *page;
> +		struct folio *folio;
>  		int nr =3D 0;
> =20
>  		page =3D find_get_page(mapping, cur >> PAGE_SHIFT);
>  		ASSERT(PageLocked(page));
> +		folio =3D page_folio(page);
>  		if (pages_dirty && page !=3D locked_page) {
>  			ASSERT(PageDirty(page));
> -			clear_page_dirty_for_io(page);
> +			btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
>  		}
> =20
>  		ret =3D __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
> @@ -2302,8 +2304,8 @@ void extent_write_locked_range(struct inode *inode,=
 struct page *locked_page,
> =20
>  		/* Make sure the mapping tag for page dirty gets cleared. */
>  		if (nr =3D=3D 0) {
> -			set_page_writeback(page);
> -			end_page_writeback(page);
> +			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
> +			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
>  		}
>  		if (ret) {
>  			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
> --=20
> 2.44.0
> =

