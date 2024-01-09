Return-Path: <linux-btrfs+bounces-1320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FCA828703
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 14:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF29B2183B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5538F99;
	Tue,  9 Jan 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m3Sq2Tvi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1kSApdr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E65381DB
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409DOjs2024217;
	Tue, 9 Jan 2024 13:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mA4hTjXQNyxmv5a/L1XKDwyL7XX1Whe0j7+MlohdjIc=;
 b=m3Sq2TviV+0IK8yhTuBJL3wqvgSSsgOW796haBxoCGNfMf7R+eim2sPb6dy2v1QLXRjk
 FCsSisT4gVcTePcg7gLp1cpKCYzOqvAlXnfwIbCq9VXpgsAFcWigHS/msNXeieD5pbLB
 Sc0Tjf7u2PQKLiQMCp+3tjEtVsi0owI2Y9b2oXivSnx0UG8vgRyJHa9rbWsY7ENE/3hI
 n0/VfFBGDYC4SIfAnF/o5sKr9xA3t7ZSJqgGeTQ8xQYHcyn7laYh98yhJUtUcIoBNtfh
 jo9MU/jqGyPrAbkH4e8aJLNcKIOM2r/YFP2XZTe9f6Pwm9x8mxKA5E3RFBMEV1dpyGmr 6A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh70d009v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 13:25:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409CZ3Tk012275;
	Tue, 9 Jan 2024 13:25:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwgr4k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 13:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsZY8inWbr+qOpLsvgadXb3DxCev4vihckpAUee+p0xy6QjYrOFn8bVG7skiiMRNFFnXFqj/rR8KgJTUvxItBInlA16wcCWPK2uC/gW30anlusXCMA07PV2jZEutXBZYPbQlkfldGC2pouHVouiamkicihMFtwO7jA9BNccbuJ7XJtZHu2nAcw8bvHmnsvNaulKUCG3Y/crhlgBsRnnYkb3+wwO4Aq32Sa03Wu9qUCwRGtRjVWJsikWYdsRoqxJsstVjvZr5D7YWK+Qn2hGeYAiuI4xgtcC5H/2jYy/LCsIlP1XZzCNjZRpykplCkLc4EpiWqCl6KYH7RlT/ArKf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA4hTjXQNyxmv5a/L1XKDwyL7XX1Whe0j7+MlohdjIc=;
 b=P4ZgdmYX3hTkYTRURqU43g5CMl8UIk9tgHwjiEMo9KDyKrrA4+YBXoaMiCq3xbCtH7KSvOOez+ZWYApz85jZkj32ELUlSobSKyO0doAmpe/Fl9TNIDapO2h7gee/A4LfDc3BNc95fz0VEPJCqBQZSJrz6BACcX5OdsZyxQFFoKd67Bzmd5PTu2W01mj73z4l9UTeFRNPZP1HZSEzuQMKZISsHhp1OryJ53pRGRyAU0MAauiDa9lQ1/BphJuSWVPf9KFfIqZ14jdYa52hSJQ5KVHAVkXXoYvcaeaK9/3xfpfROJ3vldxwDlQvfrf5Qzi3dueshh0UlfsPzoeKOgiL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA4hTjXQNyxmv5a/L1XKDwyL7XX1Whe0j7+MlohdjIc=;
 b=O1kSApdrbWRuz3FZfV8aM1lt5XNZ0wvyfY66IzBJW/bXpFydMSmNUiLROWtFAA3SO2aZ9JmgiBOYWttCd2FwytDlNE3q5Sf8tUiL95r1TMlHo0TPNqk7QvIjqYUjBreVBgWEun0T5p8Ak8agAntUQxRgzXLNvYO9fsNexhn31PE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:25:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 13:25:42 +0000
