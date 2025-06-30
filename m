Return-Path: <linux-btrfs+bounces-15092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B3AAED96D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 12:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78A71773B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B710253F23;
	Mon, 30 Jun 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N5WoMwcK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QtBwmLyO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA95253330
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278205; cv=fail; b=kI8mBM5Hgouip2J1Qu42aqzuK9kaE1cFeOz1tCiTe4EptOJjmtZWCZYfJmOc6sLNg7nBckircI0t3VcIZlXh1oMwhhjRNySGWInHjlr99c2N0/gzejfhRIj6m6iLNatnhgm0YNxmWJy0fOk6xYgfUWGtAY3nS7j0kCSgfAU6Jts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278205; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nd3t19ufAU+npQdZTDObnlYvyKTCpAULp+b54asMIIwdWDD8TmytaaRhEB4T2Kh5GJc4yRcwvPDqKA9hIGIeMKh0PlizF6aMHHY3a7f9qNVexPK4f95EBeRJdtuPF8QCvfsM60ZTJQL2UDPc/f9DYJ+aJEvu8V6irCVSKh4Nf5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=N5WoMwcK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QtBwmLyO; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751278203; x=1782814203;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=N5WoMwcK7cz8m2jwTEscitz3e7Mv/HaHsF3t07ue3KvUMoWYTzO0sxr+
   eXT7m/5/DymcSXCUZ7wc7paxg0xXpLvQuDXLdxSw55uupfq0y5u7kt7Mn
   aO5ZxK7RwjpZMfoeMj7uvIBXIZQe2Ys3Ogh+k4b8ULQcIodCfLcvcONjS
   NHkGrlYrb5bf6kUkVwBsczgLa3YLh32d1jPP97mb25UbX7B8rB2jKNAm7
   pehO1RwX8+JnPIckECnfJJw7uDGb0TL0tSU27cpbWdhpILcpt7S9VSIzY
   sODYeETArDI42ENCnv+kzdmKl5iwD7p49n8jWyU0PlCDv9MM0SlBfJURS
   g==;
