Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D523E44F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 13:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhHILdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 07:33:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54476 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234991AbhHILdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 07:33:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179BQwIc018592;
        Mon, 9 Aug 2021 11:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=MRKcTS8Q6D+1Tq/M6rl2d5MAiZvNej3d0NazFxWLpoU=;
 b=bXgUKvaEWe7IMTu+iuzDxO4dBiiwxx2hfElbayoIg9EJCx8/FwG9SdI30g7zdJkbGCwf
 5lyfMsgZZWRrj6oRFcff702GQUnYiee5gd0C1FNQg7CnjR5eJPwj1SI4aWhI1C9L7cIb
 O4VnDXhpv0wkI12wJ90XuahW7vPud86a6aE2B6eoG0Hs75q0VEmKKJWRh+sMBFuZwQnE
 J+Y1Cn67Ifq5roiI3Ehm4vJfYF9AcF3QHs+l4C2oU4W036QPAKHrWcHVms2jjvYUbBrI
 oCz2xeIuIEDQlzzevZjxjuoCO3fkUTMlxlLik7JqQ1d9bEe7zj+ZuSMYO5O0l8XmmE9a 2g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=MRKcTS8Q6D+1Tq/M6rl2d5MAiZvNej3d0NazFxWLpoU=;
 b=IxhjAOrP4fuJnuZOTSDyHrq/OSadsdCUedGzDRWiUrada/nwJM5DMoeCsdOMTcSMFdnp
 +w4ZNNL51BnjGjQlwpINRlsTb6O+v6M64PygWTVCV5WRyjCGLKt2bk2ieHZ8gSRowTvs
 Bf+FxNgOnWJCF0bUHATsP64xDCRA7Jw2iIKfdOaY7ah9I1bcM+24GqZJHW+zZ4ZtXPUE
 MHLtDVJO0SLd8NazRvANcnZ3S2ZPh0kGHKBPHSfFIvvVnFLEKTJpsHGYh1khXNGiG5pk
 /w6hO+f65sblxE5z2OaJF5EI1ABmDx1UeNwNLFqI0ZgLGNyrZZvTdmnkFAkrAkBHPLtG nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dr9w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 11:32:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179BU6eB021277;
        Mon, 9 Aug 2021 11:32:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3a9f9uw50a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 11:32:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEoBYomJtVpqMWJWycO94g5AOo5nUunoxV+xc1htix2Gu9OMDqKNeP7V3KfXyVL3EUmWztjXHYF4VoT4ZtLS4eYqYCdkzRZ2DhGZ2DsB9Mwzuy8JKjbJScyz0WoGSH4zH++u1uS+t39hEarXibCs/TYSSHl/qK1VjxIkl4G5yuNlFIO2Uv5ozUmx6nw9XW39my0OeXOPLvwgPxnop4ocAnVGmzfHBghYOp0AMcxxJ/DsuA9s05XijSru+LTc+Uu152UNKUjSKGmOr5mFf8bkRBoU3A0CEy+1Q4OXMEEY/tpOrA6od9wzKTTjFur/BAhx/wiWSg9TZ8sRw4O12kiTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRKcTS8Q6D+1Tq/M6rl2d5MAiZvNej3d0NazFxWLpoU=;
 b=QIpyviytUUBS7pw8rkrDZXJaB+b741XzDF4T8ltB1GqkIlKKJbsr6xduuAsO8rMx5qUxRYHoWJkOmiynjYbIE6NHVetBhwnt8J7fQBbBV/Woj+ch5tjMES/wkittifjpmtMulytqb4Ur37GBAkOAP5MYqH2KdQW2JnMw57hRi1bYWPZeKTdyFmAS/hseVyH0yP+Q1qpqJdv2+2mskyTc6dzxogXyqX30tPfcLdyTCsRPcDHFlPbKKfRcl93rj+EdGcbAiC7nzSkAMeSW6zoqypSRbwZxzhMK4E3UIQosN0pLnD0xJIFrp2W4Xxz5hdERsiLYPH44RsHbhJyWXZW5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRKcTS8Q6D+1Tq/M6rl2d5MAiZvNej3d0NazFxWLpoU=;
 b=fdMyGHLyDUexXpbHqqx5OAPkMJEme1ihFXEuOkX78rAtl5MXBWwMh45zK1XguKw4cVAnyX2AwNXFLUUYpg1MhtDdEqP/rzziWBjCsZ344QbzBz3HzBViXD/tfKGWqdRaPfqn+xdOP6hdfgzYqAurFAbzEGnYfvsynz7FK0JmCrM=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 11:32:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 11:32:48 +0000
