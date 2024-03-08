Return-Path: <linux-btrfs+bounces-3095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B472876363
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F21C20BA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E055E7E;
	Fri,  8 Mar 2024 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M7NmgGFC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lq0Jpnkz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F38355C3A
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897763; cv=fail; b=KlhloGIMN0CJ5acY45u6lhPsO6Tr0XnCVHptFAsdxv6yKcuJCCpxf7neTDdKhAHqeWoWp6dP3oB+H7L7NDtcIwk6JbxvXZXtFsKKReBIHhMW5V+2nCimDMA4zi5P9MFM42JU9LBGTj9evYl8X64YOfpZTKEGe69BkoDRzhpXzfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897763; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YljMnAVzQm69qylzQz7PXNghJbaouEpWFs8PR9g47fxScdBtR/AV/Z568+82AGNfDR0V3yyMvbGtGNwmwBWuZpeVKdpqGIUNE6fU/yDGCOjJcMzAHCLl91UUj29w0BT+CW2o6OCkhgqeePtARx4cbBX5DCeia9QxbqSeW8J9YPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M7NmgGFC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lq0Jpnkz; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709897761; x=1741433761;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=M7NmgGFC7VChtJSTq8xeo1oedrd7tFrb8ryM3+OB/k4RKLmWFhh9MgCX
   64EX2Ma2t2N5bgjTyCMPyeHvfj9mcIUhkmJKG/9JkiyMSAaE9IWF6z1YO
   YXoWKfNZ3Qz/iiRycHUejusXPwJz+iOUYqKQJvY7G4EpzvTyYaDBgkGv9
   Y1ejDB8oPEZDFjwsnFlFRT8rfgSB0+AdhggACN7kxMWJR+zQc/Bpo5Hf1
   NrAq2fgXGHomWaHPaVYTODmAdS+udvnVPC6AhaIcHYEmXKXx6RdEvec0K
   mOqSxL4KxT7RM94MY5AXleQZMw5R8x11hPCi75Kw7+3sEf153sM/EDOux
   A==;
