Return-Path: <linux-btrfs+bounces-3406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C335888000D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EFE1F2232A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFE6519D;
	Tue, 19 Mar 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J6hk0jeP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dm1JyY8P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFEE65197
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860247; cv=fail; b=BnDU6Xe7n/HZXy6MdjZeT2yj7b+dxgxeaGvgaBu1tJL9P64XdUAlcMCKTYvCSw615vwi4KK9oIr+n6vHKdRfqvSSLtwKVaVYljYh0eGYpPXRwF7mHyPw0q6KrCaW8kAdDID4R7J9uB/JyW+YFF51oQYiSnp6g/vuAsUVOtJS14o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860247; c=relaxed/simple;
	bh=itljSjdfWY7VQIHaL5bjRNSFlDsNhjhsJovFbOsjWzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlSOy2c7M7+B+tE3Nc9+HL0gIBALRxS+QgQovh+xAZ9sXmwb8lIMX0m3FVQTGw1KMEbDLxlFk6Tm2i7dzhnR0S/9hMEhvkqur9LZE5Ep48TYxJsZabRbM4LLEgPSXNF9o4Ynd10rR8M+Xafk4jMBv75OhsNFDqDXs/C8PuiP+R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J6hk0jeP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dm1JyY8P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHbbP026468
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=MpRrJmvTQRw/ZgxV9WHMphH/ae7MnChToQKP0b4Dxfw=;
 b=J6hk0jePzzPPXBzHBpBCKz88fHSTeiQD6LexdfpSrFS2H+mBp1eO9Ueyuh38FBVC4rTK
 QLxDZo42XEZ4kbAx+Djl3xgYhAFtpl9za9+A/pqi22SOLBhvv6tjiq7qjH2y3WZ0Hx8V
 v7uvHOYYVt7Yls1twHCOZUdJfg60S6jfjkchqL7oqIXyExyYiBmYjRfLvIXIBqhJTqJz
 WFK4RfthNkXaV+jJAHOiWuCn1h8m/RGwep6+W/gHCcIH6ZF1u2GaCSRCQqTYZN84KKKL
 2CBBM5p098+q2J+Ty86jkvkycI/jPRTKQOgdxvGgAVsj/1xBDCh3aPI8kWI8ieeZYwEq 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww272wtu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JETimC024156
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6mrpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll8uXPu1RVmjDfbgLUAb9/V2J0zV6z/BBkIFFUmWR6IDi7Z80q4d7EwkUYe2UWEkJdgi6wxGGBSQ3tp2FeirU7OmI6mYV/47lC/JmhO6BVeKKF2BgrL0F6fq9lcXDPeH2lk8iouo+KSswKZxoHKdE0wPfRkzcpWw/TKiofWZ8PlF7q/0n83lv0kBjlRCkZPiLKpQ2xq9Lx+4OLL1svIBtflpYisS51u8+88G4BD24vrzfyAkYys3Vp5DaIXiS7HxiL8x4KQYOJYmMxumnm+nEEXgwFmGMYN2MnWulIMczSy+STwy4+O+W1MuDaqouMeJE+K8OrrlLs8PTnKUuSnXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpRrJmvTQRw/ZgxV9WHMphH/ae7MnChToQKP0b4Dxfw=;
 b=JATpmYjnSbNO8HxjZljBvSqeWwmcY4S3GgzOLIJwTGPZW1TaoeSNFbE0QSFGNcuweJR8RvObbqtI95oHv1OAw/mOKmqtuVi3XNxV8xSH9kDxHKLkiWQYY9IVJnjUYnjA4o+qOR2MlLcNmU34rT3EnLDc5lNEOcSYx+kw8+R4iP7ubhmTUiVk7gD3khDFh4xsjZgKsik/6enh8KwrxB2++ZawOS1a3esGPlD6/lWBRYNja1616Zkxp5+3PReiOiWZpBDvy9OEkd2efvFgy1UH4CAmj4H3Lzj2iRM4x4DLewkIPlipwnveG2SWfhYU1bQjdIRY5Pi/O6r+iNwv9wiDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpRrJmvTQRw/ZgxV9WHMphH/ae7MnChToQKP0b4Dxfw=;
 b=Dm1JyY8PPxm3insuvyMD2RXgeRN2mz6kqlVOh2rNny/vbDifsFpnDxa0i7elQSGC219hv728dIiXNvLRErJDq3yIUv2G1XogZHCDnAe0SVztc8PplYBSUTISHOid4mWAxMk24nwfailrEIKUN9PNE0/Ut22TTAK9ljajvqTnaig=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:57:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 11/29] btrfs: __btrfs_end_transaction rename err to ret
