Return-Path: <linux-btrfs+bounces-18434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA10C233BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 05:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3261A407B2F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4D129ACD7;
	Fri, 31 Oct 2025 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XK207NX+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wO/s0JgY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9681F5842
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883523; cv=fail; b=apbUk0yGMBkzeF9R5AU5KD0M6uSB7xwopq0kMz8BcC+JzpHSohAD5bimTugXqqUImwCzGG4TjpZn5fThyzqDcx4H3EZue95a4LXlYXRNffpn5cW1R9MeyrtMApe4rFE3xmNl1cHUpwpPcCMje200NRD8mlQ37Igr0GME7jrexJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883523; c=relaxed/simple;
	bh=fya8AMM54WnijATbKwsCABBa84Ikf4DsTTw9vWi5XZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgwqrKx6yMjI6e8hKGuGtvsPBHVZYcj2b+R1zpGthJPqebnzsrodvWNXtnR4aISzc5jVTHhuheMAbdDyVk2SANDuW6DGq6AAthlXcWY0tNXzGIU9ohj68Xxe/DMavKa1ziuakkuIi0FkDLOOPO/l7dGNoaP4Shg0DgGH6ayeI+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XK207NX+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wO/s0JgY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761883521; x=1793419521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fya8AMM54WnijATbKwsCABBa84Ikf4DsTTw9vWi5XZ8=;
  b=XK207NX+ytWbGdXz97JmRRaOoGWYJELYVmwgKgrpI3sPD3znEYDiii36
   xmPuc5O7qbx1cI6iu2wFW2G9fhBtMJ0yjimvvSrG80Ox4OQuFBJbMyazd
   dFWMglCEKzTMB0QEZjrR9cYYuYXF0sANkmrXeMYj8UyFzRZggbsfntH4t
   GRxAd4MXVg+H7vlXxhtk3W73RNzMdBR3UXWNswCoJferUyiBzMp+TSNFZ
   M0pSbnMO1hO9S3aDkh7C30r6f3sunXenOmwGkb4Vh79FeORpz08HeWfly
   d9hh625pFdW3aeaATy2bohpkF+tqDyk/9Ca+KWUH+Dzm5dI04a9cMeNBf
   A==;
X-CSE-ConnectionGUID: Ic0X0Sb9SKOfV41XjXzEow==
X-CSE-MsgGUID: Yz5xvXV6TLS15HNpjJq3yQ==
X-IronPort-AV: E=Sophos;i="6.19,268,1754928000"; 
   d="scan'208";a="135183763"
Received: from mail-westusazon11012045.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.45])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 12:05:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRApok8PVktSnBDVhLAYKi4Cg0z4VbrGIbZSlclnk/Pep2rgegMKm6wYzhyXjOz23kItHtxKZTP6dP6isgF1gUYJcA4vNXnQgGzcTHZmj+jptP7MqiMKBiBbawfdLfQST//GXxiXwAUDio3gEZZhXwVRUeGzB3IkVNNYyRi7HGG1CVNh/a4mEyaktFxvSdnjpsCoHbz9ReNtQokaRo88yvl8rDnAj+wepO8dV3+6+7lXJ5n4m8rOsVfLGRmPTlJc4cxbM5qqS6c8ndrs6kO7xiBczvOM8fMdapXneixhw5xlOvze6NaiA/ccbLYiFMRby0wdXkQDzlXoE1X4p8jNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fya8AMM54WnijATbKwsCABBa84Ikf4DsTTw9vWi5XZ8=;
 b=jkigCGzMcvPVeB4VXZ04JIg6ZnViB9bkjbaQj+3GuQS0KUrzyKqPmRXKiuCkDA5WKencxu1ILgj8EaMJVllEyAJR+DhUNbZ3uu6aWno9m2fUVRBOKxz92HuswFHrLFSpLmaA4mpK3VJxOZZb6z/MC5ua50CGGmV0sQ1GyWKSbyZmIAkeVdBhwzP5+CdSIrQahMHIjPaXre1gvKsWjsP00eFnH2Izx5APICQfXxAnxj/sRLiQgjdPTqGPE7Xd0KbfVpXIlnPDGXlXVz1duivRoxPnR7G8UQI0qSng5+AQ39lsp5lkNeCkXUgftp7T+NKSDZuVaBcylp8wHZaAP2D6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fya8AMM54WnijATbKwsCABBa84Ikf4DsTTw9vWi5XZ8=;
 b=wO/s0JgY/913AB1Dlw0L8UMbvRqKBerZkTlNUJ3OobUns5avngEtxhGd/8oZxupa49cQdSK7eFTLaSN/SZ++mVHcXRUmjzjA7JP91TD0WbVrFBKC7y3d2e9ki5Zj70aGsIaA+F87fFaZ0GXFh5UvasuLEj2YbmVyo0O3PBu+L3Q=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CYYPR04MB8877.namprd04.prod.outlook.com (2603:10b6:930:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 04:05:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 04:05:18 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] fix zone capacity/alloc_offset calculation
