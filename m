Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D57B1040
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjI1BKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:10:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E843F5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:10:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6fQE028365;
        Thu, 28 Sep 2023 01:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=peMJgVfOZiFSYD3hhxXYVVdUqHzQ0vg2Q9+RbhZtNko=;
 b=d6s86y3aGKlBi/ga3+mDN5LnJ8Iu1LQ5T+v3OM/joFnoOJhrRdEptW9PihpVjlw5upWQ
 1pCB09rvvRUvAo2GagUmSx5kKYzEoyUf0CkSu8cVgMfe424HDvBXeUpaUe5PBluyTC4n
 q5Ao/yaePJcJad/HM+F2Pru9Kz6bGvTskVKP6UirAbvSxUPhzA/ZfV2EVg+NYjjTyifS
 qGOULLgNyqgFJnuAxVmUHNLZ4VwVmqjRAHbwsfwtP/sjzQpC/VvQbznUCvEkIAALNo5Q
 eYQZcl239d68/aQZRlNjU7sT+v3vobCnPPm1/nHmkKhcoIg5ORojrKxWVC10VF8JXFel pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peeaxun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:10:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMrVWv030643;
        Thu, 28 Sep 2023 01:10:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8uby8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4LW4RZRXvvKuJskZ4ew7r3FwAtfL1AghJ993n+DPkCKPiwKru3Phsm+FxCI2N02fBzN/SwkNnPHb3BIiOIECQD7MNRqs1OaF6qVrdJOwSiyo9qkRChDKz+5/ZGjHjYQDdytTY5U21wV+pj302r//RvgPffPceopjCGK0NYqmRbWI326bkbuev17RaTu2dweybyS8BBE6xzIWTnRlcZffgPU5r3jvnPHiQih4por3/lXvWbiwyga0ZI0s++p5zLAmHpbW9mJD1PT7Ok6DcPLmNaWH9BzCy2ZIwgN/JjXahIUP8HNkYoJ34P74gHgf5s6x1gnAAr/YfWjudOXcjUG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peMJgVfOZiFSYD3hhxXYVVdUqHzQ0vg2Q9+RbhZtNko=;
 b=nYptamWtnvI+R1vuNYO1YIblgMLDOydf5Fqscxc1e9lDN9ibnzc3YwT8h20XdZIgD1uNVhipAfjsZo08+zLvxsufCPJqfFFn6UaDYpyI6J86BJRPl1RluEV9zOXL+2Q86kbz/wFFAOg/egeab0X7RJ2u2Seivoc1cUaBTO1zqaRLZXLkF2NZoBh5AhIU+ouwQzYKu37liQY/FhVjfisCPSBslHPyHOqV61OKBxCnUi4GWnqlrMwZ5JEDNPIsYz5cSoMbn60OOeXGmdYYeChhQZKhPPnHkyPEylTIjrjaHKFf0wZGOSwYvp9oIEkTQD7ZwqVL2yHxXoTub88dLA2fGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peMJgVfOZiFSYD3hhxXYVVdUqHzQ0vg2Q9+RbhZtNko=;
 b=UHTWxI8Ut2W+q5RrAx6nGh6rjcS1s5DjSEJatc04RQ3kHox1KBDdbHsP3ehNFDOou2bVszVbhgCW9mXe3SIcebxM7dVtAJIsKe+hXb4lnzbarygIJvNjmQ6dAVgOOnumRS2Nyhaklrh4QDiTFNU4X26wSFEWbuuXYAFUY0OFG9Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:10:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:10:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 2/2] btrfs: support cloned-device mount capability
