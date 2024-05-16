Return-Path: <linux-btrfs+bounces-5041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F28C7505
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4DB1F24401
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316511459E6;
	Thu, 16 May 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ohgzraj+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+KaN4gG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C92145354
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857994; cv=fail; b=ghojBtteeGc0LWzsYTQOoqh5Menv4gTcVt8t/xFgs1csVOh8z7f/VWnpSK+Mny3zjKMPRaG0BcYBeg8hTqJWjrseBCRg4L2pHgqpFtymTPu27ukd/HNGH5KRvL0yS6OrbCsVcwdyNCTq8iVWNDu6d0XYhR/rIWUETMJx0k1LUIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857994; c=relaxed/simple;
	bh=o6b7K3DThPHsX043p1yeNSnm2ba6ZdSNSZJ2xA1iJPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NARE5pIAwa/aO0fexaGtMs6CpnG4Je+wJwzF1tqFjmAfL26jyieyGtJ/wvVGzhrxH4Vk24y/xZ/lms4bqGNunumUIANP283hT766yZJW0LQirXY+ZtvwhoKGWVW/MKIDeGoY9J8BBhvw9yk3XYKOj4kAAXbmlYMOQVMe+kEVlWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ohgzraj+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+KaN4gG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44G9NTN3006682
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Zn77/r6A6x/37bZS5A1sARr355sPnVuIIdGpbfLak2U=;
 b=ohgzraj+ADOhixPCTDDM1v+k0B348GC93+6qvlsaVxCwriqFn3QxVzJ5UamiqNpwpceV
 M7Pwfm1GUiyCxgPgtb0GUbc5UmakWJnqt3xXJq8yBaVqfKn90k1MW4uMyKN5H5IVF6ho
 S4f/4DYh/BOHuzNt5Q7RM5VZvAUuFVj5g73rVPmr5s6lXzu5KsI+kFx4nQF8vNoydng6
 V/ZRvwfmLnmH6g14naYbHImjlYSAsHUieLKodFvvVlppEbSDCFwzy7xQ49X+q0tiYgAD
 flKuNURRG7mkSnIuf/0Ih8XsFf+6cK4eBrIxy8Fn2Jep7jPz2yalBr3TbAaHZkfrJIP0 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7fbjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GA9u15018835
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4ad9d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF1mvbV7g72weNLhzC1s8ovolKelZ6F1upAscFQRX/BWGzGKQwiGLQoXwBLdmv/UJbXwIwxlT1wF18s4EmoTVChlIKTTkdhl80SNf40yFa1N0ew+D+AtPPAa59gMhwZw2PGQCwl6cyH3i+AOc4iVrj2Q9WX9yinA7cg9/2IvV4xABnzpuZhMjLAxZqH39ttcnpNow3ieHs0eCiOt25Xz05+X+wUDAzMoIo0me8UUGQcMWaaEV3Z1kiD0+uX0/WWv3f6EQ9YfHVYIq2sINMAnHTGzdTZefAjzjW6FzkUSG3dQOzZ4PCrdWwW+f2/gR/BmdBcuLXTpLR0GEqh22czNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn77/r6A6x/37bZS5A1sARr355sPnVuIIdGpbfLak2U=;
 b=PM1vM8xOw+OJRPJ92UZX6ENHcYzKi1YaZin9b25cH+dCFvFDuvQ7dE5u+0i1AzUurTdmBLm1IaGUKImjLnE27zxIaN2vN0+MuIe2MLloEx7DMwmv2xWQW5dcq3sDCe/d58EhF1WKfjRezziojo4Ubv0LGQaJ4qVNn7xjJ5gi0r+O7qOwEel5DJNu8YJvhzgS5Pjw6noB0G6jg/AeTA9gf4LHQmawOQBcDfFa4bFElafQuFTL/hA+aRtQRvVmWXDFz3ZSi6xly9NTqupluwmlE86QYoMpR2crxCICd4Y9nnwE77KnKORN89pXC7LshlI2wcyGZDEvpoRNejKtHZx0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn77/r6A6x/37bZS5A1sARr355sPnVuIIdGpbfLak2U=;
 b=e+KaN4gGXIfY8rn53CzIZfif4qCjcx2LpHryVoot0/kz9Wo+M6yolWeU7N9todVwCapP/x6s+TOoh4rhfSeDs5h6D7EO8SlcRuz3K0Rn0cG6pENnL6/o7hC4IWhsSVMIoquC3mTatuBk9KG+bxmk6XpSPNThgmsvlBTze5Vcwds=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:13:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:13:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 5/6] btrfs: btrfs_drop_snapshot optimize return variable
