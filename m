Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B50A7276F9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjFHGBa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGB2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:01:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8061707
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:01:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357MiCsT008087
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=e0ZqAVqyQ9XKhb3X+99J8QLm+bFx2oMHNgS2l0G7EZs=;
 b=x130TWrfofrWU9JyO4vpDxQVR+OgfVDkqplDuPIZl236G9dh5cLX6tbN09IyPJAvKr1K
 3gJPBUWE0EfHxyC3hZ7ef2ZtbPR45ngSdmiG1AJZHfqpRrcKSRX58za/X0sc0QYPvwlJ
 0UfJCnNLCJaSq14D1xazhY14CYh39YTv4u3VRbGUxsg+XhzO1cZeSo5a2QebtRqdcLQU
 10qnC+I7gNx2HDrMfcGBOXPP4dym5i3vL5KdJKQwZzqrzTSZh9NPdt4PtHc7fPlIy0+P
 qwmV1Hj0PNkyVaeXwB5zcdTZcuoGRvr63Vw2gaCZhuikAA9VQtmLrHK110uGw/TWUrZd kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rkdt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3584g5xH036752
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6j5nec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIk63ZRzT/tWMYiQaDB7F4ZE98HdW4CRIquRwpYtnply7snBURQ6k32Tyjj/kRXWYAaqoi3eN9AEJdvSA3j9qKHva04QksiaiAvfHWHkQABCvNbMY+KUnxOATukMShOmAZr6EiDDdEwipcfd667Y+DePpDUsg3cO68WcKe0mbadxratMBRJJ2kqrQWmDD3HVvnqHnZJ8Na+qEMoJqwq9S9UxXeDlmFirVw/VQrcbGTWwNgcevLAJxv6M1maR0S2SuQay1Thf833X77Vaxc+2Ir2VEMbiE5TB15VMJkL4b+VbIfBQ8AR053Ku7twmrMpEQ5oM5YFYuQ/W1i7YdYXuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0ZqAVqyQ9XKhb3X+99J8QLm+bFx2oMHNgS2l0G7EZs=;
 b=MpYfsJrAxdFJEbJ6YHd8WzitLXYjtjbqyjC+GlCbLdwLTLUQMisOrm/C11yC9DLxvYWM7oMAJn7fbNqVx2GwV14izrjIXeZlmhWWN224GUat+h0SUHvJP7nFOogNbQ8eh31syKt3RdUFMdLXmnUK6LnriQR/+fCWbAiY0T4g3UhePhN37fLfe1xj2DyV5ogEWWyB6FwwT5PZVx3z8navyh1r33qxMioixkW0uN1LHvhlvo3ZY3rEooGDSAcpe2aqNH+/XpX3/88iWAt2TcOQU/DAPFxAj/HXrGZyLZe+JAALX3eUW3WajNhwMnacFCgsjeIfIcoog2Uuigf9lpsJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0ZqAVqyQ9XKhb3X+99J8QLm+bFx2oMHNgS2l0G7EZs=;
 b=nDfq3mk4x2+1lkyKiVJupM7/gIExjdRIJpfaoES11/3r7Kirg8r/OnmS8LGJDzt6rOcmIp6K5NW2Ek5lSZqcols23v2tjTWdG+ydGDexAD01Hf2n4kMfKqzXTifsSli0fbtE+nAzWIEqlTUtG4CFmOdHJA61yRSVzSmF/oOSjj0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:01:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:01:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/7 v2] btrfs-progs: cleanup and preparatory around device scan
