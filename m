Return-Path: <linux-btrfs+bounces-21584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGoKJzPqimk8OwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21584-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 09:20:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 314281182B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 09:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4758303C030
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21133CE91;
	Tue, 10 Feb 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NGcKsnJF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VZwGlg1Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852B21E08D
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711596; cv=fail; b=Z3jTvgPeCzwnkyVffCX3OBc4UMBRloFiQGVMMXX8ngHI+v7HUBN5UZ1Cgn5rGOlb1lexKh4VQFIKZrynJ49t8R1A1n2f7S6GepD1jO0RkRHLmKUICO/f9wywWpGEUBr3uTvo8GEoKSHZE41vPgd3WJd0PowamizWL4R+SgvSaW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711596; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bn1sVA4TfH7djUV7kjWAYhmLxplwQxdtuxJLxpq3DLbshgQhbp/H1270nHac9W39ig0iQsji6XhS/XjOS3GOVWJ7H1J4isrr66JUS9ztzluu0UG27D4r8u+GFYsbzZMrZLLIQVTt7yeVN645yxlw7wloFWYuxHnW3JsXkC3so74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NGcKsnJF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VZwGlg1Y; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770711595; x=1802247595;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=NGcKsnJF9+UCi7KAAnxnaQjO/V764FMHG9uK69yzRPf3tYn1Ox369hTi
   0qNrektA92+Xt7LMswUITpW/sctHux9gffNytrCnRaQxNdxLIPwbL6UjJ
   tanc1Mzy55+Y15oD4Y+cJJkcAgFzQ2565Kk6GZXCx4OsCMKKshkSm289i
   uNgE48Vf2s1YfJB63SeWLFXhVmkwsAETbhkjJsdnzLSzwYBVUZSjS8FUg
   7FjmSZkSUuB+1b2RBqv4kGIA03tdKcK57ieXb8zZcNQGtUFl+JRfU0kZf
   WzlVAThu8psMh11poj290L6StrLiJ1Cd67J5F2o1NROpa3DKsxGxIodaH
   Q==;
