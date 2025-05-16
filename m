Return-Path: <linux-btrfs+bounces-14074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6438AB950B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 05:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC10A08093
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 03:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8B22B595;
	Fri, 16 May 2025 03:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MxVSZ7WW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K9Q9rNE+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8791DFE8
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747367904; cv=fail; b=tMbzVEs+S1kLVPSRQTll2ejaMzpUL2DKviP7OBbu8qLgcWqwXME4PAFvKZtmKQNxvW4wojxg3DIzWm+F/XuamoEgpRjElMdm1lkRBFYndy2C3Hh6toMVVV4+dz+LB1M4i7/Rc9o6TYZMgKEhrrZo+WlQcmepQngT+fRJQPnD0Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747367904; c=relaxed/simple;
	bh=VdiuyunzCbCQjOA4ER1B8vsABmHRo3gbXh3pqiwXOMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=if1j5gRfFTesr7KNoDEbDtYf80q7YlvIj82lnpSwoAqjcHlhNwGApFwsgPlv7Q3Cmr0cgRooY5/vxrCoEU63VcGIZPRGeB7+iIOQOIPLdGw9V+JpHLoqXMOKQtT8KgizpeRSVgVjJ+CYeI+1MovPa+y0cJswhIEytF31CFCa/ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MxVSZ7WW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K9Q9rNE+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FLbRiT023641;
	Fri, 16 May 2025 03:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rZndQDSOgTCc+zv9M8by8u6ip8SXMVCDcGwsTfvx51Y=; b=
	MxVSZ7WW6Oesi3wct7WabrfRS81VVd/6OgQHU+6u+IluM0g/aTiwMDYDnNX8jNIu
	0kp62Qqt7hlKV8YMlhs12uAjk2tJ3iJ1Egh5KvnmNDSQGT0oeOK4khLS37yI63Zh
	u3GRcELkW53QluU5uLxSgi0XySPPGaxWtvF9iU2qU2kDMJV2FfGD+DRsiE4O0sCF
	QH3y9/sHN3Ie6XrBNtYdncmTHzBEJmwmGbDv21A+6dgtlQFOuqc110aVMb822sYM
	nDonlP9yW7Iv9TJBpepxxTcnbarRFJz9WbMepQUrgWV6bK1iNP0ZmI3nAcWHcqn0
	udF00WQLzu8CSb7gLQIJ7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrberka3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 03:58:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G2sLpn026129;
	Fri, 16 May 2025 03:58:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbta4vq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 03:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP6jxah/1Rl5MbQoN3rTSlMIt9OvQFRKFuoGi4mfeTLlKOzZ0iXglGsgZ4Pjn6HgeuiUY1TKNd9jsG0bXS5kUzF1mzgFybovbWAPPOn2SmRuqbgllKJHMVpVcf/uwK+PaQDNbhHLEHDP6YeJBcO6jv+QjwrPCV7LNgs1YrOBNkwfHlClI+IiOew8mM1KlyiAPPa2hQHEre+7e5azd1x1S+xAuKdYqJreOFgXd5D2XaT8qGKGyoDxmg75x1399qkcDBEOlFFMkajCt37mLPonDL9Ud2KV3/9OdLfHpbQ+wrOUHQ2ZMGm/WBG1yWSfU8kFeDbDjQdXnj07zqkXOCADcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZndQDSOgTCc+zv9M8by8u6ip8SXMVCDcGwsTfvx51Y=;
 b=M4a2UzatZScWV1iFBEd4tg0MtASHJKv8ffneT9J6aoxB5HIyugn+Fg6qKCYUf3d5SksN6gJtuYxeUnqzXeKnCBg88pcmQVt8HapEo+FnKP01AB7Pd5oMOvogRf/MqCk3m8mqHB/rF6XWEyVrVAMTyoH0sxcG7W9W1N+t6JxFP3yQLhHkzrENftvmQB2JcxII1DQpKtjekapL5vY1U5sE8N6tFeuEFOQlBsKdvx9il2g+y8s/Oyyhik/5q0iIk8SKJ0s9P+8IeZLpnL4avBEQEWgCbgbM0E5IyA9QL4EHyezco/b7T34HOi6uEUTKZxp3GEp/loH+3o3KhPd9yk0V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZndQDSOgTCc+zv9M8by8u6ip8SXMVCDcGwsTfvx51Y=;
 b=K9Q9rNE+4cIfTgcKckA5mPndbBhOdirT1Qsga/VEgXFRnS9B16POASCNoeMGD0otBBkY86PCBqKQEdQZQDhoIEYhd20KAOpQO+/tLdtD4Blzas9rx/KV1umHZz/r0x2O1ADxdvd2rhHC2H8S6dPifMF5XAQssqdF0mO6JIo505s=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 03:57:52 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 03:57:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com
