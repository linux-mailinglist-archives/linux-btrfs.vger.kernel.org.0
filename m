Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9A74B4B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjGGPyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGPxp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68DAFB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Fihkq007234
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=3p+mc6Yz5kTpTY7hzxdwugDBrdvFSiG/IQrwSw1RIJ8=;
 b=v+y7Q4ELqaHv/+DOD1GpJ+84IVo6cuKO7NI8JKOp/2aKeTQGcvZM+3u5RZ2NM/CoCeUa
 IWPixklALYU1wxRAQi3Wg/mh2mU4zPSs/Bl5+OvrcQf0jifLvatiXH4iOzwtdOORs8Xd
 mQF8erzHDusIZnNLnDX2Pj3uVHilKJFecsT/g8LdZHaLE5arx7vNflonAQ55e1W/G3+W
 N9arb6d4wTXDKQ19AiszA9EUuB9CHnbTHRAKKu7uZGWrgSDuwScnoxzZeWOmFnhTCkJr
 uZoBVW6w6iBRfydDM6ESH9Q957YjJmdhWF7KDn16BUUXVuKgThQtxU72Wz+IbNM3qdhN fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpnm0g0r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FbKr4001679
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakektpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWn+/sg3T1UdM4IvIMM2TgZQWfAjqOixMrlAYiBapnxLAiYpv7fGzEUkP07lkLlAy93P4QVbkuo4VOCqP7rjjNV9s9k+ZGoeMUlgi9cQtM4rP1QF8btv/TBJPlKgw/J1VvEhReaJTfHAN58JaSPUXsNul4dM3tFF8F8cQzuA8gbXvQeGTfPHiweAy7TwAr2NZII05h4uWqRoJiMenoa5lMexDIe+aHiGEZuZ4D6bEX005sCknzBdcHklZd1l2lLOpMDlSLpzJKKhILIzZdHRVsVZUjLt80pGxXpowDB1kFVYxMvswTbzzgACHdY5qSY/JhIVcjj+VHm9Hqlx1Pfx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3p+mc6Yz5kTpTY7hzxdwugDBrdvFSiG/IQrwSw1RIJ8=;
 b=kl9iTkDk0kVB1rdz9W7iSV3tb44ZmNct3chCNWd/h4Zjdq3svji1gmIhXYzPwDpUotjYfrK1gQAotXHV9/WX3BrOsVD6MK1LWve30oWIRkNaj+wmRKb6Fm2c318fHuc0txMs3sf8xhfNfeV2doX/SWhIFCqM+pNMiF7jX0AKHUjB+4W47q8g0qVyQb6RUoZcJ8V309ieier9yKsI6floQen0vg0xVaIV4rhpgqboYI7HR6lLQvT5n5PRGzrtL6x5qgAbksDqhexisbt8h6Qk830foIfH0mEVI1ENo/zMWx8gX7R4Xk01QN0QTN8XZ7G2WUFgQ4J9v69RHJ++2D12qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3p+mc6Yz5kTpTY7hzxdwugDBrdvFSiG/IQrwSw1RIJ8=;
 b=CW3ClI/pBFlUxfM9x7CGvro3KODVarGH+dnuMGpsf3RHWYBGEH8rIXcDYDIwVMtrcZoZFyNOoNVhjjSSBbHihwaTTAVoBYJulb00Wubx1rSzYZr4EtZAhrcbyxC/QnUMxnaP6BGmchsLEjpC8mRP49Vn1raVvfx1vgwjnDsrvWI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:53:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs-progs: track num_devices per fs_devices