Date:   Thu, 28 Sep 2023 09:09:47 +0800
Message-Id: <e85f357bfbcef98bba37e2f39e884a371fc25b56.1695826320.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695826320.git.anand.jain@oracle.com>
References: <cover.1695826320.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6bf54e-bca3-4fda-0a65-08dbbfbfaf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1R5pdxU+azRMFi1rp4TJjthP4KeAnOLup0xkSbAOCe2awEEMXqa+v24oqgwpXPTKyafQ1BB7y6MsXKgB/mc5Xm3MjaNLf87D/lt6NjE1viZoNOSssPH+r2GL1sJoeYvtBDy9C9tVps8FhpVvYf2dlVcfHQe+im/jOiX/uGyKhKym56oKzwcqmRgwl2yHrrdiDf7V29W7tyZQrAm1fs3iUAkPKjagqIToTtMXbRYE+e5eRCl6nrNtLfBj9Zyx58OwlFiApfm4fupstovcP2EaEJVFvyIdVrYeBo36+dHHv8Z82lTKMg9LVrs/JVTVKrHNJsOOtOKpVVwFKHK5tDvDzbiFovAhM99lMwYm7Vby9x3e3gLeju3ShLzjKtI+fKqnj4QJIvDOmTDGZLkv/wMELQ9ruqrGKARE+XLmyPuY1yvQgKYOHQLwBWdK4QPxBD4Sc8maeVwMXmQWPHvMC3dou2W7QvgH64OUPfSvwTrM3TTOderm6sfIFuFWzfsyP3K1s6T4xSaPE3syQDuSEli3zu9FE4+QLd5rBUmB5JhlQR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(2616005)(83380400001)(966005)(478600001)(6512007)(6666004)(26005)(2906002)(44832011)(6916009)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(316002)(8676002)(8936002)(54906003)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ic98pj9zgrDshicNT/HM2RyfMaeHiGoydVZhGVlJPJF+6/o8HXFYd3lM9N2R?=
 =?us-ascii?Q?EbTK62dUOAzwICuNuPoTecco1n3ZTMNj+WoMsJj4WyKp/qDttpiQ2Te8iyOc?=
 =?us-ascii?Q?E7SkUksLd2jL71KfUG/DKeBjutDU0V1CLx/WBNaRT0rIad7K3ldie4tXBZkJ?=
 =?us-ascii?Q?IPMSa78rk+t5DrLaMkS+OkBEcij8GUnjQUR0zSzZ9tqHwDVyL4KQgchP1oFB?=
 =?us-ascii?Q?MA1X8cktBL3ra6hyFyaENiQtaScLEkuRNrNEU/TQlxlE12ysUlEiJztvgnrG?=
 =?us-ascii?Q?v8nvon7zzkrOd1cNRhS07dmG5K6ArtoS5pgYXWQkFC55HAuQa11jMWtMLB5Y?=
 =?us-ascii?Q?kdN9EAD7Yb+RqPfkHOrH39gF0EVVx4UA4oKDpSIEh2M91YxSAyAVRXxmJhv6?=
 =?us-ascii?Q?aARajTn6/iBH3XjhUIBNWyvI5hn8qpXXj2oBgqvUw8CYgGtJq0eY6a77UaqI?=
 =?us-ascii?Q?gyx2fPm418vLjXHIJ6PFIxL54+DXRW9j469a/97uwECL0yGfE7g/l9QOTl7d?=
 =?us-ascii?Q?jYqSY1gTBnPbn+arett9BTXpTMdWb0bNvJ5+uaZuXvARBQNdP5HmgGBh9Jl8?=
 =?us-ascii?Q?xN16hS6Vb5Ter1HUWKSZ8Uju+Ly+Izo7TE0/3VCVQM4dQp9mNFC0/Sf6uFTk?=
 =?us-ascii?Q?8/yxTezxwY7RKXAwORebd6QoVkYoC+rB/BUSP//st52gjpindlbmyuCSveYX?=
 =?us-ascii?Q?myFa+2C30TXvA/G+C8OwG/NZedFCd+fkAVmLcy37aB7ICP+We4VCEu0rGgpm?=
 =?us-ascii?Q?6SQJAJRf0Kvf853yAfmH5Yc5BeSO236ONows/CgGl9RZPOeU+jN/jl1sMPOR?=
 =?us-ascii?Q?dZxGy3RuNBUtWlFvEUEvSe2tenmNu/+l3LmXa4X4yZpugCfKNt1Hr5Ms1/nN?=
 =?us-ascii?Q?MI4N2hFG/+Uv/Bi5O8T/li/Uxi+ZDybU+g8xkNSZ2FiB/JMRsi9iwOU8uAoU?=
 =?us-ascii?Q?YR5zqEt8xEX/4JJnkFDN76wVVUmtvqLaAPCiyuv1qEd2cDuiyrrEJp10eO6J?=
 =?us-ascii?Q?Nq0Trz1D739pcDicVDB+q/fBprnNZs1zDHpzEA9ouMCBBLH5cJkqDWx55T5K?=
 =?us-ascii?Q?vQp8M9791oKJ5o+/R4t2uND+0iCIRo4ufJTosCPyKNwSSGp3H+i28ePI8U8Q?=
 =?us-ascii?Q?4d062KdYLWzxGqYlqDz3pQ7XxWqHxAQIgu2bz9SAyYPLrGc2yRu+Z3EFBv7K?=
 =?us-ascii?Q?rtfAef0BOc79pPO3+2iO7OoZEB4HtTtXqiO8xP7eGcujGZdc0SHQEIU45fGA?=
 =?us-ascii?Q?Ax+zZ/le+xNPA+JKcCagC85OT+/oEuti3gghQlM4jOSYPlzZXNbXxCEIkwRl?=
 =?us-ascii?Q?j9yOPF1rCtwBmq5U9396BUPnD2iYaGdbn3YDC9DZNsZB5F16Nr2Uy5Ros59O?=
 =?us-ascii?Q?ysc/cTMYuXw1hS958TStVOIOEM7L04gYCkGQj2Z5/rGuUQ1BsbJmx+wBjHpY?=
 =?us-ascii?Q?v2omt1xsLZM2scQKrleflow0QBiQgqqHwv9wErmNHieGKXycrZQShQWWerCC?=
 =?us-ascii?Q?N+3dttD7ak6pcNd1kS7ln5agJgwuJ8IeNtOxs12n3D3NPfIzVbRDsnbLEtoO?=
 =?us-ascii?Q?Kat4PWi67ypmrzJG3n45Vpc8bGWEXoQhMyyU04KkSQoxIDv/e9lrfhBdr9uk?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gOgfyern4hhUT4Erpn0LJN632PTxOPxv8v81hJbLvGOuz7KQoI23fp7rrS0qraw0GeOXwW4+Tj8a6ZawHQz7LRcB/VLbxf1thClG+haCc6YKhSwsL+q7XFtkOTvZZbKfbrGlhorxeoBG4+d+lTL+hPCwuGSH7/cBCnRWMrtd2NeFeUiidcZVmJ/ilXdyJky4mZq38RTIZ7v2YvNin02D5AgNbh6N8zAzvcN1lo+HAbOv9j72HNzn3VOn4XJeXbuSt7OdYzEAZ5VPOF/15BWVcs1qyJlBfr+RkhiraNwGLw8yQ0Cm8nkuMmBFMz4tQ4uiNU2Eohngew0utovNzCrzYjx4vHmHMKeRE+MfTDG5ldZkEML5iTGS2XYwJrFu8k+dcQTa06syEG2W8vZNjX3jD1O9VQaXtQJD/0HWJxrzE5nUz8owmgXBzblf91ZIx7T/uBbvBEjbihPSW8DcMhhwTZCnIxH6psmUmHg/EobWVh6FNsKI5L4k7VHJRvR/zdOz0iA6NeJjK89D5XNixlbd50WhQi4sQ9JLnqyOzIxi/MJpF1ntDn6j1azV1EwTKUR00pBnqgz5thOOC/KlayKtiDYseIiw5ZKAIaM8VvJze9rh75wF6X5xHVx8E3K3usBThgiW2ey37Qqm/Nx0JEmsoz41M1Dax/7Hht61xz/Ft5rERSEi2RLtPiKhMIh/HA1AqWVC9+YFFQE7uxJuWCEw3mMzXZDlIM4PhVE1V3Dlkegj1Vi18WO+wjmm7zDbpP/gu5tJTCfaBIZfK+pjZ1UlHlSPeviFluESofnD9vnyNH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6bf54e-bca3-4fda-0a65-08dbbfbfaf0d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:10:20.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QVZeXDM9aacHGYceA9LSlN9HpONY8lS7oEU9s1PhMpcrJEGMLtrEFlBDICvaxwKUt58W+yitSeKmkycLcIqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280008
