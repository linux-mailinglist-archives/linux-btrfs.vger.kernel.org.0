Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A08694174
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBMJjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 04:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjBMJjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 04:39:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A2517175
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 01:38:23 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8OFF1019888;
        Mon, 13 Feb 2023 09:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=S2ymE2BrDOD7kl6hMlXABGJAKJ2DRnPMqwCRkTqotFs=;
 b=hNvTEVFHpmh2Xqah4mbcVOWhOs5Y87ypDuQQsmdXdZr+nJWPfvIC1golqGMmpMZrWTbi
 SsXvhz+veLiELZXaYOQXs7wPLdPoFC3huIo3UInU8PiJ54r3MJnf1OfHDVsqSYVM5LZ3
 8/liwFPYISnLTYT0QTkmgcM9RQhuLX2xaPsipVa+qbIE59Oq5XPg+/WzUIDLZ5dqfiGO
 oD9Z7hOk6DSIUb8TwovjRXXiT84JtbdHIp+mdEtZfEOE2Uuip47deefMH8GQ/8/vJntm
 kuZPjswwu3MBNo+h9YYx1VbzYzKDu7X0KYEeZXLSugHj3GlaVOprCNygZs1K/eYKhB0g 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb2cf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:38:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31D80KcP032642;
        Mon, 13 Feb 2023 09:38:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3uup6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6IrU1Vc4I6jg1suLBlFq6e8lOnojORZ8JG/Gye2o7Teu6sfAA1jsoPgTMLzLc6E8kC9/1HNiNuycLE5+ujQj2NOp/VuZ8o5c8PIjxN+6RBd3qE/P1km7yf9VeiAG4Znrvnmu6f98k7FrTyQxPUD5UL4+8UgKnIoREQQZsJIsULymAQMy84lZr9qVXeOXB69/eiOdVh9APkuFuufhr4GDRNFENmunR2wvbNQV2sT0JoTB1grwNWwqWCohI8hJ74o77ZnANh3hONf/WHhVsC4Hf+XzMCp6M1coTLIwbJ+tGbSEZtSAWbbf16cBCmUSUofr9FYTopxEOqQqKmPmeezww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ymE2BrDOD7kl6hMlXABGJAKJ2DRnPMqwCRkTqotFs=;
 b=jepn8rh08u+AMwbXjQhcRhJs098lBsMNKilW/8+Z4JfM5ZFL/vRH/mPP8DIaRCsi7lX5nA+BqP2NE47sG0gUjLioY82z/edyB0PP+iCPuL9srxNJsFS8FJ3HW/n4QwCr3tEQaIRz7Z7bjwbSecMXuqyHtQa+qyE9Bm0kollqEEMiari2FyfokmTwmQrt/xbOP0B91BReTUtVpAsR5XdG8li3b4n3jNjnOD4X5FnhZPW7K5C9A/w/BpPldxWYcope+aaDHYu9DWkYBoM3VM0BaPrNVOs17R78VVu2ZO4Z9QFAO4eJ0sH/u6H4YRDHeJT1jMsv0pVZf5qrXuFMsAol0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ymE2BrDOD7kl6hMlXABGJAKJ2DRnPMqwCRkTqotFs=;
 b=wATEtqvs/1KAri/sqvO56hbjfuG0EPeqOafsU+T8RvbMh6MD/D9Up9bv8GxIzG6j004yK44r6sM4aPSAiCqf9b5cJRWfWm10C4aSZh7mNQRWbcsT7rAwP9Zkhn+YFDGZYBOWkXdhfsWPcmQ9WmiAMSycTwRxP0bhwOl+G8jHNCI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 09:38:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 09:38:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] btrfs-progs: read fsid from the sysfs in device_is_seed
