Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078074568A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGCHz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCHz5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:55:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB4BA
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:55:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3637ibgR020816
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ww9LxhqfGXde0Lblqpq7OXQHHN9GfE3KJYhzIs3Sp+w=;
 b=zlKMIrXq2jMivYEg7nswQi0mQiBf63pC8gY4ghEjTOGs5NxCBdp82yXGYiGNBuvkUixC
 P1afQ6UDpncTMEp38JGYX4bHiNY9LK1Rr3CflSJmczDqJgiGLOLT20wOxovyaPUP9Ry2
 BSjTp/8zUb0MZtdcT3MhSJnr4uqpkFTzpRm2wtS344+tdt2OAvhsMJuFH5BjfTd79z3T
 7n8kM3wWJUnZ5SJqVF3eWB7lO/mw8CyIXs6/aXDbIvbLRTy/no692tYahlIaQZHNvKEc
 3SLXtwbfv3bMlHp0cVl66clkGnoMzxunpmSxT+fhJGBb9xNdwBzmaN/gqgLpv93yWWjN yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpua0mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:55:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3636BwGO040253
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:55:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8r468-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StAkiqCNVCzWhNFevRwHQVJj/jZIvecf7A7tnUPk9aBx3XlxaWQKyYpWnpBqA76r9Sgz3ftrhw0gyeBwINjRZw1w5Pm+ea79FRARIbwppL5TizAosfHze69GMwD+tHuQzaIhMhyWjd2YzTARodkImq+daaIK8aBMac3n0sVwBpy6vpZhZ9iRRDuM8WtrAGtbeSAttoxoPqNt6u3AQAkYlAmRZzZBkRiXQ1cF/WyclqrtI1sc8YjQODqZ76DJnFiIW3E+8iBxcczvuPFqKT6M7exvi+v/bYTCEwyBqP6ogm+9c1ZoDXE80bDiIkAgv8jXTAOqyQjIBUepSasQq4IbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww9LxhqfGXde0Lblqpq7OXQHHN9GfE3KJYhzIs3Sp+w=;
 b=C5uAx4ZwSLUDWhbj+QXrg4mQ+rVrKgJZoKALE4nZtKHWmwmKrbVOqvyXZ37Kv7wgK23k60YKBAdNUCS/SJx9sW5hM6TI12zycCoX+LNu62XRLO7srhQ8KL1jo2qJ2z9BtD5KOxaWzWTG3kA471jVgTC/3wGNTji8MCt53BsbyILkGPqqtWJikVZB8+ECIMeGe7Ka7BoQOJImpwt65KMwG5KTS4Ma3YRNpt4SNLbe2rSz2rBomo81V2wQsetWO/9jNzft1OK+QPXFNJ9ob1ScdV/wcbvIIjG//45jppIpcl8NY/vxKqq0lIDfmrjrSQYd4dkxoOsNNzUPLs1xxSPp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww9LxhqfGXde0Lblqpq7OXQHHN9GfE3KJYhzIs3Sp+w=;
 b=zhu4jJIXtlxo8Lnmv6EbgPJpN42JP3jnzMCItmtKu48PD92+gL+Pv1eOVaw55fhB4Jo8n9opICsun4xyIhkK3IW12ipjpkGs5l/G0asLPjhBXgGhMA1u472z7ALa2011QHTXralwQBc1w3OyjgcDU9XOBlAP0DmeCvr/AAKAZOM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5243.namprd10.prod.outlook.com (2603:10b6:610:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:55:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:55:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs-progs: boilerplate code for printing devices.
Date:   Mon,  3 Jul 2023 15:55:41 +0800
Message-Id: <cover.1688367941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d5e4e7-834f-47fe-87df-08db7b9aeba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghPukHU4K93eb6KYBfgQ58Gs1ao/C1ikGmqHDcIcUnDPyTJWZkXj+w7dXS1ErxcDoHBiunzpNmP9M3OstJU87QryAPO+wgoTSy/E+re3uJA4TQuS8XVbrAk/UBjV1CJi3oHqclaBrBe/ffJQFkNG1tZWmMJ8DoNPWET1qvkS8yAmtjIhFfmTxvtDJoZ8CBkCfqesOvyuu6h1naotj8/27hIXua3itMRjHB7UW8QBjdw2bgqsJSBYwrqb1ByycKKt907lJPAbHvZTDs8wzPjqWLDUd69d/0KOo0WnQWFEC3QBF3BPmigtffinG0yQiV+B5OSlOb3CHofQB2MgWqqV7JovClB0YNRTGv0lochn19dZV81auJdjSy7TvJM2s2pF6MxOLvqISRDa249q9Y2NIANvj29ydryaWHxyhuuJPgWpZzCGu5SzQIWgfCXYve3BZ9xTzEp2Mj5bL5je183sbXUOu/qGqYEsBQbi6wyLC1prXtZqAtDouiY5CS/Y5gnEHOoqzFunrynWncqguG7Y+EhSt3jWui2vAAKgZsqlbbyvZet70ORWj9JIQPeaVxAF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(26005)(478600001)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(83380400001)(6486002)(316002)(5660300002)(8936002)(8676002)(44832011)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enZw85+PMOKTO4dHIzjL5wcqW57sD9oYL+NwOeAUUep4kyRe7TZ9KcF5kCir?=
 =?us-ascii?Q?XMg2YksU5smsJcfbPXMmZ9CUOkeFzq/8NFqjTBCMQG2OgpQguw/IrLp1CQuZ?=
 =?us-ascii?Q?vAbDCQ/VWuQ1P3fweiLo5BfmYYL+9tBtEMrIfgd6FaAdX4exfgx/x3eY3Hoy?=
 =?us-ascii?Q?AEs4rf/sxw0R6jFf1aLuONOWuQRC5puLo8BJz/rE2U6/gRX5HoVxFKwRt+u9?=
 =?us-ascii?Q?mI3NHNnSisRGZ0WDkMRRd5WVNH09VXMg8jOjXF+UZbtsmD0bn77TUITuTeLv?=
 =?us-ascii?Q?6wYKH4gKdAesE6HaUHhGbbw7n73NDa01JYhD2FrQGc/OAWnRqzIlHBKCN5yT?=
 =?us-ascii?Q?8oK0XPjJbdf5XvoNTXQPRT1idrESClZNL8DuU9EEpGnPXw2IaMD9yRY4+kPW?=
 =?us-ascii?Q?xRiPB4oTC7kNaR/SH2N36lc3cucdXI88mMZtJOFLPqCM9L51Qw0x/xqGECV7?=
 =?us-ascii?Q?hzet8UOrtaBmhZ73JG1goPMbAy0dzDBX7TXFqPFX/qN6mHcwe6h4cvvRgm14?=
 =?us-ascii?Q?qRqVdfLyAVvsDcZqMc0kERkkOwsqVXHYTOdIjd6xKIP+EJytG6//P2YRw4CM?=
 =?us-ascii?Q?aQaFEzlZ0y7Rfl/EY5MwM10DhgiMO1v03dTYoDB+M4jjyT8q6wWqte5rK0EN?=
 =?us-ascii?Q?BSDhOYkXDtrbvmGOXMekpNGHEePL7/t2AHS/ZXYwNQu+P6d8njFkosaxfS5A?=
 =?us-ascii?Q?Jhy0CTVOm1x31lF9hS2hFrNQEsxP1XaHT2F2zRyrBOi7qiw2CPRjsupF+p2i?=
 =?us-ascii?Q?roFJLgpQupDOWO+Xq9CFQuaduEd0jEjbn/6vJKXTf9aupjALjUsRCgex/ASt?=
 =?us-ascii?Q?Z+TvSJrneGj1XxTPN3wxb7Hieh901HOJ/E5g2n9OvzLRhgjMtmCGJ+r5y/ZR?=
 =?us-ascii?Q?w65MXu6dpUkwcIi4ZrW1FwSIEESZ72XEaW2h313KT69Ku2UIW4o8MuREaggk?=
 =?us-ascii?Q?/RFZiHJi8FSsEZ7xMtgrtB5vXwCpy6V4WLRvcP+QkHivNn6jhHdkbXB8MgPr?=
 =?us-ascii?Q?mFjTHFpCDFv92I2q2xofMacHiwMttb/wJ2pHh7ovoPcuF3lIuuzGfpKz1BPI?=
 =?us-ascii?Q?BwzrztyoLE+Sr8cl8BvDERXQA35sILo4CzcQ/xee7aTsUKDwYxWKf27q8O+q?=
 =?us-ascii?Q?MUwPWwEP61oLz9l9HIKLApFSOqha2vjqgznphR2lx9b5CFkf0tm7MaNrV1/J?=
 =?us-ascii?Q?GeMtXbDMeW1QgHMTxkBZ/T5P2NAspRjAKQSe6++WCsCZ2bqpz2OmCNCTXkf6?=
 =?us-ascii?Q?oVl6rGlX6HyKCW+1C9U0OThe4wiMJULtOd/gFhxZsAQWwBMXLRkTJLQ1jWjL?=
 =?us-ascii?Q?lvMb9PEvGbTTlTZez2PUvRmuerPDrRlEWelrRFeuySzTSCZuTxJg8+RcXdba?=
 =?us-ascii?Q?3Tj0/pD4MlyTjn8M9tth2Rrct4c/d8eSLGT57uE+NrzdJmSyAd8fYVwHen/I?=
 =?us-ascii?Q?rGHC1p1xabmFhXss46NMJIukf6dlPzHfBtMALZUW3gqxewOkQFJZsc6YZGVL?=
 =?us-ascii?Q?LUFf+YQshMqGHiwQcv4lFT5Z72zdFvOKEVjo8hDHoxYI4kFHYXvlzOGhp4fU?=
 =?us-ascii?Q?euLaYS/QpzJ8JDaxA7cJWG2jzsJDQ8HmDWnFMFD5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MeT53WXpSgmE14cRnw9xaPxAMRdQGlZZRX72ccp6YjIVaj/NyC8Sh3h+pKQ0a98tEYxJwBfleo4zWnoykWpVLz0GeFxMUd7NJ+knvu8rR/LYirhCdlH7fyFaOFlwEAOcPxmUU+ryHzlLcmZr50HIF80Irz0Bwy3wjMoh/bJan8vvjKj/DBNHNRUS4L5vb/LwyCRZupdoXoX2PXR59SB1W7Tx2hAv20N1arINeY1YZtn9ECP8XSa77P2cGdcnGDRS6d3HI17o5Zgcb+GiP5qd5Tk4tsRO18SK0CJukVO6SnJDn4S2X73Tj9PkCjk4QdZPPmI8Vm3Aur0eACjZxG2AxquAak+E0r1mzfHlKmTJ0+RhPMnxQGJp/mHmQ4gGMAmwr+Rgom4ixHLvcw7c+wT9hVQGl/teoj8GdPZQLMURFkdH5FPFyZmpm4riwhknE+C4DzSuVZunDqwa4z9KKBuSgr3SUKNRs5kRpUqZgyS84CXIJ/cmrlxuhLs0HXibR7yabYNqG8ibnQa3ooKIJLVoh6hImHU1iuOk+kusld1ybXHCkgDXBQNCUozd0h6JPuA8h4qXCnZkgNDgPPhsRlf1KLFaW8rQXCXNpyKZu+SHJwjVtG14eg6kSxyJ09ddiUQLCe2S3eJYXqWOLfYgPFo5rokQIRzpemOfHSv4ekAFyR1OZxB1ErI0ThbwttsdEM75BLZRXMX14AXGyiDF6ytDdjUf5I4SxWwoVADLCPeo6GAcjlhRfcTxZ/qocBYcwOJf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d5e4e7-834f-47fe-87df-08db7b9aeba4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:55:51.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J09SSjPc8EAYNu4ELLcqm7hpIOGIO73mw/UFbUmbyO7cztANGFhKnuKRYZ7pL4YDapBKWgpLwVuoSiAGWDROAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=972 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030072
X-Proofpoint-ORIG-GUID: xLiCn5GO485sbjwu41A4A-3-oE0nUOMs
X-Proofpoint-GUID: xLiCn5GO485sbjwu41A4A-3-oE0nUOMs
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a set of boilerplate code to print the whole list of devices
wherever in the code, for example:

	#include "kernel-shared/print-tree.h"

	btrfs_print_devlist(NULL);

This code has been helping me to debug and fix certain bugs for some time.

The code is a port from its kernel version and has been roughly optimized
but not cleaned. However, I am sending it out to see if it can be integrated.
Otherwise, I am fine with maintaining it externally and keeping it updated
when needed. Thx.


Anand Jain (2):
  btrfs-progs: print device list volumes-c api
  btrfs-progs: print device list

 kernel-shared/print-tree.c | 71 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/print-tree.h |  1 +
 kernel-shared/volumes.c    |  5 +++
 kernel-shared/volumes.h    |  2 +-
 4 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.31.1

