Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3587A51A413
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiEDPdP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352502AbiEDPdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 11:33:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45D45041
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 08:29:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EWHgg013502;
        Wed, 4 May 2022 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=v3A6MFZom4gVyxAD1o3QFCkKIJ734hzCUxRRFd1ySDM=;
 b=wvUUKvbwRdIoXGrFXy+ICtQLRr7r6nw6mrnZ2fzBYKYaOh/MvxqMmfXNhKqt44CAZSok
 eeiBG7V1OS8H9rDUbAQqZ9meI9A221QIqAkDyssp883F4tEEz8Mk7OcxE1eMd1JisRDh
 t1tRA6GLEnYSooGI3IVAOqszjTpS3i+LavBhXfW5o4X/bAFI+fnefmPDd0Fm4owxX+ad
 +x2PP7f1oRIL6kcIoBkuoeXyJuB+6ClOQfWa1umQ8m/CUDpbh+3UFVzHutSdIoWRVP+2
 K/4wLXS9qWbHd5hvVotu1u0cvABBKCObYdn6SsJI8t+xGXwIeMscx7qhogIB+MUv2idr 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsgupv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 15:29:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244FGoDE011502;
        Wed, 4 May 2022 15:29:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj3g71u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 15:29:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWfAytVtUoEZDAUILfTgy0Kg9mOo2tFwXkLzGlAYNeFbpq0P1P0o/Vgp8LBoJvYzUOZVbv0/izEZM4qMt+dJzsBcO6vHZsALhYNvmnmzg81MngnoMGtAexE4w1FouXOxKPvOqUlLGFuEFPEBPmsqzDVaY3pM5bdVDWLzBUp3BBA3pDIiARBC0RXSGeooqJ5bNOp1MwqN9By+T2VqFiRzXNFHIsJCDn90IeyIpSa27VDAZ9GZHJpGcDCl3DKzhuLfx1XhTcmShyzLD8PjWr7t3yeIQmdXMzYxEYFogm6atqRNOJJ+PxE2TahHk7W1A8X3zrZ8DV7bCH+5wYdUssv0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3A6MFZom4gVyxAD1o3QFCkKIJ734hzCUxRRFd1ySDM=;
 b=E17JNXTfhL/Wnfs/HP9zJP3tQ2BdYb7XImTVWd2SIuPQ/sdzL7qVt4oeUd8oByi+utihrGgHjVUQd4C+E/qHjYDd7z51nNRzvCrWJG37pU/yirrY6DawZyeGBcU5MwlcexV/1jepUfwNc7IK0HNsxmE/fojAQpUqfKXFBz0uUqFUc8p/G3oucpHyRaMWk3Nk2W4rWKzrWcXLOdlpCCYizAP2E6LuvwJWKPhdaZds6fUiNKVx39+LgSZj1g7N4elBxpIi6ZzL8LKdpTd1ZmaKsN3nc2P3Znf6yw274GYCAVMjlAi6TRfDv1tgSByqb0jrzjfgq5LWO5GlMHJCc73ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3A6MFZom4gVyxAD1o3QFCkKIJ734hzCUxRRFd1ySDM=;
 b=jWELNgZYSXXQun+xF9apUA7F2ACOj8HR1jadzmelRAVcF6oNnuSPI79Ls7TFLWOidW1ABlKwcsW3cMNb4p3B3E8bvoYlW3+wcO9KQdZUGxTfzlr6V+mbpa2bM1BTwKKYodu3FE+z3sc6HQ9ygrgQ0JWlUxrvSe0PMb7QiL8dMGo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 15:29:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 15:29:26 +0000
Date:   Wed, 4 May 2022 18:29:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gniebler@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: turn fs_roots_radix in btrfs_fs_info into an
 XArray
