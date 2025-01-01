Return-Path: <linux-btrfs+bounces-10665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82849FF4B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD8A7A1199
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81FE1E25F1;
	Wed,  1 Jan 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AyoR8WfU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XZTLsRG1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E3633EC
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755008; cv=fail; b=d8yZjremWj9QnlWy36O3pOwOwkwucHctr/yoKQuNMvwu4WxGfTjC9yBIbP/NPZG6AGKf21c1V++XnD5y4KoTLPA24FJeia8dvuuMdZs5VepDSEvu3PnMN9+gM6/sFpjLxq9W781C02RsvurNDGillyorWKoDsnymXU/coHnRyB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755008; c=relaxed/simple;
	bh=GlhoRK4qeeQRrNbfP4o4PjZinEE/wFIFjCyoojDDiIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIVXMLpzU5AsqtW7xhleTrVKzewnSvOayQvXh3lj8xs2uyMtVX5icqOhguC9qXvDcXrYftSBjYZ2+zy/0qVMiKfjUYJlYTBXotbjbY215UUl1sFTAHKSo4eXl/WVt9tmMPuoTx0D6GmjgFFMfa46aZmB4Fsil4zNZXqBtdfrGRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AyoR8WfU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XZTLsRG1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501FlLaq028112;
	Wed, 1 Jan 2025 18:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8mJiYkJ5HxKBAig/15cQ2jG/ySttNkt4oQAyRlWFm9I=; b=
	AyoR8WfURYekzLoYP4jwirAXiZsGzRJjRjXQQVRv1X+XBniNwj35SR/+o2Dejxfr
	vJ3H/BaOzAAUoDHE70tRFxmLR5kifYSvJ/q1kIEQBozPfcSAvATuQD5IPLCAZQ/v
	iebWmWr3jfJZefOd4Js9A1AbZu1Ys2kBA709zrKK8+pnJRacsktIXr17dxMwAzkY
	FjZzBiVgquWcgFBBwt3uNxgeUO0TMexdrQt3ppKIzU0gooGyTu+wlUrtkPDJWyMA
	RM50JvvmXm7wjvuO6zVuEqGWfBFovfnnZzBkegK6pHU/KivrqVFj3jmKbhQ4Im1K
	aqvcMb0jTYJ3s2zxNinFMw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978md3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501Ej49g027818;
	Wed, 1 Jan 2025 18:09:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry0ygrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqAjWQO0D3ovSHP0qNyVduu941HE+mwi+S1x6urOgPG+iEiQV8+U1XH/4m/tC/qlFhQKIMP843HBX4Fuzbe0g/Nqxo05NYP56tvxzI/9GGsbFKSI1AT/lke0OC5Ty8fuCFKGs1gvav1xw03SC6XGGaJ4XNF4u/Lpw6WVv3NuC7J2emMbSDlmqkZk81NrgF2ssuie4VOEVzHgplWDFHTGq1tWe10ydcMkVlJCWr3NPnk2IdeLaS8I47JH3xRFzLeiaTRVroin5/1aRg4RH9q5n8E3wgWOxdpf+Vw7BfLtiKW1dU8or19HOjT0OW/GDtt7kBk7HwbksoS4kW+FyUAQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mJiYkJ5HxKBAig/15cQ2jG/ySttNkt4oQAyRlWFm9I=;
 b=oEiuD4vztcU9zRUpfCJKC2W4Q1s5NtgHn3l/1cqxya+kV5d0LvDBLG6IUIE9unXlSj6epeaw5iLwokWDGletWbPpbX+252cYP696yCPdbiGYpCpXUnl0gUjzWE+HEuxeN/HuyEMmTgTH07AWFdDUi/SEIYMmCmHa27AGGlwJ69DF2+w2Z7kaiE/kHkgjpuUve217538R5n7uS+2xsRBlGEOzWDE0SjC+0Lvsq6LYq8n1PSxe4Qu8CQnec7oTqi7TdeH0NN8NPsUOsB6PDJtLtMz4GHWvcfS27uddWjVLozPcx53nhIygPYp6++9VrDV2NLhd4Zd6smgOYZBSpq26AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mJiYkJ5HxKBAig/15cQ2jG/ySttNkt4oQAyRlWFm9I=;
 b=XZTLsRG1Q03WGxGrwDqnJblrTmrEhAtEXP7jxaFgmor3xzZlq0WVarbidzMct4M91xfDxYmD1aSRMn7FnroLfnDe09IumOLilRNWVQsVmSRe67sLVO4uG49vtxFP5RxTQOchA7VT4LXsri0E8VIWOE8sVKk3+CpnxoMhPyKihGE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 03/10] btrfs: add btrfs_read_policy_to_enum helper and refactor read policy store