Date:   Fri,  7 Jul 2023 23:52:37 +0800
Message-Id: <b7da75a3079804cdd6aaf453e547b57be2dd508c.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d254280-1da8-43f0-3441-08db7f0255ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D0lGBhiSfUdTLzryNEPwA8InaJiBxkRmivKaigUJGXrINoWcHGLvCCNLUmioYHspeHVt4wZ3txjM+eB2VxV+xR8gSCfdscuWv4wfcyiYp0zDW0i5HNEaW5nzg3uU9vHRMDth60MtyvVXeWORLP1UP+BirHH0GVc7CxITNgXSIm//jdGunRU9qEwT2a8QWZ3WIULFd7xrmopnORx4KLZ9ZAi+qBS5YXK3P+pPyY7BlSkuU3zohldTIrIe4peCBIYmZk9rUeowcdOOb66ZcCZ8ZM967u/ZqC1DSjCADFByfXpgYySQcHlheP4owlUKz7jaH5qGdRsGAuk4vj4dv3QzJN/Pwsl/8oOhkFSjC/7n2j+oe0EXuF4XKyVQFPsnoHgSOCfClNrA7nJEusMvnOfoDUXvTZ3fNpTnRaM402O+sIbVFS8dj1q9N+ZvNaKbhJf/s5nWS/aPU844NKMA562W7/7ka6UzpnQvPPn+VoL9eGTAk9Jj/BZB9Hn+MHRfakLyX6/x4ozIQI5iVyIFiL0Jyyz6Hu7uy6LxgYtKG2a1gJTj3VZfMIX7Np8hbzD7Ki2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(2616005)(2906002)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7MSl2ZOyXH86Ldx93NYtLFaNFc28a0eZ/7X4c4oDZVVrtQhkUHc7kmm3Cp/?=
 =?us-ascii?Q?9fugYqvyTa8dclEj5yV+NNLR1YJyQSxPux7Pve8SwFzl9+fy9ep/PEguEWGZ?=
 =?us-ascii?Q?dWOzXqKoYg7MARvRaa36J5K4AEuk/ieC+pk1L9F7ApN2e5ZU3RA638Rp5cNL?=
 =?us-ascii?Q?scXEOQmDKnaavEmMpmUtKsaDg1D+n6vNX97A0ypGYb2Kh3Mf82N4J75yfPyh?=
 =?us-ascii?Q?MlLoNYhdUCjb6drzQwyhzHxmHZSklwkg4Qad3U4H96B/wLB+tG3oJANMmLuD?=
 =?us-ascii?Q?72zJFYcJA9FhqRGL5tN8M0SeuQ4UaiE2JipW37Eh1SWxu8d/KVw6srJZxzfi?=
 =?us-ascii?Q?Uu26yALXbe4xDZvMSSuXGMzUaDPuWih8kF7B6B+jxvv4Hbjcu5u5WGtqcru8?=
 =?us-ascii?Q?B6SeAu4p3nNXRVIcEQRPDZPZNnT/L4kt+QvFH5aPyGrYBtP7dY4STCkURnPf?=
 =?us-ascii?Q?XyONTw05plSllZC97sGZg/atbeW4zDjzjQmo4E/vDZc2duCXACZMXPSlrwMW?=
 =?us-ascii?Q?XP1zjj4Xs6h0Kr5bEI+bXjsLsIUOBtfaNPqvWYjpIv3Dk0kN7p3x0LmZb4mg?=
 =?us-ascii?Q?eJ82A3JcG2b7rpUk5lmNYbJIPVBhuAfuLTZhDUNDEIJuzw40Kv2X/m/2J2B9?=
 =?us-ascii?Q?UMbULMAmSy6w7vLSpZym36m4Gg9cJKYraFuUWrDDj1iuOPvcJ85dkdDtDOD4?=
 =?us-ascii?Q?RcvATrfjF8NHA5WTi8qK1zNLF+150D5jTK4rEc84k9PV7Iasaep269PwtZIk?=
 =?us-ascii?Q?0n65MHckY/TbzpniUSF6VnlnHgQGfTE07sRpnIdwqOXoVp/14qlWhp1Bwveh?=
 =?us-ascii?Q?88a++v7EYFiFrwdrqIrZDqm/IZBX6V17qwLnJl0j3sZWZcj4GTw2oIvqG8Kq?=
 =?us-ascii?Q?XixSW1RPgjYTuKlepVNmlZWA0/VrXPHzWWbhVhQSXo3zsQB3NJR/mlmd7cw1?=
 =?us-ascii?Q?AQNs416OmWJVwnNc8nKA5nYF3f0TW0km5CUOtK5zmCy5O1Vh+HhrmyZG9bBW?=
 =?us-ascii?Q?tN4BuNZmUmNR9eneOwhr5AsVwYbEP2XEgTedDKqUrjOPtI9q4YUYt/WOkBY2?=
 =?us-ascii?Q?nPVFqvV+4+Ao8BDM+fnZ5EvSa+i++dYZFecfKN/r/WfePdiYZ9XrnMUioU9J?=
 =?us-ascii?Q?4bM4dcJUzGfEjPaSmSZEiii1Dxfcn48POhtIX50fQreXRY3djVDQCOoHxorw?=
 =?us-ascii?Q?GZmLOdzoVbF3LRpGdmkEmaS19C3XMsJNtjMkR1CD8B3j6wBuUb3fbQDbg94v?=
 =?us-ascii?Q?+MaWAA3BU8WLrVWigYq/DEcnzsZBcPS9+auAHD8E8ryPg71zVz57Q1MPomkn?=
 =?us-ascii?Q?Oqw+FwVcu5eclmpoHHtAFzP6BLx1SF4f7NnyRzdruDSE/WbC/qGQL+J1Hanc?=
 =?us-ascii?Q?tRpJkc61wZOZYtaUmqVPZITg2uXKSf8/AjvNOKa9OdToy6Lp1K8oA1QZBol+?=
 =?us-ascii?Q?yuQhhc/t0f0FlAgPNUueNTa2aO4ZtIYJfjSFKx384c8y3U89dgRpYp+XQizV?=
 =?us-ascii?Q?Qj0fXsvfnR92RSU+hjt9xibGVmsGSAfft54Bc4cMcE2D2juM7MFP1xGxWbPU?=
 =?us-ascii?Q?wVVKcYSvLT2WpuLjnbdktdHwMAKo/342G83G49Fj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h+c9evx5Eft48IvoEZRfH8VKprpDwye+q/9WK3ptFnywhXH/YPuVUFKA6McLHCytbfYkZ65eYZzYc0hpu+m4/3ZbicTA4nniI++khIRZNQ8WX7rbgvqesT6UdoAwA0zgtbCamAsbYaKsCpdivBpz6RrAwoIq7cKa+iO7iETDd/ApMe8Z+SNzYvbj1PoMyURMzt/PkVKvygxq2eg+mKE3GaiLZBwsP9M2ly4ULu5CD1j35iaIFRjj5ftxGlqkuS/S2VvCNholW5mKscsp1Ln3Vm77JpVFXqQuHINZCcBRmEE+gfJuoQbgauVzmS2w4HmMJcUo3ZLamruzgEEqw1l+T8TCp3BM6cjdFgLARXSLi2i2jZ0sKXjWpuTC2XJCm7X3pTkNTMKZfYaUX/gzH8yQ2H8B31lQs/q/XRGV/ivMDP98/JEdUPsczinvldSsy0PcO+qzLvTYjwnf5anLkQK8numq7Ctbq80PW5cbHezxyCp+k+3TM8ADInJULEHG/6i2wt1ubFQ0Ia6CCG1knjTo+iuWPDqLkedmC0BV3bfkbn2xK4iakIRPREerrukv/B/+CXEfVqwuvvTVsiS/DA/JKaEYIcWuax0l/7bTon+QAXLcxmBQgIvebqRPVD947r5ZyvNzkVfr/C2/VraQGeneVghnS0tfb1nwggkRz9gZixH2REh98KEO6XqHwnvnUn8p9lX5Wn9TgLaUUMIPBpBLZGQh92l3qcykZdDzxUZ8x7o5pjCzxED6E1MeGWc+eA0L
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d254280-1da8-43f0-3441-08db7f0255ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:41.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxvQ/jYFAe3sOXor+SGrhqTb0k9LAZMOmhm8J3+pulpI/lTx2JTbpbZwUji3ImX1YEWzhdoOy2w6LdMVBY5k6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: vtzmeuHGXOa2ZTnJxfCFTU_QgBzS4_Tf
X-Proofpoint-ORIG-GUID: vtzmeuHGXOa2ZTnJxfCFTU_QgBzS4_Tf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the kernel we need to track the number of devices scanned
per fs_devices. A preparation patch to fix incomplete fsid changing.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 1 +
 kernel-shared/volumes.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 51b3a16a39af..1e42e4fe105e 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -405,6 +405,7 @@ static int device_list_add(const char *path,
 			btrfs_stack_device_bytes_used(&disk_super->dev_item);
 		list_add(&device->dev_list, &fs_devices->devices);
 		device->fs_devices = fs_devices;
+		fs_devices->num_devices++;
 	} else if (!device->name || strcmp(device->name, path)) {
 		char *name;
 
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 9763c677a7cc..93e02a901d31 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -90,6 +90,7 @@ struct btrfs_fs_devices {
 
 	u64 total_rw_bytes;
 
+	int num_devices;
 	int missing;
 	int latest_bdev;
 	int lowest_bdev;
-- 
2.39.3

