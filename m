Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9833F51B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhCQQJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 12:09:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhCQQIt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 12:08:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HFo0EC182764;
        Wed, 17 Mar 2021 16:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=dMuw2HH6xzKL2sfGq63ugkLnjzcZMmBddlqFskyJvN8=;
 b=AFyvGAm5Jkj//tYjgc9CgvleGLyvhMBVfpGW7E/bXh7VhSDv4jrIVVwtGBiK4Lsn/wek
 4wHpOydAzFybEoHgI5UWgeJPxRlMnWitosR34uZcBMmSFvTYcdwfxhgvKzo+gLlIzytC
 Q+OUzk6dXA+wf8yDohc4bX8TeAXp4kKbLhtwFecRNEEaz1Gx/OBN73ZNJ6dicUhGwLZv
 vQxJE/P0U2Vn+Yyu8vq0yaXtANVj0EBqn/YpzwBuiH1+c7d8+M8f0LTvTC+SDKliu0UJ
 ulCX+r0ZkS2sRdxgICfLq9LhFmJiXAe6oFtWMoWllyWmcPBOZqWzMcFR+eTtfk1mSTRR dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 378p1nvkqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 16:08:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HFpSYA084490;
        Wed, 17 Mar 2021 16:08:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 37a4euk0xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 16:08:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD7xvFOsskpCMBU0n5a8lURNRajWpCgCt0mUUF58UDtTEVQ7G5AeQVug2jixlwxYlZqaN9/F4SicY6SVbv0FRWhH9Pg2Y6Wbtamj+4n+6h3N6sZ1KhxS3R31MgsWi/l9FaM3KvP1rg0dTIdEcSN0sAseYhpNUtTzxzEOhY3C064U3QbPhO9Q+D2q7DzwGgJvfnroakrbOtImWmSQXY6+d10TYi53R8EFX5sO6gtyD0Tt909JeTY+3M5koEU9xDnwrB9/ZbERBAmF8IkKpc7mnQEOlWgl8SjcenhgpFr6bMko1c5MAs2PsHSevbiziZpt9zzugjbQF9sjFYXYmhe1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMuw2HH6xzKL2sfGq63ugkLnjzcZMmBddlqFskyJvN8=;
 b=BNyYYRcegEKBByL2/GR6DlRsJL7xel4W+U6SubbX5pq/IskJ+1Ngp8Mbha1a+BWMZ6DwGsUf4ntTLSFQc8M5xtC8GD5jtFqDNohK3SN4tP8+dvnJVDaOCZC+f6BpbMYONKEeI4TXXF5SYxI2qyRifdQf+TwqUtnpGEB0fsgEfVKci41+XcCgsEeEXRNwAh0CHBQVCG2yPrHvImmH/cTLCx63WqW6aWXOj80MRWojbk7VOOxLUcVIzfPMuadwhKjB7dUif4yeov+d3dAGPPcrArIqxoM7hzs+Qiaek+hUs650PZpyIMGKr4rl7S344NcldtY569NZsBaSr//bpN22NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMuw2HH6xzKL2sfGq63ugkLnjzcZMmBddlqFskyJvN8=;
 b=M+wFPezb9IMB4pnQAA1JimUcKomwytf194noPZAJ+ESTaXVZQdEGQqrfkV/vhHz0hVlJc0r4MgzFVyCJAM3L7yicCqEb2kf/bY35CNumcuknGwNMzfNdgA2c0k9AX97yC6cM5omGJspLllahCwK9x/Bxgr5CvHS12GOl1Sqzy78=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 16:08:07 +0000
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::d931:ada1:eff:2615]) by SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::d931:ada1:eff:2615%5]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 16:08:07 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        victor.erminpour@oracle.com
Subject: [PATCH v2] btrfs: Use immediate assignment when referencing cc-option
Date:   Wed, 17 Mar 2021 09:08:48 -0700
Message-Id: <1615997328-24677-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.59]
X-ClientProxiedBy: BYAPR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:a03:80::47) To SJ0PR10MB4477.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from toshiba-tecra.hsd1.ca.comcast.net (138.3.200.59) by BYAPR11CA0070.namprd11.prod.outlook.com (2603:10b6:a03:80::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 16:08:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 259eb054-cfa3-4324-bb3f-08d8e95eda2f
X-MS-TrafficTypeDiagnostic: BY5PR10MB4129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB41294DF8F5019F9741F76101FD6A9@BY5PR10MB4129.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akXZDupYapCQzs740SEhkT9DbJD93d9lBn4YbQjVLmcqxd77G0GaPZyisCHes7IEvOnG0WLN8HdAowDZOrrbmMZUsJWqMZSixLSU4LAz8ApJ0PY0C9+47quO154g/jOQfBQYs9Zxzg1YweL7FVxklXwecB7b7hNdZf+hElF2CXvqPhl0/YPqTpIWyjAx5WF01IQUq696p/L5ZPJHieJYkvQkcRBomfzI0ORD291uwjJbOA/ybBeXo7/CR3to/W04dDzmop1tr/s3Yk82ii7iWaWMGYZ5O1lIaOyj9MXjZ0/rvQgvUcPLUbMmE2JV2hPIyFzKFD20AM5kuxSmir6Iy0Siv16A2ZfMor1MVUjrE0QOTsMCDTy92XC1Nu3WBcX+lNJeZqaQQlLD7t7U7mqrfb3yXzIAEUfQN+YcTl/+DnzOQk6bhdlj22bhN/tcgztSS+p5mP6as5Qhjc8oxj56SkID4ndTn4ISNXE+5+iWVeyQAvzXmOlgjhdH/fHSQXQdgHimdVNMEvE8rBTgadBE6nTvY0OiVZoQp/+c7MrJh34L1sXi6CwGBhPwk8ifENM8KqT210HhoY9DBJgOgppz3Lu0+41bJ0OyMaGDg8rdcyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4477.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(4326008)(2616005)(66946007)(478600001)(66556008)(44832011)(16526019)(26005)(5660300002)(36756003)(107886003)(86362001)(66476007)(6506007)(6512007)(6916009)(8676002)(956004)(8936002)(83380400001)(316002)(186003)(52116002)(2906002)(6486002)(6666004)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BWjMUwMlg1O2fVp7H2H5cDP0KBfuqF96b0pwDgVV+LMwGgoqeCKioPEv0vbY?=
 =?us-ascii?Q?lYMyb7G6fU820XmxTTEerdkl2yj6DBxWd2bpwsIKi4rtltc0H37wELt5ObRD?=
 =?us-ascii?Q?zpLnZeK4R0nt7k0o0Y5NG0wuD0sZWyZsxqK7N+QwY7xuZSFR101CkqfVPX7I?=
 =?us-ascii?Q?xjopF0xf2lYLC3x3rytjflEApiDycPPJJUNqLKknPyyrAua27/ogaYUcyknc?=
 =?us-ascii?Q?zkBbLb44mMuU/3zwK6JIli/NWhkULc1zTcBUUrANNPpbnlzjTJ+f0AVS/Dm6?=
 =?us-ascii?Q?g3x55veE63kuH5EG1X4WBbrMonBezKWJCAlKFaUrB720hxsqUsyaQD8/l6Xf?=
 =?us-ascii?Q?km+NLtGROswPVBudF9FsW+RsiYOVkM3CyAOa1otUkPRba8MGjFuZR+5QpcYT?=
 =?us-ascii?Q?B88Z4gkglCF0C6z/FXqVicxdb5V1Mu0S5oZFLzpovu5gjquCcDqAfWuIXkkw?=
 =?us-ascii?Q?ChTHmBNn1KLUdIzQCHb6MEjGqD3F704c57CdAyHazX5MUS7ArkC5We+Z07AZ?=
 =?us-ascii?Q?K52iOrOflq98R8KpBybrvY8J6pQHgczpZuyZbMAujIe0KUERXnP3Z8x0Akyc?=
 =?us-ascii?Q?iid+HG1Otc0937XleUdebJngwy7dj4oGSbOFaxROKuAVQROjc6vCLkWgDDDZ?=
 =?us-ascii?Q?sCr/vJNwRZ/4IZ1biyIVWEO7sxqQSguNq5Alhqgu+A5i/ZSTnq8DsTClC2NB?=
 =?us-ascii?Q?RT/VpddA0Yn1EqmrjdVT+Rwte3e1Oa12SSIRl6Ycvlb/dqQmC4gTJSCgQEna?=
 =?us-ascii?Q?B38vDDCEOAG1tLWNYx6WjmMxIBzkgq9Y7cqV6VX8PWZQS8/lImDsXuVa9OPt?=
 =?us-ascii?Q?QNeaMTjbv+7UElDjI7/PP9esvJEdE6Jp9hSKFnbDR/xlR1MewmfkeAXI5+jt?=
 =?us-ascii?Q?0LmNoAd2xqgy3H/qCsFg+plNxvQDsjenkkYfEMMxUXWBGTl6wYu4/WsCTo5V?=
 =?us-ascii?Q?2fEXcRQwcJIbANDy8DYnKVZ9KRKqubOQP4UxW7tXLHLpV4zcckE9Y9F02qjH?=
 =?us-ascii?Q?oxiJj30kWP4nXfrBm9Pey22S2hzxhf2fY/OxrIw0r4odCme1kL9G2TCe979f?=
 =?us-ascii?Q?FGwo92TdjUGCxeEOwQMwHyW2xggy5cQiahgunwtvSvE34y7HS0UnO5TcQvmb?=
 =?us-ascii?Q?ZZ8AQcQrLWOOm8+B1fefeFWnA2tYSrRyKWuP7xfrxiBRRFpQjL5XW4mCngLf?=
 =?us-ascii?Q?sEuNr8eLL7QmVPpIiY6/R/2Zh9CNA7UUd8HMtJOz59KlcVpvaF7h0hOBDe0H?=
 =?us-ascii?Q?ltAz+W6z0FQtUjo1nrb+PpJrFrywmwLXyFNOmtU01yLu2AgRrkaGgb6GQEPN?=
 =?us-ascii?Q?dlOIrVWEvxrcJjzYye9h2Sbn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259eb054-cfa3-4324-bb3f-08d8e95eda2f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4477.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 16:08:07.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPBX8v9MiUKybYX/+vb6Tc38TKNrfwuqdojWqLnY+mWs8osBrTqh6tCfD4nxhYZIFfVk8Inz0Hlnmnf05Pl2Q4oBOtZhMLylVoP29BmMwZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170113
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170113
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Calling cc-option will use KBUILD_CFLAGS, which when lazy setting
subdir-ccflags-y produces the following build error:

scripts/Makefile.lib:10: *** Recursive variable `KBUILD_CFLAGS' \
	references itself (eventually).  Stop.

Use single := assignment for subdir-ccflags-y. The cc-option calls
are done right away and we don't end up with KBUILD_CFLAGS
referencing itself.

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 fs/btrfs/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index b634c42115ea..583ca2028e08 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -1,16 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # Subset of W=1 warnings
+subdir-ccflags-y := $(call cc-option, -Wunused-but-set-variable) \
+	$(call cc-option, -Wunused-const-variable) \
+	$(call cc-option, -Wpacked-not-aligned) \
+	$(call cc-option, -Wstringop-truncation)
 subdir-ccflags-y += -Wextra -Wunused -Wno-unused-parameter
 subdir-ccflags-y += -Wmissing-declarations
 subdir-ccflags-y += -Wmissing-format-attribute
 subdir-ccflags-y += -Wmissing-prototypes
 subdir-ccflags-y += -Wold-style-definition
 subdir-ccflags-y += -Wmissing-include-dirs
-subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
-subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
-subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
-subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
 # The following turn off the warnings enabled by -Wextra
 subdir-ccflags-y += -Wno-missing-field-initializers
 subdir-ccflags-y += -Wno-sign-compare
