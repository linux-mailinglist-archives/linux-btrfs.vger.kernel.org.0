Return-Path: <linux-btrfs+bounces-13646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133DAA8F72
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593543A825C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB82C1F7075;
	Mon,  5 May 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JQuzEZXb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n4O8xTm8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5413E41A
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437134; cv=fail; b=V980ikrjc1NFe/QYKQ61CLwyVFmCxbKc1LmkXxTHrWYzeCsevi9R0JqC0PwHYNoQ+p57PWVaHInMpLFptG9KgZW5JBnSOQhLGSg3O2pFiRijK3+acop2Dl7urJAyT41qimVWe8kGEdbZRGAsAb8tdU5pyAjfYz8RJI9ktIGs9w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437134; c=relaxed/simple;
	bh=W6ltPIBfd3BWcS/RgOEc5l7xqfXeWWnJTgKYGPXgppM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4Xkee1dZXh+iAMMd20gMhfwblMk8QY18HudbuiFwTHt/hXf015Cgjlq8clTF2yNTGQatw4KysUQg98Gv1ZUQI16yKJKtB3SY86CrfyjXUJpR0hnwGClz7PHJuGkrXbOpNNKT21agUFeng2IbhNgazbMbvXYrdMjdowsjCPw/JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JQuzEZXb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=n4O8xTm8; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746437130; x=1777973130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W6ltPIBfd3BWcS/RgOEc5l7xqfXeWWnJTgKYGPXgppM=;
  b=JQuzEZXbvyDmxE6dubwI8QZuAfH9TsbFNSSptMDI1unDMT2eukJKD5Fd
   LmBUXNLtluioIB+ZwWRu9E1ibY8Mm/Je5HwpNzuRNUiq+gcWejCc46d/7
   b1WsWsdhhZqVtwIzf4hul7pRP+KnNp1HCEoAFe3aSiLW1yd8g19oNjNSW
   ihWkbINhYqNrcSb/a5GqBWqCH2TWSGaKnNTVDbiBFR5XoRJl92tuAjzMI
   svv6wQ7mED71T/qK3S1LQBg8j52Xu70GCkhEvIQj5aSUd5FreD7x8FmOw
   hXEmzgvBFSXI4thUaCaMePlOzikEcOJn/v+TxzWfymkhKqx7G4DeB6zR9
   w==;
