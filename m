Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C231D72DF60
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbjFMK1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbjFMK1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7251701
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65FuL003835
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=NP+x5V2TXT54oxz9KDucr2K5oSxK21G/YmoUNAznDbQ=;
 b=Te5rLXGP35PbfEV1eUWwNqY0EA4/3r3o0mkt5U22A3JAje0vNFhVBCAc1lDFlPKeDczD
 lQnTK/j/7YnUn4dLLKbrjYxjeXhUqYtLmpyo44qnZx02qkfIFrhe+h4s06wmksMwdkD7
 p+wRkmags2PBrl1HiVpcUk1s4cN+tSt+dw6OdUfOduTSU/V9uutTXwVTre+sb3F6YoYL
 +Z6+J/ClAcVuB/gnjJ1ACFvtPlRUbHUQJ7bSHQUhZOh+MNmSRDaquiauMC5DvgOlrEcN
 187t6HzStS7ehGUACPJCcZ1DP5za2zeMrTKN9jkr2fLFb0aVzxzMzoBBQWyaQ8/52qLU 2g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d4vrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8aoig021640
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3ywmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHBB6vLn4qB4YaicydWt4DEb7FTK49yqR52zK91o8mVrX47X5XT64/PXl/Ic/ll/GLkmL1aaLOeKng4ZvZ8AnZK9v+3sqo4CF5mzDRDzNPFWnQWsYOQybLxLJv18unBjQwRL6RGGJYBiZKKVe+Q1cVwllK/gtfN1Fd5ONl2cvv82vx35Nig96X5GFiwxiFDdWm0bbnBIL9fB1fAD8w4Tf43sPHN1YGjfPjFmEfH/N6vGLDuoAzsbeIgeBoPZr54BXUJE6L4NI/ZsyzJhxR3LelCednp8Khv+XVd0ESVndKQqIcwunhOVkS1HiH3CWwaL60Y1nKvzBlYGlQhW9n132Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP+x5V2TXT54oxz9KDucr2K5oSxK21G/YmoUNAznDbQ=;
 b=j7bHqs1dd6WpkkffOIKIJs9ciHrfAQYC4coqRo6DVVWEiC5QJprKYyl9qbSow1stP73p5hnLzKHIvddklG+loZ+WYwN2XWIFoRVG7XDMeOdf7Rpda3RkVJ7z+WnopwJK03JHJ3L39GJD7PKnd6k2ZA+h35VZCigLCeLpv4bhXmM2eMLv4Z2j8aEf2klsREou7jlZoblfptW6VJ+gA8CyXb1CHLA/OzzOtiDOB2akWqrQYdYoMuO+V6Pkt5b1G+RlfzsKz6um/b4pC6IhcxSC8u1xERI56k9AawmiMhrc46MdyXobLYodDmYg370n6uSh7IDstDNfNAn8V3Qz2pyvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP+x5V2TXT54oxz9KDucr2K5oSxK21G/YmoUNAznDbQ=;
 b=SYmb81UkamZ+cAL3kMA+7JoWETio7LEGWZIuabINACA9tnv8br4As1TiF7moOuqJeiEq7DORMmQVrHH6pmVRU3/FuuQC/Ugtfjff/MwYL1sSyTIq+tFbcfDggmCDuIml1w3BUTJn4xh3kMjl92cvKnnx/i5c80EItZhNLR+qf00=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 10:27:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6 v3] btrfs-progs: cleanup and preparatory around device scan
