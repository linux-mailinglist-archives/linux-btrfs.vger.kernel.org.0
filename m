Return-Path: <linux-btrfs+bounces-10668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D409FF4B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D763A27C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20821E2611;
	Wed,  1 Jan 2025 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VwJj6n1W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="isu7tMH1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4591E32C5
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755014; cv=fail; b=f12Q6EZWX/VPtlcESxKdLiyf4C8xlAQkssKOAP81ogxaf18OXUgKAv5OwabpN3X6P6jWOzu832I2o4rIJgv2Nvapc07ghh6buckgI9yYtMPsDamQr4nfrFh3VkvzpqsiMsC3iojkMYmQruvfn5jnkAYXBpKuPF9jdHbxkK5ipzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755014; c=relaxed/simple;
	bh=17UvpopZT7rH2KUF26JQpZrSn5fA/ddJoI/DMBrITyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0cONKfYqqnBtmZMpoJkqfdBonmuv3uvSTv0N+S7ebPkENw3X7kjZq3GTAgPf3ArHjxTRkoq5A1oF4t9zIjoKZH6MCt/SD49mmqy3x41KCokRco0nMDKJbvrVQn0Wl4ZUtoGCNHPkr0A1ef8PCnu1KQ5G4GfilOTInoCYoL0q8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VwJj6n1W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=isu7tMH1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501FlCfR027682;
	Wed, 1 Jan 2025 18:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X/Zi4ZyndMHWVrsduqOwVKdneE9gkhj02tOtyRSR+iU=; b=
	VwJj6n1WDqj+Itxf6s6k1YkxhO8hT47WmjgEArBbe+1/4DwWkLwHdw1xLU0m6016
	AbuLwUzA8nXv2xg4Gz5xJpEQ9Uj+e9G8ley6iXfjb03uAyHfs9KUa3uvocalXFok
	/Nnu2OHplfD/xHajXdsD6ivkPVuG04gwWxvd6DQE86r/xsrQtMGhlVzefG1WRXjN
	TfHulyLDXMuOYCIyXl58+2ai0llh7pxRsp4OyV+cHCMrYRNwIg3WyK9Qf7a2/nCK
	9tGKidSl29I0q2L5o1ROomkeOfbB+Wc7J+ZuMsPreEseFnFWp69nJoLZwIXP7RrC
	WgTE7R4kR3hlz1GWQ5p/Cg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978md41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501Ca4Lt008789;
	Wed, 1 Jan 2025 18:10:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s7wvb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBNnFAvOzyEUnTAULzn0wchNWNdIw9ohZyIw0cqPegRPjf/qUkJsvBP9NX+04jc9sl4/qI8eOX9gwGtzg2kvOKE5kuxpREyg4UgbIo05Pv3QadNQnhNV3ozvemmGJ46wlxdnoOkD371pw3fH2ZCqjTlSlqhhex+GCtCfK62t44Yj2Oq0DmRk+IYbkpX4xix1mJjdPVytcnroW435cCIOERDiKnKujiz4M1/j64+9KlxPCvmcxEJWKjNcSsV11VGGqbmmd3m75x1OE4runbMcKbZT6dxEjeefzPAvQjbOxbuoy+e7uY+sa6Rnr3xYyXOFBjsOaHnJ0/GWUmVaqmK52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/Zi4ZyndMHWVrsduqOwVKdneE9gkhj02tOtyRSR+iU=;
 b=B0o50+Ht82xwCPGoMfbfVLrktG/huAqrZWy1z/W3gP6+lCmV9ZgM7tQzzp5hXPdPvquqf0SPliJ2Zj6LvVl+wB+D/UTUjtkfLDj1IZIjKeUQp90cZxxO/+ApKMnPPByoj3iud6Okm703lpfIhl8o7iJyCOLQp7IAn4q8M+irG0WhFudLmury0iGvG8Yw2eYTN9VAvOYAswVlKLybbPOMzDo5bNBmOOw5C5PSLY6CJAyTM0GOEY2GFtctQXz/l0mfKOgb8amrd4DmxNxE5laEXMfdM9YA/4geMbjrCRssHrSUR1qIaI3ErW2qo6qClocGkV+uYLr31nVvf30NRIL8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Zi4ZyndMHWVrsduqOwVKdneE9gkhj02tOtyRSR+iU=;
 b=isu7tMH1usfRMgxb73fzJ5l4anl0floFWB+HirmmVjyArZGdpUsaOGMz8DYuvsTRBhSnEbJas9RUkL0wRK+AoHaWuUZiWYaQ2odmeoAia+hEkjvtADivORNpvGjzSR2V4Izqn/j1xoPiJ0eWbFLt2XAsF1vMOiSPYj+Uu6CCwh4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 06/10] btrfs: introduce RAID1 round-robin read balancing
