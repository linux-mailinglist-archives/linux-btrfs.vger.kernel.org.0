Return-Path: <linux-btrfs+bounces-1370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD03829F1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C5A1C22A8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DE4E1C9;
	Wed, 10 Jan 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CPUcsXZW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zPfJ4yJp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B34E1C3
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AF44t4023943;
	Wed, 10 Jan 2024 17:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9VEOn9VQyWBNhcXS9XfVIvLMsPtbdW1Ji2jWqlAIWMw=;
 b=CPUcsXZWP2miFtz2Vj5/58gAVzSWA2hS2a2BNXLyWNxAMQWoQAXTRfKaiJDaTKmO+pOi
 +1oyx75qEfFRyMnxI8ZGGKm5Jb+2qgu8xDueTdz34uSVX5yz1X50Vv5vzHP3AmhXxTJE
 XilOxL4MPM5/lVOfaC2Jk/CeF7xETTwT3KFuDlFJ4n9WTrLzM6L1wG4dOIKMnVeDb9lM
 PYOhVA41Ojr1yhVq+tH9ll+1iJWZh2SzR64vCVwo6BTWVbFZHIGjPKJWa3kPM2d5jQss
 ecO7P0TwC7y2+4qruMAkFprw97n5w1hC0qSC9MBjMDNf0ghfwJCneKtSMf09bq2VUAPX FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhpg7h957-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:25:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AGYeJ1012167;
	Wed, 10 Jan 2024 17:25:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwjqdwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 17:25:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IquwWnE3IwAiqinP+04X135FMYUeMVxj2cmzzT4qhAoI6whTXzJ9Y6dJ+Wqhi4+vrGBoizzv+n6FfBOqLqkayxlPCMe0dAL7B3nVubMW3+S8sV6e7ctap1FyYeeuyZ+jzsga6fNAegYwvaLSeAPVh2XZIwx5KoaLFyAOCzNKANazKx0pep0n6n1cYsrEXCg0bn9nJgwGAT+lwSXuj1UWaBzlw7xnwXwGvhpmF9DDaYPSQvnzhzrEDOFiD6WKK0v3Cpwi4/HUgTCIn3/gr3ZVxYpwe1j7k3iwsEpJVCzOGv9MCvNN5WLWC3sBqH/r2xa27tWXMNmbAlsrOqaEJ0tvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VEOn9VQyWBNhcXS9XfVIvLMsPtbdW1Ji2jWqlAIWMw=;
 b=V9OltJeODZOodH5KgGDSYo4FKDmpW5rlFnpSTU21sYRsOhHEu/CI/iBDgXbppDIzsNP39DhbIm9UUNdKtzfu9qL0nsUSvKHsxm4lnoMYyW3Bc7li+JEDoImMWO6akuDDljquz8qbY+4Y4lt7bWwlYL8vjU/vr+0uayicaDs1BIfacw80DHG9Hq+vDUqYXGJQgcjjJmS3fj3SuSrrONm+LZuRUbMYvxma/1dLrUNed5q0WeN5ucHbPxsO6oLFnW7cvX/6972CAu5ZKGpeI2wvSvRvh8DIPuLuFaKgOj3qKhWwVQS/NIHC9EHCLKOVlX3Ivsj0pUybHAsgYI8iap2YRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VEOn9VQyWBNhcXS9XfVIvLMsPtbdW1Ji2jWqlAIWMw=;
 b=zPfJ4yJpcyKW2vC4NdoxU6gkrpr/aKTMNq3Bv6z6eJcriXr6kh1At/AKKRYPmmcHC3P6xqd4viWu5l2qq5LwiO+EPzZ2g4Cya58cEnQ2BDwTMJGgOZ7Di+SFRDom1jMUVuE3PQlBkLAcmM74gcs0C8F0JCA+io65tZuRgy0/2nU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:25:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:25:29 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com
