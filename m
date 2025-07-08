Return-Path: <linux-btrfs+bounces-15320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DFEAFC882
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 12:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01EF3BF47A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70992D879C;
	Tue,  8 Jul 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MQ9QB9tR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q7isH3Dd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207212D6404
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970944; cv=fail; b=DgZh7z9mGPpIxfeUy6ZTZGaQQRNnkS7CJ6OQqiywgVQtUdbDXw7v7gbSu9DGG0ccQqtFJva7dJL1OZRPyr+Uvfzs406th95qsTI9+bk1o6XyRUVyBh2xmXvoe4Su5NS7TIUC4PWAdrvOVzWUr1ulCoUkztSnQR9RPQ7E69tcQnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970944; c=relaxed/simple;
	bh=VpoTxz/qYYcawtYiutLQTxO4+5R+qwuhN8ToQZwGbEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKSPo/lQ5DUrdbQHPcOoMuT4jx64hJrGJoM/C8FRM3qpVo0WDZQf1xHH08G6h2BPHPDsqbFGSdb6vriyNbAHP9GkLA79lIOdmbAWZu7avUBx8B54MGKGgG3e1Cd6rnt9JQgetE+8xcVyI0tl8mE5MM2yLy+72BPmevozd3KpC+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MQ9QB9tR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=q7isH3Dd; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751970943; x=1783506943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VpoTxz/qYYcawtYiutLQTxO4+5R+qwuhN8ToQZwGbEg=;
  b=MQ9QB9tRB6f+l61xIEbpLsxK3YvNewjfbhod5GxhwnAaMxYQVhKU4w87
   OClxrkIbYO4FL3DuRUcrMCRBwciXDsM4yEfrIMaOTT62bwwkZ2QY0rH+a
   q1DiB/6GYwKde7ztsn2DXs1Yc7rBJ8/2IxfZ6BnePXwO6eZ2Oowm2KwyN
   E+ExOn62Kz6IUGLb1X1yKFMjZ6/8FrrspK93fKJC16mv2ykWf+ikii60j
   qG3ghvM5yIa/YnAN3iAripR+J8c+i+Qmyf8NXK3OkZ7mdTcvYo5pY82lZ
   CLvvjKBaq1nY4ze2UJH1hQsrbbTNF5FkPgcxrj3acGur8wjQxin/mULkV
   Q==;
X-CSE-ConnectionGUID: WmK2v+IGR362OdbNnhT4uQ==
X-CSE-MsgGUID: IT3XuxvhS8inVCZ0hH805w==
X-IronPort-AV: E=Sophos;i="6.16,297,1744041600"; 
   d="scan'208";a="85520608"
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 18:35:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDTaa4PEHFKFJKYu0mSze5BJlP64eqT1oME+eubY8gs25xYpp8Qp1+O1ERft6go8advOTDV80JT/3AGoXWGw3HrqeE0GwkBuxZR2V54GWV63mnVXOVu/x18UjlgkoXux2zqBxsrpeTYhZxYHLamqVIRt/79NxKfSxFcALCEBe1RNmLzebxayXgghwAlsNBxWd9XhnSz4RfoC3DilcuudFOwB6e6WowycTVFE93tlFrh1iqVyjaLFucG1D/965ix4QKEiV8ZR4vcOLAm/fN2Hg/Mb9EkKL9cDic3PjExF1fkq9EtrtiFPWq/mEykWS96jqu376NAcrOzg8ositnZiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpoTxz/qYYcawtYiutLQTxO4+5R+qwuhN8ToQZwGbEg=;
 b=xS/cskNALJD39WUvQe9if7C5eVkU+y6ljPbcXC2IpA3m/xpnoney1j247/QJ6YAJwyxsXlwznJLDf6VEzVcVdKs4iXCfyAgl7qoN9E2GfQ5r/0KktjmKHcXXfCNH93cXuYkaTm827YzsWt5l1eE0/robUCIqWo3h75wQ/vmIWo8BPmH2yZU6eA5yFAuovPYztmkjLbKc6VNX1OJRF3RnpWYo9+9hCvOX7JdWDKnIko0vm1gm+CAFgorwwVsm/z0lFl/QXdkYvKlQFa+iwJZ/9fKYsBiUCy28PQTCekYJMSFrFnmwgtBIAU5OmxB51rpGOEK062A1OElJGwdzp4irIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpoTxz/qYYcawtYiutLQTxO4+5R+qwuhN8ToQZwGbEg=;
 b=q7isH3Dd1MQV6q5WndSu85YoxgGFE7Lu1TxN958RK07UcwcEJDYetjl3ldSy6/giyAyJuyRD21pWNedH40VxbHMmrOLNSjjsPHsyWy3f3ys4cSgJ8OzENlBdsKXYXvEjr3s5nEUVbK/rRwvcKxe6OgYMiIYJxCWoEI9mz348QzE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 10:35:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 10:35:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH RFC 0/2] btrfs: do not poke into bdev's page cache
