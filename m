Return-Path: <linux-btrfs+bounces-3424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F5D880026
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C2B1C22AA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDCE657A3;
	Tue, 19 Mar 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EgOVqeVj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YYw+nX7W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FA6519E
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860362; cv=fail; b=BnIfLOiT1ErDNAlnmrbbFAjPZi5lsX2W0YqWG3Q7PV+4X+nOv2otpDhSFGV0PABCIG1xurYzSXm/vxCc6MjEGmLxJSPlubRbaLgiD923kSbrwt0Anr90j0eGC3dQl02Cx/kPbzshcWVXj3JJxZmSEV26YHT0I/P2KDAdIzMQbLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860362; c=relaxed/simple;
	bh=NrKUCUNSkPAFZVJEO67fJ9G3BOuLXiXpk4no3W8QiGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=olIqStcy0J5BT4nrfbydMeTHF4AkHYjcOGSGJ9jHR5YDZfoJAK9rV7oijOOkJscFiaxYxY0m4LjUgb2A3OO4S/VPRGHc5/Tb9WUv1+6o2O7S44W7CpSAS2om6XcIiVum7444yRr2GlvloOTx/21DTseoRmcUlvqm0kXeOsdH6nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EgOVqeVj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YYw+nX7W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHn5G005071
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YLZv8N2maqoEDfJVfDlUa2TU/eIRXRdSztw2zeL9JzY=;
 b=EgOVqeVj6UzsL89+Eh/LziEzM+sjj8AE98wGlIlNwW68tL9Oaqy+wAWRtLu34f7Gh+vX
 3bLSNKPDHrViot2Ff4NrA2yH1leYfRJYL+PueEDh9/0RJLl9pyuMbYvN/Q6tVY7kKyxJ
 5pcZj1k1dYP4B7SmoPsKq9WD4ELroREn5d7bY5c1iaKo9BBfZdmG+QupddyPv7V3NCZ/
 qB+PnQVCS/umh8ymg7M/v/w6dh6T17u688HHxtjB5uqolGb13LLNo1kV7ez0pVZzbO8K
 n+k7vB/Cfv1LOlxBJgpcMHTiWjeteGBBn7QPN7mhCKtbFkXDPihbBSEAqYRsyLSYZue2 QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aadnn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDbQXj007776
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6cqea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjiG8hlJWl3tLdM5r6YrR41/ik0pBAa0gOOqx1sY+zIHGmmJ9jPE4C461TshmE4EQ3NGGq8FaJjHu+sp5mLMYty0ctP4xaosgWlDqazXpnfCI4cZmfWAVqDcHG+COz4n9tzmXN/N0XxPhycRLXtZlBAT+WHQi8UyFhTTQGNmp9Qy9OUfOHFMi8BZtAs8ev9e0oodjeZtx448NfyS8RhuAxx2C4r2yueHc9SnXhv12M386vosn7InJaZwTCR+GCtHJ44xbaUPV+V8Ae12yTR8KR1d8d5RHBLECYqn3ZiGeJ+IFP1MVnfwm0pnpzy/ZgdcgmB2JeJRqK2rDptXJUlbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLZv8N2maqoEDfJVfDlUa2TU/eIRXRdSztw2zeL9JzY=;
 b=FdleXcEtJ5KQZAlJXC2osyGpdJD0xeE9wtkOPCrDnl4um2DUezxPzNfzODdigLnTemyvpDqDCOcoqyjGFfgybonCQHgxy5eCFKwg5MtN9glm7b4FmfI048A2fy40KtXnPW6cz7OGC4Tv08WE9kBC4M2FW5aKMyR2yVRvhodsQklcb7ABbK+bfgJOlr9sC9K4A602118ohngU6lWaLfhBvdnLsYwzn6CSadyWeCePRTJfRm2MUaTf9BsIOQggsb00/N0yyp18r2ypUbK+axdE4S3SyQfMjJaLZ4af7G5juKZNolbDK5f2SakxGJeh2cEp9lwTpNauY7d54xGtdzheAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLZv8N2maqoEDfJVfDlUa2TU/eIRXRdSztw2zeL9JzY=;
 b=YYw+nX7WdmZr+y9PAooXuG40ZOBFYwyIlevKC8jsnK/XLyywmNHLhNsystx2OEM6fnjrfBUp3Ex8jn7a8WvNFAgvplBN5kVbekI+WfqwbfrAKJqJ80PlGzi9gUN+qBvK8HXLBjt835kbto/EZJAfOcefxdhcXP4XS2pzQaGPzGg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 14:59:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:59:06 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 28/29] btrfs: btrfs_direct_write rename err to ret
