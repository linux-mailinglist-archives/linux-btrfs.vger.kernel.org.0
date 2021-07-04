Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B223BACFB
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jul 2021 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGDMHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 08:07:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5308 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGDMHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 08:07:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164BtWPk002465
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 12:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=hK6TwcTCEzq2jKOkwhjhBG8LaFPRTjlcSXpzdPSrQwg=;
 b=eNNthhVEHW2a4TD2vZohZ5w/WSLTiRMNHFR2AduYW6PKoQZ2T2LueRce7mRq7XI1vkYA
 farQQeebFn+QidX/Gb5wYh1N/1ALF1Ft9psBOoQaT5CU1pfB/JKCK86Dfer0duRksxug
 gzu7lhWn0QUvhhT3MzNDxxodEUtxm5wWDUf+vywhsC6+rEvaxEYG9b8Az2lRlARL3m7J
 ZfJ9viomlz6a8vWV8VuOmwIS2MwnSyetGtxBR+rXEpOOZlHbV1q+AYSdg5e/rS7GRnUT
 gCTqpjS2oM0qdR7sL1hNXn5tVmiIFFcPt8owAKje1UwpZx6rSPPssuvhecVaA5Ew0/tN 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfgs961d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 12:05:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 164BxvWp193393
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 12:05:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 39jd0w5w9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 12:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XotCUjeYHWllMJMjUycp8cW+WHV9c9iRFK8PNZG9FsXNu+UMC/TdrG6uy7AwUgWjUT+eR/amiXwl3XRdNd7eSeJ/GmPiy2A0nRbQkUq3FDaYOoxXwRqeF4At8k4WqfI/zWtVBK0ReTLUGrmLj0rc8aClfNtcHpu14BbPILfVmGulXdS6XHe8NIuZldAQ36Xj9gGGZ8/EaEPlZ0RZZPDHv7nxSaT7rTcDKGPOfiPFAEShpt9338bq0aLwn+pQEsFtyB3UWagmIs6thlye1w6TVaLsWh1BV+EyFyj7/+J4GzC7hEbxgpoTsQRsICtOtRmPp6gjE3vN45TaFEqLwpFzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK6TwcTCEzq2jKOkwhjhBG8LaFPRTjlcSXpzdPSrQwg=;
 b=enL3Edv+z92mzyVUa+IRpndyLrxEl2+3GZ24//3IZ8Ob87AvkvLhpu/etqzxN6vWSV5VX4+ipfYzyPBNe1B9V+SB5/r0aoG72oLB3UBRVOGcx9wDF5ZyWb1He5ImUsS1Dau6Hp6+Z5iAkNm97LGQprv/FWb5vYFYthl6JQuvlKEyBDZ/+K8ubR3UjBY9oaT/a1XaaDE1IPxi8rRoOx4hlEf+zrcuyPwxApg+wKC8QOsPElNh99pTJ3yVnEjao8cHHzTCGLatSOq36QTTQX5lxRo0QZeKWLODKJtFrkknRQfWfRuFw/ppiv7bZ60uKyfP9TGI2vMAw7C67scLUkTRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK6TwcTCEzq2jKOkwhjhBG8LaFPRTjlcSXpzdPSrQwg=;
 b=QgrzI9NJN0dNYKRNnrLVdzkCMl7I1HCnNuPguM2fJPt2G+VPwGJ2R1nIQPEcOXU1lMjOBJewGns0W+DkHJWwqmtx0TY3tveF2uT/UhLSaOzq3y4G7H+vF6AGhxpwWPGu3/1Iqjq+TIs6SoluZnb1nLQ7MeTI0GQvbgQ7qETqTfo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3901.namprd10.prod.outlook.com (2603:10b6:208:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Sun, 4 Jul
 2021 12:05:14 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Sun, 4 Jul 2021
 12:05:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] misc cleanup patches
