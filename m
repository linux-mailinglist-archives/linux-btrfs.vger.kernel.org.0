Return-Path: <linux-btrfs+bounces-11713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D0A407DA
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 12:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F87B3A4688
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E784207A2A;
	Sat, 22 Feb 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BRUxQBhD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rzg8oZ5T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9F13BC0E;
	Sat, 22 Feb 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740223025; cv=fail; b=uhNTWgvEOd/w3WgAdCGbDXPe1X1+fWRcRe+nu55odIgj4TEAUTb9Myd83EQTvz7mTKEtUOFBkstgI9lDqKaN5b0Teq0+yCK2Qt9KG7d6V7CTVE38wpRPCzXb74T0fj4Giflc/9GdXV0r94rpwNdN912XPSNjBIX7yDEcoKHkiCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740223025; c=relaxed/simple;
	bh=V8Cs8qu2/SJFrqZDxU64GkUtxUr1E1Hc0qBeaHuIo6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuyTwAnQoF6WUwkRFjq8Q/wemhsQW0T+snKwYNTnXJhiZsTgJFCK0nJEcG09cKP7z/yysT2NHUVwWsAy1nfhSKDUfJgySDrFtLZR8JPBZgJBtcnwITBBce6zx4979pczJBhkSp0RYSVVmZNWdm6VIfQz1dpRFoAEMdsfCPkyN88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BRUxQBhD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rzg8oZ5T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M4fZvr007195;
	Sat, 22 Feb 2025 11:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k1GZ2S5fA/xJ3TXJj5GZ/RxYopvVwrCjy2fZA3OSFYs=; b=
	BRUxQBhDMQ7wqm2eS8u6r79do8fOZ28by+NvSXT8b5w08D7TY5FlWIUZ80EiIA4Q
	IvcQlwc1kR+greMWLqiCnDHN9NIE5P/hfbYQtjBhWp34vIpy5qDGqlx/JGocJ1Vc
	XeiE+Ra7CF9WuPXl2XON098c5HSlZl4cB3JghDv8s09NNYLewn7vsZAZ+9lRLFov
	/6jHdgJZCvzafAOfp3MNZKoLONnN9TMawGLUbzWMq5sEO4Ol+qUKSEQU4Bv/JHRa
	o2GxT4cl8vK/gfLkdx2mTG5YP+NnO2o3S9k3atg+wwD34Br8PPnTNB2lA3RNonPd
	ON1Nuqo//qJGGuitWu/8Sw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t07ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 11:16:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51MAsFur024318;
	Sat, 22 Feb 2025 11:16:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y5161c6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 11:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5Ch5Etyniai7RcmeTSyo8TshNTKoCMVu4NNuD0sir6AyawL1HRIWPPfUb169PdKA9vo/ahP+LxR/ClskAKV6DG6VuThOo/CcWlXAK6DF9HcHYe8FdsMQo1ZQmyctreW2gdNervQC64ZZHOR0oRkddZtKbD52xdmK87889HCWwg6jetsSuZeNWsO9qM/N2ns3/A/TRUB8QLZHjFLqetbJI43anvvaZu5qTBP/bL8ke263HYKWBjRL+twAcipIXGNstRvIg5fN5RsYqMhDO3mJTqtMw5Q+SScJyE7KyJm4VXTqK/hAjV8LeFEjrzmTtvuMh9vs4vqfKnLLC82BVjZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1GZ2S5fA/xJ3TXJj5GZ/RxYopvVwrCjy2fZA3OSFYs=;
 b=HBeA+H34n7USKey2+XZOuakjjhmwIH/+0p2IpDFEL0Njwy2XYprqj/4yoPTZj3O5zzXK4R+fxIPrX71A/10BIPsSGcFso/zgMdt2mxN6Mv7LuuGwfKXoVSY8td2GRuerMkQvgPQy1+RWvKmoqXAY2+LSBg7pwgcnFqy80uYdk3AR5Kcht3l735j+3tbANE1CdGSPz8+dpGUi4g3ISD0GCL6BrGTpqFps5TGoFE7OTESRmVw+OdqsyJSoPDB2akJ2NgN54jsEl7N5zjxvLRtBIq1vQ4pciCZK9chYX/cm5aB0eWGwlTKqAfCWOAuCmptk+uuLoiWWBhrUpS4QDEuiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1GZ2S5fA/xJ3TXJj5GZ/RxYopvVwrCjy2fZA3OSFYs=;
 b=Rzg8oZ5TM2LPRWDDNAXGPY5N+b6TLTWb/TUsrgWQUM/l43Fmv4f7rLlR0ikXt0HT4mN/ijVtwdtRHzlyFmqwAk+ATKljbDN3EGO1h7nczZtVh9W/4VfRbM2ivg8LuEq3V3PBFdHKlHmZsfO3NoP/zGebYjapF3ogj7BlUFKhXs0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB7001.namprd10.prod.outlook.com (2603:10b6:806:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 11:16:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 11:16:50 +0000
Message-ID: <4e013629-c1ff-4e84-99f0-6916058ca6ab@oracle.com>
Date: Sat, 22 Feb 2025 19:16:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
To: Filipe Manana <fdmanana@kernel.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Zorro Lang <zlang@redhat.com>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
 <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
 <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a22c30-5001-4851-ae9c-08dd53326707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2V4eTlNQk5vS28xd3ZhWjdlcEpxMUlpcUYxc21RTFRwc1o2b2VJSmFWcW1w?=
 =?utf-8?B?WWphczV4OE5ZbUxQZVFaUUpScW81KzBTbTZlRTQxRzZRV2VoWU1OZGdNYWp3?=
 =?utf-8?B?NTF3ZnJyZlFjNVNtTDd6bkpEMldpaE1Ib3kxQVlsTENiNEpIaEw3RVFqWjho?=
 =?utf-8?B?ejdDT1FyN0tVc2tGZzlxOGlOUnNlSlB0QWJFdlFJaExoMWZJYmtTOHdnZE5h?=
 =?utf-8?B?V3dmWlNBK0pCNnRJL1l5V2t2RW1WSGJFZmUwbzJBSU5YT045MDNoc1pQTUxG?=
 =?utf-8?B?a091Z21UYnlLOUdxOVRTek9lSUhkTDBCQ0dqQkdrNUlLaFpDV2xIMjJqUmM2?=
 =?utf-8?B?QzROQ3N0Z3crSHYvNTVyWFlJUW9jdVpkQTJHOFlSbDQwR0NNZmttV3gzMitC?=
 =?utf-8?B?a2NncC9WRGdZTzNtdlUrcWF6R0hnVlJaSEc4MGVWQ25td3JLK3lMVHh6K2VH?=
 =?utf-8?B?WGp1K1BSNGZtS0RKcmVRTmUzOTJzcS82M0F5NXhvcFZ1S0FEM255eEp5dDN3?=
 =?utf-8?B?UUxMU1lKVlBTU2FrQ1NHYnNobFkzY1FZU0YyTlhjNFBPMUVFdEZhalFrVVQ4?=
 =?utf-8?B?SWJzRGpWTVg1V3lQZ3ZzVWYxN1Y5eURUcnhpc0xBUkZCSmVWVnFmdzIyb1BR?=
 =?utf-8?B?TTR2YmNsY1U0cjFvWFVrUFhpUVJ0VGJtY0xzTzBDcmhmSjdpVlFzOEhib3RJ?=
 =?utf-8?B?a3ZES2lONVpEM3RpODFqNDFrTmZlbXN5UjVxUlJheUN2aHJmdUwzOGhKYjVJ?=
 =?utf-8?B?b1hwVnJvUHkvbEhXaExiaTRMcS9tMkJ0eDg1WEp0c2hQMnhEUjJjTXAvZ3lW?=
 =?utf-8?B?cWUxOFFqQWZVZzhuNW9MNUUxNGpXMHdpR0FuWnAvcFFhUll5OHVlZFh2MXJB?=
 =?utf-8?B?VVJlMHlJekJGeHVqUkptWVA5R0hUeWZGcFp3TVNWYjdFa3lKWnJCSEJiN2NW?=
 =?utf-8?B?eTJnNEU4U3dXM05COHpVR21Wd2NFNmwwMStSUk05OFZCWjBUYkxjSm1YNUI0?=
 =?utf-8?B?OTkzQklTTEp2RkJZdEh2aFN6VWVwdGZtRE5sTXJBSERmcnJHelZtOC9vc2N6?=
 =?utf-8?B?eXZPVmxtZCtFd2h3UXRKdGo3TTFEWTJDaFRWOXVKY2dlSzFjeW80QXVVeVJy?=
 =?utf-8?B?dDlIdnBrSFVJUnI3N0Z4ZW4zOXlQWDVkUEdnektiblAvOWcreE8yWVBzMzJF?=
 =?utf-8?B?WTdmekJWbGd1b2tXQ3ZYY2ZrVWljMVNEK3k0UDV1cFM5TnBCTS8xT2lCN0Np?=
 =?utf-8?B?emFBYVc2WUM5RE9MQ0N3ampON25DL3QvZE9qTnZQYWZuSXJpWXlsTHhSTGxt?=
 =?utf-8?B?MWRyTlQ0K2FiamlaYzlUakRRWi83VGxBN0JiQ1loRUJtU3pONUJJajFFSWVj?=
 =?utf-8?B?RytCUmNtYU0zbVZEc2crc2x1NHpFU2lncVd4QXBTaHErUmxUUVJmc2FpVXBG?=
 =?utf-8?B?SEZUdHQ1R3Z6UE1qQnpabGZ0MEdUNExzSzhvdUpuVXhNeDg4Tk1TQlFjY3gx?=
 =?utf-8?B?cnkwRHlGSXZYbk85N0xiazcwSTlPeUlPM2s3L29WUXhhMHFQdjNUQzA5UjlN?=
 =?utf-8?B?aWM2cTF1bmkrOE5Ja05FRXNiLzdsUXJaVkJuYlUrd2pwa2FBMTF0V3pIK1dH?=
 =?utf-8?B?a2NqRnBIbmhsTDRBSXZjT1lOYUpqak5uQldJZjA0YThTUVNnd2h2eDg5WEs3?=
 =?utf-8?B?OWxKRjdJQmt6SHA3SGcreXd0WERwUms4QTB5SDdFTDg5dWlEMVBlZnVDdmxa?=
 =?utf-8?B?OWRhUi9Idjk2UGxnZ3FlS2srSHQwbFF3RzRTaW45ZmVsRHBJcFlyUEc2Tmhx?=
 =?utf-8?B?cUs4TFVuM0dJam4xUWc0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnlMcExHaHJuMlNuU0xCR0RKdzJVWXByN2toYjhkMUcwRHhCZnovNUoyRlNV?=
 =?utf-8?B?ZzB3cnR6SkZ3WVdxSE90NFpwSTRvTklaTFE5RlpaMDZIN2JaRUVzbU1HNWV5?=
 =?utf-8?B?cElNUjBpaHVWd1JGWHFCMHRBRFhkejV3clB2WDZCU01pZUtKREJQY0lYTkJO?=
 =?utf-8?B?eXowUk15ZlFCcDUrV1FlQ1BCWFZoR2FKNXF5TWxlazk4VlJ6bmFxNXhDOFRi?=
 =?utf-8?B?MndmRE9JenRkNS9EV01VV1BaSVk5ZnFXcHIwUm90RWE2YUxIOWRBMTQzWUJz?=
 =?utf-8?B?bC8rTjVmWC9tN1ZWT3kyZXdoVmV0RmdrRWoySTloR2xHZDFnMHNHK2pmcEs3?=
 =?utf-8?B?MVNMTWFtNjBqU2g5Ni9XOFZrNGNHejNmVk16Z1dmQUV0N2YrVDJFRXZ1NXVY?=
 =?utf-8?B?bllVZndrU2RsUXJvZzJjZ3pmZG1OUC92ZzBMS3RzL0VGNll1Qm5xeExJYkdx?=
 =?utf-8?B?amJKdktMdDkvbFg1QzRLa0RGTG5XYzFsTmFrc1FucnNZNUpFamNIenBXWi8w?=
 =?utf-8?B?VlV0eXRsanBwdi9zQStleDJmVXJhaEwyQVRTOVZvN1N0d25ETFgvNWl3TjJ4?=
 =?utf-8?B?UjJtOGFQMTJWdHpMWUxncjB5d082b0plak1raXMxaUs3MUEzNVp3WFZWRzZE?=
 =?utf-8?B?cGJaTW9ucEV5M0twR0Z5OTV4UVJBWk9YeDQyV0FVRXhiNk5xWmRyQVhsMCtu?=
 =?utf-8?B?MnYrdHlwM2xMOFRCYW5OenZCWWtVRUZzMlNrUTB5enFsV2h0WndQSzhYTHpG?=
 =?utf-8?B?em5zV1JDYUNyZEFoalVzVGJ4YzhjU2RmOE1qZG1IaVc1ZlFqVnJpeTB2SUli?=
 =?utf-8?B?NFZ3R1cvSEtwVW5URVBFWHNuU2Y2M2hoaVdRYlB0QllVMFR2R1RSamRZemhy?=
 =?utf-8?B?Smhyd3VETXVXMkFld1owOFRKYU1MSHJnN1VQQVo1WEhObkJJTUNVWWVmUmNi?=
 =?utf-8?B?ZE1jNmNHRmY2cHpidG9VMlJGWWxDd1Job1IzU0Jmb2R0QVovTnkzM3R0RWkv?=
 =?utf-8?B?L3g1ZHBMemdZTlZDUThQRElGYml1VGEyTFc1VFhXK2R4a2VPOUd1cXNwYzJW?=
 =?utf-8?B?alZUald6Q1BjcGZtaXNURSt0WHBpblBjU3VBYSt5emxLbnRjWlNtbE1GQ1J6?=
 =?utf-8?B?bTFKS3A4OHRxeEV5YXcrM2ZSUjNJZ2t3TWo4WDBQcjIzcy9wa0IrMVlSRjFK?=
 =?utf-8?B?UGdwZWJNd3FmOEp0TDhrQXVVNG0wbUJCeHJxSlp2TEhXZTRkZkpJWUJoN3VJ?=
 =?utf-8?B?UThCQzFIdFBWS2RYaS9pQkJBTzNHZjVkUU9NV3VQUHFWNUpZUitNeWhvWmxU?=
 =?utf-8?B?WnJIQXNDbFJyazZtcFlTRmpKVmk3OXdzT3FZMzlEa1Y1Ky9PV0pMYmxlSkNo?=
 =?utf-8?B?M2tJWm9RUEFPVmJweEhRU001SzdldlFOVzZOQ2dqa2locmppbDM1cUIrSXM1?=
 =?utf-8?B?OW4yUE1VQzFnQVJRdjFzOUhVTXlUVmUrOWc2QTBHWDdFbGJidi8rTGpNVkFo?=
 =?utf-8?B?cmRhOENEOUczYlpkRGo2cFJEQm9RQTdTMHh1NEppVDJGVkNuYm9GNmJZQ2di?=
 =?utf-8?B?ZUxWdGo1M0JKNDFhNXJSTC9ncDdxczYzaFZTQXhBT0RsSVVEOXBOSVR3dkZM?=
 =?utf-8?B?MnQvWjJUV1JQeHlCMW5xTktjdG9WWGp6Syt5aHR4dGYyR3pMbUNCWnFPVDRw?=
 =?utf-8?B?bTNITnVhVlZOaUNwVmg3d0pVcUVjV3Y4TVkrVFdsVUN3ZE9DK1dDSFcrK25z?=
 =?utf-8?B?bTVBckROTXNpT2J2bjVvbE51WWF3VkFrRUQ3RmZxUFJOeEZzTVJPYzFpSEdr?=
 =?utf-8?B?WVludk1lRUNJMWtLenF4cXJMQ1hzdHNTbnF2bmxLbDloSWgxZWRCRy9HT2hT?=
 =?utf-8?B?ZkcyWStodjI0NmxFUzJaeHBsODRJVnhFN3VJNk0rZlR1RC9WZ3poOEhNYW5O?=
 =?utf-8?B?bldHK3NkdzNVYXVhcDJvbHpRS0Y3SktkZGlkYmg5Ti9PMEZtNlZiS2Mzcldm?=
 =?utf-8?B?SzJOaUgxaUxzeUxJM29Lb24yZzBYZzBNNlVxRGs1bktUQVZ3WDlVSHZGVlpR?=
 =?utf-8?B?Q2doK09QQUdZbWU1THlpbUlpajZSYXVhc1BTUE1mTE5wR2s5MUJyenM5OVZx?=
 =?utf-8?Q?Dfh/yqUWHhvYNvhtrx1476vpp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ki+RBcK919YQ2c3VBw+nTuwnabTA7asJfcF2GSFjsw9lWMTnW4q/f/I2LUe++qkqFqvVWUQmvclq+/tfzjKsooRY5Ul4iCqeq/+CIL/ux7PyvIQqucxSYjfFsic+G2Jxz+88YFQXNPpGt60pcyW/xrGVlrjrZyznC4wPR9116cXbY7EvDPnxQNM0mb1lXT4gGtS79ifpysL1kCliUzLXSf4FDS2rXlVeDNrPXUm8Du42ON/ckpfMDk5GvvRfddWlweb12V5DQwIT6KlhbfVyuZ7gxXEfZo6HO9CZUf7OZ1uf6Eaihjke/bDKKy54B3ClcP8s6pPZ9ixmcGTQtgk04Q6VSAhRRELo+X7eVHwyYZOmfDMMS7XYzcQYnS+9PiW2pZ8GiQjVn+8VQQ1ATWG17O5tddavj5LHRXJAu6VXTQCl6aelTad11jeT16Z3yA0qiiZfZOZp5MCqhN/fjoydt/JZekgRgzMmUblT2mZIscwA3h2w1HH/nPQsD1a1unCg+jo1ZQKEjC1ST0eYaz3G/QGb36XJ4jdBebRoMpPJqNWkXnrqA9cNajrFxqSMlq/c5ggtDZ8Do88WsuwUiu1PboZNQMfOu6zyHBjTWmUvAZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a22c30-5001-4851-ae9c-08dd53326707
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 11:16:50.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrBLIqIoLCRCk4UbFrX7Zfhd64AROPJX7uZg1Lzmu8o359Suip5rcDT09XBB9/YV+sRI2VjHQR/4fBH4JrT5DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502220089
X-Proofpoint-GUID: --fJGceGMRpzcF4_T3muzlipfS7KUjdE
X-Proofpoint-ORIG-GUID: --fJGceGMRpzcF4_T3muzlipfS7KUjdE



On 21/2/25 23:03, Zorro Lang wrote:
> On Fri, Feb 21, 2025 at 12:04:32PM +0000, Filipe Manana wrote:
>> On Tue, Feb 18, 2025 at 10:36 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>
>>> From: Qu Wenruo <wqu@suse.com>
>>>
>>> Update comments that were previously missed.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   tests/btrfs/226 | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>>> index 359813c4f394..ce53b7d48c49 100755
>>> --- a/tests/btrfs/226
>>> +++ b/tests/btrfs/226
>>> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>>>
>>>   _scratch_mkfs >>$seqres.full 2>&1
>>>
>>> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
>>> -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
>>> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
>>> -# So here we have to go with nodatasum mount option.
>>> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
>>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>
>> Btw, this is different from what I suggested before here:
>>
>> https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b
>>
>> Which is:
>>
>> # RWF_NOWAIT only works with direct IO, which requires an inode with
>> nodatasum (otherwise it falls back to buffered IO).
>>
>> What is being added in this patch:
>>
>> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
>> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>>
>> Is confusing because:
>>
>> 1) It gives the suggestion RWF_NOWAIT requires nodatasum.
>>
>> 2) The part that says "to avoid checksum mismatches", that's not
>> related to RWF_NOWAIT at all.
>>      That's the reason why direct IO writes against inodes without
>> nodatasum fallback to buffered IO.
>>      We don't have to explain that - this is not a test to exercise the
>> fallback after all, all we have to say
>>      is that RWF_NOWAIT needs direct IO and direct IO can only be done
>> against inodes with nodatasum.
>>
>> So you didn't pick my suggestion after all, you just added your own
>> rephrasing which IMO is confusing.
> 

Your sentence missed the consequence part (checksum mismatches) that 
Qu's sentence included.

How about,

# RWF_NOWAIT only works with direct IO, which requires an inode with 
nodatasum to avoid checksum-mismatches (otherwise it falls back to 
buffered IO).

Thx, Anand

> Hi Anand, please talk with Filipe (or more btrfs folks) and make a final
> decision about how to write this comment. I'll drop this patch from
> patches-in-queue branch temporarily, until you reach a consensus :)
> 
> Thanks,
> Zorro
> 
>>
>>
>>
>>>   _scratch_mount -o nodatasum
>>>
>>>   # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
>>> --
>>> 2.47.0
>>>
>>>
>>
> 


