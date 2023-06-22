Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FEA73993F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 10:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFVITZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFVITX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 04:19:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5C1BF2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 01:19:18 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7plBC005807
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=UCtPrNTj+pRrUuSZZ17/f0Nd0WvY0jnw5ZxVXVqw0ek=;
 b=Sm1m0+tYroRlFFET6kOONvRUaHzpF/JmpYpawuDDGPsl/CO/TFWt9hRs/F5GBZhURdjx
 ucStxU00wLJcJ+gmmMcc9Y90Jn3YtQK7m7yRTwNNqUmMqLo0QPmvYiKv19hUJz+EaWiY
 ysT9rhFTJK6dhWgnr/IMraoF2fana6TyEgAqkk3LwFey96uyEGZst7ynyYxXeXd1EABU
 YAsq51zvepfeFGC+najmVQvumhx5JxUM464SZL+C+UowKoEZOpXZy5yYWKbDxLN6+AYf
 yz7jrZwz1QRNcjM4L5Im225QQp9Ok6rn37prUh+zwIWoceOtyhdm4FwITuzCdhDhdIHa yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcsec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M7fLZN038670
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93976n92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 08:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAvABvQXbfQLTefkw0MMD8JOLpLW751paNzlzZ3kmMWSYi41tsc7oGyKKP0V1X0ePyB2hv9i08Dv80dfASWYGHGUtjboDbuy1XZALWhokLmPHx5DiGYFln2rYgTndB6/+rhdOAddSEPy+rGxTmLDfNE+IWvBVg3G3VHhK8nkjgDMRAe1+yuC+I6BWqvdRnHP6rZIL6SovSxJa0v42jLJ5iVjN/r3FPSaBn/c3yEPIwFPD5zxFGHkvWDxKxNRmQVpfFp3Kpb55MiHzIixJfDHGNs0xmJvM+H2pTTtzAIc6OSHaKQUgZxptOdgQYAy3b6WNK4Q6IgKycVh4arq3PIL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCtPrNTj+pRrUuSZZ17/f0Nd0WvY0jnw5ZxVXVqw0ek=;
 b=Mat2uk++MTg59Wc/rU26kjO3aeHthJe6xxR/srS+kikxSAvAZp8xzI40tUMuXMeooi2jRieecTLsp40nkXKWv4XWDhLnoA+0gL/G2FbVFOo0M08m0SasguYT/IF++Ni3FvVPgA0NKCIIYyOgiDf0T8R0qVR3q+Ez4/U1i3Sg4a7zReWtK3v+LBu661YcjGHxSVSSzn/oaGPyo3E1ypkwPMsMF4EdfjwHO8W0eyW0Co7W/QIKuvnn8VT/i8a0JJzW1pml4b/0gTwwJ2HS04vIelOYkvb/G6pHZRWUCGI7d+XgMrqbaUYfpjCGWmjfjZOXUg1JpTf3l7xzRguKjYD5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCtPrNTj+pRrUuSZZ17/f0Nd0WvY0jnw5ZxVXVqw0ek=;
 b=TG2Nt4LEcDdXcG2yzlNph29vihqqklh/B/0G8sjR80yx2KC5qPPWjbkvmUXcnwKBQVIWBS7cDnZ0SmZrP/2RgOHilUWgp8bKkJhlxn9zzAcgdc0I6sJpKFfRjvWmDEh5oxv4tNmmfn8AxhDRPRbPTX67jy2QEO0qHbhY3iQLdKw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 08:18:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 08:18:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2 v2] btrfs-progs: tests: fix no acl support
