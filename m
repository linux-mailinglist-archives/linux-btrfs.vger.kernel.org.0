Return-Path: <linux-btrfs+bounces-12043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEEA53F4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 01:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73D93B003A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 00:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444F538DE0;
	Thu,  6 Mar 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PX84vf5m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FIYQFNII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93BB481CD;
	Thu,  6 Mar 2025 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221889; cv=fail; b=gPyb/QdgkYennVm2vJulp1FkGQs+te7iMcb5JKkIqrDfO6+3snT89Rf2b464ha6VAhpARD4lnZh9w7Ofr7aWtHcUstsnYq0ZCgSYfk7jNtRG9CvzMR/0tp2E6A8H+9mrICj1IRgCKrHpJHnWrpDshsg9tLdL2EoNmEWJ56kv93s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221889; c=relaxed/simple;
	bh=qTcedUBZjVHoT047nK5AFcOUTrrfxnD6tNMsyPFtMEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BozvAYvtyWF4r9wfqKzIQQV6IG6mPadjmURZOWwEESItdLQN3ylBh4Cdc1kddeqSs9OX2gdny4LHSEYJxm5udgMSBnj35A+YZ9U1emy6cmc9YjTMifsnCmhJID3tr3vE7K7az+oZpld3dVtk4za2aL2gD4wTLaFU0FpZXSylVN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PX84vf5m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FIYQFNII; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525M7nNJ029336;
	Thu, 6 Mar 2025 00:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qTcedUBZjVHoT047nK5AFcOUTrrfxnD6tNMsyPFtMEU=; b=
	PX84vf5mVJ/Ox4xOfSFTpO6Yi1G82lwlT3kPCVE0EAQn6XTn0RwD1HdD28cCfZTJ
	EOdiOMl/4czs7+JQ890RuPmQn60IKsXLTDrX0j46+QqcPiQ1/XkOYij+r5/IiuJ/
	oFHlfPNU1ePOPbFkqo8lXLtKfc+mu9miT0+9LBWn8TndZYVcbk7qe4aZJBKaWkHM
	AvV1wp/dbx2IzuwEja9hmoH5f7EapiP9PVUdYRmxCXlYXEaDIvyAmhl8m+kHNCaB
	M1V1TMRF18ACVwtC6vUJjdHpxIDRac2iBO2upl7MMDEiX+AuLBmyQBr3Q/M+Ah1m
	2d4A4dVEBfchE61MNdcDfg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86s25q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 00:44:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52600GZt003200;
	Thu, 6 Mar 2025 00:44:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpb8hwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 00:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AL8XwR5p/IgbxrwQpsvC6DwHlyXkWXPw1uwfuaXgF0mt/x6/kJjN+faUHlHjOewkHeyoFen6aBmhIL3YDyn3/c0vdzh4PfqHd5MpdE+eOezBa0DPGU9FVaQ12Cpj+rtRNrsc3LBRmNfg7EOQhgxfoz3MMCDPKqh4p3Z1NsH2sEsWqm+ds35/tRJav/JkYhv8if3pqYRx+OgpNBvOBvogBAK1rpPIsD0fxgK2sp8jeR//RIPnlmaVZmNzl0UCFFKWzUdXqb+tI4dbmVuJBQKmj+Wbhg4b1JD65pcmX/znwgdowvebAd+lADlXCDfJ8e3NGqEIj8QVIihX0ciBA4bh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTcedUBZjVHoT047nK5AFcOUTrrfxnD6tNMsyPFtMEU=;
 b=IM+9DPXT0+Nmjsm9hlDMSgcYpIhRByHoPl+cuDvrdLB56KkREOLQ0AnRH1hWt1T53Oi4ysmoHV+FB+iJkn471dLHQOYxNXQMoQ7Z71vaTXTJVGjv3jYNEenV0r8QqSe3nC9YMJOt3tbqok7OPmR/Grx9bCoeEUMnfr7lf3q2lq/tEcJ3KlC6wvdqMMe6D45j9LjNmVNLb04tzwRPbnAGqZ6A1/Jwj/xJR+juJ73EJ6yOkuThORfHs1QyolC52y93ZWnZchZtFXqtSNNN9IvVkcF49KrNGXyKtCIUvSuB+5rA0Cokwi4XRrC2hNl3XIugmB0+7dftXNuazaH2Ro4FJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTcedUBZjVHoT047nK5AFcOUTrrfxnD6tNMsyPFtMEU=;
 b=FIYQFNIIWm25E17/k8Q99u7bzyWXJP3DwZSTV+CxeQHCkP/AiUY8ImU2y3D4oNoo9/npi4T+s3gzGGtNDuGIG1KYU7jrwnL5oSu+FF0A2CK1GtSOm+GAzWdUqt1ZB8A0CXOsWLlCKPaJGR+nTcrmwJMkPsu+xwxK88D7y7/EJVs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 00:44:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:44:42 +0000
