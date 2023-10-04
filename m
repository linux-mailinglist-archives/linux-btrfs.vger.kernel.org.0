Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510027B831C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbjJDPBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbjJDPBC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 11:01:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26742D7
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 08:00:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948inoq030749;
        Wed, 4 Oct 2023 15:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LJElxSmUQeNbYo2CbxY9YahVwEFkkONAeitzEz5f0bI=;
 b=J++J8dMvruN2Eadg+8R4ousLhg88gOeAcIigE58UVKfuXUHuwckkkN3DuGZRmJtj2Min
 CwEXLbcfaDc/Z5s1A8Iu5gtgSNmEwwD26fBfhCjeI0u2jktEzTmnYGAcuvprgd3XoHG3
 zE/gcNoXb/Xdolbb1SS9IYmTRQWl3zI+umK3KcVHerpWUIeadmJYK38lwYsNMH749ml5
 PVYGB7q86sxjpxxoT8v4eBmOlgQvhJm7mk22vE1ycsQ0reoP3moATUa/+0xZSQc6zTUx
 8ad7qOCPsV5gUgwnNd47hMrk/ZYubsnMk1Ym283FeHjU1EESIWBUqKPSmBtnb4LL4mly CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ufbga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:00:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394Ejnjq005872;
        Wed, 4 Oct 2023 15:00:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47r31c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku7QSgggCNsIh42YefqSnEkr/0G+GVfwHUX2ZIXDNYYZsBqqjNSu9FWvSE5V0zeUbDNvxthfNVewU1osagMnGAb//3xYYZy5xzCiE5/BsP8s3CfblhrkHwaMJf6EUl2srk5ikZ8U/kjBsMfEYIbSO5u7Wiusk+1IXh8E8sliwscsQS/Oy+Do8ooiWWO1rjIMB4dO2k0kPBq3bMS/D+Pk/Pzf8qT1RhsH4vONWJ3xtFJ/KeFD/j/4tjDAlwiaSxSDShTL5R+J0rR97npxAv+n6NlfothFjSidWXW1nB8zqpJSoFOWZyb28EvCJoeVeD1rNv/uyvtWQFFSqlC+hbtXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJElxSmUQeNbYo2CbxY9YahVwEFkkONAeitzEz5f0bI=;
 b=nAHoGSfB5LW1D8UfNEcRBpaj9cRynBlQlyy6wNVkpMhc/OOR2kCWdpQIpqThSpTdBemiUXBi19pybNZrP5VLeCI/xA7ahyynmrzAj06YlHpF89tKvaM2hWZ8SeH7n7VvylR/Bwb1De9HadSZasC9ayCrkR0vR39oKWTGmJsx/a9aJLrWa2h5cxXqJaFN71YycHdJQe7UeKrBo15zU309Tr9mPMRSOPJlP8obbb3qdonuUC6wfi6KBEywyLPUMbxyC1ft4MKMtOgj8Qw2Ar/PFauvLgKWGHSu5uVzgQ1DW6M8fYy5c+/Oj+Rouv0W7cDBy8+p/zlM1O0/wQ3eRShrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJElxSmUQeNbYo2CbxY9YahVwEFkkONAeitzEz5f0bI=;
 b=lQP+eoqO5GswLSmfY2AhkK1wF1iyr+9bjv/MLJdRRZ7NIqgzYs0g/Frw2pZ1VKKkQFdBIwZLliaOxyeTp/NLvqgs9USBumLM1F2Fekd2pJ5wEmg4pm/ar9x5etbE2/yRXqsORp8QPKBKGHe220aKprntsq5YuGukZR0FrNTUTHs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6474.namprd10.prod.outlook.com (2603:10b6:806:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 15:00:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 15:00:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        gpiccoli@igalia.com
Subject: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for clones
Date:   Wed,  4 Oct 2023 23:00:23 +0800
Message-Id: <cover.1696431315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 30acc69e-a603-473d-a52a-08dbc4eaad6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkMA+SSfGSONUySTlCkAdgsBV8e1y78wW1Nboy16vUBzUC98XqT15upCKhs0k0UvO3Ql5j351OslssFNQBBsUZZPInGUHIy79UjOjWh2AEe57rC7UiMNSoP4+nPiF3d0YJPaJ0w7TxlsHkUZLw0Yo+hMeKjqG4ZXX43ALPTiFC4BD61QmhQLQyWPGgcZD2j4Lrtc5TyYPXSJwBAA9P9j3hkOmXqfXGpMaRISa60mD+QBlogA7YqH0eH95+R1aWKanyLm1lf9IxQRgjFRf4XPk6PFxNFDgUvjNTwkKTaH9TsYF4wxSaqFOM+j7qU0e0cMwS74HpUksdxevSI08iVmWqoNgqY3YIMHgCOvdDQto6no4Zr5h+6CkrEB/q5GIpFEdmahMtYB/hmcNlhgeR8ZfUyzPpxd5p5GGPR7FbtboXr0qc4nVPBsaN4QXV57auQy1iLcxiv93FCTRyp+2lgdnx1rNV277njElNeFh15JEQh2ZKXuqZx/YHaoNXJs+ncWov6FWOgxRFvt1SIczKqGe4El3OrG9aCHsARNdYqYwyxGFWi0/5Fjz1R9eXc3DhQg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(44832011)(5660300002)(8676002)(2906002)(4744005)(4326008)(8936002)(41300700001)(316002)(6916009)(66946007)(66476007)(66556008)(26005)(36756003)(6666004)(6506007)(2616005)(6512007)(86362001)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j10DwchTq2cmkVzEpFOjlHd1REvGnkUGQSXuKZu0iGKPhBY5lX1J/w3qKV2E?=
 =?us-ascii?Q?2VYZGhDoDe9yR273OD3Rt781HkFIB8Pc7VDmuoQsMX7aHymGda3f6Cu4OTgJ?=
 =?us-ascii?Q?Kj38gsYhSAM+xa3XskJXk0kqCTl3imUGUjxLNj0BealqJvzL7YA9d48kx7yM?=
 =?us-ascii?Q?Kel/Oo7UkK9Pj4FcdCRV07V5Bis3AQp4xbQbpywFlIXovLgZUCtJpNTYHvED?=
 =?us-ascii?Q?l3Kg/4UWhbTuErtrGVm/U1HKtBHtpnYwnBn+S8FAZkTrbEPzKObMCec9z5lA?=
 =?us-ascii?Q?clNASqRQ8aYyiMqzWfH7DuvsRZ1T+IOqgCOPwQj/MpMmUBqV2E/yB9/MUtz2?=
 =?us-ascii?Q?vU25daRhJ0eYjJWeLA0ZrP+9Y3O7miJR6FcNbxYQIKCM7b0b11K9FGOBtjIN?=
 =?us-ascii?Q?dRNUrDJop31ZfU+hZ5wFV10ZtzUKEuh0qHtVB7IByLKnb7wFqUz0KfSbSYjj?=
 =?us-ascii?Q?9ZoSHhLad8FX8sdF7Te6+wvtQh2UmokxtYpAYTH0kJS0GPLxsV+VcGMEf8aR?=
 =?us-ascii?Q?Wa5xtZyIgWFChVrO4ftyr8gcKX04VH1cg/iaglv+KpbDbgvpR28ptBGrWRDr?=
 =?us-ascii?Q?qfvrIRfWEcNX9T1u2GJ3it1eIBJs6AkCYvAIF8CZQKnY2irM0KeYMxMMQtKX?=
 =?us-ascii?Q?stZnFUUkZjo73+GpJp3+gxrbB0aJMZIx3apwk6uVB9NGbSE/ThW8hd9kwWvV?=
 =?us-ascii?Q?/aSbsW3S0e8u5BSVWlgpITTbop7c7AvIXscisuhqizOOA0yzK2WyH0rbGLYJ?=
 =?us-ascii?Q?SHXneUGRA09CrByZmbbI4O838LOmQNy9AG0jO8UUrzlMlUGeyhSUBR4Ywbss?=
 =?us-ascii?Q?bnG0xfg2jWn4JPfEhrssdlkVToUnmxn2KrBbOk44vnRsF5M9NPHhJ+vDjGZ4?=
 =?us-ascii?Q?+L7+uM41YMD5yL5tKliaIvlB6Fy4bdKweLKCKCfONkXpMbe+QFztBuHui89p?=
 =?us-ascii?Q?sx+utWdWcYI7KZM+MZFQCgf5F9v63sj5RMChnGCNkK9KHnmbNIWAT2pH2HYd?=
 =?us-ascii?Q?/ylIGiP+qpD+Wh0y5QGY6IFbK/bZGI76maTMzyt3hGQseWGUQ5Jv1OW9R8wp?=
 =?us-ascii?Q?rAoyx5BPwOvLPQRpsr2tXfeNw8SS2nIzVJSlkGU+8kmR8eCSGJnQdrC4YFSp?=
 =?us-ascii?Q?yJSlJZTF/GYyYYYnmY9uZGlJdt2anGqKbOJ4f7iweujvsWZaLBUrhM0plSIs?=
 =?us-ascii?Q?BFCM+LRh3StxkbKURUaTBCJIqlf+JzJ0OaJ1rdPQrR+NGh+R/995m3mydEZI?=
 =?us-ascii?Q?kCpR2M2QP/IOGvJwseBCfU0k47yirnz6qEsvzMsmhbOD1Q2iOEB7PBuC4PEQ?=
 =?us-ascii?Q?SWFvJO+gw0Ws5y5E9T2p1hUzSZx65OvW5Y+WOd1XkKbg4Y70APj+VV5C0foM?=
 =?us-ascii?Q?B9DRji7Id4wlBz+OXyHHAgmxDFyAPYixUkvB51R2Pzr/MtMAlrg84mxTBgj0?=
 =?us-ascii?Q?o7iqJV82hegZA1qzUpq1JCJu98XDRoL1lw+QmoeWjKlWqHv6/BI6zhCgENdL?=
 =?us-ascii?Q?vw8E07ar9+d9CdNKI9oaLoWVCq+vLenImq3Z/tSE1kNp4XSD1xC+r1sFuPFG?=
 =?us-ascii?Q?y+mvdJtAxjibvPUge7kfYw4antolapPmm3JwEBFe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 58wiSlCzySAe6v9DCCAJH2hF4R3IzgTQvluplgD8EoqxPj/Qj/Jkb6d6ftmN2srX2qMG1JqJz/GHeiWJTRR6YAX7aC4mF45RgEPkf0UsltMmb1nTf7ieMan5WlK2MP5xM2Yk9fV88/Cw71LGexE2/dWAibnuaCEcG0Ui9J3BPZLvBa+my2/R6V6T1rgYxPPiZNdaOkUOerrjlzMXZY2vPduOzDrp/9Dy+1WckqhS7NnosEfnTRbeoad8TwhJiuierkEwo4LJu8thTKSN+shIWO8+sEmn9s8ybuopcFlAsec89wWK8tV06ptIbS0+GZaebfi4eKYb6FYZxzgOeZEUYpydyv5CZWmT03Nost8i63eaxAH3t9ivQcmvJHfFRKCf5q/PSQRVqzPLtCIvUAztjfTB8fp98S2sC4vWQ35oR6xE9scKS9ylfeprEi+ig+xx4Yz/eZt0pJO2l/9P0CPSTMUqwPdlJiGy4kZRb2E1eGQkiM9EpFBKyEyqe/IbarZ31Z/Y0+INDPVb2pwXO42o0u8VMNdwt6Mxf9tVPl4oh/XB54zSaAKMQ4fqfaqf/r4y9/sUrCN0ebIFXLv52O7UmeoFQY1AgRyCrFMvAsEOoyV8ndNwVcyNjyNdOR2jeSd6dMe6dWyAKWVT7EJ2+2JdjzqbTcptGHC+ZhWrmXQSAuPcGN3g73LQhooEhkJhbbGnSP/xhdNGgc5XDFQ1VYdk5pxOYupnWr5n4+BQ9Oi2TdZqorYg9e5zgs4sSWDlo1jENYxW9G6+naTFv6g1rGbqv1Fo1j0q5ofcjP7z2tHgC17njFcjPnQFWQwA4B0n9L/Y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30acc69e-a603-473d-a52a-08dbc4eaad6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:00:41.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V33tjMYfYrJJFJjCfi+Xv1yrNLjN0Hf+gMCELMbLfh3Pyyr36nf0KHRZnsScauF2CcJxBEwhf0kY3+qdHVuWzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=978 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Proofpoint-ORIG-GUID: P8MPFQ0domNbARa6RlJ0oI7xQLPUQ27G
X-Proofpoint-GUID: P8MPFQ0domNbARa6RlJ0oI7xQLPUQ27G
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seed and device-add are the two features that must be unsupported
if a cloned device is using temp-fsid to mount, as they conflict
with multi-device functionality.

Additionally, add sysfs files for the temp-fsid feature.

Anand Jain (4):
  btrfs: comment for temp-fsid, fsid, and metadata_uuid
  btrfs: disable seed feature for temp-fsid
  btrfs: disable the device add feature for temp-fsid
  btrfs: show temp_fsid feature in sysfs

 fs/btrfs/ioctl.c   |  6 ++++++
 fs/btrfs/sysfs.c   | 20 ++++++++++++++++++++
 fs/btrfs/volumes.c |  8 ++++++++
 fs/btrfs/volumes.h |  4 ++++
 4 files changed, 38 insertions(+)

-- 
2.38.1

