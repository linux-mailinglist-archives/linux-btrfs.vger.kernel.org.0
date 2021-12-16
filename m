Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644D0477257
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhLPM5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 07:57:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43768 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231958AbhLPM5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 07:57:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCT9W9011685;
        Thu, 16 Dec 2021 12:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZCKx9BG9BlqsRphb39KlG12NwEaAaVcCQX64pfI4wak=;
 b=V5Ah1gU63Rf6O2yQvuKGdohk4FT3FmMdUMVEor6SiUB/v0oLyx7vstf/ZzFF1q9DC4ZP
 CJJLXiBvyXvUbyE0odv4/6evloLkJr/DTkeG4ggOEVRV2UxMBefqkdddSnEn+uIzjpEu
 KrfqZCf/Ev6rwDoI7qF3qrd3mcqrGhyP5f8m6lA2m6sDyOcUcgMCCXwXRbIwOaVFssTd
 D4pIPYyU4CLZ0uMcBew6lEmb9izSJ45BGgjxuPMKrYSZ1+JwPXFlNoaV9sGi13s3Wmy+
 uC4cpi1cGKMYMW8Dmu0kZi2857fjyECv7/xgCbirxRq+xl+OjasYny7a+4f6x8U4rzGy Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp2ndf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:56:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGCpoE4081585;
        Thu, 16 Dec 2021 12:56:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3cvnetm6mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 12:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N29zX9DYJGuGXKqppMhdCaCscfyCEMfn6/XddLoW4WPkwNxdpxLZbsDiPgpZt7eMv2YeRXnVHes8+J44l+oaa4siG37k8UEuDNYkqTo4Vd7ccccGtnKbNV2sfncUMa0vSUCzidJxdHWc/KyWP2KGCC9stnJtKbxW39Gveu+5ytJm6aeecYEDPZl68tsfnsAnaU1qVBpRnnCTeLGMimo6V2V1VyBJFraQuu2EFQPZgaBebjOjB8GPrcVXOT9BpF9SBctd+H388FGzSkLfA+7zWLVDT26HX0KGKf4zm4qP5jA15xBAfZSSrhVT1Q8tAl5Hz0qFVeg9PvgILqt+/0g2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCKx9BG9BlqsRphb39KlG12NwEaAaVcCQX64pfI4wak=;
 b=D4t1k34lwk9wL6iuUz7WjKy73KZ8Bsicl6gCAnMdUaA343FOvF5Q1qN3CK6trYIcATGyrJmBY9f5+vVDk5k4LSvS8nr9FlrAFjmxG5cPkLqpmQ1HRtYv9rlVLaT2z6hCpeuaLuDK/mP8D2VvebTIs/qFeTMsY15CZ4bbE+uIM53Yl5mkngFgeg3vzh0rkkMTE10rcVq7T/UKhgy7Emc7ZiSl6LnSzm9VhWmNJBpAoKbtYnRl1Me0id6bRrNjsf35KRpsYKpB3+Kakw6/fqNjL1y2xjRA2YXwfUtwhbDnyj0+RfllaYotiegkGJrYugETui/eUgUuNdzZ/8ANXQUKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCKx9BG9BlqsRphb39KlG12NwEaAaVcCQX64pfI4wak=;
 b=UW2MtPVErAWdujs3Bkk3TDeNGpPtD0WXYb15iyVRJqhY0vLqYBjiYENG1k80s11WKbWyIbtNjtj+1JwcD1LFxoe+ZQmO1YLn0NP6rDiK7IYFJsPelAb+aIo+E5WGceiEf5DWAZjVaLcjCcfyLORyWvERW+nPNIF06n/dlUH0UyE=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 12:56:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:56:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH stable-5.15.y 0/4] backport test case btrfs/216 fixes
