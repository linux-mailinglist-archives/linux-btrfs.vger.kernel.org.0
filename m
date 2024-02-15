Return-Path: <linux-btrfs+bounces-2412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5F855A83
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B04AB27294
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A181AD29E;
	Thu, 15 Feb 2024 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktT0ocSN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lz/1oWrh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A0D51C;
	Thu, 15 Feb 2024 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978941; cv=fail; b=MwkhAvmg0+5xKbWMvOcx+aOn+ZpQ4347ctpgBO7V+4hGtDowibJ1Xwo6qNo37znvdIkvUQcKoP/YEXINK+kZXvKvf9QI7B4Jy13DEnSHE784H+Uxo6xTzeYoa98cuuYQ105AuXzutSJOzydGAD3aGvsklb4hwEmJLYXDrYekOAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978941; c=relaxed/simple;
	bh=7kwNLKhVl03OYtbd9/PKLMXoIrMnHPX+jw0cPBHjYz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nx9sbdBJpOUbdUG73KwSzgSP6/5UkwzLuzkNDi6yRYC5K4I96GQK1ZFBRDe7fmdYEAHB8gDQAspTne5kOlmUU3WzCzNMfwFhnJpVaEPyTDIBMTB7dQPaSWcTanM1yzxc6k4VRHHFPdld67rx9Mm5JJ9OnzG2FTMPD39RWxnNqLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ktT0ocSN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lz/1oWrh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiITQ027842;
	Thu, 15 Feb 2024 06:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ljlUFOGePRNYf1XUI2UPq5wzkyHvTO6BFCB0JVKBGB4=;
 b=ktT0ocSNOl52H2a+/FmgLUJ9xaGg0hV5Z/pP1UuqLcsxSlw7eT4Pg3eO7o4mrhkh+ryT
 fycKFaf6qBXI8863kg9G44qCgiHiZ0ZCVljFiSl75bszOQ82rRz2V97FtoioHKvYAs/f
 oZFgjCcI7KVMTPj1o5P2EgFk6KWNQuFQADtzu3+jxLyFSNuV+N42TunHT66MLxO48nCH
 jyxtwL4Sz9A1Pz91IUsT+XtfJYPF34L5GmajI+hhZD+n+7Kw9t87DiK++7N+AL+qldC0
 /A0UjMmvoKNXDyrBed+4AN9xqYg8XwNxJFwBybERHTpDYkSkEFXNALYv0+a5bbZyQs+a KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92s714cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6TNTJ000640;
	Thu, 15 Feb 2024 06:35:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka2vr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDIi+S2/AIAP+CUTlNDHA1zE0taK1OsHmISPnSCLgvgT2MZTACho/+v+jJ9Y5ZCTpl75L1uD5rP9xAuYLP3ze3pnpHClk6fW1KSQXE51tN2k0VYzjjVKyEAFxPENNw80QRxPI9GiPgDi/XsfZ3SbvZLPjfLRKrqm6YrDi9ZBiMU8AFUAltHYFQJjelgmEg8d89pwg35EOzSgCW8bMk6w1f7XLxJmYBUnxychDFuokrljpsiPR0cak6Bozjmee2L47YGCj5rXR/W+0azw7W66/Yyvx0ZtFSDWbe6NoDCb2mTqsAxFGIUiRpYL6EaA9wswR3tNiirWZcOuYn4O1WGFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljlUFOGePRNYf1XUI2UPq5wzkyHvTO6BFCB0JVKBGB4=;
 b=TnyoZ/wU0iIgzYBU8YMH2ZK00zTQDvrSaxNEY8I8e8dV3kA//h3FqQpQUiuyA7ET/HQAlvdQ6SrcUl+TH4leQHtn+MfYQOvlJL1w6VymwA+AONx/u19rDgaY5ihGHJR/+lmGXXJ2TfLE/eXctvqjcfovowdj6ofN9xaIJlCnDQXFigKCgl9ExC7/HlneF1+rZGjsJPSGmqg2wogD6DjlFIyN3n+XIySg8cYYF9L730vE52iO9BnRv3R0LKuYju1tQr3thrIXAp2Sg9dDVud89yafSUqHjwHMRa7FC+6XY1yqI3xHstdNdLpGmg8zLB7214iixYSXex0SF1o3U3Legw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljlUFOGePRNYf1XUI2UPq5wzkyHvTO6BFCB0JVKBGB4=;
 b=Lz/1oWrhAsaP64O+T6rEtBr/pVxMWmYJs3Rc9p5L9Z0IBuehjXcSIlq95VDI6aeOgrJqUpzLCPSs1OrF0movcXzZJ5Sf7IyMKzacnG89oaPeOKvlCYjGMXrBMNScmvZ6y4FC+9BbYoU5TefkWZsEZnxen3ENn92d1e7GbraiS1Q=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:36 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:36 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/12] btrfs: validate send-receive operation with tempfsid.
