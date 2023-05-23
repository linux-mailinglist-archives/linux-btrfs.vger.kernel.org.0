Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DA70D9D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjEWKER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjEWKEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6894719D
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:03:54 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EeQf032439
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kTGw29Ai+XrMtqw3Jj74meDKL7HxwQxqZJ1t+ezf9BY=;
 b=vaEd3XQhFYdgL3WBYqa42eatp+IRqPX5xdEny5VnYW2oXohNBdrvxvG9OWN6aPCNNjPj
 w0sRsJntdBuEW2/rnHGrSlWGpXtj5rg++mQPxqOiF1YC8CDLI1Iut14CwiL/n/QCkPzB
 haDKD04wLqBoNND/Y9QtdinQdhzECL1LOf5ChhdMnyU5me6vtZIXFEfKVdA23MrL59EZ
 TgRC3cFKAWFmdJI56/PZkFr7cIn0ymTFQI+ICkcZ5M7S1FwnyYAnkyt2wKVoh0O3h4lR
 JXjl1XdwDU7k61ol/X4bSrHiZa/w8DwCBdFRxTNl4/2hmiRmh6Fj1wQcTW3z49pBetBU fA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bmrfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:03:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N93dRJ023677
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:03:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8u437r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:03:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gov897uCT9LsZdn4ywcJJQbZLSb2X++NU0uc+ium6lBFaZ423/Wkfq9VvE0SyiG92Y7ZwNPlgDsoGXvu0HI7U6BCsmF6ogDFC83ob8bKer6dCwC6iItG1NiaP62OSaj7EKmqa27teUle0nh2I1iqGu5zkqsg3YKqFwnD+aDj2M4O70JJfa0oGjdRXwMFAa+QuH+uqZD1q5MM1KXJuq447fWQkf8QhK3QRQ21t0Jvrg5jhfBq0uHeKVHzJyQ3/bVzS9ungCLkko22wq/0v+bPxBAgPLYf2Y9ABY6uAfiddoyXvvlgB7Ttz2Ed8frpyN73bbdraPmhpL7QOOHD97BzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTGw29Ai+XrMtqw3Jj74meDKL7HxwQxqZJ1t+ezf9BY=;
 b=hMTvyMPcz9UJQVefOBwfjeLxciaYSGMDxFUjhw6FQp7Aq3fb6DbOjp4rArdnpKf2L2CZtemVDpezDQlv9n8J5cw1IN9tnL0N5IbBORnYzabxWV15rKuBnIf7kLvvQxANOxFhHRIJcCmjMX32eQQrxupF33I+9yabtkKNTXoG7MV4v1d7ygRhKBNK75BYqpOnSqwzx8nkB6CzGj4SDAHie+EZ+3rQix4Emh2PiZBz4bN+TPFm+/cDQwSqe48g246dcBlAZX5756+xy0LbEmRedDM5NuWDD2qWuecW7ZQtbtJV30SrVkgW4OX3HUoM0YU+EwcJcXwWwHpAH6UdEMzrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTGw29Ai+XrMtqw3Jj74meDKL7HxwQxqZJ1t+ezf9BY=;
 b=i8oDr46T5HGcY0qwMYPFreXxo9MnWL3X69ECtzwSfIikIOoRaA5dyp6LMyTe8IbHsUlgVfM8TjzE5MmWM+u34NyA5VE097lGRDWFlOlHieq7QjDVOue+CHhVyH8LKd9D0/m4UdzpwGD6HF4jXrfzUebs2CJrvf1jaHjz7p4nIWc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:03:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:03:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/9] btrfs: metadata_uuid refactors part1
