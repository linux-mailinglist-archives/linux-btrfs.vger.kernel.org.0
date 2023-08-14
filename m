Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9371F77BCFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHNP3E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjHNP2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:28:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3E10D5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:28:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECjAAJ031133
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=z9tC+ZO2VlZA1xSM8eu+uXwgek3Uo4XpuMPRITSr9k4=;
 b=y6mJM1VI/g0qE5p3z/0EP9PCxxhy0OD8R8WfiPWka5nAJbkq32I5flvSlI+lNksn4omy
 BR0Qa6l81lf7/rxboYY9l5WBLAI1AyLbqFbwzh6NUoUdgCe5hPm3iT1tJavMu3GhoahX
 ivFLKJCeSnN0vz7MdN+56ymAqpDuHr9UF3/I0tUK/l0WAqagCWKMlWqRIV6867K65Wsz
 //Wv/DyMoG3doMjBVNhGd4AyN1QqT7k4mEUg8zbK+AMhWzGrCHAqkhfB1nBHTOgjmJWd
 V0A9vgx9ww7d8Y1Ww//JUL90JwBAMxs0+b9mPoGtDso4k7XOkLcMA7KkSgLYrgsXHVuL 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2tx21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEkjux040343
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0psygg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2tPIzCZwWPS3Aowev9WgvHexjlHsAr15sKdpXDEHLik9l9NRSDCnJvvgnkdCNHkqFmjkKzDre/EoGT+nNPMZbm/Kg1QJJmYGC2J45ggTjMUDkh8eadRsWqEGFOZy0lAZucu5QZSkcNBSzLd8PjxDNzFIVY6x137Ngi7Qlbo+iytCl4tFlW/sWVQrVg76NO7uCe07hyN3tk+/+kWzdkl2eMokOwDG93KnX3R0u4S+k5hQwFOLypiSEXKiWqb2Mp4IBVAYe0RkTbHjkTCwtDF3AxJwT93m1LYJz2TM/HeOm95QC2fSs1T+vObfdiDCDOjMk+UW1gTHb8X4zDgYrbalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9tC+ZO2VlZA1xSM8eu+uXwgek3Uo4XpuMPRITSr9k4=;
 b=UiL+xTXijDGukOZIUp20tv52psvYXxn7czGpL1SedvHWhMq2ipb7aizU5jjHgrfUGXn8vWtLkwQf54s0D4+n2qlsVv39BA+4RfXubxkayudPyEtENukCPF+wq5cEodPaMZ42D1kC+liT3kJ4SyzirhceDHS3Sd56lwP19eKx3O4ZgHjld0w+nC8as2HQPont14EQfXMQjk7vs43CfLjk+87Xw+Txp3BnWV+i1T9RyWyU4XOrNr80oiV+bo94v4Vbg/zUrgDL2W0EYKveO3qNbIkQsfgsn3M6hOF8NJ4g0WmW/mtDD3FQR4E7HE7kaOAn8pr8CVnBtP1NsdNn3bP3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9tC+ZO2VlZA1xSM8eu+uXwgek3Uo4XpuMPRITSr9k4=;
 b=fuBR5zeFNTVbQRBhd4YMc7EG6trz60XE6l7vCh8PfipgXbjBxQCnKasVEom53u9Y14REPRh1s/SoYaREL3fVAUJJ/GaSAHu+EY4nYBUE6LnpY9DIiDeUqL1EH6Pim7fghBoHRdzfRxoC0WdN8sRf4UditjoIH045HrCEXfjxyck=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:28:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs-progs: track num_devices per fs_devices
