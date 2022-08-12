Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C2B590F85
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiHLKci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiHLKch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 06:32:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661792ED52
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 03:32:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CAQYe1028730
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=X23jqkc6ZYFbG+cbkSA5ODZJQiQf+InlzlfbRHZV7FY=;
 b=bfAMQprgESlskRpZ2/a5vj5pFiDR1XFZxbddyHyMeCG01XEHX3InIa2g08zGGpqH5mcs
 0FuMEa1jhGXww90X7Qs/TSfiISfTgliYaZuu/zahx4YQ4vEIL3Oy405/7UZFy3RoHjwR
 n8sF05sPhgbfPbP5tT1cn6KwOGx6QHOytBNqTsXephNw7zPnFVz2R1n+M+/6TkicAfZd
 Eprum0jRWzTKJ56tb79nkX6AKtKVm1iSjWU3veD7lrGOA66W5AKevRJo1PVFvm4Qi79g
 EFq/kReH45m3sOOTq2DQ1igOEVo/tecx563E1phPDe4hY6TnOyzeXV6uzaWaGfjotySC cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq9px09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C82LSg004081
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hwf037r4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 10:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/Tmtou7bFKj+UlDN8WdARosrRs/u5Emm76yDSZDjPQFD0v+ZWtrqS6AA7RoqbRoUJjE0zKvSGb8dmNP19DbPhzqrkY0JFHo6bmtAyi8fLy6ArFeCHmF7AvM05Clx//uFGXoEfVTFQAmpgT/1pp4NIQY237l5nVpy5gXKOuYHUIuPhkYiCWOjSrL6fkZreZ7N6/63/faZ6RZQfQUcHirtLYg1oSDOwM0xvZlGv6B6U5/WloAVoITGAkosA/b9m28xtk4k15YKvYDlPN+GjAx8J4L8S7018rd98sO/rodWdpXSEaCO0tCMMrZ4Sfjgoo9R8BsxJhnW7+IXq6sDlfZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X23jqkc6ZYFbG+cbkSA5ODZJQiQf+InlzlfbRHZV7FY=;
 b=JYk/BvCKEphzg3ksxVtxufEd55pz425Lw2u67sYZUwXxapwTGtke2Thp363z9vtufCIp5CMI39+2SNp4G4kTmpmbEMaf3WsdYj+x+nptejnk0h4LehSllnz9M8eJoqHoRFYkbhW6HyyElb20Yt5gOTTaAfqyX3uNpHxHyo6xHTqfmGTil4i8R5kZpLvkAWnQQX+Q/vzoW4MMXRERVf3tDhIhIFoaL1VVVBL1VerqIx+faeqz+QQp+KjZhm2Ib7npcowB/Hs+dCEdS3FR1uf2XmPKgCyJXJdw47x6kJ+mKoiUO218CDzqZEft4KCi56hGC3hFMFL/Qm+liwzqdUJPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X23jqkc6ZYFbG+cbkSA5ODZJQiQf+InlzlfbRHZV7FY=;
 b=I3N4oUUVKcv4ODA0GV9re385dXfzYyufPl8yor39bzFCSf7/h9r6oDAra5U6URwudn1cNiVR//2QYMQ97onIOta/VCMXwyMd/FLVrc+7apy8SXFnzrX/GDnVuhdAMXNgU6LCKjEqO2fvC5lZ+vGpSuuss3OLVf1CnNbzy95BJlM=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by MN2PR10MB3598.namprd10.prod.outlook.com (2603:10b6:208:112::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 10:32:32 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1806:9736:d068:d5c7]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::1806:9736:d068:d5c7%3]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 10:32:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix assert during replace-cancel of suspended replace-operation
