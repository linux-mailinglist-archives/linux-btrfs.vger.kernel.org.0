Return-Path: <linux-btrfs+bounces-8896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D199D136
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C035B24683
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52C1AB6FC;
	Mon, 14 Oct 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n2NQvgpE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wcaxrFJ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DF1AB505
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918732; cv=fail; b=X0HXBOKvKa6joQPuq+DjyVMmt5g03uy7BmstzXOJ+s6xdzM5xAO/PR22aaBrGSM0jjJTpz84UpvCaiArhLnxuKyOV04n0Ru84GpRe6E+iPZ+ZBIJR79OzNxq1+kc8PD/rwifLMZz7Cs6Xgeu8gVrI+EZLxSTCf4IqdiXvW5pFrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918732; c=relaxed/simple;
	bh=h+u8Qa1egBM2MNfq9ISORyPoX47auU6wIxAN/Ey7wSU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KRnToM5Ceee+lZUqNBEo6hrL0HqStxDXS7t6XGsI7FRjEOVWu6gurY8f6bn0YQPWI93FweJ98QUelKOHk+YOsl3xP6W/fgoFutyMi47nok8n2AAcoH3rs5JEqRj3/mH2LbbC4AAtlUj55fD6YJq3KoREDkgWSV8cIi/IeSjzMwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n2NQvgpE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wcaxrFJ1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfffn019753
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=Jc9Ya1bLIbKTUB4N
	pgbjaGX2Ujca4365UXy5NPUnj+A=; b=n2NQvgpENDfVBo/AFXfXIsK8gvWVWx4w
	RYbdGUH5yy3Cw6k7YzfJyJoW5q6gvYQwRYCGOQNPdqXjzOSqsR6GqIuxtZy7nvfk
	ZikGxCZnAFXjD9ivgkEcSCPLi7SLhwLZtYYnf/KXiQckaihiZPolFMoJrup8Xf/s
	tAIir51wYTanOaIfnTxRfPZTFuHr2T7vhJSEUJK6UlSY/aBTdU0DIas5H/5IwUcu
	kAdCXZ4YhPqUpmkVpfqeTj/ZGgN3uXDDv5k+GnpzO+WG3/TcZaPax+5bdT8dtsnj
	SBXiF4Ikcx8ETCvTWLlDziiBxxiqr7Cd7jW8Cyn978D4LGU9XPkGzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aeguf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:12:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEhXRe026369
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:11:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6754r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxdWN9uvNRN/kgzchsY/Lpf5ad1YqI/PwdK82gOermzForJP4gRmrNjrQ5ASc9oXjghfBS0TIE4sTOPoAxFDtAxUimZCwlXtUr3FV6qIFpiHkIxNUX4g/d4ULKrrkwvWyWJ4kEe7yMcTfIDVeXrwtIG2F7LXXXESRGNuxqD3LACKzGVYx5OpmTKnX/hw+pfUs7bVoXTW7IXvVTyi0G5gGAIKcrREiy/fQm8AZMItQWo3BkpR29HJetzeYJ8vvwQjY7UbhY8nq52tMKPtIiMiTpapieoRUVQeE30xTxFuZQTcCML9kzFnX3K4RDDZ2Y34T4CVDh85WUSnu0N6QuypwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc9Ya1bLIbKTUB4NpgbjaGX2Ujca4365UXy5NPUnj+A=;
 b=TYA+g+fPvbtFGsjaAF+Bp5HJuCLZB+XEq0gdp1qhJCyARVlHpkigpvwCE/rrOJUMltiYWId9fqQ71SNPpp+sULyNvUCnAZfksVMRcD+PrWIroL8n2ZmJJVnb/rfZO9DFz3c/Pp7Tlzz4EY4L0hTXBX2QMMI3HKTpyJ+osll5nHgHBvT+Ewsqsnt9V2+nJ5ZRQZP6JU2+cMhX91IpmUM4xx8MUjUzm2K40CONqntVgFCp/zD9RMdPPttsRGp3wcO14cHeyOvvwvFexH61gi0SKx1L9CFpQ3FaSBuyCKET1x6apJvIE0/Soy9sTu7sDpxwEfnRF7XlZ7oO/U2NpY5Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc9Ya1bLIbKTUB4NpgbjaGX2Ujca4365UXy5NPUnj+A=;
 b=wcaxrFJ1XBYbYBP8nDLMsfQkNou+86Mk8TLsnwRNYf9FtyFIKXqLzlxcQirgUmMETwgSZFrSADrD3Ds78TUOTJMnWyenlEy9OHp4Cqun49bAW0AiWKUMZ1IhKNaTD7OrRDyApwMx+3rgDjxIAlzO8V0FrC1h2TSitIwSXoM70wc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4693.namprd10.prod.outlook.com (2603:10b6:510:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 15:11:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:11:55 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use filemap_get_folio helper
Date: Mon, 14 Oct 2024 23:11:38 +0800
Message-ID: <8c4bff7365deea48db84e5c91af0be3538655060.1728918448.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4693:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6463e3-d696-4faf-ca13-08dcec628a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhXbUZiUURGQytYNEdCNDJMRUlFdUN3K1AzdFpFK0NkeUl5c21lQ0NFY0lt?=
 =?utf-8?B?UCtuQmJ1cUoyeThNSzlBcU9PWEtLdmRtUHJQcXlHOHVIL1pzYW5Wd29uZ2tD?=
 =?utf-8?B?NkNlUGdJNHBvQ1BTazF6bnVGSitZNlJnNmxkWjlNS0cwNzQ0UGhqZkJjVlpD?=
 =?utf-8?B?djhkTVZLSHJkV2RLSWFhVTRpUVQzVlQ2MHFPVjN3WGFESXFMK2k4dmM5UE5r?=
 =?utf-8?B?MitwcDR1dVd2YVZTMWRja0VZc1d0dlFKZTMvN085MzlCalBsRGRqMHhmWW5L?=
 =?utf-8?B?VXRPd0grMXltNDR2blZ0R0tPMzY5RlZhdHdiWVlaTk80MDF1YjYvSms5Q1RO?=
 =?utf-8?B?L1lvTXZWS2hBRU81WUEreEswQ3dNcXhOOFRMbnpxaGRIeWZjVGV1Y1Q0aTlN?=
 =?utf-8?B?dUJIRWExVTNCeDNYN3YvY3JneVBHZWNFNW1ZQ1EvdmtCY1FnUjcrTjBPYld1?=
 =?utf-8?B?cVpLVFVrRVh2Nk9IK0pDY1FQSmdGNFRNVHVyZjJJSWtESjFXS21MQ2RhVmJY?=
 =?utf-8?B?ZEFJYWNjU0xLVTh1cjQ4NDNoOEV0UVlhYnU5elFpd0J0RVJIZ3pncE1CNjVL?=
 =?utf-8?B?aHNUM3BZcVU3bzkwZ2dXNUMwWFV3L1ZhYjdIc1JLTXM3dTJlclpTdW51M2Z1?=
 =?utf-8?B?cUNaYjk4RlZObk9VYkxEVXJ5cnFaMXNkR0Jwb05EVUdCTUEwTEs3V1paTGV4?=
 =?utf-8?B?cHFOM1pOeFI4Q1RxL2laQVkyamRkTDdnUGFxZHNSUVJydTlQQjlGcC9SaHNE?=
 =?utf-8?B?bXhjeEl3eUtHalFjOTNkN1ZpYzNhNzMrZFUwbS8yR2hWYU9TZkhXblRkdWJK?=
 =?utf-8?B?VytwekVEamhnenNIRVo4VzN4eUdxUkQ5M3hsNlRiRXdlT3QyUDZSZ2xCTFBR?=
 =?utf-8?B?N2pkRDF4c3pKVzdyeFFNckZPUVRqL29SRFlpalFLRUxYbGtWcXBVcWhpQ2FH?=
 =?utf-8?B?cjVMbTIzQ1JMSlJlSE9KVlBIMXpFdkdXQ0dkTlg5YUJ1WjhDQTZUVXRva1Nn?=
 =?utf-8?B?RzBqQzlCaERxb0hzdC84ZWhwUUk4SHNsZDFaQWMrSjBqNklxNzRERU5QeDNq?=
 =?utf-8?B?LzlnZ3pTSDdxaFRCQkRTVXU4eXZMUmY1d3hydEZpZnMvMloxQU9qWVp6T1Rn?=
 =?utf-8?B?Vkw4U2dhYjhwUGpveHJ6NXZEcFV1eEpiVGx6RGR1eDZ1Ukw1NlBxdjBoQ1lL?=
 =?utf-8?B?d2J6OXJVeHlvNXJRcTc3TVVRQ0d5RXpvbnlrUkh1aGxhWU5ZbUdWemdhczBB?=
 =?utf-8?B?ZnVLM29pUzVIcFp2YmU5KzJJMWVrOHAvMXZLMHBtaTRpSzdjZUlKdExxN1hZ?=
 =?utf-8?B?TmVNV203QUQzZ0gzaFJGVWhEczZ1aHRGaGk2WVJJSGM2aXZOYVpta0owWjFH?=
 =?utf-8?B?cEltSC9HRjJQbXhSTmhPTFhOU1JHenFMNjNYOVc3NTR3Vys2MFhad1ZwZ0oy?=
 =?utf-8?B?OFZNb0tJK0Y0aGNpTjJqUnVnWGtvSk9wVUlndTlmTGtzQ3R2a2Riclg0Q0NJ?=
 =?utf-8?B?OWp1bE5Hb2JORUVHWmc2b3l6U28xME1wT3l3NjgycHQzcFpDY1VlM2lGSWtk?=
 =?utf-8?B?cGhaZ1NoODZqTzF3cjlyQmhGWTdLZTduY1U5VXM1OFV3VlQ5R1Bic0xFQVph?=
 =?utf-8?B?RmRoaGg1THhSK2NSekM1bkU3V3VyS0J4Nnk5VGdkUlRFbGszMkpKeks0dWVX?=
 =?utf-8?B?YlJ0TjlhQVJOL3JqWThqZUtaYUozRzJMS2xpczJld002azFmRVlaMWV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clZkQWI3NjFmVDQ3R3lESDFhMU9DV256eXRjKy9KUkRiK094YmJwclNGUSs5?=
 =?utf-8?B?UDN5aXowRktmK2R3V210elc1MTdENEpKZ1BvVDFHK1ptRXphKzZQSTU5d0gy?=
 =?utf-8?B?ZlVRbitLQW55aXloN2UxMUVvNjBxZGVZRm14aUFDa01CTjd2WHF2Tk5aMW9r?=
 =?utf-8?B?dGt3eDlaK3dnT2RUNEd6Rzc2UUM2RFRZaVd0V2FXTzhsUHVsdVhaQzJ0WVJ1?=
 =?utf-8?B?VjV1NjZQQ0VQRFlxbnl4ZzJnLytPU0syS2IvQ1hYRkt1ZjJiMU5UdncydGo0?=
 =?utf-8?B?UXlETDNiaURjUDhFendTNnZwbEQ5UEdQVTRaeEtaT0tlenl6dTIvWnFUZmhU?=
 =?utf-8?B?dDgrejlPamUvOW5ZK2FMSTVQL0pZb1g4em4zaFZjakZxOTVjcXV5dWVtZUo5?=
 =?utf-8?B?dlBFVHJNd3J0Q2JYM1EwRm1YQ1UxTUNrdG1qK2hjT21PSGE1WWEreCtsNFZH?=
 =?utf-8?B?c1FENENDQVVkd2xRc1c5VGxWTWJ6WWtXWVhhNjFONS9JNm1FK3VwenRHRUp5?=
 =?utf-8?B?VjlYUkFvYTFOWmZPZFhFbFI0c3NpYWlyN0RLQ1BWUSs0L2diUGNHdS8zMXht?=
 =?utf-8?B?L3BuQlNnTFdHME15Q0NkSmhjVmpRWkJ6VHRyUlpCYndWVHRNRnN0VDllMFE3?=
 =?utf-8?B?K3dvc1FORVk2Rmd6dzZ5cTNQelBRSFBZKzVoZzJZT0hEaUdGZWN1RjdRVHY1?=
 =?utf-8?B?NUFGR3JROW5qVWg0cFRPcmNwcm56blIwZ29xR001c216bmpWcUc2K0pYcHBG?=
 =?utf-8?B?T2FmMWZWUk5nN2xlMWhNYjZRSEhRWHEyWEtHUnd4UGRHYklWS2J3ZmVFRktw?=
 =?utf-8?B?U0ZlZld0T2N2ZnkxUHlrOXZhazNhUzFxNnR2VlJ5blBEaHh6QmlSSUE1R0Zn?=
 =?utf-8?B?OThONXNRSG9FV0p0c1pjeXc0SmE2MXRpcmV4b2RtMVgzOEErZkF2MmRZTFp4?=
 =?utf-8?B?QVlCVUJvT3BpSDAxeUNEeUVuSEJwRWs4b0c0QW96bjhrc25ZZjMwTlgybFhH?=
 =?utf-8?B?cTREbHM1bkhmampKRHdqUStzWlJYQ1YyYno2cHVIdU85dE9HWnNKenlKN0V5?=
 =?utf-8?B?cU5xU1U4QUVJRlJhZWQrb0FWRVN1YzFieFpSRmlzendhUUp3Ui9xVkZEalhY?=
 =?utf-8?B?S3c3SkJ5V1BjbkkvMFk5dE5IYks1TWg2dUUwNWZTMHBXTW9DNFhoSURqVXVM?=
 =?utf-8?B?eWhwekN6TUpjdFZtUWd0YnVweTgyMW1wSm5EcWhCMVFIYUtRNEc1anVXam0x?=
 =?utf-8?B?WFRJL1FjMXhMZWVKWnRoQWQ0Y3JQOTFjSjFYWEpRNldRcnF2WW1iQjY1aFV0?=
 =?utf-8?B?aXYxZVFYa29vVWJSN3hWUE8vYTVwbDU1VktDOW4wQXZhLzZNbUtwMUZ4emNO?=
 =?utf-8?B?cVJncWx4S0NERWxpVGdqczh4TWlnL0hDaXF4TG5uOCtTSEFkVDRHOEZvcjRG?=
 =?utf-8?B?bkU0VkYwWHNiS1pueG42cjd1NjdhWUNRSDVWaXE5UTFab1MwT0x0NWpTNHVB?=
 =?utf-8?B?ejRuU1dDaEhpZkU0cW96bFhwZ29xekplakEvakJCOTNzOUlGRnZNQWFnN3Ry?=
 =?utf-8?B?cHJ3WTlISlNNOWxjY2tSR21qWUJscFN4WFd3TTNqY2JHeHdmWG5zd0I2RkVz?=
 =?utf-8?B?VGhxeUNUSjlJUFhvRzZkRmo4UjVPTzFJQU0xZndHVmtPQThpRkJKMDJHekJj?=
 =?utf-8?B?aDBnSUFRZG9GWnVGYnIvek9jNUVwL29Ud0t5Sm4vS0tBLzRlcFZIUFBveXRB?=
 =?utf-8?B?WFRjTHFjb1NxUWp4cUY3YlE1U215M3FZOTdmQXRDaEdUZWlWNXQ0amlGMnVt?=
 =?utf-8?B?eGRkd0dTeW1LY2VzWnlUTlUwT2hmTDE1LzgraEY1cG15M1pDVGp3VFhRcHJG?=
 =?utf-8?B?bkhsZ25uRkd6Vmh1NS9uNlMyaXI0cjluV3pQeTFCWkN1ejJLVzExams4UWdI?=
 =?utf-8?B?b0Job3hvMVNsR1pEL0sydTE3WTFQYk4wditQUDNBZGllSWE5SWNCZGlDTUpK?=
 =?utf-8?B?V2hNSzNGTkQ0K1FTcFQ4V2oyUjRISSt1cGNVOHIzK2dKQ3RDSG1yTlBhQ2tn?=
 =?utf-8?B?SDhWZDZOUUtVaURqVlhobFRuZ01BTXFBdFZ4bXNEeEQxYkx2SWtPMjJYaU5m?=
 =?utf-8?Q?Z4GgsljNK7jXrJM2zBVbx265m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sRUR5zNphivCIohrtcG+nk17Wrn3/+xHorrmvf1FJ0mKP1OJI9URqIdmhA2w2Pe3g8rrWmV8CD3Hnb3pctK9g/X1qYdrZXwWJgzj2oT7Kofscug9vhZRV5gUuT0keKKmuKnekw8j+bxPtV9lRd9NXzEQKtHyQcHtncKxDEfHI2IuUNsF7GgCzmXmk4qQAiQQz2qqcZTElPkz71AsD9UribEIrLUS/JKKbXwgLsZug2nrky5XmwlDKSnTN/omT0POaaz5+w7X2fKKj/OLZaVQsKECQJyT5gCRhHJBLoycoWgiMEJ57StofeOHR4iJVpH0jEPx87Jo012vGLpw9fsyIPBWnnVB9CZylwcPZUFk1ppfD/7d0sAMjMuyxoIhIpn5iPpMSCtVcl4jGtKGl9XDBul0UekjOEJLA63gH3VwLRoBvGeK1OO07bFlUY+8lYiimWMc6jQAWXFt7CF2E2jbRC4k4O7rsZQSGhhjvTp6GbDg06lmx9aDi+aW3rg9PRIT9saslDvpAx3EpGA8C7ihIULTnJDXfQb9llWi6WYvHkN0rTL//QtXTZBTbqZT1w6uIRdXMSemuM6dCO3Ktm0V3wqxvGl22nnDMpMb4TAvCcE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6463e3-d696-4faf-ca13-08dcec628a2c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:11:55.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NugtYLsaZXS4+ERqdOu8F/t7Wfqz9vFy2Qt8XvUTW3TBXOy/7O7TRaGEfYSIXwrgyOxYMwo48W17qD59vu32fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140110
X-Proofpoint-GUID: Y4DeRiyacN3Amo_eOzsdfH-4YdlvuwgA
X-Proofpoint-ORIG-GUID: Y4DeRiyacN3Amo_eOzsdfH-4YdlvuwgA

When fgp_flags and gfp_flags are zero, use filemap_get_folio(A, B)
instead of __filemap_get_folio(A, B, 0, 0)—no need for the extra
arguments 0, 0.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/inode.c       | 7 +++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index abcf8ed06afc..c375754198ea 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -453,7 +453,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (pg_index > end_index)
 			break;
 
-		folio = __filemap_get_folio(mapping, pg_index, 0, 0);
+		folio = filemap_get_folio(mapping, pg_index);
 		if (!IS_ERR(folio)) {
 			u64 folio_sz = folio_size(folio);
 			u64 offset = offset_in_folio(folio, cur);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 09c0d18a7b5a..2e2bf12989a4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2264,7 +2264,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		u32 cur_len = cur_end + 1 - cur;
 		struct folio *folio;
 
-		folio = __filemap_get_folio(mapping, cur >> PAGE_SHIFT, 0, 0);
+		folio = filemap_get_folio(mapping, cur >> PAGE_SHIFT);
 
 		/*
 		 * This shouldn't happen, the pages are pinned and locked, this
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 35f89d14c110..004f3a8b06c5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -421,7 +421,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 			index++;
 			continue;
 		}
-		folio = __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, 0);
+		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
 		index++;
 		if (IS_ERR(folio))
 			continue;
@@ -556,8 +556,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	} else {
 		struct folio *folio;
 
-		folio = __filemap_get_folio(inode->vfs_inode.i_mapping,
-					    0, 0, 0);
+		folio = filemap_get_folio(inode->vfs_inode.i_mapping, 0);
 		ASSERT(!IS_ERR(folio));
 		btrfs_set_file_extent_compression(leaf, ei, 0);
 		kaddr = kmap_local_folio(folio, 0);
@@ -880,7 +879,7 @@ static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 e
 
 	for (unsigned long index = start >> PAGE_SHIFT;
 	     index <= end_index; index++) {
-		folio = __filemap_get_folio(inode->i_mapping, index, 0, 0);
+		folio = filemap_get_folio(inode->i_mapping, index);
 		if (IS_ERR(folio)) {
 			if (!ret)
 				ret = PTR_ERR(folio);
-- 
2.46.1


