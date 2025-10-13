Return-Path: <linux-btrfs+bounces-17712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C3BD3587
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 16:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917A71887510
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61BC239E80;
	Mon, 13 Oct 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KobaOKoQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gtlPQxdT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328432EC08A;
	Mon, 13 Oct 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364371; cv=fail; b=VKIaUoyeug9R3YR3LxtBH0++EfZE1b4ys+ZsM2OGVlwldoA5aexcTi2gDcABOzVFqD3l2EM7/Fm73eoS+OXxe+YAO2oObIgk7gtKhIqsVCkZLlmIuGTXNZl98/Z5iIsG8FVLz+ocWdjUjunt3OhV9C13DkhDKnjlUyBzWBK7iUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364371; c=relaxed/simple;
	bh=mM/HR7zVtkEy6OjSvtG9Zjn3/IiY5XiNrx4jMlHztw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n2pWrx8Gc1hcuWV325cEwtwPLDmT5MNhkg4UKk5MURA5PWHgdw+dT6rPrSDas4waJQOC3YTn9BZa54tiMoHaxAm3cvPwB1gMOP2eQAKlE/tZYa/1wmrm8p1OVyzDqG+isBoRMAE3SV/ludUesRlGDD/H6jSmQ6YVkX9mDxApei8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KobaOKoQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gtlPQxdT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760364370; x=1791900370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mM/HR7zVtkEy6OjSvtG9Zjn3/IiY5XiNrx4jMlHztw8=;
  b=KobaOKoQVh0KTUTUHICJ2H1iudgLjORcNLCpIY7VNprLgcf2+yzHUosh
   0OBK11JzzE4qFJ7pGxPiL6hkZPqippRbg+kqTFMhLoSxydWTUp4Bk8MlW
   i6/qCke1xdvGj5uTi4vP3S6816vjGfbERpSxChaqNoN2zyg3Q05xIYALN
   2+p5PAlbWtU2Q33vxKaVQArZVf0EsVqWt0/lEvdkfIk3iM7Ja51vAQ4oP
   GOJVF3Ih8AxjKECgcBV1ALSY3YGqUkLd49bXcpfFHItBTKNyFoonw6ry2
   Q4VZ0iFHuQU3Lt3SUGXAvYiA4aSJX6eLMSgfrdFrZoyq41p4e0qjrjdp7
   w==;
X-CSE-ConnectionGUID: rlIZ+/9MQi+TNx6C4toSiw==
X-CSE-MsgGUID: Dh3RnjbBTAydcmMCPhSdyg==
X-IronPort-AV: E=Sophos;i="6.19,225,1754928000"; 
   d="scan'208";a="133116864"
