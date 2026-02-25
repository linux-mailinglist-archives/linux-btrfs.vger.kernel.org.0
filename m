Return-Path: <linux-btrfs+bounces-21906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPP1OXqcnmkZWgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21906-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 07:53:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4165A1928B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 07:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB42B310768B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 06:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555D2BE7C6;
	Wed, 25 Feb 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XeK1+CBl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p3VtPnSO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AC75801
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002133; cv=fail; b=CjCyqArYlEFWtUo6Vzj5fa8fQZLcW+fWFf2RcPSCmPxsEhos+5EqrMbgNagTnEcfCPxeJjx5976/V6TshfFgvzly+GqG4bSiAeg1jC6u3CfXrOf1zHyQIN/mtjeSt0EbWzgmZSM7yBICdjUPoNx0aVbwPpRQaZVI6n2k+QO6e2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002133; c=relaxed/simple;
	bh=XhMhnH/Js+dgOAL4DuWPC3jpPluZPNcVELkaeP/uWb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTPWOxiyJr0v+jEIlxFQqjhaTKjqNBs5eVXt+DNdyoIz6l/5BxAfPugudZ5WuGQ29CO35/BVNioneMCDgbrz7r555aBzi9elUlXcQ5cPXM+GCVGonXzoMxU0bBsyylqdEx7Ja+uUtykcgIgoqLkRoHw0K4yXtZi1AKDs2CF7qlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XeK1+CBl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p3VtPnSO; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772002132; x=1803538132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XhMhnH/Js+dgOAL4DuWPC3jpPluZPNcVELkaeP/uWb8=;
  b=XeK1+CBlX5tifMjcfhgTI8bKkeMT2fPytt3KN3bqq60HmfuJ2P13abDX
   aX7odhsNc/Z3YRQTjtOLQ0MG/ted9Eo5UPXC6XoR/wcogbyv8V+O7G1s6
   kdZ8RyXpP7ZZPhI1SUsyb2TQGfhmoeC1K347FPtS3eRsrnavIfY79ua8J
   d5SEz/5p6/qR5yR6YItAURO9v8K2Ju2zVY+KaD9261MsJgI280HxkchTv
   ewVQuqq7OlNkqFPVpVVGqa66FBaws0IRZlKZc+gvIOVnSE5d60qkuLCli
   U320f+3sKlto8Oko4SvY/4Sad3Lek35xx9zXqAoPm1Jx2QikFjryh9Izi
   g==;
