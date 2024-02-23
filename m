Return-Path: <linux-btrfs+bounces-2679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFC861A02
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4582A2886B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9B13DB9C;
	Fri, 23 Feb 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jn8rnTGg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M1qHZlfc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5C12AAFA;
	Fri, 23 Feb 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709743; cv=fail; b=WRXD06R3oG2jjTkeUgnVSH29X6NajmKkBFxjGmdneAeFnU45EJCbvm1pzy93EyWMNaW6gpBQXWAEydMUWfjUMDPtiNUbemPThR+bCWwCOVQAVXFYSMFZfFAz0+O87V2GwEGZh3CbyZsfSM4AGmDgntumBeHVVGHRvLg5GEDcIY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709743; c=relaxed/simple;
	bh=U8VEmHKSHlvY6bQC9y7ErV2S5n5b7ofxMwwWSeMft+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fB7wtNKfmX3NQKiIzAQos9NxymdhR1XFA1hM1U+NiyFjhvhUWsUhfWPvInx7Jgq0Ei8mJsJKLbwuGxOhKUC8HdhCQXBvBYvu8N02MlFQybFxesWOfglKCx4xQ2GDSybnIA8h9kV6OAdhI7x9RZdiU04Rf9oKJxRi5BHjhBcnkXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jn8rnTGg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M1qHZlfc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG4YQ8010694;
	Fri, 23 Feb 2024 17:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jz2HBTWTLfvipJzQrFw0IdWPfpSaAgDvmVbN0/IskYA=;
 b=jn8rnTGgeecdXBYBeTh3EAPLEH2vGpIb6r7RntgrUibKYD9CPMFlwhk0C0Ju6GVUPmCO
 d8Xn2rXE+jFrXKoqlOCbBB9CA3YbNt/hCPnYiRN5P3asTTRHc6zx4FpcrA5hPZrzuMUj
 7Bt826OsBNjAyt0c1ong4KNNPnQTqE2CVrP7X2zbVlAtxoEdxaLgy0MLxbn5HNdSbqQq
 MDYUCK1/vwg9yezQQoRMs9KUbJifyRmOPTEgTUuGJc/mNZ0BDeCnzdk5w0pUpgu8Y1Fs
 1jYZSCy0/Dzyyp+J/Y39oV77Z7s1tzhkhOKFTXoYg2zEjIQ6e13g6EuAg9xGf+8IBHzJ pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqcgbre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:35:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NH5TbU020475;
	Fri, 23 Feb 2024 17:35:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8cf57e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVhz4lpxFXhZc+k2CKaJ1xcW0nAXTUHn5TDZzSo+hxnocvSTD99bU+gkO5Ct1yO7j4uRmXTDjfONlELVBC3IrSRsun/K1Nkv1awMUewLLrutr5SYSsBnTj7FnKodgdS6X+19lWeyzRVYgZ7/uELogxgwJYmQMNfh2L+WpUudDbPbfMQKU2+3kcI/AuyIfLSgTkaWeThm9JhaaG6FqUjl4+P2HF7WtjOwfTd3IFmawlkYdeubNwh73KgnJW5CJqXeaTh+BSVka/xvH6/9XUn8OSBPLqSaWDS+3WDCK59NtIeNaiGzmwplLbD9UYRtJAO1n5NCJz7qaJV6Sb97JLQrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz2HBTWTLfvipJzQrFw0IdWPfpSaAgDvmVbN0/IskYA=;
 b=CIUgtWE8dnha1Fha28EdCo1p97avo10wZb5VIoMf1tvdMb8btjNp57G49tqQYNyj+j5COWdtsIG7giMVo79MzBxnHUQLiQGb1+WWBhyD/wNwSzSPyo9LxBAmMUXmllnLspMWVvW9JnysO87PVfVdHmK01AFgddTxqmSfYhqxtAhRV1i3MyGfkIinXZJ6QHKd+ifHBT5QB2oaLp7DbmKNjD0hN4TCtZy8/HiYmsTcsLGFyLncQOp2dzuZXBrXTNWN+yN7yQAPW3Nxee/XV/RjJztgkbKOFRDFbQjuGkGUPnRR2wRSlWTei9DajkBEujOcniUneODfwwjD9czKeet3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz2HBTWTLfvipJzQrFw0IdWPfpSaAgDvmVbN0/IskYA=;
 b=M1qHZlfc5k9bMwxkxL/+bybAoA2vGN7lZON3QEBDJnMoHwXCLFS/ypgm6+n2L+kBJHdtQgqlkFcvJl8F0x98GT8oaAeHdpHD50nmeAfNuxJjbSMnoWmxmxALEEFM0GjL3N5EMthJSwboBOD1ndQcJs6gMkX0eNrjxrHqJFxeUuU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6392.namprd10.prod.outlook.com (2603:10b6:806:258::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 17:35:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 17:35:34 +0000
Message-ID: <6b0fb656-6241-4352-a339-37d00c5a47a1@oracle.com>
Date: Fri, 23 Feb 2024 23:05:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] btrfs: check if cloned device mounts with
 tempfsid
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1708362842.git.anand.jain@oracle.com>
 <a59c46c581dd2219c1aad6d7d82e1527e8a4d35d.1708362842.git.anand.jain@oracle.com>
 <CAL3q7H5ngKVpTHGMEF-WyyTtt+-4fQ=BeMvuCUuRc9FNtrzwXA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5ngKVpTHGMEF-WyyTtt+-4fQ=BeMvuCUuRc9FNtrzwXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f04bc9-1bb1-4546-cc3b-08dc3495d6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rXM3KXRO0iWxcI23t5pfQnPJLxaMPUf7VQgv+/r/hmEo2ZJiVpad4FPCDeTRyIP+04RNnQOuywa9XtsslHDsfayZzM7Z9VB4lu6M4PPeJtgFMmL9KKfI2xqUl+nie+5bX+ppjp4dvS3XelPwg/GUewEAnsgqdlV5LcUWw3DJxesBvmvcDAHE5D4X3QF1icInoQY+NdHVI/I1wZDt14HA0N9O1+tVqcnsISUfx54K/YYLLkSvK06brMXiSM6n8YB4PDP2ykPB+nXTpWk6+7qE0B1AqwqeZO6U8UhVRlVd0b30vf9WDl8/XBMLwbytdnb17TZV+qOdYRNknISDjtsa4QTvY2W3EyXocxS8TBL7PfvnAMHrQT8DSRjYEQD+U/kp0oun0c5iOGRigl6j2/Ml9TOEwpvzOtjzgGuthqC/yZpVvLPRebOMeznsbY/UtDhk4BhkwQdKn/cjZ3xAfT8yGupHIwD0t4QtiS/3S9VvLOFRpcmCXPk9UuOzkxu1lsdlMeO4VnsWr3hbGSZdVNIBJQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2tZWVZEaklxQXZieGJDWUV6cm5qUGl5QUZNb0ZPcEFTWDdmcDg0eG5MZlYw?=
 =?utf-8?B?Wlp3THZKa2x3UHM3YVIyR2NNRWNKVS9wRVdhcGozeXZ5Z1g3bGJ0N1lnZUhZ?=
 =?utf-8?B?U3ljTFNINVZNL2xZN0paTkMvaE1VcnBtcHdub3ljdVVYQUJBVUtrOXlncjlt?=
 =?utf-8?B?S2ROR3c3WUl1N3lXb1drYVAzQVplblE0elFCMWdNL0VDZHFwaE53YS9aNWVR?=
 =?utf-8?B?K2ErUXVyeEpyRTRsU1NBZ2ZoUmtBRXBqK2tRVXNydURRNUdZeE5jVG5YSnVR?=
 =?utf-8?B?Q0pDSGE2SEx3bzBiU21ra29uQzZYVHEvRkNYemtwMmRhaW9IMWV1eXZYclRZ?=
 =?utf-8?B?VnI0SldvZnQybW5SWm1qQy9vTlJuVTdMWEVaRmZkWEhzeGhlcE1EcHNhK0VZ?=
 =?utf-8?B?OXlCamxKQjkySmlvcWFDbDZhQ1RYdUdJWFF1TjJhSHltSWs2end3S0lqM1ZL?=
 =?utf-8?B?aEZrKzAycDd1Sk91SHZqaFdEdzVIMVF1WjRjQU5McEVQblFFTGo5ZS9PQlU4?=
 =?utf-8?B?K1BaNElVK1JCS05Lb1pSbWVJaHJIM0FMZko1Rmp6dmtwenFiLzdyUWlIK2Yz?=
 =?utf-8?B?MnM2UFpnaHFYVUxJNlAyaHhscFlTMkRjZGFDVUtZdFlibEJwK0NZSHM2bWtK?=
 =?utf-8?B?V2dyWGhqTWVlRDcvM2NuM1czaG9rekIySU5lOStiSGxZVHhGOG1CRVBwWE8r?=
 =?utf-8?B?Z0svL25aZDducU56eU1aVFNGeEFYZ1g2MzVSQXJabjk3V1ZXaGdMN1FZenJQ?=
 =?utf-8?B?SGhKaHpmODFEcjgyVmV2ZW5pSTNRSlVScCsrUGd1ODFheEdhTWF0dWlJT1VI?=
 =?utf-8?B?SWpGTytmQlQwd3YranplcnRFKzM4T05UMDBuYW1zT2Y5TlR6L21jaVQrd1Zm?=
 =?utf-8?B?SDFDSGQ0VzhRczI1U25IZkxQa1JzLzdLZHNibnFRcmNncVBNWHFCV0lSZTc3?=
 =?utf-8?B?YXNUZzQ1NkJ4TzhpajU5a2xIS1JaWmJpRkpSVUlLV0cyWjJZb2Zlb0kwQVNX?=
 =?utf-8?B?Q28yeWhUdWRBbm42NjgwMGJnUGt3a3RGdWw4Tzl4bzR6RFVVZmhmRCtJMFhI?=
 =?utf-8?B?SFc4bkN5bTFxZXVSNjEwbmJvRkFWWEVmOGF3NWR0WHBBY28zNlQ3aU9HT1I4?=
 =?utf-8?B?T1FyQmw5aGRlZ1V2b1Rvd0lZdnpSeTZuVlhVaXRLS0ZSV0dONS9TQVJLVXI1?=
 =?utf-8?B?NEZwTEFSMkhobUVNdTd0ZmVPMGFSMHNuZlBHU2ZJTXhkd2RTaURMTVVsUENs?=
 =?utf-8?B?anJtT2prRUNsOXdxMFBRY2JGdEZSY3Zzd2pLYUJIV3h2MTZEdWxVeGsxY2t4?=
 =?utf-8?B?TWUvN3JFR3BaeHYrNlltMDVZbFR2b3ZqdTJXaCtrbkNOZllZckd3aHA4UGtm?=
 =?utf-8?B?SndaY3REZjROUFRZak1TbTlrdUxhSFZZRFl6cVU2U2EyT0JIRHhCZTA3bUE4?=
 =?utf-8?B?TU1qTUdFU0NsS1RXVHMyaWRPbzNiTmE5OUl5cEFablRPeEFTU0I2WDZ0M3NM?=
 =?utf-8?B?aXZZeWEwNUtCbzB4cVZ6M2ZJT3NXTGhDYjhrRWlzYXNWVHRKNlppd0tXelNH?=
 =?utf-8?B?dGZiU2Rid1FKczd1TW1HcnhZK1N6NEZJRlVBSzhMZllyM0VvYjhRWFord0VL?=
 =?utf-8?B?RG1lOC9jUGJCbTFUL0xPNmI0MkhNVWlZUlJudkZlSzYzRk9iYVlkZU5na0Ez?=
 =?utf-8?B?VWR1ZWg2YzRtQzlWN2E3SWh5cHNLcFJOQjJTeXVkUWRhaklJT1EweGxNSlZj?=
 =?utf-8?B?blFJaE9WOHQzdnpCTTdFOVg1L0JRZmxGMTNheDdqSXVpcTl3cDBYSTlxWGdI?=
 =?utf-8?B?Z283Z0RMT04wbmZFeU1aZTdXb0VoeVhGbjNLRlFwMDA2TWhIWU1xdzBnWkhC?=
 =?utf-8?B?RkNwKzl5STNDbWdWNVNuUjJ0aWVCRE5QQkkrVEthdGVqUFlrSHFKOUhaVUE0?=
 =?utf-8?B?VU4vQllNc0VXR1NpNWpIQ0p1VFJKQmxNMWJNMHVJUy9LSElvSXhRRmVpeU0y?=
 =?utf-8?B?ZTBDVkVqKzlmQVpTZXNMVjdSZldHNmliLzFaVUhmMmxVVCtnY1pXZTVmNFhD?=
 =?utf-8?B?a1gxVk1vVDh2RTRDODU0MXh0Y2VMZDhqMkdFWlBKQ0hUc3ZoMkRxRkJpbG8v?=
 =?utf-8?Q?uPTr8Ep3J/HH9xNfVHMl5gHUM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EBAzjPjnzDemwXDNBvHchzeGbRnqb6NautmsO08h+olhaB9cLc365l4g/Bh+NSjH98gwJ/mWNg97b2MYl69opo+qSUNepBfyFw9q7Bq+ONLtoErYnEfsRLhU2NyL67LqUv+7QMPgL0iFKXfpXSe0uUukT6GPigogxb60sqk9jglkr24uc94B+JCvXPJQUf49bRFj5HqKFuYP3HJv5ZKiLuWhnWUR46C+QlmpeoO7VaGpGhMt4eMCu54+RNCeDhsdVNAcbAaUhGNZoGy4s9R3U0FpvbFCMrBPd2MGFF9rnSe3Mqhsxg/Hz5LdczzQCD/HzVoxw/7frunYjoxZaLekaaCBVgo6Sn5Cb5hcDeVNmu07Z/fBtmWl0pTMdp/YPKpnidwyDbjIWUycKJSix4HNEFS3OKcVMnL0kzPJDQoQ2CHX1t76zibRMWdXE3vtV0RqJAnz41vq1Hk2PKPTFrhVsGU2ROoSpkMuEWm9nxsYhBDfdqGU4rSPtg/uxBgPCJtuvk5O3ea3oYd4s7lQ2TVs9rUcD9E6yg1LdjUDH9xp9W3SCDnJG4aTMHd3jOqAafwtMEfQyekuzehogg3URK3VWHsUzdHYOl9U/JvtxH8F7Lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f04bc9-1bb1-4546-cc3b-08dc3495d6b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 17:35:33.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGF40ceYxmY0yJyrm2Fv2/TRrW9HfUhETqJDAqCKsg/MjGfCOv9WVTiiW6OruCIFUurDfLKt3Jo5OxqenwDtKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230129
