Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EF725B38
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjFGKAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjFGKAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30C1993
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576JrnQ011468
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0a0TGG5Z0Aph1syHsauEg+nQtzcUZXpNjylzOh9oHv0=;
 b=Di0QdnKoOTrBrIdt/5sy1IKSf/aATykE+MSt41IUIhjd2RBoyauuAfDuT706M2RjcFwC
 L++oUs+CpmY3bwaO+rSpM2mmm2aho30h6Gb3zAOLp+k2nnCkChHM6lJ7fQJ+kBTsf4NY
 I5JtODvLruFtak+q3k9Ckpwn4sHc+0+xIYZ+hCssWMSxuKqzMIC+YBYim7obkUQjAKqQ
 hON2gFz5OxdLBEuE8juQ67DLizyeIXt1o1pHQaZicWJ0k1z63tt3UQsyRBldVj3sxAIo
 FbB8S9klk496IAz4/HwrxPgu3qug/BglGm+fX1Y4ZyOg9MSYuPqd5ovkTTz8LY8288Um +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uscw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579eaRW036799
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6jh8bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayBabGFEi7womecuKBqrfuUVAKtIwCAISd+upu0ZgD+rSb8RnHP86+Xuc7m7jan2e1qO3Lzz8jocOWgbyhwuEkAFWxrzyUXbOy9qzTb1DI07WynZ984+cSXAf1DMBUalXwBl71s6AOO9omRlzNKdOabYfls1XQoZ501fx8X4C+bXDw/UKWCcVdV8bAPrzx24Ps9pKxrIBuGge3AKSE4e1mKYuKabgdimm4iD/FCSrxNhh8wT8ajKlJ2Uw05PXkPb9SO6StppJBx7TLE1YwgkZRKG+SJvlCUr0nBna37pnbAIwvnU6GTVWHrEHgVsAP+B2+RQzYfBxrgH4RIYHi0mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a0TGG5Z0Aph1syHsauEg+nQtzcUZXpNjylzOh9oHv0=;
 b=EkodWs4fBjKg6jMgPfnfotqBbjwD3UjkGS3tlQHs7deTSJtIbcrovwWNtSybBWrg5yC4zRjdb/HseezQo6DTKrLFrFbAnLM0k572E9S4ea22BH5Nkf3XJeZQDis2dqtqEirakt1BQ3ytNwrpVmDdfwWggL/3EN6SNCVQ29yKL+idVx/X2Qv8nO6TTDPeCM9EwPUs4l5qbrw0HzLhDmuVCZbxkehaiC5V6jY4lF4D8YlmlbLlGf8ZUmLwHtP/AEGEnxCHSNH1jJhHNvaW5EG9o1HcJWypXsa6s1Vxn2HJEf2edRZnyNoW74Ibm+5x+Z+Sjy57Mskf8gNan/2v1tdpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a0TGG5Z0Aph1syHsauEg+nQtzcUZXpNjylzOh9oHv0=;
 b=mUk/Ysw/7CpC4XfylNijI7kx/zLfMVOaDRn4PPXQCagBVDtI+3nCH5AcDYnXbDxu+SnYLhoucL8mIP3XklHTRJQtSRGbdMaEdObFVjojOMmnA9GonV/DrS5F2D7RLCF40Z0v2SnojZ5jja0lJrBjr4VblEi1ML2rL4F91T66iBA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 10/11] btrfs-progs: tune: add help for multiple devices and noscan option
