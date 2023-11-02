Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35A7DF137
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347427AbjKBLb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjKBLb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:31:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297C136;
        Thu,  2 Nov 2023 04:31:23 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2839wZ015554;
        Thu, 2 Nov 2023 11:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=apolKmTWhcw4V3fQaCPp+GcEI3Qv8pmM8/GBCQllfwA=;
 b=sbXOhDvAHBfDeVCOs7JcqxXqTGzxtbHanLnWigweTMI1ykRPWqQe3Zv+r/cXhOMnmIv7
 9fFZPf4aw4jVVONmV5+MOEDf3rkz8R/wLeYWZRCva62KcAP6e1ouNyu9G/9kcFhbRaa0
 uwQFM5V1G9Mp1IyLCsZuRN/vifZ4oNxxCQwEL11ZHDcTLqZxwX7o1GZHbaF8fBe+CPvF
 dn+EYSzfXFMqsmmgVL5Vrd14+aEFz+MUOBJ9nk0KpifA9tLTKBLqESXpqR4Fs/2rQngo
 V+lz7+o2hnSYqjdWgJH4W0DjmDLZs1WobQUBmoFKTyX9Wpw7dhEUsTGvPa0WhBSQUVWB vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c1g04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2AZ7nv020096;
        Thu, 2 Nov 2023 11:31:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr8f67k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILEbLAzywi/xDNAmznBsNc4ARc8GKxB1PehF7wIDSPhZR6yY7fYCk59KEkcvBWO6bfgC71r2cSCTmt1swjRXQcUTSFuuQBvvpR1hLlj6E3YL54mpgDFYZD03OKIHIb/6PKvcY/oPxbw/7sYJpg10s2ovTmeKAOzYIYJojS/yBlvyD7xi8MuFXbgICcK1xSZYShmQaIS2CxPfU+iU7qQjH3EZRnTrkyGKmSyObG9AeEXJRMRfZesv5uYU+WYRFk8GjHcOaJoo4nDC5k+/oPRKDnBDDrZotJRTT8iqx7s/2Flv+PlNTZAg43B7qbSh7fNLNuT420t5mdK1c8PQ6apYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apolKmTWhcw4V3fQaCPp+GcEI3Qv8pmM8/GBCQllfwA=;
 b=Dz6B5Nrdj9NosDERqcAC8AFLMLsP8m5s/31ohZYa3vND5aus3KdMXaj21B8TPHc2eqUnDR+GZFw/1DUZ/bLX282hjQ+P9LQtItU4ZdaIKhozyyDvpg1U+61NBUN5eFuJr/U5sU34fuFDfAs7zP9ik0Q4E5IzWqckgIIRPnFPFYnfUz4kB6RyAuUyAp3oepS+ihcVGe+PnSrfhsQfcWSRnhI5P/U1jXgkNt733Cznadd0DjfR8f1ijZ7X3Mbm7kX6wxkydVF0PdDiKesDDlPDL2kTVVgtznvd1onDMkfSVBPmglWclK2TJO/i9xysPh2f7ZGTJkFde+eql9KVZwI/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apolKmTWhcw4V3fQaCPp+GcEI3Qv8pmM8/GBCQllfwA=;
 b=lKLprw/BNH0gBGbT5m2q6TALEXNCJz04umcc0DbLt1TZjgLnzcL+dpiI2gAfj1xQgOAlQYeQpK7KQEzH0z5IcuqLe7bX0VUJMi5C/ooUfyVNtA+4TbTWUddp9zgXPcJWLwmMlC5lXzsCGmhJYPcq5p0tP8LNwLUowYlnVkZEPzw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:31:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 11:31:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v4 5/5] btrfs/219: add to the auto group
