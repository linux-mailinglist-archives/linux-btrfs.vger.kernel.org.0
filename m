Return-Path: <linux-btrfs+bounces-4062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B689DD19
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114E91C22F1B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACE12D1F9;
	Tue,  9 Apr 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gyUc3U6N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B6XMiwR6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040C4AED6;
	Tue,  9 Apr 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673827; cv=fail; b=UuBr7jVxSXfySTxj15g7nLt0QNmO9haLSMiN+VoLbk1hOW1FL5GzphjrA6/eDAFN53Jn29kU2nYJDXV1KgAGepieBQdkqa9gmbXUrZADKEic5v5Iwv4vKagrM/O6bwE4Jyw3lmzadr/M3ffgP+kdU0vK+iulLy/nkO0C40PHhk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673827; c=relaxed/simple;
	bh=uWi2QNJCKQml+7UO5Tx5YvwIltZR9nTtCEnAlbJgPJE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZuapiW0/1uB1Nio2W6nbtCaxibTxrrTRGcF6Mxci+/vfMoShQuaapVk5/zKqHqGug21dUycXqn3FAoJgmsgdRxJ+gQ3FqiOoNh8cOehPyAwYuqvHA09C0GV58uHh0uPtKP44tBXIC+Si0nYoi3k5XBkGIQulGrIq14et9zXbr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gyUc3U6N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B6XMiwR6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYUse005156;
	Tue, 9 Apr 2024 14:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=G4JK5vTTLJV7bkays5RiKqEbHsNSJcObPnTaPIvtVBE=;
 b=gyUc3U6NIJmchAxy2dZXxsia2IX9rwRC7kjcbHlI03RakvDQD5sgkwKVSEfOnt80LENd
 UhDc8xCyMEu/SYzqpnqFcGeQPHX9qzRseXofxc4nHw5Eng6FwOiL7lym/r98pSRQNPoU
 Z0MgVVDUxfpWbE6noYdR6QzfP1GMc/yPfv94CbfjQKk6DQfdN7HTVgJwB5nFgGajgS6j
 8RGSp3vBMP0oAn7POxHJko80tsn8ImKGYrCz1sFBfJdK+OpDi0J8Yq5sbd4okJ92KOvi
 mrcdpjOviOLEjXLgUeYZltHnkLWifTGgpPK/d5s8HS4QDWUOOAEzex1FptVWjb8Qzn5O WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0256kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:43:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DdNTW008023;
	Tue, 9 Apr 2024 14:43:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu6tw4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt7XrG76XuU0V8vOnb7etGtXG9oX5joJkiFhu2uQ4+rrll4mFF19t7UZMJIWPgJRFlmfCJgFKRCtfHumPQpzF+3cUj9ZL++Xy6JVaRFuIRT4LGLRrkrHjdiPXpsw7Dj5eNYDS/dvoDZWZTgr6zrZGvwtV2saCVfBvL9BP5NdiDM9gifiJIt0aNNPoJ5rAVqeUDYbjaHmofhRtVLLLOHqvau9CVonrrjxQlJBuyBbd3gweBNeTdiuCokOBSWwvpTcaz41UCxmQolsnTAoW8qwMsYSiZ3KIlis1DH7QriwrWOFXDBIwwmTHXhNIuhBPReRUIX5ZOgQnHuUz/1d0wIMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4JK5vTTLJV7bkays5RiKqEbHsNSJcObPnTaPIvtVBE=;
 b=HCMkvFs5N3lTUEyJ/xGz4VfGVsLMQVen9nIAJqJJlvIbsgagrEx0ke05B5Sw2V8qcWxGh/q14JWPDTmZrHSONnA6EWEVZP0qkE3OQmLP9J5u9DaEEHlq544H4ojC82dOFRBYW/PaB6MTw/S/YkLSroS77qMMcs2ElvYlz+Bn1rktTu5+7e85xQL/sX50Sf56WlmyvB29E7j9z6jt157DEaJYnoyX2tPAwUSPu4OYMbErN6WUkm30yURayPkuh7FWo1vVoOGpHIUXmGXiZ6NB6Aq4Ke/xhSw4bB4JNqTPQ8ntFeVQyKMakQLL1RKn3s33bGOHKDVLq//6alBgC0QLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4JK5vTTLJV7bkays5RiKqEbHsNSJcObPnTaPIvtVBE=;
 b=B6XMiwR6BmGGZzX9fFW+GQKdy/gggREnwMOD/ze4n0VgpndyGr6iPYHEydVVWtVVZi4j1vgbvjG2S+JJlDKNmpaYj1vdBXmXQDc9IFD9mYJl5/lwchm4pXYebp6G5E7nHhrMrwLw4iwvrCwghTme+HYhHN2rvSa82s42ZDjrCn0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Tue, 9 Apr
 2024 14:43:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:43:37 +0000