Date: Thu, 16 May 2024 19:12:14 +0800
Message-ID: <7a99b67d236f7c98389f4e5b693014d59955a256.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: abf14ce2-51b0-4093-0707-08dc75992a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pWeSUhhpyEzU9YjDMuOJaYGmKyaG7vdFuPZKrd50Rh7qrLd+pZ2AoaluWJ6m?=
 =?us-ascii?Q?eTb+jOAmN2Q0s+tjLzlGlbsNjLwR3kaJC70WPE1yDglwDzk9/bv9MIYBZG/P?=
 =?us-ascii?Q?bIrVEA5TiQCEA7X7EAoOMJyRoxQIT0lZ9Ozg5vlF2KPNAdeJBP+2QXObp5ES?=
 =?us-ascii?Q?Z8mrNfGYWjb+d2Ftpwuff0B5uBWnnvfEiWlrrJYdykDjtNvPjEm07t4eplbI?=
 =?us-ascii?Q?rOX2YdV4qwCCVPB25BHWPPcGFor1eLb8XUAI2B6UZ0wyD6R8Cun75UgdEh8g?=
 =?us-ascii?Q?pi21uldwqL+xTyuK0PiKBt2cOD9plVtkvFWA7QFVy+lvL67w8/1IarEYGDO8?=
 =?us-ascii?Q?eNhFcUglkUDSug1rPQ916nq/jD55lD2u1GhjKx29qQzOX7N+a351Ab8iblrZ?=
 =?us-ascii?Q?0dIp86lmda8tmK3z+24xur+IrCPT2c8v3BgbSEzfhdD3VsRxAXXLabMHIkvC?=
 =?us-ascii?Q?lWYIx9/r0TB6cyWlIYHhwajdH+hyUuCgIc0C2HhlY+ee/I0GCgPij91hCvru?=
 =?us-ascii?Q?VGy5rGPgRmjW8VpZyosXmgEJz3Qo3mk5B4eSkiCyxpdFDyavkdN5O+0P6cvl?=
 =?us-ascii?Q?ZsTUE9nTl732/H1I6erGhRCKghwnUauxSfstYDJ3joWRMBkQa1M/z+0MK7FG?=
 =?us-ascii?Q?+KNWFYaA/IsMMrcQKCUKL66/4L+MqNQe1dGF2Htod6oFrKPr/X8GZbSgOi65?=
 =?us-ascii?Q?GPJmjN1DxifTQYwMkw6iUVeXIFEZIg+0zdaF14JY4jRjmkU0stIP/ePtpR8A?=
 =?us-ascii?Q?TdAUHt16jI+eIl1g7rJYvo4XAznkvAGHxmPYjqJYWkR5puIN8gV9jI7rIXr/?=
 =?us-ascii?Q?VCyKiwkLXB7bqUVFBVjs3Mz3WwakGRdRhHbXl4f1TMTpFIppYNnvXIuwWlxd?=
 =?us-ascii?Q?3OUKbEidzxjNXMrWD4qBcVUB0sUjOWTalO6nQOHqV6kp1FzO/xqxVQV7hWy7?=
 =?us-ascii?Q?diALzOXZt/5OA612uN2pnfPSRmsM3+5qqbeg6mDvuwBIOOO6s5GxWn9LrvLF?=
 =?us-ascii?Q?GTEjVIMYckNo0vPCKZD4/227T5uhudteO4kJY88VTVDce7liFHT0623qDLLV?=
 =?us-ascii?Q?+K32SztFUTb1a9PxbO0z7zBnyEklMQgrzG5MVllAKbYaQSbnxziSkIHYoCxi?=
 =?us-ascii?Q?MxSNuTk4K+bIPxj6kBMhtgAUcqCes0F726mYGfW1yF3QABnWt0/UM40VEdTv?=
 =?us-ascii?Q?iHJ1qQroIJpvmohvEm5cB9boR7NXBtIfZhbYf7sGxpJ6vTtCqHWmlmDVXceI?=
 =?us-ascii?Q?nrXqb/tLeZPblthx9NYwjUcE8Uu1wkgxYh2yvWOe+Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UkGumxUSqOiJiLTwHz3dexXIiANSdXdwWw3z+5lEH3NcIjgvB6lS0dUmH34P?=
 =?us-ascii?Q?K97ssOD93Yhdvt7IxjHasHDLj9id0i9I/v7YFpsn5wiylZwS3SZCMORc6gOa?=
 =?us-ascii?Q?RPZz4fM0Lt+bnlTrAambwDZ7RygvkmXqFoVzzFA5lvGaDjt2utKsMLvVoqFW?=
 =?us-ascii?Q?bdLTomL34/awqpSiJkIbrt2JC9qa7zJpBTSAb2wZNO8BcoGvd5uVG7fNgNfu?=
 =?us-ascii?Q?8jhaNS6Fvacd0arUetKV5YxQ52okrToFRgjocxuUqRGLUYbXtc/aQCXqzT8P?=
 =?us-ascii?Q?Qy2zjzu1EE0o8xXJlEKmHz2NiczgvlF6qFtUgByB3Asmi4P6IeCXcdkmvI4I?=
 =?us-ascii?Q?Xj0GghX4TuXRt5SrS/i+wQnrByWIipi1F37lHZa6f1pRYvMSUYtTEzMgBaWF?=
 =?us-ascii?Q?L2nebD7Eb7rkRi81TW9xLH/YU/hLoMx2pCju4AfMOVu5g81IealshgA0W7vc?=
 =?us-ascii?Q?n7AV0bp2hmBIEVIF5axGJ39sHurwxscPRpq6yNaSzr3i29plp01rs+TJlLm2?=
 =?us-ascii?Q?+Jpx1oACZXsIEeFOYTcCDT+ZngZTtOVkSNzyFDKG42iiOI+KdnWFj9otOoR+?=
 =?us-ascii?Q?o+N5AaR9HG/3DHAgwFU5ZY0jbmU5RJK2810ArwtE5QkRso+YNjBizyX0pOcG?=
 =?us-ascii?Q?L71/LivPCn1z1Eky0W+mU7dDAw5luhw4fwbWpiLBPNbx6XfOulqgwcjXw7Xi?=
 =?us-ascii?Q?gRpQrOQYPXfGS7ULNURVnTPpyVRJ6toCb7R3x505HoG3oHZAeb5m5TNDjN+W?=
 =?us-ascii?Q?9frVF9hE1cTlzZR78OexibbMDCWWCfI1wmRTbN+tITTDbR4atT5PHbwCwqyA?=
 =?us-ascii?Q?Jg/vAmkhQNGRL5xCX3GFjWqn1sVz0WM4UhLFfyJkMdr7NqhW4e2pMtKjKYmw?=
 =?us-ascii?Q?H+mfe6ZTM5bt+dOdp9mcETNxtIquKxa/3N8EKc/6dMI2chDpS7//TqId4nRa?=
 =?us-ascii?Q?NxUvuMJ3C/QwUvMIro0PDb5DLqQCjH52efOlk0YwwtNKFZSYNZuG7Ob9pblR?=
 =?us-ascii?Q?y2VfsT8Ulm/KUvx4Wy36HEOrGFu+nXF3TuP3qgDQIEJXUXfGyTHU29uUmc88?=
 =?us-ascii?Q?SLXCMy82X7wzmK8YmnlZ27uSrOpsnfxZe4ITRI6fYBEYxBpviwL0tkd9+KAX?=
 =?us-ascii?Q?Zs+mW0H6iNZvtHAMSYoDCD3PNwa9NQVABkUMHa1Kf6JxMHuFbWNUQq4Pk6ri?=
 =?us-ascii?Q?tHQye+ckChkQofHEaHgkYxwDTyRB2GxELtTbjIOHTP6a8fLCSbrav+qcwdB3?=
 =?us-ascii?Q?U2iy+c7bEQhLO+ZqPUnOm9NjT9G6bo3fequfiv1w0PQG6gVrCjn5yBp4YNNc?=
 =?us-ascii?Q?+ELNfraGuEM1/BfATp2ChzB7kY5SotEF15R4DqYgpAmvxvf0rSsCaRK+0SFs?=
 =?us-ascii?Q?NsmB5f1PP/hrAfIndE3JR8J2eTT6wO3iq072rWcyzf/Y+PUII9Xu1BiOnWRU?=
 =?us-ascii?Q?tM7oyvQXBZqdIJ6GDI/YCHrx+mTWSZ7h76ilJqIVQnIUkro6KYfeBLQXhujq?=
 =?us-ascii?Q?bIH+GUCuCfAS7fEutvW91EtmJ1UKmOX6mnJQY1/kDM6vba++bYeP2FcVeAbH?=
 =?us-ascii?Q?502J2nU0vIbyKwOvVCu/2q3sroV6pdLo4dO5cAlzu8lxb40eBlmmV8sgAKB/?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7/hVZRkVHH1j6zYC/RKo4XE+l+0gaeR7CCCA8/2g7AYTEjbUli0BHrcSzc0MhxU7dCCW3brOcw6rfr76h9BeYUw82MC22OAvE/MiLGweI6ZT/F6p5GeMMWKVm5WYL/fi9RnIRIeJx8VS9CPo/+Mmh90nG6jfSeo6+zPvyD5BX51xgkRjtRh5b0Cb1n5lzJe607NGZYPMw9c7SCMsLruWxfMpV47GYQ+D1Nw/oM3B1FLDIzkF6PpFYxa4Jlj18OPw4/XG7pgVm55Mzlz87qWMrrcy2bXTcSvKg4SQx/Q/fn16skxfoqY/+/OZO9sBLqczDgf0LviA18DGwG8pZZTeY7+RWIJ5vADmJgxhcgyRlU4X3jzC/vvB5udprjsR9qRDm/6XqlIdhjw5BjAOgmD1AZsyh/9zp4Xa5XtVENOSkhXTRs3L/VHcEjIyo1Yn4xYYXlD950BxqUHlWRaOfH4pRyhZbJvKYE+fXmJ3TyWPyw+zO5HPdunmjp97o0VnWJnTTTU9tWvMKymsPdwzalymVziNJf6wPIDQ0eKRFuBXhXPn0umZDz8bls99fsFvO+kZ6i22AvHQ+N9PfCyu5t5o2N32c6SJZpXCpdukkXDbNlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf14ce2-51b0-4093-0707-08dc75992a78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:13:08.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVBXKXIlXBQKH2o29w9Get5+XN/T1wRz5aDA/ZQv5mIwaKi++2a0W2AEqL0IhSuQjMVBjKx4maqx/d/a67943A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160080
