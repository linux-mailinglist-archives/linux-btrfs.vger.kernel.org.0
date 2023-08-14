Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812D77BD07
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjHNP3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjHNP3f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46410CE
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECi9JQ017380
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=/I2zok444o50YWAPS/n+0fN5mTzv3WEyXVdAKl3wRbE=;
 b=XTl7k6yioZOIYWgR23rzU4XoPI3FI+mtLMqyyCTr2L1Hzo/R3Jj1iBkzldF6tYBZ4QSF
 qd/U/NyfS9Xn/1H68yWD7kLwG6ohItsI7jwNy+Vi6J7bV2MK8u7/tP/gkqmKYNTEI1/t
 EaVuM8KConvKA1CDR8jbq9qnZe7Q0Jc9lvsb3S6LlrlEhKDrMl2ICbhjTzoJQdIb7zjU
 EraiZTU4YhLp5WdJAw6ql1BISxejjoTs9k84yT/l64L/7olqDH/ajc+ksAFf25Ms6pLB
 skvkGoRollQZOxokLdjLtMcBJHxrmK45DC9gUdb4OOxt8+Q/+fCqbAiVIeTKTmACge3c 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2sep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEqxmW019874
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3ua024-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSZiBszpEdTzVgV9mGrnjJBQXpZS5ZdQqc7ycretL+Qned95viTgQcgBA20o21L2Ti1Q3cRrV79vHPwNz0kVxJog2F+tYK4afvaf91GW22/FGVr2Cvqo/QMN5VEpyfsA3rt8VMnsgF7zkCNlsByA6uhiAi3C6tBNc+6Hp/R1ILWwU5Yv7hSVKNpdkNvvXEcNj+GO0NAJa4T7T+5qOosjLtiHpUNdS7dJRe0x8GIvWAeBMBzcvr+ORSMnN3zAFlyy4kikD/ndqId4vmcBzFl1WxHrQ6JwH0kasA0GZEx0WyVCue5xYR66BhXnqKqvF3nLVDsY53HmnkijKvIZfu4aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I2zok444o50YWAPS/n+0fN5mTzv3WEyXVdAKl3wRbE=;
 b=oHpdymlRtq2tf7TJNVUt/9gZfgLuGsNr/+n+HqtZ5UEDxfzwth0zldUxSViPL5hYAjGaJObEd5hKC8hi6qHzXmdbEqff5/pfNVloGE6NtTUpSdSO/7uyThDlEDDr0gq4Ady4if99QpXYYiqJ8O80upz16jK9ms2B4FhotIAXdfr0J8OEQQLD6ofpJuWSPanqZKKqHU1wO9FOXrDSfk+x2Bh8DWmGsXy980qmR/XGKaGLpIdTGfSMIqYznXOwti4Qeft2u1FKa42WXxfL8tttQ0+D9lXLgkQ1Mo2NcZPwONLcc4XYrFgrwnNeZ9WOd9QArFIdYiO1+HFVaIM1/R+Jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I2zok444o50YWAPS/n+0fN5mTzv3WEyXVdAKl3wRbE=;
 b=v/mn4bGPL+YF390udv7A5Hi2u7Hm/h6taf8naY3Mb4tjAHPbDEaI/OugN3o2YAr7GvBl6sUlwUPimZueF+bsaCfeGBqXTv1Tg6XjP0bU41tutStDSb6uUZKD+fZjHY1fHhbE5YgtvhmiqpjeZodthsBZbe+Wj9Uu16nn2gAhUn8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:29:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs-progs: preparing the latest device's superblock for commit