Date: Thu, 15 Feb 2024 14:34:14 +0800
Message-Id: <cc3da235204c07e79e3655bad1692e1928c11002.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc1a549-60a3-4981-1460-08dc2df0513d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oDHZd8aufKmi6AiIjboMTR3x1q5MfX2mAfz6mSZfUa93d+hVNNkU+dOf+quVcLNnEdjmhnhhf2lsT7ULoQM9dhpQY0J4BXFEUDI4vi6VzI38A2p7+yTTVc1yMqVSojqwJ2IAu9ef4X2ZErbFNPme7yvR0Sr0MRzCDK3y6Xt+WU/QWEHsF3xEWcL/GFpF4dKzZF9cIyFY+C0JqGZwSV3k+4sG5QlHCyQrv4cnD9J1ZM5OSZW3grmje1J14WG4XTcCcnOJ5r4Gc5dBQyXtgaRcXVgL0OI8PP0rn4ntFBHjY62LTb125LgqBd638di9YeOQWLOyMQ0qAB8bEY3i7KV/MdndyNrxAAGGAyE4dTjCWn+XJ5V3RFPvgroNEKCYRXXbB91sgggJlNmuldP3WhFmMtuaToxL7C1RB5q1TV2j2AS5WW0oh8fqemYWBGdnnnJtkaX+7OrCWrBJTgHn5Amyo96MngRjz3kYVgskv+SJF2scEwKpJnEwv223atm/7DhsVxWMhYpSjrmXYzZ44H42yWYoDnWEso9DLP6IVQ1qy1N8YzRyuq8u3FeUJtzM3S0e
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e9WlpwR+Nb3ibtbs7U9kYyzJPRECckxi0BSL/CugZYwfib24IuWwc8XKe9y5?=
 =?us-ascii?Q?g/t4H3sQTWX3XlF1Y3Dysb0ohZw7ddEl9T2N0Cy7YCGy5A+rfPA3fMa1vNGJ?=
 =?us-ascii?Q?qP5uSshtWEUsoB95UazzxEuyPlNdxppVCFI4XwMdKoQe2uWZiDAYF+QKr9WI?=
 =?us-ascii?Q?j9SDsnwaQm1uZoKMb+gicGywGDlJVtCmhT/YPLnuEUd7PLtf1khPro/DEE7Q?=
 =?us-ascii?Q?EvoTPzAROheNPYgOvpNyFWKUB+spZ9WCwq7U5QecBtJ5IN24IncYNIa3ircN?=
 =?us-ascii?Q?z7KYOeXpQDrXodSuCG3EnZNjSR/lRNb9TZyyjFftlGcrPYLnadd0j7VOqrS5?=
 =?us-ascii?Q?kqxNJn8mk90/PKAjaXh1m7e2BIajuDoUMCTIGFSNFlwuGGUoEKqiNEAVk4Ft?=
 =?us-ascii?Q?U+1bJYlWHwpGgnAsseRY8BHspeVgEwjSwxKwqCgBjnE9xK7LDUdlG4VlEtKk?=
 =?us-ascii?Q?5bK7W45n9Zc2GsXZ4/mGd7fhYoemX463Xbgy6SJUm3jtvq9pdG1CrSa9UcMI?=
 =?us-ascii?Q?yLbKyAoIrbvCe6/y1crE50a6tt/I0dets/C+Cgizyg6D8+Kw/XaxI4qFSJea?=
 =?us-ascii?Q?CYgcJc6to9GBu4UhX4pvMf1dRkKmbmcIqyo93GcB1R7c97RCjQN/SVE3KSVx?=
 =?us-ascii?Q?e8Dns9uC3u8M4SBDnDB9D5bGDYvRDqe03CzpZTu0BKv/dnKj/6e3LBtoexTU?=
 =?us-ascii?Q?YC7+NHtxzsfsgPVAeDCZV8qtY97IG8jsmvT/UOsk4R66go6r/dH/4ppgV2jH?=
 =?us-ascii?Q?7zy6EBZ7jAnVOwoh5cuPH+reetW78wjPIm/5e3yeNwSIt1oY3AE4fJcUH8hz?=
 =?us-ascii?Q?25NQQ0iS4XMKsNLbwJPeYrw/9qAzjuk656Kmx2vwdA4SvkwMIMKhG1noO2Oi?=
 =?us-ascii?Q?dMn3CMTpS4UHYcqVfB9pPgpJZffqdqyP8eG9P8Qs41PaXM8UtmcwHntZ/aFj?=
 =?us-ascii?Q?3ymEKVSf4e4wSBm/SRorkHbp0zltmCG9WJqS9oCpw8MP2cgNZJ8peLssEDqv?=
 =?us-ascii?Q?A/Q8qSguH9itS8FtLihG3SOAp0Kwbskpkt7pDI5M0y85nXaz+zjv7rMk0AZt?=
 =?us-ascii?Q?RdSVjwwEC6xoQYJ1g10S8P9QS32l8WZCSHbVntsUxrKTykZT1jkgy2IwE81C?=
 =?us-ascii?Q?F6YnXMaN7Mdrg7wJJ0ZTEeEatfXlRnl73gR5TkuxkKUY7zNIizibvukm5jSs?=
 =?us-ascii?Q?8b5kouaxmGp8u8PVXd7m94EiL4tZZoapTJ4iL4v2u/YTELQTJ6OCaXu0bQOI?=
 =?us-ascii?Q?FOgMH1+5avcyIHWp5ekLuaj0vKaGZ3R864xDfMEa53nAn30Mmo35HwkDldHG?=
 =?us-ascii?Q?+739lnJ0t+/ipAedVYTYX/oo3VthTJdBFb9OudVRKd6zgaKbmQko12NjV1/x?=
 =?us-ascii?Q?YCBNezF8a2UqTVU78bltuxPS0u6D1aArK75lDZlFbEfOPP8oRiAHPGBAlvNP?=
 =?us-ascii?Q?kX0MMmLVLvnqbMjbFPRkQfgk4YSXAIy/7GWXF7ANy/2Yj9F3hotOpZbR4btT?=
 =?us-ascii?Q?maJnqqd0tI8Ep4fIBRTcmgdQaUBT9jNmW//CEsSfgjKUnYkrx6K7kpsbP6Fs?=
 =?us-ascii?Q?qBV4Khp077Ugwiv6PS+P2Gdg4RaAcSyhoBipgtdA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L9Jywqva+Vpzhcfds9cvSG5zHzG0SXHQhaWyM+uHX2hiBrDGfLbQFWi4YEGlxzUvll8efPnO8t02sM4fTk/y/5vce1/Q5sB3OrIwDtbqBI/BbIkQOCSxgRUcqRwKFOuFHgfbhyRCTSlfe9w7qqFzApRuk8MOYThswgEji8YQKMrB7nNrQWSvhG3uDImFHzTSHnBbP0vVTuj/qWcPbP8niYlEX3SUOLFm4/DHH6E+zNztyXUOyXCIdtShBHnWHpAXYqVedjknAk/pg9I00XyrAe5N/zj8aeOHqQGOqKy4Nqt4dkxww+4IKzNH2F03UPNpypqRqKwXuXexqwBpuYG/KC+XQrD8KapXUypiCcBBi+J15F+8FNFYlpyI2gG9s4GQSGyy/6DMzFpsL+uodq5yeKJAdf1G+KP2uj44GM/zrQgpSjBOfugmc8ITHaUFVuvGTzVFfJ8FLz6bjmE7IlfDaYlMjeFicaYcXIisVX6AuwAVUrZSK76bmWB02ISBL7/ZBAOrANXNrVB0rSGYWd7viV24BrQ1UstaOV+iayUnOFT+CQHHeM8GDKexbcSiFrL3JmUfGSoivCvsyIOsKg+fD3o7X+dDXjGcmD8r24zaVCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc1a549-60a3-4981-1460-08dc2df0513d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:36.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3AGXYq+s0xOSuFFRHDQpJW9GwPuLHgAs1BcaeernD1oI/+dEchB6NDkTt1vzBtzLy9VCw3UJq7qmO2WbmHxAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-GUID: S_Tdd-ze6k9yQ6xB_nKW-sBD8qPj9l6h
