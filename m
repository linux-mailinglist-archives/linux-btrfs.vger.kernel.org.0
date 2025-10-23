Return-Path: <linux-btrfs+bounces-18184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F8CC01BBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36BB0505210
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E830B501;
	Thu, 23 Oct 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aUZpy7Ie";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AJ10VM7F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFE25A334;
	Thu, 23 Oct 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229121; cv=fail; b=AAJj9y5xfHpUQAJ7KH1zGqHejgwPDIw5oYdbhR7TlIQurQ0DFIcoWHkNrOBN/AuKhq/HYbCEUgiw975athxHzPksGLYMasKQoWg1ufdqe3l9g4dpbQqim9CHUJSMRagtuHiFg3CvxwE4FiBQX1/DblvB3yhqvEp4JpDfUZENs18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229121; c=relaxed/simple;
	bh=xOhcNQNe4FZfNTZICpozllK6fvsTgbECqohCXsNaTVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFdT1AFOKSybOChki7u9zRDv0OCPhIo3oUMIcxNGKM75MmaL4rOEdbBuN2bvyupK4Fd4D+0s50/QxrF1PrGMkcHr8Bok+PLm+Vjz/btn7df+YjCC2AFRULuDaLRhRjdtwQ1fmZspXbrxGOz9rMlr+xEAkis2RTxKqW1JO4YoRaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aUZpy7Ie; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AJ10VM7F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NB0vNk006402;
	Thu, 23 Oct 2025 14:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NDcXBKgikV1MMUTGm2byK9/tFSDC6rpq2Sj04+CEyNA=; b=
	aUZpy7Iex7Op4fw1nKHn9rY2UWNcIAQyiMuhbUpiantY9kHjJPc8UnguYUEbvcA8
	GXSxFctTvTAhoofF7JpmXC75FFrKTFfNkbDTN8Fcv43a+gL9VyZT1MxwN/GNjt/U
	RfFTBOcooWQUbIBzyWkPSlfwVFCJfrmwqqOJ38EA2pZw5cqjt3edBjWuX1kilBOe
	hk2RMAU9ic1evYexCAV3KRJA5JTHPOFG4Bx7LO9yEpKZ+fnr9sqLy0YumphQxusQ
	Y9W/hIrbjyG6Hn7f/0pCeQpe5QagV2yeX7ikqTAFQXw/iVvoagdfBgVEPCneyTmr
	XaaPKV3s3PbATI+Xh1S0EA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3ktk1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:18:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NCOatP025415;
	Thu, 23 Oct 2025 14:18:20 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49xwk94gd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 14:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URU6kAhRVjiMMRJtL7qGK5ZD7Ie/OKAEMoG+53yqUJPJiV8nMRTHNLRmMEvQhQEpJPys0vg5/rsaGtHnqZCGYusWF0jRxdjvSK/S1ImjD0epUBALBQ7GFFJ+hmZ+eAmgQuy8/phlwcWdBmrc/B091yUdh32mJ8wcPX/WRBu5KK3++N4+bv6k5AikEs4jLb5gQ849eo/HaYwY7ahNuHTodMXncDUoVS9Jm34VcauSskONdt3Y26Kr84gEtqXzj0DUzY/CEKYdSsicfxSkS4pU4WoT7a/bapHjxRI0EUvah4LhbsBAAxxrKGBOPaO9bj62m1p93HHhqE0+F1s3WilB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDcXBKgikV1MMUTGm2byK9/tFSDC6rpq2Sj04+CEyNA=;
 b=wbHMze6YOzZV/08ZByxjTg2dwzqYRbgy/mJDaC9rJYNYUsl2Tk5dGzk16yzLpFcFdfrXt1UjkSJAADE+KOQ4Gfasa8qhV9KE222y9rYv+/r7gaKYob3n2oX/DRArtDIANO8URfoSeku9nbf0PBFPE9KxUS6Uh8AknLG1N0IxHQsUgH8S1hBimKFyBAxj4xxhfY7GUUHHaZFjzyRO5If/Kxv1pb99+A9vcSX3Isqmh20Ez2Lc21poulg7s05NF/+sVxpXcdVr0A+7NbRpVIpd7cSLT7Aa4on2KoCpMzMGUv4umuyPAUZmGIpG7FYFgCHUh+oOzJuogJRpg5Vfa5ioFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDcXBKgikV1MMUTGm2byK9/tFSDC6rpq2Sj04+CEyNA=;
 b=AJ10VM7FYQSs2oG1JMO3LU5w8SQialXCrcxmiqNKy/2Lgy/nJ5L2CRFk/GzKWiIjnc1QKLrLPDwBLedWZEUNaubwLW5qXg7UIG1zPp1KnRMyB9KdMFPsQplMc7Q493LfPeUgnkMWMbBGADWuto62i5jAE0qegDAum55/CJn8RT0=
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d) by LV3PR10MB8060.namprd10.prod.outlook.com
 (2603:10b6:408:288::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:18:13 +0000
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::c66a:6ade:4fce:910a]) by PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::c66a:6ade:4fce:910a%4]) with mapi id 15.20.9228.015; Thu, 23 Oct 2025
 14:18:12 +0000
