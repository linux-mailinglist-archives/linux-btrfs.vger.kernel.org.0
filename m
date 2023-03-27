Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5206CA08C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 11:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC0JyS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 05:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjC0JyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 05:54:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E15E524E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 02:54:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R9K4oi025981
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=6yCfIyNz9wDDsLyeinKiFhy9/RYYaBLQP+ji3WXF7as=;
 b=Sk0K2myck+sGmy+8GidPfB0qatnPCiwvqISskZyPTuMzh7IqEobt4XuPhaTbsAaEhATX
 EuJIQpjSQ/C2WklpHkMwon7VrsuH9oBC5zmo6CUVEIyfWfFqZD67XTht4agPcD5WRF5C
 TzFJh8KyyHehZHzxa5E9U5r2WHHyJ7qxR5C9YeGq1s2wzWyVGc2gRfJS+J3eFuyfQMAY
 phCW2ZpSvHnT/JgFfFJYyjzBKvF3Q0qVvw+lditHShHiMR/+OsI5ebA+PS8jBaPfJBeg
 ofbjiRICeT/6JEwnzY+BFQ+0NTf/NDej9s7WFRgvIFRMqKmzhckN4p2ty70s0eT6Q6kR Sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk8dsg30b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R9Wkb3005428
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd4h3gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjEzP/2QY06kWxSQjUGPajdD2b6v+FSdmpqA7Z+cytEeJXvFjsoRCqipVB3s2Oo69gGovX1CdgUDwl1b1oF3LWKn6ndb5pD2qxI9WN2dNZzb4i6PjQFwOX97XkiUUkR3tvP5xdQxeW92g6FB14sq/QKePT+1vCPs4EHQ4M1RQC6dRPSV1HgK4MgzMGvjtEDgs7u8z0rBOEDlZN8aKjXxl3ttXOux3tJnyD7vplJ5Za48WXVqpH/53Qtlzg4aiNzMqjK9Eis48VHvktlJYU81NYhrW7U3/Lhz9cipJnnL27jA52Yb9kuLhHi5y017lPDKN4fHEPcDMC3aZ6DPEQBYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yCfIyNz9wDDsLyeinKiFhy9/RYYaBLQP+ji3WXF7as=;
 b=JfB7xxoFwucmP52bhwbJQat478x+5VFGz1AW7WbJQzKkFXAXpl4DFlcDS1qtI8OQN0dAAV/Uj8svkIwM4Km5Zn7tnoTITROP7mSc+sUGyE5P6swY7NgO2jvJ0suuPCARD7THJWTTVtbEewxJcWJnepzse/weUIWbtaG58XVb8ilY7u61wdGuPaUrRbuFzEQpDHEhR/yEGiWUZXoqjl4VE5UREmV96Osa0wD9t0qGlOQuV8LFmUAmXD9EqhoqPqj0Ij0vWyGhPQXAFOhLZ4kQGyI0cGM1qRv7dFDG7D6QgxT/dPCVTTwSm135HWXQGOPZIv2PPV2kO7fwyL4+SM+NMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yCfIyNz9wDDsLyeinKiFhy9/RYYaBLQP+ji3WXF7as=;
 b=xn1dw65p9HjTOktS2T1RjMTUgR4Hzi5HtzXqZwOq4r39n/l2f3ZmIfF3rPatml0ElwNT8/ldrD1mLcn+sdKDcSRsGj0dcr0JUpf/uaZKAFX+IEL2uyHjJyq/mH0DoEHbPoGjmUxVZEfzfglgfFtpkdUrn0ytHMiqWlHCml5sMro=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7597.namprd10.prod.outlook.com (2603:10b6:a03:53d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 09:54:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 09:54:09 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/4] btrfs: move last_flush_error to write_dev_flush and wait_dev_flush
