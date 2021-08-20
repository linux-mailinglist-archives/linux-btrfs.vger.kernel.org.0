Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE73F299B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 11:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbhHTJzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 05:55:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19586 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238868AbhHTJzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 05:55:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K9lGUP017751
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=d0mMBCA3miyc6c/o36fqYbS+bDW3hOARvhBMt648cu0=;
 b=CjVP/qJKADQwebbkIXARHveV5nAWC2x61kJiiYFDAhHh0WqbvWcGnKdj9FdxogZVsdsd
 DaxiIHcVcRO6RqTOwqbMgpktllzhA20bhMPesHg0sjD+NYXM1LryM+XNuYPgCWSB5Afs
 slTmFpRlblpjbObJA68mdCxmCQYKgZ5pvFH5rv4IX/F8jSqf8CXrj1TTeP4PcyoFeibc
 aSJc+R5onMSX8NGMIsFMofnSMBeNvB+vJoZd/C9RLJoR3v7rifvBdxis2XbqKC2T7ppw
 cnmvLrj8Z3eG3Lcgw/3ccEdjegPLqr3UkXk8psEuE8nCIDH66pB0tj4VDwPorOqIV4wj mQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=d0mMBCA3miyc6c/o36fqYbS+bDW3hOARvhBMt648cu0=;
 b=ONl1tB7dqeRfAmkRei+f2Riy0rxnXv9DNMEhlsUVRp/fVCjxFSj1qGPM3m58gO0H2N1B
 hsVBeFlN/RKCG+qXQK6BWULRG709w4xqSUZhxLpbkOejofiauinw+HNJ79lRP9whVfTo
 H6u+MH/9KXL9n/ScKRww2juIngsk1eEWO+INXZByhA5n8sZsq9JdbWaYKIggyrwajA/7
 qiNWpLy/y0J4bter8i3vPGxjngKMfrcFxQyi9T1bgODohme9OzdH7g8YwuhZQvIThiUM
 3ZCQiHIKWgudmFEk18iO23UfVmh4GP/IJcbKDSMnavzTtMDvN1Xe0slfygj2i2UiLKBJ xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs5cj582-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K9iwks137393
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3ae5nd9s6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvVOsOHQa55XTJJmL50u+jYMRl6HExqrCAjJ9SASxGpOXGfjIvzjK39IZFo6zEyR9/CrJ2in+CAi2L4B2/SRtl7nU010hHk2wZXqFLTvj7iG7mi04ZuIriAuARbPcD2ICwZnInMSjjCACSuNyfKspQ5eAVfDUTWHRfqCRSwFpnvjdKeBuwECaEUTbdLm76w15XHlL+GZCSGz1WQtqDyyQ/OeYqEq7c8w4DpZkNmqD2nseG2XPW22UwCgUzMplpU1LdB1j8IHZzq5603jl4h6H0Rbt1uaL7GfVpWPosasaBgoDfBt/cI94d7LAKIjj7bwtFS2XWE48kHQ7am4e84xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0mMBCA3miyc6c/o36fqYbS+bDW3hOARvhBMt648cu0=;
 b=n6okrFIZv1DEGw2KMEkuf/HOZOYmYtC9fn1DLjSOItPn0m2o8xo8QTPrybVBmHkHVmToBFHwNhLzrXGIxfedHx+5mTA5MI8vtbiDRgisIru9q0ui37k2N2GaiCHYt5MxRb+8qWWdH/3CKdkT3b3J+NHEC9AN3ccprqKWKeTO/t8566P+K79yGj2OMwoUd2PM8ghOwgOQLzGXMJ0qhVketCUyEJ2/XTXQMXhnmchEV7Az9Zr9k3fdL0Jif9z1sVCIK8mAo5ax94hbTHL1+KsJ47PWdKq1OnYrhrEtc/80qnmGnRaeD0CqQ5UxpSSYPfFLJ76J0UAw8oCUGlh3FM3m7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0mMBCA3miyc6c/o36fqYbS+bDW3hOARvhBMt648cu0=;
 b=t4J+Rgu8lWvsFmsIpqVfuA2Km9VfWDNDy00C2dTWlomWvr+JZFmx4WGjj2dM2UxNjTMgx/99TtnPrmDMPiSzFyNIwK4MS3HjeFI9WGXQg8y0DQHT6ZxebX2xW1D2idRRchBjeDFillCF4wiaXK6GYRW0K59mvjsFZZspI1Becqg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:54:26 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 09:54:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrf_show_devname related fixes