Message-ID: <0b2bc5fb-2345-47dd-b980-120805d3c69f@oracle.com>
Date: Thu, 23 Oct 2025 09:17:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Kbuild: enable -fms-extensions
To: Nathan Chancellor <nathan@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        linux-kbuild@vger.kernel.org, jfs-discussion@lists.sourceforge.net
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251020142228.1819871-2-linux@rasmusvillemoes.dk>
 <20251022161505.GA1226098@ax162>
 <CAKwiHFiMAm-DX3aERH_F1UooiM1YUiMaax51exhRg2=1ND2VCw@mail.gmail.com>
 <20251022211133.GA2063489@ax162> <20251023124041.GA739226@ax162>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20251023124041.GA739226@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF517B7003F:EE_|LV3PR10MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: f4548789-a149-435d-ff33-08de123effc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVNIZFlGWitaVG5RMW9PTHZNd2RJT2d6VXlUSlhDWHJLU3lkZjZYa1VQL2VE?=
 =?utf-8?B?YjIwMTJCTy9sNFExWFFwZStBNFVlaTFibGhVR1p4dlJoMm1BTXR5bjdTRkxJ?=
 =?utf-8?B?RFVKOFpFYXJVbHBPbUVRRXVBYW9jcE1IVFZ5NWxUQms2QS81SHQ0STZJS05G?=
 =?utf-8?B?MGErK0p3bmdPVTQvRnN0dUVnRE5tcjdkb3dISHlWZEczZkQvQmEwYmYvNysw?=
 =?utf-8?B?VkVWdGtVeUZVMTZSRTVIL0NLZy8vdjcrb2liS1Vza2VGRzJ2MGljNmhpZHVo?=
 =?utf-8?B?c2NQRUx6bk5xS3JHMkhFL2lVUmtJTlR2dTRkcEhZMkhQNk41Vk5VeGNzTVpW?=
 =?utf-8?B?cFhaU0FBSXlJMHVHR05GWDExUWYxK2Q1d1h5YXh0TStyYXlpM2htRW9aa21i?=
 =?utf-8?B?elc3VmNGSUhIVDlIQXdXZDY0Mzh1cWZSdUtKQUhlbXhsQnNJTk0zU3JGUHZm?=
 =?utf-8?B?cmFnRWxIOWNsK1BMckVKQ1pRWFNYN24ySkJQbXVMY1JKMVF2LzBpWUtKVFI1?=
 =?utf-8?B?Qit0OEhxQ3RQRzVNNGNCdDNlL0liMll0N2t1MlN4SU1ENnNUT1dsd1RxV29E?=
 =?utf-8?B?NVY3OEVUYnBEc014TDhZZ1R1bFZFSEIwM2lPaHdYZGZXc0NmbHZXWUFQZUNl?=
 =?utf-8?B?d2RxNUhpbGZGbSttRjQvVStoOERONVJpWFB3SnNLbXdsTHFrdElpZGRkd2dP?=
 =?utf-8?B?TDU5VXlZN21aNThOeHVhdFArNmN0RUJpYkhsZitja1dsY2lTRlhJdnQ3SHpy?=
 =?utf-8?B?S09uVDhodjFSU2w4Z2tLbVFlOHoySDdIRFFLblFxWjRhNU1YdzdNUktzemZa?=
 =?utf-8?B?bi8yZGVVRGZydmVUK1dNWlM0OTZrWHkzeVpKRjlOajBsRzNodnVhMVNuYmZI?=
 =?utf-8?B?K1lIOHB3aW9Zdi9MZjNnZE9FajFBemw2TENBOFpMM0toNGZCQnkxVWQ1TnBu?=
 =?utf-8?B?d0VtVjlBMmdySHJQNXJUV3c0Z3BKOHVmMThRV0pMMjg4ZTVLM1lOY1NFY2Rz?=
 =?utf-8?B?R1piN2NwbExHQ0VMcW1LZmFhVmM0YVhQQ1lPSWJ6K3lmU3VVQm1pOHdhd3Z1?=
 =?utf-8?B?WmFFRmlvVWlPOEpBNThuV1lBTXF4a2t2SVdmTHNyUHA2WVJ6VDc3aERpSEZG?=
 =?utf-8?B?V1VwK2d5d0kvcXo1dzAxcHdXWVVsVVRhT2ZadGhqaE9Sa3hJZWtFa01zU1B3?=
 =?utf-8?B?SlN4UHFMVVhydkVIZ25sdWtTR2h5WUthdS84cjFoY1FLa1RwTHVIdVA0bXk2?=
 =?utf-8?B?eC9mUTlZcFhUU2lDSTcwbC9pRjE1UXV1YlZudWpKQmtWK0FlS2JMZWhkVnl4?=
 =?utf-8?B?TnFpbnZJR2hMYSs2d2dIdG1idVczWVJCM1Y1dWdQWVpYdzFjTEpyYTErUXc3?=
 =?utf-8?B?NmR2cTlLekFYekxTSXNvbFIrVFZIR3cwa2Y3azU3L3VXTFRWa244RzNXcXpE?=
 =?utf-8?B?Q0JGcWZ4YW5BTFd6akJYcWxXeFV0ak16bGxqNG5sTTh5Y2R2R2xyQUJUa0o0?=
 =?utf-8?B?ZTg0aFV5Vm5zeG0zb0JnbUFCT2J1V2t2VjNCbE1iZE9uZnBYUC9OWEJHd2I0?=
 =?utf-8?B?VzhVZnhrQWIwbkI0anRMQkdaa2ZwMmRUbi9oWlk3Ym15SDlsZHdZdGgwWjhj?=
 =?utf-8?B?a2tUbnR0OGV0bVE3dlVsY083WGtRSTJtUHlydVI5MUFmOVozb1dKMFRKV2ZX?=
 =?utf-8?B?ZUlNZXpGVUZ6ZUpmN28yY0ZVRklSeFlHQ0tqVENFcjU1ekFGZEI4RzZsakY4?=
 =?utf-8?B?V3JYcEdNSXVDaXIvbkxoR0ExcTNpMHV4aDk1T0xmY2V6ak01VEtGZHNmQ0J1?=
 =?utf-8?B?akFnbmdPeWphS3FJUUY0dFVCUFBFSCtZZlJpTkhQRVBkbmdTVXc0cTcydlZx?=
 =?utf-8?B?cldVd1p6bUpkelV6amhZdzhVbHpEMzFOdjNJRitWWWJFN2lrZHNyZVBSNjNu?=
 =?utf-8?B?aUZRdTJyK0gyRW5JNndaUzI3QWNiTXBkMXpsMGJqeHlIbUtnRUY1ZkQ0WDZz?=
 =?utf-8?B?eUFmdTlSTnRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF517B7003F.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkw2NEJORnBBbjJUUFJZc2YzWDB3cTdSWFNBQ20yM3ZZd0lUY2xjZGZIdWtn?=
 =?utf-8?B?UW5QTUJST3Vmc1J1RHlPSDVWbVpvRGtYVnJob2RUOGJsbTR6cnJqK0lncU5p?=
 =?utf-8?B?WXFVWnpMeEtEY3htRlZ6VjhBTlRkRXBxMWhqZTQxMkt6a0VTSzlmTktsNi9i?=
 =?utf-8?B?RVBRV1pnT1lISkZWM0RHYW0zTFpKYTJLSHAyLzJ1NVZFSmRqYnliR0M4NUF5?=
 =?utf-8?B?TER4VzZlQ25Eb1JISm56SGhUNnpxejc3WWlPK2dLanI5R1VBMm9oaml1ZzIx?=
 =?utf-8?B?ZHlYMUVheDIzbk1mU0l0WTAzWjNUamFaNUVHSGRCeEY2cy9KT0tEY3JuKzZ4?=
 =?utf-8?B?MWgza0c2emloNklGZFV4WEV0UlFHeU1nNUdXbjMvdXJ4bWtOZm9nN3JRVG8z?=
 =?utf-8?B?Nk9YU0dUMmNYV3Z0ZmwwcmExZ0YwRUIxY3hML0dIM0FmdmM0T1Zidythbzdo?=
 =?utf-8?B?bmhuSUh3REQwSGcvNmRPM1I2L2luOWVCL0tERzUyK2t2dTBTQkJ2TFJYZ0Yy?=
 =?utf-8?B?NmppUHBBM3pudUxIb2NMaktUOG9vb0g5WldZOHVNR2RyNk9UODlDOVZvRHdE?=
 =?utf-8?B?RGl6UWh3TzVYUXJybG9kTHFYSlJBclZkSk9rSm8rZ0k0ZHdrc1RRbmt1TkZT?=
 =?utf-8?B?QStLeUY5Vjc0U0JkajUvTzAvOU1QVFJKQzR5NFZONmYxY0I5ekdaeGJLNzZa?=
 =?utf-8?B?aWFnaWlPV3hxYWlMTVg0THVqNFBCVHFpSUtDUFpvYXV5THNheEhzTS9hM1Z4?=
 =?utf-8?B?TGtLeEdSMVJEaWYyS3JxY0h4RDk5YUp1K3o2RE5rRFdTQ2FnUVFRVUUvNCtJ?=
 =?utf-8?B?dm1Oc0ZoL3YyMWNwVTRzQkhyZUdvckF1WVVZeG5PUWZlenlvQ3JMdkovMGxv?=
 =?utf-8?B?ZVpoaW1lTjZQbUQvVFdkZzJOdElQcW45Z3M4TFBuaWlrMC9rT2xIR2kxbkdH?=
 =?utf-8?B?NzdzczVwaVI2YlRLLytwc3oxWEU4QXNqUzJKVVRpc0pCeGllbnVoZTlxRXNW?=
 =?utf-8?B?UGNkNzUwbDZwaGNJNWlxRzU2MS9sOWJZU0FLenlCT0dmL3YzRGxMNjduRWVl?=
 =?utf-8?B?MGF1YTVYUVdKMEcvazRWWjFZVG9kemZyblRBNjdRcXJkbTRtb0NvdGNBc0NF?=
 =?utf-8?B?OWZ2L21vYzdvWTdKVnRUWVUySjFzM2QzcFZ0VW52Z0pJdHUwN1lXS3JTRm9J?=
 =?utf-8?B?MDZ6ZURhWXBXQzhIMW9YSW1wRUlDejNjbEt2SWtqUlBkK28vblBUdTI5Rmgy?=
 =?utf-8?B?cGFXTDJSV3RWM2t1TzF3YUFJNi9tWjBRVXU5UHl0MXFKTUlDWHUvOFhMUDkx?=
 =?utf-8?B?eVRmZXVIMTIycXdBdHRiRTZZQjJGSlBlY0NsSWl4WXI1bDNZdi9GS1JMN1lO?=
 =?utf-8?B?dHByUi8rQWNJemdFM0F1WUI5U3BlNE9OcVg3Q2QrYUxyMjQzNmRiZ0dNemlB?=
 =?utf-8?B?bElHSy9RWGxtMC9LeWVmakdFNE9QY3czR3JxVW9Qa3djTXJZNTNKdTVKdG5J?=
 =?utf-8?B?MTM2YnNVTW1BUUVjMWthY2FmcWd3d3FoM1Nsa0tZeXZuSkVqSjZWSVNDZk00?=
 =?utf-8?B?NFd5MElLZzNVNENRU056OWFXODMvV0trd0MxRW4rMVRyYmZJK0NNKzgvZnFO?=
 =?utf-8?B?TzNvWktscGg3SktmTXpINkM4YlY2WWZrN3JCd1JJRVVvOFlqZmdrSFB4YnhL?=
 =?utf-8?B?bW1BdjBEODY4SkVVbVlscWVrQnEvZ2lXSVp2VkQ1bjZGRFNzcGx2OG12TE1s?=
 =?utf-8?B?Z2NWMWpNcW41bm9DL0NDRTI1SlA5UVF5cFRPbjdmakQ0ZFJkMzA4ZDk1Vmcv?=
 =?utf-8?B?UUZhYjRrNWdDQnpGeXU4RHZRMGdSK0M3c0ZjOU9rNnQrcEhXT3F6TUQzaXpV?=
 =?utf-8?B?anFUYVl6NmFrMmNIcHJyR2FBRzBRa0d1emk2WW03VE9jRFZPVFpXUUw3bk1W?=
 =?utf-8?B?NnVkTGZQYzhPRGlycmJDcjU5WlBpd3ZQaWt1bW1pRi9uVDZrOS9tanU5WW0y?=
 =?utf-8?B?Q0FmUzIvT1BJQ3F5eEtXdmh0SXNpeWRnSHJEYU9ZSDdKbDVOamlOWHZJMlV4?=
 =?utf-8?B?ak5hY2N5RXc5eEpzSCs5V1RhWVdpa0hkSldMSzA4NVlZSVBFRW9qa3lUdEc0?=
 =?utf-8?B?QlRWZnFSclBseDMvTTZsenRFcWRrK1FOellnc0pHLzE4MnJ4RFRhRStUQ1Fa?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c4vn89uDucUHDP6vRS5JvREg5CD/6Fz97s/lPGxMS1ECxJ20BnAmhIfTBj0PwmcDtlEtQEXlPafSXkzJcis7ks4IkmSOagR8cMD1OR6o5X643TkdPlegLFVWdOtwD79W+yEkI+EfBeyBSf9Ka6nsz/j4mJCF54eN3GWpsFvMGjWFAR5Up7HotaQLhwgplnET6T/yFWvdmjvU+7vdIDE2aKz/46dP7G0q7ZRWgVIC8qeUZUn8edRTTq0BkGzKoNRgbAIxPBbJSgb8Z7OQnb5OhpYG9b/KJthpiJdcxGgaJCpzOV411HqG97k7Xb8entree5DbnnO1L3CNmhJBGNgy+5g5k3J/94ERen2nv1jAlu3B7eneyWuKXvfs+yOsAZyz+Jp/OCCC+DHPdoVQOgxjdY1crNi0sJshZZW5btSratkuDNaq8I+2CQIyq31ihEZp35oEH03nRM0dvumqTW+2jljgS/XSwMi5x52+q+MdT133jJLkQhkTRqY4+iaXtB6LjJzGClxO2ORKHvRzHP56RBdJ87xBGuR5lcGDj7awGXRna2yJPCEIE2pKFhwzvyA1EJKdglS2wFmpjdLlXxamyaLXicycALFqc2b8gAeadJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4548789-a149-435d-ff33-08de123effc8
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF517B7003F.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:18:12.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CloFI2fYnnn6zKPiBsQLMsBG3OTnIk6Aq/sJlWlFDYU6RyeFUnPhjpAniNCTj+SFxRNJlhEErYFFPR900Bb6LKCxt8I1j1rZw6aPD6PqybA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230131
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=68fa392d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=41UkMmZjoj4xAeRSgfUA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: OcEm1masZwFVl1guKDL9ZcEP2Oo3vVkY
X-Proofpoint-GUID: OcEm1masZwFVl1guKDL9ZcEP2Oo3vVkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX9co2q2Y6Ga61
 jKjT5PSpAXfg4N1yldlf34A+Q0U6oQgDgM+H0fjMPF/pQ2NQ5EJdMnI5hBz/h//g6ZPda8kkB+G
 hvnYM8Xq/rZd/6ZiJuxhhJb+6xotSW3hK0St0zNuMO+XWum26v/AmG3A+y0fzK0pcNmQ/qb0Mds
 BJsgr5DT30IH3kLzkITbk86gBgwByXxENvXs/NX+cxQZujw8uq9Evfts3VtYiJDLDMQ2/A7UfcE
 bHDbmw5N4p21HGB/zg7JoqzTS2v+o8xQ9Dqm5XsC1llsN+AJuU0b1JIkf8R9vWqxNiMaaesTnAR
 ZX9eVriVbgtWfP2JvwTp5Zv532f15RzSU/a2j3itk14ib17rzUxgHstqlXNotXL/iEcrflIaTlt
 uEFTVreMKmUi1hw3Bn6VjB7TVhzXmDpeIZUCgUEfkY8rPGHSs88=

