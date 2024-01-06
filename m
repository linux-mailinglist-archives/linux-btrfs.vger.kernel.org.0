Return-Path: <linux-btrfs+bounces-1278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722A825D82
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 01:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E71F226BE
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 00:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293191374;
	Sat,  6 Jan 2024 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6iM/4rN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W7t9Qwsu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6110E5
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Jan 2024 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4060wn5i012536;
	Sat, 6 Jan 2024 00:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8P6IFRY7+triODOT/RlbZccbz99rsVxc7nmHZbrKDfI=;
 b=H6iM/4rNrtPi6OJxbWcUq+Qih7hfg6yTHJqhQuWfyyqM8bgZcJt6u/aN+ER/xJGbZV4U
 Ci7d1LKNhT4A3FtrA9o3Mkot5RXyWBBfnYuNzWoJAKxDHueR0NNU2qXmRLXWNzXHmOVw
 NBTWf6O3rKAGTCVBfObFZhYI3If/GP4VFjqO5pJxnufS2I8tqQfUan4BoM36oBsZSqAI
 v9+gIUabyUWgft5wCoosRU1BZiGvQlLoOR1laKJb5+XifrEq2TIIbrhzXU2E74/YtAP0
 yJM8dI2+IvG+vo5wAuPW/at0ECBAu9p8QyR/pvnjVxGgnr6S7DzYDSZaP+OXZlO7Q7Pj 0w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vevsqg00d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 00:58:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405NGsJm010702;
	Sat, 6 Jan 2024 00:58:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve176g4gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 00:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUodWZst1GYWAOfVY9j9g2Cg7AZh+hka4TP9bGFtFXGmsN9QqXjp52hwNmI7aiyitFzzfXIuwsYKDWvaeS36bMeyKArzG4DDr1+ch2SJD7vj1kXSFZoJ2tlX+uCI6Ygb3/PJrt0kIJMafpJU9DmmD3w+0ZXBNdlZwCpHKmBw9sywTrVpY68wYPf0UofUgNTZ44U8gnIqY5mpMrpOYX+vuhYzMw6gSmU+BYcZ8DROxetfpUPYrSSO1Naoc1QOK9nJ/uyXwZs3ubfUBt1vbt4BSrZUlSKKwe6OHG9mpm+kKkazcwDncgve1cyEDFAv5488KXFBkCiXstSAMxxOwzcyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P6IFRY7+triODOT/RlbZccbz99rsVxc7nmHZbrKDfI=;
 b=ldsA/2TVVjqjOPhoLeIkdwOP/ZYSBJRwV2aPsGPWIGvPYfDt2PCxLpXQxpVqw5TEuWE+MbIkhUpXElSAx+2tbGhuqpaMJRmZU5PHkW7c6K8Lht0vmMU37eMjFNEweEUKRuWgKuTe1BMZ9BRgnuPRYbVqExafU9R2OWi2fwiRf+xTdDpqzHItS9xXSZCrr5IAsBsNnltvqTHJs9MfXbYRmP8lAHqJlWMsAWIl4+CQI/WUkymMpbiuhHM7FZGK/zw3MxwLOkMqgCOffDgFxhehZbYMlw/jHX+fNXwju3uEvoGY6J0HnLzDNakSR0JCa5sZAVtWhYx6DN5CbXkk94E4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P6IFRY7+triODOT/RlbZccbz99rsVxc7nmHZbrKDfI=;
 b=W7t9QwsuaP/LjB7Ayq3gx6xrGy+wp604y9l41BIcPSr0pxV4IPTFzVY6mQnNxbSCxbBKqzqSbHkiCQlyZGkYZaocMd0CCBucLy3ba+ZitvYZfqg1aUcfrzKWNXhRfD6sLHkSWlGIdLchqesXI3AfW3eIB8u9WqXVsn27bkRXs4k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Sat, 6 Jan
 2024 00:58:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 00:58:50 +0000
