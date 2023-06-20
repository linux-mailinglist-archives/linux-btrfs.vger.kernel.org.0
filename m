Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7027A7366B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjFTIze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFTIzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:55:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53E10F8
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:55:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K08McS001347
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ivUeIr+C0KdlFEjJUBF5P5cXKItmemMa/6aT411pllk=;
 b=gJLac7KpJILktX3OxbjVQl3+/6ymn+nFZD8XEaWxOtehnvjweTqJ9FoabHehmUyb7t0y
 IalTHcGRrq+ng9vU3N0whyQAzZYHsUJi5tjvzJdAJ+XY7GPlS7KwC1GtUHEIQZAj+M2W
 EPkLSLpcDzZFzllV/N3afnr+0W1lJtVWHcaQ04wjXOFatZajPulFvfpkOiKPjqZ8W7aE
 02N0rsoTNPbj5oFe2/D7pDnEu3VPxSp08qUMTDcvkYFC3Hvws6vofGNJ5L8zYd8GXx1U
 nIM77uUkTdoPQwDLADPJIDjCbp6OFZN2JkxLI3JAmBmXwlkaYI+f3zurJWgCnDdn8Ctk Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1c79y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8Rvhu032948
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93959kvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCtE4Tfk07MsupAAr8+oD867bhHagemNK3czriAbbfidJ/GBoUVBa7btCjFPi3boenTCTaWZjhQ894DHipd26kYN0bLdRj3a0cK6WPAbVnL9upOGRPkmHYwoNVPNU4z6HRJsGlGVdiCXw/xtpbU91SfH4dqfa1IXmtgBUBIhBXqtxGPsdPPBmjPXTfDWx4JW4Jsr81BtvwW3hScsCNAfrK8kwjEz4b7EDPIFIcLbJ0Bh+68AZ3CV5xB2jM0onbEHy4Owi0ezLZWoS3k0Anqr7NvkS4X/9fcjUIuCLyCj2SKOkgDZMQiPxkS3Z+gH1wWk5Jhd1erdJ2NRyltdFCIX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivUeIr+C0KdlFEjJUBF5P5cXKItmemMa/6aT411pllk=;
 b=NZXSUvbPmR6S7NTQnTVtiXba2iWq0ldAwHt2h+URRISvTIPRKimKgvufc+jK4fH/fuQjLzMOaWbj8Yj142nuIKoV0P3e2lmg3VyK1UwUdGd9yZu4euEAn0CmHL/62NbiIeDeiIumocD27Gv6u5d+AEOpXFZd38LQdtO6F4IQMVDCFrL/O8S1wLrCmOiXyUrgGh7b3LKDQL5jdlr/C1jRLye9plye1iX0xZ8t8JD1p3lsIbYjYC3iC9xedRhkKW4GRgcXEPfBOdpT34MFPfgG4knPgQso7eVaGz4cN0gGWpIYjM+h8RpiyXRa2ipB6F2vN1P8XaJA+HLJKmtdJD2wtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivUeIr+C0KdlFEjJUBF5P5cXKItmemMa/6aT411pllk=;
 b=lxI1V7TFxGjWEscS2jt4y0mdNc+MB+KSjt9jyKX/tgaxetjsG1AFhmcUAWR7NqP/nOBhG3PmRs4Ru97W8vYrzAPT2wWRaCmSkcpZksI49HwSvNKXPVvxfd3E76RGjNdh/vRpbn6hzw2y7jHm8VkcPuX7vkTthPQzxfVLvu16acQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 08:55:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:55:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: sysfs: display ACL support
