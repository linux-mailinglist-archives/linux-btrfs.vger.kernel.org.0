Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B07A74B4A8
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGGPxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGGPxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0984FB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FO5kS030683
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=6sVNSHbIzbGCf/gKIRY44ORT1aA4QZ5kKvU9nznRug4=;
 b=kqKQhh5di+Ax0a4vmVFs0CzBkrMM64OJ70nqaQsN1G8Hs1FD3lAWxZoLHVmeVXd5VXe7
 6+yutOQ5UXQXbcFZGaTCLFviARbHXvE5a7CODTWnZRGcE78bv29j8WqDgD3T629+HCWq
 YGGzWvIz01iRe+6mrpP9RCLXtyntJj6NVqlDwrjeufUwlmOP5kHQm5/7+WZ6vtM7r/rY
 +Fd15BfpVMLLvYVcVQdTpHD2BvZMoQzd7As24MOhxaclISd6XtEE/3RXGqUyAbxTtWo/
 VwJiQki35WVcEa5jq7wwPX9PVI4WbxeJ2AYEjBPl6CidFqZeTcR7CtfEgQ1bBZ3JIXHT RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpjcsgfa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FgnL1013587
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8msk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ2X7D053H8Eev4an49vzzNtPxg4+42rcAK5yfdM0+488vJLB5rRy4crUFQLqI5PR2ugdeMROPzl2ELopHm5DneBsrmksDmAoQwF/z7RejHShsiFk3xZDy8wKxL05hd4NUDyz3/hh3LTjXkyH+/aWCPc/ql7bbQFGp/MPMboZc4d4WFvGFZcMzFQc4rkoAx5mWa75aVN6UKCJBtUPk8XfpAi6zcFc5zdrvfRqJ9A9O76s7evAGn9QlHjMbk9lLSpb53YTBWVM0suVzxjlB47HOtMgiqdTZFbxCZLwlEh2rSipNCtB7mimCq0Jr2MZMfWRRp9dvHFUzo64biQiJO1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sVNSHbIzbGCf/gKIRY44ORT1aA4QZ5kKvU9nznRug4=;
 b=QN3SZTkRT5QZYtEHvBTs77PLXlY6FwfwkJ/oyWnhqKDZQrt0DztKMNiAEGweIU0OI6/sk/j4TKblGOws172aVpV76fdzWbfhTU+8iqDuASvBYZZR3/IBmKYqfkxYROwu89e2StLm7U2k+i37B6hHF6jaMY4QGF4MZvnzhokbgVc7FEYtXE1vW6T+VNSKzNrq2pnhi32XCxgSyrS1xgLX0IuQaqlV3Y6V8BYtAYdKzKloUZFQHv6qhp9/qj0hABzHxDXBvtyRZwYwYAsFfrT15jozD4jVhEc0hhmFY7iiVW4fqV86n9VOcGLbj+uWiuaAQZiwNYxFtfSEDqxL5QA64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sVNSHbIzbGCf/gKIRY44ORT1aA4QZ5kKvU9nznRug4=;
 b=xnmJvmJiqfwYVwvF7nxd7YM6nlYI0NQVdZc3N2KZ4NjLhsd38a+dyg9HKbfn2Ck/0AMkP+K9lrfHl01X5h8zN5nBBRUFOfaysfT1J+92UbEzKv57XYsVbnkiUWrx5EUH9H/FFw1NNdqJ67ZmqzfJOwzreFot6ZrLqaS/OCUEDic=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:53:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs-progs: NULL initialize device name for missing
