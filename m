Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C903E0BF0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhHEBHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 21:07:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4642 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhHEBHn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 21:07:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17517UIF008639
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Aug 2021 01:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=noqCbv837WKc1ubBvzIrlETgE5a4QxRSj15hR+A87SM=;
 b=F9w9Qg/D1WmjCv54TE1NrMaYNrLVSOCkpyW5DyAvdV/+mWuAHZQr9lfl+dPUDgHn5F3Y
 FcvI72twU4cK6ZN+jRbrA54TXMH7K/I3FApG3FTRwqhqN4aZF7pG3SkBP63drtZai8+W
 8xX7cqMz8pmBnZ2/1VabTFQ5OyZ5Fs78QVvppvJL4vEb2+YJ01lrS1beqkxhmLDk+daf
 EhlPrIZj9533qNmXqnq+o5i1LxMCsOJ80hTvvemS0TnB17gT7+OnVB6I99mq6U62GiSH
 n8eipVWcIe8+KXt3ndAsW7fqz9d2O2ZmHGArBEbwktGqjLvrclq5fML5Vv8dfXzlbUvR Gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=noqCbv837WKc1ubBvzIrlETgE5a4QxRSj15hR+A87SM=;
 b=jl8nIARO2drB9jpoIunY/B4oBxulD5yxhQRJsoONpLLDuMQCpYrQyEUD8M8Q5myCxwP2
 jLwfSs7v1PyUxQh5ozbOFO7ErVzAW7QkKffc3eyqa43wTZWNeJhEMottJ0PFG8+8RaVu
 7qAqw7immVU8nwVn/tOSc7uXHVzTW3FwDKbdEds+0sOv8oW0rwVreYVABMxu7eiGRo/9
 FjiLwhMUBJjGqwoT5rj8KdAtoplUiHuaf1SX6Umw9MUgQs2mhFBSxj1XhF0hkO3tfogk
 aEG3MyHBAhVAIeFUjoevjJsvycsFVwqheNb8HOmekmJseJJGg2SrvGkRLrBsfJXaGhbP 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn318g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 01:07:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17516B84036286
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Aug 2021 01:07:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 3a78d7pby4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 01:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9nS9x36Edby9xLaDh6rxs6qV3UP63mAtDH0pBZelW9CelrW+0s/gDtS+fKyp01JMJcubJBAHaqiOf/sJCmoYKtx6HfzGexhqlztXjNq1PXpBIYwvYto4QShH0VUSeYlkdeF/ALFbLp5w2qzaQfd061hljgo26LzfUMavYbrn+wXNHVBgNoVw1JCQxHaw/G/66VGhsWW5nxHNlCU2VNjoROUY/1Fnq28UqEW0I9UrGndcvqM8VjHD4WihwXL6q86Enu/J6LVAofwZT4ekdp+xIuitcegZXrxvlvKiZUlTGkkh9ZiXRFTDBdRNP6zI3rJP3PVCW9mN77C0netSyduVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noqCbv837WKc1ubBvzIrlETgE5a4QxRSj15hR+A87SM=;
 b=F+LAHlqNJuhEzRofdl5zZGHLtOEHAqA8iMJp04YNSqb2KjdGLsmUSL/ui8s917vl5AAhVhhehH1avOvXlsgcT5VsD+JaNrXvOl1w9JDScyiGgyPwyrbOwJxiyvFerP1ZW/kejGRxmSVeuZSgPfQ5BZActsnMIOlsSqCDhq3yvfN6HJHBfe8oc/90ljMKDrTpf1Y9C/8oHHVHac8nF9e57jzS3fMwI8LZan7zwAzpBt5/Dv7qmnpQZHxK7luXbdIDCQ4R90FoK0vC35D0cylmWa04lRV1hmHdAmxjKsvtPuvstP1BzUxeRXDPkwXADFLa9Wlo6uzPEh1qaitNrRvEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noqCbv837WKc1ubBvzIrlETgE5a4QxRSj15hR+A87SM=;
 b=XJhDGtKjGZjVjZPJCa8lmJiQpaUAJ2QJDhMwm7NPdw0Ym6wtThpMyoTeEh2C1h0g9OmavBytMofSAqPkN2Zf5uFjga1W1cHPTYOQarZfXN0acBgbMU/tsdjY+6JKOHVQnC/06Qc2H4OrliHyzT9Qb8UxPNsX1Xq5CYBM/3S/Ti8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 5 Aug
 2021 01:07:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 01:07:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: sysfs: bytes_zone_unusable is not under CONFIG_BTRFS_DEBUG