Date: Thu,  2 Jan 2025 02:06:35 +0800
Message-ID: <6f78674a41cfacc84a12f41d6ce8ec689a5c3382.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1762fb35-afee-4b80-63c7-08dd2a8f7f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AptX/N6x3jyQlAWnDkaG3K29IbAaOxL49iNbHlYjDSML1YkAf3SzMMpJ19LI?=
 =?us-ascii?Q?iI2QIN/E4kUoOHeGQgOwFItNkZ+hiON8mTj90TKKI/ZsC8nS1pOrFOhBbwyk?=
 =?us-ascii?Q?ILGIUIyCqpQBrEtQjzH2fLq4tua6eMPSrRj56O974jUfir5wOgL+bnI5ak3b?=
 =?us-ascii?Q?Hmv9gDqGqfjU4CwRN0osONQ/WgyAMvTN3TrrffUOTZ9yNt1ARkhE3CLQmIqA?=
 =?us-ascii?Q?uzv1s6qgPS4fLlsREcgrvQZY79mg8zcmIKALpiu3geEg8nXeY6ZBrFJRghHG?=
 =?us-ascii?Q?jU1CVRoerKx7TiPwWwboEv5BAi/nPsmDik0eq1T2/lkbql2V6G3c3oW1Kga3?=
 =?us-ascii?Q?aPzOjiLIFlq504wXWqXMzs+4Nq2LDOR4XjeiIc8YEUYQdl5COMX5DIqZTceY?=
 =?us-ascii?Q?it6DDQqkML0kYwDEhsmCLfFC5VUx179SAiM8vD6FsKysAjX2pXnguV/heE5P?=
 =?us-ascii?Q?Vvd8s8SvRnO/Nxn2e4aGC1lx3Bm/sbFYDKlMvxMUwx4y93KFBH/vJPHsgJn/?=
 =?us-ascii?Q?9WdyXjN90z0GtIU17t4iCZTamJqacrWh7cw/gMMb+VWBaaUAfQpJQvgNCROw?=
 =?us-ascii?Q?g/nu7YkaZEggRztlfajhqivXj4JtqKxlhvIODlNcgyVRqOdhDYCr81RG4CmK?=
 =?us-ascii?Q?R6gxVoiHTowMNGSpyb1Ry9J1XFRslC8/AhL6nfXloFS9IiS+91nax6p3QIpc?=
 =?us-ascii?Q?YWhr9BgJKVvpsEoYhQDMBsDJJAHMUZE48OEEFJLT2FtBqtLgICWIwdeZJ3i+?=
 =?us-ascii?Q?2sqpsxiGYRahg1GLEK36morsMlj3btkU49H0+LcBjgqIHPyE4nRE46nu96bB?=
 =?us-ascii?Q?Hx+K87WHvSgaLDREsAEfABp0Y7b9mw2Kxi09Ov/BQbMnH9q3YQRpLW3kTKoV?=
 =?us-ascii?Q?KTAdak9H05Tz0hKzZZRyp4HjotaWr0htMOZNnQt1jBwy6tZ37YgIFrzV8nL6?=
 =?us-ascii?Q?cRtRTcKc/HcjKo8bH4FkN0y7zxPDiwZPHeYipWotVZ9jjNUqDakn5Pgl0u6I?=
 =?us-ascii?Q?RIQYicExR3/6MkRaRWnTG//9DjJmXKbOzAnX1zECpNzWi923vKUvf6yc9Nrc?=
 =?us-ascii?Q?apFtB1AxGsTocYUWRJTvZIYGaoFDJ9oX0g1W3YQMnGHGMOOL4536LZOKU65S?=
 =?us-ascii?Q?xVqee/WRVPCBkf53vNCqAeUrtRosGLvm1oCRMyZl6W/dgD0k5EZMGRiAVmV/?=
 =?us-ascii?Q?mzldQaeHKrA5nZSV9whjXztTg8F9eFkzsnliEzMwZU7z41oQf15pvlZXcFzg?=
 =?us-ascii?Q?1GnsQbcOdlbBLGnBl6xnx3Cvzpe7BzbGWVbqwXVtWgfciLxy8cg2iAM9UZD7?=
 =?us-ascii?Q?Lvh00jKW3THDUt4pp0l+6R+oMfeX0OanMWGyMWWr4Y1xlhqbMCHObZEcS3jv?=
 =?us-ascii?Q?0EKZNag1NLeKp7MiCEx5TxQ/HJnY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZgnqEGEN4skqmlzm7o5KuRm+9FzAfNU1SEOpZy9sSqU3wYu2mUkP6Ijsg9ot?=
 =?us-ascii?Q?jBJcFO/ogTmEBdyXfRta6xxeNjM+RixvRj5B0IHCggOGxgjbCnI5Yy4jOtPb?=
 =?us-ascii?Q?zqld0hG+lLnzuSrgdq6qUYxXF1UQ6fujs5MSiXnvo8io8LXBT8flrxCCIb5v?=
 =?us-ascii?Q?IHq2f/Cq91zWAK7qcNWKqL3GUcHJZXVtigtBIzwyD/SmvNZ6nna+w9X0tbse?=
 =?us-ascii?Q?j1u585HBtretyt3F9CNKP0Q8fNlDmtePJkK9KkpVjAFKqy1aT3xnc5crbuWg?=
 =?us-ascii?Q?1bwXvzs8LcWeflh8uoL8euuMRwnaIaWI0a9eK7s3PRk1Y1bZdSn0yhsAFC0d?=
 =?us-ascii?Q?ctiIFocG8epmjsL3cDc0EY5xN4UYT3hreJrI786pb5/86+WXAalF6IdpS+go?=
 =?us-ascii?Q?cRrUC+XQmWnF400JbB0b94/9fQub7loqHoX4Kk1iqHtvw1x1kWiYeVPWkV2q?=
 =?us-ascii?Q?YPWVA2qQdwgoydZdJwr+3QUMxnsh1Upept0woq7wfSv/HEOcc0OzRNysOuo+?=
 =?us-ascii?Q?cIN9lzPRbl4PMoC5FNuifOHsdVPpPOzBDj1EMyVigkegUHSLiuipc9WFaS1S?=
 =?us-ascii?Q?kuOp0ThzD3CQH01VGVQ6AuD/ZxDL7G4P+Zk6UUfPNCXHVAXASf5FdSSJCD8s?=
 =?us-ascii?Q?znJJ9TMJwVTCcx2kr+LMbiUxkkaHaq3xxNfewz5W3rA5lzuU3V36PIEjai1H?=
 =?us-ascii?Q?fwN2Le1/0e9LoIe4fahSMizV9Fzo23VwbI6Kby7aPbipJXDMC5ubqQnIS3uq?=
 =?us-ascii?Q?3E0VH0Xm48z6Au/fOhQnobONTqcdEl0kn6hzlUr+ndWXXJhvgBStkdkPR36D?=
 =?us-ascii?Q?j3FFBWeY1YXaL5qQyJ4OIhCeNLzbNyedSZV4pdJzRyPcdO853I6yM2/Us8Na?=
 =?us-ascii?Q?e1z2RSWfb93l5C+FSEFlJpbZwBY6v3UVrJFdoU/86vVLYD3u9EZgSGEANspc?=
 =?us-ascii?Q?DtGQkFErK2CbD8Bm9i86db6xK35mvg6Y8NU87xB7DU3yiHw+FMOjvbg4CYdN?=
 =?us-ascii?Q?ztEPRzkTIPpFGJd9dEd6iFLb6mmRqob/kqKQz7DTI/OPJLhxloMr2Pprb0hq?=
 =?us-ascii?Q?czdHlEXZhQtuNK50yKneAvvfDrk00cgFXn6QVrn9HFmOkuSQ9nSZJk3PjeQo?=
 =?us-ascii?Q?m1cz7cJt/UrSyvU2K/15xMSr9Bic3wLoC+cg5oQgmVjWK9D/uHHBNmiR3EmM?=
 =?us-ascii?Q?+TVgcnyYBwHmL5hqjDLV72rUl5LrbmwlVZciA1mI4KT/pT1FdghK5RCFo4kI?=
 =?us-ascii?Q?uhc71zRTSPWpWLdn2Y3oGUkIH7GYbgcJ0cYTrHlrpISi2U+mQ4L460eKWes0?=
 =?us-ascii?Q?Uxf+G0d0orGWh762RCA7E6NK0KvZlsQINQ6k4u+Hhty4Be5fpQw6iLTKWmbF?=
 =?us-ascii?Q?O7hb9xp5M6kHxD8GQ2C0D+fc99yu1nD1yuScUsOGA/EVzTp45vYYlUoX3sYt?=
 =?us-ascii?Q?NtJ/e7SvSp1WlMesm9IUvqsg+MqTBlFcNoloXz1eVNq60j/fJNDKKz8YBKaN?=
 =?us-ascii?Q?oyr/yVku2Yrqz31ye4PcHwlSnPY1147X1Ou/8YpkBHo+zc9ER+9btwsMBmzF?=
 =?us-ascii?Q?4XxeVnC7/k7qcnqg/zde8ZMXzmvQD2FFaCtiOzG0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ieuUO5R+H1Ypd/chnh6GkVUBntE4zo8Y5QjGbRazg/BJtKAQvkQRE7aNzmiKOLcl8wtVH5wd3Cj7dJADA6dgXMOhTAl1AAgXDprdHP/MsK4/RzDJLiPCi0JDVJ8n+2QjkGzuH0OnaLFXJM3J6UsNScVcZO3BEPceXcGLqz0m8cTPbwQfo6vB+0aGeSVkOm0ifrcWWyrtnUsFvZdPnR/3P8RD6IEM3HK3WzSQgwGXn8IQz2UDP/8fqDLQD1LYFhnXwrYsbzMhEqWvCSpciPhiuwx6AqvpSMSL/u3npJh0HkMQ3PI/WvjWijqYY6yLFPKtEy2xFuc/D6EpRclnpFTDVQyjEgovy87IQra1ZMmTD39At+QgoegrhrhiKW+Bdxsh5jLSyDYZ6H7dgzGsknEbcxCFJhhrJggWB1V+3x3lHORz5JOeKwIMGO/BmpkZhMiCc3QvOAVv9qSuWkfRYdHj5j3R5lSYxsISBKXtiX8Ubc1qMb6HJfbUhlbVL69ladzn5o35VqdgSA3L7di+g0PphjxYiL5wEYh4X3/qDC1Ez5GFPBYe4LogfIDMcekzux84q19BpdnIW5nIyjWb5W3nLGGphg7yGVO6Z1ldHvwRGN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1762fb35-afee-4b80-63c7-08dd2a8f7f99
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:56.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntFCCwZnmPG6eQJLtAAvZ0x/ZLIH9SzDAq+ZkBn9uv61GUC1RZ875kTwQ6fF+tJLR9FkSrUVLvepbArQuO9GpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-ORIG-GUID: W5E7pDKrpBAJO0_9RpTB3VY-txvob2JP
X-Proofpoint-GUID: W5E7pDKrpBAJO0_9RpTB3VY-txvob2JP

