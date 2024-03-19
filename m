Return-Path: <linux-btrfs+bounces-3397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B6880002
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD3F283688
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D18657AF;
	Tue, 19 Mar 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GFvGop0w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="flm8cBkW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DED651B6
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860194; cv=fail; b=UUgLlCQnO9MWDFnSL1fVQT7oo6tOleudDeLut0HOax2YRayyQceXWkoacdC/z0v7za4p2Yjn6Sf8eIddxiMjvRIuN3YlRg5MKI9j+XOi5DpZmGskvIzf+KaRGyPO2w0bnoTdWiUzFCeolc6z70urRGXzoEvk7vFgVUHHRhAaqK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860194; c=relaxed/simple;
	bh=DhKBWfgqO8lugkAnZdsyHwjPAUEeHWUUjyCKZOtPsQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAxfPBliV751al5rTf53hekV9b7emRcha1NlcSalS8BNqt6DE0G8V2VwTATpO9CkNDfID1/3BSd25u7AIOPBt7TD5xhyahhXX/BxxNxQDRBa22CvtvOZfpqomKfPPN68cbPphq/5H9gaZ/XlSkrDdvJ1pVaL7w0B5G0SXM30eY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GFvGop0w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=flm8cBkW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHnrv005068
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=DDI3EGzAelblbXDhfBqy3I+EUXom4dUddnsgjhlhSsM=;
 b=GFvGop0wqbGghEVVDms655JHmNopsN+ZNfXfYM6Z8H+ZMSVZI81z5orhEcpYM1VEGJ6W
 mAhMqdHE6RCml4X9Yy4Sd7uFzHBxg+laX71RJYncCvo6d9z/9GVwFT5v4UVSaUdA6R72
 DpInOkHoQ15tn5+V6gOFfW9NS0KQ7Vyne+R1un/HEwaEJdTMaberZK1ghRVi73jK6vn7
 nxDgm/OI8f55BXjCvFMs3Qjz34gE48iEJJa2N70ZTPEHC2qczRv+eTQUTAYTenW8iFJW
 laK8Kl0kCw3TH2dikk/3xcQ/vrB86/qX77GmP5eGjh0+lG1vBtanQ+IuDGk8NwgamGuu eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aadnd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JENGdO015782
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6v5f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM1W+odqK85l7p/rdYE6N4LKOvVgq4+Mr7h3YuHSgrOJJluF+FtxltPOvINWkFbMcAXmiDOQiTIKvtO+L12SOphFQXNfUjL8UTEJ2j7F+VceWgAax+WXEvyaz2FNc1fvN/B8ICwdT/uJdLmFfmmZ7HElwSgamf7N+NVnRAFc5xa+2gcMZ4lK5UgzOt5NLhubGeKrtFnTAC7A1Tm6l085QKkiI6ZEhRy1SEhi2f6FyOAu/XReIGFQ99dIOgFMJkffnyuwa1wPY/he1ZX8PXDTSC4mAt88YgeYmAbu4FyOZ+/XWIDELj7lbL9hJC+3smsYNkoGR65bbR9V5z6pPGAcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDI3EGzAelblbXDhfBqy3I+EUXom4dUddnsgjhlhSsM=;
 b=Pp+Wt5CNPRZacBF/rrR4mAoF1dD3OwNUIlCBOzoP4bWNFmJEIk/GGk3WbJ/QK0qp2/FhjWBNq8vJie1plQ+i9b0mwg7u4QH2vNheSnbtrFs7de8S2h9AhcZ3YgcuWk0zXOuQGr+nCeln9Meo/pGFVzAnWdG2rLk1RZIGxLqOQtRjg15/GIFCGg9avsoq1TGK1Q5DeexT4e8UymLRDxhnSkMVxgy9SLphRJx9Mqv3w1eT59KNswQy8vU/dFhJtZpZ53ZwWRXwbRj2hN2Ewl1dhwTCJ3JpmPUCWzKtzQjswydI0T5I054WuaCztiyEIgJReg6V7yjX0DsGSQSsVSLeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDI3EGzAelblbXDhfBqy3I+EUXom4dUddnsgjhlhSsM=;
 b=flm8cBkWSpgEZ6bxnr/q8P7zLLrZ1E8X2mBm7nRgT+XjsMsTmWEX8/F1UsNj8lDyKXmzH5Fc3P3y5YhzOV3s80eSBAhcnRO9LcIZWO2cWS2AUDO47ePiLxBuZWpRhoQ2qnJtCa8uiIYfoWial0gbyxHcilHjjkqH5BvfShHtXPE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 14:56:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 02/29] btrfs: btrfs_initxattrs rename err to ret
