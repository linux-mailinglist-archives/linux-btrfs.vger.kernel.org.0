Return-Path: <linux-btrfs+bounces-4041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7A89CF99
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 03:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419632851FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7645CB8;
	Tue,  9 Apr 2024 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R6ZdC5gS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RIhJs43H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AC7E8;
	Tue,  9 Apr 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624597; cv=fail; b=b5bKDdfuBYwsSxQNc4CHM5kniwHAwDDi6IUU9UffOY53bMbDz0UtpTnZgHZbVKsrFtTs/yRqV08exMCdlcFc5C87xrfF3Kpm8rDWAd1lGl5cfskIpUc7JK98Jxh5LsqP3b/eIVROzTckzfxn8mgoyphseKb/fazl5bTK8LehbK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624597; c=relaxed/simple;
	bh=CFSbQqzsRhf2cw4mil6sQHJRNhzRifiONdq11CpNqFU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sA9oQ//O/168v1te7LC5t+AzrWl3+MigehVExDw8jxIeXwGrSn3rgeOGNeDeg9vv/rNS85Dx5vIKMA839W6si7k1Y7OzmUoSgxPZ8VxbHVwDZzlx3QvaF98syJPTw5NQ2JkQOkVzxDXgKRDpDELexKMcYGxm2+D9j9q/tu9W3kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R6ZdC5gS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RIhJs43H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnSAl018302;
	Tue, 9 Apr 2024 01:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=AKzrp3pBg6x1uXeSEYMV7C9UbK79xLfyAKPXuBJtXnE=;
 b=R6ZdC5gSnj4yRkbOfbE8uimvDfHnR0EQ4Xp3KQK3lT3r9X1sUYSBEoc1ueaHD0vOjB2g
 zlyKAhuvzTjnNVRjiLhcKPozonccBQ7P6lxsjM4rQCaLolilk/lMKKWa1StVoAPF3ayK
 b4/ctWKqmxPH2BGPDHBzTV4pJ8hAa4sF7ZsoOBBWKEezE0d7u6Njb1VDWHySe3g2hHzk
 Gndxvr/FF/82hnBfs/9Rb9uZL2TA+4TceI1/34DufEMkUmVYepyTL9cp/0gZaLQpvRNb
 l3MNUBgkQijMxsGPn3YWWVzuRDuaGtJXG7iM2TfvQNWXIBIboaMoLTpYqWjk/rSJmww6 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacm26y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 01:03:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438N553W032952;
	Tue, 9 Apr 2024 01:03:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu6kq4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 01:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0OFtwZ+1LW01TgS8g3TRL2pMsFOAfROl04RDMjM4T4nhu6biaTdlyXj9oR3ef5qEqv3ZGWvYtvYQycOx5vnKN8AOpPEQq2KYZWVOo/d7DSpS4BXjeWapeaxePxH40Ac/fRdPviBVPjBy/Koss+yXorWlrj16sKd6Ye1qJlq1WdZgRrNPhqY/GX+TW70NGV1gpiHay9ofJttZf9JlMPGeLw/fNV26ursDAywDuLk2tzz7oT6d2wliCreKs0hIK+GCkonY40pGY3docct76Fbui9gTLaBsQZJGYRF2vK+qnMaxrHIrKUUzOn9Ex3OEkQZICTKgammlAwhReatjz8G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKzrp3pBg6x1uXeSEYMV7C9UbK79xLfyAKPXuBJtXnE=;
 b=Nw5guneETN8kQod7tI9xPWkqKKzxboY2zpE+FdaZUaSlBLdDgIN7y46Cp6HFwoE4+aUEmgYsDKABGi9rUimYIQopjX+K6F2Rmi2DXk3ucruo6K+1tDmzRchk2zfXf2p0cSeN+t2T2RML7eKK1aqh3ldibKnrP4Td6108y5B2wBeGJuH8UDLdTyhjAlmiKpfXdqMsrRar+PfAmHL+idlabcY8XOdxSK6C5Y0MSntSghVSZ0qmRHEWlvlpAMeTi6unQ/Hyqa9yfr4sru0EUc6zulKcJS8v334mJj6guQ/THD24QxgGS2RQ6kKsXYimM0T/rz55XHtg5ZuE0Lo1RiZhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKzrp3pBg6x1uXeSEYMV7C9UbK79xLfyAKPXuBJtXnE=;
 b=RIhJs43HJypd/EE5nx32/bCjYOSfdiQaZiw7JdA5A3G7YFjklIaQh+8lwCaS2xyxUxkQ40Mixjr3ntot+OMi+I1yK6Qg7rpq/3V5OqsKlljjioR9HS2KWVOxk5c+vPCT8tyDiCh7R9bkcC+pKOYEyzVnredhlbR39+ge8eiHxp4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 01:03:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:03:07 +0000