Date:   Mon, 27 Mar 2023 17:53:07 +0800
Message-Id: <d3708fee7c2b1fe27f44b4a0257abd0bc9e1fc63.1679910087.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679910087.git.anand.jain@oracle.com>
References: <cover.1679910087.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2096b1b9-2449-44d1-2b0e-08db2ea935ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zk/2ln15Kuh0BPxmEKyjD+eg0JTqUE01sZLKT7donWeonVLHaApdicA06VQlutQ1ZFK8LZra4GFA+kqtoD62FafGdBrt9i7th1T8lz8ZnFkAukrYzpLcU78Y1kg9I+BjF9rGFL27nK2EpzKD1lIvZBDRwdlK5PEcsZqSQW9WvYD901DnS0hm9SbPtH9s5gMCjSjrbJI/e93RzuiIoRlpphXrcHf3CwFjYz3BFiAdOGdPSWGL3QR6AmPVJ/Etv3ROY/7d7D8vIzPGk8Tqk2KCRj/V4rEDXjYBv6yctWFB1Ywt9Qgf5CqzMRilGgZJiTbSNmvo93uLd5XGZUqkVqPOI8vdm9kZr0jej+t2+IqTw13y6OqDIk/dRwbfcctz3jmUJMlMmDzgZNWsMatPWhgHSQIvPrD0VTwVr89DR+C+KZ0iW1OZZenNTTusbV8sOzap4kXQmTU+pgwcKbJK47n8tZIp2JY5rkrn4N/xlsKp1PjAr7Lqvrvl+ppCKDZS56vYqqxqOoKcgWLj4mhUoh7KVuffy3+lS52b3pg6dwDUcwB1SxwPxwhpnQrL/rylW/rm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(86362001)(44832011)(36756003)(2906002)(6486002)(107886003)(83380400001)(2616005)(478600001)(4326008)(316002)(6916009)(66556008)(66476007)(8676002)(66946007)(6512007)(186003)(6506007)(8936002)(5660300002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BlloxBTgZkUiEGwtTmEYduybGeAb4yYVRtulqhaqRJ1yNyCMEWic0e+mz5l9?=
 =?us-ascii?Q?JJEZQhoPUaEZMgrxcc8R9UTlMr/sGEhT1Gj+Bw5TEwx31UbsZRtNkxp3fdXA?=
 =?us-ascii?Q?ftQXab3RhVsYVgwj9zCucZhD2QyqZJC4HSOpuLJCe5tUKXpRsmChhRWGhA3L?=
 =?us-ascii?Q?wrsrihpyNe8fNHrKzqZ3PDfX6GKZoyOjENwpbMteePRLtjIfIaEa3haYyppL?=
 =?us-ascii?Q?U0N0Z1t4Wt4hSfj2+lWLKlOSG6j7N2/idafNqcJHjmWfd0NgMq01IrbBxUe4?=
 =?us-ascii?Q?5+NRDTCwA2CMTvbS8HvH5TimzRrMkKIfMT7mR8jFOnwW2wEyiKiYw63rEw17?=
 =?us-ascii?Q?2GtgI/kcfWSJXKL2GEQAu3BhzG18Dp+CCReA4TLtgNkHyuONToA/IUPxZWiD?=
 =?us-ascii?Q?iTCKspna4ccq9F3BiZ4e+tjtNNpsNHvV9n5iSavfSX8MhtRK8YhzQ2Of62OQ?=
 =?us-ascii?Q?7tueAGt4eo5IkePwo4UPtNTzfTzPQMX+KgCK8YPghHvC9+cTRCJzbAdTFJIF?=
 =?us-ascii?Q?O66l6GaxdahoG3hRLMR4+G36vTdzmEnkvRyFlsv+U2RGXIorGjCQ28zQYYGb?=
 =?us-ascii?Q?b11Iizu+EhM976WSXpqEggxJukT23//nEXDDrIRgL7VKavD1G34ypMwtFRB1?=
 =?us-ascii?Q?bqaRck6Rsa+hrHx637VUm7E6q7uP9O8BoBC2xhvmlv48kEsVVlJzYtHMiWjV?=
 =?us-ascii?Q?l7BSAMuC7QKStvpLzixr+gJvArr5rP7kN5mybG9+hTyZtEKwWmd+amlqKwBU?=
 =?us-ascii?Q?jGQF4vV6uIY7p88Y/595vgRZSb24fyRlnBcH5orJu82d/7MUda4g2mGkC/pA?=
 =?us-ascii?Q?esYI+EzUAr6yj2Kh3Zrn5CTX7YUOZsCphNn7sUxrzEt5AONki1b1/5fupXRd?=
 =?us-ascii?Q?MPuAjW7mggbqkRzWlnwg39S9rNGWAWeCDdT+26brLFZvToXuFcpyo/jt3QwP?=
 =?us-ascii?Q?S7XdFBwOMl4OJbfxkbi5t9lNcSOVAai0wGCaoHnCD8skqg3KPXkbAbRF/XWl?=
 =?us-ascii?Q?dXZ0ugoFOeqbMtZIQNRdTKe1lbQwXROnFW80jTKiAabp8jKvXrUhzx5xxCTc?=
 =?us-ascii?Q?6eQwoL2I1krDyeiF+9mn9J5AsS9BsDST/Y6YD6atyJCRz6FfPgYZJ9f+9Ls3?=
 =?us-ascii?Q?A39w89vqek2tV1bDVLva9KngoFi+e25cVgBLQsL8LipucKrUeC2i0/d6o7CG?=
 =?us-ascii?Q?q/lfDNE9Ggt2lXGiQdGvqNlrfLb1oMszMYSvXa6/uTbuXzB55BOMnlx85bGv?=
 =?us-ascii?Q?AOtg1yWgwd6DV/s4ZYS77etS8h8TK0LAeCfueUERx1ja7d/lC71WpP613eGw?=
 =?us-ascii?Q?t2bbV8+mPUDGQfFsQp/qAIfgSEqstG/C8yD++gfnbjkJ8Z4vPbSiGNd/Nto6?=
 =?us-ascii?Q?oiH9/8omNxaNOXBvWr/jvbhLAor2xgF+mWCkAe+bsEbxhwwgFnQYxlfyJeH0?=
 =?us-ascii?Q?gXJ1a4R4hN+4mnuK4yk4j+z1JhtmmPEw+KcgkQ5Ok/cMA24cK0KTn/VyYPcT?=
 =?us-ascii?Q?novgdIodgWAQ7M4AP0TUoB79W3OQ8n5p9PHOIpRTXgdAM7Fi2Gu3+SEFmtgW?=
 =?us-ascii?Q?HzR7/Yk06D+YWLO6w7i5xnG23I8IccRvKFiUi6P1PETq/L3RnJb4cwDo9RCG?=
 =?us-ascii?Q?2088iQAstyt+3cHsxnGZGyw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2qhm7ejhuT9cEKcNVJDqHo9agjy4bOXGN+i0EYDd4MnwYpyQ1JEyyUz61e80AfowTE1n0DByNGfMOqhDtdDozireqPmcTKWEFc0mlarZgE4r9rFWe64XJZLghNGK6//XzsCly4l/v0Ss9muMTaol1m/eZzy2moEuFjcWwR5vs7C+HQG4ow+4qYFaZgeBrGOvLd/FK09jFLVBFX35852DpMKrjUvNb6I07SGxw2O88VAw4ipaJnWnhXH+Y+1oJyUkqQt05HHc8LCRpCEBsv+lHsUpVGl3IvovtstoebkPzWAk+KJJ8Fyfw7pbXqbGTm33YH5wXHUgYSjX+Y8RIjCRMtfENs1+UPqLlL/Tgzx02XFtv3+FzDws6b7+pkAsEanzvYklUgpil/dfXk7ZMCHL+wE5H9ikbSnO8v0RR5OOe75lqOUWx21N5SrVh5MFhh6TSHc/Pis/9SzEFIPPcwqnCtEhtl4MLqaoIJjxFouZZlnuk56A+rDuAlgloECqGWKyfEm4sFK/sOeEmlJoI0xj/scWl86hIjhuYfGKyKQGS29XP/lIItI7eic/j1siNAbYcFRz6cAOYf71Y3Yw9yPoaKrQw9jCn3wwfXW3Ky3VPI8x/FU1B1vFeF6DpuvP0pMAzJabvGi8xPQQQIGxL3u6SWCXnAG0iFtFe6XHBqtKxi5F7xh4RRxjKbi/XNHMaQlAyic/kRqskkTyvgiamxkSGh865h1KAYnsArF0E3YRzfawz9lvNGtqnS+EUH9Femgk0chj8JhmA//n5HDXqv7iUw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2096b1b9-2449-44d1-2b0e-08db2ea935ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:54:08.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Emp0IqVskqk/EFnwx1n/sv/d3DrYo8YhQDQieZCE8VEsph9KCa7Uphvzn/FKffYoqcpjdrfv/htp48Rq2TFX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270080
X-Proofpoint-GUID: qHKgfnMYT0DQebCVcXwyXRpE9SDM5hOj
X-Proofpoint-ORIG-GUID: qHKgfnMYT0DQebCVcXwyXRpE9SDM5hOj
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We parallelize the flush command across devices using our own code,
write_dev_flush() sends the flush command to each device and
wait_dev_flush() waits for the flush to complete on all devices. Errors
from each device are recorded at device->last_flush_error and reset to
BLK_STS_OK in write_dev_flush() and to the error, if any, in
wait_dev_flush(). These functions are called from barrier_all_devices().

This patch consolidates the use of device->last_flush_error in
write_dev_flush() and wait_dev_flush() to remove it from
barrier_all_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b638e27468a7..7f3fa5e2253d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4072,6 +4072,8 @@ static void write_dev_flush(struct btrfs_device *device)
 {
 	struct bio *bio = &device->flush_bio;
 
+	device->last_flush_error = BLK_STS_OK;
+
 #ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	/*
 	 * When a disk has write caching disabled, we skip submission of a bio
@@ -4111,6 +4113,11 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
 	clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
 	wait_for_completion_io(&device->flush_wait);
 
+	if (bio->bi_status) {
+		device->last_flush_error = bio->bi_status;
+		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
+	}
+
 	return bio->bi_status;
 }
 
@@ -4145,7 +4152,6 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 			continue;
 
 		write_dev_flush(dev);
-		dev->last_flush_error = BLK_STS_OK;
 	}
 
 	/* wait for all the barriers */
@@ -4161,12 +4167,8 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
 			continue;
 
 		ret = wait_dev_flush(dev);
-		if (ret) {
-			dev->last_flush_error = ret;
-			btrfs_dev_stat_inc_and_print(dev,
-					BTRFS_DEV_STAT_FLUSH_ERRS);
+		if (ret)
 			errors_wait++;
-		}
 	}
 
 	if (errors_wait) {
-- 
2.39.2

