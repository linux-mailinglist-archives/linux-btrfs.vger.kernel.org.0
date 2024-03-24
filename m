Return-Path: <linux-btrfs+bounces-3522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E2887D35
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202E81C209DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D40182AE;
	Sun, 24 Mar 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cjD/q9RM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H7XqR3Ib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2E17C7F;
	Sun, 24 Mar 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711290360; cv=fail; b=WCBkktKtde99wueW4IGBk9L9GaJ+bO1fKviINDBXJSeEflqkBxT7eDIvWHPaYZku0c7lmygPBeULpwoev9ZsCnJuxM0NFKTw7N2/wwxT2OpBJLlODWLHXEg7QT+CAhdrPGuDuqf81dbXWj8j6UAJBltOesMDn4TsnrNKokV4fws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711290360; c=relaxed/simple;
	bh=J0qkKNu5/uUgYvbiTUv4tEhRuIVtXOronw672C6r+yk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MrJM5oYBTCYTYxsYHD5rgDNZDbwBywwy77B5Jj6p9Q70guXbHVkeG7Xb1cDfTiSY0qQs5Zr0nd0unRk7ejNnYo8Yw7pMPDO2beeabpX2CqexD6E3jeK+/MZq8Pc1M8RJMELcBwL2+rvIan4V0umnetYmFpXFswQW9GAmQisk4Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cjD/q9RM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H7XqR3Ib; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ODtlqd003701;
	Sun, 24 Mar 2024 14:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U1kZ0RrhF/BHjvIxb7bzFSAvYpYpMp4WTElCZRY6onQ=;
 b=cjD/q9RMpH8TdCEe3chpu2wLmaBiYjhNXROVFGOkxUiLcgbTVAj6NmK/jhUGB1IvzK3W
 FmBPhp6DJyu8rp8WD3HL+DsEKBaXfK1SWlZc+QWkEd5pAVZM6Cy1QIMA6Ku9jYjbKOPs
 0Kn9ptKgIxb/RxcEO5u/tW5oTxid9QFw6q1CZq+sQccAZlJxw0ZY87BMRpChyTNYDc8T
 Zq21pdJt0RTIb8R3UMSFv8k6KYJInP1dWp0iftpemZ0WzQuBwCT6yDAD2psVc/ZwW3Rp
 LQ8FPobl0ddS30xWcKxIdpi0DRq4R0iBzqSVuk2HFCjasyN5Y2fyd4WYiKMsY2JXlDOr gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4dsa49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 14:25:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42OBohOr033393;
	Sun, 24 Mar 2024 14:25:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhatbmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 14:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpqED2ur/vYRyMi/FK4gKHHUmfcH51Yf0q5l+dEXFLtqCf7haG31eF6XfwUPqTd0ZGSs1fZV6/gNdTJ6iC7h4kvm6P+PB0Yh5minzn+IRtikCXSTxzTbgHbFrQ5pbuhab0BFa/c7YMn+eTBnNnOFCpOj4amN3kfjlv1xw8t+2m1ByidHQR5kJqctM9cOJmncdrOP40+PnI7lOnlSJnWs+IzS2tM1PmYAj43p/QNj+hHif2qGsXJrRNwvzxmN6sphW7cHXFy6XcbPH8YG7cEdSQK7j6pShT67G49ha0SwJncW0uQC88Vw1hXpRmG6k+xIaWv0W+KRDv2tb72j7Ss0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1kZ0RrhF/BHjvIxb7bzFSAvYpYpMp4WTElCZRY6onQ=;
 b=WQHbT50Q/DKrVjqmATGFsK0s2qYkYOww0GGZ012vqGiV7M67NDMn7ZunaX9yMHrnBaj+tIta86URrtSxMCjaWSF4xbmjCT4GCdYSZCAYwc5J6Stc6Y4pnQwT1SRdeWHopgMNntDh40O/BW55IFAHe2zeGUWChfysOVLdaHRlM14s7ZE9Zd4zHzFbnwDGaxJ+iqc7+k2+jSawP9t/U/JP3P9bzmj2VWDG+kATv+K7fEuzPj8YqTJhwyNo8f7ASlbeYQzLEOj8xhB/EbYXBBLY9s7DJLBMKVnFkR/+qKUku5SCclf480xyylb3zdu/22fPSgHkUh5xDc2ToPOYNOe6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1kZ0RrhF/BHjvIxb7bzFSAvYpYpMp4WTElCZRY6onQ=;
 b=H7XqR3IbwTBfoFIEXYikQV7c77IgwQU0lHf4rwbtTuc5Whf95TRb5xewUlohItcoAdSVQPtgQmmhsK2XXawQYCkWYEVKGbUlGUzmhsUT2vscD9W6nj5v3lRouFvHO2PUeU3EU5LvOK9kT603AMwvXOWBGEvuWTv547UbIjsky6I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7757.namprd10.prod.outlook.com (2603:10b6:a03:57b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 14:25:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 14:25:53 +0000
Message-ID: <f0cff090-9765-4822-a171-130de446de2d@oracle.com>
Date: Sun, 24 Mar 2024 19:55:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fstests: btrfs/195: skip raid setups not in the
 profile configs
To: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1710867187.git.josef@toxicpanda.com>
 <c19995ea42066da0eae381b499475c81679c8f0e.1710867187.git.josef@toxicpanda.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c19995ea42066da0eae381b499475c81679c8f0e.1710867187.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: cd43dff1-171c-4b60-0efb-08dc4c0e4f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	scUp1Fvatlq6de8c9FIsohghoukAIxgaEfVoiXiLzALz5PNcqctKRZdoQxKyATOu9xC6l4qxNSgOpJr8VKrvCpXDeLMNJMITna5YZxL8Wr/PDnnJVOmH2IqjuIw3kAZM1eE2QArihhPvViG/rXFRlACL7Bch/w8SKMX3XVHTD0sIi4iMLc5WYr79Io6UjxVp+twZjoL/A6aXquojbltS/1CiVptBUb/yDrmb7/tvwdRbBKyWpGrc74BnQrHOLUuMZ2N30aHiUf+YSTroQxDdEeYZCLtMfbLaPnNRl6MOXDrwW74FMBT9f30J3dul8Op4co2NkZOWpE5QYfk3cK9UAz6dy2vjHdN1AsxVWagesLA220/9wu7ouZr6LWemFrPLDP5u+YO2x3/YQx6bc+vuB/CCfVVWB7u82JhDoocshpEhTmzOV2cAAyvTH7VK8tK8m1Kg0ILNHCO644izjnOQxJAbQBg9Z+uGsVkd8LE7IIJL3/UTqp/ua0SUXyw5ohPxfAneOmlplXNN4TYzKEuNi/wdvkq+kQzIS++aUeWa38kywqz6zxbX2lIotU4D4l/4jUNs7A813LN0Z92zXHdPDb57HQbxmyPxE/BHf2nIqLDZDJU/5vTnV52ZcRL1qmrMiTXfMPUFZc2UezSk4Q861PlZ2Bp211ywe/oM3kyuh8c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WmdzdG1iQXdzMUtVVW1GU2g4bXB0NFZleGhxTlpaNSt2M3YzdFlpY1ZWOXFn?=
 =?utf-8?B?aTJaNTljd2hBa09hVTdYblY4OU5NaEZZKzRHVjNqYm5mZklIbWNzSlVDOU5F?=
 =?utf-8?B?cVlZYmZOakNGWlBWaHZQZXgrWVArcThqMjlRWXBCYmRvL2NpRitRUElDeXJZ?=
 =?utf-8?B?T2NtbWh2R3c5ZkdwaGdTZ1duZzZyVFdtblJWdUd3aldjalRDajVnLzNKU1do?=
 =?utf-8?B?Uk5lUEwwRXQ5V294SjJjK0UxRk9GTDU3blVQeDdhSFYzeHJIQUM3VVFhb21X?=
 =?utf-8?B?MGY1TDUwV1lyNGZOb1VFWGJRUzV1bG5RdGFYenpqTS9PdVQ2SnBSQ3hYcmNZ?=
 =?utf-8?B?L0lCYXI0UWNGaEhzK3gzV2xaMHhFMmd2Wko1Z2txLzZ2YWZ0QmpWbUQ0K2p2?=
 =?utf-8?B?bExhWFhXNEJjWXZqTXVFWXlXZXNlWVF4SG1GbkFCUWFQSlVyU2Z0anlpUkt2?=
 =?utf-8?B?Ulp5NllBSlBiTmsweWlJT0F4WjlNVHJWdEFwOVVPaUZobVBOV0FBdUhlNkFR?=
 =?utf-8?B?TkpjbnZLZThLeUVHTlRUaTkvVHZrN29ubUpoNWJCNnlRREd5L1VrbDIrQi9R?=
 =?utf-8?B?bEFQVUliUlArNURhYS82RC9TVFRsY2dDRXc5M0RWREQ0S2paZVcyVnJISjlV?=
 =?utf-8?B?QWk4MEZzVDc3OGRkQ253dHU3WHQzU1p0UGxzV2NWc3ltK1dVaXphUDIyUkh4?=
 =?utf-8?B?aWJXVjhaVVhWYkp4Y01uMGJ1YVpGeXBHSFRTQ2J3TGYvV0hENG9OVEoyNVg3?=
 =?utf-8?B?T3NkRGJYaVFzVFhzaHluQmxqZHRseS9JMVJXRml5L1VQQWx3ejFZMHk3YUZF?=
 =?utf-8?B?YVphd0FWWmtPWEtkaFovaE5BQ1JPcU96bWRPWDJoQXFJVlV0ZnZ5cWRLVUR0?=
 =?utf-8?B?ZW52bGVwYnp0T2psaWdDRGlhVXAvRUxDSDF1TW9WQlRPWVBHSXRqMFFOWEt0?=
 =?utf-8?B?VTJKdmN4MzUzRzJ2VjhzbjZQRlZyWnhkQ1Fmb09XS2tXbGpKVm5iK0QwcFBZ?=
 =?utf-8?B?K1JNai9wM3VGMGlsNEJpRy9ROHVmOGZmbDJlM3dSWC94REY5a1BUVlFGd0Mr?=
 =?utf-8?B?TVNBOUZaK1czRVNubWpldld6M21vdWNqWmg3WElSRHNVazlPOXpLSkpFMWxv?=
 =?utf-8?B?Yktpb3BEUzdXUDM2aXlwdTF6Vjk2bjRkcG1tVEcrSW1XYzRFM0taaUc3cm91?=
 =?utf-8?B?N1RyeE9VemlhcnZqbVpCVkthaCtaM0tGZEkzMnVscTRBUVlqbFJzbk51M0Zz?=
 =?utf-8?B?KzcyZERqTS9KVXBBMjl2ak9qZHR2K0wza2VJWlBnd2R2bVd6YW5Pdk1KSEUx?=
 =?utf-8?B?OGdpNnFyY05yL2xxUXlEYlVldmphTVdib0lmSVZCNjJOMVJqM2NXVG5reTBa?=
 =?utf-8?B?US9EbnRtVjNjakpiTHdka1N3Q0NqVjhlZkg4ZkpiMjJCQWdpdVhlbjhjUUxR?=
 =?utf-8?B?VytHVFBSeGxDcldIOGpFY2ZBaFhLUVd4aElJLzVmcVFRaS94YkljZ3pGck1T?=
 =?utf-8?B?bEVaMmpOL3BMUnZZMTNXK1NUdStDWkRzOHcweEx3Vk5zTE5XKzNJek1SZVJ4?=
 =?utf-8?B?Tm8zZHF2bVlFZGwrbXpqSGVhTnJlSXZkVjQ5UFBWUS80Yk91WmNvNnZQYjlW?=
 =?utf-8?B?RDZKemhpOUtJZlB2TWhKZnlLRlc3Z2IyTnV6RnJTbFlFWUhON0hQcHdCOVVu?=
 =?utf-8?B?SzdZd2hVb3RTRjIreTJtZ3NuOThCS1FFUTNxYmxMenpKaDgwclRHVlV0TUh1?=
 =?utf-8?B?WG9TY09NUUI5V2hqSjlXbEFxT2w2U0NGdDN4b3M2ZVg4SllrcUxzMnFNcWxC?=
 =?utf-8?B?MG9IN0ppblluUFRFdXAzUWFBajY0MkN2UjhKVytwakFPSUdFMEY5K1hTVUVK?=
 =?utf-8?B?RG9kZUNWTjMzbGF5Z2NPaTIwZHJ3ZEtpVVpnTGE3enFYL21Cc1FYbTh1dUUw?=
 =?utf-8?B?V1pCZU51Wkxqc2FCbjVsZDAvUFJpR1k0R0VZU0VDdEtCSXVyUjY2bjJNUEtQ?=
 =?utf-8?B?dmxkQTM3NEtuMXRzaGdUTDR6cHdzcWxFeTlkN0ZKbkN1SHIxWmIzK2gvWHNT?=
 =?utf-8?B?RTZZMFBodVBCSFhDdGpNN2lGTklvK1lmUzJKUWZKVDJJZHV1cHYxUFdWb2Zh?=
 =?utf-8?B?ZnVKNTdnaU9FMlJUN0RDVGlwOFpnTzFaek15cGsrbVhPSmVHdVEyVm9tTERL?=
 =?utf-8?Q?Bj3c7TYGi2vmkeI/ZYLxX4qli0vZbRLwVtkeGmlTGLfi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8cHrZpYPNFX/5iltnCEG/WMUhwII338qhD1G3EJDlIXOwURvmr8I1r99JkuMKOC+w2AOeZWAhKBpZrGN1YtdAbN9nBpfkjv1xLGpgMvzIldRcC4ao+aKgrAiEldu2fAlTrGM4P+3UDJM4KqtZ8M7/TAas2bLNYUwoL1hPMf5PRziSGh2ymU9Tq5J9CwIUN625efjW/ao5QK/SShG06MN28QIMaDtufL7VqIc8HoIgSaFBNy2kTgmD18scVgwqo8jYPJbE/MMR4s6vPSlSzCVQ+I0+jCnw+M3dHYYZz/goJkR3r+zU2bQ2VKhFzOwepXy/2pamK55Wf/P3PgGE3wyb1Js/LPZocEdW50EiTBXhKqfJkb50hlK11C0w/fl9hHnkN2z8z6vajBjj+EnCYlE4rlvQl+1+78D84rpcmGK5FrczAIFPkRi42b7yzrAJV0CyA9FQN/rGI8kDfJMEvFv3YLjS9dfhFKZwya8xbJzODTsXLuGsVSqW16lbpF7nTjSia4agPsmX1oDF2wp6ASP5bFH30fljB2d4SMUMka4OkXFcCVoTkeh3istqMb5ShPBQkwR7yPXDDU55SF3gA10SEUyesEyQIh0gFHU9R4ByDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd43dff1-171c-4b60-0efb-08dc4c0e4f91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 14:25:53.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imzdvFHmNowCpSPTLrSL3f1SjvWur1SvtGXYLLM0HKeDo6XPkY2WkTq5t1Ks7JCtDTM1lJ3LRNuJZpqEu8Oe3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-24_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403240091
X-Proofpoint-ORIG-GUID: VovyLA_jNkpG6G13E4tirIBLZE1QsNQr
X-Proofpoint-GUID: VovyLA_jNkpG6G13E4tirIBLZE1QsNQr

On 3/19/24 22:25, Josef Bacik wrote:
> You can specify a custom BTRFS_PROFILE_CONFIGS to skip certain raid
> configurations in the tests, however btrfs/195 doesn't honor this
> currently.  Fix this up by getting the profile configs and skipping any
> configurations that are not listed in BTRFS_PROFILE_CONFIGS.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

This doesn't use _require_btrfs_fs_feature raid56,
so applied. Included for the PR.

Thanks, Anand

> ---
>   tests/btrfs/195 | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tests/btrfs/195 b/tests/btrfs/195
> index 96cc4134..df8f5ed6 100755
> --- a/tests/btrfs/195
> +++ b/tests/btrfs/195
> @@ -21,6 +21,9 @@ _require_scratch_dev_pool 4
>   # Zoned btrfs only supports SINGLE profile
>   _require_non_zoned_device "${SCRATCH_DEV}"
>   
> +# Load up the available configs
> +_btrfs_get_profile_configs
> +
>   declare -a TEST_VECTORS=(
>   # $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
>   "4:single:raid1"
> @@ -38,6 +41,11 @@ run_testcase() {
>   	src_type=${args[1]}
>   	dst_type=${args[2]}
>   
> +	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
> +		echo "=== Skipping test: $1 ===" >> $seqres.full
> +		return
> +	fi
> +
>   	_scratch_dev_pool_get $num_disks
>   
>   	echo "=== Running test: $1 ===" >> $seqres.full


