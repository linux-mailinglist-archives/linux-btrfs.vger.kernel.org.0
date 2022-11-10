Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC7623BB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 07:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiKJGVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 01:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKJGU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 01:20:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61362A40D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 22:20:54 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA6BxrJ000533
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ZayTr0g0iciHzMOIJkqM3/GCNu4BzdgyyZZfKh0kocc=;
 b=MlWkcn3Xg0ag/9UUoL6elUgGk1JNKh5JmeeLaDxy8ACl2iiFur2WVQBOXGKFJoQ2ssF2
 Cg7RVRcUWTS5SNOF/RnCm6yS8cDI84CzcPx4Z55CqaQjyMHD33vXFePs4UdG/1p0wRcD
 3aFxmWJWBBAJZDJOuxsuVHpaa08bgK+XafGPS1fAF302A19zEtuDKQam7P/qoum+Elxg
 D9kafUKqyeq2fVR4B68FHEcp59PUVNloywPe//mfin2O6DfBsoJGqKdIpH4AqXxEVqpF
 fao+OTvvYAinzFojkZuba84Kw7Aig2dUf0YCDBv4OUGEL+6ewIThkPv7d5Fjr+wxLgHk hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krutr80h8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:20:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA4NS6c040814
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqjhu0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 06:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxFjQda37piLXleb6BUYB/y0R3LwqeFcOHog1ZJIjN+KulDbkG7/yvFVU2iodLAUBZH7lpHGiVw3IjTgMMEXN/tm9ImWOLwURotck/CjpM5Isof9N6kv2uiEos6Q3615fl+ogju9rtCxat3U305oSvql64o1s5glyvHoE1mJS+NA/AtepsuWKLbywjRaEBb645gROwOFvnOB6nXBJStKnnXcA2BFK11daWInGOqEuDQ2x2pmfitx73E/ndqHQmn5m+4JBLfVIIqz1X6+IF4Pdku/heyxhaYLOhuklJBhSg7l73PHbaIXV85VN9ty0uZ+vdMu2gE8Ou2NKGaRZjL3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZayTr0g0iciHzMOIJkqM3/GCNu4BzdgyyZZfKh0kocc=;
 b=nEhIwgS2FkwI3dAGcfJJXSt21HtMvinO7AvvZk17tcUaTIXJLspwI9CgDg1rORLsullJnBPhWWKWHnGTMGOVffOBYl5pqQGbYEIVzlVfg+M6x2aMmGDxPm+kzap7XiTfYyHKHRg+gDrHu8CGExSpfDKFnDd6FaeGM+34SGi0DX9aZ3ubYOIhbE9NW8tkZ/Z8Kh6cm5+9RLDGmvYgt9Zn+FSUiuNcX5WThuVwVOGZr/X+n4TQ25WtOcTCETNtFJglpNit/8pc8jFTSaE8h9E+GgB87IANdMG9w7NM+xXOcl+LKjHd4iqrWHauc1tK8SbfskOb+wkULWViz6b73cYq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZayTr0g0iciHzMOIJkqM3/GCNu4BzdgyyZZfKh0kocc=;
 b=h8u0i9v1DnvPZhVOvToLe5GgBMe5TL0lbDbQ+6pnVaIY4t8V5g+0L2ymkDi68p5dNKPF7ETvlsVR0qRWtFkojXEa++o9u6Qak53c058huEi98QKWg9m6Sgv79Yq/eA/MNhOBlRTsRZmWNyIh5oXPMWeBjxCMX0lE8OuKzEBab7I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 06:06:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 06:06:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: drop path before copying to userspace