X-Proofpoint-GUID: vcrV6U6ADK5EhQEu39KUVYwhtv7pm8De
X-Proofpoint-ORIG-GUID: vcrV6U6ADK5EhQEu39KUVYwhtv7pm8De

>> +_begin_fstest auto quick tempfsid
> 
> This exercises reflinks, so it should have the 'clone' group as well.

  Ok. I've added to the clone group now.

> 
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       umount $mnt1 > /dev/null 2>&1
> 
> Same as mentioned before, use $UMOUNT_PROG

  Thx. Fixed it.


> 
>> +       rm -r -f $tmp.*
>> +       rm -r -f $mnt1
>> +}
>> +
>> +. ./common/filter.btrfs
>> +. ./common/reflink
>> +
>> +_supported_fs btrfs
>> +_require_btrfs_sysfs_fsid
>> +_require_btrfs_fs_feature temp_fsid
>> +_require_btrfs_command inspect-internal dump-super
> 
> Instead of requiring here the inspect-internal command, it should be
> inside check_fsid()
> 
> That's the pattern we usually do, common functions have the _require_*
> calls, avoiding the caller test to have to know each dependency and
> copy-paste it.
> 

  Sure, I'll moved the prerequisite check to the function check_fsid().

Thx Anand

> Other than that, it looks fine.
> Thanks.