Date: Tue, 19 Mar 2024 20:25:36 +0530
Message-ID: <572defdb1a07bd51a8626109c9243dd7962f2cd4.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rwqtZle1K7lbpOofPgwoSM/5A7Git7w2Q5cfPWCxJ3Wz4IC8fPU96lR5PE42fod2/M3fo7kXq9qcoOEo53pny/zisryOGuRQbSeFUEGiBcKRP6vDmDj8KowMaYVJjHdVETjggRIhjEC1BqZfqp+Yf9IRM2ccIC6gcT6eW4eS8k30RmzQLYRV4gpisGNuDPiOCRmPuCwKHt7eRQ/FsN3A6shFkxeyX00VidFRu/pclR3iQwecKG7NAizs23a1Q6k/dbv+CrR6E5KJqxOLIefJE9Jo+Ng41GyD//e4FTFLBOeFpi7h8JnIlo934Eg8SXuCqFiPAz9pcZySInTN95srAQDwjHRypvL+Yy/WawKZqqWStMW1zPcB7qTIx2Rw9Psso8kUIeOu01pShXuZY/vk2qk53wApYziT6PSRhoMsAK14yZwTnpV9uRB1nxx85nISln+TjpVTJysfHmdQZTfChPklenIUjSnWtCYivBaEnsH2KvoVtrucclEYfn9Fgh2tyjq7SNwa3gEqhTOnukuxzJfAK9e3PeyzNw5+c1hojLgiFmz1iUP9rUBgf0/j4qErh9z4TDcGWVUQjU/DtT+WwlFFBssbnh/Ih4QxNk+IqFFT1Xd0gH5AEExZYevgab+Fp9xBEHoAFb51Rq0J+m3AjvNYLSRzegVC97AvALlEo9w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bUAmN1B5J10hlnCZawLjhgRrbVRoWd1FEdE4mK7T3TW+tqoLbWDkoVvgi8hR?=
 =?us-ascii?Q?v1JvLrqnBSDjTux/ulaPUTfbm/3ciPn2UxICrchy239zAew4l/EX4bKYkYt9?=
 =?us-ascii?Q?4XfIzhSJT4qUMMh9dDe9tud82PzIjXNO1oylm/oynPVhN/aVGxTDRhJbmo7S?=
 =?us-ascii?Q?j4D+IaNeeXlKTjaP+zX8BxQj4jt9cGWInnoQnB/wGPoIoqWbExVZ3/2jnJ2Q?=
 =?us-ascii?Q?aMLH7S1o9U8009uL74nuCczKnKHxjM16/Nijuh7XZa/OTqpX0FpyFa2w5s0d?=
 =?us-ascii?Q?fSmE3LwKemeXuEhIU7/mLSVW6FHcAh30XP8kS+5mzEuZYBqRdCdnA7PCRme9?=
 =?us-ascii?Q?keZOxLFxER8xiuBOEqfzmnfOYfdM6h9nTJ8cL17Fx+45q7wmshv6mpVz4Xoe?=
 =?us-ascii?Q?3cwPHYjYYIGXXyqXDZtN2pTNV6m/Y0HW2Vdwk7/0nmUz82Xh7GE85DyQX8PS?=
 =?us-ascii?Q?oKUpslJAHmCusm8nQXvPi86k6sDf791f26oacjA7orSqQ1EnkzlPYwYaOsq5?=
 =?us-ascii?Q?1RuahMEdUUvTRUS2Eo0kggkPqneifNfC+JUNFkv/ASUol960g2frWoqi6FF3?=
 =?us-ascii?Q?I8tGJUJ/YMMDQKuaggj27/bMYzSAhOWMlsMYFVwboU9LeXFA/iAB7Fh/wscP?=
 =?us-ascii?Q?9owvI5Bbx7d3J7OVNzBIhh6tNd3fL1oZdaeQc2f/s1AX2TtNVQrlGLAddVsQ?=
 =?us-ascii?Q?vrpJ7k8i0dGfD+LwerUYlARZ77aGQwDg/s71vtwFOw9KCcMo8SgHi//9r9V5?=
 =?us-ascii?Q?3JsZ1j9v2TQgoU7SsKldWoALVUEBq/JfsPmZzugQAqjx9yImME3MTYgH8+JR?=
 =?us-ascii?Q?TyE4QWrmNeVXcWpKkwyF/yvHX/dGkCk4Jopai0YC2OXL3nvFsP2pGEysqHpc?=
 =?us-ascii?Q?/kRMq+AfTyBN0ZApGHxgtIOm4oWZFtNi+TDqYQyCTQQXhREz8w52RDzUqHpI?=
 =?us-ascii?Q?BLTTqYw/MmQlNJy9a2Najbffch5tsSgH/RrsQVYHJ4+79jRujDwDUFr599hB?=
 =?us-ascii?Q?5a/SuXY73Uuu+wTFoymq7IWkHOoTltrte2RtyFA7TrNR/7PMxTj11PHbhlGx?=
 =?us-ascii?Q?p9msTUAF7JJ19bGAIZXD4wzFr5BtM/09EQ3DWAD6tNlERgV5yhU5kyxl1wjf?=
 =?us-ascii?Q?+yt6y5fiSnBCG5S6YqjCJSGh3PkVZMGIHOw7KDT1IWJSj8seXFm9ivubmT4/?=
 =?us-ascii?Q?9J99aaN3f0Lgwwi1yztqWcQspm0BRUPvKygpfZzC97B4TwZ6AQTMPeu9RXHl?=
 =?us-ascii?Q?4hvLt4TtC/GkLthLLmgYKBPh8eOlk9zGkMj2ZJkZ0UZ4TVDVaZPEFmXsTfW8?=
 =?us-ascii?Q?b8xkHTVTWXR8WrJSV68y7cnivIGwJO/DkR+uB7glwTkbT0OfxAGOmmPM67Vp?=
 =?us-ascii?Q?OOKgOwuRgabaOTnCfMgx5UyiRWbcFq/DxkOcDZPoqpYbE26nvwb8xRrdPcEE?=
 =?us-ascii?Q?Lq/17jQy/icBZdS/Gb4ywnXIT5KP1gHzKZzBx5iSXFOpo6vdNv3d4N+JLuN5?=
 =?us-ascii?Q?Vqj4SfzfSAtWFsuycOrtCsrDGT6OavrXFiPUMgWyQxuvXR4thrZwCpj2kj/Z?=
 =?us-ascii?Q?ux4FdRraiRCbcHc6tb7lQJoHDOeY34xaMJaqIDXlaoORF0c5W55N/hTQEkbj?=
 =?us-ascii?Q?aQAXBWuGjLXZG9pHTUTcfLRzBQgcA7J/C6XCvvYfRSbd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gRvRDhd5juWDF8etk6JjGqwBzujAxyKxA2bG8ynj+CxloEF144Fk9FQZcHzFeQlazb6+ctaRatGIVBXICwMMHuF5TolQxvOGi4AiaPtR7tSvZfnccd6+X5GtYP2DRXx42YgDF3dZmD95rbcuGlAFndbeymcNGB+ee1tOAqglV9rMZA+SdbKrw4lCs56jHeXda9e0fLPGDLeDKmQdxICavLrpD/DyIyiscz1NXEx2xEboax8IG5L3MHgm1LRYwks3zFkToD/q56uWbZi/wnIodPsC4jO+PM0z1hQBEf/1YQHqbtfMrFmsY5LbhwZEgdJPW7tjP/AUoN3Aqcctgkso8VEMXt0EzAAnNnP89nZ4OZ1/P9mQh1/oiFJBF45FqyZTjFydjOCNYBVRU+dGzS/InPHzuvGubk7t22qef9Mi78dvpehdI2xxqLfaVSaL0SqCOkHq9vw8ULjml0jUW+HuvgiydxxddRnlbIupN01kcmnZBiRuNSSXVl5gKD296ZaPEMeXFB1RUTevl3vwaTZ5RAz77hVgwPLwRkgQTmzZeyXoqg0v11Wxydjc9wigk4m4l3Va9ILsWfabA0ewyDaEcXKw9noAk6oBXaqwrqEefOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7407fe5-dfab-4af1-9f52-08dc48251f63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:59:06.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpjKxld3AWcM2jMJ0c3sWl+m4GNqXRPLPfzLSasSheO5BU13iRBMCYeoOIAp2mIGC8C2d/jbPN//msEomEYFbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-ORIG-GUID: -fdjwpeFkeNwTALHo3qXCO_tfR36Z2BI
