Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69F6A1565
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 04:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBXDbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 22:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBXDbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 22:31:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D17166D1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 19:31:41 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O1mpuC018253;
        Fri, 24 Feb 2023 03:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/VPQB0Sy2pBYwdyjF1wiK3He7RdMmG8bLCrWgnrYH5M=;
 b=JxLW3D0xtHpI9EDpZLvplBJaeTPSNPWNjlWyjYpzbu8bWj0QnZbrMAVxdFA8RA6Rj085
 ba+gz1sxQbbQyi7k37l/jpQFXYDMXK97DHaGzzOiZF1l/LsoN66XdeT7ZTc57IHJfkYc
 YihIks3ovBvsAVzMw8/LF0IKILuGsS5Ij04HL0OYNLhfG93LAUwaAYVssfJMCVgTOUaG
 jPeO8TpvdYyRIw86daKbUFzFfsadPPtqBI6US4v7wVWO7o36YxmZn7IBPoL+e1hnAsV8
 eWQIfl07RgsfxNaxhlAKWvhQCWJU62ZMEWVk1d9NHQnacBLgl8RJxIbpBxgFgBJxi5/7 LQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbv230-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 03:31:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31O0XevZ030290;
        Fri, 24 Feb 2023 03:31:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn48xq52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 03:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI30qDt5RWGYIM0HfkD5U+WKBBjxTiYsnUIwDT12KqAS7WYiiUw76n1UVLzO/f7baExZrxaNUMPKB1TC5wf2ZHiSPqravRuNfFifVezAaRMYYuQRei/CcgjDOsgEPMb4O9VeOaccrZhk6F0mX/bit3BA3DJ3DQShMInPVXw0BhcHejulL5hO6zieHWb7YASpHHW5S2/MjR/llNa+Nb/JUfvc/uQgX+QN0ucI32cvQhtxQzX4BtVfR5QFYqskQTFM3nUIWeYkKM5agb5W/DeyXLA/Pfs79Ha+mRWmM8PpndOVe2B6jUIDF+MOO7ZzMYG7bzgPKMGdm0ckurjQ8gAd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VPQB0Sy2pBYwdyjF1wiK3He7RdMmG8bLCrWgnrYH5M=;
 b=c0TXIsa+P8klcsH44evR16OYEu0FM5OTvxOsNA4OuHRNsFJJx6XbI75+4gXlB3fMD9/WWhlKVS/wDTsbpc8T6gNO6r2vU2AAHfmN463BM+GzJEBc+aoafZiQ1kPdGsofMocgiASZ3sF8rI1eFPFQAS7OC3l80+Xi2ZZBNoOUYm4QfAERqcGbVeO5FIhufXjqgCk0ktAkCZqn14b7z8dm8jTX1f7m0t0s03vUFfkIMGGKyaiwX8zzI1f3D/Aw6vS5jVZVjdnxUZh4rj98NrpsWBYVpVhzq1ZK0s4CodbfQHoRTIT9jv8NvB5NRYRv4dl0KzTdo5c1x84UgFiGnclFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VPQB0Sy2pBYwdyjF1wiK3He7RdMmG8bLCrWgnrYH5M=;
 b=uwSkdYr4zDKbDEIUcxUCpgKeyU6YwMMdz7BBLmNi7I8SX7up0RbB/JGsW/VaNEEMBt0mSg7z7HB39pXuf45QYKrEhul6mNKHfq6vlawbL1aaTZkpLaHzOO3rP8szU36nxPQP3/c4riVpsS4Kj3EtwrnwTpJe5CqUAYvf8M0gmRI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5907.namprd10.prod.outlook.com (2603:10b6:a03:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 03:31:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.007; Fri, 24 Feb 2023
 03:31:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3] btrfs: opencode btrfs_bin_search()
