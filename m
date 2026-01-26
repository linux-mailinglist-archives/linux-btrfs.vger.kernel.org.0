Return-Path: <linux-btrfs+bounces-21057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO1uBrE1d2nhdAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21057-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 10:36:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B212986187
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 10:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26B523003D19
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2884314D25;
	Mon, 26 Jan 2026 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n3mK0+9B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QifpIWrX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FF314D19
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420204; cv=fail; b=cKHOPYP7C/5j36JbAUsZG3k2F3UuVpDsPEWjudNqOrAccpgpZpH2Pp83tCOkbNXiujFtFw7EQkHtcjrr0RPWUHYPZyDn1ED2n5x27Qu5IceEoARPWfPEdJago8Rrl8UarbRb4cZQrVCo+W14vV7CtWTYShr1RzjCcz0/9XeRxkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420204; c=relaxed/simple;
	bh=BhtJkOCmvufTR0ixONH1nk9CCEMSdTYVqfE9G0jyFzw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKOb088qwML95orsj4Hm7EjBywS5liViiIzKmC6cfH53K+SVQxdOCPFD4CHSy2Gzntwedw/VS5GdMNkvVr3IuKktabqqVlorDOJ68A8nzmLudQzjqpV5WdiFtTfbXIXWGm5bLmUK0iwOvZjNz3DotmKoikpZpG9XuFqKcc4MjQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=n3mK0+9B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QifpIWrX; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769420200; x=1800956200;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=BhtJkOCmvufTR0ixONH1nk9CCEMSdTYVqfE9G0jyFzw=;
  b=n3mK0+9BD1e6xtj8OygCp5Ix3kE83sg5VfjJh1RitCC5cil6sApfKpVp
   F4zXELkOp77rQxseAmY0/f8MOiANJ/QBluQrG3MQ9YbtdXq8hAZhOREc+
   Z1vE3uLv3ED5YsNG4+6+Cvb2cT6cP2kgWnpwesmieDcPBt4c7+oz1VPJk
   R96xn0qyUWfP44IYfrViuGZsz45nN6+W5QrMlVCtKBpqxfHcuodR1WxMR
   WtEuisP4AFuM6nUeLAaN62xkKm+pO0VXxkPka7algvJYNt4M9poto3Jf3
   MQJD8baIEj2xPkj5W9QOka0TxHbgGH0sOvlq7NDSfIV0BCNnUxRWSPXb/
   g==;
X-CSE-ConnectionGUID: 7Qste20iQV6wmOt3035WkA==
X-CSE-MsgGUID: Ii+j8J3HThOk0wSz3MULKA==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="140645622"
Received: from mail-westcentralusazon11010002.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.2])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2026 17:36:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNXLg7cnULodc6CGUeBaZI6J2uBJg9qUoMPO7BtN19vztOujGiMKtRI9QbNeo5vD2foAsy2LVfovYzo8qHZPYapl4V/aqMekJZ16j6irV7Wx0/eu3KhrvIJHJZSFQ1IG1TZZQ2px5EwB9OFdTDKGqYkS4zk2UB6f9FRryuHB9CdizY0itHMuzj/1LTQ29j3wGlpwBVprWBFDO/hyaBK2E6psnHYJRw7EdA6vJmJxaDibzDpjW3xn24rm7xD/9hraw5bmT/KDnwihSKQGXkJj0HLa9Fo3C50xzdfR6GCDyoiKSbZuIEa45XYS4bNJSJc12ZhPTu+h5roJIZ4v3lSgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhtJkOCmvufTR0ixONH1nk9CCEMSdTYVqfE9G0jyFzw=;
 b=Xow4UMo7Mcxti72X9TFHiTSq60w6Q4YJ9yUWiwzv0rxEg8LjEoQxB7Puu0qHfnNsHp7waDI1AiGEcT0ULWzGg+88oD2sgktz/r1A2HRFuI6uVHg5EQzx12kCFPQxYVJdR/GP8cPCaOzUjx6QDezZKPXLqbkKiGkYLSOgCZNRc2/PrSXw8aNHEyIiHGAD2wBOL/xDYyQ39ha0A3nwpRwpdEwJqpzSLLjFpvGP65s+cmctKPZO99poXGc69+inHzN2XqbTE3nB8W7vEp4UBwhVlW+BsnK9TheYg6sIfsR0w7w6SXylFuA/XiNMgutLTa1Kj5/5bpyR9H2U7uUDOmzfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhtJkOCmvufTR0ixONH1nk9CCEMSdTYVqfE9G0jyFzw=;
 b=QifpIWrXQQQr32zrbH/HR/uzmDv72LrnR8GInnqjKTNEGK/qVnU6FSqKnMStwCaJCLSyg4oG6n3sf+OhV+050PfiqyWagiW5RTqGsWphWKRXq8kj9zpTDU3J8eTUlpbcUcbEnssYbKyMKN8FJDBf8h+6pV1wgsTauZhO53bNJuE=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BY5PR04MB6867.namprd04.prod.outlook.com (2603:10b6:a03:22c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 26 Jan
 2026 09:36:29 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Mon, 26 Jan 2026
 09:36:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] btrfs: tests: zoned: add selftest for zoned code
