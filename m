Return-Path: <linux-btrfs+bounces-2404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEF855A7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7660284E88
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB8BA50;
	Thu, 15 Feb 2024 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S8RrJjbW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NfWZ1n73"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0744BE65;
	Thu, 15 Feb 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978892; cv=fail; b=QsHhJ5W6C6tsT3388Mx8sf4H+vAMyMkMmigoU7rCM6OMceaKyornYRWT33AnVSmWuFKxTmvT3RzYo1KiXb6tY3Ymp+ObNlgn/gng0+wRLPhUEPOMLiGVH7QDcku//Jf55MvgTVJfFGgXVJ9/pnC0n215h2MIWD3MaHMuVuHn6EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978892; c=relaxed/simple;
	bh=n2WU6bpMCnMwiF/2zKtxA+lLCG5I3H7w4IEPLUu2ODY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmUrcXzyboOHMaUWpDFNYeHARklCvs3Sy4M4v5eTGVJAqni2ikLtz7JfVvsAWX6eM9HihVYD7gwisWhqRiMD1l+gYrTGqHeUlEcdbOH0A/FJpKuy+K/k0shyp4Cpkfb5Pe3SR3Jt6UDyw6yt3rBGTlFTNmfknSfItLUVZ3N8ciw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S8RrJjbW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NfWZ1n73; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiCQB014100;
	Thu, 15 Feb 2024 06:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LuUThStwsZiRBn9CmI2h+ngodEt3HD1l9nRO9ZSKtCw=;
 b=S8RrJjbWz8aKlofipNUUma/F3tmJKOxjC17NnClLxVzl+ZfudZYsZPh11tc6S6c8CVKQ
 upb7Pvib9p0NgVnBWAiAWEgALlrqpDnFuWvvpMpgWOZaMlDmACEbnlSkT/uRPGXLIxbJ
 xt0jFlGNwk5NObP+8ZF0sM7PUFm5JG0cfH9ITACjE7YBF4lGvi2koCVJ/CilzUlwXCy/
 aqFE0JWytQM6XZ547CUFvVsEqjDnEoZSj2wRhHDye5dCvFSWn7NiVSM47yDbZ9eQOcbN
 b/Lw5JJrP58qYCqzawh8mcqrp5xYfsFcaJb8Q+kEFjLwZek0fT8V89QJh9rK6giNePj0 zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f01d84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F4g2MQ031484;
	Thu, 15 Feb 2024 06:34:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka1u98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQpyouEHaB6y6ZGyx42W2irVHivXDj90+GLAZ2HaLeVWa7+LuYOStyDefdpnnt6fmtF+/1PojYQWCNE2AGRppuYopivXn6P4jHdO/W2zo53L4gmJPFD5aeNkTO/9A/cxdMEzhP46iMazDt0BAcZOk90s4Z2sSDHx8LoMSUWw6NAEuAKoAxT/GcnKGCsqu/EVrDyxqow+Kvc9i9hAZFEmJA+dvdW/YP//dviL4K58GGwDRIZTVbhI/nS2nQo/QLDTEyr44xsKE4j8Fx4of6c3XeA2HSGFU6yhoY3+r3+SG1gDYGlYOty+XiX3qgj/lvKNW4qIywWjfpgg4xfR2JG3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuUThStwsZiRBn9CmI2h+ngodEt3HD1l9nRO9ZSKtCw=;
 b=ixe9ynqH3CGv+mcZnHOd0pze55YTNfnQtx/iYv0cOgAoe3mQ9SIOKJWCMoNavA8PIk1Be6OOOTpX4NMAn0b2xrlym+azdBb4XsP17aQqDCrWSMeSLilQ1xeWbvLAFpSdBVKYPDWtJcqmKMcHx/kRQNEr1XxjxDek1QZ2bHL8k0SbLry0FMWxQDHZNUfceez/LU/HgzxUTept+NllHpQOltlS6aW3HUqoaXhoHpzPCHoLQCvKVdftyY5ng9fs6H0Cy05QMGbd18t0mq4VNHK36DnYkguX2d8OUyD3NDMGg8UcwLoft5NkzFaonbWNy4La8oe6xpIrZF0svJdfM2Q5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuUThStwsZiRBn9CmI2h+ngodEt3HD1l9nRO9ZSKtCw=;
 b=NfWZ1n734sTWIXLky34nPekkBoNKzdAmfpUMb9CGYqokOH0phlKcmJkuRs1G5LLh50R0doGKrrUV2sOwSR78sQd9YJcmYxsh8xFM6g3Ftv0qE/09J6bTEYxW6jovNHPKqggdTFp9blQnGDuqY539oFSQywN0/DhJ5vQOxBqrcsc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:34:47 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:34:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/12] btrfs: introduce tempfsid test group
