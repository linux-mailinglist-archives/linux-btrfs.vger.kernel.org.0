Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30B33E1A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 23:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhCPWpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 18:45:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38002 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhCPWpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 18:45:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GMjXcY097156;
        Tue, 16 Mar 2021 22:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=MNEGyCDGgGgqzHjbtrO4jqgqu4Jb08bo3PIc/wBCBVI=;
 b=cXIrE4serBsVfHSjPN8wcHAi4/GT5kYqbd1w/mPIXSlOmNXJZxBDMXobki/AVjSPKk5C
 yj6bhfwi0ZNdGzVMz7A/ptA35GB47beMAZFe2Brx8580Xth7jLhdBgQT8H1er32j4o04
 yILVDQhmx71bkKa/ogWZy9SwrVnIjXMjjkw254TQoGCiNjyQ4Jdmn7HrgszsFKoyhuFc
 ezrQdciqidCmV2rroybOzzcQbg6AawAxDW/j7xB4c+NSGn/j+NPILetk/MqzhY7pQEVG
 HvzBMomRY2JMrdDVxIENbIH8fy/D7N+GhoiRM9CUnFkPkmLhcqdG10eBvxl22C/twO7O dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 378jwbj90a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 22:45:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GMdjuB167234;
        Tue, 16 Mar 2021 22:45:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 3797a1twqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 22:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIQ9vFiEFCmZUboiShxbjMY6ldF+0lhMwXlQJYJAxJPzb4AxPcF45aRe1czP/BU/euXZD+z45cXRVxlh6mR0QbI2Pda5snb8T/BF3ANywGNbf9DW/Et5pxhXstwkCKwE1yYkn4Ut/C23nWmmKpP9bDDOqgz9vaQrxsyGqPS5nZjvTxTr5ln2EULhOtS+7N60YUtPP2duDe2e+JkcHh6YEc8WkJB8YyM663VSCX2Ly7I6zK7B3jamy65rCCbnvqm/dtGp89IjmIPWgPMlZOCAzziPcaqBBgcPkayXMtsBpciSGX2r40Tb28zVY1K6Q2HpDqniMSSbkSbyTgtfPu2hDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNEGyCDGgGgqzHjbtrO4jqgqu4Jb08bo3PIc/wBCBVI=;
 b=JRRsMCLN1HVVMpQK/VeeF1fYDKbOJhxVaQJLTRXwyUhf4+MO5bdIF3MVnUDKUIB3tEKeF+/MI7wYx1A+b8M8bZ0QYVrtWcZbB+vRXqveoV69Xwj90TYC5wkbLJXVj3oGKVgDWrmit6pNS0y3ZSxiZF0t2sv+JGAhcg/GWqy5IbjorTimKs7wdVQ6E7/AbOQf0R5nv6XrG1w2GUEoJvnhuTBd4HWveokzJ79WyFSs8z6fIr0+IRp4hB7exbq2b/Jy/mi/eIUCHl4ILn8oAS2creXz4lzBA/5ibaNiyV8CvgLcqBlS5BtRgqUB+3xyPn342q8mBSsjRDaLjrmTzz6BXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNEGyCDGgGgqzHjbtrO4jqgqu4Jb08bo3PIc/wBCBVI=;
 b=wefgHacP52T1UZ979BZiMLc/fGh0rh3o6908KNCb47Zv4g+NDXKZiheOyKi6nLtxusUFaqe/1rVtvKwpsRpchWvW8Qpg5Mkl44sHMNosK6xbu+bwL/c58XGl/ndfFJDRgdY5S198DpJJPHNgD1c3jZpbw1uz5zfDixS95DN+Nso=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 by BY5PR10MB3891.namprd10.prod.outlook.com (2603:10b6:a03:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 16 Mar
 2021 22:45:31 +0000
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::d931:ada1:eff:2615]) by SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::d931:ada1:eff:2615%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 22:45:31 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        victor.erminpour@oracle.com
Subject: [PATCH] btrfs: Use immediate assignment when referencing cc-option
Date:   Tue, 16 Mar 2021 15:46:10 -0700
Message-Id: <1615934770-395-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.21]
X-ClientProxiedBy: CH2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:610:58::12) To SJ0PR10MB4477.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from toshiba-tecra.hsd1.ca.comcast.net (138.3.200.21) by CH2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:610:58::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 22:45:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee57b70-52e1-43e2-5c50-08d8e8cd33c3
X-MS-TrafficTypeDiagnostic: BY5PR10MB3891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3891F5B353650756104BA172FD6B9@BY5PR10MB3891.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2u3h/Zlt668wFh8fE5ujKwxWFjPOPRC/SoSE8Vi6LTy56FHQoiCV+aAScTUFnezBR5JOB+tWFVGBo62E3X65pThP2bbKtJGogkWYiZAl42Ocg+zEy86L/Z60XlQn7UTEOED9IA8xbtpDp3XOjNaZ1MMdC355xICyKatbjej1DGgilebAftm9NdnT6LPGqbNUHmPDEh5vSKOQwAX8dthOn71M4GgHnT/WN0J1HYMEUee6QLZ/KNc61SX0o+/8TgqHPAn6NPiUMKu2g7Is9CorU3cv0K55sXVkAOGZfVocEKXV1WPX/+j5jTbpC9XMJaVJ1mmRJPFMS01YB1+lAasbA+I6AAP2ezMLFAk2c85xR9tfEfBfZRLS5ihBuHn5xV8aZbp7Dg+XOPw5yJX+2hQBLKFhAmWyC3hJJ4vWVe0GMuBTAfpLt85EqiQhiSYh3pClHivMvUqZ0NNt5/spWolu4pcVUqkzwWxE8jL+AymKJVFl7Ivn4KivDFfjWwfbW74iOV0Yy+mpFKwVbiqZEyBIqLzufdi9vCO49AMI/bj3zLiFb9NUAqEzfMWVMM2ZBMg+MnEyge8N6UHUaw7a+kWfKFtzht64vCMy7lU/SXio/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4477.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(346002)(39860400002)(4326008)(36756003)(107886003)(86362001)(316002)(8936002)(956004)(44832011)(2616005)(6512007)(16526019)(478600001)(186003)(26005)(66946007)(5660300002)(8676002)(52116002)(6916009)(66476007)(66556008)(6486002)(6506007)(6666004)(83380400001)(2906002)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PnAP8uWinQnZ1LVB/1tOmvAHnTp/3c0HTbl96NrblbULfGuSItcL0R+IA3EK?=
 =?us-ascii?Q?rW5hy3awRZE92YhBxGJwRICEQur76JLWpwXJcH60rbUUi2UY+gv5Sj26L2oe?=
 =?us-ascii?Q?2/4tYdh9f1OsG9V9p79s1Y911YtCiD4PgqZw71vurUU8WKLAZCkzZhu/rmWS?=
 =?us-ascii?Q?HjT4+0p4rFHiUYrTLH6d4jv9op3fpbUyrkdC2dPA3s6PgsuGg6yl/vFbjwFS?=
 =?us-ascii?Q?dIGLnDJ6rWa3T9OklFITc+4nZslQTIHIKcouhxZlkyx7KH3P4BbJHhv1x4W8?=
 =?us-ascii?Q?ec2xkTYmnROf1omJjrrXw4/qYwfqxKZQX1Na5wsyzkxaoU4DmStUQ7FLUfgb?=
 =?us-ascii?Q?6fAfVpVZhG2eEM2dz1Mgw8wIdyEMBZiPoZYKKx78cdMlaOOJwvx/1NQve0vs?=
 =?us-ascii?Q?8T9jr8J/B+lHTA7VTf0ujgHxEOSPxOmHHWuSyW17hayyaHSo5qRjyEMvbYXZ?=
 =?us-ascii?Q?b7zwjuBYxN/fj4+B1KatbKjav1ZGv9DqcxpavFHFbINcXv+HvPpzWbOxL5Hp?=
 =?us-ascii?Q?fTh5JNgX0zEQ8L2oLFSbztumZNlNOIo8tNC+WXNP2dps9PtzKkFPmlR0+MLU?=
 =?us-ascii?Q?jgQl92lUKox/9sOAYz02ilbOCSFsF9DbMU64SgM/2DlvT7wnGoO21cfbBJl+?=
 =?us-ascii?Q?5NKbDF2Davt2VpYQAlUtHjfOach99Htr15pjEMLjqMVTKelG+v/yfk203f1G?=
 =?us-ascii?Q?OGBiq/LYnD/eyhShXYQjWU8qNyU7f/YaRIDYLNqfb0WOnbwLK883CFDARXot?=
 =?us-ascii?Q?2jXLQDKuvQjxYUIOgvE7OTScc6aXkvIt48RufRZfNcj1YsRqE4PEcoo7bd0k?=
 =?us-ascii?Q?RxNju1A3+rYfZWpCEJyu8saweZLFcLNJ8GUpqC0ZbnWp1C0xbogbhIQAqcrl?=
 =?us-ascii?Q?J/len3xlKh4r+u8OdY3yYWxU/kCz7Qrc9DAroahzA8kZQ/5Q+WIMf4TuL8fh?=
 =?us-ascii?Q?64cMhrrIXtWQygF5HO4R2V32JvaQRcNs1k4wUnZglHZauDxk705XPT0AXdh0?=
 =?us-ascii?Q?rur3bPSDNIFFkRKiGZzvvaWQ0XoOgGh1eIhdTvr0qy26d67G6LwqcycqeFiQ?=
 =?us-ascii?Q?CUy/LJtGPxdazdGQ45bFBoeFTCPQLmtUJuKtjvQ5pj+Rdbkywo8rUvgXuivn?=
 =?us-ascii?Q?xtWAznRONGdUYEBCoaP8jCbl10ueq5fA/w57BSh+S6Z1dCupwGKhvQiBtxm6?=
 =?us-ascii?Q?Ov0h3gLPNGA7r9pfu/FwtnTT8nxQziOEJevpgcxExqHTLcWZBo9OhgB+nVcl?=
 =?us-ascii?Q?4NryukBMSm4Eqkk42j2rYLu3XxU7eQidt58dfQk2Phnw32zrzTyiELJxk2u4?=
 =?us-ascii?Q?kNric6ijMREvb+EW8FvPWo6i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee57b70-52e1-43e2-5c50-08d8e8cd33c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4477.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 22:45:30.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx+WMdMsvAj5uTFncExLYmA2KtZU+k51qaK7oufQqkSq7dqjK9KCHMEny/vy593hjAOgb8/cMyEKF0V+jPtMnfb61DpSY8r5JWLdLi0oyrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3891
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160146
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160146
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Calling cc-option will use KBUILD_CFLAGS, which when lazy setting
subdir-ccflags-y produces the following build error:

