Return-Path: <linux-btrfs+bounces-19070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3BC63AC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80031355DE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D030F933;
	Mon, 17 Nov 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YFDkyYYY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KmKdpP3O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366930EF84
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377164; cv=fail; b=dkcC45JzaxUn5L1TOMnLN/+vRnGeHzUOfU+lyidbeBPDxRkmWfge7Iy6HW5SmfjgkmUM5sWxjC9pC/zsiNddNsy55euXRzMFL/b4b8jKcvzJo1MDgT8E67TNk6Btcd+9s2la4jZzI+P4W92buwi3ZG+hSK6N3oyb9hwGL+eeFNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377164; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLZOWcWI6tsU+8CBTX/68/UtQ5dAofrSwBq6RJf4Dk9D3wufXS9r8g7nDgulw2T5xD9/UdbU3K2qQOMgM/G6mtLVl+1xXN5vIelTaOWiwXR+720VzV7mCf+sJ2Oj8t+oKnkSIDhdznBSrWlsSumnnVZTee6CjhDlbNvmjvOvIjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YFDkyYYY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KmKdpP3O; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763377162; x=1794913162;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=YFDkyYYYItMFPkoEMSxILRHojMPLiCzAM0XDRVuFREuMNys1MWekl6vh
   KGCfWkdtJMuQs/R6F0j/Yk6CHI9jHPz7xZcN8zWs6m0gpPXVDHJLr6Qad
   Adj6kiApfojNQrm261SGlrkwU12y6eU/tgsk72GB82uh9/fB05GesZCbA
   bknco8ipqWICYFiV0bTbrPyAbYU4MS3F7xMONu10iO6/ejSoJ323cvo3l
   TqYBrLK5ieOEK/4+VnFxbWSo2aZBLUvVrm7WfzzHSS1QCeU462tvWXLQj
   4CFoZg2fvXXavYjkCQ7rFsUmycZHWBfOjCD+hLt/3hAnLbXu943ELZjnv
   A==;
X-CSE-ConnectionGUID: 0PL4Syq+ShqnsqcmgKOrjg==
X-CSE-MsgGUID: p1XTs9/bR62wncgaiElc1w==
X-IronPort-AV: E=Sophos;i="6.19,311,1754928000"; 
   d="scan'208";a="134874346"
Received: from mail-southcentralusazon11011042.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.42])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 18:59:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvNnWkuEHKYJuhx9cieqM5i93YNtFZcsKfv1T5PCelItV7PtbSAEnF8PYc499/uf6OmvLVDdaLSiwykaaJGoZ23fMmd2nC70sEDxlUeYmWwY1Kax4BxOT5f7WE7OkSmKbhbq4eEL8Qtvzge8vTjV7QIPm/T+ywEejR6JrkoiqONW2+LkM6Jm6vxyEfy9Nwh49NYzz5rW4bu9a5jcF7Oq6mzw1MpAp8BMAB2m27mbCy8SaQNTLLq1p/9i+dlzpjq0BaRtsfhjCqzqNUYqIgSt7Nh3B/pBHAf7NzTfoKwrk5kLdzxArKnqnAsF2b5SgodN1EfPB+gKv3QnSk2rWhvuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=MLQEgEQq7de6Tdcp5ao+LGAQR8DIktfTA+LUpAMy5HiZY6XD7gGS6aKTgR3nZyPaDLGQFyyph+f4wyERV8SPeS0HTx5+trT3rLevnjwEU9epAlQ1gFGKrb+si2ZYnxJWxqovLcGW+fqNS9KkQ4F3mrbP6KPZMNg/tEu3uE2c+gsrvWxYwYDYFnyju85ktmMoLLBwQY8C18Z0nmUeVffv2MABSltvfqiW8mdOSUI46nvxjaY26veMwz1rLuSl7sdEfw7a+rJ1ATeJWYQ4az9L3l68gBzNsbJIhdN5IbmHTMDrzEqWb0+vicyyWJdqKZeIiJyUAO7rUzV8jNU8Uz5LWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=KmKdpP3OP/o46uxf+BQsxtsKnb//Xa2b1hWkLuusgaK1PcMDzGER1O/MNVn91XZRVnDqeU9qOXDLMtllwivSdWZ5DMbZzvojoHG1IYBDMFxACYKIgSy0t849g9GsrJx0tuSUrk6bSvQ5ZjwY2MhdHV+FsCJR57haZfdn7qTawOQ=
Received: from MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19)
 by PH8PR04MB8638.namprd04.prod.outlook.com (2603:10b6:510:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 10:59:18 +0000
Received: from MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::30e0:2f81:e3cf:78d9]) by MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::30e0:2f81:e3cf:78d9%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:59:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use bool type for btrfs_path members used as
 booleans