X-Proofpoint-ORIG-GUID: zE_4FyBFCoOwJedIPC1_5UVReqH_TjxH
X-Proofpoint-GUID: zE_4FyBFCoOwJedIPC1_5UVReqH_TjxH

Drop the variable 'err', reuse the variable 'ret' by reinitializing it to
zero where necessary.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Fix comment formatting.
v2: handle return error better, no need of original 'ret'. (Josef).

 fs/btrfs/extent-tree.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47d48233b592..578a0e2ec884 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5833,8 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct walk_control *wc;
 	struct btrfs_key key;
-	int err = 0;
-	int ret;
+	int ret = 0;
 	int level;
 	bool root_dropped = false;
 	bool unfinished_drop = false;
@@ -5843,14 +5842,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
 	wc = kzalloc(sizeof(*wc), GFP_NOFS);
 	if (!wc) {
 		btrfs_free_path(path);
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -5863,12 +5862,12 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	else
 		trans = btrfs_start_transaction(tree_root, 0);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_free;
 	}
 
-	err = btrfs_run_delayed_items(trans);
-	if (err)
+	ret = btrfs_run_delayed_items(trans);
+	if (ret)
 		goto out_end_trans;
 
 	/*
@@ -5899,11 +5898,11 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		path->lowest_level = level;
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		path->lowest_level = 0;
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out_end_trans;
-		}
+
 		WARN_ON(ret > 0);
+		ret = 0;
 
 		/*
 		 * unlock our path, this is safe because only this
@@ -5916,14 +5915,17 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			btrfs_tree_lock(path->nodes[level]);
 			path->locks[level] = BTRFS_WRITE_LOCK;
 
+			/*
+			 * btrfs_lookup_extent_info() returns 0 for success,
+			 * or < 0 for error.
+			 */
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
 						level, 1, &wc->refs[level],
 						&wc->flags[level], NULL);
