Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A248737F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiAGHYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 02:24:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbiAGHYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 02:24:50 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2072kwvc014686;
        Fri, 7 Jan 2022 07:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mLoAeuCPdGDaqQHBkJ0InzcHEGlKFNx+N23F8kqrjVw=;
 b=lKPuGoxUhG+7U9z6saOt9S5K2ZMR2huTGnktvr3deImFS37QEUFxnbnasHY7lwoI12uQ
 BsPFAPxCiUDtFIRXQLo/bS4T/bmXb30MEecBnAFpPOo63HS2kYFggJTWl+HoUNI17JEI
 BTruGFsbsiF1ww0pD7LFl6HUvxNejvRSAzuG+AXWH6iUKAvpW+dmXXZH18mLN3Omxiu9
 b9uszQQeQiJqJBrinN6iPdFSGrE95yyzfoMwSJABaGNKaaD3FAQHLobfM8Ngd4GSE+WZ
 2HoEICBP0iHeZ32LYGHM0ptqqHh9POvury5jOykHxq8SlTbwyuMNl9JSE12pBx1m1IJy rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8h9v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:24:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2077FNd5099065;
        Fri, 7 Jan 2022 07:24:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3de4vn80bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:24:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTADVhoDw2VXuqLTu3Xbwzu/OFotQWCT8xV/nG6SAphyBxnxP/x1+DbmhXQm1yEOqlaEsxyFVlDlAZlhsuMo3qr9BIYpGIM6rUY78JGMUkcYX3g54Ea/6gPVvooVo+JqoyKfwNt0zOBbUGHYRU4/lcvZYeBMm8XtAfRNK3hm+FYR+avmMcJ7RXm2BxMlA3YCvpEQ4lwSMzFYOP36QRdMnyhLNKaT0phZWIQzeJlUsuwXBgFo1cdOw+8k0xL7DjJyxXTQIJR0tVC/sOtk8fBXNFICOSvE0CpfGQhPd+Zuf44vJlcVn/V2fvRgHbj26isRBqvs/Zy1ve9+RxPLedcSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLoAeuCPdGDaqQHBkJ0InzcHEGlKFNx+N23F8kqrjVw=;
 b=oSVkplULSjXJcwWv9bqKVfi3763WtF9WAS6kwpZ3tD8OGA9E8YxGTnBFVaK8jxm2X/OGT7TjDHOz1ovNxw9nK5s039uvlKDqQNzds0VQM14HVR2VcJJTXXPIFIIDO9hEyqdxrWiivy+cah0xma3RP3hfb+5d3MgykFc1WE4x2U0VUcqim7k+U4rJYseTODAvedqlf1du4Gyr2CmoaOJDTRhiTtIZprxLRT0BvTh1vec+eooj4BNi/bHTpK2Ei1farXuewGwvHNlMJYcfAINCTjFnaMp0/gv/N6MGiM0gx81bU0vpdrnRQznNNtE6ID1itrVCAtoe6oWpz6a3OIBM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLoAeuCPdGDaqQHBkJ0InzcHEGlKFNx+N23F8kqrjVw=;
 b=BfuPXPaOOxIq2bikvjtzNUENl0i0FKLPO+Q3sMsL29h5UjR3z7d/iOjFb57QvDgQdF1D7dc+3u7xneWW7CfeqeC8UregRPiCziHGrAkLkyQsPmpBVqmIsktmqEI88IV3FDI39VpRCm1QNbqohwmdwhg5sYBX7cQgx/CIPm/4lP4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 MWHPR10MB1902.namprd10.prod.outlook.com (10.175.52.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Fri, 7 Jan 2022 07:24:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:24:41 +0000
Date:   Fri, 7 Jan 2022 10:24:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Filipe Manana <fdmanana@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: fix double unlock bugs in btrfs_compare_trees()
Message-ID: <20220107072430.GE22086@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d900e358-493e-43b3-b940-08d9d1aec53f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1902:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB190230546B2DB9E82E16A3DF8E4D9@MWHPR10MB1902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VL/gtOEYHg8Sm9R74UXLJGed89DsNidXZVXh5Axfz2mEghC9vq8yVe5oAtxaaBwTJLrS6DYq+94o5HIe4DhJpf9hPMeHC6W4Uot9gNpQMG/D09UoMI7gSlxHmrNsBCCHVxWUkdtb9CKF3eIt8TA512EYiaXoZOrGtCT9pvDg9fjVB2Irz4c76FaEMJOEo9DIJcPwIxvFOrr8KAXYz8mupvdfaZGPh4fSbKTUlGhRXHPupus7U+NI8n6GLBsl8XU/bQ1qKw/XokmiWQc1qIl9FN1QS39PoACD12Iwj012ecZc2zTWUr9kVQWxPXKSKYTETjx9El+0JXes3JD3Gaau67QwCWmy4xtuHAhrO5kgDE2lBXtdm1Ngi831KBH7pP7o9AMTQAyBhMK1ZwESeKKd4YmtjCzgOTmJM11wCB8/LbJ9XQfudWxsJnZbJix7MuEITs+4X1xpAuGgwO4N/gO7aXTqi2q8O0GfA/4qdAqci04aevmLLie+oMZJBKofS4wOeRp3FZE10OKLfRcI0MhR5sEBeKzxXfPsphKOSIDoRFYHGa7y21YbGRNu10WOt48BmRVHIqkQ4OYuVrpTB/sYExfDSGpJr8ea66elOPkeaTsvDrhnYfKCAVkSyVBY6S6pJBts5MkAVM5zxTmHgNyNsjelUJtd/Q7IqumJxthXE4VlmAXcgBU5EO6O+9qaMrx6BsuGg0CumNb+yo+6XFO5+xIxBAVSsM9+iIeu5dfPIsKsFHy1bJJMRj3T7R/pCU2R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(6486002)(52116002)(4326008)(110136005)(6666004)(1076003)(33716001)(4744005)(2906002)(66476007)(66556008)(66946007)(5660300002)(83380400001)(33656002)(44832011)(9686003)(186003)(6512007)(8676002)(6506007)(38350700002)(38100700002)(8936002)(86362001)(316002)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L62cjXSCnB4FIP5YI890KIVYpRbfgT0akhKCd4TKChV0K5P1IKW+jXIp16GI?=
 =?us-ascii?Q?rQaqSqTyYrlmCrb906MFmkEa3QmI1BD2H4ONUwsno56R32zP5wFK+jvj9904?=
 =?us-ascii?Q?gd9i9cmmHKTW5jHxUxmiDAkC/fT2yBkuZG49vAhDmpcHhzvvDm5orZmS3JdK?=
 =?us-ascii?Q?bxIZgZbckBt3+zT8R8+7XC89nn0REHNVs1i+i48k4p38r47BigenalAH4res?=
 =?us-ascii?Q?7ebMcwJiBDxlTQ5g8Qi9ASVLpc8pH/7Q1AvbitUk7wB61Duy78tPYcMBUeLX?=
 =?us-ascii?Q?eAQFCxTAtoKp2Cc3r73VfsA5Gc9preb/bzGUab5zjqYUN425hvEwEz8C2jmx?=
 =?us-ascii?Q?ia9KBx732qgkiPZO3hX/sibN6h5tt+V3arpq5OFzaVPYODf0NrCy8Lg8qa3s?=
 =?us-ascii?Q?iUUy2UvWsvOnfeJF1y1jhDBAHEamVNwo23ylib+MF/kgnWuOGs3rP6NUGVGd?=
 =?us-ascii?Q?+9oyNyfBveHoOt4ym5f4rSELA9p2SNBBRDG+W7FsyScstJ1Ni26gd+4mikJh?=
 =?us-ascii?Q?qXA+i0JQVFnLi4rrNSaP7gPXkaqhtI0b9CIw0XFC7onoPhI6fRfUyNHXVNI9?=
 =?us-ascii?Q?VDwklVZSLMe/69RMRQCT0GHRawYw5o1VR8N2pfhNW1vfslcyK8Hqk2onK/n8?=
 =?us-ascii?Q?lbehtNncEIXgwm6aPAzCoyDyrXDafhVoLbl+A7CdD057dbfk1G+Jkb344gqC?=
 =?us-ascii?Q?H1K7vOQjtZm3bGgjkhhn3u0MZgH16+x9ska+HDYp61A9+zOIyx6p8BN3nJ6H?=
 =?us-ascii?Q?CoJcxeC7kqWtLPzkPT74mNC3g9Wsfg+cTs6GjPjErJSAH0YRL/zLYJsOvjrq?=
 =?us-ascii?Q?OimG4D6IqVH1MbleTFtPBwly+m2dvuonr+rPsuMY+EW32+stt+QPB6oqrcfG?=
 =?us-ascii?Q?qc7kkch5OdPFuxrq5iIjuAhHtBOZGYKsW2TNOnCKAQzPOcnsfzOs3PiXuQAv?=
 =?us-ascii?Q?o2SFkJzpHAFcUulTRoyNdiVUAiMG3L6ij/todoRo7+YscOfzWzyazp94bCCI?=
 =?us-ascii?Q?Wl35siVz7LtrKPWykWySYfnAHq79V94K9xL18OnA+SCrkJp9KjVjzkwGinUD?=
 =?us-ascii?Q?HDRFohtqfFdPGrWT20TEj3xACjREHeNqtJiH/2zDq0zH6bf801fbpI2m2ks/?=
 =?us-ascii?Q?mjdYEdmFQriUA3fIPDo9ipoE+heVqEnzCHqQOTaBFXOndRNSR872pXIU6dNL?=
 =?us-ascii?Q?AgLJMAEAuf5Z07sgJSl1dH0TKoUTjvfCvNWYC+u7tFo3ATmT3XlkHRDUXs0s?=
 =?us-ascii?Q?2orpdusU0O51N5176e6tiwvwtt2f/N8dX6Upod8TS7HLhB+tfkAlCySMF3Tq?=
 =?us-ascii?Q?4Z7/5q+WGH40DdIWHjhCIF1kasHKQvEhT+G5K8OKvh85c20Kj2EVb+S1sdyK?=
 =?us-ascii?Q?WShvkhVDdDNYmNa6Hop7kK5BfjlZsxkV1j1BwXPSIcK4G1m+gk99kEHHqQ4P?=
 =?us-ascii?Q?ZctrGpXjZpdftd0atme4YPm1nS9C80Ciy1OIeWipJhhUVgNWLfWkr/6ZnXhV?=
 =?us-ascii?Q?GCrULWr9ZYNw+LJqZvBo7/e4+CYj6qV1U4pfC8pngH3cDWtcjVrdCrVTMjba?=
 =?us-ascii?Q?BumqwnuC6R1QVb+MRHT0Rnz4AkIFoSL6shxKsNc7yFuj7qyZ6FL638lfN8rw?=
 =?us-ascii?Q?jF88HUQrRtzecB6L5lWLBFt1AL4G3rWG24Iu6T4ZqR367hdFNQtuakw5XgPD?=
 =?us-ascii?Q?SqR5wPsKB/x8NzKLUlAzgCghEqM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d900e358-493e-43b3-b940-08d9d1aec53f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:24:41.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlOYJT8CTnC9WDmv+1jrQLi34wernlVKBBGU5NrbnAPlk+XxN1zHzrLCVGdgH6zijXz0pO1zPEuCFStCaZfdsB7TGcNqypNhabumJQfkLPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1902
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070052
X-Proofpoint-ORIG-GUID: g6ffXlgk0O8yNiTn7x5_njlCJDncQe4A
X-Proofpoint-GUID: g6ffXlgk0O8yNiTn7x5_njlCJDncQe4A
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These error paths unlock before the goto, but the goto also unlocks
so it's a double unlock.

Fixes: 5646ffa863d0 ("btrfs: make send work with concurrent block group relocation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/send.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3fc144b8c0d8..1aa8a0998673 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7152,7 +7152,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	left_path->nodes[left_level] =
 			btrfs_clone_extent_buffer(left_root->commit_root);
 	if (!left_path->nodes[left_level]) {
-		up_read(&fs_info->commit_root_sem);
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -7162,7 +7161,6 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	right_path->nodes[right_level] =
 			btrfs_clone_extent_buffer(right_root->commit_root);
 	if (!right_path->nodes[right_level]) {
-		up_read(&fs_info->commit_root_sem);
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.20.1