On 10/23/25 7:40AM, Nathan Chancellor wrote:
> On Wed, Oct 22, 2025 at 11:11:38PM +0200, Nathan Chancellor wrote:
> ...
>>>>> +# Allow including a tagged struct or union anonymously in another struct/union.
>>>>> +KBUILD_CFLAGS += -fms-extensions
> ...
>> I have tentatively applied this to kbuild-next so that it can spend most
>> of the cycle in -next to try and catch all potential problems.
> 
> One side effect that has been found in my testing so far is clang's
> '-fms-extensions' turns '_inline' into a keyword, which breaks fs/jfs:
> 
>    In file included from fs/jfs/jfs_unicode.c:8:
>    fs/jfs/jfs_incore.h:86:13: error: type name does not allow function specifier to be specified
>       86 |                                         unchar _inline[128];
>          |                                                ^
>    fs/jfs/jfs_incore.h:86:20: error: expected member name or ';' after declaration specifiers
>       86 |                                         unchar _inline[128];
>          |                                         ~~~~~~~~~~~~~~^
> 
> There appear to be other similar keywords (ones with KEYMS in the linke
> below) but my personal distribution configuration does not show any
> instances in the build where they matter (I did not test allmodconfig
> yet).
> 
>    https://github.com/llvm/llvm-project/blob/249883d0c5883996bed038cd82a8999f342994c9/clang/include/clang/Basic/TokenKinds.def#L744-L794
> 
> Something like this is all it takes to resolve the issue, so I will send
> a patch for formal review/acking but I wanted to bring it up ahead of
> time in case this is unpalpable and we should throw these changes out of
> -next instead of forward fixing.