X-Proofpoint-ORIG-GUID: 8qe4BiwgUUxyZWqhJdCzDOJdG2xiGG69
X-Proofpoint-GUID: 8qe4BiwgUUxyZWqhJdCzDOJdG2xiGG69
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Guilherme's previous work [1] aimed at the mounting of cloned devices
using a superblock flag SINGLE_DEV during mkfs.
 [1] https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/

Building upon this work, here is in memory only approach. As it mounts
we determine if the same fsid is already mounted if then we generate a
random temp fsid which shall be used the mount, in memory only not
written to the disk. We distinguish devices by devt.

Example:
  $ fallocate -l 300m ./disk1.img :0
  $ mkfs.btrfs -f ./disk1.img :0
  $ cp ./disk1.img ./disk2.img :0
  $ cp ./disk1.img ./disk3.img :0
  $ mount -o loop ./disk1.img /btrfs :0
  $ mount -o ./disk2.img /btrfs1 :0
  $ mount -o ./disk3.img /btrfs2 :0

  $ btrfs fi show -m :0
  Label: none  uuid: 4a212b48-1bec-46a5-938a-783c8c1f0b02
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 300.00MiB used 88.00MiB path /dev/loop0

  Label: none  uuid: adabf2fe-5515-4ad0-95b4-7b1609218c16
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 300.00MiB used 88.00MiB path /dev/loop1

  Label: none  uuid: 1d77d0df-7d92-439e-adbd-20b9b86fdedb
	Total devices 1 FS bytes used 144.00KiB
	devid    1 size 300.00MiB used 88.00MiB path /dev/loop2

