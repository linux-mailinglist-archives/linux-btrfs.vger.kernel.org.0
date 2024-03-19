Return-Path: <linux-btrfs+bounces-3410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE9880011
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D546284CA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE72651AD;
	Tue, 19 Mar 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xyx72l2r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wfu+Mi1y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353AC54FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860271; cv=fail; b=EgB5SsSps8wWnv0TYQDvAjL3fFvr5NOsOf/p/G6VTaHT4wv8qyvNhhM/yyKgKKwtsfJLJQCE/qYT3uAD9J+oji/dTqtuMGwf2+xJxlDKK/ED5SNJI68Hj7GxBk/DPUzBewJBr/dqDLb2hum7IoGJuVvbRU55BYwDH6KlKHOCMkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860271; c=relaxed/simple;
	bh=rmGvMRcdotu6U/Zko4IJf+JZVHhtzv7I8UlMf/zes9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlUu92xcnwJDb4j1LOSaMGOBME6Eu/tz75zCPtVQrXNIe/5xpyUGE8fAxXXsGPX783Mhf1yVel54YLRNdutn5Zb/xdQY5HQ/HfCso3gexQeK5n2wOV4Pt8F3etO9Qb9IOVn395TaDFa/sIEwhMT+lNDW2dcPN+nKUt3OjNHY8QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xyx72l2r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wfu+Mi1y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHIJp005080
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=al0eXqa16pqYP7ZwHXT182EMroug3UBVWwTc7dboXHI=;
 b=Xyx72l2rjqWSId9a0B/V7p3Epf8tmzdP0AM+G8FX0tf5gDEmKME8Mkw5qzFcc7z2STyU
 jQiIWhYwQpBUFdQRjcIBYcBE16CTEkXuIWUvrm+dOPPuRsxSiau+KiExa3KFztQpF/+i
 r8z1/VLYTgM/2oZyROlFvMTsS9lAJanmlM7bzfevcIihrFBKIOyeSxiumVAyYUwv0kMu
 ucG2aAotG84detZqvL5es4Oi8hVist/fqt+9+JzMx+NB9Zg6TSE5CWUebWcc6D6E2b54
 YDltTcvk+uUHr8MpG1A0COieUTdf6po+69KHP7N66VfkHbcLFL2X/twWSDL0FfSPtg/l Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tnsjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEPgj4003722
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c8rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH5vyGEkoTML1vk+Yb8oltRjKNX5C7VR8/eKHhZHm50vxOTrbX1nvTQ48bLUbyKe1SQGOEOvFre3ZGqWGYMF/e1wUXhW5a7haiKVtdAzXoK6WSR7kYZCZg5kEsZ8usymbfPHwLpVC6yBzG8XpQPA4zVrLdowCniXiSxmVjEXCWh6gsQ3uCsp1BzAVU2raxbK9ReXwcDmfT2NdEVg2r5VhM0Ydf//0e715Xo9dwo5+aAtFfpsuGSN0svIPZJnLUWVhEwibUE/1cMgYU63Ca+3tcEpKyz8mjdsWI2I+rN3XtWKpjNfsF0X5IOmtw6+5PwAYHbJWzqfl+V09ZdL/vVQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al0eXqa16pqYP7ZwHXT182EMroug3UBVWwTc7dboXHI=;
 b=U8WgYHHMk0ZTwd9WL4pyIVjLzsN9NMeDQBBevR36B2Dhu0jLVLBhPTnELuD+DmiTTPlrrlzrLTtR3GBQCWsbsfo6e7HUm2x75ayHXfbLXyIdImwmlW8EtQWmZ5wfK+fA2HNDftO8k/9oNPoFzFB54Ji1+449ut0UT/N49vHyDQGtPJzP6mquNCPDGbrAdnMg0vqnVCIqqP9ZzFmAQC2LiRFjyamtGTQVP4jA46fQUw7GHILiU2qW/gpna0i6k0oF9UiVLt34DYXPLnd4c/qhYx3FXm69FvdP/mz7EAnk2mLyTXcmle9e2S3dUVoqhu4MnzMAXWZwYZo4Qj+2tB56lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al0eXqa16pqYP7ZwHXT182EMroug3UBVWwTc7dboXHI=;
 b=Wfu+Mi1yspusi5Wv5s5eiXGxrJFJYQT0+rJZfTSB2ETp4z43kiXDS8FMzeCQ4i1ZANEb0s1Cx3FnAx/dGZ99KofSpCYUtOIXVtG4njd/IH8yi32QYWChwXUBGqMdTK5T2zQjdJNsGvNL//XtyV0i4Yot74jNg8biSlZLdndGMRw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:57:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 15/29] btrfs: relocate_tree_blocks rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:23 +0530