Message-ID: <328e7958-6b77-093a-f3be-bcb07e85e0eb@oracle.com>
Date: Tue, 9 Jan 2024 21:25:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC 2/2] btrfs-progs Documentation: placeholder for
 contents.rst file
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b30031c129e92c7e99c7e5bc818a456cd5828cc8.1704438755.git.anand.jain@oracle.com>
 <20240108213325.GI28693@twin.jikos.cz>
In-Reply-To: <20240108213325.GI28693@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b14d76-5f6a-49dc-943e-08dc11167ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sLTPk6vComWW1/y8ANZx8OpuVu7JPrxoN7cmJ1QbwX8gcOy9MOQ8omN9l5fsyIs1OR4SX416YCdelV7ToF1C0cJvtPPQGedVaQBMYV589EWq0fqpLo/nijELhNXtpaYH3INGGQzdn2QJT7Muj9SrXNkBkqudMa1V5t2W0syNax3Exj0FUjy/NhHMRggXMKXDFtc/+IKzkX+sNoWGNeAqigH8hivJbqHoThCWvVw/ApTqYsXQEoKuqXvOcsxgrBQr0C58EadGwANVFRL6tziREfMCFbMalBMmPrI5bknYJvSjeMCNNY5rWlwoPxGkc7k+kG8zIl016FtidPAJSJrp2MLmim06uSVOAh5BYGymMDYwogg1oVlzZxF/CZpwqFVFxQDOYGRobCSWOxa1tXj6lyoeNy8v+JR+4uvT8iKmZpQNyNWqX+++nNuaGU4k8YIJvNfphBjgSH2iwG0b6e59Cgc0iyspzfykoyiCFP4OCint+MdpPX6XUYcFV1sJPNf4XkDvnAq/ygKz2dtKssJqhMIsmcmmxsY/GrIY2Sog3vNelzwPzIxb/nsTy8gZz27OA3YPzUiWLOenkNkoRq7ojPNLtRDbncaUsXCpPj7tXNeOZopU8wZR9fALOo4jsdkTgBSW1wIcn90//N4ImUe3jg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(41300700001)(86362001)(31696002)(36756003)(38100700002)(316002)(6916009)(66476007)(66946007)(66556008)(8936002)(6506007)(6666004)(6512007)(53546011)(2616005)(6486002)(8676002)(478600001)(83380400001)(5660300002)(4326008)(26005)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1JFMVdwNlo1OWNUVkRBWEt5M0F2QmR2NEVNSDBDTE9JOWhkcnYyLzFFSWRm?=
 =?utf-8?B?THEvc0I3NDB1SkprYjUxWjkvRlF2a2J5alFiTUxabVhKWlFBaG40SGw1ZGhB?=
 =?utf-8?B?MUFQaFBrMFVsUVNib0M2OFFMTnI0a0dSQlQwZGRKY1ZCRm82OGh6Z1VNbjRI?=
 =?utf-8?B?cXJUSThORVN0ZktxRmN4Vm1jWHVaRFV3V05mbjRsd2NYR2l4dGk1ekFuOUE1?=
 =?utf-8?B?eHE4Nk9hR2ZsWUtSbDg4Z1pYc3VFVy82Tm1mWmJwYU84TTFUK1ZmZkE2eXpG?=
 =?utf-8?B?SEQxa2NmbmV5ZjQrdW4vL0Z5SmwwWWVmKzZKUnhLeDlmZkxQMy9mRkxsY2VH?=
 =?utf-8?B?V3ZJVzBXSFZCUFQ0YmtSSy81YlZ3QkQzUnU3dDRIOTRqL1cvS0VWMVpEUmRv?=
 =?utf-8?B?VkZkK1ZKVFp2VTNtaVNGMWhBMitLUzRDcjJFQ0JJSUZWR2Q1dTBCZ1B2dWhh?=
 =?utf-8?B?bzlCZ1d6OVJWcWhBVHcrd3htNzJUem4wT2w2eXVJZlFNNTQwVW9wclFVdjcz?=
 =?utf-8?B?VmtZb2luZ0NHSi9hcXEzd1Boc2UzU2RpTUM3YlRXQjlCN0xkNlFrTldiK0Zk?=
 =?utf-8?B?a292RUMvU0hueDNhR1ltRTRKR1JMVzhQWGhTeXE1b1dtaEV5MHhiUzJxQkRY?=
 =?utf-8?B?U1d1ZVcvWGRlYkNLa0V0dzBsdE50V0hDZTZPRkxKN3craC9HNkhjOXlMUEdy?=
 =?utf-8?B?ZitJbHJ4WU9EM001OTFGcDE0amRnVjQySkR4L0VDemk5U1NsMHBESUgyeGtr?=
 =?utf-8?B?VHlpM0pWNEt0VENGdWFtNDBEQWlRSmFhSTFka0VxVDNCZjd2emRPdXpGN3o1?=
 =?utf-8?B?dWRkejl4Q1hPUXpabmR2MGt3MitJcWorWFk4c21CeFZtS0ppNDBZVWY3QnNw?=
 =?utf-8?B?bkVEbk1OOUdIRjJYa0wwVnZjY1c5OGYweDlKME1Xa1NVUmdjR2xUUllkUnpR?=
 =?utf-8?B?cnl5dHc2Rm56RU4zTW92N2xvMHkzeDk2QkZtQTBzc2E0ME04czRNaG5hMzZ6?=
 =?utf-8?B?OEdRc3REUmxvRU1MWUpjRWFpaXp0WGhROVY0VkxyRHBOSk9VZHB1T1lsbkky?=
 =?utf-8?B?bnRreDdKNjJIZmJDTDZhRUhOYUE2UFZ4NUd3Z0s0TEJRdTcyRHZRUko2bDAx?=
 =?utf-8?B?dWphVnhoT2o5R2RsS0hkSEU2VCtPYkRieFB5SXVqUVhHV1hnZlJmU0hZZm84?=
 =?utf-8?B?S3dYb09BRW9HaGJ4ODBobElDMmRCbU85WjR3RmZPRjZLcGFRRnlCdXEwUVRK?=
 =?utf-8?B?S1l5eXlUOUQyMHd3MU40TkxHYWsrdWpTcW1CMkZEdHU5UEFCeDVGeHNUZWR0?=
 =?utf-8?B?NDFodjNGK0VndW5rMkx2NENPN0YvNHRXY2tmRURPZHpXMUV3c3VxRGZ4eXc0?=
 =?utf-8?B?UFF5Z3U2czZycXQ0MFFqNjRSem95RjV2d24zMUVxa3RDaUlkSHlPTUNENHJ0?=
 =?utf-8?B?ZjBVUHZUVG5QUXdheEJGSWF5emZNVFYxZy9FVU5rc3lsVHVXRVprenZ4T0xy?=
 =?utf-8?B?VjJia2x2MmptQXZ4SXh1dnJwcWR4Z05Zb0VlLy91S1NldkVYbm1yVGZNeEQz?=
 =?utf-8?B?Szl4TGlweUpzaDVIT0dsN0ZEOUs1Y2xpQ0NWN0s3V1VzMTZlK2VBK0tyS3E2?=
 =?utf-8?B?anNzRlJRY25zQk81UnVwVWExaE1kVDVQaHcwN3FCS1ZYWkJLbC9oYU1ldW80?=
 =?utf-8?B?VWZWYnJ0cDJnSHRyN3FLalBORmw1YkhBYXNQUXFmVklNb21PaXdFd3dHZ1Bm?=
 =?utf-8?B?WU9LdGJIcVdHM3Fvc2FMQXl3VGhUWVZJaENUT3BSYU15b0FZNlpFMStoZmpM?=
 =?utf-8?B?UDZzR21qK1J0R1RUaWtiMWVCRE9JL2pLQ0oxbTlqamJ6NVJRd0dVSW8xTE11?=
 =?utf-8?B?anRXck96dUtLajZUNTBFNHc4ekg2OVptR3Y0aVBNY3Q4WlRkYTBLeVozU2Y1?=
 =?utf-8?B?SzhoK05TRzFPUVRrM3VFamRQMUhIdTc1cXdtM2FiUVpRY0ZoVzhycWkyWDZN?=
 =?utf-8?B?N1hLdWRVUFFnRWdnVCtRdlFGeFAwclBQTkRVWElXTWlIT0hnNVFkenpWSDRm?=
 =?utf-8?B?OVhTRDViZldKOUVKR2d2VEJnNDgrQkszTEpxL1YySmdnbHphenN2c0hNRnBN?=
 =?utf-8?Q?8c/cb91myAzgBhWjzn/ABfo2w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8ib7Ul0WhU9sc71de5qOUKYnPKVv2Hpw8PXFSmyV3j6LMOKftrzp3wnjpdIjh5uZCe/SCscGiDu/W73pp0l8lvvsVmwUUpMcQwxEn+vyFnKi5AMn6WRhY6I7nC/6QbJupuMzMvCgLCrNuzb+zoWiSz/jgjHfRwGURNKPXxm6I1o46DiFHuYsrFreLMHu+djuy4TOGRYCyN6feLJSuU5hUeqmkY25rwfcnyxdwYbc2xu/NjttroWEUS9Mgu/EhuMet6l84QTcpgxQlYo2EIOWmT3LArYbxMvGtlBnZO193GNwEGx3iV1C/chy52zOeXvEAPH9wYla+LLAx5rzDkWLy+TzXyHyZj/Y/e4JRNXsC2sTK0u9OiI3uYs3k0n8k2jhhpXWvZRK8jMFcvle48ZBS/2LJqC0LBF1iILTRjAYZ0Aimll9g72rhYN9cid8kdStcmZEvpIk8//da6tXhHPXdoZxZ44EKuZq8IRJBoGtKJJIh/XNveUGIy8vNPBi23/3h82pidHth92o3ebmApxiGJeUIhfitRr9oop9JJX1FJuWE1F8FhGGwoz2PPNluoTkmmZO/rAUQcu0OpnBUiRfMvubbgWw00go5wLsxKPe0eo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b14d76-5f6a-49dc-943e-08dc11167ab5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:25:42.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt7WqQQ0Nx4L+1IjhDUiQWlD+FWS39PsRMMMIARVhJQwmIV1pCRtjPnScdhjytlha4DRy75gU2RV76gpu4P8jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_05,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090110