Co-developed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

 fs/btrfs/disk-io.c |  3 ++-
 fs/btrfs/volumes.c | 62 +++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a970da7263b3..04f57d8368c8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2399,7 +2399,8 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
+	if (!fs_info->fs_devices->temp_fsid &&
+	    memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
 			  sb->fsid, fs_info->fs_devices->fsid);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 39b5bc2521fb..ea4a110d7753 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -554,17 +554,64 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 }
 
 static struct btrfs_fs_devices *find_fsid_by_disk(
-					struct btrfs_super_block *disk_super)
+					struct btrfs_super_block *disk_super,
+					dev_t devt, bool *same_fsid_diff_dev)
 {
 	struct btrfs_fs_devices *fsid_fs_devices;
+	struct btrfs_fs_devices *devt_fs_devices;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 					BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	bool found_by_devt = false;
 
 	/* Find the fs_device by the usual method if found use it */
 	fsid_fs_devices = find_fsid(disk_super->fsid, has_metadata_uuid ?
 					disk_super->metadata_uuid : NULL);
 
-	return fsid_fs_devices;
+	/* The temp_fsid feature is supported only with single device btrfs */
+	if (btrfs_super_num_devices(disk_super) != 1)
+		return fsid_fs_devices;
+
+	/* Try to find a fs_devices by matching devt */
+	list_for_each_entry(devt_fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		list_for_each_entry(device, &devt_fs_devices->devices,
+				    dev_list) {
+			if (device->devt == devt) {
+				found_by_devt = true;
+				break;
+			}
+		}
+		if (found_by_devt)
+			break;
+	}
+
+	if (found_by_devt) {
+		/* existing device */
+		if (fsid_fs_devices == NULL) {
+			if (devt_fs_devices->opened == 0) {
+				/* stale device */
+				return NULL;
+			} else {
+				/* temp_fsid is mounting a subvol */
+				return devt_fs_devices;
+			}
+		} else {
+			/* regular or temp_fsid device mounting a subvol */
+			return devt_fs_devices;
+		}
+	} else {
+		/* new device */
+		if (fsid_fs_devices == NULL) {
+			return NULL;
+		} else {
+			/* sb::fsid is already used create a new temp_fsid */
+			*same_fsid_diff_dev = true;
+			return NULL;
+		}
+	}
+
+	/* Not reached */
 }
 
 /*
@@ -670,6 +717,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
 	dev_t path_devt;
 	int error;
+	bool same_fsid_diff_dev = false;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 
@@ -687,7 +735,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
-	fs_devices = find_fsid_by_disk(disk_super);
+	fs_devices = find_fsid_by_disk(disk_super, path_devt,
+				       &same_fsid_diff_dev);
 
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid);
@@ -698,6 +747,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
+		if (same_fsid_diff_dev) {
+			generate_random_uuid(fs_devices->fsid);
+			fs_devices->temp_fsid = true;
+			pr_info("BTRFS: device %s using temp fsid %pU\n",
+				path, fs_devices->fsid);
+		}
+
 		mutex_lock(&fs_devices->device_list_mutex);
 		list_add(&fs_devices->fs_list, &fs_uuids);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e485e6a3e52c..5921fdd3dd90 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -364,6 +364,8 @@ struct btrfs_fs_devices {
 	bool discardable;
 	/* The filesystem is a seed filesystem. */
 	bool seeding;
+	/* The mount need to use a randomly generated fsid. */
+	bool temp_fsid;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-- 
2.38.1