Thread-Topic: [PATCH 0/2] fix zone capacity/alloc_offset calculation
Thread-Index: AQHcRxNkZ74sJ6wbBEehVb1hBnQFHLTa/MEAgACsNYA=
Date: Fri, 31 Oct 2025 04:05:18 +0000
Message-ID: <DDW7KWDK0AWA.1OYU71MQQD70H@wdc.com>
References: <20251027072758.1066720-1-naohiro.aota@wdc.com>
 <20251030174852.GA13846@twin.jikos.cz>
In-Reply-To: <20251030174852.GA13846@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CYYPR04MB8877:EE_
x-ms-office365-filtering-correlation-id: bf836cb9-2485-46f5-f55a-08de1832b417
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHd5UkQ1QkFtTGtxbHpyUlBrZUZTTHd2eTgvM2lQMEFBdmhyMHdaajFRTUhr?=
 =?utf-8?B?aTV4QjcyT3JYaVR1bkc2YXVPclU3L2FLZkZwVGhXR1dINnVmbitKTlZEbWRI?=
 =?utf-8?B?ZkJuRXNJUXFsMElnYkFzNHV3V3pKeURybmdBOHd3OGNCQW1SamxrblZUU2pk?=
 =?utf-8?B?NmxpUFF0U0NGSXlORWhwNExwSXpqbkRGUTBhbFVtMEo5TU10VlVac1luM01U?=
 =?utf-8?B?LzZHZTNIUFErTDJNTnV6aXUzdmE3Qk85ejkxcGZ0eGIyenphZ0FjUXZBVU00?=
 =?utf-8?B?QTRadkY3ZDNqY01CR0JQKzNuT1pwM2hVbFpvQm56UjhKazJnODdwbi9rTlhC?=
 =?utf-8?B?QjU1bEttV1Zwemd3NUJobG9mZnhLcmRkNkh3ckJpcHhGZU04Yy9KTFNEaVlK?=
 =?utf-8?B?QlhXeFZRQU1VeSt6UVFaNnF1RGh6alQ5WDNNRGVoQnpUQkIyRkJlbEhoWHBp?=
 =?utf-8?B?dVJXd3JwYTJaMDZvUWh3K1c1TEJTeWdOZ292VTl5Vk15SUM0bXp5Zkx3VUo0?=
 =?utf-8?B?Q2YwU3EwS3I3R3phbE9YajQxeU5vbGt4YU5FZ2lkczI5UU95aGQ1aDN4bXRa?=
 =?utf-8?B?TkpHSVUrZjd1N0pGdXg4LzlVbjdDMlJaYnBCanRrZnIxZjdIVWVVQWE3YnZU?=
 =?utf-8?B?allkTGJFV2FyaDBoRlArQW5OS09WSEVoSU9lbUxhdUtUL3NRbnRUN1pPUE14?=
 =?utf-8?B?cnNHakY1eHNjMVgxS0hDTnhTUGZTdGQwcWVZQkREeXVBMWNvOWx3SFZub3dI?=
 =?utf-8?B?ZUNlMk4wb05pOTRtQ2NFYmZJSm54UU1iRFdyeEtHT09ZRzhFWW91cjVPaktX?=
 =?utf-8?B?UVp5cGRGZVpra2praTNscGdPaTlON05hVHJRQzFVVWZRL0MycG41VXpDOEs4?=
 =?utf-8?B?R1lCRndtd2E0eld2SGVuUEl2SE9BVFdiMWpFVkt1SE1OSGFmUFRJUTZrRXpK?=
 =?utf-8?B?S2pBQ0txKy8yY2pVaGF1OUM3dktWYlo3Wm9BWE9jR3VqU2gvRDljM2Y5L1Ny?=
 =?utf-8?B?eW1peDltWWlqTzdnQTFQVEp1Y0dGSkd3eTVMdUJEb1NJU2hjYWJaYW1DTlNt?=
 =?utf-8?B?WURlcktEV2hkZ0t1WGdXU3RZMTBId0hPTGVGQnk1ek1ZaDNxeFRxQlBwWUNw?=
 =?utf-8?B?cjNMc3hUQ3QxbjdtRlh6NUdZRkRxYjlDUG0xSk1DaE10cGdEeGlOZTc4STZ4?=
 =?utf-8?B?RTczaU52QTVON2lhamZBd285WENERHhwSjNvbVhZOE9pODBuUXprVC9CK1Y5?=
 =?utf-8?B?TGdVNm9JeVg3YzlUMmtqcFE2dEVudWlKWi9GMlRBdmN4RStadXlTWWhRUnNi?=
 =?utf-8?B?Ti9XblFEclhNZ1ZnVUNsazdLUjBGMkt2bVBUOCtSNk96WDZ0YWpJYUZLWnRI?=
 =?utf-8?B?UzVhQ2UwZW9TaWpUcmw1ZHVrVHczbjRmY2N1M0w0MzJwa1EybDJIUjJEYUhm?=
 =?utf-8?B?bHAxVHIrR2s5bDFXOFlLREhJRnQ1ZU03UnBabmhWWjZBSlpyei9uYlZ6Njhs?=
 =?utf-8?B?RDZEbnFENG5WK3JtSFcreVh3U2pHUWVjc3BIWS9uMTc0YzFjMGxOaXc1Uk9R?=
 =?utf-8?B?K1ByRG9LbE9aM1pEMkdOcnpPN0w2Q3pDNyszWjRQNk9ocXhoYmlYNm1TbVRr?=
 =?utf-8?B?dDhYMnJqYVRlY0d1MjFKQjhyQjl3cVpvZThCNFVKd3UyNkkybU1DUnhzK21L?=
 =?utf-8?B?MEdDOVIzYzBYTU9melNvZTB2VmlhUmJTMVZnZWh6V3NVWlRYUG9OMTk5RFZz?=
 =?utf-8?B?aXFIcWVwY1BTV0xzcWZuNHFWc1JJbndFMjNwTk5tYTZUQjNUeE5qUnRxTVEy?=
 =?utf-8?B?NlVSaDViaGF4Rjl5MjBzUEVuSVFsTW1vSEJVNjRlbnZ6K0JqekpZNXplZ210?=
 =?utf-8?B?QkxjSFpjVGdLcXdlNEgxQ3Vnd29qbHNqNEcrdDJwazhQbm5lWXR6OTNNQ2ZL?=
 =?utf-8?B?N2VQNVFDVjRBeXpoR1ZzTCtJR1MrbUVHRWpsZkZLTmszdm9MYXduUTd0S1NL?=
 =?utf-8?B?TzJRMlBkbml1T2c4bElDSmVkME83S1F4QStCQ3VnYmpWY2dwaDE5MzN3WkNV?=
 =?utf-8?Q?7h2x90?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUl0RlV0OG9uQk1OMmdLSm56emJYdk91aGdGSTFxd2VYN2laYkFNSjliUGtK?=
 =?utf-8?B?V0dRSTc2K01JbEZ2ZmQ2eWQyclpCR3FwcWdaemFWUXljYzdHTGR5SlY2cVN4?=
 =?utf-8?B?TWtWUi9ZeTZpT3BuU2M4Zlhwa2thNENvRXU3TU9ZdVZJRnYvNzdMb0xRVEZC?=
 =?utf-8?B?Sk9hSDJvQVJ0WmRsK3FOTG1rWTh6bmhUalFHaTFjcExLTDJEOERjbGI3ZXJR?=
 =?utf-8?B?TmpFN2pvWFV1RlNUbXF1ZWtuU2E2TkdpK1NFdDBseSttK2duRytTTHlhZDVH?=
 =?utf-8?B?bmx0VWdyRjA1SVEvVUwxWW1BQWNjQ3NuWE51WDRaRWt6WFFjMXpRWGY4bWlX?=
 =?utf-8?B?MmUxN2lNVGU0L2U4MFJNUDVoUGNJeEZiU0loTEJEVjhsSE50OXphVEQzZ0ZQ?=
 =?utf-8?B?MmVNL3BtS3BieG5Nc0IzaE1Xc2hJTHVsT1Z3UmZNdUwreVFuanhhWk0wM3BK?=
 =?utf-8?B?UnlaUmhNQjdtL3dHNWdXQU5FOE1xRGwrQXFZLytvT1NDNHRrcDIyRUhQZmtE?=
 =?utf-8?B?c2VqMGppOWVOcnV4ZExTZyt2UEVVL1F2SmlOQVBFOWRSYUpKTDJxTWUwMjVY?=
 =?utf-8?B?TWdidGhTVFRjOWVpMW4vOFZ4Z1RPY0lFTkFLbTc5SHIrS1NyTUxYYVViV3Nv?=
 =?utf-8?B?NmJDc2c0NlF4WUVNaWlvYXVtQXlMWVZvcnpkM0kwaG94eGMveGdtZURxWFg0?=
 =?utf-8?B?QmY1Y2txcjdOMlFzbHkwcW5xU1lVb2F3VUsxc2hDcDlsVGd3aXZRTlhTQjdV?=
 =?utf-8?B?Y3IyMnhiV0RKYmV5eG4xM1NiYVBzRFovRkR1R3dtdlZyOVY4b3VQSmd5ZWdU?=
 =?utf-8?B?K20wSzlzU1FsN3JJUU80ZkIxVEZvdmU1bzYwbXNLVlpzTE9aUGwzVFd5QXhL?=
 =?utf-8?B?dzRpL0hHVXhSMUZDb2VYQzF3SmZOZ3VnWUNSUFFaSUF3Rzk0a2JuTFVDaG9M?=
 =?utf-8?B?anNnN08wdWl3V2VUV0dTYlIxVlZIaitEbFdReEJUL0xYVCtuQ2trZXI5ZWF1?=
 =?utf-8?B?YnVKOUYvd2JVc29CVm1sYVBqYkgwazN4VUh3UllGRXo1eThETEUrN0ZDLy80?=
 =?utf-8?B?V0lOcURHeWVOZm9yMnBjV3dlNEk1Q25wRzdyQUk5TERMYmlVRjhFdHJ5MEEy?=
 =?utf-8?B?ZmF0aUw4WXZmanRtRnNDSlQyL1NIc3BCRW8zaEFNV1FMcWRSYlZ4NDFLVlNs?=
 =?utf-8?B?STBNM0czS0lLT25LaUFtaTFiV3RNZGpCRkNFaXBqMFZyd0VRSUU5d1dqL1N2?=
 =?utf-8?B?Wnl0cXFqNXZ0RFQ0Q2FCNzF2ejkxRSs1VHI1SFR6UHFPcW4wTHJ5bUFtQUxr?=
 =?utf-8?B?TjRIV3Fud3hPb282NnJkZG8rcWh1dEZkaGkyamR6SFZtMjdNRnZjNk4yNFFw?=
 =?utf-8?B?K1QwcjhkS01mTUZIWnd2bmFvQS84OXFQSnFLZkF0REt0V2lldGs4MlZFTUYz?=
 =?utf-8?B?dE5uNmVNZ1Q0ZzR5VUVZd2k5RnVvZ1o0VVRWaDZzVGk1YUIxeUFvUXNkYVhp?=
 =?utf-8?B?N3p0WHhCb0JPVVZodmdKVC8zUjdhdGx0L3p5ZzdPaHdKbkxrZm1MazM5ditq?=
 =?utf-8?B?aGZEa25LUXF6OEluWEpYZDl0eFRjQ0pkYk00Uk55aS9vQjZpblNyai9MSDlq?=
 =?utf-8?B?VDNSeHRyeG9xaFJ4VWtheVBUbEwzNDJtVHBTYUREZUZuRW9ISWhtZlZqZzFH?=
 =?utf-8?B?VVczVHdPNmdVZ3lwNERLRjczbnNwZXpnVmpvRmljTldiNzdlMTJ3d3k2U1Z1?=
 =?utf-8?B?QUM3UjNJZjdMWmJ4VzNGZ1VaeC9kbUx0M1haY3hMRFBMd3FRRnNZeHZwd2gr?=
 =?utf-8?B?MTRVWTFtRkpiWWFYblYxTzhPSkFqano2Y0c0aW9wRDJ1aG1yNmZoVmRuNW1x?=
 =?utf-8?B?cW91MnpkdVV0RUZlRWJCSzdxSVZXWjYyU1V3T3dnTkcrZlRScDJ5ZGw1bUJI?=
 =?utf-8?B?MklqdUQ1UVlyV3hKQ3p4TmN5TS9RMm1EcWluMWNIUG9nSkEwMkdmZ3RwWmkw?=
 =?utf-8?B?NFN0MzJPRDFxOGJudngzbERjZmF0ZUpKNW4rTGluVjdmUE9BTnRFcGpKbXd3?=
 =?utf-8?B?UEZ0Kzc2YTVZeUsxQmV2eGV4Y0JxOS9KN3M4ZEFFMEhwR01RcjdwSDNsWjU2?=
 =?utf-8?B?ZnBaNVNVUFEzY0VFY1dpQmE2VmVxVzRVd0JkT05VUVlTZm5SYkMrSStQaWdq?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1389B72FB158E647AE610F68A1B5C74F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g/IIDsZhIYjfy6U5/wlhQQOeXE5LAmnGgtRgdxOXXHY4/gN1EDFiieBVUZLjwQ8I11F2ne5zbrnj20xxIfNrfNw2qmlzVtKTbsmitOzlV8WoQNixapR4KmDVRcsQRVYycknYSc0IYvW4DcbxD19RNsYPGO31cu2Yis4MAIiZfPk6cBaEwKsZ2jZs57Q1W5wWvy5E8mLnEeE+PYwjII+J/gciXAcrWsxk5Rod1REN+I7MKCGvIivHx/kBYjmGalXZAS6r7ZWxILUnNhxPZybn82HOZpjvVsDWDfbvFlAqT2QWBEC724Y1VODhWo2jCF43aD8KScPT7COgKW1RO6O+PR9RRAZjPi0V1ne/1fYTPEcYWxVJ2rsRyUyxVQAA9b7gHluIdAL62jXfnMGdNSJGoh0qEMQVKDLX28i4NVyBzTcPauOEgF+ppOfoyQeJFCNTSjr/P4h8jG/RGpWnJasasVFHkJ8RD/o6uRQOR9+L/vzgsGjtpbBLj8hV4e3sEnCBNBzHdrIpxvAFRSgnx1xit118uu3iuN2+GklX70YZ45QiGOZY5otTGi/NaNkP86eCoikKVtPGdYjJ4OS4l3BkFf1ow+dwcRMY/gGF3Qsznrmg9tLHicbLicd3zU4R2qst
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf836cb9-2485-46f5-f55a-08de1832b417
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 04:05:18.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPWoaBiElcFQhQQTLTTZK2171V3AaO6NvTfwxjSgo1VGAZQZdDGRT0y6hBeDu5Fun1v7UdMNQXjYvMmNfYS4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8877