Date:   Fri, 12 Aug 2022 18:32:18 +0800
Message-Id: <3eb88dc3914667123ebb0823bbab9e07b24cf099.1660299977.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1660299977.git.anand.jain@oracle.com>
References: <cover.1660299977.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25592e66-ab20-436c-5a8c-08da7c4df677
X-MS-TrafficTypeDiagnostic: MN2PR10MB3598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/4Ds68B7THyCRm7o/UzUBPVOcv8yeMShxBEWHHP4Jm4JL7BMXzZ3cSTNDBhMM4HCVIm9ExrZrZ2FBK1n3bCOELZLcQZuZzo6QUZdOOHt/gzpoU3W5dcvw0f9PmL4/JLcEqG2tzLOnA4EgzMv/2r5UytYCf71Fg7uQFVTe1NOexxvlpP2qqlInFqVGu70U4WeJzj/Pj29u3ToUjRM6PUKvCqPBlqLVlFzFM/kUJCy+qcePMVY35Yua9bXWTQYiFWEHi2QvQ35hcCgzo4DGDuPKB5NO/HRkg04MViuiZmRVO7Z4aJrDCm9zF0ieKfWwgoAyLXetmlzO7gbLSNE24c5+cBP9hiwBwKUkOou439xUT8O4QDJBQadEB7Jkh42tfW0SYJgmxdZSylMl3WtwGkQZt+fNs2ZRX9C/WVlzk5qt6kPfelT0OSFK/ZrELltl901uXjK5pqgoDkm6progGDR3DEDWpaw23rmPo86TFasyb0HEvGTgcVswang4JZmzf5OW+8crtfKn/eJt4vLFPGgviU0U6uFLWG+0JPKW3qAuoEsJr3rx9LNie/QCGeRdxUHcvhhmvlGuVsosKgDCzPWGDCjCnwf07vXHy0Y8qXNn54bWPo2eG8bwYRc6/HHRqV8hmmEW8Fw2zVMCybdBs8lz8pxxUJ8uef0PmOG+ROm5pNbG4GxRYANlkJU4029YUR9wwonFbWwNnsl34bSdnXDbP2e3QXUuPPaJ/WNvqpQOim+oZ0rkm2dyf2Nj1NhZhT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(6506007)(41300700001)(26005)(6666004)(6512007)(6486002)(478600001)(38100700002)(186003)(86362001)(2616005)(83380400001)(15650500001)(5660300002)(44832011)(2906002)(66946007)(66556008)(316002)(8936002)(36756003)(6916009)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?quaWu6/7o1WV8DLK8tPcdA12WSozgwC3EoMCKrc3RQ3Rpp0Sx5Mmz/BNUWE3?=
 =?us-ascii?Q?/V22YLS7ri2Vjj+QbBXLOniLmoBoKiT6id20CoRwNI0F0xZRxTI+YVq+2plY?=
 =?us-ascii?Q?bdUGP0/NVunl+sxkx7sZtjv/FUDHFj8j5JxDHi6cQ5eVBlqhlou8g4nLATWp?=
 =?us-ascii?Q?Ak/BqouZVOlHSQRZS+V/Mf6wytmdSc7iZ8fjFXY0FkK85XfD+hYSspV0YlGR?=
 =?us-ascii?Q?2BeqwXFlzMNNAeN2MHx2R8g2iipIuX4Mu6XImYHyaPnBvtxYjGTYZ/fpkgs+?=
 =?us-ascii?Q?wDIh79vvLZNb/86yUXfSwejeKR8xyYeBwwO8lFZVVxIF43i8mK+H0aYDVyM8?=
 =?us-ascii?Q?CEsJsKivSp/8e0P/iymhFD1wnSHi5INHbsCsumPIuwGoKGvbNULq9dWvczX7?=
 =?us-ascii?Q?XMTCgeM1VtW5FKjOtzOBBifTGA5jG4NtVSDJ4nQC7RdIGDNPaqwTaAAfNiY/?=
 =?us-ascii?Q?xYWKlWnwAG+q4xT0DezD5ORvTfGvHPVXeJazayRkfqyksTjzbBJRShWfhcWR?=
 =?us-ascii?Q?UPmbEMCkZlbwbw7ZcTFaOCbeJwjUWFXwpCRTGxFJTPrFzaMBvnFeu0PdQ0qE?=
 =?us-ascii?Q?2XpF2Acn5Zk46APadQdsxCgv0/6QEoeFlQUBjz5/6pNuA9GbYNlpg+hlLd8H?=
 =?us-ascii?Q?y31z7wqn7QMAByqoOzpmlonIQM4p3WiGpteYUp4UgDNUCBqdrf4RiV54QDz0?=
 =?us-ascii?Q?hCaLeHBHscY8kPNE+HlAGDZu1TvYwHRMoUBiAAtda6wPTpdBO53p9Z71SjWu?=
 =?us-ascii?Q?AOdlkWDVJY92Y4S4k8ackmmVQK8gRyZAAvNwedYEWsVS1KnVOZqRj1ZqD0HD?=
 =?us-ascii?Q?a6RmTio8/e7MvDsKUxbUsP6NouV4Axy8FzDwvA/8qnDtEH+51kk9hsHK7Kex?=
 =?us-ascii?Q?B/jlIqDEjFy1AwtJgkkidmcX8SuQeIYeWlnJ3d+VJ1jkATaXI12zR1akv8Ld?=
 =?us-ascii?Q?qfoE8MX7YsNVZ2DTuCh5E9rCcizKJrOy9NBmb+/JJwBUzdOzYtZkog/8zq5D?=
 =?us-ascii?Q?m7RRMfYC9qSd7A2cu3GQy6Ad6vo8aSUbTD4UB8XLe1SHKzjL5ZJJlSUBTi/H?=
 =?us-ascii?Q?/TeR19CplTLtitHFbPHnv4Qt8lqZpkqFmFqmTleumQ1qVloGLD5Et5FITAV5?=
 =?us-ascii?Q?q3O6i79sJ8vDhkBRdPDXQhTdQGchM1iq3yea3a6rY0+Ao3UE2cInSIpdSfck?=
 =?us-ascii?Q?E8hiZ28XgfdENxqV59pNWPrzKB5wXhthTxK3Kw4ctm5G8jP1ckXvc831gW9T?=
 =?us-ascii?Q?oYEBd7ETcqGE5SmWPayPla5RsUB+pzBWQNmUEDx3JsCcqC/Wad5VZMHGXjdc?=
 =?us-ascii?Q?vDiILvoN4ppTHqkoIJe+jiPGmI6oqvgdSCgyuNW7sdbyKGfuOvOnekuYFQvl?=
 =?us-ascii?Q?Flss6GcW5JPUli7QOc7oupBuobPdy9+ot9jgzKI4prUuChRJX7FEIIE9RQiD?=
 =?us-ascii?Q?bd+q25o0RD0EzOUQJbC+1Vk9cqCg2kj6YLylV8mCiqq6WkbYGVQIv8CkizYm?=
 =?us-ascii?Q?jY2sV5pBWD8vPsDU8dCGw32ct11+OtEQH7hMW72h1PzyE5wV4CJZ5TuLZBj8?=
 =?us-ascii?Q?NJrBArY0vl7oydqsv0UdMARQk2AXvCluwsKn2xMk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QgQRvj/gk+R5xDLVl8RwUysBZGocOBX76zIvAp6Se6UFVWMJnBSeONVA9K/YoyTgrnLoHxRIlEVMpo+pvE/QYybw/F5vs5mHGQtMvxMhuwly67TRtwJcM2ThK2vEGVbbh4FuHPA3AHbKG4zaJbAgFjKEF88XMCxHgCA2l+vUePVPoqru2AMqmCJbBs4bT7vrPwefHzC/Q8As1Cx69bV1qN15NDnnSyiKmzrR04dBmPnm++ANLOF7N+TD8Qb8OUcybgi+2juufjUmIYaW+e7uA0wpN3XIPKQLpo8yx/WNdoYYWx0VrbwTuPovKKWvywbK3/qumtmkstB8jF0uUY2yi4DVRh54oaDzXEu93UbOYwsGRbaFqRe31r6lhbDpxkoUHDOwPU10uOAcC5ReMtfO9Mi9zq64noRbF+IlP0WEbeFM7NNUlE2JpB1hKRFQMFQAfUERkF0HpjrB/gh0uclKy3v3ax8iOT12mhuVPMO+o7SbJbsSQiOLit8Kid5I17W71mZRHiYN255Q8Bc4adbjY06A3GW6orJv+Uzdk03DqI6WCqrpJPiu61x0ptwvPpHfPYj3VUjXbno41yLDOdYCpGtSW+0mRxbn11ohg30PCCwz8Ls7p8e34GwG5L9Zp2undhB4c4hedgkruQ6YkYBliCmUFdYm54vaT1xH2W1lmp2AukWkZMYUtTMuPu6wOPSVoQl7ZLG7F9OizjsbEUnHjjOS7WTLl/7vyzISZdJP9Is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25592e66-ab20-436c-5a8c-08da7c4df677
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 10:32:31.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc5Qd/yCysJHBEWWAZ8pVwNFzQ7OtoQWheiDWLnaz8FKL522NYna+Oe+PVHdN5puwopPoimtb98aqLUXc3be9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120029
X-Proofpoint-ORIG-GUID: oLFNVNGGSekDWQMSAzQKwHmsEyp5yFZ5
X-Proofpoint-GUID: oLFNVNGGSekDWQMSAzQKwHmsEyp5yFZ5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the filesystem mounts with the replace-operation in a suspended state
and try to cancel the suspended replace-operation, we hit the assert. The
assert came from the commit fe97e2e173af ("btrfs: dev-replace: replace's
scrub must not be running in suspended state") that was actually not
required. So just remove it.

 $ mount /dev/sda5 /btrfs

    BTRFS info (device sda5): cannot continue dev_replace, tgtdev is missing
    BTRFS info (device sda5): you may cancel the operation after 'mount -o degraded'

 $ mount -o degraded /dev/sda5 /btrfs <-- success.

 $ btrfs replace cancel /btrfs

    kernel: assertion failed: ret != -ENOTCONN, in fs/btrfs/dev-replace.c:1131
    kernel: ------------[ cut here ]------------
    kernel: kernel BUG at fs/btrfs/ctree.h:3750!

After the patch:

 $ btrfs replace cancel /btrfs

    BTRFS info (device sda5): suspended dev_replace from /dev/sda5 (devid 1) to <missing disk> canceled

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 488f2105c5d0..9d46a702bc11 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1124,8 +1124,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 		up_write(&dev_replace->rwsem);
 
 		/* Scrub for replace must not be running in suspended state */
-		ret = btrfs_scrub_cancel(fs_info);
-		ASSERT(ret != -ENOTCONN);
+		btrfs_scrub_cancel(fs_info);
 
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
-- 
2.33.1

