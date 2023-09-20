Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F27A8EB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 23:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjITVvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 17:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 17:51:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F1C9
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 14:51:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ798019106
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jvaXHjRnp84w/KuLF2KkO72sC4tiFLlFNKAXZqrIw2Y=;
 b=IWzRqVEFMRdMC43W6a8Dotu2ZktmI35ueztYmoPhogi7ydMZeH3zTxsL8TUv1cf7YoNN
 3cLnndsEh9CvGNUDJZBJslA8pG6Tq7TlghGa/1GDyKrpdOhRA6sO8NcTNAD+WxOab4hA
 zyD2LjPXImVacQ0pggZ7yoiJgRhWdDCYTanWxA+XQGPEbWhkrYXotHO5ta11uEUbXePG
 649JqyFF22AtqNBPKduUatEZ1KPOtmCZgKfO+EI5Rlwmq5x5WONY9EduW4ONm/+uACuI
 dfHUjwjIxQDxkMwPxm5O/TxCCHJGd/mLqJ/ft2qrH6Ym0vDUIc5PG+iWemuhQgjekOpW wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52se0d71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKA5VC002129
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7ep9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 21:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrBqXLtg00yE0+rLxQO2Uyqsfb7jligvSgjDihQBzVgN8rWKTeZOadfT6zL+Wgb9lW0WFCs6s2LC5r43/iJLzyVevonSQCbTZaj3tgzvme2k/zBNLWBNQqg6VKgRahzIFN6pFwLdHOEq086S7+W4yF26d30WQHEzyyOCPLvJHcY4KPpZVngJZ0JLCXBPHMX9W3q8d+6Oaeem7uxaKJSf4xPHqDxkncAk04cVn68RCXhaYvR88x/bWguYA6wC2bxWXj3CQDrslJLdXkLAf8Z4hOKbZVn4auOFFjeG4y+0JJcRWBaFBE6ry3u7763RMFZA852fs7+mb/VHSDqf/J4eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvaXHjRnp84w/KuLF2KkO72sC4tiFLlFNKAXZqrIw2Y=;
 b=BXcILLfdy+fU+KK9DJMMPzEOhUpRoAHg5KS8HvlBQPBY1hnEtmzibHeKs4cVnv0WEiv04T/W8c4GD/br4w8v4k3Fry2Z06JxyUqhNypDonIfWU7UL/mdShcrDyYwGJnJSX65MPbw24tioB2hifKyh4WXTithTUyIBahJT8mz7ARIJoBiVJbDM9hAaoTr6f85DnwWnHu6wWd2bZPIgrJQ+joSsIcSdddgU7BWvcLucxHYCeRnMU2B44sd1UGsLD8jKLoz1ST+807+YpSWUCy5XoU1oivcEdp4w3Qnx7a1cnQSh0sb2voV9lNIAE1hz1RYAfyo1B3fi/tEHcYV0XfGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvaXHjRnp84w/KuLF2KkO72sC4tiFLlFNKAXZqrIw2Y=;
 b=znc9QrpnWjmeeq0n26DmP9YxqpF9Kcqncofpk5JW66t2lAJ9nKxUFMe7cHkLOR5gk86DK5N77snbXrBOBKM9NLXckRgtHnQ35v4QxurH085w1Scu5qytpr9iWumX1CK7I3wWvc2Eg8upEz5eHqa7YmTTlOZgWzBZRThM3vOZxUw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7927.namprd10.prod.outlook.com (2603:10b6:0:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Wed, 20 Sep 2023 21:51:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 21:51:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/2 v2] btrfs: reject device with CHANGING_FSID_V2 flag
