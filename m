Return-Path: <linux-btrfs+bounces-12217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAABEA5D444
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 03:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38D0178C3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9DD145348;
	Wed, 12 Mar 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="exjsOzoA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jxKCF0Wv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3B4C81;
	Wed, 12 Mar 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745225; cv=fail; b=myGYDIMeDNYC7txobbejgGNsuYQTjyGEfQbsdWZ8spJiyMmeOeBvkLPc3nnK4AWZBusG/3vW/cDHV5/mpC6ok7p+vrwSF1D/iE68gKaoniEHUqwMxDfGyAzyCqc6TFCiEIwYUqYBWS3K4i58AxM8c6F5F/nKmfA1sfC5Ffkx3Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745225; c=relaxed/simple;
	bh=9TbF430yhmu0SwNmeSTLDvwWyMDiTzPE1b36/cOjslQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDSemZH8bdHrYuv0AYDLoNwxsHVLKOt8KBz62eAE/9uWsP3wlTpUJKujNt7QsKS07OKOy3DwlpZvtV5/NFMm4iBaYTH0NCVHEYt7OzbCC9mp4oJI+3aNAEhGAaaMWBXISlGyZxuHJBP6mpqpLyc/pQxzUt2B0RkSrm+os5agOlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=exjsOzoA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jxKCF0Wv; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741745223; x=1773281223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9TbF430yhmu0SwNmeSTLDvwWyMDiTzPE1b36/cOjslQ=;
  b=exjsOzoAUd2NEEOsSTtxidtkFkhkQ82Ocg2mUPydLE9yoVzWe0TQwzc0
   bMwHEfUYslEUMd7pGBr0PIZEoMimgLDf/86cf1cqCdR2o+1C4Vubv0Wkk
   NviXvs3zeWCXWM+20QnC2tya4NkEpqO8EP+q1Ub2eicDZBl2v8ej41uSO
   HVNbSQzlIpXie2i1x6TqgrXFL7MmaA3oFuJOVDveupverSIURDFoojSsc
   uIUTvu6+xb0y8QtoGvszu79fIa65NlvcWExwvydZq4zK3UG8uYb4Z1K/r
   U5iMSikKXul2LPKXtHf3yCUaRpV19Fj6p/dSoGL2wP28zTncQ/hBXkHBs
   A==;
