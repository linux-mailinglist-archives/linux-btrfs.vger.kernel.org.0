Return-Path: <linux-btrfs+bounces-20769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPFvJBZlcWmaGgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20769-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:45:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263C5FA50
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 00:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5EEF8C56EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542644279F7;
	Tue, 20 Jan 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XOjSYgZv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nIXmddU1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9996421EE2
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915025; cv=fail; b=hJuXL9KqQ/+Ow/w63LgTICrYKZpw2czW/qn+QtSOXIrL3e7yi1p9CPUbw6AaaF7CnmOhKjWZIaoB1+VSOTDHMTOrBl+7ZoJqXswgVK3OzovL76n1aKpdj+d+qf6pxPIXCAGXdbgSHFXaKHQgplLCtxrlfCc0MuRMgxad9LS3MRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915025; c=relaxed/simple;
	bh=7O+d6hraYBEDYqk6YaDYxr1h7jkf/qQ6U/AL24chX7Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9EOxilGuH4KkUR2ZEFz/0SdR3yZnuSL1/LgPNr4zw4VMRW0GxTS529t/QKNIqQVUjcbUtTjjue995/8OI0fc0UhzcAj9eTpzuqpyOnDlrqSZt79mQK90K8SAhCP9TioJ8hG331ICYn+7q2WwmiTe7NmZVvHb4xzfoxDIQxxqoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XOjSYgZv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nIXmddU1; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768915024; x=1800451024;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=7O+d6hraYBEDYqk6YaDYxr1h7jkf/qQ6U/AL24chX7Y=;
  b=XOjSYgZvNdtxXFlreHKV3X1wkO3kDbu6BqUd73DGC7L+am5vWHHH7ERQ
   8zB8rYKkfSuJokK1L2zK7RjOFI8MVuHgfzmSNko36+GC9DGA/T/5Qnhw3
   5t+ahtLszMpJg0CplFPRg6jUuqza9EuX9wm2WS54WvO8i0pLivpBeHDxP
   0UgeIGbDKM+sd0N5qRoUcZas+KUYdBq32FzN0LFBjwCyIv13LvV2744Wc
   uH2tpAonR0ryL976/Cj7AE5xlL7QMv1f08v+1TeAzMMXzF2+E6CIEd4jG
   cyy+uQojPzQxGCYhRx/INvvdj/o1/QE794sbUgWZ47w9JQ60TR1AU+IQE
   w==;
X-CSE-ConnectionGUID: dBe73am1TwWgjhl8TyXCCA==
X-CSE-MsgGUID: D/xIyc7zSACSMjxN5pghGg==
X-IronPort-AV: E=Sophos;i="6.21,240,1763395200"; 
   d="scan'208";a="135741287"