X-Proofpoint-ORIG-GUID: S_Tdd-ze6k9yQ6xB_nKW-sBD8qPj9l6h

Given concurrent mounting of both the original and its clone device on
the same system, this test confirms the integrity of send and receive
operations in the presence of active tempfsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/314     | 85 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/314.out | 30 ++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100755 tests/btrfs/314
 create mode 100644 tests/btrfs/314.out

diff --git a/tests/btrfs/314 b/tests/btrfs/314
new file mode 100755
index 000000000000..1ceb448d2a5e
--- /dev/null
+++ b/tests/btrfs/314
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 314
+#
+# Send and receive functionality test between a normal and
+# tempfsid filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot tempfsid
+
+_cleanup()
+{
+	cd /
+	umount $tempfsid_mnt 2>/dev/null
+	rm -r -f $tmp.*
+	rm -r -f $sendfile
+	rm -r -f $tempfsid_mnt
+}
+
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_mkfs_uuid_option
+
+_scratch_dev_pool_get 2
+
+# mount point for the tempfsid device
+tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
+sendfile=$TEST_DIR/$seq/replicate.send
+
+send_receive_tempfsid()
+{
+	local src=$1
+	local dst=$2
+
+	echo ---- $FUNCNAME ----
+
+	# Use first 2 devices from the SCRATCH_DEV_POOL
+	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
+	_scratch_mount
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
+	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
+						_filter_testdir_and_scratch
+
+	echo Send ${src} | _filter_testdir_and_scratch
+	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
+						_filter_testdir_and_scratch
+	echo Receive ${dst} | _filter_testdir_and_scratch
+	$BTRFS_UTIL_PROG receive -f ${sendfile} ${dst} | \
+						_filter_testdir_and_scratch
+	echo -e -n "Send:\n"
+	sha256sum ${src}/foo | _filter_testdir_and_scratch
+	echo -e -n "Receive:\n"
+	sha256sum ${dst}/snap1/foo | _filter_testdir_and_scratch
+}
+
+mkdir -p $tempfsid_mnt
+
+echo Test Send and Receive
+echo -e \\nFrom non-tempfsid ${SCRATCH_MNT} to tempfsid ${tempfsid_mnt} | \
+						_filter_testdir_and_scratch
+send_receive_tempfsid $SCRATCH_MNT $tempfsid_mnt
+
+_scratch_unmount
+_cleanup
+mkdir -p $tempfsid_mnt
+
+echo -e \\nFrom tempfsid ${tempfsid_mnt} to non-tempfsid ${SCRATCH_MNT} | \
+						_filter_testdir_and_scratch
+send_receive_tempfsid $tempfsid_mnt $SCRATCH_MNT
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
new file mode 100644
index 000000000000..eb0010da264e
--- /dev/null
+++ b/tests/btrfs/314.out
@@ -0,0 +1,30 @@
+QA output created by 314
+Test Send and Receive
+
+From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
+---- send_receive_tempfsid ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Send SCRATCH_MNT
+At subvol SCRATCH_MNT/snap1
+Receive TEST_DIR/314/tempfsid_mnt
+At subvol snap1
+Send:
+0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  SCRATCH_MNT/foo
+Receive:
+0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  TEST_DIR/314/tempfsid_mnt/snap1/foo
+
+From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
+---- send_receive_tempfsid ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
+Send TEST_DIR/314/tempfsid_mnt
+At subvol TEST_DIR/314/tempfsid_mnt/snap1
+Receive SCRATCH_MNT
+At subvol snap1
+Send:
+0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  TEST_DIR/314/tempfsid_mnt/foo
+Receive:
+0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  SCRATCH_MNT/snap1/foo
-- 
2.39.3


