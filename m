Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975096CA08D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 11:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjC0JyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjC0JyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 05:54:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EACE49EB
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 02:54:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R9nHNR011293
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=i7lzdOonSAUyD/S7YYprK0+BQpU5HdG3cUac+F88ClQ=;
 b=bnjVMhGOsdN25G/27fbstO+tgiXVOMaF4hgDg3V0lrv4z487u8htnFy9gZ9niFR4HjAl
 d2U9/lswo/iCSS12eswuxY6k82dY1393PdgIZvIQv/GTXcoVMZATMU+vz28EkVym4sPd
 aah9pngDIM7IRZh4DC0dS3QtFnqKVoADGH+0+7Rgn/E/ldF47YreYRl3oEUvH2foqbI3
 X/wzomWnZShe/72cRP266V0lGkNLkDck0zIQ5nsXtTCg6y3yHwv/r+1lpi4ULX1SJLWC
 05oWGUqutnTR4hb/cE0HRqQbrjbQai7XwIcpfGMvfl7raNL61Z/sgTOMIK3ckhtPhgLw gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk8ug00gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R9gqeY020313
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4rtas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQAjKd5uQxTN/OX3xP9hFAxICTHkZ8lD+0PQHyL3qI4dmGIQiR2hDSHcDpZCRgUAF3PBNU4na+GGbpcwcqZxRQQilg2RacdvXpjGyshMpCK4pk/LOf0FYfCrKhI+Vb9MZtOQcI6brsYFEKN+pWaaR1MCaQKJqy+vi3fWPHFK6vxxAd7LM+sEjhZcIHS+aAHJwLEuXM0JUhpZP9o+4c+ZiPNTkFbnwm7BEyA0meWvvlvEW8tdboaffGQG+MobDiX/sGTxZBk453oCniNBzPVjuNK2DvFZpa9D7l2g7mLzr4AMoxxhSkKckk15gWH8mENqfXMEWpMtOsPDo+3BXHhtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7lzdOonSAUyD/S7YYprK0+BQpU5HdG3cUac+F88ClQ=;
 b=lQ3caTZiLDBFEY7AS6YiMMC/SRLLz9IR/kBxunPWv006u6xmNu/yhVjHPpeVDzwrQAbB5tx/6BSwrO4UuMjCeFPwwAMsR+p+bxYHzg+Pn/HO2Jy/EQkAAMg/VCZzZXwaxVrOS6R82zPHxHHVP1294PWeHGus2Dmjq+J6T/PoWFSK3T2pvh63v5xjz7/Lm5Zu+9qIgFsKYsv15J08l9v/IzVAfIAbbBw1HqpYt9ttvVCvuMJ9+MCcugNMkr94ZKr8DuqIjxFBSnXXSi4KHMkwwpIZeuBogPCu0tAoe4nKigIWy7ed4GZkLPKKzX3lAiiXdgeV8UsFtmNBQk1F14fpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7lzdOonSAUyD/S7YYprK0+BQpU5HdG3cUac+F88ClQ=;
 b=mZ9uzQ+BZ6DsUI2s06Pe+woQv2PlsHEkkuHQdg3Okuo5ZOCx4dxbyXpgn8v+pguc/8jb+0I15+lnU6ov2aV3z6a44Qr0usS3j4Md80wGSfDlDJYzE0e9M0B2WtID+UyMHJ9640za20g2RGiPKGacK/bPxuziqk/zcB3y9Bv3Tkw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7597.namprd10.prod.outlook.com (2603:10b6:a03:53d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 09:54:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 09:54:18 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/4] btrfs: opencode check_barrier_error()
