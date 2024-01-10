Return-Path: <linux-btrfs+bounces-1336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B7829178
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED34B211E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73A184E;
	Wed, 10 Jan 2024 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A9uSUd2w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+iHSFfz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1F634
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409MfJij017887;
	Wed, 10 Jan 2024 00:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=S5ZCduJ54pmV1fZzOX1uEGLYXk2Olq4t2PHtXimq0WE=;
 b=A9uSUd2wwXbRJ91ng+UHIeje/zAftIAjCer4lYdHoV6UaiFMdLLU2qnHa9Y4603jeeud
 TFUVZFxmOPxHNJWNIQ1Inapy2XWvqDCoDDzu4lJBhaUiLPpm74k8XJgGTlkvJmOpjoLk
 PticQ/lvCmiXC8SeP1YB+fZeXE+A2TPhnpLE3Z/yn6gkZc7XLdmd5T2v7aA+TEnGDfL3
 ZjCMK3798LrpP4gtO6ppAolEpqZmPwoYi+rm98P/oRF2eJFwe1p5yaYD3PL2L80GbJQx
 xMZhQzWsM2R1ehRslwnaU873hla4fwvoB72iwpz0a/9jF2tfnRCV28vovt58Fjzfq+Fg Tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhf5h03wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 00:36:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40A0C72h013860;
	Wed, 10 Jan 2024 00:36:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfurc6t6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 00:36:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW6kxQb5opP8qyquMy8T6gVBczUuRUITDPt1+8k2nnZFn2RdMPQBdI9raiGpzDWr9L6Ryh4rXwDh7z6DDdbZKOhwLIE+naplXK11NwOgCuOlxekqQFE9eBkw2Pd5O2ZWXd2LDZ2rlRsqnCtY5UwPgyKEIq4mb3oRD3iVveVpYJEjReXrXgxkU6TcnOC+V+MBoNNaurHn5uJ9vADfdWDWJNMGSs1j9im89GIjxBO5cQPl66JQuijUUy1qSllXaR4AkutpuRB3hvB5hBetxsF10AXvvMXycM+eZc+2A15i1Ft0AAMYi3dpyuhnOdqXZ0ApSWUQEy73yBqHJK5CE8IYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5ZCduJ54pmV1fZzOX1uEGLYXk2Olq4t2PHtXimq0WE=;
 b=cOZ7cap5yxSsKG2VoHDqVEIJ271JhTMUPQuxp7ylXggJlGZIGwsowytI9lk25mWc8mCGOb+yXpVPaZ+anuxE7lfikn46lvqyFdoAT8C7l0n41c7HVRPoUeoGKyZBx+QesCp+zFiuLP8L8Mwtbd5+5D66VNCwjamajZX0tEMnb3C/Ir+Fo+Gy/F2xXUxwHalBDxhDnyVhbu3MvI6i4apoY6hSJEexy/0Dkov+/6oDQgbwazCoMkP4xtjwXnlN9/bLVy2XffCYNn0tAQIuh9JnQCX0dasI4uh9kQLi91+8+80Ft3ZXQLv9e7NjmXkvRfVmfWaBvSDCF9P/nTn1JKKWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5ZCduJ54pmV1fZzOX1uEGLYXk2Olq4t2PHtXimq0WE=;
 b=x+iHSFfzqiqWUNWZ9Ve3T5YNT52Lw9glmcNZpVhBk07XQRRAOhAvaPiCau1xEJ4zdwdUDxlzEf9lxlpapxg57wp2j0XciFeNE9QPHBjh2E2eU1s9Nu8M1IG+vxEz27UdLkxH9HqGOadvt67a/SB7CCIkn0L7zfjFzaP5Kl11aQo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:36:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 00:36:16 +0000
