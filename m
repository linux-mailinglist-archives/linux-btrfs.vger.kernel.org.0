Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6147B103B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI1BJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BJn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:09:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D07BF
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:09:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6IhV029467;
        Thu, 28 Sep 2023 01:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XU3KIUfRp2S/4aDjuSR92b4WkPr9FvUed8D/YwMmuBo=;
 b=Az4+u7jqEFTbjZj6xi6Iqig7XseW9m2zb++HcfGoUwT79yhpE2Y8VXghDiRal+i4li2H
 97BOz2pV97sRr8f7HrIkLUSxzczYJwUEmkODWCp/sQN0ZQRqFryPqAhEs8t/j69vi9PD
 2BG3BRW0DNsKC9u0H4OwFzmeBQg2VB4t20B640cArxKc/b4v01GG/QuD0SCAXT17WtQZ
 WGZXnYpzpXadQ+l4cRiOTfm+OATf/edSSLNb0STvZmevCWyvO61oyIc4EGo7bEwHbCmI
 xwXMo/UEJ4yvsusTXWW6HaxtWK4JuapuflWH56oM9rnNzpyBotw8GZCvAxZdJiOC/a4I nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbjw93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:09:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMU3Kr034915;
        Thu, 28 Sep 2023 01:09:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf95hqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHnmuuVRgIKc72exk9xNv5Nu4y+NP/KySKbJ/0WZzWKURQNkfgXCid9QL8rCueg0+/C60DjaK/9OEMotK4BsLUyIhXDoYEEh11RZkkCwDkacOLCNZ5LXA996N8E0YaiJKPh1VGzmOJq2bC2NCXVcx4alp6gRlFWCQMFd8nzuSo3rfhEc/Mp8ZnkiyUgwGq5U+e2Lnz0LjKDCFH8FO1vJLhUD8MhtYJXdmUCaRnNQpLyg4Ofm1RIJxgW6tfqpiut74frVgFaGy6WncDpKaPGOwGKL/AB37fEgGmjlKB+PhKPrmTWzLOCrqftjNAcow74G77laEIqgNnK9rAh4aoki0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU3KIUfRp2S/4aDjuSR92b4WkPr9FvUed8D/YwMmuBo=;
 b=czhyg+GQT1/0w3vooH7j9rEGNZ8b2XGZGNiBYS8dBfyDvB8h2Fi1BGtMohYP6/T99hJg9H7BXKY3PuhhUG+YASsW3hoJ/GOFZKAi8eO89WpXeEmLl2aKmgjcBjWVZBDqQSOuX6GV4GGXq7m/xQIT36EVCT+Wkfbgai+uBliXy1W3DwNjFaAPiI0zjZ5qHOFqtKK3LlgJkwdfm5MCuj1CmlpcooHu3op4Nltnj0zR0QL1hcVYpLm5IOsmr8M87g9Y9foJjt9qCnlH/9pXcedmb0cA6LofJpBcz8O69H/S8irGhJXXOpW/0nzbn7DNGFJm8b9Ob3cMSI1f2eTBnekT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU3KIUfRp2S/4aDjuSR92b4WkPr9FvUed8D/YwMmuBo=;
 b=o+8e74+1bjjVBS87LqGue5yn8ISM+ppz4tjviOowVLGoKDOi43WzkuX0HuSUAZKTjWTm1x2yHjND2NC/o8NxDrnQlmHLo16NxpKoyIk3Y8aGaIqDUo6qwdV2gLRVc75d+i5XHy84tX2alN2zNwCEv/DVWaxAhXN/jkf7FZavu60=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:09:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:09:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, gpiccoli@igalia.com