Subject: [PATCH v2] btrfs: add prefix for the scrub error message
Date: Fri, 16 May 2025 11:57:38 +0800
Message-ID: <adb7e0b9365da95d9497c4cde18233f3e52e41df.1747364822.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: ad36fb1a-f65b-41c3-f42f-08dd942dd503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1dCTUg3bnhLM1Z4YzNQK1JzbmFYSTdnMEluVktZZm4wWTFXUVhnUzN0M0JZ?=
 =?utf-8?B?SVh0TkpQZHlRdmFHZER6NnNKRytYRDNadzVCV1V3ejN1N0ZUbjNWbDRpdTRP?=
 =?utf-8?B?a0VCekMrcS9iMUtjeWVMc0xhMzQ5ZEg3L0FTNUdndU5VdlFoWWpFbjVueUV6?=
 =?utf-8?B?MGZnMG1PeUtQR3B3dzJaNUpLekZkTjhJVGtINHlvUWJQclNlRC9CazZGWEtW?=
 =?utf-8?B?a3NXdVkxNkthNVFIK1ZpVmV2WE96TVRXVUtqQURvdVNYQVFkcnhkZEdLVHRP?=
 =?utf-8?B?SjZ4WDI4Qmo1VzlWalVDRjZhenFVYzNjajlpNTFoR2dvOU5XZjhrZlVMSkpD?=
 =?utf-8?B?S0lvSDFWbXdLUDdrVEhIajEzYVA3Yk4yWXVPOGQ3aitZMHYzbS8xR1RiWWRI?=
 =?utf-8?B?czBNNFM2TUM4Y1J0VDFMMGJna29wZjJBdmMrei9xclV4amFCS0doNnRXNlV0?=
 =?utf-8?B?UVpXeTdEVWJIb2VTTTJ6RjgyTlBXOCtoWEJtdEhCRkpTM3VRN2FNMWlWSjk5?=
 =?utf-8?B?d2RmYWNtZDh5NVZBT1lBQWZSa2xtTVlzcmVzOTlha1pNTVVPd0tKVVZEQ3Qy?=
 =?utf-8?B?dlEzZExqb0c1RDlTL3ZiUUV2YVJaNFZIajgwaTNEMVJUeSt0QWZRalozb29D?=
 =?utf-8?B?cFFINWpIM3F0MWhJV3JzbUdNZkFDSlZST3g1VkN2M1VlZlYxbU1SSHR5YUk1?=
 =?utf-8?B?cHFzU2F2UElwV2JmU2tibmlSUEJ3T0NSd2x2K0lmTVpTc3JVaUNPZkQ0bkYx?=
 =?utf-8?B?MVgrRS9xSENhazB3UThXZDlESlM1eFljSlZHM3I2cmdOQXhVSHE2czd2OEZL?=
 =?utf-8?B?bXFDaWFMSm5YVW83b2N0ZFA0WGMwd0tSSFhOK0Q5WStVWThMRzY1ak5Sb1E2?=
 =?utf-8?B?d3ZCR1g0WVRlc3k1WGhEeFhNekoxbHg1MEcyNjJGTjlENXpkbFRVdkl5Wk94?=
 =?utf-8?B?MXduQUM3cks3cXp1dS9qcFpYRjVkNFBMbjJ3VDMrczN4VTIwejRCeEY4ZENN?=
 =?utf-8?B?TElYeFloUHN4WTQwTlVmN1lVZWpsTTlyUmd1M2c3bVVxNExKLzUxSzQ5YmJG?=
 =?utf-8?B?RW8vM01VZkZMU013WVRZU01QczNCcjZ5YkpHZlhXajROaWNIMUFrT3dzNEp0?=
 =?utf-8?B?aURKTERzN2VwdmF6cHZCc2FKb2VUQXFIdUptRFUrelJjR1N3dlI4MXM2aHFt?=
 =?utf-8?B?T0pkM01aZFlkMjZEUzF3dDJXb0x5TUh1NG9DdUp2RjZ5dUpodXdzM1pDWEcw?=
 =?utf-8?B?Yk9iRFlKUStocXdrY251YUJWakFTZXZGTWtkU0RXL29uSWR4ekZKZmJQN2Jj?=
 =?utf-8?B?SXMyNGhRT3J5OFRFdmMxQ1lQQVV5VVM0VnAza29JWEM1ektWRTdyeXNyV0J1?=
 =?utf-8?B?SnI5alJyOXQ4bGpZZndSODE4VENwQnJBTzdwUHNzQW5WbEI3c2ZGQXdKM1Z2?=
 =?utf-8?B?MnlVQzBxSC9USWJZa1ZacnBWa1NIM1pOUURwMERBRHlMMkYxRDBlT2UzNnI0?=
 =?utf-8?B?R3VoR3EvZ2Zjakt2TTlrTjk3SXpodDhVSTFXK2FwLzdPNUdTN0NsOFpKWmNY?=
 =?utf-8?B?Z2pXbDh0NXRDaHUzU3RQcFJkV3IrclVQYzFJaXZRMGdYYS9wVFVrZlZHc3Bw?=
 =?utf-8?B?SVZXaDQ5VnNYZGpMSGtva2ZqaGtneUwzUXZoRzhBSTNSKy9xNWliVnM0Zkdi?=
 =?utf-8?B?enpkYlhhd0VyV1BTZy9EaCtJT01DSllqSVBhR3pIRW5oOWVJUExaTlFGUjBr?=
 =?utf-8?B?dW0vTUQvd0RCV1hsZHYweGdNMCtkL3o1SzVtNTJXU0ZsTkczYXY5aU0zQjdh?=
 =?utf-8?B?dVdQS1lEaFZsRlZKYUQ5QysxRURGQ3ZWTkUyZXB0NFE5ZEdTbXpuV0FaT3I1?=
 =?utf-8?B?ZHhMNTJFRElBS0JPMWE3V091TENwc3EyN05GalpOVnRQN29SZ1FKNU5ianQv?=
 =?utf-8?Q?hGzqyL8Xy3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnJzRi9OK1p6TFgvaXFGamo3cUVtS0JsVVBsYjQ4Nk5qSmNpa3JGdUc3VnN6?=
 =?utf-8?B?b1FjMzJkdlJzbFVuMkIyR1NJUTVxdWF4WFBVVWgweHUvV2FQL1A0bWxmbFRC?=
 =?utf-8?B?RUlXb2lGU3hJT0hXaE05dGV2MDljYUdRYmZWRjF5THZvVndwWTFYa2NXN0dJ?=
 =?utf-8?B?eXp6S21GOWlWL1BRcDNoYTVMMm0rKyt3SWJEVVZWblFXMHdBWW9rUzVNVzJh?=
 =?utf-8?B?eGE1VCt2c3ovN0ZiVDd5NU0xMnVibDZsYm9kdlE5Ump2Vk1FekdWUVVBZ2ZH?=
 =?utf-8?B?S0FIMjZqWWxxMmhiWXk3WjFtVkZCSFpGeER2SU1GTFBBN0g1b2hZZkQySzh3?=
 =?utf-8?B?dVI1YUdXdi9RWXRmdUE5SE5EOHFYdU5HTFdxQWE5RDFQU0dYYmszMHpWa3U3?=
 =?utf-8?B?SDhuODhSYWhrdWdRUGlmZHhJMHZva3dreEExVTIzd1J2bEt6eG9zVVJ1WHNY?=
 =?utf-8?B?djkvYmdNQmhuS0xnTnBiR29lL1dUT2xtT3VhU2RDRnA0cWVUZ2pScmdGNmRj?=
 =?utf-8?B?alJuaTZ0ek9ZTldCMG84V2p4YUJXak54VEhDTWE0SWFsYkwwd01MeU1yVHpm?=
 =?utf-8?B?cndyaXh0NGM5L3R3c3gvN3I3em9sV09GU2hXWDY2S0Ftbjd6eEk2VXk0RjZw?=
 =?utf-8?B?VTdPL2xkLzkwdmZNc0V4b2Q0OWtJNm9ENjNsSWgwN2g0Mks3Mk55YWJvM2hH?=
 =?utf-8?B?clhOLzJUUXBJaHE3TUJpTmxsSXp5b3RCVFRaL3FZSTFhQjZTU1dQZmZTc1dH?=
 =?utf-8?B?aTh4YVRrL0FhWDZRUURjeE4rbHNLWTFsYjZXcUw1VDRlemJqTk5WbEw1WnBH?=
 =?utf-8?B?ZUhPa0NzTWdiY1RrWU9pUGZ2SDB2WmhrOGNGRnUvMTkvRXhZcUNSZXFRbDly?=
 =?utf-8?B?QndEcXc3WkxJcVI4Uy9idWRDWjF1dk5YZU1LNXVkTmU3WHZiQXJCNm45R0Y2?=
 =?utf-8?B?UTdFSi9Ha1ZxWGhuSHpFUFVxUUxMdmxxdTNoUUVWbW9WQ3V5NWI1MlE2L1Bv?=
 =?utf-8?B?U1J2NWpPbmVRUE5iNXNyT2E0QVlwWGpnbXdaZEtEem9DOGZSZ0Z2YlZRdWtD?=
 =?utf-8?B?enRPZDEwRWs0allRcXRVeFgzaW1XaVNic3oxQlVwWWlUVEtXaFhHYkVEYVJN?=
 =?utf-8?B?Wjcwb3BtRlJTTW5IeCtxWUR3clFsbk44VWxxTDJ4R2cwOVZheUxxUG9nTnhs?=
 =?utf-8?B?ZVRtTk9NMEF0bXVkUGR1K1A5SDU2UlQwRk5DMHBVcE1abkJaYnJ5Y2NpZW5h?=
 =?utf-8?B?enNodXFJT0tiTFZYREVlNkZvN2NZWTBiSnZ1TThWcWFYY2xRNFMzemlESGtz?=
 =?utf-8?B?TUxmRnpybWxwaE1sVWVObFhvWkcvbm9WQkhBOFBXQWhzMmpsL1U5UFdTNFZp?=
 =?utf-8?B?SE8zVTk5aVFGYzl1VnRYY0RFY1ViMTUrT0hDc1Y1OHVsdlpvak5TUDBmK2RS?=
 =?utf-8?B?TE1tUi9aVU9LNjk1UzRLUWZRTGV6aWxIbDFjV2dVU1BtSVBTOFVBZFFiZ2hH?=
 =?utf-8?B?cWVza2FnMU81OGdmcXR0ditSWXd0MkVOY0NxdzUxcVhNOU10djNFdUI5NGRY?=
 =?utf-8?B?ZlVENHFjL0pieit5NEpHNHRNb0QzV1NIaFFGZCtTQ3N1YnNrWTZXc3FzL2ZY?=
 =?utf-8?B?VmdzaytLWmZOSkpXK1FDeS9ZVTJxd3hWY3orKzVSRDdnMHF1RkoxVUczS2xt?=
 =?utf-8?B?Znk3WGUrbW9EUk5EaU5aajV4K0FWMUNoOVZzcU5jTTBCTlpUNDYydm9vT0ZO?=
 =?utf-8?B?eWpCSzdDVzZ3NHVVYm1rNDZ5ZlNxaTNiUkx2ZFlPTWY3c1hlWlVTZWxmRUoz?=
 =?utf-8?B?cGIzWnRCVlhIQ1h3MXpyU0REV3JCbXVvZWo2dUlzeWxhbEVoTUozMTExWUto?=
 =?utf-8?B?TEsrVkNhd0dxOUVqWkplQVA0SVBTT2puYkhlYXA1V3MwVGIwbHVvUlErcW9M?=
 =?utf-8?B?S05rd0VpRkNGSWFIR3dsZnlpcmMvcWFRa09JdHk5UE9GVU5NZDM5VkdZamJ4?=
 =?utf-8?B?TkZYZUhwTStDU1hiTU5pQkNMWk5FaWJlSnU1enp3N3ZrSTBqcEZvZEhKcmp2?=
 =?utf-8?B?aXhRdGZXZ3hnd0ZNSzFyek1KRXhaV0RwdDloTFEvelFMVXBOZE5HQTEzTjhI?=
 =?utf-8?Q?YbC7TEhoYqZ2nVT0tQlNrN9+Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Da3XxfyYtv87XP0G0uTYVDKDAvCGiMolgqM1acjfU9WLzS8JNTfveiX1K1hQXTk8aeUI1bYjcTeYosa8QUe30E5TkUwC+Cn/r/ZzXu21D8AMfTqt2yzQRu4MNHL7/Eto4JjaWmh2PW3YcMMl+CNXOANHBbhsf96QQoGbAQjQwtnRBn/Qr4QBD5iSi07fPeiUcQt9D7I92vdbmt8f182+Q9zzERX7kuxJ3tc5VXg7h9/CxYCTjpQ+uKb6D7pOu0Qx8upxkMwML2fniXoUVDKuFRf/KtRK3rezBW+NwuTa4qAygO7xKxatXLmLH0KKFDKVyss7qebosatM6NABbDu78tYABbp+d8O6T/uyOrUt0/Gy3EKVVRv/b4iXnPYedwb8RiP7LvVUo/+smJfor6BfAsgwnLrJqBQ9Jvz0ecItgX8k1CuZ2V+ln42P7vArb31wrfascr4O6zuRBs4NRW3ApjRX/UIHcSBd/vC9c67OKsmf4D1RXt9w/ydAFlBOeetccyh2VdcqORJWECPWsGSVuPxitrU0XMPfVYSRDMfNS7U+fhBpbd7EEUkOSpJNz6PnXA05lRJS0+3i4Bdo8Jqwf6VAVc2lLuRqQFuH07C0Rnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad36fb1a-f65b-41c3-f42f-08dd942dd503
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 03:57:52.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e83dL2FW5+2sECqqjt2k+oYLpgpKe6OgbHZC6VEo9gSCNN8XzNdAcm1rzX1DrYbqLH9tNOdYXtZvYzBbY1vvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_01,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160035
X-Proofpoint-ORIG-GUID: _6kBIlHL4CtE946hTc_EvpaX8GLObpn1
X-Authority-Analysis: v=2.4 cv=R8YDGcRX c=1 sm=1 tr=0 ts=6826b7db b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PnT9UMLRSUDtOzlPSn0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: _6kBIlHL4CtE946hTc_EvpaX8GLObpn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDAzNCBTYWx0ZWRfX9K4rmFwfADww t1OP2UWerzvFGxVcz7sfAIVZ0B67FpQOzsC5SAhORQcIn/IEOGvWpH545cPDGf7q+FHf7Xd2Ahd y14pe7oMoBz7rjOBVNH6ry6nkTea63Ll22WGEYcLnbq4mjXLgKI+0qFREiu4oS3nvdG2u+edR0X
 MhPEI5E9erQU7rqr1hQ85q8yuzEhRrpjE9SdKrvnn+b3wB9IjWNnBF5g5k/MY+6USwtvGCQE0FA DZtEr1W1KNnpj7vis/R2JR4Q4AVJT5iOCf8PpPd5w7UuKOtqinnR7O/rKwwuujmZyzkGiHUeJNA Av5FNB07/+3EczmRQJDPLv1QMWUR07+pPw2xPK9/FulQvwleLKKfMtvRoKPm0b2hUPnNIKtaHba
 EUoBf5Br89lLN2mYStUNAx4Hf/x8D4bv5/bRaEDUnocoroL0oTsrjSohYhu/2+GBEOwvqeJl

