Return-Path: <linux-btrfs+bounces-3105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F082A876672
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B45B20BA2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7415D0;
	Fri,  8 Mar 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R50HSWp0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eg2QXTCe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B75234
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908688; cv=fail; b=oaTWBbScVvtRl50LDb3doDKprxJPNWNLCxdSvMg9lPnDyu9FApPQuUWGYZR9ftlW5Kx/2o1aLgj8IVrIrQbT3cdUUy2QFEDxY6RpvdOb5sM9wFz1KAgU4h5vzSoqjkc4pCp+QMmeN2er1hi+dLSqIES2THJJ3I9kAuXGMB769tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908688; c=relaxed/simple;
	bh=1cNWPzI6hiFRYX2/4XQ0nzfSZNhN/FIsXk9TkXJ0Abo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMTpahjA/aGOv5g2kizarhBL/yLBMoQ3hb8/El0gUs1F1ty+QIvoCRWHaf07JaTuyq9qKpInq8KMpwQz8vo/frPS1nQSxIFLyDx7CcnzxTpSwVlax9bLYEB6ZSVzxHf4cbzygcxKNqCHcL+2h+sQjYK5/J53MRE6OHgylJemrN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R50HSWp0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eg2QXTCe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DT0ji030276;
	Fri, 8 Mar 2024 14:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Zx4sGgtMTs0KmCv/NhdPGPfU0PB2eXIUGmqxdE5NyL4=;
 b=R50HSWp0sq3cl1oDmZEQrb+jhtxhiSy5rl+YeNQvg8pBUFcNG5L7WWIRi1ubMCHkG72q
 YgzR61VZjEdMyhQbM8uJsSkW83FKlp4KdgunPavnF0NgnAybGmBrltn+ShRFumNaN+/3
 0Z3GqMRAZkXovZTJsbKbPUWmH43QrY/l2XdgNzvitfrTQn3AjHahRWHd6KuWujrPE4/s
 IoUI16B00ZD5sukAb8ho7EoLBErWzwHEMkjrbDs3lrHLE4C/5+44AyFXAVZeh18RdyKI
 ewR+gGypndUfD6WNoJwh9pB8Y55Hcicpx9p3B/07Q0KUfRDY0HBfhYaw8vgCD9jLbfuU Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dq6au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 14:37:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428Dnseg013720;
	Fri, 8 Mar 2024 14:37:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcn91t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 14:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfgtRQClI2AunldwFnq1j1/asXQtb+/Ifuloj2+9SrYsGO6QTByR2Gq39c2ca9EOY2tk4/ABP3QRJOJEJJIW2J0KSvzpDrJxIQAfMCBkKHWg9t9UORwjzn5K4/0kjdVvlqkprqvHtHXxrfSIuyUjDvgOZGCW88MqQniY/ptH0Mv0jIED6amNdhjhZm0WK2bLhLjC/ZF1D/+K4PdTXH5T6KaoHkkyn6YUpJq/M+4misBz7BrmToOLIgMZw/1n7KgzSwHaRksY68AMaNZv5G1LKMbSw5PMZ9ZjlMjUA1ab98ziMhoG2gb4bAoTGegwiGWMQ0IgHzTnF2YlVHvm/guLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx4sGgtMTs0KmCv/NhdPGPfU0PB2eXIUGmqxdE5NyL4=;
 b=GKa+/dqYC6eDPUUZAaHmo6om/PLwGP+/TOwTM+ZeY3sekBixH77NeMCw86Tdo0qKYftEyMUXh5/Cl5x9lSJ+C4rncF28rRWiXyqns5Cn1YBmHvm7jid6gpSln52gfgFXSx4jdhydYPGzcokP1asiG4FubsM6RyqstqoO6th8qLHQJHMhLJQmjB/Aq9mKTh4sZZfRJ7lhEvN1mqPpk3eko11hXOf+WJj4DKjRq03RiwLROuj6t4taGJK1+zrRNcEpOnF1baHKr6yqRhzlN2ZRNNTe5MWiNUUTrjRTE9g2wxFm6xTX16ugR0Tdi1a8x7Iy6J1VxXPbMRjAE7Z5DzBhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx4sGgtMTs0KmCv/NhdPGPfU0PB2eXIUGmqxdE5NyL4=;
 b=eg2QXTCe841yL2zZCAU9+5uQx040UqbVVA+kGTENfhf9sknp4vTvCQkjKRN3LxEFCLMXBSp69oscMPOc24GWrG4i7TT/w+1yu58y2tlxa26F8lfyoEjECmz69nooEfHHtefweDKVDPdkUCBvry8xGdHgIDvXeAhVEPzhujHXFEI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7385.namprd10.prod.outlook.com (2603:10b6:208:42f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 14:37:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 14:37:49 +0000
Message-ID: <5f3eec2f-d59f-4a2e-a219-770ce3bd02a6@oracle.com>
Date: Fri, 8 Mar 2024 20:07:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: Alex Romosan <aromosan@gmail.com>
Cc: Filipe Manana <fdmanana@kernel.org>, David Sterba <dsterba@suse.com>,
        CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
 <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
 <CAL3q7H7WpEOBx_66uyzrOH_Lr+Y1j5Gg0gViqGCLQg0vmg9G0A@mail.gmail.com>
 <03bcd60e-33a7-4bc9-b048-8ae8de6ab9aa@oracle.com>
 <CAKLYgeJDQHTWj4U_SBLRK6ssoTJEkn9_EdZXWPgTfkK6s87H1A@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYgeJDQHTWj4U_SBLRK6ssoTJEkn9_EdZXWPgTfkK6s87H1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: e10ba9fa-ea5f-467c-16b5-08dc3f7d53ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rgUSo85Z6qrRpN/Am0EQuWgv94JH0/LAJ87riiI7UyHhoM98eSoKGY6JMNELkq2h/wg0f8Lraz8SgI1TIZqQf3uHl0u16ZmLrpweROj98Dj67ExSTiJ5urVaTOw7Y5KJ1KJjjv4pgSRy1LD8waIfJQD8NruOJhRbcfpuIUDugCkxEM8nQ85fNb5P/UQxGMMLL4z253Ms9MDkOJwLxUIGjC89+gE9KKc91JP8qhY/NnugzdK8RbVKGnmUQAYqjw+ShzXmPBDId/URlEt6HGy1VrspiO7TJj4w0Idc0Q6c2VrXplMq6ETB7J6ZbyatEh8fRfkLqmj57DPajVK41h+0YgEWDv45PxeSiT5aXqIt+Hl7DeDyJxBOPFVXYk/oVg/iK8eHcfDNAgm0Cr9Ivr1PJsvMFvVP+xZ5l3EmJ0T58FC7KAugDwcKjPHcXRiCcxCcMsIFmBrLriV/CNDa7ODekEMToP/yfutEYXu/XYKSY9SaxdSs+itEb5+ArXhZZVrrrAYyga/2zGkwDNJ9bUQWG8iscphWlYKlE9rWtIZ5uUlfdVMZHTfLebMOJH6n8HkL+OXMiHa9J7Qon8953P23gbrPcNS7dGUL1sefRcXH0cGMheqPfDuI10pKvB2z8rC/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmR1Z1dWRk5kcmZaRTgxbjgxbGtQOFhUWE9EZnVKcm0rUWpFdnk3UWMwZ25u?=
 =?utf-8?B?eS9Ha01rMGdZdVBIbmV3RjhxMWp1VGNJZWV3L0p3UHpjS0Q0eURWUHpyNWNM?=
 =?utf-8?B?N1RyUkxsWmdZRERONkFsTUZ3MjNEcTNmekVYNGliNnJYeTFjdnlrUDRuTFVH?=
 =?utf-8?B?TEJiQ0tPSGRIalpuQ0IxcEV0bGo1Z2tpdGZyaGtiVGhVTVJPSC91ZzgraFd4?=
 =?utf-8?B?a1dhb2N0YldkOTZudkVJbGo5VUROWXU0aTJZaG9nQURUbFRDR0tFUlFic0p1?=
 =?utf-8?B?TjBtazFlTzVWMU11S2FxWlRsUlo1S21NZEFldHJyWUZvRzlOcERYcGsvdld2?=
 =?utf-8?B?UFdXSWx2UVM5RDdaazNuYVdxUTNiRW4xcDVLaWhsWWU3UFlRRWoveEJHT1hN?=
 =?utf-8?B?MWlFMk8vT2lUd0k1NURDdzJLL2tzREt4aXZGRE9KQjBjOERPV3ZucTk0U1Qy?=
 =?utf-8?B?dTNabzFuQkt6a0duZTZ6ajNBLzVMRldEM2F4YWlibFVSaDhBSWZyNlhmbERi?=
 =?utf-8?B?SktCVEJiRUtJcWY4eWFlWUp5encxYUtTUUJSMlJsNkdxWnc1V1czWW9QWHow?=
 =?utf-8?B?aVFubTdRNEwyNXlDL2FIdW9oMjFLRTdGMzRmVUFLai9sbzZvaFpmV0UxY2hw?=
 =?utf-8?B?WnZyZDA4ZjZYa3BQVGorVjE3RjZRWEFMWTBsOEhQbDBpR1ovbVI1YVUxR2Nn?=
 =?utf-8?B?dUpLUWI2UDVmYTV2NGNyUmpDSWVuR09JT2Vjd0VVNEtzU0ZKVTdxSnJMNW15?=
 =?utf-8?B?T2E4WXJFUVo2Ylc3b1Bwd2xCUm90TVVvSlFwMWZBdVlseSsrMFlDU3VCSDZ0?=
 =?utf-8?B?dHZqcDJzZTVxSHZ0bU14bTYvSEdLTUZ1NXp5SEMwOHo2cXRsOVFJaytDZStu?=
 =?utf-8?B?UHZRUVhDZzhReHZweUN1RVg2akt2aE5acFM4NUd3OHE2dDVJTEhuSjcrOG0z?=
 =?utf-8?B?bG5udlhWV2pJem8vSCs5L0x5WExWR0dTQ3ZvQitlZkJURk90UGdGMCtwU3l2?=
 =?utf-8?B?enJaZzJRK2VacnN0b2VOWWx5c0dKT3ROYzFCZFJOOEdFUEJ1eHZQZGpQYWI2?=
 =?utf-8?B?Sk9Ia2VlUW51Q2hMODNhcDdnZmdIcVRVOGNRWVQ5OWpIbmRXby80M3BuNHdu?=
 =?utf-8?B?L3JYYWwzcnZING8wOEFBZ2YrZlZrbFBLam1wUlh6dlVOeW1LL2VWQ1RlL29Z?=
 =?utf-8?B?SWd0T20yRFRoVUpla1k1cHlXZkVzcHo1U0x0Q0lHZmlwWU1nb1U5N2lrSC81?=
 =?utf-8?B?R3FmSmhEMDkvbElaYVE5M3FHemUrd2pYQnBqTHhuakpKQWEyZkVBWFhHc2xw?=
 =?utf-8?B?UGhxMFdIQWRkK1BLVGFXdlluMmdjRzlNSWZyTk95L25OY3VwV3p2a25EREZw?=
 =?utf-8?B?RGdZQ2x6T0ZDWGlaSnUvZzFWQk44ZzVSQ3pST2tBOUE2KzM5Wit2Y2RJYTFD?=
 =?utf-8?B?V0kxZ0xJQkpodmVPWkpvTU56anA3V2tSTi9GM2syeDYzZFhmVWUwcVArdEho?=
 =?utf-8?B?MWUweTJlMHI3QVdOdGhlUTBzNThqem9qNTMwSFVDbkdDT05PcENRVXh4N0VX?=
 =?utf-8?B?YVF0a3B0OFlzQkxZdkV5bGpjSWsyTjBkaGR3V1h4RHRsejFLalRRWm9FMnZu?=
 =?utf-8?B?eVVuV1hodHNuenhIT09IUkl1UmY2dHFKeGxScFFXUFZRazdqNkFENHVxS2M5?=
 =?utf-8?B?Q2pTZlV3ZDhSLzhQaThlYnc5VWcvZjVjU0ZTWmxmUVVXcS9vNkttUGQ5Y3BV?=
 =?utf-8?B?K0Q3MFh0Y0JsVnRibU9MSjRSU0h4S3pGSjZCTHk2ZkhTRmcwaWN5aER3RkQw?=
 =?utf-8?B?Yk1BZm5rVE8wam5TUklCRDJCRlR6UHlxcU4wL1hIM285Tm5veDR0OFdJeXVK?=
 =?utf-8?B?RkdWNEQ4RSszV0pkM20yR3RxSXROQnlCdmppL0NKazRqWlUwdVprNFdKM2Rh?=
 =?utf-8?B?eUc0OWV4dWd5aWcyOFZIQVZ6TmxKcXJIVHUzaW9VN1VKMUlSUnpURmhvZFp5?=
 =?utf-8?B?Y1hQa1AzcVNsZkJVY1hibkJtbmovQmNMejMrZHA1TldhSHphczRXMzNXbU1D?=
 =?utf-8?B?Skt1c25jOVZzNExLeHYvTFo0d01GMFZ3U3JqemdkZjlZbXBGVzhPUDhvYlJn?=
 =?utf-8?Q?b6qk98cR1KM3+lIJ04n5LWEhF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EhxL77eDBNWu3j885aNAFjybnbTkjY5nDuNTv9ekUqY75msOd5Ke7hZat/JmVbxwDKRxY/3MJ/hzwMAPzB7jDO/WyzTd+GNltijp1oBVnqrkNlDFH7gkmF3ayoZSSy56BzqypN9iHBEk9Naq82xjGiUxrIYwtnJIJMY8QDXYMT5whU9njbBGktj3wiNxaYzkcakhJaRLeqPIWUKadQuk+d9t2Kr5hYlIVTV5GZ5zUoWw2uC0LHYX9MANOeA1BZ2Kw8CtWkgz9L94gi70YwoUuXslKM0Zod8Y4fj0BYIpUcpJAi77Gh1tApDRRG4Yfk9rAGafEgZYUk+54Eg3IQKjQjqynaGthMvALps6OJTlrN2syN6WKcJdVBzT1Q6vQoV2jJC+ToH0keM4H4qDDHjsxr5EhZ0dN0UfrxdpRe/qKO0GwOvBJLTxn/Hn8989sOX35sH7Zd86YPTg3yPFfQZzPSzIN5DRjk7MmEX0sVSl75gtJS4Yb+/tUd6A6EV1Zm8UHLnrHCNTqZwdbto2QKlXM021K+pq6+749eBDNfzlAMn+Jqcy0WXdwZF0T2FoMQKfTKvIG4sXFzY1mh0JXhmHaKH7e2gZYqsR/JC/Ztl4F3A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ba9fa-ea5f-467c-16b5-08dc3f7d53ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:37:49.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtgcUfKHUksd+BdLMONxN+HRbrD6lxsY2P6ej4cRH8oRAMc7MMnUKlss//AFd1qHPtqAE2d4nIBiAfIsEMk8jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080117
X-Proofpoint-GUID: 1hAQkMRR7zA0_0ITyxkqtcAEn_9GrTtQ
X-Proofpoint-ORIG-GUID: 1hAQkMRR7zA0_0ITyxkqtcAEn_9GrTtQ


Sure.
Here is the link to the latest version of the patch, which is v4.
It is based on the mainline master.

https://patchwork.kernel.org/project/linux-btrfs/patch/65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com/

Thanks, Anand

On 3/8/24 20:02, Alex Romosan wrote:
> sorry about the previous html mail.
> 
> Just to eliminate any confusion, can you please provide either a link
> to v4 of the patch or include it in the reply to this and explicitly
> labeled as such? I am beginning to have doubts as to the version I was
> testing. Thanks
> 
> On Fri, Mar 8, 2024 at 2:52 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>>
>> On 3/8/24 17:45, Filipe Manana wrote:
>>> On Fri, Mar 8, 2024 at 2:28 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> Filipe,
>>>>
>>>> We've received confirmation from the user that the original update-grub
>>>> issue has been fixed. Additionally, your reported issue using
>>>> './check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.
>>>>
>>>> However, reproducing the bug has been inconsistent on my systems.
>>>> If you could try checking that as well, it would be appreciated.
>>>
>>> Sure, but I'm lost as to what I should test.
>>> There are several patches, and multiple versions, in the mailing list.
>>>
>>> What should be tested on top of the for-next branch?
>>
>> v4 is the latest version of this patch, which is based on the mainline
>> master. As you reported that you were able to make btrfs/159 fail with
>> this patch at v2, v4 of this patch theoretically fixes the bug you
>> reported. So, I wanted to know if you are still able to reproduce
>> the bug with v4?
>>
>> Test case:
>> ./check btrfs/14[6-9] btrfs/15[8-9]
>>
>> Thanks.
>>
>>>
>>> Thanks.
>>>
>>>>
>>>> David,
>>>>
>>>> If everything is good with v4, would you like v5 with the RFC
>>>> removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
>>>> it could be done during integration? I'm fine either way.
>>>>
>>>> Thanks,
>>>> Anand
>>>>
>>>> On 3/7/24 16:38, Anand Jain wrote:
>>>>> There are reports that since version 6.7 update-grub fails to find the
>>>>> device of the root on systems without initrd and on a single device.
>>>>>
>>>>> This looks like the device name changed in the output of
>>>>> /proc/self/mountinfo:
>>>>>
>>>>> 6.5-rc5 working
>>>>>
>>>>>      18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
>>>>>
>>>>> 6.7 not working:
>>>>>
>>>>>      17 1 0:15 / / rw,noatime - btrfs /dev/root ...
>>>>>
>>>>> and "update-grub" shows this error:
>>>>>
>>>>>      /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
>>>>>
>>>>> This looks like it's related to the device name, but grub-probe
>>>>> recognizes the "/dev/root" path and tries to find the underlying device.
>>>>> However there's a special case for some filesystems, for btrfs in
>>>>> particular.
>>>>>
>>>>> The generic root device detection heuristic is not done and it all
>>>>> relies on reading the device infos by a btrfs specific ioctl. This ioctl
>>>>> returns the device name as it was saved at the time of device scan (in
>>>>> this case it's /dev/root).
>>>>>
>>>>> The change in 6.7 for temp_fsid to allow several single device
>>>>> filesystem to exist with the same fsid (and transparently generate a new
>>>>> UUID at mount time) was to skip caching/registering such devices.
>>>>>
>>>>> This also skipped mounted device. One step of scanning is to check if
>>>>> the device name hasn't changed, and if yes then update the cached value.
>>>>>
>>>>> This broke the grub-probe as it always read the device /dev/root and
>>>>> couldn't find it in the system. A temporary workaround is to create a
>>>>> symlink but this does not survive reboot.
>>>>>
>>>>> The right fix is to allow updating the device path of a mounted
>>>>> filesystem even if this is a single device one.
>>>>>
>>>>> In the fix, check if the device's major:minor number matches with the
>>>>> cached device. If they do, then we can allow the scan to happen so that
>>>>> device_list_add() can take care of updating the device path. The file
>>>>> descriptor remains unchanged.
>>>>>
>>>>> This does not affect the temp_fsid feature, the UUID of the mounted
>>>>> filesystem remains the same and the matching is based on device major:minor
>>>>> which is unique per mounted filesystem.
>>>>>
>>>>> This covers the path when the device (that exists for all mounted
>>>>> devices) name changes, updating /dev/root to /dev/sdx. Any other single
>>>>> device with filesystem and is not mounted is still skipped.
>>>>>
>>>>> Note that if a system is booted and initial mount is done on the
>>>>> /dev/root device, this will be the cached name of the device. Only after
>>>>> the command "btrfs device scan" it will change as it triggers the
>>>>> rename.
>>>>>
>>>>> The fix was verified by users whose systems were affected.
>>>>>
>>>>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
>>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
>>>>> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
>>>>> Tested-by: Alex Romosan <aromosan@gmail.com>
>>>>> Tested-by: CHECK_1234543212345@protonmail.com
>>>>> Reviewed-by: David Sterba <dsterba@suse.com>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>> v4:
>>>>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
>>>>> I need this patch verified by the bug filer.
>>>>> Use devt from bdev->bd_dev
>>>>> Rebased on mainline kernel.org master branch
>>>>>
>>>>> v3:
>>>>> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
>>>>>
>>>>>     fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
>>>>>     1 file changed, 47 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index d67785be2c77..75bfef1b973b 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
>>>>>         return ret;
>>>>>     }
>>>>>
>>>>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>>>>> +                                 const char *path, dev_t devt,
>>>>> +                                 bool mount_arg_dev)
>>>>> +{
>>>>> +     struct btrfs_fs_devices *fs_devices;
>>>>> +
>>>>> +     /*
>>>>> +      * Do not skip device registration for mounted devices with matching
>>>>> +      * maj:min but different paths. Booting without initrd relies on
>>>>> +      * /dev/root initially, later replaced with the actual root device.
>>>>> +      * A successful scan ensures update-grub selects the correct device.
>>>>> +      */
>>>>> +     list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>>>> +             struct btrfs_device *device;
>>>>> +
>>>>> +             mutex_lock(&fs_devices->device_list_mutex);
>>>>> +
>>>>> +             if (!fs_devices->opened) {
>>>>> +                     mutex_unlock(&fs_devices->device_list_mutex);
>>>>> +                     continue;
>>>>> +             }
>>>>> +
>>>>> +             list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>>>> +                     if ((device->devt == devt) &&
>>>>> +                         strcmp(device->name->str, path)) {
>>>>> +                             mutex_unlock(&fs_devices->device_list_mutex);
>>>>> +
>>>>> +                             /* Do not skip registration */
>>>>> +                             return false;
>>>>> +                     }
>>>>> +             }
>>>>> +             mutex_unlock(&fs_devices->device_list_mutex);
>>>>> +     }
>>>>> +
>>>>> +     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>>>> +         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>>>>> +             return true;
>>>>> +
>>>>> +     return false;
>>>>> +}
>>>>> +
>>>>>     /*
>>>>>      * Look for a btrfs signature on a device. This may be called out of the mount path
>>>>>      * and we are not allowed to call set_blocksize during the scan. The superblock
>>>>> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>>>                 goto error_bdev_put;
>>>>>         }
>>>>>
>>>>> -     if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>>>>> -         !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>>>>> -             dev_t devt;
>>>>> +     if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
>>>>> +                                 mount_arg_dev)) {
>>>>> +             pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
>>>>> +                       path, MAJOR(bdev_handle->bdev->bd_dev),
>>>>> +                       MINOR(bdev_handle->bdev->bd_dev));
>>>>>
>>>>> -             ret = lookup_bdev(path, &devt);
>>>>> -             if (ret)
>>>>> -                     btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>>>> -                                path, ret);
>>>>> -             else
>>>>> -                     btrfs_free_stale_devices(devt, NULL);
>>>>> +             btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
>>>>>
>>>>> -             pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>>>>>                 device = NULL;
>>>>>                 goto free_disk_super;
>>>>>         }
>>>>

