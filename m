Return-Path: <linux-btrfs+bounces-15517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36611B06DD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 08:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226633A5C4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D013AA2D;
	Wed, 16 Jul 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pf2Sm2B6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q0b8XnXl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63497221FA4
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647062; cv=fail; b=BTr/HcgLAEkHymSohDYEJIaITKafVc18UkWygQqWKOl7KoOklaQ2aQ2m0a9nmCj7xWRRzyS/iIm9/Qcz09LTujB0hrdoYzEQ9nr5zIB2WMxi7mUGvsNDrmQMzV5mrl/NY26kGv217IIUHonnt1wQXIa7qkqwivL9bfo3G5AJJqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647062; c=relaxed/simple;
	bh=jbxEBIwt1vPNO5IXekP60IJZAu/dyOwmE+lwi4OVto0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IY5DZr66Kr52kLPb0D31VF7uQmIFYKlGH6OEZtAiJjNy8V3hzEbKh2E/QIHPmtDC048unGTJ/3R/m1NemKAYq9iDSjp5XXnCcp/7voRzeEqKOcDW5Yn2+DEtpFIFii//1mktiNfPkV26HlIoNL6ih+H5oIxq2xUFUyx4CG52pDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pf2Sm2B6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=q0b8XnXl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752647060; x=1784183060;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jbxEBIwt1vPNO5IXekP60IJZAu/dyOwmE+lwi4OVto0=;
  b=pf2Sm2B6O46C2upVvOR4I/N04+PkD3SBxbMk1pkcbBssyPcOT1JWan0m
   YJfFbQ0C3b3w+xrg0x458+m2V0zM5eSZBlgmEVo5MlqVCQkthmYSqlCEp
   DHv6fQWwcl1s2Fi2rcIj/SCESj+LO9ZaTRrfVY02MAXM2b+DT5VbrWl7h
   wl87ggi6JfuTninpA+BTi7SmUvcximoZKi4AzBEt19thUBND/COiguAC6
   Vj0P8TNieaxdXYWTMmgcupm8lx62E5atF0XU5vJ0tbvedNEgUIIstg76/
   EsdlVnwhD9JltNNJ94oYQ5i4kBKGHmBY5ONNItj/eSRzrXn5J5QjF3Z51
   A==;
