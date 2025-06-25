Return-Path: <linux-btrfs+bounces-14933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4EAE7670
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 07:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378C01BC2F0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC01E22E9;
	Wed, 25 Jun 2025 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dO98AFvw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GI3epMMH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F3182BC
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829861; cv=fail; b=Ou7s/wB3zUmhHZXdaOhE4qnpRYD+/YEtJ8SwBVquSaNp6bw79HKx9iaXRGvXUYh8hOD21Dwtt0Xtmb4zqWMm1leMHXoydT7cKoycG3PshAV8bvlOfZASh6nePQp2AkW4mCd8GGL/4khSW0MoiBkIPDEyiiY+EDTbQh4a0WAZlc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829861; c=relaxed/simple;
	bh=EwIf5Xs0ZoS0gMWwJH2Qq3twQe2PX2Nq0azMiyNcQZE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2l28Xq9l+g6mBZnUl6k+vgRjsSYfBxdVfTB53a5WXvgcdtP8OYTchzQbO080JbaqhKHa3UCqRGMAtv2he/HpleFSYwBPGl1UcXEOqGl6rBM4SI7MCezOQnmmoPpOlOS0a/RlyrnpIWEsjGVvowtOEH43eYrO0/6nfCAQut2VSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dO98AFvw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GI3epMMH; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750829859; x=1782365859;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=EwIf5Xs0ZoS0gMWwJH2Qq3twQe2PX2Nq0azMiyNcQZE=;
  b=dO98AFvwKnCp2tu11Q6j5i7uecPVcH7pTjo3+MfN7ivQxJ6LSf4mSv38
   Gaj4fXtzM1ybcz8frdlaOEvK47lPgWenK1VvM+ZB20cEcT9qglaeFrpPi
   iPYHW+qbUwRHb6RJGyETKGN3cSbxvb7KVvMPK2whYSM7Bi/HTdjrRaaaT
   xnqTwQs3mblxoSYPosterO9rfkEnSSNtZMCyto1iqt7mT12g1qbFRz4Z3
   UipdpmlMUu1Dl06sqU2ipjxZEwvCitlRPWQdKNgH5rXzbRIz8NK4n28cC
   YYNJfLhVXgVA8u6JDNBg821RDvN1DqEBPEubeMxL6YqXWrzNRQCsmCwvk
   w==;
X-CSE-ConnectionGUID: k1snsNOKR0C5eZhTkPkDCA==
X-CSE-MsgGUID: c+Vxh7PoRYi4Wz8Ns9fVnw==
X-IronPort-AV: E=Sophos;i="6.16,263,1744041600"; 
   d="scan'208";a="91231565"