Date:   Thu,  5 Aug 2021 09:07:00 +0800
Message-Id: <8585061cc6672a4f3b985b7c387c7a8040af2a73.1628125287.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1 via Frontend Transport; Thu, 5 Aug 2021 01:07:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47c581d-08f9-465e-08f5-08d957ad5beb
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5171F04B4D00E2F86EF22BABE5F29@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peFCerQFn30jP7woGBAGnd12GjzuphPAFNaBD4XHwIKyECX5OH1sdSKARYNqxMDovMABDGJPMsNQ7UOVl/aUYosh/FF2H/+aHVyLniWXAlxznecRzGJmysROXsZEyRmW+HFU1O6fto7gYjkHW34t2J7bNpMXj6Wwow+vccIeTRj/iE6sbopyjLmJHqID67p4Chhc4BkzjWSffc/EpgoSvi0//2/s65RJ4x2p515wBft1h9Nsz9hxZ69yfvj/g7p8Sml0m2Xfjom/SlHrKYhcmPTp9iQSJ29pAOBC/KCCciwSt1+1E44R3Gp/KWsA1zbgg8K4f/1vlbiJh2DhwN80cbL6Im6IihvVLvpfLm61UheWDa2EV8YIZSZQrH4qbGqvrWdiQi/EsmfvD0x0BzJm+7zOlML/IzgiFdjPi6hklDdnqxY6uAhUd9QTu21XhAAlqSYhOCqe27nhY7hlbV/a+ttRMU71ur0NwYmhD55mTFwS8cbYqZHB07f31mSmi4QoAk+AYVZ5NTjMtlz1CXLk6YR4bs8Jrh1v/va0Dae9veQd15VZ/DTnoIrKaO86L2ijxrCapAilTAlMAeliTzLXv//OwQO16/6cbnxQBqsvVILI76NWeCe6PnMTp9sS7q0Sgp2BUtS/mEg0Q9C92QbQXgOo3znNRXSYHT5VGDa4xuqtcgSp7+QQ4XIw7extSvJLvQTailEsdBUEwZNXUgECJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(316002)(2616005)(66556008)(66476007)(38100700002)(38350700002)(36756003)(44832011)(6666004)(8936002)(6486002)(186003)(478600001)(2906002)(26005)(6506007)(6512007)(66946007)(52116002)(8676002)(956004)(86362001)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KB+rlphab6x+YnKkySJVyZbreF7utLtwVmvhscxMWfbuGfy8RlZ2hdF3nzNp?=
 =?us-ascii?Q?mUJ4knAfB1g9EIokVxxuXUh65WkB6WVsWknPU3do3krU7yIQpaT9q9FtDo8s?=
 =?us-ascii?Q?x0Aer1qIOwAs4SYo4T9qlYlA0qd3Rq/40cZB6i3kKTxVlfs09/BlrFzAZKry?=
 =?us-ascii?Q?bIDmdE18nKEvgk+us0dA9+HSmtIW3yv7gwk8Wfl07BgN8PzBQdpQYeT5rGGx?=
 =?us-ascii?Q?DYfl9OrA3DjmrMn3i65QurRO2Fhilejw911aEPGnSwQx+IaYGwtBcMpJm8Fc?=
 =?us-ascii?Q?OAVZ30oNktz2PPAssJjp1Lw+fbSffGJGLM7yTAwFjyeuoCIWPg5ebBeNqFRi?=
 =?us-ascii?Q?9CBD6drE6SfGcZlpLFWnYbwY/BV6pZuF9ll1mPpopQqSuFHWdrktQSbkOZXR?=
 =?us-ascii?Q?mm+uMKk441hKG80o9xRLAMVGzKyFFoyqwMaMjOrF/YcG0ZTXKw3QOB+ogaUX?=
 =?us-ascii?Q?TBSGtpdTM5I+zJ6JbKHp5a8y5LS2DMyVdQoImbW3BQ0sWXpTcuHwWFyA0fG/?=
 =?us-ascii?Q?M0XK6oRQK7sIjdVL+jhfekuN0I6ZssciUjVnt/MEwrYGnPxbaypPey0Rcwyb?=
 =?us-ascii?Q?8+/1w4I30hZCFFxfI6OhKlvEOpeVcjztmzueKuSj3tGNkysdCL78oWmKcOIj?=
 =?us-ascii?Q?iSb9wLb00Xr2RBDN//a79P4iWyG3LK7QtoKNfRjnkZb9KrrMZobxU+BtdJAm?=
 =?us-ascii?Q?hhpBDefy95as3qKPCkitvZwiTgE/uvn+aSypT3fuSZ90VVaWjYuTGptmqTNe?=
 =?us-ascii?Q?rD2++uZBjGWlv5ohIpD3U6/gTERMJz4eAQKPJvQ6fJnk2ECDJOZN9FZUTgVm?=
 =?us-ascii?Q?FDDiwWVyYxDCCrC51rUD5M4t9zx1IeOVDgyDIih2mdZLXVgAq/IBmZDujhPH?=
 =?us-ascii?Q?PwoAkGVD0fzH/aRv3CwO+275kqdLqzLPEybkhtF47y+1dm6q+c2xflKSaURi?=
 =?us-ascii?Q?04DYMeeLDVgdSpR+pG8kUDDmDB2uNpNzxzVmkeHsUPPmvqNLdt6IsEARXVYT?=
 =?us-ascii?Q?LYqsXCt9B0VnVGN9ZXN8vWn4fnKp9J6iaE4QPmEzt5o/4+XATDLgHCC/MEPc?=
 =?us-ascii?Q?H5qBlq/Uvtet9g3cCQj7+7WnY+EAt/DzL7VJur7LU6PDv7T+9QVt9MFDezLr?=
 =?us-ascii?Q?uJHP6igc6uwjM12TjDdV93tm50DUKe3DUtazLqN8JMLaVS2doP19Bte0g51/?=
 =?us-ascii?Q?/+dlRQCk5coiSkGM5Fvf0NiyCuywmzN3eVSACrvZhG+mT/IAwqVQvqNBxJDY?=
 =?us-ascii?Q?QKHjE3nTqvFQgLWgKBilIPVkj+uw4KQWXrtuKF2fJsEUg34PWpzh5U9y2QI1?=
 =?us-ascii?Q?OCaICKuQE/Qphr+3Hsu0AHot?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47c581d-08f9-465e-08f5-08d957ad5beb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 01:07:13.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngJLUjOwG0ZN9OB7ApHwo55x1pPNRds3KYGlONPcAGUwR61EXC5JTM7dqgnUP17oWSgcnP1Y3y4TLH1tcVsWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050007
