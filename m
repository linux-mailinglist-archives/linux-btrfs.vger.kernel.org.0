Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC473F7D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjF0IyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 04:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjF0Ix7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 04:53:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F710B8
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 01:53:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8DqtB021791
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=OOdOXskmlhqOWVQ1qbGyzQ9ajpQ7At0RCzzoV8Ecn/0=;
 b=tyxBV1afyomplus0oYxCPvHT+yZluESAYe0U6Nk2QxS7PTwmT7nQBem61I1H9q7LSDJn
 Ziz7w6G8PvigyhpkJAbtTKUi5Mgg8uA4m8INlm6Xs2E/VZA2GUb4V/QDcETsflVqjSvk
 8lfjiXasTxq0k3mQRC6eirUkmFJ7T4B2V/xV0nSMy4OKybWMkibyJTHvxbsP0LgRlLgk
 CbtMSjjDv5nqbQzK5Obb9VRSEfFbgUztsmWQye5l49LsHFj3Ox2C8pe32EaEs/xRkq9r
 2fLaYlBcP9SDRzL55Evx0ujvT8FKUFpzZyw90Orvoj0gtjyji7aPLas1f/DPXuYGSm7m jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdcgr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35R7C0Yo026361
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxaq3kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 08:53:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frKzDA2iY3rGOLmo5TYr2nlwENpk6uXzPRLpKuKStY/StyJQaFUwpj9O+oxAFIg4i+9BS50fjuKjvDpqjX0c1teTlQB1Ms7P0IjwWkDGz3vZ+5hDpjzj0bzv3iSDzXsXHouRyfQKzPGdn13uOdxJXfDgF2lVX1ik7dvMETFGZ8r3xIKFTG5FNpJ1b+mdHe/TeH/0K9B3mFkj2itH1hxQ/gOSV/NN6R8JHdAVoRk1Gg+hdxl/6wyjWM8f0SMe/uGhSpfqhwmOim1gRDvd/dIzl8jVT+j2QOdBkP5T6pj+aGPsXQXqafRme4CSomPRc3XBtxXFST2Njcb+87CarvECig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOdOXskmlhqOWVQ1qbGyzQ9ajpQ7At0RCzzoV8Ecn/0=;
 b=TGlxXkae7GnyP3jw8Gkdtgi2i2enyfDvft0JbJYmdbINhu9Es/8zhbW8krDdKLhHqAFumWR3L3tXVXY6J0qcuxQohZt7dOTM/7r6cJl0cgkKQg9s3TaRnUPUD+leON2w4KtIhYBMuDO7yF9o4h6Oq9JL7kiUhuNzD9l9R0BAY8Nfy78VvXfx0xGy9x5lEydovG/ynfNusltdJdIhZepqnbJk+9ycRphcqF8j73BmwUIoBV9BgQQHof72NBO9HNgXD8BEBssOhKQQw5DZ9YH3HH6JtywyZbvgYj0xG/q9PQOD993Pw8QT2EK7ukAKdL8lHVCZc+snU361MCMvAo9jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOdOXskmlhqOWVQ1qbGyzQ9ajpQ7At0RCzzoV8Ecn/0=;
 b=qguAkVwTcdRHZA3N7PaVmgQgHdgFyxx/iQZuQzVdngeHjBb0P0xLPXdKKAzaIDPNvnXG7Su2rYC3OH/0OG5NWfZeKmSrC0uXJbew+4Q4I/vs93lNbY7VSTQJCY4IVPoP9H2rnwp8BG+DEAeV/VFZwIclXItygRwcSZYdXIigU2k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 08:53:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 08:53:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: dump-super: fix read beyond device size
