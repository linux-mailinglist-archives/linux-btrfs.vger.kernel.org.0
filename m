Return-Path: <linux-btrfs+bounces-221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC237F252B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 06:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6163728288C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 05:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21B18650;
	Tue, 21 Nov 2023 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zhIoikDW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wG7z2mk7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D20DF9
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 21:18:38 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL44OFe021770;
	Tue, 21 Nov 2023 05:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SW1ZzOlr2u1PBVPW5+sFwPZuV1Nluv8mQvd6IrqMxUo=;
 b=zhIoikDWXqJmJF0FFDUbzWEXwbt2Q3S5f5qv3/zYXE8rs95yNeqzzrFnICsHkbPJkCs0
 TRuDMAlr7HMLHHbdJVVfg/qGpKDGj9+4lb5S0o8DW/J4oTxEbu7vBJ1p1mJU4I0Omtep
 JG5KDf5huHY1qhTm/CCMYkS+9ujJWPLKAWc0smGao7xT0ZfpN9WdnUAt54iNuZTLt8jN
 kLRWtq/KNO16N3lPkEFVkdW10sfQX6v+pHpZvLUBcex4xxy78uw/1ifZLuPCLKaoxKcW
 /FLQyV10BYPN2v0MRnQphIK9RryomlZ1wNxDXU4lhwIhH7USpfdbtN5YIpnyeKUYNs7U Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2v79x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 05:18:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL2Uo8Y037648;
	Tue, 21 Nov 2023 05:18:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6cqga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 05:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hayqwfeGUXPN1XBcG9Zd0nkgirv2S2jbzSuv8oDYpWOUCHKzgFWeV+LWwf0m+Od/rFNX9KtQ1nZBmdvb/Jl1dHZODha0S9cz8Y1TRcXdfLZec370b9dB/Dqu1iJD9bAnwGL2l8zaW+Kcp3VJ2VHC9tP9IO/lKwiUSwO7j5ILTCKrHKAbh6jJV8U5Mx202InSHnhi0CeCXzp3Yx6pXcdsuJyIuV/FRnQqfmHvOm8FyqNa7zwUW+W/qtxLKA4xfmQUinfHdeX2ReCoY2jbdvu5cpkPi+wCwGVvk54GgfPi+9/3Ps3ISMXcCSkkUgAIj2ReemPZ3IrtwFL1AMyiCsy6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW1ZzOlr2u1PBVPW5+sFwPZuV1Nluv8mQvd6IrqMxUo=;
 b=AecXcoSOufo5FdJLkPCNbv3KhiBb9Sjr8W2LdGHV6NxITGi7yvMMo14lPawgMkuIIsx9PlZyLjroIzwnRizShSyXsosIDRUo/jS9W+paY5tMnMrLwAYzfsGOv2HSFdOwprsdHkOGVSY2adGdsWKcYxzcP2V3shQDOOin1ibBkaC/UJLmxumgKDkd9yDNI05AiyesXi1fCiEM3Ov9QxAFbSWArcFavVfEEHb8PEhGgb85xWUMXjb1wJ9rmIUbvDEUPZOvPbTMFR3YB23rxhdnhPs3TGQ69R9WMLJ6Jpfki+r7pCYhJtmDMCFbkiRHiH2JYLia2cMH24/7Ag4nbvdJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW1ZzOlr2u1PBVPW5+sFwPZuV1Nluv8mQvd6IrqMxUo=;
 b=wG7z2mk70R4HCkr5sxt/zLE2t2Mnr5HxcS4ZsgTFrmFFNuMjPeXxi6eOjof2zQldhk+xi0X1/jkJQa9yhm9ra5IDZo9U26nXkB1wsy+iYkw6anZwCvvEOiRStLeLxoY3T1MDPBuy0YW6AzVgLqpFrSOoM5zFVi6MFz1WSOfL+Bs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6646.namprd10.prod.outlook.com (2603:10b6:510:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Tue, 21 Nov
 2023 05:18:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 05:18:30 +0000
Message-ID: <794136af-bb59-42f4-a5b2-8c760c4abd88@oracle.com>
Date: Tue, 21 Nov 2023 13:18:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 1465046e-e552-41c3-8166-08dbea514c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PmltLupMsg/vjLDbPCd7B6Hgl9Y++uDfWB1fxu4p1Km4jLGdABRo+AK3ovSDQ+Koop3jcK79p64z8+4qkGqxoUgAV/ERA94NY5tCDMSjG2PZKn23b/AY+A2o9ORvbImymmKeft7J7EqH66jgtkqNDv+R0dGKyjPcx2RkYIMVP4bvUPf/8S+aF0aLQTr0Thjf1HTl5gMePz4CyOhfl4KfBtZgKxonKITndPg7ys1X+Ivcb5DvHix/Nzz+Z12VPV04Aqtsy8bNMKfL1SOGQXcBJs6/rQxbtlEQPashsmof2TSdkhba/tKt7Zk8dfQPVGUtiZbljclzMpecQpEtrk12eblaLKFInfq7wW0p3HYmuBDhxXSXIoo0s3kTA3+zvbTVZaHlIH043+M5r0ss0KqdbqLuvfEYNfgZw+Kf5CZHxwod6q/ZeWObcXUJif0SxYyFsQouxT2XOMPDrzzrablaT+fdnH8HHSIg4hpuT82Z2KkOQjafxnN+EWX0khxM9iDhKmIZVzm3bFDs1YLiHxTlCW7GND5vU8iU+i118vfbFBnqrU99YtIeko0POUpB6NZE2LNFC6qP7OFUH7C5gEuPZNxSt0asWnv3uT/7BLuz+b1DnAqFj6sd90x4uexT1yY3ALacK8F2syGV9FNAlfNEGg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(6506007)(6486002)(31686004)(2616005)(6666004)(6512007)(26005)(66556008)(66946007)(66476007)(316002)(5660300002)(558084003)(31696002)(2906002)(41300700001)(44832011)(36756003)(38100700002)(8936002)(86362001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVZhekVOV0dHa0NmTnNPUUdkbStRVkJRUU5oOFJPNDNjUzJXSFFJTmVqOWFy?=
 =?utf-8?B?RnB5S2FkeFZQNnAvWUVHbmt0bDF4MFhHZHd4VXBPMkU5bndvS25YR1YxNE90?=
 =?utf-8?B?bjRYQjhnYUFKRmhWdUJuQjBYcW5Dd25Bb05IWDZVMUdHV2d5Tm0rTitRbko5?=
 =?utf-8?B?QlRwS1RqbEdERlQ4dksyVzlTTVlmMzJXUFZ3Z25memE0ZTR0YzRQQjFJMksv?=
 =?utf-8?B?NGZBZTdDbSsybEVFbmJ1eEJLbEZTRnhjTlZrR2NSbzFaYmNXU0FsS3FqUlNs?=
 =?utf-8?B?bTZxNnNwTmlmY1lNQTFjdTBHRXBsL0ZsQndOSEJiSHl4bmRhTnV0aUZoM1N0?=
 =?utf-8?B?d0hkRGQxUzJhMCtpMFhJTHZLc09lLzc0ZHNiUVdNOEVpR0pQUEJiVUU2N0lN?=
 =?utf-8?B?MENzTUJUQXJHNUJrMmxHcDc1TStiYjRxWlBFSnJwQjhIM3hTTnR4SklaVjhI?=
 =?utf-8?B?MEVWcGR2WHJ3ZnRJK0daS1ZYUktiZnNvckduWXE4em1WdWhMQjBwRHZPZWNP?=
 =?utf-8?B?QUo5c0NXbXZPYlpMM0grWWpOMUxjTEJwNThFcWNvazNlYmdnaStsalpDSDNk?=
 =?utf-8?B?RnNwTEEwbHhHbWJCSDhWRGpnR0tDZmQwQVVveVBIV2hHdlF3aDVnM3FZSSsr?=
 =?utf-8?B?RUt2OVNuTnRHVzVtVWk5a214UFZFWWJDdytreVVXVUx1RUxvTzdWUWpaVDA2?=
 =?utf-8?B?Z09IN0FnUXlLR2pJZGVOd09OVU9LVzljbHk2SHpSOFNrVlVBYVUwUlZtQ1JD?=
 =?utf-8?B?aEh6YUFQakxpZ3h5L1djQTluK3grZmJiRERLVTVjWXZ2WW9hSHJyRUNCSERT?=
 =?utf-8?B?L1BFaE5zeEtBTnY1ZnF0cEFNNlJGdkJ4WUlyYlhVeVRsTisvVG1rNXhrQ3k5?=
 =?utf-8?B?NmtWaXQ1Z0pNVDcwMm1qWm5RM0F1MHhNcEZzcHpKUkhRTnlmQW1NRnkyZytJ?=
 =?utf-8?B?ZW1rendoSDQzQXAxQ1BLS0JWc0lvOWRFekZqajh4dExkTk5ocm8xNmt3WnRM?=
 =?utf-8?B?RUJMeUFLSmRsZU11ckdFQlZDOFptalExa1dKNTd3T05TZE82ZUo1MXU1cGpI?=
 =?utf-8?B?U2pYbzBnK3RPeXlEcGtKb2xLNVVteERjTDZTWDdLUUFDQU5RZ0lHZTFxdHFh?=
 =?utf-8?B?TWU2K1V6V2JubDFtdi9WRHdoc3ZFaHhRT09DZU1lM2dxd2dHYXFvZjJySmRj?=
 =?utf-8?B?ZjE0WVVpdTBBVFQ0M2Z2Z3JyQmF1aU5JRGJCWDBtV3NYSkpCV2tVdmdHMERq?=
 =?utf-8?B?S0FTQ3VYNG1wSDNwMmY3Y2tUVWdVQThUR09JSGIyVnVEa3hrWFlDWjJWQlR1?=
 =?utf-8?B?MXFoRXo4R25FWUh4MlE5TVNFekxCL21HWlhYdWUrdXJJa3BWUjhhRUJFSE9L?=
 =?utf-8?B?RHdBdnZaUUpWOGZmVUdvL0RHOW1SdzZnK2JiMStoWjNuRkM3elNYNUV4YmVL?=
 =?utf-8?B?UzdHQ1hKRjhoSHZGdlEySklqSGtqdFJRZXNsVFlaTnMxa0k5TnFkQkJSTGhl?=
 =?utf-8?B?M2c0RzZJSXR1MDJuWVZ0R3lKeHlWUlV0QzIzWGxzQWFaM01xUzNCdW9jRTRq?=
 =?utf-8?B?Ym52OVNUUllpTFYwSFVaaCtJUjdNaXZ5T0IzbWNXaW9VdTYxTTljSzVMdXdG?=
 =?utf-8?B?WEFqUkZTVXdxakYrUm5zMlNCOUttYlFMQVdFTTFOck9adjN0VEZWMWpWNHhG?=
 =?utf-8?B?Zk5XUjJyVjhRNU9lR0FCOW1CNFlxdG83L05PK1lSK0FxWVhXcVdkSk1IVG1p?=
 =?utf-8?B?RUVKb2laTHNyWjZkcXVBQm40a3JXZUF3cENKbHowTVNwVjhSS1BKNUxXZWc1?=
 =?utf-8?B?aGgxbU85cjJqUXQyMVNXTldlUmlzZ2dadG9CUFRSRStWc0JRbkk4S3pCdTFs?=
 =?utf-8?B?VCtvMkg3VWZMS2xXNm1rdW9ic2c5UHFyT3RIYVpMUExLQk5WT2s2U05qUTZu?=
 =?utf-8?B?WFRnb3VnMHZ3TWc3M2M1cVRJeWZPQm5GTzYrSnVaS0E0bjZEOC9vU0pHejJB?=
 =?utf-8?B?NXJicm5JS2l5TTlicVVFV25UcHEvSkd5SGxlb2hQUCs5bllmaFhkMU1PTUZI?=
 =?utf-8?B?elFlbGNsZ0o4b2plaDNQYkNLdldXY3hZSnRoeHRGVFF2UENsd0YvRlBCK1Vn?=
 =?utf-8?Q?M/fc1UOepberMi8OE50x6zjnC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yU9E0kEdDpMsbfoJCqX/VkhcwjXFI9IdPC28ZFXYj4rpAYQxlfuXvDkK/G0QJWRJYUI62mUa24zRG31uksh2F1F5C7RPlijdLftJln4xiiAYxvEKs9TJWpN0J3YWrsrnPw3eUgD+qBfKGe2MkGkUlRvZ8NMkJnw1CZZOQy6sny+pqgBoxpgQGfy5euWCIcrX2Lkmn0y9HUlClemkxSo7UqghMWr698f5JvlScbYYJrkJOXR9c8LIQZnwJrNlPzLphBDZkF4j2MLulpNQ7XkPQd/+iOPNIb2Z0tfJZ2MxhmNg/tW/ZXVLS1VR2Jy/zc9U+qlt4Dzch54KHYUAwGtAdcwiziZ36Oc9OhYIvteyWyXnQ7LwrRgscx+/r3t9gU1Fzr1jwOHuxV+mjzrXOI/3eRRH0zMHimaD7Gl0F9BZztpmLNHqAjkgtnbsfic0ehsdBO8gG8nnv0c4Atc5VN3Vmath8xifFzkt39lzqMv1SATCWrTpASPRx8oYJNDuUzG5AeYUcvbR7iU0Fn15PogEXNoVtMjy0zRaKLODs/6ehf2Xb5Gqrp95f+JOBg782f55jMX+P6TMVEde+sbjC89NGA4Wi9O/JTZuztIKROGur8eLHZscmxHajoAtDdeFMaOvEw3lAvMEzGqUo+1vxmbghGJY6+sXjctLOm5hFfh30QgmSx/NCDVmTNGZh5CEbRmjnXCbHgIxQiGZtZmEwx5lZrQ/Cr7biXFXQJ+QFg7o72ZK2tvTjmsH688deIpA9YfCRorZkrZZjupGGh21KPwghqbX6CLDMrctqE5DHkX3rYg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1465046e-e552-41c3-8166-08dbea514c49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:18:30.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEGBal6PWlap5bxGVQsOSkVc1Q0AzIi7spTwhxOxPMpEtftBr+WbavA0HU1mWoxOD0wd1ey40QGrO1HH8Jlr8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_02,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=873 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210040
X-Proofpoint-GUID: Fn3og1vNkHTrlSD3xE539dautVRSz6ea
X-Proofpoint-ORIG-GUID: Fn3og1vNkHTrlSD3xE539dautVRSz6ea

Also, is it possible to CC the stable kernel? It's not a bug fix but a 
debug essential patch.

Thx, Anand


