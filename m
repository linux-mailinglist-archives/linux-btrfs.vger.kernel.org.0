Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139F97B103F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjI1BK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BKZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:10:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDBEBF
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:10:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6YBt010746;
        Thu, 28 Sep 2023 01:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PmpBKVy/fPLCR29+DWO8uHlk9aqabyn2g+13qizGwvQ=;
 b=fwivq7DuT1sBBvW2WpAypKlzPBG1XkqiutIJSf5D6dtkQB1vkXp6zqTKsuz0cniuRKtz
 oSYKckybIAb1oPC+LCpms6AhMbMlZ6m1Np9mKFBXRYN/5f5fVjvlIB5ZPRjzoqJqBHF3
 iu+O4+czCFp/wXcZXuS2KS+7k8196il8vbi209/iQqMoDI+XdOZ5u8koBK0ujEioCXfF
 d/k0Vx3ceZACg/yRwsQTKto8y4JsKr6R2Q77LiuGZEkpoGDynJBERdTCFnbwyWFuBn3Z
 OjASlCY1pSFmWgbiIDnmYzFk0w86LuIlh8gBRBU9abxlfvNm1R9gVDminfECnGibBcAR mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dk55b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:10:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMsDIn030859;
        Thu, 28 Sep 2023 01:10:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfet5j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHCoZj5J5ZokOYDUwzkHKrcfvZoP+92mU+tSZSKn6Ld/oibEI2yUE2EULzL9H51EUIdX/0Dfvd2sa7WgK/NFmbL9HaAQrtlRCBAWNG+Wz464NoQuS8yIZ6S2xMwYejdv10l/RjvQjvRfXp9FqKPaw6lkhyr4h8lGukg4Xe60smrejzobOo5dqjOdhtuVLOn/2tWHptMZ/WwFu4yj0yp/LrtUC7aAJH/KF4G6Gh1sXv6PvCQ7dCtgHvKtbI9fPzUVCL8MJcjY8v1Y/71RX1o3V92cvImCmXNtShHYJ8l/uDf1/qraKVBV7y+vv1E+RBUKSYRaXge06ui6NZS7B4zyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmpBKVy/fPLCR29+DWO8uHlk9aqabyn2g+13qizGwvQ=;
 b=h7h8U9lyXuzwxSiIlBJoU58fVOzYx66s2No+eoMsZSAFHWTiDS9wZWcmrCfATVzEnL3GOczjoxUwWW9OUrcSdVG1FepU8BPJTxr4eTYWO5ZUl44/55KfHjKc4awmY3mKZP+NT3r2cHPtYl5ehzYqt9ni5VDqWksmGUdSyZvmYdLelhKI2dXN3akSfR3eB3sUexUlJuVPSYmNoAs0sDWpixil14ye+oMMsoOTJmn478nxoeXyUvRWjbIVAcbM9CJdnKBJb11KUIYuzMqJeECundaZyNwn2mEriHtXDFwg+zaRG9LqvWC000fRseyWYNpexMBs64XVVNhUnhBkCWZQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmpBKVy/fPLCR29+DWO8uHlk9aqabyn2g+13qizGwvQ=;
 b=IPR5P1rCZmiZRY1DjkaFnFoaZbs5hFM4h53oUB4qbM4lZgFZaDJvAf65sC3I2nZmZB5otJdfYSBONLg99hvHRV/IEXoMUJqIo1R58zm77uB8CkURz+S/BoRP85NK+BB+9pbdhqDM5qLb880UhgwdOCTjDVl0uKgzRsTZL49vFDQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:10:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:10:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] btrfs: support cloned-device mount capability
