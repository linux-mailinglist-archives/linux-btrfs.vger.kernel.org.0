Return-Path: <linux-btrfs+bounces-2408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D085855A7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D175F2894F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FEBA3F;
	Thu, 15 Feb 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DzxYg6q1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JPvt4FjM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEECA4A;
	Thu, 15 Feb 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978917; cv=fail; b=LZsqU8MRfYMdtD6jM7CN9P3ZvFiY0d0nMJc9lN4NztPlQ/lxgoEnhgYdb+Gp8VHDFenl2b/AvMgIchpciXghCYzoORovyfymcsF4o7ksgHZXgHQk4onlN/HoxYJFnrS05ABz0DfsdhYaiiPk13uc9mVQCzw++gSvx2atOgSiwDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978917; c=relaxed/simple;
	bh=9QQqTfts5FA+UTGJJOGP1NVdHOOF2YRIHgWcYnom0vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUZsnjS75Vu/nweiWW+twBlS13s0BGAS18NDMP2BOyQfg3GaFNnBRd/08QBA/BcvJOu78Jzlnp392VqG/Y81ct0eBTMc+/GhHOznvTHtbLVGmyjHBGzZA0nd8+x0Pwk9kfrBEBxFo5KX8XwvGXJ6dkfKtrZo+ZlJYis12NbRaAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DzxYg6q1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JPvt4FjM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhnf7004446;
	Thu, 15 Feb 2024 06:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YHl4nSW4lBHimtuNuB+GXRB4k/USDCnoiG+nSMyLZRk=;
 b=DzxYg6q1C0lJjY6AwbEHVMQtYKXbulnr2XHakDhcXM9LiKxodMyFevWJu6MyYy0O2c0+
 N8oO5UfYs9qXPqyUCW+EuiDErc57e3fBrg4PN1tWTfLVa0mvly0XY7t9iBTo/CFAGwKo
 NIKcs7WTHlzfvwGqCNqBtMe4xk4Hg/YKRxwJnq7QGK0fpiye3q43lQJilmFFkl8tdnlQ
 Yvh9dIIXRmb5Iu/aPAjhw9p0f04HekFtGzoxcn1q13wK/+t0Hp5ded6dcbUokyM4ObeH
 brsJbJSqUsxqhg2kZ0IXGHJm3bzFTxNxmkoNYEPoxvuqEBykxswSsCEGIoUeSI4/spvu bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w930112ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6NQhr014989;
	Thu, 15 Feb 2024 06:35:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9s7a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llXxlnGRbGkzlkzoMkD1Os0Q+6q5ytgQOVWrGdeZ3dssChrbKUqqkZLRAfzs8iHcyvxgI4jbtquV6v6qJVYy7v5+deeZH2d9g7UOIEK4Tu6HkjR/I5z5Yh1MqqbngubteK6MlDWayxpz01UPy0D4sklRVNUSGXvpNQldfK1PBOt9HPK7nJCFd8rjUkXtbc+N1bpo/z9Is7m7QiPGKTm6QMlbBu9508McY8JgtrPSyBpDJYk4E8VjB0jL2woeNY4m+NL5iGex1XLXxaM5w6bTZVvzNnGeR59CMEsuHL6Cmy+ctUyby1jVZ3w7SaJvFMyZXbt5bndEZoTG33W8XNB3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHl4nSW4lBHimtuNuB+GXRB4k/USDCnoiG+nSMyLZRk=;
 b=odZPbQ5cuagXHC+sVxE6Yi2/1vRnSrbQA1U1JqicpEpM9UySD+h3BVm3P3xCN8HSqv4mTSyWC/xvkVTY7nH11GwCFJURgEN7yCMhWvMyXLHM09RnVEUTbrXkVvOsD/NB5qT81CswXLdnHOIuS4NcsRRrZtm9f4iH2jy64Sj60rN8adf1vmDUo0CohC+LuKS9UhtF55QmW3JYe9tL7+SmXSS90grcsIv/14SAp3eFey+6JEqcRHpS+wOrkquMA806PVcdUERW8aYDmc/YLbuv5wQD/GppznUsFqnm7iBHZ0/uOj61YmukKFqRsSjkLvRfdZ6B8bCEXwb3R2v6y+QJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHl4nSW4lBHimtuNuB+GXRB4k/USDCnoiG+nSMyLZRk=;
 b=JPvt4FjMrzW0W2eeZWgO7eXe/GX50PiCbH7dweJdnOJENtQQWo/MuBEjIMi+lqoB+ZvuE4gAXhRN4aQ6iDWNt+R1epOKcVRFUcgbxgnE0B2cRn+AJ4iswC6BCSA3hlppIma+4xPDhmWrO+twj6cUEDfleJeuIQeKMjN5+mVp6CA=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:11 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/12] btrfs: check if cloned device mounts with tempfsid