X-CSE-ConnectionGUID: g/Cq44ZbSASotS+5WaVwtA==
X-CSE-MsgGUID: Be0MMfl3SgqOO7YwWgNhMA==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="88517020"
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.68])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 14:24:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF2WDSyFalCjQArf7puyFcddT2hMRNiSbLNNlrDPYvXGQq6jhyYlwEIffL2Ho+D59rsrzdi67me0HF6Uil4EGv+2BgKuc2N6OIfJwmUGMwQQaERSBEA/vEBWSn3dDr4DL9NCZMb2UMK3cJkL1xoYGxjz6GV8Bp+px8hPoosQVNG7W0sIB3Agrtcr78Co9jyS7nWhvA+nl++Ym5NenGWy0/zzMNIvLi1JYAorr/vZ9eNwqnww6P+Hc1lnQJXjhzjMTVgfgSrBQbxFcOV5AZafNMTVqb8rW7eiZyMMWsJCsha0jag3UNz2hg4htpHASSin/24OW45EyEQolTqKNGh1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbxEBIwt1vPNO5IXekP60IJZAu/dyOwmE+lwi4OVto0=;
 b=ed7FC4MS5/suWrECK66UT+bw+iLtMWbdmZBBnA2N8AFoW9xKHbmnwX10DP65CSgFS2gWe/FNBGl/eHfx4/BlXyr7t7lyKo28FS3d9tK4l7qbj0K0rpwTmuKrm87uMS+QbhIDmW1pSvcgOm8UBFuxVkVaArXyhMUObCXScE1NrU3tOPcyrkL0SYnD5fAWDogYCXwoBTN7tAd5GpBN/PhoXNgwjXMpcnsYp05A5mnfleMbzWuDyShnTaBzlddkOfybKsGWtoLLc9W0RwMJaPBKRbW9DLo6Ov5lGCwOwMiYMYeGOQVW76fkKdhKqJq8XfDbjNa0tJ0dNVYabMxwUx0tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbxEBIwt1vPNO5IXekP60IJZAu/dyOwmE+lwi4OVto0=;
 b=q0b8XnXllZMbkrg5XhWN9GG42K66cAFuI+LS9KjNlx1ysxHIy7K8KM6mutxEo5jwrTqkT7eEADV3We5srOs/EW5jvcNQ/Bkthmwy8X2zrzeuzJ6OovM/V6rL+5D/TkG5LVojnGaYp5Uy9OCc+PEomP5hgk5vanPxVE50nF86qyY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7311.namprd04.prod.outlook.com (2603:10b6:a03:295::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 06:24:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:24:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Thread-Topic: [PATCH] btrfs: make periodic dynamic reclaim the default for
 data
Thread-Index: AQHb9bpLu5WQm2ct3Uq7fB9svGCtrLQ0SQCA
Date: Wed, 16 Jul 2025 06:24:05 +0000
Message-ID: <df3f4610-cd32-4897-8172-5fe8b6a9b281@wdc.com>
References:
 <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
In-Reply-To:
 <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7311:EE_
x-ms-office365-filtering-correlation-id: efa8743d-ba02-4571-1def-08ddc4315d5e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHJyLzlXNnlSN1VhaHFHaE1haDRMeHZ6N3BVRGE3d0VRZm5CWGIxWEMwVWpY?=
 =?utf-8?B?ODl0dHgxcHlhbGg1NVA2UE93VVluS3RzazVKc3NlbjhEUU1TMzVuSm5nbHNk?=
 =?utf-8?B?d2hRZmRXZmZJRk5wV04zcVJXeDI4U3BmVWcwc3FIN2orNnJTUjhoOXhXOGpK?=
 =?utf-8?B?ZTBIOW9FRXcwTUtQTlJaUVMxQitaQ1ZDRUwxdU9CWXBkNGE1ZGpPSXg0bmdm?=
 =?utf-8?B?aE4reVFydnJhdWpLNTl0dHk0RkJhTVJOMHpIcERIOUVIa1VwUVZrVEQ1ODFz?=
 =?utf-8?B?TGlldjJ4Z0ZrL0hCTjlUK1hwQkJzK0JtaEc4VUFJSkpCdlNkRFhGaWdyeGpm?=
 =?utf-8?B?OEc4TlgyWStzKzJCVDVUK1U3ZWU1NjFyMTFUWk12M2VDMlZjSC9KWGF3Nzh1?=
 =?utf-8?B?N2FZZ2lUdUVTUXdCb0FOVnlGVXM3QzZDcHU1T0xNc1pDcnZMbWtvQk5yVzY5?=
 =?utf-8?B?dVdtcUFaNk9adUM1Y2VhR0FBcFpPckZCbXByaFVaOE5OVWtNdGV6Zlh3VXM1?=
 =?utf-8?B?TCtlbktDdjl2TWpwSk5vOUo5Q1pNZEwyclhERnRuSU8zRTh4MEljQ3ZUQWdE?=
 =?utf-8?B?aVFGcDVjMm9LVmY5dDFqZU9IOVFKakJFNWtWcHU4N1VZbDY3MVZIWktxcmo5?=
 =?utf-8?B?YlpEajlwaG5XYTFTUzhjV0NCbERjQVRmTytuKzVNQkc4bjhWd3RLc2VlZ3c1?=
 =?utf-8?B?eEZENlFZY3ZYTFhZZEpTdUdzYzYreGhaN0ZSN1p0aFFWM3dnaTlXL2dDcjNm?=
 =?utf-8?B?R3RmQURjTDB4ck5sTVFNSHNCZEF6TDFkdVNyV0JETUdpK2licFJydk1GQVRE?=
 =?utf-8?B?akdQVG1jTlpHTXUyaUdGeTJ6QzdmbWhSaHBXR1hieTYrNndxMzdqam1TMC93?=
 =?utf-8?B?c3NrUEhic2tNYWlqZnVIWWg1UTlkQUhBVEhJZHBPdlROc3VmbGN4UWF3ZEY3?=
 =?utf-8?B?VXNlbEZjak5nbm9GL1huYTlqSDZuLzVFc2FIbGFZb3RPUE5EazQ5Zm5wczhI?=
 =?utf-8?B?Mk43dlpnRWw1TFVJaDkvZm9FSm9iOFhtNnFXdVJCWjZReStGY3p3UVBsTUNO?=
 =?utf-8?B?TENLK0FPdGs5VGVEbk5DWDdwUnNvSnhtbjhMWTErNkxvUUFVRHRxTHFGdURF?=
 =?utf-8?B?b3cwaXpxbWpIR1FRUUxvcFZFREdiL3UxVktiODdpTHppMWpsUzhxTzc2RmtT?=
 =?utf-8?B?UEh1RXVYSDR3dzcyNmxJS1Q1UTRuSVlmS1ZVRlZHMERybk9LdEd6b0xqemU2?=
 =?utf-8?B?d1Z0SUJJSHJOTDJrN2ZyVnRDdHFFZmJSNHpaVnVpY1R5cnQvandYQTV0N1BL?=
 =?utf-8?B?VnAyUkxuYjIwZkQyOWdId3ZyL2hiTmtSMEFxS21ZV0E1dW05aExHdTd5TWRv?=
 =?utf-8?B?b201U0xjZW1SczJqYmZUdmFwZlBscGlYc2YyTnFOZno4emtoT1ZjVFdlRVpl?=
 =?utf-8?B?Sm14TDNtWTN0VjI4N2VnTG9jOFZ4Uk5XMVIzTUF4dmduZVJhN3VZWVh1Q28r?=
 =?utf-8?B?NmVZdU1zNWQrTjBKMVUxY1RaWGg3VzdSK1lvWVhJQlZ2K3hPa0JSNnFTM0tl?=
 =?utf-8?B?Y0IrK1ZlcUR2WEpkMDFML2VNNE5zdktJVXZKM1ZUK3IvRUIwZzVxRXZlVFFn?=
 =?utf-8?B?M2VlbWo5Mll4UUpCUHNVWjVQUXc3VVRORnd5UEo3VXZnZWxTcXEydWlBWmtN?=
 =?utf-8?B?VjEvd0RjVWxseHM1UnNxMTh5NCt5M3VyRndoWVByeUdlc2sxeFFMR1pzTk1n?=
 =?utf-8?B?LzdUN1I4Y0dMcmI0bUFPTkxEU2ZQZWZVZzQ1OU5ZL3BBZFB4QnpDZW51azMy?=
 =?utf-8?B?eHpGREhtRVFOV1lrcXVjbUh3NEcydkpjMGlrakNtQ3RiWlVsZWtFbkpWVGR5?=
 =?utf-8?B?aWhVbE5RR0p2QlpQc1NhREZ5OFRCd3IzZlVMOVNFYUNlbXBWK2xKVFdNckdL?=
 =?utf-8?B?dExpakprYUpDRlRJaWtWWm9yVWxKcVEzRE1oLzFMZ2p6QTc4N1FzUVZ5RnhM?=
 =?utf-8?Q?4w7X70O8Pzi1OI5v80b4Q2ez7mbI00=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXVrNUdPbXEwY2tzbDU1WTkyWGNhTjdsNnErU1FGOGJtWkV0UmJoMlJUVk1K?=
 =?utf-8?B?ZVE5ZjZUcjZWd0ZjK2VKQUNMNjJocnVjSXgwamptVmVzZkluemVobUVyQ3Ba?=
 =?utf-8?B?aXQ5dHVWKzEyb3RpUHBMdDhDU29uTFRYNUY4U25WT2hsTHFEdjN1cUIvMlll?=
 =?utf-8?B?N0pwcy9uOW9kV3prZ0k1VmZScDBReTZobGNJQ3BKSmhXeU9iQ0pVTG81bE1F?=
 =?utf-8?B?Zm44ajVsLzRqQnVwWXBML3Q3cEtWcUo3OStEeXNlVDV5S1Y1VzA3NGt0eHBM?=
 =?utf-8?B?VkFNUHBZbDJrWXFVT0xWUlRDcEtYVDR2TzJkNVorbzN0YlhRWGJ6WEpXeVJE?=
 =?utf-8?B?RlM2UGFYa2RGL0JLVmM0YXErQzQrTGwxQTB0aHZUT1RlbUMybGVqQ2VYTksx?=
 =?utf-8?B?V1Z6bHo1R1dPZTdQbCttSnlEVXNPa3FkdjdwcXRpc3VKK0k2KzBjakNkcVkz?=
 =?utf-8?B?WXRadDRKUUZFdktrY0ZIV05Bb2hQZHIvNW5rOXdxdVBjOW5GZTBGdlBPSmli?=
 =?utf-8?B?elRxaFkyb002dUdrQ01UVzNGdy9VWEZKMGNiSHl2QWZURkVQcEZHVXBvcDN2?=
 =?utf-8?B?U1M4K1E5aVc1RzFkaTI0TXcxVUQ2OUlTWng3aHNqWmJlQTBxcW11VE1HWm8r?=
 =?utf-8?B?am9kRlMwV3llTUVTQStoQU5YQ09ydEthMzZnRHNsUGFoZHpURVBBYUxlTzhT?=
 =?utf-8?B?WStaTjltZzBxc1pFMFFCdGpJMk5uYUVPMzNFZ0R0QlQxeWtmdjE3TjdjSVBP?=
 =?utf-8?B?UU5semhvMGloZWp2U3BhMkN1bTFzb3BxNi8yN2JXK2pRRDRMcyt1UWFzS0Ey?=
 =?utf-8?B?SXhvSHBENnd3clpIYjRNYmNpbFNaL2JBWFh4UHgrUlczUnBiVXJsWmU3d0Jj?=
 =?utf-8?B?dlo2bUpZVy93dWNTZjlrV0d1bXorSXBIMy85NkpNNVdlMU9iUnFiRWpJbzds?=
 =?utf-8?B?YTJOVWpaZDloMUd5KzI3M1pBVXkrUnU2c05Ta3NHbXJCU1FRSG1STUZ3NXl6?=
 =?utf-8?B?bkYvY2xYL1ppSG9mZ2lOKzJBV2t1SnphVTVZWEx5ZVQ4K3VIaFREUmNuV3ND?=
 =?utf-8?B?S3YyRE9Vejg1ck8vbVhpUURmVzcxZE1qMENIcmw3MGZCWTdlOVBnV3EzcVl3?=
 =?utf-8?B?dEhxdFJKdXlsbVNsSGJXS0Y3YW11SCtzN3k5d3NncG9Help2R0lzWHdHL2FQ?=
 =?utf-8?B?S3J6alhmR205T1RMdXlNcTBxN0FtQm95dHBndHRWZUgwL0ZKQytkVmJrM0pH?=
 =?utf-8?B?cFVickhlNXNITnJhUi9rYS9MM3Y3OGlVMlZpbEk0bTJLVVdpUGMxSGRxbGkx?=
 =?utf-8?B?K3pFdVFoSlJTL0pQd0s0VTdZUkFvcnJmamlxdTQ0MU5RaStuZmhJUkJXbFFZ?=
 =?utf-8?B?VXdNK3NDMzBlQU9YZmo4clVlS0JiWjBiZVU2dk1TaFhaK3VPZUtJYzE0SzEv?=
 =?utf-8?B?NzlDU3V2ck9hLzJWNDlKM3RBWnNUcGtaTWFuV3QzcXEwL2NmenE2ZGVhcVJX?=
 =?utf-8?B?NmN0VnVDYjFBcHZucUxtMVE3dUlmU0NZSXRWQ1NHdGFoZ3VMdjY1TGJFbkh1?=
 =?utf-8?B?ZE1TN1dTZjJhZW96K0ZhV3lHMngrTVlSOWxQWHBLZ2o5ek5RYlY4NVZlMjBJ?=
 =?utf-8?B?SG1wRFREc1g5MjFDTWMybVQ3OG81M3EwdW93WGlRaHhRMzRaUWU4cGdnb2t3?=
 =?utf-8?B?dFdVS3lPaGkrWW9iNTcyM1ZlM1oySVZGd1JtTEcxSDVURVNCQ1c3SXhsS0I1?=
 =?utf-8?B?RHZjdUg1WHZreW1HaXJ3SnR4dmM2amdTT2pYNFJJc1ZBSWE0WlRPZ1IvRzlv?=
 =?utf-8?B?T1hBaks2bzduSXhGQThDM004QWhGcUk0WlZZSm02UlJDWTRORVYxeGc2bmlq?=
 =?utf-8?B?U0luUW03endyM0xuNU1xTDN2TjF0WER1eHdrZVFOQmdSYXBFQXZkQzVjMWdM?=
 =?utf-8?B?YlJONm5YYTBrM3VaaEJLTmRybUl4UHU0QnVaZGFJeTAvSGdWTUp0SmpWaTF3?=
 =?utf-8?B?SkJKdVZJbUxxeGYzOVh0Tmc3UDFXSTNQYzVpWnRvWFdnQTkzUVNyS3o1ak5L?=
 =?utf-8?B?UmFGTGxSeVN3QktaUytnam55NWxtY25TK3YxVm9xVkFOYXRndElORmZQVlF5?=
 =?utf-8?B?NVVmNVNxV2VEb1JnL0RFM2gxbVZQRG5LS083WFl4STlpQkZPMWJVY0t2K2ZI?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <924CC155F5AEA540B0592DDDE630731C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Scr0auWbnO9t7BITbksCQ0HTjkbl5kLeMW2X0X/mvApvugMz19Wjq0HhrF4H67zlRpr66c4pD/TwTYHe548iAm/goLg3xdwSXAHTa0DidkD+b1Qy5qtx+glwPGaui8gH5bX0RIHlHgO6AawQX3mmMB48sZDEcAavRo2XV0sJyW1uaEg6CW/CAMJCs3Wf44qv2G4m22nv/cV88E5lpEBS0Zur/Zh4pe+/qpU3Z7GtO0DTwggA0D3/P94zHheb/0v2S1YKzyLQC+IzczfdghtjJ7+WWcb3t7HQS1/kWHWdyD9/fOgDO4WQUFQzOn288nZD35UxydJrUk2w2CIS5qEVzTCjrJL3YfRCgkHxYKhrzGgQCRaRtTfxzJ4FbFHYWZ9rfr4rNqmNOptfyfD8K3bkMnNtKKC0frZgqC6zG/W0i6ky+j9wdC9OO8Jl9rOF8t3QKDB/HnMQZ9R5JrebHwxmzNxmMKeUpuvfxl4zEHE349t+NxVSFnWu5iVfhvU3s5dvlfdQlOmTfmllLJiuI7MY1UTFicZy2k/uddExwdsbpmWdYF+qkYskL1T7+aS7BKm9A8/TZfR5fxdJnAiF7+jjOnRI3ErcmK/FRIuYCO7vsp7rgea0oDdzfuXy/IEtZHn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa8743d-ba02-4571-1def-08ddc4315d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 06:24:05.5162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIN0m934ki3Ex8RL6L/ykVbkF8j7X2uhtI1YPbRmuXahXZmZRm4MvsiTK1kHYQufqDVFR1xko8OYPNQvDvCIFZe+8Xc06H1VuPfemVuODNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7311

T24gMTUuMDcuMjUgMjA6NTcsIEJvcmlzIEJ1cmtvdiB3cm90ZToNCj4gVGhlIGV4cGxhbmF0aW9u
IG9mIHRoZSBmZWF0dXJlIGlzIGxpbmtlZCB2aWEgdGhlIG9yaWdpbmFsIHBhdGNoZXMuDQo+IEJ1
dCB0bDtkcjogZHluYW1pYyBwZXJpb2RpYyByZWNsYWltIGZvciBkYXRhIGlzIGEgd2F5IHRvIGdl
dCBhIGxvdCBvZg0KPiBleHRyYSBwcm90ZWN0aW9uIGZyb20gYmxvY2sgZ3JvdXAgbWlzLWFsbG9j
YXRpb24gRU5PU1BDIHdpdGhvdXQNCj4gaW5jdXJyaW5nIGEgbG90IG9mIHJlY2xhaW1zIGluIHRo
ZSBoYXBweSwgc3RlYWR5IHN0YXRlIGNhc2UuDQo+IA0KPiBXZSBoYXZlIHRlc3RlZCBpdCBleHRl
bnNpdmVseSBpbiBwcm9kdWN0aW9uIGF0IE1ldGEgYW5kIGFyZSBxdWl0ZQ0KPiBzYXRpc2ZpZWQg
d2l0aCBpdHMgYmVoYXZpb3IgYXMgb3Bwb3NlZCB0byBhbiBlZGdlIHRyaWdnZXJlZA0KPiBiZ19y
ZWNsYWltX3RocmVzaG9sZCBzZXQgdG8gMjUuIFRoZSBsYXR0ZXIgZGlkIHdlbGwgaW4gcmVkdWNp
bmcgb3VyDQo+IEVOT1NQQ3MgYnV0IGF0IHRoZSBjb3N0IG9mIGEgTE9UIG9mIHJlY2xhaW1pbmcu
IEFuZCBvZnRlbiBleGNlc3NpdmUNCj4gc2VlbWluZ2x5IHVuYm91bmRlZCByZWNsYWltaW5nLg0K
PiANCj4gV2l0aCBkeW5hbWljIHBlcmlvZGljIHJlY2xhaW0sIGlmIHRoZSBzeXN0ZW0gaXMgYmVs
b3cgMTBHIHVuYWxsb2NhdGVkDQo+IHNwYWNlLCB0aGVuIHRoZSBjbGVhbmVyIHRocmVhZCB3aWxs
IGlkZW50aWZ5IHRoZSBiZXN0IGJsb2NrIGdyb3VwcyB0bw0KPiByZWNsYWltIHRvIGdldCB1cyBi
YWNrIHRvIDEwRy4gSXQgd2lsbCBnZXQgcHJvZ3Jlc3NpdmVseSBtb3JlIGFnZ3Jlc3NpdmUNCj4g
YXMgdW5hbGxvY2F0ZWQgdHJlbmRzIHRvd2FyZHMgMC4gSXQgd2lsbCBwZXJmb3JtIG5vIHJlY2xh
aW1zIHdoZW4NCj4gdW5hbGxvY2F0ZWQgaXMgYWJvdmUgMTBHLg0KPiANCj4gV2l0aCBpdHMgYnkt
ZGVzaWduIGNvbnNlcnZhdGl2ZSBhcHByb2FjaCB0byByZWNsYWltaW5nIGFuZCBnb29kIHRyYWNr
DQo+IHJlY29yZCBpbiBkYXRhY2VudGVyIHRlc3RpbmcsIEkgdGhpbmsgaXQgaXMgdGltZSB0byBp
bnRyb2R1Y2UgYXV0b21hdGljDQo+IGRhdGEgYmxvY2sgZ3JvdXAgcmVjbGFpbSB0byBidHJmcy4g
VGhpcyBkb2VzIG5vdCBjb25mbGljdCB3aXRoIHRoZSB1c2UNCj4gb2YgdGhlIHRvb2xzIGluIGJ0
cmZzX21haW50ZW5hbmNlLiBPbmUgdGhpbmcgdG8gbG9vayBvdXQgZm9yIGlzIHRoYXQgdGhlDQo+
IGJnX3JlY2xhaW1fdGhyZXNob2xkIHNldHRpbmcgaXMgbm8gbG9uZ2VyIHdyaXRlYWJsZSBvbmNl
IHRoZSBkeW5hbWljDQo+IHRocmVzaG9sZCBpcyBlbmFibGVkLCBhbmQgaW5zdGVhZCBpcyBhIHJl
YWQtb25seSBmaWxlIHJlcHJlc2VudGluZyB0aGUNCj4gY3VycmVudCBzbmFwc2hvdCBvZiB0aGUg
ZHluYW1pYyB0aHJlc2hvbGQuDQo+IA0KPiBUbyBkaXNhYmxlIGVpdGhlciBvZiB0aGVzZSBmZWF0
dXJlcywgc2ltcGx5IHdyaXRlIGEgMCB0bw0KPiAvc3lzL2ZzL2J0cmZzLzx1dWlkPi9hbGxvY2F0
aW9uL2RhdGEvKGR5bmFtaWNfcmVjbGFpbXxwZXJpb2RpY19yZWNsYWltKQ0KPiANCj4gTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvY292ZXIuMTcxODY2NTY4OS5naXQu
Ym9yaXNAYnVyLmlvLyN0DQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzIEJ1cmtvdiA8Ym9yaXNAYnVy
LmlvPg0KPiAtLS0NCj4gICBmcy9idHJmcy9zcGFjZS1pbmZvLmMgfCA2ICsrKysrKw0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJm
cy9zcGFjZS1pbmZvLmMgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4gaW5kZXggMDQ4MWM2OTNh
YzJlLi44MDA1NDgzZmJmZTIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uYw0K
PiArKysgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4gQEAgLTMwNiw2ICszMDYsMTIgQEAgc3Rh
dGljIGludCBjcmVhdGVfc3BhY2VfaW5mbyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqaW5mbywgdTY0
IGZsYWdzKQ0KPiAgIA0KPiAgIAkJaWYgKHJldCkNCj4gICAJCQlyZXR1cm4gcmV0Ow0KPiArCX0g
ZWxzZSB7DQoNCldoeSBlbHNlPyBJZiBJJ20gbm90IGNvbXBsZXRlbHkgYmxpbmQgSSBjYW4ndCBz
ZWUgYSByZWFzb24gZm9yIGl0Lg0KSSdtIHJ1bm5pbmcgaXQgd2l0aG91dCAnZWxzZScgcGFydCB0
aHJvdWdoIG91ciBwZXJmIHRlc3QgYmVjYXVzZSBpdCdzIA0Kc3RyZXNzaW5nIHJlY2xhaW0gcXVp
dGUgYSBiaXQuIFdlJ2xsIGtub3cgbW9yZSBpbiB+N2guDQoNCg0KDQo+ICsJCWlmICgoZmxhZ3Mg
JiBCVFJGU19CTE9DS19HUk9VUF9EQVRBKSAmJg0KPiArCQkgICAgIShmbGFncyAmIEJUUkZTX0JM
T0NLX0dST1VQX01FVEFEQVRBKSkgew0KPiArCQkJc3BhY2VfaW5mby0+ZHluYW1pY19yZWNsYWlt
ID0gMTsNCj4gKwkJCXNwYWNlX2luZm8tPnBlcmlvZGljX3JlY2xhaW0gPSAxOw0KPiArCQl9DQo+
ICAgCX0NCj4gICANCj4gICAJcmV0ID0gYnRyZnNfc3lzZnNfYWRkX3NwYWNlX2luZm9fdHlwZShp
bmZvLCBzcGFjZV9pbmZvKTsNCg0K

