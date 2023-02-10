Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57F691FF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 14:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjBJNmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 08:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjBJNl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 08:41:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF413527;
        Fri, 10 Feb 2023 05:41:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAo4hO030990;
        Fri, 10 Feb 2023 13:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2y1DA50a8nlFYZnWlGgE1cLXZxJyYiZO3JrpSpI174s=;
 b=kd4AKQUQ2d7s4fuKYPX4qEHUT9w39GVpwr6yOx5vZOERXVdenxtjK82RHK5onlDmcspw
 ozpa8zsbW3+umiE1+Q8C7i2Hr71g5a8pt89VPhcrohOZ+MHmRHMqPprNni9eZcVjLOSp
 Eq9kqVchODV2xljxb+5nqPwfYcaJFCnMt8FwcKK7ggSPTODNwHHT8ZCIbsrHZ9Vl34Jb
 waU8KeHh/iUYx2VcBC2DdE+iXMRhPwsgigd04EbHBk/E8r5MURyasLGOs9KLDwmTFWg/
 MrAuGz02Vx2AfWBZp8aB7p/TZftLt+KZIIjzjICvfY09jF4VWOWoFOMa/MWLpDq6/FpW xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53n8gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ABhEe2013652;
        Fri, 10 Feb 2023 13:41:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdta91kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSuz6bGqYAWyzF+UWdK6EJ1X48YFDqvqXaefZpCEpCHBQkrydteefna/pIJ5yjdgnISHX6O15LrNMVoAv7sAcp/TTUdfaVT33K3y9BOcywhiHk+ze7lSeojx1sG2Tk7PGkVmiXLL2d46Ll9ZTD3wJNvVkN5JNRh9pSc7dnxuJylYWrhxQlfSXZzFAyep4WKdfGLSWMelnb70ETzxNrcG2bOpNRMw2EfWiR2jvHpYioCY74krAoBdNsH2B1aTAkFo1rcn50VzjxwU6SURywUSI3SMaF8OvD0gcTIa4cdEcNArglbeZ335PW2jDkz/r2emM0UE/FLA4o/8OsVx+VY0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y1DA50a8nlFYZnWlGgE1cLXZxJyYiZO3JrpSpI174s=;
 b=b2Gi9k4HoKVY2h6f7YsfukfHVd8lYqP+tMo8J04RbA0iMia4pqbk6CjztMcyWE/40Qn4+75Jbiz1Og9nfLs/oq+ojd4pYwmlUmWfRIwezV8JVN4KCIbqDTBvH84LsN4k8UwGysxJg65oCeJLAE1wE/cbFgnMZ40O0pzNdXvo8XctRNPeCX5HHr6oYR1owVzniuaZwMPw2dBFOgNZUoQBjyjhQdbPiyEp6kE+CCICA4iGN6KNnt4oAYA5e+h3GG4+ensISn9gBcgH6OsJy0EC6sl5K9NSLhR0ZyZXx0XK45d6XFDDItfauz4jhRHqI2Yx1LVKvyp8a78sYHOg2ANSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y1DA50a8nlFYZnWlGgE1cLXZxJyYiZO3JrpSpI174s=;
 b=X40rS4apA69w8L6PHhijMutSkWg+oOJJQQbiU8ld8uFSTaFg0oQ8po8hfu+TmYbFEOAnBhOvx4MtkkA2+F3OxlXIXpQsa6Rj/W6gshMr3ADkr4O7+392ZrnsW2pv364UoNpbbQ7amJ7yqRfrJ8JUmevL9PETlYmuDt26IDR8PIg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 13:41:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 13:41:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] fstests: btrfs/185, add _fixed_by_kernel_commit