X-Proofpoint-GUID: xZi4NKjcpNuUJ6P4JoGWJYd7VcITdrrK
X-Proofpoint-ORIG-GUID: xZi4NKjcpNuUJ6P4JoGWJYd7VcITdrrK




On 09/01/2024 05:33, David Sterba wrote:
> On Mon, Jan 08, 2024 at 04:31:08PM +0800, Anand Jain wrote:
>> For now, to circumvent the build error, create a placeholder file
>> named contents.rst.
>>
>> Sphinx error:
>> master file btrfs-progs/Documentation/contents.rst not found
> 
> I don't see that error with sphinx 7.2.6, which version do you use?
> 

   python3-sphinx-3.4.3-7.el9.noarch  -- no issues
   python3-sphinx-1.7.6-3.el8.noarch  -- build errors as above.


>> make[1]: *** [Makefile:37: man] Error 2
>> make: *** [Makefile:502: build-Documentation] Error 2
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> RFC because the empty contents.rst to fix the error.
> 
> Adding an empty file to silence the error is probably ok but what's the
> reason to have it?

While contents.rst similar to index.rst with its Table of Contents
(TOC) and toctree directives. But, I am not sure yet if we can replace
index.rst with contents.rst. And doing it ended up with multiple errors.
So, I abandoned the idea, restored to creating an empty file instead.
It appears that contents.rst is needed only in older versions like'
1.7.6.

Thanks, Anand