Below is the dmesg output for the failing scrub. Since scrub messages are
prefixed with "scrub:", please add this to the missing error/warn/info as
well. It helps dmesg grep for monitoring and debug.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Fix remaining scrub warn|info|erro missing the "scrub:" prefix (per David’s review, ty).
 Drop rb
 Drop Fixes:
 Update git commit log

 fs/btrfs/ioctl.c |  3 ++-
 fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a498fe524c90..680a5fdf89c3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3142,7 +3142,8 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 		return -EPERM;
 
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
-		btrfs_err(fs_info, "scrub is not supported on extent tree v2 yet");
+		btrfs_err(fs_info,
+		         "scrub: scrub not yet supported extent tree v2");
 		return -EINVAL;
 	}
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ed120621021b..558f0d249dcf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -557,7 +557,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
 		btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
+"scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
 				  swarn->errstr, swarn->logical,
 				  btrfs_dev_name(swarn->dev),
 				  swarn->physical,
@@ -571,7 +571,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 
 err:
 	btrfs_warn_in_rcu(fs_info,
-			  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
+			  "scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
 			  swarn->errstr, swarn->logical,
 			  btrfs_dev_name(swarn->dev),
 			  swarn->physical,
@@ -596,7 +596,8 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 	/* Super block error, no need to search extent tree. */
 	if (is_super) {
-		btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
+		btrfs_warn_in_rcu(fs_info,
+				  "scrub: %s on device %s, physical %llu",
 				  errstr, btrfs_dev_name(dev), physical);
 		return;
 	}
@@ -631,14 +632,14 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 						      &ref_level);
 			if (ret < 0) {
 				btrfs_warn(fs_info,
-				"failed to resolve tree backref for logical %llu: %d",
-						  swarn.logical, ret);
+		   "scrub: failed to resolve tree backref for logical %llu: %d",
+					   swarn.logical, ret);
 				break;
 			}
 			if (ret > 0)
 				break;
 			btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