Subject: [PATCH v2 0/2] btrfs-progs: Documentation: fix compile an error and
Date: Wed, 10 Jan 2024 22:55:21 +0530
Message-Id: <cover.1704906806.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: f80e39e6-6a42-4eac-3145-08dc1201248a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5guCh/j2jpghCs2eKzWPs9Epfuf+zSq05kP3omWOSD7q+9Pf3yatidOSsPQVOFL/Duopqaa7U43zj0lypf9ARXAFZyUcUPwflIOHth1lifySvMPndZgpejuWumoujh39VBcYdMZX8HW93oDvJqCLdNU3uJcpboEzTuAlkvIz1hEXgKaPPCQDLL7/E0dv9ICskqI60Z+FTkYzyOo83H5StWs/BA9mD3rFmIUCbJm5iSvLFEO+kl0VpbVIAbpBFzW07qz4rIO/toMqG7A+F0sNjj/c4TxB8uGtWkXWTvZBBGsvYWHpVHrn2x0shYyCQ8wdE4cGsp0LjUiaf50FeY/Fv639Z223fOOAX5W+bLg8dC/9MH2cqA6Zcy5aicgjzpke14Fv5rJMclQPwpzyXoXraKCJZ9o6IoOjXtqtRQc1tjIw4iwhAUbs4HyexQZfedBRULHT+yU67c3H2ZIw5t23kLJgpBKeGF+KP2sX72fVP70P6qEhBHFVPn095SNH9V2RnUyXGv1ySzeVyYF57g85acca84ECRSv2CbXURIHnBZtlD2yXj67PvrdPxvWD/XikAwOu+VfF7x/Xm4m5y7Ctn+WSeDzY3nIxf9rHslAdLcE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(2906002)(966005)(5660300002)(6666004)(478600001)(4744005)(4326008)(44832011)(8936002)(316002)(66476007)(66946007)(66556008)(6916009)(36756003)(41300700001)(6512007)(2616005)(6486002)(8676002)(6506007)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YO3P9HjAPKmnUjXXnFJLWtyCG1rvQY/iYKuFDoTziWZXwRTHHB7rcptVweWJ?=
 =?us-ascii?Q?GzF6+UEpaSjpz19GmYf04c5BpYNNp10L4nGWwrDaSUMM2VUy0K8e7etKebli?=
 =?us-ascii?Q?OVBh6RJ5RbWHZkYwjAGjOrn2Fkcp1QuADRiImpLJoMjhld/yJv+d317OsyLH?=
 =?us-ascii?Q?/Pb3dpDTGAd6iCsZWPv4K45WNaCrE2+J1EnmL7gA5f125L+m9NyCrTveLQ1K?=
 =?us-ascii?Q?3kFCaG/MCaoU6B2Tba8JJRwcJmgLB8cPzpqN9NC6WMW0ysjaRfrwPal33LCT?=
 =?us-ascii?Q?IdqtHkwaxXuWNVcC+cZ0lpgnijZ6y++Omzk37ZE0Vn1VLOSlOxORBklDVkfd?=
 =?us-ascii?Q?CqOeadVymgkdlpeWWFwQr0jvUJpvuYBv/MbQZ1yrsaixEi1F47Ss1hf7wdx6?=
 =?us-ascii?Q?GRAweH++29KBVvATAc7r0tI8G0tEw59yQtC0u9byBZh5DwPNKM0IcBBHqp9O?=
 =?us-ascii?Q?5hxwX6RKjlQ8G+mSDeYer17FvdV06uL28A+NCjK76ApyFrvUPKAu5U8c0AnW?=
 =?us-ascii?Q?GJ4yziKAWwLK9fNSdD5RbLivJcPcj0CaWQy3NGkQ8sEHdgoKd/isT+7V3YBe?=
 =?us-ascii?Q?Uj4LhjeUcz0WpFNGzZqB8mhqN4U/KCixPf8Sw/410OmTgZOPKwyj3TvZKxFb?=
 =?us-ascii?Q?D0ZYPa1HTaELw+/Ka/1pQzFGcnqxNdQUGjpNgDGs8EHaLI0QdnI6ibyFXn7i?=
 =?us-ascii?Q?7xlHQN7YxNjTGkcQFEfrodxqP9a297mpXgD/k0p+Uc8xhWWx3S3Le1kT/fHG?=
 =?us-ascii?Q?AltBPqBecQ1pmbDJ/HsoehZqrumYcD8SBrSyR+K0Ce/qpkbNpl4U4JZnyCto?=
 =?us-ascii?Q?r5DT88/6rtu0DCyslwFErvx2dhKF94CxwQ8ZueB9Hw0nNaPYRlL9REWThn7o?=
 =?us-ascii?Q?qo9JJlKgfWQuZEewdrhZtqRHM3rw00UJ2KCLJ0ubNFEjQ3XGZMpWGVi01U6V?=
 =?us-ascii?Q?nX7HeBDUo7g/QFdQOSOqPsvzhCdoAinq6iddxeqCcjSjln1ENb/BtN1RwkEa?=
 =?us-ascii?Q?E0qYihmG9D6axG1KQ9zVulK9LCfKiZ8/qsWR6Tl4uKiUfu2/5hYZo1ksZhvU?=
 =?us-ascii?Q?ozTmaX++cUjEDvgfm5js4P+LatXr/0kNb25uxY4PQ7RyKtfJiyZ7RsTveedr?=
 =?us-ascii?Q?uYCISd7Q3I/f9SvmjNjIscIw0TBUEh+2Ikvex28xMreWw9uQ0WIH55Sgm46m?=
 =?us-ascii?Q?mv2MqK7qEIe+ikG4q8QwQGT8zkVZf9HlXAslKJB0PBG/Hc6N5SztF1J4jE9b?=
 =?us-ascii?Q?x3G6N1G1g1LO6Spi76g2DdeQEs9E8Jm3TE1dmJCeMHFpedLs0nDteO13U9ma?=
 =?us-ascii?Q?djKbgRpD4vxXTQSFNlFqbes2PmhDX04zD5foMBhNWY70B/WTQTQlQZIGrZkm?=
 =?us-ascii?Q?WFrofrBFJdmj3HEHn+axaPIcPDYJrsDMjhzkA5TdRb3pC0SOa2bAGnmPIrtH?=
 =?us-ascii?Q?NNqVNfSu+2rozlclHMNITnDmyQ9BKFiXdFt1fzzXRTzKMOkW/TUTbkfkpKxa?=
 =?us-ascii?Q?OhQBU7ZC/nmGYBcVinU4gtcV148ECVtu2BzCsMy6HcUaZhYlvHdb8xA+Ka1t?=
 =?us-ascii?Q?xpRqpsLjm+4pQmaY167OWOrDVDn+w7pPyxfMJpjY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ySUlmmai5xNLDYRoPvj/8V7GfaZS+RHFI6kFUFwiq6mLwi7t5JoIx/73RaSMiW3wS/x/R5cVqmK3RbJhwFoRD4sE7RnF1UUCsTZJYKv8qXAU23gjZ1kswEx5vPYirNmnONz+OObrulLGPgbPEheOdSWIJCNZJrm0Q3jZ2cAN1ot10QRbIPgYqXl4XUuu0YmRNRsjlYzHzJXh7t35JeFZaHENMuIOPoQUeko7iPp2aMbcII9koU6ZbxIwl1lSvwZ25Mq/CyhKaoFFLmQJOKKJMReBKgBJ8GOtPO1TpCwvUuxqv4FtgI0TquuL539wpo5spU7G7y16IyZ/uSDrOvnNrJZSbph4d4YmkeX6Y01BXq+1cTnyFhOu2c/j/+glHUB5CeRlgkCHXAWSCjGYk6YQW1utCUAUMSIHLwKqAhgyhSPCTEC5tk4d+Hil68wiGGd/eNvs/qLfUEFtItX6OxsNCtwGo+Xiwup5mx1r9KwWXESSodxJSej94Dg0bJxZcEjgEki5wr+NisCqyZURd+W/3sv5JQ/wtz33tPxtNQXH2Fj42B4HCeIekyK1oUaV4n8G7QEJuCl110l3tNk0e6lPCBzbV9LTFsFWZP2Ic6Zyl48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80e39e6-6a42-4eac-3145-08dc1201248a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:25:29.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVHQxi/n3Ip56oCZ7ZZX2sGitBsx+LAdXV+w/Y0wOCe3nMYDDFvw8oYHnRulPxHHbGeRuWA672TSUcjXAmxz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_08,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100140
X-Proofpoint-ORIG-GUID: zSeANYFld4bL4i207xQ14BkRiBHoYQ_y
X-Proofpoint-GUID: zSeANYFld4bL4i207xQ14BkRiBHoYQ_y


v2:
 Fix only the code-block:: without the argument and set it to none to
   match the rest of the code blocks.
 Use Documentation/Makefile.in to create the contents.rst file.
 Link to v1: https://lore.kernel.org/all/cover.1704438755.git.anand.jain@oracle.com/

Fixes a warning and an error during the build with Sphinx.

Anand Jain (2):
  btrfs-progs: Documentation: fix sphinx code-block warning
  btrfs-progs Documentation: placeholder for contents.rst file

 .gitignore                             |  1 +
 Documentation/Makefile.in              |  8 ++++++++
 Documentation/Tree-checker.rst         |  4 ++--
 Documentation/ch-subvolume-intro.rst   |  2 +-
 Documentation/dev/Developer-s-FAQ.rst  |  2 +-
 Documentation/dev/Experimental.rst     |  4 ++--
 Documentation/dev/dev-btrfs-design.rst |  8 ++++----
 Documentation/trouble-index.rst        | 16 ++++++++--------
 Makefile                               |  7 +++++++
 9 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.31.1