Date:   Fri, 20 Aug 2021 17:54:08 +0800
Message-Id: <cover.1629452691.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 09:54:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92ae820d-871e-41a4-a58f-08d963c07eab
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427CD78569510368DACF8F9E5C19@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrhrqZRXV5sjs8ftnmMQRKKcGv21MEfDK4eSs5exiWrWgrt6esUKju7+RtNTWd0eNqI0ONUGOralOEuVrcK4gDMBaeZeQhVaNMEPh5kbxDso4sIGnLdH//NT4PTL+AGV6jZX72oknVXQcwD4PexZs7b2SrJKCVzwFVL/j4FfmmrcQDo3n9dM9dsVEhdTgIaLAHZX9KU/YKeVO5jMPloORe48Na3Mdq9sCjrPQVEPKGC6yjxvmy0kdl8Q0BynW6Ad/xOE2Ac+hwgbg1cjoecozoX7sQzv1KtEzDj4iYSvadZuDFkL6+awtPtpWkJJSjmhkAj7lc5/eT6Qa/UsaEMAy4RuBcAC/89K8L9YF93O9kuDuKcwzip6HjWX9cgCAhIfVzSU/zfhmkUTGXw5XVlWev7Trpr1PqyJ8tSbMIyTR/rM7u4UvAX3YWqDhwFDwtcVGAynBDhpKx973WOlNMSSmiDy9ZNFdGobC38CkmxyWfEP0RTsOKM5PaW5yDfmJ5TmSMQiLTjDf6RmFiGrJSyYlmBthkLJchsQKP+tk1L0jJGW9oM1msXkf7C5JF5XbESiK6AUBjEji9tplWX1/Je3d0hiuRIJdSeMxUd13wily/rLaOJk/U1lYzELij9iTvGbpuu7yHVlugdvke0YUd6EWxZsG7aUfxVxrif/QYR5GzhU+RBdpNE7BlsZjyoX/WKByo9znTGoJerO03oPJtSqqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(346002)(376002)(6506007)(5660300002)(6916009)(4744005)(66946007)(36756003)(66476007)(66556008)(83380400001)(186003)(6666004)(478600001)(6486002)(52116002)(8676002)(6512007)(8936002)(86362001)(2616005)(956004)(44832011)(38350700002)(38100700002)(316002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VKYI7kHZKNc4ZJ7DQEhEdeW0wR0j/T7Jv2PgBvMXWUt8XHEfxRielrXsDxJV?=
 =?us-ascii?Q?DjsCm1YUIGeiT5i8KGt1dgSY3hkp+OuYqQDQsmO2XcPtLtk3FNdMsddpQFTW?=
 =?us-ascii?Q?vtAwIfz53LRTjdpnMRRJtWp5Umwo6qlMHCMBGstdfQYRWrHGfz4nwKdDR7GB?=
 =?us-ascii?Q?I4+LUvhvcTiAp73cFHWAkDr0jwTc+fbdZjaPJPmxhRJ4zbGTjTCSU+3ci779?=
 =?us-ascii?Q?HpYgI/dTRne1TBGwss86BO9s0/yQZM5WFCxFpQeOCDZ4l/uoVQ8W2it1VOZo?=
 =?us-ascii?Q?38N+PsR4opMTw+uw2mzsI77Sctp0M8B36ERPZsZnTUnxiCvTOmKazQLBoMvK?=
 =?us-ascii?Q?9k+V66jlhk6StbVLjOaozOZmWvXdjsBhbzU4UGCIcYkNUQFgAAo+ma4helnn?=
 =?us-ascii?Q?dJz1oB6ZlFUDIjzghP+v0eMSz65y5SD/obRAvVAsyoOcWVR4l9zOSDLr9Bxx?=
 =?us-ascii?Q?vnR97vvNIxNiNxGxoqacnV3NE20jCAGL63QtUNtEoYvJmSawPzy5a1pSKE3+?=
 =?us-ascii?Q?OTcpHE8PBfeyd20maONtLTv0v8Kjt4VN44tffX3ASlInQQWRInzd0BZIgIsf?=
 =?us-ascii?Q?Q+IW/bv+UAH69QvbHwnVthE0f/55OFI8ITGagSGzCoao5mOpOFBJz9b3tzpq?=
 =?us-ascii?Q?PT0iShaKt5B2pgHGzmd9BXpA7EFq1mQCcEbKoprniczy6bXnaO/GQwx4m0A2?=
 =?us-ascii?Q?sx2/YhgFYs4asUF3VgSsiVLqIVEclGDFDdyqBPAajWrbWk4tJNy/ereq/+rY?=
 =?us-ascii?Q?QO3YcEUjNmYavxczvZtxNr1Ys+bQJSLA1DbmPu5rxBSLmA9Sc+dIeh1adgIH?=
 =?us-ascii?Q?LSittEOcCEZ/RLFfD9d7JjYJGVJCMg2DqEJxTCML/SbVniz/JfS2psUy13To?=
 =?us-ascii?Q?QkjUXlHbGGfxR3XIXZuv/eF1jxe/hGOzA5dCrcC6a+WftzB7XiAuscZJcfqO?=
 =?us-ascii?Q?5C+8k+fP87pcgYjAoWfEBO3Md5ybQTBGCD/T7eZpl40GJrXbEEKpIfwtG0ub?=
 =?us-ascii?Q?daW2DrgKRgbHRS8mbus60brMF6w0uqpegO8lByDYzZsaf8cN3tKwIMsWOXdO?=
 =?us-ascii?Q?TtgAtRtCRADJfYg0Qppouqb96XIpfhFgvw0bWSxuWT1ERKwLVTIaPTcw0KP0?=
 =?us-ascii?Q?mXG8Cp2mXEITHDfGVL2PWu9F1XeQGlWLcz238sQcMgPExpYOVQrKi0dYwQYb?=
 =?us-ascii?Q?5o1DSNQTbNJ+bxlBHJDnxNr6j8A6Sb5uZTeaah0Z2LQrf2EeOKvTUoL5PDVV?=
 =?us-ascii?Q?vAAvsZLK8rqsKLGUTKDnow96DHQvce4D1OfEALf3BEu7tKjDnZxecuGJ57t4?=
 =?us-ascii?Q?kDGV5PLfH3G/8dhgB68S/Sd0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ae820d-871e-41a4-a58f-08d963c07eab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:54:26.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5/Rfo9lFQH7PhanLjLe7HoEFZX+j+MexOndrOKMks0J+/7M1fyVuKBQcXFlf9DXPjiZ8S10NVviHqQClT8pmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200054
X-Proofpoint-ORIG-GUID: N93__QQ9LdrVVRpon8VU7se6ApbP10QR
X-Proofpoint-GUID: N93__QQ9LdrVVRpon8VU7se6ApbP10QR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These fixes are inspired by the bug report and its discussions in the
mailing list subject
 btrfs: traverse seed devices if fs_devices::devices is empty in show_devname

Anand Jain (4):
  btrfs: consolidate device_list_mutex in prepare_sprout to its parent
  btrfs: save latest btrfs_device instead of its block_device in
    fs_devices
  btrfs: use latest_dev in btrfs_show_devname
  btrfs: update latest_dev when we sprout

 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/procfs.c    |  6 +++---
 fs/btrfs/super.c     | 26 +++-----------------------
 fs/btrfs/volumes.c   | 19 +++++++++++--------
 fs/btrfs/volumes.h   |  2 +-
 7 files changed, 23 insertions(+), 40 deletions(-)

-- 
2.31.1