Date:   Mon, 13 Feb 2023 17:37:42 +0800
Message-Id: <7523436ccbf95d7fde690f41095637ce9d9fc1b4.1676124188.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676124188.git.anand.jain@oracle.com>
References: <cover.1676124188.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 75baf377-181c-43be-8ee5-08db0da60793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shbMeUWMDAA4OzdtR1f9YpYLu0VhSqeCzLWjRsHwnVbF+UEOiYZKHMHVacYikwOoJl3Ri+myHYO79I8tA7+UllSNR7iadiQ9hVwluLZw6b3NCsFrrzwqRN4MG8vUfiB20FXzUAYZM7ZVcw3MS+8d/tDDuZLw1tCKtsgfVQNny9rHWaBrKvj0668bBqZeUt+WjUjqyul89jYCwFmAs5XnlVm5WrYhVPXfeleE4OukOg1d5PDr4o+iI3BikdPMK3x2x6Pbawq6UbECgZeNZQjB/CQFUk+nI9ZWRpJ6REWspaUyuYl6ImdgaeHmR1p9xVxuwn3htjqgslubAreqQ28EmbssNftESam2rrl2e72PO5yg1z8WLmCnpAXXKvIX9z6dsgAYjK83R7yzeNxeg09zGyX1t0b02x8qjrhOEkM1dCLfJr4okTk9nTZ+eqwYZYU582D43tS+uFI2kzIDOSOz3Issr9mMJO1QilVffJQo4W5Ncdd8IeDYfQQeq79qOKiFppOFaPOUuVG7MtS13RvDJsddQ2T9cxfNps9JzXgOoZ/o1gM6F13ARV3B0/dDT4CiwWV2eG6J4TT5SMlP3rm+FBwVP8wHXsqo1AQevFCGeuZZUcbvVmkFydPNFhdz7r0zBNqpxkSLSbSHbVEut60aIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(86362001)(36756003)(316002)(4326008)(66946007)(66556008)(66476007)(8676002)(6916009)(478600001)(6486002)(41300700001)(8936002)(44832011)(2906002)(83380400001)(38100700002)(5660300002)(186003)(26005)(6512007)(6666004)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jTRExjmQj40KAScsN18W5cMHf9S96xmLC5wdzk3de2SDBnSC7G4wkstrh7i?=
 =?us-ascii?Q?GOJ8+32ecO3VN7Hk6DGZLRx5TVhFPlIH1rzC98/EY3sHB97COR93wo4Yijv+?=
 =?us-ascii?Q?AvATi0AWT8di8BwVIJBlAq1r12dZlFe/ugnalH9ZOd8dDvHnCKJqjTNlZqTn?=
 =?us-ascii?Q?6krYiSqTV28GUqNvVwRvvwYFlnicrX1GQAx6bVJPYqQ/dL75g070mTYZOB7u?=
 =?us-ascii?Q?bbmUeSbESYNmcz/Cn0s9SYAj+tx961MebI1kI/EmAZKtblzFfn9mInHXTByy?=
 =?us-ascii?Q?Y9HuGf7VPegFh2d+8V94a0Ed6GkfOcnOTdu+yEcZGQbC8zjMnuobvO9Fb68v?=
 =?us-ascii?Q?MK/XuqJ1QFu4xtg6z6aZKG8z539VMy7OuntLs5KCih+zAcTG2uIIC7urL7wW?=
 =?us-ascii?Q?K0KrRYDgjG/z3xlDiKyANtQODUZpDdgieBaJG1z6HzNvIDfViL7Hm6Y76093?=
 =?us-ascii?Q?dCGhftXY/bBk+dgB0rOVsWgcOABqNDF2qrUz69673zV1SJdyvO+P7jxrcsWH?=
 =?us-ascii?Q?dPXJ5QX5BcKPZYrqF9jlYgP+NgQdNbd9KaN570uOflqz4W6Ghg2MO7nyaaqq?=
 =?us-ascii?Q?HeEDfb+eR44Pn9ELWSST9d+xX1zPWZfZ8SINwgAOwHccv73ZO7kpnvqL637D?=
 =?us-ascii?Q?WcD6Ena+ORc4FhgSubcLu7HIR8poqw5ZFzaTaORWd4Rf03+rNPnBLvV7011m?=
 =?us-ascii?Q?q16fJIAtbdLAhU7JSGdCemefahwpAOEpO1pH83njsKs7V3VZZ7DZ2B8o1SE1?=
 =?us-ascii?Q?jTcTjwtYrTXkE3mr5mPSTgtQ8UGFkXtvI/ULXFu/ZVZ+51Lod4djQLN3PRzD?=
 =?us-ascii?Q?jvzXFmCX6pITITRAFL06zwbeGUncysPbTRXtHxt0NLY3KsLvCjgbI7+W1go0?=
 =?us-ascii?Q?PmP1K598OOdR+NZvPfVGQHE3dbNAuBKNyFNgFsGMDO27Yb5wX8kKuSmWL9gq?=
 =?us-ascii?Q?bnwMTmrs/zyHhgkp41V+LEhFByW9pxEsd68riIhkcesHy9Lm6EkuezqpXORS?=
 =?us-ascii?Q?TIE6Ytv5h6Ernwdv443DjognI34dPgW3n4dSp8wBkqYKr+6lXbjteLSuHhGt?=
 =?us-ascii?Q?u71j2kFhoD6Qgupp8mSQH5uAIfj3H4YpiMU/vFElORWweoVoaRDt2Xnc44tH?=
 =?us-ascii?Q?ICQXNhuMcinH7zJvmBtEi0jPK+vV/HsKZwhZAGdVaI8Ve3y8oKctFe9855yZ?=
 =?us-ascii?Q?937wriMnhXdvSW1WKn9M7bCVPFKZVedMrYV7LNI+Lmm6oXh931QPdpGM9Bd3?=
 =?us-ascii?Q?5DlqM0tV1htGbWLDn5G7BR+kxEmWdwtTuTCQsPJSjfRFA6MGPIVdXC4+VSUz?=
 =?us-ascii?Q?ot6HZWKv6EJyXrBblZcKzoZjKe25LszYHm+XffoiG8C2mCCxOWgxLCbPqof9?=
 =?us-ascii?Q?rBjtrrhqf0KLa+TEtZH+PKa78jXhggRjiM2MhlFq3uBwS+h8vcxW45LbMCRS?=
 =?us-ascii?Q?/KYMpRtNDD5V09OeNFgTkqO6VxExmRvLxMTUpm5mwFWqzZhHl8BAjkzFp+AR?=
 =?us-ascii?Q?qoXhYte0HAgGJMJJjTrRY963yyee/l2fRlpmPiM2U8BN2l6IpggsHIVGz66S?=
 =?us-ascii?Q?vUC+SxIc/uoroEZzOBpI2DEaKsX5LOgMBYxiZI2GNdhAeDqvmZsmcBfOaQLp?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iycba/nhitJh0uqVgzHxc9cvOQPRnErLCuIk7Vn7lKKR0e+Um3PFdQA5W11XTQXyNKvbq9dmQxyviwvbkJWkFcI9+SXV15gKGRPAuSoR5QmLqUVgeeFmJWL2lWdFGOF9amCBWE9ifJSU+o2yPXyWLiCNxXLknwE0IuMGTRFZuyi5sseJ3wloXpKc73L8MrUXFNl1xZ0Ik2Dl/EAF7+24BEh4aDD4ZXwfP6sbtOrqxyu0sVUv0vI4IYsGZxzKPTVsSldHJ7yYn/yaNxMUqID5SGyrltQ1UBstLQl7mQyo975ZxaiL6ivafbDkZv/vifefkjGr8kLXpj9FUM1J0SX85lsNQQpJCX3JA8W5fCpPa0SujPq3IB7LiPdy3Ug9xU3YEXLK5wBa048hpjFKMVpCIEwClr02SdVNLjavPlPaDcL1Iwr8jEJLjf2fx+D/YdYrS3M9PFkTw+NxnXyECcOB3frjLO87QMeo18u9H+wEquPg1l8/OovcgwLHSSFM2ipgl9XttxTXKBt14BtyalgKHSlmjY+Gqu/PWADZJVXpCYycaiw6rkK2wl9xp36tXGMsDj9JayEzZ1f2Pkdk7yTD5U+4vCdzadpaETWtedbIhyVZX43/ZTnqJL8aB3p/YcYIgTmpwXc4SiTErdEOyQDJpIeygH5TTZShUbKCJ5o0gPoOalARlZ8UKddjWL8ENzfDVfA/xHRDULXNtvJijTmxTUO5c8OADp9YHTEsLzZi5Ak7leFHyfE/ob8gacERDowLeC3SrYUWxLmV4lgE/BPYz7fXnNNTFXaGfsWgQYvFDGIEZp7t/loOd/mv5CJq/TmzgKrYYFLH/SbHhDAyLGaTyg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75baf377-181c-43be-8ee5-08db0da60793
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:38:14.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aqt5ZAIXnQe2vPD4J4uHDoiSD/AkjYjAxsiQz4rOs0DDn287a2joZolLmUJ82VAP7/FZ2wUNiEeL5RGvA68hng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130086
X-Proofpoint-ORIG-GUID: Zpj3_RwN96hTFEFv0ATPR8c_aCDZd5vy
X-Proofpoint-GUID: Zpj3_RwN96hTFEFv0ATPR8c_aCDZd5vy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel commit a26d60dedf9a ("btrfs: sysfs: add devinfo/fsid to
retrieve actual fsid from the device" introduced a sysfs interface
to access the device's fsid from the kernel. This is a more
reliable method to obtain the fsid compared to reading the
superblock, and it even works if the device is not present.
Additionally, this sysfs interface can be read by non-root users.

Therefore, it is recommended to utilize this new sysfs interface to
retrieve the fsid.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem-usage.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index bef9a1129a63..e7fa18dc82dc 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -39,6 +39,7 @@
 #include "common/help.h"
 #include "common/device-utils.h"
 #include "common/messages.h"
+#include "common/path-utils.h"
 #include "cmds/filesystem-usage.h"
 #include "cmds/commands.h"
 
@@ -701,14 +702,33 @@ out:
 	return ret;
 }
 