Date: Tue, 19 Mar 2024 20:25:10 +0530
Message-ID: <b529e3dffa8b6d060d128d7eedae091be507c30e.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7460:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NLlRHoyMhZdXz3y4NCiBbXg3pR3GvtXGulE+8MBP5F3P2BI4rtwvczZgWoyoS2EuhVumfktHVQWPAWE2CqubuA+M+HDqpnA1Tsq0xWMRCku1TtlCoBOhhFLXVTCDd9/hBY1YJsMqQWIp/RvlKgxziNcIW8iNmWhywAmjuzoSX5UeqKTFEmqMMCVTNJZ3lhOlmaWfc9kST68oEvcUIXlcdD+QOYwA4t95esFGWlNJOxb2qBKoPp3kh9zJDMYU2U623J5NPlpNVvAWjdsvU8I86YGaRBm1JNk1EdpYZp2Uqa63q2K0CKzQRCVtVVivG1VDiGojnulqFVDSmvoRwgg26ino8YIu3utOdbNAmyApWCPvqyp781EnnVl/Vsf28H1kuVdrZfJ0JKMz2U2Ktj3FP50ZFfMykBVbCQYkcbldhHBrdk7U1VxiULF1iiL8eu6u2+kH6w/lga9zqVXwIMgsEM0pRVg14pYlwj9pV4gQyM104/IqkkXEOdds9Vbt2vRp3wQNJZrvowP6GdqOUdVHUFPb0QUSuq1+/kSJQs2eNg/dhEF9xfsmaOIkVZm1uZEIgJ+/E1ewkJocSu95QYyI3Sn8rZWQhY/Pr61MpG/4C0YaC8eR9TUsAY0l1HE8eMa/TO1RLLO7YRIuBYnyLUKfhbf7eVVkLDAndcbwnQ/+2P8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kwmZ8i5480YAgs/pb6iB5IYMA7pVdzOX0k8qrlOoZPwcTFVIDX0wk9q6EklJ?=
 =?us-ascii?Q?DGrR8m0cvCI4k9bRU9HVatsTfne3xvdmNNpiCZRT+k4hcLeeFhsStQFxz+AH?=
 =?us-ascii?Q?BZNtjXzLQChc5AnNYdxbMQWor0xaYjDO/YY1m4XgRuLFJov8slaRoaPgPJO/?=
 =?us-ascii?Q?pmNDoMBEMd4+ijWDuQ0B00po3sgWlfjategt/VWNdPNJ4H3JAQ9YdJO97wBs?=
 =?us-ascii?Q?wsqBrw+aRkk73/gWq73bS8q/1ntOyKA3YLqLoGyWEzh7P063lQFra3WTl6//?=
 =?us-ascii?Q?cefM8c5pqQa02m6jnEXBPTX7jfm52HqTbaUZ+gZN7W+oNdJdOl7YeNB7FbWZ?=
 =?us-ascii?Q?yfqK2Xuhx5Bd6ZHNcxrvXUO9sYrKTIGo009elQOaSx+mcHtmw/01joZt0gsi?=
 =?us-ascii?Q?ERUdnhBtKOtIOIGvJ4qtKy1wK3Y4BSL99JiWIdOzv4j51bkGx6FygrSbzDWh?=
 =?us-ascii?Q?ECZvaHAknQBJqCWSjRS2icUbG8zGB+Dz8XsuhhwQN5ZjzBWOW2wMJAVBXF/2?=
 =?us-ascii?Q?Y7uf15xqo8CuYs+YllxoKEa07LTQVQEgudjZt+Siw8PgrwYwQJ0Ec8LItNUH?=
 =?us-ascii?Q?8HL835ALuU6A7/Y8JjF2ha66lSmq58XaCnD0etCDGHGquMOSGAVfBVZscg+M?=
 =?us-ascii?Q?ujB7eR2RYJwruPu9c+1QVqvluTZhaKK+J8XfMGzU15jmdHZSkTIY3gQVbWlB?=
 =?us-ascii?Q?nLOhuD+iFWuOdtRVDm+3Sy2icHbgEQlrjmjlcKypeafYOoTOACuqKoIwZ24c?=
 =?us-ascii?Q?c1dMouDd25rK4AH5iiOy9LFAMrPAuYnk1E4HQGxpAtnUlIiligFN3eurVc8R?=
 =?us-ascii?Q?KNYHCzCajgma28+HazFztgNKvGwH8ZtZmtNuHe6Tat4V9U2eiS8Xe8NC+4Kj?=
 =?us-ascii?Q?xnVLPD729iGnX20J7WcWXsjoxsNUz6F2p2s4Qm29YQAolf1wJCPni5QK7RgO?=
 =?us-ascii?Q?rm/X96RlH9u0lX2bEQDjnrSMfhAnkjyIPeyIIJRYcdMfcDBluA52L6XO9abb?=
 =?us-ascii?Q?9UmMs3sVGL7Jepa/oiW9zrQ2qIs64xrwOhAlQNIp8WLLpOkYN9TIgnD/NGBl?=
 =?us-ascii?Q?kfNWhdT/iPzLdIPeH6zuATt6FHW2iViiBWVlf+FBgF/vgdAVE4pTU7T8VcYC?=
 =?us-ascii?Q?dK/qxL3aNsgqjpQqlfwihGhhc3vnzrqmS1Ywa592avil1gfvisQIJ3mlvR5w?=
 =?us-ascii?Q?DmDrnRwQ4V5qaVKuCmvPmGkrZrnfyVvUtPql/10Hx65DM0EA9EiQtqEVohv7?=
 =?us-ascii?Q?m9GJgLcJ5B7x2MSZY/uUUqjgfyZoQe8QVu5aCDSqQF6gB5oBRdYaYjuIsJut?=
 =?us-ascii?Q?jzMDW97djxpkKxBYh5EL6ZmhnwP0ZytB+3myAan9s8YlwvFh39W3rX7JZaBa?=
 =?us-ascii?Q?kTy/Go9cK0ad/kKuUfpIhpo2Hsbdae5fHc7p5WrPRw7uT/PoDoXHbvOdhqU/?=
 =?us-ascii?Q?IXcjRbG8V4GYVqs9YX0+qU0uKQlHR2EsAQWHt95n6N8AUDa7q4lX1X4RO54S?=
 =?us-ascii?Q?2WFt99NDWAaqYWw1VtFvHxIOTviLJqqsc79ymkCFVyyNdcAs0Qyf3zJVNFPu?=
 =?us-ascii?Q?p7M62Fu6FvvPqhVtbfL3b8g+QBRCOXbj/BtH8vm6D6nIX0Rs95eLmCx04b2I?=
 =?us-ascii?Q?0R90ocvnZMJ2+OwW0UZFVbqf1tpr2mXM054XBHV72Ubw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gbHvE1ALJ4q7p7HZJYrt4BM0u+3QZ1huUTzzvg12Z6NDcQbu0gQflbxga5kv845WY3TAt2XWh/2YKdqplrSqSwYQRiV/tU4YOUajsYOvDQ2ORGqMupX3yKlGpASYb7105RZ85jhcE/GS52tkgdymnEgE6n6iE10oAmGSNlk9F4RZRDSqpzj2/X/xPS3CzH8PSdD3qMqyRfFDFZH+Kf7gO9w1MLyC/DaKx4/NURScWGlcHAcwtY/WC3zHQURHogdD/NIwckfTawIs5gm1AfrV26ekgiuQCWw9Q2cIzdC/WSFXymyv2Nvhu7Po978RaqZZ+KUsrqWXgUJVrcCaxwhYuQjSZrU5s0CO8/J13oesbravTVgINiMB3UmwRT/1+ZRKhL0vBCn74BYD059jTI1oZYpWhvb8wQWz8VvSog6wbS1lHQpPjHfH/CvcTKQH0f3f/55TYElrNwMITrFhGeieWYc4s6LWNzMrGZW4uIDlfDhTfNNfF4k4qsrJz6vVZRSTNkwpS5pDtB5j35o0BP4cxyDA0aA9t0SWo3I6b+thKJCUL7OpbbKirrisuZ5eis2MN+/OkWPFXn68DtNkYidBmyqnXm5agj/xwZZegXnoAJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7326c03-81ec-4682-51f2-08dc4824c164
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:28.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6T/RyUiMeFIrquETvTeLHjmZ2YUV2heRgwoYu3Hu6JuN1aM1VTNrkL5vERoJm4z0hu+8JWsTEOjI4ptv08Rng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-ORIG-GUID: EV1bRwfenSHQN8S4m2r-hJ6PmEW_-E1X
X-Proofpoint-GUID: EV1bRwfenSHQN8S4m2r-hJ6PmEW_-E1X