Date:   Tue, 27 Jun 2023 16:53:15 +0800
Message-Id: <6e8980b7306716ed8a71dc50868169ae96424e79.1687854248.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687854248.git.anand.jain@oracle.com>
References: <cover.1687854248.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d89f8ee-584c-4304-7f88-08db76ec06ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sP3oMasPxCc+qDBLPC7UZ5jjHAzi5B6BKF+RdtC05VlpfDfQwWNyc2zq3zGgvDQRFaoPapAEobI31SvDDEnbO8l27ZiLzFCdNq5RwZXZUhL0643ypw07aH68pG3cE0MjKhrg5DlIJi2e6HjD5kPc61fb2uWPS6eZGJtp961pyX9uMG7TjEwE3GRNmdwxuDLi4NuyU0kyt+E9+pUHIitGbvxadY1DyOfmdOfagM61I6NM0/QbbG9H60WlaZSMKodZmK74FZzBWFBM7dm1KsJedK7r2N2r8bFouv2NRPThihKTZEcLgPp79TCWu0y5qbJnKRC8+lrFnUPv5g+9JpymMfiRj3kz2fDZLaEFRtxGFZgeS1BTA/aCtTohPu436yFoiFYdCoRXXzd7tkQ/DowYD8w6qZhE7uMHlKWZvwYY0/P/bZvIufBehDgEqFR4AIDRCltzHFmzqSU7n4t4BXRPpb5gbFHbK6lT8PChXvqbvRDMskn9Qbu14sktgNZgISxHicuCflcVN1impFENV9sw72JvPKR/9NLP/yB4jLtQks5M6Eu+8xqaIzUxYkFjdleW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6486002)(38100700002)(26005)(83380400001)(2616005)(6666004)(186003)(6506007)(6512007)(41300700001)(2906002)(86362001)(478600001)(316002)(66946007)(66476007)(6916009)(66556008)(44832011)(8936002)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CTxe6AkzDoaKbkYWhtkedoUgul974IrITvvaXvyDRACsuKLg0iqR/iLk24J?=
 =?us-ascii?Q?00iIfwB4GC/TyW+gN3hPX7T0L1yJXcLu+PLKfyO3oMYgS8KdUcjNp03+w2ow?=
 =?us-ascii?Q?4GhUw6Y9T1ZPv5kzsEc0DD8DxVbzt+U2l3nifryABF5/LzLOs1BZV/IuAdJU?=
 =?us-ascii?Q?1cRG4K89s7ne5oPDpY9XuoKm0plpz6D+CFfznWbrf7IRUPQYJRZGScLAl0P2?=
 =?us-ascii?Q?l7KQZ3xKP3pLNs1+czeARNj4qx8gmb+CsHmyX05Wuk0httANLGx/nCjXsNqr?=
 =?us-ascii?Q?RR7zkVcVC6gYqdHRu07xzucS9T/MnQeNQr5OlnYYbPKq6h1J2CablzGnEL0D?=
 =?us-ascii?Q?Fa/EYfGJdXy+aVK7d12Ymobm+sB7SnL8gGbGMzsXreZdLTHuMJ3/Z1MNwKVD?=
 =?us-ascii?Q?oRkDYwWOpB/I13yApzMEWpk3ffS+pivB2+amjtWpS9yDs3dExawNkFL/SN6O?=
 =?us-ascii?Q?LOcIMR9Gtcw+NDqQXBoyiNU3LYXzLikh9c7OCSOpme81STWRMMWhyTmTS9Cl?=
 =?us-ascii?Q?OQppI9RIeyI1LShKbRwDsWDDTCC/t80QU+v+0zoPKM5gKhb1e+VvSaRFJYnY?=
 =?us-ascii?Q?yGPHz4P3Y70N9qIPWfGNpxSQ+D1YqcrrHpPekjxd0EeXdCC19mW4J9Rg0LTe?=
 =?us-ascii?Q?rle8BCCloee23w74z+m5KYUeM+bBTj7iJcbucdqTdtEV9MwlfXh1jAhwOJCV?=
 =?us-ascii?Q?+5QTRyqmLGlaNasGO5jaSbidX675d+VXTUno0C/V5BalusaYQneQwLENdtEP?=
 =?us-ascii?Q?ssYpytHN0J383+Fsp1mbXzaGGAzVXgyY0onMmj6hLJAkkFik5BarMA0LXo6i?=
 =?us-ascii?Q?O8T3499aPEFm7q3KPpW5A4DmczegpXrNy/g+B/Zf+mDqgGEnzk0wTtiAZTun?=
 =?us-ascii?Q?vTnl0U0rvi3mWbJbEl1EF/2C0lG6JN4JBKSzlSwoq9IUT8ZYPA8cwCRJy2uZ?=
 =?us-ascii?Q?o+gMVfv5dwCG20Xs8J48LSnEbPxPYewDlOzcjWXZVpXtVfotogFW0JbSC/Sl?=
 =?us-ascii?Q?R/bDV4oXcuyDDZmo53CU2y58EjopgwunQ7ylOPFXQKj3M8nCk3IqVQ6Fp8f2?=
 =?us-ascii?Q?4fSpUSiWb5qHYoO5e9GGgpxcrVdTXCor+yAYUc357Wm9OBlTCUFYopoc7CTR?=
 =?us-ascii?Q?M1HZAKdeYfb1DKNVQkVp+njxQ3qa8jzvrmOpT51UBlQQpIkfzsUfQy22jdMn?=
 =?us-ascii?Q?ZXzqGi3TpxkDL9uknTj7nPfrlszD57yVRQuyeVLMa+hS5oBv/ZnzRDtQZBNu?=
 =?us-ascii?Q?Wqd4L7fFBQBR5Zx/Eq8S7OXBFHRMvLo3/lPc3HCiYBIaHDH/Sx9zRAIPQ9Jz?=
 =?us-ascii?Q?CgJxkDqzpWflOtuiL0Z4E3AOwePlUntlfLzmc5gPx7URl0Cumv06hyxB25vt?=
 =?us-ascii?Q?OJ5X3O5SKpPjRWJrncemlwYTMEepMnxwO6XxXCcYpFDBqGvVnX2nsZFP1/Fz?=
 =?us-ascii?Q?Fok3iU9HlxiNLUA7G+Bo+XE+evfhjdNR+Z/Mza9Eg1ZIKgTYXEWaNEYbnZK6?=
 =?us-ascii?Q?ZUXMpbpMwlN4IRXyjouf95WuAr5diIA1hnhwQoV1yHnx9Q8iv2yA5Mp9JAfI?=
 =?us-ascii?Q?ag7KsDpPxJY9y/9t9OC5oGxObutHnmE569hUptdw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SKcBLeSFvSOh53PqoWBEOdibHgRsMvKlaiyuhLpZuxSQxZS5oze+Qhkvx20rVl7xiDn2DXdQ8+/ipBHgeesFvVLH0kucQ/KMoFM6k3kiiGc1juHvSz5nTc5mPqwz9il0PZvRQS0JtSy8XHpd72G8YFtURu64/9JuIKkh78gPvHf0vUd5tQqiJqd+v/oW/RPdrngSGhcY2q4N9/BDgn4r8U0Gsp3CTeS/c0gQUbuVtovgZwuIF2HbmzaKDxOY0pf4dvKpeE7LM6J7H4xPkTXa8m/ZA1992IICxs1aUJ1dQhiDZELKv4ZeQXMHKpbS46IbGlX6VILbznKraZrcC1C6Yd5hNg+ryPN3uALZh8kFBn1CQ0BNsPsnkfLzMDve2UUzDDTYwyt+p668Zvt0eJcuKH/XI8TS3dVCE+vTz6iQoIC9DD8GNKKdS2JU2NzR2NVQx/Qki9XAEYBdcq+ZDdJgpOOBO7oyzh48vPSZSvUB/KfdTYHYkM4ujWpWuAmRE0ZH+ZYjTmu7OfkOPSWHWLt2LutPl+ZX7y+VaOIN62Xy1Hf8iJbbsy/878aepEqqck24Rp7ASvgahpBQ3xYUkd8KGlO8xexZifSHLbav11cU74/M+La0bM0+mM1UBhTN+K7/6hyuM1Rxq+1InxxBe5K+emQK3K7rrSPe4YI7pwg1v0aj/AZTXJQb1LQgIlLfrarZgvEmsFVkxxKcqkRp1PY7WDNwtl3nVtAZvt1T0oBeIn4q6nUB8L46fUBjdu1I8XLbUg4OT/O1ntFM3CPDyBfSew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d89f8ee-584c-4304-7f88-08db76ec06ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 08:53:50.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfgLzLNWXDVyepSgiyJiK+1v/6wicP7isR48JmknoeIELcO/IHy9daqLYy4jIfIVNiuStQl4wCRmic+CeJaImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270084
