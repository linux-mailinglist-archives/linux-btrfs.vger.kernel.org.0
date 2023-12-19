Return-Path: <linux-btrfs+bounces-1045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA7D817F9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 03:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DD3B23D43
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26034468F;
	Tue, 19 Dec 2023 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgY5r3BW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CyULU+G2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74B1FAA;
	Tue, 19 Dec 2023 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0JLMH022710;
	Tue, 19 Dec 2023 02:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=GF0NE0aM8Gl7VmDPCTV28HzkFNrv9GSHqmDCPllvbNg=;
 b=TgY5r3BWh7GBYqlcR/01ZBrFMhuouhce4T0fzfKPzczrgjHt1Wh/aOvoJp/I0c0RKwz2
 ZeDIh1iNaHNVUguJtc87exUjj41AJlP2q1WwfkFe2ds/CZmfZW+MOOSUyrYabF9W3sPG
 vEE25ebMtyGrite00rXEXbbA25UsIMyLMc669Hx1NoL74FJBRs2oUk29X9woDmE15zBf
 IZv5WcI/Ub6WUtVEyISI2KkuEYSZQjQJ0hcblAGxdzN1Z4Q5YYagR+jvL+vjGoN8snGX
 4VUxkEz3ovrnlIygyd/5CuKUv7OF3AcrM+cy5L0oahSTpldVWEycn3zw1NQkuBeBIEBM dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13sb4p6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:16:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ02KcW020176;
	Tue, 19 Dec 2023 02:16:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bc6nhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 02:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRujpUJWjlA7mwuD5xsj41dv11yX7Nb9mcHrw1Bkd9wIOL36Pmxq4jpfAZOHgTWNVyU3o47ygrV+glQCDtIIEElyqlbFfr4RcXWWTymL5+BHLoG2cDvG62FM24DepSo0DZom7/I3uwN/nwPvz3nHdlhgHW4Rye+4G1XajUKt0+B91W5+b2aUHNYwIrtBDV7aIGPwNDfovPWq0OLFy6ryPkl0zcskWRptA/FN+UpQYxKa0NjQtoV32DSK+FuKFqj9cmMOq7z5CFv6nobtcGFp2n5jLJDQFZZWlVpfkRX2A4HA+fNkI6wEdksP4ZjG7h2DmhZuCy2TpJhh2UUK1MDAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF0NE0aM8Gl7VmDPCTV28HzkFNrv9GSHqmDCPllvbNg=;
 b=jyN/RI2xxTo8QY2UmMgtSCwDvSObR3KgO/3PjAve8zpcszR50diO3bu0ZCOzTpo57/xkvT5g0mEtiLpdWHHHSK+GwA+unN6EE2STRAfDzACZznCH6ogTf5CJLjJrAmEzMH5H+YgiQrlZQ5X92lN2+baoJ/zRFq1gWBMyZwTjlSJgtUldFHiNfKO0GyH80drpZfoRuAdV1X7t5cdkLcM43b3p1ag1FVB2Ur14Adbpm7dUoY2AEP4MSaD/1wgccDL995aKYEZ9Feu2Wjuj3WLuRDZ1sELvomTWloD6PrabEIkYW2+qTXTDuWba2TI6ACBWe472W0cZJT7DjpBXhHgW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF0NE0aM8Gl7VmDPCTV28HzkFNrv9GSHqmDCPllvbNg=;
 b=CyULU+G2suiDNaHFt6GCyyyRPib7NCcBGf7vaqFSGEYtfoZbC5OoOxNEAoDKpiZjnSeGd7p4ZtDYSXYVHHCavWQV6A1u90fUsGZKEQl3GV+O1+KpMhWaVfiFW+ONr5k0n3G2cwidKdIfgcvg3/wIuqvr6F8M0wt93fFxFTRQNjg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7986.namprd10.prod.outlook.com (2603:10b6:610:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 02:16:49 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 02:16:48 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Damien Le Moal
 <dlemoal@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: remove support for the host aware zoned model
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1le9rc4y7.fsf@ca-mkp.ca.oracle.com>
References: <20231217165359.604246-1-hch@lst.de>
Date: Mon, 18 Dec 2023 21:16:46 -0500
In-Reply-To: <20231217165359.604246-1-hch@lst.de> (Christoph Hellwig's message
	of "Sun, 17 Dec 2023 17:53:54 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6532cc07-13cd-4758-a9b1-08dc00388e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3GC5xXMx1Tpj2ExnmvlvH4YI6uBRDgKN56kC7xfkc8l86jfV8XvzEClsl+gpIeaUpzXMlq6cHL89jj8r/koi9H8GywRQZvR/TJb4bD6bncY61mFld7mJTq2W2Jqx4VRSgVBpxCfUlbSiHkxBMYg/UVN32Gh1r0O+bR+XZZFNedz41yhP6tsbnrD3O28DMhH722fRGUvqWIqj9h8GyhkJs0ZLtIgy8K+YYHGtv+9O0Z6bIsv4E0NdUydAUoU531hUw8qK8XPkcPHPWc5h0J/E1WSkdnyIopq67nix2bo4TJ3+lnkVOIJBzD1DR5RfmRKznx3ygIgRbC4Vv2y1KN58rfFMzNKtVBM97aSC9mDkzBSyjpyz8B69aL/njaeFhwu20M7Sl/FC0UUBQlkL1HZz1EjMWnIHX5qK+MrLAHTBUd4DixOAackQ5fWHWalrJzKZdjZQ408UE0wgOj6JdwWDUl3MCLfi8jL+cKmJYc13oNRlANBfOzgNBkh0N4ETWGfdujIsspqlRIQsF5MXSeORJF8sZO7BMDx+MN9FWIjzzRgcqQpkq5n5wCrEhSc2ooLJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(86362001)(38100700002)(5660300002)(6512007)(36916002)(8676002)(4326008)(8936002)(66556008)(66946007)(316002)(6916009)(66476007)(2906002)(6486002)(7416002)(54906003)(4744005)(478600001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Su58NUmDcDMO/9vw247v0WY8s6Q1jAjJrUXmL/cLoppO7U9S0gqAzBTk+4Lm?=
 =?us-ascii?Q?lCiVdzuiqisUT+0Fq1akgBeGO5oHq5u6FimSarQ8YM6k5r6r1kT25QEbbFgr?=
 =?us-ascii?Q?V9GRnZcCRcbaKzagVIS5hLM3H4tRfVI1Ww4unmXjMug8BS5c6gCM0RJGttar?=
 =?us-ascii?Q?dI9QAUY4avH7FnZdEBq1lTRoioRGR0AqmwksFXkJgxjeXvM+c1eaVK9hFHkI?=
 =?us-ascii?Q?YFGg3ZUIezTi1tnM5zJAPhiQvP7mA8JzlH0n8jpv5rXZVeD0PNTWNkjKA0Ol?=
 =?us-ascii?Q?bSd8/60CYehccEv3vG3mq48tGfBIMgcRvkY/JljDxs61cgJyxezRjq9f8o4n?=
 =?us-ascii?Q?yrIflfMloOoaZc/Xf1qoWQzANWGPGQ2pIBp9VCo4t78qs+jwV5vY0qWmRtpm?=
 =?us-ascii?Q?r3dZ5YbLKrRn/J7ufKA1mjAgDH/m/MvSPBCNW015t+1nR18lc4pYABwIx0vs?=
 =?us-ascii?Q?1u9MobJijRx/oOJj7ftoIQVrka0Npub8k/5IXO0oxDggJfDg22OtnQ1JuyJl?=
 =?us-ascii?Q?WbD/FiLyYktasItYowcLCQsJJ+w5H3tQJbhouj47Wl1CLqQjSN4nd8mjhTdZ?=
 =?us-ascii?Q?ZqrBN7iGKybkr1AJfC8fNQgcXgg3jgbbHQ20V7is9POIZQ7gVxU+sfPm+AuT?=
 =?us-ascii?Q?itu7TlzZJC/ZmfbZ6mZJXZlQdBCj5unjmrGv6A21FPMzLqOjE05hi2LzH/VY?=
 =?us-ascii?Q?mp97xjkaIxnWuzC3V7Di13qc3XFv14AGeBurgGOPo4aPHTGXtOkeGbih9oQK?=
 =?us-ascii?Q?466yic0vYV+NrMduxH6c1YuHVnes7tcdWHhQ4cuVkMxCLeF7j1f17BSQNHUf?=
 =?us-ascii?Q?aFnJ9a7YHuGa1tkvotwd6qGX2FTZPLlu1yU7CjsE+ZbBYtt9NKSKF9VRrXtF?=
 =?us-ascii?Q?aNAGbd4jP5g4OMGmdSoDb0PA1J+aslTQfinnUW7bnIbqoeRmRfhJFp3YoFNb?=
 =?us-ascii?Q?Oh872cz4I3h27FX8NpXjbnHdmEAvxWuJ3+yIXlYavAFAXzu8SguoeiwhwfNO?=
 =?us-ascii?Q?xZsE+LCwfnekJz6tuXLICpopQtfK5trhfp0OxHET47EgKXJt01qCLcKxCLlS?=
 =?us-ascii?Q?tbDiqs82yMJN/eaCFMtfLIoKMlnE6x/i8eZKLuSPPq1Q2AU1vyqmZqDSjkQu?=
 =?us-ascii?Q?FqtO2MjqZmimggbaMk7mEsbWQ6DmkltSj2vJ+Sy3utsbtpwnjjp+JQFiTpXK?=
 =?us-ascii?Q?EPxxstCBP91AqwkNWJgYMezEaFBm8pEIMGI+rqwMOPVTN1xqe6GTYs8HjU9Q?=
 =?us-ascii?Q?KfIewULBbKYDXmdeEc3bmBuU3nNJJAFxaK4J1eEZUoKzVGlbKbnv/zAmtD9s?=
 =?us-ascii?Q?Qi1MEm863zSiiHgBJZSm/3Pl0H1xCwsjzhm3SOW3d9wHXeu1de9PyrNIKca9?=
 =?us-ascii?Q?3snHz4XXiUnHXZy7Z2ysDrJxtZilurfs8S9uNRbo2Nuu5+RCMoeOkNF2q6X1?=
 =?us-ascii?Q?5tt6F3cD6DTFFgUKa5EMxcWFBnkBtD1dWWLAmtt4NHpG2mbf989Nc9GB3f5k?=
 =?us-ascii?Q?m8KzlEzq86WgjAS6+PNYaXdGFaSrIuvm+YjTvuLPS+/PPq23zmiteBERnmWb?=
 =?us-ascii?Q?kHsvpmCgmXyf25BWMqEHJ1glVGWJl9RE2YCQcYRTCFlRvQoMu2iGUAUAkg1b?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1BrS6xHxtkGc+gaKYrVs6qwzPBPWii/vOsvC3RkXn9Oacy3Jd4gaChvv2RIM73rt3nZExXfMvRG7t6HdEEL7SQtoMdNIAI27rTe/ywQi8wXzYyw1OKmH2fWgq5btxmgblUqfo7Hh7H58kR+OkpV2YWKVM4DkXfEgunLLkgcmkdLhZGQ9gTZ4N7+FmQE3UHm1+SeQi9jHetTLfrQXbVX+DOPJHZL/aV9/8gxsJ8ln2UO+hO6+oTglLCYJvJO8+sBACbzEglzkUgkf72+1kLQmaYPOphgu7nu29KpSDHO+rwMxZbIct6BIJPFNnV1V+iJyv2dCfg6I6NJ+pMQVjdNYs9qicVOC7vzspudjBUHYysbSjwNbJcW3HhadmhJKdmeyD5hq51SdLV9mq/QjreNKOFwyAacD+kboJK6IwVoujRM+5AKB00W6/zZz4aKTfMNUvONa3R3TfLWQV8TL2C4stiI4xvrpMRfMa1HlDhGZd/xjLpba37DihE7pgiwwfW5jsRo0lUJb0nGPWeTMROvdEGKPCop+VnAUw7qTtAsMGlQO3OsBgRTsyWrAKQ+0pnyPHS5Bv9tSVoizAZAMmmxZ8ugImpCmFne3sJiRaQy/iPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6532cc07-13cd-4758-a9b1-08dc00388e6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 02:16:48.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /e/d173UqCIjA5rASusJo9ol6xvFYyGB4j5i03RYUqFlfJLbCLTqWSeDjOsYuk+QTFfD6V7rteTmBgrErdEMFZfwHXKWnRfcM3pLLWifHnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190016
X-Proofpoint-ORIG-GUID: MJkdcGrpWyfclLxx9a4RtFQ6AR278pdT
X-Proofpoint-GUID: MJkdcGrpWyfclLxx9a4RtFQ6AR278pdT


Christoph,

> Fortunately only a few HDD prototypes shipped using this model which
> never made it to mass production. Drop the support before it is too
> late. Note that any such host aware prototype HDD can still be used
> with Linux as we'll now treat it as a conventional HDD.

Looks good to me!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

