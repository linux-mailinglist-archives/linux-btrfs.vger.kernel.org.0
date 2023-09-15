Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443497A14B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 06:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjIOENp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 00:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOENo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 00:13:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F3C2703
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 21:13:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxelU017817;
        Fri, 15 Sep 2023 04:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ULJUkIZLgQ4Jzq8sDdKiRaWBsQz7/vEKmuMlMvnKrUQ=;
 b=Nvxz6b3XPZ1c5LUeMdDWyQ5Ge/PwdPLfaD7zgTWeGxWAhP090p2wZyu+GEs24XqFBwEG
 nrsvNLHAbFrVcMEA7Ebf8wg1iYPtcljalHiqr84JaYfVndMczzJzcr3LisecpmJDh0LR
 BaG52cd1D3HHNnErh4bfxKRy8QUpQ06fRmb54ZLxB/9/T8llxzwIV1LJMbWBeKq+3MrD
 o9tIQwCHcHMbA9BMofTsfWclqBHqQQyDsAF//Yjmrdhd3uLiwTKwyEvXh/5ZkofZTso7
 j5ga6+vA+iE99H9Z+YoNMj/MmTI+R9637n/VkhoNDZ9VnExoo20PYUJKJzt5krcL+yMc oQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kewme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F48GXc003122;
        Fri, 15 Sep 2023 04:13:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59jpwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJZk4dfoh8q0KPiF6Fi1DfYZknvbFMWLZHKsTuF3iuOW9ZFlOWcVAfZvfS/kSq8gM2u2lqzJ96+u+fhsMqdnUexPOL9DdF6JNsr8t7Ei6UAMAi4dnht+jHIPRg39i/Ii/eWgk4otF0NPKJqYxQuiOt9FtQHmqjjKRzZO+F5jSmHwH4uFADcmJqzcFjljq4ivL39GsE6ApklVft5utwe7Trr4AthNcrwxB+xjdp7VyKsjFfVCTbocinY5IQQnhDAAJZY0/r+LtEuwcMg5JW1vpbEBChpELVQ9edE5dArbk2L9aDgryXw1287XqynzeuxV9SVHIQmP0I6PP50gTEgEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULJUkIZLgQ4Jzq8sDdKiRaWBsQz7/vEKmuMlMvnKrUQ=;
 b=YEQWgtIINDPelbHisr4HF/Ve+OoI3wffNwvYo+oR+D2QC5GvLrdk4w8IZrESqUw/OfmG+3eQs/7FdyZRZMuD4Olsan8CDJWa+zECbKLDv73MRSiinc9OaQm8GPAzO83wtkIA6IOaP2DxFykxbxnIXtKw9PdP/yt10U77e7KGhpbsxA5hK46a1MKOeAKy/LC8wHt+wiO4nhVsnMBNYMYBNIwENNC7yqSIBnCTqiGg3thKFRwSgbK1bpT4wutXP1r7Wuqx717ELAX3J03UG9oWF5wSFmzVIRE83Mw82Wx0xvc8+xhyEle3/VgtHOEOKXhFC0dmhyTAs6cA8uqsNkUT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULJUkIZLgQ4Jzq8sDdKiRaWBsQz7/vEKmuMlMvnKrUQ=;
 b=ofjwshad9gslnGVGuhfpInk7B0sR4UR4ozo7uckeojOoEFDhFEhph4YuCo2TKHGQXLwV/wXwwxdkujNt5hYgr5edP67NVAqftJX6N4fM2DPapl6YynBC1rfNbHKElnBEb1XjDStdsRhOWEvD4aCrb2nnQ4yRY0rGktrwPCGqzVA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 04:13:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 04:13:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