Message-ID: <YnKbzreg3dLw9QTa@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 048ac5e1-fd9c-4873-3d26-08da2de2dfb5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB442994DEC69CB8404974FA798EC39@SJ0PR10MB4429.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5Sk/ndY5rbqzkmI4hblsQORwKZiAB/RLwR6PoZrqzyrMELev3AjpaSIhp4JJQfv8lnKNyroNVRqTcYBzxa0Zxm0jRO47WvLcO9Xzprb88gxi7o7hDD1Oo+Ezqse6PgNZCMJXxJtfGiKikSfKjYoR+yFppBxdZHDsOk8XODvFX0wQKYWA1ov9FnqmZgbsRdKVQm0l45Dgrid5ygspbYXB7ioKO5HB5U5UIs7SIDmLywpMWk0rRntYd2tlWct4IwHTIm1RHqkbeVXV7RMnv/N2ABg48nSLVJJjBsTQmUQSSHrT5KFrf7BEcVN/hJRWxhCZ9ept2m1iV9GoROIOTaPV7C9i69w43GYGmWypO15ZRXToEkj8llYLQNXSy5g0UZbGlF7InBNKI/tjE+WINmKN2ZN0sx6mucmR2/ipp+gvuPEqC3DKFLikik+kLC7oJclF/IBkHrPT6tYARE09GRWF97Y1X521t0hoxK3gaoHmaG9nc2igJybkqhcUcom+PkBvLy4auR1fRcqnfDnbx6c1Rq7/vrrAd3CpPdMPUim/EjMZjj52GWFU/MnNqHusG5CKayEsXRpYFOaiUFa8Vks25H4JYtZ8mHfob5SorV7Grrf692VT5f1c2DcJT3kSDNgTuHf1i3wr+F1RXpoaup2GpD66xpJxHLcD5K/ouoBKYYz4CGVoCj4DdgG3cjc7jOO8Ym8qWaeNqd60UUQn1VR0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(6916009)(66556008)(66946007)(316002)(8676002)(66476007)(4326008)(5660300002)(8936002)(86362001)(2906002)(38350700002)(38100700002)(33716001)(6506007)(6666004)(186003)(52116002)(9686003)(26005)(6512007)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZHl91IB7S/YPA9KErfobSM32yWAPw+6/aGSYkD6zOsKnysanemGQqC0k5cG?=
 =?us-ascii?Q?VgF1Fe1b+cTxHyiAplVHnDNmeC3GTOIHfEZOj3LM4WhkHRsHYjejmvzl4L1t?=
 =?us-ascii?Q?qhDlhSiRotLri+pNs09Zk6/G9E3S7h6uBQKQ4Q9z5WGn+nrkCd0xvIJNOi8H?=
 =?us-ascii?Q?dh+UOfwgg75SS2bkPSn9otlDc0fYt3Qad+o6S+eJ32LRDvRmswGs0GXP/oKC?=
 =?us-ascii?Q?HJ9MQgrkxkPylp0mOLNCoaLhwE7yVlwstyZ1dA1qy0VEl1LtjIgTIh5X07f+?=
 =?us-ascii?Q?/DuwJ9vIHRFogaHAmbaomggLNKlPTjWNb3bN4CKMWIamxCxPO9l8EXKsA0uS?=
 =?us-ascii?Q?VMwXHMYOok+JB/woOC0mrEkclffhvydZWkNuRtjQqQhPcYU4Bwhvjr06kRBe?=
 =?us-ascii?Q?sJWE2T8G6U4klcxHcoHHBy9Qx4i4waxshqwRswDj9ZECprZMsbW1j3XHky2b?=
 =?us-ascii?Q?0KqZOHXgOwJhESoAwKpwGITn1vUZMS79uYtQNBOypYqO/d0K/tyC9SL9ZcUP?=
 =?us-ascii?Q?KpBhPq0qUpN3imrchLTwuNSsVv21+mwOJ51ZoOTWZV2cR4BSnSW2/GAx45fJ?=
 =?us-ascii?Q?sVgn7d+rUOFCqdK/mKGTJBQuvRGBtkXU7xL8k+SDq08VWHCpxE4fr8pYbylZ?=
 =?us-ascii?Q?5Jli13mRKiEXyIi2a4hMFYtIZFrfpqM03aa/goErYqUB3mqDV+Hi5APf0syp?=
 =?us-ascii?Q?Uejdx4L7WoEpPZYUoTx8tE3kP++jJxt3mxgKvWKBKAXPEEL5WmHsPw5ilyl3?=
 =?us-ascii?Q?tnE3GDtNF0+adWQXyXTSOODDPyk8ixj2bWmZIeFnr28ff5tL6XrVOdJMumbg?=
 =?us-ascii?Q?4bOloQ4q5rPGLfB0J+mS7Cjmf/m+vMHN+5uuS9XbW+CVQlD0uie7tcKTm9/n?=
 =?us-ascii?Q?QvMRdp5Rh61a777oO1aaaLgvzgAQ7rGCoJ+C6VxDl2ZONmF9gByS3OJzvw5H?=
 =?us-ascii?Q?e+hg8mNL3ryELZNDzEt6S1RgGRUq3Yjx9rJ+Qib0Yh1mMvF+ur84oLlsDbM/?=
 =?us-ascii?Q?b9I+2WLkPmoRRQUMuApx8G9gynJC/my3Xt8hTOXT9A3RqxvrVQph3d9XdGwB?=
 =?us-ascii?Q?qxllKcNlGmHy8mvcWeAiJKuWTMFi8UolfjjiM915aog+hjDuus/MiysZqn/s?=
 =?us-ascii?Q?5jx4L0EJ738ppaH+E12Rxg0/5WLxWh5WvNoYCsyFoc+rGDjH4qKCBnWvdjvF?=
 =?us-ascii?Q?T0d6CXAsAEfG84Kg1aXIonu+Yl8jSUVK0CUP6bLtZJO0A2hB4PlaL6IzWK5N?=
 =?us-ascii?Q?V50B25TRaPAo5VMf54/lxamK6Lf2EjTfwwgsSTXMyylpupL4wYP2Dc8R3fRy?=
 =?us-ascii?Q?L5ogpNQpTNd4KPR6P3OQzadBh0x7u86bUeuBSrO32q6HQliv95gHtk6SiH6J?=
 =?us-ascii?Q?8uHNY/h82Tce9GaeheE0LufxFzaxHADJcHz77m16nxKaVLsHxiPbso3VkOcm?=
 =?us-ascii?Q?HsQvz8HlpK4yWFKmWn/K66CgCykW5hnun+71qDQADpo/NBWc1BNzS1zilE9J?=
 =?us-ascii?Q?A8WKIUzho7IQfF1job6NYElnZGLTRo0F6XcuoTqouC2b4E22r044bTyQhJlU?=
 =?us-ascii?Q?nnUMDo2QdapZ1d36tRdt8qI/klivawnzljQGuyUU48mpgN8CD1frcNqX3lwO?=
 =?us-ascii?Q?Gu/Sv+G7KCV6Up8WA4RQ/vcdsnOKSbKFPzwlrwMh32hAEV/XMLEtDsJyU1rh?=
 =?us-ascii?Q?O3edICQ0tDEI+GaBYnYSvzGZJ6TaIS36UV6/gj78zKTfZMelk5+dv69/M5Vf?=
 =?us-ascii?Q?LSJQUkMCJ8Qhb42+wkGL23AdXYCvZdM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048ac5e1-fd9c-4873-3d26-08da2de2dfb5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:29:26.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAXQh3Fjxn+rU2rV2BQaT0893HingJdKIuU2ba5UU9vN9Jwu6yCQt1sV07CkOftEytZlUsxnyncRQRzJzdjJ/3cgMXOiybqq/MLrE8OI1PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_04:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=521 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040098