Date:   Fri, 24 Feb 2023 11:31:26 +0800
Message-Id: <10cb860e9a12aba47b67457f3a13a8a3166cb60e.1677207967.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223201918.GZ10580@twin.jikos.cz>
References: <20230223201918.GZ10580@twin.jikos.cz>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f207ec4-c1e0-4793-26ea-08db1617a11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: st179s1oQXxfQJhknQWzWtD49byZo/CiTpDOTXTHgVB3XyK0GwAxlHviw1q4LRtlS+G/jv40QxwYUgV1WKZWxSjFPGN0A1db4a3xG2XyFxRn4p5PwG7mb7DQ5ERfAyyfzGowe/5OGWSJc6w/5ETdeSSATqPh+dd5qjtKWNrDUsl03aChZ7zVQmkze+xcJqEKxdIv24+vxyc9G+dRGruJ4FyNRQRb1g3ho9do9wEjj84GA+xU1eiYSm0fcZ1ripDeturTtnPRYUsu69fpQdqHG6Qo6r08QfLGbUTCoBjuNG5Fd4a1EsU5bOl+ygk7DMtXPbQJPpN4L8VxjmwhsY1rQp+fwBJuNBYyNrlGSHJ4HtHkkXQ/X9jEc3h/HkqFe0HQ8HQNkXnO5KuepGax70VIV8XQi8L/s1bLJLei2BdfZ+/5rb486vY3EW4fkDnT+WQgT7E+WwmpBxitiVkDPsci8v202GKNwd3+MTXu2aSUoSkKGGo0MIWhGRvVo0zf9/BoOoyDhhbRn8YTgPbHsnVy+B08OOVcvZXPetM030HFXmKCMJFeeO2CEG7YaXtFKhW8/0SuYXFQaqciiPP12LAgDMqf4cpx7WC0/W8TkqnM0Qr2BtnukXn7Es3vhzS8Fv8hCorMqvLpgHzw1/qPDdTlwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199018)(83380400001)(2616005)(2906002)(186003)(26005)(6512007)(6506007)(6666004)(107886003)(86362001)(38100700002)(6916009)(4326008)(66946007)(8676002)(66476007)(66556008)(41300700001)(478600001)(316002)(8936002)(44832011)(5660300002)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jLnyjRrLqECWdvG0fPgwOr2CjcZA9gwX3JuYM4bOQ8gLi74vS1qn6Hp8nBFd?=
 =?us-ascii?Q?7hDjBUvhCUlD5F1DD7M84XlXCtbNqN52AhUzMnt5KcQWvJRXhUYCmeQGDUYN?=
 =?us-ascii?Q?mKY1pCaMbshRtzf1gndtLNR15h0WQSkTvXn21qojzhA8x3LvgVcMrHAHdcZs?=
 =?us-ascii?Q?FN2VfttCtOXGAJ9GAn1AqcoIkftx6Kuf5m6xylTy5VpAHWX9n7/qNb5YTiaB?=
 =?us-ascii?Q?tHtT8NjjqOIr/9k2xNrOUeC+sqjkN7SipuvPEgsgI2ZyXYA/BX65EGHkMmwi?=
 =?us-ascii?Q?qPSCpXenQGKiMKnRQT92MVH+TjIU4aN/hkwwYv0rDV/JI07VcM7ticqyxUf7?=
 =?us-ascii?Q?mMZqC/uqci3PfMF+P6rHih/w+knuX0amkBuhMpGK5q9pCAeP/dFI1gAQ9SMN?=
 =?us-ascii?Q?om2VWiIEKGlg459qGPkXwN1L2prJa58zioHsVpvF7in/9ZB7kpZgE8kvrGnS?=
 =?us-ascii?Q?Vf4Pt57aE2CZX4V5nkFKu2y+FnRZ2vN+UvEaPuni3ipwguZC8JRBd+Qcx++B?=
 =?us-ascii?Q?McS9mlaEUO3pfOpxonwrUAGlaGhwqFLa8W6NVYzW36beCp8HgmD04gJA2W7z?=
 =?us-ascii?Q?GUrAzNM7jQdeyLbFxX1J7qZBs/eP4ZFnGcxoS3jw5Ej11ehgE+PEA+wWhA9O?=
 =?us-ascii?Q?4V/nhhztJ6tpBHjmoPC9LrboZI/DTBVUVsRU2mV53bvmNoVeFc0C9SyByfM8?=
 =?us-ascii?Q?T09qdHNNUhpmi8YJEo0gDN1QOwXfxpr91rOkqcWwHpbK0N6DDIxplDDqco4k?=
 =?us-ascii?Q?XnAdIy4gv+lnp8qFnRT8sxgTO6gn4a+QYBfh3qPyVQNqn7EJI1Wef6tiYR0F?=
 =?us-ascii?Q?2wLVzi2985Xzq2iqtPTQDxT5C8y1pdBgl9ndemsGHbX/Atd640pYGbh9doX7?=
 =?us-ascii?Q?WLguKgXWJfcbrjQ+mkU0abE4CUijsQrBpRBu/0EDCsUn6YKJ33oI6uhDSjJO?=
 =?us-ascii?Q?no5lqN7bTfUl2E31x3gbJsj3KldTGVsgu1nO0rOKK/ZoTC7DBK4PIav/EsoO?=
 =?us-ascii?Q?DZrXIr1i7a9LOmPzca08SNTWYXEVYgskKevHz9PeMMJr3HREspo1fXc/ooaT?=
 =?us-ascii?Q?vSe52rXk0rG3XOd6P8m0l7I5Nq3FPse0QdPEqxEkyWaVLgGaXPKpl2B4QfkD?=
 =?us-ascii?Q?klqG9qr1ox02HV+89XpKzc99c6f9m1iJeeKh3uW7jhov5QAWbx01trHJNwKP?=
 =?us-ascii?Q?hvnjyJ346geF4fWbRC21sn9ZLo9UKKFZhqXaSIoRuqha81j7TNVOtcNYpDGs?=
 =?us-ascii?Q?F4p/rONyEaqCGIplQIfpvMr8Es18G7naD1VQ/NPQtNAouMpGMjQgZ4+cCMbA?=
 =?us-ascii?Q?wHMzGlqBxfI3Nf46O7tleefZA9q4sDTJeqTK85pe29ih3VHG2546NdnZDrEi?=
 =?us-ascii?Q?So4QWCaMew1w2ZSANK//WqhkOxs67zvMtkFoNAZmjX+eWkuOHW2M4kD39Zlb?=
 =?us-ascii?Q?2ypHLhYDydbaWEwabk++iIJ+t3r//Eppn7OHS6zWyO4fUji1h8r2EwWxk8eP?=
 =?us-ascii?Q?VF+J+9AT8+T9UIp0aknLHpGS/g/eu7enpoErqA5NIdr9K5yiu25lRkCHA8mn?=
 =?us-ascii?Q?HC0kmrXcmTZ41FlKlDen6ww4KV/3GDUQJHjn3N7s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O4mygc52bpLWmilowjmLr3PwXl2PE64qNaPyJGbGDewJ4uMKXFhZTr/LZIBZUE+7oubTSW897J4Je675BTqtTUEXNsPcHY4Qw7qCZjV3g+nM0Zorgtrl2cSoTCmARaVNpw4HoNbc5cdmK2rFQcdGYMkN+kJt35FpveVxpS/LfAnTqnPUwq6q2Zz9qejbMRs1z8Je0JHj6ktD1qFfcM6O8NfJqOC7bTVJjYx4QxlFxfk9ybUu7QzMdxTUoy0qvW08/tAQK2an6vVQm6JzD5cRKg0D7Mz56kp1fuuDfDjc5rdRdxl9/fBlfsYaqeGgbJflbcUzSZ1ovN+pTuUymN68dxkCYQ+XaBQOUZtv3Bc7p9D9kPVuVRW8DiuDXygTK/9n7gEAX16tnNbWuYzU8RWxnU9UkBRbpFUL0GeAUbCMEA7OwTCt3BcK6G05jJVBd0OjGQWRW+9QAk7H6scmoC1Y/mj+VDRIXlp2cd6/ZRL4LbCJ6ju9smZq5srqU8ASnnncHfNqnq/V69E8OL3+oLytRtmmjfPvjytxFi6ieiPEXWp7eLDZEOPUY2KaoSpS2w+AgIrcs4wy7rPMs12uaed66dZzhEOSiIpCVJw2KMCMrEMJuIZmBZhlehEaam3B0wDA4XhJNtFzWFmuEeCosFlFeJ+ir0XealSzCiP6tOfpnbMNpHZPgDYbSCDfeM3XhOnYnzNbTKiUBkz7qUVPcj7Q7oqEUkmXdPTJ6IOTtlcWANaa4PjpDnr63b9+CMKY+KZbrzGuIZqkpe3Afg69TooSnysOIaGtC0rIkleZCJjCLrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f207ec4-c1e0-4793-26ea-08db1617a11e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 03:31:35.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duYHRW+7fEExLpO7WdWa/z/VYtQZck0Qxa2L/OVT4wQKMqDTqFNkHQ8COamEcyNj/nHPAKe9qf4pvFdAzwT+Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_15,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240025
