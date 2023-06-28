Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC8741097
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjF1L5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:57:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2458 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231573AbjF1L5m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:57:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBT8BP024967
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ow6YaI9oltxDzbRhjWQcqjUEAnzvTWUkA4lUZF1Jvf0=;
 b=w+LmuSaJhKdqLk7DqlrVb0h5yeNJO5f/vQ2EPZyhqVBnOtlMtSnGM9Ay1CWyi6wwIaFc
 UDoBOAC+y+DAOymR9uAvQvYI/9Mue+CLTmVrY0O3L3vMEse29KCDpJ79eXjHOv/9+zTt
 QVfimlhmS9PFR2I+ea/WmjI6KlGz7hsmbzs+Ygnp0cu7JOXtQPgRF4DvTLVQhGC2W7KL
 Ap1dUJ/61vbZU+RaQugtbeJdIfR/u2X8kLY4xUV4AKaRFtDN/BlBe2MCRvyUW7CdHfhI
 m1SijdpJ7ghFTvNQJA3ooM8oYGogiTf9QfsLK1RRLfDMwm16c8b5+ItMJ6QIkyT+/V+m ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e5hyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SAcqxR004046
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxbwt1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMPH6Mpdwwyw6exH+DXDXVCqOIDhyOSZT736ie3SGNosN3dLBOq1dXv83ukNjAS/n+mBGuOGLyuzHbwRb8fzXLJK1agS7pPPUTMLGQCXH2/F3iWeS8WCEl88037w8HdLGzPAMsRQ9eomrK9a/CR45pJ1qF5O+T1FsD99D90Lbp4Rd9pD8TR/lheec/ukZ223RQSe++fsNnPyXIWuN5SZ40cbwKkE16W20p8OajEck0hp96Y4Z991hFkL5WpYZLeUy0NbdlPMOqLIANCS/+09l7JyI0Uxhcpjk+c9MEo8zBNrd3AseIMMtvexDusa1XCeqjlPIkRhh3IFr6bRnNef8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow6YaI9oltxDzbRhjWQcqjUEAnzvTWUkA4lUZF1Jvf0=;
 b=HJhlSNZpXt3Rs9oryrKsYWjxa/QA4MFFXPiCLT6d2yCuVQ93WhkZzVlnnlLVRtsRWEgXOxZwUggW0EhJI1x9GgNLGXHx0hknu5IY19pNkTTKWS/sMullPLQ0JoEAiWnFhcXIn5GVb/zzsaF+mPfe0whLYevAnjyisMm1gjEqSqtyiZaymIHKBsxH0PIiCyLvuQzE0S0AukYgVjfPrF6IsQZpqYj5ud6+ikphZarb9LymjzPrZXc1lTNra9VuLkLp4CHNe1+bItkFGrslfSNfnBfjRh/HJtWXEVkolfiLFmtA87CmkvzB39n38AaJXtnJAdI00VfxBN/FG/5k/3pywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow6YaI9oltxDzbRhjWQcqjUEAnzvTWUkA4lUZF1Jvf0=;
 b=CpYaeH31m2yAXHw+w3wEU5gFvp7mKjJpo1E4zuY623ri3OeIq+Zv8cKjLuwVGWVyKO2x7os9RCfma7fulTuiYE9SbHWJCAoI6nzMsFlmRfHou23KNBoCj2nIqXLhzHiKKD5xYRTca9ax/H/9pI1D1o0Jc4GIXoTA+SnCCYVsk+8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7272.namprd10.prod.outlook.com (2603:10b6:8:f7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Wed, 28 Jun 2023 11:57:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:57:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs-progs: docs: update btrfs check --noscan option
Date:   Wed, 28 Jun 2023 19:56:17 +0800
Message-Id: <a4854c490f80ab30eba43f393a15b623486540ff.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 244aa879-4b8e-40f5-8213-08db77cedea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdwxWwrsTR/TATg1BhjD/Rq7Iyb4ovbD3ZOj7vWtGxvpmq2lbhlyVYxC1dL1ETDRodC6XBGV5xIOtPhEsCg+7kcOSsm9z9gZKYreKuH8prC5nj4gqBUEAsbZOaKavZBeytzyowFy1rM5LETpn9xpcelU9vb0ABKC8sj0K/vPGhhVug1Uu90ThQxfPXOgxVQE4ppQ54w9bjh/saZPTT1SzV9GdFhYCFaJ7DG31Az4pGyqckjT7tqNQrEzOV63ILGt4fUtN1GVqbmou65fizeBxcfhaiZzATrh8UCoTenDthl/n2vn78LOxnzD/JLGQoQSS8xpHxSjXndZWZlQe968zbZqLAMV/kNpUVvJTSaXW2Rb6HNKYVcdvmF8QFRPwwxQY6voNYhDVJqqD1PSq9QrgEidyILhqU4rVbDiyfXAEVL6Lpaf1VudW9KiM5dnbcjWwt3lSMOUCWdtXhyvpx/TbDOi3uCBCXzqAB085RQccyftdl0vc33mYtXaIRjwHbgSYdC3jjFSptPO8nSGSnuwtHS8h9vssK4DH+XCNM5TqVbl6MtjuiJgYAleOmAqc+Co
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(186003)(2906002)(4744005)(5660300002)(66476007)(26005)(6666004)(36756003)(6916009)(15650500001)(316002)(6486002)(8676002)(86362001)(478600001)(2616005)(38100700002)(44832011)(66946007)(41300700001)(8936002)(66556008)(83380400001)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZ5F5KiGYCzB/RxXY83AmPGCEwxZZ7XuOqihs8Snbieit0BZF+5zRvN6BWry?=
 =?us-ascii?Q?36D8/t2goGsANBEbJe8K4cmJ/gZlx1DiBcAIZP+RRuVB/fUYVPpO+CvLaYjZ?=
 =?us-ascii?Q?wQFotLPWhagszecy5RCsLt2HTc+nswd244mf5Vr0AEHQlf3cpMQg8jHDtj7O?=
 =?us-ascii?Q?QbiEmyZjvbXR8ZLiZBbrpcCQbp0GnPU8fYks/ahqLD8j1wYNioK5uKomBMo+?=
 =?us-ascii?Q?AQmvHleSdBAAb6iAedwL9LuQgytDaX2IG50uEzLAp6ReNayfSwI6NdhCYIyB?=
 =?us-ascii?Q?IMY3lRPbrxlQgvJb+AhgbR3QX7lYp8aWad+ghi8UeR2fx+j1xXYuFKSx8Otr?=
 =?us-ascii?Q?KLm6ZlkdQu8OjFPV3tIklFeoj5Ad9SHOVHCT61/VxPmayXZuWp6Iv3HMJavo?=
 =?us-ascii?Q?EjNfQwtp8/SLcXNH/yJGsZ7EGrj9D0Npxdu+g8vD7QNeoydn3B6dXmH/WuWI?=
 =?us-ascii?Q?BiRh3lvB2HyOsbDrCyzL6gqtsiarbb6gL0H0+KNdy70oOAEZlBiBBWZDWVp2?=
 =?us-ascii?Q?VXRNlf9RNq44YNRjeY/6NIFbm6CJrRMtGLCiqh3/IpNMzEclB966mqSEfypt?=
 =?us-ascii?Q?9skJXj0ivW+ohbnizTjSK4bjHLHsNo7g1xK4jpLW01vVBib+lLff+aWqiJr5?=
 =?us-ascii?Q?ASxqRO4nacEjTcabAhxwQ32zlR2sZAGlpvz8HMlSxtjBykMC4aQSNAr7zmGA?=
 =?us-ascii?Q?VqU4KDkeXZ887yMOCB6oaqZNezqIrG8hXH04kjvhHUC+0bU3Le7VPX5NAyEQ?=
 =?us-ascii?Q?0R4oUJXWnJsXZdtOyvtjVbC2QT9KkR9GKmhg5FIpM7Tc7dHUyXrfk01Vn2tp?=
 =?us-ascii?Q?31bit/ETtcOAlhqHsHh+VFVYiphyCrOzPF46vxyytQ+x306qSi2daXCkMWw3?=
 =?us-ascii?Q?nK5JfFPZQ7tyLBNLseMQ9njoovM1DhHCyqGq6O97l5WnUg6YybXMrpyNSUZ+?=
 =?us-ascii?Q?/wUpxtaxganR6QN5/SmVx0yDQsSmjpJVh2GGbDmxDuyBz3Jk+x1LXu8JwByr?=
 =?us-ascii?Q?/YL7xH2M/vBgI0fEmy48nK5x/J3Qa9X4DLVifJkb9ZnIRZDaifzTUe01BlAZ?=
 =?us-ascii?Q?Z+sMlypLlgIDAFT/qIz4eC66vWjA11w0cbTY4g/gnmuzCRN4uPr7nIr+wS23?=
 =?us-ascii?Q?3GrIeMFeZDTCJrmgofOtwKJdGLmi+Zkb5Hn5wx/6E5Olsww16rauozwv3vzn?=
 =?us-ascii?Q?XjrJWYdA4kjaBf27bdnnIpE+DcWEqBLeM6OxjzQUFzSQyxoAMtEUxBOulWKJ?=
 =?us-ascii?Q?yghUVkI5eiy5J7OQYtTUs3uTtO4wWBVGlZEHdIE1e+0qJyJpRRATCVsdEk5x?=
 =?us-ascii?Q?/IDvQIfvMbN9Fy20z4PuAnXCbI/oWSjjnBgUFNxqcAc+Cmai/UXjt9sVaOSq?=
 =?us-ascii?Q?vvLkUaGHDnuIaWv14g6W4aI/GGutArXzYUp7cujYk0vOgnZcRNSEqFRuubGO?=
 =?us-ascii?Q?dn1Kze/e3Q1rBRRMUs2eHkOmrFfKVxU5BGDqIzjQtPTj0lRU2CuHkTX0P8dB?=
 =?us-ascii?Q?ZN0fTZ0YeuSxONTLTYzPgJPiHS22L3Jn7dvY1TtPhU2A3tjGhOLFX1AO9Qwr?=
 =?us-ascii?Q?hGKnY8CSOmqB8YuP/duDpgIAsT4d+nR/Ty517eI/kl6MhAW9SEFwUiIWlIq7?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vouTBkjOpmFbEqjDyNk6nyM2NmmMF+d8hQsrXfzBb1pdbPflA/QWjqB5tot0CRWj2O/uVWMyKId9HaxwfLbjXeQjZ4B2ZP44hnlK9FvdDvlmiUQbIjg1puh4h1dYjWy6uShmALImtD/ZUEKfwNRe28jbmNjZz4jwncYnzpnNPk9336mxjGxhnuwRYV9xMLEkHtYv6ayZNNctHFezVVlMEaFyfxT8pubSlhSbWU6ku+QWaP8A160+QFf5yYUmAanr3mbc427Pxv2IZLAJ8MCSherBrzY9sKckTJ8YSIxbbyuSiwW3f374QoDHoOywSEStgsceS8XXSPPECqsZFrqu6mykqOyC0K7Wi5Ww1xTZTdqmUHm0QkEiXBbvEhlaAIFaNygtjgayT0qoYBmvpPHfYGN7+fNJXGl4cd5d9M2uEgIDng4yETms8lpVXg/i+sniYy4nOKppPfYU860wRUN9UvNHhqQDkp8kBz0ZDs9yZkNAo9e3bnsCbyNL+NHPSRpjBkUXaxjuH4G5YTY0FVis/JaE25CYHrRZBGxf+c/sbiNEkWwaZjH/eTwpSkOaaT8Fm0bBUXEDk0VEAJJXI+laKN9OFf7DXpF4oqt4ZTnUq8MThX+wv/e0bdQ4jLpm2pN8zZiyFNSTqI+Z4fiX8I5z1QyNr/6CC1aEM18QH0d+eOqU1oJrkqi7j0CbO6DIpy4Ig/IbvlewFe+FTZmWJwhq4wL2hakEeRaCp9YLl54D6vkq24uK0RxqQZPddhC2PU9QAMUy//qiO+gks3WbOGP4Ww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244aa879-4b8e-40f5-8213-08db77cedea4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:57:38.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxzN0tfgdNj1VX7huvAON1l3Lz+qR3yeA9eIAXQLXU98/sRACY6hfgp99ivyqgZzrcSzRRS/AdIahBVtDhfkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280105
X-Proofpoint-GUID: Ru21Cc8PauL3PTGfUiejP1hGpQtR1mhA
X-Proofpoint-ORIG-GUID: Ru21Cc8PauL3PTGfUiejP1hGpQtR1mhA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrsf-check.rst to carry the new --noscan
option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfs-check.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
index bfdd48bbcbb7..5f4f724111b9 100644
--- a/Documentation/btrfs-check.rst
+++ b/Documentation/btrfs-check.rst
@@ -89,6 +89,10 @@ SAFE OR ADVISORY OPTIONS
 --device
         List of block devices or regular files that are part of the filesystem.
 
+--noscan
+        Do not automatically scan the system for other devices for the same
+        filesystem, only use the devices provided as the arguments.
+
 DANGEROUS OPTIONS
 -----------------
 
-- 
2.31.1

