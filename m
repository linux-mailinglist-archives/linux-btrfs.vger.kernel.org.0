Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3F53EAAB
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiFFMOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiFFMOW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 08:14:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F71900FC;
        Mon,  6 Jun 2022 05:14:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2569PS5e003670;
        Mon, 6 Jun 2022 12:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=mM4Lj4OfHImuuM514wT27LAUIOydapI2ReCVwKX4Yys=;
 b=qz5VeVZH9CtBA/MXvmBJFI9avT0HfjwmIRsxxeNLAtQU1nRn4CXLT9XFUdQlC+O61Ts9
 sjXoRf6ROaY0WFG8FkJlVSsmG36yyTwXRYtyhefoNVPfuKLJzXVpVzehVnr8si47Ma5f
 Og8CBA/I8ZgypDMyn1rPEL8kjqzFctZuU0EOEHdTDGRlCLxQvW/4meKYhpfU2k5pFsMf
 KXXrn9WZzKqD70ZEyOStgvPCfFj6cTs075CyKjeUudZGlZjVEkohFtc0hx44whC1JXHU
 Np14VXKy7JfhW5B4eKohAaga2BhyNXc+ggwfDKxp6NwZ/MxGUGhjPBl7kJBwqcST8r39 kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghexe89vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 12:12:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256C6T4R010580;
        Mon, 6 Jun 2022 12:12:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1e1yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 12:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4Z5EsZ+Ep+Q+HGbU469xeURgWlnlxB/vjWAIY/LkFtVoZmN5oDiB3XZJb3etTyGQIZqviZG+D6pC3t/fCWNUoNrMAGb+a4Ldgj6Ockh45zjqPruq/fidPLYZP8JcxhvBKjzoe+yc8DA8hHgWrrYLIqPeN/jubrNAubnCIHW6nHbUPkTRpS21xDZNQ5FwTdSs24gDaIti+efh5A9Hw374XvhdHwRSHWgrdaBytWXL1lqspn90+TVIQ9NC2CNzlytDM69oHDmiRJvI4gE8TB138iLQiirvQHYclRjMoyGvO8qWKbehcQdk/SXOBU03+Oonm6kK8SEiq5QM409tT4RRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM4Lj4OfHImuuM514wT27LAUIOydapI2ReCVwKX4Yys=;
 b=GlTxa2RmzKoWrFNqfvToCOXzspvcl7XuxuBPFmVlcUAJYpkgn6ILLR1xgmqcnAmbcsBhR2imwMw/3fXOc5fl0WP6AKd723TJYA0LJBDeztyhHeYc1UsyiQgWuTJp/yLwJXjV3VzIKwiqmDR6KciY/WFWD8DUwy+n9ow0aT5Zx15RKd2BoGSJUEG5hRX0+o2r2FVtNlgJODW4hV38njA4u6EpBLwirQnU/3KfWuZl3th0Ih4PRMdjZb2pUcivCYGPKwz6LOBS9SPMLt0TsCuAb6w32fbFGpNAkvwiueMf8Q+/mzQXailgm3elB1+JsgLLkFTda47IgckCwLhMUKJSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM4Lj4OfHImuuM514wT27LAUIOydapI2ReCVwKX4Yys=;
 b=CHXohd6dh1zIR6M8VZE4aZjSAPPSh4Ncw3Bq7mqcIhgBqsLJ/AMFE4HbQ1v75GZ7Z3a6uLp4+UtI9GvpBV29DtcCG2Gph4Hb+X5gWDqxiF+OsEAMv3J/QxnrlIKarAr0V3gYl7n+VRUMba6qPtc7VWFPIj3x3vUzWeZyFgEQkZ4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5305.namprd10.prod.outlook.com
 (2603:10b6:610:d9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 12:12:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:12:06 +0000
Date:   Mon, 6 Jun 2022 15:11:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Replace kmap() with kmap_local_page() in
 zlib.c
Message-ID: <202206030230.ttuhGnvx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531145335.13954-4-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d93ce84-0124-4d1f-5cff-08da47b5c573
X-MS-TrafficTypeDiagnostic: CH0PR10MB5305:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB53056147B987F02E79B95C728EA29@CH0PR10MB5305.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uav2j7q7qkldeD5uv/c2qBZm4fc/qhWeXPwV4O7evtqAer0+MHR5Xm8luW+zq/U0kP6Dw/ogMlnoe5iZlvRjqMqKB+/Tv4YLW+hfllAYj3+M0Sav1GkDoau4GRwXZCp5uYzs7dM7oEdm+fhSIpqVPKn5XGElr/cHxNVzqistgNWL0thwpe970i1EDzhBH9HVJ4yks+7YNmClHjsysNzBtSBPYKOsJLyESkH3ipVpDE/FaHxVnQI178Kz4euTtchiXtVt/31Hlhn5/9r+kxPaiAs9NI+EZ8CKLUhtRL55B5LOg568ofH53rg9J77VDjb7Ldgm98cY1QsRuWO6XHm6HhnlhYBx56HhnMU1U/a7MyALEk6COun2HlOSi84SKiBgtv+ATOPz0NTxJQj8TpcEN3RPmci5X9pfkQ+cGiaZb0F2QVtVpCN5QHw3IAzq/LjDuGVN3wGsZ0+6Bls/yBnGap+rOOZ3U7fQnxvDQlRbgU4DOdlbONm3ZMISBKvlNNsfl+upnu9oUM4TvVmg8oRuyZnpUdshoiXVl4WvT3ChLpROdaf9ocqbMSQm+vlqlPvalScUyj4Ztno5r2fE3lLya7ZlfOf1saoRHikWhwSWuqLeNiFkzwKMxOgoJDxpkgRu0gva7dmBYmDZQFUI4bz4rHFzRy4y1tUrcqorTfWmy7lhxFTGr+ZuU998QgxY1C48nJZVkfUbYGieXXCU9xoqjj91PpKUyV44R1llFT0uKusxRCSSQ9f/5sjdXNQv16VQBDaSFEpct2Jc5CEXAgffvtoSXH1pEMB0vs2exKBrIrMCbbBeOf6R0Rmj3WsEyEqKDnezSCPR90SDmr1PV01i4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(66556008)(66476007)(66946007)(26005)(6506007)(9686003)(8676002)(4326008)(2906002)(186003)(4001150100001)(86362001)(38100700002)(5660300002)(8936002)(1076003)(44832011)(7416002)(30864003)(83380400001)(38350700002)(110136005)(966005)(316002)(508600001)(6666004)(52116002)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mZThNMEI79Z2dFL3CjDO/fzbw47F8RY1oat5sZ3Oe3UQc4k9MRDzgPTMDaIU?=
 =?us-ascii?Q?LunYUk0cC8yxTobwJiu7jnaN7S7wl5GlYGkEKiK+AkskaJ8nVNge/sGg60Yi?=
 =?us-ascii?Q?tCwY21U7Zx2s/Ey44eANQ/1DsUpXmQz9Xb/pc3ym0yvmtn2qPrp8aiYLtJtG?=
 =?us-ascii?Q?oPu/zoUAfl8HhJn2ay8fdhP5x0xG9VW6AVk3VqiGCNB+NPufvREY/Uo6YpRu?=
 =?us-ascii?Q?m1vjcZFf2G0rvAdWHJsMsA492QRjwPMmZoZ1vNsC41x3f9pff3skx0jaegxo?=
 =?us-ascii?Q?4yUhmTYA5K7o2A5IcGdxTEHnu7xBkkkENMUPHKxOYjgTLTDmTCJa+PXVVgAT?=
 =?us-ascii?Q?tXXMWOledpv9MkPB9aCdoQ7rH5SJyf325lu/t6One8D1pZ8FG9tRYL+7UANL?=
 =?us-ascii?Q?Jw2Y2xWPzfMZDh+q+fXJyJaiFe8PjXLkuqyvCio4Q5NN+k6osr9CCoJGXsl5?=
 =?us-ascii?Q?VJ7bl3l+V96lB3P6CxRChvWWaYEJ6ptBeVRgMoTjVnRmvLTbcSYKOXP49tzA?=
 =?us-ascii?Q?dhyxzBrwLvsPOCt5/lSRo2wNXuaczzQq0aH0LPQSC7Dpt+dT3BJwp8lCsyWz?=
 =?us-ascii?Q?CFsxyrELblfMcMVNgUyi6pHFruRTCxzTNBxaVQLyqHx1WeNskbgmte1N1BMQ?=
 =?us-ascii?Q?JffnrdvTo8upOYmwT0xedrpoFe9a2aOnNUqarOU9cSwCP3b5stI9HdloOgri?=
 =?us-ascii?Q?y41NfZiRubWPYE8H3F9l2tXJMGIeK1zVSrz4+o0obDUbAlcWpb4XGhAJyJav?=
 =?us-ascii?Q?qyohyaohsAqEFPpGtPsVdbAWIKlG5FSZ9Byv40kNoTjMNauuKY6X0bo5xIhT?=
 =?us-ascii?Q?GLb0WRQ88GU0ZwlDyjyyKg3kVpcTV5nB4WzEvblXQ+sXfEf2rzTiMqjNedRM?=
 =?us-ascii?Q?TSs637FlyK7+koCq7kldWZVe30AUjafJQ7UiPUxX2rjnHJB711j2X0+q8Iyb?=
 =?us-ascii?Q?vxkZ21dxmP40/bpGkR93674zU+t5PhEYCbfw4ceNbHMLjgxx+mRz5n0Y2Ws5?=
 =?us-ascii?Q?CNjWaXrouyzcwbPeMnjkzJxuSyuObNiWC+ln6rCbU1wpJJRiP/Hif71byQGj?=
 =?us-ascii?Q?2mbDh3bYEWNK/a3q1aYKvfxNZ9tXOaaoOCUDVuA4HjqG/RwijWogdZA2cZBu?=
 =?us-ascii?Q?6ToXXgdctap0/ZSwTNbcgT/eJlAxYuJBmXEDTJlNsrw+7mLkde+kdL3KniCa?=
 =?us-ascii?Q?NqGOtNtLMlKAMZsva+eWNrlmnCZyLqW2E82Qmkcuobso+4sLKwFbKFSTLc/j?=
 =?us-ascii?Q?jhJWmoThvWowa39uF85dJPQUa2ia7NDtkOOJIctl86519j9SMElIRus9hGQw?=
 =?us-ascii?Q?81RmwnM8clxTaNqX9yuKITmKY5/sO4/eLTkfcs2UqQhxEb+vo0Tna8fI2OjU?=
 =?us-ascii?Q?YRbAp9Dhke029prztH9/ggT3hXB1DtH3dl8JwfU98lRAlHNxSU2ohcSBs1+e?=
 =?us-ascii?Q?l052yXas74SNdUhHXdTi+V4d0AdHCNEGbWvBGHTARRb6x/InfWvNRhL57L09?=
 =?us-ascii?Q?nYgR56cCCBK05OBJF0DFlL3c9U3IHNvXSOLYvclWTBmBFXW7vH3JmXVwD2vX?=
 =?us-ascii?Q?CjAy6zs7lF6FrfkD70cFzpwOvwrKWsHJF6YZqx740zoyPHWhpotMG5rkuNTq?=
 =?us-ascii?Q?EF1wFrlWR3lqyWfHkNbuVOYpnFVOhkyil4I7olIgvSCz4cqH6oz6mcrqvWDG?=
 =?us-ascii?Q?f/cA5UTLFKmUUvKqAzBbb95QkcEIFEd8uJj6qtjImg3TyNLlLGmRfhvuc+Y8?=
 =?us-ascii?Q?kYev+oB4Sn7zdV6PihFOKhdDl49aaXQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d93ce84-0124-4d1f-5cff-08da47b5c573
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:12:06.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpzRAtLc4ti19KZ9YMItG5v7gCirZsotpme7Y6FI4st9SQJfGOICRcf0/Ff4SjoyR5LvEUF8U/gbSTDpm4It0JI5rBGllmIpYNIMmuvhHCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5305
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_04:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060056
X-Proofpoint-GUID: _KLy5DdXdUf8MYFN13eyXPH4UDhDMSZy
X-Proofpoint-ORIG-GUID: _KLy5DdXdUf8MYFN13eyXPH4UDhDMSZy
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi "Fabio,

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/btrfs-Replace-kmap-with-kmap_local_page/20220531-225557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220603/202206030230.ttuhGnvx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/zlib.c:151 zlib_compress_pages() error: uninitialized symbol 'data_in'.
fs/btrfs/zlib.c:267 zlib_compress_pages() error: uninitialized symbol 'cpage_out'.

Old smatch warnings:
fs/btrfs/zlib.c:164 zlib_compress_pages() error: uninitialized symbol 'data_in'.
fs/btrfs/zlib.c:227 zlib_compress_pages() error: uninitialized symbol 'ret'.
fs/btrfs/zlib.c:270 zlib_compress_pages() error: uninitialized symbol 'data_in'.

vim +/data_in +151 fs/btrfs/zlib.c

c8b978188c9a0f Chris Mason           2008-10-29   93  
c4bf665a319755 David Sterba          2019-10-01   94  int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
c4bf665a319755 David Sterba          2019-10-01   95  		u64 start, struct page **pages, unsigned long *out_pages,
c4bf665a319755 David Sterba          2019-10-01   96  		unsigned long *total_in, unsigned long *total_out)
c8b978188c9a0f Chris Mason           2008-10-29   97  {
261507a02ccba9 Li Zefan              2010-12-17   98  	struct workspace *workspace = list_entry(ws, struct workspace, list);
c8b978188c9a0f Chris Mason           2008-10-29   99  	int ret;
c8b978188c9a0f Chris Mason           2008-10-29  100  	char *data_in;
                                                              ^^^^^^^

c8b978188c9a0f Chris Mason           2008-10-29  101  	char *cpage_out;
c8b978188c9a0f Chris Mason           2008-10-29  102  	int nr_pages = 0;
c8b978188c9a0f Chris Mason           2008-10-29  103  	struct page *in_page = NULL;
c8b978188c9a0f Chris Mason           2008-10-29  104  	struct page *out_page = NULL;
c8b978188c9a0f Chris Mason           2008-10-29  105  	unsigned long bytes_left;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  106  	unsigned int in_buf_pages;
38c31464089f63 David Sterba          2017-02-14  107  	unsigned long len = *total_out;
4d3a800ebb1299 David Sterba          2017-02-14  108  	unsigned long nr_dest_pages = *out_pages;
e5d74902362f1a David Sterba          2017-02-14  109  	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
c8b978188c9a0f Chris Mason           2008-10-29  110  
c8b978188c9a0f Chris Mason           2008-10-29  111  	*out_pages = 0;
c8b978188c9a0f Chris Mason           2008-10-29  112  	*total_out = 0;
c8b978188c9a0f Chris Mason           2008-10-29  113  	*total_in = 0;
c8b978188c9a0f Chris Mason           2008-10-29  114  
f51d2b59120ff3 David Sterba          2017-09-15  115  	if (Z_OK != zlib_deflateInit(&workspace->strm, workspace->level)) {
62e855771dacf7 Jeff Mahoney          2016-09-20  116  		pr_warn("BTRFS: deflateInit failed\n");
60e1975acb48fc Zach Brown            2014-05-09  117  		ret = -EIO;
c8b978188c9a0f Chris Mason           2008-10-29  118  		goto out;

cpage_out is not initialized before the goto.

c8b978188c9a0f Chris Mason           2008-10-29  119  	}
c8b978188c9a0f Chris Mason           2008-10-29  120  
7880991344f736 Sergey Senozhatsky    2014-07-07  121  	workspace->strm.total_in = 0;
7880991344f736 Sergey Senozhatsky    2014-07-07  122  	workspace->strm.total_out = 0;
c8b978188c9a0f Chris Mason           2008-10-29  123  
b0ee5e1ec44afd David Sterba          2021-06-14  124  	out_page = alloc_page(GFP_NOFS);
4b72029dc3fd6b Li Zefan              2010-11-09  125  	if (out_page == NULL) {
60e1975acb48fc Zach Brown            2014-05-09  126  		ret = -ENOMEM;
4b72029dc3fd6b Li Zefan              2010-11-09  127  		goto out;
4b72029dc3fd6b Li Zefan              2010-11-09  128  	}
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  129  	cpage_out = kmap_local_page(out_page);
c8b978188c9a0f Chris Mason           2008-10-29  130  	pages[0] = out_page;
c8b978188c9a0f Chris Mason           2008-10-29  131  	nr_pages = 1;
c8b978188c9a0f Chris Mason           2008-10-29  132  
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  133  	workspace->strm.next_in = workspace->buf;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  134  	workspace->strm.avail_in = 0;
7880991344f736 Sergey Senozhatsky    2014-07-07  135  	workspace->strm.next_out = cpage_out;
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  136  	workspace->strm.avail_out = PAGE_SIZE;
c8b978188c9a0f Chris Mason           2008-10-29  137  
7880991344f736 Sergey Senozhatsky    2014-07-07  138  	while (workspace->strm.total_in < len) {
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  139  		/*
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  140  		 * Get next input pages and copy the contents to
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  141  		 * the workspace buffer if required.
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  142  		 */
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  143  		if (workspace->strm.avail_in == 0) {
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  144  			bytes_left = len - workspace->strm.total_in;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  145  			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  146  					   workspace->buf_size / PAGE_SIZE);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  147  			if (in_buf_pages > 1) {
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  148  				int i;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  149  
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  150  				for (i = 0; i < in_buf_pages; i++) {
a549d3a90067e8 Fabio M. De Francesco 2022-05-31 @151  					if (data_in) {
                                                                                            ^^^^^^^
Uninitialized.

a549d3a90067e8 Fabio M. De Francesco 2022-05-31  152  						kunmap_local(data_in);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  153  						put_page(in_page);
55276e14df4324 David Sterba          2021-10-27  154  					}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  155  					in_page = find_get_page(mapping,
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  156  								start >> PAGE_SHIFT);
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  157  					data_in = kmap_local_page(in_page);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  158  					memcpy(workspace->buf + i * PAGE_SIZE,
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  159  					       data_in, PAGE_SIZE);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  160  					start += PAGE_SIZE;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  161  				}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  162  				workspace->strm.next_in = workspace->buf;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  163  			} else {
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  164  				if (data_in) {
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  165  					kunmap_local(data_in);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  166  					put_page(in_page);
55276e14df4324 David Sterba          2021-10-27  167  				}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  168  				in_page = find_get_page(mapping,
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  169  							start >> PAGE_SHIFT);
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  170  				data_in = kmap_local_page(in_page);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  171  				start += PAGE_SIZE;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  172  				workspace->strm.next_in = data_in;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  173  			}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  174  			workspace->strm.avail_in = min(bytes_left,
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  175  						       (unsigned long) workspace->buf_size);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  176  		}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  177  
7880991344f736 Sergey Senozhatsky    2014-07-07  178  		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
c8b978188c9a0f Chris Mason           2008-10-29  179  		if (ret != Z_OK) {
62e855771dacf7 Jeff Mahoney          2016-09-20  180  			pr_debug("BTRFS: deflate in loop returned %d\n",
c8b978188c9a0f Chris Mason           2008-10-29  181  			       ret);
7880991344f736 Sergey Senozhatsky    2014-07-07  182  			zlib_deflateEnd(&workspace->strm);
60e1975acb48fc Zach Brown            2014-05-09  183  			ret = -EIO;
c8b978188c9a0f Chris Mason           2008-10-29  184  			goto out;
c8b978188c9a0f Chris Mason           2008-10-29  185  		}
c8b978188c9a0f Chris Mason           2008-10-29  186  
c8b978188c9a0f Chris Mason           2008-10-29  187  		/* we're making it bigger, give up */
7880991344f736 Sergey Senozhatsky    2014-07-07  188  		if (workspace->strm.total_in > 8192 &&
7880991344f736 Sergey Senozhatsky    2014-07-07  189  		    workspace->strm.total_in <
7880991344f736 Sergey Senozhatsky    2014-07-07  190  		    workspace->strm.total_out) {
130d5b415a091e David Sterba          2014-06-20  191  			ret = -E2BIG;
c8b978188c9a0f Chris Mason           2008-10-29  192  			goto out;
c8b978188c9a0f Chris Mason           2008-10-29  193  		}
c8b978188c9a0f Chris Mason           2008-10-29  194  		/* we need another page for writing out.  Test this
c8b978188c9a0f Chris Mason           2008-10-29  195  		 * before the total_in so we will pull in a new page for
c8b978188c9a0f Chris Mason           2008-10-29  196  		 * the stream end if required
c8b978188c9a0f Chris Mason           2008-10-29  197  		 */
7880991344f736 Sergey Senozhatsky    2014-07-07  198  		if (workspace->strm.avail_out == 0) {
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  199  			kunmap_local(cpage_out);
c8b978188c9a0f Chris Mason           2008-10-29  200  			if (nr_pages == nr_dest_pages) {
c8b978188c9a0f Chris Mason           2008-10-29  201  				out_page = NULL;
60e1975acb48fc Zach Brown            2014-05-09  202  				ret = -E2BIG;
c8b978188c9a0f Chris Mason           2008-10-29  203  				goto out;
c8b978188c9a0f Chris Mason           2008-10-29  204  			}
b0ee5e1ec44afd David Sterba          2021-06-14  205  			out_page = alloc_page(GFP_NOFS);
4b72029dc3fd6b Li Zefan              2010-11-09  206  			if (out_page == NULL) {
60e1975acb48fc Zach Brown            2014-05-09  207  				ret = -ENOMEM;
4b72029dc3fd6b Li Zefan              2010-11-09  208  				goto out;
4b72029dc3fd6b Li Zefan              2010-11-09  209  			}
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  210  			cpage_out = kmap_local_page(out_page);
c8b978188c9a0f Chris Mason           2008-10-29  211  			pages[nr_pages] = out_page;
c8b978188c9a0f Chris Mason           2008-10-29  212  			nr_pages++;
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  213  			workspace->strm.avail_out = PAGE_SIZE;
7880991344f736 Sergey Senozhatsky    2014-07-07  214  			workspace->strm.next_out = cpage_out;
c8b978188c9a0f Chris Mason           2008-10-29  215  		}
c8b978188c9a0f Chris Mason           2008-10-29  216  		/* we're all done */
7880991344f736 Sergey Senozhatsky    2014-07-07  217  		if (workspace->strm.total_in >= len)
c8b978188c9a0f Chris Mason           2008-10-29  218  			break;
7880991344f736 Sergey Senozhatsky    2014-07-07  219  		if (workspace->strm.total_out > max_out)
c8b978188c9a0f Chris Mason           2008-10-29  220  			break;
c8b978188c9a0f Chris Mason           2008-10-29  221  	}
7880991344f736 Sergey Senozhatsky    2014-07-07  222  	workspace->strm.avail_in = 0;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  223  	/*
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  224  	 * Call deflate with Z_FINISH flush parameter providing more output
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  225  	 * space but no more input data, until it returns with Z_STREAM_END.
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  226  	 */
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  227  	while (ret != Z_STREAM_END) {
7880991344f736 Sergey Senozhatsky    2014-07-07  228  		ret = zlib_deflate(&workspace->strm, Z_FINISH);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  229  		if (ret == Z_STREAM_END)
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  230  			break;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  231  		if (ret != Z_OK && ret != Z_BUF_ERROR) {
7880991344f736 Sergey Senozhatsky    2014-07-07  232  			zlib_deflateEnd(&workspace->strm);
60e1975acb48fc Zach Brown            2014-05-09  233  			ret = -EIO;
c8b978188c9a0f Chris Mason           2008-10-29  234  			goto out;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  235  		} else if (workspace->strm.avail_out == 0) {
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  236  			/* get another page for the stream end */
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  237  			kunmap_local(cpage_out);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  238  			if (nr_pages == nr_dest_pages) {
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  239  				out_page = NULL;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  240  				ret = -E2BIG;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  241  				goto out;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  242  			}
b0ee5e1ec44afd David Sterba          2021-06-14  243  			out_page = alloc_page(GFP_NOFS);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  244  			if (out_page == NULL) {
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  245  				ret = -ENOMEM;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  246  				goto out;
c8b978188c9a0f Chris Mason           2008-10-29  247  			}
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  248  			cpage_out = kmap_local_page(out_page);
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  249  			pages[nr_pages] = out_page;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  250  			nr_pages++;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  251  			workspace->strm.avail_out = PAGE_SIZE;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  252  			workspace->strm.next_out = cpage_out;
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  253  		}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  254  	}
3fd396afc05fc9 Mikhail Zaslonko      2020-01-30  255  	zlib_deflateEnd(&workspace->strm);
c8b978188c9a0f Chris Mason           2008-10-29  256  
7880991344f736 Sergey Senozhatsky    2014-07-07  257  	if (workspace->strm.total_out >= workspace->strm.total_in) {
60e1975acb48fc Zach Brown            2014-05-09  258  		ret = -E2BIG;
c8b978188c9a0f Chris Mason           2008-10-29  259  		goto out;
c8b978188c9a0f Chris Mason           2008-10-29  260  	}
c8b978188c9a0f Chris Mason           2008-10-29  261  
c8b978188c9a0f Chris Mason           2008-10-29  262  	ret = 0;
7880991344f736 Sergey Senozhatsky    2014-07-07  263  	*total_out = workspace->strm.total_out;
7880991344f736 Sergey Senozhatsky    2014-07-07  264  	*total_in = workspace->strm.total_in;
c8b978188c9a0f Chris Mason           2008-10-29  265  out:
c8b978188c9a0f Chris Mason           2008-10-29  266  	*out_pages = nr_pages;
a549d3a90067e8 Fabio M. De Francesco 2022-05-31 @267  	if (cpage_out)
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  268  		kunmap_local(cpage_out);
55276e14df4324 David Sterba          2021-10-27  269  
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  270  	if (data_in) {
a549d3a90067e8 Fabio M. De Francesco 2022-05-31  271  		kunmap_local(data_in);
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  272  		put_page(in_page);
55276e14df4324 David Sterba          2021-10-27  273  	}
c8b978188c9a0f Chris Mason           2008-10-29  274  	return ret;
c8b978188c9a0f Chris Mason           2008-10-29  275  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