Date:   Thu, 28 Sep 2023 09:09:45 +0800
Message-Id: <cover.1695826320.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eeb02a-cfd7-445f-93c3-08dbbfbfa8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoYzHgaBN8U1uwoMBcyYQ5ui9W4huZJ+bFmN7TQTYok7FbC12EdyKVMiPZxBNz647vAzKIkXK6OvG4PrUi91Kxk0LTah10SY8wJoT+QKl8FSRz3XXYaX+yVLA4kW/bBi5pKxTihVcV5m8k3KefSHTGxhRiQoYAaaEJyeBx81jxx1ZXsC4U2RnZ/Y1EJAk5POYH0Y4sJIPhj68bS/mZL9xrUjvVq9323/GeJxsY06nJaWUM2EI1bg52jiynh6g4Z0c5OaIrd0XB4OyMta7JIKXWqKRk63GiRttHdRfysoXmBY56iCHyI5MFA/jfHGSfPPNlegtFqe969KyVI32xGOxtuieC9BZRoKWHmQ//pxQLA85DkR/9d9RmeL/3pahRj9kGzXlDBJCBXZu8e6vzVFObcbeOa6Cg7KelKOdO30glQnX/qWXvjMNfVufJBSGP++jkieWzaQx9Yrdo6V2uwi+V/dmuOToUyT0gTY0VTsxaP2gm/L0r23BDTKdAyYg6BAVKVHYqWVtGJTSeqrGjP9W1xc9WLAq7czFFZhYOX6osg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(2616005)(83380400001)(966005)(478600001)(6512007)(6666004)(26005)(2906002)(44832011)(6916009)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(316002)(8676002)(8936002)(54906003)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1vGx5Ip7sGGLJ7s14SaKnGEkKo9HKfupWOUosXslA93ESdhPNbpRl5JtxsK?=
 =?us-ascii?Q?nciWOU0gBpTVeMhGC5/O+ehz6Mu8mFpnn4RhULI2oUPZzpI/2g0kOfehf1x0?=
 =?us-ascii?Q?ZS48FNbXsqClIiFosDlDIj+xtmeKI7kxWqXB/6OI1KG63Sob0iPMjfBG0+y/?=
 =?us-ascii?Q?a20iLvJJ76SvUriPxrE3XT2vRZZsvdXl/fA2bzXxiPoUzrrChVNXVCTIge0f?=
 =?us-ascii?Q?jittrNL3VOJxYxznaJYuRR7rsbYf1EYFpUsOddKLQa3NGc64NK5x6Ip5QtZY?=
 =?us-ascii?Q?Gg0pTnytLmMA9NZQPX1DXHBn6qNo9OO/OY3BSfRtNzW55Py4V6UxAY65i2Oh?=
 =?us-ascii?Q?y9OQ0iAarMD5RGgutZ40Rlq+WUAdKyq9ZXZebHiOSL4S9lJw9jHbjwKDOZiw?=
 =?us-ascii?Q?eY/kHfvKfh4qcfoddQ7VeIxAC+1+H0ivXs58+t6LeJUbjVl2Y0YvslfGDmTo?=
 =?us-ascii?Q?K6WNqq0dV9vvD71rTIwoxwjRNH6iQXNUMudTyusega84TWI9l2dBGKnU6KEy?=
 =?us-ascii?Q?dVn2ASiS2WdS2uufSwj99Yyk8VBW5KpQgfokhkW3xR2+KXg0rD60uCUuie7I?=
 =?us-ascii?Q?csn3Qv01xY9Nw94ZLtcNGM27pqhF+asEG1GYYo+EZtYwXJ9+heub/CbTbqii?=
 =?us-ascii?Q?sq1uc3ot0DpWICYue5lF2uu+iuRY3XSRw6jzZXmfBRZQeLH7DyRhLULx5ZeQ?=
 =?us-ascii?Q?BCJ7xKJzKXNrJZmcsLbf/U8txCTdsWSIszPoxaonj8FqKlAaXIfg/Eu6kgdq?=
 =?us-ascii?Q?tXWinutd+gd1nh+SXJntmOdxmZF3H4gwbtwpT1cT5sMX09oQjp0dNKDA2r+e?=
 =?us-ascii?Q?DecJwjJrrzMVpqxu1CEGjav1L6bhl50e4SO6VEknXSfqalkNMEGMaGqOWQ8C?=
 =?us-ascii?Q?d1J109KFQ6Ej8eSIkRwzLx/GlLk9wThBepNu8+WRVUIB7MTMcv3/7kfwvMcc?=
 =?us-ascii?Q?h/3B1c7JPbgzUHTjHXPKLIE94agY6k+lksvNy8roPscqKcWGTK8IpcpE8Mbc?=
 =?us-ascii?Q?P3/VQOQvzcUOzBtAkUDhlVLjdFD3AciwGC6rKaMOu1+XMHH2+ZPHSWO9nKT4?=
 =?us-ascii?Q?C3K+F0ob007p8+eg6g/vp8qN8LI6LDKKOUQWbbhdXGxKn1SPctQ3EoBCh7sG?=
 =?us-ascii?Q?BaZCTMY9yiEcA1B6xciyCSPR3VvZZ+OOvI+CeV2vWPXZt/2aRrnt2D+znHga?=
 =?us-ascii?Q?6awOHtFkuexhAgpYRieVVO+cBXeP00wVWtFKh+MrqeRh8WgLJkorw1ImmkMw?=
 =?us-ascii?Q?VIw8R7M5M1G7gGv2wpf1vhDZUjdhr7waXf+5JXWnfmyBQKlJtCE3rej9q3AR?=
 =?us-ascii?Q?fsaVuDt3aWsIDJeoyTJQTr7Exg+UljzWXFOlgwHxv3iLexLdfuOi5TXKJZMw?=
 =?us-ascii?Q?/3GbftsnHn3JAYWHR0BqxOileu1TLDsSji/85C20vEQtRy3o9mrJZQyQ5Usy?=
 =?us-ascii?Q?WypKAKkr4+924cxfvd6X8Uu7nzHVBW/iEcFLijwex/EH1hMs4ndcXUIQoBml?=
 =?us-ascii?Q?ClaCS8kNgjXMPU6OGtqX7NJPvEKa9k3KhhuzfRdaIKKUO4XXcsnpXsI7XzmM?=
 =?us-ascii?Q?ZJnBZ1KQvDpJNS/NISHR13R347tl8r5SIbOYe+qWArvQh5xOas1+fOdBklK4?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tm/C0KTXHCY2GPBl8LV0TqCfCqH5e3CVH6rQpK69Sg7tWKBxQfD9KKDSZO2FWd10/tzPad4vxFV1YS3VnkxiABnNiNsU1AtjFmBgKRRiMvLml3odtBZGNHb5CRAI2lQIPk9TPr8tQBhSo35KqwkX4EQTZ56AcGaQGgNHEn6ntSbn/XTx2DJKxn3M5l6vnHDQEOnkmQWXff3gtClGPusV8vFoZaANQqyrLpGTpEEmcqL5HIPx/hEL6cZHmzw1sG25++Qf4YnPtRHgtwFz6kUjifMWlzqLj+oCHwVjBo2cOfOVXB+WS0to70AtjD3jibOUt6oM2fVhSche0jHqtLdF6foBVqxfkbHjkd04jjAyRUTmsfAgKWeDPIdebqbnHpp6Z11GKvzmYaFPBKwpDy3zgGllxhxwCH4f64yTPeMW2982iDUfiN2PbRpiz7Sgr4notjRGRmqvyx+moXL16kiHA1PaNKoSMuw0dovmrjxEu0g4qG3zw5TsJ/ptqrDIR4XBWonkLx1ZFJ+WnaVahyip1wc1hfhDs+yoA1/R8rOFlmQg6cI+VWLj5q7fNc+SoIfHmwCWclU46JbGjPYmHVhKdctrCMXpKKjvoSeAPgCk+fnueoPQ+K3mTfM4e7IuaabKBo3/N+sk5WeEW0bj6jSANIkjqq9CpjIzJVrzGlDJ836C7ixLt4tQE9EwBm3TvCHuY1aQdQQOoAlSM4y1wworG2vP1qUDZPXxp6dCqZdUx4hzmam77ZD8YtDYnDlZDFPW4G2OgFqvd9TdJmEpZbA4mDae9y8tBObgHHvqf8nwdhXTtayJq0ankZSgAQalIYeg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eeb02a-cfd7-445f-93c3-08dbbfbfa8ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:10:09.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b5XzsYqojxd8hs76ri7yyiEuIsgOWvpiUqMnzxke4o0wrBgZNA3EnleXAleWfWjpkyHdNktmxq1KJna9mmzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280008