Date:   Thu, 10 Nov 2022 11:36:27 +0530
Message-Id: <cover.1668056532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4bab78-58fd-42e6-67a3-08dac2e1baea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwQbJCOobexbA1jGAtdiPapnbWl9FHZeE+gXx43Te2BvBaEL83You4/NZu2DFrpdsexztNRreiuf9Q+snQuSaeTBuynn9X6u2ZYTuHd0SCr9PsJRufxJnrusHjxxAC2l+qLYtLLP3KqlAY9GSwdnYROBJgG27wym4BaLUfNO9JqqSrn9x3EqblZD5IY5cPQiosHuBkPl9qDWi+jZ+Ucw7GbKSnvwvkv/8x9ycBSq/VhW3U7Ki2TIeTGvjGXwR92cfmoeZSLgLPlffF2o8cGtjMmdN739TgWlf6Z700L1033RnkV3AYMFb3B16Lg7QXY5br40pAngCbu5JpFuyCAwrQmMVAe1sy0En4yFHzMqriv8p5MTwhtAjKAPab3YMoK7o+yGjsosKNeov9RXAYsLbMgtVi280hVVuFiujlAQhtN7lcZI9Bp2z27Cij4mSBOOFA2iqo37SHYy+5ZhllgavvAgR7ZvrffnAqUHNGtz2N4xWsrzZc0zRX5R/5zfBoiMUqoS1/2nZC9FAIJQ5IB1JXQcco4Z6FySYnpzrvk+lrN3/0K+1kYPYXqB2DrmFsxGCGTkw9HDiGnSSI+kwhsNCM7bIJb68ExO/yCXfpeKrlCxZ+ICpXRns+pg+Kjjx/bSaEZUNRVthwcySHEtRmVOhr1wg6ixEnKqu0Pqak+oS4YLKAHyf9xhwi9XPPNrnPmWhL45dyPm7LhP1UfYzdnX5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(83380400001)(6666004)(6486002)(44832011)(36756003)(6506007)(4744005)(478600001)(38100700002)(2906002)(86362001)(26005)(2616005)(186003)(6512007)(66556008)(8676002)(66946007)(6916009)(41300700001)(66476007)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7neYWMJRIvfS6etQh9+kfN9VziN2jETS7I99DwRkH9O4spAQhudaikW+hwF5?=
 =?us-ascii?Q?5U7sFiPutJP4gttNsN0UI0PSSPVITfxuJgEXFA8oKHSPcjwVS7SYBSz+EiEH?=
 =?us-ascii?Q?tv9tju1pVa/0OMbopigsvMp3Aaa30z1PAK5pmOT0x1z0rxWiTDL1SoYYfzOk?=
 =?us-ascii?Q?g7aaqfskjmhZ3+ybzVIM4gw4rHG+2UfG8FaT24BhE38p8j5cEwp+y1Tp4ymN?=
 =?us-ascii?Q?mmU3nYv1qA6P2F06j11iAiZPfnsH4SA3D8q1rrf5dKBqqsge/6/BGiJKMGgv?=
 =?us-ascii?Q?SHpb5RErDjy/hx8R5HAblM9pp5vWlVVU+lXcF48obUFNKOZn9yvpd/8tuODb?=
 =?us-ascii?Q?vJZ/eUVbEMqvXti6mRDV4j/OQN33NsQHbdLlNdiDpjqUHvPbsbwqjYbVbAXd?=
 =?us-ascii?Q?UpbB5eY96wqpc8A920Ed/AxlNOenepGREVDwWO4Sk4NSz3NAfGggkrv/+rLo?=
 =?us-ascii?Q?e+0g/g7j3AZTe3kLP1/z2Par+ioU8E4yi0iqVIWhMuWU2Cgty4MJpu+lEdi6?=
 =?us-ascii?Q?48gkBiiwt4YpvHes/ZjRyM18Xg0DYP7tSiwy2n0C4/KPqrIEVFOXYNyabyLs?=
 =?us-ascii?Q?j4wYTVrNTj3dAyk273QYC9mz0k8oaLEiiEdSLUEopOinT++U6E9wk0fRUSXI?=
 =?us-ascii?Q?4eLWSzJwlzOa+1SVFsqQD4x/FZxddhTTRHLkEHnqoNNKw1yQvwQTGmaqGhZf?=
 =?us-ascii?Q?AT4cd5ZkJVbGlb1lv5lZQRNx64ar+Kp5Mf4N5R0CBmxgX4FkCrfLUKFe6XD0?=
 =?us-ascii?Q?aUsQJdEEhoXRx4T442+gviWYnsbnnU0hVRhbgiJTT2N8SQiHUTsXgwkQ+ctO?=
 =?us-ascii?Q?CPOOcsVjzgVHaH5ZTGTfhDHI/ppPvUMT/pvg4mrvTFz1mynZxWLi9R2c5Ztv?=
 =?us-ascii?Q?e7sZcyfVQwwVSCUf9eznLXQ4Kl7eSKH6zqiA6V27M19v1Dc1K7fJnn256+NA?=
 =?us-ascii?Q?+s2enEbXuaZmwTqEeR0QP+7PMWDBUWqcd13Hab7LZqWuiPpXGssGHKAZK9PR?=
 =?us-ascii?Q?YN2iNoIj4gtmnCwkpTsgaiciD9F/UwlIlXFnQY+t1B7QeTLwvrmSpj3f84iO?=
 =?us-ascii?Q?GTixQbiQAbZSmr2vT7gZ0t79HeRkAObBWKo71KNPV+Zv71hTv1XoDJ7pf7Qp?=
 =?us-ascii?Q?OlYVOVSUb8rA33DgYg9i/40yQYvCbFT58iBT02MxG5bjb9MWBYOAMqSFuG2C?=
 =?us-ascii?Q?n9xrcDAqCRYGdQ+1c3SurmMxz6PSIVIHV9gwb8xJaqGuk5KMezAesqi1Obl3?=
 =?us-ascii?Q?qALoH1zCayeWJVt3nU6cMRVYx5hB0hZ+f/Jci3hxNnngJLPDtg8Dztpv2DgL?=
 =?us-ascii?Q?FxEPXK3kQHVNpNpFj7pUgHwzr5HLyyfTkJ680e44rjSl8CD3ZPkMGFp4RP7N?=
 =?us-ascii?Q?cfEIgAA8qERYJXiLdAOMtZNny1EAoRub2bkI0fDmBnygXwLnnST427dVCKMv?=
 =?us-ascii?Q?sydOwhiGynlkeq38rNJv8MYTWQsNBp73kh/WVaGzlrOOp18DTxu1gvWulZv9?=
 =?us-ascii?Q?9Dd9IxxOHenv1oO8Q5q+Su65HfDe4v0SFROt8jzVWtfbYf0Gyv0Q343wJ1YG?=
 =?us-ascii?Q?/D7adIt27btt5TrlPTLXcrPPkhsfpaPFZRk488cZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4bab78-58fd-42e6-67a3-08dac2e1baea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 06:06:38.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNPL0GvE+IBnvo0cpmW6uX51kGioJRwDoBPX2C7X9U1j8W1P0bbd6fxIAXQrYVuYk8TcWHs/4Jn+EumseRh2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=814 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100044
X-Proofpoint-GUID: r8mtIxEhlGznuYZljGmF36cbHLpPOzQk
X-Proofpoint-ORIG-GUID: r8mtIxEhlGznuYZljGmF36cbHLpPOzQk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the ioctl functions below, we are holing ref to the path when copying
the temp buffer to the userland. Which can lead to a similar lock splat
warning as in the commit
 [PATCH] btrfs: drop path before copying root refs to userspace

 btrfs_ioctl_logical_to_ino
 btrfs_ioctl_ino_to_path
 btrfs_ioctl_get_subvol_rootref
 btrfs_ioctl_get_subvol_info

Fix this by freeing the path before we copy it to userspace.

Individual patch 4/4 is also in the ML and is different from here: Check
the value of ret to copy got dropped to keep it closer to the original
logic. However, its version is unchanged to match the rest of the patch
version.

Anand Jain (4):
  btrfs: drop path before copying inodes to userspace
  btrfs: drop path before copying fspath to userspace
  btrfs: drop path before copying rootrefs to userspace
  btrfs: drop path before copying subvol info to userspace

 fs/btrfs/ioctl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.31.1

