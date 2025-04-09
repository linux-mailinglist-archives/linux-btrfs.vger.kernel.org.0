Return-Path: <linux-btrfs+bounces-12898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9024A81E83
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E3F7A62A8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB525A33B;
	Wed,  9 Apr 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aj3eR1xP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZVJvMw/Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A182899;
	Wed,  9 Apr 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184671; cv=fail; b=W44QaiUQByijLjKKXarHmbJGKvGYYjwRkj3lb+WnRyEYFJHU99Q9gR7X0450vHOf/4ddn6RkXHF01x8GZ19qk1S60kIFJMABhItR8ImWQGXEa4vZET3WbQq04ebzp9yyeu7B2qC62xVn5pw8qYU++EhJgV3KfUmyrVoky/xkJM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184671; c=relaxed/simple;
	bh=7wONUPwTRkzoqXjjDECFwx2DnVUDaNvhziHRXfXaYTU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MDREgoCg8TW4wFgZKODTmTXIbEQZwRvGc06t/MWLAG3LPVLr/PoS5/oLeR9ffnmnMk97Uz3di2PlNGjVgFcdu1o7w+ZMIvwNFB+ztjwp67FZxOd5v9o3MAreO+s8u3kxWeEUCIG2mllbknUGHdag9ju9nvjNwrRtFnPbZUtrZSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aj3eR1xP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZVJvMw/Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538LAGH6024746;
	Wed, 9 Apr 2025 07:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=0VFJmYVkNO+LsI9O
	Q1tHnfy5yEZciUM3SHvmSV5fS9A=; b=Aj3eR1xPuiZ6vFI0smiQYMekB7K4Mzh+
	AgWSNecGH1tQGnE6uxqn0dbzwRmLNunmk9x3Y4YSI3D1ozqIx9xveID4HCc74ZMT
	owrk8/+vtHeP1T+OnUJKKYHEQLpnCIRbuPyKnd7PDepR8h611J2YiAkQq7MPF8b9
	XDBRy3gFIXsAuk1R1jOkKffH/Kn49xHTmqkALkJskhsGldAnHyki4AhaQi98oIVg
	6WITgcdVp4HIQQmaVgKwkp8gJHP+XUdhBnaVxKf94VmwDYEfsuflfJbZ8Ulmcsu/
	E+LMlqZoVIu+0ub8HJaD9QZCCU8j5sZQthTeC4ZU/oQZWBD91qe9yA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sxg8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5396E23O023934;
	Wed, 9 Apr 2025 07:44:23 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttygrpfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBVAddSr3PgculVWPnONiGpXKxrzeT+3fuy0TGf1jCqXMGKHt+6hZJWhp0TSE5wt19D5xuvcdq7G3Z6sty/6L4Xmi3BhsBXEQvP5v3wjWMY396s7KCrhZnGiQtiiwigzXH6dJ4s06VuhBrDjHBRLKV0KlY4kgwoxaNt6XJgRDmIt+8TGnv48PL4rm6req57yg5IAF5yLcTFwhriYAAzpWJQ2hlMceaFedSixCB6WZ4qcA4ycvT9Ica4g3WI5vaigtzWZoM02yisArYqJqXGpMEHaLXI1nzoU+1Yd1xMasko5WjARqcx9P9BJ/8X9YdP4KxdiOunWZQI4TrXrROLYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VFJmYVkNO+LsI9OQ1tHnfy5yEZciUM3SHvmSV5fS9A=;
 b=KszbiUfFl2dbw8umv0hAiuyZFWgi2Rt1qFjatVjlt3O4XEDhpecLY+vIOQQgytV8ZHRsgDUl1AUF7IoKBFqD2LxSXPCcJNKEAczuIr3cJzqfB9UJccuRmtlcYoOnsJNdvlQMQTzZuhkC5SwuXpgs11ANvT9JmFoaACqGWnzzmLvMhMMAKKsyZSXqJ8GgD8P0oRPYDon5KYhGHMpKIbGFP6g7UAqyWzK8j78NMUk4xzpzLv6r5tltByonPvJRmOOFbqsczi9cgfNFYnG5T0YbdMFXmybHizCd3YeYNqiRECv2Q6pBmXSoMjYBtuBem/MsFF1HocZgnQfmcgXVCU7+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VFJmYVkNO+LsI9OQ1tHnfy5yEZciUM3SHvmSV5fS9A=;
 b=ZVJvMw/YptLscSBBipJfJ5f0p+vbAnnKnD/pAMBPAwpKlcZ4qrZsmvAlC7t5fiy9DpqPmSRFDB9RmxJ8T9xQwYP7BM3ejh608g66ochatvGfqejPjEDZGFfTJbRMn7IfX0a9ksUnimcPzn48J7W+AC3gWTGUNlGfLr1Ckh4ukhU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 0/6] fstests: btrfs: add test case to validate sysfs input arguments