Message-ID: <eda3efb3-6b21-4250-bc46-2082311d0f36@oracle.com>
Date: Tue, 9 Apr 2024 09:02:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fstests: change btrfs/197 and btrfs/198 golden
 output
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1712346845.git.josef@toxicpanda.com>
 <88b11129c00fb9b07e36569b4b5fe823c0a98c39.1712346845.git.josef@toxicpanda.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <88b11129c00fb9b07e36569b4b5fe823c0a98c39.1712346845.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5976:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dOqv9cXRHB8vwGGNB37d07Arut62YhbpyXassPWG7s+podYBOzQntrc7GGrBA3KPay7qPipFX5AW5Muq+rNgY48dnCnNHb9NgB29F0pRetbcESgdAZGbcX1YvB/vqS847iYBwX6MKa8lwSiao+g9ZPSDVPs+cw1PPo/Q/2hYaPpo2WmD+JaHRjx8qyNKl0/f9pgCOMZhce7toBbFP9jPOcwivLUQk3wQVRzIGOtrR97lyxFgucYZvIEHhfCzpO/2zLx2EQWjuaHQM14c2LVMPhLSN4YzCLoODHMaDUDSZEIrayqC1jAvzfJRqHh7JbrRi1dTyFnAPncsARYkNv09gAg6pEJY958KpEP0NvV808/UWHib9nsHX73yG4h6MlxzafiYVVfVYgv9cN1A/lI1pEMiXp+8GKqucDjs+GCXScqIbCHz/i8KnjdaXm9Lt6iQJNWLmpzHqK6IzzVHeLWqih7HsD12/aiNNkTKcKl82ok6x/oQMpIR9LAvMBb6HVpN26WFMh1zywHBCJuATAcpgPMem8PqtBM7P0HLYz7V3WLr+KVmcAcmnjH+m7L5Iv3VT20t0mbm5W4PvnWVCl4PlOW7sY5SYYVzDenKdjc9zKTjLGOTRpccRHl9vdybCe0luraPmgI8KogomAri4dLpu9cw83xj/KkKup8/hJCnet4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Qm9RTFZiR2JTSzE3RE9jSGxEU0JZL1RaOUNBMHUrTjR4YmNJb2Z4SEZoUllw?=
 =?utf-8?B?OGhjZWNtYlNRT1p3M2FUSWFIaXRDaG8rYXZ6MmRaMWtiZmdZLy9DV3ZSdHZi?=
 =?utf-8?B?UkNnOVl6WUhhZWJ1ZnV3ZWcreFovRndxRUxCMmRlL2h4c2xBaWxaQkpYTDA4?=
 =?utf-8?B?WkVHb0FPWExKV2lxMHViOWJKQ1FhMHE2QVJPb1VKRWd6eEVlWHN0NXdVSkpT?=
 =?utf-8?B?OUdZL2gxSjR1VDNYb1VZMUJPdUxmbkVhRjVmMFhYNjBENUxyRkhteUIxWEJS?=
 =?utf-8?B?S2tHaXA2THoxR0FBZVZMMWVsT1NRTjdGa0RFSFU2QWRWTWRLbk1SR2V4VVZs?=
 =?utf-8?B?TFo1WXFFRzVQejhVb1pEWm05TTR4WGJ1MWN0eG5TeWpnUmx5Yk1BZzdzNVd6?=
 =?utf-8?B?YkFCY1EvWFlHRndxcHVJUXhQT0hLNEVSTTQ2bFBWY0Q2azdOTnhYTWFROVhs?=
 =?utf-8?B?ZVJrS1pPNmFBcG5vZ0Z0OWhDaldFMm9ZdjJhSk5SMnN3WHd0bFQvbWM4UEdw?=
 =?utf-8?B?Z3BNaDMvZ3FKbE92VHhuTGp0QzVFK0lGeE5FanRnZDFBaUtVVGdPTEprNmJ2?=
 =?utf-8?B?MDhMQng5dWxmUERsVUNuYXBTR3VLeE1wRjYvSXdPNFRLTlN3cFBET25qVFp0?=
 =?utf-8?B?VDdJaUJDOVZHVXVBRTd2VlVzNTlXMzN2T0hMdElvWWRWMkhsNzFSbzFadDBR?=
 =?utf-8?B?VW5TQlpVbE9OQnJNZWwrL2lwTXdMZkhJbzRYVml4T1hSSFVrZFAvMzVaczhn?=
 =?utf-8?B?TzRjOHlHWTNWbURmYU42Rkl0aUNMMkxyMnNBNDR2N1NXV2JXTXlPUlRqdGlK?=
 =?utf-8?B?Z1dxSHlBT1k1cHZxMG1ZQ2hNQ1U2ZVBDQ2I4SVZWdzM5TklLUFU5aHlGN1VN?=
 =?utf-8?B?R2ZVMkV0aWxwSW9vQlVaM21iMFFSZWtwZVBzQTlYWHhGQzFrY0hoSVRTYXRo?=
 =?utf-8?B?RnpaRnQvWFR1ekk5QXpzY2lLMEF1eGtsQjRnNEg4OHdUTnR6Q0JKQW0xc0h2?=
 =?utf-8?B?RzZ1R05XOVhyWFhnakVaWTN2M0NFZnc3bmFvZVhkNWxSamhCdlNGdHNzNi9Z?=
 =?utf-8?B?QklYMUpRTTNacnFiYjkwL2hvYlZVbzRtaUxWeDRxWkc0R200R3FPMytyR0Fw?=
 =?utf-8?B?Sm00bUhGaUtLTVN2cm9xOVlLa0l3S2ZrcGNMVTZPZDJ0c2cyOEgvSnBpZURq?=
 =?utf-8?B?VUlQVkR3OTJwWENmaXJxRU5IazNwY2RweTFQdU1ERUhXeVREWFVBMWF1U2xz?=
 =?utf-8?B?cTlzejhsVm1IUmhxaFpQdk02czBvN2VpQSsvSmhIL1lxRmFmNmk4QnZ3OE1j?=
 =?utf-8?B?V2cyamlpTjBiZklSczVDTlJtVzVZamZ0QjRlQld4c1dNdjdUbzRxRTBYN2pn?=
 =?utf-8?B?MlpoWEhSZ0dYM3g4emFXS2lSWVZJait5NW9lYWhoQnFNSHBmQU1NMmVpMUtL?=
 =?utf-8?B?YU9RaVFSMlFGRHQ3bGtaTHcwRnRvWHgzRUZGT1BjTlBKVDRJSWdwMlA1a1dR?=
 =?utf-8?B?WDV4bTM3ZENnR2VLbWxmSFBzYkZqZTZ1WmdHalp5L0kxbkRWZDBLUFdsSExU?=
 =?utf-8?B?cXY1U1JaOVdKcTZwcDgwRjM0ZDk5b2RhSHJtWUtqV3hNR1ZFWDZscWw5L3BK?=
 =?utf-8?B?eGg5aDJ5MXlUZWVNZy85ZFdHOUtzcUptZ2NBbXhDZkN6RStHL2xXV3dmalRZ?=
 =?utf-8?B?WlFCNFRvV3gxTUR4TWJRRmIvcXZid0RBTnR4bEs3T1V3WDFGMGkxNklRbkVj?=
 =?utf-8?B?ZTY3V1VsQitrQm9TS1hqV25FTzZmREs1Z0h4MnhIU3RUM1l5Q0tYV3lweHpM?=
 =?utf-8?B?UjVlenJzVlFPaFR3RjRQUVVTeUZkOURFeXVUWTNtRm40WGpneDhHWlUwcWl5?=
 =?utf-8?B?YWRxK1dlQmtxcHRaczd0UnNTNGI3SzNycDdtbW1lVWpHcmZVT3ZLWm1VbEZ6?=
 =?utf-8?B?MVBZTzB6T2dSN0U3TGQxSTQ5eXpsOWFCREFmQjJzNTNzdW9YTXFaeThUb3F2?=
 =?utf-8?B?SmNVdUk0UWR2UTIzUkpUbGJBTTBRRXovWTBUaUZRejlBcXRBUzVnaUl6ZDFv?=
 =?utf-8?B?SVZ6WEtDRkNKZmxXbVBuT20vSURQVkVqSTZ4ZjNoRk5iVHF6elRaQ2dMOUo5?=
 =?utf-8?Q?tvXapvmwcdZypYh3Xs3u+KD5/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aD6ffiNUgWKB+DBdKM6E19S3A95NODoyo+FGIYMmB1PLXEjSe0xG17MvxGVOVaqcVhyeuv6JlaygsXulzunQvRsXhAOtcwa8leeuxWYEzIvEmlFOhiF13uGUmtKQjpF38LbfIGn4dney3SDWw9QWgmLdNr/5+WR1HmnFqArhHfh5Wb81T2qAJ3oTKHl8N/wVTMLD7Z1/Md4PmaN5xqH+LbFVdmfgMegqJ70QImQ3aL8U2lHGt6D1JpIhgxYfhj4K64+usI15ai2vUpSlYoGojB9loOf8aRvORIsCSgeYhtrDr0GukdeKmXZPgCQ2AGrlwd+wTLN+qbwFIHBbGi+PFwWtWM6cDVLuI7Avwbly9ZS9B060aDe0pjzsTtY1A0m/jxxppgAR2g0UH/nmPNMiegtRp2S5txBkDSGUUuQKOhSRgm7sMlGQOVv7sXuuaDQgQ23i9Ub+wh8uNBLmMGiDHSJ/xPueIg2/yzyYawEsXpKd9/tDOQqD36FcWyO2QpHaJlNyfBJMM5uB+wzP81qaHqZwAI9DTuuZ4QKkYxpaj9d6Y1XnVtPxOmx+Sjhxf4hr2wcuhUa6JKq+ElvXPUU/kOiDqe2jrFIGqdrNxs9NTPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae93772e-7ac0-42d4-176c-08dc5830d115
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 01:03:07.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz0k/lbL7B7gKywuI73zZtoeeZn2jtwz8KpNqsUCCB/AOEAIxMD91lPzFHwI/QXiZf7ch6LDiuWHJIK5ES5Tzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090002
X-Proofpoint-GUID: kNrFitdmCIE2rsDl_YZItP3vyAqZyTZ1
X-Proofpoint-ORIG-GUID: kNrFitdmCIE2rsDl_YZItP3vyAqZyTZ1

