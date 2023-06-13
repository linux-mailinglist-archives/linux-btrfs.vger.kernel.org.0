Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B872E00E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbjFMKry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbjFMKrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:47:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594D10D4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:47:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65GBg002074
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=5IsT+RYwy9H+LIAOhgYdGGgyuyfolwuvxhsoRPxKRUk=;
 b=tlyiTuqYFq0qbms53iXcOlioBTyZmL3NCIFeMcC3UKT0za0mqqUjuUzuuxkx0H0Zv8hX
 ZTPd3SzF0JeWJ9AlBlBDcK1mgiKpR7Z3SyYZ34ZFrwNXJZf6KNrQQPRHvQyT8Al8yCYW
 2ZjzfZgKwlHjmgLbyQTCzSZF0PWR0FGT19PlXbBVnY1n0qkb/YxDRXEd0uTL5pN0j5QX
 Xh00n3pUO5E+WpIc31EwMyxd4Ic7LHgsN324IvNlnjZuMjvAw+y4SzbLNI8Pnw2dMJQ7
 wly4qs3Tnvd1DyNJNJ3sDot/+gvrDu/fVxxVfpU5XuaW6YWx6m8zxOPrJ/0Ncy9LXibx eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstvus7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAhekI008272
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fma8jhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdu9Rf5xUi2sbMcoFNBGJFvCi8lpTotox/luT0991SyHDvTuteCpBmiX4NhvfYLhhvAviyRXpXvr4PJW4zliGFzAehTL93JH9goHC/oTwjHrI4UdoxMASP9Lulx5dz3s5E7K4oSKUy+o8/DO+Mcu0zSIODh1gXRCxHZt4AKpuCXVcgfaMrjkwfKpEDdHnHIDA4ExW92xZLLCNLydijXhvLuetIIkufRW/6BNQOkeTOdC5/nRROvASqZOFDqjw+yzY7NTtQCAL1cuH6k8+COh/NvFJq65NK4YCF1wW3holKJvdCNFGm07nCpFsdfu9LBmhcxnaQ+EBc6g/9NAmbEHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IsT+RYwy9H+LIAOhgYdGGgyuyfolwuvxhsoRPxKRUk=;
 b=HPYdC/UpPOa+ssuuU5eCOSrDoel0Skh2+x/11mVE7VmgNrFqzJvje/bzm7BaBjMxAkKRZis0a6puHJRPaxotyDIw7JAF2qcVO5OAwUc9SWEZjOzaQ44miEd84Fn314bYonNJMyOzuF2AgOoVz2EnAU62w8Ik2uYKq0NaIdkaLDMUzoxLh1Jjnen8lT2AKZr83GouVkBWcy5C99ZgJIduONxF5dhkIIY/XtSpfIKaszYnQfAVu4nM0l9hai4TDiiAnRwAP1Y24cS91PEjh/UySFM8VwDgWy2OGVFU397vUnfMDGkgIo/33oeAz47GyBwNQbJRFMP+km0Rip4eiVvoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IsT+RYwy9H+LIAOhgYdGGgyuyfolwuvxhsoRPxKRUk=;
 b=vAjYIlVfuAahJdtRAVbPkiSURHy4jDZ3Sp35R2YPLPEI/JwUHDlGZMoApY5GiT9WjXRfmPzE8XEV8K4BsmvWIkere+c0IqzyTsR0wGJF6Iz5BzXZTQmyN55SFQW+w3z9MY3ba2Ppu8limARd9GhvTvfItOr/DqFsWr/YWSKJMH0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 10:47:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:47:45 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: docs: update btrfstune --device option