Date: Thu, 15 Feb 2024 14:34:06 +0800
Message-Id: <8b09597200b5ef28be39ed3658d84e9b22febea7.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0555db51-b321-4291-7141-08dc2df03415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cdhROswgboGZBahZ9R8BME/Vlx0sGCsA1KZMaPTUuof5i+vH9zCYkEr7C+nxY1B/zz0AlQU568ImLXCgP8du683kqo730j98FJZY9yvwRRd/xiG3AR3ups44STZ2heXw15tdsksGb6uGZ1aYO28Qfk4v1stmdnTWHwFOL7rRE3P9DUE99lguAXnVE8Ugtha7FlttRL5pfAfc58RTiTHNu6GFJyE3QA8sNDuMdYMoPycj1HeYA9G2Ty55+1013aMDMJnNux7z7MtUKRLIRpGBMGKjxNwfOXUpPC8gVOFqMZnd47HdNeTDO/2e6zSYKfMdf5IqHPByEcYA3+bmXlswylSLirHKy5zEYXwH+2iF3px3WHIOSkfCOlbQdMRo5OHJYDjFoF/x1aiKnR0TUXv8D3rDow3xYL2X3JrXTtwecRDZ0vU2fAefO3KFROaR9mXbImtvqpN2qqPxlW6saZ0m+N+wTQA0vvKzlCj6YpPLt4VxKTtlxt3qLMFPu/zxYI8ziZLwkdyRTud6O29x7q9r6D55WdoZX2WCaR807cfQ8BQhK5e9lswhmklYm0yAqkBk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(4744005)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xDY3lEpVwICUJ+IJsVo4qtZQQjQ0z0EBqJOVO+9thSxMFsvn1v640DEeX4Pw?=
 =?us-ascii?Q?6Qe1kWLUYnmR18pLGWR7JPozXtGCHOmg3gugzrtqrskee3A2HHorL63NjGwe?=
 =?us-ascii?Q?cMH85NxPhBJ95O6VegZI6cHTcgPbcQ+ihypU+vb7Tfg9epA+mwXRqaOc5uzb?=
 =?us-ascii?Q?2sxYpgLTUsrjDUHYKfLP8MWgHmyECeea8xaZImokLA1ccDFaDHoczQ4f3Lwb?=
 =?us-ascii?Q?AAso2CeWCdb+QKsSCDvGZv/4uKCvHYdOXlRnbE68pHspPPaqvpgCbz8yEP7F?=
 =?us-ascii?Q?fORetIc5K2MqCKJ0DIBMQ4C/PoJTohOzajd3+chNdnbBYIz2S8MxizfGKnmX?=
 =?us-ascii?Q?rjxqAzntrioSyDoNQjFPxR9e/u41r2sva6DGOWwZ/+VKP+tvGIu+Klvs+Nx/?=
 =?us-ascii?Q?Fdg3gIN7UM1U51p0JkSIgLSm0Di+DvABrpMp0ZxAESYkp24JzWl+Va+lkSec?=
 =?us-ascii?Q?ITrbPIuTgdT6Rn26ac5UnWMWYrGElpzqN6dnIOdtptd4bXi4TrQwZdcezttN?=
 =?us-ascii?Q?OYGGPdYuA4xk5jcTufqCkyn15cFlFgjGYRiMICqWrp6u7GD740H+5Uh0NZLy?=
 =?us-ascii?Q?pPLHEsm3SQoZXEPoIWzKBFk0SSDQWBJyCTAtFAWFfK5u7kjXnmDiafTpttGa?=
 =?us-ascii?Q?OljNJRSa8QycjWS5oUeK8Qvo1ug25oDSTyOUBxIdccw2veH31P7ZWaWKG+tI?=
 =?us-ascii?Q?KAkNjWJYoQuc9bgsnhj27ef5AjmiOUm7AMdolZvpVbQpX8qQAj0bUU1DO5AH?=
 =?us-ascii?Q?4QIYpdE/OPUOoNWT2/TIjEd9RvpXRQX5J9vWugGnTXX+Zs4OGUBC4/ZL55nW?=
 =?us-ascii?Q?2oSVWFBxv5stm636m6v4kqn4/wNGmr5uZESXh0rXXfC/GruhDgsyWN6PL2dR?=
 =?us-ascii?Q?MDCk6UKH9x9m4EXWuHlX5aiRtbEM7ye2FD1q7+ezbwFQ9TVQ1rTPDgyNrLmM?=
 =?us-ascii?Q?9I2CfjqjKNvMhDvK/+VP2xHXAlkq9nWjL22kAZM5WVN6ItegEHx4xs66eRWC?=
 =?us-ascii?Q?m3lz+4KbyJGGgOa75+h90BfZSu5MRbaxstzMdtP2QvXd3y+vR9Zegn8jpD2u?=
 =?us-ascii?Q?bJJk+KoE+LJva4Dukqw7ecYP08aaIMi2SRiGlo7AcdCzcSVLpTgEEKqAnD0G?=
 =?us-ascii?Q?MePvAlOqXlkyyN09cXhnzATJgmKtL+rD9LPb2VpKA+Mv686JzfgsKpRyXwOr?=
 =?us-ascii?Q?jxGYXw6sVxp6GVboixLTgoGVL2+ybQh4cH9DYOgSCMoYqcL7RL81QkDSWNL/?=
 =?us-ascii?Q?ajIqQtNt3ssLPvisPlcUqjrZfny42XhxSQu0ORGC9g7NTtfornKaFJMdqQqT?=
 =?us-ascii?Q?4ZwG7OMFZKc+OlN3PoevXUE2kXoljYun5zsnkeWiMcq2Cs+2CSbQQucK7MQy?=
 =?us-ascii?Q?r9v9s/JCyAJ0o1W165/7URm/lg0r+aba7J7pHnORSxcI1rd4pXdrgK6tVHZG?=
 =?us-ascii?Q?i5qJQ8IWK047PmRjxVXlrGo9KeSkXlxI4ayjg/SWeyD0Y+y9tqAaes3x6HTn?=
 =?us-ascii?Q?zrXEMZ1WMeY+IQSy0NCH31cWqd2lqhpCEIHYGgZp/EgkGoH7X0WWhnoIEODz?=
 =?us-ascii?Q?VaiMFbToqTccBwj4MZ4WThh7i+AkP2UexA8K6QYD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cHHKStsO0EsIwGg37vSu3Kou3dWbrhKUmyeo1ybFFqXV4IVvV5dXuINrnM3epuKy7YqF/aqRK4VMljWucyLBPom95cGVbn9AZicNt/vv+JhbqiGhY801OyHtxgAyS9fPEI90hWrLlLfHcH4t40kgeENFgf10Nt7WYi3CpebkViOqogx1eZuIlv75Fng5qdn3Rd7iGT4K4ATuXnIshlo1CCJIFRa3iUYI6UUzHvKs7FFr6yBzkW1mxsUSV1pWscYyRMs4EtjQqygCY3LZTLniB4iQuUq5xYtS0uQN+Z6SdDjIvNbsPonTjrxY4jxVR3omNcOLYo84Ue+O5Ba9UrZey/tMrCvC+W7ImJfwnEMvTkyrNOhidSIUWPutfnfhoC/ybGFO4Mfqm3S4ys1XDjorSEqh2FK0/auqWBMfqRokRMpnIWw4IRiqoUSHk1da4757QFMn1yzNqF216Ml4JND3BL+2yDfTCGjms3V1zdSoXY9+P9b/YwUYXrry2T7qM29Xy9aeVp0zgqyD2yu0TW+7QzAkSPgvKEXkwW+x3CoKKprMDglTLWkK2TL2nm2yHGiZwvlSpjaAikP8kOl0NLSgv861BQx6II/oxoDZnzU3M+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0555db51-b321-4291-7141-08dc2df03415
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:34:46.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvDgNExvuNdC4srrJtrwhk22DH/RgG6hN4x67QBdKQDVNkIs4tNKihkWRqrxhFB0Lohdta9GVhy7jVBW9JWAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-ORIG-GUID: MncAQuH3NAp4AiZWeuEKG-zwodMgE-1o
X-Proofpoint-GUID: MncAQuH3NAp4AiZWeuEKG-zwodMgE-1o

Introducing a new test group named tempfsid.

Tempfsid is a feature of the Btrfs filesystem. When encountering another
device with the same fsid as one already mounted, the system will mount
the new device with a temporary, randomly generated in-memory fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index 2ac95ac83a79..50262e02f681 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -131,6 +131,7 @@ swap			swap files
 swapext			XFS_IOC_SWAPEXT ioctl
 symlink			symbolic links
 tape			dump and restore with a tape
+tempfsid		temporary fsid
 thin			thin provisioning
 trim			FITRIM ioctl
 udf			UDF functionality tests
-- 
2.39.3