Received: from mail-westus2azon11012056.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2026 21:17:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUhFOwE0IY3dphX6aORtZf8BytSBc3iXm8tw8jRPxJdAJFE7XDO89yocw1f/Y2OFW999RxPx7gsZcduRpN5mXkxu5a/nrAmQhp9lgsxk7esU82BEZwBt68ltvYirsuf4pxDi3xZKYmQR5/pBRmT3LkJryZIxX4fL9Z8OEXLtFbLUinVNND1kaDJ6izLAFHQ26fztmkwoAaBJ3f/Y/vSlDMRxp/cvS0gCbrrOjTPgSfJdYtIMVgC5imInxR0ArEumVjkPW273E8deIiHsPj4zXJPBtFI99MbhrYzxCJ9hxQzLt1zaF9fDmBsJcHO9uhuqi1kEszwuhIHbpQxHFS1n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O+d6hraYBEDYqk6YaDYxr1h7jkf/qQ6U/AL24chX7Y=;
 b=X39Yf+nO/3UWPcf+k6FF28Wy3KSJIdbhCWu9r8r8+HcUb89mMnpjRysqiFHtxNYESJiQWYiwZ6v2XoJDsUmrwDW9m3q89JH0M6y4oX5JHj0rbriTPanNM/Sgwtss5sumwNSRCf38Am/S6gjat3ja1SsYZ+CY+h20STOmnjfl5xxS+Fc+YUriOyR50USsL87V3lotllDCBs2Us9SLS1/P+uToGOHkL1zx9V8EGfUR9l/qoKsX91rhh1dfdTQ4RVPvxsdyxLdE7XRrHAGLg37fOloBhgFpBqPDyRYgDYtXIRMg6CdyEcjCXM2+sA7vSaJQQtn9yoM+dv6C8mxYqq1rkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O+d6hraYBEDYqk6YaDYxr1h7jkf/qQ6U/AL24chX7Y=;
 b=nIXmddU1Rby8wJ9+7zkFmixK7rRL4/F20KtjKEOclmSAekG1lRYkz/Ntlr+uN6+dQZ4G9gditCv3i7hkSfhpM9+2A09YEyjQifRqm7FBb+kcX9ClVmdRA1KFvyzeXvhWGJh99zERZv83kTB4X+CjzKkGB3GIAzXkjj1GYXgtDS4=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6687.namprd04.prod.outlook.com (2603:10b6:208:1e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 13:16:58 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 13:16:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: some cleanups to the block group size class
 code
Thread-Topic: [PATCH 0/4] btrfs: some cleanups to the block group size class
 code
Thread-Index: AQHcign3yVeZDvFRXkyqEy2T4HP8tbVbCggA
Date: Tue, 20 Jan 2026 13:16:58 +0000
Message-ID: <e809392b-18d5-4853-92a4-78e10b32f1bb@wdc.com>
References: <cover.1768911827.git.fdmanana@suse.com>
In-Reply-To: <cover.1768911827.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6687:EE_
x-ms-office365-filtering-correlation-id: 0ba47ef2-4923-489c-9299-08de582630e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1Rsd09ScDhLMlYrc2syT200bDRXbFNjTFJFTmJzS3FWKzdaWFN2ajlUYVJr?=
 =?utf-8?B?a2pERkxqdmo2LzlNbkM2T2hlcTVUU1dhVkY4Uk52MURueExtRUV2MTBGcitZ?=
 =?utf-8?B?ZWVmMVJHekI1c0tidVorazEwQ3k2K25VYStML1FKZWpFb0dFVWxOaWJSVG8x?=
 =?utf-8?B?TzcvYTVrUWE4TmczdVVVOHZaWjVSNVcxVHJLaGY4TythM25NQ3hud1VhQm0y?=
 =?utf-8?B?NDNpR2RnVndsSFh5TkJkckhnY0t1aWJDclpBOXVaNmF0UmlqblJKY0tBYk1m?=
 =?utf-8?B?RXR3ek1IdVlpNUFLVGlvMTRNY3BYczk4YWwrYzNVazd1NEZDRlh2MTJJOEtT?=
 =?utf-8?B?TitCZElHTHNsSXREcWNBVEdzNkZDRlVHMWVyUUd1TDhoVWdWQUNVWTkxUXI0?=
 =?utf-8?B?Um8wYjdpSGdDNUFZWkwxL2F1ZXpDS1FKN01YZUROWDNpbFdXTDNuOGV4cnV4?=
 =?utf-8?B?ZzU5Q2ZORmJDL1lRUXZtNzdMODJtdXBHV3NaUmVqb0xGQ2ZGNGxPZ3B3WXhZ?=
 =?utf-8?B?NmJnRWgyem9QYnRyeHRoNWJFa2U2YnhvdlJuVlM0VkF0anV6MnhQRFVkU3dG?=
 =?utf-8?B?KyszUVFOcjlYSGZsRW55Q2lDdWxWS25jejNIZDJSMlhWdTBOUmsvRzNqa0xQ?=
 =?utf-8?B?S1B5S2V0ZmpBYWpFY3NyNjJkYVdGRWJ0MWRjc0JCd09oQ3Vvc3daM2txOE03?=
 =?utf-8?B?d2NicnNuQ1duejBiUmVlSkhzN2VGSHdka2pjTHZnUnA0MlZIamlwUUJIQ2s1?=
 =?utf-8?B?TXM0b29nTVJRUXNEb0NwbE5aTFFhaktQRkdpa2cyVDNrMU05WUlrZ1BYdjRl?=
 =?utf-8?B?WE1oblZrYlcya3ZiNUI3NG9mRURpNDBOZU5VNXpzRkFqeDFMeEFSaExzNzZ5?=
 =?utf-8?B?V1phTWYzZ2pCcEVGYnhQSWFnWmNzT3gxR3dVcmtlcVhKbE1RNHdkaisvbDZ3?=
 =?utf-8?B?c1hDaTBMUDRFdWFJYzdVQkEvckNyVXNXTVBOSHBISUZkVmdqT3JqQnYxRGI4?=
 =?utf-8?B?bVZ0ZnZvMTVCNERYZ3RycDlrZElzenMzK0lEeng5SGNSRnZNeUNhVzdnSWhY?=
 =?utf-8?B?TWpNYkhPdEMvMGYwenJ3THhWWnpmZjlkNEZwd2ZaU1JPM0F2dUdCZUJTb1JW?=
 =?utf-8?B?UUNVN3kwZkJWUG1nbUI2Z3NDaGo0THVoRUIyLzlxQzRvVGdTY2JyVDFJT3Zv?=
 =?utf-8?B?SXNzRW9jQWNXL3B1M1o0TTluZkFTamRqeFlvR3dwRngrOW0wQnA3OXg5R1RN?=
 =?utf-8?B?WWxMRzlhbzBlZlA4N21Ja1l2N0xRRDh3VHlZYUZHMXY0STk1dDBLYmdQL0Vi?=
 =?utf-8?B?OWU3TWo2UWVENVArdDdBSkdxZGl1L0NVMUJTRVZTanFZb1ZMdU1wR3Q1Vy9l?=
 =?utf-8?B?V3ZybDNHT2tBSzg3dHBwRHhBSlJvUm1UUkpNOW1iTlQwemswajdpVlVtcjQr?=
 =?utf-8?B?UWpFbkczQTM2b3R2eWtJa3Z3OVpTM3N4RkRscGpYeStYdVNwbk40c0ZyZndt?=
 =?utf-8?B?SEdPZDRibzNZMVJlejV6RTN5SzRyVWc2S2xudURwSWU0dmFVZGhEWDNrT3Bv?=
 =?utf-8?B?OTVBMkxFNjBJajJXK3lkRmlVUW42N1hQV0l2V24vc2FEMUN0Qko2czlKTW0r?=
 =?utf-8?B?SmIwMWE5WXJ0TWdZbUc5anp0eXc4L3BaU2EzZlJxNnVsY2hLMWhVbjJXRytN?=
 =?utf-8?B?SzZXR2tkT1hCZ2d1THN4a09yMmpQcU5DNUt6TUM3WFdvb3cwTFBOQlVqcXZv?=
 =?utf-8?B?S0hrRUdRUUV6NDVQTEpZK3QxT3JlZzd5RHhnU3BMWWhHMVBZQmNUYVlpbmVN?=
 =?utf-8?B?dUVGemg3cUJqR25lc0hkTFN6RVhmSVYvSzJmWTdBUjBBVTVhK05CSWNtQU9h?=
 =?utf-8?B?clh5QURmYUhqL0ZtOEFaZmNQYXh1TDREek9DZVJnWVRSbHMwSmlsRnpISXo5?=
 =?utf-8?B?UkVrUzdSa3c0ZkFUWEFyRG9YQVBReXJCWGNaVmpSU0N3TUpzRFFNdVhvT2Y3?=
 =?utf-8?B?bnVCMXNRZ1piamEveWlRMWd5VFpMK0lHdXZ6RHBCY0p0TWpoTzBxbHI4dmJx?=
 =?utf-8?B?SHNWTUd2M3p5dHg5enhkMVhHclRzQjExbVo1cWo4eUNJT3lwOWZ1cnVacXpp?=
 =?utf-8?B?RUY4QXBjSFpFQUJXTWo3UHNFNE92eTRQcXZ6bFdFNkR3U2RsRHU2TWVsdVZF?=
 =?utf-8?Q?g4lVIRHU2CKbK1Q5qqzymJY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2Y4TmVveWlqdlBpZnRGMnMwT3lGVDFST0FkODZaa2xFMnFnNVFhdzRxQTlN?=
 =?utf-8?B?dTY0M0VWcFhocllSR3JvMjMvKzFOdzFHUWxKMmtuRk5WalZOUEVvOGJlbENN?=
 =?utf-8?B?NlJwamg0S0JzakJIbFRzblJCS1MraUtaM1c3OG5JTzhQd3kwRzFkekZ3ZjBi?=
 =?utf-8?B?ZzVTbXFXRTBycVFTYmMrdys1a3hLaktKZm9DRUxKU0NyazJBWjNBVXRkVlMz?=
 =?utf-8?B?NXpsSXV5b2E0TGgxYkdkYUN4MVRIeUgyY29ma2RucFVQRU5DT2ZsR0lnT0l0?=
 =?utf-8?B?TlQ1QkJCcFJYbldPMERUZ3UyQnAxbFdsQnNGcjVCdUJuN2ZFd0NPOFY4Tzlz?=
 =?utf-8?B?VFhxRktRM20yTHhPcEJYUmhiZDhXMGl2RlVtMTc0YzE3NWlwb2M2MzlTRG91?=
 =?utf-8?B?V1EwR0xwWEEvUmdpNytpQzNKaW1mUXVobUd6RzZ5OTdaM0d0cUpHMEN0MmdY?=
 =?utf-8?B?RmQyRFVRWHJQSCs1STJwaEVCNkRoRmpacFJ3dlhIZWlXZXZHVWdFYWpKTngy?=
 =?utf-8?B?U2NlUjZXUnYxcVUrN29NcTRLMm93YldBbzFzUVk1NmJIaitHSTZZRlRmdFUv?=
 =?utf-8?B?aDEyMHhpS2g5Z3N4L2RUR0hjZlZVQ3o2aHQ1VWNoM1FQUzBwcytSclN2L29W?=
 =?utf-8?B?NWxaa0hWL3ZrNVBzblorSlJ0YVErSnkxeXNNMFBwNGpxY2Q5NjZMemxxSEw4?=
 =?utf-8?B?REY0VVdCRnc1VyszdU11WUM1dFByUVlSRU55ZjdFdWhzN1JsZGV4UUwzemph?=
 =?utf-8?B?cmJtTmZFU0tkR2U5QWcxaFJLS0NoeUZVWmNyd29OQkIvcjBRcEJuZElGaUVB?=
 =?utf-8?B?YmlFMHArS1JmQkNWQ2lVeXoxV2tCQU1vNnI5M3M5Y3RhZndGWFJ0akx5MC9a?=
 =?utf-8?B?aHhyOGltN0VieHg1c296Z2pOZzNzRm1jYlUyK3lMM2ZwVmhtaGpZMEYyc2xt?=
 =?utf-8?B?UWRKY3ZlRS9nMkxzZDBodjZpMUFGcXNncXFBc1FhUldVK3c3MFZmeTZ1NldC?=
 =?utf-8?B?Yi9TQ2NVaHJjUERCZ2ZlTFprUm1CK21GdXpCdTZJYlRzcERIM2hPVFNRR3Fn?=
 =?utf-8?B?UXZLQlRCd0IwRnhlQlFCK1Z0cTZuYzRkS3VSQTFVcjlXemxDWHVtRXhJMDhm?=
 =?utf-8?B?MDhUak95TDhIZ3h0bTNpZE5TQ1FIbHYvSXNoQURGRk1wRlF3d3RnbjdDKzVB?=
 =?utf-8?B?eXBLRnAzNzl6OHArd1g2cmcxT3VGNHFHL2wwcEF0TVVlNHhHcDFoYW1wYmsw?=
 =?utf-8?B?QU9jbVZzVXl5SlhwWGpQU1JYSWxxL3BydTVBM3NHWVp4R0VDSmdkYnJsdzhL?=
 =?utf-8?B?cEZFSm5DTkl4eDJGZ1g4QnI4ZEk3azNiNCttV1B1OWNjRHpQWHZFbUo5cHRp?=
 =?utf-8?B?TEN5Wm5SYTZmNEtRak9YWHF5QkI0cmlqa0lVV2p3c1RYcTE3UkoydXgyUjdm?=
 =?utf-8?B?Vml0QXUvRUJWVHJQajI5N3pqQU1kOXo3Q0wyK0k2YnZETEdYc3VMZERjemly?=
 =?utf-8?B?RGxRWXplc1J2dGg0T01HMkdXRkczbUlyY01pZXVIay9XbXFmQkk2RUduQjRo?=
 =?utf-8?B?Wm45dGcxQkpscU8vMG82YmF1SldobHJMMVVac2tMMXcxaWFhdEtZV3kxdmdB?=
 =?utf-8?B?OVJnbDFLcjJ1VGVST2FpZ3crSjh4NS85bUI1bGJwVWw3OEFsZFphYWhXTzBj?=
 =?utf-8?B?azVMT25IeXhSNWVuMFVoTERoTzVrb2hQMldjbVFkQ2ZZUXg0dnR1ZUJpalcy?=
 =?utf-8?B?Z2Mrb3ppUW1MalU3L0lOR1J1SHh3ME1zZDNvOWhOSUkrSGp3cFA3bzVBT1B1?=
 =?utf-8?B?UEt2TzJDNXpHQXliRXRTWWtkVHRReURMTWFBUFN3enUyT1g4d3hHZ280bWI3?=
 =?utf-8?B?Qkd4c3JNc1NUdDlndDN0REpvOUN2UXhsUjFoZkZNUFZCQ24rQVAva2Jpd2pT?=
 =?utf-8?B?eldkdUpwd2YybnplNklDQzhWRGRyazZqQ2tMNWxSZjdCRzEycUZIYXVJRlBq?=
 =?utf-8?B?REF0Lzd3ejhqSTUya1kweW1sakV4TndhL2xpcitja3ltS0tiYjJCUGY1N09L?=
 =?utf-8?B?N3pJc2hFbUo1Q0s2TXJaTEtMVm1xekN1VkNEM2wxQ3RRdUJVMEVWMkFFc1Mr?=
 =?utf-8?B?dm1HcldhOGpuT0dkWm1MRTM5L1FBMlVrRmFPTnkySGhPaWJtN2pNOTVhUjFs?=
 =?utf-8?B?S04zRFY4Qk9Zb0JwbndleTZjS09NTmQ4Vy9NWCtYU1FBUmNTZCtwVXFNYndM?=
 =?utf-8?B?MXNBY0wwbW1IK29nSUF0aDBYejlDV284WEtUL2dQWkJNa1JSOVhML1kxNFBS?=
 =?utf-8?B?S0xiSjE3SVZnbWlJUE5GTmVJa3d1UFZPNXBLRG9FWWdIajVxd3dDUU51R2cy?=
 =?utf-8?Q?Ce0vixapAu0yhpkE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CE51E4300BEE24F983DBFCF6E703A5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hJl58Ntcn5ZPhEZdgKtq3uKseT2hQgelmXg4NrVLjPAsag6dLHdY7CGympSvKBfqTynkpbjRylSKmcdpuQ4wFuCw78+dfVGfii4eL+fVOgVY6dCuiY1uDhUqWcX2GEJdmqeVPzVRcMBTyQIYwxfyeOnKFMjKniIC6CfPg1F8stQp5ejmZIY4SwxFAOUSyxoJ1TuL8tHdBF0TyeGskEEDx0e8CkLeev3+wONTM5kcR1Jr5tcg6LNixhl1ZoKqdNSgP+W4rdTBgsqyeHZXoHn7w8OlEyrz5F4LtwCaplklhDArjFqfrVfwaPxv/XK72rg4eSh3szvPPekAsH/9Hsw+xYDOUpOgynR2lIR+/m7si2STlLTrR/28XCBIZ0BZNxo+FjoiX7I++IWzGbTTa5AWN6oTiN0k0io2Hx7db7oj8JEUKtJMKlNcgLroBc9rPqOhN2gyzM21z1HhfVqjnwV+QSAn/LDTOlPIbf8L0gB4fbtsAWGuu11c3AKKloIJ0YksZLts0RIAQF+c5JJ40E45uzcxnGuHPmPLCa89Jvik0oWb9L41MeQ3deXJ7qyvS1DtWSBh2KoyIkmFusXIrJVjqOGnAQBkkxh0K9si95KJ8bzM/0nwvyZwy6FaBEpHp0nR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba47ef2-4923-489c-9299-08de582630e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 13:16:58.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wbKeqeuhpeVVth8zOPqhtWqZQuC4vfgE9vf614Zn9tmeugMwbkeyOve4dUGsQCK6Ar2utgArY05Kyvm/xWSFlQrcFyZABcRTYHT27ThTLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6687
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	DATE_IN_PAST(1.00)[34];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[wdc.com,quarantine];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-20769-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 0263C5FA50
X-Rspamd-Action: no action

bG9va3MgZ29vZCB0byBtZQ0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KZm9yIHRoZSBzZXJpZXMNCg0K