Thread-Topic: [PATCH RFC 0/2] btrfs: do not poke into bdev's page cache
Thread-Index: AQHb7+euf8Gi7oInskuyWky6fBuq9LQoCEiA
Date: Tue, 8 Jul 2025 10:35:39 +0000
Message-ID: <f72cac03-3c3e-400c-adfe-cc045845fcd5@wdc.com>
References: <cover.1751965333.git.wqu@suse.com>
In-Reply-To: <cover.1751965333.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7812:EE_
x-ms-office365-filtering-correlation-id: 98906d42-bb3d-4d0f-a5ce-08ddbe0b2ed0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QktFc3NsV3J2NnFaVjUwbWhIbkFFWGtKVkNDN2ZDaFlvRmlsbTFISW43UStx?=
 =?utf-8?B?TThQUFh1OENMT2dIRitrN1JIR0dWUnhwNU4wSytyd2V5cmxuZEozeVRYOFlG?=
 =?utf-8?B?M040Tmtsc3JlUFI1a09XM1dvSGRwdmNnQzg3OWVLRmNTdEhhN0JtMHdvNlVF?=
 =?utf-8?B?aWh0SlhnRlNZUlFEK2x3ZzQvc1U3SmNvMmRWZnYrVFNaY25YcG9OQmZtMDJl?=
 =?utf-8?B?RWU1Ny9Sb1ZpV3FPZUppQkVycjJEYzNDVmZXTlorb0ZuUVJZSnNnTlJrZzls?=
 =?utf-8?B?M1ZUSjJGOXJYU0RyRDlKdURJaVh0S1VESTQvbkExYjhTSGhXVHlrRnlPRFpK?=
 =?utf-8?B?VVBrSENBd1pMcUtObjk1U1QwMXY3dUVEY3FiK2puUFMvRGEra0xpWXl3UWdv?=
 =?utf-8?B?dlZSTVpacUk4T0lHRUNkaEY4WTROR2FCMXJnRGg2cjM1emZzNXBJR2pnYkVq?=
 =?utf-8?B?VXBKRlFvTGpHS3E0aVRvOFd3eWtNMzhxVk5yMnNsb2lZU0JCN1Q0OVRUUllV?=
 =?utf-8?B?ay81WXdrWktaSU43TjZ6S3JQcU9qbmNELzdnTzQ2T1VaN0J3cHoxcGtDb1hk?=
 =?utf-8?B?MVd1Rm5YK2oyZDA1UUVqVFFYZERwMG0xcUtBSStSNXBWc1JMK1BmTkVTZU9X?=
 =?utf-8?B?cW5xS212QkxZT2czd0ZZNldNdXdXd0tsNVlqR0NoOW02TXg1NHRUdWpCZGc4?=
 =?utf-8?B?TFZIQWU1OUZWTlBJZ2FSLzMydHdaa29YUGd3Z2lMZEhwZzdlNlRkQnN4OGRD?=
 =?utf-8?B?V3dPbWZYK3ZpdXY0MGhRR2lrL3RxaFRoNGFFMGgyd1VlRk9FRFl1QTJFS2J6?=
 =?utf-8?B?eVhhNGxnZmlKS0oyR0hjZHBHM0ZKMjFJazVKNkpjc0JadGlKckRpZjZzb2w3?=
 =?utf-8?B?bU9ycTJjVFpDYzlaeFN1US95RjI0bGRZZllnR3NpZU1XdFVMSG0xdXJNaXRI?=
 =?utf-8?B?SDA0WTFuNkZocU5selc5WlFGcWRUTUxab2VGVThYaG9UcmxFVHRMd3pHM1Vj?=
 =?utf-8?B?bDhWc1BiWEpPVkJ5bHBKSXFJVXh5Si9wQmNTSzZLTHh1VklmREFUSzZxdCtO?=
 =?utf-8?B?TUFZYjdVRVlnNnZKVGhRT3BHRmo5ZnI5MXRIWGFXQzN4RDd3V0JjUUE5dzJJ?=
 =?utf-8?B?TE5vY2x1MkExUHk1VGNDME9wdlVoVUxCdXFvZ0FORGpsdkI3RDV0MGZQeEsy?=
 =?utf-8?B?UUkyL2FaaG1RRWZLaEFrVXE1ZHp6OWVKbVpkQml2d0hCWHFOUE14NFRORDgy?=
 =?utf-8?B?UDRtbU5JV1RoQWtMbmdaTllUaTI4Um1tVk9tSGZmbzZHNEk3bENjeE16TjFt?=
 =?utf-8?B?bGpkLzV4OVF0RFg5U3ltdnhRRHVSeUZDMUNpQkd4SEZYNmRabFo5dmlIQ3dP?=
 =?utf-8?B?M0tFSUYwamM1ZHo3UEI5dEpqYnQ2T0dPdWlRandBWHBQNGY5WDhqc0xkLytw?=
 =?utf-8?B?MzRTeVBKVWpsZUt1TkhBdUcwSWZSQ2RvUW1pSjBwZWdpYXY3QlU0aGpzWDhF?=
 =?utf-8?B?TVh6YmdWVUxXL3AxcG5jSWhNVTdjcDVOQnRLTDlpYXU0MzBBbExPTWRGckxS?=
 =?utf-8?B?VThUTXJPL09vQ3ZvaFZZei85d0N4MVNoZ2dLc3k2aGxlZi9kajRUeHpvS0NB?=
 =?utf-8?B?WHpPVzdOTkRQamlXZVVPVWY3NXZTTk9jdUVhOXVybWdZVFdRalpaakFmRGJH?=
 =?utf-8?B?MlRTMWduN1F5ZFJVejk3U3plT3cxVW4zT0cwM3hSTlRFZWRQMTFmaFdHL0J3?=
 =?utf-8?B?bm9OYTdaeXdQN3BqRWlGbmN6QVRmUTJ0ZE1jMjFUVkxBMW9wVlJ4MlQ2SWVJ?=
 =?utf-8?B?UTI4UjhQRXdZOTY2RFNaS0hZb0w0UWVkaVo4aUFWc0UyRUdIbXE5R2VmNC9X?=
 =?utf-8?B?dkNEczdBNXpla3d2K1hZVjFhanlSbm9wSXUreHpPU1AxY0VSQ0dqdC9sRTFr?=
 =?utf-8?B?RllMbFFTVFNJOThwSmRkZ3ZFQm41YTFsTUhIak9JcHh4anFGQllRSVF3cUVz?=
 =?utf-8?B?MlE2OVFKNUhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXZNZmlwdk5CdEJ0SzA0d1JTM2ZhZ3o0SUE5aUZNSkZzV1NMVmF0eFAwRDdy?=
 =?utf-8?B?V0RvQkRiYVo0TDBlVzhKNFJtYXFSR3lZeUwyTUtUMVJnRmxTK3ltWSswdUtG?=
 =?utf-8?B?bVJydmltS2JxY04rOWVzdzlQb1k3VzYyb09EaWo5QzBIWC9VS1huRlk1Z1h4?=
 =?utf-8?B?L2htY2lzNk1yb3hsYkFvd2x2S1hrbTAydERCL0t4MWs1b2VWMnBjRUQ0ZHA2?=
 =?utf-8?B?ZEpObnZUNmdwSXp4ZkxMU2huY0Ruc0hTM0NVWlBsNng0em1vZGRUNFB5Zy8v?=
 =?utf-8?B?bVB4dzYrMVo2T2o3S3poMHcycUNxR3JOT2tsVC9LZVJvZjVQQm40YmNsMyty?=
 =?utf-8?B?K3ZCSVJsSXgvQmNSdmtyVUdVeTNYRkk1RGV6TkNtaDFUYmhTKzBmNFdSL0Uz?=
 =?utf-8?B?L3BNeDRldWpUc1NlZHYyUmJoeFdMN0NyNTNFcXdvZ1FlZ1lTM2FMMDhCVTl1?=
 =?utf-8?B?M2ZQcmFULzBWRUZTMmRsQkVOWktzZzhXSElVdXBBTy9iMEZQczVhU1pZMWlm?=
 =?utf-8?B?WnEwc1d6WXMrcHI0NmRGRU1wZldRRGE5RXB2cmFxNnpOV3lJSXlMTkRSUlF3?=
 =?utf-8?B?eUw3dHMreHJjRkZ4S3VPZkRBOHltbmZYRlRXa1ZwRWNpK3FRMUJlMS9rRDhr?=
 =?utf-8?B?R1dtOURNWTNhQ0Q1aVJZZ0NnNWdjaXlXbVlNbWxpKzUrNnlQNzNEUzZlZ2Zk?=
 =?utf-8?B?ajNFOTB1eEg1S1FOYWJ5d2xFc2svRk5LaVYvZ3M0MzMrRTAvcEpZSkNOd2Jr?=
 =?utf-8?B?VTRVYWtrYWIwZGFTY1EwblMwY3FTbTBsdis0endRNWdzanNrU2VaaXMrVytJ?=
 =?utf-8?B?VSs4b1k3cnlCSjNpdHNSQisxKzhEVEIvRW1jeW9BTW0rTzBJeTMwQlZsd0x2?=
 =?utf-8?B?bWZraVRPMThaVVNPdGtYYjVvKzZkR3c5M0ltRzhYUWFXeTg1eXlMVU1uMmtF?=
 =?utf-8?B?d21ObGY4cUNrVFRKMjhDNTlnMzhHcEJ0eGhTcnc2MlFsc2g1STQ4d1Y2cFlt?=
 =?utf-8?B?bHFMMmZSbVorTWE0eVcyK2NmTHorM25sTDJoV3B2WHh5ODNpUmhnUzU1SHJm?=
 =?utf-8?B?QkhlcVBWd1ZpK3JsWFRPc21HcmlWUldaYUJnbWZYYlBmMm95SzVRUCtkemdK?=
 =?utf-8?B?R1ZkaDhpMUlWVnZ6cHpXbWp2azF5NmF2S3Z0bkdvMW5OalVra2dyd1pHUFlh?=
 =?utf-8?B?MGh0OG1vYWdhbWpKZHljemtqMDZwWVh4R21LZ1BoVVRvNkJsQnFqTDYxeDFH?=
 =?utf-8?B?ekRScnVrenlvYVB6YnFiVmZyMnFYcXFNM29zM0hsTDcwNWVSVFRhNXVRQTRj?=
 =?utf-8?B?YjdjSHhFUlp0UHU1eHFCNGxEZ2d6N3A1RXBFRWJEcll2STBtdWd1MS9YdGM5?=
 =?utf-8?B?VktiODBnTld0VTl4MHdrcjZlSlpSWFNXREdza2VmQm5YanRXak5QdkhMUllW?=
 =?utf-8?B?OTY0eENkMkxWQzVaQnN2eVpVRFZyRFBySDlMc1VQdnkwSkI3eGZhQU16Z01O?=
 =?utf-8?B?SzZKYkxsT0tvcTczeURJV3kyaHUrQmFxT2ttb3dIWWwyKzdFM3YzU3k2dUo3?=
 =?utf-8?B?ODF6NWtzekpveEFtSVhPOWhRdnJpOW1PMXZBTll1UllnUkxlaHlUUEJnS0Ro?=
 =?utf-8?B?bTRuWU5aeWp2NmZiYmo1Qzl1b0NxRm03Vm1aSlhMbEhHcExQR1hKaDhUcGZ3?=
 =?utf-8?B?UHcyT2RPbXdET0FWMWw1STZEZnFwZVJhc2dHYTZFRG1Sd1hrNG5rU0NIZ1pI?=
 =?utf-8?B?aTEwcFdrODZ3dlZGWHhWQjdyTlJQOEUzMEdYYm5TdDk0eGFNeUtyM24vQWF4?=
 =?utf-8?B?NUVmays1WjJFd3AxQTYrYzQvaDQ1c2pnZnM3a3ZEeE05Qlcxek43T2hKM050?=
 =?utf-8?B?NnR4TnhjMHFrQmRFRzVydWlJaEFsdU5GbkloVnZTbGRvYXVtMGtOWmdmZWYr?=
 =?utf-8?B?bTBSYTNrSmhzNXpZMVhNWVVLRlVDeXhVNno4dmh4TUJra2ZlQkJzbkhlWTZu?=
 =?utf-8?B?eGZFQ1M4U3lJeWdaYkZSaUJJUEthcERYUXp4Q2Z0NG1vZkoyVGRHcTdETFNp?=
 =?utf-8?B?V2Y4ZUdTMnFkeEQ3QWI1ajFSanhEczVpa3JFK1VHYk5HV3FvTXJ0RjI0Wkx5?=
 =?utf-8?B?anJPSHdiV0tHUmtqcDdIV05zRjlRNjZXU0FReXo5TDdNS1J0Q29Dd2FMa2NZ?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AED59A5C86D2784EAB672C56FFB4ABDD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hcy1/W9RBkYTf1mEQjHTD50s8rSK2nMxceOvo2JJa/70HxE3007g6D9G15jey9ZYg8Ihh/G+c3NfmbflVbZSGDck090gqQfdGlguqDc4CdCjnh+PQhHs8jIzKNw/IMWdqrtOA4gFsuSsG2xAIqL+FPOJ5ZaJg+o8q0LH50VqaJ/FZG3UXIlpZ/sD4tQXU7+3dU/T++Vv6qKVtEShKplJpFm6czZp6YgcKcLMRE+Dml+vVYKlAJf4oIUMtZQ26w8J5v/+thSQe0aEpU35l8RKvSSjC+E5CFcjup/YQR/PJ8VBMRDPjW+M99jb/0Xh6jVsbIKHphxVenoeN/KgDQh8Ja8eI66UlKya884uRVj3GlmDlC5IEQymUNx4qiXu1KLwUGgHTck6kG6RODkZJ3RmBqWgJ7YI83kN63whMdy/P2B3seebmwOJymqBxGxJxYUOu1arrija5ahe3N0bJGNu2GBjmUm2oGX7YKeFqk5Xg/wAeSd6ma4obKPVjKwQrPUReLvkgi29QTQbTJBI48WDmzcL07k/Q1RaFuHrE3NwIdDD9rAiwtdZdyTC1zbTMAH2EJwRolbqcPEWW/jBEzrWXU7Mra8olZw9OBj/ThWoSOxC54xCdi4X0yBYcSjkIkWL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98906d42-bb3d-4d0f-a5ce-08ddbe0b2ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 10:35:39.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TaQyWSiZV9cbnCwTbfXB6QXYRua+GR1c5/1P2LGqUZSuUPJKWf8JF+TohQdM4dNMS0e0ny/lHk1Dz37IIk3RZ7APkwqGlc4U1nJ0r42HfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7812