Date:   Fri, 10 Feb 2023 21:41:21 +0800
Message-Id: <4ac4ecd714b31cf8294a0da56889df0d5014ed65.1676034764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676034764.git.anand.jain@oracle.com>
References: <cover.1676034764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc7df25-bc8a-43a4-9a9c-08db0b6c9018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tyGjHQzuhe7rdNwl7NKm5rnLq8wkhuU903HxxT8sgMBX2uARLiGzf/azX/c10bMRZjDoOqsVztBjhl3Mily8qJF4TJTuxijV6TkvWEI3Z4nsYRY8mF9ENz9gsmc5pNsfSh6icK2FbZpxaFcCa/dNGJ9QD5mVxMTMom7O3lDNnleOnPWAo8iGEcMH3ahbLbGH1vRM10zujZ+WHKVCWMYiXRKilqrBrrQNUB0FnowH7x+amZMds/MB+0foOQsdJGK1VUly9gJx/ipf5M5gXqRf4KX9ORLXeCAscpY5mwtWGB0W6s1cavoaKvZU3g1g+pUFo+ljvutXEKHCorhR4DJNhPgCuW6hvzlxjG90YdRy0NQmAypVFhdNJ/sZ85LZZyEDdQ3Dv2+VtS2kd18tf7hRD6vqJqNuSFvenoAF0f69Kkl2a9ApnDViUYyvnGCq2SH6L+ssfYIT2VP50I4NxYf1seO1zRy/61q4/RaLrf6E28A6d0PM4j9uoDRkX4eNhRKBGiKQN8YEqd77gv3rfrwF7W5Ur1OFlT6dttbKG+99/iZa51EmlJJ2PtJJ1Bc9/3PiqJb/tqq7ObHiGvZe6TNVz4v+qEL+kqTyzuRo9JX6RkyXxkIeMoBJH5hc+x6XTp67eHdCqPlAsLmS4F2WJCL6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(26005)(478600001)(186003)(6512007)(6666004)(44832011)(4744005)(6486002)(316002)(2616005)(6506007)(4326008)(6916009)(66946007)(66556008)(41300700001)(38100700002)(5660300002)(8936002)(8676002)(66476007)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vjKhHyscNvXpeB18aUOoErvAsq2iJyEPn2h0kwT1FEkZquYHmjVSWy6p8gu?=
 =?us-ascii?Q?C0IcS82gog2e+j3OX9f4sDfmpRWFQDk6KNluj9ft3FUkFuaNWBLJvbzmjyB8?=
 =?us-ascii?Q?m0x6TS/XcE9FEXiVx/FMVVQsmrUfh/iA+oiA9f5+eqfk1QhRwsNtVGVqPYdb?=
 =?us-ascii?Q?r+tzTPDlZdvKF9ZIckCuaCFSH3QYPIcqVungs7IGllWosLDtuJG43Njwcwa4?=
 =?us-ascii?Q?QAxQZOa7kScmfWEnopzMGcx55IuO7Djklcrb4EWCmyWDYyqqi6XQQfgivYrR?=
 =?us-ascii?Q?czq3dHhqWI1JxzJ3SSAGq0z9MRjRhi/8IIxtFjD+WY7bdhoQcZC9TJnxq+n8?=
 =?us-ascii?Q?8mgxOXV3fLy+Zk/Ud6ltkssYGH05lJhk6LQMuo2NHdX0anFV98qGPvUEsk52?=
 =?us-ascii?Q?xVI+SxcmYVwbMvLuNNCuUUtC3hiqyfwdOGQgkEzaOia9Ylz3J6D169YQvNdM?=
 =?us-ascii?Q?MfOtn6a+3lRGWPWQlgy/oTQ3ACrWRLUyjM1LLH7YM9ksdJ4xVEHVZF6JOg4r?=
 =?us-ascii?Q?EAmSToS0RJbt8zwcUm8u7pOZZ69PCIuIH29ACFqNoA6bSCBysSlqgUZXss7A?=
 =?us-ascii?Q?Jm6hTmz9UfkkxnHrD7Vu1vg2rR5t63w1PzHfD9I1vQU7Xjq5XTHkJAW575oV?=
 =?us-ascii?Q?jiVpX/NdnLV/cBeKm294fvH80L1Nesdj2oEwkHoLOlbLPST8LYOZp6WZdEFG?=
 =?us-ascii?Q?e+Vz+hYf/Zka7iEYS3Ar1v+uup501uPMz8MM83C/TBXLlJDKB3R1/14X8CSz?=
 =?us-ascii?Q?B5GU6mjFaMV+2RlTdQ9U/P+K/jSXyqAqHnR2oRmmTHEKPS7BIWQgJvnXULZv?=
 =?us-ascii?Q?JmTBtD1r3FlwBiJ+d9fkdPanmupzIS7tcQQAHUaTgreUCmaVbQcHzQHJDrSC?=
 =?us-ascii?Q?GEHSmKxeTvbS5oIvWPuv2NKAqmztcH+A7LTnRr4BDA0moMzFaaI5NCWR+6xH?=
 =?us-ascii?Q?CLwITht608xq4xRQZasbTnzGfjHE6bi/hbUU8zAe8mfKOTJU4DMX0uWtF7yk?=
 =?us-ascii?Q?bPsS6BvzYYYhNOf2ZYkuqsnAZ9ozf07axR4CkTsWuO5HoBiA2ZpcnR/xf5wb?=
 =?us-ascii?Q?8zYSCRj8bwbeV6/G0gyKY2ycv8/VLw4oxGv/hdyWwA/xM/jvVTgMYawO5nli?=
 =?us-ascii?Q?qsJW0r9AscK+56Dydy6IAqYnZgolQr+1mY7HPuT2FXfoF8gK74LujlTcP9Bn?=
 =?us-ascii?Q?bDIKy1W+XvSOdUrMSr8mxfiVCMsQ4cIeBYJqF2Jr8IZ6Tjy4Obr9XcaDKWuN?=
 =?us-ascii?Q?ujKbC6wP0t9CFuTneMEN1eClKbbICra9gpw0GeMjeq7MxxaFcpRc3uSayCo+?=
 =?us-ascii?Q?opf91rW6y1QeC2yzWnEmd8ZjXnqBBTRNJRukX5xR6NEbHf7ma2VZFaURLVPo?=
 =?us-ascii?Q?ZszFtL9PSfb9WVwojnxV3Fo9/+m0KulM/SI9FauMnZGaYcJvOWiIBqrcPSC3?=
 =?us-ascii?Q?AQqPVEllj9u/MB9NIoabZMIJcrI9K6giwH52j5SCQqPIcChMOTzG1Zsed/o0?=
 =?us-ascii?Q?cFcu6ZSakfN1Hd7QRJz8/WgcRu+mrQpF80Ilnww89u7B4gut4YwthJSCav5g?=
 =?us-ascii?Q?IZtNXSJNntDN+/mRO4NGWGvybrL/d8iSIYHxOF51OwPVQA3Bdf9e3MTwQ0n5?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FqctMGwcOosz08m1A29KtcdCEKZuAJtmaKPf3MQUPiczwG/bdh5FN26pzbZhvSWBa0J7M/vgIJGRq1MVCQOjG8/05+QIw+ZNX6F6Tjavl6oTBFQ6chvxUPlUeAcm+CoxsJ8ZtDdtWCaPvLCoTF6heGlJ8Hm/zlL0YeDnjQv+XkYJiMZRQlsMIjjB9l9WQAPKWvv5/5OleTkY/yqDjx+jvVTyLzBOfufQylrbKle6K9OhF5lXDQwJTyubqQXGYqtPhIQoQci6E365SBzL+dR+cipZmWkUzE7nMssZJKcOrYo9z07BJz65dN5pn4UgQcjFgoVEi5vJI9wqqmELQiFX+0iQ6J5itpIdUcPFgIexKgn/NwhR25B1obT6j0v2/VZSJMZFfD9IPI6Bwdrf8so4+4a88x59Z1x5J6wyN7LNHwocTAk+ZYgFdMW6BL8G2MJkSz4Mjdng7hkQp1rMjenUkxH5yXByoC0c8pfne911cYD6k0JLBKTufX1Irmwm+X8GU4OrG51inKjZI97OXUux3Hsdfod16TZcJK9nNYC3x5Z7R+Gym0unB2L6tKCAvzkYqQeHehhqulLoMVPNf8C3U9kuP2QHl6LEXYJQsB05oQoWGPJZ+2cauBJkDN1A1sIbIKRpw5wcXIVSBadYTbaXowDJGnAxeYyGkD7IkaA5tV9uR73if3Gh0UCBgXL5cyNuYdWit8KnclPUo3m6vagN/U5a2Pdeg3GNSwi8/9SZ0w1tNThItsrjFDJ8BHEMiNGv3s2Khf9gblo48xm4R3wotI0yAJfB5xJUVIydwGDQeDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc7df25-bc8a-43a4-9a9c-08db0b6c9018
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:41:50.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lg5CIaMk/9yZ7VPXKAPhGsAVs5GgY7J4j0jYAZNtuOJfhDdl30ulLFzQSqKy98IV/Y0PsKPYThE7RAQzkd4qDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_08,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100112
X-Proofpoint-ORIG-GUID: QMJ9oAUzPtCpIKKjskj-Vm76N77xkPj3
X-Proofpoint-GUID: QMJ9oAUzPtCpIKKjskj-Vm76N77xkPj3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/185 is in the auto group so add the _fixed_by_kernel_commit
tag for the benifit of the older kernels.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/185 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/185 b/tests/btrfs/185
index efb10ac72b79..ba0200617e69 100755
--- a/tests/btrfs/185
+++ b/tests/btrfs/185
@@ -27,6 +27,8 @@ _cleanup()
 _supported_fs btrfs
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
+_fixed_by_kernel_commit a9261d4125c9 \
+	"btrfs: harden agaist duplicate fsid on scanned devices"
 
 device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
 device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
-- 
2.31.1

