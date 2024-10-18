Return-Path: <linux-btrfs+bounces-8998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8F9A3D99
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 13:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BE81C247B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 11:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF38EADC;
	Fri, 18 Oct 2024 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3ex/RuN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wIRyRf9C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60F15C3
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252489; cv=fail; b=MUN5be9C65pO9F9B9VVqO3p6HVK9FsD8nSc6AE5xojieboCdKQiBLEZnjO/O5dl0CZ4zWZBMxRonleQNU79f8v7TGoJsBZTjtSLiNzKb0a+UmCoKN+Um/6Yk0NrGUAgxjUuPQYgoeYlsdMrlMCoAtI3HhT7HTcHcYRQ4e9BxTSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252489; c=relaxed/simple;
	bh=lV8a8SdGtGlHRldx91A+M36zU3qy6zGjTBuyeoEmjxk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmykNmTUCEqCphSEkKXeTOo3uyg2bScM/kzQKp6L0OCx17l2LU3GHqI1PjUotdjLGH7kYbzwCO3CpWvBjnypbVnLdUIy69jirlLmk4NTA0nfQIepWwDg1kpSLXoFT2n6jqQ2NyNunPyEW3hSBo4u67T9mFldDK+yp2rNRVfm1mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K3ex/RuN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wIRyRf9C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBsC0i012241;
	Fri, 18 Oct 2024 11:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JmoMA4sDqedQe7QCguMLXrhVdsCE9op2jDJC2MmERbw=; b=
	K3ex/RuNTEdbPgGVdt6/N5NE+Q9t1glsfakFmj6fAmm8I5db3Ms59RMwrLz8JTrx
	/IHHyr6pGiD7SI/peHv15ktKTTpLGe17q50Q9ytwIfuYEHNh3Ui5x+vtZPSEyqnj
	2INOO0CKuHkCpdFbkDWd2KvF3JROInBz2T8jPz+gs6mV9o0ldgb5T4fyng5CCQvH
	3lffnYqj29RHrXrn6JRi9BsezMdJxQBcYop67q6wxlhRg/QFdDo9IWW11w4bdlbD
	Bn28HLqJSivDm9pJ8lwRY239/E3CuHebnIHdaj0tRI30Stmi0GPrIwXwry2uedhp
	js4vBPqhicveG/WnXHkg1A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2rqhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 11:54:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IA6SvU027236;
	Fri, 18 Oct 2024 11:54:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjj41p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 11:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIHTMTaf6C2dYuLEYuoYiWQPMHw587Ip36h9dgcI56ikutIXDnO0BVwvvGgGBALYv4rW1184A55W8IKmrGmQEPf8V4401vc9Lc3lpZYDEtpujD/txhXUg25EXdGcHeKOHiGPdfYqFR+C5R33G+NtvgS+vh+jy2yhWKbVAu/nTo1DrL247/lHxxaRL9XmAV/brARFBDijvS5JDWEpu/iR4qvJrIGTpqOphWViHUBy03rqQs8vIHrZrxtmXIcmkwFYoD8ZDFD81ATgPIgHfPsU/Gng1/n0EQpO8Rx05OZcT+fAZzATcqR3B4f5bqaGebwDUEbbC9McN8p3fmybjmPe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmoMA4sDqedQe7QCguMLXrhVdsCE9op2jDJC2MmERbw=;
 b=nG51eDwW8CxGFjEcsElf7gOXIhgt9T7nY27AqW8sHtERbZOyyLmZU4pOB8C5VR0i3JWHOjhzUNmjmmv391VHC4fAgtWlW/r7+CW2ea9U/PAI74uEqSSiwAoln+3OGBHnR1ZEElmz0kz5T9E9VsKz/XeS7GeZcoukUeZH7H+cbbIbGaeKozbsEFB0y7YCudrQt1jNz02XBHiH8fJOpZFW1f2M7fwE2g4WRC9cVDw3vgvj/JTdWNuZOen/W3axuiACOmjtCk6DBVSd2MK2xifGuN5C8DHJxHpKTNvc6Tm+j7DeIS/XRhzxCEzLixKflIYP3FiYUJ/SUpuu2iF3UWkX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmoMA4sDqedQe7QCguMLXrhVdsCE9op2jDJC2MmERbw=;
 b=wIRyRf9C1jWrJmFGhkeARTvKQFXhSIAny5gG/S6rEVO+aoMRbFgztvX6+H+TrskhSl1OqLT60g/jr+QKX+j1qfIyUmXZLlB3zWcHEdZ9tKj6hqz0LfwYwQWotd4su0jPBAaxvG8C+XRc8EEat+sHcapCJpz1J8nECcsxTvGscs8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4271.namprd10.prod.outlook.com (2603:10b6:208:199::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 11:54:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 11:54:37 +0000
Message-ID: <56258d9b-484d-4340-b6ad-82ac8648a03a@oracle.com>
Date: Fri, 18 Oct 2024 19:54:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <694552b3-5f70-48d2-a62f-4c2b8caf10fd@oracle.com>
 <12c0bb30-7ee5-4aec-9fe8-f40ee01ec9a7@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <12c0bb30-7ee5-4aec-9fe8-f40ee01ec9a7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6087f5-d5ec-4b5c-46f5-08dcef6ba3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJzdmpPS1luVWdiU2oxem1HaWFTUHlMbFphNVVpajhraXY1OEtQSDU0d3Zw?=
 =?utf-8?B?dDM1Q3loSndpeUpkN21ZR1kvSmlKVytOMUpLejNkSkZWelBmZ3J5Z1NwSFpB?=
 =?utf-8?B?L3dOZU15dGxVeng2aXpBZnVCNzllZ1MyZHkvYlE4VlEyUWlyaERqZkhZaFVG?=
 =?utf-8?B?WERkblhvSXd5b3cvTXUrYkZuSTR4TkhJbjJJam5KYUEzd0lGMUh6cXV0dnN6?=
 =?utf-8?B?Ni94SllDQVZJWUJxcmd5SDdpcEhHLzFtc3JuQW1ObEZ1cDdVMXlFUlVsZEhQ?=
 =?utf-8?B?QzFyVEtTaU1oVWRqaFNSL2dIRHJ6MjlNYTFQMXZrbFJFZE9QN3pORzdQajdC?=
 =?utf-8?B?T09WYi9UaXJURGxpNnZsV2xMNVlPQXRmL25ra1BsOVZ6cWFpay9WZ2V0N3Vm?=
 =?utf-8?B?UW1GWnY3aEhidEpNbkNNMCtqclYrV3Q0SkVrVk1FOXU5S1oySXB5YkhJTW9F?=
 =?utf-8?B?T21VQ25BT3BKOHdYNXQrQzR2UFNQbDZpaEhnaTN6NEpmditGd2pXanRNekRa?=
 =?utf-8?B?K0JtMFN1RkxNQkVVZHpudE9tOG1vTFk0NXZWWk1JY1hzeVJseVd3YkFEaHJ0?=
 =?utf-8?B?b0oxNksvWGphOEtVbVVOdXM2akVCN1BFWnp4VDQza2Fkc05FME9JK05qK2pJ?=
 =?utf-8?B?a1lmWU1ORmZ4b0xTODJLaFJnY21Da1NzdUo1S2Q1MFhET2l0VGNvRU1nT0w1?=
 =?utf-8?B?dlVxOFRGaUdnVmxQVXd2WDMxOVUreEpNd3FlNjE3ckpQMldKcVlTT0hnN3M4?=
 =?utf-8?B?TU42K3JhdzAvcitNV3hNVXpKWFRSWWJCMC9HbHZUdWx2TkdraVBTNXJzektK?=
 =?utf-8?B?RFVnQWY0RnRoMkMrZ2ExVXFHZ3c3cWZOM21MdmppdjY1VkNiMVZ0bHNYNHBu?=
 =?utf-8?B?YmxndGFDZ0FURUVFMTE3WHIwR1g4MjJTQjRrSXlLYmpQK0hSOEhxRldnSmNj?=
 =?utf-8?B?c0tSTFQ2d2k5V1FCRUUydERaZUFNVlZ5dG5OV2ozV015OU1ycExrbk1XdlBt?=
 =?utf-8?B?ekYyaEp4K3Q5d0xBSllUdEJBb2R0a0xxRE5uSTJWTlFTaDA5dnZQT0NqTWpv?=
 =?utf-8?B?Uk9NNC9VRmx6YThwK21kMWE4MGE2NkdzM05pMnlCVHF0U0Z6TFZ6eURTMmt3?=
 =?utf-8?B?QlJpcVJBSzh5QnFabGpQTTdvaEFjTWJFWG5makVGc0JQcTN6cmJaL2JWcVk3?=
 =?utf-8?B?MjNKSUZ6d0hHR0hFZTlZaVZ6U0xPeHR3aDIzU056andUeElHMjZOVHNjaTNW?=
 =?utf-8?B?bzR3M2wrNDdsZHYyRkpIQStMSTY4MTJDOEoydlMvazd4cHFWZE9mNnVFeDMy?=
 =?utf-8?B?SHFlODFVdWxxa0JSR0VsQ01EZkg0LzJXRU9sWGxEblFUNENMMTRyejg1S2d6?=
 =?utf-8?B?dkpMTFZvTFEvSUtCZFhoSEpHOC96VG1JR2IwK29WYWFPRWx4VXhDdy9FN1VR?=
 =?utf-8?B?VWJEZ283V1FGa0prTHpxa09YcXMwL0QyaG9nbXczMEh0b0c1OS9RT0V5dS93?=
 =?utf-8?B?SncrVEQyMGNXMHQvSi9wMjhpS3BKczExaHR6aE9wMkd0MHk4MU9YUkJqeFBK?=
 =?utf-8?B?WHlHSEJ2WXBZblV3NGErRlRzQm9CVStROVdvaGJmUTIxYnAzZGJrc3dZS1B3?=
 =?utf-8?B?bTRDTnZvVUgxdXI5RXZJcnpxUWE3Zzl3SUN6U2RDcXU5WXRGOW5adDVKSi9v?=
 =?utf-8?B?cWNUOU5vQmVvUS96MFFwT09sYVBQS3ZqMWZ6d0lwMDFMSjhROCtQWG13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5RNldPMWdDTUV5cG1Sbm81TXVDRXBtWjBLSExkVUhnS3JBR1RyY2tCT1Jm?=
 =?utf-8?B?eHZtblFzYWQzaHVKVDh2ckp3aS94Mmxtb2JRaXFhanJIWWRpdWpLVTdmaytv?=
 =?utf-8?B?Z2dUU3RoWkJ6Q3Z2Ykdvb0IyV2F6b1FSZCtpVGU1M0EvVEN1bHk2aThGNjJU?=
 =?utf-8?B?RzR3MkJRenhlTW96dXJYQzZ3WlJ4Wm9LK1huTGxQeUgra3VOLy9mUmFKK1lR?=
 =?utf-8?B?WmF5WGg3OWhEb2JJTFZpaG5EUkRMYkNKU3ZoNGlhbFk1dS9sWjN5V0t4Ryts?=
 =?utf-8?B?V3F5eHF1YVpReGlOdjNwS2pTcE5JblNmSXRqdzNwN01oOUxpVUJoeFZ1QkIx?=
 =?utf-8?B?MmZLV0tKeEliZ2NFblQxQmpnYnVkL3FoaHh6Tjh1bDg3Y2l3bWtOdW5ZT1N5?=
 =?utf-8?B?a2pacTUyWjBhQXE0TkFTZFJEMnFIUVVob0o1K0lKa0J2VXZFbC9mRXM5WU92?=
 =?utf-8?B?TXI5cEtxTlFTU0t0QWczbzR2K01BR0pXOTZJYWJpM09TQ1NQejNkM2UvZWdr?=
 =?utf-8?B?UzNma3ZMMVdaeTg0UzRQMFZEanFLNUNwZCtKWDdZdjdUR25rSVlWNyt4aTBa?=
 =?utf-8?B?V3AycWxTVjh4ZCtWZ3IzQ2RXTWtiZUdVWVRsWEVkWWhueU0rNHN3VGRHd0ND?=
 =?utf-8?B?OHNUNmJPTEN4Yk5OL0Z3dHJHdnJBbnIzMER2RUQ3TmxodVpIMWt0VGtQLzBr?=
 =?utf-8?B?akpHTGY2eXNTUTl5bGtUeGRBTVpFQ1JuR3dVSE9PN1lTdWx3UjBUYVhNLzFU?=
 =?utf-8?B?dFdWbVp3aHVzd0JpZFk0WERubUg0bThDeStCajM2cEtNbkZOZUt0UEdQczd6?=
 =?utf-8?B?U2JJYzFJQmpvVFhlQ3VUbXQxK0RhOWYvQ1JaZXFZa0IxWTNSNk03cU5aSU9S?=
 =?utf-8?B?OHB5QnVUZzZmWGdLQU5hUys3V2JLOXZnN2E2WXlDZGhjUjZWbG9aWDRFbVRS?=
 =?utf-8?B?ZDBFSGFiZjhVZlNmVmJHdUIwM3BwdEF4TmhRSmxqZVcrT2FDdXlLNVJvUEJw?=
 =?utf-8?B?MlV2WEZueXI0TFNRSDc5d2FHS0FPaUxJcG5oNGhkT3o1RWUwOG1zTE5GWXVx?=
 =?utf-8?B?STJxaW1CYXN5NlZNdkdhL2NwcWt2WUo0UlFLKzdhUUdHR3hSYzJZd1RTQUxG?=
 =?utf-8?B?SG5aZmhodDJCN251TXR0Ly9RZUg5SW1MdXl3V0dQOU5WUTRWeHI2RGV5UGJN?=
 =?utf-8?B?Sllta3VUM0laYkdpWVY5bnI2ME52MTM4UnplM3p0OEpRdzZUNEYyV3lVa2lE?=
 =?utf-8?B?MmwrWUdHRXNrcWhjOFByd01YZmN0eFZpWWV6TDJVTW5Pcmg3dzgzZU4vY1hX?=
 =?utf-8?B?R3U5Y2t0Q1Bod2lYUUJMTktMbjVnUWpXVHBPWSs4N0RFV2xtTTZtRkltcHBr?=
 =?utf-8?B?aExrelpiQkNkYys0L1dYMGt5TnMvdXlwc0JoVU5sM25yTTYwaTl5VSt0ajE2?=
 =?utf-8?B?TitPeWlVT1QyaHVNOVQyK1ZsY01RVmYzK1REQndwTlBtK3ZoUjRIUy9CNU9t?=
 =?utf-8?B?Ym9UVCtjKzFONGRhNnFXN0FCd2hDRXBTYzdRVWVaRjdJMitKYWhOazk5QVFN?=
 =?utf-8?B?RGh6Y2g4cWtnUUNFUjdKdjRnbk1VMmxlenY3Z2QzejRuRkVsZVRmcXFNTG5u?=
 =?utf-8?B?TDN3R05MV2txWFlFWEp1SnZpZDd1cjQvOEh1SWxGbURrc0tQL1JHTzc2YXVE?=
 =?utf-8?B?TG9leDdDYUY0ZUI0VWpQVUhmN3pOS3FpbVY3TEFQYzkrd1d3VVMyR0c3eXpw?=
 =?utf-8?B?RFFheXdGb20rUjRFWGVlSVM2cWZUaWNmOG55Mkl0NTZpOGVxbWpMN2xVQTI0?=
 =?utf-8?B?WDhXSXlaR1hjK0ZTUlh1bEFOcGNjUGpxc2o1RHgyZ0hxamhQeVJEVnd6TDdZ?=
 =?utf-8?B?VXg0RlhUcVJqbDdhYW5BamJFcDhWemFvQWRpRjBSeEdqdjNkblMrcndUZEN0?=
 =?utf-8?B?b0RSd3VtWUk5RXV0cFVOenI3cVlZRlZNTWRINWNIeUxDcFA0cksxV2JFdnVv?=
 =?utf-8?B?aCtoSVVRelRJaERqdjdURmhFa3lpWkRqZ2ZDaWwxWXNGOHhOaEgrbFNhUHdH?=
 =?utf-8?B?RmhwaU9oQXRuUE52dE9LcUF3bHBSQ1dSbDZkVk8xVlBqQ0d0RmZzUTV1RWV6?=
 =?utf-8?Q?i7DYUi9zfGjoHHCj/aPAdj6B0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lwSXnMjUoKAc/s67tDmQ1WMxz9Ukr2rp0eLhuwOWLtUy2r+I0PE40+jByOybM6cGit/Cbwyab2uTRmkVwKe5LXaNPSub1r9APrxgWhLFH8OdZep+Kkow7ioyfCI2zOpaa1B4IDgIYuoX+gfI7sfK1UsIeKGyRHIRq4iNPld5H4xyAyTipVJhFT6gTKREXYX6Yuts3w6CWYMkui/uGNtsUwI0vQGbEwtuBrhT749vCqFgXa9WpUjYyan5+MjT9/NGNaASYs3Yl32n4bmX7AwyiUHbjlAvP+zqPSRSqF9rf/LJzue1BFnWudGOM6l/qcMwTX52gY0inCqV+MjvCsZwxdi5dpRJzYLh2gqfTf2lfGFyG/MKh+Ia1e9bCJ/XLVw7IVzClHckSHC8ju/L3RfAvSuvPf2TnARfacXfaZlQObpaOUu/J25mSLgRTixmx1XCx1+KiV/x1W6IDoDY2kSPhQPqEgmQtY3tpspvGxzzkke6brN5JzincG/5XBY7SNE9ijB4aZbFGzLCsOL+3Vrcag0almX6PaAoS5oTtz5SMGMpmTzGCD1PIPFak+AA2qH/ww5Q+ZJweCv5Wd7w0jSxJh+yGnwV0LCyjjjabq+nou8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6087f5-d5ec-4b5c-46f5-08dcef6ba3f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:54:37.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiZl4l6Q1oVL9Ot4kM3M9AR5UO0JBx5GOrJnODUht+RUj0z4kYhLgbuX9rJDxcsQlpNlgqkTfbOhyc+1kfP9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_07,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180074
X-Proofpoint-GUID: W_Sd6i7nQ_telkxBaV9HZF7TX4dNZSfH
X-Proofpoint-ORIG-GUID: W_Sd6i7nQ_telkxBaV9HZF7TX4dNZSfH



On 18/10/24 04:47, Qu Wenruo wrote:
> 
> 
> 在 2024/10/17 03:44, Anand Jain 写道:
>> On 16/10/24 05:38, Boris Burkov wrote:
>>> If you follow the seed/sprout wiki, it suggests the following workflow:
>>>
>>> btrfstune -S 1 seed_dev
>>> mount seed_dev mnt
>>> btrfs device add sprout_dev
>>> mount -o remount,rw mnt
>>>
>>
>>
>>
>>> The first mount mounts the FS readonly, which results in not setting
>>> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
>>> somewhat surprisingly clears the readonly bit on the sb (though the
>>> mount is still practically readonly, from the users perspective...).
>>> Finally, the remount checks the readonly bit on the sb against the flag
>>> and sees no change, so it does not run the code intended to run on
>>> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>>>
>>> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
>>> does no work. This results in leaking deleted snapshots until we run out
>>> of space.
>>>
>>> I propose fixing it at the first departure from what feels reasonable:
>>> when we clear the readonly bit on the sb during device add.
>>>
>>> A new fstest I have written reproduces the bug and confirms the fix.
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>> Note that this is a resend of an old unmerged fix:
>>> https://lore.kernel.org/linux-
>>> btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io/T/#u
>>> Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
>>> were also explored but not merged around that time:
>>> https://lore.kernel.org/linux-btrfs/
>>> cover.1654216941.git.anand.jain@oracle.com/
>>>
>>> I don't have a strong preference, but I would really like to see this
>>> trivial bug fixed. For what it is worth, we have been carrying this
>>> patch internally at Meta since I first sent it with no incident.
>>> ---
>>
>>
>> I remember fixing this before. I tested on 5.15, and the bug isn't
>> there, but it’s back in 6.10, so something broke in between.
>> We need to track it down.
>>
>> The original design (kernel 4.x and below) makes the filesystem switch
>> to read-write mode after adding a sprout because:
>>
>>     You can’t add a device to a normal read-only filesystem
>>   so with seed read-only mount is different.
>>     With a seed device, adding a writable device transforms
>>   it into a new read-write filesystem with a _new_ FSID and
>>   fs_devices. Logically, read-write at this stage makes sense,
>>   but I’m okay without it and in fact we had fixed this before,
>>   but a patch somewhere seems to have broken it again.
>>
>>
>> (Demo below. :<x> is the return code from the 'run' command at
>>   https://github.com/asj/run.git)
>>
>>
>> ----- 5.15.0-208.159.3.2.el9uek.x86_64 ----
> 
> I also tried it on upstream kernel v5.15.94, the behavior is still the
> old changed to RW immediately after device add:
> 
> [adam@btrfs-vm ~]$ uname -a
> Linux btrfs-vm 5.15.94-1-lts #1 SMP Wed, 15 Feb 2023 07:09:02 +0000
> x86_64 GNU/Linux
> [adam@btrfs-vm ~]$ sudo mkfs.btrfs  -f /dev/test/scratch1 > /dev/null
> [adam@btrfs-vm ~]$ sudo btrfstune -S 1 /dev/test/scratch1
> [adam@btrfs-vm ~]$ sudo mount /dev/test/scratch1  /mnt/btrfs/
> mount: /mnt/btrfs: WARNING: source write-protected, mounted read-only.
> [adam@btrfs-vm ~]$ sudo btrfs device add -f /dev/test/scratch2  /mnt/btrfs/
> Performing full device TRIM /dev/test/scratch2 (10.00GiB) ...
> [adam@btrfs-vm ~]$ sudo touch /mnt/btrfs/file
> [adam@btrfs-vm ~]$ mount | grep mnt/btrfs
> /dev/mapper/test-scratch2 on /mnt/btrfs type btrfs
> (rw,relatime,space_cache=v2,subvolid=5,subvol=/)
> 
> So it looks like it's some extra backports causing the behavior change.
> 

Actually, it is caused by util-linux, specifically the libmount.
v2.38 is good, but v2.39-rc1 is bad with the same kernel without
the fix.
Unfortunately, a bunch of libmount commits between these
versions are not bisectable.
So I have no specific commit but commits from 2b1db0951b9d
to f07412a04ca8.


> But I still strongly prefer to keep it RO.
> Even if it's a different fs under the hood, it still suddenly changes
> the RO/RW status of a mount point without letting the user to know.

Just my perspective—typically, we add an RW device to make a seed
filesystem writable. If one command can do it, that's great from
ease of use pov. But I’m fine with RO; it’s cleaner.


Thanks, Anand

> 
> Thanks,
> Qu
> 
>> $ mkfs.btrfs -fq /dev/loop0 :0
>> $ btrfstune -S1 /dev/loop0 :0
>> $ mount /dev/loop0 /btrfs :0
>> mount: /btrfs: WARNING: source write-protected, mounted read-only.
>>
>> $ cat /proc/self/mounts | grep btrfs :0
>> /dev/loop0 /btrfs btrfs ro,relatime,space_cache=v2,subvolid=5,subvol=/ 
>> 0 0
>>
>> $ findmnt -o SOURCE,UUID /btrfs :0
>> SOURCE     UUID
>> /dev/loop0 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
>>
>> $ btrfs fi show -m :0
>> Label: none  uuid: 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
>>      Total devices 1 FS bytes used 144.00KiB
>>      devid    1 size 3.00GiB used 536.00MiB path /dev/loop0
>>
>> $ ls /sys/fs/btrfs :0
>> 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
>> features
>>
>> $ btrfs dev add -f /dev/loop1 /btrfs :0
>>
>> # After adding the device, the path and UUID are different,
>> # so it’s a new filesystem. (But, as I said, I’m fine with
>> # keeping it read-only and needing remount,rw.
>>
>> $ cat /proc/self/mounts | grep btrfs :0
>> /dev/loop1 /btrfs btrfs ro,relatime,space_cache=v2,subvolid=5,subvol=/ 
>> 0 0
>>
>> $ findmnt -o SOURCE,UUID /btrfs :0
>> SOURCE     UUID
>> /dev/loop1 948cea35-18db-45da-9ec8-3d46cb5f0413
>>
>> $ btrfs fi show -m :0
>> Label: none  uuid: 948cea35-18db-45da-9ec8-3d46cb5f0413
>>      Total devices 2 FS bytes used 144.00KiB
>>      devid    1 size 3.00GiB used 520.00MiB path /dev/loop0
>>      devid    2 size 3.00GiB used 576.00MiB path /dev/loop1
>>
>>
>> $ ls /sys/fs/btrfs :0
>> 948cea35-18db-45da-9ec8-3d46cb5f0413
>> features
>> ---------
>>
>>
>> Thanks, Anand
>>
>>>   fs/btrfs/volumes.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index dc9f54849f39..84e861dcb350 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
>>> *fs_info, const char *device_path
>>>       set_blocksize(device->bdev_file, BTRFS_BDEV_BLOCKSIZE);
>>>       if (seeding_dev) {
>>> -        btrfs_clear_sb_rdonly(sb);
>>> -
>>>           /* GFP_KERNEL allocation must not be under 
>>> device_list_mutex */
>>>           seed_devices = btrfs_init_sprout(fs_info);
>>>           if (IS_ERR(seed_devices)) {
>>> @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
>>> *fs_info, const char *device_path
>>>       mutex_unlock(&fs_info->chunk_mutex);
>>>       mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>>   error_trans:
>>> -    if (seeding_dev)
>>> -        btrfs_set_sb_rdonly(sb);
>>>       if (trans)
>>>           btrfs_end_transaction(trans);
>>>   error_free_zone:
>>
>>
> 