X-CSE-ConnectionGUID: 1kKXlMuLSlGBqfoYY5bqvg==
X-CSE-MsgGUID: hWAy0fpSQ0WbOGy0i4oXvQ==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="141051541"
Received: from mail-northcentralusazon11010051.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.51])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 16:19:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVAXI3lWyOXOD4wnA2NJyhYGu/Ap+wcDf75JIVwsTbO1JMiKi9JvYD3tNXYWDUl1hbhthMUtE3g6tzdYkwIoyE0VmfBPu/Wlu5W9bvK/CF7izAp+VbKVrEPDtynFLVgJlhycZbLQVeUMlWrSaHi/IN502w3bxgzqfiu0gLrTrQQm2JLky6YOj6ijNTcU0S2yZ4hJAJ8ECmtkgUSjXqfubERwdJTHCDBdnLS2rXPDNv/MhqDm271zWOyakIAAw+mtXAuKxrXtGtHnEId912us8w2bhWjxMICvTy9XRviY9GxsZycV7dn4he0pWfJNxjwjiD+TocTuiHR2PB2je9ncIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=GqpztWe20d4Nbxi8KpRGKIR7E0tpnF8cBRGxB1fYaXSuugn4cpIY4i/xrPPONWIfahSgc+tRpmshA83ZlJTzdea4pSiCdzzZOv4Qfm+1i7lLgdfTJ0nvD1Kgwxpv6BRQQ+YaSMXWGUVvU5lOV7UM57RWPmSQYV0Vr8m3KUcqQup0uUO0Bpil2q/jDN3fS6D4SkAioWQl9RUFxodrXXNUBOilq6M2iov7t+Q5ngtVGdkJIeOsVWfNytjjfbfK6TL1RiAdkVhxycA/Eb/02rvB/1HqtQ+mRt2H16O5ceI51AKkOYhrG/ftoTtL6rZDGx86LiY2oZZOlvLBClDlGllyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=VZwGlg1Ybv1lPSNVTJ5ZKAPrGFcX67kH0YS1HeQQct8hfYmeqnjAgKO2aCujy7gcLJV1RUwb6fGaNzi24NHt22WfXF0l1EzKfzDVG0/ZXhj72cZa1SBhm7yu7BDng4EbrsAgzkxKRSFbrcDoIMX1L1e+W9n0+XqUARTEUCTd9Hc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7568.namprd04.prod.outlook.com (2603:10b6:a03:32b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 08:19:52 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 08:19:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <mark@harmstone.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add remap tree definitions for print-tree
Thread-Topic: [PATCH] btrfs: add remap tree definitions for print-tree
Thread-Index: AQHcmfDkTyBJhDpsGEah7Sk9qDgYjbV7mCyA
Date: Tue, 10 Feb 2026 08:19:52 +0000
Message-ID: <fc56d76e-dd97-4dce-980d-8dd7d5f3f52e@wdc.com>
References: <20260209181043.27364-1-mark@harmstone.com>
In-Reply-To: <20260209181043.27364-1-mark@harmstone.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7568:EE_
x-ms-office365-filtering-correlation-id: 864ff796-7e23-44f5-353b-08de687d2a3a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTNtN1cwRUVJcGN5WkhjbVJlY1hMc29LTFl3YXdxN1dnOHB1Z0YwbkZSUmFX?=
 =?utf-8?B?L3hZclV3Um50RVlCTDBOVGx3cE1HYWtyVVFiZ3FGUHhWcjRSTThQUG9oTjV2?=
 =?utf-8?B?RmVmVjE0eStFTnAwK0VQd1RkQkUxdFV2ekt3OUpXQjBvcjd3WkIrNHo3OUdB?=
 =?utf-8?B?V0l1V2FRL0JadHFIRTI0UlhXT2Mva3Fyc2dZSDFOMTIxakhMWHNwV0VYeGE0?=
 =?utf-8?B?cXdVaWczYVg0VjZPRGp0QllTU3d2OEMvYWJkbHh1UXh6WlBWK1FXaW1ld1Zr?=
 =?utf-8?B?YzlLZFdNcTBZWWhwOEhhTGtxTVh2amtmakxMUEc4clB2cjI1YUM3a1ZaeUFZ?=
 =?utf-8?B?YzZ6WEF3SEhMeHhzQWJCdjAyNkNackdINHAzQloydEl6d21KMHpDVklmZXhW?=
 =?utf-8?B?aG1hK2hCWUUrOWRReXVyN1lTQXdCaUQyYjRNaHo4SmlpNWZnVnF3WnUyMnl4?=
 =?utf-8?B?K05idnN3SFNmTlhzR0xJQ1hyekNyYkhzV29SdGp2RkgxcnZNTUJoZm1NQ2F5?=
 =?utf-8?B?OTdFcE5GVDdIV2crVXB6cFk2QVFIdVVsL04yUy8xSHgyU1QwWEFleUp5SkNP?=
 =?utf-8?B?TDAzZmR0UnpIbUI5dE1QT2E4RmttUkc2N3NKQk10eU03QmFNelk1azNGYXQ4?=
 =?utf-8?B?ZDMrelJWQjhmVmZBVW9VRlMwZFFpb3NFWERTcHZDUnZXZXR5L3JUbmkvY2tx?=
 =?utf-8?B?ME9MQ3lOOGRkb2VvajM0Qm1DU3JaWTEwcEJmOGNwNjZub3R3QlhPR29jSU5W?=
 =?utf-8?B?YzNyYlJUTkZIV0kydCsySzFQQ0N2U29TZjh1eTkzMHVpcGRPY2p4NWRVeldD?=
 =?utf-8?B?RVk3Q1V1dTY0djhRUHUzODk4N1UrNEVvM1R5MmppNkZuYzA0NzlRVzVTYzdz?=
 =?utf-8?B?bVVTczMrWDMxMTl3dGhLVytiR2kzMFk2M3NERGl6R2VmN0dXOUljc2NPandQ?=
 =?utf-8?B?VXVpV0lBYnQ4WWZhNDZ0M3drRHZ5RTZkYkRvV2dWLzZmQzVCYTB0Ync1bFEw?=
 =?utf-8?B?K3haUDIvc1ljYXpwd1g1WkUrT0VDaDN6WDRaSExhUTE3WmhGQ3F0UEZNd0Zn?=
 =?utf-8?B?TnY2anRKaWg0Nk1XUXJPQ29iNHJkS29NR1lhc3k3YWlRRkllQ0ZWRzZ5MVg3?=
 =?utf-8?B?R1k1bWNDTUdLUnVDV0IxTnBJRnAxZm9OSkRWZGdiYmw2NzJxQVU5K25sdlRD?=
 =?utf-8?B?TXl2N3B5ejMrQThFNVptZGJibitZcmJac3JYaFdwY04rM08wNGFNeUhua1Fz?=
 =?utf-8?B?bXFsdkdlZC83S2hPNUlNaE1MWlRKWTh1V25TL2JTazV5US9JeDdnK2IxczJJ?=
 =?utf-8?B?Z1MvdWVuM015Z1dYRk5JNTJmbTdwQjFqTDNtbjlhbkkwKzYyMDFYY1JIeVJi?=
 =?utf-8?B?QTE5NFBCcUJFR1d3K0cxSDF6SnFFMUtsTzZlT3gveWx0eTJSLysrdXk4NG5s?=
 =?utf-8?B?RHcrd0VpVkljRVFHcElYR1Q4M3BWUGI5akorSVBZVndvRVhuR3R0NjF4RUty?=
 =?utf-8?B?UDBvaEtWY2FvL2M1Mi80WHlTMVhrOHJzaVZZNWZRWDVOcjFBczFZZ2Nzb0Vm?=
 =?utf-8?B?bmRBVVA1NCtEWkNZVFlRWW1RQ2VodVJOR0k0bVFJUS9VeStZaGc2bHJUejl6?=
 =?utf-8?B?R1FaZDRuTGlsNGJIOHVpQmtqTVdQalNTQmpLZzYrdCtFVnBxTDRhanRTUUM1?=
 =?utf-8?B?N2FQSTlEUkUzQ1NMalhqdkRkQmVDZ3VKdXlCNHpzRVhLR0h3d1ZIYUxxNWMw?=
 =?utf-8?B?RXVyNjlKdFA0clRtTHlXd0hVc0hkOVp5TDVjK3ZaVEd1SVVETUt2NE9rcG84?=
 =?utf-8?B?QTRNNGFzMVlOZTVtU1ZkY1JuUm5odE1VZlVkMHBCUjMvTXlJSksra0Q5Mi9k?=
 =?utf-8?B?UE5veGkzVGYyTGRMeGNWNnVmYXBMYWtmQ0YzYXdjTFVBa1Q1K0Foa0FHNXJm?=
 =?utf-8?B?ZzQ5UW5lTndLdkE1Q0o4T0x2ZVhnVTJNcFppOThsME1xUTZDUC9wRlc2YTZG?=
 =?utf-8?B?TU9QWE9BVElTcDFXWmVEQ1dCSE5MK1NEM3prcmhqYUVFaVhMQTYxaDdwWm5k?=
 =?utf-8?B?c0JIRjJWRzl5T0EwdE9xV1hUdXordDQrVEhYKzNRN2o1dTZ1Zm90UUhoTU14?=
 =?utf-8?B?NnFJeDFwZkVQWTNuWTBnaDQ0M09iYm8wUWNxTzk2N0cybjZRenJoSUpDRmY1?=
 =?utf-8?Q?ZiUOmOXMhWoSw9E9eiFVSh4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGExZ2pMbzAzTEJyMTAwTlBiTUpyNWZjb3FjSEw5YlFDK2NGQXpiZW1sS2VR?=
 =?utf-8?B?WmpuS0tuazBhK3BPK0NBKzIwenlGcGJnN2RnSURGczdHWHkxMzRPZUFQeXV1?=
 =?utf-8?B?eDV4R1BDdGl5a2xMcG02R1NLcTkySDRERmk0NW10OCs1azlXL29idTRuai9Y?=
 =?utf-8?B?SUZ2OStPdHllbHpwUE8zenVSQTBPckRmUkFVWEYrdDhEaE0zQVQ5RkVDOFVF?=
 =?utf-8?B?dDRzODRKU2FKSWdUZ2ljWTBRRXJVSFlSY3N4ZDQvK0dHRFBhN2dXRFdNUTRD?=
 =?utf-8?B?ZEJJT0FzTW9HdFFuWFdJNjVnVEZFdlBRa2ZiVTM5VmU0UUZaTElua3RpWVVt?=
 =?utf-8?B?QVV6Umx6dU5qWkVxRDhiQTlWclF2UWd3SjBuVlYzYisrNXRseFJpajdoaDQy?=
 =?utf-8?B?ckR3ZDR5TWdMWHBOVXRFY2k5OGhXYTRLa0Fsd1RRV0NxWTVIVDBKVHplQld1?=
 =?utf-8?B?TG9EMnM2TzJmZ29nVStLVGVEeU5uNllYVk51NTFrWUFIaUNIaDlXL0x3bUNU?=
 =?utf-8?B?eEdEMUdIdm5TREEzL0JQMWlYVHNRYnc4NVdIbCtwbVdHWjlxZVNleGYzZS9h?=
 =?utf-8?B?S09yOWUxSWw4cmcxT085c0h0dXl4cXJocnRCQXVxRzNuNVBWUC9qVjUySTVQ?=
 =?utf-8?B?ZFFHcW9iV3ZGNklGakd5UWd5ZEJ4YWIzR3V2ak04Mlh2VFRUQXI4YlYvR1Rr?=
 =?utf-8?B?SWpMK3luMmRRZUVKNFRMc3d5dWVqZk91SUg5Q09rMkpjaVVaa21IeGVMOWtQ?=
 =?utf-8?B?eVl5ajh2VHJ6Nm01VHk5elcwcVhjTWZHT0E5cDdiUVNOT21US0RDWmRqelNO?=
 =?utf-8?B?OHd2OVZWQ0ZCUzdFM1JaQkhWeXB0WHA3MlNpYXpwNmxiOXNQc25zc2ZvKy9Y?=
 =?utf-8?B?UUp3aWhmY3NHME10QXEvaUpWQVE1U2RGdFJJY0wyNXhoRHNIWjhmai9tNExq?=
 =?utf-8?B?cTNBMTh3cUwvY2tFK1F0KzY5aGlZNXMxekhTQlVoSmJmTjRLNi9tMDlXN0M1?=
 =?utf-8?B?c2NpN0F6bC9hZlluZnBVeXhuSkR6a3pqQU1WMWNJenB0RjE2TnBrOXBnT1Fv?=
 =?utf-8?B?YWtoWFdQMVhOSGRsVFVqQWQyOUhKWUU2V0l5WDBuMzdVamJKK2lrQ1d2aURW?=
 =?utf-8?B?blJPVTNSVUQrRjFHeURyRktUbjFLaEt2enl1ZVd4M1AwcEh4VlZ3dFNNNU4y?=
 =?utf-8?B?ZmhqQkt1UGhtV1Q3UHB2R0Y0OCtrZ2VxRWZEYURTTzFLUmFhbXJDa3lpZzZ4?=
 =?utf-8?B?TWJDRlZZUTdHd0tnRzc1aWlOL1RQeW5sMGxGWUpDRWJib2w5d0Q5VFlnVHJL?=
 =?utf-8?B?TTBUbUYzbmVHdUlucVZHRXlScVRCMEJqeVpIejVHbXVtMGlETHJJSWNmb1NX?=
 =?utf-8?B?UUpGSFhIZlkwSTBKWkhQTUJ1bG5nbUpldTZoM3V0QVQ0U3ZTTDRKakQ2UVhT?=
 =?utf-8?B?VkdXczJIeHVQaVp0bmQwWXlMUE1WSnRpRk1zS1dnTTZTaGRkbzRIU2hjRjRj?=
 =?utf-8?B?MUJNd2tualBodE9Qb2VFN3JGOEQ4OExMT05vMVBtUjJDenVyaW54elJENWlU?=
 =?utf-8?B?TFFCYTkrTTBXZGVCV0RFQzhWT0lZK2V5ZURRL2RSNHFCb2tSNUJaNDd3Rk5j?=
 =?utf-8?B?UTFkek1HRnJuZngrcDAyOVczOWZ2NWFRN1BKQk1RdjRLU1JUZnBrUXhZS2M3?=
 =?utf-8?B?bWxMUlVXWTJicHlaaS9JL1FXUkFEbU1INHNKQXNyQzhKN21WUXJ6YWY3cFFE?=
 =?utf-8?B?bXdJaW1CSTRVZGNET3ZtTlFJWVlOcWtrMHJYRUo1cStBOWFRSGxCcXJKSXhM?=
 =?utf-8?B?WnRxTzhWUHcxMzVVRzJZMFZMaTE4d1NGMmRiU1NSTUJEQ0kvQjJ6Yy9LM1hs?=
 =?utf-8?B?ci85aGJ0QWF2dkE1ZjB4SFBWbVYranV5cTcwT1BxZUQrMis1VUNwNlhyUzZ5?=
 =?utf-8?B?N2ZLTHNLZHhsby9tc3VldSt0TVNpaGVsamx3dFl2VE5hVHIrbFFwSDNZZHky?=
 =?utf-8?B?L2o5NmZ6TFlUbnFjQld0ZFhkUGVlVWN3WTEzT3BGR3JtQmhUWDNyZ1FHMFdI?=
 =?utf-8?B?OXJLY3k2MFZjNE93c0pwcEhXYzhvWHdOSXlZK24rNmtZQkVxUHJYWHBnamsz?=
 =?utf-8?B?eDR1WG5OTGNiK1RYTFhaMGVyR3VwV3NmU2NmMm00akRNamhycVV5UnUzdDV2?=
 =?utf-8?B?MmF2dGhLazVPTnBnc0RZaHBTR2d3Q2xtMURnMlpjaWNMemsvbTN3WXEyR3g0?=
 =?utf-8?B?ZW1lRCtMVnhhTTlZckM5VUphYitoaHR6L1hMUkZ5eWQ4WGRvYVBrcUFMTi9S?=
 =?utf-8?B?djhjTXlZWm9vU3NqSTVuaG5tSktGNjRMRVY5WHo1R1QvYW41dlJvK2syM3pH?=
 =?utf-8?Q?6cyK5VCTz2MPOJ90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <783CEFADB74F7C4BA4012858588E9364@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xgamvRCXwFLRbAKbWsVz5UL/3qvliUf0l6/+O0V3Fgn/zfF6kB2UkPvtOKTo7BvD1NBtn/M+fX5oizAOPfGMVJ10gIyGaI5XoD227b0+Vjy9EXaOgfBnNw4hQ4CbHmGweutb438dE0khzwHcl2eRxWwcUaiOdu74C1z9ys8+bECOtk1McmLJQkp1KbFm6BP69ZlTl6zNYyUs+QkWN6qxXN9NdsHrd1knfVfbWS8+J9jfsNmeKP3ArrVmn3KMiFidynvA8to/jIIxbDH0WIbDAZRz4TASt5/IxhKjlug0fS6XYWTFQW7wrNOIUBagQsSzzqEBGJXXvalxV+ctOBVi5D3gkbpGOUDoZxVe0vtJGeRTsJ8+r3hBvJSLcxqPJC06x3WtJEpPfT4d56SsRUG4ZKM5qQd9KqFpm3NeKV43zK/dFr1OPUQ1pwa7boOG/FQPKCRtqQo0MkBOZ77OLm+JP8o7Z+PRg+0w7KtImrEcLAM+tY2X3BUyr9LOy/mkMtvHHiFbZKDlyRJAyYGGFT1QYcsyWy7NfSe+DGfmTqKk2ZltmLZ9DHKqkMU0WJ5Q/Re+YKGel3bNl4wKlCC5p633aSYeAbX82uU1wwlEO6/lY0mdZUYNjSzYT57vyASdhLA9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864ff796-7e23-44f5-353b-08de687d2a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 08:19:52.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ezv13U4RC0kodFg2ZZI3me2SywalGDn+HIFH7QfuGnb/nkthEOyjoJvp4iPWsUMMtQSKH7mGWx4H0hIlW9SLb9bULD8wVu1N0Yrl7p5uTnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7568
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21584-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 314281182B1
X-Rspamd-Action: no action

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