X-CSE-ConnectionGUID: ZMSDIWGPS+KICzXoYq4lxA==
X-CSE-MsgGUID: gK1dH+OxR4K7b2uqP4uGtA==
X-IronPort-AV: E=Sophos;i="6.07,109,1708358400"; 
   d="scan'208";a="11733391"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2024 19:35:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXMpn4o0TBpOdn3Z6AG/5PXqc8j5RKfUT8d6VLcTA9tEH58OxN6CZe4umD4/mGlYB+lUzepgYa3MkAHnSZiIZk3ibxkPyeYSeF0JKXgNFrYtCOuSj8nMXLrW0Tja4s/2xjwaDyjHfiC4KVqeLM1iQJgKyGAA0Agd7LX12nsqX05p7dPBhZ2/9MTpCRqbMMakTcy2DIIQzKAG+XwqrCOnlhF3VA7fKWrg49bzcifc+DnAh105qCV0SJs/JHt5EP3omSCUnjro4muvIy8n6kANHqWMIcnC6ntZxGuJLFJ6WXIPIZEFWJfjWoFdoWf6f6bE9OSjPn6Aft8ky8T/0PGI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BRZlvs27Ffx6bW6tCiDe+WOiWzjev214YBn/8+ebRe/2sn4A+QKqeV1YlR/S+M6gwQ8B73I9h5zhWeewvWoIHhGMEMuuYzHwzZXX3pApvrCwtGTx/t99sFWJCNTp3h6GLsaLvfyHLAhYFHC7b0VoPDul1fuitD0XE9iwkxlgSK7BbVIGube9wxgp846hGj+aLVhhTjdixNzsXH/qjNTjLAeZdwhxXOjlkEehDLiMqwOZPQ9OF7WoQx3eAs4Upw95Hil1dQlExlnOyo4bhWi6azquXeVNxvNeCfjKz4ZWw5Niul+I3ql/Zt8Yc3cu71aLEq0KD/iL0/lQcfUjVaL+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=lq0JpnkzSLXSKAWSDMfDVF2V0gRLj+wjxg13O2OGm0voGj1dYsboBFw4yJfV4pWuIoGNWWG+CLR0gkxDytW90hIyhVZoUZUTGIrw38uXKl2NyIe9cCpAo6FjwSIgsEE2+pDzUNvGUso1T8NXQk9azRFjdHgCkIVCMoTBWY4CsBI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6636.namprd04.prod.outlook.com (2603:10b6:5:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:35:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:35:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove pointless BUG_ON() when creating snapshot
Thread-Topic: [PATCH] btrfs: remove pointless BUG_ON() when creating snapshot
Thread-Index: AQHacKjJsoxgVB4q1kS4jI9k1PGGLbEtuEIA
Date: Fri, 8 Mar 2024 11:35:58 +0000
Message-ID: <7b207aa5-ef46-4c38-8437-c2a83eb353c6@wdc.com>
References:
 <0d0347a460b26e36966f95604ca8c69b956f1c62.1709814676.git.fdmanana@suse.com>
In-Reply-To:
 <0d0347a460b26e36966f95604ca8c69b956f1c62.1709814676.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6636:EE_
x-ms-office365-filtering-correlation-id: 1d711a49-5fa0-4751-bd5d-08dc3f63ec8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KFUp1KLKm8xVzBn6KqQncvFOJ1SkOh4xadvpM8JMgWtesxBArdK683K0kTYOK59o2srkJ1ahUvhHFyGCLzTgtjk4zX+5/V48x2kOX8XYBU5mc+Rz04mMErhCbI/biUfmYKl96Ib+iuajiBaHOepe9NehBMYyltfTe9SByVt0KcXmMluNwMJe4X6wdcmrH2CzpEXgr4/Wg66fbWi2CvkDy8Y7w/OQ3gfDkPSowdZkjVEEAV8TRHUzEVCA8PJAlJE4/ldnvpaJ+bPcBDCqw8kn9KpzpuPVKG5DbHVStdzF1QI4jnw/p1RjtspGBWKGVsYHLahlx4gMT3lIsTgcKy7fFofSqCYLLYl55OcwpLMj3uSh0Dpnvn2OMKqsTX/FL4mC9LmLP8Y5dw5+jo0P4czDvvR5Lg3WAgOvPmXWdYxGkOWkYqXZMC340w2BrkdEIRYtyODo32QB/cf8TLIGfVCIO13v3OeNnXbO0m3E5C+Lay2ZuJpEHXhhrAt+WIlAUGgKv2MRtjKY0B+G/LHA1X4Rk3/eAvceAAZ2O0Ti0j2ZhNt1T3mtNIPoKrq83c5mlZ7b4hByI6uF8qL258ul6kkKF8b76dxeKvEMgSC/jnCacJl8OL4+YPR4Vef68rJMWDzI/5VW9W++UTLV20k+zh7jjBt170KPrOJp0dzgulRVMo5/M819z54RyBNvAG0cNC0cqroNV2fh2ORD3SZEAad1kjSBqBFehy1LPny5iMAkY34=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnRuR0NEWGM3Tytjekp6Z1Z6elc4OFJMMDhYeDJVK2tUczdERUFWVUVUMVpk?=
 =?utf-8?B?NkorOUVHU3JHQVlHa2pXaGliLzFIYmc4Yk9vRXJnMWRSZmU2UEhKcjV0YXUv?=
 =?utf-8?B?aEdvcU9JUG5xekFpSm5vVHFjWXBXTHJSckhlWFhwa1p2bEl0V2k1ckV6NkRy?=
 =?utf-8?B?OUloOWJISkxiK25xNnNLRmFERjl4VEM4T3Bxd1BmMGxCdS96RUpwQndvcGVm?=
 =?utf-8?B?UXRDc0hyak56UmdBWkFjd0gvNmp0bVJmSldXZjVDL3c0RTJ4MGZxdU9HRVJj?=
 =?utf-8?B?cmxVNG4yVzFmVGY5OStzMGlGVmVDdk5jTjhuZy90TEljUDJUbDZDQzlrSkpR?=
 =?utf-8?B?RGhzUHBKSVFQcWJXNVc1dkthMURYSE8reHluZUZIeDhBTExSM1FteDVvSnNU?=
 =?utf-8?B?c1NxUTRBdXhmemVDNi91Z21QR3ovSnB0WXZ1M0wxaHNVeFJXMU5HOE8yTmls?=
 =?utf-8?B?ZWdhdmZ6aExiMDIrenhMbEVCWXMzL2ludzUvS2xmaktIUmhHQWMwNFF0Y1V5?=
 =?utf-8?B?RjQ0cHk1RjNMZWMwV1hPTWUyQ3RTV0tnOVNhRzduUks0eFQ4eEM3ZXUxS3g2?=
 =?utf-8?B?cmdVdDdaMkV4b1I3N1kvQXpFUVZDK1V3b2JZZHVGZlMwa0tXQ1hBMlVHSEk1?=
 =?utf-8?B?UElFcmVhWTRBanVRTmRZSmhqdWowZm5XMU5ZS3luQlhvc3B1Kzh5NTRWTHJE?=
 =?utf-8?B?aUQwaHJueE1vVXRtWVp2cnF0M1QwdVdYNXBWbkZPa1hudVE3NWgyVE5uR1VC?=
 =?utf-8?B?MmErU015eTZVczd2elhqQWtLOW5WUlBZQUVqZHBIQmZYWEhFeHdJN0lGQjhP?=
 =?utf-8?B?dU5YRFJZY3R4Y2RCeUdJV2ZwTW5UakZaYVFZbFIwZ0R0aW1jWmt0bWVhUVpO?=
 =?utf-8?B?YkRxM2pVM2QzREU5UzFwZm9COUFNdzU3dndJcnNlNEY4eEpDOCswUmVIdDlV?=
 =?utf-8?B?VEh1UGttT3VJelRtQkJzZGJycSsvNGFhaVVaZGVPai9CU1kwUHZ6aURhd3o0?=
 =?utf-8?B?bEVBOEFDb2tGUS9veGEwaU5XQUQrcm1WbWV0RXphTDVPMWo0Yk8za1Nud3By?=
 =?utf-8?B?MitDNXB5MWJYVTJoVEcvanJqNkhuVE1hbncyNjBpWnppOEtHN1ZDVHlrcGty?=
 =?utf-8?B?MHd0NzRFNWpxbnNhZ2hBSTNkZEJIT1JTUHNWdmtxOThJR1Jxelo1c1R5d3l5?=
 =?utf-8?B?bXpnVmFrVFhBcTZiLzU2Y2hZUkhhQlZxNXVPOFNyTHlQR3pXZ0hNTXZJcGhG?=
 =?utf-8?B?blR3VTFPZDZKeGlXV2srS0NtU1JlSFpDTzNIU1VFUGxqSFdPK0ZPdmVrQTNk?=
 =?utf-8?B?UmY3R2ErYTE2cGNubXIxT3kraUtkbmpGVHg0T3B4M0tLL1dmY2pjQXpuMmRv?=
 =?utf-8?B?ZUcxVFptTTJTUGIrL2MzT0lDV0ZXNVpqQ0ZJYVlnb0dmdXp6QThHSm1ubnJ3?=
 =?utf-8?B?dWxIV2hYZVF1WFl0ZFNaTHkyS0FuUEJ1OCsxMEsxV0VuT0M1TUt5YXhoTjBP?=
 =?utf-8?B?MW5iWTJHbTNiY3hTQmlQQnVhT2t3NndmUTlGQVB6R1BIVDlUZDBoNXZPb1Jo?=
 =?utf-8?B?K2lkb3ZCRStEbklXcEFOY1JucmliS054TkNaaXJIUWorbmdwK2tiQnl1Q05O?=
 =?utf-8?B?R09SL0hFMUJzbjhzTTl1VlFXbko1OGptdXJCNmtnYnVYV2xKYUljVGcyMERJ?=
 =?utf-8?B?Nm9McEs4ZC9SL2tybW12cHE1TE5tYU1naURsaUpGVUFUQjdzYjhsczFTOS8z?=
 =?utf-8?B?V2RGRU1KLy84SERTYzYzZW9RaExocDBRanRHNGE1S2plNERCdGRPT3dXTm1H?=
 =?utf-8?B?UzRzZjRuZGN6RkpydVRBVWZ5eGpEcmE3dTF3eTljSHZMMkNyQjFRWjUrVW9x?=
 =?utf-8?B?NjhzcUVQUnhPaTF2TUQ5QmFMeDdlRmROY1lWcHd2TnEyUzJHbGtpNzY1Qitx?=
 =?utf-8?B?WExLR2Z6b0NtbnZoWVEzeXFlY2pKNjZ0ekVRNW1Ba05Bc21IQ0hyM3RJUFZp?=
 =?utf-8?B?WmZWYnRaT0VXWG54VmFWNmRPOGdXQklyb0Z1RkR5dW10TDZLZ202WlpaN0pj?=
 =?utf-8?B?anZYMlBSUE1hVWlvem9VRTZRTlFUdHhTLzdtbVZyK0JWVnJnNjQzaUtac3hY?=
 =?utf-8?B?bEMrcEJFdGZnRXJOU2kwVjRnYjF4Qld4N0p3YmNNU0VXNXYzMjR4V2pxMXVX?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <911D512DA183794FB0FFCE901F2488F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NPoS9lqlw4hL2viMxjXvwsOwIgxeMVBYQMSLXGaz4YcTDC8g4XcipFsyf4iM+h01yN/F8Ubz3+bzo33q4xoquOYOYeZZfeogmNIqImZyYei7SXd5TeK8We69KvJEMP8miA2IFpfWsq7fksuoF+HK852LbUsq9O+WjvhxqHn6fOmSpvKz2beKoXRl+H8Cw7kBf76Cyu8XgCvy24gLvxSQhroTGNiJ1wbW9HVC6TkLgAEvF/W9nGgrOEE3Am3/D9c+/Zkf1xCxJe1s+5GDt1ZNoTsjktzf86NNCzLlHMAR50O8RJAYspgTZ6cU1KrsuBvZmLIHVyUGN36JysTCY6cw9ngiFdgMayLmC6GCpOZbUNNleyk8vxjyP+Wkc5+RTpGJwt0YW1Oxhpx8NSVUwPVCq1ggSOXDwfJ99Tut4Il5LNbz3dhmjtY6siNe4a4cw+i5uYqXoMBovfKIib5mCRelz6RdL7CVcnLHFyHrjjBmxQOYme9HCwNjLhEiyy5LHDkwAXVsYWb08saoVbbRhKzVB1+FKyXFVj8qAW44ROYWUvb2kD08D9zgxt2eQVdqk17Ddpx9KuwfQJoZ84uWZ7uo74rN/C5u2dQpwDZeGjzKhOIDm0fQfqa9pwb8hzhwNyra
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d711a49-5fa0-4751-bd5d-08dc3f63ec8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:35:58.2595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8HRFO4wOs+GAGXz4yYzTnTGB4uNK3kMzK7mBidEDYR8TQSETT53jvG2MOHn+lXQSwyRogqyTr18gx4Ln5H0BTLydFhqRAHx7eCFXDokYAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6636

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