Date: Thu,  2 Jan 2025 02:06:32 +0800
Message-ID: <3f4ce63b7690aa207fc6cd220ad7210883621986.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8c6321-3926-4e6f-71ac-08dd2a8f77bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CUv+O0e8Hrn5qLcGXE1kd9u0jsRxY+fRoAvZTDvytYj4cjQuyP6uzxQAVDf?=
 =?us-ascii?Q?wRtjYWUtSgUtVBphq09a/pQ0578E/WMwDsxzuU2XFBFVC3pvQlJGg8D/ROiz?=
 =?us-ascii?Q?vu6AY2iBhGm3zrE3danJncixzqR2BIY7QfXuEXPqxww3Fmvwj7SWlMd2SzjH?=
 =?us-ascii?Q?/YbppZtVU0jxud9vw2DRC2jYz6qkT6HUKjzu01NJc1sE6YK3m0yQJXEP1YrR?=
 =?us-ascii?Q?2cbxrKMj/ICrPISrnAMQTmdhrCXQ9ttNb8EiyozIlx3NCjtTdTv6GO3HrVvK?=
 =?us-ascii?Q?ZsnP6ZLXWvZt6qXrfCIAlTFP2RmU62KCcsxacSuACgPIXeN6NoC2foNWLUR6?=
 =?us-ascii?Q?3ZQiQLdUfo4jVctXvNZVvHloyuSAHURUZOKB0PV5xM5WTPzh1XX2Sgag8CNh?=
 =?us-ascii?Q?QmWfaKKUNiZOm+fai8ZU80LyLypJPxlQZPjfWwsv12+wd7VRWM5IxZSgixg7?=
 =?us-ascii?Q?Fk1yDvAbMsyItO3VEHIOuPhsPYYXBrxpfNs23rsBEBtYMM0nw2cUkKUUW0Sy?=
 =?us-ascii?Q?S7b0KwlIhVcFbM4r/uqjFW9wSqznc8zYhy21Vh71QgETX70ZGYmyJ7UrvMTx?=
 =?us-ascii?Q?T8z2Yqxx8/uwtvIoEWQJO39CLzFCt9WbOUpXMwIrwNpmxLMhqc5aOwwcIyfu?=
 =?us-ascii?Q?gW0O7E3hQNOz/RLoXAq3h10sl8JR/t9svqeuGiwlANwzIEyCnbUGNvIa3kbw?=
 =?us-ascii?Q?h0h5Hx3gydJ+YiTkhe1eqKQnXH8NyaSOSUGdRnnJcNKQ1NYxxWHpR87M8jP0?=
 =?us-ascii?Q?xgsKE+BGVQqj+k3gDA9bLswGYMmxK1v6R0orXTU2jH7I2M02wWH9h9L7cLQ8?=
 =?us-ascii?Q?ds4BCM8PUIscXfvoOmov2xNlfUQnCMgQHOoOkBACrNB2hzFejAacTPjp6kjv?=
 =?us-ascii?Q?InfWM5C4wyKilggf2KRz21l5EubTJoO75YviqDpRQ71F+4kKxIGuDGkWeMf7?=
 =?us-ascii?Q?MQ18kyOdsUHE9jkxbHCk2LX3BQxZI3yrHaWsz95eaAaKoS1Kgc7JkyvoEcII?=
 =?us-ascii?Q?qan/aI7pB+70ml+kxJD72at3L9Cj39MB8/jNxDpeGQaWsh2lGKc6Rp8NzCXX?=
 =?us-ascii?Q?pZkItx1I4LZiVUMV8px/t6SGbldVjYSyM83FFFO51EhtCLrajJsPGvfeZQwB?=
 =?us-ascii?Q?jzHZMX251KtclU7iyZMQx0VgHEAS93NVFj1/0U/ArYSgMNO6TtIDstMvGDIL?=
 =?us-ascii?Q?a15a2y0awxoVGfThjCDW65wc2my2fe0zXfldvWJ9V5YKro33bslodE1FzRj0?=
 =?us-ascii?Q?JZrVMyRlZNCZBGL7bQF5OyxOkls7pKp//k+lxKG7FYTS61tYmq7LWc8yBaLq?=
 =?us-ascii?Q?4IkUcWtFAxQMUqBDs1dKhTWlA8NzJLHz8a4HSqjaFtX5G59bxm4R18mMKhWM?=
 =?us-ascii?Q?6yfgNlbDn6qRFZw/noH6ofCjQR/E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tapEwd0o+kGcfaxUHaI2H+pBaTIHU/I9wviR2pGuDWg50o0hgxPdGcGIV9tl?=
 =?us-ascii?Q?WLBaL2eCnHX037cViddr6XKxgr+Puh016qv26/0E06tgM6T1EHm8bfAfsJ4N?=
 =?us-ascii?Q?rHug0hRlomLEP2HFGLWb1MIm1rGKODP0Dw4Rxx9iY07PuFH3KOFbaxhVfcCY?=
 =?us-ascii?Q?YzrK62KcPHXZV3TAodXrDImw81vD8gr+LgpLkJEzKmBB4zHAkf5y3cf9Sk6/?=
 =?us-ascii?Q?revd07Nih/hWGqE73PJII8M2Ew4IGjK6HyCujfLxbkREEQQ3/buN9XDoCCwD?=
 =?us-ascii?Q?sUDJcpzUiPYMDq2336l9c6a4mH9MiQbwnl8vCas8RjgJv7kQ0t3sJv45aAoI?=
 =?us-ascii?Q?wiFLpJADQEQoABpaeKvzKtpMqCCukip9viw4Bj4Ip0z4U/aTpM/CYBkMzep+?=
 =?us-ascii?Q?YLtnhuo+4t2LFgeX9/JQoWr/uQOQui6ZbJW0+cOH8WTJnfyo0FKYG8eyeJPb?=
 =?us-ascii?Q?gM5D7KHLQ0h4Qojz1jvC+UMOS38ynidSo+11NAQU/BA6yR6kySofjwBI9M1R?=
 =?us-ascii?Q?C4s/QiYrokzHcjHX6eJ97SRiaQrnwdU3iNReuY+6hbtP2MecaXi4LF7bGPc5?=
 =?us-ascii?Q?E06Gtaz9L+yaDlmeo8tLbJDO/UTGECy6nlUX6YJV7KGrKWyW+QWeGwZic9I3?=
 =?us-ascii?Q?3wd5W6WFxaDAINU9B7z0KWBaSjX+q+LD6yGE04d4Q9WwO3SUFHRtmf1bfmjO?=
 =?us-ascii?Q?psRCM7H/8cVnVwusr96r2oUiS2ir+4RXMh7GyNc/knSN2wJjOgrXO4+KzifH?=
 =?us-ascii?Q?nk6wcT8MsJ4SimqSr602INzZImG7Z5ARGn10wjl1OgdJj5mQSdd8c8uqsAsH?=
 =?us-ascii?Q?gvHkLGNLyr7BqSSBpKmOti6uBT48srd/sEJ6GvHCVMk/Ru90qX/G1AYlkxrp?=
 =?us-ascii?Q?ic036IA43xcl7RUCU7ny0WjE3Vs0BmmdPfOPNdP1JwBFbD3bnrOThWNymeo5?=
 =?us-ascii?Q?JN4xAHkY/wJ3blojNvy5Arp8ryzQ5Gekb1V/5v4aWkDbhCOFNRwz3p3rNNqQ?=
 =?us-ascii?Q?eTd/q1cp5cOrm6YzUvSJFbm6iG/xvj18YQRkGUYsVO88PGvCdJ99C7qIQIBu?=
 =?us-ascii?Q?RpYoHSHv0SqCbOKqJUhOwPRR39LbIAm4UUM7DdVwLXkMkcIurzyaEpJ372Nw?=
 =?us-ascii?Q?n2sk/TMjBZjMqWJ161ICGjQbqBGvZi+GbhZHgIowp+sxPgNzTisNnfiBzvg5?=
 =?us-ascii?Q?NwODklCyFGb8GVf60Yu8oEWKpy+FSyRsUKSLoYl9lunBIVDzgNaVlaz7vw2u?=
 =?us-ascii?Q?7gmWGp9qTAhdm8pG52DVyEtduK3o3DxkRiI7twYIVVxcbFvGOFWcV/lm9Gu+?=
 =?us-ascii?Q?JCgwbNEV38S73We6KhruWGfJYt83vwUzHwCnBdRkd3eC+AkBe/18Dc0/eWQQ?=
 =?us-ascii?Q?WWiB3jYq2EjwpD+2StSsgKYFGfXSPCNSwqRy3Pn7PqNDe3OmxtnBmfISwba7?=
 =?us-ascii?Q?MdU1UpNQWC3p+q+ARnnM5ftZYe5XpnnelF/4i+XALsgnTSU9jygPnRJAYryn?=
 =?us-ascii?Q?MBp9I6CSATl6pgpTyUqiu4kDVCzONEt7uNLcBTOUIdHoXH9Kj7rQHOyCiiLk?=
 =?us-ascii?Q?sXRXU6jG8TBAyD4FyH1HjGYVz582Mqkbkuhy1TI8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PxKlp4wUBks4WNE5lghkoIzpxK3KiZXJIMnz9LgeM6DxA0+E6WekYlwfDPHDU69BnpTgqWyQkk57lCofNMoZqwvdMJbrtC/pOjORfEgWXjE2Fq1aGe/ViSPOYLL2pD8CQq3cmUOZ+ydbhT7UzG/9I+9HKgkiWmhgo47QjPFyw1OG5i8krgGEErMv1oYOdvyNDyeL+HYW4/hQhVH2c69FUAMhcx4PoXDeuog7BHNEVjHJ1GCZsqAoIbJxCsVIp3+8g+Cn3QY23KQDTHVxth3o+TXyU565Hu/oZfT7bRVjXoBUJz+vJ8YPqwa8Cm/CvLRA6hW3uTaKw+xQOjP5uGWruxPAZz0R+JmW4TWrUPKkIBsnqBZNHuB3oCjmK7c4H4HicywweV/OtZ5PKf/083qOl9hMdKdiQssaAfZVIOlhRLEDYTQzb0kzNICJmgmQvjbhdOv5iS3NKI8s9xGojuzJ7VkE8Cy3VJ2sHuClwTA3bh7f0zuhMdA3tuJjRibGT5kt2L+yZdnA5Q7p58GS2dDyhNpSyf0dEjXG2e84bbXV/1NtOkdYsdqucKbyfg3ok0lSbWkENAxq8THQt72MiciYQ1GjVBw/HCeRAKhS4W3Hfmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c6321-3926-4e6f-71ac-08dd2a8f77bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:43.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AjvFYktK3DNiMnoLK+9mwifFFeNvU3pnTsZ+mi5OP649oDUI5y/jSRBIJo2tDmMYXOoj0EnCEHMVUV3agvNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-ORIG-GUID: L9XcIJNU1Wrv9X7FdrvGPKkKNtOgo2Ut
