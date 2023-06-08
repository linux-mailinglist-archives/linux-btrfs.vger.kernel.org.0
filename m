Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCE7276FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjFHGBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:01:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BA1707
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:01:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357MLH1h019428
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=mpA3xoWNI1qzNj9lqb5vSUJa7aQ8VqesA0p1LrO45YA=;
 b=KswUurdoQTlK1oeBGJM5enh5CvBxbx/GCWnGqNpfR/IKZZQj6do6pPkNRrq5AFXnMn5H
 xgFFP42MJx+IeCQI1OHalVAfgbS+nxQoOrx2huUiRBzkl2vJ4rD5tWvVfdLAOs2MnHQ8
 ndvNQ612lZ0sPINhKQpB9VfM/9RvOkIGFtOh0DLG5ZrJhbbV4unOgtQiXAI2zZLhqZV1
 CkiN+HliFg/nYjTK4V2CXiSaBNc/yiWnTOcgZvxjsh3YXzY4lpuXRXzJ79+9dCinl5Ri
 vFyCx3o8qJxnEWB55cwZVVUu6OQcYFRFpcgX9AZG/7AtsCucBZi7nCOxdhGcmnbnKEv9 OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6skfwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3585VVFh036674
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6knsx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/ATHGUe3fVcwSUZMw8FSgtLh5nyLvzGTHtxfZkAzALzXA3ifleK/MHsTfnLdeTBoEEe6ZE3qvVA3nJ4Tbw0gQ00gh/uCPUJbI65yec28qUPhOyR1j63YaU8BMH8nXLgGIwT7/5rfj8Sp5DRiCOBwEmBEFIZry3p+lvFVWccjmZUlyvXHt/RFc6lVfRO8c5mBdNSXa9KLnkB4pMl/D2fwhHCzBxhJ3INFCVH4PV9AhilF35eewcGjdZmvtNISPXJpmL6rn088aqd61ztAHatK/QbiK1/TpciAsSXvY2UyNMwAyKgnLVD+xVIhib2bgYPtCCgjmOwsSrIZXi4f5HvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpA3xoWNI1qzNj9lqb5vSUJa7aQ8VqesA0p1LrO45YA=;
 b=jrDrXXDUEGDmTeaYhNEYWIOQOwF4m34+vZuMOJR+TBw/w2yfg00G4iEA+rIEQyXIarVV6012vUgWsAEW5cLxURnAg6XPsPshcF9YQ2yvz/KN4Tj+KVqHVrgNoM+4TYSdQJ6PpoN8bAImLsUJTldRZngBSdLxBLMP5eVqp6G3bca13eqEqrjocqZZL/VNh6oMH62XoZfaryUF8al+wqh6jKliID1FdOGT8p7dPAnEuusuoK3WCiiZsIiyGeMc6kI3DeKsDnVvKxCqVe1Bxo7NW9Ia9KmkOWotuH50OsuiqLfwsUXTR21ZFSv12KiML7N5/A5rtYouYEtRFA0VZ4tXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpA3xoWNI1qzNj9lqb5vSUJa7aQ8VqesA0p1LrO45YA=;
 b=xZfoe+h0mm7+p/96kws6FLqtWnePbed8vptSH5fw7u2ANeSQm5A+nkUNqFjuF9U1yKtSfSK6ssLuuvkoKFYdu0eNQaXfo3z9xeIu+a7/kDTYDMYZC/iCHLcOBfuiz4JV+8+1foWnenBCT9yCiwSUcpQ2Z08aUxhCGXLRzWZ7a+I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:01:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:01:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/7] btrfs-progs: check_mounted_where: pack varibles type by size