T24gRnJpIE9jdCAzMSwgMjAyNSBhdCAyOjQ4IEFNIEpTVCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0K
PiBPbiBNb24sIE9jdCAyNywgMjAyNSBhdCAwNDoyNzo1NlBNICswOTAwLCBOYW9oaXJvIEFvdGEg
d3JvdGU6DQo+PiBXaGVuIGEgY29udmVudGlvbmFsIHpvbmUgaXMgaW4gYSBibG9jayBncm91cCwg
d2UgY2Fubm90IGtub3cgdGhlDQo+PiBhbGxvY19vZmZzZXQgZnJvbSB0aGUgd3JpdGUgcG9pbnRl
cnMuIEluIHRoYXQgY2FzZSwgd2UgdXNlIHRoZSBsYXN0DQo+PiBleHRlbnQgaW4gdGhlIHpvbmUg
dG8ga25vdyB0aGUgbGFzdCBhbGxvY2F0aW9uIG9mZnNldC4gV2UgY2FsY3VhbHRlIHRoZQ0KPj4g
YWxsb2Nfb2Zmc2V0IGZyb20gaXQsIGJ1dCB0aGUgY3VycmVudCBjYWxjdWxhdGlvbiBpcyB3cm9u
ZyBpbiB0d28gd2F5cy4NCj4+IA0KPj4gRmlyc3QsIHRoZSB6b25lIGNhcGFjaXR5IGlzIG1pc3Rh
a2VubHkgc2V0IHRvIHRoZSB6b25lX3NpemUgaWYgdGhlcmUgaXMNCj4+IGF0IGxlYXN0IG9uZSBj
b252ZW50aW9uYWwgem9uZSBpbiB0aGUgYmxvY2sgZ3JvdXAuIFRoYXQgc2hvdWxkIGJlDQo+PiBj
YWxjdWxhdGVkIHByb3Blcmx5IGRlcGVuZGluZyBvbiB0aGUgcmFpZCB0eXBlLg0KPj4gDQo+PiBT
ZWNvbmQsIHRoZSBzdHJpcGUgd2lkdGggaXMgd3JvbmdseSBzZXQgdG8gbWFwLT5zdHJpcGVfc2l6
ZSwgd2hpY2ggaXMNCj4+IHpvbmVfc2l6ZSBvbiB0aGUgem9uZWQgc2V0dXAuDQo+PiANCj4+IFRo
aXMgc2VyaWVzIGZpeGVzIHRoZXNlIHR3byBidWdzLg0KPj4gDQo+PiBOYW9oaXJvIEFvdGEgKDIp
Og0KPj4gICBidHJmczogem9uZWQ6IGZpeCB6b25lIGNhcGFjaXR5IGNhbGN1bGF0aW9uDQo+PiAg
IGJ0cmZzOiB6b25lZDogZml4IHN0cmlwZSB3aWR0aCBjYWxjdWxhdGlvbg0KPg0KPiBQbGVhc2Ug
YWRkIHRoZSBwYXRjaGVzIHRvIGZvci1uZXh0LCB3aXRoIHRoZSBmaXhlZCA2NGJpdCBkaXZpc2lv
bi4NCj4gVGhhbmtzLg0KDQpUaGFua3MuIEkgcHVzaGVkIHRoZSBwYXRjaGVzIHdpdGggdGhlIGRp
dmlzaW9uIGZpeC4=