Date:   Sun,  4 Jul 2021 20:04:56 +0800
Message-Id: <cover.1625237377.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:54::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Sun, 4 Jul 2021 12:05:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23dbb64e-973a-46a3-1c7e-08d93ee3fb05
X-MS-TrafficTypeDiagnostic: MN2PR10MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3901FABCF2A6A8D5AE0D3AC8E51D9@MN2PR10MB3901.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TTzEucJT3b+LSRykucRkL5MIzKVc1kgzTmX0lsO9SLQW8+LPPu6qB2Fyn8JuWuBbia8boD4a3I9N6BAR8A1ZrnBrZzjqWaF2zGf+8ODptOmG/KBpd+66e3WzwHqVAKIjodXYoOeVfbLSQp0Q0u3HeJTIaK/4g3MtC7fFdWL4XEQ49ISbcbyPFxOf3exLL09RLodLke5tEsjo0jEAXjH3nf0BmLM51OWfAsIdFmvuFkShTXjK//qiB4cfeF/zjDtnIqLw1fzqvqvXotdJLoOadFrPecNcfosZtharIFJ6On/QJCEP4WNloelnXCwIpSaLxYtiphJRZ+6/bDsLgq7dp3LoQHrBjixh7V10xaq5phH0TE1wJuP1TovFh+NkhLO3b6NqnQPjac+ezO1UyLIn2NqXuBdRdvV5AGFRhNBBPtAN9O9Vqz6nHXQbikDVr2W1gQA4YyvEEOAradgDFR9XAU8aoGAqYP5nhKMgFuXfNnRAMSjZQ5N1jPMHiMm4LxDDLSaJQ+r7tO5claSjOPFTM4Whg4QRxeQXt3kY3lBaDLo8Urw8YJwP28aYmnukoavtK+d92H4STPrbhukEE0LOXS1nqW71oC2hMNWAB8WmyBT2y18ZCCt4J/GmtLr3wenCyA48IymOt2gZdW98+PluweiR/H57zYbl/XGbXWFA46KPDK/O0xAUASjaixZdLARi6K6mSj7g07U0w1WtN8dNhMc+SRJR46zcCk/KjkSsNe+yIDzYs9WZfbMAjgsu8M/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(6486002)(6666004)(83380400001)(44832011)(38100700002)(52116002)(316002)(8936002)(5660300002)(26005)(38350700002)(6916009)(86362001)(2616005)(8676002)(478600001)(66946007)(6512007)(186003)(16526019)(66556008)(36756003)(2906002)(66476007)(6506007)(4744005)(956004)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqVI/TLpd8EiIhLbwZHGpHd+ukXtZi392q9d+ZkUZtRv+UT3RcgZ1bqThNyp?=
 =?us-ascii?Q?7cplXTuR/3UPWagAgsJ+QcJMTclZZK76fNq4btNAuZTN/7ovZkTPLD5RFCO/?=
 =?us-ascii?Q?IUBt7NTgbQqDwG/ART0Ey8P0d9iyTzahljEn1KLeLvGNghr/m+vkWgfbouNN?=
 =?us-ascii?Q?hWpbwtTK8A7/pD53JcEt5NtSNwZZJmbAaH0gWcEuZznExft4KEleN+G8tuE8?=
 =?us-ascii?Q?DXUe6vKYVCoKxBK2Zb0kI2qfERsNnr9kz0mdtuyu1KU2Q/fvbhX3I6TZstCM?=
 =?us-ascii?Q?pGGUWRPO7zTzYWltXbuYYA4PB8lGJJEwVF9YBGdm1PKxp/RU7p7Bgo+v3ZzE?=
 =?us-ascii?Q?U0knWumlOYyP6qbcwohrT3+N/BNrHTZUuxljMa/coKQWH8tz3bLYVvwPL/1q?=
 =?us-ascii?Q?Zo8+Lg437Y7Ccwui0anb3LFLO4sr0ba1b6sc952xYKcGxeAFqjByjO+dDGaW?=
 =?us-ascii?Q?XxuJYR77XMV4jeaDiBDVwptmzmcx3MFxUVEzn+4Ni6vPpSbO8kFAIkXFdAfn?=
 =?us-ascii?Q?TJeO067q1uppLDx2FZHnKvUyleQX2tFN6GabQDL5fIinhsjuIP7fszhSoUSW?=
 =?us-ascii?Q?frYUc+W/ECsOld4n00fdhiS+QraZ12vbOv0R04U0Eot/T3WHC3+r4WGSBKtJ?=
 =?us-ascii?Q?ZoED3Mf6qnbgF+4kzNEpGQ4JsLyoTE7O9oFaX7821PZOcD6XUO7xm53a5i0+?=
 =?us-ascii?Q?zbdTeVpJEnn4IkUOhSFuVS11g1I9TgdhDunob48J7nCwNCghHShdxaBuDPiE?=
 =?us-ascii?Q?xG/9ApC5MoCWL8MYVD182TLQj+fAtH1aE0eY3V1pe39uJ737FAe2JyEoR+xO?=
 =?us-ascii?Q?6nzUrPi1+EUjz+4a4S6L1ve2r3MssZ5fuPd3jKLkTGjqsdwJzWVA7qPF2wTW?=
 =?us-ascii?Q?xBxV3Hkn5+/IKHANv/+UHf+Mrc7NSvv6yxp775dl0dDfJx8WXdj/L2FmFG0R?=
 =?us-ascii?Q?KJIWMUuRBOjl7t10n/M3OboeHCGkKXwimVVfDJSQKVaYMainVaQsy5YQmXNE?=
 =?us-ascii?Q?HFQ1vWr1j+M2jMX2D6/DGAPRLzDH3k+CI80gYy8Kqpf223xGVMLzEXI+A9To?=
 =?us-ascii?Q?HIOjSUhCw0C7eS0S17aCF9pIWiEew5tay5VCSesrxVcK5FzLEmHnMZ9dLUA+?=
 =?us-ascii?Q?rzAHkOGcuNX15piVe8EJtnCPJqoWKaxMliuVKj5ssdeAoWxZFTrCrrmtAKF9?=
 =?us-ascii?Q?BWEDRsLA88qc+ooUZjOmH9OToV2NjfHB/5DW9E7+stdoaZ0JcNgL02ENg/QW?=
 =?us-ascii?Q?b6kZ3q/7IKzHB8DYmNXOk0ai1a+Wut75Li9ndhYmE4yD8RahXx+F2unnJ7T+?=
 =?us-ascii?Q?3YvJmxg9OdWDegrbW15bH1Yk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dbb64e-973a-46a3-1c7e-08d93ee3fb05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2021 12:05:14.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywNEGYplts+5I7STrldaL8wxU6lKDCYTfWoIT2MUEg1yIRy3RtKd6170LAdgZ7Zb1VKYE2QAWIShgkapzvSg+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3901
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10034 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040075
X-Proofpoint-ORIG-GUID: RXIE0jOEjbhGTKFBtXC2m0coYzkj1BE6
X-Proofpoint-GUID: RXIE0jOEjbhGTKFBtXC2m0coYzkj1BE6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These patches are independent, not related.
They are miscellaneous cleanup patches.

Anand Jain (2):
  btrfs: cleanup fs_devices pointer usage in btrfs_trim_fs
  btrfs: change btrfs_io_bio_init inline function to macro

 fs/btrfs/extent-tree.c | 10 +++++-----
 fs/btrfs/extent_io.c   |  5 +----
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.31.1