X-Proofpoint-GUID: I_MfZtZB-6qRBy-PimeDKvRrnWtieKmw
X-Proofpoint-ORIG-GUID: I_MfZtZB-6qRBy-PimeDKvRrnWtieKmw
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sysfs zoned file is under CONFIG_BTRFS_DEBUG (now there is a patch to
bring it under CONFIG_BLK_DEV_ZONED). But sysfs file bytes_zone_unusable
has escaped the CONFIG_BTRFS_DEBUG config. There is no problem with this
as bytes_zone_unusable with no zoned configured shall display 0, so it is
just a matter of fixing the consistency.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because in my understanding, there is no way to fix this
inconsistency without failing the ABI compliance test, so it is just
better to leave it as it is.

 fs/btrfs/sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index cb00c0c08949..baef8f4b972e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -702,7 +702,10 @@ SPACE_INFO_ATTR(bytes_pinned);
 SPACE_INFO_ATTR(bytes_reserved);
 SPACE_INFO_ATTR(bytes_may_use);
 SPACE_INFO_ATTR(bytes_readonly);
+/* Remove once support for zoned allocation is feature complete */
+#ifdef CONFIG_BTRFS_DEBUG
 SPACE_INFO_ATTR(bytes_zone_unusable);
+#endif
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 
@@ -714,7 +717,9 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_reserved),
 	BTRFS_ATTR_PTR(space_info, bytes_may_use),
 	BTRFS_ATTR_PTR(space_info, bytes_readonly),
+#ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
+#endif
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	NULL,
-- 
2.31.1