Date: Thu, 15 Feb 2024 14:34:10 +0800
Message-Id: <7b0f9a055c331aba64405adf60f616c5922c90a5.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 5067d46e-7c71-492a-6bb7-08dc2df0429d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	chUHSZ+Mn7KRBz/cS4LCegWEl3vrHGPRMAMwcQMY4bEKfNvkme8rs56EJj6piDus3nw5rzoSgsSsxjzuLAGax5cDWX16+vhFFlipF/chT8+wg51eS82gLv/xDsKyK0DXgQvf7cZlj2oxiWvZXF4V7nNl7I4XEB2nDN0AAB7988LIZ+e0uCe0/UG7kGLrU+Is8bAMmAsgXRvDbt7ApOoQ587F90JoGhMp/eALnm3AtZCsN165cCkEERc6pgghsjqAL+PVsUfC4iIjFegAmfmWB800vHagiEbkwvWcleLrnlcwRBRBGEwdT7kNaHEWxa7OT0aFOyiN6WzcYWP/766gWtXxwpezZbDy+BKRBb0uIebyVkw8VHFMeXPxwcGvk8oj45sEpOSd65Jo2j47i1uCZjwwccQfEXNREVIRAJF91kM3lkkh/ClwD4fFWOxpz9Hdn9lMulISm9IyCYkSEcARXbHKUU1e7tUOEAjbnmVJ0hldPYLRvjm8+pwWbsNPFzlyS2PE9JgSD1TVA1ERZo8//f1ozp+7yXL2nCHVxbYlhLVJ3bZpiMZUyhK5NN4rr0az
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4ttAhNirkh749aYnoiA84RalNHOSD4cSW1UgTT9baeURG7LrDE5n1HkOzozk?=
 =?us-ascii?Q?EaaE9Ar839MiZ8tj/VJeKNoDVn+DYiB7J6QFVq7ha0OjdDN1qKUZMqKaQXx3?=
 =?us-ascii?Q?VaofQfSoHoLzj3Wrn8lbsoSVoXcJ/LyUIzymE+M8yZWKElZhXr3oPM0jgWs2?=
 =?us-ascii?Q?QKXNZyP4YIsfPcFrtrFyfsU/sTmMnRuHWqS2qw4Mn3yi9eBVsbozf3W8ke2n?=
 =?us-ascii?Q?C+h9pTgEvKvKsqdiwEtqco8YUmVXSZRYB/oQrU7u2qBJSeVaLAid7FxRJG/a?=
 =?us-ascii?Q?XSlqAOSxor7ErOzYjNLGOkwOpas8DDyXGjJPKn4hg2uJ0SQChSb5Hs1pBLn+?=
 =?us-ascii?Q?juraJC7yXTUUB5MpZ8yHONRg+x7/7hYtQMKvklPlSUnETI+plssAWDzRGB1T?=
 =?us-ascii?Q?Gx+IUhCgsiz59GnXrQG/K7GqM6Ixx7PMLiLcZiEinPHYMI3LkAqUjv4ULB9x?=
 =?us-ascii?Q?nslxwP9jBlMETz5zHyc+p2N2nz0TS/7Q56/DDrx1WSD6STE9Y/9f2UY2t5wV?=
 =?us-ascii?Q?gMBCxme+QO5s6vYlJ2jZM0XfcIm4IRjNYaBvWevZXdvoM71BI0xPfC0TqlLY?=
 =?us-ascii?Q?lh405TEPuwKtLACO1OUJqJ8gbUB59uYkYLV5j42l8VG72ZUpoxCWgxVpgbxm?=
 =?us-ascii?Q?8vqoVHq+9WFyxI8r2GVv/z1VaLmL6wz5KF8Y6KgHwJTy/bVAkmXrikCHEPqS?=
 =?us-ascii?Q?424cuiUYtoDMwRwNtEuZn5UcHuAyXBRdKGA1NkqqS1M65rFYoLIN4o+QT/5Z?=
 =?us-ascii?Q?dMdy2Xj6q7tdlN7QMaN0BVQB7TTOdBfiBlpcxr0RfbL0fQ6UzNIjt0jFj+Gf?=
 =?us-ascii?Q?VcXffb3dgS9bcZLZ0Y6pykr0Ijn/KWje11QB/oUomVLCtnGiDqUdDi/xLBwS?=
 =?us-ascii?Q?+gJDJ94s0BgE6CU0FHTufJevYwABs6c2DZsHFtBI315+gZ6YfDuXq26i56R4?=
 =?us-ascii?Q?OWXToeuoqKkxWOSlIz5BEJmHMLyw5Flk6ifhysS6+/8AF3pOBG6CfHYC8Ce5?=
 =?us-ascii?Q?1cu3JMgUfUbKDOYU57R+QQzs3FheeVUN5SkLAo6wX5Fg5IH9YwsrWaAswLQ7?=
 =?us-ascii?Q?qBEZKRM61tFGil+1DKtAkbQslwcJ5rOMgXXOyXaIN8vLKMP/8pmjjxIWeMTK?=
 =?us-ascii?Q?YsC/+ZqwrdeFJcpXfMIVhozDHZ3/fyqUPhpLh+YLR8MSiNiI4nPXtWigYvc4?=
 =?us-ascii?Q?yYMv1jhBGL6J73mFUe5REtrmFF7E583Ic72HTTVa4JnfCk+Zimf/fvcQcnL9?=
 =?us-ascii?Q?L5ROoUZSN3ROzgaoT2QOqs5LoSJgL4iIJKYJvTujcQiihi6T0EPQVvO7EmJq?=
 =?us-ascii?Q?fkN5Ab42YrurKEmjrLNXlsVtKCUeFKBY9yqv2XxxquMt7miQAknatxuetY6T?=
 =?us-ascii?Q?nfPZNM0b/ly2Ia9aL4mpMzYMsOz0jMARVckVVTA0D30wDnPE4ca9yuzjHmWp?=
 =?us-ascii?Q?PUKcd48mSlR5N7eQBg/yYojAXGQ1XtRNKoAj0tLQDELvW6onidzxy6+7HqZt?=
 =?us-ascii?Q?fEoTxfn3aspsu78JqEr58JNj3EPAWi/L7aJaJS4xqDi3iVjozIcDtYpL6YeX?=
 =?us-ascii?Q?N4tSD0ngHfRY9z+qFM05nxggDKPGtLg+zu4Xe2TJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	086wWt/R3yfpJuVeXNRT3S5wlgA3NX30GZbdCK2q6C/HM4RSATZM2JWNxKp3svbJy0hUWz8FzAsgPvqs5Qptodv+7YOtEQTACACS7DXTJenQWvXLSHgjj4GhARjQHYQdZzFzHlCs7xRcJKf3pyARVx6S6Un0p764ZhozmLIf674zV7jwlz0yZ9y2u0tNwUyEP+OtmFOo4LQZUkbB9klY2oNFPGhkk84cFeSSAu7FG6aeS02ivO049Hntz/xaE27xJlln6HC5Vd5ob9FfDQPalIiaeE1Odb29BARR0XRq/BNWxWf8Eo07M5MTtLAfpcq1/W0Yju9aRpT/aiQQz87BA/2C6X5kFqwx7qU5FroekK86yWOkzoK75tA/llcRoPqXfPR43j+sZZv0wcxqjaoZOY9Yq193vbLoVEslMbhzIFOg4TlB7uuIsKwiO4RLYV8DBN9maZqjlkj0rfQfRjDTfQXOfoZIP8g14c+hGeaQF74npTSvjQ9VRMDXBqMbpIPZtaLunX2pzo4UvVJeHZ8YkezHt6QBjk35Iz17trGepypMXnBixL5QOmT0tVPTlJyWCW0z+7VmmmSXJGt2USbv5qd56uzo9VTTzwWOvG/1qcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5067d46e-7c71-492a-6bb7-08dc2df0429d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:11.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLdjoCGoij1qdTtvX1e+rn97zw5HKm/Wun7BYpBG/ZObs8xUYTDKvWQEG//4xmhYsOba+F6dGrQvBl2T0dbBBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150049