Received: from mail-westus3azon11012053.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.53])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 22:06:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zORj3ZWKvqzGzbfvFpidEYdR3DiU0C4l2jqAZMN/mhWh4tbGjMnUUlUAX3uNCiESmSwRJlBibk1lEfv7jBWM5EXIidBecFb8OJBUHbKJTzCbPMsHsjo59dESGZ/gK/O3qOOCoDYRWhC6qc0otc/lqcSyz5Xo64WZ4snRAcE7wa9XE1uNtv8/GaKgfgij74/pS/qMT5/EHRBxKcsti7vwTvlDT6JwmBAONMw1QXT6pRnTrMPAkU8hIsofU9Qrwq5Uv9qBNojlIDfqduUx1/glxTrCWfBOPugX5rBqbyfx69Fz1u+BMypVvHMnLtnFIDoPf31qe2OGyHIZgFfyTHAjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM/HR7zVtkEy6OjSvtG9Zjn3/IiY5XiNrx4jMlHztw8=;
 b=YbxE/7p8Nt/goP2Jq0Pghf9GEAQT3A7YuTv55cDY8Oi8ECBqBXmMoc3KeslkRK469/8NQRtIL/afKqngIE7UlMc0jMSy+Hhi6+GEjH765a8PVcfawgUiMHqMo31tHo5QiEplbF3WO2AenLGWhECZsfn+xuO8xnCQ1XAn0sm4rIbfPGJPHhizZ0rv8ULLmdm2YqawT6F5Tzy8afGwVOt/63/sA6tBlzDm+Gh8Kfpvw2e4/zz8DOuIySBVQt3E2tBNipsTzQlYUH2G9aic289Kcc9rF75lMrHUqJdhlMhgC22uxkDKXw8LA8mFi8SphQdxF+HUU4klk/DYPosJwjQdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM/HR7zVtkEy6OjSvtG9Zjn3/IiY5XiNrx4jMlHztw8=;
 b=gtlPQxdTl8jNsii8PMlI9Kn87lo3ey/PF7L1W1AtkiHShpMrrmAfPY3UtJbZBL3MiQ0UDM/qwoQnxj1SkaRXY0aCl0cVEQ/JOd2w84EdyY2kH/h8Q3MdVPINeovZU+fZobG6O91/mnLbeaKLlqo93NebiqlGQX/rU803p97RXxA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO1PR04MB9578.namprd04.prod.outlook.com (2603:10b6:303:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:06:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:06:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anajain.sg@gmail.com>, Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Topic: [PATCH v3 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Index: AQHcPBiKpCCNtqKcfkqgMF3aqqoT5LTAGdMAgAADBAA=
Date: Mon, 13 Oct 2025 14:06:06 +0000
Message-ID: <4eeb481f-b94d-4c2f-909e-7c29ac2440b2@wdc.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
 <20251013080759.295348-4-johannes.thumshirn@wdc.com>
 <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com>
In-Reply-To: <006ae40b-b2e6-441a-b2d3-296d1e166787@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO1PR04MB9578:EE_
x-ms-office365-filtering-correlation-id: 2f188fb5-d8eb-49ae-0c62-08de0a61a70b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZThVdHB4eUh2UW1WaGMwak5CM2UzOFZUem1qelo3MkpnanlmcWdNSWdicmJR?=
 =?utf-8?B?TzVzTk5ld1dsVEN5LzVOMkFicXphamZHOThDeTNjYkxxa2ZjZnlOdmxmbHVF?=
 =?utf-8?B?VVA2YWJISXdscmdyTmwyUFVVRmtWVndHY1dJRUg4QXdhOGhKSHNzNzJYbzNY?=
 =?utf-8?B?M3gvNlY4b0pmYlNXSitTY0trNDVidGVHb1NvZ2I5UDJGLy9vTE84NVJlZTI0?=
 =?utf-8?B?T0xURStJL1Ftb20rMjlLZmNMZ202dzZGcGdydjRYeEJuN3lUNmh1R2RqaW5O?=
 =?utf-8?B?Vjlzb1dzS0owY0VCS3ZVV3J5NmdlQjE4K2Y0R2hhamNpTlp3bUJSUjFUUWow?=
 =?utf-8?B?SCsyWUlkdFg0dHoxNEQ2VlVXNWZScnRObWxtbHVURmEwdmFUOGNLcGdKRGQ1?=
 =?utf-8?B?MlZYbFduY3BSZUY3S0JKWnVkaC8ybS8xK0lMWjEyVkxNOUZRZzVJL3pXcEhT?=
 =?utf-8?B?Rmd5elBSb20yT3JVU2VKeUo4eUhkZEgzQ2JiMkRRdWs4MGZEUkxucnBkWUFj?=
 =?utf-8?B?ZnVTR0ZtUVhKYzcxVVh1ZUhScUVQdzFpQ0l0STRvNEd2NXU3cFhjaWlSa1Jj?=
 =?utf-8?B?Nnc5Nm56aG9XaVB2OWJ6NWFVaHEyRjA4bUlBdmpObjRiR1lJWHBtYXRuWEVD?=
 =?utf-8?B?by9hSnltY0Z3YllNNXZNSWpRTCtlYnZhdUFFU2VZVXVhczFQOW5VQzVaaVhn?=
 =?utf-8?B?azFKZjVEK2lLNG83V1Z3a0loN0I4b3FZdXMreXdxaGp1YzB3RlNaVUhUMGk1?=
 =?utf-8?B?aW5sSXpoN3NXRzQ3WU1WdmlVQnRKVGlBTEw3ZXVkS21NYTl1SWxZdDl5SEV0?=
 =?utf-8?B?d2l1K0JZcDB6SktZblN2azZ3eENkTTEwR0JDOEhJNXRndGIwTHEwTXFiL3Q0?=
 =?utf-8?B?WHVWSTdGMDh5Yys4TlhmWDJyMm9ERE9wd0hKMUtOZ3RGTDZ2ZDJOa0IzVjdZ?=
 =?utf-8?B?TmJuOFB4WjBqaG1NQTRGaUx4cUszVFQydHl1anc3aGdwMzNmQjVNYVlHRmx2?=
 =?utf-8?B?VHdqWVhqRFpScUUxdW45YXRnOTcwN3pEd01oUXJVaGE4R3FNNUYxcmNRWXl1?=
 =?utf-8?B?elB4WGxBMzl5emNFYVBVUy92c3dxUHV5NGdRbmZ4Z3VJZVRWRkc2cEhPWU4w?=
 =?utf-8?B?VjBmNVlSL0l0aURWV1M1TWthOWU5UnFiMzUxRVZBWHFhUjhMQkZVbkhXU3Js?=
 =?utf-8?B?V3BWalhOaDNnVkRtQmpra1pyZXFRS0VCSjNFaVV4QTV2TEs1RG0xby9sZmZJ?=
 =?utf-8?B?OW5uOWNYdDhwTTJQbWZteFFGUDVWYTBtZ0RFWWl0Y1FrK0NhLysrTWZXNVli?=
 =?utf-8?B?ekFSZUlocmIxdFErMDNYSEdHRGdzS2hDNm9RMzRWMFZHK3lzcFEzRUlCakM0?=
 =?utf-8?B?Y1E0cU5yZUxHanlOK0s1WHIwOUtmaHV4aWE1aXVqeWxrSjZCMUdEdUM4SnRu?=
 =?utf-8?B?b2xqRFlLSy9leUQzNnRIUkpXVjE3ZDVBdHJMMTd1cDJWMzZheG02a1NLMWk0?=
 =?utf-8?B?OG1QT2kzNFhKeGdMQXJqdERDakZTR1VRM1RkdXNubjVoY3Jra1JFUHo5NHJX?=
 =?utf-8?B?Z1ZxdVlnUCthV1pDQ1BPSkVsRU96WUhoMjVwL0twTGFmRVVDcW1sTDNqZGJW?=
 =?utf-8?B?STlBblRMYTRsZ3ptZDBFb2IvVTNyZkR2NGlnWjJsN21yNXY4ZENJWmIzMS9H?=
 =?utf-8?B?NWhxUnJXSThsTTdKcUYrY3pHVE1GeU5wOTNsdUZrMk9PZ1ZtMlRiNGVENVFu?=
 =?utf-8?B?aVpyWFhwMHAza0RuS2hhaGpUaGlzV0JhK2xmZlNSTjVuKy9qakdmMVpQUWZH?=
 =?utf-8?B?bUZpU0tmai9pR2Z0T01zYUVNNVV4OXVsUDhIbUxqS3NlSnBNd1FRSkx6Wkx5?=
 =?utf-8?B?MGtTZjJ5eDdQTHhWR0xTM3g3akZqdW9mTmszdU12eDhVSk1wME9NaktNRnhs?=
 =?utf-8?B?cHBqYjROWVNvM3p2czl2SjJSaGRGLzBXMUpSbVQxYTZFRmpqRTlLb0U1MDNN?=
 =?utf-8?B?UDQvdGdSclRES2ZrNkdRWFJqZTVJdXZ2R0VzWTJIVVR6endITUVURFM3bGUr?=
 =?utf-8?Q?wF2KeG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWRqRDZjamFRUzZ2bTRTNVlQaGFPeWRyR3o1WlJUVy9NVklKVS9SZTVndkRu?=
 =?utf-8?B?cEFHdTJkYUs1aGdwOVBCamtYc0d1aTVIRDczL0tPbVRENThJaE54amx0b0Jv?=
 =?utf-8?B?ZFVaQUg2YkZIYUxsOGFVeWpRcFlDVUtoTEN4VXYrZ2tUdDJvcVk1aWtvYkxC?=
 =?utf-8?B?RGdFWElDc3lEcnlYNVVzQlZjZWY0TEY2U0RzVGlUOHF0eVE5R2s1d0FDOW0y?=
 =?utf-8?B?bFFYcmtuVExIVDRuRXlCMTREYzhwRFpnQVFMZ0RIK0xWdGt6RysxbkRNWG41?=
 =?utf-8?B?VEJDakFyL0lRN2VOTEdnVmhvZk40WmNaSUFYNmUyR0VHSCtKNzQ0RUlHeUJX?=
 =?utf-8?B?emtMVGd2VzRvcDZHcG82cjZ3UEhVdkg4eWdYQWJ4QVQ5QVV5Z2h1UnlOTGNC?=
 =?utf-8?B?eTI4NFo5czU1bklTY0RNa2phYy9wa1dQd2tEQ3NzMG5oMmk4VnNaWW1YOXZv?=
 =?utf-8?B?cGgrNW1KN2R4UnEzYjJ2NWxJVnc3QXQvTjd2QUN6cTJKNEk5QVczV3N1MmFD?=
 =?utf-8?B?OWx0UHNIL1U3b29uSmJFMGRpQXhEZVphWGFHUFZjV3g5TUdZWWk3RmFSSjJS?=
 =?utf-8?B?M3Y1MDhoYVZ2YnFWVDM2N2tkaTc2em5aTWJUR3F2L2lYa0cyMGduWHU1b0tn?=
 =?utf-8?B?MU0ydUFWZ0xYL1l4SmhlY3doREVmd21UdWEzSENOVUJEaGx0eTlxa2tBaW5i?=
 =?utf-8?B?YnE4YVgydENsM2FkN1RVb2ltVjlCNTRCRm5SVW81dnVybGp2YURKaVd1dUZP?=
 =?utf-8?B?VGJ2SnUrUStnREc4dFZVc2ZTSkg4d202aGpHNktFNnJuYjFBa3M2RkxJK2xp?=
 =?utf-8?B?OXJRbElmZndnVWR4c3dwVTNZS1dQNjdsWHpJN0ZHRUt3UFFMTXYvblFoNlpm?=
 =?utf-8?B?TVBVRGFFbFlqQVI2TkptV3RwRDdINVBFTGYwUFJ0dTc2T251UWdDQlJHK0Jp?=
 =?utf-8?B?QXVzV1g0S21abDN1VDllcythN2ptVHk4TUR0UnRabFQxbnppM0lCUE90bU9r?=
 =?utf-8?B?M1NZMSt5OUlxZmFwSXRlZnVwZytvM1JBMXdJWU1BWkxJSGpFWUQ4R25WR0Zy?=
 =?utf-8?B?R3A3YmFuWStTQ0pDL21zWStaVFUydmF6VE1WbnlRM2FjdmxiKzBnTXdERGdk?=
 =?utf-8?B?a0h0UGovdzZQQlJsMzdsR2h2QWd5aGVkRVRZQjFRN1N6NVFoRzFIL1ZPTGFo?=
 =?utf-8?B?US9rdDFVbWM5TlFTaThoKzd4T1RGNTEvajFUWU1aeldJcFB6WGV4WUtHUklx?=
 =?utf-8?B?aVJSZzJQNHNHdTkxVUZScXA5eXRZRTlnVXJNVC9RTk10KzczbXQ4Z2cxVkV4?=
 =?utf-8?B?cys5cWI4SVpIYVpST09sbXNIenNwVHRaWEJURVk1czNieG1MQ0s5YUtVcEdB?=
 =?utf-8?B?dkg3TGxId0ltOHkrYW94N1dUSWNiR3ZaU2lwTVRaVUI3OWQyMzhHUFhCWk9u?=
 =?utf-8?B?cElFODgvN3RhSFY2RVNYd00va3RXdnNwNzdIenIvaklJdzZhSWhOSGtpMmJn?=
 =?utf-8?B?SzkzNTlrZXo2VTcxWk9COVFwcVppTWZpZlA4TXRGalRaQkc0dkZvOXNzaTN1?=
 =?utf-8?B?OFpMNFFLK0wwa3h2bXNIZ21mR0g2d1kyWm5KekpFdVV5K3ByYnVPcHcvdEN1?=
 =?utf-8?B?QXIrRk1wRHlFWGw4RXN4dWZGWS80MUFWYmJUd3l1b0d4RGo3ZEdGdDRqZkdv?=
 =?utf-8?B?b0pmNG1YajJPU2lOU3NaKzYzQXd2TUpJYlpiaHZTalRVUmNaSVZkV1BDNGY4?=
 =?utf-8?B?cnA0aTNHQy9BMXRIclhNR2VyOFByTE5CTzlQdkRwdmVEZXFnN2I5YlI3RWM1?=
 =?utf-8?B?T3BnQTVhVVNKVGY0UTVoTUlIaGxpNkhPRVg4UWdaR0V2cExQOTdhWUoyVEZy?=
 =?utf-8?B?aWZVM1JxRytLVzUyNW83eXphV3VwQ0luNms1dHhHRnNmS3NzOGZEWk1sZEpH?=
 =?utf-8?B?TmJqOWVqTXdZN2RPclhkbW5zV0c5aStXdnNadHV6eEtHbWs5Rll5Unk5M0w4?=
 =?utf-8?B?WmxFMUpjTERLSkl3c29lTVpjSDRHUXpneitCQ1BaUUEwSmI2QzE3VzJPVitr?=
 =?utf-8?B?ZTVNbDJRM2x3Y3c1ZjVpdFVqZ0phNEdybjVZbExjYkpTTklrRXVMVTRQaWRN?=
 =?utf-8?B?V3lQaXBqVHhPbmxUMkRXZVBRMXUxK2JtWk9QSnE4WHdoK3UwQ01TREMyZWlQ?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF11FE15DF76C443933F1744E8DEF748@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wtQqe80yeRNWA/8q0F6hfeU0HCQ1738fTeZzfbrF8VHqKkmnxlmAwgce/Fm7r16A5t69Gz8C0axBVpUB4KmxCo+FUfKhohPcAyvAVz09HKaM6ckz7xjCnBrTYnJSF9E3zq6xd6v1L33U1JAAYY7Yj7hQThODvpnA70RgMdc1Mx6VV1NBjAu/7x9jx17v60TjOP323QUXUF3cCz4hYraDqYCtovLfSqrLThcsoaCQYapLe+ToQLdq+CsjhC4sCDVWmU7niUXIBxrIIma3zGQsSlQMKhHUGkxm19zC3cU+LzeMvPmwCikJP6ujhoW+LVku0zVdTU6iewrcKDJN5jDUJoe4YW0NikaP+Z20RtDW8cZaTZiZCQ6AkUb4K6pPnBZMTsLRFNGamwQ06aBdsJ3tScwUkUTFymoqDV3AECTT8ZDWUjTn9nz8lx/y/HHTqe6aPD7VtzHtBWZXpB5wghXyTbR31Dov4kAGrveGVqJ7jnI+BPvuoSzsRkpjWj6KC1qXk8hnbo/dU68SqUp7grAwkSI3IypQqFYua+yOzN+NlmIVNQMAf1SBRP0NjT29wEGMeGas4epyW9898Oixbyjdy+gnuCEyzK7JIB1u2e4UDSq0ethzmJnI4tZhKCfRBkF7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f188fb5-d8eb-49ae-0c62-08de0a61a70b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 14:06:06.3762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3drlJw7e9nfqQoKm1KaGLohynjA1hFbHZiyWa9rQyMMwAG9MpDjuUMrRh64Itv+9KTGx1rqH/E8/DirDjNch5PsG/pj7Yw+8ytezHLPoye0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9578

T24gMTAvMTMvMjUgMzo1NSBQTSwgQW5hbmQgSmFpbiB3cm90ZToNCj4gSm9oYW5uZXMsDQo+DQo+
IFRoZSB0ZXN0IGNhc2UgaXMgZmFpbGluZyB3aXRoIFhGUy4gRm9yIHNvbWUgcmVhc29uLCB0aGUg
bWtmcyBlcnJvcg0KPiB3YXNuJ3QgY2FwdHVyZWQgaW4gdGhlIG91dHB1dCwgc28gSSBoYWQgdG8g
bW9kaWZ5IHRoZSB0ZXN0IHNsaWdodGx5Lg0KPiBFcnJvcnMgYW5kIHRoZSBkaWZmIGlzIGJlbG93
Lg0KPg0KPiBUaGFua3MsIEFuYW5kDQo+DQo+IC0tLS0tLS0NCj4gU0VDVElPTiAgICAgICAtLSBn
ZW5lcmljLWNvbmZpZw0KPiBSRUNSRUFUSU5HICAgIC0tIHhmcyBvbiAvZGV2L3NkZQ0KPiBGU1RZ
UCAgICAgICAgIC0tIHhmcyAobm9uLWRlYnVnKQ0KPiBQTEFURk9STSAgICAgIC0tIExpbnV4L3g4
Nl82NCBmZWRkZXYgNi4xNi4xMC0xMDAuZmM0MS54ODZfNjQgIzEgU01QDQo+IFBSRUVNUFRfRFlO
QU1JQyBUaHUgT2N0ICAyIDE4OjE5OjE0IFVUQyAyMDI1DQo+IE1LRlNfT1BUSU9OUyAgLS0gLWYg
L2Rldi9zZGENCj4gTU9VTlRfT1BUSU9OUyAtLSAvZGV2L3NkYSAvbW50L3NjcmF0Y2gNCj4NCj4g
Z2VuZXJpYy83NzIgICAgICAgW25vdCBydW5dIGNhbm5vdCBta2ZzIHpvbmVkIGZpbGVzeXN0ZW0N
Cj4gUmFuOiBnZW5lcmljLzc3Mg0KPiBOb3QgcnVuOiBnZW5lcmljLzc3Mg0KPiBQYXNzZWQgYWxs
IDEgdGVzdHMNCg0KSGkgQW5hbmQsDQoNCkxvb2tpbmcgYXQgdGhlIG91dHB1dCBpdCBpc24ndCBm
YWlsaW5nIGJ1dCBza2lwcGVkIG9uIHlvdXIgWEZTIGNvbmZpZy4NCg0KDQpUaGlzIGlzIGV4cGVj
dGVkIGlmIFhGUyBpc24ndCBidWlsZCB3aXRoIHN1cHBvcnQgZm9yIHRoZSB6b25lZCByZWFsdGlt
ZSANCmRldmljZS4gSSd2ZSBiZWVuIGRpc2N1c3NpbmcgdGhpcyB3aXRoIENocmlzdG9waCwgYmVj
YXVzZSBmb3IgWEZTIHRoZXJlIA0KaXMgbm8gZmVhdHVyZSBmbGFnIGluIHN5c2ZzIHdlIGNhbiBj
aGVjayBpZiB0aGUga2VybmVsIGNhbiBhY3R1YWxseSANCnN1cHBvcnQgYSB6b25lZCBSVCBkZXZp
Y2UgKHVubGlrZSBmMmZzIG9yIGJ0cmZzIHdoaWNoIGRvIGhhdmUgdGhpcyBpbiANCnN5c2ZzKS4N
Cg0KQ2hyaXN0b3BoJ3MgaWRlYSB3YXMgdG8gZG8gZXhhY3RseSB0aGlzLCBpZiBubyB6b25lZCBS
VCBzdXBwb3J0IGlzIA0KY29tcGlsZWQgaW4gdGhlIGtlcm5lbC4gSGVuY2UgdGhlIF90cnlfbWtm
c19kZXYgaW5zdGVhZCBvZiBhIHBsYWluIA0KX21rZnNfZGV2IGNhbGwuDQoNClNvIEkgL3RoaW5r
LyB5b3UganVzdCB2YWxpZGF0ZWQgdGhhdCB0aGUgc2tpcCBpZiAhQ09ORklHX0JMS19ERVZfWk9O
RUQgDQomJiAhQ09ORklHX1hGU19SVCBjaGVjayB3b3Jrcy4NCg0KVGhhbmtzLA0KDQpKb2hhbm5l
cw0KDQo=