Date:   Fri, 15 Sep 2023 12:08:55 +0800
Message-Id: <cover.1694749532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 281144ea-c0a9-43c1-381e-08dbb5a21fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoV7xJzzRQu1XzrscykbZIxJyr6yukCxXMt/yBsJZ8JByOetizhJusAuSpUqqIVs1PpnQ/MblJwnOQL7/vJUllYT9qpBzT3FhsyLSZkkhVisrtYrrR1B64yLMHb9sKF1I5vL1IR9BhfS9KLl7Nb5SxCSPOF35lZa+oXGKyy2RlFWKajgtOsTj/luGucwGqZKEogmVo43lL3Cpk5+CELcqaGDbwuU0If7ygwoeRLe89dFnbfGD0NebtGYOAzbPP94g2VZd24BnXuVovRP5BLMAmRIDHUEISW9SgbaWkaZnB7pcKZF5aXbZyozUbLqIZYwmBCpnVP5rAxKSO4WASboYh1ywumk6gZURu/wF4O7x2FDLEK10VPsKmLs+SVMaJJphPtMDb62rTRDu14pEpN1MOzC6LSTLtV51sybfle61lSRYXmFMfnpvAZoVVASt9XM5fEYDFYcaahYPermmr+f2oF958ZNlaIAXquTmHojSX6Oc41Tn8Riw0tbcKa//JFTdjhN+ThgJld2cBCqQjdUplH/K8bjeaipnpdTnNSoOTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(36756003)(86362001)(5660300002)(6486002)(44832011)(83380400001)(8676002)(8936002)(41300700001)(6506007)(2616005)(6666004)(4326008)(26005)(6512007)(966005)(66476007)(66946007)(478600001)(2906002)(38100700002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YoQEdKFUYY10QdbaAb0ybr4PrwaVdLmjw0x+WoziGZp7A7R0vsL2AqVFlQ8E?=
 =?us-ascii?Q?bAxzkKKimUID6BgTGYRDoM5+M9YiCnTC7KepaFR+osmdVDpKIHWJCDyo0z5C?=
 =?us-ascii?Q?n+sC146r/3saqytEmZoPIUis/wDqW98tiuW+PQVV4s2Lis+OTaDhXM22t//l?=
 =?us-ascii?Q?XPLdD1Au0tKV3CeJdbXIAbOdChtpHGt/DwsushZiUQh5Sx4CtZ4NrIqcO/Vp?=
 =?us-ascii?Q?FXH+qYNDsWHcdnEa3I2Velxlz8mZ++tdUGnJP5A3ev6c+6LpEwdEXY3/cqfH?=
 =?us-ascii?Q?6ErGZo2bB85uOz9+/GJqqCwGpNCyuQbmZYVN+yx9f+xtsQ3aPWeUEG33Q4Gj?=
 =?us-ascii?Q?XCK5QgA/Tr8+IH+IEgPi1KVgsyJJ/GMHUE9YBamBXpy+2OC1sCEL2lKeFuT1?=
 =?us-ascii?Q?g7byiF2xoacY7RU1u0u4BrjF9dkt339j0cAUBL+LLNo2EpFlXWjs1S7KRpjz?=
 =?us-ascii?Q?vbYr6Oc0EH5s/+nRMJYoJOvIeNbGPTJXoCiGLFwWYz65IXNAkKhGukUcuFa0?=
 =?us-ascii?Q?sSDwbH/sPnUcH3Dh9N7vqsOUvAsILu/qA+qrxCQb8BhbniX4S9VacfiyfYv9?=
 =?us-ascii?Q?58sC+k2no1eZBTBZrMRK9W2AeL9bYx3RF9wRkGpaKix3Wd/Bixbb+R8x2vdm?=
 =?us-ascii?Q?FS3vgXj7AX0zW+Z3XRQunbbsHIbzc95+8gCOpvn0q1jJIf1yOjiZWKyOXdTl?=
 =?us-ascii?Q?RbCbvRghirc5uddr3yeAenH+FK41YC3kGgragAQfVOsF5pL9m+A28k+ke5dZ?=
 =?us-ascii?Q?jHi7HZmbyBG49sFljsoK58YqgOUcFKEgbKAa7a7xZeRT2Q/gzGM7jjsY81ef?=
 =?us-ascii?Q?WX39A11yZ5j4/hcUBjwz5mV1ZSZnGXXHLnXLaLR0QNgg74WKdq9aosHh1NWg?=
 =?us-ascii?Q?pRcEawDHgZngcZ+zL5f7rIDdQgq+cEGqHRe7BpTIZxlj76EVhaIhN5CWZYBj?=
 =?us-ascii?Q?DqUd8o8XoyP/EuXUZ5vndpVMvpfUXxXULNVH7Sa0io2qratJj/i3Zk13Pb8E?=
 =?us-ascii?Q?gDu82XiKC+v1rP1IV82qkSfolxq2L6kRhekZFiJyHq+2WTr5sbZ4VTzCvlJ8?=
 =?us-ascii?Q?tjRhUujP1td9qWqXPPP5i2gxl0qEZBu9TzwDS+TnJzbxzLSdLA6S6MG/ztzD?=
 =?us-ascii?Q?8P//cXeI1NxBACMOAFykTHBL/dF0ss8nFfWVChsVi2XQGIjz+Sdl9aDJQSK5?=
 =?us-ascii?Q?iaZG4en0JtAH3Qyf21QblJIBjpoPlErDmU+57fn6H8XBotUg+hudEQ/vDGJV?=
 =?us-ascii?Q?HYQDTVfu4FeF2FBmWGR0ix0mRmmiiwA3Dbi1/JAP4xfz6kPK2eBjxti9wjId?=
 =?us-ascii?Q?ObpzyV+59jY7ZxfzeY03hzittgjqkRFdWevDckMlkxfiH6mqVk3vPCQcNH9B?=
 =?us-ascii?Q?1ghl5xreb1BPy5kLc5sKBvIwdsbEIqouYGZGZDVHWJFfcQ7aEX2l4oJhEYBi?=
 =?us-ascii?Q?/mpxYiR9pm8D+3qWo/iKhrAr3/XUK/258QRAXeVlw3OMjfYSwEgKPKvG1awP?=
 =?us-ascii?Q?nIxWSWvl1Fgez2bflwn6RwY/ulzoG2RV7OwmtlwS7Iel+69M2wfuXKJM6K9M?=
 =?us-ascii?Q?TxFLoliTYGKitT28CbuzNbBb17f+DcrDQSibCtabTJJmlNcMZMao3RD514J3?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NDtM+1YmdSO1joD3LyPg4voFS5GsIssKG9dtmvb9rNv1mbQQE9fiW+1SE1sTVRZRvXldLd+tiHEWSKB7hcAB1w13ti4cCVHABFeCSE5sgUKGmr8UckWafYLQYNAv03VkW/DrsRXbLIQchTLXtAT/MtRfJTLwJx5ghgoemLIY3yFSuVs8d+uV0KHbFTL7/c/8Y5K/Csd03lvUvnCjvFK1JonuCyY6QNCpgA8WMImE32UGKD2NwIc1UhFCXNVIMx/JvjLAtmtkvu+olThvXYOOXrV7eqF/fUo/NfYdDeB8Uv8h5lCv2iIqB844JdPfzcMRDLgY36ZhppK46OcqOTWvaIOBVJA+YtTKLzAJ65Xfir6S4X5LEUNWC2ppU9H7xtdOl+wR3Grk1Z5s0s7qpWdnrrSful8Q52/1RmzTNxGLlhfg8WGn8BBHDbll/2W3IssEMjVIYNjUS3koU0GRofd7XiCnv7Uo7zFVvCJaJercbAe2X5eMIROuqXoTJjFZ0QfMy+OblWks8nXPvkzAtqsPrTWVdZ1A0qMCCWdSHAO8WsoomRamo6+qKDx+S7q5bSfCbn3TYWO6jUAcR8Ar8sxll9Rmng+bLNfqsKTWwUHq7xZutu7FvtZrDMn95oOaWAGwsVK4phkaE0ljlywGdfbxNJLGjNrKCNFdiFhCyZLZaFWoaGoi3lCPXiwHaNF7YfvfatMkYmZEicI42toC6k6vEjKK1/nWss/uAr2mo/55XGj/VmrxtQBGecouvX2gso/nuZzNeu+zsaOpfiP3QBcBXR9CTKfrrCeDaTcu0VBd9Yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281144ea-c0a9-43c1-381e-08dbb5a21fa5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:13:32.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2onBYwa1PowBiEG5e4bC4ccOXY33MWM1dNkukIfYB8VgWlrZHESt8aukFrJlkP8Bd3Z8oNzp5CDhDkiDYRDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_03,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150037
