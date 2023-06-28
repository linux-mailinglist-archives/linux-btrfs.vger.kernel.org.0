Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27076741090
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjF1L44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:56:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45500 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231688AbjF1L4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBT8LG024960
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=5LHVQbpO8MEvKQlTcUWudv+5R53EDHgfjymVlhBesZU=;
 b=kcU+w8q5j47LNGBTnCLuRoTv40fwrnCJhO1CousWAYjCFZ/HVDCfmpY72pxDxLAOwjLW
 rQdKMavFwkNvqLiFp5MP3GiyzeVepj2eIH49x+eCoeA/LXq+jwe/6gsyjORSlS9dVZWn
 hPbPVxu6acyuS/X5X5bjr3JlM5+8UAmm7sezOjtJXuaurWJzcw9UTJg/SkEWtd5QC9xp
 9FTKPcpy00yBa+pyhThqDdZ0uU4kuTqBwm6tmtj/Co00aIF7diKnKdDJJMxg/p0dzLFY
 ETXpuQ0VtAKYzQZpYpLLKrJM1nbVjnuHz6DCfBOWOeSh2qBIAKMg9QYT3zmcGCNweHeq 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e5hxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBBgUw038194
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcdna7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoNVPWXTFPuzmPOBrV5I8xNvfM7Tx7XbAIkn2h4o/9W5quHx0ayLBx9EuZjKk80LFutiZW56y3TAnphYJQFvrAI84NhKnRrcLkJTuxlzUkdQtTRIcHHrTcU6PgVbjvIb9/QMdyBIgZbwXBaL4hi//4Zh12WGeyS8YraDGyT428OyU1pUfDdkzUStoOnTvd4NDZAdAS3Wnpp3cFSujeASCH6fieXWUZNeyAFviVp+qpvUMfJ/QspTlykMCt28TVrmnCINt8Vg0YGdRfUcLmQhz42+H+sx802+l3hGwYI+oK+kjYM4px0xx53CFQO400QLAUIADp0cj4KjpyTCuraC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LHVQbpO8MEvKQlTcUWudv+5R53EDHgfjymVlhBesZU=;
 b=g4vuI306tdykz/lIX2+dah0bNESGVYV1NZBaUNlrQ16zW2H7uUAOKVFdnnDkbwCVF/YQDhPcSa7Ovs20N0CMWyKEXMdvNnpvvTBbTicDHAS0Qm75pGQIC/8kV9GB/w3ws/08HCdtXUZd24kPoK5rO2AbwdQx/8mz8KzAF5sd8zGWwCAa0L0g8GTDJxmymxsq2SzSIGy5dghim/1sJi6tMsY82djVvNZPglnmrbQnJJSKIyZyoR8tY2cL9o7DCtSXxEK0jmxI2Czc9ZQS1ba4UUR1V+oN51nS1X6dXQ/JvVXd1tlmg1IHcfudFyInj+4TXtpB8zuX7UpQjE6LO21yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LHVQbpO8MEvKQlTcUWudv+5R53EDHgfjymVlhBesZU=;
 b=ErDumrlz4isEM6JznwGHg75fKYCIfzaGB89ZtUmaDaLZxmcLN7rPei/0IP6I1TfO79sQ64AkSuuQJqdyKoDnptsN7u2TNFT7/EUV5BpNEDMeeYJJ14cQblEgQ1FAgGAG2iDEgzBsUZthZbJqR/RjjBisZtSDHvTrtZAcLty3PZs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:56:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs-progs: docs: update btrfstune --device option