This feature balances I/O across the striped devices when reading from
RAID1 blocks.

   echo round-robin[:min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

The min_contiguous_read parameter defines the minimum read size before
switching to the next mirrored device. This setting is optional, with a
default value of 192KiB.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 49 ++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h | 10 +++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index cf6e5322621f..70f89d1adfbc 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1305,7 +1305,12 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+static const char *btrfs_read_policy_name[] = {
+	"pid",
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	"round-robin",
+#endif
+};
 
 static int btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
@@ -1347,6 +1352,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 
 		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+		if (i == BTRFS_READ_POLICY_RR)
+			ret += sysfs_emit_at(buf, ret, ":%d",
+				 READ_ONCE(fs_devices->rr_min_contiguous_read));
+#endif
+
 		if (i == policy)
 			ret += sysfs_emit_at(buf, ret, "]");
 	}
@@ -1368,6 +1379,42 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 	if (index < 0)
 		return -EINVAL;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* If moving out of RR then disable fs_stats */
+	if (fs_devices->read_policy == BTRFS_READ_POLICY_RR &&
+	    index != BTRFS_READ_POLICY_RR)
+		fs_devices->fs_stats = false;
+
+	if (index == BTRFS_READ_POLICY_RR) {
+		if (value != -1) {
+			u32 sectorsize = fs_devices->fs_info->sectorsize;
+
+			if (!IS_ALIGNED(value, sectorsize)) {
+				u64 temp_value = round_up(value, sectorsize);
+
+				btrfs_warn(fs_devices->fs_info,
+"read_policy: min contiguous read %lld should be multiples of the sectorsize %u, rounded to %llu",
+					  value, sectorsize, temp_value);
+				value = temp_value;
+			}
+		} else {
+			value = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
+		}
+
+		if (index != READ_ONCE(fs_devices->read_policy) ||
+		    value != READ_ONCE(fs_devices->rr_min_contiguous_read)) {
+			WRITE_ONCE(fs_devices->read_policy, index);
+			WRITE_ONCE(fs_devices->rr_min_contiguous_read, value);
+
+			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
+				   btrfs_read_policy_name[index], value);
+		}
+
+		fs_devices->fs_stats = true;
+
+		return len;
+	}
+#endif
 	if (index != READ_ONCE(fs_devices->read_policy)) {
 		WRITE_ONCE(fs_devices->read_policy, index);
 		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1fa40bf6f708..ab2e970dd6bf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1334,6 +1334,9 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
+#endif
 
 	return 0;
 }