Message-ID: <4fb96310be2a8a28757ee55042321749bc6d1e69.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xh7VGlgdKgqqh7/2+FmAGFY5rBP1UaU7+dBzMWRVYEub16DTv0o6d252n2Sc8+sQOCpKGJoSZpTasmj+Dd0ibwVfFuzV1iuVFqs7XLtx2Nws8jFdRcFMKc1ceYDdwnbPkspN4IE8iVyunkt8rd+SUaPBQZ/NZ7gAJEC227DU0TR5QJkpA5A7luT7FFYhB3oa7WZBe/57p+GQWvcJQWws6k+PMJz0CbqyKaNDhyXGCfx1Q7AoY9tp5QaEseSrAJcgpA0RPFhWbDNKDixQ3ZqZC9fvpmaj1vTohlS+EcYCOn3+yj+pIJGGEIAHCeJjM++Y+RPw5unSEhr2fBUGPG536NGY32bcTG1J3WFy/essSkG+ciRI11cJ+AQkTCgkYy/Mc8/qC02kup/1Advu7ZhUL5oJd04zbz8J6s8XPuSVCwg3MkJIfI5APnrL0tlR0IcyGZgrkhYCfZaVRq5Rdwlzy14+83KMEMZ/TOaKO67KGi1FF3wKQZEpLtCvKyz2w58wtiAvy9Z4G8wcttfWdWXQOq0vztItNFDgk6a1RYyXwR3Au27P/YUPclLQSUiRrO5dMh7ehi4t+a5VoR3bW2RDIQ+Pwisw2xsPcLgy5LZaC/hhSVtmaV5K8/WAP11znGytyzzyxhhh1zr7KuqupaKrdSrKrIMEmqViZXu9BpB6ljQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sn2oiblM3W2hqFxs7CFSppNuOrsuNPjVaYUwxu+WDxow3Y0+cPT5PigyKRpa?=
 =?us-ascii?Q?RNZGYEM65s4p9EfDHJZls7BB5cF0+Oudeq9fmXxoPOx/NzMpJb65PI3SstLM?=
 =?us-ascii?Q?FHsZlBVIG3IsTo4YN9Pnjo7wllu60vv6KraHOaGFXy4CqwB1dgq2Q/tWJaxT?=
 =?us-ascii?Q?cfdOPu9giKcSNlkbzjDErfwe2fTV6B8Us30p0QxnDAY367W6s3xqex31joDc?=
 =?us-ascii?Q?GMQJH12GfXN2ogdpcvEfUzjVjwE6ZeFES/aVf2onPDgmsHWp27EtuuJtNK/B?=
 =?us-ascii?Q?R270dE9bSbAQ6bL08aTUnDg159+o8n8lfy6vsNb2bUgv7RlviuuFTcalQNXJ?=
 =?us-ascii?Q?dFXFfUToAM3zRMuQQf8xI6RhYD2W99SGYiMlDjqexolcvXEmHjA/Oa8l2c6W?=
 =?us-ascii?Q?wvw5KsDrw9+QQ3MQmZofTxh6UgJ2fDL2IGUrHwwMaoY2nBUz4WgdToOielW6?=
 =?us-ascii?Q?qRDG2bp5trhuitiBmv9zlYZuhOhpqjyNOyDfMArfaAMGjzbspAJlj/dBk9c9?=
 =?us-ascii?Q?Saln7HuttNk/KbWSH1/jZF60mVTx+6ZJHjPL141w/z0wfBzscJKNUjmecF04?=
 =?us-ascii?Q?r5cJzCNguEq4FoIcp+3x2QGGWrayO3rrmqvIyf8Y2DKKsauHS+Kd2Z4DDDYb?=
 =?us-ascii?Q?/sBYbjeJrN1eGDGguDOt7JL2hdOXZuYMDw8JJQPqjKduuUp4vWuM7EaCvwfU?=
 =?us-ascii?Q?AIQos4IF9XfKmdR0LXh5VqgZghoSwZt2+hrVoLQtaTDouWERxGeG5ThWCbHF?=
 =?us-ascii?Q?wB0QPy39Ew4CP+IciDJeIcfWBX/0VfeiDUdo8mD/tZcTaAS6fyX3m6BC4aSv?=
 =?us-ascii?Q?z2TlF2bN07qxMnK5Bi4wgqx1NvOxKxEOyk2c0DVjvg1jdeMSTX8rs2SQBNm7?=
 =?us-ascii?Q?5e9NFlXWQx/GodzPKtyada4Dzc1hMNUHjnhoNMPzTbeQBUr8JyGx8jXs0hqM?=
 =?us-ascii?Q?fjVfCLK1R+EizOHEejHMn5D61LhCZjdvzjrtKeGa2n96bK3mzhHf7SpEd0Tk?=
 =?us-ascii?Q?6aafFW+8oV5ziwPVYKQGI6QrMpvUnwZYoR/GEXgjtjXFQyXcCefO44CLlIs8?=
 =?us-ascii?Q?MZI5svVM23sMStIKcv/dQii+M0VxUImnH/NabScHajdR463Cnnzk8EHtas1X?=
 =?us-ascii?Q?HSaJFYLA2OJbVx0b7KcSNkxZinxySbHSBG17HUc5Fh89enRSQ6CgSsawf34E?=
 =?us-ascii?Q?B7LuRSYTsW35o1u+jjjLylaDBA1wXSfz4etvlqlnvBlkaOiy1zLlLd6TeWqF?=
 =?us-ascii?Q?6dKa6pbwKioEOI6LsXvM4/L6OwmFwG1fTdm2W28d0X6Kxzt1ce6ZVvIg31j+?=
 =?us-ascii?Q?e7+FzGXI1Lms5SqtlkKgZbuxNgfYU4E2zvn8Cuzul5ABDdw/dYVtBn2u7aII?=
 =?us-ascii?Q?BYqn8hEK51n3vRNCh1mj6cuaCTtaevVeVL/91NlSu+nyh4jj8+6UPKadK5UU?=
 =?us-ascii?Q?MTKU8IcYzgAUfHpENy+QlEe6VgkimNqiL3uXDfDHF63ifYQpT0bDTnFoF3Zz?=
 =?us-ascii?Q?viQ8yBpCEwTznR0VGY1MPin3kIMsJW7hLBy8/DWrLT9+B2QSLQi56yM8n8Pk?=
 =?us-ascii?Q?pF63SWtN4udcpTxh0RXX5zMczKpc3moZD8ZBSorU9o1Kj9G/GsvMEKgeHLmF?=
 =?us-ascii?Q?KoDJifZfryaLczguxb2klnxxBVsDJdUGnaC9xvf3xML9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6Aq2MlKugL+ZKNFPfSDdnti8/URV0+hov7v7Vf/bJpa3mVHCr9aYf61g4x8IcjWVTZGGJbQNCjiWErH378BVah1xAyf6Fk4OZrNm/fFLtpi5OMiyGEA+7HgZvvPVAQdBcWINB6WMk8SFto9LZpACchxHLp96eqgI/8O79aKlffuCyCa2Z40iD52D/E/n2AcyShLXkJxFWC7EVpS5UktgNMugmDtvwK4xX1NR4lFTUBiFF4/ZBPGCoRlLYeONdeeFmIV8Yw4gCnCEzn9tn9zu3xarbjq+Us5UrMSYZLsFvZGw5UvrLxLwSWiC9rItBWKG2eIRldAEjSuqOcBqkDAC+0IdKZ3WCo1J5yYgOsrRZmzdyrE/akm8ZsZuc5NxZK81OWs1iD7ahN8pBTusOd67KphHLqvgWeEpwEpyfH7zxt0FV10XOJKxid8t9fTx+XG/eG6UuuPQoYyjrBGh7GkwaKFaEzRnOLFXYTgQBc+C1/LVjeWNgw5ANkK87G3ivtJFzhvGMfZLzOQMuP+gXHDPuv6VUxHf/pn/0l7Ize/aRcq1P4edENyTRsHlQWY7SYRwtGKMZcmymLol+qUYGT5Al6cIee63HcsoBHecuHtvXdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcddd21-df3e-498c-f192-08dc4824f000
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:46.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4OOfWT2STUD8hFVGjGPtAdUt979XBD08PoqZ47SKqqrR+Oj3/XqbUJbNq1I5074ur2WnxuT7cfbKYRkvGrdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190113
X-Proofpoint-ORIG-GUID: -nELxNcnQbQzcWm5-HAEuyGHP-aWLQUr
X-Proofpoint-GUID: -nELxNcnQbQzcWm5-HAEuyGHP-aWLQUr