X-CSE-ConnectionGUID: ZMmW1wGYQAmf/6XGVsK+3Q==
X-CSE-MsgGUID: 7sIxmi7PTI++XOKx0bhrlg==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="85485655"
Received: from mail-co1nam11on2062.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.62])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 18:10:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+TYuzF+cfX/9J0jgnFhZjQnaNnCeX3SdOoSAGCw070nudqCbq+DTmYJnaZRRY+qlW1zTVDHxQe2dUKr+8OOHKc0ywL1ai11sLpcGDLSWlNsOQVhmn5yKDZsP/gpb2S3NZQQJQ7SbeL+e0yGLr/9ZeKIOfoGWLyt28KUQdKnDTGbdrrtzag9XLBQjTA5R7dVkiC1n7faQUu96z6djFvvt7iDDKa12Q+72imcGJC9luwHsvhxa+dQVefjxh+Hz/VeN6Ch8aNo/ozOzJnv+awGky5XQ9vdIyBfBQn+wxZkU4HZ/dWWRXuKbdDCW+HSPht5lDj6JnT5gCHYytnMEXom9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=VGR8602EOLMVgi05QYZ4LTrm0qaTSsrwvYX2iyFuomBBkioFpF84mARjPZmW2cbsLLuoxj/UDkEKXNM/ueCisl/nppjntaee+5JC3FmDel4PT38aRQ8N0IhUY82JnVCrlbm2ysrdRZJszE/jsPcojnhKk+/eiJeXS7r0YMAcyiAxVrQ/WcrzJHE2JBFUUgDytE1v3Wl2xnZ5pfRnThwnY+JmbYK13GhVNT4qcD883gazqBbJXwr+puiDyEcPHo3H9QlkgyF6zLUvzvZE3I+vE4D+VTqu3oAHc3xRLKpPLeslvhXLoJQy3xllZw9078eQgs504leZWlVAmCrhqK3Qsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=QtBwmLyOhe14SkDijOKa9uLnhEYOEmALvFOc6qq5Fo8P0YCOoPnaz51F67ig+3W1RqDyGSRDufqJ0gn5viccT8zzaL7dmUGYhdU5SyVqgL/TqKtWjMWjFJecH1+vIUQAphBLGb45ZMtuTxf2ixjG5eW5C90yNjHD+DLtSq1dEqc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8560.namprd04.prod.outlook.com (2603:10b6:a03:4fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 10:10:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 10:10:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: fix removing of unwritten non-data
 block group
Thread-Topic: [PATCH 0/2] btrfs: zoned: fix removing of unwritten non-data
 block group
Thread-Index: AQHb6aCakc0GDSrVPUihA2bH8JjMV7QbewUA
Date: Mon, 30 Jun 2025 10:10:00 +0000
Message-ID: <e6da2659-eb2a-4f2c-b147-c0f0824e11c3@wdc.com>
References: <cover.1751273376.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1751273376.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8560:EE_
x-ms-office365-filtering-correlation-id: 19770c9d-80e8-4e35-97f5-08ddb7be464c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTdmdDR1eDFsbFlVQm5jcEsxM2kzRkhUUVpTOFVobHVMMi9mbngwampxYmVE?=
 =?utf-8?B?NWRjZUZsOExSYVREZGRGeHgzV3R0a2p0K3hNUHpoeWVzOTRYMDVNRVJycjlw?=
 =?utf-8?B?b0xBSzN5T0NPTVVHaTN3aW9IY3RsTjEzUVZrZ0RZaDB5WXQxVFNva3NINmpV?=
 =?utf-8?B?YXM1WDRoNkRnUkdIM005UWJyL2czWER5cUtYZjI1TDJWTnlLcXFweTlqUmdi?=
 =?utf-8?B?ZGhmUkROU1V3ejk3VTM1MEd2dDVySHArWnJkblVsQVgxSGxGOXcvY0tvQXhv?=
 =?utf-8?B?bDhzVmdoN2F2anMyMzFxaTBRRXBSZksvNysxU3hkZVBWbjZ3QVRpRDJya0Nw?=
 =?utf-8?B?NkYycjlldGtTalA2TFpUZ09hUXpJVWQ3UWdvb1RTUXRqTzRCQ2kvNUc3KzRn?=
 =?utf-8?B?Sm1sQXRZTEt5RkhrMHliNW4zeGpKZmU1NDg0cVBKTExTQ2JpdWZNcVltclk4?=
 =?utf-8?B?eGJpekJEWkJVbExieWhzWEZkM0NTcTl3a09BY1NVaWZ1Z2tSaW82TzFRL1Ux?=
 =?utf-8?B?WXB0YkVQYjRlNkMwS091aFFtd2dUZ203N1VBeSs3b0ZzY05xTTZ5ajBXY1dY?=
 =?utf-8?B?UVdIZ3RHdzM1a3FORXJZNHEweW56QUpsV3FPY2JCMnprYkdsQTkyNkwyWnJX?=
 =?utf-8?B?VHRpMFg2Z0ZsL3ZLdm44Q1ZobFZNSzU5L2hnQktOVGpKZkJCZkl4T1hjbkdy?=
 =?utf-8?B?QzZid3NIelVXUVdKT3llRXRXYVc2UkRNWUtjR3F6cWZwR2oxQUhNM3cybk9O?=
 =?utf-8?B?RnErQkhmdzhWTHFCVDYrZm0wcUdrV0RWTktLOFhOcjhteE5XZ2hTRWs1RjBO?=
 =?utf-8?B?TyttSWtWdkdSWFdqaWw2RG9qVlhhaldPWHQ1Y2hDUXd6UTdxemVPSUlQSnVa?=
 =?utf-8?B?VFhPRTZGa241RVkwMkprUjhOaVV4VzUxeXd6Q1A5QWVvT3ppb2phOGREcnJy?=
 =?utf-8?B?VmlrdVJNZlNVVkJ1VzJjTEZYQmNSKytrbjlIVEhoaFQyNVc3bjNvRkVuRXZ0?=
 =?utf-8?B?SEhoKzdKdU9hbUVhU1F3Mm1kendMelh4WTNmTHVhUVZMaEgzeGZ4ZEhwT01I?=
 =?utf-8?B?Tkd2ZkNSbGoxQktpNnBYUENWb1BDZFJ6dlRFRkxjZys5dzA4M2Ftc2RvVzVy?=
 =?utf-8?B?ODZubXE5cjdGUzRtUllWS2lValFHd2lqcHF6eStPT2dkcU9yOEMvOE54R1d2?=
 =?utf-8?B?MDZrc3M2UHRicEpwby9KSjNORGdGTysyRFBhdkZCeng1bmVPOEVIcVpYckNK?=
 =?utf-8?B?cWhEeVlLQy9JNWRicyt2QWU2WGFYNEUrZmtiL0w4ayt0U2MzTm4vd29kbVpH?=
 =?utf-8?B?VUZsaFJoZ3hJcy9QU0xCQTdJTG1QbUNneWZIajRLWWE0emJZMFIwQ2tHWTRM?=
 =?utf-8?B?NFdweSt2ZkZKdkVLZVh3NDQzU3ZNUGowc2xMNndlODZLUU5hTThOUk4zRjJp?=
 =?utf-8?B?am5rSnpXUXJOdVZRMW11MkkvcmVSQWpuaXJ4SU16M3IyYTN4MHoxWHduQ3RY?=
 =?utf-8?B?L1ZNU1VSNGs1MmZ4QkgyaEoxUlFxaFF2ZEFobnZWT1NwYmpKaUJhNDJwZEZG?=
 =?utf-8?B?b0tuRWp1V1dhejJYYmJ0dmgwUGozMVpRZE9vK0VwNDZvK3BkNlpiUTZHbEEx?=
 =?utf-8?B?N2V6U1VOcW1JR1J3S0pnMHFsWUhsdmFtV0ZTR0pLdCtrZXNYWkZMNmg0Kzdk?=
 =?utf-8?B?Y0hPelB1TCtQQ1hNeUlBV1RwWlBVYkFDbHRpNGg5SzVrOGY3S2c5ZW9vSlFW?=
 =?utf-8?B?a3g5bUVqRWU5ZTNpTUVQVjhJcG9ObWJuTStQUVVIZ0k3c2kwM3Nybmd4ZTNz?=
 =?utf-8?B?eWNKTDR4WVNwM0pJQ1NGM2hIUFRCUUx4ZnNyMVAzckpkUlNrMTNnd1lYUHFN?=
 =?utf-8?B?UHFMUm92YlFqZk1DMmUvL2JSQ0RwVXRDdENXQjhqcWNWVEFOa04vZGwzeFc1?=
 =?utf-8?B?SThvUmh4aVVzZ3J3OHhaZkVXR2ZGZldSWm9nK0xIZkdTS1l0eG5raVQ2aGlS?=
 =?utf-8?Q?QR6qLcXLEMX8vA0KMV7HJPzNZEunn8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlQzU0hQVFNpVUtMWWR5cC82T3pLaEhYVnExZVZ6SEs2Wm4rTFhndGdtRkZy?=
 =?utf-8?B?TGRaYlpCOFZDbXRpUXBwZU53eWNEWWoyUWttS0xwcThRQzFyNzFxNU8yU1ZC?=
 =?utf-8?B?bGY3ajJPTFVvUUkrMVRDN2ttcnc4c1pmRnVlc2lHSGgxaHBzeUdoa3NlcTU2?=
 =?utf-8?B?Y0xraHNvVFgwZzlsSlh6dm5abjN0OHVxRGQ2SmdrR0xkZy8wUks3dHpNZkVT?=
 =?utf-8?B?RHJMU3orZkN0bGcrWldKbkJmajd5WlNwS1N0N0tYS2NCYWZ5V2ljeCt0eVFF?=
 =?utf-8?B?SHJzeWVET0ZtOXljMXl6Yml6UGtnV1hMVFB2SE92SUZxVk1RMkxIdjduR2Zm?=
 =?utf-8?B?MVRqTGhtMk1DcCtBdmcrNXB5RDlWbjg4a3YyM0ZRK1h0R001ZTdwMU52VFQz?=
 =?utf-8?B?SUVjZk5oNFNqNmxrcGRTNVZiSytBWm1kV3ViTzJmeU9uMVVVVGZnRnJ1bkQz?=
 =?utf-8?B?UVBhTGswZTV2NnlVODJCKzByNjNHNkx6NlBvZ3VwTXNxUkxsSXVkV0pvaVM5?=
 =?utf-8?B?OStDRk9sOW5RTzIwUlloenJiM3JvS3BIWnBpbFhTeXZxOEt5TFFQaUk3S1d3?=
 =?utf-8?B?SGJTRVI1dnFuT3ZsU1p3TFc4anF1UHFucFl5eWhzM1VPWGp4ZW5hVk84WGdU?=
 =?utf-8?B?a3dPcW5JRjIxNmdTVlA4NXJ5ODFGVkJsVlkwTDhnSW1uOFRRRzl5VzlHbDIr?=
 =?utf-8?B?d01xUVhWcTJIY2JvNW5ib2dKenoweHdsSktkYkFrSWorWGU2d1dmQTdPZ0pa?=
 =?utf-8?B?RXVtNTdkTFIydXo1eFlNNksyR3lvR2Z4aWxhc1NUbXNrZ3pueVQvV2N2a2JU?=
 =?utf-8?B?NFk0QTloU1d2NGtoaHVydHZCR3VINS9KMDJieFpRNWsyNlQyUk9qMitDc3NM?=
 =?utf-8?B?T1hGUFBQejZ6SldRZjNsRUQ1T3Y1V2FOcE1nQ0VNSDFQUjV5elhVR1RYLzNs?=
 =?utf-8?B?NS9PV0w2dHA5L3hQdjh4K0xwV29LWUdKbjJ6OXBoZUZ1UVA3bXJZSGhaa0c5?=
 =?utf-8?B?MzZkSUJXdE0wclVrR2FNQ2FBaDZ6elFieDI2cmtZbzZLemF5RWxIRUVEcGFm?=
 =?utf-8?B?cWN3ZlYzSkZOeUphSFJkbG43VTVIVCtXVjk3RGhUVlBiLytreHhqa2ZmT0pn?=
 =?utf-8?B?VTMzR3ZCT2JHdGhXQ1dBdmpyNzRJTFdLaG1wWXFvdHl2SEJWK3NMdExDaDI2?=
 =?utf-8?B?UXJtQTFTOHlLYXBWWXk4TWdPM3JmRENrNThxbW5SZ1MySEwrZHUyd3ZHK2dB?=
 =?utf-8?B?NzVjV1dXSzdvZjBob0FvUGR4RTZYTzFMaHdNVkNpb0hXUFN2Y2cvaE1oNlky?=
 =?utf-8?B?QytMa2ZpTVlGb2NCQ0xNT2djTHk0b2lEKzdxbWlLTlh1NE1sRDdWNFdLbDJG?=
 =?utf-8?B?SnArT3VpUFlyYTRsa2IrazYzMStuN2RJajZJdGRxazhmanJtQS9QblpaYkFF?=
 =?utf-8?B?UEtvZDgzL056WERxVmoyazhkS05mL1ZSM3RCSTVNODZicy90bFhGRExnUk1o?=
 =?utf-8?B?K0JjakxGcnM0SU9pTW5tK01MdTlNbVQ2a1NFdlRsQ1prcWpybEVVUnY3cjBy?=
 =?utf-8?B?am5KclZxOUZ0ZVB4MFpDQ0RRZTA4V01ZeWhZQzhDbDlURDV0em5YeWJhdHJ5?=
 =?utf-8?B?dVF5U2NUVkRUQ21tZENsMTU5ZWtic0s4QmMzb0hYYlBnblo3Y1hLOXVWV3Rs?=
 =?utf-8?B?KzF2ZW5SK1Y3SU5Wbi94cEt6SEtwT0Exak44eHVJWlBmejluS2pmdHkxMFND?=
 =?utf-8?B?L0hnY2tUdFR0eXVEeVUzak1Sa2hmRGlTc0dsMUZ3dGRPa0t1cTVBWUd2cy9C?=
 =?utf-8?B?YVladnlra3ZJRlJMTWFIa2pOOVdzeFluSEkvSStjdGJrdFZ1bU9Na2ZyNUxt?=
 =?utf-8?B?YjN5Rkc3RkZQL1VPcUswYy80OG5XVkVqV2drcW4rV1FCZTRZSG41YnhkN0Vt?=
 =?utf-8?B?VW1UTUJRUzhUclZFVm50ZUNvZE5GT3c0ZTlZOFp4Uko0dWJzWXBldVJDaXVs?=
 =?utf-8?B?L0FLcFZuWWJQaGRjYmwwV0VUd2gxS2pQQ1JQNXVjQ1dFb3oycFI2Q09sSXlj?=
 =?utf-8?B?RmxHVjJsb1NWMEdiRHBRbk5XME5MdmRzVFduSi9rWE1LK2lBVVFhWHlyV0E0?=
 =?utf-8?B?SWwxVitZb0k5WU44R0pydVNPYkpaU2k4bVk0dFI2OTVJUkFuZHNMSzZxY3pm?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F92951BF24FEA64F9B969A1AD84B8638@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cNHRcdKvFVF4dnG7U0/C+K3LyoCg0xRADXHaRn48ip++OSu7dkIV2CB+rsV4vqAzBYCyLy91KxbmZ3Ovy9/uVepDOiNgwD+2zYVUO6PPVQ6qwv7oVjP0xkM1DKVNp9syLoVwelG8r0vtVXGnL8SmKgG7BqfHupnU1AD+zQB0ZdMkeU9GLSTHw1+glGWmZjFqAphbugm5SP5An7zG+bu4qpUDMnmOhcjT+X8SsAeSVPrclcGlyB2MIdN5/NJy4dO4L4H1d2Sg42GlCLwt6BLQ9gkwOXsetQeo1hGXz+nTucAijCGXatX8p+a3WwdWefh/ISaFmvCzD4NoTs/7t6ulxQVDuEj/7qtvqciJUNZwx6VnAKNZzVgpSDU8zHWm0SIizd0f9KXV1WwPPaDUDs721aQUVkYoA0V/BtXj7qzjj3TA5bJwUy/vupOXNTQb/lt1i+kFR9QM4TV/r9SatYMkTRQgT0RDNzY75uLRD6LtZkefVryAafL3ZGpYHtFzONqeBukCSSXkWtKTqhxZ/LvqMOPsmSQMSQtBeJiEvMSAEj9xDeNTyQEUTozP4g0W6JrzsbYjr4OV9y/PdjzPCm6GlOcJ5dy6GkxtrzCrB7AzusoHiQ9LNWkTYZfHeYpZvlg7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19770c9d-80e8-4e35-97f5-08ddb7be464c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 10:10:00.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lfO6MoZgvvsMt2Tcv6tXiE8f7flRp8PpFXteMklzQ/nujvOdWaudpB5Up2TmMR6oXwA5Xfq0/Uy/iCcefsztGhaK+rmgSyuFBPvOlb5zvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8560

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