T24gMDguMDcuMjUgMTE6MDcsIFF1IFdlbnJ1byB3cm90ZToNCj4gW0FCVVNFIE9GIEJERVYnUyBQ
QUdFIENBQ0hFXQ0KPiBCdHJmcyBoYXMgYSBsb25nIGhpc3RvcnkgdXNpbmcgYmRldidzIHBhZ2Ug
Y2FjaGUgZm9yIHN1cGVyIGJsb2NrIElPcy4NCj4gVGhpcyBsb29rcyB3ZWlyZCwgYnV0IGlzIG1v
c3RseSBmb3IgdGhlIHNha2Ugb2YgY29uY3VycmVuY3kuDQo+IA0KPiBIb3dldmVyIHRoaXMgaGFz
IGFscmVhZHkgY2F1c2VkIHByb2JsZW1zLCBmb3IgZXhhbXBsZSB3aGVuIHRoZSBibG9jaw0KPiBs
YXllciBwYWdlIGNhY2hlIGVuYWJsZXMgbGFyZ2UgZm9saW8gc3VwcG9ydCwgaXQgdHJpZ2dlcnMg
YW4gQVNTRVJUKCkNCj4gaW5zaWRlIGJ0cmZzLCB0aGlzIGlzIGZpeGVkIGJ5IGNvbW1pdCA2NWYy
YTNiMjMyM2UgKCJidHJmczogcmVtb3ZlIGZvbGlvDQo+IG9yZGVyIEFTU0VSVCgpcyBpbiBzdXBl
ciBibG9jayB3cml0ZWJhY2sgcGF0aCIpLCBidXQgaXQgaXMgYWxyZWFkeSBhDQo+IHdhcm5pbmcu
DQo+IA0KPiBbTU9WRUlORyBBV0FZIEZST00gQkRFVidTIFBBR0UgQ0FDSEVdDQo+IFRoYW5rZnVs
bHkgd2UncmUgbW92aW5nIGF3YXkgZnJvbSB0aGUgYmRldidzIHBhZ2UgY2FjaGUgYWxyZWFkeSwg
c3RhcnRpbmcNCj4gd2l0aCBjb21taXQgYmMwMDk2NWRiZmY3ICgiYnRyZnM6IGNvdW50IHN1cGVy
IGJsb2NrIHdyaXRlIGVycm9ycyBpbg0KPiBkZXZpY2UgaW5zdGVhZCBvZiB0cmFja2luZyBmb2xp
byBlcnJvciBzdGF0ZSIpLCB3ZSBubyBsb25nZXIgcmVsaWVzIG9uDQo+IHBhZ2UgY2FjaGUgdG8g
ZGV0ZWN0IHN1cGVyIGJsb2NrIElPIGVycm9ycy4NCj4gDQo+IFdlIHN0aWxsIGhhdmUgdGhlIGZv
bGxvd2luZyBwYXRocyB1c2luZyBiZGV2J3MgcGFnZSBjYWNoZSwgYW5kIHRob3NlDQo+IHBvaW50
cyB3aWxsIGJlIGFkZHJlc3NlZCBpbiB0aGlzIHNlcmllczoNCj4gDQo+IC0gUmVhZGluZyBzdXBl
ciBibG9ja3MNCj4gICAgVGhpcyBpcyB0aGUgZWFzaXN0IG9uZSB0byBraWxsLCBqdXN0IGttYWxs
b2MoKSBhbmQgYmRldl9yd192aXJ0KCkgd2lsbA0KPiAgICBoYW5kbGUgaXQgd2VsbC4NCj4gDQo+
IC0gU2NyYXRjaGluZyBzdXBlciBibG9ja3MNCj4gICAgUHJldmlvdXNseSB3ZSBqdXN0IHplcm8g
b3V0IHRoZSBtYWdpYywgYnV0IGxlYXZpbmcgZXZlcnl0aGluZyBlbHNlDQo+ICAgIHRoZXJlLg0K
PiAgICBXZSByZWx5IG9uIHRoZSBibG9jayBsYXllciB0byB3cml0ZSB0aGUgaW52b2x2ZWQgYmxv
Y2tzLg0KPiANCj4gICAgSGVyZSB3ZSBmb2xsb3cgYnRyZnNfcmVhZF9kaXNrX3N1cGVyKCkgYnkg
a3phbGxvYygpaW5nIGEgZHVtbXkgc3VwZXINCj4gICAgYmxvY2ssIGFuZCB3cml0ZSB0aGUgZnVs
bCBzdXBlciBibG9jayBiYWNrIHRvIGRpc2suDQo+IA0KPiAtIFdyaXRpbmcgc3VwZXIgYmxvY2tz
DQo+ICAgIEFsdGhvdWdoIHdyaXRlX2Rldl9zdXBlcnMoKSBpcyBhbHJlYWR5aW5nIHVzaW5nIHRo
ZSBiaW8gaW50ZXJmYWNlLCBpdA0KPiAgICBzdGlsbCByZWxpZXMgb24gdGhlIGJkZXYncyBwYWdl
IGNhY2hlLg0KPiANCj4gICAgT25lIG9mIHRoZSByZWFzb24gaXMsIHdlIHdhbnQgdG8gc3VibWl0
IGFsbCBzdXBlciBibG9ja3Mgb2YgYSBkZXZpY2UNCj4gICAgaW4gb25lIGdvLCBhbmQgZWFjaCBz
dXBlciBibG9jayBvZiB0aGUgc2FtZSBibG9jayBkZXZpY2UgaXMgc2xpZ2h0bHkNCj4gICAgZGlm
ZmVyZW50LCB0aHVzIHdlIGdvIHVzaW5nIHBhZ2UgY2FjaGUsIHNvIHRoYXQgZWFjaCBzdXBlciBi
bG9jayBjYW4NCj4gICAgaGF2ZSBpdHMgb3duIGJhY2tpbmcgZm9saW8uDQo+IA0KPiAgICBIZXJl
IHdlIHNvbHZlIGl0IGJ5IHByZS1hbGxvY2F0aW5nIHN1cGVyIGJsb2NrIGJ1ZmZlcnMuDQo+ICAg
IFRoaXMgYWxzbyBtYWtlcyBlbmRpbyBmdW5jdGlvbiBtdWNoIHNpbXBsZXIsIG5vIG5lZWQgdG8g
aXRlcmF0ZSB0aGUNCj4gICAgYmlvIHRvIHVubG9jayB0aGUgZm9saW8uDQo+IA0KPiAtIFdhaXRp
bmcgc3VwZXIgYmxvY2tzDQo+ICAgIEluc3RlYWQgb2YgbG9ja2luZyB0aGUgZm9saW8gdG8gbWFr
ZSBzdXJlIGl0cyBJTyBpcyBkb25lLCBqdXN0IHVzZSBhbg0KPiAgICBhdG9taWMgYW5kIHdhaXQg
cXVldWUgaGVhZCB0byBkbyBpdCB0aGUgdXN1YWwgd2F5Lg0KPiANCj4gQnkgdGhpcyB3ZSBzb2x2
ZSB0aGUgcHJvYmxlbSBhbmQgYWxsIElPcyBhcmUgZG9uZSB1c2luZyBiaW8gaW50ZXJmYWNlLg0K
PiANCj4gW1RIRSBDT1NUIEFORCBSRUFTT04gRk9SIFJGQ10NCj4gQnV0IHRoaXMgYnJpbmdzIHNv
bWUgb3ZlcmhlYWQsIHRodXMgSSBtYXJrZWQgdGhlIHNlcmllcyBSRkM6DQo+IA0KPiAtIEV4dHJh
IDEySyBtZW1vcnkgdXNhZ2UgZm9yIGVhY2ggYmxvY2sgZGV2aWNlDQo+ICAgIEkgaG9wZSB0aGUg
ZXh0cmEgY29zdCBpcyBhY2NlcHRhYmxlIGZvciBtb2Rlcm4gZGF5IHN5c3RlbXMuDQo+IA0KPiAt
IEV4dHJhIG1lbW9yeSBjb3B5IGZvciBzdXBlciBibG9jayB3cml0ZWJhY2sNCj4gICAgUHJldmlv
dXNseSB3ZSBkbyB0aGUgY29weSBpbnRvIHRoZSBiZGV2J3MgcGFnZSBjYWNoZSwgdGhlbiBzdWJt
aXQgdGhlDQo+ICAgIElPIHVzaW5nIGZvbGlvIGZyb20gdGhlIGJkZXYgcGFnZSBjYWNoZS4NCj4g
DQo+ICAgIFRoaXMgdXBkYXRlcyB0aGUgcGFnZSBjYWNoZSBhbmQgZG8gdGhlIElPIGluIG9uZSBn
by4NCj4gDQo+ICAgIEJ1dCBub3cgd2UgbWVtY3B5KCkgaW50byB0aGUgcHJlYWxsb2NhdGVkIHN1
cGVyIGJsb2NrIGJ1ZmZlciwgbm90DQo+ICAgIHVwZGF0aW5nIHRoZSBiZGV2J3MgcGFnZSBjYWNo
ZSBkaXJlY3RseS4NCj4gICAgSWYgYnkgc29tZWhvdyB0aGUgYmxvY2sgZGV2aWNlIGRyaXZlIGRl
dGVybWluZXMgdG8gY29weSB0aGUgYmlvJ3MNCj4gICAgY29udGVudCB0byBwYWdlIGNhY2hlLCBp
dCB3aWxsIG5lZWQgdG8gZG8gb25lIGV4dHJhIG1lbW9yeSBjb3B5Lg0KPiANCj4gLSBFeHRyYSBt
ZW1vcnkgYWxsb2NhdGlvbiBmb3IgYnRyZnNfc2NyYXRjaF9zdXBlcmJsb2NrKCkNCj4gICAgUHJl
dmlvdXNseSB3ZSBuZWVkIG5vIG1lbW9yeSBhbGxvY2F0aW9uLCB0aHVzIG5vIGVycm9yIGhhbmRs
aW5nDQo+ICAgIG5lZWRlZC4NCj4gDQo+ICAgIEJ1dCBub3cgd2UgbmVlZCBleHRyYSBtZW1vcnkg
YWxsb2NhdGlvbiwgYW5kIHN1Y2ggYWxsb2NhdGlvbiBpcyBqdXN0DQo+ICAgIHRvIHdyaXRlIHpl
cm8gaW50byBibG9jayBkZXZpY2VzLiBUaHVzIHRoZSBjb3N0IGlzIGEgbGl0dGxlIGhhcmQgdG8N
Cj4gICAgYWNjZXB0Lg0KPiANCj4gLSBObyBtb3JlIGNhY2hlZCBzdXBlciBibG9jayBkdXJpbmcg
ZGV2aWNlIHNjYW4NCj4gICAgQnV0IHRoZSBjb3N0IHNob3VsZCBiZSBtaW5pbWFsLg0KDQpJJ3Zl
IGFsc28gZ3JlcHBlZCBmb3IgdGhlIHVzZXJzIG9mIGJ0cmZzX3JlbGVhc2VfZGlza19zdXBlcigp
IGJlY2F1c2UgSSANCnRoaW5rIHdlIHNob3VsZCByZW1vdmUgaXQgYXMgd2VsbCBhcyBhZnRlciB0
aGlzIHNlcmllcyBpdCdzIGEgcGxhaW4gDQprZnJlZSgpIHdyYXBwZXIgYW5kIGZvdW5kIHRoYXQg
YHNiX3dyaXRlX3BvaW50ZXIoKWAgaW4gem9uZWQuYyBpcyBzdGlsbCANCnVzaW5nIHRoZSBwYWdl
IGNhY2hlIGZvciBzdXBlcmJsb2NrIHJlYWRpbmcuDQoNClNob3VsZCB0aGF0IGJlIGNvbnZlcnRl
ZCBhcyB3ZWxsIGluIHRoZSBmaW5hbCBzZXJpZXM/DQo=

