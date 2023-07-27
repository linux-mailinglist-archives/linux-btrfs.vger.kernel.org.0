Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4124764F1A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjG0JPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjG0JPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 05:15:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E875264
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 02:06:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R0soIw010053
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 09:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=+7WT8kdnHIxUoamLRsiTzX5A2yd+W80PQrKxFI1a/oU=;
 b=kHZy1lQQLm8NvyqfqtEvjBqvMsGKheWiV7wVeepqGoqwlMBVUpQunZB05ZG4rxszSsil
 TD8491L+tkhW2qYvF82hX3HFK8NrovKwdME0TgUnpQLe1eyLB/2Qc7G3rs5UKU4aVvj2
 Q8xht0nIqnRtdy76CQ/I/O0048u8e8RR/o5U5L2OtKT0bhkCpY1YfApEmmP9Jn5SeP4e
 wBmJ4heMrUHc/aPt5ZP6yAx/DX2I6dxwrJ8tFMTY2lmsQrTSmtoGMBMqzouxLL4HqX1v
 vkatiSUBAhQ1wsSq6hz33M0ynEJeO+FKfZQJAu2IvqCAX96f+cUUPbtV/rQE+ld+Gf20 eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05he18hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 09:06:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36R7hhlS011886
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 09:06:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j7mkct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 09:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImAng27/eoOCrzKd3UGW3uEYBVEMeHeae0lqL6K39Qj5brSazzBUdWHWHyejjaEaPRbs+vyYTwK8MkSkLR2xHl/gGkY58WXk7jtzS5/QnD3sPpXIgoN4D9/1vT+nML+XpABqZRIN5Gc7w0CeHcWzGzVEy6XZemLqJ1PCZ408XR3QCIFfKkfCGTIbphA3YPJMVJ9KXwPCRFITqRQNYiKhZOSJ8R2wUDC0PADTDpc6yXBrlVzfN+IaagMQFFbOeKl6Sg1LIZIca4SBikIR+WbRv8NNl1WJLMOPilre4LiB9NOouv//EDBkLb9jbtUBXlnFODKudttvsXYYVmcDJ5z/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7WT8kdnHIxUoamLRsiTzX5A2yd+W80PQrKxFI1a/oU=;
 b=aZNvPGb/nbWdbtVQWG4s7iNq/s/xQU4DYOCPTFjZcXSYnrUiyfJ++nCSYgT0gkTJrMfEdnhk1OaeFpz0BrDNRigt22puvc5/I3BtQOYuENKFbaC+tKpz7XLDaOcd6FqO70ous2AjitiyCYzo2s7xGuuWuSnd8dQCsmVYiXncXaOdtuPvTBtk2WEeYzAIXOtNBil47HYKoXJO93jZvx2qiU6sHXsv1wSOfknz0AlsxozfxC7hmGJY8fwqIjQXhi8jtURe6PaNMWGjHe1FQkcliLsJ7y39fwj4riAjPQhuZTsEXB4T01/W8+yNmaIxtQYj+5/KXOIPpqqf+emDyc1pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7WT8kdnHIxUoamLRsiTzX5A2yd+W80PQrKxFI1a/oU=;
 b=jVZEWuYPiT12pt6rf5AnEWD00rbCegF4GeC6e1uRxYuDbk/WfV3bqzCmhiKnjTmsVGU6tMWsU5dAI//EnyQT6qYRMF6ZxbCLphFl0YfqjJVb4L2lmAwFVZJQIsWdZdWZz+5hgjsuCEyAuxQ32li0OGdG1uFm120L/PPQU9qaZXk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:06:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 09:06:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: register device after successfully changing the fsid