+"scrub: %s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
 				errstr, swarn.logical, btrfs_dev_name(dev),
 				swarn.physical, (ref_level ? "node" : "leaf"),
 				ref_level, ref_root);
@@ -718,7 +719,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
+	  "scrub: tree block %llu mirror %u has bad bytenr, has %llu want %llu",
 			      logical, stripe->mirror_num,
 			      btrfs_stack_header_bytenr(header), logical);
 		return;
@@ -728,7 +729,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
+	      "scrub: tree block %llu mirror %u has bad fsid, has %pU want %pU",
 			      logical, stripe->mirror_num,
 			      header->fsid, fs_info->fs_devices->fsid);
 		return;
@@ -738,7 +739,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
+   "scrub: tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
 			      logical, stripe->mirror_num,
 			      header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
 		return;
@@ -760,7 +761,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
+"scrub: tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
 			      logical, stripe->mirror_num,
 			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
 			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
@@ -771,7 +772,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_gen_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad generation, has %llu want %llu",
+      "scrub: tree block %llu mirror %u has bad generation, has %llu want %llu",
 			      logical, stripe->mirror_num,
 			      btrfs_stack_header_generation(header),
 			      stripe->sectors[sector_nr].generation);
@@ -814,7 +815,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		 */
 		if (unlikely(sector_nr + sectors_per_tree > stripe->nr_sectors)) {
 			btrfs_warn_rl(fs_info,
-			"tree block at %llu crosses stripe boundary %llu",
+		       "scrub: tree block at %llu crosses stripe boundary %llu",
 				      stripe->logical +
 				      (sector_nr << fs_info->sectorsize_bits),
 				      stripe->logical);
@@ -1046,12 +1047,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		if (repaired) {
 			if (dev) {
 				btrfs_err_rl_in_rcu(fs_info,
-			"fixed up error at logical %llu on dev %s physical %llu",
+		"scrub: fixed up error at logical %llu on dev %s physical %llu",
 					    stripe->logical, btrfs_dev_name(dev),
 					    physical);
 			} else {
 				btrfs_err_rl_in_rcu(fs_info,
-			"fixed up error at logical %llu on mirror %u",
+			   "scrub: fixed up error at logical %llu on mirror %u",
 					    stripe->logical, stripe->mirror_num);
 			}
 			continue;
@@ -1060,12 +1061,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		/* The remaining are all for unrepaired. */
 		if (dev) {
 			btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
+"scrub: unable to fixup (regular) error at logical %llu on dev %s physical %llu",
 					    stripe->logical, btrfs_dev_name(dev),
 					    physical);
 		} else {
 			btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on mirror %u",
+	  "scrub: unable to fixup (regular) error at logical %llu on mirror %u",
 					    stripe->logical, stripe->mirror_num);
 		}
 