X-Proofpoint-GUID: F1a6iMi4J7b92P0Bq4z81K6RTjBLyMVX
X-Proofpoint-ORIG-GUID: F1a6iMi4J7b92P0Bq4z81K6RTjBLyMVX
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

Building upon this work, here is in-memory only approach. As it mounts
we determine if the same fsid is already mounted if then we generate a
random temp fsid which shall be used the mount, in-memory only not
written to the disk. We distinguish device by devt.

Mount option / superblock flag:
-------------------------------
 These patches show we don't have to limit the single-device / temp_fsid
capability with a mount option or a superblock flag from the btrfs
internals pov. However, if necessary from the user's perspective,
we can add them later on top of this patch. I've prepared a mount option
-o temp_fsid patch, but I'm not included at this time. As most of the
tests was without it.

Compatible with other features that may be affected:
----------------------------------------------------
 Multi device:
    A btrfs filesytem on a single device can be copied using dd and
    mounted simlutaneously. However, a multi device btrfs copied using
    dd and trying to mount simlutaneously is forced to fail:

      mount: /btrfs1: mount(2) system call failed: File exists.

 Send and receive:
    Quick tests shows send and receive between two single devices with
    the same fsid mounted on the _same_ host works!.
    (Also, the receive-mnt can receive from multiple senders as long as
    conflits are managed externally. ;-).)

 Replace: 
     Works fine.

btrfs-progs:
------------
 btrfs-progs needs to be updated to support the commands such as

	btrfs filesystem show

 when devices are not mounted. So the device list is not based on
 the fisd any more.

Testing:
-------
 This patch has been under testing for some time. The challenge is to get
 the fstests to test this reasonably well.

 As of now, this patch runs fine on a large set of fstests test cases
 using a custom-built mkfs.btrfs with the -U option and a new -P option
 to copy the device FSID and UUID from the TEST_DEV to the SCRATCH_DEV
 at the scratch_mkfs time. For example:

  Config file:

     config_fsid=$(btrfs in dump-super $TEST_DEV | grep -E ^fsid | \
							awk '{print $2}')
     config_uuid=$(btrfs in dump-super $TEST_DEV | \
				grep -E ^dev_item.uuid | awk '{print $2}')
     MKFS_OPTIONS="-U $config_fsid -P $config_uuid"

 This configuration option ensures that both TEST_DEV and SCRATCH_DEV will
 have the same FSID and device UUID while still applying test-specific
 scratch mkfs options.

Mkfs.btrfs:
-----------
 mkfs.btrfs needs to be updated to support the -P option for testing only.

   btrfs-progs: allow duplicate fsid for single device
   btrfs-progs: add mkfs -P option for dev_uuid

Anand Jain (2):
  btrfs: add helper function find_fsid_by_disk
  btrfs: support cloned-device mount capability

 fs/btrfs/disk-io.c |  3 +-
 fs/btrfs/volumes.c | 75 +++++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.38.1