Date:   Tue, 23 May 2023 18:03:14 +0800
Message-Id: <cover.1684826246.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc0973e-1e16-4b3d-33c2-08db5b75018f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtsK6taerNpCWotApJn54skeD6/W6uzzeo6QfBJ+RWxIfvQ15i46/tE8dffly6BTdQRRWkxgRZLsvG53XoS0Es3TvzW8pfpYCSL0zhz0ML+yQ2EeMN7j+Cpzt1yZRNiJnDd9MyPbjzqUhUi5O/+uIBnNBpKEM2e8pmKSV1s/uZcW+31N1HIjmMXymHgy6yBwv2gQLJdn7dccb4umi+45XrWUDF4KzinWceVPbLNoxjb5qKypOyYeeyLH4YCzBCAq+c/OY26ku52sHR/sclSHArhoZetEArlGB83D7NpZHv/k0kmNuxpKw0WgH9CD4IZ98W2WpLfPnGnmxF3yaPnm6aNU5Lzb6g50Ys3tZGl75B5Nq1FSZbFqnLhqPYFAovTZmGFZJ130NxYU80KUIvhmsxx/lw8sY1sKHeG+Nd9tQlt9mlOH10voHDtVybtK/wp55oGqO/hBS3worjiIp/oi1fnSO19bM0mCaBtGQJH3XaGlfz+ji9fOt60D3eLSSkGnHd51nysof8mrBQQV8jTKSdMvEmEpjaZaRnLBdkOb1EX95CcozE/3iJ0J8aUDQO57
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(8936002)(8676002)(5660300002)(186003)(26005)(6512007)(6506007)(41300700001)(44832011)(107886003)(83380400001)(38100700002)(478600001)(86362001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(2616005)(6666004)(36756003)(2906002)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DbFAR5LShN+ofabOA2zCmN0FUZdOQF/C/KsSspjAtAtT8oHAibAO5l3MDfg?=
 =?us-ascii?Q?RKeXR94zu01B5RKQl9GKZs9dTnROq/1iqGY5Y5TraGfKk5oA1PZjMGTNg4Un?=
 =?us-ascii?Q?I5D5zEP7L4JmsYIVJlKBzstPtjjZKYb8sFf/RvnLERvaiJloqzcTJ351F3P9?=
 =?us-ascii?Q?f8g4Uk3HTvOUhBC4n6w9cEoTZ7aaAsCMU495+ANAfWgdRSMWBVyOFCIl8IPP?=
 =?us-ascii?Q?VPduILHA51DwMgPwRXg2g0I+hdg2E9epnF1M3XpaLgZeCSFYFd6OUixx9Baw?=
 =?us-ascii?Q?u5abNW7SFrlzRkoAbTCjh2jvOnoSorBQjKYTxjW/3wIycihNq9bq9lbsZovq?=
 =?us-ascii?Q?xS6Nd2V/8hm9j5OiLCLVucCzGO5QPk31RR5gdFqaek2Zx5wAnAiGp10J9+sv?=
 =?us-ascii?Q?4eDevzAq+h02ZLFiqkenIKg1QSF1T/3ky9zx3vwBUDTp9YttNChaB7U5suQw?=
 =?us-ascii?Q?CagDZ2Fqferh9jaVLXpcw2e8KcXNfuUzcA/75TzjXri2Sk2Ts8i0LIUZuWzq?=
 =?us-ascii?Q?aef8XXJQzwup1whxeWgrAzruLq4pYxAGpte8hZcTeQIqC/C3cWPKh6C9qEyR?=
 =?us-ascii?Q?xhV46TCAFTlTMF8ZRY42qvfvciDKMMmhvETGDMhFmEPb+2TsxRvdQKV1N2fG?=
 =?us-ascii?Q?jQGNUghobtnljfLhmetfIXUjN2kcr1+vjmMMnR0b7keMpKQ2AdxuB9pPpkhc?=
 =?us-ascii?Q?02+IkZ3uKh3PySzDtT4DCh5gXEKq0UqpSaS84q0dIGhXkKyTT7cOPkZdWjRv?=
 =?us-ascii?Q?kNnhawG1/3TTo2DBLZL2NdnoSAcrxD4faUXfHYQiOm0Rk+1GvQOx66lh9V/i?=
 =?us-ascii?Q?lX1Ofh6HNXqgAejPPZQBNoYfSJctX0AOhGardVeM7IzWmXCwnaOtDQ+6WasB?=
 =?us-ascii?Q?MjPrSbSe1BucmbSGtfwXEuqIEJ5/38ViP5PuieDMzxbbVUKY6rwVzM2CrIWw?=
 =?us-ascii?Q?5QlmTAKZMbXP0EWRdEbDAC9opMLJD+zu6uI6Oas6Lzyu01thrZXFto8i+r+9?=
 =?us-ascii?Q?G9lBeS+uVeSnXuIJ9kHxLbhcIxMtECJB1nR05ioUKG5b/SXg2g+uFjhRXiN8?=
 =?us-ascii?Q?I1CZSmoOXw/vfr1vzvIhRY18Ycq5pxUrINmPjPKf3XLxc3FCiup+3TSTFEk1?=
 =?us-ascii?Q?Xgs5dTgADvCS9eztZiy/I1g+HfSzj8/6EWwd2Gh3OuplBAWrKhBjguc6Sg1x?=
 =?us-ascii?Q?byiyYDeET8zBwiv8IfdcoZYV27pTEIeJzQ7AOwiCYceakyf4Kd6kIt3CeAkh?=
 =?us-ascii?Q?0eSdbQdLa5IIN+EDTpBw7RL+M/NIy3YL387/1+Xz5s4xVuToCCpgbPlUpbS1?=
 =?us-ascii?Q?Z9IcVHtPYy3VBl0t+rNuosx34TLBDeDc0fgxlLvmMRbnBTCGjnphFB5NEgXX?=
 =?us-ascii?Q?O+eTm9GFeWBfjQfOBGDaFMotAD3EKbLMkFgZF0EMIxvzJOiyJwC9qHr8Yj6B?=
 =?us-ascii?Q?xB8crf7KQaqv5/1kkWL+glP8BRZ1pOo7+mZI+h5LIdSfT8QRUPzTVAk6/oMv?=
 =?us-ascii?Q?EbOY/1crJE3V5ulHCwEmZAsDypqRrSgGwo4KO3JQ2mmbS+xKlhrC6BG5gIlr?=
 =?us-ascii?Q?z4/zgVLOgrTY9J72b+52QNeSrifoKQlThHnI+1I+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Vtv8EsNWfiIhFgAWpiYCAQ5iOuqXzxDHJhy+eJTBJo7NWaEyQLjHLrwCaV2VsGtWSOMoemntgoBpRxDjRYci+CBopzQVoI1XBAXhjif/7jko2h0DeRJY4x32w5C7KlKrOZWMcMyWcuieMYycvrHbXuUDHzlEpHz7nu9y6jXUDhELvj5M07L4dOrZ3yRXepmQOHwyxnHW0zrvWcfyBU4jzBKnRntW+GqEBEqDPk2y0y0uM7zdjJDtAJY/xZ6JHmb6K3QhJdiGe1DJNcY8k4+Qlk++PWpdtaM7sq4wK0dRKsCqLxvScQOflQQreGzBnvUzZSL9Rm+hAZ1vx8wu5Dw1b7UzcWSTHFZD2TTsrdLhg8+HO+DTu11eVqvx+bLbE+obqSJo6HrfiL1aBuAtnV+7JaX10/hgFDpUWu5WpWv/gtpNw+ie2NayPh3rdxyNQbG/h9mhCEywL+A/9fosQnKhxDy3MV0Qo6BXdU2eyoX7zSQi1Nn99c5KC+IQSaYUZS1KityAkBB8QdYuN3Ph2BENPMXUvRhvj2oyO/fulaM1kipAL4953JBrHIDF2f8fQyBbO45ZuhU3LZzNU2l7gI+fcOJ6zb+AKonucWoSskcZhqM+TNCJH0Ec7BxPhuq4GFdaer3fWm8dEmi4AqhDuSYlAnW73WbiUsb+IFFxdddecPfCGPasgFihrc5H28dwSarVWiYBpN60H0WdksA7TRAsNdAGt2mf34PAJO7u6lpo7MVBtVZ2XYAgfQWTJx4SziXczbmS5tcfQs/OSre9Ol/mZQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc0973e-1e16-4b3d-33c2-08db5b75018f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:03:50.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei9VYPj+bGAoROkvNVLgIxoLJh4q7kAGTiTx46AKCP4OR9qARNE/LIoPhDhoDYQauJoBwrh3QXcksQOslTXblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=801 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: sPp7VEUawfRFJURLjqceoLPDd6zuyOTl
X-Proofpoint-ORIG-GUID: sPp7VEUawfRFJURLjqceoLPDd6zuyOTl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The metadata_uuid feature added later has significantly impacted code
readability due to the numerous conditions that need to be checked.

This patch set aims to improve code organization and prepares for
streamlining of the metadata_uuid checks and some simple fixes.

Anand Jain (9):
  btrfs: reduce struct btrfs_fs_devices size relocate fsid_change
  btrfs: streamline fsid checks in alloc_fs_devices
  btrfs: localise has_metadata_uuid check in alloc_fs_devices args
  btrfs: add comment about metadata_uuid in btrfs_fs_devices
  btrfs: simplify check_tree_block_fsid return arg to bool
  btrfs: refactor with memcmp_fsid_fs_devices helper
  btrfs: refactor with memcmp_fsid_changed helper
  btrfs: consolidate uuid memcmp in btrfs_validate_super
  btrfs: fix source code style in find_fsid

 fs/btrfs/disk-io.c |  24 +++++-----
 fs/btrfs/volumes.c | 114 +++++++++++++++++++++++++--------------------
 fs/btrfs/volumes.h |  21 +++++++--
 3 files changed, 94 insertions(+), 65 deletions(-)

-- 
2.39.2