-			if (ret < 0) {
-				err = ret;
+			if (ret < 0)
 				goto out_end_trans;
-			}
+
 			BUG_ON(wc->refs[level] == 0);
 
 			if (level == btrfs_root_drop_level(root_item))
@@ -5949,19 +5951,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		ret = walk_down_tree(trans, root, path, wc);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			break;
 		}
 
 		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			break;
 		}
 
 		if (ret > 0) {
 			BUG_ON(wc->stage != DROP_REFERENCE);
+			ret = 0;
 			break;
 		}
 
@@ -5983,7 +5984,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 						root_item);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
-				err = ret;
 				goto out_end_trans;
 			}
 
@@ -5994,7 +5994,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
 				btrfs_debug(fs_info,
 					    "drop snapshot early exit");
-				err = -EAGAIN;
+				ret = -EAGAIN;
 				goto out_free;
 			}
 
@@ -6008,19 +6008,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			else
 				trans = btrfs_start_transaction(tree_root, 0);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
+				ret = PTR_ERR(trans);
 				goto out_free;
 			}
 		}
 	}
 	btrfs_release_path(path);
-	if (err)
+	if (ret)
 		goto out_end_trans;
 
 	ret = btrfs_del_root(trans, &root->root_key);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		err = ret;
 		goto out_end_trans;
 	}
 
@@ -6029,10 +6028,11 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 				      NULL, NULL);
 		if (ret < 0) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			goto out_end_trans;
 		} else if (ret > 0) {
-			/* if we fail to delete the orphan item this time
+			ret = 0;
+			/*
+			 * If we fail to delete the orphan item this time
 			 * around, it'll get picked up the next time.
 			 *
 			 * The most common failure here is just -ENOENT.
@@ -6067,7 +6067,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 * We were an unfinished drop root, check to see if there are any
 	 * pending, and if not clear and wake up any waiters.
 	 */
-	if (!err && unfinished_drop)
+	if (!ret && unfinished_drop)
 		btrfs_maybe_wake_unfinished_drop(fs_info);
 
 	/*
@@ -6079,7 +6079,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 */
 	if (!for_reloc && !root_dropped)
 		btrfs_add_dead_root(root);
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