X-Proofpoint-GUID: iA2YpipxJ_XOneDA00xfmcffqJ2K073m
X-Proofpoint-ORIG-GUID: iA2YpipxJ_XOneDA00xfmcffqJ2K073m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_bin_search() is a simple wrapper that searches for the whole slots
by calling btrfs_generic_bin_search() with the starting slot/first_slot
preset to 0.

This simple wrapper can be opencoded.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Title changed from (btrfs: make btrfs_bin_search a macro)
    Opencode instead of macro-ing.

    Dave,
	I think opencode is what you meant in the review comments.
	If not, I didn't quite get what you implied.
    Thx.

v2: remove extra ; for define
 fs/btrfs/ctree.c      | 22 ++++++++++++----------
 fs/btrfs/ctree.h      | 13 -------------
 fs/btrfs/relocation.c |  7 ++++---
 fs/btrfs/tree-log.c   |  3 ++-
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e1045e6d5e84..5bf75c7aad4f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -854,7 +854,8 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
  * Search for a key in the given extent_buffer.
  *
  * The lower boundary for the search is specified by the slot number @first_slot.
- * Use a value of 0 to search over the whole extent buffer.
+ * Use a value of 0 to search over the whole extent buffer. Works for both
+ * leaves and nodes.
  *
  * The slot in the extent buffer is returned via @slot. If the key exists in the
  * extent buffer, then @slot will point to the slot where the key is, otherwise
