Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4976DB8F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjHBXas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHBXaq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B42685
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiGDo010854
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=+o0i9KbfPxCYJe3Xymr46lpr5mvX5oxAiyuCcrs+SCs=;
 b=FIFt+DlaYD7eSb5ARHjae3uWmsHQjPOBL3+yH0mfls5zMDoubH5yu9wQJ8WZDbJEG/3M
 AgwzxQnGrAsawbv/NOO+H/wsnhx1DMdR+s4gAWYomzMunh96DGvWlvB/pkdcdwDrxK0/
 yaQLE0Et51MaHVjk/U7gl0XIXL36poNvRHjhf0AGBMBn1SrMISa3Je83XpqwNSEQvGXJ
 SutftDKR+HyVVWf4oa3Z6oq/79uo0TBsp8oGQBJg3048f1+Y/C4dXYn+oyMykaT3JtAY
 KE32pFOzSLBefIArcM3C4hxHpv8kBACreGw4MRFEgMTlIJS/ooqt8kLr8K/ECfJhD/tN 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu0ct3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372MJ45f003887
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7emf9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzLW033SR1TxnJXwE333PB9L463IO+pC1puL6pnv/FRz8hKiigMVWSnlIZQVgXlP9CaV+F16vPoZPkl+QRrZyEkPYsXFK6NhjZc14SgyVcljfJkOzvDg/J4VFiS1HSQntTnelevIPpHxpDwRQYzfnPu0LCnxLt0aG1vzWb0LU2iIx3Kjh4qUCQyG6rj2W5N9uV62I2RfLwIR2Rtpv3AVHYy+C16p6ZGuyGJuqZMS2WEtCDwDgtMERO9BQ6OP/8L6Nqo2JC+HVHEMvWYaeQcULD47ayb9wpfGxAGaM+9YEHySYlwDSQdV4mlnMLEpselHDxUnAao87VvNABmGpn64aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o0i9KbfPxCYJe3Xymr46lpr5mvX5oxAiyuCcrs+SCs=;
 b=C7z22BXRfmZOoCeV6+CZEVTi/tAeDV8IdzZVT1VFpLO4o5my/7ImO3NEcAaNm3Wl9vwNkZYbZOLMKPxoioRKtpftdFySaajkv2PzNMFKBIR+EWmmkO43eSedZweEGWI7R17MhYCzkfcE5Ro7vK64wQ8aZ8YtMt4dC3XC2R6n3kcqB0FiELaIZGnmS2aJ+Z4k0cAPsfcr6zj6HVsnpEWytTJq4c+CCIRCOOal2kA+7Gc8N0xv0GeQZN3yebqz9wv+4CrgKDFS51vbDh8QGHqnf0m209LB8sT+4nADXs9moPjnH/qJTjz8YKpwwp46K9S1Y4xMe4pzyUs2LQCxmvvxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o0i9KbfPxCYJe3Xymr46lpr5mvX5oxAiyuCcrs+SCs=;
 b=yT08yehC6QQHoAbUpAI1FZ8O10q78J6XDSWhBeEeCe/mKexFtP+agFaBQHSkdkVWY/71520sSXihpna9sp8MWI2DwG+w9+QWH2SU762OOqNvVAmQkRiBgeswHj1Kpg7a13y1OEupgJHM/9OD9rA/EJaNQOMnHBWM5vl2LVTUWTo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs-progs: track num_devices per fs_devices