Date: Wed,  9 Apr 2025 15:43:12 +0800
Message-ID: <cover.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6c9641-c1be-4391-3cc1-08dd773a56e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlF4WmhWMmFIak9iUzBvWWxyaUFjOTAwQjJycjhHWU1mNEFWSkgySGpzeVlP?=
 =?utf-8?B?ekZHRExCaVBSTEhwSHp2TWtZU0ROdm1sYjRkTnpOdXZOaGN3VVYxeUpVaEhI?=
 =?utf-8?B?eVlURlRkK1V5L0dZMHREQWx1dCs4MzlsUjE0ZGNlQWxNU1hGUzdWdlREcUNp?=
 =?utf-8?B?Mms1bFNJbUZFNzNra0NkbitGbXB1NEUvWk9jb1FwczVFYlBKUmtlaVJuOHJk?=
 =?utf-8?B?d1hDdXFEd213QURSREpEbUFhVitoUzFCQlVtRDFkN3FCYnhxMHJEbXNXRnBO?=
 =?utf-8?B?enFBWDVKbVpEcWtlUUZQVnNRVVBZdU1pZlEza25nOWRwTHlGcDVwcDNtMGpJ?=
 =?utf-8?B?d3BuVHIydU0xdUFVdFZOU0lpVG12ZVJpK3RWeE1lRXRiZGJyNnFFZk0rb01B?=
 =?utf-8?B?TXFKSTdlVVJMQytQUXNpdHNncWRXLytaQ3Qybk10OHBEZW5oclN4WkFvOUN5?=
 =?utf-8?B?VTE4SElPNTZKUDZjblZZbHVpQkxVcXhNZG1DYWxqcWkza3FjRjd3N2pqWEw2?=
 =?utf-8?B?cjlCRFZUcnY1UUttZHc4eVhCK2llK0NqTW9GK3ZERU9GVWVpZWZIOFN1MHZP?=
 =?utf-8?B?RWtEOXdZUDhUWmVEWmVJL3I3SldhZ1AyS043MXpiaVNaRFZBd0I2UTZNdDQ4?=
 =?utf-8?B?S01FK0lFSWo2NXQxWGRocE1NVWJoTlNvRXdieVpXR29MSFROR0s5ekJqdW9x?=
 =?utf-8?B?MVVqOEozaUcrd0dEWFVjTHhHSFRQQmhvZ3dnaE04UzdQeGt5ckdRTWZIYnFU?=
 =?utf-8?B?SVFvMkZ6a3h4RVhlVTErYzhHbnp4TmlCMXVYKzlJZlVDMnF1clJyZkpqdUZQ?=
 =?utf-8?B?UlkzbVZIYUpDTVlxTEJ3azBrTEZtbXhWWGlycklFQnV6UHhZbUI1MU1DbjZY?=
 =?utf-8?B?Z1hoQXVYeWNhdEdmcEJIZlJHWmV6bGlrcTlVQjBNUmhHWU83Z2FKMVljNW1p?=
 =?utf-8?B?MnMzdjhmSDdqQ0tBaDZlWC9vWkE0RXBFb3laeTlLQ0FGNG43NUgycGpjTElT?=
 =?utf-8?B?WkxxWmg0NnZhcld6RGFNclBDakVONWErVmNpZUZUanRGYThGUklpQXE0aGwr?=
 =?utf-8?B?a0RoVHZONklacTNJV3lCRFZCV0JTSTFFc3VQM2FlQS9PVjN6MjdSbldCblp2?=
 =?utf-8?B?bjB4aUVlTkQxdnFwNEI3VUtqWUZmV1dlQ21wTWtnTjg1UFRLQ2pHM01OcjhR?=
 =?utf-8?B?dnhrMitxYm5JM2ZVVjdPYmtBb0lGVDhEeUc5UFdrb21JeXNCajdkcFdaT20x?=
 =?utf-8?B?Rzgxa1dZZnpTRjZRaG9QbmkxQjRiRUN2U01RT2NqSnlGaHJMSEptSFVYVC95?=
 =?utf-8?B?UlpJUnNwL1k2a3I3U3NxRUpLMFA0Yk85V0hZNkJublNQVEhZQTVKVWVxTlJm?=
 =?utf-8?B?SzFvVFd5Q2IvbDVWM3pRMk5RaUFtSUFBd2lMOTZ6bU8ySUFOZ08rUEpkYU51?=
 =?utf-8?B?L093OWpuSEJvNWdML1lUTml6alk5YmVsaTIrYU9FRWRLV0k1KzVXRHYveVJo?=
 =?utf-8?B?VURBT0J2ZDhuUUhNK0E5bkgvMS9kV3owU3h2ZW1BUkUraGFwWnRHNS8zaUZ6?=
 =?utf-8?B?Y045MkpLVnYybVJzOUhIOVphYnBORVM5cWk2VWxUN0VnV25RU0xoaWRpWmd4?=
 =?utf-8?B?bkZNQW1XZlpQSTRlNzZOOWhMcmkvRHlZdEhlTXpEMzVrcXJEZW9aMy9FTVM1?=
 =?utf-8?B?RkdzdlgzUGxOY3ZJVnhReWZKMGs3dHZCdGt5U2JqNkNEQytlK0VSOUJnOGJD?=
 =?utf-8?B?QnpDL0dLN3dmdjFaVjFoZVBCbVNnblpleGYzNGNXSWIrb2I4Vi9RaXNaZGJI?=
 =?utf-8?B?NmpCSGRZZ0Zpd2U1MWQ1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZyS0VCUm9iRVRDWGZHZnJnVFZjL0krcWpiSm5sb3pZQTZiclJtTlozeWxJ?=
 =?utf-8?B?c0tWby92eTF5dWErbGIzNXZVMU9DNW42a2JLaXRDZjJPZ3BKQlBFeS9URlVR?=
 =?utf-8?B?YWMybHgvMWhYamxONG00SkZnVEZnbWFONS9qbWtOendOa0Q5dy81RnZ1MG0w?=
 =?utf-8?B?aERkSzk4eEtYaXhRWUlKV3VVSllSVGFzblBVU01INHdCNzQ0TGYzay9NeUI2?=
 =?utf-8?B?SmljdXNDdEIvMnRTbXZvanoyQmF3cWdaVnZxeDdERDlqR3VjZy9NZURaM3pw?=
 =?utf-8?B?U2I4WndIa0NzOXQ1bzVsZkpObEpVY2JuVFVsZ0NtMnBDK1llVlcvNXlzTDhG?=
 =?utf-8?B?M3JlUWlhTEVJWEdibHBjeHVRMWxqUHJldGFiUXV2QmhESlJXRk1ZNHFQYVYz?=
 =?utf-8?B?enNLay9nYmhxdm04MnFXaDduaWNzUzJvNitDdFVwdFg3eWg4YkhZc1VXYU5Q?=
 =?utf-8?B?K01qeFBGSVZ6TEVNWWxhaUJJZGVCbGptSnJqMDJWWS9icHFPYkxLZWx6eS92?=
 =?utf-8?B?MEFBaUdUTVN1MmlhNlZCUzhWQ0tEQUM0WEh3TUlvN1FtU1lNaDNVSmpseFdt?=
 =?utf-8?B?NE8rL2RhQlIyWDNjUFY5UXNsZ3VuaG5PMVU2by9wbU1ySm4wNGgrb3V2MEtX?=
 =?utf-8?B?QmZmNnNtUkVISW1ZNVF4eWN6dllrNHlFNHFRNnBUSUlMMGprL0orTHRjY2x5?=
 =?utf-8?B?QWpWc1lzZmxnSDR0MHhudUloU3FzOXpZUHJmWHpVRjQyMDB5dTdIa2NTYWN1?=
 =?utf-8?B?Y212dnEyYUZFWWdNZ1dmVGxoZU1VeXpOMFJ3UHZzWWM3ZDNkVEpXcFprSGhH?=
 =?utf-8?B?WGZRVDV5QlBHV3B1UWZHdWVwRERDUk9qL3lCN3Y5WGhrRHdha0RDSis5Rm9P?=
 =?utf-8?B?UElicWJNMXIxVVF4Rjl1VHlXelZBNTRieFpEN2tBSWY5a1diUEZTYzl1RzRG?=
 =?utf-8?B?Mzk0cS9VQjVFblRqSmE2M2NkT2xaSjlpMERLSWg3M3JReW4yTU92QVk4VTBs?=
 =?utf-8?B?cTg1b1JUSjRXK21sK092QzRHQUFBMnRyQ2hnUlhvdlBLdE5xaW9tRUpZcU51?=
 =?utf-8?B?YkYwZHZodnloZEhrWm5yY2o4ektwck1KYzBCd1Z5bU9tS1U5SzJUNzFTMnYz?=
 =?utf-8?B?ejMyRldlWUNqZ2lRa1ljb1RoZm4rTWltMUtuTEFBdmVZN1VyQWFtSjZuNFFw?=
 =?utf-8?B?WU4yWEdkeUlWc1VEQlprbnBnM2ptVVJQR2tiUERRYUgvT0JaKzc1TWdjTVBr?=
 =?utf-8?B?R21kVlhXY2JrVlU4U2Q0NGlKOENIY2RZb2pETGxzMmNPVEl6QVRkbnM1elRI?=
 =?utf-8?B?emMzV1lmZXVXd2c4T20wZXdlWW5pcnR4bGtpTitnRGJLN1VtVVE4blFFN1Ey?=
 =?utf-8?B?bFRISTkzUitXTisvR3F1VE9rM1NyMHp4ZjZyT1dBTWE4L3N3WG5BNis0S0NK?=
 =?utf-8?B?dFpaN2oxZEFac3k3ZmxSNktEU2tlaGhUSWVpMU5vTzBqM3hPZ3ZJUDlQa3dW?=
 =?utf-8?B?ZTIrWk5VcGhCVGNyZGd5QnR5TDFIOFpDZkdHM2dWdGgrV1c3SUdoMUJqNFRR?=
 =?utf-8?B?YkZ0ZFo5YVQ1KzBXVWpIVm8vWmxrbW1BMU83N1B5dU12K0hhdWlBOC9qemxV?=
 =?utf-8?B?blJMOTFJUGVUMUM2YVBXN0ozdXplSE5OYzRrQUsxWUUzVGs4bUlldzRwcVkv?=
 =?utf-8?B?a3ltYW54YnVuWFB0a01NZ3Npc1JkeXdWWDNvZXhhUUlJWWpxQ3A3Rlhlc0hI?=
 =?utf-8?B?YndlbGgzMllzdjY3ZWV3a1RHRUt3V3JWem1velliaERXTS9wQmxZdGZlNURn?=
 =?utf-8?B?K0I1N3FtRWYxMmdWMVZyaTl6d25MTWlnaUJHalR6aVpaS2VrN0E2YXZNR0pO?=
 =?utf-8?B?WUZqVGNVZWx3M2xpeEpOMGI4ZjYvU3loWWJTWUxqa0dlZ1l4NnFqcU5ZSEwr?=
 =?utf-8?B?SFBTaUxlUENhK3hmN29aZzFQdExxQ1A4VUt1WTR2YzJORk9GaVo2YkdkVUtu?=
 =?utf-8?B?QjM4MFZPVlgxZDZoUWFTZWJNcW1Uc2lOYUxia3FVQ0FablRvR01MZy9qUWEx?=
 =?utf-8?B?ZG1kU3R0UFF1NUFKbWRtWHZhM0d3Ull1VkxHOWdyaVo5OW42K2Z6MjZZM3Fj?=
 =?utf-8?Q?LF4adbJqdxJ9ZhQMv8E3E32jU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sFuvM8QOljHgshZP2dUQ3yrZFyvm82NeEJQzvuYstl1V7EyHQDJzl0SyJAXakG70C6otZ5bzLsEMhcjl66CAyHPoTnLiMtQHeSRuR3OPUW+4+6WvUzoDkqyrRDVaFQSnq2waMuaErGSX1DT5jeNn9dGH7DfIbS02MjqTzJh4Pk/S44dWKuGGUpOFJHmgQf9llh0guoXXQgGKuAqvzGp44/Rwy20bx+xbIxONLbw/NzOVIYtoh+EvRVAIT+6cByxXB0KPTgdrGNGRoKvEU51QOf6+kYzg5nxl0FvntyCJ5E7qRNUlFjXiCwd4ttjCHpr+3/RtfGbqJ0hXWb1fodqZz9Rakw73SwM6ACFHKryUwznIp3cdOcc5ZpH3wEaLdFhMu21AD+01y6OR9skJuEOwaw1OP9sRSXlMyvF0gckmN7OaeQS6iQUBrTIPQegJ1h4NTlkIEqf99i3xjVNJFbI7+weTZ5nZE8rwvv98AmFRvOu9QNWlS8uKj6kiQql/qei3vi+dZ2Eap7HfsxtYQ/D7xpm5jGNgyEgpDZGQi0EOwupwty5OzULt2nhRvd9VUzpe7P8+PDKUExIhwo0zR5ZDp1E8buGTqY3H44Y/+WvaNSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6c9641-c1be-4391-3cc1-08dd773a56e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:21.1305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw7tWgVNBuR/vDuVNeg08ig8wS7ZRo9kaYdu7Lip+RmxsN+fnsJ4i3N3mDe9vqiOn46fG0uG53GXhMmE9So8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090035