Simple renaming err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/xattr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 6287763fdccc..15d0999e340e 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -504,7 +504,7 @@ static int btrfs_initxattrs(struct inode *inode,
 	const struct xattr *xattr;
 	unsigned int nofs_flag;
 	char *name;
-	int err = 0;
+	int ret = 0;
 
 	/*
 	 * We're holding a transaction handle, so use a NOFS memory allocation
@@ -515,7 +515,7 @@ static int btrfs_initxattrs(struct inode *inode,
 		name = kmalloc(XATTR_SECURITY_PREFIX_LEN +
 			       strlen(xattr->name) + 1, GFP_KERNEL);
 		if (!name) {
-			err = -ENOMEM;
+			ret = -ENOMEM;
 			break;
 		}
 		strcpy(name, XATTR_SECURITY_PREFIX);
@@ -524,14 +524,14 @@ static int btrfs_initxattrs(struct inode *inode,
 		if (strcmp(name, XATTR_NAME_CAPS) == 0)
 			clear_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);
 
-		err = btrfs_setxattr(trans, inode, name, xattr->value,
+		ret = btrfs_setxattr(trans, inode, name, xattr->value,
 				     xattr->value_len, 0);
 		kfree(name);
-		if (err < 0)
+		if (ret < 0)
 			break;
 	}
 	memalloc_nofs_restore(nofs_flag);
-	return err;
+	return ret;
 }
 
 int btrfs_xattr_security_init(struct btrfs_trans_handle *trans,
-- 
2.38.1