X-CSE-ConnectionGUID: NO4tl/QvRIWAOSO3UuQqPg==
X-CSE-MsgGUID: NJLmJWZWQxK1ng43D/2Izg==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="141026960"
Received: from mail-northcentralusazon11013067.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.67])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 14:48:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAuf0AOHm/ruAeW1AT3VfmtC4+vYjEYbPrGedXWqt/YrsqZqBp4zqyN+6h0ekEkEpqU2R6IKeWO7ysptcc7OBMXPwxnig0zYVC5S4iDz26juFUHmsYkTf/1MrmBHYZKC1DtDsIT3xd7gSVyFd+4RAFtJzYvRchJc3vE98krXRAJJr+/WTfs5n0+/TcP+s7octYwAP0y+BHUbLKy+8ZI5L1/ORRGRet1ISHXwld3TwcK6b3mAirg5MwYgq8LUDGQSZDLS7KuLFWkQWVS5ig1HhTNU+5Z0fD7cmTWSbQo9zrTFMP5Xtuezn985EJLwHuTOzHRlezOYh97Gin3HTwY6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhMhnH/Js+dgOAL4DuWPC3jpPluZPNcVELkaeP/uWb8=;
 b=sTajqg1ZeezmCFQ5mQu749S9sSnO8CEx1otC0uB9WF9H6ugRR3oAf8cy5lOIWiP3mp1dMk/XNa5COfVup8YEL+DcVvjrroSRut1qI5gsTVV8qk5wAgbmTr4hhI3iChqJl4cmx9E/XQ1ykqT+I1mwP/eAe/GI7QnHDOL9MzMWa0stlYBl6CTN6fUVKc20nv9tjkpJzy5H+QdzVyGIK5OPbNO5ZD+YL5WyQvxSD9JXWe1pwFjYVsUIHVxZnj5mBKdlH7RWEwedUtfWIAVVQJaqxFX3/L4dw25a5WUM6QDiQM1SlbgwMP7JEkfwu+gh4EMXcwV/TANp4KhQbJ8AFtn5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhMhnH/Js+dgOAL4DuWPC3jpPluZPNcVELkaeP/uWb8=;
 b=p3VtPnSOz4+oHMoerwBmUY3dU3sKEAohPvf029KBX+mn71JHpwHUUybBqPMCihuSBZhSwkLwaT9vWi9tHJtBZNoB5iTVStpsCc5LqmmRCL4Szdso4KN1Ua55P9RgAbtgzA4eHUYKL/2sHMeC9oGLDGb64vbPqfGSzeA/xzzFwOU=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH2PR04MB7095.namprd04.prod.outlook.com (2603:10b6:610:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Wed, 25 Feb
 2026 06:48:44 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 06:48:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: zoned: move btrfs_zoned_reserve_data_reloc_bg
 after kthread start
Thread-Topic: [PATCH] btrfs: zoned: move btrfs_zoned_reserve_data_reloc_bg
 after kthread start
Thread-Index: AQHcpYxIYpEUyvt5Rkee1TIPD1eIHrWR58QAgAEStAA=
Date: Wed, 25 Feb 2026 06:48:44 +0000
Message-ID: <098d71c2-ef87-40bd-bb97-c770c0e199f9@wdc.com>
References: <20260224125113.14831-1-johannes.thumshirn@wdc.com>
 <CAL3q7H5+v__wrqe3gj-E0PE_09-S7ZHERnFLO5LEPcjKwS1DJQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5+v__wrqe3gj-E0PE_09-S7ZHERnFLO5LEPcjKwS1DJQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH2PR04MB7095:EE_
x-ms-office365-filtering-correlation-id: 4e8f96fb-415a-4e69-4501-08de7439eb44
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVdHcHV6YzZvR1dtbENaNXVqMG15TnFOQjZMM1BrUU9Td1M3bTFwcThKLytq?=
 =?utf-8?B?NXdnakxmTVFkeVZFci9Sc1orTVVzdk5ydTRIV1EyYWNxWTNvYUtYd3llWi9B?=
 =?utf-8?B?VjFYN3JKUk9QdEI1WE1pcUlHVThSUnh4bzdmL2tBRUN5UzlpT1BvUGlyVGlE?=
 =?utf-8?B?bUE5alNDQjBEVjlOR2ZtbzcxalhiZ2ZnWUF3N21EQld4Z2twVklFTWJSU1hG?=
 =?utf-8?B?RnVTSFVYQUpJUGlKcXBIeXBhSzNZVzV0Vjk1TzJPZXpjTkZqb2thSFpKTDZV?=
 =?utf-8?B?ZWJNeld5K0hmYldlV0RhaVdVWXJpeWpUdnAzQUFVV0FUbjVhbExGR0JvL0kr?=
 =?utf-8?B?WE1sWnpoQVRQdng5YXdOQ0tQc2JiU3A0KzQwWEZ6RFJIYlNCT0FieWQxRW1o?=
 =?utf-8?B?SlRaTXpZS1o4YndlVk12VTY0bUFSN3dvNXo2QzgzNWN0OGwyTGhONUJnVlUw?=
 =?utf-8?B?cVlONVl1b1FibDFxSzh5cENJdW1aQ1VKdjNuSDVZUTJBM1Q2RUVxN0J4YXk3?=
 =?utf-8?B?Yy8zWmZaTW8xNDY1ek1zZ04rVStHVGIycGU5MHZ1bk1CUWN2dFNkaGpzRVI3?=
 =?utf-8?B?S25RKzZ5cEpKNkpMdmcvWDc2SEdObk13YjQrelo4OWFaSWdFNkR5RUplbEQr?=
 =?utf-8?B?U2hHK2lXNXBwWHNYeWlUSUdXMnFhejJXMWxlSGpLRzErMXNUQ0VKViszV1Fn?=
 =?utf-8?B?SFRvWjMwRHZsT2tMblhmMThreEVyVXQwb1oxMDNpeFVZb1ZvczNvaldtY3Nx?=
 =?utf-8?B?bThBRFN0b3g5VnVNaGhtekJlV3V5N0xIL3ljb2VvSEVFZmZKNkVVQjIxZlBj?=
 =?utf-8?B?NGxPZjhkb1NrdkFXdHpHcHVNcnAwNzFwS1V5NldBSTBRamhkVXhWdTlTNTJU?=
 =?utf-8?B?amNFRFgrV0xaMjllWEpYOFpSWW10eU00Vk0zTG5UUW1kRURyQkZpWjkvOEND?=
 =?utf-8?B?U2dQRTl4TE12OXFvWVhJS0VGandxZ0dOS2x3MDlVZHNqTmMzUzBVNGVscHVm?=
 =?utf-8?B?TGliOXhRa1p5RVlmdkNiM0tmaHJpV2FBSEhyT29XL05OSFkzaDZYVWEvTjNa?=
 =?utf-8?B?eEpaeTg1akdWYWx3cDR5cmZnU2hHZDhRYjBDN2h3bTNicEJwZldwUHR2Q1BQ?=
 =?utf-8?B?THJ2OFNTSnNOZkxSWWRlRlM4VXUzOVlXeHhIbWF0RnBqRk85c2FpYXNDTWJT?=
 =?utf-8?B?dnZMNXVmbDFtQlBhWEgwd3FqN2xPeWFZaE82RlN0S1FQL2xQWitJa2dCZkU3?=
 =?utf-8?B?Y1hXZzJqTXJDWWg0Qi81UTA2TjhCbXdCTFpoSVMwd2k0YU5KTkRQdjJONFZ2?=
 =?utf-8?B?aldXbk5rM0M4Mk5ZSUtKY3liSFBLaGY4ekVRNjQxZ1lsZzVFMEI1UUVvb3Rm?=
 =?utf-8?B?VjYzSWljcnBiQUNBc0lhVkllZ1RvTlZSY3MrSzFBbCsvZXIwRjBoQm90d1NN?=
 =?utf-8?B?SHVvMm8vUStnaW5LVUtjSENjY2lyeGE4VEY0ME1yK0l5UmZmZjR3RjVucnpW?=
 =?utf-8?B?NFZiRHUvcGpGS0p1QS90cWw3SDlicjd4QWYzMG0yeks0dVlFdWhXTnNBck5u?=
 =?utf-8?B?bWdCMmxEakJrZy9zU0pNWUtiRHJRcS81LzlrVW5MUmFwN3RNUFM1OW1nWU5h?=
 =?utf-8?B?U212UjJLSjRYelQwMlRPb0R5K3hyckV6YTU2QzhJcGdnQVJtMjRWT0FzYmR6?=
 =?utf-8?B?NFpLeGRYT0ltRG1kbmg2S3A0RjZNUUIwMTNWWkVWbk1JSHI5WkNSNmRLam03?=
 =?utf-8?B?Zi9vTjNzT2JQYTdES2hFTHB2SjJnUVBhblFQaExOb1Fxb2tTVkxQMk5vMW8v?=
 =?utf-8?B?V3FxUE5meXZxQnNvUktvUmNHQ1drbFR1QU5HbTNPMDhoSnpjWXBIbkhxOFc2?=
 =?utf-8?B?OUU0N3hhT0hUVTFsY093andjd09UV1lsYmpuVVMvaHBWYkw0ZXI2bUxpakxU?=
 =?utf-8?B?U3ZlSG5RT3IvQTJnK0hXZE15N29kZnhjU2JYR0M1dlJxbElQMXcvTzBvK0Zp?=
 =?utf-8?B?WXVWbTZVQ01SaGJSTnQyclc2bVBXQ3RLT1BMamtBWkI1MG16WGh2c1d4MjA0?=
 =?utf-8?B?MVpIWDllbzQ4NnRra2pyaE9UTHlUZ3pCZWZWdzRwWDcxVkhIRm5Sc1MvUnF0?=
 =?utf-8?B?dHhhVkVuZjNEZHVMNWIyTmpsZ1lmRkZuQVlKQXJzeFlZVzJhRDJycG9qaE91?=
 =?utf-8?Q?tqThA5tWja1wxu5VxDN/1ig=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTA5QkxzeVc3SkpoTWtON0pzUTRUN3lLd0Y0eDVsS2trS0hxUXlxajhBNG11?=
 =?utf-8?B?aFlYQzBwYWZXSGVBWjZvYVlwY25mRFFYL3JrQnJEN2pwZXJPZ0hBR25pUUhE?=
 =?utf-8?B?WkE2Z0NvWi8vZ2JXb21CV1J6eFg3ci9iN2wwSy9QVU95aHNRRE00RCt3Q29X?=
 =?utf-8?B?bVZiNGxFTzh1NkE4T1BmRm1Dc0hDSnJia0s4SzdaQlcwckRNc2hqSlR0bUt1?=
 =?utf-8?B?d014UGRxK0JWeGE5Ry83K1kwZU4xeEdYWEFaRG9hRTVRMVBLWldjTE1qTUt2?=
 =?utf-8?B?YUJWRGVaRUEzVjJRdzEwN0xhZDdSelY2UThKRERyN0JDMERwUzQwdkRRMC9U?=
 =?utf-8?B?c1BZVlpvS1o0UlhNeFdqOSt0T2V3UWVXWU1LR3pSbXlQdDg2MG9uN1FxTVYx?=
 =?utf-8?B?cXJnMHNQMTV6dy9sSTNUNG9kanJPZnpBVEVncTlTTUtpNVBqY0lhZmxDcDJr?=
 =?utf-8?B?TWczalpJU3ZTWi9Qc3JzeFpNY0hGSEIrZkdHejBmdmV5aDF2RVNhRmRGWlZG?=
 =?utf-8?B?VDNPdXN4YnFseXd6cXlWZGFpVGZTMUhobXNZMDlreWZjN1V6OEVDWnJpRDU1?=
 =?utf-8?B?akhnUElMOXlUSXRJK3RnNmVGL2huZEVEMzJoQUlQaWRJaVBadjNvLzNiNWZJ?=
 =?utf-8?B?VDJpTHF3Tmo3SEd4T1JKMGR4M0psdjYyOTd2V3I3S09yVmVlZUxGSFFKQ2pm?=
 =?utf-8?B?VVZKenRVdFRJWmsrbGxZRDNsZE9TbWRQaTNsZGJSMVJDYS9vdGt2bThXbUtn?=
 =?utf-8?B?SWNBalY3b3NpdGJsenFGNXVJTW5mL0lXV3N0V3VqOFdnbkFGUTNMRUdqVGtM?=
 =?utf-8?B?ZExmc0tZWlJ5V0tSTjZ1UXozcUo3WEN2aFJUY3lVMWMwc25sMDArSkN3SjBs?=
 =?utf-8?B?RzhXVkJlMmtQbm5jNGZhTElxQUFTY2NMKzdBTTZrUXhLNEZPSFdxUGE4VHZL?=
 =?utf-8?B?K2kvb1gzZWEraklIallVUFVVc0M1aE5zYjdFS3UwdUgwSk0rRTQxMmV5U2Fr?=
 =?utf-8?B?TUZPL2R1UjYyUDRDWTRoSWFSeCs4QW00aDdic2w0aGxWaHViQ2J6WmVGUnkz?=
 =?utf-8?B?SkRFQ2ZsSVZyWVJycnRmZVRPT3hTY1F1VnlzdG5EdEtGcXZQYmF6cHYrYjNr?=
 =?utf-8?B?aWR3OVNCb1Uxd01TWVBNemNRUGVZZ3VCY3RZcERTOEdsa3M0YmFXcW1UMjlT?=
 =?utf-8?B?VVM4bFNuMWQrWStuTWNiTEF6bzJuOGxZVzRpK3dpSW8waVBDbWNGWjVLNVZN?=
 =?utf-8?B?dmI4b2dhR3ZKd0dnQzhpZjgvN1Y1SjVtM0lyS05VV3JCUlo0NEVRZkZJaGl1?=
 =?utf-8?B?M1dNM1FtQXFmVVBCSjRLV3lCVDFEV3ZicVhHT2xKWC9MckZmUW9wc3BFMHp6?=
 =?utf-8?B?SHNDWWhzU05vZmIvUHVJT1N1QloySE92ckg4Nno5VnV4N2Fzc1ZsUndLSnY4?=
 =?utf-8?B?Nmh4UHh5QlJVWWtUcHRJSVo3emZCOTZpR0JubE05dmY3dzZKNXBRS2dJYVZi?=
 =?utf-8?B?cHk4UGxhbm9ZZnk1YlMzMmZZMU9yRDlqM3NmMVV0aUlqODBLOWY0aEFXUXNQ?=
 =?utf-8?B?L3JJM1lqSjRaSWhjeCtHdWtSUmNzcCtHaW5MTTVwZzlQYXB1WnRpQWN4djVV?=
 =?utf-8?B?dzVQMEhLNTdseVd0VSsrYzdXV0JNeDhiL21yRmxITzFuY056T0ROZlVseUY4?=
 =?utf-8?B?dnFpL2d6Y0x1eC9XNTZSM1RycGs3ZDV2amQzdVJCdEY0alRwRTYvZ3dFNTl4?=
 =?utf-8?B?RUVmazhwK2lDMUVqM0Ntamloc3l4dktmeCt3bG82ei96Zzd3a3YvRFdMYmNP?=
 =?utf-8?B?SExKU2hQa1VuNGhjY0JDL0k5aFRYOEdZY1NMZDM2c3NqQnNFckJ3dGZzRFBx?=
 =?utf-8?B?VGE5bEJqVWx3OVBTKzAyVzc2U216TXJadVZjenhnTUljSzhBN3NmSWN2b2RP?=
 =?utf-8?B?RDdFMnZwZmx4aHk4YVM2Wm5FejBXRmQxNlFhQjFOZFdGNW82ekZXVEV3OWFV?=
 =?utf-8?B?OC9CckJYLzJpOHMvWVQ5TGdTKy80RlpUMUNHRE1zd3NRT29yd2RKQUh3ZGx1?=
 =?utf-8?B?M2x5UDNSc2FoODVxMWp1ZmtLNW4rRjIzM3pYTFVORnhId1Qvd1JvQ0NNTnds?=
 =?utf-8?B?cVdDMENpTjk0clN0QlAweVkxbTR1ZGdOSGFRSENVT0ZORER5ZFZid28zMHZU?=
 =?utf-8?B?eWl6NGJDU2ZhbGtEaXVyKzdhNklXKy93YTV5aWhCNnJjZzIxekI4SGJFaGZU?=
 =?utf-8?B?Y3gvUUtObzJlVzBlQTRLcm1vT2ZBV2VSY2lMb3R2NnJsSUkxZW5YSTMrTzh3?=
 =?utf-8?B?a2N2WVd4ak5YL0JBbWM3MU5zS0Y3ZmJFelZyOWxxM0JpWjR2elBucWV1K3Qr?=
 =?utf-8?Q?aDGH7yR4FGfPfhSTCXqeV4CZ1RC2CFgc+ne51tLHqZtkx?=
x-ms-exchange-antispam-messagedata-1: 4LRH5Eoc6J9SPvG5+1SBCFVb02Diurre8zk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6F31A574BFDDB49A87BBC4DB2068EC1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JZ5rkRTJ/cKuecg99RCj02HpIgCQ35j2UBTRuKSWRAbkgzZE3bd+AfvsF2GRfGpaA9qq/27M+SBwD7zvWVSztaBWJP47YUjU6ukRmTZ3JDcltZs5WODedwJJMVAzCqrGoLbvk1VtUYL97BRHoArdT2hO7YImUFeXrAiBGrpXNZitli0XxGFS5P7jWwQREyNbxzZc0r4lsndgDOJcO9ThD4H3SdkpaXuqOFrJkGLn9bXGZythdn0lQIoYglMCB0nvy7VbIl9xQnDnDIeOTUESWvdMZ1FnkbVOkU5/qThBxv5hFNBpQ3+J8YipzInBhty/TthMRW1u60GFJ314bk6WbDngIbKJvJrQPDVpWT+I1o3rEsnxjienmrSY6Dm0RoBOHmtJ2DRXPVMsMTelOe9Iv6WydpbQCZ1OSOd8ZUFAq2/BFA1pA9210WiSWSwIrhh6xdGC8KeEroOmGgTIbh09tshk+Hc5ttzlCSHlIYjhyV5KGKBXfLTc4IigBUDKJQsgWTZSsSC1Yu8EJ0CGtFOchkaCMM1AFvGfEvl8p9FYmBITHaISfybqD8eLMDK22bEq35IsEbuOvuxmDPeWMzOq3PKvBls6o5yQuTtzmuAQh0V2XsGYgiZRXKMGYFfbA5qa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8f96fb-415a-4e69-4501-08de7439eb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:48:44.1797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eFZqI4IxbhT/8HMaferw1DsVfMQ9oiX/IitH0q0zzY0VASkhNPUNFfu4MJGs49GQsl6Hc0kwHEIvfgK5bqV+sCvRV5bP+rsXv/U9QmMNoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7095
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21906-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4165A1928B7
X-Rspamd-Action: no action

T24gMi8yNC8yNiAzOjI2IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBBZGRpbmcgYSBjb21t
ZW50IGFib3ZlIGxpa2U6ICAiU3RhcnRzIGEgdHJhbnNhY3Rpb24sIG11c3QgYmUgY2FsbGVkDQo+
IGFmdGVyIHRoZSB0cmFuc2FjdGlvbiBrdGhyZWFkIGlzIGluaXRpYWxpemVkLiINCj4gV291bGQg
aGVscCBwcmV2ZW50IHJlaW50cm9kdWNpbmcgdGhlIGJ1ZyBpZiB3ZSBnZXQgYSByZWZhY3Rvcmlu
ZyBpbg0KPiB0aGUgZnV0dXJlIHRoYXQgbW92ZXMgaXQgYXJvdW5kDQoNCkkndmUgYWRkZWQgdGhl
IGNvbW1lbnQgaW4gZm9yLW5leHQuDQoNClRoYW5rcw0KDQo=