scripts/Makefile.lib:10: *** Recursive variable `KBUILD_CFLAGS' \
	references itself (eventually).  Stop.

Use := assignment to subdir-ccflags-y when referencing cc-option.
This causes make to also evaluate += immediately, cc-option
calls are done right away and we don't end up with KBUILD_CFLAGS
referencing itself.

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 fs/btrfs/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index b634c42115ea..3dba1336fa95 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -7,10 +7,10 @@ subdir-ccflags-y += -Wmissing-format-attribute
 subdir-ccflags-y += -Wmissing-prototypes
 subdir-ccflags-y += -Wold-style-definition
 subdir-ccflags-y += -Wmissing-include-dirs
-subdir-ccflags-y += $(call cc-option, -Wunused-but-set-variable)
-subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
-subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
-subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
+subdir-ccflags-y := $(call cc-option, -Wunused-but-set-variable)
+subdir-ccflags-y := $(call cc-option, -Wunused-const-variable)
+subdir-ccflags-y := $(call cc-option, -Wpacked-not-aligned)
+subdir-ccflags-y := $(call cc-option, -Wstringop-truncation)
 # The following turn off the warnings enabled by -Wextra
 subdir-ccflags-y += -Wno-missing-field-initializers
 subdir-ccflags-y += -Wno-sign-compare
