Return-Path: <linux-btrfs+bounces-9004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9B9A4995
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 00:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3581C1F23CE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 22:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF8190462;
	Fri, 18 Oct 2024 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wr6igucZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cebi8ERm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23D188010;
	Fri, 18 Oct 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729289979; cv=fail; b=mQI/xGzwI1ZJIdqeDl728uoe5UpmR6LLxqnoPA6Q8YeZP7H/g1zIlHiaSu1uOVynZ2abxFSRGi+ICHBHlI+sg0SID/HdXCmr1KzjDcGXJ/tP+nqJcDMFiMEq6ho9VYlasPJ0EMrjr7SwuP6/r67S1Vmgv94u0f5UyKBCf1xH1ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729289979; c=relaxed/simple;
	bh=oQ4MKIVHEtoiE66TGJBeEiTNL3k7s+3q+Xr+/YL5w2o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3K/qD7wrBC45ZgN5ux7aVYJQA1GPBxxGr66Q2LmLlccqmiUqJJxBF8I96H8nv4P/92RWTA8HQhWWPeTvVXTIjDEvEDz6WYF3NDAKWrDCUTy7/yAGsj3kjBX3ww3STx9FxQC3u6QxLTW9U+ixdDfeGq4y9n12uBGWe3JWR6GTWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wr6igucZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cebi8ERm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ILuiDU027830;
	Fri, 18 Oct 2024 22:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=w9AMDvUT1ERUd4z29PkOlJd32tkn2G6ZPf+s5CUCsEc=; b=
	Wr6igucZBpgKkbHA6tg5nXjaJAjY66gSB5sAi5Xl0gEPRlp+deOWIRS7EeGmIyGN
	JfzyYddPZmXtsXcYKduGdyJ/ZUW2QlwQ2Fs0AtVy3qEc5X9IGxT2wKkSjbKavhuR
	53T2Do6uSslQ694oPhhJD0CPDz/6Jko+HjZ1dRfz73CW0aQrq2ED1VY2m/vlyPA9
	LSwa/8vtCWhchVQ7V4h/I7YsiwwFrau67YVnRlHZty8kMWwHCJaVQdgRYtOJcEpd
	HCUpwFEILvAOA1ohn3Wfc+2wS15A7UDqpcXyZHg4BYsZl8xk5MDUCgVBj35kwQsV
	8mY1EdyzT2arhmY0UZ965g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09s7gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 22:19:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IJmAxC026718;
	Fri, 18 Oct 2024 22:19:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjrfbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 22:19:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6YKT9ugliRSzVcyXdYqkLdEWDsQ0OAc3R0B8yma4xUBAQ5R4nZWBMe1ZKpc6uAoiCH692mIyAqyCcPveluZoLvufnQ0BEMc2Hbf8zUyyRAMlDlh1JbvtjIpuNd5HSuECH7GW3Tcx4KCNL0cKsCmIOMylsl0gtdI6fIQ9PJ+v4ktaPVXOl1pd1WJV1UVcR6ebQPJVbqn+osZcBbWxMIvWTEpOS6L/hrGQiWq5AimIbWkDs4fnXGF+RZRNRpkIAYnlX99jGCSss072mylBvRSY5Hm59H3BCzNNAtWkRMLtArl29qJmxhLhGPTNdOAVYaqH2lRH75KtElmLIFEJYr1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9AMDvUT1ERUd4z29PkOlJd32tkn2G6ZPf+s5CUCsEc=;
 b=XAIIDVHcpa/hTfNR/67sw02OzyQaplzDBXgRBVkrMcUkvFwuoUXkFzql/9I5DQAyiKWhhiaUbtHHzLb27pMpsO0dvSp3hVWjg1DH6+szLC/g8yVjgM71jPKWnILaj4nZzW/VO/znsVtxU2pGo0H5Dw+Ug5ZTUEdOpAl3S1B9DOw/Ef1ObhbtAA2qfAV/uMIvioFbcAWDUlx3QcGFqX6A5LXSw7ijCvfmdZBaPC2p6Moei/3sYTMyEa9DwfthE15T6hl3dFDvGmUt13YOvWLbvfFXkSsoHphh3pXduiQXgWL4OfFmoZChfzYPXFdZIdvk5HP1s8WNXEpT1ffI0hNgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9AMDvUT1ERUd4z29PkOlJd32tkn2G6ZPf+s5CUCsEc=;
 b=cebi8ERm/q5P/oB2z+oFw0ugcjKft3FaXZpbbXziNvtd2ENlbW9agezUV5kC8Q3EM1x0F2G4R+y331CPh2hNeiiztY2d1OOPvhb26uQWB/FE2kfICSlhQH/WyuIzxA9JbchWqkPny7hshXram1hw0qqkzx0xcjERb3pXW/DP3IA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 22:19:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 22:19:24 +0000