@@ -5965,6 +5968,70 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 	return len;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+struct stripe_mirror {
+	u64 devid;
+	int num;
+};
+
+static int btrfs_cmp_devid(const void *a, const void *b)
+{
+	const struct stripe_mirror *s1 = (struct stripe_mirror *)a;
+	const struct stripe_mirror *s2 = (struct stripe_mirror *)b;
+
+	if (s1->devid < s2->devid)
+		return -1;
+	if (s1->devid > s2->devid)
+		return 1;
+	return 0;
+}
+
+/*
+ * btrfs_read_rr.
+ *
+ * Select a stripe for reading using a round-robin algorithm:
+ *
+ *  1. Compute the read cycle as the total sectors read divided by the minimum
+ *  sectors per device.
+ *  2. Determine the stripe number for the current read by taking the modulus
+ *  of the read cycle with the total number of stripes:
+ *
+ *      stripe index = (total sectors / min sectors per dev) % num stripes
+ *
+ * The calculated stripe index is then used to select the corresponding device
+ * from the list of devices, which is ordered by devid.
+ */
+static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num_stripe)
+{
+	struct stripe_mirror stripes[BTRFS_RAID1_MAX_MIRRORS] = {0};
+	struct btrfs_device *device  = map->stripes[first].dev;
+	struct btrfs_fs_devices *fs_devices = device->fs_devices;
+	int read_cycle;
+	int index;
+	int ret_stripe;
+	int total_reads;
+	int min_reads_per_dev;
+
+	total_reads = percpu_counter_sum(&fs_devices->read_cnt_blocks);
+	min_reads_per_dev = READ_ONCE(fs_devices->rr_min_contiguous_read) >>
+					   fs_devices->fs_info->sectorsize_bits;
+
+	index = 0;
+	for (int i = first; i < first + num_stripe; i++) {
+		stripes[index].devid = map->stripes[i].dev->devid;
+		stripes[index].num = i;
+		index++;
+	}
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	read_cycle = total_reads / min_reads_per_dev;
+	ret_stripe = stripes[read_cycle % num_stripe].num;
+
+	return ret_stripe;
+}
+#endif
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5994,6 +6061,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_READ_POLICY_RR:
+		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
+		break;
+#endif
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 45d0eb3429c6..5728b8717317 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -296,6 +296,9 @@ enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_ZONED,
 };
 
+/* SZ_192K = 192 * 1024 = 196608 */
+#define BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ	(196608)
+#define BTRFS_RAID1_MAX_MIRRORS			(4)
 /*
  * Read policies for mirrored block group profiles, read picks the stripe based
  * on these policies.
@@ -303,6 +306,10 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Balancing raid1 reads across all striped devices (round-robin) */
+	BTRFS_READ_POLICY_RR,
+#endif
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -436,6 +443,9 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Min contiguous reads before switching to next device. */
+	int rr_min_contiguous_read;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.47.0