Date:   Thu, 21 Sep 2023 05:51:12 +0800
Message-Id: <cover.1695244296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e684c9a-5700-4643-b232-08dbba23bcd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugxurAacaumzHUOczecJ3aYNmSxAAZqgwalEq00b9QJWo8eoKlSM5v+obmI+t+xt+QcDz0PLNxfsIsOkRUGieHB9NWuU2igq/jo/FJictB8TJ+HkTP2T2m3GPqYupTa8MltzY4g5kFfZtcjG3Tk4pVTYBByteA+CZr4rJUMt2baDauPvCiSaG2tjKYkxqlbjqyjv5Lsc322pKWd0MPZDbOBbptwncK9P9VASzSbKJTBbrqZOqm81yZU6rWivxxKyzmv7YlKXLv4MOZJvnykOhDrh/PKjMH414n4ZboMzJYyIPPxwECDYbZPnyPmrM0OD4wdRuJfAhSr6j/2mqUWdjh1cnrmaCAUwsxAYWSUDPbsSZa2ampNy8CRO8rF6A1PYgfwApN2kjy9Tbts2WL+dJ2mqeCo5PT8ikZXKo/tgyNJHbLn9TXJBjPlmITnLCOMU1sPpeafAXI6u7l/frH/6xNK6KcC0mu8wQA14hAzAfLT5lrXACCvsA/o03ARcG3qV0ZeWMxJvoiyjJaLBN2OD30I/uNMhcyB7YM7B7c6LqVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(478600001)(6486002)(6666004)(6506007)(36756003)(38100700002)(966005)(2906002)(26005)(8676002)(44832011)(83380400001)(8936002)(5660300002)(2616005)(41300700001)(66556008)(4326008)(316002)(107886003)(66946007)(6916009)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y80qWwnbRzr6Fa8A0lWcZvn+pmDDh95Ma+RnHpJSdpnY60brNwU6IppZe9EH?=
 =?us-ascii?Q?0aCp6ivHkBvEzrNC85GcejBoXWVYDY4us9tZt56nJeQOYVreywj0Youki0cS?=
 =?us-ascii?Q?6bj/KvpcIfbOimW/YEbIqav7UR5j+tFsEDxaedn58wxAGdUg8k7HiQAgAKqh?=
 =?us-ascii?Q?ZQOmBgoZkmNlPSZ0/k7YElnRQIopzyrx2F9Q3L3gz/jhDpDu7ZZ+uWI+SwJs?=
 =?us-ascii?Q?PV9pCrN7sc3vJ+4GhHfwQSsvK/iQjswUh+qVcYN6bKuZYJXVbvcLIOZrJcYy?=
 =?us-ascii?Q?YtCjI0ED9q0NqlNdjOrcI0/CAOkDC3daTZ9ByBQWzLHOHJ5tayhQyv1KAvOC?=
 =?us-ascii?Q?dlw488Mrq5ID5Y8230+eStVqKt2B8AEy/S26TwDMy8mON0y7lskDYmjOKB/u?=
 =?us-ascii?Q?EpYL88k7aJ2HDTh495dCEU4JIS+fwfZwhQau1Y3Dr0SL1G8R+SN+hunJvzep?=
 =?us-ascii?Q?l+512dfyLo4STC/3LJPkN6pwu4OD+aPizZBt/DvQ8bjjtvB0nYlotaQF7WaQ?=
 =?us-ascii?Q?cDhAUAR3W6HK8O7VE2l7AOY8DQaByUV6Jr8ND9ItF6+rz7z2D+3Ka0Kocpch?=
 =?us-ascii?Q?HA6urZykHaCj2ZwOnFCeYtiAcW2H94S2N+zy3Q9e/WCXN7qihy6zqbp8SXwi?=
 =?us-ascii?Q?glMZCYQLU1VTQMHw/mexysKSCGegxdOSuKZsj68TzU+TB0YynUhSAKc40Bgg?=
 =?us-ascii?Q?cmeda0FBZJNRt50Jnzr5pzRnbeN/SeFz8NzHily8ow+Ss/xdd10HI6XmskMH?=
 =?us-ascii?Q?2OIMAAm/geqWIXj5L3Zje2cE1j4NMzobrmlClZOjWPnnluQehO4KHL6iT4xK?=
 =?us-ascii?Q?MXNkoCQKA0TT/Hkk5GCPCP8vcJbltN0QJZvuqRe3aIb8gJ56ahirKfK6Cof8?=
 =?us-ascii?Q?LwkouIQV2xPay2yCQuNIeYyxsaHTUQIS4PoYauf2Rqcu6u3WDPEXgf6FIK2J?=
 =?us-ascii?Q?u/8slTmQpl3spDK25CY0x21wZZRwmh2Fv4BnWrUds3unN6CIkeEP3nXyrtvu?=
 =?us-ascii?Q?HYV+gHJI4CO2MNvZQUTPJN+zUixJEKmMoWnNA3avcCPYjCGHJsYT4C2vIiZq?=
 =?us-ascii?Q?2v943DXVHaHBThjjDkQN9IuFAoWA2TjWr0Z+1ypRExAFeS0psbN7Ar0VYNZB?=
 =?us-ascii?Q?YR3Sw+cqvd+I/unwp6gAVVxbD7qhx3ktE7q56XVk22MC4iWWOK11dv+4xhOm?=
 =?us-ascii?Q?GCJ+aDM9tHHRUEpwpyr4ILAjJROk2+lREkJLkc7zfPIFH1aOZgqfrXavCJDm?=
 =?us-ascii?Q?FFCcvhZ+Khq+dJu2TIumXT+qHIijydyUIp8rZa6QOnzqef6FF5XmsDRz/vyX?=
 =?us-ascii?Q?acluOSsXQ264GLGOLpesFtM1ZKzHIlpm9qxTgHmkBumAaZFWgJWYj6Z6BdNs?=
 =?us-ascii?Q?Wu6L0PuN39zplNen/VVi/b3/ZtO+vb0/IIXGcpmZcB4xW5I5peOA7QbCXMom?=
 =?us-ascii?Q?YJmGa6hHoE3xi5yBFROATXpLjp35f0B7s8y2gLyYK8nGOWj+jkuTMFHls6bo?=
 =?us-ascii?Q?LcTCyy+dieAi5FeEzNRYmhMHTVNyGay3jL4kKtSK/66ge65psaKrtbAsQFB1?=
 =?us-ascii?Q?4B0iwBSpUZnPM1qwq6fnRcpnaZwaZAZgsQyzgv6X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I3dybGugWxFKBMf3M45fKKjCV6bX92DxML2wkP1idd8FdxLtj8KfKHR9WRSB/1Fqjcz6i0YdpLdO8CWj1+Os9mehKk/w5C5SpV2klaMSgMvH32wqCiR/pOWDmjx2aW2eXFeb5iV/aelTmkODHKR4BiiI30OAkEuzGlK57IgWqlbbLEySYkCz89+IzusAd2IFc8PWUyZF8JMZ1JHaO7CbtRvVZIbQ++XM0W2GArHKa8+pDb8AFJQUrsEpVL9ZafFFN62RhizpNDNQBKo+v86PyzZA1FY33dQXPl6Z1TFM6249iKIpGu7wSv8zLwy8bMvSziNDbUblajkIk79QpZRRgJXVESUj0Rurq4OtB5iVyGRaxUS2ksWMRPbyuXUIchc9TtKDQj12RTM+G4jGR1JjNXJzABNvEQBaaT5Dq3V8TShtUAy9+bimajdQXhTo4dm6oGXF75fz0cC7dhSe9jHrt1PKJ3eJok6nJ9XYvBQAmmruDV0foEpvPivZfP7eL6WtA3499BjVfOM4XCwtbaSQdxa/RFI802QhrEQFyWzrnFiEMulvVRdkOXincUXE2GvQLCIJtlvIrOz7Zbx1mOj0a0IPr3NAaKLu9La1p2wPDJZN4JsyW07WaNSAvGYj40j95rRAArLPYPmM1JOIE/fMR5rRa5C89CMjiffs4JUGFltXd6eb0nPD9ZLSBgKi/Xmws+9YyVdPx7jsqr0tN5UBrb7C2eA9el96waEhtsAjYYV0GhAWMDqO0l8wOyAcOlGscpWPiecTnQxdVsgf8p3+Wg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e684c9a-5700-4643-b232-08dbba23bcd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 21:51:25.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG9QAUmta08NCn7yObPR+gZTLOqCLEbRtHEGKGM72ScBXRH4/JK5tKJLXImRglIXkX4WOHt5inO5OSATZ7kN0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200183
