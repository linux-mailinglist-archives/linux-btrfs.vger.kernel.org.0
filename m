Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4B6F6D61
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjEDN4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEDN4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 09:56:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3C7EC9
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 06:56:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DgLC0008983
        for <linux-btrfs@vger.kernel.org>; Thu, 4 May 2023 13:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Ke8c/Lml9JmZInQFjhZRkv/tTg38hs41YBH+Amv4voo=;
 b=pXd0kQu+FrKw0rHTvg6cia1zWf//PMDKJKVS1m1XtdiPisJvKb5GV1/yypHycquNsgBI
 8+LDTId1Lpxl/Fh0TmPeUx0C4lEV5LafPj1apkwRIZEJDUiSpRwIW0zldr84RhOtcpE7
 jWYDuUdCMNux7COD0eqxAUULfe0+L5mWuC1E0bk1L/vdWIFT0PzAqLwxywfv+7D3Avp2
 Ec0Mq2mDpvM28B1t2BTCQ/0xPg2ydVCuXioAYDMYzkeNHRZ9u4urCI7htnD9ZM+GbrCj
 gMbA3v98yOheK+SF6i80JD310ld9joreXProBoTMniMrfZt2kJ9OVKt5By3h4b7ZtlhH yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d21gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 13:56:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344DY8sS024996
        for <linux-btrfs@vger.kernel.org>; Thu, 4 May 2023 13:56:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8ravb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 13:56:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNOxOm1vRwrkWkjxU+svR1OK8IPO9xLv2oPCinHOKHXdxDNBKg95WU6MTZeKA+npzsHnFQC74WOGveD7rOaTENEvGS85Ncj+DOEcjLgOCPf71X9d3tYwQgw3SdaukTYx12PxKVg5X3iD+IHgFq1IMdcYP2lixvmmULUy3JdK+IfJOwQdWD7/UHo3yLX1yvjPKORsKKLAwoL80iCRFcnnl3weqIOeQPzfjl9Z+rqqQwBLCnLHxvweq2RCtxARXdiffG5OHP5wlFyZbgN+Ykh4PVSEJiBUuWKYxgxzZHlrYmacDKODb2AC1pERMH9WCDqZsxS/cXewco47+FJlc0kyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke8c/Lml9JmZInQFjhZRkv/tTg38hs41YBH+Amv4voo=;
 b=KguwYQv9Fd1aPNYP7YNYY7+bp3dmKtEeFc1QFNjDFoKA14YOHLt9ebsCCq+iotxdDa8g5CUgSjd4ybAivkm5mx2lc1ZUvfTOrsWzo9DuOOm3ZwmRoA4PiWhRYvNZ+3DMwhMCabWO+WggMG4V7qXaQKcV//TMrnkPTOEYOXmX4MClyRaln8G3pUQmrLTz00zu0dGGuyfJH3Kr8kYkRu1kNhzYYnFSEivpSwz2uQx35Xn/qTUDxIH1YV+EkzsHvrUOcHijxJeGz9dhOuMwIZepKdgiztn0hiSLOuIas6DVeOE61XL5lh9JomFx3LhEGqsTKYmLVeNpuchAsPSC9OY63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke8c/Lml9JmZInQFjhZRkv/tTg38hs41YBH+Amv4voo=;
 b=uZDjqftCdT0XRqTCtXjjnLuxIpxHsVt+qIgCnTN5Ikhcrd95KV4QwSQm771ry3zvrCzARJb1dh2EoNRSaDidmOR0tdmcJRpJEJvSkYrsjig6sFsijawOSykzUpaozcZWcypMLjBCDIawBWvpJ+RT056bk1QHhq+Em0be57RDGMA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7530.namprd10.prod.outlook.com (2603:10b6:610:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 13:56:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 13:56:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: fix static_assert for older gcc
Date:   Thu,  4 May 2023 21:56:37 +0800
Message-Id: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 02506c50-ef85-455c-fd67-08db4ca765f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I96/xnw9EP5xVIr5Jzp2wA2fJYqFje5MLNH6amdJOMfPDLVS6xI7r1ZVNDS43cj0y0QEs8LynEQo1T5Fo7HUuUETmvUhYcO+gVqiMvyhFeKqdq5UtpwQQPAXLGI9TocI1aj7YOocTZj2x7Z4EndR7CD56vYlaXe6IHEjNbriskSnVLwsKmYrs0XWBdoj2prtJMSAz+GDg9eqQ7A+XXhnS5f0njaowUAwTnuFs/t3ht92CB+upQ4dqydNV4fMDhuPmm3Sx7cjHHNqRYfWO7mhmsLr49xgreckLG4M15khV/z4HANzczOvr9XKKuT5y+C3ryPaDJ+FYLvZZ9oegBx7R7IIum1/wbZpdw9QMBgwVPi8SJmwhNyLs9yrcUGWCaMjKcGUb9kNgXC4N0MeOqxiQWEeJXJgcCyQXyFUOcGIIbujGFFL/btupYmCwd95WlVW9mCvagSzMc19KD+ZwtVArcY2d3uRBzqgrQctT/+XnrqmDEvN4Gbt9wSAIJg0XJN35UrAVcJg5zwSW/2mREoazm99wYl4ODl6Ng67HGEVNgO6rUEheQp1M153iEv7xTaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(83380400001)(2906002)(478600001)(5660300002)(316002)(66946007)(66476007)(8676002)(8936002)(41300700001)(44832011)(66556008)(6916009)(38100700002)(86362001)(6486002)(36756003)(6666004)(186003)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rc49e5CGJMnNS8N3PMBDTDUmRvHmD2ysXLexb4G1bx83zc1x/QqpSWlgix0h?=
 =?us-ascii?Q?VqL9VeKJYxsmnyySUjp+1LLfD0dzFHl3v5HUMn7Bjgps0SOmGuQHlskMbQt8?=
 =?us-ascii?Q?SGNygDh+4GZ47/0zmX6pG71qA7Q37abDwEz+IFJr1aj9H5uFffJo/BBAQ3XR?=
 =?us-ascii?Q?tUu2ZbnNZDZnw756i539zaGv6cWgwy+Qd2HvzDEtAJIoMcNNxJrIUN+8yaaj?=
 =?us-ascii?Q?rImfz6iMFJeU141WgTexTL5/4mDHeck2JMz0teSqbFj8sbhJ/v863yOHzUVk?=
 =?us-ascii?Q?8Yac2ZbfHTEK32Fozh2cJyuPUumLALrdUQt+I76u57w91JK/J5b38VZ3hYb9?=
 =?us-ascii?Q?ZImn0Lq1eICGIhVLGzzlR+eZwt8MPnHrE7oJQFkebE1D86OR9grepJXtvE8O?=
 =?us-ascii?Q?K7NUqqbYQqulTygt7JTtqg7DIFL4IOHvPCTRWztt7+43F7TXLvI3+bgnJdRu?=
 =?us-ascii?Q?vP8lr/IhHf23dndqljvoWiB7Xg8S+OK0uOI9zRi9HRtopN7vlPdaIpDzZXlf?=
 =?us-ascii?Q?IQACH1nKan9P8eXQyg3gwBeIa8P3k4AZ3fIpwuAXItZWBuhLzBuWFAfgiSF4?=
 =?us-ascii?Q?FGIQkgdCzW3jmr8LImUjhRag/iHKTWG/qJnyxrw45zPrHzoBl8M+UrbefHIL?=
 =?us-ascii?Q?NQLEvDeP+BlfM1pQOovpf5dBbT0Se+Jmhf1stK/8cZv9QzcjHTBjTz1lNQ0p?=
 =?us-ascii?Q?/CpeJpX1D+S8T2U4YWsH4qXjl0ZFHQxoM+mMgFBKIk8gH3hn2HjEJqYOqxAm?=
 =?us-ascii?Q?pKsOBbzQ9tLNTgZ+9lRYJ0K0sEC1M4FFmSC0oihHNh75bFzBsIHof+j6HGzd?=
 =?us-ascii?Q?0dMqxmvaFUuTLJ8lG92m8vilzWp37D4p88qyFyXpMhfnLZfel1+baESRBgxX?=
 =?us-ascii?Q?UZ4DATqvpQAgZuWspVGmfLaU+eAhcf3yIx6ftK0WFJXk29CPNB/vB8P/TBK5?=
 =?us-ascii?Q?EMVI6ffO3vQ2j2JY5IiWjTM0XXld1jcAMGdPI0lmJ+GSHpnKOKXVzrZ2hNs1?=
 =?us-ascii?Q?1OcAN4kjxOLq1bVUGggQwxZSL978WlsxH5UGu5Gjk3VPDZ0olwgirCpT2OZX?=
 =?us-ascii?Q?eI7W/ApAF7VfUULihF/okIIUEJlOj9AsKpSLTkGVyC+zZTxiFL/yZi6inKME?=
 =?us-ascii?Q?UoBXvAG7zIYh9DDIpEE6Fnni8StgdvOz5IV5nvoNpijfQutF5IlBUi4wEBst?=
 =?us-ascii?Q?pBipENR6skxgdr58+ueZ0HX3nFmzpPy7s7NGYL8Kk8BxMGfop8T5/lDT4XUg?=
 =?us-ascii?Q?Y/1pKojH56LO/me1Cg5gRr/WtsLNfhdF2UY+ojYkDo3OraGTBVn6dI9OXzxs?=
 =?us-ascii?Q?69qazYWBVf/bpyLHKqLbBR6kuyfYv1BVsbj0tnVnE7fDu+dAmZ0r7SCmCbFv?=
 =?us-ascii?Q?/KOLxMwbFtVSC6Oetn66uHXU8pZFk58JhZ2H1zFHYTEwhdUpI0ruK+qIMnf1?=
 =?us-ascii?Q?EUiepbqAo81j76aAUWGkFHILmkB0XQsYPm2qlcOr2PgF4ahCAq/6UtINjaG7?=
 =?us-ascii?Q?ifz2/LCw6mhYRHPoN4E/PChMKd6oB2bR8zGS2izik0s0wNlJKX6kCL62wf4e?=
 =?us-ascii?Q?Yu0ynOFJYMWcJjEN+Z6O3sgBgtVr2WoTDxmAy0zCXxWfYCXMqaLLlLitQ426?=
 =?us-ascii?Q?3xqvbbM4EmSumo+BGhzy2fE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aLqWkGrxysEdDv7qOqFuHo8IpxRn8rMHUNeLKM6+GDW730PumwPGEWT8YG/7u0qxEnPLLmjVhk/5dZoYJZqmL0AEZlLaKFAPFzW8Z/fu6sgh0p9dvZp3vkQVkKKufmMusTu6yqsPNOldGr7mLTA6F0GzoQu8skMNrDrfr+UnI58gH3wZn4bZbo/doDlUZ4tX1zOQ5/6Xmb44PN+moQ9Jn9/cVDRPO8ugep04iE2aOAlTkvGtieQbD/mPdZSp60/87t/BLuMX9VJkdeipKy6Ke6hcNIMG2OQNchIl5ryCBntTDSH2hbKD0k/tUdpHK6TSeOunefq1sWGgRKa7sROIH3SlYTBzAbmNBatrI5++oL11KzMWDioNTy9vAhU8Ys/pbr2nKczj/aoBpHc1j5Ccn+56+i+9LP4RBS8HxrEHH6P1nMnbgpmIOeZaalBuN5oIaQAFDPVJOlm6dLglA2+D00Ll5LAJ7QtSURekyxllDkW9kqwq0TvsEjmInGTEoLroJnohZUPCADdRc99pTycNkKS0lj2CopqbnnkVqGlraUWQclI4svEGQMwdDBG2faVC4Bk8vUbOZWkUaceGvn+mGm6u2ghUebRvCQitSWzMI5SmQGZ9nOOsOSrwpyW5Nxwb7YYeNfxlG6x06EVaH00NyCnu6QNCdqWeXAS3QrziGtNJXKrPsr+vh9x7+wUfx5yGFTYIuu0GCgEo9zDWAPW8gagB8nXym4CV/Nf+qIPZHo23luxoPetFjZmBnSNDNsak
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02506c50-ef85-455c-fd67-08db4ca765f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 13:56:45.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vPFpIse6osj7Mz9/24H+qRMGMx1ydhk1DkICkfahgOXUWSMbiEcGTlOdITRZyJyrbH7Pwu4QqNXvb3uqIuOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_09,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040114
X-Proofpoint-GUID: 9qA2H7qZyrKbhibkHqmA3miXEGSkbUBq
X-Proofpoint-ORIG-GUID: 9qA2H7qZyrKbhibkHqmA3miXEGSkbUBq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make is failing on gcc 8.5 with definition miss match error. It looks
like the definition of static_assert has changed

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/accessors.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ceadfc5d6c66..c480205afac2 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -58,29 +58,31 @@ DECLARE_BTRFS_SETGET_BITS(16)
 DECLARE_BTRFS_SETGET_BITS(32)
 DECLARE_BTRFS_SETGET_BITS(64)
 
+#define _static_assert(x)	static_assert(x, "")
+
 #define BTRFS_SETGET_FUNCS(name, type, member, bits)			\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
 				   const type *s)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 				    u##bits val)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
 }									\
 static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
 					 const type *s)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
 }									\
 static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 					  type *s, u##bits val)		\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
 }
 
@@ -111,7 +113,7 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
-	static_assert(sizeof(u64) ==
+	_static_assert(sizeof(u64) ==
 		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
 					    total_bytes));
@@ -120,7 +122,7 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 						struct btrfs_dev_item *s,
 						u64 val)
 {
-	static_assert(sizeof(u64) ==
+	_static_assert(sizeof(u64) ==
 		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 	WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
-- 
2.38.1