@@ -1594,7 +1595,7 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 						    sctx->write_pointer);
 		if (ret)
 			btrfs_err(fs_info,
-				  "zoned: failed to recover write pointer");
+			       "scrub: zoned: failed to recover write pointer");
 	}
 	mutex_unlock(&sctx->wr_lock);
 	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
@@ -1658,7 +1659,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	int ret;
 
 	if (unlikely(!extent_root || !csum_root)) {
-		btrfs_err(fs_info, "no valid extent or csum root for scrub");
+		btrfs_err(fs_info,
+			  "scrub: no valid extent or csum root found");
 		return -EUCLEAN;
 	}
 	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
@@ -1907,7 +1909,7 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 
 			btrfs_err(fs_info,
-			"stripe %llu has unrepaired metadata sector at %llu",
+		    "scrub: stripe %llu has unrepaired metadata sector at %llu",
 				  stripe->logical,
 				  stripe->logical + (i << fs_info->sectorsize_bits));
 			return true;
@@ -2167,7 +2169,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		bitmap_and(&error, &error, &has_extent, stripe->nr_sectors);
 		if (!bitmap_empty(&error, stripe->nr_sectors)) {
 			btrfs_err(fs_info,
-"unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
+"scrub: unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
 				  full_stripe_start, i, stripe->nr_sectors,
 				  &error);
 			ret = -EIO;
@@ -2789,14 +2791,15 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			ro_set = 0;
 		} else if (ret == -ETXTBSY) {
 			btrfs_warn(fs_info,
-		   "skipping scrub of block group %llu due to active swapfile",
+	     "scrub: skipping scrub of block group %llu due to active swapfile",
 				   cache->start);
 			scrub_pause_off(fs_info);
 			ret = 0;
 			goto skip_unfreeze;
 		} else {
 			btrfs_warn(fs_info,
-				   "failed setting block group ro: %d", ret);
+				   "scrub: failed setting block group ro: %d",
+				   ret);
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 			scrub_pause_off(fs_info);
@@ -2898,13 +2901,13 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 	ret = btrfs_check_super_csum(fs_info, sb);
 	if (ret != 0) {
 		btrfs_err_rl(fs_info,
-			"super block at physical %llu devid %llu has bad csum",
+		  "scrub: super block at physical %llu devid %llu has bad csum",
 			physical, dev->devid);
 		return -EIO;
 	}
 	if (btrfs_super_generation(sb) != generation) {
 		btrfs_err_rl(fs_info,
-"super block at physical %llu devid %llu has bad generation %llu expect %llu",
+"scrub: super block at physical %llu devid %llu has bad generation %llu expect %llu",
 			     physical, dev->devid,
 			     btrfs_super_generation(sb), generation);
 		return -EUCLEAN;
@@ -3065,7 +3068,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		btrfs_err_in_rcu(fs_info,
-			"scrub on devid %llu: filesystem on %s is not writable",
+			"scrub: devid %llu: filesystem on %s is not writable",
 				 devid, btrfs_dev_name(dev));
 		ret = -EROFS;
 		goto out;
-- 
2.49.0