X-Proofpoint-ORIG-GUID: iRJU67UFTkk4mIR9fQq1U45c7nvO6ou9
X-Proofpoint-GUID: iRJU67UFTkk4mIR9fQq1U45c7nvO6ou9

v6:
 - Add missing if statement for the test in `_has_fs_sysfs_attr_policy()`.
 - Add a comment to `_verify_sysfs_syntax()`.
 - Set seqres early in `check::run_section()`.
 - Add _require_test to `btrfs/334` and `btrfs/329`.

v5:
https://lore.kernel.org/fstests/cover.1743996408.git.anand.jain@oracle.com/

v4:
https://lore.kernel.org/fstests/cover.1740721626.git.anand.jain@oracle.com/

v3:
https://lore.kernel.org/fstests/b297a34f-4c09-48bb-86a3-fea50c364ba8@oracle.com/

v2:
https://lore.kernel.org/fstests/cover.1738752716.git.anand.jain@oracle.com/

v1:
https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/

Anand Jain (6):
  fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
  fstests: common/rc: fix unset seqres in _set_fs_sysfs_attr
  fstests: filter: helper for sysfs error filtering
  fstests: common/sysfs: add new file sysfs and helpers
  fstests: btrfs: testcase for sysfs policy syntax verification
  fstests: btrfs: testcase for sysfs chunk_size attribute validation

 check               |   2 +-
 common/filter       |   9 +++
 common/rc           |   3 +-
 common/sysfs        | 145 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329     |  21 +++++++
 tests/btrfs/329.out |  19 ++++++
 tests/btrfs/334     |  21 +++++++
 tests/btrfs/334.out |  14 +++++
 8 files changed, 232 insertions(+), 2 deletions(-)
 create mode 100644 common/sysfs
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out
 create mode 100755 tests/btrfs/334
 create mode 100644 tests/btrfs/334.out

-- 
2.47.0