Date:   Thu, 22 Jun 2023 16:18:10 +0800
Message-Id: <cover.1687419918.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7bfa8a-b31c-4e01-9c6d-08db72f94105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62oTw2a3u0SNbH0SYOmP1EPZhSheNhsXYsISSF/6Mgd5JNE4KxvJTAxd8AAjITb9B1yEwBqmoqKtrAHyP/ZGAvtt5tcB70LXdHwb5iKfIyRwOfXtQY+zbAasiLZJR0OeqDZP7CKm7d/9M05IcOnS/Q/TYIcLXGGAmzdYDpgTnjQ4KYwR6Cm51Z7pAaevprzJVPCvpurzyxcPYlSDgxa+JFYqIUX0d2RsbjY/PLBkrOSKuto84cMm3g8qhKavQOxi+MUHeLqWjuo+7kn/Z/LdL0sivFTVPSCznymnH2zMc2O05SteBfR4zfoKyKJouVtrym1wLIh8ttN7z/j6XA4IOZfnz8mfCQga/jzZQLWBZs37FOOxDnrsupy3ZywCPBfJQaowF3iZ7Ta3urtQw62IRDomkV35x5stY1WyfQbupxsg3/X+X8kulLYKyUYCQwXnzNaGIW9tDFZTaIQJEXKz3iFVZKbPjD4uJ5fgeMorcu/CGpJn+HBpbKE2idfKcrz7JAftdzseCobrjzgEelSySkO4kPGa3Ncn5pa7pkAX3pKlVr6e9lk0Zkq92Wcyt3PZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36756003)(86362001)(38100700002)(2616005)(83380400001)(6506007)(186003)(26005)(6512007)(8676002)(478600001)(44832011)(6666004)(6486002)(316002)(66476007)(6916009)(66946007)(66556008)(5660300002)(41300700001)(8936002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycOoeyOJin2cdQdCdLtTmWLPuGl7FettgTMRrgbIo6iQBMRjlF9xxnEABX+/?=
 =?us-ascii?Q?2iCzidKMk0KfeGOM+wHkqMFwak4OSiS1OK6u932dDQpIccNCzH/mpOCeWfNh?=
 =?us-ascii?Q?3+0dKwm0ZwkKHJt6PmypnFTTnw1jMaQNBmS656i084pDI6nn1z0Rl3FHQ55I?=
 =?us-ascii?Q?khtJEaG6N+CkwI0t/0IybgknIhhCHWvgfUr9rhHS6ZojN88s2MEQ3evRLY7b?=
 =?us-ascii?Q?qhJ0TIi+MaYJviOGSq5aC52J2Oq5mkDPmkWPbQI41mzxqf0J7Zqdr6mCIrjN?=
 =?us-ascii?Q?CLHxoc/sSLGTcMWpvGsb5U5j1TkmnP4Qh1Mn1bB2SSoBNY9Gsdu5XFJK5ouC?=
 =?us-ascii?Q?mV1CoAQG4CsMUF7+OqiW7KxphdDDRjtb8pAOKCMVsNtZDsmUJUkBNf0rpdm/?=
 =?us-ascii?Q?D0hCiXYGDkpTI9t07Tk9SmknYBigzb1Ds2OT8mVY0iWzJqHENTMhzlAEsd+Q?=
 =?us-ascii?Q?NTLQhXFTbbuaajzR8o8ryG3+Cmg7C4a3iJ4Ik/N1IuWJQoXde+5isViNfl70?=
 =?us-ascii?Q?X3RM+U07HZY0zaNG+8o1p/1lD12csRnKlvJ60TUUnRyr9Plm9XriiXKqXH4Y?=
 =?us-ascii?Q?XKMmYofmesLyirX6FE8MFJW1XP10AhjP3ffFhU+f/D2fIElH4hZwH9CBScym?=
 =?us-ascii?Q?2t6fPoCEw3fnCX1cW7XjtY0xuq+JNAiNpbMefdGEZXB0sruTUi8DcWnDN6BA?=
 =?us-ascii?Q?cqtsqPKjIGOhtBNR+GuSdTxQ8KmaQbVbtFxRHNeQuvC1M6JLz/K9VREuf73T?=
 =?us-ascii?Q?KmG22jt4xM7dlVUI3X0dLn+hytmDtm9tajq0E0pJfHKIKRTojvStYUGB7d4t?=
 =?us-ascii?Q?Uk5/dmWraB8tsPcDDk1Dt4FPE+s6fSfjLAnMvX7iaXms9Di3p1vSRUouYX4+?=
 =?us-ascii?Q?CnpymBOzoDZgXPGxvSLhZ5Nq5b0U3Fj9eSIospDibqa4rIlkf/gx+cve/flZ?=
 =?us-ascii?Q?jd+/Pxia50vaMg87h2uBtqL+hFlmLTwnMbEPlfped6/bI4pjQzRADjTPciqw?=
 =?us-ascii?Q?QLPRAF2tcXo5aLTZ85sRcN5kjploLfeqzO1U8R7PR0Bw09JyhaO5pXXmzO6S?=
 =?us-ascii?Q?Gg0KVOzSLDfLxa/sznBlOqzc/d/m+bKB2/NykTRCLPJqPrhOZdzKuOaCls5X?=
 =?us-ascii?Q?YFPa82HC8fnxnjbPcIX8qs9UyImcT4O1eqcNPaRSr8PQhz0avh41XYU92tBq?=
 =?us-ascii?Q?alDlz6KExI9p3wsfVySJtJMUyKUUNAz3hJJOCDmHYDuhxU3qcU3pZz7uulNp?=
 =?us-ascii?Q?g2p9eRn9Gdp7+ituN7eHbXQh6glS6E2ggorcSzP2wc74o+xQ31FerYgBklUA?=
 =?us-ascii?Q?AzneujU+Pa5cxc/0ilE3gnNIlftbwwbPUHFDc0tceddB5RtejoQW3ypjxxQN?=
 =?us-ascii?Q?qQr+Ekvj5K0pzi9tmyOfLMKPCAsZsmCJ/Q7s0G8FeyyOuBaTpfRAo9tFmEZs?=
 =?us-ascii?Q?mNZhoFgxp5RdrV88Wi+nq0CrFUUpMVDDysTCh67nfFJO73bbtmUm3myeBUjS?=
 =?us-ascii?Q?PExdl6KgDVNVJDRvP3h1Op1Ws39gLcOfhB3MuUjEYHElSqvAMImn043uToX3?=
 =?us-ascii?Q?mUcCcjNj/LLi/0Z/kiW82D4FPvpV3dQ5npQ3u085?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RYxfp6ubIRhkpNnX+VlBRf04cqB9LqfFRtXPBmDQU/JvKPddGfp8wtNUUyClRlknO5lkoHT2055OZnMfifcQRM50yj0u/+5ZzSEfDboXNVdg9/+ChGnWl4+DysBBqp3aFEQrUrAmSMTciD3wTPtHpfpez2aHxEsbkajZZAjSYV9Wvp/E5yJ/HCIx5hk5A8SlJgdAjeVXswGtQ8ivgj3Ppp9CgDyXOJUaRVPg9tCdscgcmAWfDy7NXu1GzYqwlIg6QYjyVatsfmz5GNZi/5Ot27dICjQto9jNo/fwm/DstiZq9u3i6f51cZMX+s7WzMFFWWEsx1/t2YEpXKnwmuIQC9BLtUgi4KlCnKQQPSNBBAAxT6XadXC6v1CNOVm2fBKwOvofeDI83Xkc+i1FTgu174sjrdjf6oVd8D+QdK8BYdYOtB1zPq9Kw+96EJw/JNdZYdH/2w0TuiX6qpBO8Z5LdyeVTiksyqtfiqEsbyax6SAgq2MVlNlx6NTy3aLYb3pnNhhgXDOWU/+91dPS/1naahGRsM4eQfdKN2da9G+DpGIc/2sjXn7GQ4341AU4dUOuH8AAsqd0AP471aQC5ri69dJPfllrS44TXXwgm8Uw0YHQK6TgjFEhHnm2Rr6xmbo6HJmvEutNV6isHXejrZ77g3cQjC+JVE/lkZZVqcIbvoCPLMEYuuFUcNZ9ycSdK9EJNYxuZqG3qxFkyUIDBO8X6tk8FKWJ0C4S4+vwr5NtvnZBmHgqvPxP6xipANBkY7QCX0YAWWwYckFsEuBarDBgrQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7bfa8a-b31c-4e01-9c6d-08db72f94105
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:18:26.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPJ5+R3w5AYKuXEl7M5vJKelxGUqs/B4CuSmiB4VJjXuLdIvT1e+0LReZUBpMOMiCgiCkPYZx9RHVIky6fOaSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=879 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220068
X-Proofpoint-GUID: frA7iaisYEqqVgzHCDTo0wOnh3aCEbaZ
X-Proofpoint-ORIG-GUID: frA7iaisYEqqVgzHCDTo0wOnh3aCEbaZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
 Works on David's comments regarding function names.
 Also use /proc/config.gz to verify ACL support and
 merging individual test case fixes into a single patch.


Btrfs ACL support is a compiling time optional feature, instead of
failing the test cases, let them say notrun. This set fixes it.

Patch 1/2 is preparatory adds helper to check for btrfs acl support.
Patches 2/2 are actual fixes.

Thanks.

Anand Jain (2):
  btrfs-progs: tests: add helper check_kernel_support_acl
  btrfs-progs: tests: check for btrfs ACL support

 tests/common                                   | 18 ++++++++++++++++++
 tests/convert-tests/001-ext2-basic/test.sh     |  1 +
 tests/convert-tests/003-ext4-basic/test.sh     |  1 +
 .../005-delete-all-rollback/test.sh            |  1 +
 .../006-large-hole-extent/test.sh              |  1 +
 .../057-btrfstune-free-space-tree/test.sh      |  1 +
 6 files changed, 23 insertions(+)

-- 
2.39.3

