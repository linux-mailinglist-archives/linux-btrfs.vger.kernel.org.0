Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2478B0C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 14:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjH1Mmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjH1MmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 08:42:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FFE3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 05:42:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S9OEs6015425;
        Mon, 28 Aug 2023 12:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=m3BYCdxkn1DQZoDX7W7vDDlj77iSOYyEKMnrYMWyNtk=;
 b=GBSapkUvnIcDdmNRp5TKMbbJIL5EC6tUneGd60Q7DDsbgD8Ba5xQxRN8K+Tr62KpR5Sf
 y63RdRLLCuzfB5OHcVV+OmDCL72MgHO6Uo6LyVCQKnKmHqDHQAFnFRdb2/CRaGRigT0W
 yBYFKcCQQCn/voOqKkatUPAv9csQJjAzt/5GmNvLkt2OmWGyo1CP0khY7w0NZFAcK/0Q
 /+tnc0JhXTg7ls87+MxCmInjhZcmB/cw1us6zEp2SCVySLG4IWMv/J1mWGMtltU1mwF7
 kQYUecXs0VgIfQut0cx4JTW4/h6dWQMAFtFaRsYH9+usKm/FCbBZ6gpgjZRmU0VWMyuO 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdthnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 12:42:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SB0vfZ032924;
        Mon, 28 Aug 2023 12:42:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dm58mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 12:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaNk0jbrF8B1OXEWjahThDUg6ooxRke6XXZnGD+is7lgMuYaT6pdt5EE35VgqZq1oDV3Z5QZ2WVYCQhHHMzpBpaSagK5jUM13Wr17jrTTbz4ZBW657YbS0/53yzHcl6Y4GxbONN+xYqctoHZ9fo82tJHqfr1AaJTRJwdz84DAcfFg71zkC+WQdGPOUZHuOh0gtwz+me02q82JKWycd2ZdOpwH8mbz0MmaW6v9BukHpl5lZjEwEW4detXP7H17dwFWzD6SLOI/CyArp16xafNZjwJUUsEnfwrTsQcLbkXUJT9udXgOt9+uQvjE+atpZdqW/mt4c9kFQZglGiQ1WEdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3BYCdxkn1DQZoDX7W7vDDlj77iSOYyEKMnrYMWyNtk=;
 b=VU1ptSK4s9VLEyqQfiibJzHP5BWvThHJIDuw0qnR96tO1QTycTP+5vuinAjaVXpBeBvheZY2b+G3eZtIOm/y36poonlWESj1c44BYL7RaZcjjK/lVoUdGVrP39T3P3xODWw3Ao62YHKZUPeGKpP9YF65X32mAiZVp6gAd5hGKnnLYvVi5jMPU6Pdx18n7y26Mxrtzp6GZklN6uuiU39L5xF+aGURmUsxIKkg8tcN3H8tGPdaq3mo1Z1BXDRnbMeZGc20QQ+I6sz9gvP/n9RhcygGhsuZujHwUCuDddJ1W9WjoBOwVxNLTW19UCMFoZd/C4HlKnl7tiDREGqexYVBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3BYCdxkn1DQZoDX7W7vDDlj77iSOYyEKMnrYMWyNtk=;
 b=vQED8h0IjuCuXtGbC0VwajDyoTtK4PS4kUCA31S+h2hEokjzAItzXcDaEE5xEBYlbvsWXwYQJrxzgq09qtBCDDpjvcvzkezbTuQz1vRyevWiDi+69DPvlYH7AdUxhxyeVI+ZWXmBLcypRoOfcUHt0ZwY+pRD/sTi38mVoQpZ92w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7852.namprd10.prod.outlook.com (2603:10b6:510:2fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:41:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:41:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs-progs: print-tree add device list
Date:   Mon, 28 Aug 2023 20:41:39 +0800
Message-Id: <1c088db3e322e8f8d5b332b9f3ab582e06f66387.1693226314.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 62980f37-4db3-4069-90f4-08dba7c4278a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJFZ+8K2RBfCok/vZdMqOYNas5YpmgTs+AkKOOPGJ9nQDrLhoQCAbzGVUK6k9UhEUtCB1ZtrY6t3P5rlVfodB7RHfWW5ee91D7H8e10G9fSsQnHGF8OSU0Pl6Vp9cBwSfecapCahA1OwY/WCDQTZbloi3PeHRyQKrrpifwnaY3DZOsXBCrRuEnIfb1b0AEKvOpG1yaaQ7Ah83kxss/CpH3KXf9Lqa50Kb40JHANFpPJFQi2oW8c6gMjcQBZnHmlMssCWlnAQM7NJkuMDdzW+FSBRNmW3SwDaAwwMhq2U9RcARF4DYEuEUpeaekWcdGO8QWCaQHt4nO2EX/5DjwC2iFN4uDCUkzKwgWJCSXxJ+YrOsAPYhxj5Iqd/0oAdiu4myremX2/gsISoRMazy1JvK+cQ1hemX090MYP4XE8+qOjTLUSDElceHsWJpDHwY0m62BdshYnIi/MbXJRhCcEBsQxvFK2WHRH+t+mkY0FjLyNqvSTW2qyOWeIDGdq6xffivuiNiFmVp0oMtpwlXyz5fNB8gj20rZXTe4pwqbUOLd0Sxj209OR5eVZuE/h9d/3/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199024)(186009)(1800799009)(6506007)(6486002)(6666004)(5660300002)(36756003)(86362001)(38100700002)(2616005)(2906002)(83380400001)(26005)(478600001)(66946007)(8676002)(8936002)(66476007)(6512007)(6916009)(66556008)(41300700001)(316002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwzPhZp8Qg8dTdUaXzfIeM1Q+JLNizT6DIqjEPwRgv8/uGzcCAA40NvNbhLV?=
 =?us-ascii?Q?/f5mlIgUeBvZvuZxQSriEdkD4TGLFLeLP3kdKS+0DaTqiqfHXqXBNMqzTVl3?=
 =?us-ascii?Q?Lieg6GQH85oiTJJopJpLfN7jdD/RaiOem8E+ebx0fclpl2Ejm+wiQ6FYbg5I?=
 =?us-ascii?Q?fLeg0804+oSzsnQQDyO32bbf2jXOgWFKrLMGcUD534ECPNYp8LUMtoWDtyZc?=
 =?us-ascii?Q?sLuUyQFaXveGl6QDiL/8NTawq/8FGSZrh9kCAREq6Ovoy6h6OB8EatnXWW0b?=
 =?us-ascii?Q?+zTSoqKSpL0oC8CnErQRgn+VxhQz7s+Q8te+trPp9sGxV3FBb1fIoUqbg0LC?=
 =?us-ascii?Q?YSRk4QcBZCLobqWxRsB7vFyQ4Y82nrA7+RjFX48dI3QZrY8QDvD6jnF/mj1H?=
 =?us-ascii?Q?vau77xSMmjqTemzPBP7ov4qNPYhondeQVmxJkWVG/B3pZT+Cnz3D5FlViT2L?=
 =?us-ascii?Q?nhLaAj6ghb9M0eBXk6j1xShoBKzmrSKJoUWQxARO4HE6QbdJ7nktDpVot/3M?=
 =?us-ascii?Q?6wBr/s3k9Vi75K1oy1T8JLokCCfg9Dk7t++vin+D/UM0Ti3Dut4Yz0DNXsNU?=
 =?us-ascii?Q?wbY53pb95MgSXqkx4/vj4OrhXunK2BKABGyQpwZpdhOt8Njlj7YniLdqwB0b?=
 =?us-ascii?Q?lmbl6jHXoPdwDAXxs2iY6bTbuYwtHYtBnQ4HIcO7q7E8ubC0ouPz2IygNRWa?=
 =?us-ascii?Q?kRxYjLn3PE76QG9J0X7WTxpEYP2IdUJuyD4hHkdus5E/S5QmGFDTsM3WIOd+?=
 =?us-ascii?Q?8Gj24liwaLB1A8yi4dE7/wd8xxreSYwlNrg1t7GKkI4AKKnAHI1Dp3Xu/eBm?=
 =?us-ascii?Q?R0TCqhHk+mcDOyIDxP2d1Hm/LZRZ8YykqGvKMuQWAfPmurV3pxzBVDNKYSUb?=
 =?us-ascii?Q?QvO++BtN0iLLKZmgCJL4l/i00Lp1hBr2/Jqtz22+thd3m11vKbeivkNUDVn8?=
 =?us-ascii?Q?e/ymwsxr/omGtEpkSMhddSpvSFtpH8lz0+OWHFJDVrq+VLwac//mM5685e9e?=
 =?us-ascii?Q?MTlz8szDMTWy4DvA9T6as3kK6t7cTn081MUgDodT77CL+lvHEWgZUHhwPcbq?=
 =?us-ascii?Q?q1ehKGn0IW9R9G64QCWptpGPtxcIdurjjyWNOkiK56SRNmU6/efaXmwSLjP0?=
 =?us-ascii?Q?1OwA8yNMq2ov2M0r+/n92+U1BVTdlYONghx7nck7TCm6WV+wnxCV7sZQgSIo?=
 =?us-ascii?Q?JjTlE4tnBKEjodqx6hRlgNsCbl7kMQWgSWLdTFZzpyWMaQrIJsFinCbr2P4y?=
 =?us-ascii?Q?XG2n+XQB7zFpm+vI6jaFT0UF7fvYHm7a70pv0k31bqKZmnFtDbRramlRZh6p?=
 =?us-ascii?Q?k3Gxfr1S5UwCrSB6MufrMFIq/zNxobwdnfcf3H96YJQ5MNeIktgboO8PTg3v?=
 =?us-ascii?Q?UcF455FlYf373L8tZqa0caEXuXRzH6y2b8jdyv5CTDn/YBO7IH6l+7EfuVDV?=
 =?us-ascii?Q?7XPYD7J6iuvGR0cyOJX22TUlLw8wi1WXP69UBLEVAjL48J4HxgvZZoejBvuk?=
 =?us-ascii?Q?/KJie5XdVvzZ59FmHWNf1kIv5pTSkj7dTbtn8UCGH9l35Ar4BEL+qkIXXzAo?=
 =?us-ascii?Q?43VkU6F0OUdfzDdlCq1ze55gqFdz7fVW0akvNYih?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sTy87/T7ydU+wIOtWInQFd45otyqLeZvh83c/AogpwduqJbNREHe7YSJUPNo/5Vb2d/Ry6RjUj0xNapZ2hp5HfRYIHTG75TlRrmJR7kLZDYPQ2/fErm0igZiAOZBBSgyUcFoXOKBQsdebHY5bCSFELjq9b79hGvT0P2HBaWWOiRDLEG89ElRjuwtIe14thMOR35OkjipovqwLMqBPL5hMvqUlBxew+2V0w3iZBPFa94UcRQZmZJnrEzp88mA9UWf+xTui9yktSkNV9HyR11sjCkeb42K36aInCIfffw9cWUR4DADkzMmXghf3b7ymCZbgFTPFtJu0OmzooBN7P+o9bcHwXsElX1Vu02D08Z8p8KfMBXAtaaGdr142RVC4mmBZz3/8rgxD+m5EukmxPX9X0k76qZi0JeFWIakZ4+Ml7pKZlEZ0XwaG7zw7/GMsoBwitLdPCr4K50vsgP+9Rwuzf/lNj7IeWE8RateYIOyF2abRkiUTTWw1Xs/Q6iuf9ghRq9v4cdG5lQjXBB4YGuupkKLnK7pseDtTigBsqFElled5R0d+nWL2eVW1QUUH4P+LPHlhgTUeQvd794GqHRI2EII4MwcVXjhqb0eI47xMt0TD6EQ1U4aPiI9ZVoFFltcbrG3sm02cCFnYQhhSrlvz+XF8N/rUjBT/4qCpxd+6YTwTmucdH7QYLS7MAZRU4MsQRQRevIyoj3EmO6jjNe3f87TI4bqJ2c6THdDYIMOmo6mHlvcTNZDuwygKO0bROD2aUjuKA2HARfo1twRY8fsyzbrUCdFqky7uxOLIv/ua88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62980f37-4db3-4069-90f4-08dba7c4278a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:41:52.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYnDWC4PF5GY/nml2aphTUxukQVed6ZaLxFl7HnPHpd/OOK9zCb53Cmxu8NJVBPJGcP+JDYX5syi28p8Uh563A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_09,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280110
X-Proofpoint-ORIG-GUID: MT9imoMt-BcWL8iVgFAC7mANCklqeiAh
X-Proofpoint-GUID: MT9imoMt-BcWL8iVgFAC7mANCklqeiAh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A ready code for printing the device list for debugging purposes. This
helps investigating issues related to the in-memory scanned device list.

Example usecase:

	include "kernel-shared/print-tree.h"

	btrfs_print_devlist(NULL);

[fsid: ef1fdb64-9cf8-48e0-8657-e06ee2b3ac80]
	size:			144
	metadata_uuid:		ef1fdb64-9cf8-48e0-8657-e06ee2b3ac80
	fs_devs_addr:		0x152f2a0
	latest_devid:		1
	latest_generation:	8
	lowest_devid:		1
	num_devices:		2
	missing_devices:	0
	total_rw_bytes:		1048576000
	total_devices:		2
	changing_fsid:		0
	active_metadata_uuid:	0
	[[UUID: ac7dd718-fedd-4640-8b99-12a8cf45ae87]]
		dev_addr:	0x1542470
		device:		/dev/loop1
		devid:		2
		generation:	8
		total_bytes:	524288000
		bytes_used:	60817408
		type:		0
		io_align:	4096
		io_width:	4096
		sector_size:	4096
	[[UUID: 0e4fb27e-3855-48cf-820a-684a37762549]]
		dev_addr:	0x152f340
		device:		/dev/loop0
		devid:		1
		generation:	8
		total_bytes:	524288000
		bytes_used:	69206016
		type:		0
		io_align:	4096
		io_width:	4096
		sector_size:	4096

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 76 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/print-tree.h |  1 +
 2 files changed, 77 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index b7ca8b7e218d..cf0cd2508d76 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -18,6 +18,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/types.h>
 #include <uuid/uuid.h>
 #include <ctype.h>
 #include "kerncompat.h"
@@ -2104,3 +2105,78 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 		print_backup_roots(sb);
 	}
 }
