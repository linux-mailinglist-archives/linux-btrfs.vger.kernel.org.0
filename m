Return-Path: <linux-btrfs+bounces-15201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A21AF5D67
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25B43A8A51
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130972D7809;
	Wed,  2 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VK4qnGEV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QHQEoRSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB12D0C9A
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470562; cv=fail; b=ge2hRgV7dn4RKE7kS8AoCFSmPhjleRCkaKu/8gywe5rnPsw1g/yq4hElkdbmUx7pUwnRDJnjzZiq1iqZ+7kkozhQamnQYjmQo/AUKPAsWcMSTvYb2X/1liVMNirRo+BSjBJ8GXDKUuBIo4wmPB/IyZ/vG6awnMfkxHESVd0kbd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470562; c=relaxed/simple;
	bh=9ISxuzNtOXIotDwRcXwVHP64CuBq/c24UX9RFzwrpoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pY14jAfSwwoCrlrMN7kHtWAXiaE9dyKStJvJvl1J20UMJJpijykHUoLPrk6s75HkqYR4gP/28GQE6aHo4h/mrpeGpbAnhcubZUn6acGPqd5IKDxjmmewnNDOInA3C6TAGJ0wPNslEEKnnKWz8zkxw+y7PkH+/SsEbY1LvQxyMlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VK4qnGEV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QHQEoRSB; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751470560; x=1783006560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9ISxuzNtOXIotDwRcXwVHP64CuBq/c24UX9RFzwrpoA=;
  b=VK4qnGEVZaoto3DZfJlbc5ZLdBtkT6L1WP9FuHxqoheq5/fi+c1xSWGz
   kGfzcM8MB/1n1Yun4pMzVNrrn1JzoXqmFKuPcHI8P4Ut8OqZZvTdBibWn
   NTciY1ts8VZtHIY/6VOqEd74xPWwAipOrbrQVIkbCoUEMf08uJt7D5Ob8
   cyOG0Pm/IBjsfP4VOfDWpdUPhti4dmTT6FJz1JmJ7qoEVUqeSs2k5KJRh
   NzLA/ksB3ZGLQ1kPrFWyHSyVkS9PzWOL3Uc0CBcc2HLhGNmHhesPNs911
   +6ns1ecg8rmtWvC58BXdjRJ8ll9RREypjcIr+uhqDbsNXN188FcmRnBy+
   Q==;
X-CSE-ConnectionGUID: nhjKfapnSp+Rj6eeZEjYjg==
X-CSE-MsgGUID: 24kRyH9XRkGrjmpnwElLtA==
X-IronPort-AV: E=Sophos;i="6.16,281,1744041600"; 
   d="scan'208";a="90563758"
Received: from mail-mw2nam04on2063.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([40.107.101.63])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2025 23:34:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj/hBbkahVfI0wOop6HL1SUSk7U0eaHgLJpDC3mUKn/o8bYaVfdYzO6SGZi/WswHD0bm/9ZjhRjeMbdV+QvC3V5PUwlVDS526ZOONERmzyRFEm0lftkoh9+VrnE9L4HAZmGl1wHMr0B8BF3D/CLMUBNtRbCxn5NO3JIzfq7W59H17foDX8zNWy0o3/oEt8s3oiOKkpx1NW2154Bks49dr19NHk2t4HpLZu1rpkF2qxsXZ4N5NwyTAhwkfmqdd7KvDcZgof7z8nXh306pjkpinCjCpPNkGgW2UQhc+J7oJT57ZTPnW5KrImf75ddHPCMmIZm5XNuRsCU1Liqp3ZU/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ISxuzNtOXIotDwRcXwVHP64CuBq/c24UX9RFzwrpoA=;
 b=L9A2B5kN9fy8cmdQqwfeQyPqRHCvwCrU726wtVGI1bFbHUnNN2FtPiZRLLlTMhWNiZZWS9FQSiKfRZpVl32UdPvxsvMuirQzYIGQGRyIV232Kr6r4cmf9h27FcH3bitUy1MBzHY6ewjETbbEU6jLxzlaDkoexov15wOvSOCG+biZpoW/wfe4Ub9u/ABw1FKI7I5H4zx+2mVkX4JdPTJiccptlw/uzMdzPc16D8981aXJ+f7d4756mr8BYOBXaz8BZGy5LFAbr6SVgrmNECOZ9Ck6ngWo9jGEAPfXB7mhlONMthQeXWdJMkFF0Iqt1OOWDtftRFr2XppPYUs5uP7oLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ISxuzNtOXIotDwRcXwVHP64CuBq/c24UX9RFzwrpoA=;
 b=QHQEoRSBy0TF6PyFBm25P7KQYRJfKBOK/xyQ1GUvhjNBEndcG+gc0LEMKFbMM22h1Med/hK1UumWTHKxEdtKxK+pIJS/7u38i+E9ucbLGCWdU3YO7klVGlqjZOGvweLRG/UcABSqTekkrrHWT5m0cQU89NeCCWxlmZ7kNGu2OuQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB7511.namprd04.prod.outlook.com (2603:10b6:510:4d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 15:34:50 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 15:34:49 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, Johannes Thumshirn
	<jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Boris Burkov
	<boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH RFC 1/9] btrfs: zoned: do not select metadata BG as finish
 target
