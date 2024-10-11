Return-Path: <linux-btrfs+bounces-8840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E6999B34
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 05:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C30F1F24ABE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 03:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719881F12FB;
	Fri, 11 Oct 2024 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="czY6pDI7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xdEQPKb+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A9804
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728617730; cv=fail; b=NFYhg1gFlrlu0UZAj4PC8FeUvcDDMYFC8q64mLmhyjY+DuqAn8lXKlV1RBeqkeHBiMnTyrdKUhk3nrZ11yvoYsy2QRNjl2zIx6gF0nVyoQQ4YZG4R2B6tfEXE9443RZdktNeBmJkSeVkX9oprAAH/k7JX/Vyft54zNlUJCUeYFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728617730; c=relaxed/simple;
	bh=qJ39kfBPnz34+cAo4VlqmVZzOwtjI+/KcCfXcFuabDQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dwS+Bi3SaI7oZavXgBpbDkKp1DRn/Vq8lAl6zyii4PuGwFadbbZ7h0LJO8GBo0Ofk8CARO04xtDCuvwgxgGdPmlRZgl25ObYWhOsEshI0sYqqI8jmUnREX8JydWFFRfBgR/p4ObQOTGgo8p01RRD0do3eGhN1q1sLCf3Qv+5Zrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=czY6pDI7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xdEQPKb+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtdXk010809;
	Fri, 11 Oct 2024 03:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Fkh7iCAd61D7NFsWNf6HVnNk5UmmBnJK7WpvvFdTItY=; b=
	czY6pDI7HMLm7ctLjXOFqUoMl9iJLNJzb/3PAJfjL9zlqieHdeLQqjN39AiD1bmL
	DlzizM6GM2YNUsIA0qlGx5w7wICd9MG+ucdn4rI24DPQHNJFCTc0g4VLixCel9qp
	PgO+qFWSN6ASXjtUvkORu/gu/zVh6SouYxYNlGssg5HuVq6fyx8rdPEIUxOlM9a5
	86Tf+Sn3WiW0/x7KadHj+wz9K2uGB8yZgN4yKmrWytzfpC7kAzNyDW+X8fPlk9fy
	+gUgV0ZFLqS4L/RTRm2XQitJg2W2HTmqv0Opa6I53hxs2vckk9ljSB1GNv41WRzk
	Y41fU1bJLqhoWBwBRbsX1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ym2ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 03:35:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B30GRg006138;
	Fri, 11 Oct 2024 03:35:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwh5yk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 03:35:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BALZ47sSpc2ZV9PjEQNjdEboQO5+46Y34Vj3m4GCpHwianx1rQxM2dOh17cjl70UT29LUZzBs3e7GBgXex+x0yFc+Ae+y+Pf/PEYN2+Hrs0b8p9hK9sSF8Ut9fSfWUH5hUPfxLHZ2bMgJ6flKeghoLMSA5ku5GhjpSlAugtO3LzUbP+VgQz/5xI8xyCgUhCGprSbKv/So/oIlFnaxCD/oqsAhOcUCS5mnqbVU9uZ8KHCqg1AFgJJ+L25zNBi/0Q7jcC/uorKKwDEAdwp8KZY+VkTfY9u0X3yXKRfGu7psQhD6rRVKXAVnkxPdfjFH8B9hFPLEhKz/55ATkgpEv5ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkh7iCAd61D7NFsWNf6HVnNk5UmmBnJK7WpvvFdTItY=;
 b=d2S5P/hRzmAXePQEKyyNksMevDFGu4C3OBsPJtkqJsYLt66srppT6NF6u60/jAYQCYzrarf9Bl8QHrciEz+6z80ugNRKU5wgBf3zYrYRT29XPNUNZt4V/XOkIFtCyWHZuUHYVqBZYB+/F5a6TsGfyPQH6WqHlGUkt2Pk4bMiU9sh3uO3kY8iGHBjY/F9s0aEJDO6AqZ+FUbhzrigN1+IPQ7qAFB4S7252HApHZ1TKf7alg7FWDU0LkeWFqPXkEyt5zdExCR0DV6ZxqLvJiTwmk75lslU/79C0Xzwm94UbgIUINRbto2XCX1vAvWHgdItJzW2tI55KFCFwVb93rxYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkh7iCAd61D7NFsWNf6HVnNk5UmmBnJK7WpvvFdTItY=;
 b=xdEQPKb+g24fTmCQlPuwddkb0yiJ4Ztsi6q+oSAb9Pvnb0rdnh8kSu3N9jEyQIQS6pYY+Uu1HoP5Ix42mDeGw8UKoRXXC6LrmfOHWsG6VTCY3BCHt3G0gcZM6WpfgMLtOjy+kKUXG1K16J36Ew/nUuDus4hM3y0yt/OeDzMo+J0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6411.namprd10.prod.outlook.com (2603:10b6:510:1c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 03:35:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 03:35:12 +0000
Message-ID: <662f66fe-8016-49f3-9c2e-6624a8fe3679@oracle.com>
Date: Fri, 11 Oct 2024 11:35:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
References: <cover.1728608421.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: e9706631-44f7-4133-99a6-08dce9a5b679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3NhM1RWNDZ6d2RlWmdsd2pmU0ZqUG50eFlpei83MUtmUG1FbmF6UDZ4V09W?=
 =?utf-8?B?NDFoSk4rSDZudTdzVG9XbThjU2dsczN2S3RkNXFTSWIvdEtUY2hvWHFuRjNV?=
 =?utf-8?B?ajZVUis0bEZvaFBBUmMxRndtekZjc0tZb3Y4TlRZS093WXdBaExNV1QyVFpN?=
 =?utf-8?B?Q2M0Z01pY2hDenJMOE5CNFowNUtiSWNMR2VUSGNzY2RPTVBFemwwc1FGNDNu?=
 =?utf-8?B?N2hrV2k3TzFaNzQ0SG5zZTFNcFpvUktVL2R5WnZ1OFYzM0J0SUVVMFNwV2Jx?=
 =?utf-8?B?b0NRNllDZUE2ZTlSQStwMmxNSUdZdTNKSW5NK3RLUThPd094aWozYjIzOUJz?=
 =?utf-8?B?SFU5L25FL2l1TzFhc25XZkFJRGE3dEwzd2p5WWtIdlc0V3hFYVVRRHJXblpG?=
 =?utf-8?B?VGVYNDNmeTlpWkNOd3NXWnRWMmdLRW9mZ05Ma0tQRmR0aHBlQmxSOHB5MHFt?=
 =?utf-8?B?NnpDQnZqbXBTRmxnRHBOMU5IVHVPdGdHUVBDbVZwZkg0VVhBWlRvb2FHa1hX?=
 =?utf-8?B?NmZkVHBnZFBOZHJhOG5RZ082YXp0UmV1c0pXSSt1c2UxZEVzMGxuNkh6UlRN?=
 =?utf-8?B?NURGb1JsM2E5K0xLZEpkdTh0V1R2UW9BNHlqVk1XUDRTbjI1Y0ptaVFRRVBT?=
 =?utf-8?B?cFN2Zlg2NExDeXJLL2lXYkpCU1Y1VjYzckEyd1BUWk0yTlBmWVdseGVXb0Ni?=
 =?utf-8?B?azlvaGZyVjg4NXJIVlpjaEYrUGc3MGl4a21KZFV5eUxZYnU5NkpKbG1hL1Bk?=
 =?utf-8?B?czlxVlkwOGJLTklCSTg4SS9Fem5EQ3RYbzZZNFRqN1oremMraUhPZ0ZKdFlJ?=
 =?utf-8?B?cVUydTFhMTR1UEhsb1lIbFpqYnBPY1BuTU9CZ1IvKzFNRFJyZkx3K2dQMXF0?=
 =?utf-8?B?ZUN6MHNWOVdSRHU0aUFhaU5HUE1qNDB2R1lUMy9TaTlnM1FWYjdqcFpkZEtJ?=
 =?utf-8?B?TXNJcTZySE03ajBJZWFNUUIxRnJReHAraHJkK1pEZ2o1Qm1BRExrdU5YY2NI?=
 =?utf-8?B?REpVeXE0OTh1UjB2UzZNeGptTVMzZEMxcHByaTNyK2YwRVlWU1RoK3JLWGJ1?=
 =?utf-8?B?NkdwRFZTL0dtWHVESGVqOWtSTUZINnJ5d3V1d2JxMjJVVm5nY2hUTkk5dnk0?=
 =?utf-8?B?dkxrMkVJQTZ0N2EyekdBUGxyQ29jeUQ0Si9GZkZqQzhRUFdTOXozTlZnaGNE?=
 =?utf-8?B?R0xsaS80OGJTV1JObUZJK3ZMMnFIN0lqc09HYmo1VEFFQjQwSCtYd3YyYWVh?=
 =?utf-8?B?blA0Q2NhcW9KSE5aQURSZDJ3MXFSSWNtSWxYS2ZOWjlGOHRGWjhlK2hHOW5k?=
 =?utf-8?B?SjFsUzkwdUthazJveXordHpRdlBpdld2WU1ISGdpVzRoRG5mcnNNZ3YzTnRT?=
 =?utf-8?B?eHozaSszZS82VUFFS0tsQWI3aGJUNllRVUhIb0ExT0IwZFFFbW9QVFlKM2Yr?=
 =?utf-8?B?MWl3dzNoZm5CZ0p6SGZPQ2JEMEdwb29QTjFuMlEzL2xZd2xaaUhHQXMvcE9n?=
 =?utf-8?B?ZXRjYnpmNEJocDRxUkgreUNhbG9RYXhMWXNHa2JaNE1kQ1ZTWnloR1BONWZk?=
 =?utf-8?B?WlBla0RQd2xTMUpEaDdBT0lhTVJveTUzeXhQWklBYjZ3dUlkWFlZU1YvRzBR?=
 =?utf-8?B?NGhXd2lVeUg5WkkvWFQ1dHQrY2k2OVRyQVUwTVkrSVVZUEhTWm9oN3Vyb1c5?=
 =?utf-8?B?S1lFY0RQNlpnMWwrMzYrUmw0SVQ0ZHM2R2lFeHZOOCtBSmh4bUw5dmtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEdnNjVoQmhPMDA0ZXIxRW82cW8xNk5ocW5tV292aUk4dkZBbXpKYWF2RHlS?=
 =?utf-8?B?OFc4b3gyU0pIb3ZlUEhUbUZIQk0vbXBlemUwVDhQNnkrQnVmUHpQSG9uczVx?=
 =?utf-8?B?Si9oRTlaVUNJdFFvS0dYc2o0K3RuWEk5TVJMQVhZc0lRMEp0MkRNQ0NzWlJ6?=
 =?utf-8?B?SWwyYXVGbm5KbGJ4UkczYnI5bmxkbGoza1MvUnJGU3kzWHM4dXJXV2lmRFJ6?=
 =?utf-8?B?WkxlUVBOTWFMQWEwekd1VWtrRGNOZVRYSUlIZGtGdW5BL2F0b2JaRXUvVUR1?=
 =?utf-8?B?ZC9UcytZUnZWaFNJTC83RnVqWWw0RVROaGlEaWV5Sms1QkM0K0poTXJnM2VL?=
 =?utf-8?B?RUt4UE5mbE96NlJrWGZPSkd5M09WUFpNWmMyR2lRSnlWK3gxVWdOTi9XNHJP?=
 =?utf-8?B?bVVLS1NUTTJKcjhBd3habWdqZGROUHRWVWc2OTAzSDN2UWZiQmNOMzdoVVJp?=
 =?utf-8?B?UFNVc0ljOXFWUmN6UloweS9WakhGWi9CZU1Ka095TmtUY1h0Yjdvb2E3WCtq?=
 =?utf-8?B?ZWg1bmhYcmVHelFYTTRNSDlQT0lzdmovbkx2UVZRMFhaczdWQmVBSlNBMmVx?=
 =?utf-8?B?OWx5eFNaM3BaQlhFM0ZuN014K3l0ak1JZVJYQ3g1Zk9SeDltZExCdnJtVzIy?=
 =?utf-8?B?TFd6UXN3RjhORlpLSHkyeE5HNHlITm5UYXBxNnhaMHhBSmhmV2M0Z1dIZ0Rl?=
 =?utf-8?B?cXFHNUpBU3B1VkhLWGJPZUlrRXFXYWY0Y1JJWDRCNW1vUGVVYjRBYVQ3dXNp?=
 =?utf-8?B?c0RManJReDBYc1FRWU1VVXlLVjlEbzc0WmNPNk1EL3dFK0s0L3NSaWEySVVT?=
 =?utf-8?B?N2RBNE1sWEx5d3RZTStSVnJlVUJwM0VsdDlGbEIzQ1J4TWVDemVqTVZMYUNT?=
 =?utf-8?B?cFRML1YranBycTkzQ3A0eUt3dy9kV2dLNmFvSWVlbUJJblZyVCtYNzc0TThk?=
 =?utf-8?B?RUY4VGhXNkpZZG94MDJpanlCbjZtamxpTkZad0RqVVkrMExQbE9BajJxTlZN?=
 =?utf-8?B?UFhMSVBxRGhLUnZxYm0xbkoxeUdXM2ZnVmRUcFBjb2xlMjZ3Y29EYXR3NStw?=
 =?utf-8?B?T0tYL3JObHBPU2hXRVdYVkhKZEZzcmdnbTN3YXQ2STgybE1CQWVqbUJqRHVV?=
 =?utf-8?B?MngxRmZNNWtlZmFJQXgvTWZqOHA0QldqZDBKRSt4ZEQ2WDJuQ1p5VkY5UVJh?=
 =?utf-8?B?MTR4SUJBNWJ4MWl6R2RzbmRkNE9ObzRzRVErdndDNHQ4VDNoWElUZVRzdm9l?=
 =?utf-8?B?V1lJUlRYYTgyYmJRbEVrSDdCOXVwdWNvdlViNDU5YStzUUdDWXREYjhnYURL?=
 =?utf-8?B?VjFGckNrZGVFYUdrZWM3ZVBvcmR3WVBwT1h2MEpXdXE2b0R4ejFST2VHc3hV?=
 =?utf-8?B?dkRzV0xLWWtQMFdUKzN2WUhQUXpWcjhtb2tSNmliOFIxODgxL1hhTjFoUUJ0?=
 =?utf-8?B?eVlFUWdZRzJwaW5XR1hHSlJzRHJRVGhMZFZOY3UyU0lIK0h5ZW14V0toU01G?=
 =?utf-8?B?R1h6V09DQnBDY0RWYUJqWEZlUCtQWGdwOVBqTS9JYUtQRXo0QzFMak9HWHdz?=
 =?utf-8?B?TFFzWVJGcXplYStpN3F4NVMybll4d1lKS2xkemp4TUczN1JralQ1TDY1MUhu?=
 =?utf-8?B?K1VtMmo2YU5rcGN3MVpBQ2Z0R1J2WTJSTjBVVStVYUtBVnlNU0kxVU00R201?=
 =?utf-8?B?bW9jdFpnV3cvVUlpc3Ruc3lHRTFtOXRiZnN4OXZ5OW9XelYvUFI2Tkd3eXN0?=
 =?utf-8?B?clFnZEkxcEZlZzd3OGZuOVl2US9UNjVGMkZBNU5Xa3BxWWkxekZkTmVVTis1?=
 =?utf-8?B?eDB4K2JXZmlHczQ5NmtaVEZzMFhrYnVkSEtLdWdEU1NJRUgvSGsvY0FMZzRG?=
 =?utf-8?B?VEpjQlJDV1FnR2RqNGc5YWtVbEhiSDhpd1QvbTVFT1dRYm1YUlBYWXNZL2oy?=
 =?utf-8?B?VEdWYm1IakNxNDc1K0J0aVNoSGlwM0wyeHhPc05nZU5QdndsMGNTeHcrcFhE?=
 =?utf-8?B?NGtTWlZxRldsNE9UZGRHbzBKVFdOSHhObGtuUFk5V1VKT1BTWnRydW1NaFZz?=
 =?utf-8?B?VmZtVWpUTmJXa1JmWU56ZXZ6YStsMnV2ZlhVTWw3THF5bXhmaUNNc2c5aW55?=
 =?utf-8?Q?A/ScO4/GD4j+oCHQp6K0MZPHt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f/RqsZTpDlZf0cV4gtDMaxtLPPZWlbe39wrzboFwiW5mudwfHMwx1Vu534RrFiLiLyNLcC5wVMs5EDz1nRYDUiPYQ7tNKYmrPawr6JDWMQuPcEjqDWlJJtfRpkETMlDHVPmj7kbqG+mow6t//ZGGxElqJRybSt5Jg5yIGwyP/a3PH8wzl1EWlbPD/M1zbNngMAnlj8mHJr2M0F7y7Cef+WP7T408c+KmzlWgC86TfoR2EhzVZHNEhCgc570Zv+zxiI35hKqdqO+ghX/YiDfEdu0MO8/+hsK/mvTRbpshEU1urIhcOEH5sDMJjDip4UHf/1GlUX5HUiFD9UYW+QkE8CBrkJOvd8pJdJZ9QYPPzTN7uVttvcy8LyfQCV+kHc34u29+F1qzdk6oXiFrlT1yEpnEhq8Z27U71LD9C0p6iGQGa6BPoBWt/VjzyBZXhTdmUvngZVTrqUM4QnoFHmuHULDh8FQo/4JUpr2sA4Hit/3bdt5c234Y/UVBh9YmJlh6nO+NqURHSbcKZ7LXFMcaHlKco3B9p9wu/dLld3qOAbHelVc7LURAEsm8nmF+RvVwI3mf38RTaYEcaQ1LtbpU7lXE88RCJIrpXR2d8lvFSFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9706631-44f7-4133-99a6-08dce9a5b679
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 03:35:12.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVA0m2+flYxb3i1wDJ8lTXHpe1HgWJP5J+jW4d91CySgWnqHkFA7q8H0bKFZsyKIRZasnyZW2F6D78qSDugYrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110021
X-Proofpoint-ORIG-GUID: HffBk-Z6Cabl0z4AsgamXQEGdCUFEck4
X-Proofpoint-GUID: HffBk-Z6Cabl0z4AsgamXQEGdCUFEck4



On 11/10/24 8:19 am, Anand Jain wrote:
> v2:
> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
> 2. Correct the typo from %est_wait to %best_wait.
> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
> 4. Implement rotation with a minimum contiguous read threshold before
>     switching to the next stripe. Configure this, using:
> 
>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
> 
>     The default value is the sector size, and the min_contiguous_read
>     value must be a multiple of the sector size.
> 
> 5. Tested FIO random read/write and defrag compression workloads with
>     min_contiguous_read set to sector size, 192k, and 256k.
> 
>     RAID1 balancing method rotation is better for multi-process workloads
>     such as fio and also single-process workload such as defragmentation.
> 
>       $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
>          --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>          --time_based --group_reporting --name=iops-test-job --eta-newline=1
> 
> 
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> | rotation|            |            |        |        |
> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
> 
>     rotation RAID1 balancing technique performs more than 2x better for
>     single-process defrag.
> 
>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
> 
> 
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 18.00s| 3800   | 0      |
> | rotation|       |        |        |
> |     4096|  8.95s| 1900   | 1901   |
> |   196608|  8.50s| 1881   | 1919   |
> |   262144|  8.80s| 1881   | 1919   |
> | latency | 17.18s| 3800   | 0      |
> | devid:2 | 17.48s| 0      | 3800   |
> 


Copy and paste error. Please ignore the below paragraph. Thx.
---vvv--- ignore ---vvv----
> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method is preferable as default. More workload testing is
> needed while the code is EXPERIMENTAL.
> While Latency is better during the failing/unstable block layer transport.
> As of now these two techniques, are needed to be further independently
> tested with different worloads, and in the long term we should be merge
> these technique to a unified heuristic.
---^^^------------^^^------

> Rotation keeps all devices active, and for now, the Rotation RAID1
> balancing method should be the default. More workload testing is needed
> while the code is EXPERIMENTAL.
> 
> Latency is smarter with unstable block layer transport.
> 
> Both techniques need independent testing across workloads, with the goal of
> eventually merging them into a unified approach? for the long term.
> 
> Devid is a hands-on approach, provides manual or user-space script control.
> 
> These RAID1 balancing methods are tunable via the sysfs knob.
> The mount -o option and btrfs properties are under consideration.
> 
> Thx.
> 
> --------- original v1 ------------
> 
> The RAID1-balancing methods helps distribute read I/O across devices, and
> this patch introduces three balancing methods: rotation, latency, and
> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
> option and are on top of the previously added
> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
> RAID1 read balancing method.
> 
> I've tested these patches using fio and filesystem defragmentation
> workloads on a two-device RAID1 setup (with both data and metadata
> mirrored across identical devices). I tracked device read counts by
> extracting stats from `/sys/devices/<..>/stat` for each device. Below is
> a summary of the results, with each result the average of three
> iterations.
> 
> A typical generic random rw workload:
> 
> $ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
>    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
>    --group_reporting --name=iops-test-job --eta-newline=1
> 
> |         |            |            | Read I/O count  |
> |         | Read       | Write      | devid1 | devid2 |
> |---------|------------|------------|--------|--------|
> | pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
> | rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
> | latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
> | devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |
> 
> Defragmentation with compression workload:
> 
> $ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
> $ sync
> $ echo 3 > /proc/sys/vm/drop_caches
> $ btrfs filesystem defrag -f -c /btrfs/foo
> 
> |         | Time  | Read I/O Count  |
> |         | Real  | devid1 | devid2 |
> |---------|-------|--------|--------|
> | pid     | 21.61s| 3810   | 0      |
> | rotation| 11.55s| 1905   | 1905   |
> | latency | 20.99s| 0      | 3810   |
> | devid:2 | 21.41s| 0      | 3810   |
> 
> . The PID-based balancing method works well for the generic random rw fio
>    workload.
> . The rotation method is ideal when you want to keep both devices active,
>    and it boosts performance in sequential defragmentation scenarios.
> . The latency-based method work well when we have mixed device types or
>    when one device experiences intermittent I/O failures the latency
>    increases and it automatically picks the other device for further Read
>    IOs.
> . The devid method is a more hands-on approach, useful for diagnosing and
>    testing RAID1 mirror synchronizations.
> 
> Anand Jain (3):
>    btrfs: introduce RAID1 round-robin read balancing
>    btrfs: use the path with the lowest latency for RAID1 reads
>    btrfs: add RAID1 preferred read device
> 
>   fs/btrfs/disk-io.c |   4 ++
>   fs/btrfs/sysfs.c   | 116 +++++++++++++++++++++++++++++++++++++++------
>   fs/btrfs/volumes.c | 109 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  16 +++++++
>   4 files changed, 230 insertions(+), 15 deletions(-)
> 