Date:   Tue, 13 Jun 2023 18:26:51 +0800
Message-Id: <cover.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 630ffdb1-7bae-4c20-f4ef-08db6bf8bbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xv7GAd0Cjorrafg/Jk1I3SuHPUCzDM06Eav2aUa+jxZ839070QsnDiOUt+3Ad4kCeAXVeGLz/h16SlFJTkj3S+U0EYATRXKyRDZPeIm842G0JpZ5750m89vumdUz8tWqk4zBc7n0Fw+UxmX1UmsNO8rGHFsq7Nikd0j6njFm+aK5ExlSyuxEzbDVWhLiuHem4LfQsEu3D1qhXFPDjvZoottzZ1GYGr6hOtscyBz/RrpB74HceywIJl359nm2d13/WtMdbP+1xUo3P0qGeWnaunmyDozscCFZpcMJ1qa8G+darOorizpoRco4bu/Ee5XeJ+cqIA3soh74JVN2WdTJM3G+3dlKJtLsbTQDbjNcguaeDrVgRIfY2Tfz1mqbxENME7+PLVurp2EvoRjaVVYm3uc7/nWHeKnFB9WdK7OF3C/Eqqf3+Sudykaqinx6hLpEl/dwF9tvxaKI0IM8FEyUZ9FSE6veDpDlfBuXOxI2h8Im23fBS4n1+Pfht3kDVnd1oGGK9YBzOMB+Q7fG3dRzYhyYt7L4z8Eu7X8UZS0a5GlwUv+zVFGjcaTGQPkCJdur
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(186003)(8936002)(478600001)(6486002)(6666004)(5660300002)(316002)(41300700001)(26005)(66556008)(44832011)(8676002)(6506007)(66476007)(6916009)(66946007)(6512007)(2616005)(83380400001)(2906002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwJEE+0wQZL8EZ36Npi1kCk+3ysNMi1AV87frUQwc1r5Kn+McKTwE58hgUPH?=
 =?us-ascii?Q?arsmN5wyTGW0l8Wq1TORRgzWpnsPPs3+pH2Nta3mjfD31wOKXV8jR8q+RFBY?=
 =?us-ascii?Q?36eqPsxdBkTuVJkFtH6L6pDdr7BwlDbASjvi6K6p/GtxYFieRN3/aYeVO1QO?=
 =?us-ascii?Q?W4lg6ZsbmLXXCAqpDGKqTtbzV2l4GIxx5UeEZkOYYBMbGXE94zK0VcV0pMgI?=
 =?us-ascii?Q?Kd8QHuLfay8peCM4UW25Cnp97ro+PkbwnC+RRHypR6yedlf4JKDzUgUvL8LX?=
 =?us-ascii?Q?0ZRdKTLo7xoaweHmrsobTj+V0l4zqdOfrb8iuBg0xHnAqKo1o39Fhksg43Wk?=
 =?us-ascii?Q?Luuq15bCgqQk4jGI0zNAWdytgrbG02qRtFWLQRKmUiDmH4UOjE0XH0PcJ9N/?=
 =?us-ascii?Q?0wn0A/1CTLFKH5P/zabbAnXf9h2N7tAa6Rw1Ua/USU+2thguqS3DMxgH/gUH?=
 =?us-ascii?Q?ajRCkQP0XYZUKZvKXSwj5gILMYwn5lGXOPW1CCc8qsO9Zk7htyc5UkZJtBHF?=
 =?us-ascii?Q?tKoyMvf16UScNrr1m09nGCKWUM8c3WXuerHZX2jby1AxjMOo1T5UMyf51pZo?=
 =?us-ascii?Q?Tsti5MykWCho/72TCe0Ozk9hloG8FYwHxuPK1SA9x05BFDhz3MGHamom8BsJ?=
 =?us-ascii?Q?CyP5Ft+PaqqkO1CVspiOOms5o55ee1MVSSfx1CMM5vTww21cxKRtDtEWfPh5?=
 =?us-ascii?Q?SwHNBSzv5IPYG9kkHjj4iUD/0Kergu1Ig5RoBfJEDUJyyhBerDod0hcs0f+1?=
 =?us-ascii?Q?wIX/sVX8JzKMbumN8TdI5OYxa3xfOaYDlYcX6ItUrl7D1YJTnBQ0Z7DDQLK2?=
 =?us-ascii?Q?H66+8l6ChqRBZTI0C0XbWisAQGyZkArnmrS3mSG9psrsl00XnW2sjwRbyhXL?=
 =?us-ascii?Q?/1pD99O8R+FJyXM6tEvfOX4CAo7xwjpf+ARXlW33u3tx6zlMXr26SzcKHxGO?=
 =?us-ascii?Q?NuyXBemQsInhr4YcfHWZ6ZEJyMAeQjAKq3yGYEeRhmP4ZRmLbTcC468TXBEn?=
 =?us-ascii?Q?1ZjB0+RjTE+iF43HwzzPds0MIX9syZx50vhhUWFNRVrZhzcDtFi+1gIn/AqN?=
 =?us-ascii?Q?B4DNJ1wSymrKOF3xnwE/+TQ4IImK1vSzgbkBCDKbhltng/9c/gcUq1CA8LNW?=
 =?us-ascii?Q?/J5aJZj8410Jb8Ci3ySwc7LE1Zx0oa67Tav+2bp7Z0pCWab2XfNFsHn1ub/U?=
 =?us-ascii?Q?RP3ueu+gstdQ1IG2A7oINSklnalF7pe+lwaQva4tk2KiQ/FfYPP2btxKfT2h?=
 =?us-ascii?Q?gpzNFP+IqtvdidtC89e8zQdxYfbRkkhqNOb9FLoqLc1tHa1q1kYPAj35H4oJ?=
 =?us-ascii?Q?YqYYcYfScRJBa4T+Grz8O3DA4DhBX4IPs5Y4BcmDrVa0xFUY4c7IBMQbNKMQ?=
 =?us-ascii?Q?UGOz0JBFbXIB7daxs0p+aZhSutWLOuJXvUBSIX/09EG8/wpDPZkj4Al335Ma?=
 =?us-ascii?Q?gTwe8rNsBUQHbg75RH8Tuw0Q8U9ewZmIQ8pGiH95fL7LFQiaFhP7ms+7jf4m?=
 =?us-ascii?Q?fYD2JhOb7kuF1KpfRtw8chi+ULK7/vScsbT13OwKQBcXoqSA50M3XgPrWXoW?=
 =?us-ascii?Q?3cRX026PgyAwkWpnlU6jlBe76AP48sLwbqhgSgP6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YtfjxFCkGykQDqSbCFIPq64p3NUI+2UmC9JL3b6NWkNqgUbR0lC62aoN2SYQtwCPlvQQwhUcDOGhsTgPVvS18QjgSrdQa3QzyO/q9PANJa8wglu4HCcYoib7PwsUFI3y367zRUtrfQeXFw/M8oCpb2aOi894gsgpbmmZxw7IOz1f5Ho0vLCg0zfzDe6Fh9DUsMP1ltcwuxR4ErCOLzstkVtbqQDkkyXsApT4EAYPyUCTijqTE+IcxJcj29vQreiZjhSVBMr92Fs53vviuksPsvSpkyZWTS+5gqnuLyFc7iHUIAsU2/+IhTdCBqInjN/sJP/DcOrw9szkxH9Yycw15yjtlSqFqzoYueFBJuklVbrakiCouAv7Zu9rcj+/8Vdpw/4uqLCNmYyh/ak19J3RmnkPRvWj0CTHMlMZjcYRScQxBZ25nLrL8si0XduG0UEmsUz/r2hnClMl+EOjwIALWiZ5eDT9CZmE7b3D+JlWZWITVQvElATAsR9YHQxQ8YRuBhQWV9SFStuwUovO8ZnjKSCWw1/UjO8eZvfrl+rs+fcf+klEOwHfT7aqs4pOP8b9pdMK1xAUgxCgXNl6fn7iTqvnaTL0D8ozIKwf33Dpa83LMtMr+sqCQPJDeCQdQK+jEqMUXIaYtvwmGfpRbq+TcrMJXv/rGAl1S5G3NWxvYhOF0+JmrITWpfOKwZ6NUeorH+vMcFNyi/N1BkP8SrjRbEzvAXw4unW4tIWqtFHwUGURMtQQ1KdWIkHLHM6sFFCbPSYD2nYzYFwEQs4YwUIxTQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630ffdb1-7bae-4c20-f4ef-08db6bf8bbb6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:05.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMa6A2aQR4g0Mk2m2wtKhBEFh2R1qNpE4046uqK5RakIhavWF47fgyNEkA2M3qcqQ5m3kJ6bEsP1/KWf/LHkcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130092
X-Proofpoint-ORIG-GUID: YAhPHM2OKo5JM96C6DzHfpkz1LAniVdo
X-Proofpoint-GUID: YAhPHM2OKo5JM96C6DzHfpkz1LAniVdo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3: Contains fixes as per review comments; details are in the individual
    patches.

    Patches dropped:
      btrfs-progs: check_mounted_where: pack varibles type by size
      btrfs-progs: btrfs_scan_one_device: drop local variable ret
    Patch added:
      btrfs-progs: drop open_ctree_flags in cmd_inspect_dump_tree

v2: I have separated preparatory and cleanups from the introduction of new
    features so that they can be easily modified with a smaller set of patches.

    Added missing git changelogs. (Looks like sshfs lost my last few changes,
    now fixed).

--- original cover page ---
In an attempt to enable btrfstune to accept multiple devices from the
command line, this patch includes some cleanup around the related
preparatory work around the device scan code.

Patches 1 to 5 primarily consist of cleanups. Patches 6 and 7 serve as
preparatory changes.

Anand Jain (6):
  btrfs-progs: check_mounted_where: declare is_btrfs as bool
  btrfs-progs: rename struct open_ctree_flags to open_ctree_args
  btrfs-progs: drop open_ctree_flags in cmd_inspect_dump_tree
  btrfs-progs: device_list_add: optimize arguments drop devid
  btrfs-progs: factor out btrfs_scan_argv_devices
  btrfs-progs: refactor check_where_mounted with noscan argument

 btrfs-find-root.c        |  8 +++---
 check/main.c             | 14 +++++-----
 cmds/filesystem.c        |  8 +++---
 cmds/inspect-dump-tree.c | 55 ++++++++--------------------------------
 cmds/rescue.c            | 16 ++++++------
 cmds/restore.c           | 12 ++++-----
 common/device-scan.c     | 40 +++++++++++++++++++++++++++++
 common/device-scan.h     |  1 +
 common/open-utils.c      | 11 +++++---
 common/open-utils.h      |  3 ++-
 common/utils.c           |  3 ++-
 image/main.c             | 16 ++++++------
 kernel-shared/disk-io.c  | 50 ++++++++++++++++++------------------
 kernel-shared/disk-io.h  |  4 +--
 kernel-shared/volumes.c  | 10 +++-----
 mkfs/main.c              |  8 +++---
 tune/main.c              |  2 +-
 17 files changed, 136 insertions(+), 125 deletions(-)

-- 
2.38.1