Thread-Topic: [PATCH RFC 1/9] btrfs: zoned: do not select metadata BG as
 finish target
Thread-Index: AQHb50SYpHAyG+wRJUWDzKkNMkro8bQW4HAAgAget4A=
Date: Wed, 2 Jul 2025 15:34:49 +0000
Message-ID: <DB1OGYV2ZD45.1V4529LQ35FDH@wdc.com>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-2-jth@kernel.org> <aF6B2CJpduXwbdyh@infradead.org>
In-Reply-To: <aF6B2CJpduXwbdyh@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB7511:EE_
x-ms-office365-filtering-correlation-id: 1b51ffb8-469d-4c06-7d00-08ddb97dfb8a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVZ6U1BNb1hZTzNTT0NvYmRjZUI1eHROYUdYVXRWM2ltSmRrcmNYWjJLTWxC?=
 =?utf-8?B?SjJLL0p1K3JpOEpldXlPUEE3bG5pTmdsSDlrTVRrTnVySXI5eUhTSHgwenRw?=
 =?utf-8?B?ZDNyR3IvMFI3SkVEM2crLzhSUG02YU9WNm1zNUtjdkJLek5Od0lkY3psb3lD?=
 =?utf-8?B?MHc1Y3ZmTlZETHFJVDVydUZrR0JoSUVSbzVCL3VYRDNlSzI3ODZOaTU3cWxi?=
 =?utf-8?B?dXBFb0dUYTFKdmtTUTRBVE5pOUFEeXptUzRsemIzQ1JNNkFhV3ZzSXpxaExW?=
 =?utf-8?B?NzF3YUNtdG1ObDdaSTN4dysvYWxSY0ZmWWRHeTV2UVBWZmlUSFk0dGJ5RXU1?=
 =?utf-8?B?bnU1S0xOSEF4NVhjVnZaYlFMNC9sVERITmlhc3RXZVZyVldTbXNRNjNBclBD?=
 =?utf-8?B?eTBtWVpvYVR4bHc5VGU5akhhcTBkMWp3bFVRUi9uUDhMMm83VGtSY3lteU51?=
 =?utf-8?B?MWhXS1JvVnRSNHk2amZJejAyL0JuTFlsdWZ0VTRRaGpYT0NMMHpGMm9kYXRr?=
 =?utf-8?B?cHVoS0F0QWh0SDRjdXBoWVh2eDR5clBvakRvQVdrWmNocU5uZEVyK084RTlB?=
 =?utf-8?B?aVdmcm02Y2ZVZWN4QXhqQzRTdVdKZ3NLVUpTdDl1L08vdnVSZERSclBlUVlo?=
 =?utf-8?B?eG1manM5MFVUdWhSS1o1YVFoVENOSUw1anFqcDNFOHRVL2tvd1JLRXBuMTg3?=
 =?utf-8?B?eXBhWFBuRThnM1BEYlVKeWxDZ3diNE9zR1pwS3ZFMXJzU2kxY1Z2N1QrQ1hW?=
 =?utf-8?B?b1RKUE5KMVFJU09ycFVvcXV6M050eDVOUEo2aDFKTkgzRTVWNHJLcmZWWlN3?=
 =?utf-8?B?NGo3Q1gvNVcwL0w5M3MwazFFQTFhNU5UVFo2NjFFM2N5NW1iQlNjZmNtRTBE?=
 =?utf-8?B?WWhKalc3R1Zwby92TkZYUFk1Z2FLMVdJMmtKNlJVWWdlNkxQN3dRdmhCSWxr?=
 =?utf-8?B?YklWVk9xLyt3OWhseVRaM0lWYVUwOWlIbVVvblpjdlZSQmdOblVIME1JeDNo?=
 =?utf-8?B?Z1RCWmZ2a0IzZ25DMS9HdldQNDR3QStjSUJnZS9WWkxCYTFUV0VuWWw5NmR3?=
 =?utf-8?B?ZlZDYUJJSS84MTZjTFFMejNjUXF2cEh3a2p0cVZCdW5aTlFGN0lvbU41NzFx?=
 =?utf-8?B?M1BGV1FiNVoxcWJnRzJmd2YrTXVVRlo2YkZ4cmtUZ0JGc3Q5bnhDcUMxdFJL?=
 =?utf-8?B?VEp6Mm9KZkVTT0NPdVlaQmVYSUFORThLODNISUQ0L2UrS2Z5dTNscEFCc1Yy?=
 =?utf-8?B?aVNlcFk5STJDbStJcTQxL1dYR0l2M2FXd2t0ODBySkh5RWFMOFB1ODNZV1hw?=
 =?utf-8?B?TXdPQUFvQU44MFlLQUFBSUQvMmxubTFMTDRuV3RFZ0Q1VzIvdndwVXdvd1JZ?=
 =?utf-8?B?MFRWN0FLQnhoaENHUmxmNDgwTGJSRk1TRTZRV1AwenNjM3l4ZmNtZ0s3OWln?=
 =?utf-8?B?eCt0bWxQZWlrcWtJOFdvQjdwMmNZWlc2aXpDejlFTEVmQ3F2aUdETzdnbEpQ?=
 =?utf-8?B?WVdaM2RBMWFuYm9uMEJrN3BSMm1rUjVHbzFYVFNSQUJTajRuR25WUFQrbG1V?=
 =?utf-8?B?ZW5leXFva2ZIbzBUVkNjRlNmTzR5U3VwTzRlQjN6RVB0N1ArSXkwaGlJeGQ3?=
 =?utf-8?B?bHNrY2tDbWl1aGNKVzNxaGlDOG5tdnArQzV6ZUtlb0JjOUUzWi9VdnRJODBH?=
 =?utf-8?B?c1hZVERnM0dvZmxuRVh5VlEvZktwWmNHdU1QcjJ0SzRtN0NjZDYvaU1iYjEx?=
 =?utf-8?B?T2UxY1BRL0ZwNm5FTHZUbDhiRVJkTXZLcGFPYmExdGdLRXMwYXpXOFVvRi9Z?=
 =?utf-8?B?U3Y3bGE1eUg4VVpSUXBBbklqdnoyNjFFTFc0cll1OXhUWENjUEJPeHNTMS9v?=
 =?utf-8?B?TXpGZ2pSMXJDQk5OTnBJdFJIc3pjeStPS3h5STZ1Ymt6dHZvTERLRi9iWlVF?=
 =?utf-8?B?VE9Mem1xNlBlRWNyNkEyTlBiN2M4MXJzeVg2ZkhSa1pWK3E2V0ZobDBUallN?=
 =?utf-8?B?K3M1Q0MvZ1Z3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czNOaTY5UXZEeDQwTzZMMU56Q2x3Q3RFdlpUenpZK2xWQ1FrNG5TdUJhUllS?=
 =?utf-8?B?MFNxV2tQSWVFT1grdDlJN3dod0toKzZCRXNrc2dLRDhXNHhpTk1zMmNtQ2tT?=
 =?utf-8?B?c0g3bU02Rk5udlJtaVl1aGsvQmhLbmxSNGhkMnlhNDZRY3JxMFp1cytxL3hP?=
 =?utf-8?B?S3RobnpZcDhhSitJRzBoQi9UK1dnb1VsQ2RMZGZjREdOYjJBNEJCbjVNN284?=
 =?utf-8?B?dWFWRzA5WVB6bFNjREIvVEp6MFoySHlCSHdZZndzREhST0RNYXdQdGNaVjR6?=
 =?utf-8?B?RDgzRTdQVGN1ZDR2aDR6M0FYWmt5R1VwaGpkV01yVlRVNmlHNXhqMVM5VzBR?=
 =?utf-8?B?Y3VwV0NmRnp1UlZua3c0dWVvRXdYSXFiNGdqaGd1aVhudUFNTnF5Qnl2RlFv?=
 =?utf-8?B?WTc4WDg0b0hSM1ZVclMrZkxVSERFSVhwc2MrVGg4STVmL0pMLzVIeXI4bWlz?=
 =?utf-8?B?aTZ3UmNpbTB6bTZvTGtuSFdpZG1rMDF5Y0U3L2lORjZGZjdGeVRKeXU0bEtU?=
 =?utf-8?B?US9XK21PdFdmODZ3anRGOHV6Mk8zTUpGcFZneGZ2Q0ZVZFJQbllWUEZJdHQ1?=
 =?utf-8?B?cnA4dzNKQW0wajl5d080ZHhkQWZvZWF6UnMwQXpPVkxlRHk4ZkRsQTVDNnRu?=
 =?utf-8?B?QmZEa0Ivc3VDSDgveW1idWtnRjJPODBMampEQXNTVjBTVGQ4SGkxY1F6cjhV?=
 =?utf-8?B?blc0UVkvT0ZURkNSQlByeUMyYWkwa1NvMFRSUGdnVzlpWEd0c0FlTC9qbm94?=
 =?utf-8?B?a0tCSE9mcUJ0SzBIMHRTVVdJN0hmaEtDUzVUZWU5ekZqd0ZCdTJTbHpsM09q?=
 =?utf-8?B?SXVjY2s1bERGOWVVWSthdDB1REMxMVhncWxSeFZTMnlYQThKWTZNaUt5USts?=
 =?utf-8?B?dWsvMjMwa2Jza0RyZHA0TVQwQzVCTmMvZW80a2c1UXB2bHkrUDFPbXU2TjlW?=
 =?utf-8?B?VG9sU0RqcDk3U3QxU3pnTmxRNS8rV0xpajhaOWNtdWVHWkl5NlBRdFlDQ3ZU?=
 =?utf-8?B?RnpteEVkSXEydHNyWUdjZ1htdVhQUURWN3dwUHpxRFdZWW45dW93WjE4WUhl?=
 =?utf-8?B?anIyeGxTc2hYWVZnOEg5MUVKNFdnQXhwN3FmZGczR1RBaGVkaGM3d2lqY29I?=
 =?utf-8?B?VkVpeG9yakpDcTFlalpMbVBNa3JTR01GOGhMZ3hNc0dUR1VSM0RzRTdHMU5t?=
 =?utf-8?B?Z1ZOTEZWOWtueHhhaEkvQndwa3VDWjRMK2svSVRXL3M1YWxRaitLeXV6STA3?=
 =?utf-8?B?Z1BId0tidHFlRTk2YVRSenhPTVZ4dXlZMFZCaER1OFdwZzlUVlZKazJYbWJo?=
 =?utf-8?B?dkt2OUxKTlBtYzd0Y2lGQ1d5SVBwM2YwMFlmWHlrRHV1OUVmc08yVFpsUXNB?=
 =?utf-8?B?eTV5UkxmeURsejl5ZzJLZTlsc00rVHR6b3IvNDQ5RDk4SFV5UXI5MUJrN2lp?=
 =?utf-8?B?NlcwK010aTFuT3MzOHpZMnpQVUExN2ZoU0F2d3FXb1QrUnVLQjVHUVVXRDVK?=
 =?utf-8?B?b0VHVlkzOWlBeTdacllSWXY2dkRWVExhVGdQMEliRUJvR3M5cmVpUnBDZy8v?=
 =?utf-8?B?UmhZWnROZUY5M1o2VXJiMTdsaEozTG9qVFZHUStQOEZGT1JVcXFzU0xkdUN0?=
 =?utf-8?B?dWkzeU5YMlU5K1NxWVplM2c1OVBqY2ZCYXVCcHR4WHJ3V3Uwamx3dWxEdGVu?=
 =?utf-8?B?czRBTG9tb21aaHdMQTJHMVFwZzF2djBYZklMVFBxMWIyMWkzd0VBS09BMFdq?=
 =?utf-8?B?L0RzRy9qTnJNNFdTZUdvZlVTN1JMSjlneUJvQ2sxaG1KOCtqWlpZU3B3VkFU?=
 =?utf-8?B?aGtZY1hSTnBSZjNQbnhSQklUWEtMb2NNT2NIYkJ5LzkyOVpoell5TUZYazFR?=
 =?utf-8?B?bnlHSlNmMUYrbHpZWUsvbEovVHNaYXNtK1F3Tkw4S0ZHN2NhOWJBRUtqdEZh?=
 =?utf-8?B?OWcveXgxS1g0aXBLeU02cDN6NklhTFhQK1JQU0VEUmhiSEYySi9ZMTJGcmFU?=
 =?utf-8?B?RG1hZGpWY2hCTEliNE1xL1Q3aWZZRHpOUm1sQnJiZXNkMFlpamg4bktHb2xU?=
 =?utf-8?B?NUpuempGS1BPcjFYa3Nib0RGenprWGIxdEFxUjF6bTJjYWJDZFFNWHRaU2dG?=
 =?utf-8?B?ZjlVaXRKYVdHeFYwd3NDcTRTRnJvOFNyWHhYQTRDR3R4bmFidXVBUE9kMXRx?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A5B48E54129E4B8E86B271162593D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FcuMggQAdZgFmw/I1OJRTvRaDQx1O0glumDIOG2bhsDPuRC6b6XPBF/WW5LhCljI9manvQpcBPpXG4zSlmwMWhWASkHL4M7WzBRDJcHEmQDYiUF1xQMeQJ8yvl341CbuhfJzY6aUPXE38SRLuWzLFi9ZzOphKumbvJ2dhERLhJrUBspySMtyx48hQVZH20Tof55A6QCmEbMbsM8+X3Ifz8qjeOmq9XeqPn9NLAAv1aIpdbJfooQv7vSqGWNqNkby8pw6cqVVDuESeqdvvwkKczKDLE3i7h3ioS+dGiFZtY8CizbZO0BS8mtjgLRAu7vcYWbnwpZH7mk/KrPbRimQYYXRgoGxHdB2Q+fMX34uzyWIgCBCZZge+0+yOvf+K9wFIfjGNQwx62WR5FRVYwyV+Z9AlhXsFL9HQPxAmw9zwhLZVYcql2fRBMf5kuUzsFb9WBHqtDsMgVUBZXym/UofvC3fd+/LpoyQbyglQfZdkekOuT7AffHvvbwp4DlI12D8ScdxARrRfrq9GxJy3l15BDFvwIZ/9f1y19KjynL9nB8oEr3m75yIhUt/+RYoOICwOM3jV9V9ZdO3gIDNfhj5qzwBmSrVqnWwXeDcRzgXWTaYTVxZFY0U0qkefol5PJiv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b51ffb8-469d-4c06-7d00-08ddb97dfb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 15:34:49.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UoOWLRU1L3et6fbfiJEQyL9qZeDmJBU01CwY+V7Q5KlNr2exJxLrSTazcnAlRy6jGML5jxPs1winhhIlVt50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7511