Date: Tue, 19 Mar 2024 20:25:19 +0530
Message-ID: <5efe4beec59e626e1290c57a55c041447d587642.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7117:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zf2y5Tw15RN5SzxD7H7IWZWY22WvDSNGuGlnDM3F2sDvjDTUlDTccHWr7KMlbp5ZxWz4bxkhAkKX+9Lk27Xh0F9FoGSmaU/wIVexMSHXRd5E3CxNEmDH2Y3J+gKcEa9qhOZpjFdW3V0ejw1IGUmpHeXxf6aTVVqPtAdRIkxaF0VF+W9ROWZJszQcyOoN7k6a6NVjUlHXCRvvbnVIOipgKwsva2pZMJmbSByUfbvEgYk2jBWJ1u6qHvJJNOOEVIdHbgwn4cN8bDUThmUF7BxBoQLHWopuO15LsDqDgB/+IrYaY/j0LP2meC0H5613azI1qCu+Vb70t9r3gJmQ5GNrpilNvX+1heS0WcyVqVecjFhI8POujaJg7FS+YbtqJvnst0ZcddUYTzHr0GPmH40fPLCvV1teEFQjBKEMY8dbyyE6jcPIVGE8P1A8pgjC1eL0BdoVzakqYXNobpZuxpAmdu7yWmVH7yVB+F1+bjV887UnZjuXUHL7fH4GCvAOwvkNFmOsQYEA7eL1hp4w5feinx6WNh4xV8DPTYoCCPQpus2Y0XdholuSzJuZ2HyeWnBUkmfxxzN7enfNmIZddIHHAJhHOoGsh2FLVNd19rGdkLrl7e3tOtDZLD1bYMsZdJkNNWMEfT8Qw2bJD7ENw+XUEZfzhn3nFDC9gtF7Xc1Rfys=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j/IXaC3w2fPc+NIN4UhCs29QzidlCbglhf4SrfePhaCmHbTJo9oZcoj2rLqH?=
 =?us-ascii?Q?ZsLIWjp8A9tSjSjTyHKhUflX43CsgajSvPXBoH0DfaMTGR42vPwGt9aT/2kw?=
 =?us-ascii?Q?zgqP0ibSruWEaboO3gCfejTnL8VZRQ50nT55O0/dG5iDPAYwFSdhmIxCWwc7?=
 =?us-ascii?Q?/iNfxvMu3lLRJR4LJXBAE582pNdUl/16lYuB448Y8CnWWVv3XhIEFaYUwcE1?=
 =?us-ascii?Q?WEOOdwYrrDuhj9rnuBTt0yZN26FUS/NdzSHzwDpzaMAvWukmstfsnKdj3cUH?=
 =?us-ascii?Q?zUO8ttYmIJDIkghoGJDd9kNdKPpERljzfjpNgxRj+rUCkCBjsPTBII2ZER5c?=
 =?us-ascii?Q?ht6pfjXs1WID0u/+5O21pOe0mi5BMHeXc/HHQha1nQ+ERxviYSNfvyZnqyqy?=
 =?us-ascii?Q?/CQfZ75kdmk2ghtcIPmq6lSEyU7FQPPKeG6bFldhmq3oml4+JS+/WBKybkT6?=
 =?us-ascii?Q?KBbDKwDOS7UGOBfthSfR+n1QO697PcpQ9hUTyEPt6PLYHvLMTGBdcmnPlKzL?=
 =?us-ascii?Q?osB6deXnsyHqRXe0NPpHXM7ftgGDjRtQnVvW+5u0wLY/Bfyg/x0z/GZ5xNzR?=
 =?us-ascii?Q?R8tETGlVAOeh2UvxrRPSVYRevuds2b4INzHoeO6Cy+bqIG+U6L/VlISEX06R?=
 =?us-ascii?Q?xd673vEKgJwbXHN8fBUGCcDk6jNadl/I8JqhlyZfpnzhW1BYAEf3CONrVIw/?=
 =?us-ascii?Q?uXY8xVTsP6coWDGeWuK/I4UqhMdi1f8oA676Z7hprqgmHHOCeu3E1h+QX1i4?=
 =?us-ascii?Q?wpLDrxxgoAaAbw/eAreltt7FSuqbCeiztfbAieL/b3smYkQ8mgb5JFHx9Hwh?=
 =?us-ascii?Q?9gXEY+4QGETk0VOyiY2Ct3S9TRNEQP+CctyC4isy4L1ru2Bn+gku6U8luyqh?=
 =?us-ascii?Q?xkEXfzrwy1QVxPR3duYoi5OmPBH11U6E+IQWG2J9dq+7UjiQx5Hn/FpnPg1Z?=
 =?us-ascii?Q?K1oxkU6IhpYQW6C2Od5Q1suGl6wPnOlXhhLtF4xSceLHg3EDliksCdCCMqeL?=
 =?us-ascii?Q?lyIq1FK07d5zBD4oNGT6fI48vabJueb3MYtCrmLktIuaFrv8zGI2Iu6mPyKy?=
 =?us-ascii?Q?ccHe3meftPZv46h+qK+/wCm5INBMWWMbWG31uoFEflWwGt0GZLe5WrO98iiw?=
 =?us-ascii?Q?1Fnm1PIoXISfWPHLBUaxqjz01ORen4+QEAJMYnzq2nZWV0I+ccyLbwvy5Hfm?=
 =?us-ascii?Q?RSbwxDclVtzi2yghXkHMVvvpK/zYquTgoDRM7tiEbs70EoT/gdE8x9EVJjMJ?=
 =?us-ascii?Q?1ITvXSD0TBOtfKQS+hhG1ms+kMij5ePdA8NbYVVPfVUhdPk1dqulplUQCyKz?=
 =?us-ascii?Q?pLU7wnPVGha2ILFj0trUiqal3pClpuZNw3hrSCu4ZtvYeaiUzefH7mv1sTol?=
 =?us-ascii?Q?vEf4U1RmAQzVwkYjLaGEwq5qQpMJOAx6/Lyk83FTOPzUwF4fCLnO3xNE2A7+?=
 =?us-ascii?Q?nquOlpXPnXURHBsDz/7lO8kclS/sOrXzhUxinNVb7uW/G8Ux4o4A6F1mH5Wt?=
 =?us-ascii?Q?V5T1IwzyyQqjSTYUeOVoTWPCD3iDInqK5Xo6dwF9jLkgQRoELZ5LjmjVgoog?=
 =?us-ascii?Q?ISzcNc0l9q5D5v7OBZU05i5Vaa1f6E+Pu1dBl+fs9FJUToZU07ucDd7dIHuo?=
 =?us-ascii?Q?qQG7e0J/WIZicZyZiu63r8wFm/2SFPDkJqEH4UrJjpbU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L1lRm4q+dchYpuNu8mdXPBXLC80NXWG7815G7YCTTkWI29orWYGRdDYA8kVwmf91pszIdvi76WXj5vAYA72dN45fO4Jt81QU0y8sTTHmaqh7PqSaLDOthiV+aZXGJqZvKZiGDwVfx3MQTra+iJr96k387OrrpnOWDXFVS1sK2YjcQsZuc0RaM+QdapulP0/LlrysZp7OXvIXt9+UVCJeY10HpbAUtyLKFtEHzrc7hobxNZPA+Ifj7L+Tpb8d67GbsL9wfSEX+aNOoZCqreFz6Y2uEwsSjXFOIO7YHcufMxVtiW64kFhRyP1oeVtLPYzXmyuFara5hAuoXasFpmZRU6myaogR8pcFC4ETFFKr08PJOBTjJ92lYRnryGif0tphcDemfCPiM5bdL9tOj5PGvWYEUw2P/YsD72hn2c5d44kb5NwIRTp9r8gwN6xknRKbtURDH/yje2QohGMB6pBNzOvZgD3BVhY0QPdLKWBB5OKi2z180mfbLYXJ9lvWOZ919A3R7Nicvlb3PHqp2yPSIvVUkWTVJorcyyVt45P1LkTHRzeym9JKDK6B+ZG5dghj4idziSH1+FnFB0V6oK3F5YqBFLZnRyf+Ll4WCwP4gGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a7397d-93eb-40c6-8f0c-08dc4824e158
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:21.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUIADkJgTJIs5uF1DyN7efyMZC3GpBP2vdbJkw+94lXrhKPBokHZgQxU+q84QM1RfS3AsGLdEmVwc23UcMfIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: 1VpHwxK-dGuQZuxDa9ucctpmaOCWQO93
X-Proofpoint-ORIG-GUID: 1VpHwxK-dGuQZuxDa9ucctpmaOCWQO93

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/transaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5b6536c1f6d1..feffff91c6fe 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1053,7 +1053,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_transaction *cur_trans = trans->transaction;
-	int err = 0;
+	int ret = 0;
 
 	if (refcount_read(&trans->use_count) > 1) {
 		refcount_dec(&trans->use_count);
@@ -1092,13 +1092,13 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (TRANS_ABORTED(trans) || BTRFS_FS_ERROR(info)) {
 		wake_up_process(info->transaction_kthread);
 		if (TRANS_ABORTED(trans))
-			err = trans->aborted;
+			ret = trans->aborted;
 		else
-			err = -EROFS;
+			ret = -EROFS;
 	}
 
 	kmem_cache_free(btrfs_trans_handle_cachep, trans);
-	return err;
+	return ret;
 }
 
 int btrfs_end_transaction(struct btrfs_trans_handle *trans)
-- 
2.38.1