Date:   Fri,  7 Jul 2023 23:52:34 +0800
Message-Id: <035575319ab5d70795697847c39453580d581c51.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a4ea02-dc25-4535-de92-08db7f024968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoDIl/apVP8uZ/SY8gjcymMBrFdWaIMoivuSdwLxUQ3ZGedYZuzKvy5q1lloW38pC6PAk4E48qbckCV4wtPSrX85kMjMlmliQa+cb7NsjJkxmBvxLsLcyPg8ukxihyDlOUI3g/tLJGOZmJTz4mDaLcXGGJF4H0G+5ydf64BQ+kUX7TAjiNmmDlGcy8Vo5GzTOKGbrWTKcAqgcd/ToZ45dML/uIgVYSO8raAXZEfqvh9vhIwr978Cq3IZQRD+qNBV3fY2J4/NeijbjdOD5k+XBR3eE4plhgj3Nl0R2wZ428WTwzpdriMQvHgSXpUW7cMyBY7kfea0YUvn2YINQT8e/QWlGoKgRp9SpF1R/5Lt80gclEjnsDqRHAiGYgw4ZtfiefUXepTcewlR+oqSDsLG1VjFVK7KWiYPBSZm+eRcET9x9YJQ2rK8QtIvPI4jCL91wcEl6SC0GxGz+h5YmW55jWDY1AqH6Xkyd9WXbs4KDZdqxxVcV3tMp1zzasCkVgO5mJ/mgDfYwHVPaSfI+ijaw7VnK1b7Uqm2voDJj565CvWR1Fzq7Y8kFyJpU+d1vG2U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(2616005)(2906002)(4744005)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7J3578NWSD5YZ73wSkyFx4EfOQZtkh2RURdm9Tn6xGw9VBkgC5eZiwXvfeT?=
 =?us-ascii?Q?zLDPSj/cw/yz0RrDyAKhpEXpG4Q7Qs/VpI6M70VA3nbJxU+GqH1afmd3bd0U?=
 =?us-ascii?Q?+lGczNLnMtrpK/wMt3f9hslgbYLdHOt8nLJ0QGsKl4Szf5bdib4wrWlJ04zj?=
 =?us-ascii?Q?MYvIe+3IrrBP41eT6HRt9hTuxXQFwTF76sAqNXdNFJQEWZCWsC7tekNr/Xo2?=
 =?us-ascii?Q?o1UtBPQij7WDkT9xrp5RH6vbQ0dZWxughOMhugDM7j4og5cVW52u2lz59ENX?=
 =?us-ascii?Q?PHO1lVSECQGH1jZFvkiVuTE+zLBK/z9yv/RBe/s3Qng5adTtf/EldDEZafME?=
 =?us-ascii?Q?dET7JBAAdZPR//xkfUWqP/kuhBwsoKOTRUfg1Luwigd05t/5bHywqI5jPdz1?=
 =?us-ascii?Q?1Qm8vJIwloPyyIi+CL4R4ews76Bi7iXoPDNoHrEgnGmM9B+nFCtDKBkeVpzP?=
 =?us-ascii?Q?fXrfxFeaBw09C7983EMxUg4wTHDs2ncjsDOb+bhFNkjnravYzexalj0pIWed?=
 =?us-ascii?Q?7x+Y3/BMn50U8N5tJwRa0nOtXxb4QsPClWcEIM1w7FaChFMpeDHY5ZbHnnvz?=
 =?us-ascii?Q?peG8CEVTNyNVMN2ITyOH4yMo9vNlBQDZeQw66RIiHb8fpvbkp7ump64xDErf?=
 =?us-ascii?Q?fIhsJmgBa8ibttW4G8D7NsDb66DXT7Qmtw1icvDmOqh5xSHzQ45JxCcYk5LU?=
 =?us-ascii?Q?pglwD/JMTXNiv+1YAyR0fSJkoSaEp+inW1MZFY1IbMCeEfoV5BlW5ceKVIfF?=
 =?us-ascii?Q?NFtm9wpZy9jJpV3Cmwvu6Rgun1BMp8AMdY1+spHclM0IqLvKqyMlw2VM4TGc?=
 =?us-ascii?Q?mkEzAeMDGOJ9/G6Nraj/sJMcS1JL2YiVgG0udNdKJpESmyN5WEE0TYnOay6V?=
 =?us-ascii?Q?U3oTmn6u2hUE4dC8hUEXacq1O0JawZt5JTtXiq6y8ZjBYPZHimRWeyFrCBED?=
 =?us-ascii?Q?pd20wbwa2Y2/HLLFLwZH9qoYaFpGKXGnzT1qkb2T9e52FdsXKki1bL+sq0Eh?=
 =?us-ascii?Q?+rodtf6uB6veSYOKDAfcdaCdsQxSDA46wiRMppdjFmOzdwaP6VyLEfkSbYmx?=
 =?us-ascii?Q?QBmHFGG57RbvVmRNQPGXuxotLB/OuAPln5yS6APfMK12kursMrJ8sHAEYjSX?=
 =?us-ascii?Q?v/DSRE1U8cLnRsTIZC6JoZh33KIf4nWKKCi7wuFWdE8lW2HN1GcQaIma0sBu?=
 =?us-ascii?Q?XTfgZCFCps0AiU9dsFrwUFxhuSdONBfhG6/RXnhfmcxb9t479oXvlpLms7WP?=
 =?us-ascii?Q?EmJmmV8XB6shOQgP/Lh3CUzdrCwVWCmsXKrIaCi+XPtviz1cd5vgDt1I3ewo?=
 =?us-ascii?Q?fNCScSNWUn4kLm19dQv8dWve5+C1ZnaEd0PquF7UAe7PvIntHGOWGIS8H4/y?=
 =?us-ascii?Q?a0WM4pupfCDIeewjl+hfe8cJeN2i5q05xUcimQwsabqv4T3H+UA6jmY59UGH?=
 =?us-ascii?Q?bV1Rds3zJwr+PeimAP7IEj6fGhxiBQHgxCcAQ37dslIDl+we+Y6jgQ1yDRHd?=
 =?us-ascii?Q?vp+bJnDqi9tNr8Q4C2MNrzGHCNa/CdCmaeUkecNPq3tghlp5E7Rib2+02vlU?=
 =?us-ascii?Q?XXDF0siYIZAGxhtEXXMSUXaIaDpw34EOAHBBFjmF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VqNctq5hz6Xn+GWgHmp+9SR9Wg1qLVtU8vkM0Jmx8BOgnjmWzFd0MQUDWGbQnNc6nIlWg8KzHr9d6rwxZqYwhsUcnKyJLtViHs+AKYA7a8N48g12XYs8tlR81Gw44XkChqZsn/hgFl8HrTkSjMavyVN+bWt8FCF4kKXwvLivAi6gKQ8lC0FxnYPk+s7CQJW/dQbeeLDWLpbyZ+AOEM1L/t7gA3QZnvA3QtxCyzSTU0biINfar9Ir1PTJxIm9kql9zrKx2a0O9r/Gc78xKu9Q/1SMnF00ZmO8Drs/P8f9Jt2t1qjJMFhyHqto/0FN4FwsVTVNW4nktgyr2SLCAWJjawbQyeSt7pfHI0lL5/Ng1yPIvqvjyjvpw2k6rWBe9IWUzQVipvZ0Bx7lv1wi5vAIuJQw5nt9PmU7h5ZVrqja/bencg3qvkZs6vnLQy/szN9T7nWdAHngUq33nF9seRM4VNtdpHJk91Ps5+V010L6cnhwkBzVHjB4uKYwoxXgBDLVyQJXsw+BnPrJGZcLN4oift5io+Xnu/Fy0dBEgblK2EyzW86eI3MC5Dm3+r++6rlyoCX4Au1BHza0vel2Tqzf7QtQwzsG9xBp6vNc5MZebO9XcF8Ec6yPXxJAPO93FZn7YWbiq456NBb1WRC3G4s3Gc+KKCs3xbbllnCG0jGoeC6HZvdrfTubRXzhYYsdEQcI/25PN6FfD9dMb97pkeDpIvIWfo6W3lsPx+FDx4hDOOoyTtSp6Nt19/P3ewzg0Om1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a4ea02-dc25-4535-de92-08db7f024968
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:20.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3StK+0BDYuXMrkRJm0SAwCq4YYYgjSVrvYND4k/5tMO53wCByLqU5EocDchLx8UuTqyTzATJvdAqkL3IlE6WLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070147
X-Proofpoint-ORIG-GUID: -PZQdMA0eDmbhlyrFnYDOyzg-1hgQhZK
X-Proofpoint-GUID: -PZQdMA0eDmbhlyrFnYDOyzg-1hgQhZK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add an entry for the  missing device it has no device name,
set the btrfs_device::name parameter to NULL.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 671396dba689..4a8c559d4b20 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2082,6 +2082,7 @@ static struct btrfs_device *fill_missing_device(u64 devid, u8 *uuid)
 	struct btrfs_device *device;
 
 	device = kzalloc(sizeof(*device), GFP_NOFS);
+	device->name = NULL;
 	device->devid = devid;
 	memcpy(device->uuid, uuid, BTRFS_UUID_SIZE);
 	device->fd = -1;
@@ -2257,6 +2258,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device)
 			return -ENOMEM;
+		device->name = NULL;
 		device->fd = -1;
 		list_add(&device->dev_list,
 			 &fs_info->fs_devices->devices);
-- 
2.39.3