Date:   Thu,  8 Jun 2023 14:00:57 +0800
Message-Id: <cover.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6f1188-982f-4d5a-9f1b-08db67e5c905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNj3hn/yFqG9Tl2v8fNYa04wR4tRyIGJOBDeMEKjGQ+dGWpN/UBcZk8M6odKxSmMt2Tqsgamxih9aFWCwL2G5dOzrFJXVkxdkHyJgX08W8gzHLqij3yF+5wKmpipFSDZk01aJOfqfPar4e2gXZrMoiN8D6cTGtH+Py/QbCJGMGNWR4YxfK6ieBGMZaXGcvu+ApGqdSqiqGyb47oc17QTIEjL9at8su9hqyuCSzy1rdhLGCGPApoPDI6DVdfe5fzo5aTD9yLEmnsp6Qwj7AyO8MOIjeL/4wwfkMP+5ReakogxKQQOwMIhegN0tRlO/y8kxDY2rDoIQiSAwgSyPutJ0MM/Ex6ePtV9faMAYbK4cNWwo3XJdCXmpX+nxflrR5/RbBGKeVOY1920Z3/mmJ9XVyyNOlkUSGuYMjuHSA8K2tbyL7Zc74jU2DALmtYiUHatUX1a1YKJexVzEAGNEOR2Tj+ul52BMthLt5ihC/s2MqSeIlrsZTodi7gI6yhEZAAL/5m308TL+KK+lODhnhMYtatV0dYvSAMYPb5GJaZ/tD2M03HCB8c5scHMTa1j4hdt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48B3gJMW7xJAIjxFZ519wDBlu5xnrLG5wSpQDOdFRC9bZnq+JVyCA4QtgKWC?=
 =?us-ascii?Q?P0+8tS39hK44XuFU7YIWRdumd8LK1k+AN/M9i8IDw1j5BKmQope7ZJbXsPmD?=
 =?us-ascii?Q?tgJMQubyr17gPO6Ff5EXeZQfwvE0Dse/1Dw3Z2foYGGufxZkdTFFaOLa9TLG?=
 =?us-ascii?Q?v0UaaoOxAFCqO9ENHZ40gWsFTsqT0iF/jatkPNwr3pyy+7vU1z6ST8hZjWBx?=
 =?us-ascii?Q?Mb+isPxXFYSylqchEmNSqJddJ3GVtfhHv+qvR4I8JH7o9pw+hfmBSvhcsFgg?=
 =?us-ascii?Q?2z1SfNxOkqdgWsIZ9NmJs/vgdA8wohWlMsywyT4EE4W6PWSN9yD3aD/miMij?=
 =?us-ascii?Q?UeePi6x8wrFDtRmL9T/zlLcIyx36XBtOrIiCjZzJUWXRXL3IA9jag6OtT8ZE?=
 =?us-ascii?Q?jTF9K2QesmJk6vaFd2EueZTi419Wd5imkk6REMc37kVxtzY0akzNjOrrUQUS?=
 =?us-ascii?Q?RTwAlNxkEPKch7dnQMUmxIiyST7NgQNil3yhUxcsDbY9+VEebMbCofPqfzRv?=
 =?us-ascii?Q?yAzRaZaxY55X5ks3NVGgnDdSPpw65BEbjyaMVc8IgHFBWDTt+LXFgQJ1aWBg?=
 =?us-ascii?Q?PLZZf0SisCC/pYFyEALrfzIygV1WM6Asvc5PDS4EwuxutOLtZslno/a7Ya/f?=
 =?us-ascii?Q?8ZnpkdUmY4qI2tBjMygkuLpvP1cCvzb4TBkBk/wHvslP1Un2GJd/F2rNZRnh?=
 =?us-ascii?Q?2t+6kmS21iZ/ic6ySabLmY/IemPfutLZCibbJP72vz5TVd+3PlJAbpxm5y1g?=
 =?us-ascii?Q?If//yQ0fFYFl8M5KZ4k814blZtuLOEhVc9ourWLIu9uG2mqOx7hsncihclBL?=
 =?us-ascii?Q?viJrlCiQUrBvp4ZslGwx5mwoGBmjq+kC+rqCHXPMffE4GeRgGt/klI3zwKjR?=
 =?us-ascii?Q?QKxmOebVdlntdzOmb++FxH6SkjqARTFGpgeidqUoSnVZJL4VjHqxXxh9CfY2?=
 =?us-ascii?Q?EBN+Acr7Y+ReH7M3quAkyE5TD88v/80z6ckIRupeqid9w8Q/qxHWF4pWxl7J?=
 =?us-ascii?Q?rbSsZ9x3xePp4bIwpkam77zkd1KkVpKDk9bphx7SVgZ0/Lsbnn9XXx65H1i8?=
 =?us-ascii?Q?ecs+ns8TSNGfY09h1QuH+R6n+nS7VPmIvOOuGxgEQi73zi8ViYWDeQmr8KFZ?=
 =?us-ascii?Q?+aobYMi7Ut0VQO/0IX1MqoqniSxOfBfScGJy97cUzGpfFqDTn3YcZbuSkp+o?=
 =?us-ascii?Q?BvPk5tUtTouTHKwHpGvm8w8aqLYUVjHyYLi2+FQAneFJv7kKkTcb2NUtk5V1?=
 =?us-ascii?Q?J66+Jw5AdZQ5T0uXuTHkOJq6E7yaZcjIfkYokatdifXfyqvFsbN7cqvdiS8B?=
 =?us-ascii?Q?LvTIzhPShuDby2UPijQ+NejRxi26t1dnrVrwl7RMrjk+LInjr+ntvB1n0cQH?=
 =?us-ascii?Q?yhwzEvJJHBvE72cyu64YYxOD2/JoWLT9ItsHrmdSqDCDz66EOu+04/qE7nj3?=
 =?us-ascii?Q?mT7iDeNJ7RgKt0usAo9A42UyQ5Oe7GUk96ARRP4cxhhLbch0sW6cInNPK/4Q?=
 =?us-ascii?Q?nAftPAl4TmCfoIecxdndyClKxo/LauzXwW7mIFqRGKO+r4gkRZGuIKcljzGt?=
 =?us-ascii?Q?eHl37BxUfJ5izCC2HYMUAlFUHodWhB6iDd8btDtG/rRVvXBIVGD9XYxN/M7G?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 14krDFKd/Fij2U0cEMFscrczdNUSUjCDz6tSv7XkJAZZUt5GBy0u9rxU86I9VGB5MfigU3uxFsVXqt6khghXSLUd5O1V8AZj/OHW5n6gvb3ZHO2dApKGO6Y11o7ApelnQgotzpkW2OIHkfOnFKerUvR59ersQzJJGvZbPrN69ccBm+aFbbNOKvlv35p5glX5NB3nk4UY1z860AghJY5kouOTJEoDGYkdjyoo2svY2W02LyFsseg6A63K3Uctslusucfqo1lzyF8oju8oU99IdnojubQjS+QrHAawDOtjrDMfr4zgu/NXHVHr+QWsP86krYHa+VWyzknSYmZVRAfmqmozgEG8ySmdq/y6kwKzanNC3KVjfphyoY4rwH1GdCgM9sHMLCbBQ0YWdSipedKMgdB8nVHifhWKVnyg3flSnZOUr3j8SzQ1up0GqnM7bEap2ApFXx/KbnesBLnUS0tX5m8nb66jPn2bL7yMXDvO3IJX+jhY9RC8L8j9MG5VR53y3AlzU0YEauEooLBhupWpLCHHZaojnUWKIWEQ5+szKLm2agWFFs4emeDQNrd5g3gMVtQqgul632rJVW5sIXbX/ujOGSUpyab8Gnjv5P2Cc/VG88rce96WXnEzoZ0JGMeoyA4wFhBRrvtvxaBgiBIC+crrUP+ZY2WMNe1JCDGqMNxul068Y4kQ7dXeOh/ARy9WJY6TUomWwOqtNn03KOsiVeOOqID1WC1tX12tPZ6PjJsIYBa1F7W1yKHbecZFD9cZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6f1188-982f-4d5a-9f1b-08db67e5c905
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:01:22.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MooF8IhZYZ/5I68ULm5VuS1WFwSwg4lu97RCEZHSK4lKQjnFHv9qLg2CBNsg5MK+27B5HUrnyY733iVDH4EVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-ORIG-GUID: ixwlDduljNHxmY3VpBkb_Mv41KwSXn1U
X-Proofpoint-GUID: ixwlDduljNHxmY3VpBkb_Mv41KwSXn1U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