X-CSE-ConnectionGUID: OYIY9EHUQ12kD0brCA5cNQ==
X-CSE-MsgGUID: U6rICWs0TuGx8X6pYIPguA==
X-IronPort-AV: E=Sophos;i="6.14,240,1736784000"; 
   d="scan'208";a="47449174"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 10:07:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA3q8UIIR9CtgwC6zALJRuRUlo6/WEZCJZKrj6hryQ3qGBXiCSwCO7rl52Ha+7uzsrz14tV3c3/a6HBEvLjqPJI1SRwfg1Ra48PoT081kekexv4dsLYMV6DV/H//4h7djfX6N/4Zsi3uybQ85UL6nnTrFor9pQASd+ADta9cuBBZ0SzOp7ETxrMNQSzMlqLfxUtdCLqNISUdnqA0fvc9j2QzYMHtSeha7mKss0rD8Ew0Brc/ezIeWSwTyeN9D49I3LI/aXp/NxYjSc0VhHTj/Qoe4+Iautpy4jK019VTQG4VIyk5JSvCiZ6ZKbcmfidJEqNwjnxIhUwtpCmUAYKRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TbF430yhmu0SwNmeSTLDvwWyMDiTzPE1b36/cOjslQ=;
 b=p5bNiH2E4r8PL5gOiaiosiSNTl/4FB/70A+pcHyr+u6+1tKespl40PhKqTXI028b+I4b+frZkSdIpEXbmSPwnjMztoiIcyexOfSVo6PWdtC0BamTSnmn3cW/XptTipFU/upNVhMlbVufxZBA6DMRu/v4rBfiiT21+E6nM8/iJCTJQcwctfoIsdHPCBnjE3xjddO4yGeYtYJjdKJO0jHyral/CwaQz2H5q04gNz6h6M+QytK35IQliSdSikKRlSKkslmDFseTr/pqKrLub+1vqubE3A+T88zp3qVIpeiGyBZb/uWqpmRhJa3wqII2b4aRNdmYAiQb50ETQTOWFuNCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TbF430yhmu0SwNmeSTLDvwWyMDiTzPE1b36/cOjslQ=;
 b=jxKCF0Wv/n2gvBq0uilp/dMLNn5npCxjMIxnXP49OYF8EKZLPhAaCET5Vbzn9dmTmQOx7d53yAnMsfai5Q+15bWqfmtqJjmrzy3GY+6Dxk763Y4MY9GGYJIfDFr8n9o8mVtvohsB6BPKvOYkQC54j0CEMQtud3OA6grQPhUGuqA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH7PR04MB8481.namprd04.prod.outlook.com (2603:10b6:510:2be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:07:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:07:00 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: introduce zone capacity helper
Thread-Topic: [PATCH 1/2] block: introduce zone capacity helper
Thread-Index: AQHbku6c0s1fOWu5HkGSuuLniPLidrNuuWcAgAAHlQA=
Date: Wed, 12 Mar 2025 02:07:00 +0000
Message-ID: <D8DX5DG9RPSR.349R1ZG7XDGRW@wdc.com>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
 <da0d31a0-f2af-4aa8-ba9b-ce73bc010325@kernel.org>
In-Reply-To: <da0d31a0-f2af-4aa8-ba9b-ce73bc010325@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH7PR04MB8481:EE_
x-ms-office365-filtering-correlation-id: 28e8117c-adce-462a-e039-08dd610a937b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEl6QXNKVWNRZFBEc0tGdmVzS2l6eXpvYjJ0dEZpYXBUY2VKZ0lIWUcvQVh3?=
 =?utf-8?B?VkcyOTh3emNPUW5GWGFmR3hOYUJGRlg0Q2NlYldMZVhJQmRFY2xIT2t3UFp3?=
 =?utf-8?B?NUlxUndYRCtkZWMrKzJ5R0tXRmpuMHc5cXBzUDgzZ1NlM1VROElvL3FoSXNn?=
 =?utf-8?B?MllwdWFvNm4yeFRQOWhoT3JrNU5QQkJEVUZaVGVXdE9LQ2VjOTFTRGU2WWhC?=
 =?utf-8?B?cXlpVE55V2E3NXYvMi93WUxJSVFwdGdSM3lWZ2UrakJYazhqVFB3OExzSXBO?=
 =?utf-8?B?dk1yZkkxNmM1Q1Y3V0NWS1pMWGV6bXdCVlc2S0dtMlF5MlRlcVhoKzljbDI5?=
 =?utf-8?B?SUVtRzZRZGIzMmd5eEZTb1o2SlJuM2N5bCtWcDRCQlh2WTVOSm9XNHpuS1d5?=
 =?utf-8?B?bzU4RVEyeHBmeVJJeU93b0xYUjE1aW9JOGtiVHhCWUVOaXR4cXR5T2JSTWpI?=
 =?utf-8?B?T3JBclpzdlkwcjRKRHRTSEYyak9uTkJMRWFRNkI3V3JGZE9UOXFPamVQSUVq?=
 =?utf-8?B?VGNwNHFKMGJlVlozcTlYMGE2RWxjbFBidkhEeCtQelVsa1B6aFgrc21EbkNF?=
 =?utf-8?B?QmZYWkFqYmRXRGFHVGhuMWdFc21UK1R4a3VpVHlmb0diRFJ5aEZ3dzZyUXow?=
 =?utf-8?B?eVI3RHQ3aWhMdWtYc285QitHYzNOUU92cEg4N0l2LzFRM2FpNWtiMkQvaDR1?=
 =?utf-8?B?VnhKR21pMWhBa092MWJ6d0JRbDBNWnNPOVNGWHQ2bXRZMWt5bGtuWjI3bUht?=
 =?utf-8?B?VXlWeHg1THR5OENGMlBmdGJwN2RvRk1EN1FmeXY5YWFBaDkvdGx4V0dJY1FU?=
 =?utf-8?B?bEVtMnAwTmozZ3VIbzJoVG1nUkcyMTFkK0pDb3l6Z0d6ckNXVDVYbjR4OFY5?=
 =?utf-8?B?cTlLUkx5Smp4OXZzZXp4QTRCUUsyR2dMSnlJNXBlc0tDQjRseC9tRDhnNXJj?=
 =?utf-8?B?L2daL0JwSURaUDZXRmNTNUNuRlppd3l6T20rdHBSTVdCeXlaRW1tV3c0RGQ3?=
 =?utf-8?B?bFh1eTFHN1VjVGNqSnJreHluYVNsaHFqbm1vUUhZdXE3WmdIRHdCODU1UUM4?=
 =?utf-8?B?RE9NOU9VOTJtVUYxTytUV3FOQS9YQ3NwdDlTR3luOS81VkludnpwL1dzdm1M?=
 =?utf-8?B?cGJuZ1BVb0M4TXdzV1RKQTBsS1dCN3dLZ2tyV3BZQ2tsanRTN0RKb1duWENq?=
 =?utf-8?B?c1ZzZG55UGt6djhRUm1oWkwvR0FmZTVjcWdXY1Izb2Z5WHNJZDFuY0tPcFlj?=
 =?utf-8?B?eGpXcW9JS1NqOTk2Tit6NDRpSTZud2pwbW1OWFpjK3VoZ05YZngydUFpTGlm?=
 =?utf-8?B?NjVJZ09sYzk5ZCtkN09SUUFIKzBEN0g5WkVYbXdUTnJjeXVtcmk2NkZmTnFF?=
 =?utf-8?B?T1pGbytkK3dnMis5bmNhdDlFVG5GVFoxcEErNUdoeG91em5NR2t1QVFiMVlC?=
 =?utf-8?B?WkJDRDd3TGxHL2RCVUZnbk81eStNYzNaby9GTE01QjBFUERNUzF6b0ZndWtu?=
 =?utf-8?B?cHFmcHNRSzNhS3hHdFU4RFVqeVRhVmpJUjNoZVNIemZCakEzbmRGSmhQSFhz?=
 =?utf-8?B?MEJONTRYckRuSUVUeUsyQmMzRXYyeDFzeVE2MWhGMnRJYlNEMkpIcVVrUisv?=
 =?utf-8?B?cnFwWEhheGI3MkI0UGVBd2JiSXJMYThna3c4S2hPc2QrdkFZSmRVaHk0MWUw?=
 =?utf-8?B?cFdLNFIzenVZMzRialRSVjdrM0RuMUt5ZHg4cEV0aE42K1FUOGYrMUJNQlE1?=
 =?utf-8?B?RmE5TmRVRnB0S0FvMDRCMlA5Vlhzb1U0UmhBK0Mza2cwM1owajFtZDZXQ28z?=
 =?utf-8?B?alBQcXliTGNvcjVtZGNQN1FVeC9EL1RYb09kQWwydFdha3NZaEpEdWRQS2ww?=
 =?utf-8?B?QUdtOUJTVzYzUHhyT2pjanNXZTdyakl1QlVhUzB1eThVdkEzVFAzR1NlR1pG?=
 =?utf-8?Q?PBejHwjE+20vFItOwsyhVFPH1VLmCu1I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlZuSGJIOE9uMWh2MFk0TE5BRGhjd1p2ZlB1QkZOZmJXVnBXK2lsUENkVXFN?=
 =?utf-8?B?RFczU3FCOTBORDRENGthRmFTdE9kVzdQci9Gc3U2MTdlc3ZxeHhETUxtY2cv?=
 =?utf-8?B?QzQyb1FZdXVTdFN4K1JUa1pockVPVVNHa1ZKNHdYblFpMkxFZzRhTERjWjBn?=
 =?utf-8?B?cGFBU1VqUS94RWNVZStyTmFGZUJQRXo4eUdFa1BEcXlpZUpwb1lxY05yWEJW?=
 =?utf-8?B?Yy9STFBKRkR6LzJINkhXaS9ZZnFGR0dCQ2tRZ3c5cVJqb3dCTkxmMEhiRTE5?=
 =?utf-8?B?dnIveWtVTk9EVFdlYmgyZHdkMXVrWmJsMTJZNlR2dldsQTZjOUoyV1ZRMXEy?=
 =?utf-8?B?T2FYWjNuOVllMUlMbjJ0Z0s5V3NuM1ptSHVpTzYxRE1tdUJrS3lSUitBNVEz?=
 =?utf-8?B?dmhrYmpkdWpiaTZPc3dBSFlwUFdWTk5MeU5xZlB3YXFrTFA2NW5hdXJ3MTBS?=
 =?utf-8?B?VTBoNDdEeDhMdVU4NnpMeWJYZzI4aFQrakdQTmpJZHVDM25NeisvaFdhajk2?=
 =?utf-8?B?OHgvWjVDd0E5M1kvRVZ2TGxvU20yb21FS094dU9SRFpSV2lVOUYzY0FNWjBD?=
 =?utf-8?B?bWxVUEp2Z2UrN1p4cUpVZTd0NmJzQWl1eTg2UGlSUldmQWpqaVpMUlQ0OXI2?=
 =?utf-8?B?ZmY3cm1NWjZZT2V0M1ViVk1uNm45cDlGRnRxdWVvcmppSTNmT0hDZHRyeFBM?=
 =?utf-8?B?bmV1eVc1VTdSWlRvSCt5UHZ3STJmSkFxbk9tRWN2NVhUQ2VCNnRhb2ZXcTMv?=
 =?utf-8?B?ekRpRllSZjhveTlXNVNNNVpzd0U4QWZWTnJMZzd0Q1IzQTJEbzBxalQydVNp?=
 =?utf-8?B?bEl6dGg5U3NQZjVhNjVRemtMdTNkWXFMc1BLZW1yaFg3QzJaZ1dSRVEvbHAw?=
 =?utf-8?B?V0xraWNPZFMrMjdFRFpoejRDQjFPQSt6MnErQlhSOC9mSCtTVHRmMUlIVXhl?=
 =?utf-8?B?enY3SjlTdGRucUtwRXhXRFhndXdLZ2VDUzFSRHQwSzRiSkxXTFVLYm5Obnhk?=
 =?utf-8?B?NlVFUDRBMjJ1b3BKQ1NpNHRJRnZhREdPVkkxRkIvVDNXOVI2a3hVYUFqQkg2?=
 =?utf-8?B?U0x1SnAwR05sRExidDlKcVBqVWVvRUkxbXhVR01RTWswVmh5aUE0NEVuWHhu?=
 =?utf-8?B?dElFZlN3YkxOUGhPU0Rpd1h5a2xVRHZsWSswWXVxb0hVbFJZQUxUc2xud3V6?=
 =?utf-8?B?dURmd0NmekJMaE5NODZiQS9tR3ZoVXhlaXNKSG5ZWVQrUW9qREEvSk01QUZa?=
 =?utf-8?B?eldoZ1lPQlRORmRybkNqdC84UTUrT1NFYjAraUY0eUx3RDhxY1VXY2lnT1Az?=
 =?utf-8?B?R2FJajIzK1pkOTFXTUFwckhubFBKc2xHZ3JqVGZuVkJTYUlqMzhDcVhJM0t1?=
 =?utf-8?B?cVNWK05BUTdyYU1DRURMejRFSVlTbUFFcm1wVlJyd2tIOFpNYmIxaE90WHAv?=
 =?utf-8?B?TzBBQzlSVXgwMlRqN2hyQUdMT2RqMHROQXBiYXlXUUEzbHFwR2VreHN3OG55?=
 =?utf-8?B?M2NRblE3bDROMUJOTmZSaHd5b1ZHQkdvN25ia3NyYk1tbExRajd3ZmhMNFdJ?=
 =?utf-8?B?UjdmVm5UczFQRENWcERyMzlHVFJUN01aczBZQkRnYTBncCtwaWdvY3lIVzYx?=
 =?utf-8?B?dEZEUkRiMXhHZVpzQ21lTEJGRzNUZEdEbG9ZYlEzdjdqRW5tMlZZN0NOemRU?=
 =?utf-8?B?cEExME5Cb2E3UloxNzNrVnlVUWxMUjZlUC8rTVRwbXplWFN1Y3d4YWc4UE9t?=
 =?utf-8?B?cWRnZVcybjZRN2JwS0xvOCtGVDZ2NXhJVnI1WGtYVXFVUGhTRlFJaExpSTFT?=
 =?utf-8?B?MC9LMmYyNmNOT2hMWDJseWpTdU9SOGpiNUJNOEs2cmNDUkhGVnZnMUJLeUk1?=
 =?utf-8?B?enFJZk81NUxhRVZDeFVhZXdHd2IwUUJhVlYwMU1yaGE1M05hQ3NHTmNUT3g0?=
 =?utf-8?B?UkVlL0t4SklVbzl2VXg0OHlBem4xVzNLMk5pYkNNaEFRVDJ2SXF3NmN3a3Iy?=
 =?utf-8?B?NU9qaVRBV3cvdkkyM2M3S3RhcE5QbGZzTWw2cXFsQUdTWHBQeVAxMjZWeXRB?=
 =?utf-8?B?TUwrRmFmSGhWbm1CUHpqNWJHYUgxNDJhQ3d3UkFHTFdLT3lucXRxaHE5aGw1?=
 =?utf-8?B?RjJtWjJyR01jeDd3K3B0K3c4T2pjbXdEN1YyNzZ1YzdFdEhMYll2L1hoMzZp?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9088AE065C8F474E8FD7BA7C84B2BA86@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0h3Jxz8PgCpNkBMWMFOxeroDi5KGgsiq6tCtC+7zOraq7SYR1NAceXDHCvfycZEHsl3ANEuw8tXxyGJ534jSO9XCca8arq83hK0BA3Y88P2tLZV6DiTXgdqBaTiwdNaaymousBQJtEKuIp0iqZecrE1wm+imyqtN9UEduILriWADIxKaPfWFraxhbVCNzOXEXRT2YV9XVQa3Rx+gHw9gaefWdhwCFTHtccyVyLW3gyV9jDbC6tNLMSjz793UWHMDcv9KuewpAXuN+s0bpsGC8XjQ+1TANgRwOCGVJ7hImVKxnpM7plgbZTEUzNZTMgXFMW9aanOwnVI775x1UqEDvX5rh+v/grL/sqSdz4ipqd0EiHcpEcizBtZHbrQ+ijAXcHYnBi1DzXtEAUto9iU2Kmg4FxE8vJnnCQKtji957UiilMRkLUfRMNqRs7aKgoiJbLjXhGvFGAOGd2KAsbxEHKylo7okGSGy6xefxJ0ONX+KnsipujPOPYC6IU8oyK4qUPPe9rYnZEIuOIzK11Aa4VB1CAwkBhhDSdcJBsyuwHZg4z92BQQrBjPnUbtpaxl2SqT9zRUGjs3+JwHoOFJQAhkFwaPetJbmnpOUvCQXHfj6FMJTIDsnSasT7QL22fFy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e8117c-adce-462a-e039-08dd610a937b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 02:07:00.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtbscddQFV5PT6jrhfHSGGJzG2n+Dhwz7Nf46pbhlW5oJzL9gnd1QMlcC3NSsG1QaurZh1AtSko6HyWg+zJv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8481

T24gV2VkIE1hciAxMiwgMjAyNSBhdCAxMDozOSBBTSBKU1QsIERhbWllbiBMZSBNb2FsIHdyb3Rl
Og0KPiBPbiAzLzEyLzI1IDEwOjMxLCBOYW9oaXJvIEFvdGEgd3JvdGU6DQo+PiB7YmRldixkaXNr
fV96b25lX2NhcGFjaXR5KCkgdGFrZXMgYmxvY2tfZGV2aWNlIG9yIGdlbmRpc2sgYW5kIHNlY3Rv
ciBwb3NpdGlvbg0KPj4gYW5kIHJldHVybnMgdGhlIHpvbmUgY2FwYWNpdHkgb2YgdGhlIGNvcnJl
c3BvbmRpbmcgem9uZS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogTmFvaGlybyBBb3RhIDxuYW9o
aXJvLmFvdGFAd2RjLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1ZGUvbGludXgvYmxrZGV2LmggfCAy
MSArKysrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1
ZGUvbGludXgvYmxrZGV2LmgNCj4+IGluZGV4IGQzNzc1MTc4OWJmNS4uM2M4NjBhMGNmMzM5IDEw
MDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaA0KPj4gKysrIGIvaW5jbHVkZS9s
aW51eC9ibGtkZXYuaA0KPj4gQEAgLTgyNiw2ICs4MjYsMjcgQEAgc3RhdGljIGlubGluZSB1NjQg
c2JfYmRldl9ucl9ibG9ja3Moc3RydWN0IHN1cGVyX2Jsb2NrICpzYikNCj4+ICAJCShzYi0+c19i
bG9ja3NpemVfYml0cyAtIFNFQ1RPUl9TSElGVCk7DQo+PiAgfQ0KPj4gIA0KPj4gKyNpZmRlZiBD
T05GSUdfQkxLX0RFVl9aT05FRA0KPg0KPiBUaGVyZSBpcyBhbHJlYWR5IGFuICIjaWZkZWYgQ09O
RklHX0JMS19ERVZfWk9ORUQiIGluIGJsa2Rldi5oLCBzZWUNCj4gZGlza19ucl96b25lcygpLiBQ
bGVhc2UgYWRkIHRoaXMgbmV3IGhlbHBlciB1bmRlciB0aGF0IGlmZGVmIHRvIGF2b2lkIGFkZGlu
ZyBhDQo+IG5ldyBvbmUuDQoNClN1cmUuIEJ1dCwgc2luY2UgdGhpcyBwYXRjaCB1c2VzIGdldF9j
YXBhY2l0eSgpLCB3ZSBuZWVkIHRvIG1vdmUgdGhlDQpleGlzdGluZyBvbmVzIGhlcmUgaW5zdGVh
ZC4NCg0KPg0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGRpc2tfem9uZV9jYXBhY2l0
eShzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc2VjdG9yX3QgcG9zKQ0KPj4gK3sNCj4+ICsJc2VjdG9y
X3Qgem9uZV9zZWN0b3JzID0gZGlzay0+cXVldWUtPmxpbWl0cy5jaHVua19zZWN0b3JzOw0KPj4g
Kw0KPj4gKwlpZiAocG9zICsgem9uZV9zZWN0b3JzID49IGdldF9jYXBhY2l0eShkaXNrKSkNCj4+
ICsJCXJldHVybiBkaXNrLT5sYXN0X3pvbmVfY2FwYWNpdHk7DQo+PiArCXJldHVybiBkaXNrLT56
b25lX2NhcGFjaXR5Ow0KPj4gK30NCj4+ICsjZWxzZSAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAq
Lw0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGRpc2tfem9uZV9jYXBhY2l0eShzdHJ1
Y3QgZ2VuZGlzayAqZGlzaywgc2VjdG9yX3QgcG9zKQ0KPg0KPiBJcyB0aGlzIGV2ZXIgY2FsbGVk
IGZvciBhIG5vbiB6b25lZCBkcml2ZSA/IEl0IHNob3VsZCBub3QgYmUuLi4gU28gZG8gd2UgcmVh
bGx5DQo+IG5lZWQgdGhpcyBzdHViID8NCg0KSSBhZGRlZCB0aGF0IGp1c3QgbGV0IGl0IGNvbXBp
bGUgd2l0aG91dCBDT05GSUdfQkxLX0RFVl9aT05FRC4gV2VsbCwgdGhlIGNvZGUNCnF1ZXJ5aW5n
IHRoZSBjYXBhY2l0eSBzaG91bGQgYmUgdW5kZXIgQ09ORklHX0JMS19ERVZfWk9ORUQsIHNvIG1h
eWJlIGl0DQppcyBub3QgbmVjZXNzYXJ5LiBJJ2xsIGRyb3AgdGhhdC4NCg0KPg0KPj4gK3sNCj4+
ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKyNlbmRpZiAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAq
Lw0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGJkZXZfem9uZV9jYXBhY2l0
eShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBzZWN0b3JfdCBwb3MpDQo+PiArew0KPj4gKwly
ZXR1cm4gZGlza196b25lX2NhcGFjaXR5KGJkZXYtPmJkX2Rpc2ssIHBvcyk7DQo+PiArfQ0KPj4g
Kw0KPj4gIGludCBiZGV2X2Rpc2tfY2hhbmdlZChzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgYm9vbCBp
bnZhbGlkYXRlKTsNCj4+ICANCj4+ICB2b2lkIHB1dF9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNr
KTsNCg==