Message-ID: <646b83af-235b-4243-9e16-9e288e39d113@oracle.com>
Date: Sat, 6 Jan 2024 08:58:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] btrfs: subvolume deletion vs. snapshot fixes
Content-Language: en-US
To: Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
References: <cover.1704397423.git.osandov@fb.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1704397423.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef6fda4-2a84-4d34-c684-08dc0e52a512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2EEDM8yRuoobKfGSePNZ5DKOJX6NsnqeHqYQ7epMUiZWZSiM1DIRPD4DW5MMJmolZarA9CEr0FZrJ0V49EZWdS1ZUworsRv19U5njWc5ZUqELo9JOSXj9+zVSwkk4s2rdgg1pBm+MECCWD28rranoIcPte/ZYRLmKtwttS1Q90V2s64DOB7f9q8o5FSSh2r0J/Cnro1lRZ2H495Ya7hIp6w1PBB9GFXGSXXauYytyFl2jYoH03jZCd5BduOTucG6ZtUfCGO953hbxCGmD8VMgJPtIATEt2pnyUaOCtOsfkUsce0ptKBO6muONdy7hwkFiIzfbSyyA1+/h6uVHK72VeY9jN+L29y3lF8Y0W8+Zm8ANW+qmthhNR0BE7cF382N+IHgwOg6sA+55vv778R4sDeXkm+r1V4JDrXqbih3nkD/joDJcrhM2rDcl47wzmYy/dvhZ/dtmvT5Dj15r1um0SizpcOHQokzWjW5u3JJ2GvCCkM+sH/7ncuVkdxV33YaeXDuqNMAm58xwPwTqSodygFFenZUpds4If383rkCd2zQD/QSxdXfvYKanRuNtZYnSgx8iUMIiM7GakUoRIZ1E7QuZn2p1ZsKVSKp/uzS90ddD6PgMoK7/0mxvVyZRCvS5MVe2kFz0mgh7mJvi7hEbA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(2616005)(53546011)(966005)(6506007)(478600001)(6666004)(6486002)(6512007)(26005)(36756003)(38100700002)(86362001)(31696002)(5660300002)(41300700001)(83380400001)(66946007)(2906002)(8936002)(66476007)(66556008)(316002)(4326008)(8676002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHNJb01lR1hKYllUMGxvT2t0dERwK3hvSFI1UDEzTTZxL0E5V3VSSTQwWGY0?=
 =?utf-8?B?d1lITENlU0x5YjhiN256cmVVVXZmRzZwN292ZHJEbmNQalVOei9WaU95S28v?=
 =?utf-8?B?QUkwSHg0azg0b1hPUXJQY3pqYzd6TjNsNlhrdDdEcVFGUWV6VzVEazRCTVl3?=
 =?utf-8?B?dWVObllxVUNsUlliRnV2RUhKdXlDQzc4YVhNeG5kTWpxR3RIeHY0ZzBNakIy?=
 =?utf-8?B?S2M2ajJVRjBPTWFERUlYOUpIa2MrV3NFMDNiRUEzcWpDYjh6WURQUkpFeVZU?=
 =?utf-8?B?M3dNM3g2QXRZY3JLQzgxSmdzRzh3cFd5MFV4K3ZVZVc0MXB6N0Vxb05oWHpG?=
 =?utf-8?B?dERJcXRqUTcybnN0U3Rnd0RkLzBIMmJFbFdpV1E4MWZ1bkQwaEdSY3RhcUxy?=
 =?utf-8?B?WjFOUnVOQ2IyN0FwWElLWEF6RmI3Sys0aXhsaFJnaDd4MTJJNFVmY0tWMXE5?=
 =?utf-8?B?UjdzeWlESWUzSmxObzhBTmQrMk56ZmtmdHRBNDRTVGpISitOZUwyU1FDcXdn?=
 =?utf-8?B?SUpUZys4bjQ4UlRmUkhvMVkveDlFS1A1NWxEeEhSS1pSdENGTXlVMDUxb2hq?=
 =?utf-8?B?VnJ2UTZ1MTU1QjlQdnAwYjIrZUM2bVFuT2F2cml6TXFWZE5oMC9ITmZUeEdk?=
 =?utf-8?B?anQxZWdEbytZcDdHY0JqZUxlcTN0M3JnM1NTSFRrL1VieEtBTlN5cUV5bE15?=
 =?utf-8?B?eitYVTZ3UnBUWEFRZUVtR3lXUnV5aXhpZUZNdFZST05RMkpUVGFwT3hQUm1I?=
 =?utf-8?B?eW51L2hCeWpLeTFRTXVYZTI4WjRyaFFHeVlOUWNPSEwrVUwzRUhmTW9BMXlS?=
 =?utf-8?B?d0ZmaDExd2VxQkkySlU1dzBacHN2WnBDM1RxU29uZzhlVGRWbFVDSjJtZnhX?=
 =?utf-8?B?allCVEY0NHRab2swUHk5OWh1K2lSNGMzVEJjd3RhWGtIanIweXB6SEViZ3pl?=
 =?utf-8?B?RC82L1lzTHNMMENZQ3pveTNmT0Y5cDZ5R01mREl4eVo5a3NpZWRFOFQxa0dD?=
 =?utf-8?B?dmNGQ0ZLYTMzMHlSY0ZGVTlsQTdtRys3WnZwMzM3dW5hWUNIK1dLbjNpTmN5?=
 =?utf-8?B?V0lnekJHZVFoVStPMEp1bkNRRFVtMWd1dytuUkkvcFZPU0djNTRRSGdjVUpG?=
 =?utf-8?B?MlUvRk5DdlAwZ1VZMHRDd0NMSFYySHpLMmZ5eGxlZURJOUNwRGw2ZTBteXNL?=
 =?utf-8?B?eWxITjZ4RlNoUUtXTUsvZy94RncrR1FSUGhjd2w0U0s3b2FtL0FnV1IyK1Fx?=
 =?utf-8?B?L1BjSDVCOXN1U2t4L01lOXplVFBrZGpqbTF0dXlLdXVNdjhzRWdGNUZ2TkIw?=
 =?utf-8?B?eWNpZmcrakU5QTI2STg0aFJHekQ3Tmc0S3BHaTUvNWRlVTRnV1JjK3hxZW93?=
 =?utf-8?B?V00vZTBneU1XajlUUWZJLzFUamlkOGVzaHZ6bEdERG9nUHUrb1A0TmhuY0dX?=
 =?utf-8?B?SDk5UHpTS3ZOYUYyMmtTWDFwOGd5eDFCV282d3VYWmt0SVQyN3JmaUplK3Js?=
 =?utf-8?B?YXBNak1DandEOTFWOUJDMURCQWZJK1NIZkRHWmhja09SVWRQM2pGK1pvYk1I?=
 =?utf-8?B?UVYxY3dYWTBPYmowLzNHcDl4RldLS2ovTWl3Rk00Lzd3a0dzQjFYeGxuMnN0?=
 =?utf-8?B?U2xzYWo3Nk92cGEvRmNGbVo4NkYwM2VwM1FFQ3BlSDMwZXp5OTUzT3JwMTg3?=
 =?utf-8?B?NGRINzE5cVJXaHE1Qlg4aWR0Z1JiUVlZVE44YUJDakRQRXgrVHJhSk9NeGJ6?=
 =?utf-8?B?bFRheTU3b3MxUFM4WTYyK0lieXdxNDFxczJvM2s0d1lLZytKOE5oSW1mU3Jl?=
 =?utf-8?B?SzZsUEdWZ3Y0cS83VHlLM1VCcFhuRGN0SHBOTis5SnE2S0NrNTFFVHBvdVF1?=
 =?utf-8?B?VXFPTGs4UWF5Rzk1QnRtL3NyWEFIbFNyY2Nxb1hJMTRaQ2YrdWszTDIwMTds?=
 =?utf-8?B?UlEvSk9NQzE2SXNPTEpPWVYvMlFERzhobGs3WTBZME81cmRyV1UwN1UyN1hp?=
 =?utf-8?B?REN0OWlKZENaUG1lcUdneWZRTWg1Z3ZuQmx1VGwwY1RCOU05Y01tN0dmeFJD?=
 =?utf-8?B?N1VNdXk1NmNHd25kb0RGVnVhdEswOEZac2lRQTh0cCt4N2JvYzVUbkROQjE0?=
 =?utf-8?Q?Q3TwfHiuKhYrRSvrCjzTXIagq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hY7rCO6VbqF5/7aPU7YcXCqxk1WVgwR+CC31wurJwSLFTgOFt+WmMEEGgmhw2b3aYb686BsBSOUBlAzDaKQ4cBFuhcWcndLs1KIs0E1wKp06aYqvaAfYQdd4VBmiGgEd0BDHZmd4ds24Txepu73NG49qmPY9E8jly8qcRcOL70fBPW3g6TYuNdvt1cT74wALUezxu6FMI0hZQTm5SxJpRNcq6QtDvgfbKJnNWbx906S1aHNMNSOAozsVA+/skUG7N3Jgt0Bv61x/VC//dLwL6PSaDjR/VD8bFIO3gfpkXDGf7IGqnEepaiJ3D9Aa1EnYIqJ2W5KhmlmF6NwjsFUtqZnLmNWPvNHi9adpNMJkNqZvaTRb+vQHeIHdQY0aKp7B0Ko1IkqX04b37uHdLNfy5FQEY5otYNBb0ho9gXkdDrLSw5AalbnkC67ZbfiX0Fh0fZot/1CLWkjew0+Tpn1uPmQaHlTUzb2AK0pT8MUFjHEqCjA16KwXOiZaByQjYgiEpEjrMKHU4AvtxcQtbbUchhOMRvNsNzc+63H32CmREkiav591ulg8JyAP8piB+9vbc74ZxVdiV6ONtyAsdMMNpAXH3nSGS8hNLLStwC+sglQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef6fda4-2a84-4d34-c684-08dc0e52a512
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 00:58:50.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8wFcmsZGRvKBwbQ0BLqD479Crn3U3owhYn6DRBL345+ZyKgocYQa3WGOxBAwYSUAJc/RV2etCuW228vFMRAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401060003
X-Proofpoint-GUID: rkxF1adkzenI4tnZwbE-QuApOORUD4P2
X-Proofpoint-ORIG-GUID: rkxF1adkzenI4tnZwbE-QuApOORUD4P2

On 1/5/24 03:48, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> This small series fixes a couple of bugs that can happen when trying to
> snapshot a deleted subvolume. Patch 1 fixes a filesystem abort that we
> hit in production. Patch 2 fixes another issue that Sweet Tea spotted
> when reviewing patch 1.
> 
> An fstest was sent previously [1].
> 
> Thanks!
> 
> Changes from v1 [2]:
> 
> - Rebased on latest misc-next.
> - Added patch 2.
> 
> 1: https://lore.kernel.org/linux-btrfs/62415ffc97ff2db4fa65cdd6f9db6ddead8105cd.1703010806.git.osandov@osandov.com/
> 2: https://lore.kernel.org/linux-btrfs/068014bd3e90668525c295660862db2932e25087.1703010314.git.osandov@fb.com/
> 
> Omar Sandoval (2):
>    btrfs: don't abort filesystem when attempting to snapshot deleted
>      subvolume
>    btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of
>      subvolume being deleted
> 

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thx, Anand


>   fs/btrfs/inode.c | 22 +++++++++++++---------
>   fs/btrfs/ioctl.c |  3 +++
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 