X-Proofpoint-GUID: xQyOK49Sd_jETow40lLBvDL4h2FSlmV0
X-Proofpoint-ORIG-GUID: xQyOK49Sd_jETow40lLBvDL4h2FSlmV0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4:
Remove the patch that has already been merged.
Update the commit log of 1/4 as per David's review comment (Thanks).
No code changes.

v3:
This current patchset contains the remaining unmerged patches and
addresses the reported bug:

 bug report: https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/16156138260

In v3 of this patchset, btrfs_fs_devices::inconsistent_super variable
added, which helps determine whether all the devices in the fs_devices
share the same fsid and metadata_uuid.

v2:
The earlier revision, v2, of this patchset consisted of 16 patches, out of
which 12 have already been merged into the devel branch.

 v2: https://patchwork.kernel.org/project/linux-btrfs/list/?series=776027

Anand Jain (4):
  btrfs-progs: tune use the latest bdev in fs_devices for super_copy
  btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
  btrfs-progs: recover from the failed btrfstune -m|M
  btrfs-progs: test btrfstune -m|M ability to fix previous failures

 kernel-shared/volumes.c                    | 193 +++++++++++++++++++--
 kernel-shared/volumes.h                    |   1 +
 tests/misc-tests/034-metadata-uuid/test.sh |  70 ++++++--
 tune/change-metadata-uuid.c                |  48 ++++-
 tune/change-uuid.c                         |   4 +-
 tune/main.c                                |   3 +
 tune/tune.h                                |   2 -
 7 files changed, 280 insertions(+), 41 deletions(-)

-- 
2.38.1

