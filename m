Return-Path: <linux-btrfs+bounces-9742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E39D0736
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61933B21AF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F615D1;
	Mon, 18 Nov 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YiygTl4Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gh9QviyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40010E0;
	Mon, 18 Nov 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888746; cv=fail; b=d5geeJv57fv3yfDAOz+MeTZSqMND3q6ykVSHjHwTAjb6GFkE+5lzE+Cha4R0ycm1CrBaMEhpAqvdws+163Kz0ZvmmMvxJohgRXQpKng2xEAHd+QS9PFX8vITAmrIhtT2oZ4VC2/rbIk0tyIHJ/YVlRTGTXeJQ1oevhXCWruv4e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888746; c=relaxed/simple;
	bh=7jrlpxCWm7sEqjF+/GngtwMutgky+14DFuwx9Yqa3jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQ7XJWOv/cWvEnb11i7YYBjuCygoTRRXBdrJr4W4LVOZ3mLWkBNa5/bhYhpj3ROdnjUE+ogPAeD3cK3FkGdXopyTmKP50ynyYneleK2qM9RoZNDPu5DMM3BwE/uS29eoInFXknKuNy20RWZtMvWB1f8fNac2St0eNSr3GJooQ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YiygTl4Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gh9QviyV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHNorKs011922;
	Mon, 18 Nov 2024 00:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9TwKbPc/CWYyP4eoL8btLAg2yreRLokScqNBy/+SVSI=; b=
	YiygTl4Qk1C4Ds6PDqloqiXOwlFeQkqyo8FhQHkE/67P9ecDFEn5kIHYMp4wWgh3
	tFuC6R4NUZ9aoYkNY4oCwrX25H7DMMoDwlUBG+EbokZvELjQwWcniQRFMag/wG/V
	28ARrZyI09RqtgZbEEyurqMp9GO8agU1wqD/XFCPVAAJ2KnpWR5T5jyQlLkfCpXD
	u19yoMP0AZk3yBddj5/80FVYL4kyHOFTloFXWFn6hCeV0qTNDSB8infvgJhwyJgq
	x7gXWsALNevGeuEkgniWNd6XzRrfsie6uP7lh8wNYVj84QI7RlAHIbY1+XRkvY8C
	Hea4OeKDwO90VqwGTb1H3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0shp5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 00:12:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHIOEak023209;
	Mon, 18 Nov 2024 00:12:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6tvm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 00:12:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhvfV3paus+Tr2JEVboFNMrf0ZIXpFwNCUf8gNc0QzcyXqat4pT2sVCcnyolbnxATjzjraZNYuoagdWDBLqO8BZbt77xhuRNHDCae1zE21g2iqfjYCgKzn9sYWSAOvg/Rbl2ERGuVTtIKch2Y3fb/h9oM71I4FPIdOIoFZgCrc0Kgilwq85QFJ/SbXg5fri3UA2FxLpYRTf3fV/+ElG81hZ8V9i7Sr7EmY5zgNNa3lsVTIrLVeiSTWNl0cKUYF6LphPeNQkdzqbKVE4NgxLhlOckmuA3vuraPDyUZIi1vzVlGYpcWElbvDYd+QljovrAeSwX4OCP4TfV9SSh6g9ewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TwKbPc/CWYyP4eoL8btLAg2yreRLokScqNBy/+SVSI=;
 b=aNqF/UO+sHk3noY76JFitjv69ADmqg54HleV7+/k3UiHbb2dUC5GQh54+UD3stgzeQSlKf8FhA7nw89Q7IfhSYJWLl28gWdRmXFCTkfHkr0TCM5ZWrnCrfOxjNzpDpNHkY37XMhgLHmsY772PDqpobhTd1pTG0FmOdc2r33QsXy+Z4AuqV+C/NHE1wgOOKR47mZ32grEVauAp2y+n0Mkv1KnIxZ85QPoJ97xldh86+rl06bcCCxFvnWXZvwpxTrQz6YFXrSLBugk/XXgVZi98xEJo0xjDd2Tz+IdJ7fLtc5kgYOA6ENouest7x8/aoQZ++D98deRgZ0lPY+uHl0bDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TwKbPc/CWYyP4eoL8btLAg2yreRLokScqNBy/+SVSI=;
 b=gh9QviyVuiqOtctlcLdH36x7/CeMkGgLpoceyt8P5s+PHMY+Z7p13F83DWYvc+blRmnxkeVq+Szjw2YXuhrRl+QVyXqFwjl9mHXmv3B4z/EVRfPk73uTkAx30I8apJwjX5RR4q0fLdRaPePAHeaz43W9l92p71R1uly2rjXZ4So=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5120.namprd10.prod.outlook.com (2603:10b6:5:3a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 00:12:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 00:12:17 +0000
Message-ID: <817b208b-5009-4d7d-8d9b-63d319dedd73@oracle.com>
Date: Mon, 18 Nov 2024 08:12:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fstests: move fs-module reload to earlier in the
 run_section function
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1731683116.git.anand.jain@oracle.com>
 <7af8f80173fab5408da86f5b3393e787659a81d6.1731683116.git.anand.jain@oracle.com>
 <20241115163955.GD9425@frogsfrogsfrogs>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241115163955.GD9425@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: cd53fbce-2631-4ff7-58dd-08dd0765a93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDVYQ3lwd2liR2E2dHg3cVVhQjRzb2t6Qjk2R0VKcHFPVmhWY1RjdlVoWlFH?=
 =?utf-8?B?MGtISTI4N2ZTdzNoYUpFV094ODdmSE1SdzVmTlhDbmV0cW9HZnNiTFdxOVZa?=
 =?utf-8?B?K2FRYnZKYmNocGQvWGh0dnA3UDBoQm9KQkt6SDFEQ2dOVkxvSXVTeVhSSHpN?=
 =?utf-8?B?UjlMZzZHR0U2dVJhNU9KaUZwVUYzUTZ2YjhtZStidnFhUlJmSVhrekRSbnhD?=
 =?utf-8?B?OENHQUQyUGFBKy80cGQ3SHdtMU9ta28wNXZLZlV5VVRNbUlUdnhmbFpMUlNj?=
 =?utf-8?B?TDFRdFdxMUg1eXdlU0YvTXNjWmxSODVLWlcxTFp1S05oWnNLblRCRDBPeCsv?=
 =?utf-8?B?MVYzY0dMKzR4S2pEd0JnSG5IUHdEUW1qWi9GU0NrTC9CbnpmaGJQWVNlRW5q?=
 =?utf-8?B?RjZJVVh4LzZKL3pRNHh6WUFINnc1SUc5R0ltb2E5TldKSUxBZFk5aGhILzF2?=
 =?utf-8?B?NUJzNW44SERQOUhrR0NGb0VIRnFKU0JCR0hrYWpXMEx0VFZoTW9YMUVsQ0Vm?=
 =?utf-8?B?SEN5d0F5QWVqTlM5dVNRNkZlUm1GRnhBVEhjTEZaTExMeEl6ZXBhWUsxVTkw?=
 =?utf-8?B?TWVuTUVLWkVuc3Y4SHNURVdLaW4zdDllM1hWbFZQWWtiOTF3bmR2b1VrdzZt?=
 =?utf-8?B?ZXFMVkRhd1dLbXpzaXBpdkxiZkNmUFg4Z1lZcldlTWZMSS9ZbkwzWG13bjlZ?=
 =?utf-8?B?MDJoa1g3emNwNzVxRGJSUjZlSkNodlcyN0cvOXNXZ3d3NFdkVkNhNlhBK2J4?=
 =?utf-8?B?SE9RNXR1eTFGRGtubUtEN0xSV1ZWOGN2QWU0L1FrUGx0V2VQU3RZNkdwRXZH?=
 =?utf-8?B?RmlRdUJ5NDYzK1NodUNTOVg0cTlTNmwzUEUzNHlWSlhGWW12OUNReHQ0WDZK?=
 =?utf-8?B?UXhDdDNGTVN1aXFEbFdsbWppTzJ5dUQ4Z0xIU1g4anpBMnBKRzdoOTQzeitw?=
 =?utf-8?B?cXFFWFFYQXEwTHlTY2RFdUtENTFUMVNxcStBY1ZWbWdLT2Vqb1AyVC9jVGQ0?=
 =?utf-8?B?ZUhOcVZsUzNxWlJ5N1FUb3lOVlJtZzR0K0p2K1djR0VBdVZVTkhxWFFRd1lo?=
 =?utf-8?B?NEkrZUFac1haTEdjbHltR2tqdGRrMXhkVWlnaDJqTGgrZy9rcTV3M2U4azVN?=
 =?utf-8?B?Z0syT3Zub3dzY1JxWm9yYXBFSDQwd0svd2tPbFRvMEFrRWR2SHVETmRySVlS?=
 =?utf-8?B?VE1wSXRCZ3dkcXBRR0JBSU9aclVhdmdTM3BaNElRTFplNm1NcUhha21xWlBP?=
 =?utf-8?B?NktiWnBpelJzMlBOK25GdTdkTHoyRTV2ZWdvQzBFZ3RFcDMzdEY1eldUL3Bm?=
 =?utf-8?B?YkI5VG9hZ1BnSVRlTnBIWndhV0dMNXUzTWpyL0pKYTg0VkZEVFc5STIyZXRS?=
 =?utf-8?B?V3BWRHl6QnB5Y1pwRk56S01ZU0ZtRVM2c2dLNGZYbVBNd0lTcEdoRTAyNHYw?=
 =?utf-8?B?SzhYVnBFa0pCZ0NNRTRqRlJ6SExpcWhEVlYyWWpXelRISGIrOERmbjZiREg2?=
 =?utf-8?B?M0lFM1FFTnYzb1RIM1ZKcFlodVdlbkpldjd0bUx6d2Z4MkljZFd3UWZYOTIz?=
 =?utf-8?B?KzVpVXU5UTFOSjVjQlgrTEE3SWFvNENONGYxRWJnZWtQTCsyZVZ3VHNiajl6?=
 =?utf-8?B?L3liVDV3RFBLR0d2SXZPYkloK2FtRDVEV3h4Mmw3cTFwWW5MaWVKdzY1MnJ1?=
 =?utf-8?B?L3NqN1lnY01STWh0MWVzRzEwbkpvWGQyNXAySGphcmo4M3FBbHF5clM2aDFw?=
 =?utf-8?Q?T6Ilp+4iSLyQQzlcyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3J2bGN4WWdwVFVaMXN2anNGQnFMUHlmWEtTVnkweGlsYjU3UHJ3NEpFWjdn?=
 =?utf-8?B?czRvRnc3QlZqSzVpSlR0K2dSRzEvNEFFY3pURzFBbmlsU0p5M1hXdmxNTmdC?=
 =?utf-8?B?VkJCRjI4eCt5WXQ5QjNWcWNHYUNMTTB0dnd5RXk4SHJRSkFOd3p1T1FWdWJE?=
 =?utf-8?B?dExyNU1NWE5BazVLSzlydU1hbWhYSE1JbmY3RFFvQ2ZFNFVaaEVMOW1tYWhL?=
 =?utf-8?B?a0RPYU9DeVdOM0xnMUpxVUdSV2pBLzJ2cmRwSSt0SHd1cGVrNzJnY0M0SURX?=
 =?utf-8?B?eFQ3MWhKMTVmWDQ4L2hlYnI4VHpDb0lrdU9DQUdlbDYyYlRoVnc2K1BNbXR1?=
 =?utf-8?B?aWExOU5YV1RJU1NkSmUrZkQzMFBCUE5IWjJ6SU1tRFlEM2RORTVDS29GeHU2?=
 =?utf-8?B?Tk5VWUpCRk8xRTh2bENsT2djbUJGQVBZRVp0TEwzVDdpMjgrNjRsZUNvVW12?=
 =?utf-8?B?czNpOTN6aHpLbGFOWEVXaDFOa2tRcWNYei93QTBmR3FweWFnSGlZQnNYMGZZ?=
 =?utf-8?B?MFhodlhHVjNpZDhKYjhyOXlnRU53TndzeEhHR3R3U3U3SlpEdlM0Yk40dkhl?=
 =?utf-8?B?YWlCQVRDOFkvZzU4L0hORXY3K1JCWnNHQ2srNFFvT01XY0VLTTVPQ3c5NFBi?=
 =?utf-8?B?ZitERHI5YURwMXo2T0ZkTktlVnIyVms1MjV1T3hIU3BwdVhpNjJ1dzBHSlgx?=
 =?utf-8?B?ODAway90ZE1QeUtKVFU4UktvcUg5R1dzWGhDWWdZTXY1aFl5a2d6S0Y3djlY?=
 =?utf-8?B?Z05ZYUxTdytvQytQM3FNV1JaeVhtc2RncHNSQ2hoY2FQTVRYOHNqNzBhRDVU?=
 =?utf-8?B?Um9KKzlyRVY5a0xyd3RNTm5rUzZsSUl0T05KYW1jZ2g0eGgwZzF2TzY4b1BN?=
 =?utf-8?B?UHhjS3RhVTlVcWxCeDk5VlFYbUwwZ0hNYURJcjN3M3RzY3dib1B3Rk1GUGVZ?=
 =?utf-8?B?eFFwOEw5UW8ya0QxZllxdkRIelFoci9RWFo0NGFkMnVkYlNBMEd2bjQ5ZWVk?=
 =?utf-8?B?cWJBRnVpdGVXMkRsYnNwaHdYK2orU3JpS3NNYmJDQTFkVGVVakxNOTJrejlh?=
 =?utf-8?B?N3RMZW55VFNoMUY1MEozdHZ0dnRaRFZSVDhVd2FBcWxtYjdXNlhYUEpwbWlQ?=
 =?utf-8?B?NGhmNHZUQXNETlFRcTlkZnNjQmpZWkltV2U4MldBVUdIK3p6bndWcjB1VE1X?=
 =?utf-8?B?OWF2ZFpvVGU0MzRPdnRHOU1oRVdSaWFaUndzMjEvZTNGWnZBditUbEdySmw4?=
 =?utf-8?B?QndyMFp2N2ZFeUFxYXNrRFBmR1JORERkSjVZZldCNno2S0dHU2pHRGhrSlhR?=
 =?utf-8?B?WUZvbkZPTzdsRytHUDlFSm1aYjZMLzVBZGFONllLNkhKRHVoKzM4VUZzdnZk?=
 =?utf-8?B?azNIcGQ4bDBmWmgzY1kzV2R6YTZuTnRnSFhLVWNqU2dKWDRuejRSMVhUQmpJ?=
 =?utf-8?B?ZWJtK01jMTFJVmhnME9WcmJ1UW9wcXVIbkcvbWVlaS9BNHppYVY0aFBnK3VW?=
 =?utf-8?B?bUF4RDlkbmJ5cjMvSVcwVnhCazh4VGRUakNWOWVqTjhtRzdQaCsyODBSejNQ?=
 =?utf-8?B?TjhHSllEYXkvamJrRVB5Qmpxdy9zRFNCM29zcjVwQTFKRWJOS0F3UkZoRHRv?=
 =?utf-8?B?cFdyZDVrMGN2cDdBQjIzeEhRNUk1OFFNaXp6bGRLWjQxL0F5b08xUDEzenY4?=
 =?utf-8?B?emJzSzZOQnNKc2M3eHhsYVZkSFdxQk5hY2xQNStpazkzd2VEbjFUZXRCdzE2?=
 =?utf-8?B?V21kRW40bExTUW9PNHZ0QjRxKzZyYlJrclVieFNjUUw0VHZmd2VMTXV2Q2hL?=
 =?utf-8?B?ekduSDNZK3hhWE1TWHBQRHFxbWpqMjVEdlZ2TFlncUNFN1JRVTJYTkErRGcz?=
 =?utf-8?B?RjFrNjlCb2dSZzQ1YUpLMlpmOWN3bVpBSVYrK2hKVU9OVGFNVDhvT2l5ejVo?=
 =?utf-8?B?dS9oMUZwMHZUQ21hM3BBT3R4anh5eU45OWpMZndvYjBiZTYvL1NQWWkwQVZV?=
 =?utf-8?B?UDN4ZUQvMEUrMENVY0lvam9BSFZBSmcvVG1UWmxRVElXbDliTFg2aFB1MUxs?=
 =?utf-8?B?Ry9uVmhoaTM0M3JCRndqL1B1dktJejcwSzZwZnBvVitoeHErZElKYWtTeWpi?=
 =?utf-8?Q?UlCNL+zFHvUuNedAL/Hd6XVEp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Dk7gLG6w033if07IbFXmrZQLXRO9rtvFo16ydJRzwhhozXUKccL79yKSdodnu+fO2D+g5q/0bUMVBQf0+eapcUVDaiVNm3wGWM2ow110XmFJGSN3jvwH2UFZFELVv3qDtZuPBYIK+TY0UQD9m52sENpqDmKaQ9QX0sVxlCGrzaMJ2+joeK3JgHk/7KK5mxsmVeX6TwWxcIuP3RAhCf0NJNMXmREriRWaJcaJ2dz/eKSyxHQXMCxrFWGtV9OYYQ4AUvadD/X2t5xo3jLItlTkGBz/5xJUrr9aoVvtRNrZvIkudKc3nmAi+q3hxiV5zZjETC8WJ6dU4vWDNxzG/toYujWodJWCqkfdEJ6SoNbUCZYUzqw7GuCuSNdu7REz6blOA4cjSm1tXeAMbrCTQ+9e1eypWBJ2/H/fHyVeGBxmXTdOhUjYBfxvsw90S7XmdMTK2c+Xlq3jWSWF8RY4vPcUfDfjFKAVd8oxAj/UHgiplWbzN/jgcszT+tNDWoMOsXNXcV8DUDMyTP1EVcDDe+ESQyxMsbIB+YX2maqpiZoDGhsomatQp0aMjjp1hp3FCf5UKiD9f1laEEiKjnmBcOvge9O+rL0DKH5aBSweNbg1qk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd53fbce-2631-4ff7-58dd-08dd0765a93c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 00:12:17.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyLzV5sdDagVZjAyqQXmkiaqlSND7NU9EFkjf+ldPhk2wcttNoQanlVHP+0GibkvIMqiVv4a8nY1nl7Z1NG/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_22,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411170215
X-Proofpoint-ORIG-GUID: qyTCcwwzXMotB2s9fEYvX4G3XKz5U-iR
X-Proofpoint-GUID: qyTCcwwzXMotB2s9fEYvX4G3XKz5U-iR

On 16/11/24 00:39, Darrick J. Wong wrote:
> On Fri, Nov 15, 2024 at 11:20:51PM +0800, Anand Jain wrote:
>> Reload the module before each test, instead of later in run_section.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   check | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/check b/check
>> index 9222cd7e4f81..d8ee73f48c77 100755
>> --- a/check
>> +++ b/check
>> @@ -935,6 +935,15 @@ function run_section()
>>   			continue
>>   		fi
>>   
>> +		# Reload the module after each test to check for leaks or
>> +		# other problems.
> 
> Hrmm.  The nice thing about doing the reload /after/ each test is that
> unloading the module will purge any per-fs slab caches that the module
> creates.  The slab teardown logs any forgotten objects while $seq still
> points to the test that leaked those objects.  Granted it's not a 100%
> solution (that job falls to kmemcheck) but it's a cheap check.
> 
> This change makes it so that if test N leaks something, fstests reports
> them for test N+1.
> 

Agreed. It's better to report the issue at test N. I'll add this comment 
to the code in v2.

Thanks!
Anand

> --D
> 
>> +		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
>> +			_test_unmount 2> /dev/null
>> +			_scratch_unmount 2> /dev/null
>> +			modprobe -r fs-$FSTYP
>> +			modprobe fs-$FSTYP
>> +		fi
>> +
>>   		# record that we really tried to run this test.
>>   		if ((!${#loop_status[*]})); then
>>   			try+=("$seqnum")
>> @@ -1033,15 +1042,6 @@ function run_section()
>>   			done
>>   		fi
>>   
>> -		# Reload the module after each test to check for leaks or
>> -		# other problems.
>> -		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
>> -			_test_unmount 2> /dev/null
>> -			_scratch_unmount 2> /dev/null
>> -			modprobe -r fs-$FSTYP
>> -			modprobe fs-$FSTYP
>> -		fi
>> -
>>   		# Scan for memory leaks after every test so that associating
>>   		# a leak to a particular test will be as accurate as possible.
>>   		_check_kmemleak || tc_status="fail"
>> -- 
>> 2.46.1
>>
>>