Message-ID: <68417a40-c25e-4a53-bcc5-7570dad7af13@oracle.com>
Date: Thu, 6 Mar 2025 08:44:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: return a literal instead of a variable
To: Dan Carpenter <dan.carpenter@linaro.org>, Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <2b27721b-7ef9-482d-91bb-55a9fed2c0f7@stanley.mountain>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2b27721b-7ef9-482d-91bb-55a9fed2c0f7@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8f95e0-2438-4d02-6f56-08dd5c481515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVRxWHBkQXZ0Y2ZPdGd0Z3ErL3RyZFdYSUJRa2hMQXlqNlE0NGl1UENqcFk0?=
 =?utf-8?B?QWY2RUE1Smk2VXFqRHkzOS8zSFVoY3ZZd1gzb3Uxcm5Kekp2enp6VUhXQVRZ?=
 =?utf-8?B?NXVVdnZIYXdIbEdWZ2dPdW9LcURReFBiYy9GNDJSc2UxdWtzWjJTcTgwV3Uz?=
 =?utf-8?B?blhDRUErNytkWWUvQ3UvRGpKdzdaS3V1UFdFMzlWL2hlYktkMUZTZ3VtWGVl?=
 =?utf-8?B?S1Z4S2liNTdQSzhobHNyeStvRmhseU02cEx5T1l4Z0JBdzlRMDJ0VzJ2TDFO?=
 =?utf-8?B?MDNqai95ZkZLV3RNWmh1YktQSmNQV2lTdDJ6ZkdRWjYrMkFvQ2l4bU14cWZx?=
 =?utf-8?B?aDMyTWl4YWx0MVI5SVZ0NEpNUEZsbURUTWRQUzJtZ1o4Rk1xeWV5dlAwbXhi?=
 =?utf-8?B?b1pHV291VW9rQkF2TGp6T0JuTWJsSjFoOWlpeHBoT1RYYkd3WmNrSllMRnFx?=
 =?utf-8?B?WW5EdkM3b0thVlNEL3lnSlBkajhjMncwVTRiYkVxVEM3cHhrRmpoeEN0YVd5?=
 =?utf-8?B?aXJBTGkvMGFQSWpPVmNlaDNFUnZaSWcyRkFpeEk4cmdWYkY2emFYRlB0MmdT?=
 =?utf-8?B?MHhja1MwRzIvZW5tajNUcWxhNUlBYm5wRC9NMmZkcWdRL1NmcDJpZldBdUN3?=
 =?utf-8?B?S2xRdGxZU1FKYlF6Z3IyL056aHJuS3lMK3pjVDV6aVppR0gwaWt1b1RwUFpa?=
 =?utf-8?B?YlEwOG5EUW8rYzl4dW1wTVo0cVFXMCtSZVlGUTEvY3dPbjl4RFA1blY4REtt?=
 =?utf-8?B?b0NnY2JsY1VlVUlTcFhSRzhxcDNIQmRISjduRk1IenFHcnlhRWlETEhMVFk2?=
 =?utf-8?B?U2pRVVM3YlBhc0l0eHhLcVZEZ2pzNS9WRzVMVTR1S1pFR3VrRWRhbis0Vlp3?=
 =?utf-8?B?UTFZbTc2TXdkTTVaNXNrdzcxLzdCcy94Wnl2VU5rcEQyMWwwNWEzcjU2N0Rk?=
 =?utf-8?B?MDJRUlpJWkxreTFZZUMrY1QzTWh4bWFIam5PelJqcGRlYUhKcUQ4SG1iVjRO?=
 =?utf-8?B?b0pHUE1YMXBEdDR2VG82WjRTcktYQ3FuUWlKZUpPUnlZZVA2WXlLQk5WcmhU?=
 =?utf-8?B?WmpqTkhrZDZ2NkdMeHNSU0lDanBjajdpUjBjZE0wR3A4Z25JYzZDczhIZzVh?=
 =?utf-8?B?ZXoxRGlKWm9iL3h1M2NCdDRvUnk3QVU0UVFxQjVIbHJNVzFoZll4U0NMaGw3?=
 =?utf-8?B?V1JiZkk4SGd2T2w4OVUxemFMbzBCRGRMS01TTThCT1ZnQjJsL3VWd25ScDk3?=
 =?utf-8?B?b01hU0g3a09CMWZlb0xzMkpvZEFMaDVyeHhGWGhqU1ZjckhuTjA3eHVJSWNk?=
 =?utf-8?B?bU1HRjhwMHZoUFdvdHBVaGNpT1hwaVhZSFB4UnI0RGRuaS8vZXA5M3BQRS9X?=
 =?utf-8?B?S1JJM0xWYzczOEE0aEZNS0RMRnhBUzdHeVlHZEFUak1uL0hXd1l5MExhZWFt?=
 =?utf-8?B?NDVFc1FpWm9jT21YdElIdE9MM1FMeDRBdGRNaFFVK0ZEUXNYaVQ1WDJCQTU5?=
 =?utf-8?B?M3ExZ3NXMHBoSGlXaDM1alpmejZNUkhsUC9kalAxektnVHpEdyttQldpRG41?=
 =?utf-8?B?ZFBLaWdSbDVWNHZ4OXhRWUdmUUNFZXptSW81VWwvWThpUk5QM0NlRXZRNTVT?=
 =?utf-8?B?Yml6TnltNzVPQ0NpOFBCV21VRXVIRHVIZlM1cjl1ZzlDY0E3T3d2Q1E2UjFB?=
 =?utf-8?B?ajh6eDExbmFGOVFBajF5OGdSMTNUQlZ4Uk9CdXVDM0d2TWZ0dUxudDNTb2w2?=
 =?utf-8?B?MXh0RnhqWVNKV1FxZFpOaWdUQmduYWs4T0lDS09IVS81OVAva1JzcXNjcThG?=
 =?utf-8?B?VUtWMEgvblpFKzRNMjNRZEJrNHpPU0RJak5vQmZwOFdaLzRyZm5jVmdxUGJT?=
 =?utf-8?Q?tzNReSmh2cBCv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFZTSnFPdjRGVDNlRy9ZaWdTUmRrTFlCSXg3RzhVTHJpNUxZeGZNZG0xR3VS?=
 =?utf-8?B?RVlQMUhudkVpMDdmZUV6NjlQN1Y2UCsremc3bHJ1WTRobHFmN2JNdWorb0Vm?=
 =?utf-8?B?MVRTVm9ZTWs5WURmRnVDdzRrNThWMjcxd09qeXEyMFhub25zZTlhOHdvSHNC?=
 =?utf-8?B?OVpybTB6U1lTNE1pblN3VHA2OWFiNmhOSlVXVTQ0RWd6YUJBOWErL1R1RE9x?=
 =?utf-8?B?NmFOSEcwLy9tZHhRTFZMaWVuRmtvc09ubUFrNTQzQXhvQzBMc0hkZFdGSmJw?=
 =?utf-8?B?TXJDV0dLUHgwdzArODJRRXVhQk52TTdqOTI5bXJKaS8yb0lvUjVnTXJKbkUv?=
 =?utf-8?B?ZFByZERKSDRLNTVIcnNLWGdtUit1QlBaazRnY0ZDVDJvdkN4SHQvOXpxNzNZ?=
 =?utf-8?B?VWRXeTVhdHl6SVJWSmdVaUh6M2IzaE95NTc3c3RMa2JXNmJpZ3FMRTUrcTVS?=
 =?utf-8?B?N1ZhSmNMczJGQk5JQTlSeFRwMHpNZE0zUk8vS3FGWTRFV21GZFpHZVN5ZEFo?=
 =?utf-8?B?ODgwc1NhdFhFZytqaGVxNzMyaUtXL2ZCb0VCa0dsVDBrQTJseHQ0aVJYb1pk?=
 =?utf-8?B?UWlnMnArWStOZGJQUUg3cnFmcXhUZEpxbnBrSFZYcys2QmRCajlPOWhCc0lO?=
 =?utf-8?B?N2RBVE5OTEpUVWs2d1dnT0FnUFhxblhnTGtWQ2xJSTM0YzJJTE9TT1RGT2ZU?=
 =?utf-8?B?R0ZieEhSR1h0aitRSWxkeGpUTllCZHQ0MzZ4K2J3Y0tWNTJqSUkycUUvR1U5?=
 =?utf-8?B?cUFRYllranFseHJtU0t2b2I0UHpMQU1nZGhBc3lmRTFKTUhxeHIvTU9NMisy?=
 =?utf-8?B?bTZudlFoVFFHdEFySk9JN2pWQzZaaEtROENmQUFwS2F6S2p6eXprOW56czQy?=
 =?utf-8?B?QngxdUIxaWRHRFQzRXJZMitlczZpVmlpcU1McDhaSGs4QW5PV2lUUWtLN0pC?=
 =?utf-8?B?bEtIcndVQUc5RFR5T0ZGckJwV1A5bWdXS3htUG4rMzdQSzBhalpVOHFVT0s0?=
 =?utf-8?B?MFBqOTNaRDMxUTN0V1JQZmdqNWpaWWpMSTVLQ3ZUaEg1amxiWnFnTytFcEpR?=
 =?utf-8?B?aHp3cWx3Ymg3ZENNNnpGUEpGRFVpUDJZTkk4cmtEaTdUc21RaVBEeW9yQmM5?=
 =?utf-8?B?QWUvaVRBWGFCT0hEUkx4YUt1M2JWZFI4OXNuZXlIUVFjQnJDTG45dFdMeFFx?=
 =?utf-8?B?cndOREk5Q1MzbzZXZ2F0cS9CamNoRVhqRmFNUEx2Z25xQTExRm5nRzdQamVt?=
 =?utf-8?B?K3Vsajk3NDdDd2xzclNHVm4xR0t6NzhTSHRMS0tXRHVoNXcrclR5dHBESWox?=
 =?utf-8?B?QjAwMU52MEdieDlrWDBNbFpDV0lmaEpDbUpDMmxpeFlTeXFrS1hVTTBGRDNL?=
 =?utf-8?B?d3Z6SU5oWTc1Nno3RHFjQTdtSFFsUkFrK1dOSTlZTzFxaEhOb2xBcDBNRjRz?=
 =?utf-8?B?VEVVYkcySXVZTzZ1QW12NVNja0RrLy91NFIrdTQyZXlCM3dJU2UzdFNSOVlk?=
 =?utf-8?B?ZUZYb2dQYkxWeTEydTNGdnZiT1JaeTlvenU0bUlaU1h3ZDE3Wkc5U3k0NDZy?=
 =?utf-8?B?S01BTkkxdjJ6QjVHSVIvWGl1MkQrbHFScDZJZDg1cHlGc2QrNnRWTHo4Q2tU?=
 =?utf-8?B?TUxtdExWM0VkM3QvSjZhNGJBalpzVHpLZUVOZlZBMkJzbE9WK0t1NFhmUndy?=
 =?utf-8?B?bGRQVmJ4VEU0NzY4UzNnb3c4WmdCdHI4Z2owblF2SHkzUFhBbldaempIcS9k?=
 =?utf-8?B?Y2hFNXUrWVFqYkhDczBwNUJab0xjWXg0NWxoTEtoZjZnUkd0REpWRnFkS2dJ?=
 =?utf-8?B?YlJiQW5zUlgraGxaVTdlNjYrQ29sdmZWSEkyb2lvWmhUOFptaWVkVXJ1M1M5?=
 =?utf-8?B?dFBmcDF2Yit3V0tVcGN1M1BRZFVWdUZxam5oNVpBK0tsWThUTHgycG5SU0dw?=
 =?utf-8?B?U2d0ejl0a0diZzA2aXg3Wno5ZUEwdWdlQmJ2NUhmcEhXVkdidnFaRjBhaFRq?=
 =?utf-8?B?NDBWaTVFN3ZNcVR5MEJ1S0EzTWVBOFNlOUJQckUwZG80QXJtbDZOR0s4U1B3?=
 =?utf-8?B?STZ1VHZmSlRXUDRUQWVtRVdiT1JSYXYwd0dFcVFHR2N6TWFLOGQza3dhN0V4?=
 =?utf-8?Q?weSM2II+0kpwXSoTbObUHGv2Y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J/WvoHGKChncyAdgoSEJCQRVnwfwPk3hIWeg8vGedo1ux0kTV8G4KsM+liHk/IY+DHAortFRL+tTqn5Z9cXzqHLLHHpRp7hRSWbHhUtN2GEBjxoh1mXPKbfoKxYYQstO6XR6z9XQbMixyTX+t69EBxkhMKrzA8D2ddgbiaL7yzK4ImsKPPWRpKUHZbZtse6z2pzKaxTSt7LNHyLB59V7j6Sh07K8HqU630PfG7Xq0un8QN9j2VrLJs6FxZnJ2oO9fPfhr07uag0a8UF3QEMi0aGuikg91iHQ13uP5BUtPshTDKWzSU/9IHHzD/OFy4EnwGkGARCJLTczG1XfMsde8Of375JEVMzeN319nPlegxPBvQ2fjnNwIdZt2tzfvY94HgFRepdYOoSViCPXdRa0ZCOmrAjVHsNMiGYjd5OaMkLgYktF26bmRoEOl8r1pGmbZDeHHtmrr7VqVuQyGabiXEwRetoT90212m1SeWkcg8KagqfSnSYQytGoaSlJwSIbSeQ+a7al1XLytNPyuTX5TY5wcpqtBcHC4P0DtwSVukISfR75h5x2wV+yvWC5pXJ2r2MGSxaJ4qWEPqSd0twPOnecGXrDocwMaDg7dMpKvtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8f95e0-2438-4d02-6f56-08dd5c481515
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:44:41.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xr44HwbEg40Egi7/VTD2JV9IFs2zpzkJyzpQ1aJvbjMtDUFwAGR1Lr9mCNaHCJ084HgVxYWJfCR9M95cflx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_09,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060001
X-Proofpoint-ORIG-GUID: Bi4z840chQNiT8Oyc_2Gd_2tQ6_C1CmG
X-Proofpoint-GUID: Bi4z840chQNiT8Oyc_2Gd_2tQ6_C1CmG


looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Thx

