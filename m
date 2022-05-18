Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E352B1B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiERE7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 00:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiERE7G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 00:59:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178B114F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 21:59:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I2V9fD008004;
        Wed, 18 May 2022 04:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=Jp2aMOFh7br6KCpCfen7w2yZVWTX+YE3UqP52GdHENw=;
 b=k+MwnDAPlC1z7iBxTSPTcCpCAY3pLzZlnkBLWt9dX5hC9R0sfTLa8fAzLQrcDSmxPuIx
 pH901o/mv92rcS/TifhAmQpTGmzaIyJmvcH0kiD7yTjL3QLUSU/Zes3lUpFixjr7A0Sm
 rXibHBU/dweJMiH9/bjKbfogtSsS867PqD28+pi5a5UoZEbX4xMY82GLDR6dphESp+Ts
 TOnR5l787eUDW97U8R/O8DmonOpGzAJFQsrb6NNYP7LoSwTxvG/EF+M+KvbtzANnY8vO
 KBH6zZW5J60/jIH17Y5r7PI9/w1ZZsPSgAa+pFdeo79elxkavIvNcFliKx1n1WOra9QM tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc7wvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 04:58:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24I4nx7U002582;
        Wed, 18 May 2022 04:58:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v9cgvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 04:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtseT6VbIGxdtG+OBbTwgGH7CQC8ZagJzyxYxbGHHDvg18U/G/MUYQ9bdWjG96Z+xTcMrRm39oJQMnlUi1Ti7X75aQjABrUDrQCb8nLlE5IEpztfqGseHiEjD/ArtU9+COk0iRAYxRNVLlqdOqMBbw7BmAtKNjwhRxVu1pqM493JZ7kWnMGpQboJfLbcVXwZoN4q5gfFA2M8Y02VOkgHTZMpJItQKN5PlXKLJlyU58UYZZC9+C9BDcRvk+PzhOMMM/pqsZ9SEpNf4VHWmZpgArPyp6hi3C0gHIdSAZxcYXyfdm/GS/TFCEf1RYu1muPmfDk4rjHeM/DebtNmoUcb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp2aMOFh7br6KCpCfen7w2yZVWTX+YE3UqP52GdHENw=;
 b=HcIeXCctb84tc6NQ00JzICIFC3Xf/Uskt4yu+DTgRlCkkP3CNgv5IvnURaIKXoku5Kxo6oslkKZaFXpUS7OZ0XrhMe+aOXwAv6lciKeNivbZjuQQjnalf0nwisXIqFq9LMwZCSHOOCG14raqRzLSnlC5tLwCquUlrcLj3zDDXtiZos0OF40YAg4C6IXpZ1a134JF4sZ/0oq5+gBYyvBCzrlDiXwW5+XfFK2ClGT5nimS9JoN0eopul7TWVUf4iiMF6tqotLfIKsVzIlNoOCsws8FPlrvUE+6WfsoQ60nLxRTe0/dMa6RbZmJd9jc7FUcw+TllcQ12TqrpvbJnbQz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp2aMOFh7br6KCpCfen7w2yZVWTX+YE3UqP52GdHENw=;
 b=TFjY5v4PNHNa8WqIBSS1YHAUWsg1tJjS91/mifLpWNYvAUoUe3dwVUo17PXWAIuLltWL/pMO2OqzBuB8hSI+5/eeTuxalbZtXylYnWaMhAVS5Mj4GdUFtoZcC9SI4suPhFwxZ1G1dQUJKOCadpql38j9rgPp/zCb7RDkEqLbk/k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1661.namprd10.prod.outlook.com
 (2603:10b6:301:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 04:58:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 04:58:54 +0000
Date:   Wed, 18 May 2022 07:58:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org
Subject: [kbuild] Re: [PATCH] btrfs: prevent remounting to v1 space cache for
 subpage mount
Message-ID: <202205172208.qdyoDwJs-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e09cf20ca9309f2b9daf57136c3e2c1b22f94f6.1652682383.git.wqu@suse.com>
Message-ID-Hash: 3I2SRHXEZ73G337KNRCGOAR4H5BEKDAV
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c652e43b-860e-493f-f6d1-08da388b1b6e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB16615F250B03F7ACCF2E43BB8ED19@MWHPR10MB1661.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfbkiDnut7V30XlO5EqVHBE29NqlnH350SCUr2VJaVRyqG7dfVQaXbgCF+/hKRuRQL6Ke4mx6KeNDWcDzW6q3UEOyGolcLrVT131tvEM8m2ktFF45LpNLe6K0b7W7nwlH3PyGEhPtR0hXQarHr5yzZ9SMkFPEvlej6yHuOaOPzlBFh0bIHFMyx3OP84dZ7HZ3vgnTLeQmvWqm/obhAJENR+ywbT/AiTSE0TxpSDcmGYX7QHCr0+1U2HOiFcr0lJjv7UJOAf8nWLpVIJzNGm2/3kFOEdBPWh8OVEQBWz0+v822I81KnyP/chJyeXdkhA2TpNR4Sx6uaPRjtNYOGO3Rnc15afDij+F1FLw48R973kSHZpWxFPscnfJXvWaQw9LT1dWXgix7ToUcxpc6sE3WUr3T4G/Tr5fix/8+i7HDUEpjB2XbjTiysX1TRcnTa9zrg0S2IQD/ipPAxnlYTmbajojT0V8wdPRtP48BHuFW4uun0P06qs3g50QyEr0lwxQXpReHKpypxTGSqXoashKAbuZMa0U/zuzmC/OeKAzKBDwO4KVG0CNO334REX6/cQysTZw9DqNXml2iAdMhCT6QffNtXJceSAqkp8M743d+GMNVSmismKs6ZVDZJ4KI37dO8wndtCELh7lKkqIiRKuyy/Q5nDF9UnCzpwFoPMn9+RfRwzfrm7TmDMV8RdEZvlCjP8N0IjkZQVY4x2L601mcl0im9OVBa/2VyWZcIP2j44UIJ7Velq8OtsJsX/ZH/4AMQoc/aomXwAT7TKgTjixA+ptMSBZzNS7sy72UDmyTfWvcw6ctQPtu7bnHo6+FjiltyaqgQEHSaRgnchfnK74rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(316002)(508600001)(966005)(4001150100001)(2906002)(4326008)(66476007)(86362001)(6666004)(66556008)(8676002)(38100700002)(38350700002)(5660300002)(186003)(9686003)(44832011)(6512007)(1076003)(66946007)(8936002)(30864003)(83380400001)(6506007)(36756003)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uaL3NY3tQnFjyh4lnXg/hd3sneyOzFQlZDcA4XOkqKx5qYqClaUaF8GfGRat?=
 =?us-ascii?Q?/pAVspnRAPuy7ISdMdC0O8Se3GSlRhd6Mskn7YjMGqK77O37e4aBe+vUc1eM?=
 =?us-ascii?Q?//XJfTOOAXfZJuNOvIwNxk8fv66u7B9DNJe7Y+jsp/RVQzmH14MNcHjGSXYR?=
 =?us-ascii?Q?qGoYAtZtzgB6/lzoT2taVStGVBdbmRJZAmdJPTpqFoIyyo9Oh6SG5I7KILLI?=
 =?us-ascii?Q?R/6/xCvjVLr2wvPR4dGszb594dP5QJgRhrK3woyD99jaknQ8R10Adl/ZRgpO?=
 =?us-ascii?Q?a6NzMz0Cgbq/dODMUwchJUkUdkcS9y39j1KIRq4K00ctj+gABWXSYxevl27e?=
 =?us-ascii?Q?zSVtR44gJZtga1ufSmhhdswZP5NeJhubtBQV02269iZXcQ8+TYHOyv8QEkFa?=
 =?us-ascii?Q?8g/YwZe5eNWuyWlPGr/z80IrpwgMT3EFRVTrbXRtr/xGX2ZT2n8vuiofQv/B?=
 =?us-ascii?Q?ebRcgpfa8xZKjzjl1MHGxfOBp3s0cIt0NHSh4Y6TvQOpIRT0ZFfHgeN8AHqH?=
 =?us-ascii?Q?v+vPVscxpp+DUNoG9MVsLcJMqiy9mtDsF5BFcHiuv+QQcb2zKC4X9R9Mr/hh?=
 =?us-ascii?Q?ibizawoJgQchwdRKIa+Awgdfeb/x3sLU0jy/ZK2+5ZjojLdUHqVaqlebP2Yj?=
 =?us-ascii?Q?XuV8MVJICYIFiQoBdKflFAwcjp+s0RTCRZC9C1anVj5++vH/plZn41+a5kg+?=
 =?us-ascii?Q?+5gE8Ha184a82+zY1DAuqJrb2Onen0vL/n0GmTGTpBRXe1gCvGm+jXgnpa7j?=
 =?us-ascii?Q?Tjf7V1+aUy2NIq92IoMrQHReh7fS4+SQWHQ7ZFDOtYnUPMKOS8Ro/FzJOgvN?=
 =?us-ascii?Q?aSf1KCo6ljovPUD0+xaxbX94Mnz8sFdyuNTnSGibzzBavCN/jZdAVG1pZpJb?=
 =?us-ascii?Q?/tk/ThFYMoEzNs7JaER+TbpC8CDvftMudCpGu7MP/HRQrAEu/QkSCjJpBVnW?=
 =?us-ascii?Q?EW/tW0xB3bPDVYYoz0idelCWs9HLTJtyLw/dkjXqyjDdGBrBKUG7zXNxwcXI?=
 =?us-ascii?Q?pHDttKr/pfJmtwKzEXp/jkYgK+CM8X7F2L0oKsMDfRH+pT4/6r7v0M/tLbIK?=
 =?us-ascii?Q?NlqOjwxyHdFzZz5vagTvYfyYQ4MkqAxSqf32hy5i8Yr2vaqIJu4D4TTEiaP+?=
 =?us-ascii?Q?9wZ6T9BKRnYFmUZTyNq3ZRTM1DyARUDmYJjyS/2IJAuLR5SrNdLubfSxECMa?=
 =?us-ascii?Q?hzE/Hpgau8vXC8BSf8vk7o5a5S9uYVXG3gRgujrjd90AsIfbSxL2QRS36NZe?=
 =?us-ascii?Q?bntVIJtVcAiPTjSRBhT4n/9/xihZqniuR6XbVGrnckNefEeBo1sVmJoZZ9he?=
 =?us-ascii?Q?HTdF2Ah831XCR6oi8rKODTi6/ANvCfhCAt/gIZhyw5fHWihD1R/nXdqZvZ9N?=
 =?us-ascii?Q?JUeAhsn/UxEOSvlhtvbgzdEmSCNt/8VWZJSHRr6mzTKKo5HNyhoUevcCFd4l?=
 =?us-ascii?Q?5KlgzFQI6WfgSmLKxrqek1TdLx/j0NUSHY0nblpSG4Z9G+rzLT5/Ewueg3Gd?=
 =?us-ascii?Q?36FRztaY5K+3VTseiTppXCfsb1gOIm0/2dB3a6vWEDIzVj1q5NykHYtIkaKN?=
 =?us-ascii?Q?lEj2BV+wRpqsi8shwTJ+G63wS7zZuj3zNJeH7pMWfq9VUUofZqg63iAEaI6x?=
 =?us-ascii?Q?7izXibMkE06HdB6imuiZZtluHabzcZHXgov/8XaMSoP32UB7AAu2jMxYwjsg?=
 =?us-ascii?Q?/PtIIs9sg1AMWIxNWOnvURKlusM/vjpM6m5ySgIM3Qkfc84mbxST59QH7En+?=
 =?us-ascii?Q?ZrcYY/Zeb9k4PFhFANFVsgUgMT37L10=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c652e43b-860e-493f-f6d1-08da388b1b6e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 04:58:54.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCVQqjqDGmkleWreM9AMBBjezEcUo5FSYWYAJ5Enb/TlaMXzUaVUOS0AYyFzxqXyoHsEtq+La9PzgVWij7cQfvBsQ9rTwxu21aiNlO4v5dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1661
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_01:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180028
X-Proofpoint-GUID: vAwAjvGu0zP0g8iIEIg4Rz-k-FNMm91N
X-Proofpoint-ORIG-GUID: vAwAjvGu0zP0g8iIEIg4Rz-k-FNMm91N
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-prevent-remounting-to-v1-space-cache-for-subpage-mount/20220516-142802 
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  for-next
config: i386-randconfig-m021-20220516 (https://download.01.org/0day-ci/archive/20220517/202205172208.qdyoDwJs-lkp@intel.com/config )
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/btrfs/super.c:1994 btrfs_remount() warn: missing error code 'ret'

vim +/ret +1994 fs/btrfs/super.c

c146afad2c7fea Yan Zheng          2008-11-12  1959  static int btrfs_remount(struct super_block *sb, int *flags, char *data)
c146afad2c7fea Yan Zheng          2008-11-12  1960  {
815745cf3e4668 Al Viro            2011-11-17  1961  	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
49b25e0540904b Jeff Mahoney       2012-03-01  1962  	unsigned old_flags = sb->s_flags;
49b25e0540904b Jeff Mahoney       2012-03-01  1963  	unsigned long old_opts = fs_info->mount_opt;
49b25e0540904b Jeff Mahoney       2012-03-01  1964  	unsigned long old_compress_type = fs_info->compress_type;
49b25e0540904b Jeff Mahoney       2012-03-01  1965  	u64 old_max_inline = fs_info->max_inline;
f7b885befd05fa Anand Jain         2018-02-13  1966  	u32 old_thread_pool_size = fs_info->thread_pool_size;
d612ac59efc3b5 Anand Jain         2018-02-26  1967  	u32 old_metadata_ratio = fs_info->metadata_ratio;
c146afad2c7fea Yan Zheng          2008-11-12  1968  	int ret;
c146afad2c7fea Yan Zheng          2008-11-12  1969  
02b9984d640873 Theodore Ts'o      2014-03-13  1970  	sync_filesystem(sb);
88c4703f00a9e8 Johannes Thumshirn 2020-07-23  1971  	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
dc81cdc58ad2f4 Miao Xie           2013-02-20  1972  
f667aef6af626d Qu Wenruo          2014-09-23  1973  	if (data) {
204cc0ccf1d49c Al Viro            2018-12-13  1974  		void *new_sec_opts = NULL;
f667aef6af626d Qu Wenruo          2014-09-23  1975  
a65001e8a4d465 Al Viro            2018-12-10  1976  		ret = security_sb_eat_lsm_opts(data, &new_sec_opts);
a65001e8a4d465 Al Viro            2018-12-10  1977  		if (!ret)
204cc0ccf1d49c Al Viro            2018-12-13  1978  			ret = security_sb_remount(sb, new_sec_opts);
f667aef6af626d Qu Wenruo          2014-09-23  1979  		security_free_mnt_opts(&new_sec_opts);
a65001e8a4d465 Al Viro            2018-12-10  1980  		if (ret)
f667aef6af626d Qu Wenruo          2014-09-23  1981  			goto restore;
f667aef6af626d Qu Wenruo          2014-09-23  1982  	}
f667aef6af626d Qu Wenruo          2014-09-23  1983  
2ff7e61e0d30ff Jeff Mahoney       2016-06-22  1984  	ret = btrfs_parse_options(fs_info, data, *flags);
891f41cb27cf50 Chengguang Xu      2018-05-09  1985  	if (ret)
49b25e0540904b Jeff Mahoney       2012-03-01  1986  		goto restore;
b288052e177926 Chris Mason        2009-02-12  1987  
fd847878aa1f3c Qu Wenruo          2022-05-16  1988  	/* V1 cache is not supported for subpage mount. */
fd847878aa1f3c Qu Wenruo          2022-05-16  1989  	if (fs_info->sectorsize < PAGE_SIZE &&
fd847878aa1f3c Qu Wenruo          2022-05-16  1990  	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
fd847878aa1f3c Qu Wenruo          2022-05-16  1991  		btrfs_warn(fs_info,
fd847878aa1f3c Qu Wenruo          2022-05-16  1992  	"v1 space cache is not supported for page size %lu with sectorsize %u",
fd847878aa1f3c Qu Wenruo          2022-05-16  1993  			   PAGE_SIZE, fs_info->sectorsize);
fd847878aa1f3c Qu Wenruo          2022-05-16 @1994  		goto restore;

Set an error code on this path?

fd847878aa1f3c Qu Wenruo          2022-05-16  1995  	}
f42a34b2f10c41 Miao Xie           2013-04-11  1996  	btrfs_remount_begin(fs_info, old_opts, *flags);
0d2450abfa359f Sergei Trofimovich 2012-04-24  1997  	btrfs_resize_thread_pool(fs_info,
0d2450abfa359f Sergei Trofimovich 2012-04-24  1998  		fs_info->thread_pool_size, old_thread_pool_size);
0d2450abfa359f Sergei Trofimovich 2012-04-24  1999  
c55a4319c4f2c3 Boris Burkov       2021-02-23  2000  	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
c55a4319c4f2c3 Boris Burkov       2021-02-23  2001  	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
2838d255cb9b85 Boris Burkov       2020-11-18  2002  	    (!sb_rdonly(sb) || (*flags & SB_RDONLY))) {
2838d255cb9b85 Boris Burkov       2020-11-18  2003  		btrfs_warn(fs_info,
2838d255cb9b85 Boris Burkov       2020-11-18  2004  		"remount supports changing free space tree only from ro to rw");
2838d255cb9b85 Boris Burkov       2020-11-18  2005  		/* Make sure free space cache options match the state on disk */
2838d255cb9b85 Boris Burkov       2020-11-18  2006  		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
2838d255cb9b85 Boris Burkov       2020-11-18  2007  			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
2838d255cb9b85 Boris Burkov       2020-11-18  2008  			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
2838d255cb9b85 Boris Burkov       2020-11-18  2009  		}
2838d255cb9b85 Boris Burkov       2020-11-18  2010  		if (btrfs_free_space_cache_v1_active(fs_info)) {
2838d255cb9b85 Boris Burkov       2020-11-18  2011  			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
2838d255cb9b85 Boris Burkov       2020-11-18  2012  			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
2838d255cb9b85 Boris Burkov       2020-11-18  2013  		}
2838d255cb9b85 Boris Burkov       2020-11-18  2014  	}
2838d255cb9b85 Boris Burkov       2020-11-18  2015  
1751e8a6cb935e Linus Torvalds     2017-11-27  2016  	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
dc81cdc58ad2f4 Miao Xie           2013-02-20  2017  		goto out;

This looks like a success path so that's fine.

c146afad2c7fea Yan Zheng          2008-11-12  2018  
1751e8a6cb935e Linus Torvalds     2017-11-27  2019  	if (*flags & SB_RDONLY) {
8dabb7420f014a Stefan Behrens     2012-11-06  2020  		/*
8dabb7420f014a Stefan Behrens     2012-11-06  2021  		 * this also happens on 'umount -rf' or on shutdown, when
8dabb7420f014a Stefan Behrens     2012-11-06  2022  		 * the filesystem is busy.
8dabb7420f014a Stefan Behrens     2012-11-06  2023  		 */
21c7e75654b77b Miao Xie           2014-05-13  2024  		cancel_work_sync(&fs_info->async_reclaim_work);
5705674081cee7 Josef Bacik        2020-07-21  2025  		cancel_work_sync(&fs_info->async_data_reclaim_work);
361c093d7f99c3 Stefan Behrens     2013-10-11  2026  
b0643e59cfa609 Dennis Zhou        2019-12-13  2027  		btrfs_discard_cleanup(fs_info);
b0643e59cfa609 Dennis Zhou        2019-12-13  2028  
361c093d7f99c3 Stefan Behrens     2013-10-11  2029  		/* wait for the uuid_scan task to finish */
361c093d7f99c3 Stefan Behrens     2013-10-11  2030  		down(&fs_info->uuid_tree_rescan_sem);
361c093d7f99c3 Stefan Behrens     2013-10-11  2031  		/* avoid complains from lockdep et al. */
361c093d7f99c3 Stefan Behrens     2013-10-11  2032  		up(&fs_info->uuid_tree_rescan_sem);
361c093d7f99c3 Stefan Behrens     2013-10-11  2033  
a0a1db70df5f48 Filipe Manana      2020-12-14  2034  		btrfs_set_sb_rdonly(sb);
c146afad2c7fea Yan Zheng          2008-11-12  2035  
e44163e177960e Jeff Mahoney       2015-06-15  2036  		/*
1751e8a6cb935e Linus Torvalds     2017-11-27  2037  		 * Setting SB_RDONLY will put the cleaner thread to
e44163e177960e Jeff Mahoney       2015-06-15  2038  		 * sleep at the next loop if it's already active.
e44163e177960e Jeff Mahoney       2015-06-15  2039  		 * If it's already asleep, we'll leave unused block
e44163e177960e Jeff Mahoney       2015-06-15  2040  		 * groups on disk until we're mounted read-write again
e44163e177960e Jeff Mahoney       2015-06-15  2041  		 * unless we clean them up here.
e44163e177960e Jeff Mahoney       2015-06-15  2042  		 */
e44163e177960e Jeff Mahoney       2015-06-15  2043  		btrfs_delete_unused_bgs(fs_info);
e44163e177960e Jeff Mahoney       2015-06-15  2044  
a0a1db70df5f48 Filipe Manana      2020-12-14  2045  		/*
a0a1db70df5f48 Filipe Manana      2020-12-14  2046  		 * The cleaner task could be already running before we set the
a0a1db70df5f48 Filipe Manana      2020-12-14  2047  		 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
a0a1db70df5f48 Filipe Manana      2020-12-14  2048  		 * We must make sure that after we finish the remount, i.e. after
a0a1db70df5f48 Filipe Manana      2020-12-14  2049  		 * we call btrfs_commit_super(), the cleaner can no longer start
a0a1db70df5f48 Filipe Manana      2020-12-14  2050  		 * a transaction - either because it was dropping a dead root,
a0a1db70df5f48 Filipe Manana      2020-12-14  2051  		 * running delayed iputs or deleting an unused block group (the
a0a1db70df5f48 Filipe Manana      2020-12-14  2052  		 * cleaner picked a block group from the list of unused block
a0a1db70df5f48 Filipe Manana      2020-12-14  2053  		 * groups before we were able to in the previous call to
a0a1db70df5f48 Filipe Manana      2020-12-14  2054  		 * btrfs_delete_unused_bgs()).
a0a1db70df5f48 Filipe Manana      2020-12-14  2055  		 */
a0a1db70df5f48 Filipe Manana      2020-12-14  2056  		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
a0a1db70df5f48 Filipe Manana      2020-12-14  2057  			    TASK_UNINTERRUPTIBLE);
a0a1db70df5f48 Filipe Manana      2020-12-14  2058  
a8cc263eb58ca1 Filipe Manana      2020-12-14  2059  		/*
a8cc263eb58ca1 Filipe Manana      2020-12-14  2060  		 * We've set the superblock to RO mode, so we might have made
a8cc263eb58ca1 Filipe Manana      2020-12-14  2061  		 * the cleaner task sleep without running all pending delayed
a8cc263eb58ca1 Filipe Manana      2020-12-14  2062  		 * iputs. Go through all the delayed iputs here, so that if an
a8cc263eb58ca1 Filipe Manana      2020-12-14  2063  		 * unmount happens without remounting RW we don't end up at
a8cc263eb58ca1 Filipe Manana      2020-12-14  2064  		 * finishing close_ctree() with a non-empty list of delayed
a8cc263eb58ca1 Filipe Manana      2020-12-14  2065  		 * iputs.
a8cc263eb58ca1 Filipe Manana      2020-12-14  2066  		 */
a8cc263eb58ca1 Filipe Manana      2020-12-14  2067  		btrfs_run_delayed_iputs(fs_info);
a8cc263eb58ca1 Filipe Manana      2020-12-14  2068  
8dabb7420f014a Stefan Behrens     2012-11-06  2069  		btrfs_dev_replace_suspend_for_unmount(fs_info);
8dabb7420f014a Stefan Behrens     2012-11-06  2070  		btrfs_scrub_cancel(fs_info);
061594ef171a5b Miao Xie           2013-05-15  2071  		btrfs_pause_balance(fs_info);
8dabb7420f014a Stefan Behrens     2012-11-06  2072  
cb13eea3b49055 Filipe Manana      2020-12-14  2073  		/*
cb13eea3b49055 Filipe Manana      2020-12-14  2074  		 * Pause the qgroup rescan worker if it is running. We don't want
cb13eea3b49055 Filipe Manana      2020-12-14  2075  		 * it to be still running after we are in RO mode, as after that,
cb13eea3b49055 Filipe Manana      2020-12-14  2076  		 * by the time we unmount, it might have left a transaction open,
cb13eea3b49055 Filipe Manana      2020-12-14  2077  		 * so we would leak the transaction and/or crash.
cb13eea3b49055 Filipe Manana      2020-12-14  2078  		 */
cb13eea3b49055 Filipe Manana      2020-12-14  2079  		btrfs_qgroup_wait_for_completion(fs_info, false);
cb13eea3b49055 Filipe Manana      2020-12-14  2080  
6bccf3ab1e1f09 Jeff Mahoney       2016-06-21  2081  		ret = btrfs_commit_super(fs_info);
49b25e0540904b Jeff Mahoney       2012-03-01  2082  		if (ret)
49b25e0540904b Jeff Mahoney       2012-03-01  2083  			goto restore;
c146afad2c7fea Yan Zheng          2008-11-12  2084  	} else {
849615394515cc Josef Bacik        2021-10-05  2085  		if (BTRFS_FS_ERROR(fs_info)) {
6ef3de9c9252b1 David Sterba       2013-09-13  2086  			btrfs_err(fs_info,
efe120a067c867 Frank Holton       2013-12-20  2087  				"Remounting read-write after error is not allowed");
6ef3de9c9252b1 David Sterba       2013-09-13  2088  			ret = -EINVAL;
6ef3de9c9252b1 David Sterba       2013-09-13  2089  			goto restore;
6ef3de9c9252b1 David Sterba       2013-09-13  2090  		}
8a3db1849e9e25 Sergei Trofimovich 2012-04-16  2091  		if (fs_info->fs_devices->rw_devices == 0) {
49b25e0540904b Jeff Mahoney       2012-03-01  2092  			ret = -EACCES;
49b25e0540904b Jeff Mahoney       2012-03-01  2093  			goto restore;
8a3db1849e9e25 Sergei Trofimovich 2012-04-16  2094  		}
2b82032c34ec40 Yan Zheng          2008-11-17  2095  
6528b99d3d2079 Anand Jain         2017-12-18  2096  		if (!btrfs_check_rw_degradable(fs_info, NULL)) {
efe120a067c867 Frank Holton       2013-12-20  2097  			btrfs_warn(fs_info,
52042d8e82ff50 Andrea Gelmini     2018-11-28  2098  		"too many missing devices, writable remount is not allowed");
292fd7fc39aa06 Stefan Behrens     2012-10-30  2099  			ret = -EACCES;
292fd7fc39aa06 Stefan Behrens     2012-10-30  2100  			goto restore;
292fd7fc39aa06 Stefan Behrens     2012-10-30  2101  		}
292fd7fc39aa06 Stefan Behrens     2012-10-30  2102  
8a3db1849e9e25 Sergei Trofimovich 2012-04-16  2103  		if (btrfs_super_log_root(fs_info->super_copy) != 0) {
10a3a3edc5b89a David Sterba       2020-02-05  2104  			btrfs_warn(fs_info,
10a3a3edc5b89a David Sterba       2020-02-05  2105  		"mount required to replay tree-log, cannot remount read-write");
49b25e0540904b Jeff Mahoney       2012-03-01  2106  			ret = -EINVAL;
49b25e0540904b Jeff Mahoney       2012-03-01  2107  			goto restore;
8a3db1849e9e25 Sergei Trofimovich 2012-04-16  2108  		}
c146afad2c7fea Yan Zheng          2008-11-12  2109  
44c0ca211a4da9 Boris Burkov       2020-11-18  2110  		/*
44c0ca211a4da9 Boris Burkov       2020-11-18  2111  		 * NOTE: when remounting with a change that does writes, don't
44c0ca211a4da9 Boris Burkov       2020-11-18  2112  		 * put it anywhere above this point, as we are not sure to be
44c0ca211a4da9 Boris Burkov       2020-11-18  2113  		 * safe to write until we pass the above checks.
44c0ca211a4da9 Boris Burkov       2020-11-18  2114  		 */
44c0ca211a4da9 Boris Burkov       2020-11-18  2115  		ret = btrfs_start_pre_rw_mount(fs_info);
2b6ba629b5aac5 Ilya Dryomov       2012-06-22  2116  		if (ret)
2b6ba629b5aac5 Ilya Dryomov       2012-06-22  2117  			goto restore;
2b6ba629b5aac5 Ilya Dryomov       2012-06-22  2118  
a0a1db70df5f48 Filipe Manana      2020-12-14  2119  		btrfs_clear_sb_rdonly(sb);
90c711ab380d63 Zygo Blaxell       2016-06-12  2120  
afcdd129e05a92 Josef Bacik        2016-09-02  2121  		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
c146afad2c7fea Yan Zheng          2008-11-12  2122  	}
dc81cdc58ad2f4 Miao Xie           2013-02-20  2123  out:
faa008899a4db2 Josef Bacik        2020-07-30  2124  	/*
faa008899a4db2 Josef Bacik        2020-07-30  2125  	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
faa008899a4db2 Josef Bacik        2020-07-30  2126  	 * since the absence of the flag means it can be toggled off by remount.
faa008899a4db2 Josef Bacik        2020-07-30  2127  	 */
faa008899a4db2 Josef Bacik        2020-07-30  2128  	*flags |= SB_I_VERSION;
faa008899a4db2 Josef Bacik        2020-07-30  2129  
2c6a92b0097464 Justin Maggard     2014-02-20  2130  	wake_up_process(fs_info->transaction_kthread);
dc81cdc58ad2f4 Miao Xie           2013-02-20  2131  	btrfs_remount_cleanup(fs_info, old_opts);
8cd2908846d11a Boris Burkov       2020-11-18  2132  	btrfs_clear_oneshot_options(fs_info);
88c4703f00a9e8 Johannes Thumshirn 2020-07-23  2133  	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
88c4703f00a9e8 Johannes Thumshirn 2020-07-23  2134  
c146afad2c7fea Yan Zheng          2008-11-12  2135  	return 0;
49b25e0540904b Jeff Mahoney       2012-03-01  2136  
49b25e0540904b Jeff Mahoney       2012-03-01  2137  restore:
1751e8a6cb935e Linus Torvalds     2017-11-27  2138  	/* We've hit an error - don't reset SB_RDONLY */
bc98a42c1f7d0f David Howells      2017-07-17  2139  	if (sb_rdonly(sb))
1751e8a6cb935e Linus Torvalds     2017-11-27  2140  		old_flags |= SB_RDONLY;
a0a1db70df5f48 Filipe Manana      2020-12-14  2141  	if (!(old_flags & SB_RDONLY))
a0a1db70df5f48 Filipe Manana      2020-12-14  2142  		clear_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
49b25e0540904b Jeff Mahoney       2012-03-01  2143  	sb->s_flags = old_flags;
49b25e0540904b Jeff Mahoney       2012-03-01  2144  	fs_info->mount_opt = old_opts;
49b25e0540904b Jeff Mahoney       2012-03-01  2145  	fs_info->compress_type = old_compress_type;
49b25e0540904b Jeff Mahoney       2012-03-01  2146  	fs_info->max_inline = old_max_inline;
0d2450abfa359f Sergei Trofimovich 2012-04-24  2147  	btrfs_resize_thread_pool(fs_info,
0d2450abfa359f Sergei Trofimovich 2012-04-24  2148  		old_thread_pool_size, fs_info->thread_pool_size);
49b25e0540904b Jeff Mahoney       2012-03-01  2149  	fs_info->metadata_ratio = old_metadata_ratio;
dc81cdc58ad2f4 Miao Xie           2013-02-20  2150  	btrfs_remount_cleanup(fs_info, old_opts);
88c4703f00a9e8 Johannes Thumshirn 2020-07-23  2151  	clear_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
88c4703f00a9e8 Johannes Thumshirn 2020-07-23  2152  
49b25e0540904b Jeff Mahoney       2012-03-01  2153  	return ret;
c146afad2c7fea Yan Zheng          2008-11-12  2154  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