Message-ID: <ef523540-c7b3-4827-ae9f-ea55130f5060@oracle.com>
Date: Sat, 19 Oct 2024 06:19:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: add test for cleaner thread under seed-sprout
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
References: <20ebca40c55ed9207b6ea77aa50e93f3baf698ad.1729101127.git.boris@bur.io>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20ebca40c55ed9207b6ea77aa50e93f3baf698ad.1729101127.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f5f23c-4976-470e-23bd-08dcefc2ebfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJWVGtpSnVicm5RRzZUOVJ0amkwTisveTN4Y0ZXbFU3bytIOFJIWStxNWQr?=
 =?utf-8?B?T2JqQ3RPbkdGOFlMVzVKQmh6bmI5MzRDZ3lzTmc4Y1htQ2t5TTJDZkhSUEZK?=
 =?utf-8?B?VUNJenNJQTZuR1grUmFjQUFzSkpEQk83bi9VWFE0cW9WclBERElFcm1IM29k?=
 =?utf-8?B?THFhaEdFNzdmMHkyM2lTWUZiSGFKMURVNUhhQk9CdUFxQzVNOVBQREdwWnBp?=
 =?utf-8?B?Uk5aSVJHM3hFcnl1NXc3bnEvOTFVV2NKcSt3blBRYVoxQ2Q2bUhYcTA3VU96?=
 =?utf-8?B?c3IxcVBBbVF0ZjA2OGZLcjNxNXpZYXU5Um1CWEtLYVM5TE10Q0MzaDZIYUxh?=
 =?utf-8?B?NW1DQXkwVXZkek9rUm5JaWlwN0d6dXpmT2hXYzRXenR0elB6aEJUQVZoZGZk?=
 =?utf-8?B?bHNpSHZEcUltc1FEWDhEWjQ5UitKZGJFK21vQ0F2TjhYM1RJMnAvYUJyb3BQ?=
 =?utf-8?B?TTNFbEF6VXRrQjhCRld5ek04RG5oVFZxNC9DSjMrRzlpTG5YMHNJY04wazZn?=
 =?utf-8?B?RDF6TWJvMFIyNllUckJHdStITUJPaVhrQzRQclNCSncrUFB3L3F1VUpoY1Ay?=
 =?utf-8?B?VHd3elNEdEc1bU9TSlRFbkp5KzduY3lQVTIxWlNQNk9Tbm1ySytzODdvTnRk?=
 =?utf-8?B?VEFpUzRma3ovWVJmaVNOZDNEcnNqNmpwcGdzK2M3MFBZRFRGTXNyb2V2ZTBB?=
 =?utf-8?B?dGxsUHJmOG1tYVE5ODNIZHFvZ204QVdYQ3FpeHkvNFVUbm1mZlM2MUlpNUk4?=
 =?utf-8?B?T1h4YnNVWmFjYXNiSksxaWJBMi9uaWkrblMyN1R0U0xvNlR5T3VXdnNIUFFQ?=
 =?utf-8?B?cGVNQnVTbGhLSHFJVUdvK3hWSmQrWDdJSGx2MFdUVDJwK04wN29IUm1aaDdn?=
 =?utf-8?B?SFFISVAyaDB0cXRCL1hOTnpkT2R0MW01RjNrYWlNaW5pQ3dXY1ZkVWsvbjNh?=
 =?utf-8?B?b1E3c01FdHhuZE1obThNZWRYUTBTMG9VTUdTbmQ0RVl5WkkycFpwbFdpYlBw?=
 =?utf-8?B?dk81RzR2YmN6dUFZdVRoc25iT09HL1FqaVg4WWNiTG1ic3MxeW5UNUxuWklr?=
 =?utf-8?B?NjVpYVkwcFhacFhPbXl5UjNta1JmWjhvanVvcXdIYjE2TmM3akQ3Rm5UMHQ4?=
 =?utf-8?B?a1FKTWg4Y0MrUWkydnMzdjN0S25CQVB3bHFQNFlwZ0s0MmxVOWdsYTlqWk1s?=
 =?utf-8?B?cjVBbDYxcUlwK2NzWElNZ0RaNlVISERHZnFET0k1N2VjYkRXL3haV2tZQUJz?=
 =?utf-8?B?ZmtWWmlUOGJ5K2lCQ3N5ZGMrOTR3dmxmL201OURyY3M3MFVsUTBnSVFzb1pJ?=
 =?utf-8?B?M0k3R1djVzhLNDZhY29GSW5DQ3ExMENjeGdGcTNnY1RnUUpGbE5BM3ZQeWFW?=
 =?utf-8?B?dlgzRk1xWCtDa29PeDMrb2tXMjUrd1VhRW9ZR1ZmWlVrUi83dVlqRlM1VDAx?=
 =?utf-8?B?dFozZENoczdjNUlnTkVGM0pWSmpDUXh5ZWlhanZxREo0WEgwSzQ1YVFGWFRP?=
 =?utf-8?B?c2IrcFZNSFA5Uno2a3gzWE02TW9MbTVxdlU5bHhuZWEwN0lveTJUdXJJcm8v?=
 =?utf-8?B?ZjZwSXd5bnQ1SmhYaEhKby9vc0VoREJrQWJDc3NpMDlod3kvak5MVkU4RWFw?=
 =?utf-8?B?eStHL0Z1ZW1wUW9TYStTUDU3ZTVpc3A2aFpnU21lZDE4VU5SaEVub2xHTnhk?=
 =?utf-8?B?VXNXZWxwUHMvSXJoTEE3bHZUczVUcUJmT3N3KzlValRuaGpBaFVrZ2JoaVlr?=
 =?utf-8?Q?IxqgRggHfZwWSRyrYTae3BAABoQQXdf+KDMlGNx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHVtOXVvMVBwdDg0THFJNCtqbHN6TXFoSmI0ZUJ5WmxyUTlYbE9RMEdvNENv?=
 =?utf-8?B?WGJIWlViTXQ1bWZCM2FIUHhyL05DWlk1emprQW5PS0x1b0tWQjl3Z0k0TjdX?=
 =?utf-8?B?MXBLUmlYd2pldlhOYTRrUlB6elprTnBwTk9TbUlCUEpZanEwN2FOdUM1S3N2?=
 =?utf-8?B?YnlxaVdIUCtkOWxmVVJ1MzBTd0ZtY1RaMkVMYjBvTkliN1RjWkIzYjBUNHYv?=
 =?utf-8?B?T3BPblQyNnFNWDRnbmREVzlqeklhbjJEV3g4Q2FXc0RpRGUrN3JPT0VkODFv?=
 =?utf-8?B?ZkdQMkJDemo0SlRZcVpmS3l1V2VOcHJmYk1ZNXhvejcrclNSSmc2VUdzOGVE?=
 =?utf-8?B?eTdkMmJpUC9OYnNTcnhObjArMWlmYXJrUTdIZnMrTWRUczJLUE12VEtjRkpo?=
 =?utf-8?B?aXRhektialc0Yktud01uU2NsYlk0cE0veHd6dkEvM2sycmxPYkJkeDlVcnVW?=
 =?utf-8?B?djF0dkxjeU5FSXA4QXM5YmpYWDFvbnR3Q0N0Nyt5ZXRpTThJN3QvTU1QYzBF?=
 =?utf-8?B?ZHBBQVRET0IvUWZCYUxUWUg4VGJnejdaVWJGMnY2ZGprVGkvUHFrd1l1NFBU?=
 =?utf-8?B?M1lGdWhjQmpYRDFvM0VYZ1BhR2d4Y210aS8xeVhxV1VGT0xRYXpXb28zekpO?=
 =?utf-8?B?KytCT0dZTi9JRUNFQmJOTlZyZFN4Rlg5MjlxdkU5RDVhNml0K0thZVhYWTl2?=
 =?utf-8?B?eWtrampoM2ZnSkE0dFJpWmpBVDRrelBrcnE4M1p2ZHdCM29udzBBTFdlMkFD?=
 =?utf-8?B?aVhEb3F0M3E2RGN3VGQ5RXMyR1B5ZHlpV2k2RDA0MXg2VkFReU9adWRZUTFM?=
 =?utf-8?B?dnFTY2pKSWtOREtuSS9GN0s4UnZLemx1Y2VVU2dDa0VjNm1BT1dPbE9QeXNW?=
 =?utf-8?B?QUc0Z1NLNThTb1l6eDE0bmYwNC9IWmxlWDBDaHhIc2pMaDB6c3l2WVZLS0Nt?=
 =?utf-8?B?cXp0L1RML0J6VWh6VFVMOWVRaFpQWjBDWjVjRFpXTzQ1NTZuS1BpQnFCYWM3?=
 =?utf-8?B?bWZ2UzB2U1lrRTUvTUMyTWxsdi8zRzBxZUtxd2ovQWxvWWFXVUJxMkFob1VZ?=
 =?utf-8?B?aGdZL3p0eDczZW1LTVc3VFdXRnNTY2FlNTRJT2ZrQUdhZnBVcThVL2Z6WnZm?=
 =?utf-8?B?enMzZG5oVkk4Rm94TFNCQkpxZTRTZ0IrUmwxYWNEbG9YNCtoL3lyR0t3dGl6?=
 =?utf-8?B?THJSeW5IQ1lqQUdoVFZ5SHpYelRIbjdqU25JMXp4L3hlZEFpaDhtaDZkc3Ew?=
 =?utf-8?B?dDU4cGpxbVA4UUtYRDRrZE1TekFvRG1WdTF1eTFTeGMyNXUxUkdDT0tsZ3dN?=
 =?utf-8?B?L1Yrb29PQll4b2NPeXF0cEt2Z3FlY2N2WU1NVVZHTjdnU2NlMGJwcFlkZm41?=
 =?utf-8?B?c0FTQjRUVGllZnNLdXNsZE0yRndxMGk5bDZmVyt4SzBiSlFJUjRDWk9TeWhL?=
 =?utf-8?B?V0xQb0lpTXNWZzNaakFZbTNyM3RhV3VyQmlQTG4vaVkvdGxVTkY4TUsrOFYy?=
 =?utf-8?B?b3pvd1FxeTBabEtwb3pTWHBqcXFsTGcwV0tBOGFWeWR4eS93Qk02d0pRallJ?=
 =?utf-8?B?S2g4UmRNZnFENVM0eTdQMmR6N3J2Nys0RVZNSEo4OVZvdGV2YkhWUXdoYzVi?=
 =?utf-8?B?L25uT3YrNmdpblpJYUdSWjNqMmMrVnU1NVpJa0RudTFzSUwvM3p0VmVKbFpX?=
 =?utf-8?B?UDhHTENBTElqakk1OE9BZlhoSXNNTjl0aEdxQi9KK1Z3b0lTZTQxbjZSTm02?=
 =?utf-8?B?SXptWklBcGM2TXJibldYditQd01LMFdRZUdyeUtJRFFQcjhUUFRtRXNVakNl?=
 =?utf-8?B?cldQT0lVZGw3a3BvNlVoOW9hZmdsMzZudUdTTG9relkxejY1MTlsYWtKSngw?=
 =?utf-8?B?STh2ZG1teUVINUpGL0p3K0ZoNUFWYjFtMUFsTmlneEl5ejg2VTFBNnZqdUI2?=
 =?utf-8?B?dDJ4VUxaRFdPRG9VQS8xcUR1SDhNM2pRekFESGJOcFpMeTdTaFNQTTdFOGx2?=
 =?utf-8?B?UUNYRllHZXdRTlBwR1ZzbHNVK1N3Z3FKZTErbnBTblJaaGs2M0ZReHlLb2t1?=
 =?utf-8?B?OHpjMlpFM1ZnWnUxdG9QK0tHOStWTjE3ZnJBZHdsRnhPSXI0aWFqVlZ0TWJK?=
 =?utf-8?Q?TfWLINDqpbxgC8n60O4GAj4Ak?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqNm8T7vPOxGLx0fPGJWRLtQEa3Y3r3oHt0692QHhm7DBnU7PESo6Z3LHnKFeu5WulP1eBNTRTMb3u6B6+JCx4beSy/rbx9MXg0PXr3PnJB8GJVJ4dinY4egYyk8wk42dgANQ+uFixGl8mYt/1lFDyg0TwpCdgEfVAScipvLrjxucWQWXHCBz/kLPp18okD1/2k9g8yRH53mCcltogU+fXA5G9FQlHuqb7Bvcu0MkGQIGx/VeLGwz+TKNG+j9elHXAFqKFYlVhluCzqt/O1Ml2MjJECcH5EL+J+jQHesMKKLHSIZhmVKpPkdDBRjDJ/7iga+ssVdY1EPw4HM3LjxCqP8RRFd30oMXtLqPk3Bi3y98PL8udRjMBAt1+f2kTiNdYKfdmgh4AYnE738RB4njya+OVnPbV2uoQVx2O+X85IzgWiwH8iCEvmNde8Q21h5FCQkkM74CjMu/7WzdrKRKNFFmguPmje+7zHL+Dklafk1CRiVxN6PkBmiwYa9KeUrXQV7QIwk11FnXbufsfZaEKwF3Kych/DaTJDuRfYms1qdmL4yiyteOi6NnfwJ4ztomMGcxLAKpE8ZYJSAvzlDRHntKDvOtgMaBI3677zTNJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5f23c-4976-470e-23bd-08dcefc2ebfa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:19:24.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSTDMW97/qTChWG7craUr0P6KF8lAwYBQP4hgZkrpk7xKrOA66b+URobEL+tqqiAsVJKnh4qC6UGG2kdtxj7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_17,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180143