On 4/6/24 03:56, Josef Bacik wrote:
> Both btrfs/197 and btrfs/198 check several raid types.  We may not have
> support for raid5/6 for our available profiles, but we'd like to be able
> to test the other profiles.  In order to enable this, update the golden
> output to have no output, and simply have the test check for the device
> we removed to see if it still exists in the device list output.  This
> will allow us to add a check to skip unsupported raid configurations in
> our config.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx, Anand


> ---
>   tests/btrfs/197     |  7 +++++--
>   tests/btrfs/197.out | 25 +------------------------
>   tests/btrfs/198     |  7 +++++--
>   tests/btrfs/198.out | 25 +------------------------
>   4 files changed, 12 insertions(+), 52 deletions(-)
> 
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index d259fd99..2ce41b32 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -38,7 +38,7 @@ workout()
>   	raid=$1
>   	device_nr=$2
>   
> -	echo $raid
> +	echo $raid >> $seqres.full
>   	_scratch_dev_pool_get $device_nr
>   	_spare_dev_get
>   
> @@ -62,7 +62,9 @@ workout()
>   	_mount -o degraded $device_2 $SCRATCH_MNT
>   	# Check if missing device is reported as in the .out
>   	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> -						_filter_btrfs_filesystem_show
> +		_filter_btrfs_filesystem_show > $tmp.output 2>&1
> +	cat $tmp.output >> $seqres.full
> +	grep -q "$device_1" $tmp.output && _fail "found stale device"
>   
>   	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
>   	$UMOUNT_PROG $TEST_DIR/$seq.mnt
> @@ -77,5 +79,6 @@ workout "raid6" "4"
>   workout "raid10" "4"
>   
>   # success, all done
> +echo "Silence is golden"
>   status=0
>   exit
> diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
> index 79237b85..3bbd3143 100644
> --- a/tests/btrfs/197.out
> +++ b/tests/btrfs/197.out
> @@ -1,25 +1,2 @@
>   QA output created by 197
> -raid1
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> -raid5
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> -raid6
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> -raid10
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> +Silence is golden
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index 7d23ffce..a326a8ca 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -28,7 +28,7 @@ workout()
>   	raid=$1
>   	device_nr=$2
>   
> -	echo $raid
> +	echo $raid >> $seqres.full
>   	_scratch_dev_pool_get $device_nr
>   
>   	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
> @@ -46,7 +46,9 @@ workout()
>   	_mount -o degraded $device_2 $SCRATCH_MNT
>   	# Check if missing device is reported as in the 196.out
>   	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> -						_filter_btrfs_filesystem_show
> +		_filter_btrfs_filesystem_show > $tmp.output 2>&1
> +	cat $tmp.output >> $seqres.full
> +	grep -q "$device_1" $tmp.output && _fail "found stale device"
>   
>   	_scratch_unmount
>   	_scratch_dev_pool_put
> @@ -58,5 +60,6 @@ workout "raid6" "4"
>   workout "raid10" "4"
>   
>   # success, all done
> +echo "Silence is golden"
>   status=0
>   exit
> diff --git a/tests/btrfs/198.out b/tests/btrfs/198.out
> index af904a39..cb4c7854 100644
> --- a/tests/btrfs/198.out
> +++ b/tests/btrfs/198.out
> @@ -1,25 +1,2 @@
>   QA output created by 198
> -raid1
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> -raid5
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> -raid6
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> -raid10
> -Label: none  uuid: <UUID>
> -	Total devices <NUM> FS bytes used <SIZE>
> -	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	*** Some devices missing
> -
> +Silence is golden