Date:   Thu, 27 Jul 2023 17:06:21 +0800
Message-Id: <4b7b4c651700247046a32fce3148e510877ccdc6.1690448585.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: d867970a-eccf-4d9f-a0ac-08db8e80c295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xrsd6Fe6jtbS/TeiqKDAGWLJx0Dcn/aTyeo3LbMoZF55i/bwLd6hN+RDEO8zXiQXjgM+e5vSrwkUbah4fXsj+pl/a7Poky6k6CSAqH0SQn0/cC3FFXsrlv5Nsrc3nH6CUoWHVaA4h59FYJb2kAwvCVWNBj027zb7VpfzOfdQ2PTYEcpY8pzd1EZodmZdsmvdIit+Fw4haZmOisOZ+VsvteQVUvN0ZWQo0cdeBHpkz7pYmYFXlRpM6uyddvNE58tV4OahvE7nkQmkxv7jbxQYgeJfBqsv+aTTTh7ZN+F6hLGjVPcQ0PygHFZ2Dt9W4pVgl44rOcd5CD3jdv4fe/IjUaC4SffkLOxM9j4Ph2Es55xgyeh0ibo1Hz3oLRz2tWM8Uk9JomPqfcXcKJPJ2ji4CGJ8JdUKd6vcyUM+eIE/UNdFvghAR1Uv7w2S4GXe7sW4M/emD6NivIWUwINN4XSgA+j3VCwgCLR4FnFVS3oISboGkyRDHQGln/ta2y7zLbta9f655hXkoaefqJtrr+sGaNgZUZxSOAButOs390lB9dML2ED5XqgHZP8eQIlxJYuC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(83380400001)(478600001)(5660300002)(8676002)(8936002)(44832011)(36756003)(2906002)(41300700001)(2616005)(6506007)(6916009)(66476007)(86362001)(66946007)(38100700002)(66556008)(316002)(6512007)(26005)(6666004)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvAk4j4tnwU3qxGcDhIhs2WACq8+OHiFKdMB5zTw99VW0/YtcyyXRdhCIMH0?=
 =?us-ascii?Q?IUDf4c5sxwbnr2cyDNlmN9fILI7gKP/cQFdzVg/udWUwG1m7Ny1tOAR0HVaT?=
 =?us-ascii?Q?n5sVMmto9yoG7CbJybnYdHP/pLfn313/ymjNOAWqtLOhTeSIyxH2qGrlJdHw?=
 =?us-ascii?Q?SZCtKc+AAXLpZ1DFIdqXirAy+pzJoElPjDPd2IrD+EUp5QzEoR4ymUG86+gI?=
 =?us-ascii?Q?n4Fzi7X1rjr7LRXXLdwZvmsHJTibIOTvXWNKyKwMd+9ISflOKJytl+axb6W3?=
 =?us-ascii?Q?rFdXyhFuUxouHccUaB9Sw4J0f+txHR1qgBI7jpkg4Xf/EdctK3YsbYVpW5Q/?=
 =?us-ascii?Q?e41cp60ov6bQLsOfi2Jh+8HOcNtJKpgCFZD57VfSvdJZT/+E1k8UKf+brnx5?=
 =?us-ascii?Q?nWPWBHLgEWe/342v7PbWxb48kwRprE6JAKVa+PVpTIp7hflTXEULQF41D1fZ?=
 =?us-ascii?Q?iVwYPrnSgmVaPB4c7LW/lFxC+GH0ztWLcul028Jj4YfR8HIBArOxJvrrTlt8?=
 =?us-ascii?Q?IsNzTR+6cU/L9Zx/UK2MdY3H3QTnLDSXq8+dbflIXDVpo6n3JKG5NC9K+0a1?=
 =?us-ascii?Q?Kk30DEcMWJvqV4JTwmCCadFiGPDW2JXg8YK7vnN1isQLQ5bJymnUGAWuxGey?=
 =?us-ascii?Q?JMATCFRDN8b7XxHv6YT7/g6+P5SvJ+Ab67c4PZvfnzvn7vyD4ko3eMehdd8y?=
 =?us-ascii?Q?z69ifH1zV7IqiG9D11uAC+C57YgWjKpXQO0UEVcM5hFAGxePcA1tArQbXFPk?=
 =?us-ascii?Q?XOrbCfPZOsTbWzAqPkURNQ4rRMwEyCbwo+ZPXNLW9n9adJ1ahwDDD7k+VBji?=
 =?us-ascii?Q?zOpbrM5UUAEWwZDazwIQESTE97SiDFAo/3EeZTHlnUT+nHJG3UBcClRNGUiR?=
 =?us-ascii?Q?isBt/l9zPejaiZh0LIzhPIx1mJyePOP4+HG0KvbGpINK/A9Z20E7QTq07Ad/?=
 =?us-ascii?Q?L9WOw+wSXLSKfc/EZQEkcP+ygUvNA/TTIV8Elic9zqWxPdEQ12c0bDbl7wru?=
 =?us-ascii?Q?AZriW+ZuXLsDh7xGOKmtZhjcFwXS2YThXE6gJ9DjoFG0IxnRDGjFrFVG10SR?=
 =?us-ascii?Q?xuTNHDINDWJkDC1KDiQOOFkVYAgL0RqH33/33vy96HXvoJz7IL62JiEpKy9/?=
 =?us-ascii?Q?9hs52JLO2pd9/zpL7Y/n55PapA3JR/IoIn51L/K2oN45qquTIbPt8I76ilo9?=
 =?us-ascii?Q?8b/RihH9IeIxU6tutZMxYPQOoJ1RcT1LKBonUgQo6rQElkd6/EReNumYqyqX?=
 =?us-ascii?Q?XkS2c0+QMuOgymq6WHSGvmt/HTDecNM8193mZbob+MuMPn6MSrVGDKqK6uVZ?=
 =?us-ascii?Q?tpwWJSMN/dPIuHa/dhcY1o8ui4R/G3ZkZ/kBsVOutdkFL7DSZEZmMQpZJb3Z?=
 =?us-ascii?Q?DgaOq47IK4cXpJyYQULO6p1PKvqlBAx4XaGHts/Up9ewxfCbylC6zivx0AKN?=
 =?us-ascii?Q?SwJvqLQkrcxW8wGOKtP8ttTt3t7NG6Fq9koBr2gyO2VcTc5WYaYPGFBYKMgi?=
 =?us-ascii?Q?rYxKY3bRySEPufmZAaGwRrTPwwRt/yith4yOVF5n1uBgxXSBpQ1J2mAWFk7Z?=
 =?us-ascii?Q?HNEgZVAW8Fb4jPfZ7uwg/R4zTsOGUZ4Ti+1xI9Gn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BPxSbYZIhYFpoabedrBwyk6kqRrN1yaGi2km61rftnClIxwWyVbBlQfRA9LToxkKJZPPqw3DuQdEhSexG/V3UDXHa59vNv3QV3mKH7TByguGTR65FMxLzVuhxVrtseNaLL+3tWmPy7OtSmobm7vdpXtpkAiF3aooqeCqK1g+DfnWtnTb+4oEzovEd68rIDmdJw939aWFEdluggyGiAqFa91zu1rG1n8KStfqV2t6SNQJtaq1952hlk807e+tFfXOTHsPxNpU5J+BF7p90NBgJNIaBkWOf/OB+rfV/EWXijRXAGkTV4rfJP2DOsxWU0cxPX6dLhGSoLEE1LMLxBrhBaMI+AgIOVCJhJ1U22mD1GlQfxf1AbcwqApFrc/W1WiaX8XaIjfs22apPQKbCXj7u7JAIshjjzpgIuwtbTFtLBLOenBcU78hyb+2zMsFXb92MnwmrfQ7Jlyrxjc5ylQoF/EezvrQd8P0u1Gv51Ei1iF0NzmeXP0JqwlUiMaZrgvnh7UkECe4kOxLCW/syf+r3bijzSFK9GlPtnQ5DVre59oBQHvsEFtouqjo2dxU4S36edPNhvWMY640NDGVL4iSBwxYnRXo6cGqIHBU7qSWKGtYBDSiO9cvIDKLdnnR8TCknTuuo34TZ33KldQr67XbqGqEXp4SDD5y2BdUL6bAuhQBhXv1MRbd3bRrolKjOpU2ephAooPmKD7TeK8JIYm7skObplq8OIHPk33RsNEs/ic/c6Tf5FdCUBBwWmIIDL+J92OkV4gvMelK+1pcEqcujw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d867970a-eccf-4d9f-a0ac-08db8e80c295
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:06:27.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOGl+QWQM71OD19j7/ZDp73Bi1yoM9wD51V4rcG4nrk6ShaKwuHG9QGrZjLpHIh5k/nlDjRE+4wfkWr0zSc4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270080
X-Proofpoint-ORIG-GUID: 13vHzdmZ8X6SbsT2VkLpDr6bEJcHNLTw
X-Proofpoint-GUID: 13vHzdmZ8X6SbsT2VkLpDr6bEJcHNLTw
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Testing with the fstests config option POST_MKFS_CMD="btrfstune -m"
reported failure, as shown below:

  ./check btrfs/003

  [111.635618] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (1117)
  [111.642199] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 2 transid 6 /dev/sdb3 scanned by systemd-udevd (1114)
  [111.660882] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 3 transid 6 /dev/sdb5 scanned by systemd-udevd (1116)
  [111.672623] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 4 transid 6 /dev/sdb6 scanned by systemd-udevd (993)
  [111.701301] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 6 transid 6 /dev/sdb8 scanned by systemd-udevd (1080)
  [111.706513] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 5 transid 6 /dev/sdb7 scanned by systemd-udevd (1117)
  [111.716532] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 7 transid 6 /dev/sdb9 scanned by systemd-udevd (1114)
  [111.721253] BTRFS: device fsid a6599a65-8b6d-4156-bb55-0a3a2f0eae9d devid 8 transid 6 /dev/sdb10 scanned by mkfs.btrfs (1504)
  [112.405186] BTRFS: device fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e devid 4 transid 8 /dev/sdb6 scanned by systemd-udevd (1117)
  [112.422104] BTRFS: device fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e devid 6 transid 8 /dev/sdb8 scanned by systemd-udevd (1523)
  [112.448355] BTRFS: device fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e devid 1 transid 8 /dev/sdb2 scanned by systemd-udevd (1115)
  [112.456126] BTRFS error: device /dev/sdb3 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
  [112.461299] BTRFS error: device /dev/sdb7 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
  [112.465690] BTRFS info (device sdb2): using crc32c (crc32c-generic) checksum algorithm
  [112.468758] BTRFS info (device sdb2): using free space tree
  [112.471318] BTRFS error: device /dev/sdb9 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
  [112.475962] BTRFS error: device /dev/sdb10 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
  [112.481934] BTRFS error: device /dev/sdb5 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted
  [112.494614] BTRFS error (device sdb2): devid 2 uuid 99a57db7-2ef6-4240-a700-07ee7e64fb36 is missing
  [112.497834] BTRFS error (device sdb2): failed to read chunk tree: -2
  [112.507705] BTRFS error (device sdb2): open_ctree failed

The original fsid created by mkfs was a6599a65-8b6d-4156-bb55-0a3a2f0eae9d,
and the fsid created by the btrfstune -m option was
1b3bacbf-14db-49c9-a3ef-547998aacc4e.

During mount (after btrfstune -m), only 3 out of 8 devices were scanned
by systemd, while the rest were still being discovered. Consequently, the
mount command raced to find the missing devices. Since the mount command
in the kernel sets the flag fsdevices::opened, any further new alloc_device()
were blocked, resulting in the error "the fs is already mounted."

It is a good idea to register all devices after changing the fsid.
The previous registrations are already stale after changing the fsid.
---
 tune/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tune/main.c b/tune/main.c
index 82ae5a0ac2d1..4fdc2a0acce0 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -446,6 +446,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		if (!ret)
 			success++;
 		total++;
+		btrfs_register_all_devices();
 	}
 
 	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {
-- 
2.39.3

