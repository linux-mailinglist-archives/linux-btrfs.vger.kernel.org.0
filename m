Return-Path: <linux-btrfs+bounces-2652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95486045A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 22:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60E91C23108
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD673F1E;
	Thu, 22 Feb 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S1tkzWRu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DdgK+oh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831126E5E3;
	Thu, 22 Feb 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636055; cv=fail; b=DhVqFvP5HXF+fgoiecpENHY12tGQ+hZCBSb/atSMi3Z/yAFOgYNhT2WZd2cWsBuMKdUlG+y2VDL3yeaNdQstm4jjbKuD+NMoy8ognuI6YkxMPMkPbZWB7U4YoZW3zgtXbnMdXVG/rGuHDYIosXP5B7CnxI8I73b+PjxB6df5blM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636055; c=relaxed/simple;
	bh=MzWUkFlzmQpDqElkA1kpCLRXekDywWw60SbAbuOf0WE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DbnZWyYHV9NPE633clivM09q7QoaSdoGMU2Y70Pq+3PfOAMVh/PptV5Ckd5VKp3KJ+NyJoX8pYuAwn+NKnicqjcDFojeiKPmQL/oNI0XkTpt1wQ27TmI0Q8SIFOSTzzSeEvAGxIw7dzZG+sq1dQlNnLJAIYIxOU9pKVADk/BxHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S1tkzWRu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DdgK+oh9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIYLcs017736;
	Thu, 22 Feb 2024 21:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7ynACqzq89xgU823ocildEKOZqLMd0ZNzTQNzMHfFRU=;
 b=S1tkzWRuhX3KNuSruS29fnAkVJVaxEXqo7MQbInGMqoMi6z4OxnPqrsRVBmbNGGIxZ0a
 Xgc9aCLlaPSNm4clwBM2SyJs4+DkHBM5e9sXaghrBX8Qu1Xaskb7V8x5e9x1c2wcrC4L
 1x1woKoNYfiQzdpuLx2gc8omN/Fm/eP7xaoU0MCFJ70uA9MGofTM0vJQVU5jmMdHig6E
 HPxzgRSzLCOKAS36lx618TrHWlolF8sXl3DrrBcluCeL7k90rxwJQ2iUxzj+9O4IIdNq
 6jafrmqcL/CsI2K11UPEIL6s9H7ZspltXTITJJj24v9Ilkxs3QpthNvfsUfmiY1aaSHy Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqcdwyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 21:07:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MKt6Se035680;
	Thu, 22 Feb 2024 21:07:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b6w9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 21:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZssfmdhZpj8R3PGDZf/U++N1zBxXF4DtQLBN++A7dw+ma5PmNs7CZNKP8KZmE0W5PKLAbBMHSAwfaTbxX+FhryB503ayaUushr4OhNa6dSf3/OozV/2RlZR1WmHwPAW5jN6UMgqzy6saVY6r7RZnclm6vEWWhHPYTghi4iJorQ5u5tuCoF1qN7hDN307QOUM0vi+DLRS1G3765zXGIqrVshgijfjNrH0sGB5V4Ln35vJ7SNgG4Egv6pFRhjm5g/97KRfGFO8ICQ+3ETIgtB/JOTeRua2yQ6SsHBiTn7Ym+hkbvYyL2BNOctt1M+BwHHKNKcYlew82D14gNo3H5eEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ynACqzq89xgU823ocildEKOZqLMd0ZNzTQNzMHfFRU=;
 b=QiaKHOP1HnK6YkBPD6QF5mzQXBgpaAHbsPMjZR4qA0kG7iRHYQlM3KyddtZNqPdrxZ6wXP4Jj1MDBWQC62eYR6y//IVj+MRKt9UXVAe4AcJQiudc7BswohMiYoEO5lj4tWv0kvObvnk8MPUzT5Qq7jBINC+6o1mna9RNaBM3pyW1/Z/WbFMkqjpI//WF7rqflkjB6TFqoJmAxMC6P6yZaqRSZPY/rACx8LXcdSV/hPYnlWXEnKsW8an8DgTEJun4gjxR6ys7w8RkSkpBNBZshtwhpmwWPoIc8/RmqnGmE1ObbRJ6zKjMkUXthspZ18nvQp5lnnYfa4muXAhryO5Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ynACqzq89xgU823ocildEKOZqLMd0ZNzTQNzMHfFRU=;
 b=DdgK+oh9c3sUWRbpwJpJaX9fpI0rLSppMrDgEBb446yXwJ8OCCmwGlsuw3sjP1bd5I8O1JLw3hmD+3rXEPKxKKOua7TPf6IXdzHoSje3AZFXy/7n5o2AWqHkSbUUS+R1IGO/W1ATQtxUkIGeL5C/12ys83TX2nCOpebLQp1mqps=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB7031.namprd10.prod.outlook.com (2603:10b6:806:347::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 21:07:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Thu, 22 Feb 2024
 21:07:17 +0000
Message-ID: <cfbfcc61-deb6-4011-9acb-65fb271b0a61@oracle.com>
Date: Fri, 23 Feb 2024 02:37:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: dsterba@suse.cz
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, aromosan@gmail.com, bernd.feige@gmx.net,
        CHECK_1234543212345@protonmail.com, stable@vger.kernel.org
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
 <20240220181236.GF355@suse.cz>
 <bdaa5790-56d8-4490-9eab-9a47e4926661@oracle.com>
 <20240221214949.GL355@twin.jikos.cz>
 <e86a3121-e54c-4975-bcea-507fec8642a8@oracle.com>
In-Reply-To: <e86a3121-e54c-4975-bcea-507fec8642a8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2322c514-6e3a-44d9-bdf6-08dc33ea3fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DXvyReY+bgludEjFNeRgIG5pyLyKFjg7F0+zN2qUsqJAE5P40Li0QU+Sgf5fZg9Cgnx4n7KKF/QRCbtUogd6bNYt5fKzTgPaTpQAEZu/mxbaOOVy9lwfeEl5vZyBxUmtDDJmRPdS+63/9mTFT2hvtibbUzup2AmAYNINNfJG0KZaStnE6cbMvhRw4iHPgwVt3/zLjOATe8qllT94cm8Oo+4YLMwpYeGCqA2SrxxlZ4sp9epWSYHbITDWwxg7lfpOLXasu2FQMyoY5vrcEmz3Tvz0fCTdKTgxHYNA22y1xrs5fyXnA4zgxUsMivLagkSqYttQB7zVdIlvgpqZJ+XZANt0tOkReu9Nz+2tl1m8lNAQMOEU+3+782qf6VkqmwjE3PxvKu2ayZEnbE9dL2I+1/W73wEFWUdAXFtpliM/dx3bMHemTLdcqkPJEUnHR1DCgcz4QGJpyg9xuGvWIAjjzCZDdF9MiWctnyM34xXDPk6zZ4mUWoFeSpaBQMu76aoXRffgMncp5Ow6oXSM7PXUtVeGkqVCGIgCGRqBxVMgUFw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnJlUWNwcUh0eUdZQVE1Z3lqa2diQjFSS1ZTR2hIemQ5ZmMvT2pzYUNWemdo?=
 =?utf-8?B?Ull0RnkweDNaYTR4cG1odnZxV1U5M1NBWktXQWlFcFFZeWplUnd3NHJ0VXda?=
 =?utf-8?B?U2VockI2ZDRBMk9JQ2FJamhrcHRoVHd0Z0xJeWRRMVUzNHdaMkdhVXhqNnF5?=
 =?utf-8?B?MU52UjVXMkVVd2pNdGEzSkZOYi84bjlxZW80U3pBOFViY0p6YytXamJ3Vk5m?=
 =?utf-8?B?djhiN2VrOUI2T0Z2U2h6eGdKOCttRTBkYmNsR1o0ZGQ3dGJLaHYzcTNJb3p3?=
 =?utf-8?B?a0lCNDMyS09CUCtOSVVaUVlLeU5sREhieUUyNyt3bm9OWndYa01QSjdCYVc3?=
 =?utf-8?B?RjZIcnAvanlzQmxYMzQyek1IVDJmZWlzSzZ4d2hRUU4xR0x4TVlyenFFcDln?=
 =?utf-8?B?SVEyL3R1Q2xOVGQ5QUQ2Rkd4R2l3MDVpUWF3allPMXVLOXFSTWFMMWhqL29m?=
 =?utf-8?B?ZC9sT2xvU2dielRqZ1dEckZycHlqbGRFSlhqc3Z3ZC9pL2c2SGVpdlY4bWlK?=
 =?utf-8?B?Si9CT1ZsUmwxbnhpTUpvMjhJellYMjdHMlJtWkR6UXRxcVBpb01SeDRuN2Nh?=
 =?utf-8?B?cHZrRHpUcjlUTE5BUDVUcC94ZzFwWTF2eFVDZmV5aUtLM29FR1pqL2c1NGtY?=
 =?utf-8?B?MXRKa3pVN0dyb1Y1cTBOZUQxVzhXeVY2T0g5VUlLWHkwUGNTZU80Y091dm9L?=
 =?utf-8?B?ZEdqUitHVGhkN2UvTWdSQjZKL2VYZXdMUExIMHNZYVBqdnNKQzJsUjZlTzlr?=
 =?utf-8?B?TTN1UjJuWnRMZFVkaFdkRldwOXo5YU1MQ0pRd0JUMjBUczExT2R0cENQWlNs?=
 =?utf-8?B?d1QxdTNsVDJQU0F4bjdmNW15dVBLR25wdHdJUkk4RzZuTTlhVlgvRE9QOXcy?=
 =?utf-8?B?aXNhN0M0TTA4bDFQSDQ3aDA5Kzh4QlErajh5T2dPaEpHcFg5aEFzR08wbnZp?=
 =?utf-8?B?b3ZueUlBYytMd0RPZ3llRVNWZllYaW9Ncm85WU90YnNRV2NSd2VGbllrUmpJ?=
 =?utf-8?B?QjAwQWNBNUt0MThkZnBzZmdIaWh2aU1xMGhjcHJYRFhLeWVWeWVBNmZzQ0Vx?=
 =?utf-8?B?NTB6U05nRDRoRExLMEJIYlFBZHcvZzFVby9xYmVidEZQbFY5UjcyZFdGSnJD?=
 =?utf-8?B?dG4wT1BtQWFsSjJ3ZTE0a2ZrV2pPWE1lNlpKWFpqWFBMQlFpRGpSaG1yQm9w?=
 =?utf-8?B?dXRoZmU3L2NZVkI4ZytJYlFnVHJadXZWdGxPQU9KZnl5djdBWmVOQTNCUVEr?=
 =?utf-8?B?cTROcnI1Wmh3NjBrNDZ6c2wwSkk1Rjl3a0tITVVrQ0pPOGpUcnV0NU5teElx?=
 =?utf-8?B?bHNzSE5VV2hoNFVRelYwcFhYb2hTR2dCYjh4S2VsRzBzM2pOWWlVNG9VdkNF?=
 =?utf-8?B?NjYzS3FxeEl6MGhyV0FabXdXY01JNkZVeHBIaFRlcmtONG9JWGlvUTgwSlNj?=
 =?utf-8?B?Z1VuSHlvR29ucXcvL1Rjd3RjOWlaNnJ1Z1NLb1RJWi9ZTmdQOGtjdklvYkNz?=
 =?utf-8?B?S0tyNmhTbUJ6UkpET0VDWkVsQy9IaUhScUJrc1Y4dVhZTHhVRDErOHdLOVhs?=
 =?utf-8?B?TkxmNWR5WENPeGRiQlZXMmRKeFArZlRCMGM2OUFlNGVtd3BwM2RqTWQvUzN1?=
 =?utf-8?B?WThKazdnSUhoNTRieERJK1JlQVNIdnBHRTNYQzRrR0xyc2VXZFpEYTh1NFFY?=
 =?utf-8?B?NHFrNmRXdzhHMlY5NHBRbFcvQWpuMXN4SHF0RkFHQzBWVEtKUkU2SDRuOWJo?=
 =?utf-8?B?bUtuUGgwMUUrZGxHTGxxTksrVVh4S2FTaEVhTzl6MHVLYks5dmVVU005WFh2?=
 =?utf-8?B?REFlSFI4aGN2RS9uRWF0ZHhSTW1DNWxKMGV4QncrbEwrU1VPR3d2V0t6NXBv?=
 =?utf-8?B?Rkp4SUZka0QxL1M5eUV1cDVJbnZuRDduaDFjQkhUNDd4WVdPRGpSYXpNUVNq?=
 =?utf-8?B?V3lQS2FlUDd0ZHllY1JEeXVtZVBWZG5nZlMzUFdmNHd0Z1pBNXVITDhKeGN2?=
 =?utf-8?B?ZFl6d1Q2dHRzcktPck8wSWRERExkQ3ZJZnJVNjdMNkhRb3hsZ1ozd1Q2aEgx?=
 =?utf-8?B?NjhDaUFwbURRKzc1NDRrYlFIZVltSVJwdjQzV0ZCTy9vTnl0bkw3eThPbnJZ?=
 =?utf-8?Q?hMCMhi3YsMOSCNDT50FmbK7Rg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AdRHXdB5XzEiF4DTbrk3SGJlMfpqHs1cKljGx7RXbqDaQ/dnO+8kr3Xs3CCQWplj/ZrDJluhVqgRVJ1E0zA67d34LlNWUKDy7O1kCBfzf3ozrcUCLx4sRnhvbot8ZPuEQhMd5bGaky+kyp93VFpvo7VtWuUvtbQVgZ90QZE2+w/zzdSaKeQA7LoaQbe/KIE8B9SlnvlJ6FQ8kNlFb8eY31LiqK35EYHHx8VB61m9XLGXBb3BWBqRJ2svsCJbtAfnLPbufzyANxhPlwyz9YCJiBFMDJ0M+9vouUF13xXFfbhJ0Ghs5AyosXoRtlGKJAYUIQ0YBjMu5aa/ZZrF2Khl7HCo0D6OwqGiWroQsPTg5dIIiqpYNZXOX/zveCvDMluYxseH8a5uQdBRBwl9OR+sprwgJ0K9vLNqz2vQSOy2SgJ7LlgIlEb93mDnwGFsOY2/T70+hG9XzTBZ7qqM5TFLVf/pz3nVnYrw7FuAoAr8TFJzXuoDvV+ABOzi46lR4WIwdWCjVGNict+pbAxtLW9gVvtSS8e21MHYO6CmPLAB57UVvs776vJ1hwYX9AbNkJwAodgKTdFc7r/30M2pq8l9Gp1y7rnE/9xM8iSVxcQCKgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2322c514-6e3a-44d9-bdf6-08dc33ea3fd6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:07:17.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/lGQF6PJPvE+l0CQejVWUuawd91i2TnfWE2ykDP5aX09o3yfpQKTErehdKtKyo4i67ZF/DOoi7tly4JuQIyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=972 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220164
X-Proofpoint-GUID: vGmFkOnzYK8i0JeTSNAeNfPKGYyiopAx
X-Proofpoint-ORIG-GUID: vGmFkOnzYK8i0JeTSNAeNfPKGYyiopAx




>>>> $ ./check btrfs/14[6-9] btrfs/15[8-9]
>>>>

The stale fsid matches the testcase btrfs/146.
Unfortunately, the failure is inconsistent.
I will take another look tomorrow.

Thanks, Anand


>>>> Thanks, with this I can reproduce it and have some ideas what could go
>>>> wrong.
>>>
>>> Thanks indeed.
>>
>> I tested the following, it fixes the fsid problems and has passed full
>> fstests run. The temp-fsid test coverage needs to be done still.
>>
>> @@ -1388,6 +1388,10 @@ struct btrfs_device 
>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>          if (ret)
>>                  btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>                             path, ret);
>> +       if (devt) {
>> +               printk(KERN_ERR "free stale devt (for path %s)\n", path);
>> +               btrfs_free_stale_devices(devt, NULL);
>> +       }
> 
> Right. I had this in mind to check for the stale devices. I'll do.
> 
> Anand