X-Proofpoint-GUID: L9XcIJNU1Wrv9X7FdrvGPKkKNtOgo2Ut

Introduce the `btrfs_read_policy_to_enum` helper function to simplify the
conversion of a string read policy to its corresponding enum value. This
reduces duplication and improves code clarity in `btrfs_read_policy_store`.
The `btrfs_read_policy_store` function has been refactored to use the new
helper.

The parameter is copied locally to allow modification, enabling the
separation of the method and its value. This prepares for the addition of
more functionality in subsequent patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index fd3c49c6c3c5..3b0325259c02 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,6 +1307,18 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
+static int btrfs_read_policy_to_enum(const char *str)
+{
+	char param[32] = {'\0'};
+
+	if (!str || strlen(str) == 0)
+		return 0;
+
+	strncpy(param, str, sizeof(param) - 1);
+
+	return sysfs_match_string(btrfs_read_policy_name, param);
+}
+
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
@@ -1338,21 +1350,19 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       const char *buf, size_t len)
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
-	int i;
+	int index;
 
-	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
-			if (i != READ_ONCE(fs_devices->read_policy)) {
-				WRITE_ONCE(fs_devices->read_policy, i);
-				btrfs_info(fs_devices->fs_info,
-					   "read policy set to '%s'",
-					   btrfs_read_policy_name[i]);
-			}
-			return len;
-		}
+	index = btrfs_read_policy_to_enum(buf);
+	if (index < 0)
+		return -EINVAL;
+
+	if (index != READ_ONCE(fs_devices->read_policy)) {
+		WRITE_ONCE(fs_devices->read_policy, index);
+		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
+			   btrfs_read_policy_name[index]);
 	}
 
-	return -EINVAL;
+	return len;
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
-- 
2.47.0