Coding style fixes the function relocate_tree_blocks().
After the fix, ret is the return value variable, and ret2 is the
function's local interim return variable.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/relocation.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 535d5657777b..47b564df4340 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2776,12 +2776,12 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct tree_block *block;
 	struct tree_block *next;
-	int ret;
-	int err = 0;
+	int ret = 0;
+	int ret2;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out_free_blocks;
 	}
 
@@ -2796,8 +2796,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 	/* Get first keys */
 	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
 		if (!block->key_ready) {
-			err = get_tree_block_key(fs_info, block);
-			if (err)
+			ret = get_tree_block_key(fs_info, block);
+			if (ret)
 				goto out_free_path;
 		}
 	}
@@ -2807,25 +2807,25 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 		node = build_backref_tree(trans, rc, &block->key,
 					  block->level, block->bytenr);
 		if (IS_ERR(node)) {
-			err = PTR_ERR(node);
+			ret = PTR_ERR(node);
 			goto out;
 		}
 
-		ret = relocate_tree_block(trans, rc, node, &block->key,
+		ret2 = relocate_tree_block(trans, rc, node, &block->key,
 					  path);
-		if (ret < 0) {
-			err = ret;
+		if (ret2 < 0) {
+			ret = ret2;
 			break;
 		}
 	}
 out:
-	err = finish_pending_nodes(trans, rc, path, err);
+	ret = finish_pending_nodes(trans, rc, path, ret);
 
 out_free_path:
 	btrfs_free_path(path);
 out_free_blocks:
 	free_block_list(blocks);
-	return err;
+	return ret;
 }
 
 static noinline_for_stack int prealloc_file_extent_cluster(
-- 
2.38.1