Received: from mail-dm6nam04on2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([40.107.102.44])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 13:37:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb4Z0d1XLEZD41x1l+O67mrfkzHuTEIbHTr1ktmlJBAi52SQ9tf+uts5Pjb+WnoA65cgYOJ6UpaJBjKx4LrjqZfKA8h+YNssbiI+T2SmLmrQdancBiJBcW5vRo6gu6//IsLRqP2NK4JoLRt+fKagGlqGUU1ogt/KZ3DfhVBgO1prK63M3MFRqjKZeauO4LVqCqPaBsTTnJwwD1QBDL5D/JUhPKxlt5LPMKxMCjMPeDzlK7C6PWF1D2Nf1rCUAvz/Z8otKfPWwWz+4DYOPdZTQ/OSe5hoFSKEC5tJ/jjL0gZUKjJyIJ7qtW3XybKDE5MEy22ZoINxrcOVwFmkQ/cQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwIf5Xs0ZoS0gMWwJH2Qq3twQe2PX2Nq0azMiyNcQZE=;
 b=nvb7ysnlMcAcCYK6uBfQwVcabeXSxC5blEPJ9PoJKprKkprE/PcayjndT456vSzgHiFRDsLCgad5+QZSExpLPVWIpjIzqmjylHNyo5idP93VsZHfZ1zvmG45v1JZZDE7vEyP7CVxZp8O5r9mBxdNdpQzuHLkShADqFBsUGNDYCqCDg6tpRvt5a9ne9XHKwoFeC3/HR75P6eFCCnrWjFxcvOdSepPKkFqTaB9YmVp/VVhL55y6l19+kGMkg1A9DxvSnUi9LrLNIsjGrt5bIAbiZRcA64+K57Pe026R7VtDEg1PqXOLbJ7t9R45eU7zOugJqhv5OBO1Cq4wOJ2COoVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwIf5Xs0ZoS0gMWwJH2Qq3twQe2PX2Nq0azMiyNcQZE=;
 b=GI3epMMHwRf/VRlRcE4jr6xmZG+fK0ZJSLTFfdyGQ41BUr+zL2bvxLwHbHDWW8ZicMnHmiFe1I9+ChZoxh6UyibtGCl/ggusN4HEHhJIKISvzcKVqBe4d255H8L41zRjindmAOoM+5YQ4HYDa3m8aP7aFmkfIERHl6UIXl7ClgM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW4PR04MB7314.namprd04.prod.outlook.com (2603:10b6:303:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 05:37:34 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8857.016; Wed, 25 Jun 2025
 05:37:34 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix a stupid bug masked by CONFIG_BTRFS_DEBUG
Thread-Topic: [PATCH] btrfs: fix a stupid bug masked by CONFIG_BTRFS_DEBUG
Thread-Index: AQHb5NI9ofPHfRwobkyg/ZN3fP0vorQSToQAgAB6CACAAJQ5gA==
Date: Wed, 25 Jun 2025 05:37:34 +0000
Message-ID: <DAVDDMNOQ2CX.S4V6AY9R4FGX@wdc.com>
References:
 <9b16023e2cb31b509405dd5525bbd5d19a2f384b.1750746917.git.wqu@suse.com>
 <DAUST0RXUM9H.3ORVRVN7V3A4O@wdc.com>
 <50f1f675-6046-49c0-842b-3f469735d25d@gmx.com>
In-Reply-To: <50f1f675-6046-49c0-842b-3f469735d25d@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW4PR04MB7314:EE_
x-ms-office365-filtering-correlation-id: 1b478b5d-18bb-45e5-bac6-08ddb3aa62f1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3BBb0tlV2hNTEhRN3kwdXArUTlQQ2JoYWh5RkNmc21uZWtIbjNtN2VHR01a?=
 =?utf-8?B?dkFjcmR3VEpKRUx3MUVFT0VsNlpKaGpRWW9QS0RULzFRb2VxMk91YWhNV0hN?=
 =?utf-8?B?NDh6RG1ieHBzWnJyay9aSWNTSXVvNDZJOVo5Nkhxbk8vYTFDN01QU3F2NCs0?=
 =?utf-8?B?WFE0OFZ5ZE5EeG5RVGtadlBHakRUVzNyUlFVN3hZQ0Y4VTRqNlVLclczYzM1?=
 =?utf-8?B?WTRYbGcyTHRsYURrQ1B0TitncndZbFJVS1RWbEJMcnhUL04zbGQ1cldhNDFH?=
 =?utf-8?B?d1U3aXpLMTRUUzlNM25qV2xOUjQ5bkx3SlhkanE3UGV2WElTUU1zTzFnYThS?=
 =?utf-8?B?ZEtMc1NzTGRIazVVM015aS9MMHVWRVR5cUpBQitodEtGTVZFWEN3d1pTbTFZ?=
 =?utf-8?B?UkZUZ3F3K3ZyaE5oSWlLeDl2OUZQV1YvOWhhWjFrME9Dbm1jMk55T2JjTWY0?=
 =?utf-8?B?a0NRYk9WYjRCWU5BakZxS09UM1Q4REg3T0tmcGJXaW1aVkdYaHd2bVB2ODBy?=
 =?utf-8?B?eVVId2h1VnFPdnA5blRtUklEQUlnSGNOQU1wVmVQSGZDU1gxUVRVdTNPQUFz?=
 =?utf-8?B?eHhza09IdkFENXhGN0pkc2NYQ0xhT2JyQk8zUWFZUlRQQ21nNmo1WHJxRWRy?=
 =?utf-8?B?a2Yzb3dJREcvU0JrdEIzZUFtdTB5bGYrMUpGeVBrL1QzQ0RCNmdkcEFEck91?=
 =?utf-8?B?MG9tUERjTFZ6dzVvbnI0dVUzQmtPQ0lQQzhBVDZvZDFDdWNDQTJ1eFZiM3hY?=
 =?utf-8?B?azhLZGg5YVliMW9iZFc1ZnJMZlFCTkJKYWc1M09HdWx4TlJ4SHFuOVRtejFj?=
 =?utf-8?B?MWtVa0N4dllORW9yY0VnbGlTNW9aaU5ZeWFUN2tOdEZSYkF6eUxKRUZ6SWUw?=
 =?utf-8?B?WHkza2VjOU9Wdm5teXZaY25TSklJUFdVUnVUSDlEbU5SQi8wZDBhUW5VUVlK?=
 =?utf-8?B?My9rWmg0aEVWejJ2SWoxd3NySnZiNXFCMWdvYjk3REtWMXNxRE5GR1F6UU1r?=
 =?utf-8?B?cHB3RmxVbnkrREdpZGhnRmIxb3d6U0JyMVRGemN1NmVvRGIzUkx3RWRjUktN?=
 =?utf-8?B?Z2JOdm9Oc3MvOTh3d1ZZU0tjNUNyajR5TTBKWVhpaTRpb1VlU2thYVNVaFcz?=
 =?utf-8?B?cncvNVo1VzI4by9yVVhoSlR2OEE3QjM4eFZDdUg4SUFZYkRQM3R2S25ZTXNI?=
 =?utf-8?B?dWFCZWlZcWtnd0piTXRVTThKUG5QcVlqdkRkbk81ZnhSL2RqMWh0WGRMb3kz?=
 =?utf-8?B?eFJrSFNjWkNoR0lLOVBIa3E4V0RoMWdvdUhwbWpveWN0TjEyeVJ3Tkx4ZUt3?=
 =?utf-8?B?YjUybkxwVi9FZDNnNmRPcVB4ckF5OGhSVFJ6WWpGZ1JUa1NIcnVMR21SV1ZM?=
 =?utf-8?B?QzBlZVFiL1hNa3d5cXc3YXphdFR1VkV2L09MMGVFR0JvVE12V1BVSjhnaE55?=
 =?utf-8?B?N2toZUVmVmc0a1d6b21PUjMvMWVmcFpSRnhacE5reUowdmdTZHRnRmlRUlNO?=
 =?utf-8?B?ZktIanhJaHkvZW0wWEJJUUNIYWUrOGFvWmlUWTJEV3JJZDRwWkxzcUczU0E1?=
 =?utf-8?B?bzBhMFIraUt2VlNycDJtek1ia3BaSXR1WlVwaE1OU1dTeHBNUUw3K1QxRnN6?=
 =?utf-8?B?a1N5bGtHaXZmZXZhdUNXck5CalhjblpKWGF0R3F5Mk1hSWU0NjlYbytkWmhk?=
 =?utf-8?B?blNEWGdTOG9pTzAwa2JDVElkeCtJTW9jM0FRYSsxRklLUjVtRENIN05QK0Yr?=
 =?utf-8?B?LzR3V0lHVVFocGVJWm9vaWxwZUphWG1vV21GcjNScmo3TG5ac2ZheS9DZFBE?=
 =?utf-8?B?STJteUMyS3ZSck1FK29VMHg2SjFaZ0RTYVlJQWFEZ1J6ZVNiZTRtM0ZEc1Vr?=
 =?utf-8?B?ditTbzFFb0QxYlJ3L1dncVpRWEtIc0xXVkljeDZsWE5YSkxaM0dDMlYwZUJP?=
 =?utf-8?B?SzRIUUFodGo5YTVPTUZIbEtLRHZjdzJpUzExY2hxWm5peUQ3aUU3Yk9HTUND?=
 =?utf-8?Q?jzCa+YpJpawCJSzpiG/bV6na81L6ok=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGNOSlU4MGlQVGZPZEttTkJGQk93NlRyaVF1TStZNVRxZXJuQ3NDSlA3TElx?=
 =?utf-8?B?Z2ZoTktnTnFjUGFHbld0eGJkWUVGRmZpc2ZyelczZ1FvSnRQdkZQRm15K2Vs?=
 =?utf-8?B?bFVvRkVzSEEvNmwwWHNiTXhGYlJvVWZ4cm4wb2FHZTB5b3FaTzFYcVR0a3VU?=
 =?utf-8?B?aUFIQlFwY3JXeFg5b0VlMDhNcUp0K2lvaXRiMzVNVzBwcENoZ0FjRkc5TWF1?=
 =?utf-8?B?V0w0cnJnOWM2RkJ5T0poOFY3TUhDWHZOQklRQlNKVEdWeWl0dlYxMEYyTWx0?=
 =?utf-8?B?MVd2SzRIQnZiSTVxRGgwYWdFNmlrT1FveC9QVXowK3o5T0s3K2pPT3RVMDJr?=
 =?utf-8?B?cmNwbXhXd21XcWxYSThaamhEQUFyN285alAreDlIcWgwMUpFUHByeEtQM3Vy?=
 =?utf-8?B?c0x0T0xqamJJM3RId0FjS3dudjhYZnRucHl2SGQySHozMnRtdEJXNWc4RDhH?=
 =?utf-8?B?cFR5ZWdDREIwbXRIVmlPR0lUTTg5TEdTOVFybkg2UUxVdUszaFRjWlNSaDNN?=
 =?utf-8?B?cVVPMVcwTnlvMTRIWk9QZWtaZE42UllEMnRHaDlEU3FHQkxkSER4Z3RpRkNh?=
 =?utf-8?B?Zm8vYjRYMlFOdjFDMFVEV1lXaGJmYWhFVDFBZk5ONWR5cnlST2JpK0M0UG9k?=
 =?utf-8?B?amJNOWZ1Z01HRnduQWhoNVoybGV6N0VrZFNQYTVaUHhyaWRIazlnWk9xd29j?=
 =?utf-8?B?Y05yYk1kaVg1bjJLTnd5YTl5eFdab2lqSElJSFVtcDRqTFRuMFdNNldxTy9R?=
 =?utf-8?B?NHovSU9rZUc4Qlc4VE9xQmR2RTBIVFVvMmpsZU9DUWxnRzJtNytqaHMrY1Aw?=
 =?utf-8?B?dzk2ZzROUjVCT0VQVTdtYk9FS29jY2N4TnE5Tm4zZFl4cUxyQjBBU1dZY0dr?=
 =?utf-8?B?UGJ1cnIxT2lNMnZuVERZOUo3TGdMbEo1ZTVpVi8ySlYwc2x1aHZFV0hVVFZB?=
 =?utf-8?B?ZnV0bjl2emxsL09zUlY4NElkclU1QzBQVUQzNDJKL0JMSXRzajhjT3ZmMyt6?=
 =?utf-8?B?WUdESWcyZWIxU1VZNHRmUjlpYnhBNHZCU2hYZzVnQ240TmFnWHRGS0lxTWh1?=
 =?utf-8?B?c2cycGpHT0l5WlNGa1hyRzV1UDVsQjd4Mk5qd2JCQ25sMFVocys3cEpVTU1H?=
 =?utf-8?B?dTZwU3JHRkhka3lkcXNjNnJkeFE4ckgwc2k0WEtQc3IyZjExQ2VjOWNjR1pO?=
 =?utf-8?B?RkVqV1BsWnJscmlDLzNpd3lKK3Z2WkM0ZU9OOTJ5SzFTT0VUT29BYUlDZXdY?=
 =?utf-8?B?RFh3MU5ZTDJPNW0yN3FQTEs1bldEeTQvRUczUVlmRk1lZlQvYWI0WGlzY0k5?=
 =?utf-8?B?NGxiYUg5OGN6LzNIUjJSSVY0aTQxVTAxZmJFRU1UdWZYZDlzc1RNTzN4MEVv?=
 =?utf-8?B?a1ZNeERWWHdKemE5NzJFTHY4bk5QajNPWGxhK0RSZjY5QkNBNDVoV3FDN3lp?=
 =?utf-8?B?cjZ6K0NJdGp5ZUVVQi9OR2IzSzl5OXNEclJnTm5YemVmb2wrQVpYUFJBRWlD?=
 =?utf-8?B?N2hnU1ZtaEU5QUFnUFpxaXFhVDhUMWdWKzM4ZnZodnZjZ001clgwc0ExOU1r?=
 =?utf-8?B?K0o1enpzNWFDcmUveVZWTlk0aWhSSmFBdlNPeVE3anRNQ012ZXd0U1NkU1lv?=
 =?utf-8?B?RXZraEFqQjliWXo1Zk9TUDRTV2dVRzRIT3AvdUJDWmN5MmNDRzlDd2JldWdi?=
 =?utf-8?B?RGI1VnpIeCt0NkYzT21RamJQK2NPaWg5QmQ5S2E3MzdYMVhFYndFWWM4Ujdm?=
 =?utf-8?B?dm9YdTZUM3lCUElQaE5ab1lpWll3NlFmQXZMQmNYbHY3Y0VmaFQ5ZXdCdGNJ?=
 =?utf-8?B?Rm81eDFTQ3diUDRHc201OWpHMzlEWjZyM3pxVGltNFNEc2REOUpDSlVncXRt?=
 =?utf-8?B?aXJyT2UySHlVaktFeU9RV3puTmpGUC9zN2toaXJ0dWh5eS8yVzB1KzE5UmY3?=
 =?utf-8?B?aEJtWnZiZklHcWp0M0xoTVdnUTlVY0Vicm9UU2NLOW93M0t3akNnNC9YbEpj?=
 =?utf-8?B?MmJTYWxSZ1VEVFFpNldoMllxOUpsZnBuSWZGSFFBSFRHM1pxNUxRWGx1S2c5?=
 =?utf-8?B?ckN1Mnp5UTYwdFdXcHVudlFWaW1mL0QrRU92Yk9Kd1ZUd1hSMXN5dGU5N040?=
 =?utf-8?B?c2RnMHhJakx4dStNUVVrVUNKaUZJK0VBYnhlSUVYdDdKWE9CS2Q3dE5GN1NB?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D091E862C3E4748A81AE0904EB63846@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ahnF6WZ9cA8lfZwjAdi3waElJJXY1bQnVRIlsFmUSnfxXp++UOOxep1rrjDP4iO0ilknS6FILA6rwf8SO++vbeqUfer2drhCz+W2c6JCNH7UI7KNZyZrjOBS9QGEUA90l5tav/BrmwSHwgIoryV+iltIZXGDd4H+XYvxIK/g86z7Bioumk12dFQbDifWr0Pp+qqI+3UqUqf3fyoHOPR4hM7AS3zRZVnK3FJUMhlZrn301vXjotlW7sPajXqAMqLL/w0Kfh8cBkTXdQnQRUTNNLUD539hkVB3bn8RdOm6k6yC3dNJgp3k7qz1UwV/pdT3hBW0wFHdWlqf1W/NYe049hJDpgaaNdnqKs1Jdgo06j6wBUpGLQgLTqr2WE/HMquG7gg9MTBk2/ejKF7pKzNmuCO5dfi/dtWxdi1YBcaGOYh43HqTbC7oz9FC88kVk5D77g5zA/fKZYsOLQG9+KbYE/cFs71l25KcLu7Aba1d+YNkDdxqtToRAMAgOnht/cEB5DA2vSX67XmUO4nnhaXM4drvYPQOEOYL/UG6NBnF3likyZGo/mnMay1euInL/kx26agWg/qMT5bzby/ASrQzt3iokePTN/8UXN8MrVh/6yjyE5Jmq7YAS7QJd248RhFs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b478b5d-18bb-45e5-bac6-08ddb3aa62f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 05:37:34.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+L52T6UcLhWhc9+drgOwoEuQ9K8YHpUieFQcnzpntUsUI/P30t/adh+qEG9pwtuFOp7C4W3QP9U8jHFE9aSZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7314

T24gV2VkIEp1biAyNSwgMjAyNSBhdCA1OjQ2IEFNIEpTVCwgUXUgV2VucnVvIHdyb3RlOg0KPg0K
Pg0KPiDlnKggMjAyNS82LzI0IDIyOjU5LCBOYW9oaXJvIEFvdGEg5YaZ6YGTOg0KPj4gT24gVHVl
IEp1biAyNCwgMjAyNSBhdCAzOjM1IFBNIEpTVCwgUXUgV2VucnVvIHdyb3RlOg0KPj4+IFtCVUdd
DQo+Pj4gTmFvaGlybyByZXBvcnRlZCBhIHdlaXJkIGJ1ZyB0aGF0IHdpdGggQ09ORklHX0JUUkZT
X0RFQlVHPW4gYW5kDQo+Pj4gQ09ORklHX0JUUkZTX0VYUEVSSU1FTlRBTD15LCB0ZXN0IGNhc2Ug
YnRyZnMvMDA1IHdpbGwgY3Jhc2ggd2l0aCB0aGUNCj4+PiBmb2xsb3dpbmcgY2FsbCB0cmFjZToN
Cj4+Pg0KPj4+ICAgcGFnZTogcmVmY291bnQ6NSBtYXBjb3VudDowIG1hcHBpbmc6MDAwMDAwMDBh
NWFlOWVmZiBpbmRleDoweDFjIHBmbjoweDExMzY1OA0KPj4+ICAgaGVhZDogb3JkZXI6MiBtYXBj
b3VudDowIGVudGlyZV9tYXBjb3VudDowIG5yX3BhZ2VzX21hcHBlZDowIHBpbmNvdW50OjANCj4+
PiAgIG1lbWNnOmZmZmY4ODgxMTZkMzEyODANCj4+PiAgIGFvcHM6YnRyZnNfYW9wcyBbYnRyZnNd
IGlubzoxMDEgZGVudHJ5IG5hbWUoPyk6InRtcF9maWxlIg0KPj4+ICAgZmxhZ3M6IDB4MmZmZmY4
MDAwMDA0MDZjKHJlZmVyZW5jZWR8dXB0b2RhdGV8bHJ1fHByaXZhdGV8aGVhZHxub2RlPTB8em9u
ZT0yfGxhc3RjcHVwaWQ9MHgxZmZmZikNCj4+PiAgIHBhZ2UgZHVtcGVkIGJlY2F1c2U6IFZNX0JV
R19PTl9GT0xJTyghZm9saW9fdGVzdF9sb2NrZWQoZm9saW8pKQ0KPj4+ICAgLS0tLS0tLS0tLS0t
WyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+Pj4gICBrZXJuZWwgQlVHIGF0IG1tL2ZpbGVtYXAu
YzoxNDk4IQ0KPj4+ICAgT29wczogaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBTTVAgTk9QVEkN
Cj4+PiAgIENQVTogOSBVSUQ6IDAgUElEOiAyNjQgQ29tbToga3dvcmtlci91NTA6MyBOb3QgdGFp
bnRlZCA2LjE2LjAtcmMxLWN1c3RvbSsgIzI2MSBQUkVFTVBUKGZ1bGwpDQo+Pj4gICBIYXJkd2Fy
ZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyB1bmtub3du
IDAyLzAyLzIwMjINCj4+PiAgIFdvcmtxdWV1ZTogYnRyZnMtZW5kaW8gYnRyZnNfZW5kX2Jpb193
b3JrIFtidHJmc10NCj4+PiAgIFJJUDogMDAxMDpmb2xpb191bmxvY2srMHg0Mi8weDUwDQo+Pj4g
ICBDb2RlOiAzNyAwMSA3OCAwNSBjMyBjYyBjYyBjYyBjYyAzMSBmNiBlOSAzOCBmYiBmZiBmZiA0
OCBjNyBjNiA1OCBlNiA0NSA4MiBlOCA0YyA2OSAwNSAwMCAwZiAwYiA0OCBjNyBjNiBiOCBmMyA0
NyA4MiBlOCAzZSA2OSAwNSAwMCA8MGY+IDBiIDkwIDY2IDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAw
IDAwIDAwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwDQo+Pj4gICBDYWxsIFRyYWNlOg0KPj4+ICAg
IDxUQVNLPg0KPj4+ICAgIGVuZF9iYmlvX2RhdGFfcmVhZCsweDEwZC8weDRjMCBbYnRyZnNdDQo+
Pj4gICAgPyBlbmRfYmJpb19jb21wcmVzc2VkX3JlYWQrMHg0OS8weDE0MCBbYnRyZnNdDQo+Pj4g
ICAgZW5kX2JiaW9fY29tcHJlc3NlZF9yZWFkKzB4NTYvMHgxNDAgW2J0cmZzXQ0KPj4+ICAgIHBy
b2Nlc3Nfb25lX3dvcmsrMHgxZmYvMHg1NzANCj4+PiAgICB3b3JrZXJfdGhyZWFkKzB4MWNiLzB4
M2EwDQo+Pj4gICAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMA0KPj4+ICAgIGt0aHJl
YWQrMHhmZi8weDI2MA0KPj4+ICAgID8gcmV0X2Zyb21fZm9yaysweDFiLzB4MWIwDQo+Pj4gICAg
PyBsb2NrX3JlbGVhc2UrMHhkZC8weDJlMA0KPj4+ICAgID8gX19wZnhfa3RocmVhZCsweDEwLzB4
MTANCj4+PiAgICByZXRfZnJvbV9mb3JrKzB4MTYxLzB4MWIwDQo+Pj4gICAgPyBfX3BmeF9rdGhy
ZWFkKzB4MTAvMHgxMA0KPj4+ICAgIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPj4+ICAg
IDwvVEFTSz4NCj4+Pg0KPj4+IFtDQVVTRV0NCj4+PiBDT05GSUdfQlRSRlNfRVhQRVJJTUVOVEFM
PXkgZW5hYmxlcyB0aGUgbGFyZ2UgZGF0YSBmb2xpbyBzdXBwb3J0IGZvcg0KPj4+IGJ0cmZzLCBh
cyBjYW4gYmUgc2VlbiBmcm9tIHRoZSAib3JkZXI6IDIiIG91dHB1dC4NCj4+Pg0KPj4+IE9uIHRo
ZSBvdGhlciBoYW5kIGZ1bmN0aW9uIGJ0cmZzX2lzX3N1YnBhZ2UoKSBjaGVja3MgaWYgd2UgbmVl
ZCB0byBnbw0KPj4+IHRocm91Z2ggdGhlIHN1YnBhZ2Ugcm91dGluZS4NCj4+Pg0KPj4+IE1lYW53
aGlsZSBDT05GSUdfQlRSRlNfREVCVUcgZW5hYmxlcyBhbm90aGVyIGRlYnVnLW9ubHkgZmVhdHVy
ZSwgMmsNCj4+PiBibG9jayBzaXplLCBtYWtpbmcgQlRSRlNfTUlOX0JMT0NLU0laRSB0byBiZSAy
Sy4NCj4+Pg0KPj4+IEFuZCBhdCBjb21waWxlIHRpbWUgaWYgcGFnZSBzaXplIGlzIGxhcmdlciB0
aGFuIHRoZSBtaW5pbWFsIGJsb2NrIHNpemUsDQo+Pj4gYnRyZnNfaXNfc3VicGFnZSgpIHdpbGwg
ZG8gdGhlIHByb3BlciBjaGVjay4NCj4+PiBCdXQgaWYgcGFnZSBzaXplIGlzIG5vIGxhcmdlciB0
aGFuIG1pbmltYWwgYmxvY2sgc2l6ZSwNCj4+PiBidHJmc19pc19zdWJwYWdlKCkgaXMgaGFyZCBj
b2RlZCB0byByZXR1cm4gZmFsc2UgYXMgd2UgYmVsaWV2ZSB0aGVyZSBpcw0KPj4+IG5vIG5lZWQg
Zm9yIHN1YnBhZ2Ugc3VwcG9ydC4NCj4+Pg0KPj4+IEJ1dCBDT05GSUdfQlRSRlNfRVhQRVJJTUVO
VEFMIGVuYWJsZXMgbGFyZ2UgZGF0YSBmb2xpbyBzdXBwb3J0LCBhbmQNCj4+PiB3aXRob3V0IENP
TkZJR19CVFJGU19ERUJVRywgYnRyZnNfaXNfc3VicGFnZSgpIHdpbGwgYWx3YXlzIHJldHVybiBm
YWxzZSwNCj4+PiBjYXVzaW5nIGJ1Z3Mgd2hlbiBoaXR0aW5nIGEgbGFyZ2UgZm9saW8uDQo+Pj4N
Cj4+PiBbRklYXQ0KPj4+IFJlbW92ZSB0aGUgUEFHRV9TSVpFID4gQlRSRlNfTUlOX0JMT0NLU0la
RSBjaGVja3MgY29tcGxldGVseS4NCj4+Pg0KPj4+IFRoaXMgZml4IHdpbGwgYmUgZm9sZGVkIGlu
dG8gdGhlIGxhcmdlIGRhdGEgZm9saW8gZW5hYmxlbWVudCBwYXRjaC4NCj4+Pg0KPj4+IFJlcG9y
dGVkLWJ5OiBOYW9oaXJvIEFvdGEgPE5hb2hpcm8uQW90YUB3ZGMuY29tPg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPj4+IC0tLQ0KPj4+ICAgZnMvYnRyZnMv
c3VicGFnZS5oIHwgMTQgLS0tLS0tLS0tLS0tLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBk
ZWxldGlvbnMoLSkNCj4+IA0KPj4gSSBkaWQgYSBzaW1pbGFyIGhhY2sgKHB1dHRpbmcgInJldHVy
biBmc19pbmZvLT5zZWN0b3JzaXplIDwNCj4+IGZvbGlvX3NpemUoZm9saW8pOyIgdG8gYnRyZnNf
aXNfc3VicGFnZSgpIGluIHRoZSAiI2Vsc2UiIGJyYW5jaCkgYW5kIGl0DQo+PiB3b3JrZWQgd2Vs
bC4gU28sIHRoaXMgcGF0Y2ggaXRzZWxmIHNlZW1zIGZpbmUuDQo+PiANCj4+IEJ1dCwgZG9lc24n
dCB0aGlzIG1lYW4gc29tZSBjb2RlIHVuZGVyICJidHJmc19pc19zdWJwYWdlKCkiIGNvbmRpdGlv
biBpcw0KPj4gbmVjZXNzcmF5IGV2ZW4gb24gdGhlIG5vbi1zdWJwYWdlIHNldHVwPyBUaGVuLCBz
aG91bGQgd2UgcHJvbW90ZSB0aGUNCj4+IGNvZGUgdG8gdGhlICJub3JtYWwiIGNhc2UsIGluc3Rl
YWQ/IFNvcnJ5IGlmIEkgZ2V0IHRoZSAic3VicGFnZSIgY29uY2VwdCB3cm9uZy4NCj4NCj4gVGhl
IG5hbWUgInN1YnBhZ2UiIGlzIG5vIGxvbmdlciBwcm9wZXIgd2l0aCBsYXJnZXIgZm9saW9zLg0K
Pg0KPiBUaGUgb3JpZ2luYWwgdGVybSAic3VicGFnZSIgaXMgdGhlcmUgYmVjYXVzZSBhdCB0aGF0
IHRpbWUgb3VyIHRhcmdldCBpcyANCj4gc3RpbGwgcGFnZSwgdGh1cyBvbmx5IHdoZW4gYmxvY2sg
c2l6ZSA8IHBhZ2Ugc2l6ZSBuZWVkcyB0aGUgZXh0cmEgDQo+IGluZnJhc3RydWN0dXJlIHRvIHJl
Y29yZCBwZXItYmxvY2sgc3RhdHVzLg0KPg0KPiBCdXQgd2l0aCBsYXJnZSBmb2xpb3MsIGV2ZW4g
aWYgYmxvY2sgc2l6ZSA9PSBwYWdlIHNpemUsIHdlIGNhbiBzdGlsbCANCj4gaGF2ZSBhIGxhcmdl
IGZvbGlvIGNvdmVyaW5nIG11bHRpcGxlIHBhZ2VzLCBhbmQgd2UgbmVlZCB0aGUgDQo+IGluZnJh
c3RydWN0dXJlcyB0byB0cmFjayBwZXItYmxvY2sgc3RhdHVzIGluc2lkZSBhIGxhcmdlIGZvbGlv
Lg0KPg0KPiBUaGUgbW9yZSBjb3JyZWN0IHRlcm0gd291bGQgYmUgInN1YmZvbGlvIiwgYnV0IHRo
YXQgYWxzbyBpbXBsaWVzIGEgZm9saW8gDQo+IGNhbiBiZSBsYXJnZXIgdGhhbiBhIHBhZ2UuDQo+
DQo+IEhvcGVzIHRoaXMgd291bGQgcmVzb2x2ZSB5b3VyIGNvbmNlcm4uDQoNCkkgc2VlLiBJIHRo
b3VnaHQgInN1YnBhZ2UiIHdhcyBzdGlsbCBzb21lIGtpbmQgb2YgYW4gZXh0ZW5zaW9uIGxpa2Ug
dGhlDQp6b25lZCBjb2RlLg0KDQpJIGNvbmZpcm1lZCBidHJmcy8wMDUgcGFzc2VkIHdpdGhvdXQg
Q09ORklHX0JUUkZTX0RFQlVHLg0KDQpSZXZpZXdlZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJv
LmFvdGFAd2RjLmNvbT4NClRlc3RlZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2Rj
LmNvbT4NCg0KPg0KPiBUaGFua3MsDQo+IFF1DQo+DQo+PiANCj4+Pg0KPj4+IGRpZmYgLS1naXQg
YS9mcy9idHJmcy9zdWJwYWdlLmggYi9mcy9idHJmcy9zdWJwYWdlLmgNCj4+PiBpbmRleCA3ODg5
YTk3MzY1ZjAuLjQ1Mzg1N2Y2YzE0ZCAxMDA2NDQNCj4+PiAtLS0gYS9mcy9idHJmcy9zdWJwYWdl
LmgNCj4+PiArKysgYi9mcy9idHJmcy9zdWJwYWdlLmgNCj4+PiBAQCAtOTMsNyArOTMsNiBAQCBl
bnVtIGJ0cmZzX2ZvbGlvX3R5cGUgew0KPj4+ICAgCUJUUkZTX1NVQlBBR0VfREFUQSwNCj4+PiAg
IH07DQo+Pj4gICANCj4+PiAtI2lmIFBBR0VfU0laRSA+IEJUUkZTX01JTl9CTE9DS1NJWkUNCj4+
PiAgIC8qDQo+Pj4gICAgKiBTdWJwYWdlIHN1cHBvcnQgZm9yIG1ldGFkYXRhIGlzIG1vcmUgY29t
cGxleCwgYXMgd2UgY2FuIGhhdmUgZHVtbXkgZXh0ZW50DQo+Pj4gICAgKiBidWZmZXJzLCB3aGVy
ZSBmb2xpb3MgaGF2ZSBubyBtYXBwaW5nIHRvIGRldGVybWluZSB0aGUgb3duaW5nIGlub2RlLg0K
Pj4+IEBAIC0xMTQsMTkgKzExMyw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBidHJmc19pc19zdWJw
YWdlKGNvbnN0IHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPj4+ICAgCQlBU1NFUlQo
aXNfZGF0YV9pbm9kZShCVFJGU19JKGZvbGlvLT5tYXBwaW5nLT5ob3N0KSkpOw0KPj4+ICAgCXJl
dHVybiBmc19pbmZvLT5zZWN0b3JzaXplIDwgZm9saW9fc2l6ZShmb2xpbyk7DQo+Pj4gICB9DQo+
Pj4gLSNlbHNlDQo+Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBidHJmc19tZXRhX2lzX3N1YnBhZ2Uo
Y29uc3Qgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pDQo+Pj4gLXsNCj4+PiAtCXJldHVy
biBmYWxzZTsNCj4+PiAtfQ0KPj4+IC1zdGF0aWMgaW5saW5lIGJvb2wgYnRyZnNfaXNfc3VicGFn
ZShjb25zdCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4+PiAtCQkJCSAgICBzdHJ1
Y3QgZm9saW8gKmZvbGlvKQ0KPj4+IC17DQo+Pj4gLQlpZiAoZm9saW8tPm1hcHBpbmcgJiYgZm9s
aW8tPm1hcHBpbmctPmhvc3QpDQo+Pj4gLQkJQVNTRVJUKGlzX2RhdGFfaW5vZGUoQlRSRlNfSShm
b2xpby0+bWFwcGluZy0+aG9zdCkpKTsNCj4+PiAtCXJldHVybiBmYWxzZTsNCj4+PiAtfQ0KPj4+
IC0jZW5kaWYNCj4+PiAgIA0KPj4+ICAgaW50IGJ0cmZzX2F0dGFjaF9mb2xpb19zdGF0ZShjb25z
dCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCj4+PiAgIAkJCSAgICAgc3RydWN0IGZv
bGlvICpmb2xpbywgZW51bSBidHJmc19mb2xpb190eXBlIHR5cGUpOw0K

