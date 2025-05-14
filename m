Return-Path: <linux-btrfs+bounces-13985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F8AB6059
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FDB3BE8B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68D145A05;
	Wed, 14 May 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zn5OJ4Df";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CRB1WO2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CE1805B
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747185066; cv=fail; b=hT9hrn8R58tpNpuyQNsNS1xEX2wZ/gGGXd0xnLXRm3oPbCEWLVfZk+ZSHW7T5frwc+EtCP5+0rNiDeWR9RUZq90rX9Yvv4SomOKZrcgKZWK3IQ9KvsY/iqsyn9D1kCnJpVUvtGJTjxEYRXW23IZc/kRNrsHN2QlzNG0LJl71Ppk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747185066; c=relaxed/simple;
	bh=EgJ3UHzURmi207UczOtJaSwNUWbPDAPZhs+f0h3sktQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F/88hsV7IpRAcZXHXOnmoymRo+oIVeyyFcMRK5G9oRk9jK2sdBeGLAY4X3DamBUJmjdqassMGXRX0gk7zh5IsUYZBeqCbbh9CiO0Jo3tqJ1kezD5KVhz/+XvwEknlYCenDA7S4DuuhN5h8/P2oCYWlixAB0t2y6g5CAKmB8/xCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zn5OJ4Df; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CRB1WO2S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0frd5026831;
	Wed, 14 May 2025 01:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/n92G5ky1n0dYtyRzgHwsleAeHcSQ21CfftG9zjj4LU=; b=
	Zn5OJ4DfiP3vSwcDL1wisYduOf9CB8vddz9Z/BduilyqZzCaRL04BKzA6lsagDLb
	fSTo1QctxIKdAEz42c9BbI1A4oIY6rnYdoJy62D+wqbNJvpISWKJzey90MRlt42P
	1FsDv+la/U79Fcch4Nxe9d5L+8dixZaB0DlajVHHfqZ28PZMsh6zRkUzMaacblJ0
	4weoPhYeUIBdDiNoqMe2NGeCHG8nNH+LJ6biYWwT7jMymIW0L/mMmxukGi3Fd8Oq
	5dcJZn2BodambTjp2kZBrsLAZ61PPsKdL5nSyVp3nVGcou3+d3CP4sIypyJ57Bsv
	2CWO894V+UhGoSO81QWZlw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccrjxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 01:11:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNlADH016844;
	Wed, 14 May 2025 01:10:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc32t781-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 01:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG7ddrsIv/BA7lAIAiLKscr/8hhvTj2tlB4R5bcOV1GZSkTL5Jsl7Ng/pRU8JNXRVxivqPx2vy7mtmC0kNaz3kYsjGaIW6t30b6yAZ2NdKg4p88WOPeHfQho8wlan5Et/+D34frnj7KpAzRaBPzy8D9nhQLneE+yiea71C6nynXsDaB3ZTfaMkCtta9yMcTHIGjEDinNodBYM07Le7f2Lg3lh7LvcqQ1RtaTaRRKAfTlV4vmIP9VTlCiw+Na1UgMXimA6/8kh7JK5AI6Hx4uepd0/WVdPbAkkzWfsHdKhdSwgcUUwyrpyKLMg330jJKBJVJyvvKEhBX1k+X5oC0VAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n92G5ky1n0dYtyRzgHwsleAeHcSQ21CfftG9zjj4LU=;
 b=nIlT8OBuuotsuBJwbKsWPuuhPJmfpKKHWyCZjBcb76RQsj6+Z5Rk3K/0b1bOJToTyGzpRInmH/KktIUMbMmFA1FxninyyKgq6qA/KFHpe2s+TTmP4GWhwQoL0mzfz09/Y9KUE+aCUsSkOc4vHKtCO+FlX9aXUuxz37e7ZJ++eQ12itwx722VuoJFsU4QlAnJ/BuNC+ECCXywWEx4vwFRvnuCHGX2XcxjnruNKYc2D37dViSFgB5zGzCNwr14mB5gKgDd1N2BmJZB80bwMrRI4eIj7HJv1wOe8hTPleSfBPKUTErIiYwg7dRpCmDsce0nxctWQpcIS+o9J9Z0fMcvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n92G5ky1n0dYtyRzgHwsleAeHcSQ21CfftG9zjj4LU=;
 b=CRB1WO2SiNX4oZqeqCvXZoAzZHXoIqqGep+CoDU9qdN72HvFQDDMItNdhmYSINBbuLRTnZT1wqYyRlrRj+cfoCmNnEUA7Kh+TfjFUFRth2s/V0nVNINcE8Iic0JIP8gFjsrigXsUc+ea+052Pb7EzyBI1b9axSDlNqmtZkuonvQ=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH0PR10MB7006.namprd10.prod.outlook.com (2603:10b6:510:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 14 May
 2025 01:10:56 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:10:56 +0000
Message-ID: <4ff10de0-062b-45df-9312-c5d23a9a2ac7@oracle.com>
Date: Wed, 14 May 2025 09:10:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid NULL pointer dereference if no valid extent
 tree
From: Anand Jain <anand.jain@oracle.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
References: <80137af65712e7c2a8ac301b7b9a3901e8bdb44d.1735792000.git.wqu@suse.com>
 <48406910-f69f-4b8e-9327-8e291d9c502f@oracle.com>
Content-Language: en-US
In-Reply-To: <48406910-f69f-4b8e-9327-8e291d9c502f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH0PR10MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c078c8-c59a-4b6d-6796-08dd92842e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRpeFFXT0VVU0ZnOStxS3ZDYlBqSENpWk9aT1h0ck9CZUpzSkxRMjRwYVcr?=
 =?utf-8?B?bjBZallSenk4ZXV4T2xPV1JWZlpWMk1LYzJJNkFTejdlV1dPTjNmM0pmaFg1?=
 =?utf-8?B?V2NuWlRLRENKclVlMHowRGFpY2VNYlFoMi8yMFdvSXRzbXZkZzhDOWhaSWdv?=
 =?utf-8?B?a2RqaWNaY2hkeGVUK3hqWU5PSFpvZWV6QUxyTzNhVXRsclc3Wmo5RlJTT0t2?=
 =?utf-8?B?OW5NZUROcHo5RnVTU0J0YWFMNFF2S0Rka1hCbm9QOEZPTzdxak1taDVqQVc3?=
 =?utf-8?B?cExZZEJaMm1NNjZodE44QmJqMllVdGV0RTFxamNjSEhocG1lNkFWd2wrRS9z?=
 =?utf-8?B?c3picXJPTVpKNnhuYThkTFc5d2k2b08yOEJIbzA5Z1Z1Z1VQOGdtQlE1V2Zp?=
 =?utf-8?B?MDhtOEFoUHdSWXFmWFVRclZrRGlZc2E4Q1lnV0c0cXhxdlJINjE1SW9IdXc1?=
 =?utf-8?B?ZGFZNTV4WmRDNUI3MVpnMXY4S05DUEVoREdzc0VPbFpwZktsVWoySmY0RmVD?=
 =?utf-8?B?aUNUVzdDRE9ESnZ5WFVLOFdyUDMrbW1McWh2Ty9LTFliZGw4V25lWGRJRVE4?=
 =?utf-8?B?TGE5ZkkyYUNRdldMM1BKMWg4Y1BkTnJ1enZoQ2ZFajVIZzF6dFZFVzR6bjlt?=
 =?utf-8?B?bHptSjltVWs1UFVKZCtHVXBTMGlIN2YrUFhQZmdrS3ZlNEZHbmtpdVNQTVdO?=
 =?utf-8?B?WklZYU1iNnBBdFRYdUpnbXl5SzFLWlYvcnRPbjZ3c00wZGNFanVFV2FkZFJS?=
 =?utf-8?B?cU1PVHF3MDlMRHdLbjJBcHFaZGkyaDl4Tm5zUW1lRkZ2RDNRNUdHaGc3Wkp3?=
 =?utf-8?B?R25veHV6R0hZNFBtWGh0S05SVzk5TVpDVklxMDZ4TW8xbE1qQmNyT1pHdWFS?=
 =?utf-8?B?U29vakx5SDVZR25lMDkwOVpvQWkvTHNpZVZGbHpyMzBvWnZiakdKUTZsaGVq?=
 =?utf-8?B?RTdBOFFaeUJ4czhkWVh2QVVvUnQrMXV6YTc1SmtlcTlqTWpHY0ErU2ZXaWJU?=
 =?utf-8?B?ck1FUkdZSUxNN240TEFRZlZ1bmxCSHF1TGZVdXFKS0REb2RDVTI3WjRJdHh1?=
 =?utf-8?B?K3FRVWcvOHFWU1JZNDhqNUgrNHFPYjB2NVVxZGlieVRzUjhTTkVzaG1TZHVS?=
 =?utf-8?B?bnF0MkJKZkZoODA2S0pBWE9KNVAwVWMyd056QWhqM1l6Z2xVUEdMaXZ3R2tF?=
 =?utf-8?B?RXYvMlVLZ0pjdGY2NDA0Q29YRlIwN096VnNQK1VmOUVuRkZheklGMjFGVFlt?=
 =?utf-8?B?VHE3aFVLNUpvdjYzRVl3TyttZnJMVkRqb0RqRk81SXJvWmlMM3l3cjNYeFdj?=
 =?utf-8?B?dnppRDhLc0diYXN0bXFTOFh0TnlMOG9GelRvWGJ6UEpZUHc3NDRLbC9ZM1pt?=
 =?utf-8?B?a09TTFVpV0dzRjRmV3BsUVdiWGYrNUFjcENpK0RENU0rL2Z6UUszOG1xU0dp?=
 =?utf-8?B?b3RkRDYzWWVZL2tWV1JwdmRnS2NwVWhLZ0FLKzZlWDJSNERxUGp6QzE5UVVN?=
 =?utf-8?B?MUcvakxOajQwVCtYM3ArSm1vbkRDZjJqSWZjL0Y2WXNjaVZvWEo2VVlsUW02?=
 =?utf-8?B?emtQbUdlb0NOcVRydGMwUHl2Mnc0ZWZwNVRiVnVkNXRyUmdHWWtQWWh0UENq?=
 =?utf-8?B?aHl5NzZ6Zi9hTThUSmg1MFRLdVZxWFJFNE5GeFo2UTVzSDFOd1UwYklaeFh1?=
 =?utf-8?B?VWRQb2loNGhXazNlS2FrSGhObkpQRFVxb1ViU2ZOSGRsOC9rREMvckU2ckhK?=
 =?utf-8?B?eTJ6bFF4RFF3VTlrejM0SlVKbEt5N3NESVB4UkZQQzdTcWkxUXg0OG1OY0ts?=
 =?utf-8?B?SDhONG4xVjBzeGc1YVRjVWQ0dlRpdFFtQ3lFNVFvUmtlbWoyZnpzWmVhcmVh?=
 =?utf-8?B?bHBseG1xUllRTkdocHQ0REZDcTJJaHMxZzUyQk5scWJDb3pzODA3Tmh1Q3or?=
 =?utf-8?Q?K8E0FLidR+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdWdEMrcjJxM0xxaGFiNVlwV2VlMGFMcWRpNzE4ZVZ1bXBXQ04xN1k2RDV5?=
 =?utf-8?B?bUNRYmJEUDNSREMvVXRNRFpBS0VPWDY4aWlXbDBubzZpM3RHOUR5TTNkM1o2?=
 =?utf-8?B?Y2puaHFyMTlNZzVyZ2piZUU3UTFXdzJORk1WYThwSk1YRklCYWxSZ2toRWw3?=
 =?utf-8?B?cUR2Q0VQMGVTd0ZKd1cyWUl3cDgyVTArOFBJKy9EYWRkUnd4VXRiMk1OMERW?=
 =?utf-8?B?bjhlVU5OMUNZTWwzY3VOVmZQYm96UnkxelBYak9CYWRtWmRkVGZtd053dkxV?=
 =?utf-8?B?MVc4a0FzR29JZEc2V1JoZlhzOFRrWnFtUndKclg1TVB6YnJqR3ZyRm1ibWdq?=
 =?utf-8?B?OUR6d0pHOUM1QWZtTWVwaEJWUFRDVEtZUTBYL053ZnpzNzNXZXo5UHkwOGs3?=
 =?utf-8?B?L3dOcTZOSEpaSGlvWG02MUdJeHJ4NllCRGVBd3ZWdWlPSytKVHZjYUg2YzVt?=
 =?utf-8?B?cW83eml6RmdLb0NPQUZvT2FuaDlBOHRvM0dTc0VTeWFOZE82aytLeE5DNnIx?=
 =?utf-8?B?OXV0R3BHeHJXb216b29NRE00dC9iZmZCS2ZobEY0MzFiU3VORWQ3MURmUmVo?=
 =?utf-8?B?bHVoK3ZIM3BnN2R3SDMrRGlxRlhGMlM1cEpibmthbjhEOXduem9uMCtmU2Zh?=
 =?utf-8?B?KzF5RXJLd2hsWW9tODMzemdJWDkvTGFvR3FRbm1LQ29KMVJDSUYvL0ZMbmQ3?=
 =?utf-8?B?Z2RsZGxUbDdBajlCUWRoM0VOdGhnNTlEeVArK0xqcWZNNXZ2anZhZW5LTU5H?=
 =?utf-8?B?YldFMVFhUlREVEZiY25iQWU1NkJsSkZqdmlNQWowMlZLOVlXYS8zOUkza3VK?=
 =?utf-8?B?L1JQQkwvdE93OVRubmc3TzUydzA4L0lPRndvK2lDcmUxMjBYZkVCcGxwYlZI?=
 =?utf-8?B?enBERmM1aWU3M1BodmxFbkNwT1cram50akx4c0M3OU8wQTZMRWppRTE1QTR4?=
 =?utf-8?B?RUpXTmNseGJ4cUZFRm1ocEdCTmpCOURpOVYxVE5JbHZyNGtWNU9OMXF6TEli?=
 =?utf-8?B?cEpGT0FoTUkwMDlwYzhNVHFPdHUyUVlFWkdaakp0OGQ3cURsMmtrVlpTSUJ0?=
 =?utf-8?B?aFNCR1lUR0x3TDNic3RKcDI4VzExUTQyTWg1TEFwVGtVeDh4ZlJTZm5xaDRo?=
 =?utf-8?B?b2E5NEtQVWZKbmQvZGh0NURpYkVqNHBBdmpMdlpLdTQyVlFCMmEwa3Fkem9Q?=
 =?utf-8?B?QVNvVTcvWmh0K3FaTnJKVVYveUZncE1QREpyQWRPU1hsSmJ3ZVQvVHVicDZO?=
 =?utf-8?B?YTU4b09hV0ZRRmRqWE16WkNISFJxZHlJWk9OazRNQnRiRnhnM1NCekY0WEh0?=
 =?utf-8?B?aHdhdWNqdWp4TStxZXYvWW9Ec3FzdHg0MUhjT2habGVzMHc2SG1FK2dTOHZ3?=
 =?utf-8?B?RTVsUW5QbVl0NWMzZjR1dVVoN2tCSTlRTTJJaG5Cc0c5Y25lVjRxYzdjcU1S?=
 =?utf-8?B?cmQydnJwYjkvaUJBem1QbDk1Nzl3dXlINlJnVDJIRTc2Q2hlMFBxNWt6UkJm?=
 =?utf-8?B?NFdYdks1ZEZMZGV5L25JVGpxcDgwRlZSSjFjS011VzNKWm9OT3YrNCtuT2Fk?=
 =?utf-8?B?Ni9xdjFXOHlUTVRXU251eFFza0lldVdvRU85MnZxMzZSM3VFUG5Eb2FENXVF?=
 =?utf-8?B?eHFtem1KT29QMnZ5U0hDOExvSlhnVGJxTUpkNlpWMnNsWW1SckpxMms5ZHZx?=
 =?utf-8?B?WlZMRTlTQU56WkxHaGYwdXJydXdtWnBIcG9qdlhYSlhod1lrK3lNVDl6ZFBD?=
 =?utf-8?B?QUs3NEdyNXFYTGRHN1dyREhRT0RZakFncTNOcVhCaGlQYy92Rm1lT1l1dTAy?=
 =?utf-8?B?UUVsRm9TSFM3Z3pmbjhKTWN6OXlBSG54MEhUUHdtbWJNTTVJUG9sNVIxNHFj?=
 =?utf-8?B?UjRtRUloUWw1VmFGK2VGc1B6ekt4U25PcGpXL0xRYk5lVHprUy9zT2lndzRj?=
 =?utf-8?B?YitwWXlPb2NjUFB0NGdlaGxOcmNQSmJjRHh3ckxWUmZodVB2c2Q4NzJ0ZFh0?=
 =?utf-8?B?UFNuajBkMU5NNm1Tc05KZlZOUHRoRDN5VWIvZFlyS2laN1hMaUpCSmlpRVhN?=
 =?utf-8?B?TGNabThhNVZmNmwrNEhEaktWUXdGemc1eE81R1VraXNZb0dVS1JaME91ajQ1?=
 =?utf-8?Q?5Xw0cAxAJZK7biEL91nWkB9G2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tQS9lgBaCBx1kcDST5+IEZ5BZhmia3xXmFyfTCNkmsUZIYKQoQrmnsUtyctPb83m+Gv72kzMOhEBU19E5z9FFFvAl4SzzNy1ed4pg32eLJR9aw/P4sq3FP7E+sLEwNexnyLvA5/dq+dW93z4ZAn5gboqX8VGp8Q4DL+NlxhGlNOQ2vWTOU/iAphWo4DzroHOAuc2LgoAjJmIn8zkVG/kcVhq6/KOOe+laJ2jhck8nw8k7QQHD9lgPHpdtEFKobeH68Tf+R4nYnOYZmW1mWGfvjkjs0Qep2LN+RFwizfct7FADcjk5yQmjMGW1FA1Ds9C2FwXeX93Ge8SsTNOXp/5uhWIUnHvhe3VBhsAnzmN4cMJR+yOnBUf+E7o8O+YTEQvYQIv1mNSUnIuxJAaNL0IhlXT+2qayREYW0WG9bCZ3hljybGAy6Tc9mqj1EnRnYtlOumyDLMIPoSkGHUIwDvoRzvR/FAtjUq0HgD53BmIj8czOVw+FW/JQ345kYELfe+kF6G4QGG9KYUTxf9zEMyeL63f38JJCa+Jd22FYK/4vtQLN4bOzskZv2qXPhnQn7UBRpkwGJkpgbChkd9q6a/DIgs5D8nWGcw45WeOdpv6GJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c078c8-c59a-4b6d-6796-08dd92842e00
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 01:10:56.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQig0NLIczjoZARLWOOY7xawuwYsF/gwwbp+aGvq/S4BDLM1Oa1zBXfTwQev0q+35eB582VXnZvmS5QU1+wAIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAwOCBTYWx0ZWRfX426C9eJY54Ny hMk6FXbub+VKZZyKvnkLE07iTJqwdm80OrWV7kkYhv6MhiEscMhSXLy+UBILx8D+XxyBBLbKbU9 jU4hTuqjF6DiTaRaOJlRHeaDYiDy2AirNDQjrD+XkyzBR/qo3tCPhq0x72AuxL+7Yh9Rgug2QFO
 46/VM7yYoxRvqHshoWfCE97vstRKIQy+VLMpeLnmPyYuo0thbSPV31JAOUE1PN0wiOiVKw/QGRu AnEcHeGw1ldZFY4HrKaqkglosQBeWLGilz9sOOxceCzR2qy0APVBufUMiAjEm75OgUqYxEloYOp 3KxMnulMl3ttWXzn1cEB3RrzrbIIMCaFJvWWjBvScJLruRdc4C2uMMdym1sPJyr41VV221UxRqg
 KhbLP3Ep/yUsReIBZ+41V8b/EDdE3ho7KRlI3j6Q/SzJJ2X+RtVrKXwe0PPtpkVpa1ax5FYW
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6823eda4 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=QftY1nFDi-HUHgqdl78A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:13186
X-Proofpoint-GUID: XYGSdrOp8O25s6nW2A4YHQeCHUyCzt2x
X-Proofpoint-ORIG-GUID: XYGSdrOp8O25s6nW2A4YHQeCHUyCzt2x

On 2/1/25 13:46, Anand Jain wrote:
> On 2/1/25 09:57, Qu Wenruo wrote:
>> [BUG]
>> Syzbot reported a crash with the following call trace:
>>
>>   BTRFS info (device loop0): scrub: started on devid 1
>>   BUG: kernel NULL pointer dereference, address: 0000000000000208
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 106e70067 P4D 106e70067 PUD 107143067 PMD 0
>>   Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 1 UID: 0 PID: 689 Comm: repro Kdump: loaded Tainted: 
>> G           O       6.13.0-rc4-custom+ #206
>>   Tainted: [O]=OOT_MODULE
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 
>> 02/02/2022
>>   RIP: 0010:find_first_extent_item+0x26/0x1f0 [btrfs]
>>   Call Trace:
>>    <TASK>
>>    scrub_find_fill_first_stripe+0x13d/0x3b0 [btrfs]
>>    scrub_simple_mirror+0x175/0x260 [btrfs]
>>    scrub_stripe+0x5d4/0x6c0 [btrfs]
>>    scrub_chunk+0xbb/0x170 [btrfs]
>>    scrub_enumerate_chunks+0x2f4/0x5f0 [btrfs]
>>    btrfs_scrub_dev+0x240/0x600 [btrfs]
>>    btrfs_ioctl+0x1dc8/0x2fa0 [btrfs]
>>    ? do_sys_openat2+0xa5/0xf0
>>    __x64_sys_ioctl+0x97/0xc0
>>    do_syscall_64+0x4f/0x120
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    </TASK>
>>
>> [CAUSE]
>> The reproducer is using a corrupted image where extent tree root is
>> corrupted, thus forcing to use "rescue=all,ro" mount option to mount the
>> image.
>>
>> Then it triggered a scrub, but since scrub relies on extent tree to find
>> where the data/metadata extents are, scrub_find_fill_first_stripe()
>> relies on an non-empty extent root.
>>
>> But unfortunately scrub_find_fill_first_stripe() doesn't really expect
>> an NULL pointer for extent root, it use extent_root to grab fs_info and
>> triggered a NULL pointer dereference.
>>
>> [FIX]
>> Add an extra check for a valid extent root at the beginning of
>> scrub_find_fill_first_stripe().
>>
>> The new error path is introduced by 42437a6386ff ("btrfs: introduce
>> mount option rescue=ignorebadroots"), but that's pretty old, and later
>> commit b979547513ff ("btrfs: scrub: introduce helper to find and fill
>> sector info for a scrub_stripe") changed how we do scrub.
>>
>> So for kernels older than 6.6, the fix will need manual backport.
>>
>> Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/linux- 
>> btrfs/67756935.050a0220.25abdd.0a12.GAE@google.com/
>> Fixes: 42437a6386ff ("btrfs: introduce mount option 
>> rescue=ignorebadroots")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> Thx, Anand
> 


Ignore. This is replaced by

    f95d186255b3 btrfs: avoid NULL pointer dereference if no valid csum tree


Thx, Anand