Date:   Thu,  8 Jun 2023 14:00:59 +0800
Message-Id: <20d70d9b1ab791c796c73bfc84c23abe956af52c.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 377c355a-5cca-4469-8604-08db67e5d1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSeGU3vdkCLh0SQ6aa5E5GJ5LEAyxkT/UiB7GF2/Wov/55gwoBiloeq+f2Ld3zHKndTCqQY/jP67lJ+uWDKbDhCm5qlsZVZOy2e79Rgo08J9quraLWPwaVS6tz3dWJcr1/d4uCyEULEXR6UB63oKieZtmfj0132Y/I4lSF8iel5R52XH87KjEKDts/MdHkZKQvjtaaDs8TNZ85POqdg7wYCscY5BzagfvdLDO5XQaoQeOYoRvq5orZ5kME+fhSksNNDaHLt4YPYwBIa8AZiH9iSzJKhT/lA29QVMmwkk3j9qNB11XlNgVBFSvE05LjvUAbtd/q2Xqh2+oDJjoj+ppHkjZgM/C96cGXIb3eCVAZpVz+FLVW7SoArWNxqagcR0IZzrWdrw5hOfZXEtUzYXLE8wtp/aW5bVeJ09gwBEiOm6VxVbxgSPsynBJXKDtXQ5TyCf8CrnZEQ9sq1aOBvg1Ussdce8TURWxbqfvQ7y1JLgN8w7yvDNrR/HIrC6+9mx5i43V6FrJPaRYttQXPWZ3Xr7yCns94lpBoceErmHMJ6lZw6hZoa8PV78p2feQ1DY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+uOnkHi2of48i9Ejmwh5XT14O6ShaPDw2QPRnehvakH1WGJBktGY5VhymfL?=
 =?us-ascii?Q?SrNThPXPc4BhQ2EIwkhSOU+0ltcpPFXArueevC3dmaHUqodKe1bf2dsqlCSA?=
 =?us-ascii?Q?9o/qO8pBaI8qU9LucwTMBfG1sspNs+WSN/cdOPQ1AtkDrTnDZXt8YEG879yx?=
 =?us-ascii?Q?ed8sndWdhz8PDRMZhLusyh8qE2rOrwbVMV/s6zsJdqxy7ICVT4VzGvvcwQ0L?=
 =?us-ascii?Q?ZpG11oqw4B8u6wfSzifx0N8z/hMz84bs8zJAWRG3NIWY256vYHP9LaBPN1ix?=
 =?us-ascii?Q?B/boYg/zhhv6zy4tZy15DFU1lZlRhLBX809C7RSMlvM4wTNosnHAi8vN7U4N?=
 =?us-ascii?Q?9MLBnWLTcvBwoIA/WtCu0DrN2X4jRsCNWsT7Sk+6Vk+FntxjSorprgSh5tYG?=
 =?us-ascii?Q?CgIUf+dNGR0fAik0a/GFnhdR/aWa+ilH9tnNfk/AX/99vNn0uc5rZOk/rX5p?=
 =?us-ascii?Q?Jk+iKgOL9Z94y2w60f5bRvE6oEYVsrGuJwUOEOtF2YtByHc2kX5jE2y6Sgnd?=
 =?us-ascii?Q?YPXxPgDyS3udLobvquQiwmA6C7DITYer6fOF4XR3gJXbvdcRTKDBuwp6AYMr?=
 =?us-ascii?Q?m6fIbFsFtD/Xw7ynWExyZFofQEOmt49/ARofFAgyY2JGxNp+DqTErvJFsDkf?=
 =?us-ascii?Q?6RmdEJKDPUAlRidWHQH2kbEFmWygai1wdCdrAUmf54sEOQHTmvA8SLRXDY9d?=
 =?us-ascii?Q?6+o61fiNjjEtSDkAbkb3vafakzIvy3uMCoBgocNm7zBT+0KtmDq6pXtmdG1s?=
 =?us-ascii?Q?X8CjtRAMXdHJBJqVf6E0hwcS819fmWClhoa1o7rGiIsBTP1+ZUbhj+j77T9v?=
 =?us-ascii?Q?cDYeH6LOrPyA+AIo3l8AL20wOI4uhU+F658/PZ8RjsxbqYOl877heTTS4qxQ?=
 =?us-ascii?Q?v0DJugv4dds7EGAU4tdy/EfvP3sMJz+Jt1IcFjYgsQL5icIKmICkFtn18MuE?=
 =?us-ascii?Q?e5QZkr2nA/36z5Ed21iZDqxRtX5GyypcRFDyxaiZHlHneW8wFk8HhYZg++C/?=
 =?us-ascii?Q?kB9gx8Z4vyOZgy3Gh1WyrqQFyTUhnbO0GsLrm54+/1i70hLDatUWkyShMyeu?=
 =?us-ascii?Q?gtxayO7idhfioWLPU4qUR7wkIsRlgIGxnfvy0u2ecZk5PtCj1FAITU+i+ZEl?=
 =?us-ascii?Q?/TiuGZk/A9LSB8mbrCYwY4sJN91VrHSj+ySpyMZSwgM6ZVS0BKTc+FQLYVdK?=
 =?us-ascii?Q?/9IPJrmKFQ4gj3bj7y8ucrRPwtMiLkGjU1P6BCDyZwpCos/VP2AWj0/5FE8R?=
 =?us-ascii?Q?8sBZFVm+S6AbjLegdpxzcVQM40aaKSXnnEfSgsCWkqt9ndH8NFg3ulujlWuC?=
 =?us-ascii?Q?Ko3hVG4rxUYyHsfcLRaFUj4oYAtCHB0v0k72afII29mokndGQOsjkW/p7niL?=
 =?us-ascii?Q?xJ5howQ9WFB21ezJd3Gnq4m+Aujl4BorkudW+Fd0hGkZLHSfLlomm/fUYxjW?=
 =?us-ascii?Q?ywddQmaGlaDmIjZt0w+Xeb5h/mJ29ZsQkyg6tRb+N3ksCJ5JEtpI9NRUGkct?=
 =?us-ascii?Q?Q5soPQz37K2lK9ZJEti/hyzfkqiDwJsXZCxrxCPjYeqsvx6srqZ7ywIdLAs+?=
 =?us-ascii?Q?TqGeZQ/69QNCXV3/KNbL/D8qTOu0n4J6qUtccGw2uEMLD0yJkq3qAQU46aS1?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8XpqD/1KMqN0FNw5V6YaH2e5v5HnKQEqnPt1capcvPVLFLd2YbVrOjXSToUNfKW62us2UZFk/vqJacuLnmqPploBy2gkh7vDkxuplwQaZb0bEf0Z5hQWd7XjDZgfjiErfx8RYOMMyd9NzpaCceCPuYmow2yboA7sgxgye71mODpMK0GAueM08w92RvBOZhBnqQ6QxkDVz+B3GmGbIjkLAGMR0/ADNPWJO9ZUeFvc1zt2U+bMc8fv8QziWh46P5ezYG+tRM2GLlbKFvNhSCT+PkbIGWoLGFAnBQq1NUCjFGmnCwcqEH6eTAKPr1pIcCoPSb8vtLMwIP6rgsOIPv6WdNifCWRgWEVwOj8CKgZiMg6WMO1aTVCavl27l//PSZnKThYQsxkISvj97T31W6CVeyRUqHBFImGRZTlLF9QyNAnRZ/HscIFEShEdEAExJdLiPNdXXNZy0pYnyQ3+WC6p443Z0x1GMyT7H+CJi9Ey66WbagfqKhkFSR8NzQLuHEP7IzejSgu4Bgf5AIV7ESTDX32/RAvBZFuGsm2avGcY9A1TUlH3VkUTvIih8slW5lwzyvCJtYJLtuonBMe/ZLgR3dnWDjc5utOBwq5ggb3hNE6bk/mqtFPy30jacm9TlphCjpDEp59id/SiF/lXT0TclvYynBuTcU3CiFRdUYbHphzoZlkM+/HZna8gigxf+YlP+E6rsrjX+dst54b9f43yfAONaUi4FczOkL+KLJIXWirH1FdvjVdMlLR8BuG/2/lK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377c355a-5cca-4469-8604-08db67e5d1ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:01:37.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Pjuciji1wY9ZKix+mvg+M3C2hepTJOyxBY9rv+D2sXrPyuTn94v8u1I/eEm9oQ+3Izs4W7sYgBp6pRjiE0HVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-GUID: hgf6oS9tf4rYtIpbKZk0h7nmoO_qkyl0
X-Proofpoint-ORIG-GUID: hgf6oS9tf4rYtIpbKZk0h7nmoO_qkyl0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pack variables by their type; it may save some space. Also, fixes a line
indentation.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 01d747d8ac43..1e18fa905b51 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -55,16 +55,16 @@ static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 int check_mounted_where(int fd, const char *file, char *where, int size,
 			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags)
 {
-	int ret;
-	u64 total_devs = 1;
-	bool is_btrfs;
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
-	FILE *f;
 	struct mntent *mnt;
+	u64 total_devs = 1;
+	FILE *f;
+	int ret;
+	bool is_btrfs;
 
 	/* scan the initial device */
-	ret = btrfs_scan_one_device(fd, file, &fs_devices_mnt,
-		    &total_devs, BTRFS_SUPER_INFO_OFFSET, sbflags);
+	ret = btrfs_scan_one_device(fd, file, &fs_devices_mnt, &total_devs,
+				    BTRFS_SUPER_INFO_OFFSET, sbflags);
 	is_btrfs = (ret >= 0);
 
 	/* scan other devices */
-- 
2.38.1

