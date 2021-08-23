Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B503F49D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhHWLcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:32:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61600 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235011AbhHWLcx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:32:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TQWt015809;
        Mon, 23 Aug 2021 11:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VkYn0kcaXon6byedJO3U/1GoyT4P7k7TwzPEqaFH/UY=;
 b=E0dlMpKJ0aVrKc6uKWRb1sfT12lVaBGnAF3zcS53C4BrcB21VhNRX279aBt8xeddxype
 lw0BZ88/+ixkEIlj1MmWFlsj4U1OW6RmMyz86nd8yXayOn+RPF1AOYjNmdwTsmxaZfNj
 us8GSra04Ya2KC00S+Wjb4rCMhtVgBOszDIHkhNq7PHSUtudq4Gq+VcV61Vtddxdm0Kn
 47D8QqPs6zFt7A60sjYTDP6JB0IVeVOkBtW6jSkSkSZpbahX/hT7SEpSxF4VSK46pkzo
 9rHRVikW7RWq9wePLhlnPomcOTnRUQSP1Ra0xq0bPl2wzYNtrpd+Zv8fZcmpcyvY8ekX rQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VkYn0kcaXon6byedJO3U/1GoyT4P7k7TwzPEqaFH/UY=;
 b=TGRXXWaqR5e2HAHbeWjDguqHLk80i2AlVBPL5fA8GLzEpih46nsDtOFT9oPqYTJHoRSg
 xugJYKD+6N51fKxct2zRLtIxdAQiil1RHjEE5sX3FrFqq+g/JzesKmna6QbOQRTBm+rv
 EAxdJ1MwqKLu7omwZrRIZAw4pxaY+51juDgcxm2DPVcu6d4qDydGzKDi1GspnCNtii+I
 n3QoiNpfHpbL261nymk4rrdcot+WjtqycgwdyABpPENnAHRSO/VyTZ+45CsZUAn+8Mnh
 UI3EF8Wm4j0dZKZcUtknDwB+2ApV6iLCGXmpf51Eq2yBcdHyvRvMAZ+gJO+Ii3tQy5wH eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwfm17jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NBVLxS021994;
        Mon, 23 Aug 2021 11:32:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3akb8sh71r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPQPIPoLSMNGhXzYwgdUKLzKne6XA7FQnc+urv5EtRft7wBhwURWg9UYURFjhceAWq+kbJJiu/Ozcx9I6xwneJK4o1E1M+SMAHzdNXFGzbQisekqofG/ETbKsqCMLp6bah7BoGnlVsUpffaERCuoM8aWynudl0b4U7h/7dp5zJbt7ZG0tvjXVAR4rS73sytUc1OVTkx2+SUUv2XXuVTB0VxOs6QPMxltaNtQ1a1i7MS5+eA68Iv3hvkJzYCucNd1GHVltBv0wSzzcn7QselXjK/x3bzKNYPRypUngNV7UFJh4demUSt2MsihQNwDETzSVsxcmp8j4wdedOh3hoVxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkYn0kcaXon6byedJO3U/1GoyT4P7k7TwzPEqaFH/UY=;
 b=noAUXtj9mjPpe81yamOUzTlvCdMVJcSZsjLX10nCl1GHvUix0HJnVoE5TLHjvaLw3o93ZOA3V4fE45OcBWwjWiVYYwgVVP8cgE1ponQtAeLIhikcF8k1z4BhkvsdOsogSrGcJo4iGYKiZHtuTF3TeXfZLcEKVmPvAnBK3Au17rqs5E2msSeIMUyKwnigw2QZFzyPgMia9sSQOvAWL1jOxctTp5+M1hAgMs2cmFmPZz7btAUB5HAv9Y4/Nmj8qX6QgYQ6Odw8FIWizSy5dYkvny/6cydrfv+ulwMeat72xMLo8vAsX32d8LFRgBpwazAK35VLu1c5j0CxfSbunqs5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkYn0kcaXon6byedJO3U/1GoyT4P7k7TwzPEqaFH/UY=;
 b=SI5AKeawAXMYhEJCwbjrjatWj6z4RTDGPrevlQsnOlMix1DCHiWqFvf/lUsrMzdu+HfD3UDXLm5fX4Viklvy9CiOYFQSP2DPWw9w/GL0s4u06Oc/DDRUfzcEawj3A5wwX32zrjSXjr4CvnshMIMDYKyAHqQkHeg8O06buFxJ+6Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 23 Aug
 2021 11:31:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:31:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v4 0/4] btrf_show_devname related fixes