Message-ID: <542615e6-fad2-3469-f173-f761e33880a6@oracle.com>
Date: Wed, 10 Jan 2024 06:06:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
 <20240108213325.GI28693@twin.jikos.cz>
 <328e7958-6b77-093a-f3be-bcb07e85e0eb@oracle.com>
 <20240109162359.GK28693@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240109162359.GK28693@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: c2059469-b9ff-4f2d-6fcb-08dc117427d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JGtSYNi9gDXoddRmei0O9oB9uFDvXFHLfbGsSF11Vz5vfkeUxPxz0cmBwZsmO+hYpsGPOXvWyz2SzwSicLMi7YnjIBJ4iGhOdVtsfRH7R8xi3xz2q4uIpk4kwxxZlwrNkms+OEO+XT4OBipEBXljfYrdFkOJQMqegR/zj97DSQkFFr5aW6y9iO+odO5PM4QZT0s/ymDfPvpQzYtvBwf6OcBzHIXtheRVQwGRuxAvgV/7bLtfRRbFjYHrQq5hsLBgNcQUgK1fEAK47auAdC0FRVJ7X91O8lCYKRCf8YdsTTPNRqgNTKn/DtHj2vchRvBIbdcrTndemXnUf7hRObLMxh2jKBpL7Ocq35XykJ/0oKtRq17uiFqhUuPtEBGTq/lxHC8ySN46HIXW0aoxyNCEGSXGJ7yLc6QkAeF0tuBtwC/8tFoQCiznLQ8wgYx1GJHEQaA2cMhl2wmLf2w4d/uOKddOebLbyyx0aytlU3cwf9IrN3HC38ov9ZBsCrKUXwxrjnTs9n3ZMtvp5vcyOcYARmhYBCSYWhlRGTUpx+hdcbHyU9HgVQQZe1+GNKVt9IoB/1dx/jlaaQ1Se1Cg4d+pX8M6vEHN2qrOCbyPr89fHotkXhv2nygxMWlPQVDT+MJi0ba8Bh54c+a1TwTY9oKZCSRuUWamLva6bJEoh9tfCJXoKjHnqDQP3+VuqIfrOTls
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(53546011)(26005)(6506007)(2616005)(38100700002)(6512007)(44832011)(8936002)(4326008)(8676002)(478600001)(5660300002)(2906002)(6486002)(6666004)(6916009)(66476007)(66556008)(66946007)(316002)(41300700001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OU1BUDZFa0FiaUc0MHl6UTBmYUJxZm9hSnBXYjBweHVrZHB1NGphbWtTM0Ez?=
 =?utf-8?B?am5GWlZxd3h6ZldUczZndnZLTFRTNVorTXJXSnZoaXV5aE0vUHlHVlAxNG9z?=
 =?utf-8?B?MkFjNFhseTNNZVIxbE9xejZ3M2lZQldMMHJKZzZvREFhaGxhWmE3d2NKR3Uz?=
 =?utf-8?B?b2ViMHlkSUxHcHZwcmwvWWJiQkkvUzBvNGVhbDBCTzNSYzA3Q2RtUFpuRFA4?=
 =?utf-8?B?L0l6ZjM4NURYU2pQZEdpRW44VlA2UWNCOUZLaldnRDJuVVdrTTc4S1VXSG1q?=
 =?utf-8?B?ODhSMHQwVUE1blpqNzN5UzRTczNuekdCOHZBdWhuaWZuSkwwSkVkTndlUkZB?=
 =?utf-8?B?OE9jWFVDUkJQN2p6bWZnZVVRSzVNWmpDekFtdE5BN1g3VEllNjl2elJmQnpj?=
 =?utf-8?B?Y04xeVBVMU1ROWhBKysrYUlpK3JBTXhsMk8wZzZrMjhLN04yWlBPVmJVRjgw?=
 =?utf-8?B?MDY2a1Joc3NrTzVJVitEZm0zZFBRMFNZZkY0M3MwdGVjbFhQSTZuMnd5RkJH?=
 =?utf-8?B?dUlHOHFtempVYXpUbWkzOUJkTHVody9DVjUzWHVKSmZBRGFSOHhlY3ZhR0Ja?=
 =?utf-8?B?empQQ3hhWE91T2NRUldDSEI3b0xlSjBra3hlU3BXSkhJR0FNdWFKbThpSnVs?=
 =?utf-8?B?WWJJbll5RE9BVzhJL1lYcjRvS0FSNXNyUXVTa2piUkhYU2RrUE1rZzZHTkJN?=
 =?utf-8?B?cFp6cTNDcHhOelgxNW1BV3lVREpzOTFrSzFIYlVQQTdZM3kxL2tnVUk2UUtD?=
 =?utf-8?B?bXdRZCt3UTk0WGc2QzFyMk5YeHdTNktzdVVYZXBTSWplcUtKbmV5L20yb0hW?=
 =?utf-8?B?Z2ZaR0s4QVNVUG1uZXlpcmZ4c29NdHZPTjlESkJVNmhWcVZBZERSalFhM0gv?=
 =?utf-8?B?dnAzRTBMNjZBWHdRaW1CWENvZ2Q5dW1wQjVlOEFaRjlzV3NxbkR6b2ZIRFMw?=
 =?utf-8?B?ZDBSbHdCVjdmVlkvNjdEMU92UXQ1Vy9QcU1UWGdOa050Y1FTaDdWYk92NU52?=
 =?utf-8?B?bUZNL3hYT0lQS0cySDBuVU5PTHVsK1NsamN1UURkd1k2NnQwVkVaT0ZHbFpi?=
 =?utf-8?B?RWFkaVF6QnQyWW5aempuTnRpMExINXVEUm9sRHIrMDZKcFdEajcveExjQTM5?=
 =?utf-8?B?UDNvZzZUVW1zZzN5S2NzdXlnR2dzeDJGRjg1NFZsK1YxTmZ1L2Y3clZMT1kw?=
 =?utf-8?B?aC8zVnJ5MFFKVTdFSVRTK09BdFRBNm1jTnI5dkFZeXJpVmVmNlZFMUR1MXZq?=
 =?utf-8?B?T21GNDluQk1TM2grTGcvY2h3eFlkd2tCYTF3UWliVHdGU0tDdkRWL1V6N1Nq?=
 =?utf-8?B?Sjd1Vi85WVAyczF1YnhIYXdSamtHbC8xbXJzenhjVjJwOFk4Q3V1OU95RnE3?=
 =?utf-8?B?eXZ6UE42bG5mZ0hKQXpTTlV2MHVGT2xpbTEwaUFtcmp0REpCSk9ESVVPRUxG?=
 =?utf-8?B?aDZZSHJmRm1BVGZEcUJEbjJNYURIRXlId0ZybFBwbmYrZkoxUWJTNnpyd2RV?=
 =?utf-8?B?V1dEcmoyRUp5R05tNzlkRGQvckVERGpYWjhXUTBHL21OSW9kQW4vR3VHemYw?=
 =?utf-8?B?OGd2U0dOcWlGbGU5R3ZodHl2RTNOZXZJUTJ1MnJjeFlIWUY4c1l5TnFvZW5r?=
 =?utf-8?B?NlY0Rlo4RUtJWFhDNGg4M0lpL1VFMzNrVVQ4cHczVWtVamhUNzFYd1dtbDdL?=
 =?utf-8?B?cWxQYURGdktiL09NYnl1TEVmdm1maHVMNUhBN3FSRVREeHY5N2lzaGxmNzBR?=
 =?utf-8?B?Rk9LdHRlNEp6NEIxTjNFMWkzVTRiY255YUt4dUFTd0ZuMU04dFlQc3J3aEdr?=
 =?utf-8?B?Q0VjY01XZncySVo5dGFrd2VHQ3dRaFBVdXNKNHpuMERjcmVhY1o3em9sL2dx?=
 =?utf-8?B?SlY0WkE5a0xUY0dtb0orUUtIY3JaWERydGZ3M0k1MzZZaTc4NVpKc0x5RDhy?=
 =?utf-8?B?MlFDVzIwRi9IQ05ubXNRczBZSjNZWEZYR2VNR0k1Z0l4NnJaVUpVOGtiNjVU?=
 =?utf-8?B?UWtTei9hZ3RzckNBWVBKb0V3dTBIOW81eDQ4eVR1TUN6Z3lGTmpiYW0vcTZo?=
 =?utf-8?B?TnFyUGJ5VWc5TXdNeGRZUmxEOXpVUG9XZlIzck55Zkwxc05oWlZjeEthaWEy?=
 =?utf-8?Q?2bIz02lCs0aHbZVYKhe00Erw8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+idVIEf26WgQu21meJQh/qaEOlzwaqcCKbOve89TZPAPggMlN/BlhWo7pcflvziq/iF2qGres5FqBaUqAfjNm0Z/fKrcnhgh9ybuNmVErU1wrjFqNf/tkY3UeNv8AsZTuslWOWQoPAmwz+MHpNVoQo8joK3isVTVXLUNn8IVnMBpsrUch/obrCJ7XIVfn+3zpfbzegG8pVc/Jiljxglw3lL9M/UmYUIGDppD3CUJ697OTBZIZCE0/ZbB+7NmVorWn+demikd50TDXh4XqU7gn1Eo977eQaP89iEP8HRjY59iDrW3XCngjnnYMaH85OwLxEjnBH5HKlLVMA2v9JABCnieB/V2YXQg7BuAt1DMpuljho/FDGosCV+eSeJVufo9mbuN4rD0G0sVCfILlYQm42E8qj4384/ypUg9JeCH3EVHWcEfggTOq9M4swTXpDNjBAL+ZJur+V4kkJHaSGc5+VgeYPcjaB19cG4KnD8Xe6StFETYvntqcfwZG5N94w95h1sbMS/bpKUmydxllDVp2cRAKCYZUS5HMSF64Z6ThpfXnj0eSzIUjQpUYa4SjoqEVtNujFWVqq7deo10CPqsRstEOYJ+uVNZY/dUWR5+2RE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2059469-b9ff-4f2d-6fcb-08dc117427d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:36:16.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBGfkZsR8l9A3/z0TZCQkr69f9SIY/0qZUBB715POxcygqec9N6Z0ufcOjoPdCOljUhOLzVpyvlxfcNZcKsAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_12,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100002
X-Proofpoint-ORIG-GUID: kvEDHjF7o8mtcTCseFNfv4iBHAre1bNG
X-Proofpoint-GUID: kvEDHjF7o8mtcTCseFNfv4iBHAre1bNG



On 09/01/2024 21:53, David Sterba wrote:
> On Tue, Jan 09, 2024 at 09:25:37PM +0800, Anand Jain wrote:
>>
>>
>>
>> On 09/01/2024 05:33, David Sterba wrote:
>>> On Mon, Jan 08, 2024 at 04:31:08PM +0800, Anand Jain wrote:
>>>> For now, to circumvent the build error, create a placeholder file
>>>> named contents.rst.
>>>>
>>>> Sphinx error:
>>>> master file btrfs-progs/Documentation/contents.rst not found
>>>
>>> I don't see that error with sphinx 7.2.6, which version do you use?
>>>
>>
>>     python3-sphinx-3.4.3-7.el9.noarch  -- no issues
>>     python3-sphinx-1.7.6-3.el8.noarch  -- build errors as above.
>>
>>
>>>> make[1]: *** [Makefile:37: man] Error 2
>>>> make: *** [Makefile:502: build-Documentation] Error 2
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>> RFC because the empty contents.rst to fix the error.
>>>
>>> Adding an empty file to silence the error is probably ok but what's the
>>> reason to have it?
>>
>> While contents.rst similar to index.rst with its Table of Contents
>> (TOC) and toctree directives. But, I am not sure yet if we can replace
>> index.rst with contents.rst. And doing it ended up with multiple errors.
>> So, I abandoned the idea, restored to creating an empty file instead.
>> It appears that contents.rst is needed only in older versions like'
>> 1.7.6.
> 
> Ok then, the empty file would be a fix but it leads to this warning on a
> newer version:
> 
> .../contents.rst: WARNING: document isn't included in any toctree
> 
> We could add it conditionally at build time in case the sphinx version
> is old, with something like that:
> 
> .PHONY: contents.rst
> 
> contents.rst:
> 	if "sphinx --version < 3.2.1"; then touch contents.rst; fi

Ah. Thanks let me try.

Also, I am testing it manually using man, is there anything I am missing?

Thanks,
-Anand