Date:   Wed,  7 Jun 2023 17:59:15 +0800
Message-Id: <a4689c8cf4a314ef98c104a98fae63a9ea491f72.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc4b11f-3248-4339-bc74-08db673e10ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgKMtA1H75NyIPktNdCjGwr+6BQfBXd9oHaW+xXluM2yB+DE5FacDV54icQiaae4KCy1JpuP8XM6b417/FdsjyF0EdCVQOS4KGzucgGrfYZ6q8Cv8pFcHMSKujWBWfNUNlHulQ432eEU/ddJ03rLXKxl2DqA+rjzyVdhPE3lPmfn/W5M/7nphW1yDIZ3NCM9f+tMSSHCxZeK+4yOsENlwW+CsKCbNV0NA+HIyEtNv8d/5QHY0twrWpPl4+JoxFavEGTprWzjqQMf/AvctOGqlLJkoSdPpm3up8uhWv3mBWOqMllZS+6UDjy1vwCzehKSa60zy8IuKp/7/WHfMJVEOd+1Lt86sikwoR8bE/amnDRIYhC31LAG6grilhiLiM7B3MLC8PNZbeS3UAXAwQlmpv2L4oACXGPENPTszCDmwUzdAhq6FkUsQdGZFLEXG8SrR8uPaSBfWg2DLa7xtJ/lS6J0+1pMDr40wB+oqf6kHhtine9ykhTKi4+4M6sDYRkxtYJRczmk7lpnYWgfmwTo2N/QzKwljlfXQvSNVTkCOSYplsLKRhcHh5aqrUl/2qHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9QbIe4JxAooXaEgnYIB7pNTG3oA/lAXAITpCMDMBflNGd30lNGO/X9Hok4L?=
 =?us-ascii?Q?UDpMIFO95FS4mcSk449nGKtviDt/jvoE3HBmdnZ4brWVeY8NNgEisklbrtg3?=
 =?us-ascii?Q?56gxV0fsNglKlXxpjKszRF6lj2ka0KGrGD2TgWOzwqyrV5f3GsrIh5ODo8ss?=
 =?us-ascii?Q?brZ6QfZd13TLJFmqkpmFgNdC7VK6Xj1gSXcOjg0c0qI8jHXgDvL4iLy0z0iT?=
 =?us-ascii?Q?ICy+ZV9Hg6q2FzzEsjz4R7lQ7UU0IGQUilEtTkEnNIpNOe991PWa5KqTkM9I?=
 =?us-ascii?Q?HHfo8HjlUGTmIZZoqHEMMReTr5HL+z9EnxBmdCuh3/bvRyT6QwvxLuOLnmQq?=
 =?us-ascii?Q?hrmu3SXqckOJ3G8KFfwC8Ki7VTre+5gSzPAm0/PotFtQm9VuiGs8KrgKkf1Z?=
 =?us-ascii?Q?jUjUG3lvy4YVB3TwfF3jjMcrl+fcffENI7pn2XEoNvwI0AD1LCUJNjOqmkYX?=
 =?us-ascii?Q?Vc4N+ZfNLRxvSToWg74xM3bZoU7CvtujmK1bt2gCr3EOh5EjGFjCmVkgPMK7?=
 =?us-ascii?Q?e7B8ocLVIwDyIgMpgjDzWp0fVDC5INw58iEOjuLpN/gsZfrBE4ch+0zQdtau?=
 =?us-ascii?Q?rtyp4CmmeYOzuyDA2Vrw0sCaGL3M5S0tQ+3V7Dh6oJmLv2SLXcrTxpv05Lkx?=
 =?us-ascii?Q?3JxhZ9VUIufRJslqWoUY0RjG1kYgxbVWjXs6s366Bag5Z4fQQSnZvjkLR8MN?=
 =?us-ascii?Q?tZqxhcLXwHGk2JQRx0yzT6VoKRelXHqqd1bxaQiHv5NLcgpYUYr2+sv5CIs6?=
 =?us-ascii?Q?i1Tza/Y4MKNwUa9tZggGnK71K2c86b9ckVm1aPv/lIXil8N1LgyFvKwk9zJr?=
 =?us-ascii?Q?BuJF0ge7YVO+uf/1nNTONhg6NHzeUmFtYFrYyf1PeyW1zu8QlRqUTzPzvLnV?=
 =?us-ascii?Q?JvhoSAXz0e/7+DDgziuhgDZ8sT4KEIVPESP0m1Y11BPI4eoneemg4nFC8dYB?=
 =?us-ascii?Q?jCTtJUDcHgrAv/FfieJ46UE9D6Kzb2IvIHCl2yHCS2Ka3eM0czUh/5Hgd+k4?=
 =?us-ascii?Q?qLInp3nLWMZUnu8kwzxlOI4clonlEc+2OBhN0rfeFKWU9AiE2zxwXjw1KPJX?=
 =?us-ascii?Q?HelRCdsQgF0r/9olD5V4MoRevq+viVJX/NSGzaiT/ma4D0fTLTYe5wIT0M6d?=
 =?us-ascii?Q?7/LyfmbzkB7pGmsiY839iquRUbph6Jfr5rlZJO/3rhGl/OhN5sA1ot/JtZAy?=
 =?us-ascii?Q?uel3uoNXisePbkq3Gg74YSa0cmaWjkpEIezHMyOI85hgyYIfCSfLH8oNosf2?=
 =?us-ascii?Q?07ej8Z7Ds6pR9cCBWs/GoeVRW098cUzUIfnDMt6hJGia2KXHP/1tGRdG+Oj8?=
 =?us-ascii?Q?9m/tzYMgRfedCZhgc02jKHyXyVKj162vbqweVJLeGLT4N0W7EjSZPB8aTis8?=
 =?us-ascii?Q?WGevcGcF3oDGMlS4guQht20tXrTuY/cGHU9XN92mLtIyqPkRNVjC1VSmRwh3?=
 =?us-ascii?Q?X5eqLqDXXur4HaQPhaW2S8XZ3rbDYO5UD3DwhCNRqs4F7oBF8SHQ6aoQLc9k?=
 =?us-ascii?Q?eJbm7V4Lg64wEa2WfJx3ct3qZhbWntlifgeogatUuXRBqrmn2Y5S40mKtzWx?=
 =?us-ascii?Q?VcFAk1RDd4tXMDMhdOnOYzXpcZG/Zk05Suzngl7p/HWrXEZ4G+7SjFE9Kl7A?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s0eSq2sK0iMewgj/Nnx6OMs6Dahe2KTdWsXL1I0UVT1BO039JM+RfTUMzD5TzGHToAnSUkIXcygRIPMKxe/u+07loxkMSF9Sq9gFn/tsnyNtIVsSTGxVVH8U4+4v1d35S+ey++jYsBXHrN2i//IrbgcRjGntRAFRyZB/EJ2RPRaqdcUTBLkmtGl/VfzZ1jtbgJ9bcXoHGGDqGh+Ep0T4s3PuMdyH3R4LqLhxeiwT0P8qnF5EKwNiWVGTVK+FRK1cLzKJXGhV6emHn9EM0g9xBVeHGtrAG6Rq7j8AmfOZqxBbL3BHcSCgVWS/mrEDDPhtYtzGy6lSii4CzJAAFXxK7MSZyEy/+w3m2sere8FYM9i1YayrI51kIFw6yKdFph20Q6F1Cx3LoaBsZ9i8JD5Fy++uQtPIkPh8HVr1Qk84Xg8iSBT0aY0e7Pzoz9gT2ZPAOj4mVn16nGgPovJwmghhuCrNPLUkJ7aai34EwBtkhmvK6a3VkAAzxLUcb7VEzgEVgdReDpUzR4mYQzq8wAdAseUmtKWjukYKM22woDxdbTLDEuRJ427awww5VY1WtuBSZ203Wa9P/4hI9VMM5n12DnGKJ+2h7OYBb5O3D4/Lj1uKJfDPjOqgRgtPaP9ZLHBWhxjC6rdDn5rz4U7yOYv6ZO9DG5LkiqJSiQ55D6gaXxYQHkhnwH/w+7l2luoFieneZB+l+vDXcwVMjE96hpqlxP1fsEyFCO/k/c4sIQjDPdkJM6ZuqBbc8e4RghaSbp9eEkVmpxnRBL8dx+zOTyPmtQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc4b11f-3248-4339-bc74-08db673e10ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:46.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC+HBKTgHo/jaVG75Q/2Nia5oCz8TNRzw1DDwGktZH5cT4J5zhMUXvkxIHdrCWbjtoG8BTRa4PEeY779x6eA4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-GUID: iWDz7oOxfhgSv9HA99tV6RWAepGKSy5w
X-Proofpoint-ORIG-GUID: iWDz7oOxfhgSv9HA99tV6RWAepGKSy5w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Updates btrfstune --help to carry information about the multiple devices
in the command line argument and about the noscan option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index fa49f1685e0f..dd412113ec4c 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -94,7 +94,7 @@ static int convert_to_fst(struct btrfs_fs_info *fs_info)
 }
 
 static const char * const tune_usage[] = {
-	"btrfstune [options] device",
+	"btrfstune [options] device [device...]",
 	"Tune settings of filesystem features on an unmounted device",
 	"",
 	"Options:",
@@ -117,6 +117,7 @@ static const char * const tune_usage[] = {
 	"",
 	"General:",
 	OPTLINE("-f", "allow dangerous operations, make sure that you are aware of the dangers"),
+	OPTLINE("--noscan", "do not scan the devices from the system, use only the listed ones"),
 	OPTLINE("--help", "print this help"),
 #if EXPERIMENTAL
 	"",
-- 
2.31.1