+
+static void print_a_device(struct btrfs_device *device)
+{
+	char uuidstr[BTRFS_UUID_UNPARSED_SIZE];
+
+	uuid_unparse(device->uuid, uuidstr);
+	printf("\t[[UUID: %s]]\n", uuidstr);
+	printf("\t\tdev_addr:\t%p\n", device);
+	printf("\t\tdevice:\t\t%s\n", device->name);
+	printf("\t\tdevid:\t\t%llu\n", device->devid);
+	printf("\t\tgeneration:\t%llu\n", device->generation);
+	printf("\t\ttotal_bytes:\t%llu\n", device->total_bytes);
+	printf("\t\tbytes_used:\t%llu\n", device->bytes_used);
+	printf("\t\ttype:\t\t%llu\n", device->type);
+	printf("\t\tio_align:\t%u\n", device->io_align);
+	printf("\t\tio_width:\t%u\n", device->io_width);
+	printf("\t\tsector_size:\t%u\n", device->sector_size);
+}
+
+static void print_a_fs_device(struct btrfs_fs_devices *fs_devices)
+{
+	char uuidstr[BTRFS_UUID_UNPARSED_SIZE];
+	struct btrfs_device *device = NULL;
+	size_t sz = sizeof(*fs_devices);
+
+	uuid_unparse(fs_devices->fsid, uuidstr);
+	printf("[fsid: %s]\n", uuidstr);
+
+	printf("\tsize:\t\t\t%ld\n", sz);
+
+	uuid_unparse(fs_devices->metadata_uuid, uuidstr);
+	printf("\tmetadata_uuid:\t\t%s\n", uuidstr);
+
+	printf("\tfs_devs_addr:\t\t%p\n", fs_devices);
+
+	printf("\tlatest_devid:\t\t%llu\n", fs_devices->latest_devid);
+	printf("\tlatest_generation:\t%llu\n", fs_devices->latest_generation);
+	printf("\tlowest_devid:\t\t%llu\n", fs_devices->lowest_devid);
+
+
+	printf("\tnum_devices:\t\t%llu\n", fs_devices->num_devices);
+	printf("\tmissing_devices:\t%llu\n", fs_devices->missing_devices);
+	printf("\ttotal_rw_bytes:\t\t%llu\n", fs_devices->total_rw_bytes);
+
+	printf("\ttotal_devices:\t\t%llu\n", fs_devices->total_devices);
+
+	printf("\tchanging_fsid:\t\t%d\n", fs_devices->changing_fsid);
+	printf("\tactive_metadata_uuid:\t%d\n",
+			fs_devices->active_metadata_uuid);
+
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		print_a_device(device);
+	}
+}
+
+
+void btrfs_print_devlist(struct btrfs_fs_devices *the_fs_devices)
+{
+	struct list_head *fs_uuids = btrfs_scanned_uuids();
+	struct list_head *cur_uuid;
+
+	list_for_each(cur_uuid, fs_uuids) {
+		struct btrfs_fs_devices *fs_devices;
+
+		fs_devices  = list_entry(cur_uuid, struct btrfs_fs_devices,
+					 fs_list);
+		if (the_fs_devices) {
+			if (the_fs_devices == fs_devices)
+				print_a_fs_device(fs_devices);
+		} else {
+			print_a_fs_device(fs_devices);
+		}
+		printf("\n");
+	}
+}
diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
index c1e75d1e117f..da17c96426e3 100644
--- a/kernel-shared/print-tree.h
+++ b/kernel-shared/print-tree.h
@@ -47,5 +47,6 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata);
 void print_objectid(FILE *stream, u64 objectid, u8 type);
 void print_key_type(FILE *stream, u64 objectid, u8 type);
 void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
+void btrfs_print_devlist(struct btrfs_fs_devices *the_fs_devices);
 
 #endif
-- 
2.31.1

