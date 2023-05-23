Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FD70D9D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjEWKE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjEWKER (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62AD109
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6E7DY024594
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8PxtplqlOtSNhUrPu+NECbIi5Zho78ZvS1cbMOBIAHo=;
 b=vpjElfMgQCg9vHNBofiecfIiK6E2DpAUVqtGahC14bdaImjtT1jxzM+wBFhqQGEVOW6d
 yyr1HRElsZ3gGTbTg2wR8mxA7OGM0bkZcUuq7uqOCh0ibshg9sHcXjseC7v3C6d9KJ0b
 j8YdyOWdD7yBlFxc4TH0kbbH4QZdMCzD1SvgJGfWXe8In7hZsen4i/3ahGGtBqm/YtAf
 2STDN2pnEs+EHu+axgAYIZfwlE+k9Su86ixeMObiTorxxS2dENFJrm7nBEh8c+j0M5u5
 RSg4rf4zcKYAxzEZy0wHv2taQafvbNRyV3+ugT349xbp1mS6FTz+4BQOt4/wV+7I9TLT Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp7yvqnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N9AScG028899
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2quhmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFrEkUlr8WfEUglqmxNdHVN9eOCdnNgR7yhCwfwlFTCQIJdzhcz5b3CDIoh3TNu97XII9ueGxXdrkvDnji85K4QoNgRWRM5eapk+CVoTRl19rQk8g+KXJX7Gk3B3R2jZ4hzF4XwhYXJXwxcyPIlmHghTv4dW+b5XfKLoD7rHMPfjw0irJT6IWry8+OPS4AJ6XtCKuxKHiIRxPMC2R+JqMF7ToX6F+pG1bUyvZJptK7ncBl8CMi+YwyHp+oX9gXwksxI9N/adpNK8w03GEiU1GwLkXjMA8fDWWCJCcub3364en+vmJBmzvEElUoK6QKnP75t17DV8x3LGNsEdOnF1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PxtplqlOtSNhUrPu+NECbIi5Zho78ZvS1cbMOBIAHo=;
 b=j0o05QVtKbd/r/iamY/LAAvnUBTYXcEHrnMghaNhmd7hFWY3QW6ZrCU/gjHZia9nHQ4a+/l80WpT7NO/uMUJx35+tNbgjrFWuhR1sge7tUttH8/SgZ1sPWAtihItrVpRCX7m1G2LBbWHAb6HZpPPAxrp+KgZIMRuK7b29c3a9AkFyzHGkS2k0anRYXGYIPWJJVb7PR4lRgy0MFr8A+zfRT915XK5YfRpqK42vmw6ym5OW4tOEr7/f/8JgOAbzgVd4jV80wXNaBybYsKh8B2Ur2Euv45L3lK8HsyJUmSyPslZzwfCaaYMaS+Ra8GVYUb0L7O3XtB2aq7rh4HDrVVV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PxtplqlOtSNhUrPu+NECbIi5Zho78ZvS1cbMOBIAHo=;
 b=dY8kmZlLJnz7k++tsCIfPqYGb3fJe5lbp7E4I8KvZ1JxVlvazPvpAsjmoIuYuqNN+16yUzUZNvrGKPgMIb8zhaj3nRiQDpEvWu6VuzJL6vZ8/tUr4qR/N6Vn3+XS5KrFRqYQ6sGeyu3sRQD/aoZFKpTR2Vn09ejzTxCbn8aPvFE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/9] btrfs: localise has_metadata_uuid check in alloc_fs_devices args