@@ -1860,11 +1861,12 @@ static inline int search_for_key_slot(struct extent_buffer *eb,
 				      int *slot)
 {
 	/*
-	 * If a previous call to btrfs_bin_search() on a parent node returned an
-	 * exact match (prev_cmp == 0), we can safely assume the target key will
-	 * always be at slot 0 on lower levels, since each key pointer
-	 * (struct btrfs_key_ptr) refers to the lowest key accessible from the
-	 * subtree it points to. Thus we can skip searching lower levels.
+	 * If a previous call to btrfs_generic_bin_search() on a parent node
+	 * returned an exact match (prev_cmp == 0), we can safely assume the
+	 * target key will always be at slot 0 on lower levels, since each key
+	 * pointer (struct btrfs_key_ptr) refers to the lowest key accessible
+	 * from the subtree it points to. Thus we can skip searching lower
+	 * levels.
 	 */
 	if (prev_cmp == 0) {
 		*slot = 0;
@@ -1953,8 +1955,8 @@ static int search_leaf(struct btrfs_trans_handle *trans,
 					btrfs_unlock_up_safe(path, 1);
 				/*
 				 * ret is already 0 or 1, matching the result of
-				 * a btrfs_bin_search() call, so there is no need
-				 * to adjust it.
+				 * a btrfs_generic_bin_search() call, so there
+				 * is no need to adjust it.
 				 */
 				do_bin_search = false;
 				path->slots[0] = 0;
@@ -2328,7 +2330,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		 */
 		btrfs_unlock_up_safe(p, level + 1);
 
-		ret = btrfs_bin_search(b, key, &slot);
+		ret = btrfs_generic_bin_search(b, 0, key, &slot);
 		if (ret < 0)
 			goto done;
 
@@ -4575,7 +4577,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	while (1) {
 		nritems = btrfs_header_nritems(cur);
 		level = btrfs_header_level(cur);
-		sret = btrfs_bin_search(cur, min_key, &slot);
+		sret = btrfs_generic_bin_search(cur, 0, min_key, &slot);
 		if (sret < 0) {
 			ret = sret;
 			goto out;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 97897107fab5..dbe44fdcf9bc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -511,19 +511,6 @@ void __cold btrfs_ctree_exit(void);
 int btrfs_generic_bin_search(struct extent_buffer *eb, int first_slot,
 			     const struct btrfs_key *key, int *slot);
 
-/*
- * Simple binary search on an extent buffer. Works for both leaves and nodes, and
- * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
- */
-static inline int btrfs_bin_search(struct extent_buffer *eb,
-				   const struct btrfs_key *key,
-				   int *slot)
-{
-	return btrfs_generic_bin_search(eb, 0, key, slot);
-}
-
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ef13a9d4e370..7e14fad2e53f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1266,7 +1266,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		level = btrfs_header_level(parent);
 		ASSERT(level >= lowest_level);
 
-		ret = btrfs_bin_search(parent, &key, &slot);
+		ret = btrfs_generic_bin_search(parent, 0, &key, &slot);
 		if (ret < 0)
 			break;
 		if (ret && slot > 0)
@@ -2407,7 +2407,8 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-				ret = btrfs_bin_search(upper->eb, key, &slot);
+				ret = btrfs_generic_bin_search(upper->eb, 0,
+							       key, &slot);
 				if (ret < 0)
 					goto next;
 				BUG_ON(ret);
@@ -2441,7 +2442,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			slot = path->slots[upper->level];
 			btrfs_release_path(path);
 		} else {
-			ret = btrfs_bin_search(upper->eb, key, &slot);
+			ret = btrfs_generic_bin_search(upper->eb, 0, key, &slot);
 			if (ret < 0)
 				goto next;
 			BUG_ON(ret);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 200cea6e49e5..e18130439a00 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4099,7 +4099,8 @@ static int drop_inode_items(struct btrfs_trans_handle *trans,
 
 		found_key.offset = 0;
 		found_key.type = 0;
-		ret = btrfs_bin_search(path->nodes[0], &found_key, &start_slot);
+		ret = btrfs_generic_bin_search(path->nodes[0], 0, &found_key,
+					       &start_slot);
 		if (ret < 0)
 			break;
 
-- 
2.38.1