Date:   Mon, 9 Aug 2021 14:32:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org
Subject: Re: [PATCH v5 09/11] btrfs: defrag: use defrag_one_cluster() to
 implement btrfs_defrag_file()
Message-ID: <202108070109.1tqb3qPy-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081242.257996-10-wqu@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Mon, 9 Aug 2021 11:32:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778698f6-778a-4649-0883-08d95b296a33
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44490A448246F538D1C80D2E8EF69@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khdzW5K60ZX+LVSn0zg/2R4pKmjejnBDSzHaZs1DDuZY/3jSfQptgekhoFquo2G91XCqOA40NHnj4/GnTriRIrrD7AE5e25fACZ5xVHb1SifAhTu+t7XTzPem/+jl04sltLknhcIQ/Mv0icSpp1fcLhg8vS2IRpnCl3fTRcf5eiumEtDhtvbsdiAZLt5A/QTIiE4moOuDi+PFa96S6WRJtkpyVFm1p+wqgMpNY1APoGTemtMg/kGSOhy0aaNSNBd7hK4GZVUh4MOUbQIvUtEMtsuWVqqaoCvh4eWlAVHtuZzIWepF3ZlM0zXYe25nZ7o4ZiEv45hH4Np2iK5NmQhvGCJkzOjsoS4jkPdfjoShdFpXAGTd/Te+tfIq69Vxv7bBuYAfRy0ZR+0L67rgLfWw/gNrZmm0amJugbdnSDHW24Q5eBIDv9mKTPRbMF3WTFsGztqb3KR6Hpd5TzFyZ6C3LgkmTQ+ICENszcpFuOpD4AknQbb3Zh2lORUpdpGDoEpgAkBBpodq80HnIFkghpFGoOGpTC+7H7b31zkhcmpCneXSlUsdpPd9yWPXtcGbSEZg6EFLc0YiNCAbUMJFG7NMJji5hYRQG9eafPuIAEQ3G0k6r68mOnjOY9AgcGDE7XXjwnUJwXcuL5LR/expWWWn+Uvr+6eaPoA4ctXmO7+PQkLj3wcWCP8t7zW1pWE3Zw5mqnIP1ff/ePKpASVAfDOwAHdxHNAkmhFt3hRhsK7stra1ge68VHCgBWVlPeWD+u3ZX/UxWL+VxV4T+ssa3dtP/OGoHyrYP3zTUIohJuNDxtaY7VxmjTt9uSWwLmLwTHB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4001150100001)(44832011)(6666004)(6486002)(5660300002)(36756003)(52116002)(38350700002)(4326008)(38100700002)(86362001)(956004)(66556008)(66476007)(316002)(66946007)(26005)(2906002)(9686003)(1076003)(8676002)(8936002)(6496006)(83380400001)(508600001)(966005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vefbsM085mGuJtfDFO5CHC0uB9BlLF2dXLSJiW+YTwp4m0PQTw/3DaiaAqKu?=
 =?us-ascii?Q?B86+jpUrwtahU9mYeSQyMY+VtPvEk2cXSeELlq/F4325j1EHon3jvHlRGDQx?=
 =?us-ascii?Q?cczn9eWqFGT4x/247BKSfuF4brJItXmn8uFuJ3mF2NwhADSVR0DmegTzi5GC?=
 =?us-ascii?Q?IKAqAeoixj8OKkJMCg0rQMWECcZKf687SvlfsjPNWTtRd5qjovshsPvmC4o7?=
 =?us-ascii?Q?16Ocz/D9gGXEpl20niGg/ReN6ZMZ9SZkdYVKL2Hg9nDAjkxvCKbWpm5yuIyI?=
 =?us-ascii?Q?ADkZ5uSHJDzhcbYyiJgCh85whUn9Y86XWQZVU512jrv/YYKwIGzfJh/7mfZy?=
 =?us-ascii?Q?dR9Z8B6taLstAliYQ37YA7Thww/KsReBs39LI8/S+P0WaqddnfKTZM8wKN8h?=
 =?us-ascii?Q?LsW2kzEsDwKcmnSJbLvlpmyMOqcj8MRRGlhzF+UNdUUxZw0mCplZjdlIW1EQ?=
 =?us-ascii?Q?NOECR/ZjEhlKLnNqhPCpOJfgHx8vAOT2cq/uvOj6npJvJQDB5D4x6PQPG2aQ?=
 =?us-ascii?Q?LMet0sFHwgEK8yGA4Qvgw5x32I+DEdJlVkswnp6QlkmX5lzRa1YFjvvWNahu?=
 =?us-ascii?Q?FFm9e75G3W8d1XYSbB30YpZFtABuAq1H3jh5dQWHDdNProKaAFHiQEFLDjDw?=
 =?us-ascii?Q?dgUHnaqQZJ5Zxf42Vfl6vRwy1vostcY/0O5p0ZojpHLEF7twf3gAY3xPd26c?=
 =?us-ascii?Q?nP2AJoDqWClSjJ9MwmG1EatiSb1Vz2D8eZiHNx5TLu98HdiErQ1EuyfI8Hlz?=
 =?us-ascii?Q?4PkOl4AdTnSkzQ31rA67/LsoSUb5vTI6CfZgocbjI3V3ZId6WzK1C+5PYhuZ?=
 =?us-ascii?Q?KhCjijLrvLvh+xCPIKzWYv80KbN96jeyJd0aQ9XqQgDcQGhSQwW569OnrsWr?=
 =?us-ascii?Q?zB74KQVpZ6gi8FTyzyPTwL12eHEg5OxZNCkzEXfWJjjsbRUGzHNbcIz66QQp?=
 =?us-ascii?Q?PnkPgW2Znt2A41rlopSrChjG1kcoX0M62L9WjdKsjF16nG/e+q/XuP6SQAqn?=
 =?us-ascii?Q?ee/3JLkep6BEwQS5GIfgIBrnz6Rac7TNuGJhDAW1heUp36AyJYrD1fAM+Xau?=
 =?us-ascii?Q?dC3c3Gt2XILBKt8+QjmqU0xknrAuh9oDlJiTDN0gySHbqvn+j9g6DdDM+YE6?=
 =?us-ascii?Q?gxWrFwZ7XxoRP8Z14d9U1kR0F8PfNhWUK3W4B1RKMYSzdBTU664YfDCez1G9?=
 =?us-ascii?Q?v66lDrEjRyvWfaG/Qsme59thf4twJnho/tGH2LSysAucI9Xez3RNk3+cW5cq?=
 =?us-ascii?Q?eXL31zAzgWBAA8OQ/4Lp5oRw4fqR5AvpdZ5JOl8zU6ysCFIG5XBM4+E32HEK?=
 =?us-ascii?Q?cU0194rSTdwbzunNIGNWtBwP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778698f6-778a-4649-0883-08d95b296a33
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 11:32:48.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0x0oh0hBdSqHMB13bKqjTE2yKT1rVdf1Ffh2QtUbShLY1ftEvpI8Xa/zPGp0l+SUIDCKZ5kVuD5hynvVgLDF6u34sUR7ttARM+yH10EuiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10070 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090088
X-Proofpoint-GUID: KJgRobXEi3qzQh8vACIFyoKnqJtzExD_
X-Proofpoint-ORIG-GUID: KJgRobXEi3qzQh8vACIFyoKnqJtzExD_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-defrag-rework-to-support-sector-perfect-defrag/20210806-161501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: h8300-randconfig-m031-20210804 (attached as .config)
compiler: h8300-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/ioctl.c:1869 btrfs_defrag_file() error: uninitialized symbol 'ret'.

vim +/ret +1869 fs/btrfs/ioctl.c

fe90d1614439a8 Qu Wenruo                 2021-08-06  1757  int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
4cb5300bc839b8 Chris Mason               2011-05-24  1758  		      struct btrfs_ioctl_defrag_range_args *range,
4cb5300bc839b8 Chris Mason               2011-05-24  1759  		      u64 newer_than, unsigned long max_to_defrag)
4cb5300bc839b8 Chris Mason               2011-05-24  1760  {
0b246afa62b0cf Jeff Mahoney              2016-06-22  1761  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1762  	unsigned long sectors_defragged = 0;
151a31b25e5c94 Li Zefan                  2011-09-02  1763  	u64 isize = i_size_read(inode);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1764  	u64 cur;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1765  	u64 last_byte;
1e2ef46d89ee41 David Sterba              2017-07-17  1766  	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
fe90d1614439a8 Qu Wenruo                 2021-08-06  1767  	bool ra_allocated = false;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1768  	int compress_type = BTRFS_COMPRESS_ZLIB;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1769  	int ret;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1770  	u32 extent_thresh = range->extent_thresh;
4cb5300bc839b8 Chris Mason               2011-05-24  1771  
0abd5b17249ea5 Liu Bo                    2013-04-16  1772  	if (isize == 0)
0abd5b17249ea5 Liu Bo                    2013-04-16  1773  		return 0;
0abd5b17249ea5 Liu Bo                    2013-04-16  1774  
0abd5b17249ea5 Liu Bo                    2013-04-16  1775  	if (range->start >= isize)
0abd5b17249ea5 Liu Bo                    2013-04-16  1776  		return -EINVAL;
1a419d85a76853 Li Zefan                  2010-10-25  1777  
1e2ef46d89ee41 David Sterba              2017-07-17  1778  	if (do_compress) {
ce96b7ffd11e26 Chengguang Xu             2019-10-10  1779  		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
1a419d85a76853 Li Zefan                  2010-10-25  1780  			return -EINVAL;
1a419d85a76853 Li Zefan                  2010-10-25  1781  		if (range->compress_type)
1a419d85a76853 Li Zefan                  2010-10-25  1782  			compress_type = range->compress_type;
1a419d85a76853 Li Zefan                  2010-10-25  1783  	}
f46b5a66b3316e Christoph Hellwig         2008-06-11  1784  
0abd5b17249ea5 Liu Bo                    2013-04-16  1785  	if (extent_thresh == 0)
ee22184b53c823 Byongho Lee               2015-12-15  1786  		extent_thresh = SZ_256K;
940100a4a7b78b Chris Mason               2010-03-10  1787  
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1788  	if (range->start + range->len > range->start) {
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1789  		/* Got a specific range */
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1790  		last_byte = min(isize, range->start + range->len) - 1;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1791  	} else {
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1792  		/* Defrag until file end */
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1793  		last_byte = isize - 1;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1794  	}
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1795  
4cb5300bc839b8 Chris Mason               2011-05-24  1796  	/*
fe90d1614439a8 Qu Wenruo                 2021-08-06  1797  	 * If we were not given a ra, allocate a readahead context. As
0a52d108089f33 David Sterba              2017-06-22  1798  	 * readahead is just an optimization, defrag will work without it so
0a52d108089f33 David Sterba              2017-06-22  1799  	 * we don't error out.
4cb5300bc839b8 Chris Mason               2011-05-24  1800  	 */
fe90d1614439a8 Qu Wenruo                 2021-08-06  1801  	if (!ra) {
fe90d1614439a8 Qu Wenruo                 2021-08-06  1802  		ra_allocated = true;
63e727ecd238be David Sterba              2017-06-22  1803  		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
0a52d108089f33 David Sterba              2017-06-22  1804  		if (ra)
4cb5300bc839b8 Chris Mason               2011-05-24  1805  			file_ra_state_init(ra, inode->i_mapping);
4cb5300bc839b8 Chris Mason               2011-05-24  1806  	}
4cb5300bc839b8 Chris Mason               2011-05-24  1807  
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1808  	/* Align the range */
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1809  	cur = round_down(range->start, fs_info->sectorsize);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1810  	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
4cb5300bc839b8 Chris Mason               2011-05-24  1811  
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1812  	while (cur < last_byte) {
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1813  		u64 cluster_end;
1e701a3292e25a Chris Mason               2010-03-11  1814  
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1815  		/* The cluster size 256K should always be page aligned */
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1816  		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
008873eafbc77d Li Zefan                  2011-09-02  1817  
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1818  		/* We want the cluster ends at page boundary when possible */
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1819  		cluster_end = (((cur >> PAGE_SHIFT) +
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1820  			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1821  		cluster_end = min(cluster_end, last_byte);
940100a4a7b78b Chris Mason               2010-03-10  1822  
64708539cd23b3 Josef Bacik               2021-02-10  1823  		btrfs_inode_lock(inode, 0);
eede2bf34f4fa8 Omar Sandoval             2016-11-03  1824  		if (IS_SWAPFILE(inode)) {
eede2bf34f4fa8 Omar Sandoval             2016-11-03  1825  			ret = -ETXTBSY;
64708539cd23b3 Josef Bacik               2021-02-10  1826  			btrfs_inode_unlock(inode, 0);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1827  			break;
ecb8bea87d05fd Liu Bo                    2012-03-29  1828  		}
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1829  		if (!(inode->i_sb->s_flags & SB_ACTIVE)) {
64708539cd23b3 Josef Bacik               2021-02-10  1830  			btrfs_inode_unlock(inode, 0);
4cb5300bc839b8 Chris Mason               2011-05-24  1831  			break;

Can we hit this break statement on the first iteration through the loop?

3eaa2885276fd6 Chris Mason               2008-07-24  1832  		}
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1833  		if (do_compress)
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1834  			BTRFS_I(inode)->defrag_compress = compress_type;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1835  		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1836  				cluster_end + 1 - cur, extent_thresh,
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1837  				newer_than, do_compress,
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1838  				&sectors_defragged, max_to_defrag);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1839  		btrfs_inode_unlock(inode, 0);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1840  		if (ret < 0)
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1841  			break;
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1842  		cur = cluster_end + 1;
4cb5300bc839b8 Chris Mason               2011-05-24  1843  	}
f46b5a66b3316e Christoph Hellwig         2008-06-11  1844  
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1845  	if (ra_allocated)
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1846  		kfree(ra);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1847  	if (sectors_defragged) {
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1848  		/*
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1849  		 * We have defragged some sectors, for compression case
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1850  		 * they need to be written back immediately.
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1851  		 */
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1852  		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
1e701a3292e25a Chris Mason               2010-03-11  1853  			filemap_flush(inode->i_mapping);
dec8ef90552f7b Filipe Manana             2014-03-01  1854  			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
dec8ef90552f7b Filipe Manana             2014-03-01  1855  				     &BTRFS_I(inode)->runtime_flags))
1e701a3292e25a Chris Mason               2010-03-11  1856  				filemap_flush(inode->i_mapping);
dec8ef90552f7b Filipe Manana             2014-03-01  1857  		}
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1858  		if (range->compress_type == BTRFS_COMPRESS_LZO)
0b246afa62b0cf Jeff Mahoney              2016-06-22  1859  			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1860  		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
5c1aab1dd5445e Nick Terrell              2017-08-09  1861  			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
d0b928ff1ed56a Qu Wenruo                 2021-08-06  1862  		ret = sectors_defragged;
1a419d85a76853 Li Zefan                  2010-10-25  1863  	}
1e2ef46d89ee41 David Sterba              2017-07-17  1864  	if (do_compress) {
64708539cd23b3 Josef Bacik               2021-02-10  1865  		btrfs_inode_lock(inode, 0);
eec63c65dcbeb1 David Sterba              2017-07-17  1866  		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
64708539cd23b3 Josef Bacik               2021-02-10  1867  		btrfs_inode_unlock(inode, 0);
633085c79c84c3 Filipe David Borba Manana 2013-08-16  1868  	}
940100a4a7b78b Chris Mason               2010-03-10 @1869  	return ret;
f46b5a66b3316e Christoph Hellwig         2008-06-11  1870  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