Date:   Tue, 13 Jun 2023 18:47:13 +0800
Message-Id: <bb2229c4849db7ce042cae8ad53790faa0024f07.1686484243.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484243.git.anand.jain@oracle.com>
References: <cover.1686484243.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 42088a2a-a9b3-4350-9f5f-08db6bfb9f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KramQAse/3HTAY2KmrWRbS2Em7/W7uBe/JdttDsQudJnvX+QA2Evvn4g1hyJlAOseFid8i3pn3gNRZgSNH9Iv9m5AzmQZ2+KoppSaX4Yxmh1rzp2O1Yr5xBn4jOcQQDOiT01HzCg7LikOaLJA7BV0oDnsBrDzPC5fqGq+02J2+9/jTZhuw/8XoJrYNFjtKfU1po7cO3zE0sQNvUHw5QyspKEvvSSWCEV4MEB2EBq7rhdiybGqoCDE4bGeV0V+WIFvi/jTiJTUzDrLS4yeuo4Bwk4I0EgnpZ1qy/TE5Wsx3OPvFoUJVPkYs7sYefX8Arl+BYDo4ZB+dDX6ssMbcmrUjhq9GXnIOY/W/HVWVmxYDvv34ioY7fx3r0dYvgDU0rD6+SCXtmOPMflWFWA8oFSJochVqrz7s2f87Q1v1dcMtErxSoIh847XefdpRqJwVkTnFEIKfQzudQkRRAAw2BMKT07cMoSgfOVrepyKwIJOODsVYx7DHvAwaoXEbBn3qBZVXgGhM33wOlxdoba8uPOhZ3KTQFgGYdMdM7BYrgPbOfm4A2ru4gYWWjymcm4hbNe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(86362001)(4744005)(2906002)(15650500001)(2616005)(83380400001)(26005)(186003)(6506007)(6512007)(478600001)(38100700002)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(66946007)(66476007)(66556008)(36756003)(316002)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPbIF7iS/K2T8El2WOGTzO4ipiEevK6lwCdhuw2isWp7Lj+Uv5pYxB0g9Fmd?=
 =?us-ascii?Q?5ycwU+aACeJUbMSkpJJlGjIfdOSFufRyG2jhEQShCML837/8duk8HAmdGL3J?=
 =?us-ascii?Q?QMLjaI0jHYdc2vyXQb3ZNWdD7uesrkxsrvdhunddmyW8z4MiJYvpRl6DyrbM?=
 =?us-ascii?Q?FSGjPU3vkRgA+p3/iOG1rNmyUyqjyYKztYrw4HV8Ys7T5/8NqNdzaghILnY2?=
 =?us-ascii?Q?UtxZGCk9H/jOZot9JNGZ4EYhP2jUP2FXWOZkROZJkjExv6K0RK1dzAxKYdrm?=
 =?us-ascii?Q?HScchWgdxOkml6J3llKR5X9ccOEAw1lY5yn2vy4/7zOkx/5MkEs+lPlKrsMM?=
 =?us-ascii?Q?OXRrdlYcdX5m5NejyqxZh9Pun+mnfVYMvKcPXyIiCIzQAfNRrbNefndptCe/?=
 =?us-ascii?Q?SNLf7mRsBHgiR1v3IPXA3/WTOxv3kZWuZ9Qc0zUQlEB5uINrnKzD1ZOA73Nz?=
 =?us-ascii?Q?XhsDRFGJhy0SLDCbIDaXQ+uQQ4BmlAVsXT7MQzT/IGc5N01+UhFRHMKygmqz?=
 =?us-ascii?Q?P0PpgGnye4CJ44LMvDtmrasow6Scf3QLn849MZHdOhCigtt+M3lt5R+icVpy?=
 =?us-ascii?Q?lkZTXC4iRKufKzMRTUX1oRqXxEsJOE16h5jLISG9iYiamhdIBxeXc9gh5P0A?=
 =?us-ascii?Q?9BcE5881gCIUMELBjLAJT9BKqxJAJtE1mvpHVtdWm0Uu5Ldj0mSAUxaXse0e?=
 =?us-ascii?Q?58sbFQPflBauPP391LrAtIokY85PdZ6/gCeeSBDYbX+X0lEk3MN69f1tAx4Y?=
 =?us-ascii?Q?FhAhA0sXIBTly3lsaU1tx8mg9Kt1o96xMYWekj/txPdZ6Z0HIy8xA98tcwQ2?=
 =?us-ascii?Q?MMlJHWnOfbZV1YwbGt4TeBeFs2ZI8VxWLyXl3H9uGhp1l/PFXrN/RX0b7QZW?=
 =?us-ascii?Q?E9B7YcHmAG+fmAcbIGATxNEKRqKv2rFYSBKC5uHWoGVzIE8El87lmxJDKqBD?=
 =?us-ascii?Q?bt5wGjF7Aiwlh0EvJxx5UY529SqA8a1kUSMCi/ulc2pFw4OBDdV21a0HbqwN?=
 =?us-ascii?Q?GpsNuegBhkT4gpvfdbm2+CkjFWYX+WiX2MLpXzUupYLFYge1kNdAOj1lxHr/?=
 =?us-ascii?Q?tsJ5t0lTXs1CqzNGO+UgTpoE55MosqKBGxkMgAZmFVX04ST0IWk34/qwexlY?=
 =?us-ascii?Q?oAA8JlFp4Z/jTlzx10/s1v/1JzGT7eE72CxEU++3KPzFxgmeTw9Z5CnQxCqi?=
 =?us-ascii?Q?EPshT0ppTmuuKDrcHu4JqqOaqHygBX9Ana1SZ6A0nD5gZkUF8rxUEHrp9vee?=
 =?us-ascii?Q?uU2h0C1CBVlnv/U72GXb/hytSyTqsSqsJ/fDBqBtV+HNE+1tIDixkZF9BnH7?=
 =?us-ascii?Q?U7tioJu3B/7G8LRTUwE3ujgw9wIIsNK7EgHGvyd9RloMMPyKAXY6xioD9pQ1?=
 =?us-ascii?Q?Zfx9Y9OZazEJb1bTJCmwcns6tLGX9kJ/O21yDd6v1OMETyIsemy6hBTYIk1+?=
 =?us-ascii?Q?ctz9LWQtIR7SNpH8TFZE7dSmJEqmFV817SieuWaSScG9wuGSaPpx598gmbMp?=
 =?us-ascii?Q?u6ySjrUXGsSUh9tAcb1xyYXCmnTXLZtzm5G30AwD4DlFJvlw5Uf9aT+vPedb?=
 =?us-ascii?Q?M2OlNGW8d6Vgbmmuw31II3B7ZCPqYb128qP7rhOSAUxf4pgpcwmq40AQ46pG?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qTusIDAggB6jWwZYV1tN3siSXflPnT0UXyVUfLbgSh24ngMGITS7j/9RCsCHmQmHmgzoeRjUqbmTf2etXuJXQcoLvDIJcjGN2cnhvjoNBh0JB+nP/sGlzvAE6lMU9If2dRer+FgxBBIZv1Tjvmrz2xgowYeEH8nPW9sk1WdbXbIr4wHRWtt2Q0np58sC7/r939XYGB25Eum4Q+sIFl6U776aXgsbIvsbgvmijBz5vq7W82+Ndr5D3FSaEi+eE0S9pE9ABb4OvFANqoQQiYUXgeaUxeMwsKj/j1XXvzClh1HkIq4L5YC13RnEQh4sVjIEf7bGhBUI+Dn2LoUHOUV73weDoKG3NAK9Ct8JwGhwCYoVYbmq7iSXMd2V+haIjs1nZ9QHw0b3qb2jpMjtoNV4yddyIf9Qkr4y0ijBSVlg6t64MJDq4Vgnj0iuwgrGo8oXboodLU/knEAQ7G7eZLgXK5ugUfyDIamysJ99hmagyOtqIX3QCeZJvSc3dTtNV7mbBpVCFj/trtEPmS0m3ffxx/a4kTNaD1uX2Stw+Uqp/9V5EX+oYHZDVf5KSNVjaUgIEDmztPSQpPyyH+CYKMuZcDwukQ9biveVPTSRKBEAJEZ71Azvd7gPiWv8pqcRBgIYFmPYby03pG67wpz87HT7+gU+yJXCy6jPDh8FegVsk713kUHKh2QjmS4tiBUnXYESc+HcwVvlDE13inxPdefOHQUaSSbjyAEPvYYCbNnJo7oj6hhLgSYqmXl/hE5gbKvt2c88N1Tj7/VFq8zQzLeDIQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42088a2a-a9b3-4350-9f5f-08db6bfb9f1f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:47:45.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy5PcEOwf3dgQuqCj3X5iY0vhAuk0zaNKDjszuQSnJffzVL4idi1LSu8/3kuqNs24P2HzTXg6ppVm26TTl1N7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130095
X-Proofpoint-GUID: qmdaCHg6ECCHmNPxTnz7er6W4U5uO2Yk
X-Proofpoint-ORIG-GUID: qmdaCHg6ECCHmNPxTnz7er6W4U5uO2Yk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrsftune.rst to carry the new --device
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
2.38.1