Date:   Tue, 20 Jun 2023 16:55:09 +0800
Message-Id: <1d62fb411a289807d8d12d6a76bdca867a56b591.1687248417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
References: <df5dfa3a329e7418519a5881311d776a50a118a2.1687250430.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c431dd-2d20-4269-bec2-08db716c171f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4ggF0OuulT+fv1Q0QfLOQbce+E26m6RFGnFVnNRzZ5+XULJmtOkHTSItc/3JolOBXzRHGdFsJvSH2pXdPYOKcvTTkmAVCcAevNaxUSvFEXNR/4nbc/coVKbza7ejMjnt0uFbuLXJHawAejqaJWzxfiohoogiVvcq5E7bVKQRJ1smLsbKvvlHnq1xdnE1GhdO+e/lFZb/jkJx2+40t0WotcKO5QaODwsBcCgJiASNMBwQ0h3HSgfO/nKdZAjHz2mMyNHzVjdjwK1bJ+HbllDGKOO6UN9E1yGUS75VqIlEtZX1SqetzcaX4skHZqR+/3oIzmpeItCwYpZt9WhECwiMqP5wy4PdIBLscD/CNN55Gsxu6VhC1kdN90NNpXZ4/8swk/yDHnwNVl1X/eyUXIl9bPVONodGfR7rYAwsnxeK0QgwLRXVcz0SX0VIN6MuqApYasMA1irAKcseqXBkf+aJ2WMFbW/aFn4Rxrqp5rVQpgUe1pYiMiSGMyMmwyaI/Tn3WVoPfAmAhWXhbT/ZzJwVS6fdCOo/yzwzeHCyDejT0vvS77BzRw1DqTBN9sTT9q7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(5660300002)(478600001)(44832011)(26005)(6916009)(66946007)(66556008)(66476007)(316002)(4326008)(41300700001)(2906002)(6666004)(6486002)(8676002)(8936002)(107886003)(186003)(6512007)(6506007)(2616005)(83380400001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LqPydtlApXYEscVw9lvk5pSnLZNiZzVei7SLf1RSGWGBl4gmBiWk5ZmjbCFW?=
 =?us-ascii?Q?DOqS+ylwwUX+18ZVHQcQiQI878/abhyDW45y7VRgBrgh0BpjNVuPmyvQ3NmM?=
 =?us-ascii?Q?PVa0VHjXM90B2uxQ34u3j1WAer6GxoQtbadN7kFXQwOAykn1SwMu1nkmQw0L?=
 =?us-ascii?Q?+VMkk7VHwyKCA8jHSny8QB5DFvwR1PzxhU7nMxF2+pIesWOgsPKSUj81yljF?=
 =?us-ascii?Q?d2jbouzeWeU8eU/eXy0+FJvooOFLRJblJY0oDVtc6Hp+21X4eBCaQXKIWBJZ?=
 =?us-ascii?Q?GazdP202NabNHZOaMFahvPCL8HPwCidSGj5tL/gIvK/8YmI4tFOer78wrwP9?=
 =?us-ascii?Q?nxlDQY9wzOIq+Cft9DIdDXN5aPQZim5P8bSIfzGidzmg8/Io9gw/qahTMA8y?=
 =?us-ascii?Q?6f/m5WWy6qCkbG0EvpPh1lMsfv0FBGrz5c8FzOKXXTL+uvsLff8M7SSeTIq3?=
 =?us-ascii?Q?7P+iouto5XaiEi7CNAgHYfXcnD9bZHftKLGEmAWOGrOQvnIebXMu9sT+Wu2F?=
 =?us-ascii?Q?fS4gjPzcLcGfyFblkmRtuNZrI3y60vy0gUo5PI1Sj5B4DHuBCamYdLoeo10s?=
 =?us-ascii?Q?+3QubQqjjmGbl1VEcWAwkJaBTTefLo2ZBQBfPZk964y53zaT4pE9dlf8l3eH?=
 =?us-ascii?Q?jAMbA9wDPoyME5NVsoDubbV/kAna9sUC6c/2u/2vcIIdf14rjZOmKlCUxq7Q?=
 =?us-ascii?Q?kzwMbs9+Db6w+X3qXTjlWM0rRxUbAAtbeq2p60coCOdSbx5er1Q7OT2e9FlA?=
 =?us-ascii?Q?uZNt7WVXnuGtt8lzUVNPfoYhgK3VaLctyEpPE0WlvI3MSVmfPHty3m2QDuyn?=
 =?us-ascii?Q?JtVcFy1arA0s8+o66HZ5uHxlGTHkT44viJ/u4Kua3uzPPdgpYAMSjqeT+4SO?=
 =?us-ascii?Q?/8mgZ5nAqxbXEXxnm38xMVca8Sj1c6nGR5MAuGG5OmFEhG3txTYO1ivFbzTl?=
 =?us-ascii?Q?PS6BAKqb8rnbgo9VwNvV7Nz826P5n1wICr77e873kzO/aiP75uYUTZn4/7OK?=
 =?us-ascii?Q?daMOTCwM4pDAqcDqzA1bn/bCHmwPwSEZ12EqfoHA97wTifW3mpmsiHMIC9NV?=
 =?us-ascii?Q?1m14rUBpXL5cGEVjmPXiPo7oY5SSuiYQ/tOq2Rj4dXIBy9AdHrGmhhzHIi/M?=
 =?us-ascii?Q?viyw7BDsUcMqwnKO1lYRDI+lMfrIEGZioEin94uTzEFFGemmtKjLq47yHX6K?=
 =?us-ascii?Q?odzQ9zwYIkDbbOdBwkNiTP7Hms8kTsL9qfGEJ5vevfdavJBk35SxIPc0VHZq?=
 =?us-ascii?Q?Bem/coUn6DDaI6oOLYZZ6Zp63/8zAqVc6b3rOBS0lVgpC3OBFzDv9YvH6XHt?=
 =?us-ascii?Q?t1N/E9IvlWED/wmBtCu1m0mkb4DMoH2A/PX0iShucPKhWxv44DAUKnCL4CVV?=
 =?us-ascii?Q?JP6c2LAPy5SWoh2TTJlaV0TIe07Y62AkLDOdU+pC4nDpgT1SoV2IJ9tsrzWa?=
 =?us-ascii?Q?tIm2CZuZdNYCWqiy+oZUJrL+fPbt2DQ1FKH1ZR73H/4CxaWOHrrdq6t1WpEX?=
 =?us-ascii?Q?OgjLs3zRTxgmDCHaaGFwiFd+AB6p0pogqPiMDR/owSlhK8pfO22KUhW7zIjo?=
 =?us-ascii?Q?tBccu8VULELwTJR8ZJDkcWXE3ScAR5CZFnmAxCdD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KUWC2MToR3efxHMTcDJd5DdZ3/N6VwsQbnijWK8/tl18asiF1oqmEjAq7aPmuGx1W/T/g9cZINl3iBOkB8dg0hcvmm2ZsC5tvsqft62RrKfH4AHdclF83o3S4SPq0VofqVOQlyoo/Bvk/3B2DUVaCxbAdL2FXZBUZFVS3svQGaq4o9i1sVRpk5uWAA5ca/TE7ZezmvxPMClQOXDkpjtKbZcDAmpoK2iOI7PJzBeCTKj21L5rZVIjJh+ChLvtNevXXBItXb5UuLQjwC8EtSUqbjE38KUllcEafP1WN32tXF5bkBKPSLcQaGXRsRhujxUu9pB2jWAAZbygE9yhQK3t+FVwPb1kXcZggHL1XWZyXZod6chJucRhrwGHtbnp4Q3r/S9v2BeTeVrmzyuVUCw2JjkSB2JoOXMxE4iZLg6B+ndiYrPemRvQQYJD7V7+htRENyOLi0ma1gQflXRpRmYMbtIRLQ5lysgq4MCfCM9vt1xfaVoH2fnnnRCwuxy4KYxE1RnqWBZ0kYiZ3IVzGzzk2MzMx3I81taOWKflWyuKodJ7Egjpaov7hsavh2Fs4eGZwdfPgvVZA1zbGWAzF/6wttEg+nPGSxV9tVAYP7jmlWJ5VkCFZzscmSrfOl1OXjT1mYscn1tXAEt2g5XnHBBGHznWaIoxVZk83iMf1LffuouKpq9biNpaWNupgUO5XwQZUmpbrfXlfH0/x+zIIOxikh8ORGIqfWw1op3yWexjB5ZVT3bJxmXNXeoPXi5WI4M+/2nZKoezPM3MelTabO3N/A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c431dd-2d20-4269-bec2-08db716c171f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:55:26.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1zXJvo5IyXLwSKBTXmh9oQW+PVZMWWQ4JhQpRAP2r20e4rdvBPq4gqhWdBiJnsmcvV8qeLyaB4cP9Qi+qVkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200079
X-Proofpoint-GUID: iYPLT1WHV_9KkYxGC9SYLRASua9tYs_P
X-Proofpoint-ORIG-GUID: iYPLT1WHV_9KkYxGC9SYLRASua9tYs_P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ACL support is dependent on the compile-time configuration option
CONFIG_BTRFS_FS_POSIX_ACL. Prior to mounting a btrfs filesystem, it is not
possible to determine whether ACL support has been compiled in. To address
this, add a sysfs interface, /sys/fs/btrfs/features/acl, and check for ACL
support in the system's btrfs.

  To determine ACL support:

  Return 0 indicates ACL is not supported:
    $ cat /sys/fs/btrfs/features/acl
    0

  Return 1 indicates ACL is supported:
    $ cat /sys/fs/btrfs/features/acl
    1

IMO, this is a better approach, so that we also know if kernel is older.

  On an older kernel
    $ ls /sys/fs/btrfs/features/acl
    ls: cannot access '/sys/fs/btrfs/features/acl': No such file or directory

    mount a btrfs filesystem
    $ cat /proc/self/mounts | grep btrfs | grep -q noacl
    $ echo $?
    0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 25294e624851..25b311bb47ac 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -414,6 +414,21 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 BTRFS_ATTR(static_feature, supported_sectorsizes,
 	   supported_sectorsizes_show);
 
+static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a,
+			char *buf)
+{
+	ssize_t ret = 0;
+
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+	ret += sysfs_emit_at(buf, ret, "%d\n", 1);
+#else
+	ret += sysfs_emit_at(buf, ret, "%d\n", 0);
+#endif
+
+	return ret;
+}
+BTRFS_ATTR(static_feature, acl, acl_show);
+
 /*
  * Features which only depend on kernel version.
  *
@@ -426,6 +441,7 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
 	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
+	BTRFS_ATTR_PTR(static_feature, acl),
 	NULL
 };
 
-- 
2.31.1