Date:   Mon, 14 Aug 2023 23:28:06 +0800
Message-Id: <98d2fc9f0f90b4134fe7784f5fb482c88f241599.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e82dd6-3225-448b-1ed8-08db9cdb4120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kar5EWOyuwUNYuAEUsZwIRJLBhW0ZqkC7AcY9DEbgfpCSu1+ItF6MBVVk0fwKnU8/okyU8aKgsPrjSB7NvtMqHFiUxr4HH+1yGOoyAKFD/lxV5MhyzyD/7w1+si3HJKbj2DoroUwi+1uSk+CqziPtztU7foP9lDi1hrbkt12fz4yIzTwhFd7llQmILuhQqU8EuNQAGY2Wgk7PicMrbXIg6i5EM+0sPfbtbIlnYNjQ25X+KVS37EvS7OJ/2KQKQQhh6ePBMcsPlS5dhC8Cf/I22SaRQaAXFHdBYoqMyKzAk+JRs/sxds3MtLo+HvRFCpfoUNc3XbKFQWsQgDECL5z8FyIvsNM6KDesaHOzDIxDelbBcwKnP9EW1jTDgi0kUpLpio67sDRNql+wUYHvCZw3OFstiR2Q5YH0YsOZ9oSiPEXvbvRu6deBYSddK1WUdTM9aPqgMikZiVUQYaCoajJWq/tQuWgOyVbF5CYUOQH109+C9woETuiKLJwX7DAah1P8swOd1iiv7hbK/N5PF33/gQ4VjxC6Q/dQvH5PlSpNV/OlwbHMKuk1scB9xme/R1l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fRdwGJXaka48hjsM3NtEo28R20Q1bEUTbztl1TjC4SS+Ieh41VmGHS64yep?=
 =?us-ascii?Q?fz3+CLRWWC7ODGU2q7tw2T27lKYWpV2swFzBp+NfHbuwARON09kw/uZMLLMf?=
 =?us-ascii?Q?Jg1Ia0Ea7CFNGvB7rm3NozTSgCeneSYzdVysjF1FnUmYioDWmkxgx7cy6HQM?=
 =?us-ascii?Q?iBrjLfqUrmsOvf6fCfPyQk0cjxExiI7xwpIdUIJQ3zjQDMcquP176jozzQLJ?=
 =?us-ascii?Q?9vNpXyG4BGn+NkQu9nbhr75PDADf61OeP79axjjJRHgAPpE0A8ts/DllJbSz?=
 =?us-ascii?Q?PYcpn4v5YCkVIz8BlHIH8gjXQ3KsfPMf13JMOA8sARZnFc7UBIQO3gKVviOi?=
 =?us-ascii?Q?j/a4AJsm2A2QKFelus+wFAnrdjvc0dB/h+Yip09ehkxsVz3eCUjCyKxWLwv5?=
 =?us-ascii?Q?JrrdHZiIjuB7zFyyzvbielrTJuvAXTYeWEk3CdLkU+4cC3cHKSGALIOdv17G?=
 =?us-ascii?Q?2dYyLsCHko9xVxH2w9zIxQ7R5WzldV3LhLJE/P8TOML7/hXQ6lXThgMM4l/R?=
 =?us-ascii?Q?g8qxHFA0hg6d2IscF26tjebiQ5vhj2fCGjwMabW+QBv0yNaUB5R5s9jgMGRe?=
 =?us-ascii?Q?0R2/MGw9g4YfhyHzMcYSbK0xNbCY9kjujXNfCJQCFKT/8qy/MLlFLGf+7O33?=
 =?us-ascii?Q?u9P5JZm/risixTVk2qCMoTb9Bnlbf5mkPz6loBEBICnCzKW6IHQJK6znUBEc?=
 =?us-ascii?Q?lzWbFOljmmdRGoG9/WXMGCdEnf0uuU+YATynBcQgsQl0oeSqsf74z4Ff0hEh?=
 =?us-ascii?Q?XPUv6G2TehRVY0yfh/Az5Avp8fYEIWRm7zw490fPOft4GOpZT07X1sHbMn92?=
 =?us-ascii?Q?zEr3bO2EDSDYra/HmJdYqPBMR0XFzUlFG/BptBYGoOSlhCX5nrnZpHGOT2yr?=
 =?us-ascii?Q?jGw+xPiJN3EGzawoB5ygmajgqn0HEMNj8SyflmMfndDqgkcwL1c9iESDQZt0?=
 =?us-ascii?Q?XIFj9qlyTchwmqQAlf0R1bb7CABPq1uGIwsD5thJmwCA5rFWj+tamyMG52gV?=
 =?us-ascii?Q?VbdMKVg6aUhkX/wAER+dm21a3vEbPWEJTBHalHY0imWAK9PkZaKGcNC6vBgQ?=
 =?us-ascii?Q?iKnEk8Mw0x53Jw3vFIkcgsukeb8EmFqNQTAHPMUHYtCc6UM1xmHod9NLSk23?=
 =?us-ascii?Q?a+SemjiCZJhBwaxLILh+PIuSJEpao2Mk4hKr1SwvlbV3YgsukK67Ih5wmg1Q?=
 =?us-ascii?Q?n37LJ8EmyJ7oPGzXyt4zPl2LyXuXfzXdy/IBIDLvqQJvYKJFS/7daM4ER7TK?=
 =?us-ascii?Q?py/T15ZWRDLipgje2CWsFYBaJtxAuz92xg/sURhPdulwWzfTTlV4bNy3qXcj?=
 =?us-ascii?Q?s4zM43qmSTtFXSvZpqdecF7YRpVib5+IpRdtppWzJOXPLgz440Cgy12WHpke?=
 =?us-ascii?Q?Q/3wvRx0YzIsxVhGGjhkcTHMuRIv3mSwheALKpoFJgSl00HfNQLk+iD7QXbE?=
 =?us-ascii?Q?3fKCpYigeyswu+VADlcph2HkaBoxV/zdyGa5BdCAiImBSa+SZmm/caiY6LmD?=
 =?us-ascii?Q?tq1CzLFLeygKPFX3HbGuXwA0SxWZ8v6LWyfXGvl8udgYYYNDPKwlRbmes5pa?=
 =?us-ascii?Q?pRS1o3z70Qb92ulEXdqSGSVfy00DOzkFbUf1dMH5nqai28kWQMHG0Oqmd8GD?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y83xdGPWveObia3RwtEBn093otQ+iZBgrfeExV5DjXr33nDf6YXX/TIWi85GTZhAk4oZbeD+mUsr3iAw4HuHeMhuIveM9VjdXfYwKJBvm1zReOnYS4p6lWiGiriXSy0ZI/sOi5iANEkHwbTBWdBjX2QzVwPnoMQbrj2fih1K6VKqFyzek/0beyJegpMm2PG3hNsn/bahT2lJGohd5jsHXRt3WtJgt412KxlVgVyH3Ni7ZeTFKeQC5sxkSxVeGFLoc+7BY3vp4oar7AT5hvjrJ4AgYXoV7sZcpgEktBl35g9AJPsS87EnZ0YH6yy4XudZ6uryOlS6pSwQzBKQ3nh7gx8MR5UfsxEhud8noBdt9GEp41PlzHL3ypvr6zlOPIAsl9mOojU3f3RP7GzZQQy98Zb9w/YWukH7z6+kuwDqR316sZaMoS0wvuLrpzFmR5yjwx7ml1AkFvSKL0WKASDWkwpQTr0+uyflJjprVWYR4GChDTW+LOj5JSLYv3km9Wi5ks77i5Jwh1KzFV+nLsw1esHcv1ciibAd2ApOqET88ruEVDo7LhIYHqm4ye2rWXxu8d9AJh2EUGdCfIvTIoZvDxEs/9mLq6V07UO6hOtnjW2xxydNmZZ7mnYNZEZT7dYCaP8B7i/W/dl8cwDGoWVx9YIL5ftPLyBH8z1yZ/tW6AxVjtf3IWsLiQg3PoCX/HARlgH6Yy5Ryp49rdHJk9n6xB1pR7GNbK5ZcRtQ7IYwXQ22JIklYk7DhvAaSPQeA4pFPz0Db6E8xDAviwYv1yzV9A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e82dd6-3225-448b-1ed8-08db9cdb4120
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:31.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aD0ODsHATH7sItOnHUvCKZ7gdhSIte9Gv8st75ujCDaEf0IEe1/xd/hpHLysua5ya/DX1YOjM/3Gd9OnfKVGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-GUID: c1qB64iS5sf7SeBsetPFMCGQahTk_a20
X-Proofpoint-ORIG-GUID: c1qB64iS5sf7SeBsetPFMCGQahTk_a20
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch provides a flag to copy the superblock of the latest device to the
fs_info::super_copy for the commit process, rather than using the superblock
from the device specified in the argument.

This serves as groundwork to enable recovery from an incomplete
btrfstune -M|m|u|U operation.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/disk-io.c | 3 +++
 kernel-shared/disk-io.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6a3178a84c88..1ef28ba33f28 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1513,6 +1513,9 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *oca
 	if (flags & OPEN_CTREE_RECOVER_SUPER)
 		ret = btrfs_read_dev_super(fs_devices->latest_bdev, disk_super,
 				sb_bytenr, SBREAD_RECOVER);
+	else if (flags & OPEN_CTREE_USE_LATEST_BDEV)
+		ret = btrfs_read_dev_super(fs_devices->latest_bdev, disk_super,
+					   sb_bytenr, sbflags);
 	else
 		ret = btrfs_read_dev_super(fp, disk_super, sb_bytenr,
 				sbflags);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 424b953e0363..4f9ef633227d 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -104,6 +104,11 @@ enum btrfs_open_ctree_flags {
 	 * specific checks and only do the superficial checks.
 	 */
 	OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS	= (1U << 17),
+
+	/*
+	 * Use the superblock of the latest device for the transaction commit.
+	 */
+	OPEN_CTREE_USE_LATEST_BDEV		= (1U << 18),
 };
 
 /*
-- 
2.39.3