X-Proofpoint-GUID: ecKcNpwOb0EYSVq1uWAV1oSyA1dEyMxV
X-Proofpoint-ORIG-GUID: ecKcNpwOb0EYSVq1uWAV1oSyA1dEyMxV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Gabriel Niebler,

The patch eb8da5bf4831: "btrfs: turn fs_roots_radix in btrfs_fs_info
into an XArray" from Apr 26, 2022, leads to the following Smatch
static checker warning:

fs/btrfs/disk-io.c:4453 btrfs_cleanup_fs_roots() error: uninitialized symbol 'i'.
fs/btrfs/disk-io.c:4453 btrfs_cleanup_fs_roots() error: uninitialized symbol 'grabbed'.

fs/btrfs/disk-io.c
    4408 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
    4409 {
    4410         struct btrfs_root *roots[8];
    4411         unsigned long index = 0;
    4412         int i;
    4413         int err = 0;
    4414         int grabbed;
    4415 
    4416         while (1) {
    4417                 struct btrfs_root *root;
    4418 
    4419                 spin_lock(&fs_info->fs_roots_lock);
    4420                 if (!xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
    4421                         spin_unlock(&fs_info->fs_roots_lock);
    4422                         break;

"i" and "grabbed" are uninitialized if we hit this break statement on
the first iteration through the loop.

roots is also uninitialized.  This error handling is badly broken.

If we hit it on the second iteration then we are also toasted.  Double
frees.  I think.  (Trying to send emails quickly and then head out the
door).

    4423                 }
    4424 
    4425                 grabbed = 0;
    4426                 xa_for_each_start(&fs_info->fs_roots, index, root, index) {
    4427                         /* Avoid grabbing roots in dead_roots */
    4428                         if (btrfs_root_refs(&root->root_item) == 0) {
    4429                                 roots[grabbed] = NULL;
    4430                         } else {
    4431                                 /* Grab all the search results for later use */
    4432                                 roots[grabbed] = btrfs_grab_root(root);
    4433                         }
    4434                         grabbed++;
    4435                         if (grabbed >= ARRAY_SIZE(roots))
    4436                                 break;
    4437                 }
    4438                 spin_unlock(&fs_info->fs_roots_lock);
    4439 
    4440                 for (i = 0; i < grabbed; i++) {
    4441                         if (!roots[i])
    4442                                 continue;
    4443                         index = roots[i]->root_key.objectid;
    4444                         err = btrfs_orphan_cleanup(roots[i]);
    4445                         if (err)
    4446                                 break;

Imagine we hit this break.  Double frees as well.

    4447                         btrfs_put_root(roots[i]);
    4448                 }
    4449                 index++;
    4450         }
    4451 
    4452         /* Release the roots that remain uncleaned due to error */
--> 4453         for (; i < grabbed; i++) {
                        ^^^^^^^^^^^

    4454                 if (roots[i])
    4455                         btrfs_put_root(roots[i]);
    4456         }
    4457         return err;
    4458 }

regards,
dan carpenter