Date:   Thu,  2 Nov 2023 19:28:22 +0800
Message-ID: <b1363af84d3204be7b0cb5ad551292202b6c5a2b.1698712764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698712764.git.anand.jain@oracle.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: ac777b12-b002-47e9-4756-08dbdb973857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShY9MaG3W+Zn6BwpDtkM/99NQTXPFNatWPUxKIzFphqLT1jLNOCWcHBFZGECfv5RN62Ne3z4vMgzqGaGgxlfjqlX8+Nr6T7gRLXMXR+GjCjIlMh9o3wrMMimR8PQkrDxLZZgRr24Sh61gLTKDFG39C9U7OTurbHT53CxE+BRKBw5DYY/OVBbheBfGjjP+a31OsjNPFrm7oO8vJhRneOifbd2+t+JwzI5/X8KU81NaeKFRV1aPxbWfrBZPnpBnac3Ll3YSVulqZIflXKaRqk+EML+KFzgJTQES7Uee54/3sTM7rKjYvArSzzFeU38ksGieJapx6P9fP3Nq3NIoZCx/R1O8oFJFrTwezzeM3gv6nLmKfDB8ISr8u6BZaNmQip91OxezcxFtBuTGXpfgn2A+rhEbbCD9muInonl8U5G3RVa6fJ1SQTQbeLBah53QOwybtEY0P79wTJBa01Gj2U78XUNxlL4K/hYc0t9v8tf1e/eStV8Xp22fpqFLKvsGFQwZcAVfmTSwGGpHaH3G1jwuIzSbO3ljmFzDF8fwx/MbYznjF845w5oBPWuL3Dmcr8H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(36756003)(86362001)(4744005)(2616005)(478600001)(2906002)(316002)(41300700001)(44832011)(8676002)(4326008)(6666004)(6512007)(8936002)(6506007)(83380400001)(26005)(6486002)(5660300002)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E1fLrJOmdjfRs0Z1LVgjMqu811hl2xteIPnsSoBWdnNyjMvd9ujWSLrFBagx?=
 =?us-ascii?Q?2/Pw0wMmZlSVRW7mTKlbpRO0FU7fhMRrjcBx+vz0MxpnJ9ezzyzEmWsVPRKg?=
 =?us-ascii?Q?Yo/a/VTy90W5bJwerY/47h7+n+zxvvdTQ1NaffmiSCzshtDE7mvQt9+Kv6yB?=
 =?us-ascii?Q?zFAgEVNww6p5AqH6dxcZz8VQT3clUDPbQp/NiGm2x+V7xA8IApEJTVcApiFg?=
 =?us-ascii?Q?3Feq//f+RQryPTv4mzba44eDUhpuyRNfKONIaHgtDEraGzcswp0euEJRqnWP?=
 =?us-ascii?Q?/6AaHc15SlnRb6YtIXcXzPG0HkbFhQ3Z/Je/u2ljVI9yezU3zZAcw4cHZKkg?=
 =?us-ascii?Q?KHatzt7Or5xrW4zttc8rFmSvSqk3XtJxcrnz/F0D4oo/RKfwaP9H++tClhNx?=
 =?us-ascii?Q?QJtXu6TBXKkxyU6Zi+ViyCDuGVdB24mMUYifA9uXx+imCKwYuRF8Um2BH4e1?=
 =?us-ascii?Q?c6zf+5LZsSccF6he2+pdaJQNnGeCBzWtxLAe7TL355d5BdohNi5+N8KNni32?=
 =?us-ascii?Q?mb/+UjNYzg56PwxvzRwN7bWkcaVOrrRr6tgvTnUVAAtGwemO4+E5E899FJO0?=
 =?us-ascii?Q?idgw/b8q8NKQ9Frh+iNGAldzc/1GmVRR8PAyVtF9tw6vLGaIZEi/Ug9p/A98?=
 =?us-ascii?Q?Y7PJ+md7kuLb/1zHCINJBZpcb7KeM1Mu1lOJBgItClY9oQKH/vMm0hTveaKS?=
 =?us-ascii?Q?yvzl5wint2wivCRkqLXqVTuXAD3YOngJ3e82QI9D/yu9Uke3TcSjPYr+Yn6/?=
 =?us-ascii?Q?x2viTyt98KQDB29SReyf7jrw6HN717rwXn60vt88P2hh5wj2i3k906pGj1xP?=
 =?us-ascii?Q?jkHKt2A5ApoP5Mbz9lGUj8GGPRnDG8TVFUilk0XDTK5YtZMFfUV5G8n4p4Iy?=
 =?us-ascii?Q?+6SRvocSr7H6o4/tPEw3XEUhosZLzgraImo8YEs1aeRaGlOybCGktPlmY4WN?=
 =?us-ascii?Q?GbmRTr5OJnHCYwBQ4fgAsjyJ1h68/KxfRc0G91wHn95OmAaxFsU9UqMajPA8?=
 =?us-ascii?Q?+46X1sb0UWq+mo05FrOuqWcxlYnBCIFutRecly92FvGuBbZWkuFAwvqDWKbP?=
 =?us-ascii?Q?FONnovl3QN8pQOhqWONNr29Tmt6EspwIrNXuOp6ao6Bu/CScbJ7f+njzVWGf?=
 =?us-ascii?Q?pzAz/8847QvocTsX+my01fI33ENhFopyysCMTopo1/ZjNClqlfgM6OFXpirE?=
 =?us-ascii?Q?hyUx3VHciVcKWj3kJjPnIK3vz8zGD7/xMif1lalz6TdtfQU3OS/dbS0jrh19?=
 =?us-ascii?Q?+gNBcvwryJOOYQeYqi2S6Z0ptv5OkrbR7dEvUAdrmdWScxTyOTADYBIxtuj6?=
 =?us-ascii?Q?EVNh0kcWUnpfi5JJkKjAwICxApaUGjJcXqajK2G9mbt28+GaYt6OjpeggQS4?=
 =?us-ascii?Q?2j5BIh1dm0iWbrCKfn0in2l0imsJzdeBnKI3Kcgm6ZvTUdKofLmeFSY2GzCZ?=
 =?us-ascii?Q?1sawogz8NkLYpl01ZEZ2MkqKz3EmRVDvAqgNoG/zmkDZchdaBpT64CVHAFea?=
 =?us-ascii?Q?RGXnfwr2NiSpJ4PrdvMzMp7Zc8XlrCAHfvbpB0OY/ECLVysV+ULtwvaY27+w?=
 =?us-ascii?Q?/vMcdUkBgzfHtr474gB9GApBJ1Ek3qWkQ9RjAmqc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YCsu0VlfM3tPG3VJoLVaaeCV96Pa5X3xNR18cl9kysAMG8jGB2CBfNnQRBcDKpESXd7aBe/r75KidIE8JwzxgR9saZhOk8QfQafZ0vRpgemml0lZn5lBe1Eo+W1i75lQR8lc47qT3rBDTiz02pUAekOO9XHxLBQ8Rree25MVhLUPq4yqHduePKxB0sl4VT6hqddc/3I9Ct+w7kC9TKrHoFYPAdgkatfnKPgH2upjBl6s9eY869ICBMJ8lcqspig0jpqjtkdAf+stldLf2rZjH12ZHN27tQpmNyWfwr06pzkCxeotPmYTGix1nQieo1G0olGqmMemqx8qauZF0AJQmAu28ie8S6fzwWiXjj/UwTky5ZMwo9OYdOXeL/io+nO9CaCXFFs8nek3f3nLCtxD42PZDcYqgcy6SFjm4VvYVDFIc2cebgkIFF+V6BmYqN52UkneI4r4e6yQDQUTljOjB4wuWTgAJM+fb+NuuB2YvNXXE3BlTnnZE6f/QBLaZCNke+/fgDA12ElnQTgZ+cqsg7koXXCAp7V5G0+KGNYp+RgBSkrhEhpnxexU5xA0+0pP0m0sag+edE2TvCS6iBVDmar979xifB4httm2a20Ot/06kEnm0Mxk7EicuzLb2izYwqpHbIQD91yHarcAhtyWx8eLcGCEkmeaBdke17CYTaHOnapBVOQWHK3Nkhd61CRS9Q4XgtnMtXQnzew/BjLVZMBMVKk7Ivuk2WRGC1tbnl2knE8gcYUGPDg93QYo1V1diN8FY5vaxGD2ht2oKNfGRzxN+nTQE4neC1CiZEB3mdGRNoGaERD89KoDWKvFvbE5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac777b12-b002-47e9-4756-08dbdb973857
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:31:13.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUM9oo5LwIBpoVy/b9BjPY9NDoEDIoaBrZjCV1Iljp/+EC3L0q7kcVSXOcLqxNXZjQs26hg97RARZCk07i4llQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020092
X-Proofpoint-GUID: Jc8Er3jrnp3Y5EByGyHvBefRnA_jiq8J
X-Proofpoint-ORIG-GUID: Jc8Er3jrnp3Y5EByGyHvBefRnA_jiq8J
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add this test case back to the auto group which reverts the
commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") since
the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
btrfs_close_devices for a single device filesystem") has already been
integrated.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3: A split from the patch 5/6.

 tests/btrfs/219 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 0bbfd6949cc8..9da835dcab10 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -12,7 +12,7 @@
 #
 
 . ./common/preamble
-_begin_fstest quick volume
+_begin_fstest auto quick volume
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.31.1