Date:   Wed, 28 Jun 2023 19:56:11 +0800
Message-Id: <8bfadf1467d7a5b7283d4bc4b5b00b7f070dd814.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbf1fdb-9bf0-40a1-8e27-08db77cec25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBhb69fbzakacbUQcjucofywAt1YxooWy4VncBR4lv+MQsTqmVBZdisozvR4Ukq88RovQ/5hfKyksq7uBZBMzYuuVbz8QDdjkpE5fLjnWOX/M4YwrB8j56qb/ZvMpYDYAT2VX0n1kqdRh+JE5gl3dk/O8iMy84AIwa9Rt2gLsQ0xYmODV2qfOqji8s/Yk7K/9WMLXFcrc8UfRPLK6Lc5Nvgzss6o+ReCuhix36xc1pnAM6OULTcF3wbYptNaOhk8PSkHaX6SPWGx697O0vNgjZ4aPuZyK0Oeo074MXZAsfAf8juyAACBU/RS1y4hyrxG+YwYGr4XRP2Si4c2vDvVaQgJKT6A9qeDdDIXh+zBxjAMKNn6keCxz0zYZBBOm0hRB0G/aZxV8yCe5DULZkKcjijhkCpqnVHNRReMb+12MRLwYjJcGV0OJuHuw2MkEkOQAHcf/pvq7q4an03G1Bj46L122rA4Wi88goJn+3BNTJFzI1n6qEuNIlNsR6p6bdKmI0KhdTLbVCA0kaZ6gbYMVTBINX77qTCwakL+el66Ym+3R37XE3OA7Y+5NaRSaj3g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(15650500001)(6512007)(4744005)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UsYkV1S43LrypmfgUan4CJWc4xcEjMqXVMSa/hRsjfEVB3Nxe8mxYJQOlshQ?=
 =?us-ascii?Q?Sb/PdrO/c5y56tUdvCfK5Knut+sNSeK4Pgo2LN1ICLJZxED2IjsGWP/2zpzN?=
 =?us-ascii?Q?H566rAYXGHW7BT/vaB0YyzZ5oUl+wUW6kZzAB+QTg7BAd98GEQGjKX+N231J?=
 =?us-ascii?Q?M0/QqzDYjqXJ6xdGLBUmMPp8FRvBPRBbf0EX3qsRH9+3VmDqEZqssKbc+HPv?=
 =?us-ascii?Q?pcka9YFDL2cvE95HJx4FzXhpT23N5RqNyOLdSu/ZHWjiT5//QOi7ue24iQgo?=
 =?us-ascii?Q?kXR10uJNFQqZzR1mmYw1swr4/+GxEUKjXtbdMpl7WjwBlbh37r28/YI1J93/?=
 =?us-ascii?Q?afnF4cc15Hv+pJndNB+xtYzD3EG/W8kT+ueCu6ZlFNfpuMLjW/YXirGSUStU?=
 =?us-ascii?Q?yVPo3D96MN/oK71/Oq/4dFbGivoXjo2fDXjm2Ri7tzA33DB7ZOMD1awdlcj7?=
 =?us-ascii?Q?2KxVdQr+2fqwsoPOeKuD+PPchmVRzC282vLcdsk9jCB/YzGRPeqhXVuoaUEL?=
 =?us-ascii?Q?wdMlDWYX/4kQjNx2s2VVaaKU5b0lu1hnu92I4xuKnyRUNrRs+fNR+UPwVXM0?=
 =?us-ascii?Q?FJ38HF/StARD3kggKlZNEcB6ol0/MX34jsOaUFnDUwaluZpoELLssOFX1ppO?=
 =?us-ascii?Q?RqrSs53LwrXAidPrY7H00GERK8hJn0ZZ3o24AZUUMFDNz7uANw5/6yVxMLjp?=
 =?us-ascii?Q?x0DbYqxSGAUWgx7Qlf4lG5MCZi2Mc65RdGLMJ7+Td24XdoaqAwTl91nV0mGt?=
 =?us-ascii?Q?xtdrG7O8QKi0OnGYBFMbXD44caZBBeTiYAnoGTBx0QDJ0lWKPZffx5dq+Y27?=
 =?us-ascii?Q?XKJ0vobF8j1BBYkj+DBD+H+mU0j59IIhjbFwkp2eiRLBpqu7ts0P1JNSHgP/?=
 =?us-ascii?Q?jI9IZXVw7TgyXwsc5bcugpdUVxLVi/8+GEnMGyz9O6uWhgEIwwOJe5M7A59e?=
 =?us-ascii?Q?g9VIxJJFGFcOheKMlMYZ/Bo8HemLJfgrgU86L7wv1pvSV6gOLhNbTLHqjnaz?=
 =?us-ascii?Q?g9vv3ecdSwzncBTYvf5DxKdE5D7wDY3B6+snxuEgN9NGtwX0Rog+nZ37kYa2?=
 =?us-ascii?Q?98gDXBEiTczeneI6H9aBwaFOcK4OWitUrvYDGh7E78nyi/OPkE1nzOvLNBU7?=
 =?us-ascii?Q?BhOLa7e0OEyb4qDLvJmHnWYQIpOUYHwVY6i8YA4i701SooW2JwANERJU/NsT?=
 =?us-ascii?Q?oourp5OkFpIUalwsJjMlFVW+dHH3ueorZ8CjmXgQe2diwtCU670kKQ+L5LJ/?=
 =?us-ascii?Q?VrKNg0jCeS/QC/6uZJ6bSn4HATmUt2aXISvlq9K4YIob3Il+lO/iVMvBKVIU?=
 =?us-ascii?Q?+4WpXVYaW2wW4CSImcV5Ne2AXFmfgshTfG31wA1koUKgDf2/lXKBs0WYebQb?=
 =?us-ascii?Q?jMZKEgqGdV/NL9/paVHdeqsF29u4CeLzH2R9dJeoFqRZyigbxvcVK65rIQct?=
 =?us-ascii?Q?YReYkHQG1f+0dtLPaLhoMVp+oNGWOO8lnk/uJuGSEXAfHfxdNiPPz+alUURc?=
 =?us-ascii?Q?oRUe2jyhu3QN8KMezvB19CXv/ma1l2j9xwv/iXcBuODvU6e0zNaxzTDPkirR?=
 =?us-ascii?Q?QUyjqE6xHw2gkano/ZJjn1ZVnVl9vcdeaOMGDnYx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GYGZ7g05LdRCF+yTCrZZyJNWgoiuwwOOtYBiWwycTeZT/brWT4Io3eZWA23mbp7rYaautp02yRo4vsxGzr13dtbRZ3FRF2VccktDVoUbneov3ehlWNup568p0r344p6z1WS2nj3Je0oMZ7teLADJ6O5S48XaeK0WV2mmNdoZRkm5o/EZTYpsEsX7JnyXEhKAI4tcwXNM5MmWB+RpRoUwLJ/dk8G0lUEJe5DHE504tlVO1mOA2k0/iUh0IDf0OBkbThXbfFmelPX8R5nifP5gJHyl8djrbek5bRsc+RuQI8tJm+4pLJ5xJb4w72jkl4In4vy0lZodSxteXfqoFuKCrW8C9/yjPfqSYYFqXqpzjxwYpRGapgAWMvzbHGnfxZIx9y21LcX+KJRLqVrH8hAmgYtzN1KsrQZvDLrEcuGyVPSvf5W33wy6FAOXIsaerCHRvmzQ3pnSyBAN1CrmOxQA3S18c3SC5ubwnq0aqNG4c/+EHekK3TdRzgAhBI+ys++cYI4Tpuen2zUsfmyAYPirhwl3WFPNg53Woe2Fz7DWlioC8NI7fpXRC3AbFhi0Y8t3leQ+rSmi807NGAfkEhRwJQ1mkuMgyIUNVYQSvKWENceo2jwfLvT0YJBjF1fZ7PFwtKJbB3i3/NJlauAwo8+dSHhJVEMdpSDUGOFBxcyErjQ52t7VfcrwRFsWgzWDmsopQFznk5jbEFjRTShBVPr+qvTPJtv0fG86n50ZLOL9r03S3KrFjvn1szZDjlPS6lV4W8jWaf8sMpx5KeQOHMxvtA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbf1fdb-9bf0-40a1-8e27-08db77cec25f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:56:51.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KSs+DcRXsQ4CfQPH8ZhieOtIP1Wi3nVeUekwJ1br1zT4jgPPFXIVRIxOgAMkhL7lkATSjwvsrbzp/8wFNipGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-GUID: 5i2dfVcyuY1GeSXxw4o6uwaDj1udt0su
X-Proofpoint-ORIG-GUID: 5i2dfVcyuY1GeSXxw4o6uwaDj1udt0su
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrfstune.rst to carry the new --device
option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfstune.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index 0510ad1f4c26..89f4494bbaf0 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -46,6 +46,9 @@ OPTIONS
         Allow dangerous changes, e.g. clear the seeding flag or change fsid.
         Make sure that you are aware of the dangers.
 
+--device
+        List of block devices or regular files that are part of the filesystem.
+
 -m
         (since kernel: 5.0)
 
-- 
2.31.1