-static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
+static int device_is_seed(int fd, const char *dev_path, u64 devid, u8 *mnt_fsid)
 {
+	char fsidparse[BTRFS_UUID_UNPARSED_SIZE];
+	char fsid_path[PATH_MAX];
+	char devid_str[20];
 	uuid_t fsid;
-	int ret;
+	int ret = -1;
+	int sysfs_fd;
+
+	snprintf(devid_str, 20, "%llu", devid);
+	/* devinfo/<devid>/fsid */
+	path_cat3_out(fsid_path, "devinfo", devid_str, "fsid");
+
+	/* /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid */
+	sysfs_fd = sysfs_open_fsid_file(fd, fsid_path);
+	if (sysfs_fd >= 0) {
+		sysfs_read_file(sysfs_fd, fsidparse, BTRFS_UUID_UNPARSED_SIZE);
+		fsidparse[BTRFS_UUID_UNPARSED_SIZE - 1] = 0;
+		ret = uuid_parse(fsidparse, fsid);
+		close(sysfs_fd);
+	}
 
-	ret = dev_to_fsid(dev_path, fsid);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = dev_to_fsid(dev_path, fsid);
+		if (ret)
+			return ret;
+	}
 
 	if (memcmp(mnt_fsid, fsid, BTRFS_FSID_SIZE))
 		return 0;
@@ -763,13 +783,15 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
 		}
 
 		/*
-		 * Skip seed device by checking device's fsid (requires root).
-		 * And we will skip only if dev_to_fsid is successful and dev
+		 * Skip seed device by checking device's fsid (requires root if
+		 * kernel is not patched to provide fsid from the sysfs).
+		 * And we will skip only if device_is_seed is successful and dev
 		 * is a seed device.
 		 * Ignore any other error including -EACCES, which is seen when
 		 * a non-root process calls dev_to_fsid(path)->open(path).
 		 */
-		ret = device_is_seed((const char *)dev_info.path, fi_args.fsid);
+		ret = device_is_seed(fd, (const char *)dev_info.path, i,
+				     fi_args.fsid);
 		if (!ret)
 			continue;
 
-- 
2.39.1

