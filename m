Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F357C9F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 13:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiGULwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiGULwk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 07:52:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7483F0E
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 04:52:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LA6XPe025046
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=evpyZJgQDNEjqEsG/mD7Ldq45LK7Z3KSpTrLeeLuDvs=;
 b=vIk5bU/LpQ4sSkwPadxe5zh2epSIooE2LDdg0JCKRHV4B9Io7PNjhOjITxMm7HJuNuVy
 ZrZzXbPNkWVchl94qsb+Dbmychx0Rat5I7pq7HiwfWvP96rlOFerSgSxzswW0NkGZhUh
 FwVlryMPzz/p25/QfJqmeAmRGRsH4XUU/ggvn72Nl2AUyA6nhMkHaEUYZ3NYKomgTk3C
 RkoUJ8LGDcpSo36KUfsGz4gVjCMi+vbSUOEuOF/zkmm0ngrxpKjLEKkGJGuztjozfTIp
 NOanwte/ePGpHqGc5oTA1VwCpsT7MdRNTuoD3RBYsg2idtzjjML+5s4u/OhDxEl8P0nV SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtmav5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LAb6VU016401
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1epba5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 11:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC9BnUku1rKVmgg7B7hWcICQuWVLdYCS3YTI5UmJKaP8I+C/HDQDCMNRZgYvL3IcxzhuFWsdILASlRXDlnxTa4JOA5xVyIDA3rAbHEYextof2bbSvMHkpRLk6YdBYMZmQC0M9/iRRIbo7x7NLVcAIkU8AFvWrXVKxm3MJ+QxACeqaA9ela5HCf7p+RYt2mXIKT+KXueoleORvpPl4VtsWD6FjFD0+lDeFvd7EL62fYIF7MPUq6OUb66+MBDPRNPbFjTaah/yCMTu7pjlh+jxI29FSJDJ1geS1UfYMr/Z30T7MrcEUov8Qd2enfwjwO3Q3jlewJK4fz6ELDlm/lz7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evpyZJgQDNEjqEsG/mD7Ldq45LK7Z3KSpTrLeeLuDvs=;
 b=gOy60TMzOZzm8zEiTM353ax1DlPp4+6/Mes/Ur6VxB4Rjs5cnuvyHphb/Z1uUpEiqhxnWDkpf2rZGdhYfQlDEKiUT7imvqj6euMT0mOIAPFwjoR7sVz10dkXyuLWIfIItrj23+VqsGPOrwy8efMj3PlZ7bzR1y2PVaQ6gQhTswk8AlgKxo4/lIp4NC8E9kg78hbIbOwawfA2LvRuV95Wc/Yx2c/bd/61GGy3an0kGzVrYvSrD/7o33x3gQYNJCjE9xuvkRh/3C07t0i8BLvH1DCrl/mUpXiwmwnpd1A8APjU73EfRphCK5Hr2+onBYTyOEgATOivpjQbAccIfYupdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evpyZJgQDNEjqEsG/mD7Ldq45LK7Z3KSpTrLeeLuDvs=;
 b=do0w3tpZqxgpa98ykDpwEXtxmZ5gdgDEMfNvgjLApw5YtM8Z4kqQckbdPSFCu/ZCVvU+2Vl99Np9z+Px8f7nwybYNpk846DKMk4Vb/bzKpLGV3K/LpwXh34xj1kXJPudh0IVnnnYZTyWrBixiM2t6K4Wfxr7Wqu6bpX6sNUuWHM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 11:52:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 11:52:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/1 RFC] read_policy type heuristic
