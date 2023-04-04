Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BABC6D6602
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjDDOzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjDDOzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:55:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA34C00
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DuUk6017273
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Apr 2023 14:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=54mj2vAeRlHv5D9KCVtRSYxZ+tHKbvPXa9LChF9yhE4=;
 b=iwiODzRRYkq1xFKoVEy7lNb68n+zZau5q8+wVGiYTByVcAme4QBetCNH6RkDo9rKPCOU
 4lookyjbEL8RG/uG9UnARuPO5+xpILKS6HjV9P2WylZOQdX8n1J3Fa0xfUHx4WM1vcxH
 YNu5Njjtw9cmgNf1RGXCJrLAGaJoYCGs40FDVscnwY57x41GAzbuLriXkr9k34OOv2l3
 Ukkej0XwM8nn2L1VqO9Co5L4ebu5I2sipbxRdPBVvvd2789afr99BMMmtjEOrEZ+g79D
 RWYJuNN/o2qg0w65HAef6IW1FrVaXzOtcshsxsgCDDxow1XDf8NikXR4wSrES/KqFZ+I lQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhbx1y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 14:55:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334E92JH037592
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Apr 2023 14:55:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjs85my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 14:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMod73FE01Ix+ZlkmHoQ5ugJ6A7J4Y8k1t0APiBBXUNfT/M0ZXb7KUl0STdw9RSmlrOW4LOSdFgqCr2qjsw33Rk7jGBK8w5wbNjQJArbpZTHhX3YAahcpQnyrQJfKuB6OMlA+vSwvGx4wmPHxvXqY+11qnoNBHiaqu+d10+MCoVa+Czt5VLn/C82WbMbfVZELmh7LkAZwY1DogWnDSrhGVKdS/E0gbp8KOAZN0uQY/fAvomWxYpCF0aGLDJg/U77+vPYZyHDS/o+Rn8J+wzv1MIEpgkTwS44JhZCmIhQ3vpkFAOiTq8lHG6+/c7wrPmnsNAx7WzDsSRmmDW7EqJLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54mj2vAeRlHv5D9KCVtRSYxZ+tHKbvPXa9LChF9yhE4=;
 b=USFbn7szuGF57u/wdDjWzYcBd76HpSQVDRf4+/jTdc3cqXOcqEmGQkA5A0ycxxp3EeS0Zs49Czod6AGUeIfluMXVc4jCX54Oft6j7vzD3xFKqevOzkeZ9FfWhA15gbu4vVR52hX2g+3YNsVWWEat3xIAHVSXg9X9a6ws/9bgoczYx+SlQnYBzQ/VJO3sUKpXMNARZAMQAU/Td8obPVPpOJltAeXcFmSQxVx3MToGFJs8BM3TWgK9PE6E0rMfJ78FqYGWu8Ra+NrFCk5PqvTv2AVL4e12rkUXC7DgbIHNNHpKmie5FPghaqzL6bjSIItCyoDHTQK2kDazWcKt/5u72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54mj2vAeRlHv5D9KCVtRSYxZ+tHKbvPXa9LChF9yhE4=;
 b=MsKZJDk7C6zPuDZ1QZsF0C60eoRWKI4ZAOFKgkamBALFwRthKmUdhn1HcPj0MDK/+0euoigmFJf0Bd0rKXSwbAsnb1D9xx0M67wNE3J75tGkTzaJcaTtO7yB4ct0CkEz0JjfUAzAD8QytN4uG6RiCxQelJBVn6FNvhN7nzWO30k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:55:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6254.026; Tue, 4 Apr 2023
 14:55:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/2] minor cleanups for device close and free functions