Date:   Tue, 23 May 2023 18:03:17 +0800
Message-Id: <346ccfd4aefd8077db8c0c908c53718ee5090b63.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4fb30e-6e73-401f-e137-08db5b750f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIX1wBowffqXEVSEMfeh18iAy1LPEXL1LtIlnEPk+Mu+W5Bceo+e3aNfkDJWsizJ8ThBGBf/wDPLrNZbZ2NZJvwJZelEf5yGiVtCDyOjyDk+h6XpAWEkIUbw/AEjby8iJJjGY0CrCzCyoPr27DxiyEEvvV5efb44H7Lyzhi5ZdbBf/G0nLHjQ1elXm7wXITucEobeFHjc9E3JNsUW4b0zqiMoi/kaq4/c9XT00/wy44gr5L0G3ZCvptuw8efCUNygoIa+70WrqqFt3ptugQZUKzNnB6sewuYA5wkJqUG41gxPyCmczOW/1syJJzssqn3AiZUHnIN0E/hXGpB9IXmL8TDxW04yRhPX079czrekmaW6KBDtTSfPe2L5zXm3i0SfMw9F0hGIEFe37SJCwiq+kMyZr6YK9xDeXO7Q9oyDLJUwKbTCUZOWb2E16Pc+hz1uQGgyl7R/7z2RuxiDSwEHAuDmIuFDdmYJU8O1/51ZjiyDfT0SNjKWVwv3Ch97fyH/lfjyD9IlZTODGh0kSpj6fh1PETT8yGUkEbdkF689mx2o0YUdsuXpmP/B8a4wptu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(8936002)(8676002)(5660300002)(186003)(26005)(6512007)(6506007)(41300700001)(44832011)(107886003)(83380400001)(38100700002)(478600001)(86362001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(2616005)(36756003)(2906002)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrlyT/ucVYCGfDi2ZzodDPiFEX9acat6KdZ5WHU1edVqax/U4zV/poEsLoEF?=
 =?us-ascii?Q?MJX5/RXk7SR3l5ALEFN5YbjRXt2SDOg+pH4uIvA3hOm/Fb3RPPjOaZBy4jTe?=
 =?us-ascii?Q?rFmiGIDBFcR4E5gRIDfIs28fgC5vUFy6Uu/THjlo36irPqV7vai+pbSZTpLp?=
 =?us-ascii?Q?7ifcSVWkyqe5ovkRy3Q7QL4gbZS64BAcEh+CHoKtrW+O2b87hIy+qpH4STDe?=
 =?us-ascii?Q?1ht2Cby3jvuy5Wyl2rJESNHNFrmmNVIBqQXFWmE00GQLanmlro3co8WUcmbP?=
 =?us-ascii?Q?G0/s18wfYuni2XFGddl+auujvKYjI+7W76/gZoF5ilHAC7fSXU20KpDKMfw8?=
 =?us-ascii?Q?4f7OXxVy+7ZZ4tqNPLENNj+0YSYj0WDcPMobL2S8WJKUJVc9xR4p9KVl7Zlt?=
 =?us-ascii?Q?L6rvtGiMZImPceShVACE+b4wF83TNavoc1gD6Zz6mLcfBDv1hT9SA0GD56SA?=
 =?us-ascii?Q?EOEZE9v+PBi7TbRr6f2Ci+A2iTG1hy1JIbM19hdrEk1ky6LtfrKA1GTuPadh?=
 =?us-ascii?Q?zAmYb5f27Tsp1Sq/gZrc2YRxrEIMrGqbv/zSVuR2ggsmL5QYFWvZDepsmD0o?=
 =?us-ascii?Q?pSmyFjdGXltM8rP6xElVtXssac+Fvgvm4MC+AwRvPBDeGb/cN0kkPy2JjD4T?=
 =?us-ascii?Q?LK+VNpcsKVyn7/43Yq6HyC74zLQaZuXwCQUZ5mg9rrfBszv6hb4892MtwlCB?=
 =?us-ascii?Q?ghgd+epoaQFVWv7kfeFNVQz1AuppY0IZCshIOPY0TfiSGQOScuA8UGC5WgiV?=
 =?us-ascii?Q?FHgoW645kcsrBnQHzzo57hJLFlPHqSIIeYVblyI+KnvJ6aukp8QWQV0IT1ts?=
 =?us-ascii?Q?48E5Rr12YnZQPpFnjia6w2ZI46RdbxbqVcacwhyTtQuWUboBdFS0IPvDayb3?=
 =?us-ascii?Q?iamJn/GJXNdSapJg+eHk88ut9npquwW5OFALgwBp9Sv9BqdIvgxRJDeKbD06?=
 =?us-ascii?Q?JnCzBBdDdgQLiOVhrh7Mmvfxl5G9q5S/NX53VELFGVRDP0bJI8HTRgyprt8O?=
 =?us-ascii?Q?1bzzBAgQ8HtKnLCJndizER6PccMjYpn2DTcZw0LUwSAb8hjYE6fWDDffVGV0?=
 =?us-ascii?Q?6vstoGx0PXX7u3t/iRmwZLlWFcEBx5mCMOjojbl6IcK5v2HmauBuPcefQsvA?=
 =?us-ascii?Q?CieYAcrmJaOJCvYTwHrE4PzA+tI4A7us38/SVkJwuhfCwpEqNsP2LoGCTEQu?=
 =?us-ascii?Q?UGJozm7eYgWgOn7IHvrbzduyMSakG0+ZNaPJfR7UeHkw+Mvu9NJTOw+xSRO2?=
 =?us-ascii?Q?01NSVyCRfnaaZTJVf0hHEKUQ98Gm4yQJN3ftipltfn117VJKm+NjFUwBDuDf?=
 =?us-ascii?Q?Qjn+tOkx9K6Nin8MKLUWfZUGj0MN0PjwSBxAlG7pK6sUqTw95OEcDlAjfERx?=
 =?us-ascii?Q?mQqcwznJ5fOgxAs2WowvHMpaP9xJD2t8SCCp91w+ZrjWid4edV6OfxWmcAON?=
 =?us-ascii?Q?pNv7yCvxGx1MPWq7rIAMQhEJ5z1H7PF6yDffVgWDlpAg2Z2cBTIwbY1r2WE/?=
 =?us-ascii?Q?aSM7kxyzPZbNdFnCfPwYoJqmb8FvGhNcFPJXTE7U6irAF6MOi2q9XaOnE2TH?=
 =?us-ascii?Q?dHuuwGuWb9CODz4UD719Cgaid0wy/36Zt5epxfW4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pPYf+St+UlOHxCouFUYcd2H+5ngpkFnUR1yFdwr04Dx5wSSENh5Vyao3AHfgvaddBCQTn7qmi0mZhWLfpNTRQ9MblRvXc1cCitrIwlWW9+8t6aMoa5ugNVqxsxniiwJGUGJITE3Zel/7GxcIAi2RiQ776yETsci+wP8W+dROPDrRYHFftJYss7iLpkBCN1LVWa3Sfgjd7jHiBS9FLyPrWA47Lt4+E6p6RS05fgex29uskmYCQtyvobK1EpcFFjoKc/Nbgo5BN7bVB9cRx/I2e0/SZwpHjBIohkx1wpsTS2hl6GuqT/QAsd7Iwd0ziB7O/vMPBLJWZc4o4Zpw1pHv57VffK0QLDaw6ITJ8w+sR1l+R/cCLLdFLPHTYnRxM+i22piAcgdqVJwe02vQI6pW+ZysXWR/6A/sHamt7K4I3JNz57jOoXdBq48VYlv/F0iCMwzZtMVLjmoIL1oVdZtzBLv3zTcV4h2BMlvf/hv+9Vq8eHJ2mfZcCpA6QmHFPLBmrXpj/AmJY4zfnmXa19uitJ4y2i/O9RwKLzBPlvsHY7jqNDJVOAmyEfPwHe+cyCUE7db73caVDLFy4xolGakfTCnmWjT3jqjo35sbSd0/rBxW4NyhgAbD3BM3cJSqKUJZh+J74HwB9yOwbjC3ximp947B92JyedogQOHIUleDyBDEm6JIDHdf0QjaRNJt/jMYnujN/0J3lwSYfbeCnlQqLBlVJ503oETa7towsFdYhco9UJHJ8axvUBEcDwFZv5AdBmcJAOdiqnuTRXZ8uSAVuA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4fb30e-6e73-401f-e137-08db5b750f3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:12.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Idv/NpYMUxbHY/+tvPSAoKD4RenCfApBpvM4pN+JzXXIBUFPGZvnsWzKVEjsfir8jd0DoxSRfRI6G294RnZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-ORIG-GUID: hINL0J-H48rNVD0ngl2AEdXWBuV7P1lb
X-Proofpoint-GUID: hINL0J-H48rNVD0ngl2AEdXWBuV7P1lb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify %has_metadata_uuid checks - by localizing the
%has_metadata_uuid checked within alloc_fs_devices()'s second argument,
it improves the code readability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6f231e679667..95b87e9a0a73 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -791,12 +791,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 
 	if (!fs_devices) {
-		if (has_metadata_uuid)
-			fs_devices = alloc_fs_devices(disk_super->fsid,
-						      disk_super->metadata_uuid);
-		else
-			fs_devices = alloc_fs_devices(disk_super->fsid, NULL);
-
+		fs_devices = alloc_fs_devices(disk_super->fsid,
+					      has_metadata_uuid ?
+					      disk_super->metadata_uuid : NULL);
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
-- 
2.39.2