X-Proofpoint-GUID: fyTYjyIbg6AAJHC_g1Js9fPHuOhcRKLw
X-Proofpoint-ORIG-GUID: fyTYjyIbg6AAJHC_g1Js9fPHuOhcRKLw

On 17/10/24 01:54, Boris Burkov wrote:
> We have a longstanding bug that creating a seed sprout fs with the
> ro->rw transition done with
> 
> mount -o remount,rw $mnt
> 
> instead of
> 
> umount $mnt
> mount $sprout_dev $mnt
> 
> results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
> critical btrfs cleaner thread.
> 
> This test reproduces that bug and detects it by creating and deleting a
> subvolume, then triggering the cleaner thread. The expected behavior is
> for the cleaner thread to delete the stale subvolume and for the list to
> show no entries. Without the fix, we see a DELETED entry for the subvol.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v3:
> - add volume group
> - switch to SCRATCH_DEV/SPARE_DEV
> - filter scratch devs from mount/findmnt output instead of suppressing.
>    This adds the expected read only message that comes with mounting seed
>    devices to the golden output, and makes the ro/rw check more natural.
> v2:
> - update to real copyright info
> - add extra rw->ro transition checks
> - remove unnecessary _require_test
> ---
>   tests/btrfs/323     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/323.out |  4 ++++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/btrfs/323
>   create mode 100644 tests/btrfs/323.out
> 
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 000000000..4e389d66a
> --- /dev/null
> +++ b/tests/btrfs/323
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 323
> +#
> +# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seed remount