Date:   Tue,  4 Apr 2023 22:55:10 +0800
Message-Id: <cover.1680619177.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6106ab-e7a2-475b-f077-08db351c9fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmMQnsmAW3X7i1ipZpkbLQjIUcLEHyFs4N8nrvk9UxoPUGc5JU5s8xy9GROrbk9/iEKOvT31OUaGvjmqdvLHJE1xkfBzU9PqXfNUJo94aytOs4DiPoOELIGZ+G+bc3L+Kw+U8s8o1BvVxjrVDjRVVinnhNYHZ4R/DRHpB86fQqNUEWoM4xKu28diJIU3/fbhKy6iWUHZGOuDXsaWcyolWpHGze0N1e2mDHRGkjfKiqUw93/sDz1ysCXpdMTQzzawoUil6zAYHfYrXk8KgHa43j+LsMdcTi65JZMoVGIItbdw/0nTE64tXl3cPx65+dkzJpEyi3lZDcVYe8W+JcsRTrZ6xEhtAdtYK+g2yf9MeSbus4MdWsEEiXBj2dX4ICc7Jizyp+KbUGLJ0zWU56EPqNem9W2Kw3W+r3fK2SSx+HseRrX4aduGbhgqb2GRI9xvVB1CiRkunrZTpf8rp2xJl3lB5/WEW0gkrr+AdzMEacTSGdsb1K8wAqX/EgpoHRAEIDgNs9MIZhsPkgMSctSX18oNXUy8nGjGUBjHjtzDHkx9WzjVVr2AbBZJ6gSi9Je5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(186003)(6666004)(26005)(107886003)(2906002)(5660300002)(86362001)(8936002)(44832011)(4744005)(478600001)(66946007)(6506007)(316002)(6916009)(4326008)(6512007)(8676002)(83380400001)(2616005)(41300700001)(36756003)(38100700002)(66476007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PoJ8ayLzL/BS0wfag8vz/peis7TMcKuegQqotjr1QVwz2IwaJ+2j4Rp6jSrf?=
 =?us-ascii?Q?SiDirB005kVxXnCJGqkRRcmhZfxXGOUj0K4tEQC0+fqTm2n8ItAHHoPMHjzZ?=
 =?us-ascii?Q?yTRTyhkAJclxYkdKIRdxqes0X6EZLP0VwjX5jer+LdUMLiw+dGSc4XTb9yjB?=
 =?us-ascii?Q?r68iqvvhsTsLKw+ZRTHWndcEgsYfYpOKoC0gWLJ5SbDx919I2MLaEkDb4rb8?=
 =?us-ascii?Q?jV6ZYuMlkQ2I248s2hom3i0kW16NrVMyABSdp3SqfAYSTrn0Dp6BG4B0m2nj?=
 =?us-ascii?Q?5froqUDpV1Ewr9QELtPg0uhKJTVXfVbhwWJOa92EcyBRDijVGjmrtgBSVoYP?=
 =?us-ascii?Q?p/pBYrXUvhz1+SWCxLgZtgFilkXpMuZnNU9ziRcQL9QRV686ivQF3c0fJ1r2?=
 =?us-ascii?Q?bGknard5CFl34tAboM/5wYjvYXTxkr2f/5jfIJ+KKzw3AuZk+uUSOx9NRFIN?=
 =?us-ascii?Q?8LgvpnudgYTaha2t+qBiMvk0qM6KjISoI5Iqy2UX225Y0U7ux39fjQGsFaOo?=
 =?us-ascii?Q?g3X+ixjsqB98qP1gF28alwLuIMeKNoFLbik2ty9yhLZEBjLjv8eJdDqhYqyN?=
 =?us-ascii?Q?jZ3Xafu+noy8JRerKbp5TPxo7c2sKvWYoX5JgarPA9tYz07tFDbihUMVMFTP?=
 =?us-ascii?Q?8xUvY5xQRxYzvpLBIh5+oUiuSs6ppRZ5a/nooIocI3hOin5mIhu8gRYLIO5+?=
 =?us-ascii?Q?dLAotzqflMEcwPfQTtq13AwyN6X5twdfokKydLeT+GaJoj4ZNOo6CQJeNYzB?=
 =?us-ascii?Q?+Dt+hlu5x0VdNubiWT6+lPBTgaBCTKDe/dxyEkusg9qEKSzhjwsOKbgxUy2n?=
 =?us-ascii?Q?vWo+drVW1O6gQjg2ACJN/eILneTnJMbbVsaq28NbR50ShWGP1h9PyyB1wp7h?=
 =?us-ascii?Q?YUwTuzS/muVCqRyw1PJXD+gBuHqXv14vES6xx1Tk1S9pTjpvb23gmk4CZmhr?=
 =?us-ascii?Q?n8oDmRfna8JQTFQlmUEfub991hexrn6XWm6aes8MzFgyT/zIb0RZks/VZovP?=
 =?us-ascii?Q?T3G10Tp+cfMPU2PGKRcKrS8WhyWcGcFiKAjTCqsYSE1Phc0IsUJ0qpSDWHjh?=
 =?us-ascii?Q?Ab0MHa3k56K8OA8hgWMvcaD1q7Pl72U97Y1cjn0QMDoUfR55a5PtQ64XFKV8?=
 =?us-ascii?Q?5xl0CX5ZLEHIK4ZG6BzXkvu/8FUmVN720880THha/LdODCegR/xgssjfgJXv?=
 =?us-ascii?Q?ODQwYLXLyclhbmkychefMui5d2dCkiPuPEdhZwE7nUP/tj1o/ArJNMaGWfxl?=
 =?us-ascii?Q?C0gWd6qtHgKNh0yldTSM63bilaji3M9phfeRCGnJV2wGArw+v6zkVa1uoZAo?=
 =?us-ascii?Q?gMbPnQ1mdILo3qbgOeaQVqeDeou+eyXsO/v3wRlZINjj4gROHDiQXILOgEDH?=
 =?us-ascii?Q?C51pU1AQp8Gh7z5eM8it2BV6gPQyuCdZfuvyECVxCzFXT+cRo0bt5zzXwAPq?=
 =?us-ascii?Q?w5VKhkITlSQkBaRm1pKDrc5CuPkIFVxJlJLrmC0bzqk3mxg0XnDmDXJ6LYUO?=
 =?us-ascii?Q?h8nsQr5WbSIG9kpCir5DdeiG0wclURtPKWSvs9Wkogck1ag/T4ATBfweXvcB?=
 =?us-ascii?Q?vBm0i9WFOQaDeJxtgomXrBBjcm/qaVJLw7hiUdBP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XP1APilOG/mq5DedlSZtKaQKPaT9jao/2R3JwALbdo0aT0z/vvH5PwYuYx1tTBSpRSJQ75xMMppXh71mhWnI9vyJq20okj4XlhL+ljKCJgxLh3zV7eAHfKlOeLqCXDg3NTtlu4mrKzqLjtwpdx78JmuJmH/Ia06xXXoNuqXMBEflJmHsza8PUyy96KFM4MF6tEuiF3V+gwSxYd3zFwlh69JRpTTmDrdvRwPXNClL4U22MsxjE5RZZS5PbdFURq+v3xFVCshMYItWISeLMzVSuHPVdJAf9PXzBmntc5NGy0wtmni0TCAxqTh3Uifp/qwsLk3lnb/Oz75t90ZsprEqt7i2rFBCJT1WIiFd7YEtdQh69aj6nXVIt4x1vUlfK3hgN2CLxRyYLfw/Pad1vj5Jn32zjUHEL/7j0fuk6bJc7pENeXqnbdH8wgYpsS9YfqmLxoZ32Q5gR/WCxvPfpAHT8Qchfw/DafgLypze/ShDot/f15mIq134QXAhw0aytOOUqbM8GzSNDha0jSknrLkiOnsIyxXZPHsUU4OsdzZPRXtB5Kn+mdiYsof4wWt2m/+Fb0NGSaE4KryCs3qZmw6+Lf9P6qJR4HpLg2Egp9UG4fBstsgz//i797p6CDnI2yN5P67777yQ8yufbhp22LgzUDDHd80wV2w5vibh3qQQrBIJGIz7SLUO7yNZ4e6Udr/AamEqhD3SUnnYfFfI+m60orqZkiOn6DrlCK2FRXCvQoNvYpI8vaP7PJd8ZVmCC7yR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6106ab-e7a2-475b-f077-08db351c9fef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:55:26.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zm7wUZn9awjm/rGaPontsqmf7ounwQ/zPRs5jTTIC8+Yu+Ixkg6uYENt3Ts6YKadFAzTU+xjhUUWUDngQGrVmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=739 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040138
X-Proofpoint-GUID: k9P9FDSWjV6N_nMO3H48ACQXxzF3dyYU
X-Proofpoint-ORIG-GUID: k9P9FDSWjV6N_nMO3H48ACQXxzF3dyYU
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series includes fixes for minor issues identified in the
btrfs_close_one_device() and btrfs_free_device() functions.

Anand Jain (2):
  btrfs: warn for any missed cleanup at btrfs_close_one_device
  btrfs: remove redundant release of alloc_state

 fs/btrfs/volumes.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.39.2

