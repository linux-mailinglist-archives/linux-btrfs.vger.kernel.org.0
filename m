Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0195477BD12
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjHNPal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjHNPaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:30:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9422710D5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:30:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiSS0015354
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=IjPl6RcP7txMgyozdstnmShz4wsMwb8k29ZEGfQ96+Q=;
 b=w2fHI2E9RPKYTs3RGf0dpiXsqGYmGVxC3VdeVojTgkPX+28Su96C0Jh2Hs8ZmIyVu9Qj
 eVgw05nioKk8uY82z6Jed/Kou3wT3Xl2/MXsDVTfT45rvJFe6eAMDMol+PjDgCBKgfAN
 KJwOKyDbi8YbhkagS3Mq8uDxX9geHNw+WVDT7KliEZIAPkT+7JYZIjzdzhrque6xKR13
 9ZosV6P9WA/m/WYDKRp3AVqC6Bwtel2/h0wi4FLJJGS5Sk4DV8ICqLqIwrgksZyhPAed
 5LxwKbin7zjKhLp98M9vR4skylju3FKlRix6HvixmxwpgfEFIc3wnO/p6SFDhbc6jlKO xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfjwk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF5u98003782
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexygt8yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuirVGzRsQG9Jb8M/4BE1VszEmBlIJCkcC0+ax2VNLg4CGeTEaBDmTxRKnx6vC28TwyJtnwcVhFhnm7o9dH8b0VeV6VqF2EJJihe2rl+w0NOEiT/idJKHIOyswkTHWnHf9E+zLXSBjLubXVMIqNx4aaljRpGZoIZN9yqNzTPA9U14K/i1jsO58Zl58ydgpCtH3mBMEHldlqWmFx7QPgesfa7ixi/XTI9xJS4FFtwHXQ7wUSUd/lGtyG7K2db2aFe4mVbRM7QdbfiVXmSV2sE6otoa8g/3qscQTUMakGIHx3l6voi63cXnydK1Q4rGjY0G/YllNM8LUsKHrp+RACYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjPl6RcP7txMgyozdstnmShz4wsMwb8k29ZEGfQ96+Q=;
 b=cvet9qrzwErVq52DnOT97FmknC+YBsnwd3R9R94tAX808uATtFKCgj2BbdERUXnLCb6kHCTuNCiQMnGrXdF7/U3z+kFHkHqCDhLafuo3IWQDshleiIeloQyJSDsIRDwZIG2NeEBtJ5/0SVgtj0dgJQZdkKHvmMW1ihS24QUt64lCLAf+hghXfdK1AlqU5GS9A1STOIZg5LSgdfdjLaIenpKuzjST4O1J0Q40FXx2vGW5mG9rFvoRW/UJYhd1VHobASyQq1ODegIPvb1iZqo2UWS+ejn3ns7c6Wg1GTOmlRZhNoMwpKcMi8MtXvu+0OngfIkhbmOqxYj7019hs2ArKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjPl6RcP7txMgyozdstnmShz4wsMwb8k29ZEGfQ96+Q=;
 b=jUTf/X27Z18DKZYLz3ZxkWAWeprKuCQV3bbeJqNC2as5CHG+JZhOQflIV6pVxpKxDzdQIvMUugHNnw/RnDCkI7HpHSQXhalPnbKdkXuQenPD58Qwvou/fGuTRM/K3Ob31oRntquwTeFsePzKt9bmH0Njm/ZNNpFJpfwMn8/3SE8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:30:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:30:07 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs-progs: recover from the failed btrfstune -m|M