Thread-Topic: [PATCH v2 4/4] btrfs: tests: zoned: add selftest for zoned code
Thread-Index: AQHcjofPepvyXH7CsE+DiCAy3A3bV7VkMXUA
Date: Mon, 26 Jan 2026 09:36:29 +0000
Message-ID: <c217b72e-f416-4dd7-9028-7ac8233e3809@wdc.com>
References: <20260126054953.2245883-1-naohiro.aota@wdc.com>
 <20260126054953.2245883-5-naohiro.aota@wdc.com>
In-Reply-To: <20260126054953.2245883-5-naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BY5PR04MB6867:EE_
x-ms-office365-filtering-correlation-id: 83b8df7d-cf88-4c7f-22e8-08de5cbe6230
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm0yTkZlbkxvNGlrWEVIVjZBTDhQdVZTRkxOK2dib2hhV01GcXhTZVF3NnNx?=
 =?utf-8?B?Q2hDR1BxWmdoRGxSc1JUR2x5cGc2YXJFQ29tVlRWZTVEa3FWNDZtMVFNdFR2?=
 =?utf-8?B?RkRIamhuWHNkZVhUTkhZMVRBRmdOQWx0eDAzOURrRTVPWnIwNUcyM3YrUU5t?=
 =?utf-8?B?QkFPVjcvcDVmeDNRZjIvR3BKdkF0T0xVam4xaUlwdDkxeE1JQ1pUYVJpUXMr?=
 =?utf-8?B?ZVRYZmhCbmp3eUdtV2VpbkNFOWhVTE1qTFRQeVVyckhZNWpoYWVneWxLUldq?=
 =?utf-8?B?eDFuL3duV3B1a2NtN25oMVUzRjBYMWhYZ2Y2alpEYldDTUVWclBhZ3prdG9t?=
 =?utf-8?B?blRjNVd3VjBLUnN4UW9yWGZJRUJ2SjNtcFJhcmdBQk9LNytNQkhhQmZLbEdo?=
 =?utf-8?B?RkxOSWgyU0RTNXVudE4zcnZCMnc4M2Uwb0pKZWJsWHdPcXJJWUJrdVlBM0lY?=
 =?utf-8?B?VHUzUkM2RDFPYkp3VUE1bFpHUzYrbDhoQk1XZkQzb3NlbXZDSjFkRFRmdVpy?=
 =?utf-8?B?MmMxMzlGbFBjRVFYcUFDMzAwWHRRK3hrYlZjQmxXa213Z3BXbC94SVo0TWs3?=
 =?utf-8?B?QjkreEhabnZVeGxWMUpNaHNadjRWcTUrZDRmRVFrTWZnUEhmTnl6QWd6NUJy?=
 =?utf-8?B?ZHBOR0lQZzRJamFNelFEV2lxTFV6clJNdVVESzN2ZTFuWWMwcmRsTVR5Y2pz?=
 =?utf-8?B?RS9VTFNLQjFhTjZaMm95bnRYWk93L2p6Wjh2dlFLek9qaTFtL1ZmSDhSd0ll?=
 =?utf-8?B?UE1ZMUNtNjROMGFtVnNwemZmMWdWTnRoV2k3a2cxODhBQ1pRNXJSRFhBUmN3?=
 =?utf-8?B?MmRRY2NlQjJ4MWgrRUVkdHZFWkdHeGRKK2N6Vk5pbitvZ3FEejgwQWZ6elIz?=
 =?utf-8?B?b1ZaS1MvbDNCWTE2QkF6b3pZRkJhQkNyNW9GVnEzSS9wMkYxMTF0RExrRi9S?=
 =?utf-8?B?TGRqREtVSkVtclVoRlNjTGpkZDdSRndCdmdWQUdPcWllTDZCYVBiaWNJb01E?=
 =?utf-8?B?R2R6dWk5T2NiNVVhZU5ZVTBFeTVCT25ucEJWam9wa1lPb0lhTERVZ25xVjM0?=
 =?utf-8?B?ZVpVRGFYUDVZclRIdE5GaGFxZ2VDQVBDMXMwMm5aR0loRjBJWmtoL2FmMzlu?=
 =?utf-8?B?dE5oYjZIVG9HYnlaT1Ria2VZZnE4eEY5bHF3MzZXMStYcmsvRXFDUzVDeERh?=
 =?utf-8?B?KzNHcW4xV0lhYTR6dU5kYUc3YkhqL282R1hmeTZZU1hmbFp2bkVxSk11bzlF?=
 =?utf-8?B?RHZRV0hCWm42c1lwZlN1dDNya0dIY0dRYUtjeDh5dUlueXN1ZVdNSG9SWEdy?=
 =?utf-8?B?L1Evb2QxbGtoQzFtVEdpd2tZSnpJZzlNK3hsRXNWZGNUcVFzSG5CemFvQVBr?=
 =?utf-8?B?V2RvaE40TitBZVQvMHJDYkpUQW9zTUVEMEJ5SzVMbElIc0RMOUxrT09qckRm?=
 =?utf-8?B?cTFvV05Ud01RamwvWVlpM054NUs4d1ROTjhNRU1RZ0pwVVNjelNjZ0VDWkMw?=
 =?utf-8?B?RzV3eFdzVm1mbE40emF1anhoa2o1ZzZwNElIRWFUaGcwZFBFYXBwbE1Fc21s?=
 =?utf-8?B?N0RWQm9QbHk5cGo0VWdUbjVockEvS3JTSjdLbTVyTnJEVWlpcGJoa3JIYnhD?=
 =?utf-8?B?ZUZXKzF3Rmd6RjhsQytCU21KRytrVnhweUNYUWI5WnU3L1VtTXVFMjg1ZSsw?=
 =?utf-8?B?Znd6RFBPRnZUWE1qbXQzbGlQSWtqaW1pQ3ZFdkFScmdERHMyaVRiVEVEZUxG?=
 =?utf-8?B?WGFsRVd2V1paUVczb1BwQlk1bWxMeDUzdk10allqejdRTS84UXovaU95TU13?=
 =?utf-8?B?VGdERmNpUkhHdmtRVm5EUFdtWm14NEFoNXZhQTU3UElJN2k2STdiUnc1OWcv?=
 =?utf-8?B?Y0RvR053d1dEdTBFS1ZhTDBjL1FtTm5QVWh2M0JWVU5LaWdXaFhhRmYweXdU?=
 =?utf-8?B?L1poOEcxaXh0OVI4eWtqUGo2Y3lCR05pWEc0Qlp5VklyTVJFZnJGbFpGdlN2?=
 =?utf-8?B?SGxOTGd3QVZKK1JzV3pndWEwTEpVcXhFZU9TLy96MXV0bWFXeUNENWJRSUZv?=
 =?utf-8?B?MjFLK2o3Y1g3ZmRzSk9CVExqRGJuTmJuNGhJT3lGaGl1OGR4bW5CQ2NmYnZS?=
 =?utf-8?B?QWNKOTJkcnZsQ3NEdy84RmY1N2FDMWxiZ3pXeExoMzJVeUlpY09jTnFyZzZ6?=
 =?utf-8?Q?fxR1YQvsY40l7pAeENE3G+Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlQ4TEdzY0QxZDhrd1FkdllGZ1NxUUcrUVZVRkJFYXdnbHFlYWY0WWw2cys1?=
 =?utf-8?B?andzTHAybnFXaEFQd0Rwd2lPMGg2NXk1dDl1LzNVeHVaR1ZFWmNNeEFHVStY?=
 =?utf-8?B?N3o0T0RVb0wvcnM3cnVQK25xa2VBSC9zSTBGSlpDNjJtdGw3MXJ3K1JEV3Yr?=
 =?utf-8?B?VzY4MjMyNlMycUdWRkZmc3VaeDdIQlI5NW8vMFZUMjM4aEVqZTdSeXVIREdo?=
 =?utf-8?B?ZXRiWDkrRXF6SGJoWVRBRkxVbmJIT1F2NnFOS3VCc1NuVkgwZkt1cDB2NU84?=
 =?utf-8?B?NUxxUE5aS0ZpdExkc1c2bDlCb0FCQWFjNHZsMUxlc3dJdmhwK1RkWG9VTWoy?=
 =?utf-8?B?WmM3c1g1Szl1UUpBaGljTXlIUXk0eTU4MFV2RGFTUjdaZEtQZ09pYWNENWFB?=
 =?utf-8?B?amY0ZmhjdVNjNFhHOXU4R0syY2s2Z1BUckR4UmxSOWRxck9GMFMxN21oOGNU?=
 =?utf-8?B?K2xoM3lMajU5OUJHVFZ5Z3I2ZWlSSU14MmFWNDVtWUtmbzdWeWtNT2hVSmZF?=
 =?utf-8?B?T2J2Qk80bzZNb3MwdHJqeUY5YlVRejZzU2Z1NUcvNE4zWHg5TURUdW95Y2tD?=
 =?utf-8?B?OEYyQVZRbytyZkxPcWExV0VxOVFGL0F3VHhLU0xJYnVQQkxvemhLWjV4OWpR?=
 =?utf-8?B?cnBtY1JZbUdEaGx3M1E5UWNxWFFldlhkdEFiTlBmUFpXL1VBT2VrNXVCaDY5?=
 =?utf-8?B?U25rRTV3S2ZzNy9EaVY5RWswV2NjRnFyMjhEMVpWU25NM3FSamp0S2ZLc0s0?=
 =?utf-8?B?bFdFeHR4T1pIbmJoTHRlQTlrQkhJQXNoaVpDVXB6aWF2SnE4UVAvRE1aS3Ra?=
 =?utf-8?B?SW13THBIMVE5Q21WYnk1WVBRcjJEQVp2V1JYZmQzdFpqN3FlT1h3Z0xZb1FV?=
 =?utf-8?B?dUtYKzVZOFhDNnlJRjR4TGdBZWFLSTFQRWdqbWd3SUFjMnNmTC9DWDd2M3cr?=
 =?utf-8?B?NXNNbnhBL2ttWDcxQlRBdkR2S3RJRVcrSWxDd3dFeEt3Sk0vMDZ4TDZ5Vnd6?=
 =?utf-8?B?SjhwWnFTY3F4ZnFvOXlVRGFRMnFtakM3RGN0RkcyS2pMOVV3Q054OERBZllx?=
 =?utf-8?B?RTdKcG1rVlRDSTkweU8wWFlteTFEYWNwY29jSVRHWnFFS2U5cnJsV2FqWWxO?=
 =?utf-8?B?cXNXaisxKzhjZGN5cW50bEU3bnpORW9TQXpJamtCWWQ5ai8rYlh6RjFkRXdr?=
 =?utf-8?B?ZnpUeS9pSTVhSVpHNmJqRzA4N21Va09Qd0VYTHlwSVBjOElGc2EzSGV0ZGxs?=
 =?utf-8?B?aE5lNGl1NThsajVVN3IzdFM0RXl0cEtKSGhNY2c0OFlkY0tZZG1rL1BoamRU?=
 =?utf-8?B?cC82SGpUbDFScXJ6ei9ZVkFRMDRMWExsK3VJVEpCbzg0Wi8zSkh2RktpZksw?=
 =?utf-8?B?dWp0bHhKRDFJcEJ1NkJlb243Nkoza1pVSGluQkJsbDIxMkp2N0c5SEpoR2tU?=
 =?utf-8?B?SEFwQ2ZHSThiaEhPakNYbXFFQmkwSWtDbU1FMkNEbUFlRUNDVHVza2xOSU1M?=
 =?utf-8?B?cmlYZ0Z3V3dpdlU3K0NSMndYVWpUZ2RRbU5FNGNKTm5vY0o1amVJclJzR0M0?=
 =?utf-8?B?Mjl0UlZsT0g5aEE1MjA4QUw3N1RUMGJPa3p5Wm53U0NaUVNGc3hBa2Q1ZWt2?=
 =?utf-8?B?eXpWMGREMlRmNHRtbUZuS2lhd3pCUDMzYnZjVkdERnpVKzhxeldZbEE4dzFz?=
 =?utf-8?B?M3BEbkEyR1N5TGNJdVZxanJJVmZqUVVsdHFZWERnNU9uMHErUzV0dmVGZTFD?=
 =?utf-8?B?b00xa0tCK0lSM2lTcU5WUEhSYytoRVgzWnBPakJOVGhGcEh5Ynk1eUdMSHo2?=
 =?utf-8?B?bDI0eStadWJvSURlQ2lYaHJ2OTJhUFFnclBsL1VGZnlZTTIzR3dwRi91WDAz?=
 =?utf-8?B?TEVoWHhna01VRVQ0OXBOcWlnVFYxRDNXajlaWmNQcTUwdnpGbjI3cWx3cG0r?=
 =?utf-8?B?dVVpU1hhQ1RJY2hoaExPNWV2QzQ2cnlvNjZMbHF4empDcmd6ZkFsQlJ1aS9F?=
 =?utf-8?B?YWNGN20vL0hzb3ZYN1dsV2JtL05lOW5TazlTcytzR1BwaWZCSTV0U3pyZnNl?=
 =?utf-8?B?Zm9WRmNoS2p5aVA2NzVkWWFOb1U4ZklIWFA1Nk1rRm1LUFl0a3l6S0hCdFNl?=
 =?utf-8?B?b0p2K0ttTGhsUGgwWVRBY3NEUElFaE9pcEIraE43RFh2S21OT0Q5RXNMREtK?=
 =?utf-8?B?ekhmOHFYVkF6alBuaE5wak1kcWhyV2d5NGtuT0lzRlFocE5USkFsVVhONVk5?=
 =?utf-8?B?cTdJVHNYRjlsMHhuU0ovZGUwSmpVVFUvTUNpOFhFNTc2ZzhNa0xGVmNFZDFn?=
 =?utf-8?B?NDBLWWRnRm5jQWo2WVg0SzFaTlZZMFdBR3lEQlJpV2l5VHdZbEpsTnJ2QkpF?=
 =?utf-8?Q?5mZLgUEADpQXtSzo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AC9BA209BE47F4F806954E89604F215@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fJou42UQHTn1UfI1qNHaHeAus3fXfgockYsXxtwb6UIlVJ5Dv+yB7TAyfWVTVlojL5AdqvGRKpyrxLUMf1f+psMITwWuvOr6UZMyfyIeHda4HWxbpN8XzvYMEzvluB+wLNwqQ/m0wd4xlYe5uF1wnITTxWkrVS+Q27AcOIdd23bvgDHmh0r+gR4csFRhaIIs6vRnd8rggVO9YMmmsrDszbIbgwZbojtHCX64B3YdF9a49UOUbsjLUzRhw7EFubnin5dp/6hnPpGBrDrNPHAI2zXTeG5FkSDi+uara5lrU/UEPHIQVqo+bj0dG4YNxTGfdQG8HZCrhdGbftewHtgbwSn9cSIbQwnchDihhq7TvE98+xq7a+qezurbuEwnVGjj4r6GUfKwnzeRqpbhbQ4YsBcI7wpEvFXv1oyQ21vLZRUqdKwktKG3G0x1jZZB5/WLyjolBlUL6PZJerZcKRHi8xj0T2e4uMh0XqTBLu3maChJbkKufFD9ARqZ2ySW3cttcmkjtwasGnk0SAFv1Km6lzqAY1xhTyakj1UcNDByc7BWee1x9UvhM5lJInJTHZCxKV/uShd3MXVcgocXIE4kR8z7fWN6Gp8g4RR5a/hldoEZMQPxKXFvs/0GW8hP6flj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b8df7d-cf88-4c7f-22e8-08de5cbe6230
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 09:36:29.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2b1pg97qfkRo3Yx7Van5e9NPbTMvuhjQUzIaFw3SflaVHnRl3cANU/MMUa3sWY0A2C1eiyvOU8J9Sr1XgMux6v4s8TkCgbEIu0mH111c8kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6867
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21057-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: B212986187
X-Rspamd-Action: no action

T24gMS8yNi8yNiA2OjUxIEFNLCBOYW9oaXJvIEFvdGEgd3JvdGU6DQo+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMTUgRmFjZWJvb2suICBBbGwgcmlnaHRzIHJlc2VydmVkLg0KDQpDb3B5cmlnaHQgKEMp
IDIwMjYgV2VzdGVybiBEaWdpdGFsLiAgQWxsIHJpZ2h0cyByZXNlcnZlZC4NCg0KDQo=