I'm on vacation now, so I may be slow to respond to a future patch, so 
I'll go ahead and give you my ack to this.

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> 
> Cheers,
> Nathan
> 
> diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
> index 10934f9a11be..5aaafedb8fbc 100644
> --- a/fs/jfs/jfs_incore.h
> +++ b/fs/jfs/jfs_incore.h
> @@ -76,14 +76,14 @@ struct jfs_inode_info {
>   		struct {
>   			unchar _unused[16];	/* 16: */
>   			dxd_t _dxd;		/* 16: */
> -			/* _inline may overflow into _inline_ea when needed */
> +			/* _inline_sym may overflow into _inline_ea when needed */
>   			/* _inline_ea may overlay the last part of
>   			 * file._xtroot if maxentry = XTROOTINITSLOT
>   			 */
>   			union {
>   				struct {
>   					/* 128: inline symlink */
> -					unchar _inline[128];
> +					unchar _inline_sym[128];
>   					/* 128: inline extended attr */
>   					unchar _inline_ea[128];
>   				};
> @@ -101,7 +101,7 @@ struct jfs_inode_info {
>   #define i_imap u.file._imap
>   #define i_dirtable u.dir._table
>   #define i_dtroot u.dir._dtroot
> -#define i_inline u.link._inline
> +#define i_inline u.link._inline_sym
>   #define i_inline_ea u.link._inline_ea
>   #define i_inline_all u.link._inline_all
>   