Date:   Mon, 14 Aug 2023 23:28:11 +0800
Message-Id: <5d68db431d32f2521e6541e5a8a4ed3a14f4e674.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 02655a28-5cf1-417b-c74d-08db9cdb570d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUaOxM0nA9e++1YBXasKrvFa6eLR/BQWkMSajObraryoPLYzpbDWbIIc+A3AwP6nAOHcPPwMEvtVcn1aIjnUfPOpxLFXlOHFizf5FQ9NwOlUXEFXnKLVyye0J78xR4pKPCdF3KUXBCScpQewMTUJRdSsCMOABv+MXdt8ushfD2WE6KO5IoIASBQPNwa73UHrPvkU/bDosB6JZNxs1YhI7hEt6EcwwmO8BcMMX7i+dQWrVnKT9CTwJ5KS/wywsNHim0nmSCDmgEeQv69CXACoS1Ad5Xz8iOnP5iJHys5VqBs6MrzowGgMPpF0FRpnF/KNmGs0bZKPVWsWkWC9Z0Xz4ysa9pDGZiUPVPY+LFk4qq4YjDBFLP/ZbR5EPUZIyQvhFbFN9lMQHHmD2c2r+go/+DdLb+7/1QG0bhhMlAfixLmZCbidiG2dH2dxj/ESxrnhHgIuFs87evobUGaT7S0+PsMKP0bVJyzl66uZ8BX9FVm+4JaNC145BhpE/sa1MYskbAVZsCPjot89ZMhOjbmNSt2MjOFjDqv1p2qcnuEFLPlrHxr8zW/odwFlRx52ITSa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(41300700001)(66556008)(6666004)(66476007)(6916009)(5660300002)(44832011)(26005)(2616005)(36756003)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6pbdpyDaXofuXPzcc5E3k3QIJM9iayphNE+Q4kYdRyIVaEn97n+ANqOZ3n9?=
 =?us-ascii?Q?yZPWKLqNgjuat7Se4Os+BxEtoRYFAEyhi8iu7zUFHAgUQCTTx7AgAtp60epK?=
 =?us-ascii?Q?0lrwcLKIWmmkMnh5r2h05da5H7xcPK0m57LH4pHv92nd6/l3UstWkpGYyR5g?=
 =?us-ascii?Q?9LkBmeK67u7nhb3Hvb0B+dFTXKAT8rizE7ulWy6n97+9iNlet1UjInGRGvVL?=
 =?us-ascii?Q?TwoUIyoFBW5RTlKz7RX0WUws14GNs6PQEgfaA2j28XNzoBVs5Pp1gylznB42?=
 =?us-ascii?Q?TSMwZXfbPyu+qUgmKnVjo/2LjHI1GwLINhVk7tiq4KjCN+3OA86MmHOqghRM?=
 =?us-ascii?Q?tqIc+TKidDbtFNvaVcx1YWS60zU7qWxHsGcZrcPpOrJ00OsY3y5FKdYO/Fog?=
 =?us-ascii?Q?+cIo0iqaYCG9eBWSRnTtjWLpzgX6EdqEgEnlGBBgrj1yeEq7IvFGM/7tDRIq?=
 =?us-ascii?Q?hidtHuoirm+OY0VYHaEkCLS2CYcHHZMVewc709Z1C//v+4Ppx1IYKPPAfmEy?=
 =?us-ascii?Q?6XQRbrM17L3xRJkF3tIP5GDwKlW5kciEDRv1Al5NZ8hWa9fHuBR8TpIK+oYu?=
 =?us-ascii?Q?LOmbzjFzusdVIJQEI/5gk44nKCD9PmVHyNH58Obr7bbthpiSCSSBnlexRcwN?=
 =?us-ascii?Q?kJfmsWO5GN3egsJkI83QL2Hzw/vNLJJWj3KkcXPs6oR0zScfbJaXvVj95GsS?=
 =?us-ascii?Q?KaYC3ECkAUoQ5oLyXgQ89nw3GduJx7mCHKmjr7b6TdxOqCkRz4wXex9uXCub?=
 =?us-ascii?Q?LblFDNCsxt5JqYhJK3tliZpmdpTW0JvC0SuiXj6uD6jHGSh25n0TXQwQkCIw?=
 =?us-ascii?Q?gHIjoLLFm3dfmaSCp7nWkRZjOgKmx8xilJ5UPiU9cLaFr9dcEQeNUBd5+Gx4?=
 =?us-ascii?Q?N0sSHC6GpdMQXw8wS8WjkN/T/ktcChTrGPrANTuAS4Onri4HIZI5i/p1f/SY?=
 =?us-ascii?Q?noCP8leHm5+mNCbol8toW0iQEiAlCrbkJb4WtNdz/9MmwRec4Pgqd/bAjjgF?=
 =?us-ascii?Q?NQYLOjvynGGwbQex7S6DDVL3ZDS3/BO9uolDfal4EYxh0Mp1Gg0XkLw8rT4p?=
 =?us-ascii?Q?q3BfsFts2b40bm/UVfDKcAEe6D+iBDEGuDeACg9PfMBbYjncyvYi6bIJHyjz?=
 =?us-ascii?Q?pMdRWV9wfUX0b3t1RhWvBy/6JoicXMvQnYXtOQRW/TK651d6fSoty2tomFqP?=
 =?us-ascii?Q?OeB8/EJeiTAxGdti6tYDqcHSF37msjFhwmCy1fomq0v/+4KFqZ4OTN7ZQyvJ?=
 =?us-ascii?Q?xmQPoN/8585NHjdTfBvghp+ROpSU2b9QbzXyMExQp0rgZb4c+7B0h1pGBJhG?=
 =?us-ascii?Q?3wAMaJpTQiKf/vT+5z9EjaIs615JvSaQZDWxtpS5hRtYSRi3yrF4Ys5wc04k?=
 =?us-ascii?Q?/23x0c/gv714VLpbOwTbpXCP3nzXM/+jchSxq1c0vb+JrPhUalye1MQmyYUC?=
 =?us-ascii?Q?6RLrvMLW4kXO8N0VGD64q1NWqCz6q0P36/WsH6LZ5aVTWF4A/aF0Q++5V1fR?=
 =?us-ascii?Q?CVDVtfyPSoLEqPGL/KKZZd5S6lpEZIIYwBkZUiNJc8rXQ/rEcmeZ4qmoA4L/?=
 =?us-ascii?Q?Il8yrttTkBnbgotzMOejbAX96+3p0cm5YekRjp9113jV/mseAuxccEQfHs+o?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LfJt/JLxewET3VjP4JCvneyPNasVG05u0uAUI+aUSVZaWUz7OmmXx1ojc67QwMfXY0YVsE/8L9F2chgRzI4fV81NycW8juwGx9+yX7yA9amt6x0HqPrOvzhpdGJESioYtVCONj+pSSqPyiilk4BIkMHao5B0iUqrwyweJ/Uw42yczagA8ymR6YoXYfLKa94YHt+UHDxqtEM4KeQpMBNXLS6Z/hmtUWa2u/e26heaU/QXcMkrAVLZRnZBQsg3+lRwaBdKyYONyDxFMvxKQ9ObAGxbWWnHS65MRLKWYYDr3tKwSsjGJ6l424yYGLcgrWeWorxC0XfB+lYyAxmX7AmMkfxnq+88FRpT1rsMixxie0qcajK5504UMm/bK7j6n3kMyBS1DJBEfL/YVcH8D/S7ddZKui74C1iroOihifvvLZTwn1wLO0CNEGc38jrMy4xBxlQTz3nR7ew33RhUV6IPvFMbOwZamsfOC6u9275pYSPP/WGYQIKBHsgwL+RxQwrTRj5GUVpThc4d6UuceoxxohfBFGNVlZwhStwoti07bzcZSMFrP5m+iGUjMAswiB8hWoOXHnrrWjjHBxDSmoRgx+UJ3CVpiANlpFQlHrnCH1EpabssRwrd+xh97pU2IqQ4cyu6st3oIGQasV1ckyeWatkJUbib5yf1MwVUJiklnXP26w2Re8nSrCVw880go7w5aN/v3YAno5ekhd9/nxEgMqsK5NZsP4sJuOlJCiKD/M/DMWl4ENJUymKaD8hJHbJ6taFXyddB6+DLObaffGjzxQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02655a28-5cf1-417b-c74d-08db9cdb570d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:30:07.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsS6gp6BPaJYI63gMIO3IsRkWg0DdwqgO6VlOl17rL1XmrWipriA3f5sMWFAz6HH6++wIvTK56qJuxLuXjYWJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: XWXoapB99V_hXMpA7SIl5QD4bzmhr_cF
