Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352577149F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjE2NNi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 09:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjE2NNh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 09:13:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A2C7;
        Mon, 29 May 2023 06:13:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T7TWUc022451;
        Mon, 29 May 2023 13:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=grRziIHv2LAuM0wmQ0otnad3EvJu9z23/WZMjy5pZoo=;
 b=dZKuE7YwtwGj0itfdvQEO8Mt4h9rVKAZxythVbEF7isvXL1PprG2vsZLX8+xP6mN6pII
 9s138M2Z2WS9CaZVOE3IawQgt4LedZtGQtDfis2YW/vdog0k2DpyevLOqTcStStYilgf
 8U1ZdekqIuzG9NqkPA3Y8P6Mm7b5ug3ZU7RTrr8y7LlSQeUBDt0K3fsVfcXpOBap9EzA
 lvdmYpRuKFIPHVvbvlHiSfW5YqBt0NOS/fEXwVDorKWIouMbZ18r8AhbelLuxxMdl6jf
 IgEbgZoWCQexttYsW5LNEI2eDpvN21smjyn3GADF19Ja3psRPyDDlQXU370xGDXoDoBn 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb90yx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 13:13:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34TCx4QH030013;
        Mon, 29 May 2023 13:13:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a3bc5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 May 2023 13:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbM3lq03N4JuMInYk5W0lmBwRuSgQ8s/PWNVC3YeYjjJY9yY0IcvhKC8bL+KQznK+y5dKTwuzMdtaV4QO1fd6K2kSQKYrczxAKEagrqoWTzvEEpLV+ppySkv5U0+kDtB/xM+h6zHol4cDiS3yKy2NhrY12bvZ0cg7CaJTagDUQfCQurO9OARiSpWaLiL5UJbGxZ3xK1dJOhZ4w7yssBskA8q1K82FSg6upYk1mmtyXHmYUrZZ+9i/TZ3R2rSnRQ0cf5RDsSZv9Crt/Y3apTTPJboPmdBf/6Kcayd4TY8C6CghdmSK7dhzAt+CKGJn8/Qabv6yi1pTchCNRuGW3iwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grRziIHv2LAuM0wmQ0otnad3EvJu9z23/WZMjy5pZoo=;
 b=dnaR+FFz/bKCXvoi/4lzoRSIPh7wQNw0TiI6Er/G7VEx/ztMLBOIAG/ahXiEf+3zl7C+yk0eJQupHdd5NHiSzUu9B0VKHhaiKRCnxNBWyIF9wPRGP7/tka/urI9s4UZ6Up8Ki3LKbR8kHthAR2cA5eA4oJUnOCAE4epf48xjkkh79dbuxA4sxG0Ov2B3cJ9/Un1Wl5hHeZHnYddGzSR5VggBscb6i0eOjcOTaxafXsuGn7TvBXa5+oUJ/K2Edzm1oU4pIdixziJhdGZeJuTEWDF1T2zTTpfxVcSgyT8pgJb2dOeNJGeagE8f8N+IdxHaJ5joNuFER6DJvK5V6eujhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grRziIHv2LAuM0wmQ0otnad3EvJu9z23/WZMjy5pZoo=;
 b=evB0QkEiW0Jr4na4hoODLMumIAb3SU35S0kNu/eCm3eooCsLuLMa5I5QxyOTop3b7nR8j3jwxDd3hXKdo9W+/kEvAyCZuJ7wvASPnNRDkbKvyxxaj7QpwTg6tUQ2bPcxLyKjewbh/w58cDSsgD1vU8nqTp4HtE433YIY8Y683JU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4860.namprd10.prod.outlook.com (2603:10b6:610:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 13:13:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 13:13:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/122: adjust nodesize to match pagesize
Date:   Mon, 29 May 2023 21:13:20 +0800
Message-Id: <04c928cb434dae18eb4d4c2745847ed67dc3b213.1685365902.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2a9f20-9a05-496d-2661-08db60467e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nimhiKMOjmJDd4tdAbp2dVcq7/xMaYI8lPegGYjWP7wJc2TD2UWLjaaBnmjN1uaNBqPYEu71wsucnx/+vQVgyazG+2LNv7EEyAF9Ku3fUu0s02oAUhMgT5WSen5LVDPPnIG9/KLH990loKoHCZhmG04arHuyOrZ1Cisllu8sNlQcd0Ymz15U2MZzxWkY+mXMQ4lY/IGMu+pGhvz1BHCXyPRPBiD6dyhQZZdnrmGonX/3wIqFnmWcCpG2Fbuc7lDlzmK0s5llvj/bredjNSVGuS/fJHqdzwV//kNU/EJcXLwfTjkC+oPrlXQwWPNaXflAbcOZInqAnvDtPUqOKgPK7X9HejJFZrH6/2vu/ntzrzSlH3zfuRaLc/kfeVp1CneZuj0xV2UMm5PEP3V3uACEajPh/04graIIV/qxICafgsuElj3xeXAP9Wo7uvJCd8/5c1IrEoKc1hYuH+7lccm7eJh+ShBeZ2E8Eu3WfPWjpOxCfsLY2D43qv+LG523LdzQOfPds892uV6QOihvCMVDcIhGZAJZSz0WqLE0nhEb5ANQDQgjbRWimkpztdRLx+Pk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(6512007)(186003)(26005)(6506007)(6486002)(316002)(6666004)(2906002)(5660300002)(44832011)(41300700001)(36756003)(8676002)(8936002)(478600001)(38100700002)(6916009)(86362001)(4326008)(2616005)(66946007)(450100002)(83380400001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWby7moULFhLofw3PE2fW8+NUajkIaG1V1ogheMyZSmJVrh0pPFyEfrOq2gH?=
 =?us-ascii?Q?HooOaMhxe3C6CxOFq+7r9lClUJ/oDUBcvCQwlsLJiG6poeDjE0aIu3W5RQHr?=
 =?us-ascii?Q?3IkH16kznNKnF9bJ2QQ+JEckqNCCO6ngEVqnPOMJ1IUmxmDKn93DIqoofFmy?=
 =?us-ascii?Q?QrdCyvolyIWhgqRPkhBiNnyrP/hAKjrEZS1ah1dV34cCr+CSEpYvsmOKBXJH?=
 =?us-ascii?Q?bxEkCQhHDzS4nEbmXcidoEdLjeDGZ8UM4JeKCXV0rIG9VlNfanPFCwr/SWMb?=
 =?us-ascii?Q?v3ow1GST6ycclxU8oDkqhru7BG42FoAcS/IV3aCf5S4xVDYIzxKi5lnrEaQU?=
 =?us-ascii?Q?8wu18IL5+pwpLkmKM8oHOqajExPDWfNCRCZcOsIiTnv6wokFVS/FtC2/XNRL?=
 =?us-ascii?Q?8CMB3i9rP/B/7wnr5Pz2PUcjRKaCZpf9KU+my6Uq/qpJRyEOYjhNios7TGh2?=
 =?us-ascii?Q?GDahvPWdMj1x7S/RuDs2vZjnxkeI6GZeNkLadVEZgekKaH7xZdUY1oYYMIBM?=
 =?us-ascii?Q?06I1nd6vPtyJ+rzLNTvrxktn6aac3sKgo9FjGsCWS4bBSIw4a6ScrpgrhIJ2?=
 =?us-ascii?Q?mj3voYZY6QXcb0h7qgol3z2dGKiG34gVSE1lBr4W9OEPz4w5GcqtvH1nUiOt?=
 =?us-ascii?Q?jM7e8/C5foXx318JDnXNx/Vr/LK7Hnzhn/a4LdpUt76NvByGzhOub2SGtc+h?=
 =?us-ascii?Q?6EpshlHyUagS2U0brwGytzO7swVjLfYN3LCZxxDJeYqxxP7T+HDHhshiKiP9?=
 =?us-ascii?Q?3vWXu8CbPIJHPuKv1Wt81jwMnMmZtrMdKN6HvVAbdUurz94BJPP/VSPfG1Xq?=
 =?us-ascii?Q?87KdUl3tQ20KcSeyuEzjPYWxUyDgRoW1IMKjGegJ0cnJaSQLfYA3Lj4gf6Zr?=
 =?us-ascii?Q?3ZVa5Kn7WMxqWugg/RfnEGCaDy8c379T6ZGDT6puVg0wrhbCLiFMJ1zbTT9J?=
 =?us-ascii?Q?0baFQxQ2uHedjM+5AFE4+Id1rbJ/ByT3S4INWZQ9Voqda5ly4i7wyqon7gMH?=
 =?us-ascii?Q?EnqdpbyX/f0cL9l1PTXWV1aqJFBJgsmXhjGpcoIVTNnEWMZ9H9g8bCSHiK15?=
 =?us-ascii?Q?M9uaKGaVsS3ZCKN/ZUJIg0Itrn9+uAUyW17udIB6fbLWzBGl9+edpdDeSj0g?=
 =?us-ascii?Q?U0VLhNZX9gBr68j7L8zV5c6NuFQ/XH8/Gtl7PmSKeBUY1qlXH9r98az31DbA?=
 =?us-ascii?Q?sf/NzwZjYrm8Mxv9ubH6mMIRGQFRRSJs4Nb8xrqpaeFxakG3iRQmxHSobFLr?=
 =?us-ascii?Q?Wdk8n3mmoXtMT6EQw0Ot5Uf7G1fYOCMgoOiY8em9k9iXpblm1qvoKl5SzByG?=
 =?us-ascii?Q?D0Vwk2E3V/czxqFo4lSJv2S4+z656EGOEddAnXu0InGe5PpEOhKFI0lcJopm?=
 =?us-ascii?Q?I2ifn4MP5PxiME+EuaCJ3iwYZFVqTxSHwa40TrHcgFyLjlf4Cn8sWSGfVr5R?=
 =?us-ascii?Q?wqwsljrdDHGXwltSKf5RMVfagglonWHRC679ocmMJchdf7jLTLgs+v21lY+C?=
 =?us-ascii?Q?VYXvz9YjvOcVQI8VEt68fxzREoKg8tFZTnkG6YPkOYSDw/pR5G2moJRusRdJ?=
 =?us-ascii?Q?WXjufMVrYmPfvTwZBD3IzXVFiNMqj+AafY4bZjAS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UcJIQtRv+Hr+O0jQK/libaXW98ryrXoW4ky93MOOcWT+FnQYaiWnNxsGb1GNqfxHBooVsoziKoNgA7TYp/RJLZ9q+pBSJBK1t1JTcgDyEXdEtc28cJjYDY4UrM/kfBE2uBmymF9vGxKliVwMoKettBO02vWINHg+WctAmHAaXWedGJ+uNLEX7e0f8yMjZ7dO5UUGujTXJ5QSSzC3sjbQDvBEqtzeTKh3b5sSroSHaHFTcqmMM1YCwo8WjsBEVIB0Ksg4JD2nDZ0lK74ClS+V7eHvosp0fRe9dmY3r1BCNI9Tz+V+PPIGrWZYfc1Ps/ikOdCz+Hvc0DNFX/zYXgWK0FuhrkGur+RkaLqawsb1XFL9K+fAAdPD2n6aRoq2wn9lGUO965drA/EgpxRu/9eVmdP2mmVNg8XaL01mbl2yEsEKJHzgV57VvcMICdJ3yPI/OpGBIHSh+7NfTFC2P0uVCLVgrBa5dUgiWScnZELzr9+1drlCV7CrPgG6g2e5l7SENkruHc1QaEqXGjv+lPyK38orqnQwooF3cMmFWerEEFEul7ErOGktV7B3ziv8w7p9spkyuzMy0SOuAqbpNT0DgZ4us8+4AyebW8/XE3J44HE+0LkEWiJA91MtWDBErKiUvu/I2vSifLVu2jNrN8zh9fuZ/75BLhl48gRKJrS9uH04ELkBBd5YG5QfhNpP3myHIMmECSD6ze5j5uIplgi83Qq7xDF2PhKtJZRO6Qf2bxvYZ/L7UW7TF0IawGGbFOe8Y0sJkA68tXkjYyEWGpIX0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2a9f20-9a05-496d-2661-08db60467e40
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:13:28.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW1c38cLjRbUwOhlTPU0tB0j+5m7ynu1fYuisld9AXMpndvjq9wWDUh3lElSZU+SjvNsBJVP7Ot9WBhEwFokEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_10,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305290112
X-Proofpoint-GUID: xc2G5j_zAz2vPQu8xIb5M3GJhF4nY3xV
X-Proofpoint-ORIG-GUID: xc2G5j_zAz2vPQu8xIb5M3GJhF4nY3xV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrf/122 is failing on a system with 64k page size:

     QA output created by 122
    +ERROR: illegal nodesize 16384 (smaller than 65536)
    +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
    +mount /dev/vdb2 /mnt/scratch failed
    +(see /xfstests-dev/results//btrfs/122.full for details)

This test case requires the use of a 16k node size, however, it is not
possible on a system with a 64k page size. The smallest possible node size
is the page size. So, set nodesize to the system page size instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/122 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 345317536f40..e7694173cc24 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -18,9 +18,10 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
-# Force a small leaf size to make it easier to blow out our root
+# Force a smallest possible leaf size to make it easier to blow out our root
 # subvolume tree
-_scratch_mkfs "--nodesize 16384" >/dev/null
+pagesize=$(get_page_size)
+_scratch_mkfs "--nodesize $pagesize" >> $seqres.full || _fail "mkfs failed"
 _scratch_mount
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 
-- 
2.38.1