Thread-Topic: [PATCH] btrfs: use bool type for btrfs_path members used as
 booleans
Thread-Index: AQHcVYLq21YZLmwMIkSCA+mcEud0arT2t2mA
Date: Mon, 17 Nov 2025 10:59:17 +0000
Message-ID: <4369fae3-2c47-491b-b80e-41b64d7f7d98@wdc.com>
References:
 <3a03fb6e8f1d35902220f7e8b7b3d0167f6f1bb2.1763136628.git.fdmanana@suse.com>
In-Reply-To:
 <3a03fb6e8f1d35902220f7e8b7b3d0167f6f1bb2.1763136628.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR04MB7411:EE_|PH8PR04MB8638:EE_
x-ms-office365-filtering-correlation-id: e957ab58-10fe-43ae-0fc1-08de25c85abe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1E2MGJiTjFnZXdVd1VwNnBZWlJLSU1OTVNpZENMZmU1VDJtdlM3b3FOVms2?=
 =?utf-8?B?TFZtWC9hYmpNQjhCaEp0TFhZbVhjQ1lHVTQ5ZDlpbkp4TXIrS3prQzVsaEpX?=
 =?utf-8?B?aVNhU1VIbTlGaEVHVGF5NnozYnFUUVF5cTlXTmNLZHY3RHJiSXBIMEVWaG9R?=
 =?utf-8?B?MFVteW9EZFhqc0c1bDVCN1lGVndVOTBIRUpRd1M0QVpMYXZQblBIdUFLcXdK?=
 =?utf-8?B?QlhQcXhkN2dGZkpIRU5seGJ5YkRSbjRVMXVFTXpPeGk5cXBUYVduMEZOQ0d4?=
 =?utf-8?B?cTZucjZidlMvbTZNTVFlMUQ2ZTJSNjh2ZHE4ZzYyRzBsSCtpUnFjUnB4U3Ru?=
 =?utf-8?B?TCtSVy8yOW5HS3NYK1Rkc3Z2Nzk0QnlUMjlVOGRyMGp3REUyUFNsMjhSTzdn?=
 =?utf-8?B?dlZhc2RvdVhhWU92S1lCb29COXhJbmhhc2JNeDRnaG5YdldMbnp4aEpIUngz?=
 =?utf-8?B?S3pmWHFrQVRtUnE1ZGtkS2dpMHMvUXRzZHRub3hxbXI3bml0bjNjT0hKczVu?=
 =?utf-8?B?aXdKTDFabytVZ3BaZkEvUUY4Wmg5ZVN3WWZsTTZHVGFuM3d5aENlYTRxYXVS?=
 =?utf-8?B?c050bEsxUGZvTU5COFJyNnh2S2hkQVpHYnAzNFlGeTVySFR3VG5uOGpJdjRK?=
 =?utf-8?B?RkttS3duYUd2MzNQRUEvZTdpdFV0RWV0NlZtanNIN2JqWTZxQlgwVkFjY21V?=
 =?utf-8?B?OXNaNGZqM0U3UlZtTk9rNVBZL253Z1V1dE1Sb1d4YlZSMXJCY1owQmRLSnB1?=
 =?utf-8?B?SXJqM3kvaEJqQ3cvK3d0QVh4VlpkNEFnaWMrWVZOb2hPaHFYME9sTmhyQVRD?=
 =?utf-8?B?STkrL0t2STJSaERqNzlsRGlEQzdlZEpmK2Npc3VwZ1A1ZzN4dU1yeXd6V3Ba?=
 =?utf-8?B?Zk1ucVhoR1lUdmFOVWFNUDZ0WVhIY29pWXhKOHpLYjAybGZOeHp1RkRkdHhX?=
 =?utf-8?B?SWZDZ05yLy85Qmo5bmM2SWJrYzRKUE0xM3U1U2NFNkhRT1k1c0dTZVNaTndL?=
 =?utf-8?B?ZUJnTUY4ZjlDd1J3b3RMMDJyS0g1N2JReVlIRDRCdUdPTmNLbjF2RGNGU1lX?=
 =?utf-8?B?SjhFbkJKeC9WSCtZL09NZVFQdWE0UzZCS0tNekpCNmxBOFZxY1l4b0NmUlVq?=
 =?utf-8?B?K1A3OVI1VDJLajFtYllGMlBLWStlMUdMeTVBNVJqRWU4N1JzOU1mS1RNcElt?=
 =?utf-8?B?QnFYL2NtVW4zaVp0Y2FqaGxBN1FBR0VqZkhFMWZuQUZjb2djVitpTm92TGVk?=
 =?utf-8?B?MUJiZ042S2c0eVVoSFdyT2Y3RG51RWdDamJ1Wi9MdWlwb2FZaVFsUVRxbloy?=
 =?utf-8?B?MTVHbitnOWVQa1FSV084S09SSlg0SkNmZ05DazRnNy9UTUlTY3JnQWtQYlpR?=
 =?utf-8?B?K0V4NU5ScGg0Si9TakNWaDk2Vm9MZm9iZVhoQmJmTE9yTmZLTzJHV0JTTE5q?=
 =?utf-8?B?SDlhY2dLcUJybFNOaVcyNWZGd3AzTXdmYmF3YXlOQld2OTU4UU1aS1d5SUV3?=
 =?utf-8?B?VzhIL1FRcmJLOEl4TVZNY3N1UFRXM25OM2V1bGVBTHBJaXVRSFdnVlFGNmdo?=
 =?utf-8?B?eHRlNEh6R2ZPUlRJYTkwc2RUTm9XQ3JOSXNxbmtjSHBRRnJYSnNIQVg5RDVD?=
 =?utf-8?B?TTduNGwycUowN0JkRDU0RjZhaHJtVXVqME9sb24vZ2JZeGNOd3BCRVJzVG5Z?=
 =?utf-8?B?YkJKaXBjcHpmMmxRbExzeFhtbEhQd3RSWGd2MHI3TUpweXptL3cyc1BQOUVW?=
 =?utf-8?B?ZTZEbVVwUkpIcXpjUDhiVGNwaHR3QmIxa0M1QkI4eGZkSFM4ZEY0UmJ2U3FD?=
 =?utf-8?B?aE5KN0I4RGdrL0RrVnQrUEJzMFRDQlBtNnpKK2pCSkFySks2L2tDN3FHQWRh?=
 =?utf-8?B?bVJacXNNdGRwK1JBeVdxQXgvTWpmbGhEYVZiR055QnVHRFh4OGFxWGdtNHh5?=
 =?utf-8?B?M1BJbDZ5Z1BoL3J0bmRuRDdiQ2RPMHRoUjJZYnljTUc0bnpRb0k3dGx4VmhH?=
 =?utf-8?B?RFJ0dlEzTC9ZRXRYUVVTb1FUZk1pREdyT2ZBSDdKU3J4eVpMQVJEU0JobnJN?=
 =?utf-8?Q?FsUiA5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR04MB7411.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHdVbGJtTVVIejNUbTdpVzN0MXU1cENxcFBwOGd4NWFzZGtCTUMzNTczMEFX?=
 =?utf-8?B?OG9QTmRXYXBrSU5udUNuT2FoUnozY2VqZTh1aERESG1PYzZpMy8yNEJKSWRZ?=
 =?utf-8?B?aUxLVE5yUjFDa21BM0ZNbHp2SlpNaktOSGl3ZzRxbFZWeW5BWDZJaDBMdmNM?=
 =?utf-8?B?WldXU2RjZWhqbGtsVUJFY21kOWg5MFBSMUM4MFZWRm03b1lzVGNhTnpoOHpy?=
 =?utf-8?B?V2QxbFAzR3lmZm53aExpWENxVWh2cWpTd3dUdStzZEQrK1VZWGwyOUtXNGkr?=
 =?utf-8?B?NGNlUjQva1ZsWlVQTTQvK1dSekRQUTBRb2daQytSSWJSc3BxVHNGK3A1NkN1?=
 =?utf-8?B?dndnSGthTWdFeE1hRDU1ZTZNUXNtSUNMbEtPSGpab1V4c0gvT1JUcUpzVXVN?=
 =?utf-8?B?ckV3SFc5M1lPRDMxOFZIQU10dit2RGtoaTJSSE01TDlCVnJyM3MvcXFoeTM0?=
 =?utf-8?B?TmthMFcrTXVySk1FbUswU1FWU1ZFMkljbWU0WnhjU0hDK1VRUVJuZmRsMlk2?=
 =?utf-8?B?V0FSYW5MOVFvT3ZFeXRzMlplUW4wQllaYUVtZGVpeWhOSEVjcnVkUGpYcFNT?=
 =?utf-8?B?UjErV2lZdDZpMnBGbDlyN21ZWXpJWXA2Ti9vYTZkdWF6Q1FyR0JtMEJEUWVs?=
 =?utf-8?B?S3FpMEFacVAwbmcyY2NDbUpYUklpZ1lpNFJOSGhSQU9tdnZ5ajhURGg0eDl4?=
 =?utf-8?B?YVFzb3pVWnBWdFFSUlFGUDM5dmRCWDZMOHNMbVdIQjRMcCt0SjNBRnhoVitw?=
 =?utf-8?B?NnpmV3lMbWtCbVd0byt5ejZ0cWlLcUZTUWJCb21LTFZVRlZpaHVYMXVPOHlt?=
 =?utf-8?B?bEc4OFF3dDFkOTN4ZDJlQ1hrQ1R0aSt2aTlEOGVLNGdOTy9yM1Y0Y2Y2NUVW?=
 =?utf-8?B?WHJ3UHBVSGlBWFhjenpuaFZSYmJSMjdvSHE0RlRnZ2M2VjVUdUV2RkpOdlR3?=
 =?utf-8?B?T29IM3JmSFRaeUtWdER1dkhsWlhQelJnRjR1aFlncXhPVjNqdGtRU3dpZnU2?=
 =?utf-8?B?YXNlSEFQb0hCYStrSFFTbEtRQmNhVWlSTzNWbFhQNmg2MDI3b3pjNjNZdUsy?=
 =?utf-8?B?SWQ5N0tCZU1QdjIxbTdwMUU0bkMyeEZ2VWlEbWp6R1h4ekpkUkNndmh0NE9m?=
 =?utf-8?B?c1lTQWdMcnR6UU5nZmUwcGI3ckxldlkwR2t1bHlCaGlYZG9pcXExSStWUDR5?=
 =?utf-8?B?dGFaamJaQW5qSFBMZUhEb0hqR2RtL2dmcmZlZGNXMTV1TEZuMjZ6ZitCMXEw?=
 =?utf-8?B?WmYzRVdxNklwQTFhUytuZ1o3alY3RnNmOUhuK3U5d2RNeWtlV2VQNW5aNldm?=
 =?utf-8?B?S2xMdHB1ejR0aFJES1FDdXZuWnhpTWtjQmdod1FYSkgwRjNURTdidlU5RFZI?=
 =?utf-8?B?U0tvZU1wMytxZ1ViTkZEb3ZPbmdkbzQ0QVNRRWtBOWZObjFBbDVtejB0ajdG?=
 =?utf-8?B?STdpaS91NmlEWmVFRWNBdStJZnF3djZrSmxPLy9yZnd2NnVhVkxGZ3YxLzVh?=
 =?utf-8?B?Tkd1OWsyY0FmT2dBUk1jN0lzbHYxUzg4ZldYdFRNTC9SSHgyUVZ0NERmMmlr?=
 =?utf-8?B?WTYrNnpaZndjdlRFQkFsSllWRFB6MzZZWmJ0SUxXbW12VkdRS0RBUFprbERp?=
 =?utf-8?B?WVVNT3dEckhSV0ZuckNGOE9pb3JWVWVhaUluTStOTDUzbFo2c2VMTFNMdmg3?=
 =?utf-8?B?VysyaWFUYzFuT29xU2FwUDFCVnZkZ0Jab0pEMXU3eEgvVkZ4a1d3akNLUHJO?=
 =?utf-8?B?SmhPMHZFREhvUUZLTit3d3hDdEMzY3dudStNMDA1V2hyd1NpbGNEclB4d2ZD?=
 =?utf-8?B?ZzB4ekpFWlJvcXB3dTIyYktDOExwdnFTR1Y1Y2pVNEc2TE9rYnFidCtTaHB4?=
 =?utf-8?B?QmorU3JHMVZEUDRtbG53WEV3dU5JUlZ5MmZ2VWNwVzBEQkxPZXl2V3FvWTJK?=
 =?utf-8?B?ZVhaNkZJU1p2TksreENteTc1UXoxbXpjSUJSaktWZ3hkUTFsanp5VDdJdlJJ?=
 =?utf-8?B?dUJnd0R4R2dyVklhTjlBNDMxYnJjZklTL0VqNXNMWnVVbCs3azZwTDB4K0xw?=
 =?utf-8?B?Tmx5VzN6TkpNTHNKRUloL3dpVy92K21Ma1BzMlp5RFRTeDRYYXpsa3Jidzly?=
 =?utf-8?B?dnMyNGtOQjJ5NVR3UFJvQ1hQMjA4a3c5ckFZSDNBdnBJVHNEdDFoMWtVelY3?=
 =?utf-8?B?N2U0TmxISGZxYitrS1IvdmdxdjNMbnhKVVBMYlFOdnpRVDVWV1ViUWFCL2d1?=
 =?utf-8?B?c3cxeW56RUh1N3A0SzhaNmtLdS9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <601D5698211692418D4A8B57213D444D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	98Mm0ViAGK5BCc8Q40fGqApBj7ll9om6/v6HOXlcjeEtQznApmUWcOft7Ip9u5Nze8cpHtCD+G5PJqbjKl/e2JDOYl8y1sCl1k5xOl0E48ov/JXG6NTw8E1bYHUkU1iEunQvJNU4avjTXQiZxLwrKGrxEm6x3ZKh7xN+p8OUrJhlvDk3oclr1OdPyYzZsLkfRfFANKSjqGODXdpOvCCvzRHgWjwV0TjbDXWnnWj68wHSKndTg9D4zwnABL/9ClDtTtLTaJUlBVBw6OIksYhUAW5dWGEp0Nmmn9htkSM+BSaKMjKwbyjMNfnJrrbJK18faGkvLAG9rO2+Ra49fbqhtXD3dIPJBVpWwMCGhrcql3yHN+CoabsriiBF/Qr95vyQs+2HyJaUIganUXwSyNnmCc29j6OKa9NhooLUyY+x4Xp/0sKAmNJXovBXbvVnXnExLNuBpV9JN0IWs3l8eYbTQ7ApY9rHiDNTqixSaBDVn/wzPaJQgn/vbTI6I/YbA0fXmZB61KYradJkgfuPbZPaBIncyOcc0yh7hpLDTIXQhOu8Gl5DCj9Pd6XjSHFVH6wMQeDrPOsLxqm5H2DmJBjro0m8uNB2bGKzMC8VGthvpuipMStI58IbjUa1/Ozz/JY2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR04MB7411.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e957ab58-10fe-43ae-0fc1-08de25c85abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 10:59:17.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs6QKlBuX+Q35ID2uaaMC2Kn7tHa5mqUKswAUKvzY7pr15jiiaeizEdatX5APk9XgEfCaoDR8etHOklTAfsYbi/RnCnDMdhZq32pu+VlvG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8638

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