X-Proofpoint-GUID: H6FjbZBBQ2HNXeL40ZzSHm37T2XmJ7fo
X-Proofpoint-ORIG-GUID: H6FjbZBBQ2HNXeL40ZzSHm37T2XmJ7fo

If another device with the same fsid and uuid would mount then verify if
it mounts with a temporary fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/312     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 +++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
new file mode 100755
index 000000000000..782490b1c62f
--- /dev/null
+++ b/tests/btrfs/312
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 312
+#
+# On a clone a device check to see if tempfsid is activated.
+#
+. ./common/preamble
+_begin_fstest auto quick tempfsid
+
+_cleanup()
+{
+	cd /
+	umount $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+mount_cloned_device()
+{
+	local ret
+
+	echo ---- $FUNCNAME ----
+	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+	echo Mounting original device
+	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	check_fsid ${SCRATCH_DEV_NAME[0]}
+
+	echo Mounting cloned device
+	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
+				_fail "mount failed, tempfsid didn't work"
+
+	echo cp reflink must fail
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar > $tmp.cp.out 2>&1
+	ret=$?
+	cat $tmp.cp.out | _filter_testdir_and_scratch
+	if [ $ret -ne 1 ]; then
+		_fail "reflink failed to fail"
+	fi
+
+	check_fsid ${SCRATCH_DEV_NAME[1]}
+}
+
+mount_cloned_device
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
new file mode 100644
index 000000000000..b7de6ce3cc6e
--- /dev/null
+++ b/tests/btrfs/312.out
@@ -0,0 +1,19 @@
+QA output created by 312
+---- mount_cloned_device ----
+Creating cloned device...wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+done
+Mounting original device
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
-- 
2.39.3


