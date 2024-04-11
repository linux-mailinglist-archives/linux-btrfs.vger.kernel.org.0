Return-Path: <linux-btrfs+bounces-4135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942E58A0B8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 10:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35041C209C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B701411F3;
	Thu, 11 Apr 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Asm8/UiZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V87U71ZK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6713CF91;
	Thu, 11 Apr 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825102; cv=fail; b=WzSquYLmZgawfJgyvILJYk8/WnolXBTBVoKZXSomYnmRLmP9IfVzTeItmeYE8LDxvFqosGtZu1wy5pb9biBzVAxRjOdIsaar5UkWlilMoNN5nLhdXrM8lveqHYmqcNTWVQ5Sux2NYcgfyiakPyj5g3lz+wq+F19drfIM6kSTcYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825102; c=relaxed/simple;
	bh=qheogy5p9R5aAYOzRZ20gI2XwN1b/eeMFCZJzyu5HoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4B5+kEzmwBzAXWIDlUWhLyvQAdS7hu53iK8SqVIYL0jnzPKx/jPRQApp2+nyOFp4fhsO6fl3LKWNR4JOQms0Gq3W2Swma7oIajIyRe2f9ZONK3+y8YBsiOWIs5s2EA+17n/QqD8KWIYV4ujIjMGkMXz0oYtsstOQ0xGn+a+2Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Asm8/UiZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V87U71ZK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B6EXRO014636;
	Thu, 11 Apr 2024 08:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cE4uTbvuhz1fnGZoHhjqLSbg8Ky+RIFIxcrUzDLW2kI=;
 b=Asm8/UiZLMCiMoIetP7UwSltasLYLRR/PTrCB4pi2l69Y7dj1JaZ7VW5t9l1zgBVKTIQ
 yeQfOJe+9gCLAnQZlA2uNAup1fYDkIzluOcylHhnFAia6EqyAEfn5v04Lgn2evPhvpVl
 tJOLbzJwDGtKqPozeO1BUzaMB26QIb/yvSbRDnAKlFqIM0FDJU3/yEAcegPaqkrc0XG1
 JS8VzKdt81+P8ddfITrdOjuumLue7TNW+hfiZRfbINGMpmFi6ZlnG8QhU1eqRLgZ6Mv9
 x9m6b3WtPl99VkfaGn44gvqN4HIwG5y+khWmHoeh/ciTuly0w9DPZkrTxhWuWJUr9mlO Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacs4sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 08:44:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43B85hCp040007;
	Thu, 11 Apr 2024 08:44:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavufhkg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 08:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6zfOV5Gyqc+MTax2nXUHgfTZGSyjZOBqpSvmNGRMmd9zF/RDOeHmvSflJ8GbqVWZ5fIshzyCHgPvgdiHcS6favi0oaOUa8R8ey5rPjJDgEAg86LKwR31D1DlDaODeSp8HmqYnvqWA3UEJtE4MRaW9p7D51I9OYsmP/FgjvLy2h+NitQkci6jNxXHfGP0VPzYEoeBhwfu1m677GQs/3P4ntnC+SqYcM+YRyl9R5qJg/yVX9JpRr97eJ6v9UdNqou38zM0lMEcn/h26zIPiPuySUGcMPYZc7wV83xT2f08EOFUrtl87VQ34WQFwoTb6MjpTSjsoSxAH0iDp23hbao4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE4uTbvuhz1fnGZoHhjqLSbg8Ky+RIFIxcrUzDLW2kI=;
 b=LytTtOeZMUoLgcZAGXxRrJHZ2r1GA5rzcSFxADWUdtOFWw6HX3UTDtlvWmIjtmzxDEzATzWAWNN1I9hGUHGcx1S/LDT6MxsMtHHvN5lglNflMKcInvwvCyxuiWvLyxTdv2K0S/aEdjSSqgvziNZ0sgL/MdQdR25Xco4lNaw/JjvPAblz6opTHNY5S7VjcLsDEVIy93RGN6mixGA0XORPcWbfXQ+81eN8a55wiKucvM/YS9vSRc9GMWdrsxRqax/Bfe2ckUN2JdOEJmByM38FYg4QIm+0hlN6udt2TTGceT+1oIGSW7dfWs+EqEKfCY917BGGVvMtlZJIEkErQReepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE4uTbvuhz1fnGZoHhjqLSbg8Ky+RIFIxcrUzDLW2kI=;
 b=V87U71ZKMMq/1aZjwrxMw8MbUEDClNvduJCT+bY9r4S/INfF1wCWmYstyA8GuKnwwcJ6BMnPSugQXv6GjWNUITUhg3LO77yKI48CHZ1bjob04B0fqXUUkscKGH13hk6QDjlZU3TCSIxGsweRlD1nmVmeiU0hF5nhuHVvI2SggO8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7538.namprd10.prod.outlook.com (2603:10b6:208:44b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 08:44:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 08:44:50 +0000
Message-ID: <d756b8f2-5f55-4482-9a83-e2ab740e11ed@oracle.com>
Date: Thu, 11 Apr 2024 16:44:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
 <20240409111319.GA3492@twin.jikos.cz>
 <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
 <e9576dfb-c3ce-4adc-bb32-f7efa235907a@suse.com>
 <20240410162635.GN3492@suse.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240410162635.GN3492@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc41475-a53d-499e-36f9-08dc5a03a608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1uokzOpE2sLVhAFrupGNXqaYMEhGNR/lLn1LjNfV2MFPSUN8yUjsI+Dtn0OMoJpzsbPLjhBCicjn13KjK37ua6+8zlCvrg7pnGoRY/l8O3d2LI8BiJf1nJ1LlXhwhTmwY5gGyxzOc57hIjO+e/pxffyNRbVSXbPn9t9XT8ubVHCgGo58fnRgkByDeebhqFNbLXt3oPMtPY76w5BgjlQlrRxcgLgP/uPXC5+mYIm/8BwT6H+9IsdMSjmPJmQ8q9ACu9K5AlZIodLYjaVUamXJ4FbfVBdyqloKrvaxpTV6Po9icYWnHBTa68WY0Eeq+f/0g+IGi1RKwyKqIPVNCy5fyjpRrB3b6mta+/3Y+f6giuosUn/JikwF8K/LP1ZtN9rcVW82LA+5Mf6J8krXKR4OtO881vQrfzgSYGgBEwt/bR3/aLPROHqAQqgEbsuJEc2+wYN8CfWrb7ZODnQ5QLIJaKPUHJhTlM4IJyxrDMnL4BHDiA8FtnjAG1ZR9n5si4g0eVkFBdbCHufavyoW9EgF3onfi2fuRUd2i3WF8e0+52FWu6MlNs0pdCvhJuUOU5ejOqAi8bQADgF9FAl/MGWacTOlCrG1oJIVvTSjjHtjDF1CwO/Oz9RP5vXuJcCIDHLcQVH9jL0RhC9deivAORlzqMSPERC++nWmnuTApze0AIw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0o3RFU5VWxhVVdwTnpKM3J6dEZ2Wm4xMm5PRUxSZFYrei9ZSkpoRktiVTdG?=
 =?utf-8?B?aFE5M1ZhSncxM1hnSUJUbjZaZ01KelMyMk82eEUzZitZWXJUKzZZZlRIOVlx?=
 =?utf-8?B?c0NDVG1pdVl2NEFvd0d0aklISVVuUnhUb1J0a0xhSmxGTll2bFJKbi9yUENu?=
 =?utf-8?B?cXdweGsxbm5MRk5zWnVqZ09QWVZydXA5MExlTG40UzhNTDVRZEVxSVVmVmw4?=
 =?utf-8?B?M3c5MkUwK3ZEZFd0aE1QelAvRENQTSt5Y05NeStFV0g3dzRIdStSdU9OZXJK?=
 =?utf-8?B?YXgvQXB0dFhoVGVEWXJTOUZhekRtY3Y4a1AxcjFteGdabTU4aENjc3lZdmpw?=
 =?utf-8?B?aXV1NDYrYVp4YU1USWFrZ1A2OXZCUm5Xa0hpL1NhWncvOVZ2cis3a3hla1Vs?=
 =?utf-8?B?dHJHZ0lUdjRsVEpZMVo5S09yWlVvTWNSNm1tQmt2QmY1UnVUTmdSbXFzOFF6?=
 =?utf-8?B?N01yRlNZKzZ4YlFXUGhxUTl6Vk9VdC9HMmRYQVhtR0RBZVRwTmZRK0Y0RjdE?=
 =?utf-8?B?YytWZ25jSVBIN0FYUG01ZkZEL28xOU5uZkQ2cFZhQnQ2andReWpLUDNuT21D?=
 =?utf-8?B?QjdSaFdiejRKcVVtcUVINVNCdVpzckFJQ1A0QlMzSzVHLzFaMERPbWtnZSts?=
 =?utf-8?B?MFdLb0ZqcVJCTmxoaDhCdThQYzd5YlZpb3BVWlg5a1BrRVVjMmZXMEJEcFFT?=
 =?utf-8?B?Vm5pQjhxSTVvY01XV0RvUU9MYjBOdWtaU1pyTXJyaWRYN3E5WmY0Z3o3N2JN?=
 =?utf-8?B?Y0F2YlArbHBYWUQydk9tVmpqOVU3N1NLUTFEWHVZUThLQlJwS1pabENqVEFz?=
 =?utf-8?B?aURFNXZac2J2Z1UrejRlRERoaWVrTkhHVGVrQVd0S0d1aXUxanphZGQ2bkk3?=
 =?utf-8?B?dU1UQnlENGpIS1kxTDhyckVQNlRNSjZMcEFNTmkxNjB5WjQ0UXVhdFhEaW9r?=
 =?utf-8?B?T3VZbE5XRUZ4SDhCRG1oSEFaNGZDTzc1ZURRZkgwVE8yQStuNEM3STFXdWJU?=
 =?utf-8?B?dkRnK081OENFWk1CTndXNHhMNEhUdFE2cVpRYVNIWEI0NHRRTExuNHpxWS93?=
 =?utf-8?B?eHVLM0pJNEZFczVVQkM2cG4xZEVGNEs2Nkd4ZnNjb1FOTVlPdk5QelM0ZXMr?=
 =?utf-8?B?c3Myd1QrbnFUMlN0amV4K09FR1N4WUtnc0IrWFlabWwwdnp3K05GYnNxTFlD?=
 =?utf-8?B?emVCM2krODQ3ZHI1a3d0cG1OdnpJeDFHREE5SnFMaVZ0T2s0QXE5MVl1UW4y?=
 =?utf-8?B?NnJIa1lVYlBxc0lYdnoyelcyWUc4RDNDWWJ2OHBHaitVM25ERkV1MGd3UlI2?=
 =?utf-8?B?NkwxSnRUWTRENjYvalVhL1BCQ0I1WWk3b21TdzY2cG5OcWh0UWpXUUtyT29V?=
 =?utf-8?B?UEM2UWdvN1h4UGhFSkNwbGI3WW1WWXRhVUV4VkNRNU04L2hUQk1CTkhGbUpI?=
 =?utf-8?B?OGJ6SittUUswMUFDa3liVG9FTVZiOXZHMjBFaXVoVVVTOVhXV3VIRkdGbUlQ?=
 =?utf-8?B?QWxZV05raTBSVDh1d0w1Z1JWOVZzTDk1eVQ5TG9kVzJJVU1KUU85VFJmc0lW?=
 =?utf-8?B?NFNKOWNEN1ZOYThNVjVhdms5N1JKOFRGaHVoUTJ5TVNVUWE0QWdwejZ3QkU3?=
 =?utf-8?B?VG5WYnpvZmVpaWlLSWhBU0Rxb0hVQTlFUmZCYmF3NzFwSkZMTUhwTjJyTVhN?=
 =?utf-8?B?VEFncEF3bXIxa3RrSW5JWVJQZ3ptUC9MdUlzMlQzOUFsL1EwN3paSW92ZzJN?=
 =?utf-8?B?ZFI1RGppT2VTSjRwSWpXTHFDbnF2MDcxSmhkRDU3c3c3YytoNTdVbjlDV2R4?=
 =?utf-8?B?R01uNVQxbFU5c1Zha1VFMDRTdmJ6aWpUTVp5T09PaG5CTW9qMTluVXcxdnVU?=
 =?utf-8?B?eEJ2SFdNZkFJU3ZYUkVURUdDcUtReC81L1d3c21vdzBTS3ZmcWhnZ2EvKzRN?=
 =?utf-8?B?YWZEWTFwYVlFaDVwVEhCc2t5dE9YZmhhdk1OUE4wWG4yRTVnRHJLc2pZcUFj?=
 =?utf-8?B?Wi9oeVMxbEh3aFFTNzVJcExyVkQzK2JCbktjMGk5c1BBelBtZ2dzQ2N5VFVS?=
 =?utf-8?B?YmRCR0p3cEJxdHQzYktsL3lKVUlhdDlmRTg2Y1dySFBCRm1MN2RUc3lqY1JH?=
 =?utf-8?Q?80FIrc12HeR5FS5uVmBJsGmz3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pErX3k/j77unKGnwiCNOfynsJPERaP92L1i5AcBrmip0+QhVJnysEQ5XiMDE6QHe/bIB88bxl3mJ/NUVpR7FTrobUFAqsr3egZ4tQ1XIiPavzZIK/0HodyrpSfGCF4VE4oO2SYpVLvLMW0fQ62fR6sulARMC8l3BUPmvGV8OAiXzneFVZ50rOhCCQxANRBdTp8n7DpckPFqoOZjxER+By8EvCt+2s+DPiABM3mQEiH3E58g9FKhYo8XR7n8bAe2kcDmX046Ky4SVvL4nc6U9XDBPwXiFWqtERX6Pjz5q1xStzXRkBuNuwG4hR/2rcimU5Uz1kAVkfy3KJzF3YqSuQ/Vz/teJpzf8hm6iO+Wd0NgdWOZqddjA7fqU2AVn9zO+Alk66ahSA/sGGlML8silzlaRSGlzhA3xRqql8yhQf39U/UiTT6BWG68BARDBASTHLXPGqfiKSWFwIWOVjEEK7VvJgR4M0qz8LRphg/r+v/i3q+Y8cl0Qxt8e/airxOIAtoBGbzznPq7ejckDW2tasSBjxoC3M4m3FKvyUraafCZSfQtZGBkzUpcuEz2+PUMlvDgpmo1aE8lpqfqXwIr6NhradB813PQxj9wIiAn8ens=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc41475-a53d-499e-36f9-08dc5a03a608
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:44:49.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YZASfRmVrNqstK9Gcez1580OSU4RrdGl4fZggpxvxlEyonGMI3WYLcsTf2uojr3MY4DhIILdmoUZadIofBBGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110062
X-Proofpoint-GUID: MpdWyKGW-aWabMy9GzYYEFnB484Dor3n
X-Proofpoint-ORIG-GUID: MpdWyKGW-aWabMy9GzYYEFnB484Dor3n



On 4/11/24 00:26, David Sterba wrote:
> On Wed, Apr 10, 2024 at 03:18:49PM +0930, Qu Wenruo wrote:
>>>> What past discussions favored does not seem to satisfy our needs and as
>>>> btrfs-progs are evolving we're hitting random test breakage just because
>>>> some message has changed. The testsuite should verify what matters, ie.
>>>> return code, state of the filesystem etc, not exact command output.
>>>> There's high correlation between output and correctness, yes, but this
>>>> is too fragile.
>>>
>>> Agreed. So, why don't we use `_run_btrfs_util_prog subvolume
>>> snapshot`, which makes it consistent with the rest of the test cases,
>>> and also remove the golden output for this command?
>>
>> For `_run_btrfs_util_prog`, the only thing I do not like is the name itself.
>>
>> I also do not like how fstests always go $BTRFS_UTIL_PROG neither,
>> however I understand it's there to make sure we do not got weird bash
>> function name like "btrfs()" overriding the real "btrfs".
>>
>> If we can make the name shorter like `_btrfs` or something like it, I'm
>> totally fine with that, and would be happy to move to the new interface.
>>
>> In fact, `_run_btrfs_util_prog` is pretty helpful to generate a debug
>> friendly seqres.full, which is another good point.
> 
> I did not realize the _run_btrfs_util_prog helper was there and actually
> the run_check as well. I vaguely remember this from many years ago and
> this somehow landed in btrfs-progs testsuite but fstests was against it.
> Using such helpers sounds like a plan to me (with renames etc).

We can do the renaming part in the separate patch. Qu, are
you sending the revised patch?

I use run command in some of my local test scripts it help debug,
switch on / off the output easily and verifies the success return
code.

     https://github.com/asj/run

Thanks, Anand