v2: I have separated preparatory and cleanups from the introduction of new
    features so that they can be easily modified with a smaller set of patches.

    Added missing git changelogs. (Looks like sshfs lost my last few changes,
    now fixed).

In an attempt to enable btrfstune to accept multiple devices from the
command line, this patch includes some cleanup around the related
preparatory work around the device scan code.

Patches 1 to 5 primarily consist of cleanups. Patches 6 and 7 serve as
preparatory changes.

Anand Jain (7):
  btrfs-progs: check_mounted_where: declare is_btrfs as bool
  btrfs-progs: check_mounted_where: pack varibles type by size
  btrfs-progs: rename struct open_ctree_flags to open_ctree_args
  btrfs-progs: device_list_add: optimize arguments drop devid
  btrfs-progs: btrfs_scan_one_device: drop local variable ret
  btrfs-progs: factor out btrfs_scan_stdin_devices
  btrfs-progs: refactor check_where_mounted with noscan argument

 btrfs-find-root.c        |  2 +-
 check/main.c             |  2 +-
 cmds/filesystem.c        |  2 +-
 cmds/inspect-dump-tree.c | 39 ++++-----------------------------------
 cmds/rescue.c            |  4 ++--
 cmds/restore.c           |  2 +-
 common/device-scan.c     | 39 +++++++++++++++++++++++++++++++++++++++
 common/device-scan.h     |  1 +
 common/open-utils.c      | 21 ++++++++++++---------
 common/open-utils.h      |  3 ++-
 common/utils.c           |  3 ++-
 image/main.c             |  4 ++--
 kernel-shared/disk-io.c  |  8 ++++----
 kernel-shared/disk-io.h  |  4 ++--
 kernel-shared/volumes.c  | 14 +++++---------
 mkfs/main.c              |  2 +-
 tune/main.c              |  2 +-
 17 files changed, 81 insertions(+), 71 deletions(-)

-- 
2.38.1

