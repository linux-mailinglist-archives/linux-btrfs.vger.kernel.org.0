Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0683D87CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 08:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhG1GVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 02:21:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44230 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231199AbhG1GVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 02:21:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S6GXCT001793
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uPhlAiYiqCT3HW8sL6iE6iiZxta8baBfl7R68LiKq7I=;
 b=CpkLDQ8Zx2FXlGpILU0/ZZMBM881ikmEyC4mjUrlY8QISXsoI9uIDG8FtqkT6xCnYJa1
 gllMQnOSlp1bFJdIErqIGE8/tTeqwXKR9lEXyBV+QUkeZCoJWdoKXLYZr3O8Z/AsMzbW
 ruhsnJc4E+x4VN4ODBUx6WWZ7BDbK9Zld74O+PlDn1TmbRrbhBEYbo7Nvd7l3AtCvQ8W
 YrnkVyn5drUVKu6Znj06o87Egj1g5oimFSFtKNSiTACZwT8SJazH+KeethtSQ/TR+2dF
 y/FY2coGAJ4VHMNIarvGBvAa5mWd3hboDxnOoKSo5Odh3N6MQSpLvc4t3uyT5rg4P0Ii pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=uPhlAiYiqCT3HW8sL6iE6iiZxta8baBfl7R68LiKq7I=;
 b=eYIaIgfvhlxUbF55i+X2iZjiS0743KuhmABlHj8SP9LQhhhwU/u91APxSiLrb9SyysdT
 8UT0fvC48JMqVoSgLfLxayg9Vd+YZiwFlb0UMpVUPSn+tXmCh8MqgiOWkSQ/4pmp6djV
 AI0SGgzM8l8zLHr6poLWut7tbw7MBLqjxjT12WHsOkfnPm/SUVsPYOVjCjKJAW1DArgt
 DX/Wzh43UAgfRhVnjf9EVH/41PlplsejkrbwCwrpWggBRVHeIbi0GHGjSFGv13XrTshH
 Wyy8+pxssmQaQcdYFiYt5ZeqyYtiVrboAXmRIr/vSoeCMJpDJEEtuo//V0QIYX2ZFxVV vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2jkf9uqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:21:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S6FYJi097501
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:21:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3a2349hv95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1yjUq3IH+n8S+wXQd9fdfrDHlQ86wtuG/BiSuh6M/w6ig3mD1QGdK2Ndg9qSmcG9L95QJfu3OOCqywaQ9TAohlppeStZthW8JiovZ/AjGO5dR0iClSpzoNNyf5bPdbqpJqLfO3uytQT/ZInvCph33qsqUOVxtUsRi06raHm8GerJ6ACQ+ewOxPWtveXeH0X2w2iGLnJ6YwsvGVmbEu1dM3mFBK5aavWDNSOLW0nk8FcV2YaNxoB48XbVPvSiIKKyyAJKtyV4AZ0paKu1Y9MIpFKby8xnXpHCKoILf5NA4pXRQ+a5X+eINP3YudeeS79fg09qTOvW+t5CE+X1AUIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPhlAiYiqCT3HW8sL6iE6iiZxta8baBfl7R68LiKq7I=;
 b=GGYtWJVAYwKZqy53mul2gOqd2BNSDAokGYEFrxR2PCxsOYJ5uY0R7dxWx/WyXR3HcAnOKQXJdYYsvdd4Txji09XqxTHuKLT3KtZVDM6mURrzzmNrTMOmSHG4dcMB5QXq4hNv4/BNT2aoS7Kf/Kl1VR2X6iuQMP3HC1b1f4qWNXFgNaDw3J+NyYHu+0IntuzFboTlRurMeEqUL/9vxkq0qzIHCfIgoabDogNPJdzoYTN0sEUU1y8jBUEKpT0VpmnpQs9ghqyUyQB7JixcqDPi6tzkjQo82SQ0zcJ1S+1UTZwFutuo9fYXdNyoefXiZR6wAgXsJvIlHuQ/eELI3UWWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPhlAiYiqCT3HW8sL6iE6iiZxta8baBfl7R68LiKq7I=;
 b=zqPepeauPd1YrwpNGx3mBGNrvjJ06DMbgavGfoOygQGpBR2k6qFlNYDDH3YbRUMNbsE2hifQwjh6y2iEv19TWbDQz08YobsrVVA1IXJj8mKcHDku0DwCEEkwXzUNDuKfHRZt+uro3z/O/E70qQvbGuyyqGPmzA7miCaKju0nElc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3790.namprd10.prod.outlook.com (2603:10b6:208:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Wed, 28 Jul
 2021 06:21:03 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 06:21:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: drop ret in ioctl_quota_rescan_status
Date:   Wed, 28 Jul 2021 14:20:41 +0800
Message-Id: <c37927ff2082701c940d0aaad2301e4774159d74.1627452869.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR03CA0086.apcprd03.prod.outlook.com (2603:1096:4:7c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 06:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef98613-cbac-487f-c37a-08d9518fe036
X-MS-TrafficTypeDiagnostic: MN2PR10MB3790:
X-Microsoft-Antispam-PRVS: <MN2PR10MB37906287F3D693CD5ABF3B39E5EA9@MN2PR10MB3790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gi1hLzpuEuln43HA6cgJg02n2HPp0j0Pzon+Dl2eygTOXKVgTn2ze1w3rJN/KgewN6vSkR8Jdo92gLQoGzXHJt/tIbWzgp//4XjkVn2R/yiv20oS6v2dAen0ueV2J3i0LyOhpLCZrPuM5Up02G6tQl8S6NdtJfqq2pxHfuVIztxYE9IYC6w4inOQa1SHQ89KZU0RlLqKU2BORv27Xvjjgv2UxIE5jH0wBpYvsuKcx0qiR24NJSuXi0E9KzXUtHn93TW73xNnHLVf0a6pIt96mF3TxdvaRxUxXItDJpv/+bL8WAzGDbjDMEqzTMF25rplg0iWf2dpRNhQNnyiadLvzsmqxXugyJT/KsTF+n0DYg6CFazEAoFzzQ8p4Sp/leP0D3d+anb5JQuDhE8HUGS3jJy/XUXsJZVUvrmvPafMCfhtfi+zz20ATNL6VHtZWQHJ6AkyJIBdkhxRGJuilqdQn2b13kiY+CMJ/Qgwulh/gnSu2kncJy5x7oFg+PP6WG/9lgyc12tpRJg+f/qI5uXiofYC/BarldGqMGfwYTXL91dNZq1y1YlQNasRA7/NI1L6c4lUBVmVrfRXLedS8/DUEASsiJ+rNFfjkBl7vpRe09+yj+h8W4A7H2eNLZZnQsyci1b8HzLg2e/aHNea3xh9O4bdEkN0MTFztIjWW9D6UJQ56oSOCkJwtUiQmjE+l8Lv5XCMvh0UnawNPfQBA4r0FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(66476007)(508600001)(26005)(66946007)(86362001)(8936002)(6666004)(83380400001)(6512007)(66556008)(6506007)(44832011)(2616005)(316002)(186003)(6916009)(956004)(6486002)(52116002)(8676002)(36756003)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6fk0ulUp28YpazUMik9W/EzGgqOJvVMP2B1IDH9cyIMFjxe3ZbdBEB2oxfVr?=
 =?us-ascii?Q?Vrnbby+k9Zd2vebQCzmFgPlQTX6fe9C2QWoiIJky1YwVgLtIcDlyvQZ1Zra2?=
 =?us-ascii?Q?QE6SXkSh+lwEKtcuZhAAcZRMPxZfCZKjQpTkRtqRWzIfCv5XF3vDojGLuS4L?=
 =?us-ascii?Q?ZrPJOegrQv0jnUA9UHNethI5BuS4Q2kqF/n96n8JFRUSddiA18dYGJm9w/Ez?=
 =?us-ascii?Q?dMDZtb6eh7atN/mo42jsoIbo0+fPcqqvebjR4/bYB2rQGqxTQU8UJ6hTeojR?=
 =?us-ascii?Q?mJkmX8qkAEijXAYn7IgDaOcrN6HL48gaY2i6cJCjVlfvMoqxVUC/h9xBhPRS?=
 =?us-ascii?Q?4/duO1tRIVxHKKgson9BViZXbmbN22Fpvpl0Az8ZRHBIJY/Xmdqsq06WuYh/?=
 =?us-ascii?Q?Fh4D0Lds15/36OUI6FXasPAJA4Z6rIaGJvhKFENEE2fh/om5uFfbn8tGgrSh?=
 =?us-ascii?Q?N2RSqe0hn8aARKyXUtJ8/WiuKgDLyALCWlCUt2hzq/fkAmf4fqXcL60xght8?=
 =?us-ascii?Q?IMlLQbiCWCh3Mci5WSRB2K3paXq0JHtG9V7OtKFGjINF+5wYOHGIG6hy6u6q?=
 =?us-ascii?Q?xn9hqyDFg/5tDDj21nQTe+N2nyTaj94UvNSKVz8ZqO2zHCtPOOAe/dBaTxyX?=
 =?us-ascii?Q?jtw5FWXwEsBNTQxEB4lseudALbpBXfgJZXURcO6ZK7mpzqm5ku8lyBUZwzXG?=
 =?us-ascii?Q?qbuL9g9P2KepROVUQefNFwi7BhFvZ2bzdYlruYs20J9/FwMiuGr8OR7az37u?=
 =?us-ascii?Q?jCqRTBV6ySvDn1APFxFvF2EuxlT5DG7co7djToGuPMZn78JpcBdbmYW4Tw81?=
 =?us-ascii?Q?qZvnrvurabCovpSVMRlyb+y8ydGXWov/gKVKXE1ouDKCKpIKlvUGSmH8486Z?=
 =?us-ascii?Q?wAfS/XVmJUjWXon8gOMrxzqAduEtiAcCqjBQ2vbATCHZDqVd5Deo+63pKTwu?=
 =?us-ascii?Q?ZVM07b9POaT5/h6aFqohm+rWMpnKo8mug7ORp9nVk0bwU5hHIzRRaOmYrp9S?=
 =?us-ascii?Q?rt3fWsIYwB4pyctlYDvPLkMP6sM0GEowNjy7smrUTeA8bbnlyD1s0+KI5xCX?=
 =?us-ascii?Q?otxAwfIyZYxN18L4zI96XIqXDv93uDveuwXTsrhxqP+KgxIEUqGNoGuM/z21?=
 =?us-ascii?Q?m5y0EJXdw++b1bpZHzZzeJkzTtrw7IRgmhYavOIsI6hZu9FGCmyGRNykl2Bm?=
 =?us-ascii?Q?qjU5qKhqTXuyrJqyA0D7GhbnAtC1Yt+OmCIRaee7M7EgYjIPs3aTNKxymkVo?=
 =?us-ascii?Q?5yjH8deSZRAo1zK7J8IwJaCKxhMrZSiOsoclMigGWwwjYQJkExFHqXZQhCwR?=
 =?us-ascii?Q?f0r373YAJVIXE5iN1RuvLw8G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef98613-cbac-487f-c37a-08d9518fe036
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 06:21:03.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptmL8gAq7/N/3blHk/K3Ul/yO64lhfWojUlDIUb21P6ms/D7M4ia2fCdRzEkc6HkZcM8GkB5TRtbZr3Kc2/AUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3790
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280036
X-Proofpoint-GUID: Em3HWieYqomzJYnl6ap_mSmbQq9uU3qv
X-Proofpoint-ORIG-GUID: Em3HWieYqomzJYnl6ap_mSmbQq9uU3qv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need for the variable ret after the patch [1]. Drop it.
 btrfs: Allocate btrfs_ioctl_quota_rescan_args on stack

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
David,

 You may choose to roll this patch into the following patch,
  [PATCH 5/7] btrfs: Allocate btrfs_ioctl_quota_rescan_args on stack

Thx.

 fs/btrfs/ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0f1cc8f489d4..693422acb33b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4405,7 +4405,6 @@ static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 						void __user *arg)
 {
 	struct btrfs_ioctl_quota_rescan_args qsa = {0};
-	int ret = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -4416,9 +4415,9 @@ static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 	}
 
 	if (copy_to_user(arg, &qsa, sizeof(qsa)))
-		ret = -EFAULT;
+		return -EFAULT;
 
-	return ret;
+	return 0;
 }
 
 static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
-- 
2.31.1