Date:   Thu, 16 Dec 2021 20:56:43 +0800
Message-Id: <cover.1639658429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f9db8f-556a-4440-41f7-08d9c0938920
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4980C93C419A2E8D4FD62F2DE5779@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnN8gZt7audotdusZKp+anft3akGWNnn79JdEOJZ/qGYvXcl6S3LERFBkTJ0aplleYUlb6wP1vZkrm8GjFENi3607ObvmIG7E1rew6rb+N5aLPa55N1cvsHinNyHSYP1LgN8vsw3ZMM2sJQR8rUNmoLXlT8KVpmbj9eSt+hX0ms66T127Di7kitY81Ia8/pr/Qv7N7cMaxe5WK5xo5Wei/+kehCTDLeHgnDfEEi+kp74Kkw5lKRTK9SaNK4l6VJ2CZbRHJ+5X48/DNlTKgZoeS2NkDqWPE6s9qFdlBoQMw7xQWyTu8il7DcqHxQAAh2vNag2jPn9NsKr62bZM/E6m1zGT/8JZ3aujMoeybWuCDvdnB+g7+A0n9eLkxuYe7TC1T4dGhxv6bJQQHrtkfNOAuUY3MxVcuGuZ/ymJ2p3Dlbo7euTeQESvLkfdzZaoSzUrpdeONYUDh66iAe+myT2PT91WEvtepiLRGF3T5vecHdzffdSf8QdnHR7v95GYJ9dXvK/XUUKlE68mlghCbVxg8PA45EUIHdHV0qglzxQFJYQ0vQWNoLqhKLh0fIjSc6Dv6lhVGbbH5/J72RpRicEt/57ewakSrz4XToyfiVOMKKdTka5Qrjuo7AN3xVZo2/5tBS1eSrwTh+Wqkhhlflx1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(86362001)(450100002)(6916009)(8936002)(66556008)(66476007)(6506007)(66946007)(5660300002)(4744005)(36756003)(2906002)(4326008)(316002)(2616005)(6512007)(8676002)(38100700002)(44832011)(508600001)(83380400001)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pax3v2ewvsl8LSOqhGfIXzLvQxU3n0JddQTVpFbjIsCqX39Z4p9TUnSov8y1?=
 =?us-ascii?Q?KSLiHRDslf85wKNJd6MV1IRiDXBLAR4UsImN8u7osRaQgf2aRDi/UIp6ZmAk?=
 =?us-ascii?Q?7xAHvIe1amR9WxPBu5/tgl2Z7CbeVgrT+7ZqZJ0UyrLFqqsTMKCTm8ip0zLu?=
 =?us-ascii?Q?cRXqQia9I5vqn6dBBZzdlpBaVz46tlCf525/c0T0U1fIDXC9i7lLiGVbCpTi?=
 =?us-ascii?Q?l1c7cH6r/ejts6BHkKm6GdUPE/PI5MzDxHG2ReRcXIsPQB//hT7EQVGN+ku5?=
 =?us-ascii?Q?6QSNVBXLtOh2QfD44JGtA9CZyYxguxFzE6A9SLhRrBt4JsMrVXqRCG6zc86T?=
 =?us-ascii?Q?ZRcFYJIa9weuznPrARrbYB1WIk5kpAQ31b191BVpjwSEAbiZhQyUzPn3i7Iv?=
 =?us-ascii?Q?ndPO69nqVwl6CxCkoXIvjh0uv8i3NPu6OlW8iRZistEHCgG+VixWDF4j1Wso?=
 =?us-ascii?Q?gb/wlSCQQeJ+SDgLk1nVak8iJxl/siY0A+RliINy+3tvL9W7rOmaadShxiSl?=
 =?us-ascii?Q?YpNze2Arqa0BPBYdEMG1Oki5RnqylE/WKk4Fru2lEYRCF1WM87qfX9xI1O98?=
 =?us-ascii?Q?1KMx2vM69EpIX7tXCUFgr28wByDHf/+RtjtFci+NFssbmKalobMpyffL920V?=
 =?us-ascii?Q?yIRzKRBwLdgBbrGKpNwjpssaRgPVNot5xIFWuVNdfBje0pAVqSxznvXLfrey?=
 =?us-ascii?Q?qkwq8lZa1rsDJ0JEcfykon2BQaSQ31I5UVpFE71+cIOzCaHdu1vasAZeVNtT?=
 =?us-ascii?Q?RccaTKtI40sutd5kxxpc87yHGC5oDLBj0jlFWvv8gFr1ImGUBMaizWhqXFAB?=
 =?us-ascii?Q?CkYn92lhkD2CE0t+bRWARoytFEU7KK91u6RP5EIba5OqsZXiyZ/R2Z+K07Ow?=
 =?us-ascii?Q?uXT3FjS0STU9qfuPjGtbA9TMAGTuthjsnneNR2ZJECu2QirEn5n9oMAa+4M3?=
 =?us-ascii?Q?tYor3fnzbPhVSc3x8b3s1ZbOtPYcAx4KgY/tCilmlvReAqAlIQ8xYXk2VdIi?=
 =?us-ascii?Q?mJKAaR+iFjnqRDErNWNjgJvT8fLtDbRi/5ncTzsS1QUG98n6mUhjv+uE1VMF?=
 =?us-ascii?Q?jjchbvXaz+4LuigXjo5tinrajvNgMLphBUrpAF07z5zObQeTQ9+Xi5fjuKWS?=
 =?us-ascii?Q?8gDxOi+pkoez8HilKgPwhu1X5XvC/ah5AN53EbrCY3jP9C/QG3psE+YcM2VA?=
 =?us-ascii?Q?RRxn40YRw20dkXadR4cz5kBmiGe6tNn0v3Jw6KhaHO0/3TtfS1bLGCBd7XyS?=
 =?us-ascii?Q?6wtw0LVZVi/Ff0PoyNC5S8t1P3HdNzXZopfhV3jTRFK5TujjNOmOPz3HAs7A?=
 =?us-ascii?Q?+NkWNccb84fPLCVzhLRAwyfse0jPow3FObb1guY2ORCbQz3LAyiyvtNgs64l?=
 =?us-ascii?Q?OOi09BiwB0JtLdqanUbzmxpqTbDvfyYObNhtkkYBL5kDiogWq0aeA82TCRmP?=
 =?us-ascii?Q?8xAnt78JA2rSCjCyLWGN6vj8LSpbf+d0gSs2CD2warvhYBS6ZtZjo1CP1s/J?=
 =?us-ascii?Q?emOr2AG9JkzODRKKEAdh/7lVoczBMvOlrhVybOPeiUazXGf/EXYzNzkNv6d3?=
 =?us-ascii?Q?1XrSUhtHFttkAw7C6w+IUVUNCmx/tmTLLb6VhECl+x/DsMBDcMoeuu6IO1WG?=
 =?us-ascii?Q?nFaSwSxE0v54I18tvCUskqTGzUwE2w0Pa1m43xXI50RojVroRykzlNCPjFLU?=
 =?us-ascii?Q?/H/G/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f9db8f-556a-4440-41f7-08d9c0938920
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:56:54.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wv7BESfoqNL2kkYsMPnczc48pezzzHbUV8CQJ6hnr2ixJL8nLENRe1y6ShK+9AncmGWcmsJxxXfQSJWr++j/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=925 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160072
X-Proofpoint-ORIG-GUID: 1n8-6o9Zwq7eb0fIViTX-plwbrTEETOi
X-Proofpoint-GUID: 1n8-6o9Zwq7eb0fIViTX-plwbrTEETOi
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In an attempt to make all the fstests test cases pass on stable-5.15.y,
backport fixes for the test case btrfs/216.

Anand Jain (4):
  btrfs: convert latest_bdev type to btrfs_device and rename
  btrfs: use latest_dev in btrfs_show_devname
  btrfs: update latest_dev when we create a sprout device
  btrfs: remove stale comment about the btrfs_show_devname

 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/super.c     | 26 ++++++--------------------
 fs/btrfs/volumes.c   | 19 +++++++------------
 fs/btrfs/volumes.h   |  6 +++++-
 6 files changed, 23 insertions(+), 38 deletions(-)

-- 
2.33.1