Message-ID: <eac13a6a-4c7a-458b-8577-ffd2846df63e@oracle.com>
Date: Tue, 9 Apr 2024 22:43:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4583:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9sr4xyAy4JRwKZznjmFJMzwNlGs3oOQZvMmxaPDp6FCckRjt38y2alpgOxpAGOcl17ALIbHLnA+7xGbVoy9vNgjaJtdwy6v3ikxD8rtlWKyv0d+9tZ7wExr823JhsFElK7lxiumzDQ7/cdsqWzxmKSYM2EXbmdyz19HOtBb0ituyLWrgpvZo4J2j6pHcIHtTo6dQe2zDigFSFE6WFzQRDH7rcND/a3CYCg781CLIsSotAsD79/NXtuI1dq/+2uPrIUCuEczOh1qSrSTwhZEOKJF+3gXThafZhU5eKbME0RE36lcuKmcYK869OTKs29KZvFpugfyY8dAX3dYbDhsRU+WOhLEN8GkQAipGiNnN9qZGRY9ilaQz7R/PScGGL5G1oa2UgFTdpcKc/g5JfNFY45GF+FLkeK2NvNQtkztIicPAZmeCHW+Wt+8M4AnVg+1Opuimsu038gKcJKruk136zKB74DiQ0RKlAZi0gYttK3mdneVsDjs9K+6PlbmKQEzQLT5F2ikqC0bcdcGA6cwePYv1y04mto5OrjYxwrryPgijvQYuJ0bQmI4Q+/d++WxZM1cPO8PTViBEYevh1MQCLzcH0tqtG+n2WXLtcswNUXuoFpyjUMgUUckUHmDH5NebZ5CCxZfWZJe72NT5j89Ik1Fqghhwb9XiH1kSh7nQZkk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zkd2dVZpQ1NmYUZvNXR0c0ZGTkFOQjdURG9SQ0NISlZ5eUZFdE1GMWlLWCtq?=
 =?utf-8?B?TDkwK1h3TXNoRU50a21nRUxNWFlsM0I2UU4wWUsxU25zcitGSmpRZHl3bnMv?=
 =?utf-8?B?amF0SlAyUkJYc0ZHNkh1TGxqcVJQSTZmbXAwNGlYODB0K1BwVHpPY25aUk9U?=
 =?utf-8?B?R1JQSnRvYVMvaVNHRGJzcFNYb0lOcmxCd3AwanBYZ3Z5QlMxSFJ5NlhaWVlI?=
 =?utf-8?B?MjRWVys5cGo2U1ZTWjg5T1BBVHY4SEtxQkFHTlBpYVFFWm9kQzkrYTRveFlt?=
 =?utf-8?B?OGZRTmNDU1l0cXhOckwzeGZXZFZQWnZuU1MvLzRzOVEzVlRxZ212RmttNWl2?=
 =?utf-8?B?TytoSkx6S0NZVVhDZmJMdi95ZXMvMXhUdUVLR2l5MUJxdWNCSnhLeTdxTTIw?=
 =?utf-8?B?SlRrbmRXQzBlWG51WG4rTVBEdCtRbnhYL3FJY0lpUnFhZWh0OTN4WmgwVnBN?=
 =?utf-8?B?bVo5eEpPdzU1VjRhcnFBejFTQnlIYmNGeStGNTVYVjVwVkZxV1QxNlhEbmpD?=
 =?utf-8?B?ZlBmZ0N5MHZIb1ZwU0h1VkhwSVJPRXp4WDdtTWEvVWhpRGJzSE9FQUFTNUUz?=
 =?utf-8?B?dW1VWFNxS1RMOHM1M0Vac3QyM2FLdHdROXgyYXRJbkRieEVWc3JHVWMybGlU?=
 =?utf-8?B?UGZzTlRxSnlycWVRMTdVYUhXNnZCSkw4U1Z0QzRMUVVyc3d3MHlBRngycUxJ?=
 =?utf-8?B?MHpJMUtmR3BHQ3J2NFI1RjFRZXFLWFg1Vjh2Q09LRUdkK1lmTEx5SXNGUFlP?=
 =?utf-8?B?em9aYTNvRWRkVVZVODFtKytZNlViajFSRDB4enhRNUsvNWIxSEtaNUZmeTF0?=
 =?utf-8?B?VmtkWFhsWFIzWFVONUtGNVZOTXlMTU90QmV3VERRcW9WbkFDK3hMSE03ZEgz?=
 =?utf-8?B?Ukh0bnhHOG4wNlFyK2hCK3lDV2dzTG1UcWIrQ2R2RXF4TFg3UFEvbkRsdmVh?=
 =?utf-8?B?NUhKTDM5VXYzQkFmZ0VwQ2hNZE1CWHk1dEFrOXlJMzNNcndVUURNaFdOdnda?=
 =?utf-8?B?TGkzT0VIblpteGxlVFBFeXpRay9tTGpMcjdrRkRJcVVRZTNqbmY5N2YrazhS?=
 =?utf-8?B?Ykw3VU1HNEhDQy9LS1J5SDFYaDFmNGRUT1ZUdjdOdWNYQjNFUHdTMTJuWnZO?=
 =?utf-8?B?L2pqNmZWblhMYjB3ajkzRi8xdEZsaEk1d3piM1IrTXMxdDVLbVAyY29NVGRI?=
 =?utf-8?B?Z3F3MVVXejlCUVFwM1NlcFRjTnZsQ09XcTlRd1YxVnJFWFlXd3FmNjI5U2RS?=
 =?utf-8?B?R2tzdGRsY3N3b2tMMHVxTS84cjNQRGRVaGFDTnJWLzhwdUNNQnNZVm5DV3hD?=
 =?utf-8?B?SEpvRVZJV3hSdDREbFk5ckJrUzRKcGtEUktiRXNwWnhrNUkyVGFxYWNjM09v?=
 =?utf-8?B?czZSSFVUbVluTzhLeEZ5YUlxQm82SWo1WGRPalNHcnNpQXc0OXBIMjZJWHQ3?=
 =?utf-8?B?RUpOMTdsTXBBSit5QTQrOE5RdUZ3WWZGanNjNVRkMjF0OGw0RG5LTHpmSW1o?=
 =?utf-8?B?a2RjSjdHNmZITEhva3BtVjJmOXFzMVQzYVFLYVNLc2gyc1Exa3M3czVFWEpV?=
 =?utf-8?B?eWtoUTNLaXVKRG1ScXhPckxxczhHcUJZc1AxMUROdTV6ajM0Y0tTVmpJTXh0?=
 =?utf-8?B?M0g2aFpnU2MycWlmL3BJSG95My9BWW03ZnVyenMyd2ZWbHUxWXRiNmpUOG42?=
 =?utf-8?B?eHpjUVgySXoyL1BCdFRrbHRQVGVZbk9FcjZ5N0RwMHp6cHcwSVQ0Mkxub2w0?=
 =?utf-8?B?Szh1eUpZN2t3OFdOUkJrUEtDMHZSeFFDem1MbENXYm4rM1VBOXZRelpmdG5i?=
 =?utf-8?B?RGdZS3k3SDlNSy8yZlNMaUVMSHcrTnZ0NnNZai9jUy9QZ0txYVVVak96eHRW?=
 =?utf-8?B?ZFNBajBESTdsdW0xWG5LWTBPc3kxejFSQTFIVkFBMjdFemkyU1kzTis3V0lu?=
 =?utf-8?B?QTM5U0dmNmZxeDdMZzVXRnRYeXVvQVRSaVRzckRRdDlyVDJsVHZtZU5yZDRH?=
 =?utf-8?B?MFV4MWU4THQvVzZaVUphWlNEaUY0QlRJanJqNGNLZnl4SXdkUmRjeml3WFBM?=
 =?utf-8?B?RXc1a0ZFTlNETG9qTDlyQ0lPUXJVUVFwbGc0cWFIM3BJSlVaeGdtSE1Jc1RY?=
 =?utf-8?B?K2tnRnJ5amt6QzU3cVlScGhRNFpsOEE5bThObXFSNEx4c3RTR09BcGtuVmI5?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8d0PE0QEr2TLcdQ0hKWjmBRH+WRvFrVb3CMDU7Aj+dIZbeRhjybDaDA1PrpWoW8hXWvl6k0nzzOcp/AEpwjYqGtypbrZtWmgI6wpIDxcm94b/2I41CXxyRDP1TdEZyM+E4b5aVbTwGD/b6gUpVpjN2s7tvXeFiCYNnczAprIzd6I6yOcYlTLrA5X8ko9EhaVck1Gl4J9VUGHoRh5hVNILbBFlBzx8QcyBRN6Vv0uAqhfPzABjhG+0s6KyCCCuJUZSffLScXz3vk6wQ1bHWocyisIeDFL4LSGsc29LDWU+kQIGx5wy0ckdv7aM8Au/UpCdDDNlbLr69wvfl1VNPEeaI0DZhyDScTYkougVmP48PHeOtC1n9hjavI1cFHKo8Zz0YVK6BNJbF4JThYYTdAxZ2ilhBEzmh00pmbDpkcHOqaY6jCoifTTXaZsDF+dDcS2Ylw1Rg8xhTO9saI+6E5B662kvLpYnWCGFoydLAsxxxLNVbtwRjWUig+tUStj2f0qaT1vN36DU+Na6V5tKkaq0lIsaQLYPVYBLDpjr8VBscyrXH7cHoqfIVwAuiA7YmehYK7t9y8kXiKnJrIOcjQ//7lS2eNPZwGyIIm4fekbbsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a05b8c0-a922-4b1c-01a0-08dc58a370c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:43:37.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppOpbiU8wswxoNt6oBC5EwPdhiUzRWPeF0SLqq14VhIx+aMoY3sK3f+lANVPqTA0kcT69g3BTFRoZABSTCsb4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090096