X-Proofpoint-GUID: 6Trpm4K35uJk6QziiIEDfb8sDP0c2u4w
X-Proofpoint-ORIG-GUID: 6Trpm4K35uJk6QziiIEDfb8sDP0c2u4w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
failing because the command 'btrfs inspect dump-super -a <dev>' reports
an error when it attempts to read beyond the disk/file-image size.

      $ btrfs inspect dump-super -a /dev/vdb12
      <snap>
      ERROR: Failed to read the superblock on /dev/vdb12 at 274877906944
      ERROR: Error = 'No such file or directory', errno = 2

And btrfs/184 also fails, as it uses -s 2 option to dump the last super
block.

	$ ./check btrfs/184
	FSTYP         -- btrfs
	PLATFORM      -- Linux/aarch64 a4k 6.4.0-rc7+ #7 SMP PREEMPT Sat Jun 24 02:47:24 EDT 2023
	MKFS_OPTIONS  -- /dev/vdb2
	MOUNT_OPTIONS -- /dev/vdb2 /mnt/scratch

	btrfs/184 1s ... [failed, exit status 1]- output mismatch (see /Volumes/ws/xfstests-dev/results//btrfs/184.out.bad)
	    --- tests/btrfs/184.out    2020-03-03 00:26:40.172081468 -0500
	    +++ /Volumes/ws/xfstests-dev/results//btrfs/184.out.bad    2023-06-24 05:54:40.868210737 -0400
	    @@ -1,2 +1,3 @@
	     QA output created by 184
	    -Silence is golden
	    +Deleted dev superblocks not scratched
	    +(see /Volumes/ws/xfstests-dev/results//btrfs/184.full for details)
	    ...
	    (Run 'diff -u /Volumes/ws/xfstests-dev/tests/btrfs/184.out /Volumes/ws/xfstests-dev/results//btrfs/184.out.bad'  to see the entire diff)
	Ran: btrfs/184
	Failures: btrfs/184
	Failed 1 of 1 tests

This is because `pread()` behaves differently on aarch64 and sets
`errno = 2` instead of the usual `errno = 0`.

To fix check if the sb offset is beyond the device size or regular file
size and skip the corresponding sbread().

Also, move putchar('\n') after a successful call to load_and_dump_sb() to
the load_and_dump_sb() itself.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-super.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index f32c67fd5c4d..a1c3dcd9d90b 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -20,6 +20,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <getopt.h>
+#include <sys/stat.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/print-tree.h"
@@ -33,8 +34,27 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		int force)
 {
 	struct btrfs_super_block sb;
+	struct stat st;
 	u64 ret;
 
+	if (fstat(fd, &st)) {
+		error("error = '%m', errno = %d", errno);
+		return 1;
+	}
+
+	if (S_ISBLK(st.st_mode) || S_ISREG(st.st_mode)) {
+		off_t last_byte;
+
+		last_byte = lseek(fd, 0, SEEK_END);
+		if (last_byte == -1) {
+			error("error = '%m', errno = %d", errno);
+			return 1;
+		}
+
+		if (sb_bytenr > last_byte)
+			return 0;
+	}
+
 	ret = sbread(fd, &sb, sb_bytenr);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		/* check if the disk if too short for further superblock */
@@ -54,6 +74,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		return 1;
 	}
 	btrfs_print_superblock(&sb, full);
+	putchar('\n');
 	return 0;
 }
 
@@ -168,15 +189,12 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 					close(fd);
 					return 1;
 				}
-
-				putchar('\n');
 			}
 		} else {
 			if (load_and_dump_sb(filename, fd, sb_bytenr, full, force)) {
 				close(fd);
 				return 1;
 			}
-			putchar('\n');
 		}
 		close(fd);
 	}
-- 
2.39.3