X-CSE-ConnectionGUID: okqe0TuiR3SEzsXsyms6Bg==
X-CSE-MsgGUID: eMFc7YTnT/q6DUrBX56QjQ==
X-IronPort-AV: E=Sophos;i="6.15,262,1739808000"; 
   d="scan'208";a="79289974"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2025 17:25:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyhWZH9GdfC6ifEGybBPyhzuSdVGqNCkx4ksRRtH9qlntnOrk6h3AGFFNAqH7YcQCK44p1wqQBM4KcsPOaUpcqo8naShohhSy9by7xgEEJHEpy8bcI+85RlkozFiLTwjDHIQJiQW0sJFf3FyxKO8kYMXN7d7fldrbf2wMrPBOmg9+OalEyRV1CIMEJ6TLUjNjwK7k4Ay12pXA3rOpGoUd5AdDRFBsUyJgFSDJxQk2xld30/z6cvV1Jx8iSm4ukpX9FMTE5DoJSWjsK4Mg+9KaxlJ6TDlSrAViqz/z8pHH+QtNkh//azyIzODQQvjroBmmEwzL9GXZYqjYaYoDPTZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6ltPIBfd3BWcS/RgOEc5l7xqfXeWWnJTgKYGPXgppM=;
 b=W6nex76dpEu0ZcPhJqJQk0LASb70LDakxcM4dlD6Dlf1Ywjs/tbIR/UKR/Ai3BsyRnFAxmGJemG4L/OEytJksWcxE5v6DrO5KG7CNocdpWSRywDBm14uQvMEcFrH4ZnXTASJAKL2KVMcSJX9lHQhy3aM8hlRLrtYd3zhQVm6kPp47ORFV6QFQyjOuW7P3v+8n4NXOscP8EWnlDgE5uFQLcBKTrPjQKxS1jWvq8C0pSNgp5ketSdI7iNXk3p1jtweaPZFSXk7lR3nEp1Y+6eNpYujBxpT1XGsCL/zP7J338t83dv2XHix9ogR5eUzwMQ4ta+rwJdDbsmTbLRkNxU+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6ltPIBfd3BWcS/RgOEc5l7xqfXeWWnJTgKYGPXgppM=;
 b=n4O8xTm8QagxS5Prkc0pIo9me34oSExaBnmkWwk83pXhPMJPGgRXxs8YJXs3+ip21Ny56PTUpMHF+tBkprkXRwJJWWqr+fglUJIwijsXRtxcRi4zKkUBvstd2mvZ6snjcAcDtiBZI9L2OzQPy3ipwiMvVJfVKYIxq+18ieOdJ2Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8594.namprd04.prod.outlook.com (2603:10b6:806:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 09:25:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 5 May 2025
 09:25:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mads <mads@ab3.no>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "jth@kernel.org" <jth@kernel.org>
Subject: Re: BTRFS critical (device sda): bad key order, sibling blocks, left
 last (4382045401088 230 4096) right first (4382045396992 230 4096)
Thread-Topic: BTRFS critical (device sda): bad key order, sibling blocks, left
 last (4382045401088 230 4096) right first (4382045396992 230 4096)
Thread-Index: AQHbvZwdL8y+c6w9BUKWVJnZYo4XV7PDxAaA
Date: Mon, 5 May 2025 09:25:21 +0000
Message-ID: <6ced26e8-ffae-488f-b910-f332f1190430@wdc.com>
References: <c00b7f69-6a21-455b-aab2-dafcd1194346@ab3.no>
In-Reply-To: <c00b7f69-6a21-455b-aab2-dafcd1194346@ab3.no>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8594:EE_
x-ms-office365-filtering-correlation-id: 8d213357-4a25-48ef-8870-08dd8bb6c26b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TktoaUJSNGRJWVZSSTcvMDBBUDZZVDNBSjN2MDBENlZ0dEJhSUR4elN4WmxS?=
 =?utf-8?B?K2ZNT0RhakFNZ0EyQ1hNT21EUUREU0hsY3JMSmMwQlhlakIwNThqaU1JZTJG?=
 =?utf-8?B?eVl0VW9JY3Z1SHNJK0k3VWRabC9WZitiT2FIY2R2TS92RGh6UVhCczRRNlVj?=
 =?utf-8?B?aHB4djBLRVR4WDI0RVFjdjVBZ1BXR3RDeFFTZXB1dmtNQjluWnhYN3V1bVJL?=
 =?utf-8?B?N0ZYNmpsUDUzNjQvZHdyaXU4UzB4RXNqbnh4Mk1ENjdONVVscWlnVGd5MDFT?=
 =?utf-8?B?RGNmcGtTYzI1aDdqdzRwaDU1bHJyM2V5TC9EUUJvSzJldnBxYWhySDVabUJC?=
 =?utf-8?B?UkdGekJ5MmlzUndwUmd6WWpBanZtVWhMakpmZm1BSFFGVjFKUTVCc0NHTGZV?=
 =?utf-8?B?dktYQjE3ZWtLazJ2Q0orWjdhS0w1TjRRbXRoQkkxWXJ3U3E2Z3lldStNTnVV?=
 =?utf-8?B?cW15L3dOTEs0bDYrNkRUQU5KdURqaCtHTzVoMHRqZEFyYk5DSGs2ZFhpaDA0?=
 =?utf-8?B?TFhlam9FRWNJTjJpbjU5WFdpUXhOaWViOU1uSTBZN2dXMHkwdXNocm45ck5V?=
 =?utf-8?B?YkxwY2ZkN1dGUjgxL0JQK25ucUtSZHVlZFlwTVp5RjBWdkNnRDdJaTBvVldW?=
 =?utf-8?B?cGtCUEpzMWJpbDdHUVVubE1FQTh5MlpkVHNzamVZdUREdHlQYm5MTDhWbnJW?=
 =?utf-8?B?RDMrVXdZL0NDT0pGQ0Ywam82bityRm1COCtxdUxkS3J4YjdKZzVaeHprb0Z4?=
 =?utf-8?B?OXFWQUY2V0dTaWJpRGphbUZMUWNlR0M2dzkrenMvdEJteFpoUTU4cHE0NTR3?=
 =?utf-8?B?T2FrNmowQnhvQnB3M2FhRDltOVZPQkxyR3lQSVZkVzhTOU92Z21CeHBxWXlD?=
 =?utf-8?B?RzJzVWdibEExS0JNT3BFOGY0blUralFiYlFTcTR3anQrbkY2RDg3RFdCck83?=
 =?utf-8?B?Z1FuS3FjaGg5dEdNcURJU2p0emV0L0lrVGZFR0l3aUhrOUNTS3VNcWZhUVJN?=
 =?utf-8?B?M1dlYUt0VUpaVEZzRzZZVlU2SHJLQ1k2d0NKQXRDUGpOcnFlOVk5aVFaaVdG?=
 =?utf-8?B?MG40N2h5L2JsWWppVXN0d2R4NmprWjBXT0ZZdlhYNXZKamFqQjBFZ2dUU1dh?=
 =?utf-8?B?eG9tbWxGYXZjaWVDSnJ4MkFCaEhBKzZhTldUY0Q1N3JxYXBRUEpwQlhyOUhi?=
 =?utf-8?B?NmdEenlLYXhiSUVTNHJKT0FnY2cyOXppcHJsK01hNHNiMnJGbzJvWmwyaFZN?=
 =?utf-8?B?eEQ4ZHZzQ2xWVGtnTi9mcGlBQTRoSy96UW9rc2NwbFhKZVFDdUFqTDdMS1ZB?=
 =?utf-8?B?T3lxOUlLakphMytucUlteG45c1psWGFTdVVLcGgrdFZiYTlJRDdDSVFiSHg3?=
 =?utf-8?B?d0xSQVpsaDJSZXg4bmZFYWlVSENWSUJ1Q21Xb3l5aHEwUTl1YWhZaWZVNzQv?=
 =?utf-8?B?aGlJK0dRMTYrMjdEa3hqMjZ0cXZCOFNOSHVranJpc0xXU09sRUJTbm9PVWJi?=
 =?utf-8?B?NTB5ZkJMTHUyQmxzemt6OHA1M0dYMVJNMnpyMXVWTEFsVEFjMzlicXFjb2tw?=
 =?utf-8?B?U1dxaFlEaDh1S1Z5VDhhdytvZlBpb1ViS3JDc29LbW4yK2ozMUlZbGhSdlY0?=
 =?utf-8?B?OHQvc2hLRUh2NVdtWWQ1UzMraDJRZS8vUU5pWmhpOUFSKzVzRUtQSVJXbVZU?=
 =?utf-8?B?dTFqWW03MUswcXg3YmtEOVJ0emhkdXpEWXcvZGErWDRZc3VrbTR2R1FvekhS?=
 =?utf-8?B?cjh2dDg3UmhTalRIYnBkeEtIMFdpbi8yTzJDZWlGbXprZFhURGt4M29qSEVq?=
 =?utf-8?B?U0V3SERSdDJpZGFuUXI5NnZPeXpLenh3NDJWUHd0SUlCLy9mKzYwNlJRWlZZ?=
 =?utf-8?B?SmRET2loRDMrTUF4MlovNFJoaTA5WFp2ZEE5Y1NqaEo5ZFdvQ0twTkQyRmEz?=
 =?utf-8?Q?zMG6qnCz+Zg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDNESDNlY05jS1FXRzVuVS9DcTZFOC9YZ1BBMnMxS3htbE9kMVlER1F3TUU1?=
 =?utf-8?B?Nk5WZzZybkt6SHhMd1VXSWpidzBCaUJuZHRjbnlZRjI3SGFFNk93RVhFWk5C?=
 =?utf-8?B?RUpBeHI5TE9DY0RCZFovdFpCRkhXTTc3VDhZTmZVZmhIOXVENW41Yk9VNG5D?=
 =?utf-8?B?SHNTU3QyTWg3cHFpUk1oeTZXNkNEak9LRkU0S215eGdCSXQ0cjJNSUs5bzRj?=
 =?utf-8?B?ay9kUkVlL1p3VUZqQ1FaZmRIMGo1OWphVjMxVFdyb0FzRWExYVdGcGtvZFkz?=
 =?utf-8?B?eTd4TTJoMTNOcC96cnB2clc0bU9Vcm93ZEFBQjU1aXdYTkN2U3lGU05nOXQy?=
 =?utf-8?B?YlZGU3N2Q1h5NzRoYk1zazdzL3Jkci9RMEt3ZVhlVk9Jb0dzcGJuVnRpRGNt?=
 =?utf-8?B?UDZEeTcyMUtNdkN1VTRiUjVXNU93QlV2NmF0Yzd0bURoUlFacldCOEtCL0xT?=
 =?utf-8?B?SEZHeHZubUVyeitDcHkxdmhWb3JWWUhjTnY3Nmd0cXdvdEhZTmFZdXA5eXhs?=
 =?utf-8?B?Wk83enJuc2lTdUNKMHhQMzFQMkFqOVFweXNPeEF6ZE51TFk1czM2OHpYb0hh?=
 =?utf-8?B?ZFNLaUY5dURjQkNWVjhlRnFWc0pObDVZdHh0OGJVamZ0ZjNIa0lQZmxCR3pr?=
 =?utf-8?B?ZjhGK2FiTGt6WXNOSWZqbzhhZHFicFR0ZTYxamluSkRmQWJPVk9FTGwwckhF?=
 =?utf-8?B?c1d2UFBKWTdXUU44WFVqY2hMTXpMQ09wZjFEU3lZaFJnbE8zSlQ5VlVwMWdK?=
 =?utf-8?B?WER3Y2VLS04wOHpFa0Q3NzlqblNNU01vUVFQR0ZPZVRvNjBOU0QzNm9HNXZY?=
 =?utf-8?B?NGdWUVV1UFhzYkJmMGUxMk9ubUFOdnBRbE1kWTI0enR6dzNJYU53WGFaOEpq?=
 =?utf-8?B?T3lhV2FQOFRzU3RvL1lCNDZMME9GcXpyOEdSVXgvT1hocjVhNEoxazFzWWQx?=
 =?utf-8?B?VFdVTUM4YjRkRDhvNStsNWJNeHJodkVWQlZCc045ZUJ3MHdFRTdlQW5uOXdv?=
 =?utf-8?B?aEZCTml4MzhOclJOSTNZR1MxRi9VSkJtU3dEZTdDRDQyclBVbVZBRDlWdGIr?=
 =?utf-8?B?cEdnRStQV2FwQnlZSlZrSlBjU0l0MGVjSk1SZnBBQnFzdHVITGY1SDNzZXRX?=
 =?utf-8?B?dzVpWWlaUElwQlpSM3g3ZlgyZWJxV2txOSsycVI1S1V5d1pMN1c5WGZvVDlx?=
 =?utf-8?B?dTN1d0k5QThkbFJER3R5ancvQ0pJN1NuamlUdS9PUjNkMlF4K24xay9RMlRM?=
 =?utf-8?B?elZqSmJNKzkzNEE1NDlRZ2FBbVNxWEJzTkR1QmR6TU9UTUxPL0orQ2x1dXpt?=
 =?utf-8?B?eDFhWXE3WDcvZ3Q1ZWhQd2tRbDRRam42QndnblZtNzIySnhYcUR1Y0RuZG1V?=
 =?utf-8?B?RW5Uc0xWNXpGZEFGUjcxaEtRait6OEUxTnZmNnRxU2dyVUoxMmhQemRBL0U5?=
 =?utf-8?B?Tk9ucmFNY3cxN1doUEY0c215ZHluR3ZtL0dXSkNUYUJ5Tnc1ZFd6aDZ4c1BO?=
 =?utf-8?B?L2FMNkJ3TzV3d3hXTUhZd3dreSt0eXlvYzVHSFh1Q01abXJIaFZuMWl1dGkr?=
 =?utf-8?B?bGdtVkhpSFliM0t3RFRhVTl1Ly9FNXkzZER0dW5TWGlieHdscjRNSXFIRkdy?=
 =?utf-8?B?QVRnVEREckRac0o0eVFObmVzaU9scDZnTFhJcnVLMmFJMjhrOHJsVkkwQkY3?=
 =?utf-8?B?S2JnVXFMSVlObnVmaGVTaWVZdWFYTThmaitJNXdQWDV6cDdrQU5XV3lNSSs5?=
 =?utf-8?B?RFpqREhGUmdYQTU2cFRFQ0Exb3o5aXJoYm9nRCt5K3JtRkp0dkZtck9XNjZ2?=
 =?utf-8?B?cGl4eXc4Tm1EMDh0ZjM5T2NwOWVGRnNjZ2Y3S01WNzN5dGNoSmlldytBOFpy?=
 =?utf-8?B?OFZDTytFR2dBWWxMdkN0TEcvQzgwVlFGNjRLNEoxT0ZGR21hYk9vS2tualJW?=
 =?utf-8?B?aUdDVm1telhJZUJXQkFKc0IwOHRNeTY4V2toZVAyNHZDNXlzbk9KNDZUc1Ey?=
 =?utf-8?B?bnRVYmsyak1PVkZiRUdTRVFwczk4L3ZWRW5qTnlUSXRNUHFzTzBPZjlWRWcv?=
 =?utf-8?B?R2diaElHdWErMXk3MzJyVGppMkozZ05NYkZGSGVERk1sSXU5NTkvRmVIZ050?=
 =?utf-8?B?VmxxdnpyS3hrQVYwZGZlQ3lyOG5vSnNGTVY0cU5kSHA3S3BKeFJxclpTTnNp?=
 =?utf-8?B?Q1ZJMDJac2w3U2ZTMWN0L1NGbjRLc1gwbzFEV01LcWhUQ2pXNVNXQVVPMThL?=
 =?utf-8?B?d2VHQmhFd3hlRmRTY0JDbjVlRk1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FB31027A8330548B9300E319C04338E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MELTZwaGr8gLYBPsenZMrubfW9PZLOAKnqNpOA6Tqhyv4XsUehzPx/8+tnQmVe8zrbuJbTjlIplAAAIKsCw1UhaATnjsDnUNvyx552ikOW0+hzdDL2cB6SgkaEHdSYKPw1lUZUGtaD2XuwKC2ExxfbC50GPP2kEfmKXa+ZqWR3JAV+Lh6axlFG2SxP5dKeDbhSwzt2s3fumPwoxi/Jb9K7uSVuQRHDUa4tXGFoX+KnD1RKlkdLt+Gga1huNhMqi4KJZqqIeg0AWKfbRfDtMM+THINsY2Ybty/lsrutfvQPIsO+oCIep11q6EZq5LsYSGf+H3uI2g+Yp/QLX13qlqR3JRbI/18yPRHPZ2KOZRJQNrszc2eVyXEgTaXx4RLH2E/2riS8EoNShull3St37pfbM9nrpZkPqyMomZoMkDOnqjo4nnsf0DGLzlnkENfBBE9tSbcNsbFIbWWNpDSn3zrXIjK28CUln0i4+lEYuuDjHCFK2V/SU0ldRONV8uh1cObFNl4ihH304EAZSCjKWQX7vyFae66P+EJAhriMZgCKGWwIOp4EgzGHUf531Ca9Omv6xbO1YlEf4BHdKE9wmeeWV5DBtDwDb3d/wpBI8pXaaVMSjfsHqb3wfH+QthnZCP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d213357-4a25-48ef-8870-08dd8bb6c26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 09:25:21.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fCtJdGUBj/MpfAPv0K4A/+jC9CFq0F23CMFrAkwg/WtyagczMTpxFgPZgT6yuBkDnzOncQ4i4gO8BjZ7ogQfueGGwf2RZ2x/IOx/+zssik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8594

T24gMDUuMDUuMjUgMTE6MDAsIE1hZHMgd3JvdGU6DQo+IEhpIQ0KPiANCj4gVGVzdGVkIG91dCBj
cmVhdGluZyBhIHJhaWQxIHdpdGggcmFpZCBzdHJpcGUgdHJlZSBlbmFibGVkIG9uIDYuMTQuNQ0K
PiAoYWFyY2g2NCk6DQoNClRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCg0KUGxlYXNlIGJlIGF3YXJl
IFJBSUQgc3RyaXBlIHRyZWUgaXMgYW4gZXhwZXJpbWVudGFsIGZlYXR1cmUgYW5kIHNob3VsZCAN
Cm5vdCBiZSB1c2VkIGluIHByb2R1Y3Rpb24geWV0Lg0KDQo+PiAjIG1rZnMuYnRyZnMgLWQgcmFp
ZDEgLW0gcmFpZDEgLU8gcmFpZC1zdHJpcGUtdHJlZSxyYWlkNTYgL2Rldi9zZGENCg0KT3V0IG9m
IHB1cmUgY3VyaW9zaXR5LCB3aHkgcmFpZDU2PyBJdCdzIG5vdCBzdXBwb3J0ZWQgd2l0aCBSU1Qg
eWV0LiBJIGRvIA0KaGF2ZSBhIHByb3RvdHlwZSBidXQgdGhhdCdzIG9ubHkgc3VwcG9ydHMgZnVs
bCBzdHJpcGUgc2l6ZSB3cml0ZXMgeWV0Lg0KDQpbLi4uXQ0KDQo+IFlvdSBjYW4gZmluZCB0aGUg
Y29tcGxldGUgZG1lc2cgaGVyZToNCj4gaHR0cDovL2N3aWxsdS5jb206ODA4MC85Mi4yMjAuMTk3
LjIyOC8xDQoNClRoYW5rcyBhIGxvdCwgSSdsbCBzZWUgaWYgSSBjYW4gY29tZSB1cCB3aXRoIGEg
bWluaW1hbCByZXByb2R1Y2VyIGZvciBpdC4NCg0KPiBJIGRvbid0IGtub3cgaWYgdGhpcyBpcyBy
ZWxhdGVkIHRvIGVuYWJsaW5nIHJhaWQgc3RyaXBlIHRyZWUsIG9yDQo+IHNvbWV0aGluZyBlbHNl
Lg0KDQpZZXMgdGhpcyBpcyBhIFJBSUQgc3RyaXBlIHRyZWUgYnVnIGFuZCBJIHRob3VnaHQgSSBo
YWQgaXQgZml4ZWQgYWxyZWFkeS4gDQpBcHBhcmVudGx5IG5vdC4NCg==