X-Proofpoint-ORIG-GUID: hlvvSp-mdIcLD2dSFLMGBLgLvR-VjEyA
X-Proofpoint-GUID: hlvvSp-mdIcLD2dSFLMGBLgLvR-VjEyA



Thanks for the comments and opinions. In v3, the patch is back to
the generic group. It is also limited by:

    supported_fs generic
    require_duplicate_fsid

Thanks, Anand

On 3/17/24 01:02, Anand Jain wrote:
> Given that ext4 also allows mounting of a cloned filesystem, the btrfs
> test case btrfs/312, which assesses the functionality of cloned filesystem
> support, can be refactored to be under the shared group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> Move to shared testcase instead of generic.
> Add _require_block_device $TEST_DEV.
> Add _require_duplicated_fsid.
> 
>   common/rc            | 14 +++++++
>   tests/btrfs/312      | 78 --------------------------------------
>   tests/btrfs/312.out  | 19 ----------
>   tests/shared/001     | 89 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/shared/001.out |  4 ++
>   5 files changed, 107 insertions(+), 97 deletions(-)
>   delete mode 100755 tests/btrfs/312
>   delete mode 100644 tests/btrfs/312.out
>   create mode 100755 tests/shared/001
>   create mode 100644 tests/shared/001.out
> 
> diff --git a/common/rc b/common/rc
> index 36cad89cfc5d..2638dfb8e9b3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5408,6 +5408,20 @@ _random_file() {
>   	echo "$basedir/$(ls -U $basedir | shuf -n 1)"
>   }
>   
> +_require_duplicate_fsid()
> +{
> +	case "$FSTYP" in
> +	"btrfs")
> +		_require_btrfs_fs_feature temp_fsid
> +		;;
> +	"ext4")
> +		;;
> +	*)
> +		_notrun "$FSTYP cannot support mounting with duplicate fsid"
> +		;;
> +	esac
> +}
> +
>   init_rc
>   
>   ################################################################################
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> deleted file mode 100755
> index eedcf11a2308..000000000000
> --- a/tests/btrfs/312
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2024 Oracle.  All Rights Reserved.
> -#
> -# FS QA Test 312
> -#
> -# On a clone a device check to see if tempfsid is activated.
> -#
> -. ./common/preamble
> -_begin_fstest auto quick clone tempfsid
> -
> -_cleanup()
> -{
> -	cd /
> -	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
> -	rm -r -f $tmp.*
> -	rm -r -f $mnt1
> -}
> -
> -. ./common/filter.btrfs
> -. ./common/reflink
> -
> -_supported_fs btrfs
> -_require_scratch_dev_pool 2
> -_scratch_dev_pool_get 2
> -_require_btrfs_fs_feature temp_fsid
> -
> -mnt1=$TEST_DIR/$seq/mnt1
> -mkdir -p $mnt1
> -
> -create_cloned_devices()
> -{
> -	local dev1=$1
> -	local dev2=$2
> -
> -	echo -n Creating cloned device...
> -	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
> -
> -	_mount $dev1 $SCRATCH_MNT
> -
> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> -								_filter_xfs_io
> -	$UMOUNT_PROG $SCRATCH_MNT
> -	# device dump of $dev1 to $dev2
> -	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
> -							_fail "dd failed: $?"
> -	echo done
> -}
> -
> -mount_cloned_device()
> -{
> -	echo ---- $FUNCNAME ----
> -	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
> -
> -	echo Mounting original device
> -	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> -	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> -								_filter_xfs_io
> -	check_fsid ${SCRATCH_DEV_NAME[0]}
> -
> -	echo Mounting cloned device
> -	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
> -				_fail "mount failed, tempfsid didn't work"
> -
> -	echo cp reflink must fail
> -	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
> -						_filter_testdir_and_scratch
> -
> -	check_fsid ${SCRATCH_DEV_NAME[1]}
> -}
> -
> -mount_cloned_device
> -
> -_scratch_dev_pool_put
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
> deleted file mode 100644
> index b7de6ce3cc6e..000000000000
> --- a/tests/btrfs/312.out
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -QA output created by 312
> ----- mount_cloned_device ----
> -Creating cloned device...wrote 9000/9000 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -done
> -Mounting original device
> -wrote 9000/9000 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -On disk fsid:		FSID
> -Metadata uuid:		FSID
> -Temp fsid:		FSID
> -Tempfsid status:	0
> -Mounting cloned device
> -cp reflink must fail
> -cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
> -On disk fsid:		FSID
> -Metadata uuid:		FSID
> -Temp fsid:		TEMPFSID
> -Tempfsid status:	1
> diff --git a/tests/shared/001 b/tests/shared/001
> new file mode 100755
> index 000000000000..3f2b85a41099
> --- /dev/null
> +++ b/tests/shared/001
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 001
> +#
> +# Set up a filesystem, create a clone, mount both, and verify if the cp reflink
> +# operation between these two mounts fails.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone volume tempfsid
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +
> +	$UMOUNT_PROG $mnt2 &> /dev/null
> +	rm -r -f $mnt2
> +	_destroy_loop_device $loop_dev2 &> /dev/null
> +	rm -r -f $loop_file2
> +
> +	$UMOUNT_PROG $mnt1 &> /dev/null
> +	rm -r -f $mnt1
> +	_destroy_loop_device $loop_dev1 &> /dev/null
> +	rm -r -f $loop_file1
> +}
> +
> +. ./common/filter
> +. ./common/reflink
> +
> +# Modify as appropriate.
> +_supported_fs btrfs ext4
> +_require_duplicate_fsid
> +_require_cp_reflink
> +_require_test
> +_require_block_device $TEST_DEV
> +_require_loop
> +
> +[[ $FSTYP == "btrfs" ]] && _require_btrfs_fs_feature temp_fsid
> +
> +clone_filesystem()
> +{
> +	local dev1=$1
> +	local dev2=$2
> +
> +	_mkfs_dev $dev1
> +
> +	_mount $dev1 $mnt1
> +	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
> +	$UMOUNT_PROG $mnt1
> +
> +	# device dump of $dev1 to $dev2
> +	dd if=$dev1 of=$dev2 conv=fsync status=none || _fail "dd failed: $?"
> +}
> +
> +mnt1=$TEST_DIR/$seq/mnt1
> +rm -r -f $mnt1
> +mkdir -p $mnt1
> +
> +mnt2=$TEST_DIR/$seq/mnt2
> +rm -r -f $mnt2
> +mkdir -p $mnt2
> +
> +loop_file1="$TEST_DIR/$seq/image1"
> +rm -r -f $loop_file1
> +truncate -s 300m "$loop_file1"
> +loop_dev1=$(_create_loop_device "$loop_file1")
> +
> +loop_file2="$TEST_DIR/$seq/image2"
> +rm -r -f $loop_file2
> +truncate -s 300m "$loop_file2"
> +loop_dev2=$(_create_loop_device "$loop_file2")
> +
> +clone_filesystem ${loop_dev1} ${loop_dev2}
> +
> +# Mounting original device
> +_mount $loop_dev1 $mnt1
> +$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
> +
> +# Mounting cloned device
> +_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
> +
> +# cp reflink across two different filesystems must fail
> +_cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/shared/001.out b/tests/shared/001.out
> new file mode 100644
> index 000000000000..56b697ca3972
> --- /dev/null
> +++ b/tests/shared/001.out
> @@ -0,0 +1,4 @@
> +QA output created by 001
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +cp: failed to clone 'TEST_DIR/001/mnt2/bar' from 'TEST_DIR/001/mnt1/foo': Invalid cross-device link