X-Proofpoint-GUID: -fdjwpeFkeNwTALHo3qXCO_tfR36Z2BI

A simple, trivial rename of err to ret to maintain consistent coding style
and reduce confusion.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/file.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c22264c9cc45..0c23053951be 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1465,7 +1465,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t written_buffered;
 	size_t prev_left = 0;
 	loff_t endbyte;
-	ssize_t err;
+	ssize_t ret;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
 
@@ -1482,9 +1482,9 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		ilock_flags |= BTRFS_ILOCK_SHARED;
 
 relock:
-	err = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
-	if (err < 0)
-		return err;
+	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
+	if (ret < 0)
+		return ret;
 
 	/* Shared lock cannot be used with security bits set. */
 	if ((ilock_flags & BTRFS_ILOCK_SHARED) && !IS_NOSEC(inode)) {
@@ -1493,14 +1493,14 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto relock;
 	}
 
-	err = generic_write_checks(iocb, from);
-	if (err <= 0) {
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-		return err;
+		return ret;
 	}
 
-	err = btrfs_write_check(iocb, from, err);
-	if (err < 0) {
+	ret = btrfs_write_check(iocb, from, ret);
+	if (ret < 0) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto out;
 	}
@@ -1552,15 +1552,15 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 
 	if (IS_ERR_OR_NULL(dio))