Date:   Mon, 27 Mar 2023 17:53:08 +0800
Message-Id: <e89b4432ea49eac0f2313dd14f551d0ec94ade66.1679910087.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679910087.git.anand.jain@oracle.com>
References: <cover.1679910087.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c63a4b8-46f0-4d17-fece-08db2ea93b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFoGb9hqhwqdzrnsXJbKotxD5ZIeaTSZw2vDlImrw1gUVYNdYRnlFFYjw+QNy7SOgQYqy9cbCiJ/BG0jYJnpiV3hrl6T+REVXVdBbqNntIN0D02w2nsbLlvBbqEgyZCkEYpCpzSeFaKm0TvKMXsjLaLTx21f+kHbY3EnjQUMsVskXNxuLJzA06RCu2fDzlNpkc3LbCxT1QXkCK/n2R9xRFW2o/z12p8TFzVA8cXbtZLRhfCW6FVI6PHXf1zpyGG3zdIJMbpJsEvuqJEE24568DhskkrbJSmcp/GI8jRcWtzlo3JCs+r7V1+6DtZwSA/gR2XNnvXdsx4m0OHx2KDaCk8IrnFvKgaGdJO93TQ737EnsBKVfrDd+x5nBLGpMSIsOSZkxcOtDLK7I1VgD2UB1QQkg3FrthxfB4lefjoXQ2/Xys+FxnXlX5lF8plkjdg4gnoaW8SLwTTLJltWsRWXDd9w/3EvYwV6vD60OVFt/HkEAQOD6IqB76YfEkkmXFdmhNBLvUzHtf5WaGQfRZ4qZ61pEyWDYD+S1cWzTLncBIJ136TsnLcP1X5eWTpEAf/A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(86362001)(44832011)(36756003)(2906002)(6486002)(6666004)(107886003)(83380400001)(2616005)(478600001)(4326008)(316002)(6916009)(66556008)(66476007)(8676002)(66946007)(6512007)(186003)(6506007)(8936002)(5660300002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rzcjT/51NZ5HrLQj7NmczC87m02CpfbInaRJFsL4R3IBxSRCjtaDLAjMNK6z?=
 =?us-ascii?Q?RvIRyag0uHnYG4yqwdvbHQadMhwtKnvxUoh9xTIWhPMZ23CVEQeexNb/o/2U?=
 =?us-ascii?Q?UeoQuGbbdqJVy60NBDSl/U7FrOmKejCnpihouCu8m7qxz0qi1p1RoykGsvM5?=
 =?us-ascii?Q?Icm16kmqR1PAJw/+IB0z8b7Qn4kg6XKuAhB5B/hUI4p/vfPLotFm04tUbMPR?=
 =?us-ascii?Q?5qJz+zB/3S1NSTNifoMwARcU8ePqu+GD1bmID72eWcXaiGse6ZUnOe7EeVJM?=
 =?us-ascii?Q?kQEgvq7zrQ9tTTrAl0Gsbu/2nFBBMyaNeVpNLy+rg19b+R04gpLN8LYArCiu?=
 =?us-ascii?Q?R1wGUAiQ3/uv+9ttIyGbVv6OFVINtv/CtYRjd/sFRyNl+6EFaA+2oUtg4vZw?=
 =?us-ascii?Q?mN/1NactgY+zVjiUS31phWp6dLVtazhO97p2TOuiDhpSq0SfqhT5tMVlqXnW?=
 =?us-ascii?Q?letc3bkf9tLEe5Ljj7oRWazPZ0LQHQRvhsAqwUS0oFoc1DKoXtpJjxiP+2xc?=
 =?us-ascii?Q?EPOpN+rbDz4zdDQgf02aC9ONCvlCj0/NIglA2UlFuBBiPDRu79c4iD+ridrw?=
 =?us-ascii?Q?VMkXLHlJxVO64Ivs93iOl865Pds3IfDfTx/daPCj8WZXwqQfhYb98M0HPUil?=
 =?us-ascii?Q?ZN/eQ/dt5BJ7KDmnymUHE6TTCSIbO/wQo//WQ0Sz4capk17ESdkItHWcOR2K?=
 =?us-ascii?Q?kmSaIPeH2zAiCiNVJmU3xUrXYzTkUcHIHMcR+605XR79y9cyTkNV0GCAorI8?=
 =?us-ascii?Q?lnNlFgJtXseHIEbAwsA/oqCO2bvLS8hMmE0RmlbmjyRxvk7s5F17RROyAUWW?=
 =?us-ascii?Q?G4Fyc+NE3nhaF9jl5Gi+/NNMqZ5XUg/VaSCCMB0n0GQf5bxmSURWZoyio+9e?=
 =?us-ascii?Q?Hjk6mj4Zc5tTDp90nIzVZHTiyMdMtQdOaeZ6EDt32bxSyuvLfri4xw5MJ0Ua?=
 =?us-ascii?Q?Qm3aqUPt4IH1Ua2oDDu9cL+elcmx0OI01XIDpUxkk8Lcd/Tmy93PcY5DxdPh?=
 =?us-ascii?Q?ZOQDcnhLzh9D4ah0g0odeUUIv3qxwbMOR/7tqLQlz3Le/js/I8TkxsR1v/uT?=
 =?us-ascii?Q?oDg7hGEpOyYX6kZmLAWUlfuU9HVKN6kWUhjVoi8hxxaub7ZZPIrMT4vfAoLO?=
 =?us-ascii?Q?Oyc0UgvNHY+72NOcXFZzwl6P5nhTjfOZCHLBmJ35yBLdhcfyHNJKxbt/nkOK?=
 =?us-ascii?Q?OyDl0Z30Jn5jG5CAbsskquK9ItqT/HNizZo6z+bFQn0rz5Gv/vWAaRNo63JJ?=
 =?us-ascii?Q?mepmfashIPDKZYQrddy8gkbFhVw1jzW/RwSqZEn7x061D7x2odvI9/beROSF?=
 =?us-ascii?Q?m2lHUxtbh/CbzbKkS6m4/LcOUOWzUd/u/RLyaimnZGdBpWNFLJ5l3f3HdcVb?=
 =?us-ascii?Q?g3/B1RBcoIp2jBtnqJ476JM/5VhaSFBksE+4yY1Qg0PIWMyi7KFf724wGHk3?=
 =?us-ascii?Q?soOt6UI/HkuKJQQD4hzTVqoblsf8lkE+HDRpfComJHBFZ3tcxi6AA0dm+1PB?=
 =?us-ascii?Q?R64pYZg/hgIa4gGwBbtXSlLIdpTiP/Bw4vb1hjVZzRTomJCaK/nYWl/vamAO?=
 =?us-ascii?Q?2x9/aVElYockJpZpqDl1coBkoEqVukfViaQQ8Kk3qesCvQg8BDkBYORglrVL?=
 =?us-ascii?Q?CirQobGtotxtO0de2ug3sno=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PwBXDxy9h6OaS9eHpYo19TD2t72/qnT0YsEte1DQ0Q2lUpeLBH7dVIoDFKL15pwGuHekZdgiA3U61wGrA89NcADFadbNkZ+5htaKbEespRcbpSPPtgxZVnsxHLK2erBZLmLyXf0cdI2lyW98jX0nMPi9QIYDSilwgqMbnQS7TiHU3ToSqR26ek/PnroLm/cRtj2jDgR7YF3nFkMXlarGvK/bBpQpMTXMSjTFzeAhTfrO4PpD6GfLwPBiBIgkW1c5Buvb96dQB9+Mhmnil8IztnCVXhLTZR7tDH+tdpRWnfbTcswpYNnt/XxCzMkx5R6HeSLFDvp1YPmykMIUs5UFQWDXhPXlL15cpalvSMG+ZO8me4ZK/1aO+oQ2GUgTpUu49ONounuDpuz+yUr3fIgYiGE/fffzdyXhnRaOOktdCl+K9t+v+r3IoqbJe3pQA94S3Or3oDoXCD20DJ5Y8CBj/tND196S7WhjJcccmvc7Qx+eFACOHe8vjx9+ul+srP37af8rBHUK9VH4WCvQSyh6XqrUnwUugGTiO5jX6mhYIoWYzeZ92vvzbQG/slnsQLv4TUw36ihB+UfkzVYh0N00NyqmW3E/QJtEpDLhctKre1xjXOBhrtdgOqDxr7RP3I+nSzn1TdBrg5ViejkHbHuUd1sl3FXdu4HQZHFClUaR74SRsdEWPbLzt9bIqGN02ssiGb+2D7v+Wat8S6+DHuLQ7DvIkGhrKrgTmSZWu9w18SOvPH04njXwq4/ffmC03RopZoeFrKb+GCUPm+Op9EDBoQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c63a4b8-46f0-4d17-fece-08db2ea93b74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:54:18.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hxXhF7A318aJvO8pNUNZzdPwTfr+cJ76kqrFYbu8LnE6HEPQoZVSv2fyr3TNo20DgCsFaB1c1wCy4papbMw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270080
X-Proofpoint-ORIG-GUID: Wfd2P7eKSNKUgNnI-2Zvvj06-KwEEoTK
X-Proofpoint-GUID: Wfd2P7eKSNKUgNnI-2Zvvj06-KwEEoTK
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

check_barrier_error() is almost a single line function, and just calls
btrfs_check_rw_degradable(). Instead, opencode it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7f3fa5e2253d..745be1f4ab6d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4121,13 +4121,6 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
 	return bio->bi_status;
 }
 
-static int check_barrier_error(struct btrfs_fs_info *fs_info)
-{
-	if (!btrfs_check_rw_degradable(fs_info, NULL))
-		return -EIO;
-	return 0;
-}
-
 /*
  * send an empty flush down to each device in parallel,
  * then wait for them
@@ -4171,14 +4164,13 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 			errors_wait++;
 	}
 
-	if (errors_wait) {
-		/*
-		 * At some point we need the status of all disks
-		 * to arrive at the volume status. So error checking
-		 * is being pushed to a separate loop.
-		 */
-		return check_barrier_error(info);
-	}
+	/*
+	 * Checks last_flush_error of disks in order to determine the
+	 * volume state.
+	 */
+	if (errors_wait && !btrfs_check_rw_degradable(info, NULL))
+		return -EIO;
+
 	return 0;
 }
 
-- 
2.39.2