volume

Zorro, can you pls add it while merging.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks
Anand


> +
> +. ./common/filter
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_scratch_dev_pool 2
> +
> +_fixed_by_kernel_commit XXXXXXXX \
> +	"btrfs: do not clear read-only when adding sprout device"
> +
> +_scratch_dev_pool_get 1
> +_spare_dev_get
> +
> +# create a read-only fs based off a read-only seed device
> +_scratch_mkfs >>$seqres.full
> +$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
> +_scratch_mount 2>&1 | _filter_scratch
> +_btrfs device add -f $SPARE_DEV $SCRATCH_MNT >>$seqres.full
> +
> +# switch ro to rw, checking that it was ro before and rw after
> +findmnt -n -O ro -o TARGET $SCRATCH_MNT | _filter_scratch
> +_mount -o remount,rw $SCRATCH_MNT
> +findmnt -n -O rw -o TARGET $SCRATCH_MNT | _filter_scratch
> +
> +# do stuff in the seed/sprout fs
> +_btrfs subvolume create $SCRATCH_MNT/subv
> +_btrfs subvolume delete $SCRATCH_MNT/subv
> +
> +# trigger cleaner thread without remounting
> +_btrfs filesystem sync $SCRATCH_MNT
> +
> +# expect no deleted subvolumes remaining
> +$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
> +
> +_spare_dev_put
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> new file mode 100644
> index 000000000..1ca2e4b13
> --- /dev/null
> +++ b/tests/btrfs/323.out
> @@ -0,0 +1,4 @@
> +QA output created by 323
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> +SCRATCH_MNT
> +SCRATCH_MNT