X-Proofpoint-GUID: XWXoapB99V_hXMpA7SIl5QD4bzmhr_cF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, to fix device following the write failure of one or more devices
during btrfstune -m|M, we rely on the kernel's ability to reassemble devices,
even when they possess distinct fsids.

Kernel hinges combinations of metadata_uuid and generation number, with
additional cues taken from the fsid and the BTRFS_SUPER_FLAG_CHANGING_FSID_V2
flag. This patch adds this capability to btrfs-progs.

In complex scenarios (such as multiple fsids with the same metadata_uuid and
matching generation), user intervention becomes necessary to resolve the
situations which btrfs-prog can do better.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index ada3149ad549..371f34e679b4 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -46,14 +46,23 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	}
 
 	if (check_unfinished_fsid_change(root->fs_info, fsid, metadata_uuid)) {
-		error("UUID rewrite in progress, cannot change metadata_uuid");
-		return 1;
-	}
+		if (new_fsid_string) {
+			uuid_t tmp;
 
-	if (new_fsid_string)
-		uuid_parse(new_fsid_string, fsid);
-	else
-		uuid_generate(fsid);
+			uuid_parse(new_fsid_string, tmp);
+			if (memcmp(tmp, fsid, BTRFS_FSID_SIZE)) {
+				error(
+		"new fsid %s is not the same with unfinished fsid change",
+				      new_fsid_string);
+				return -EINVAL;
+			}
+		}
+	} else {
+		if (new_fsid_string)
+			uuid_parse(new_fsid_string, fsid);
+		else
+			uuid_generate(fsid);
+	}
 
 	new_fsid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
 
-- 
2.39.3