-		err = PTR_ERR_OR_ZERO(dio);
+		ret = PTR_ERR_OR_ZERO(dio);
 	else
-		err = iomap_dio_complete(dio);
+		ret = iomap_dio_complete(dio);
 
 	/* No increment (+=) because iomap returns a cumulative value. */
-	if (err > 0)
-		written = err;
+	if (ret > 0)
+		written = ret;
 
-	if (iov_iter_count(from) > 0 && (err == -EFAULT || err > 0)) {
+	if (iov_iter_count(from) > 0 && (ret == -EFAULT || ret > 0)) {
 		const size_t left = iov_iter_count(from);
 		/*
 		 * We have more data left to write. Try to fault in as many as
@@ -1577,7 +1577,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		 * to buffered IO in case we haven't made any progress.
 		 */
 		if (left == prev_left) {
-			err = -ENOTBLK;
+			ret = -ENOTBLK;
 		} else {
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
@@ -1586,10 +1586,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/*
-	 * If 'err' is -ENOTBLK or we have not written all data, then it means
+	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
 	 * we must fallback to buffered IO.
 	 */
-	if ((err < 0 && err != -ENOTBLK) || !iov_iter_count(from))
+	if ((ret < 0 && ret != -ENOTBLK) || !iov_iter_count(from))
 		goto out;
 
 buffered:
@@ -1600,14 +1600,14 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * below, we will block when flushing and waiting for the IO.
 	 */
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-		err = -EAGAIN;
+		ret = -EAGAIN;
 		goto out;
 	}
 
 	pos = iocb->ki_pos;
 	written_buffered = btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
-		err = written_buffered;
+		ret = written_buffered;
 		goto out;
 	}
 	/*
@@ -1615,18 +1615,18 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * able to read what was just written.
 	 */
 	endbyte = pos + written_buffered - 1;
-	err = btrfs_fdatawrite_range(inode, pos, endbyte);
-	if (err)
+	ret = btrfs_fdatawrite_range(inode, pos, endbyte);
+	if (ret)
 		goto out;
-	err = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
-	if (err)
+	ret = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
+	if (ret)
 		goto out;
 	written += written_buffered;
 	iocb->ki_pos = pos + written_buffered;
 	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
 				 endbyte >> PAGE_SHIFT);
 out:
-	return err < 0 ? err : written;
+	return ret < 0 ? ret : written;
 }
 
 static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
-- 
2.38.1