Date:   Mon, 23 Aug 2021 19:31:38 +0800
Message-Id: <cover.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d6da8e4-26d0-4d8b-efd7-08d966299dcc
X-MS-TrafficTypeDiagnostic: MN2PR10MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4206250619ECFDC08B42CC8EE5C49@MN2PR10MB4206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Auz5V0paLqZRrzvs7ONjNvlijWZeLma2hUSVfUKGhlgK3PSIVY0zXCM/zOco1UeYjosXPYSvUjuV5bnPUCJ/pKe5LN6MNzHAolQUWF5DMrDPcRhHKdRvXaIUABQD6XZCGlk1fSpoLVcy5K470jzf8mfA3MGahwsjGx8lTDjmnEbm2ggcxZNaQ40UdHfaQ0XdilsX3D3O5qWorztKUv6dJiH01n9L6ABS4nLM1v9fSadTRN1BmLIPRLYAlOUvP+cX2g63LlrWyRmiJvRq9MF9NRPuOeFO0IquBSWFZcUdsETIYG3lBOGvbJRMMbfPEA0T3y4kDDKXCN5KkqaoYXoPmLxJ2amWOs0IF0NRo6bfH31H1Scp6orh0HBU5vbjNh0QH9iyIw5+jwaCG/JLDy9HZWoNxEazE7QY236Seexpr9FHh1+1uICHnyb+LDJi3nDnrC862Owzggcvu36cIAdGB2Xt+KE5RItbVjz/0NZDVvmDNscuPQFDh/OewWk2isa6+zNTfddcp3RbCt2kVEJfiBUbxML0U/VVi7v1GeIx8iduz4jY+d9XebuBPqvEvAfnw0tVd6S/LbM0dkG0866DDo2Ip4HQlgBXxnwYfoPWaegJHXf3qEGajzDWd5vg3MfFnOVFPsAo2rlZpa61JdBQLjit74Vv0KaraeoCa09HRjMF3IEiAfJ27S2GIAWlXVweoD5Nxr/sGFKsvXrwXTJewg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6666004)(52116002)(66476007)(38350700002)(4744005)(6512007)(26005)(478600001)(38100700002)(6486002)(6916009)(86362001)(316002)(83380400001)(2906002)(44832011)(66946007)(8676002)(4326008)(6506007)(8936002)(66556008)(956004)(5660300002)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJ0ekpjuBvJefzonytNc+E/BH5WrSb+C6d6dpg5N8oy3012h6tuSHtoRW13q?=
 =?us-ascii?Q?wFmEB9cizSbGKFFlMU+eIu1Z2/fQoefXPWocF+dvS2BcnLkjMfiLI5QeSfQm?=
 =?us-ascii?Q?FxN1/KG3DD2ebYFF7ro9i54snfE+SNq5C057O2DmuMh/TuKPle40XNQeS/Ef?=
 =?us-ascii?Q?9vwNq69AGtNYfG9Xq9Xv/FEq0GdMU7MBpfbdZhw5glbFtEnF2tyQbt/jiboV?=
 =?us-ascii?Q?Nc5UrAaly9LyG7lwPyYM/ciO7nLlPhYV78bZKlPa0LTL9V4pwr9HZOVhz0Kr?=
 =?us-ascii?Q?ZhQyqqoSiPaTEiI7IqzosifSsYG5vG0WFqPsChEVq5mpnW5gkl9aEIi6Zcpr?=
 =?us-ascii?Q?UkUEqOtEdvgI9Uthd/zDJdMsvp63UPhWE9y839QzCBmHv37ixtlXXz+FfXIA?=
 =?us-ascii?Q?2d8f2eR1HlJo8kbL7W42sODhUAnqDT6YOqR+QtR3czVsA19erOot9cWFzLnl?=
 =?us-ascii?Q?epm+WRHC9e1kgjQwmJiXLj1pp3EZdhpNlVzk2qsJ05oxN3G0LBQW5Wf786JN?=
 =?us-ascii?Q?lJBmTR0zYItjGsfqsngnPrZG8oGFtw+bMOWhsvei4/bKNRumEJJ5SAQVsaLa?=
 =?us-ascii?Q?AocmfzdssonOf9nwXNa42dKhMS7UAYuJEGM9sQ2aGLi1ge3mjxSoT3UCbobo?=
 =?us-ascii?Q?fuSUuQxPH6BNB+rTTNDlu4d4mnsyySPxxjRVfG5b8ZRor7l+/IkW2gt5Iprw?=
 =?us-ascii?Q?GH1PVRE1JHtaD4cf5FSTst7+bpASJIgvy3xOLmiP997VIgjlhneRiqNDrbhi?=
 =?us-ascii?Q?B330ZE4skZnPbBqT5xTb9Bdtbh8ZnQsDZHFXbtUxAoPN2VIC8o6pZSyQ8wkI?=
 =?us-ascii?Q?NABmB0yt/d1MOAzEpRDXtfS0Pja+8WonwqMI9ugaOm/RV7zookd+gwx8VTU7?=
 =?us-ascii?Q?Fjk8ql22K8UQ0NPQ2fINJeS2SbwG4Y7IudqYHg/400nhWgsFiFte4HwdsPpu?=
 =?us-ascii?Q?vovcnpc5cIDGzQpqLxC2m3NCa9kzTwKFRjeNE9eMzPRfUPOvtAJqvRMCYzT2?=
 =?us-ascii?Q?eBOTJmyUtgNRe5BgN7GtbU4sgEs1eV3s1bWpgg0TzP0n7ADE58EIPN7YorHw?=
 =?us-ascii?Q?l86ETKdLdZpJfs2qfWwj8rnryQs9Mzu0zp8+i05C0FHcZPdRDBumoLkc9HHw?=
 =?us-ascii?Q?MGun//mHrcvKwyTB+bYLyis3jDu+Afn9uyyQQZBLl5y9BG5op+aUN1YRrqlY?=
 =?us-ascii?Q?G+ZHNCHurTHS1fu3Aud80IrHg0EdCHnbYA+EFlYbwpL4glVkuf9XqQAsSXvn?=
 =?us-ascii?Q?MbWkMe37OEH7F9JznJmRtjBikqds97gkAIfB48iDAU5sUxA8a4EVOzS+6P6U?=
 =?us-ascii?Q?Q71gJjoLGnAXgv4VFSlalTzA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6da8e4-26d0-4d8b-efd7-08d966299dcc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:31:58.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvewP9J5b4UsLaBigPyQ1q+R4ruuM+2zMqnRviNw+jO1CVXBsgRBrWN3UdtQNrKaEBHEQCPidmzXjBoHwquh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230077
X-Proofpoint-ORIG-GUID: KQCuP5IKUuqQCOqIDaaOlAZG1etAI6Zj
X-Proofpoint-GUID: KQCuP5IKUuqQCOqIDaaOlAZG1etAI6Zj
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These fixes are inspired by the bug report and its discussions in the
mailing list subject
 btrfs: traverse seed devices if fs_devices::devices is empty in show_devname

And depends on the patch
 [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
in the ML

v4:
 Fix unrelated changes in 2/4
v3:
 Fix rcu_lock in the patch 3/4

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
 fs/btrfs/super.c     | 26 ++++----------------------
 fs/btrfs/volumes.c   | 19 +++++++++++--------
 fs/btrfs/volumes.h   |  2 +-
 7 files changed, 24 insertions(+), 39 deletions(-)

-- 
2.31.1