T24gRnJpIEp1biAyNywgMjAyNSBhdCA4OjM0IFBNIEpTVCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3Jv
dGU6DQo+IE9uIEZyaSwgSnVuIDI3LCAyMDI1IGF0IDExOjE5OjA2QU0gKzAyMDAsIEpvaGFubmVz
IFRodW1zaGlybiB3cm90ZToNCj4+IEZyb206IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdk
Yy5jb20+DQo+PiANCj4+IFdlIGNhbGwgYnRyZnNfem9uZV9maW5pc2hfb25lX2JnKCkgdG8gem9u
ZSBmaW5pc2ggb25lIGJsb2NrIGdyb3VwIGFuZCBtYWtlDQo+PiBhIHJvb20gdG8gYWN0aXZhdGUg
YW5vdGhlciBibG9jayBncm91cC4gQ3VycmVudGx5LCB3ZSBjYW4gY2hvb3NlIGEgbWV0YWRhdGEN
Cj4+IGJsb2NrIGdyb3VwIGFzIGEgdGFyZ2V0LiBCdXQsIGFzIHdlIHJlc2VydmUgYW4gYWN0aXZl
IG1ldGFkYXRhIGJsb2NrIGdyb3VwLA0KPj4gd2Ugbm8gbG9uZ2VyIHdhbnQgdG8gc2VsZWN0IGEg
bWV0YWRhdGEgYmxvY2sgZ3JvdXAuIFNvLCBza2lwIGl0IGluIHRoZQ0KPj4gbG9vcC4NCj4NCj4g
UTogd2h5IGRvIHlvdSBmaW5pc2ggYSBjdXJyZW50bHkgb3BlbiB6b25lIHRvIHN0YXJ0IHdpdGg/
ICBJZiB5b3UgYWRkDQo+IGFuIGV4dHJhIHpvbmVzIHdvcnRoIG9mIG92ZXIgcHJvdmlzaW9uaW5n
LCB5b3UgaGF2ZSBlbm91Z2ggc2xhY2sgdG8NCj4gYWx3YXlzIGJlIGFibGUgdG8gZmlsbCB0byB0
aGUgYWR2ZXJ0aXplZCBjYXBhY2l0eSwgYW5kIG5ldmVyIG5lZWQgdG8NCj4gZmluaXNoIGFuIG9w
ZW4gem9uZSBiZWZvcmUgaXQgaXMgZnVsbHkgZmlsbGVkLiAgV2hpY2ggc2ltcGxpZmllcyB0aGUN
Cj4gaW1wbGVtZW50YXRpb24gYW5kIHJlZHVjZXMgUC9FIGN5Y2xlcy4NCg0KQmFzaWNhbGx5LCB0
aGlzIGlzIGNhbGxlZCB3aGVuIGRhdGEgZXh0ZW50IGFsbG9jYXRpb24gY2Fubm90IGFjdGl2YXRl
IGENCm5ldyB6b25lLCBzbyB0aGUgbnVtYmVyIG9mIGFjdGl2ZSB6b25lcyA9PSBtYXggYWN0aXZl
IHpvbmVzLiBJbiB0aGlzDQpjYXNlLCBpdCBmaXJzdCBjYWxsIGJ0cmZzX3pvbmVfZmluaXNoX29u
ZV9iZygpIHRvIHRyeSB0byBmaW5pc2ggYSB6b25lDQp3aXRoIG1pbmltdW0gZnJlZSBzcGFjZS4g
SWYgaXQgc3VjY2VlZHMsIHdlIGNhbiBhbGxvY2F0ZSBuZXcgYmxvY2sgZ3JvdXANCmFuZCBhbGxv
Y2F0ZSBhbiBleHRlbnQgZnJvbSB0aGVyZS4gT3IsIGl0IHJldHJpZXMgdGhlIGFsbG9jYXRpb24g
d2l0aCBhDQpzbWFsbGVyIHNpemUuIFNvLCBpdCBqdXN0IHByZWZlcnMgem9uZSBmaW5pc2hpbmcg
dGhhbiBmaWxsaW5nIHdpdGggYQ0KZnJhZ21lbnRlZCBhbGxvY2F0aW9uLg0KDQpBbm90aGVyIHVz
YWdlIGlzIHdoZW4gaXQgd3JpdGVzIHRvIG1ldGFkYXRhLiBXaGlsZSB3ZSByZXNlcnZlIHpvbmVz
IGZvcg0KbWV0YWRhdGEsIHRoaXMgY2FuIGJlIGFuIGVzY2FwZSBoYXRjaCB0byBmaW5pc2ggc29t
ZSB6b25lcyBhbmQgbWFrZSBhDQpyb29tIGZvciB0aGUgbmV3IHdyaXRpbmcuDQoNCj4NCj4+IFNp
Z25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+DQo+IFlv
dSdsbCBhbHNvIG5lZWQgdG8gYWRkIHlvdXIgc2lnbm9mZiBoZXJlIHdoZW4gc2VuZGluZyB0aGUg
cGF0Y2ggb24uDQo=