Subject: [PATCH 0/2] btrfs-progs: mkfs: testing cloned-device
Date:   Thu, 28 Sep 2023 09:09:17 +0800
Message-Id: <cover.1695861950.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: e362ea9d-8075-40d1-d737-08dbbfbf8ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thGqjrGuzvrHlur5iw02X820m1CKE6HOQfChD3GveBFeV1XltnIgrU82BdnxD2ePOOiV6rc0SglnStNrbd6d9zd5GqA/vOMK/57VegIbSlxh+r76sK6A1fV17kog30j1M0My9TL3/YGPNA5msjI7IoS3FSnNYyuVdf87TkaiiLCYDsowrVB20mIVrpcG8snw1q4NUc/rY0cJPzWJu98m8GUlgvhNyI7MzeEe7jRzigHnyUwcaKEUdjrdr+4IRsaaTgBGMDAc8VBL4V+yawwGjtI688Jie/K4vrTSfCDuNxgC6YRCMjwgAKXsbQBUu5TVcT6d4ZOPo31lYTYVm8XSHtCGPHjtZUifcv2rtEP3O4vRCDn8E9SpAT+9/MLbJK2bw/1X8pBPkjXsPEcPXoRaQqwwjMPLMrXwi03PBOwZ9e53BNOYSkO63LMeFqKS4I1aLlGsQ2ksA0H3eeXggFEimUleOVMUItSfuIYAqJC/62RY2dYuNXVP20BGNYOVS/XseQ3RMadWLcDX1grdj1W8DFl9/bsVNLdw9h55NDV1v3zjuyDY4iXkLNW6YcR+0i53
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(2616005)(83380400001)(478600001)(6512007)(6666004)(26005)(2906002)(4744005)(44832011)(6916009)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(316002)(8676002)(8936002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9DBJWemieXClzOR8e69EcsmFJwzNhbckO8rtutCJ+OhDHZipEWucxiEJ0nh?=
 =?us-ascii?Q?9Jh0M9a36TUPK36aICELzyUuQjzbTt5JQnRxlrOdS9dOgNKCXzAB2mKI1Ywp?=
 =?us-ascii?Q?lVnpBxXRq7pYzBqa4Dvu3wVrJlVJ33y56JHatsedpv4VIqg+0yqzADPZWII+?=
 =?us-ascii?Q?QngTmOVTCUJqwocxFXHUbJcqJfg6cERpEt1h4RMl5WPDjMXWyHlaWOV2iYFn?=
 =?us-ascii?Q?Xv5W+g6n7Tzj6z7sCWcvU3B7+87OjhSLvAsS5cyE0ontAv7huJ/8hOP6sd0v?=
 =?us-ascii?Q?d5Xtif1FJiIIv8kfPCpzREmUgkdKIOtszvlGwgAqqkNXHOPfyA7i6nAqJ3zi?=
 =?us-ascii?Q?3QRMAH0qwSem9p6J+Mw7tNLBFSBMyDj8KelmPjDbIM2SAn77Fmddvxotv2kK?=
 =?us-ascii?Q?6qJxxdCJ8laKYcn+G/BQy0qkD5TscANntIU3MYomgpWX8GK4P1vwdTGQmkos?=
 =?us-ascii?Q?0e4xXuBfRu2GOhU6nr58v/cFhB8hJbkdHp5xYR9CQV9UAx0wi6wfZSiVV/Al?=
 =?us-ascii?Q?3BFmVWltVvJ850c2dnWgp0hKr71WSWeRWs/etEMc0xVWet8g/QSOBIoeSaMv?=
 =?us-ascii?Q?Gzstpqj3SnQZ+plTz5B/aG408zxIofvMApAj8zewsOYPnT0Zz9zbLPm50xDF?=
 =?us-ascii?Q?RYYRbkzAW2nj6phGXprCDZcSfS0uVp19eiUKTD8ktGunDY1yMJ2RNGy3rMKY?=
 =?us-ascii?Q?nxkXSiO++gzvukIIQy81qSj9WVrPv9bbPWIY7SLsRXvcItqaH3qz+9JcXwCk?=
 =?us-ascii?Q?XRI3SB4mryR9A2B8HE5RWUg5H6KYa/imUETU9GiUx8OaU9CmvkyWwK+AW3TK?=
 =?us-ascii?Q?T0hCdQGWA09D7WjwIGgwH9sN4UxV8ChNVRg+/p+lI5gvLYfrpSAK4c4GWoXd?=
 =?us-ascii?Q?LacSS3RvwO8gyK2PvzpS4Xebn836qBdTjuA5zdRfWwgZb/u4lp5j5Ms/n40W?=
 =?us-ascii?Q?Slo/LBGKHZ8LE1FSITO2hj1+yWtICstb74DGSIv9tkw50uPkGuPew+h7/4qQ?=
 =?us-ascii?Q?HI6LlRpU5NE6ws+vZlev4jHqw7QoCo7KQRclxetCn3G5S/qtVclH/ONwv93g?=
 =?us-ascii?Q?qbt60WsAVQhdIuzZ6QUorvXab5xoVaRoIDUsqJIxVwopQP5+v9w4Eo4rgFMv?=
 =?us-ascii?Q?w8yywXdIPlKynKXYnCAq+Sp8OIDqFyQaaG+Ck1s4brbIYKqbdHXZB+a9CBcD?=
 =?us-ascii?Q?8Kstzihvd4oX5Vu5XtSPce9NDZxnx2hb7eG+MJm5g7Tryp0Ussca89t7/Ylj?=
 =?us-ascii?Q?fj5QDC5Cvk4ZfBx3bzAEXMXtmRK8i+9I/hNbxnCaHELY0Iueac2d8+vpuy+5?=
 =?us-ascii?Q?kpvBcqRdRWlpNFsRMYR8A59r4kMvccabt19WmseEHSgT1lYjyposXD5DVcqi?=
 =?us-ascii?Q?sQ9reLA5Pfz8fnGOyABB8E0DswarDIaMuQu1Ucqjqtfh71AMDZ8HfD35Wx7F?=
 =?us-ascii?Q?E1exhGMxIrsrJFCWukZ6n4pyUvVzrS+t2v+1rAlrCIT8DAXTBoo/bLgFaA8t?=
 =?us-ascii?Q?5O0sB8MF0NhhT0+DWDZ9XgeNQZh0CyJl733gvg7qFdqgDOqt9KYks5MTc07/?=
 =?us-ascii?Q?EXUHuy4DPNLgUQDXJwq45j+717PUfZcDLi3J4Uvx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TgB1YgpCft2OFPPbgRFgk5DOTKgNtJEYKoncPZluElhyDCaCNONcLziee6xIG9YRC9WD9WIlKWPDBVjiYXHrXgbxw7zX//uIdI7BU+bl/CGMmf4QAbthzI+yX84+Ra/oqc8Jp65PmbsA4BKvJsPueFb0pwn3fDJ5pumQ7F0IceA4Q/GKK7Z+hX29jRa1apqxj7KOslyOYTWQVudN5kmej3TXgI2l4mpgv+i7scUP34q5QicTouD6Z6YldXgGGjKn1Xoawk0OE+14ympIbgWOqSmnsB8soMGOG5cUNrwgFsQbvrb3K37YxRDFuoE0zW3AR8lWHU/J20Ic2IODcYcJvydfvrUA+GXqnG13AtAzhXpbUwJ4eFW0W6yryEzoU1zkJHqfyTZaFOlRvzqRXkW0afPi2n6rTURGAOt7KaX/bbY5Y1Sz4uSKJ9XEr0FV7uicXjBwYRRcLaUaXMSxfuDxJ+slHU1tEhPeowm7/7aFGXcNvH2d4onKtP8RsSff/03WdiiYLPa3naktHFwgWeXIzCbEyYDKIvTyUlcQYTv9u+0ugjK9gP1A77lQiJtct7gAMT3pKI4SYv1E/wUSMpQtISFzIY17c0lmOS+cODIuUBjNwyygP8XZRf27pn2Vz4i/jYlLN0KDRQGpw+j2ni9brDSyDcYnEcX+1br+ai71BTqwny3ZkZqjuRXxdcEjOZC5R30KlyMZ+JoJsLGOU1grfDoPf0Yc2mMIxJ/DH8K5XK0reenHv+pFqewHV18uV7sPmXLQjTMkYgGHo32wmr2gFq03OOP32hyXiJfwyUmoMD42TRV7ZE29WVzHSeqn7NWb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e362ea9d-8075-40d1-d737-08dbbfbf8ecb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:09:25.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs13Tc30fzGIXrBfCE8a/srZlBqhArbR3CwynkrrKzvsgWMHKbQAjoQiaIR5QWTBuJYGbpT2LUnopx+au/7UXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=816 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280008
X-Proofpoint-GUID: Z6TeooEVtjb31H6EjuEt1m0T90b2O0eR
X-Proofpoint-ORIG-GUID: Z6TeooEVtjb31H6EjuEt1m0T90b2O0eR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset adds support for testing cloned-device in mkfs.
So using mkfs.btrfs both option -U and -P a new device can be created
to match the FSID and UUID of an existing device. This is useful for
testing cloned-device.

Anand Jain (2):
  btrfs-progs: allow duplicate fsid for single device
  btrfs-progs: add mkfs -P option for dev_uuid

 mkfs/common.c |  8 +++++++-
 mkfs/common.h |  1 +
 mkfs/main.c   | 14 ++++++++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.39.3