Date:   Mon, 14 Aug 2023 23:27:57 +0800
Message-Id: <fc73d820858da0f787a1f22eb590cf851ace4d5f.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e14e7cf-b72f-4eb8-8021-08db9cdb1b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xt4udvhWoIGIR57SdSUZXWJ4l/WrlOGEab5TWHrIPG30iFF9NtHjmdHY/BpE3NU0H0paY2PzIjbuPie374G6IfV3x4UVfMmVRc4CUVM+bLwzj55GBaShZSBIn1iJOekLtYMBXmbcaJI4xDtgKhTFqakdsuD3Zv8/Ww/f9/3rcFzUNAcFaY7FNL7fvvpEsIjyjuLJNuQZ/Y+D0w9rbbrFmWhWwanZCDPO+hOC+8tAgOtwwGiiTnJ4OsV1uwkn7+KiCC/myPchmnQ8SS7bF93UEbUwnCNG3A7AXbzFtobXRWxaDlyGl+LVyWPJGwmcHjx9UjW6erHSeX4ptCqAzDHYnP/tjZBpincdsdk1LW/1mYIesQiv8ofMO2faC94DtmrorwnVX7jFIi+01G63vbzbtifzS5vN/ONkg2AZLU0AbbRynoH6006MoilQQfZKbyMLq90ge9CLk0hd52TGJUCPW2pchHna7OcHQ6ZIq8WyxYYrU/WPSaHN1tTMKSb1uoMadjnxasCI+ndDu922MXbc0INRAAiyBd92GrrpTVhtLZzskf0Z1QA20wENT0Mt2wma
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6ZG+gNOK0dU5Uu2on0WE45daKucemFVrGCN2CTv8vnluA7FzbCWuyaBtFbm?=
 =?us-ascii?Q?SUO148U2JYs/0j+5D/syyLMlAqVwcU4bi/FaJokTVxUuwMfSN5/US4tuNZqC?=
 =?us-ascii?Q?3Oo71kt1oNroEfZic4LsJRaBhakDNwvTkMPnpahRCAzZ/pnUG+4XN0WbEqyo?=
 =?us-ascii?Q?kPL4Xd0sPfMucvoi4JOKvohMm4AQ1QGDPvX924ess3xf0kQdECp2+osy7RWe?=
 =?us-ascii?Q?QSdtlzVz8kh8rMI5TOPV3t6RH04MlrEt3ytePIJzhJVjDMECkTGAu80wb/Si?=
 =?us-ascii?Q?drK3QV1Wz+C8oyiiDnwiJhwfiTyWI+B0rcxzuN1rWH9rOICb3Efgz+Z6m/Th?=
 =?us-ascii?Q?EV95sLw23jInYm8JRJorkXzn+N1PS9aFCDNsVm31fJIyiE3Uu3lvZbiqbGOH?=
 =?us-ascii?Q?MZfSgO7/y8gW9F9WTv2EywyV8VlltV1Iv+nL6UD7hZZGdKxA4BIB8tLGV36o?=
 =?us-ascii?Q?Em1EQY1RWOM8/E/eEVJHTjhhrLcE1YrFHV4Kb++9hCfEnNtzz1QTEjVrqc2E?=
 =?us-ascii?Q?Kdn0IyA7AM9n+L1S4V58UAAzVHYIwlSYAJdE0UCWEV4JRXPRKbFhrcqc42hx?=
 =?us-ascii?Q?y+C1f+GzHv+YB4eNTfpCcCeSeDbMkTicGJ6XxCFlvJwaL05zZU/1MkjgV9t+?=
 =?us-ascii?Q?2J1iBh8XL7nmurpmoxAZ9v/z6qe5JLnANUZCC+JQytGRY/wPDOq77tyg9Hp9?=
 =?us-ascii?Q?QhMnqUtW3MZKHgCqAPTtRdgLVIGWllObZNbCZhbKKbxXbHYsTqDOtA7JJT0g?=
 =?us-ascii?Q?NdTMn7IvhZiCO+lwAZgcZPKjrQaIvuLutCCTEvHmGPW+rbschZ52l6OjA5nm?=
 =?us-ascii?Q?Re+ijMTsuhbDrW/1KOmrrnarcB+8RmampVofDA7krFqI/JU3s3okSO9tiY09?=
 =?us-ascii?Q?GifA8g+vOEe/y1Q4QyAfPatVaYrHKkMPrYZsiVqEbLyhwUkf/iFYS4GjvbMq?=
 =?us-ascii?Q?vHdfDj8nRasmxMBuag6OC/1NFg7EZ9uFh+qQdY84RTw7ermCkd85KRYYvm8A?=
 =?us-ascii?Q?IYmzAZ/M2cNu+4bglJIL1xc7tRudmZoNRkLngMJDFGJLIQtTL/oAUeVWfY2Y?=
 =?us-ascii?Q?FiALcAnZFeuLg/7QiYqUqL2tnu00wx0/q0M1S7DfUwy24xttv3vYBq1MkXhW?=
 =?us-ascii?Q?58Uyx3Ezbl6AFHVX8ruBIT2p0riZVdS5RFlNsQt9wqIOjSzRaWC2ilVxZ+e5?=
 =?us-ascii?Q?43Bf96JJvUvaKdcAbfQaTeaslQiZ4trQlGo884gJkynQ1Lbby2HrnZsyeBXy?=
 =?us-ascii?Q?xdUMU3MZte+TJ0dYbPwZ4g+xWr4cyFgB76tgQXH5Tukz1z3qT2etucqqDNXs?=
 =?us-ascii?Q?4bi/+u5RQ/eh1yvs09zs1GDaq4iGe75mOqxTY59K+gGJ5tq6UIqlHzwwVTxr?=
 =?us-ascii?Q?ueNiJ850zfdAqjz9HpBO1VXlqGgFbU8qcG+vyHbOxK00LI8r0igLpdTtt3JD?=
 =?us-ascii?Q?zQwOsudxwTh9gUQYp5FhMeGOzF7N6NLSTi/fQ0sQny/vYq/lFJcFk2K+QfFx?=
 =?us-ascii?Q?ni3CE0iyyl+9tItL1HDl1lqCI8uKE2WXUUzSx/Yh3qXnG8yQp+Fy0ZT1rvIz?=
 =?us-ascii?Q?ZIO4b3WSNxL710/+rBk+PKkF4MoeF7yxBr/CmapkjqWG2OiiBVoDkFpLWXJR?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: osTgn47kXEYN4SXcBXIWHdLWoiiMKJOnU3MMEDaCwRWNiLtznqk/A1oAN0LFY5OjC759g2PUFnOzg4ldaGWIVFsZFfq8bb1X/zGEZlTYyJko9QUxl4LwftWzjzBmaz/qtioXDJY+yQdOqcBb9LULH8yqFsYOghqWw3GicKCYrKeCIhfib3yVBnfPckIbRupvPLZnPT5OjUSuufC9M/71Fex+vyMvD/yEfk3bPQairdy98x29QmHbPn4MMsGR5iqCKxQ4AQHfxo5YG3Gzz6iJ8dVKcxYqEF6N7u9XmE3GygpaW/TbfB8rRJ7sVQDICDnl8D2koI7hbI70ZOrMQ+9gv9C0Fbf7rWZXvHYAkA6fPiCKT82VNyKXg82Q1iW/ZtGnHGd9XoE4Ry8rR+e6F8XCQF97xu5HcbCj1gc9rEfLvBUnDoBYLkfMc/XegDp9lYGfXI/bRhLTRs7J1HuQB6JR8lLlHxaqovjJcCoMEnLj3ephZUcVZhlSWDI/g8FKiThQBKEtfEt5T8lHPIHP/w3zAH6oAVlPw2awTjxHWQrLxD/UTgHxohq988tT+4ji1Kx7P7ojjQ3jWXLPRHuOBa5y3qJmiwW6C2y5CGjYfl4hQeqNYXc39B260sKHrnJz3fs411AgGiryQNvEtRR5hH7F5AhyjWSG1/Qwz3l15UkHTVAMzwIdIaNeLLZYxwcBXwA0XLgKHaV+4R+9QNGS6rRIEvEY27jrsGaULq+Pty75Zi8AiT/A6WFzqyalsUTYJVWhoPb/hOL7GI++Xw66axTObA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e14e7cf-b72f-4eb8-8021-08db9cdb1b9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:28:27.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYEJhOSfmUE3w/TQyDsbCRc/zGx158ZgBCT1oiPnUb0kBLKe+h0FKOZhLoGZTbixW3N7HPt2mUJdMdOCpS9H+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: MiT3PCOD8R_6L_v9lLeeLAKFY6Z4xFLW
X-Proofpoint-GUID: MiT3PCOD8R_6L_v9lLeeLAKFY6Z4xFLW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 946c2e7a931a..3ca7a5a62da8 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -406,6 +406,7 @@ static int device_list_add(const char *path,
 			btrfs_stack_device_bytes_used(&disk_super->dev_item);
 		list_add(&device->dev_list, &fs_devices->devices);
 		device->fs_devices = fs_devices;
+		fs_devices->num_devices++;
 	} else if (!device->name || strcmp(device->name, path)) {
 		char *name;
 
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index c89c1659e60c..23559b43e749 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -88,6 +88,7 @@ struct btrfs_fs_devices {
 	u64 latest_trans;
 	u64 lowest_devid;
 
+	u64 num_devices;
 	u64 missing_devices;
 	u64 total_rw_bytes;
 
-- 
2.39.3

