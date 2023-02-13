Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23769416D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjBMJjC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 04:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjBMJia (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 04:38:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828410400
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 01:37:58 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8O588011110;
        Mon, 13 Feb 2023 09:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kkfW/WKDUFbtBpLHBW8hbREC9x2wL9rczOtw/k67wQk=;
 b=hJG44mewxbLGZVtArLkfcrsqGRQWOvHwYFXubzcF+i76/oL985gcS50HHTt2qd46Xfe8
 YpDtjO6e7whzII38aZTX2tBsVyTzFrc2IFBggwTMSpzm0qBiSzJqN9r+3IpFlhH1QG2/
 yK1d1ZJ5zrC8/+hxrt59a8pdAlfvyPUuPuQse1v2VsRbxoWSi+b1NdF00u6sPxalyiHv
 AryblywUlBQiV+MUJY3Ea93bOvMPXkZFC5vRb6JtXGO9ClZBh+dK8x9oA82zSbAFK0TR
 +b4o7s0hE0JjM2BvndUQAnhhI0U/0OfCtnzgkHLYUGhold/pD5xQRJG0oN7EKaae7FcB +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtaahb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:37:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31D7Q92D028862;
        Mon, 13 Feb 2023 09:37:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f3k58b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 09:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCWPdlbhDSl0vTk7TbsLN1mTdzJGSG3fdIl6lIWcDPCXPilaSybW7/UvgbCbL5lSLKbQR99aNRLfkJcKww5z+bdMUWDude5p5wBocZvcnCTDjsndK/4WGsC3FibSWvz4kadc9DI4/JKx7G0dDgj30gKgibfkS8wGVl1xzAeHr43FRiw15W/kSs4URDU5CKDVXCdUNpyOpbIchmzWcAEntL9CXEEUqmYfrJwR9B6BqO7+pcUHyqiIoy6qBwmVi23s4/mUM9oyEDpwIVJjoUG3BXEu72hw0+h5hxoem/eDWGY5EXoabLHjOL2XLrM4UqIPApnesP/OxRfah7UsAdCnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkfW/WKDUFbtBpLHBW8hbREC9x2wL9rczOtw/k67wQk=;
 b=FtmZWXDfp31whbixUgOcnpkQn/OFQjYbyz4ljpIGxHkWOMefWvLp+r+1gfpFcm3GZMqVr0I7GcX8rx9Cv181QQNDSiA72UKlaD8IqcjoP5qHb5vnmAR6urgV8/b8he6gas9v96tnD/heSEsKICGci7qgXcICCfd+BzpZofSDBKnWKXFsHIbIqf7uIVovQT3kO/S6UJeL2VdvNVOynhny1VEUCmOQyfraXMCaZiUg+uZ+Zy2bprHLjS6k+RM5lwLQgkm2YdLmmZXrBE2ONoKAA0bXnECAj3atNcDvHNb3X5lXg4MqCkQyInwlgPwmFE0fsJhoGdUZt+e/6q9Z1HVHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkfW/WKDUFbtBpLHBW8hbREC9x2wL9rczOtw/k67wQk=;
 b=x4h7vu1VRyhUMPzsU8W2RMYjLEuRkHGilYPCiJvNK7QcXa3kNzNMqL6ReIQVxntdELiHNV7mzgVIEw4xclhnQ70AU1XEFzfRaTScI9JnlSwIW7khTwtV4bGHLRDRgTZ8tsbQ0Z9pZeAP/wX4SFFrWU3A8uypravhyJWp/nKoztA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 09:37:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 09:37:49 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
Subject: [PATCH v2 0/2] btrfs-progs: read device fsid from the sysfs
Date:   Mon, 13 Feb 2023 17:37:40 +0800
Message-Id: <cover.1676124188.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f60e35b-201b-4ac5-29b9-08db0da5f8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wEFQrTu+yFbrQbou8QGONNWKXxLzrg6mTms9kefoECUGzFRA/upSzUnxXIenEpRMgOf6+ZUrampCvnpsw+SdIRxlMAJnF5C18V5UA4yhx/xR9JvA8xW3xHIxYn4qc6l171510c3MKDm/EFBS3+DCYLf9zHea+Y02hxpxSE4SqsurjXUTSkCs7fVDIFsikARbpKfD1UGWeXA99Iwikloa/IRKVNvHuK5y5X4r22wt2LZ1tNSQFvyEUrSQc5TX1ZWOwgTFbiH8HwnZrnq8DkJYfozlnISs6EC9ufdTYHNXSTCZWvRpfjqnMIYsSIPFhryjMv4Ntg+bTUewF5IBMTu8ADK6GtJ//ixptqIYaWEd3WSBudv3gSlFEsviY26w0JoGfdTj1e/BnglQ84gbZM3DS/4zMW8Bl9M03SWOgxzowqHkr0AjUytbUP6UTuBN6h/MRWTxjxqfZX4I/yBVFJmqNqSFN/grGZu+8VzP3r29hxSwjRJTJZswBXnv2mJ2rvk0LHO4eHSnXaHrObcGuRPFIMRVoMD7u+7nMyfTDQ6o/6YFCVwvic7xvOLRqUi56zjYNNf3aji9UuW5Sdogklrb511VVkv25fk8LTjxS9vTCgFf1LJH5JKTrMWm8vGJe1QIt0dXDMpNOvlK0Cs6ypjFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(86362001)(36756003)(316002)(4326008)(66946007)(66556008)(66476007)(8676002)(6916009)(478600001)(6486002)(41300700001)(8936002)(44832011)(2906002)(83380400001)(38100700002)(5660300002)(186003)(26005)(6512007)(6666004)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psApnE2kLfV9V9k9TYQ99YaXCoah+HIZKomQJaSzTbQ3q3iI7XNopS7UEJy2?=
 =?us-ascii?Q?VxVDA3VqADr3YeuqpSFj+VQJsG8jAoFbzcrC7lfOMFye6SfhiQlz2Sf1iqV6?=
 =?us-ascii?Q?ZaFAMntXHCZygq40ddEaPfC9FFUwQk3PWprlsAAbQt3hdrEm3yU/uhdxJgZ6?=
 =?us-ascii?Q?ZPqXoROMFw0hQ4O/lxzSSQ0GM+WxurK8z+HTukliZf2No2D/PifhEu2wL2X9?=
 =?us-ascii?Q?yzBRJqhUdX53o9vMnOAmgWfgh/L0+1br5irSMMdhhOa1UNaHEYXR9s4jvQLq?=
 =?us-ascii?Q?Wc8bxjrfLBEy4HIddApVbtvldueuwziA+PcDPKmtib7J2IY3aYvw/5IYGWtV?=
 =?us-ascii?Q?pWteqnLHjb2WpRKCDt3lTtlA20bED0+vX6eZ6gyg04Ez40FlSERlpqaaS9Nk?=
 =?us-ascii?Q?r1njoEZr1T+RZ2nfIXWu0nM636ope/FJPChtPZ4fk0RayjU/4S3Xcm0Lrn1S?=
 =?us-ascii?Q?k2gLOnr38QE2xsXCNqkXeIK1m/UIAw7RwJ5LLOlTe7fWtPy3mvRJxaq8pi/N?=
 =?us-ascii?Q?yHMGHvVdmxHXv+g5rxKXCSwkLBQij0Pk+EoFcm59DuVw0Gv5vZWy8IJ4P2jG?=
 =?us-ascii?Q?bRkGQhYFJjxJDLsIyvHBERoz8TjnfeXWzjuijZk1mAcCRKzOo2RI+uaRa5iP?=
 =?us-ascii?Q?DLb+AUKMhbCd4eDWsfTrMfi3WYXRSllR4zTvDdx+oBYyu61+ylh3xV/3ze0v?=
 =?us-ascii?Q?1R5oym5NO23KQMuuemligunacoxOaeFDwwTQCv5CoMSblaCoS0ElUINTgLDP?=
 =?us-ascii?Q?kTFMOVn0z84NMjqxdz1FW2XiwN4NvdWdkTVBl3Mv3wy2L6YiGyInn8LcjSl2?=
 =?us-ascii?Q?5oD4c9Rh4Blqj3fK/1ewA31mQoBgz8URmTbmbhxoBZ+9u0pq6mqSOYBAIU7l?=
 =?us-ascii?Q?XVj2eSwOyz6BjKuLj2Av2vk9VL9M4FNXom8GhY8WBOohN/AvN/9t4lf3Tidu?=
 =?us-ascii?Q?mVzUjhOEb/E9uf+neuDyVejEwnzu9Pm4kcGkYozjzqpkKQU/nAw4mW16jYRp?=
 =?us-ascii?Q?n3lwP/2usaT5m79ga0BKjtOoWF0hiO7U7vb1j6nCLeWAfMAotFD3+yYGHFkv?=
 =?us-ascii?Q?W/Sl9iCbVueXo/XPnSrudsSXUX3xAhHStDbDaWqq7YT3/tQDb/ZtsmVwGbGn?=
 =?us-ascii?Q?NlzaLu2U7QQIZDm/QPXlyOvDYAED7XUrgL/VkEFgsjTEc8pPN2G0B7iEsObB?=
 =?us-ascii?Q?grUP+VP5bAf9Aq2bPQZFT/gnJWXq1TtJvg5e00UyQ8GK07i2NQlg+ptbkHMx?=
 =?us-ascii?Q?E2hppif69L5RYYNBxYosnBJdXPEeqOWiFnskcsTX6s0bm2ughFzkE8wtgVbY?=
 =?us-ascii?Q?tkf2XZt8y5vUVIiB3X2vLK+M9uh5Jh4J5AqkJlwXn5k3uA7TBLYbklZ7hFcG?=
 =?us-ascii?Q?iVnGnByP5NktnFqpKqbXJ/tR860nHiEtD54vWDDiN7cPMQC04u2w+VYrrufH?=
 =?us-ascii?Q?g9BSvG4bXLzaPsER/kXsplXz8nbglmxNzUJzgebusL5PKqxrdpHu2eWW6+FY?=
 =?us-ascii?Q?34jddS4QjGSbXuARWZvew3YVL30iCdNowMW/mfEYDStotVbo8bI947EujT/l?=
 =?us-ascii?Q?EIA5xsOmR9wpLV966RSttiZk4abNZ9gr+LBnrdc4k0UrfK0ajCexJJz3k24B?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b0h10HtVYqYxt25s8x7AOaZVRo8Pv3GaRMKupJwULjca18VqcAK6Bw1Qa1blZk7LpO6xPCkiGqKvjd5YcPlV28MUoBGwO9RQ48R2pkY+GevEswFFI2P/zBMUO2XZbStALzVrx+0/xMxS/JTHScvtARYuG4SlQ4oXqUoiJ9KCdux1C4u8R+a6ipcqim7+05B1y694m2nsQkJ4t3qZs70pBGKHzYpXW3EDnzj1c92WQsR6U3HElr8WChYuWzNdtQTRwc2jtzR7RNUZt3meAYpW0qyjqMS3Ao+Hut2lNpXUOhsHPXVLv4Mgj3ATpmzm1XFWWj+tXg64IptPAoSFSyj0y6oFEMTfyKccmcLXNn9CSWn1CexZV8BFiVu/9yVVl+ekBHP2axlPzYVQa32O+IhJSg5z68Qnb2vDYDI0APB9+p5qDudHQw4R/KTQ4Iq1DUNbA3TNE7G3hWyFZb3+vn/vOGab4toh/uP6FpxexK8f9vUbbEqokAQnxWUjzNSkukjeo02/R0zpcc0/A5k1zGPmEQUs2Yd7NNikS0T1ReaThd8rAuS0F1+780e77bwpkhWcp1qeOu3VYs1IqyOt9uV8wG4LJ3uIP8K8/V6t4jtI2fDwlx0S1vBRnNAFoN/nriNph5tnymTMEWOc/7mbGeb5URGFnElyXYO05MvC0KkKLXwlG3glPU+s/p2CnP6euOWgWFtMYqS35tgXWejXVmhGhxfJsS0HxaANEx5G28kKATn4R7dn0uCXvYkUMFPSexk0NKgoOE4IQ12wptbMWpRuRXNZSh/tWAGaTcbmBhtsSqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f60e35b-201b-4ac5-29b9-08db0da5f8a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:37:49.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaw7O8TVU+bpo2dfO0yVQ5w4Xhm70lU1UCLn3x2AL1+uZ0jgXJ21IN0cwb3nYx8o5HwRXZMlJsPACWBMScOaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130085
X-Proofpoint-GUID: OYFIBCCf02Ff8Y-X6IIPh2HgEJ0PlD_2
X-Proofpoint-ORIG-GUID: OYFIBCCf02Ff8Y-X6IIPh2HgEJ0PlD_2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
 Almost a resend; no code was altered, except for the change log.

The following test scenario (as in fstests btrfs/249) shows an issue
where the "usage" subcommand fails to retrieve the fsid from the
superblock for a missing device.

Create a raid1 seed device while one of its device missing.
   $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
   $ btrfstune -S 1 $DEV1
   $ wipefs -a $DEV2

Mount the seed device
   $ btrfs device scan --forget
   $ mount -o degraded $DEV1 /btrfs

Add a sprout device
   $ btrfs device add $DEV3 /btrfs -f

The usage subommand fails because we try to read superblock for the missing
device
   $ btrfs filesystem usage /btrfs
     ERROR: unexpected number of devices: 1 >= 1
     ERROR: if seed device is used, try running this command as root

The commit a26d60dedf9a ("btrfs: sysfs: add devinfo/fsid to retrieve
actual fsid from the device") introduced a sysfs interface for
retrieving the fsid of a device. This change allows for the reading of the
device fsid through the sysfs interface in the kernel, while retaining the
old method of reading the superblock from the disk for backward
compatibility during normal, non-missing device conditions.

Anand Jain (2):
  btrfs-progs: prepare helper device_is_seed
  btrfs-progs: read fsid from the sysfs in device_is_seed

 cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

--
2.39.1