Date:   Thu,  3 Aug 2023 07:29:43 +0800
Message-Id: <bef7d89c5e6564fcd621787a647fedfe72f94c0b.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: db0a2453-db42-4434-c4d8-08db93b07cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD4mFTcQJvcdLB9ojzCVjbqQUBh8j1z+TL56z0QxGsBlMcviFQYG258pK0TwckCil1fbTnIc5Jr4CGDE2UZOX+N7EUgaPsWfwR71AKZjPrlShEuXw4J9OjPsjQglHdf97t/acIlsO6SsoYtWSGEU3cpF0mtV56kGVFRnNIVrdGgF2LtT9u333YhSUiN+1yWlI+FLw+pgbcUSlcuNAhybzvOmavn9iaeWyNamhWOJXM2K5BvKDDeOIzJoCvg2TpupEVGJ3rfXSW2yyJQ0FDmNWqn4mao09WN6eJ/mtKSSkKZw/ik7F2rVvVSrBkkNw7T9LdDjVU/cpy3eYA6Q4z7FlziKbmxHjSYVG9GKKIntD+CkptYHBgGYTgdFo5tOy0HJ3AH4KNgAuOXBurFxjz8VttTbcl3rxrhJkK+ES8R2oNZmP9ESPum2Qa5Xe64VygmPLuu9XAW/Q8XusbZijqzXvx2dIdYibUVa5sPhqkAk8xKT9lcSIBAq9NR3KXk9VFU6yTr+mW71IlZ8+LJEL+mtd5fPQCfdT6sjikBbEfW3p6ydcvlHMi2AF+wQrqNSZNFg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I9d/8sANv1A2nARgkx50K0TixiNNOmmfp5UAtSCicFRCvT4H8SGb3RzkYF66?=
 =?us-ascii?Q?a2PoAiYODKNl5FVc9x9dxdBRu2XdDBYCzm4sYvgskfFbMlYyL3UD6PJK1nBa?=
 =?us-ascii?Q?I7EzzjJoahY5DEv8pjC8x37JF/mQ4b0Yd7sKuW3tVCTbtWg7v4Vvxn4dPmbi?=
 =?us-ascii?Q?1ooUKXaL8fiawzIL91ZR+dLRNGr5EApYTuFfMfEUc406XlGfqhU7itCpB6l/?=
 =?us-ascii?Q?6vMPrbMuOi5mSWDQFc7Zlg3xLZCs8UCzypgmRm7IJaPJEfvekshm6pWHilkM?=
 =?us-ascii?Q?esIq0RSwbhMjKWGdz1ybUYGFd5aZC7FrlQEiPQp3UA4h5+ebv/no7lGoY9Ka?=
 =?us-ascii?Q?2+BbY7lcmmN+3hQSOOeRhn8yqQQ/ck0u30uQnbFyggQJBIahk61h0SwgCriv?=
 =?us-ascii?Q?oxcb/YLEBXjeD8i61Tij3cfh0lJat/wOGRJaDJgMusZWDc66yFuOaov5Oq3z?=
 =?us-ascii?Q?52M56PPw30VNDtc8ilN5uvt4HuCKQ+Ed0/L5TNxqttjbPRFcTnPu0LYPGO6x?=
 =?us-ascii?Q?usCtneN0CSggxmx+W7lEn5ziaj+o8okbbiVlVQl45S8EYk0/0BOgUYQLgyOi?=
 =?us-ascii?Q?FD5PBz9WHufV/eYoSTUzI7kXluR6EiPrS9mS/PfNwDq540R9ZVUN+iWvLfca?=
 =?us-ascii?Q?A4eXcKwkGFfJV6d/xtrM782x0790/zQZL87GvIvbXgnESrN4EFTnl+spoyGw?=
 =?us-ascii?Q?hPQmeqvU5skLyQDBYVbjxpDWTL20AK8d1OVUSuS0k3LY2Bs0q6QglMyUrjUz?=
 =?us-ascii?Q?cF3JivrayVCXOpV+KnG77x+RnpL9MyVgJMxJQIlltNZBpNoWHi0QwnhEYzwf?=
 =?us-ascii?Q?wODC9rD/d5KXhM6Egyhp8EPqjUKL8iqInmDOMTEBroGKM+s02vLzAFZhdECt?=
 =?us-ascii?Q?dVDhzRzz6UxucWukH5+5oPV91t3pl87+3Aqpoq2xg9JnTmTOu9oq1EogxWwu?=
 =?us-ascii?Q?2Oh9vqcVbsyLdat5YNX9/CW9THm5tMKVR4+3GYO43e7XfwZThkGeCqBrpJl7?=
 =?us-ascii?Q?AFjxxqV0J8+WIo4/LxFSDK2mlFvCW07Bp65e5rmuJbUKqDidvGm/B/OYin9Y?=
 =?us-ascii?Q?GvJSG5bE+9VObhevXe1gOEIx6BqQsxqp5uC8z0rhG/b0BX2Ko8n+knRafwzY?=
 =?us-ascii?Q?HQB1+A4zJBNAgRiCzoAxYOHhpL2Lgx6N+04GN1ZuM/VKZzzHpIrnL7WWRJ7i?=
 =?us-ascii?Q?j6d4B2zL0pwtkCHKg6HWvNAFyO/fUv5zW7aBc6oLXd8weWDFoctTBtq6SBs+?=
 =?us-ascii?Q?76oZrf6LBRJfPG5//e7xGukgBdFjpF+wUNSuBfpB0ivgUVBwI6F227Tpr/ZN?=
 =?us-ascii?Q?z8phoJ8J9dbxiNpV+LFLIT1szf8r3nRgzWQWmxHil0QNAxuUkdhPXyl8vRFD?=
 =?us-ascii?Q?iYB++Xh7w2q+i+yp227tymfr0u9yXx+xBc5M4YjQ9naGKGwot7cBueMx+ExU?=
 =?us-ascii?Q?sfeYCDp1w2YOtDAu9J/Y/aFRRrjLDZNiBgpRtdP03vofQAKRpNz5+CEp7LN3?=
 =?us-ascii?Q?p3tx+pme71sttwsPC5NNRyMc3XQqW2VjqoFRjZ9i/nq77w+6wBv2Ju8g/2tO?=
 =?us-ascii?Q?oveJ04w+XxcMeIMIm3hJ6GWWhPpXB2IvEx4uyawZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9WUwODa6hG2mXKOur1Ef1FGXbdROAvWOEce4ZvjdvI70/dnQnpdRl5n9b/d49hJYMPKSOpy8W4mkGKr1oMgr+jAG1pq8v73JzdHCJIAIr9cQ/BjKSFzUEpx7YG9zLnjwm6xgrTkdeEaOSKhodulcKzCAbj90CNzvagnskqUoJ89VjQL5izJwlSidLZ851aDMPcByxTAfG3o+oELDC/RT4d/tiH7AmlKHgml8OPLIRPl6yPplB5rTPnXA5cFiVhG0AfdL3Va8I6uR7bkQP+QzX0nUMXxnReFzSIC8yC6zKwhnm+T6BnfMbCpbiZqLCOv0IoVvqkhru4D4XSh3taxQARd/m/I6EjZ5c3pNFt3ttBg7ApDVz/S9uaoBDRs6uz3XbPDnG3YjUH48vxwqaQngjDFlxDX71seJlF6j6j395dQy0UatHtPO/yFxtSvEa3fjYzGGz9J7qDYXEOB4EDUm4KXuCFLyn+hcflVBY1zOHMIhUkzHB4Fgn7G/ZL+8UTy8YtXD8AVA3Hi4uzNpcUYYa3f29zjAO0LdWOiKcxEsM5r5qxDSgzuoyrnfxtDP7jZ10KCw2XH/556f0i8WfLgCSK7NJyzBrYGjRPev4m8YJJcd3SbUoRZpIUfo5xTHFfpRwO5UfWfFLImajG3DnadOcPsUjLuOwoQutbq/uTUJTYTiB7bKU5D8gMuJXwrU0djQMlt8FIcM18LxtLOBENdoKnPXWuDx3XkUwjnuibGdqVjlagoPDFJg+zLFFJm3Q2BEvujH34mwCuU2opMj+SlxMQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0a2453-db42-4434-c4d8-08db93b07cee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:42.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26oCHvfUTai56/dtf/q4jtLPonKHPN+26aD/txsCxlafbpDPEVeIQ0v1LI7E+pld6kbY7NboCcw8EhNg3bsiSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-GUID: E1DaWST81YMYXfwsmjOgMDRApvWgzrWv
X-Proofpoint-ORIG-GUID: E1DaWST81YMYXfwsmjOgMDRApvWgzrWv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
v2: Maintains parity with the kernel.

 kernel-shared/volumes.c | 1 +
 kernel-shared/volumes.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 375ceaa93de4..88d6c51e3e7e 100644
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
index 786add2c879d..fe8802a9fb38 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -88,6 +88,7 @@ struct btrfs_fs_devices {
 	u64 latest_trans;
 	u64 lowest_devid;
 
+	u64 num_devices;
 	u64 missing_devices;
 	u64 total_rw_bytes;
 
-- 
2.38.1