X-Proofpoint-GUID: jNJ8jIfgHid4TeigiFpdoZHm-duj37uV
X-Proofpoint-ORIG-GUID: jNJ8jIfgHid4TeigiFpdoZHm-duj37uV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2: Splits the patch into two parts: one for the new code to reject
devices with CHANGING_FSID_V2 and the second to remove the unused code.

The btrfs-progs code to reunite devices with the CHANGING_FSID_V2 flag,
which is ported from the kernel, can be found in the following btrfs-progs
patchset:

 [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
    btrfs-progs: tune use the latest bdev in fs_devices for super_copy
    btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
    btrfs-progs: recover from the failed btrfstune -m|M
    btrfs-progs: test btrfstune -m|M ability to fix previous failures

Furthermore, when the kernel stops supporting the CHANGING_FSID_V2 flag,
we will need to update the btrfs-progs test case accordingly:

    btrfs-progs: misc-tests/034-metadata-uuid remove kernel support

v1:
https://lore.kernel.org/linux-btrfs/02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com


Anand Jain (2):
  btrfs: reject device with CHANGING_FSID_V2
  btrfs: remove unused code related to the CHANGING_FSID_V2 flag

 fs/btrfs/disk-io.c |  10 ---
 fs/btrfs/volumes.c | 166 ++++-----------------------------------------
 fs/btrfs/volumes.h |   1 -
 3 files changed, 13 insertions(+), 164 deletions(-)

-- 
2.38.1