Date:   Thu, 21 Jul 2022 19:52:26 +0800
Message-Id: <cover.1658401527.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bfd9531-593c-41f9-d7cc-08da6b0f7ef4
X-MS-TrafficTypeDiagnostic: DM6PR10MB4140:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLZ4U4deRkJvbFZ9PeTHfSxJBlaOA+fv0i671S8+zzxxSI/TT6kO+7d/TAKU8l1LJB+8w57whF+KCcZPT+fyab1jyYhxyHUD0BrLrcBWt7jOQdBooPTPeutKZaX16CcoYxauiN+5pnTN8amyGHHiUNxc9tmH72meLD/Vs97F+IX8Q/xSDCdNvC7dsdMswUlFIkqTJzUj4wX8sZ4fStQg00k3zoy/crUjYUOu4I0OjOLsMWOjVklYJ4+nuM8xPg7QfwX7NJkup8kQu8RyDwOwkuFa6omSEOLrakih7fRY3xuyqrbzXTSLxkndSUHWjKv0hgMwuQjvmukYNHSaOY2o9aKGjIAJAtjZZBzoo2IOJ5NtvSxMf3evyN66akbEYkJs9pMsJq32a7bXptQSi3fy9EvY5bs47VDn0NaHHzkfsHO0Pim1Mg/dhxDnJXNQm4G8RkYkhaa/Jx88kAX97SbWWdgJ5hHIn6/CxIB93Nw8BtESLnqIfs8ATnjxBvBjIx19NNjAyXKJRby6r829cqa1nouQ7Xidjt85Gbj3K/uvOz6slGLJEQGdv9CEXsufHz5EeQ0VQcSU2OhX0dwdJjzXDDXKgSgAza/yB5T5/yIqtXrmide6z4w2r/WL2ElWDMWV/TMug5doA61hxw7tBgv4P7M3aY03aik9SZsdzqtaBFDGhDOjvo38o8xgClT5FWhPj+JkJfQW1Hv4i3L9hPbbXiSc25WTBF6uZHlnuaeKC/dQvdB8OVlXjOEw6IkHkKbkxm8c6yi1byyGEfFTtY2mnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(376002)(346002)(366004)(66476007)(2616005)(6916009)(41300700001)(316002)(38100700002)(83380400001)(186003)(8676002)(8936002)(5660300002)(44832011)(4744005)(6506007)(86362001)(6666004)(2906002)(6512007)(6486002)(36756003)(966005)(478600001)(66556008)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftfddTNTJm9VunT2Dy1vmVN4TqeahsSjMojClzfSDwP2+XpK34ar1BMwoBAd?=
 =?us-ascii?Q?TKE4n9nLuH+gLQ+H/H9VetbIz0xCBzdZADwUqHMRHdG0mT6QgoGkxEq3iOPn?=
 =?us-ascii?Q?8O9Q2XqXR5h4Iea3+/gVk4sh2JzkSb8v752eS7lwmfatrR0foLfUDtvlVUSg?=
 =?us-ascii?Q?WimbZBOF2lN96yXwBAX13U7HadBBs415iwb0iYcLYZUNdXaRRf7tOxPHR+7j?=
 =?us-ascii?Q?7koStTAfWTULjKzVKpofOPG4p7VDUIkgodyNpY/uaO0gE2bG8/WZqKCsuHWg?=
 =?us-ascii?Q?jZ1bqqLLxKB4AUAcO1lxKm1J83XSrpIFPFjao58+vUA7zbloDKkP+r4aWoS+?=
 =?us-ascii?Q?d4FUhtGDaM5an+E6jnJWdQJ2sWqSefC+k+aA8ubshSJbqOa8nfkNk1So/1De?=
 =?us-ascii?Q?I3bsRA9FzeflCpx7myetKzWOcPBT3Hu78HC7WNBNEWkVyKb/l1wZ3bUUVAH8?=
 =?us-ascii?Q?7a+tY2hNE18pY/mvsm+RgArEahpPM7lA2Dd5tKAvJGEtGSdXCxb0FQAyTHJY?=
 =?us-ascii?Q?rV16/sh+LguePKBEKc3nrwSsPuEE/woD+/2BiX7epm5d17NEnEqHay5GNnjg?=
 =?us-ascii?Q?iGce48ZIP/TX94MLBhR40p/X/RhD8Gj+TmVQuWi9JGaeqqP0Wzc0BSI2Y7lW?=
 =?us-ascii?Q?drDeYbhfaQe824cUQM9ynXpi6NTQ1HiJstUsFFehYffBcMOEmGtflHwC/kH/?=
 =?us-ascii?Q?etJCwDEY0nrJn+3y4D/IREKmrPOi61cijgi+clF28Q3YbW4GGFqe8u30enmT?=
 =?us-ascii?Q?nOTxZxHrmbISkzDiK9TOvggn5Cfml1kDImmFiWv9U/xXGpKXGmD867oeNtED?=
 =?us-ascii?Q?dFs4izKLafMUudYfu58NGcvd8e19fVyzXkqIpMorDxwJNC/kIK6mZ72ILDDA?=
 =?us-ascii?Q?1vhYTCOEYPbfBM4UHeiZHg/z1IOTHPTInfQykhddD3Jh9Nq5PR6ph7u9cFci?=
 =?us-ascii?Q?dRUGjtkTOCRZA+mt8EbU3LZbwXWXqObW7eBIiFi3eXF2v7ans58Jzkz7gmnu?=
 =?us-ascii?Q?GGokUB7ExDdGvF9SAxPYMs+MNjKmlHNhmLbteCruIIRg7abQQP8EGOzKXR2d?=
 =?us-ascii?Q?PhzwxQXM9mlqE10uvmoydoRs/ZcQVINE4x3OSAPZqzIWYp514Muw0bU6C2Ug?=
 =?us-ascii?Q?CjgXex0C+U26eraEBIXBnhQ7O8NryWyq509rohm8Lffys2C8CDj5pO+GMlkg?=
 =?us-ascii?Q?xss1+VR2yIn3JrhZiiXchjK1W5AF68PdUVZXrN0KK2kSylnOnWAwi+m/3f3i?=
 =?us-ascii?Q?bQ35jcjzM+fbpr93eMptMCLbzn9FCGOD+2fRixO+AFJl+ZKIsMPa9lard4Ap?=
 =?us-ascii?Q?9LewCLR2S/btGXxd+zNIuJms3pz6pZmMFqAgSRXEOhSm96GSh8X6mCc+Wvc5?=
 =?us-ascii?Q?3BrAx0T3YAZp3teZG1iCVYJ4s/Vms6kbYZ3Nb77DxZpm5fKDcSfWMl+zyHWr?=
 =?us-ascii?Q?Dpgvn0bPjiaev/K8R+6VgNE0lk/ZRcW43+Erb5Vto7ThzwvaBE+Ng+5sIjvO?=
 =?us-ascii?Q?w0lH4qksETBXD4GIzgHdO1qfCfjsXvU6O69BPASMORxc8w3zt3OrEsL8Bk0m?=
 =?us-ascii?Q?z8nckj2+QrKw6/UptQnuQEVsw4t98kYiVV56Pi01?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd9531-593c-41f9-d7cc-08da6b0f7ef4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 11:52:32.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezYY0bs6PUMHWFJRs0At7R4wiiKvGzEQbKQcG/yO57A4DuAq6htGSVWKKvg6Yh6YnmekJukAbtf1Y20WM2d/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_16,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=514
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210047
X-Proofpoint-GUID: RNjEwJ99mpxDULaywXrbkmquamA2D8Zg
X-Proofpoint-ORIG-GUID: RNjEwJ99mpxDULaywXrbkmquamA2D8Zg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

POC patch proposes a read_policy type Heuristic to solve the problem of
poor read performance for the mirrored stripes on mixed device types.
Read_policy Heuristic has benefits of both pid and has no dependency on
block layer iostats. Instead, it uses statically defined device_type and
its latency.

This patch is a POC patch that has no performance analysis yet. I am
sending this to get some early feedback.

For the read_policy type Latency, please refer here [1]. The read_policy
type Latency works better overall, and it is self-tuning based on the IO.

[1]
https://lore.kernel.org/linux-btrfs/20210120123437.OVx7ybGaVfmOdZxtpp43qcB_ORHQQs5OzPSzr3ZUGbo@z/T/#u

Anand Jain (1):
  btrfs: add read_policy heuristic

 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.33.1

