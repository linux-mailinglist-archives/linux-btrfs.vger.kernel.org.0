Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0706519793
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiEDGuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 02:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiEDGuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 02:50:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6D81E3C1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 23:47:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24428crM019152;
        Wed, 4 May 2022 06:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=+nsNxwiNeMQN/pqnu2ZM+97X8KxHLmPLljlU7ecurVc=;
 b=AI1kOjNrY/ZdObLelVNp6B+9ejjkOpJOwS/Yv5FSliN/Xq26c369Ritp/GFSeeBubyA2
 TPyHrq+XLHUxa46fSlOKyC/Yb1URIktlJd7fRxYAyWDfS+1kMfU6AMTfaCfSmjI01DhR
 InExQ4vD24PuAsgyXFkAFV4X0VXW0YJIapaav5/Vx/f4uoloE0dSvBFg2GAS+EE2wusG
 8GLqOg5RQBOmHPlcAGipQOsfu6qpe7Bfwsz7ADos6dJ8KnrgfWPR+kNIAGq0pqPieltk
 AXhcrTcXzDjaI1Bxe/l2ypX5S2VzjjkiU+3MTxqbhXc5f2iIEJ6jGMTj57ahlqp0/hCm QA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0aqb17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 06:47:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2446kSdU004279;
        Wed, 4 May 2022 06:47:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj33c1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 06:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuzMAESTTiR1Bf+rfzsBsnUlEAFdIflsAT1C7ckiSfhbkaHYRT72GRee/AUx2Z5flRAAP9kRLQ1GFLnIbvzy1KR0fbWqIibC9r7W85BMIos+m64bhwr+psXx7xNPjT6TGqCULHOVG3QwWBPI90kJBq9pZFzJ+Stzf/13aHsSfEJZqOL5BbO9jpM80tXBcZqyOswN3zN20F4YoQA4MUgnDEW+RtbVdikgc9Qx/Lv8LzTByR8uh0KfrGcQfKXU1Q7gWRcwUQO/qrG3XSW1aIJi2GL3wK3UeH0Fi6sT7zskUiOQSYpHD7DwLnevs+GOY0zK80FpnV6ZaWESQSOTf5kDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nsNxwiNeMQN/pqnu2ZM+97X8KxHLmPLljlU7ecurVc=;
 b=PtFo0VCFmAKyRdNhv69F3uHL3TqBmCc+Nq9S3oLOtqdSaEmPExOLibNtdavN77pz+9BdJg3oD/Y4L393Q152DXt2n9hT0wL4r8d5CHGlYsNq9hOm4B5v+t/ivPL28fXclw1c4rq+6Ckr++50AjoR4t4cF5fSQJDyy7ewduLXiK8DFxPkjcI3icM328ZSsXSJjE6g7x5HxDQHW/1jiLk0bo5prt9o1KbGD7Nd6elnSHDZ7vpy5qOYgP+BS0IGoQ13t5Zu5xIKwbH5jVAm1RnYdabGZvQtTh7UZ/kFzVcmLgYu6nh9f/lU0hwOJWgvkFwUK2elkkTytezqHfkexolq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nsNxwiNeMQN/pqnu2ZM+97X8KxHLmPLljlU7ecurVc=;
 b=x5axOlt/wMvFjE1K8ykxo4HmZIyDKNiIcqe5TCUXPEIiWK6yVeaWRhf3ksA5rPvJ+S8GpTvsikg++aB5EsMbl0AoxJ0xUF782IZJVSQLbXgbpp67obtNJ9ZyzeSu/fAIZ8gt2n47FJVqtoDqkunHxW1vTDGbxwynmFEZCgNl2II=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5751.namprd10.prod.outlook.com
 (2603:10b6:303:18f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 06:47:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 06:47:08 +0000
Date:   Wed, 4 May 2022 09:46:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [kbuild] Re: [PATCH 2/2] btrfs: Use btrfs_try_lock_balance in
 btrfs_ioctl_balance
Message-ID: <202205041423.NVVJIHSj-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503083637.1051023-3-nborisov@suse.com>
Message-ID-Hash: SYMM5PLM3NANCNSAY5MJU5M2CYNTLMLL
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0059.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23ee2d8-21ad-4a99-a01b-08da2d99e893
X-MS-TrafficTypeDiagnostic: MW4PR10MB5751:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5751D510734FF08D8B31C4668EC39@MW4PR10MB5751.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6tT1PTqwuA04ry1LsykW5ApZBF+AixWX2Q2m+V3TSxcuu5s4ukr1WbO1W0uFc7gTV7WUx9jjAGmuB2wpNbLjTAer5pNep3EocIdN19PSaRJhgbGPD9OYVvetT3LdOIO38frYsCtSsQVGXkyTx9PS2wYEaz+M78bPkUZKjREBGJWu/PNnrODLqCpKeAqrjHTcHf07X0h6Y3EeZgMjs9ugaIU69DbpUIzTJA9OyPfeQaQGdkSwHMk5QjNf0lgA64VlyOzfRBhlVicj8HKaSzGJEScjqHQ5iKECiOGTNk6F7c/mSJymR0vGq7XOVSWhGiJRvfvYcmonSbBJbma1m/gwe2CQ2VUmoqUV7XxPAv2q/DrCx+y0H992VBG/54pQYXhXr6t1irekuDppI+Q4ZDknJHBHsmoA8VRg1dtQ/V92APgnjlYkqsv55pprwXEvhwVc7Hi3TJ4raGnLIhfcPMzjUf8oTGaVrs6H8cL8V2mr5WLxvTHN3L7uuhIKZRI2Y32YKtDeqBogfeRb/fFdAnvQkc5xBOsrE4hidVZ78gUKth8zIxh4VSOhTtUIBm6drmPGbMxzuHEzBgySC51c2izfNM5bqEPNRIrjjRjga2dH7zuaM+kXOWMPupckytWFDRpdc42a0RHP1xRsS3MJYD0ocKMFqvgEkplfMww6xpYP3TP3WGm5POpnVZXgnTWTHgqWWpbvGULvcEJ9yjGLC8+o28rVc4sE0++aHjJ7NZbWSr7cmdaT8SWXdAuJP2se4yP4qt7gQhzyztLzZYhDuAWIYJlnOOPQ1KwgEcHh/9xvNQaIh+zjpnz4HC6dm+JqF/lvy5mriP9VPsc8XwWDYQuLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(966005)(6486002)(508600001)(2906002)(6512007)(26005)(6506007)(9686003)(38100700002)(38350700002)(6666004)(1076003)(52116002)(4001150100001)(66556008)(66946007)(44832011)(66476007)(316002)(186003)(5660300002)(36756003)(8936002)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/iZH/2JbHf7zb9WRHktb2wc4+ArGrR3Va5Mym5nxAKtnMWNP5X6C86j7Fea9?=
 =?us-ascii?Q?5ht0k1ZythxYg8V65VjyYooSs9jMIep4Ih5NifGRobf5yvDsTQlf5qNuBUSW?=
 =?us-ascii?Q?1uwVReQiLpJcE0l/IssXR1EYWnTTcnB2AzWpo47QO9uv06RzD+XH7UMf/Xj7?=
 =?us-ascii?Q?ODeVpHirg5YleYt3VwMioXosbn6qY1fyK6NdDqMxkkAEMmCBTSFS4k7apMVt?=
 =?us-ascii?Q?3PVkyATiWinZg7UXdu04Ec583tuYA5JFGe8ERW1I0jtnloLlIJ+NZgtgJ6Kz?=
 =?us-ascii?Q?SXAj09DLk+dbNLcdlh0hX4NQaOwXkCZqfH52+43VMLVkBuCxjL9j4uGNn/02?=
 =?us-ascii?Q?6bV/6VVA26/8UOQK2XRpJnJM8BnD/J+SmsoCpdo56xmaWEU6iFmwlvqXsJy7?=
 =?us-ascii?Q?KVNv0Mrk57QZHAZ8RuDP2VxCHW0UPy4M7uXo0FBxgTvCXCUF1OjPureKzBh9?=
 =?us-ascii?Q?+hLypHBdy8e/ZB+g9Qr96cEwVRcg8AiwWvQxKrXfdi9enmzRjO/0WIk0FE+o?=
 =?us-ascii?Q?Ys6nWwp8qOktSFCFxKQpuFK00tiVDXs+ciOkFHWezvPNo5S15W+5AJoSZqT+?=
 =?us-ascii?Q?g1DkM3w5f2WXqXig1xkMlxImrbZvaLDJURxksaQvilUUeh+qMUrx0h3QUXa5?=
 =?us-ascii?Q?tsaQ3GB34ndUTEioSQA94nTUAktqeeqRx/d5CFCul1iaOrqXVZn+znDfYb4e?=
 =?us-ascii?Q?x6BgwCIZizDDJ1d0kBmHKypT0vbJ0K0vCWfdRIowIKPP/ANDltx4Ul8B4uDb?=
 =?us-ascii?Q?j+cYrhUl0PsliEFkZwYCaXAEAwYfeGoEep6BvpsUa7nIBga9iqFL8VG3AehY?=
 =?us-ascii?Q?yhSI8Z+hKNkIlnkGKGRajL0BfKbe24WIMTVb+SNPax0eL419sqgEeuybu76C?=
 =?us-ascii?Q?ERghTPe2OM6UZ+kmPVvdx+xq6hLa7QDObNi4LC4FBxkZrTP1AmFCmgd7ZtnA?=
 =?us-ascii?Q?IDN0UOibMIRIaBgC3xcFNpx6mdIaZTbRWnpY3P+Gvjpb8Awl3GEOCQ8bpRHa?=
 =?us-ascii?Q?nbpyrVrxoDhgFTOjO39lC9uitDh065j7ggwDwYyzyGgALdpTlZfMEILQjqRG?=
 =?us-ascii?Q?hqHDK362PVjNvz3b4Bp9OSX8jJg0nEcThEnRO+eR0gINSgJkuJCFtSTLFHrr?=
 =?us-ascii?Q?WLid8V2653ysftyg90+qeyV/j+sbTuANTUXPlNHGHIzGKrRU11Dr+gria6F/?=
 =?us-ascii?Q?fCJBqxgpYm8YlHIFISI+4XB0dTtBmR7w/AQzLaCIzCb4eDiSNgJKg5dgd8oX?=
 =?us-ascii?Q?CUGho9b3wKYkWaA0K/g8HIpuacdlsDcrY7V/vLxRi8gzHujLvy60Y9LUZ5Vy?=
 =?us-ascii?Q?yXjtKJJ+CXtQOP+WqJ4JxUB/B3wLZKM822a64Bjm8GtQ2jHMTCMtXUHENHfQ?=
 =?us-ascii?Q?hCDtwPL5d+mAaq9ACwRosUn6dD7vIEMqua4O0/4NgzPpQJ+UC/Q86SY2sAkx?=
 =?us-ascii?Q?uqfuz96JfnKeuXeZW4Qm/YQmp1jZmPn0eYvAb8hOGSS+Irz192pDBmjCkkkx?=
 =?us-ascii?Q?I0Sj7OpIQWok5tJdFns0r2ayiQoL7xeGA8tJ3eQmNJXWGW5OzisJcBaMZjto?=
 =?us-ascii?Q?ABzBOkfDcyo0vL3DnVuhGLnlDzSLS+0bDGYy2ebBp4xTZyVEVNdfXpFPFIvl?=
 =?us-ascii?Q?keHHBBJeuKKpVUp4IJsA+dBqAKUYxojq3hMIj0XhhMFOjmmO6Vn/9hoF3mdX?=
 =?us-ascii?Q?m4rXCtmYwHCCCBXwgzu3PSgvXydywKRWuM+iu7tD3sMVz9ufLn+Cr1oDtMCI?=
 =?us-ascii?Q?GE2F4y5Q+ClnK1mVQedkA8yIkRvNizc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23ee2d8-21ad-4a99-a01b-08da2d99e893
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 06:47:08.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 439DrMNbJwtTtKMnypCzp2IKFHH4SJM8ilAK+/PuAIs8nD9fkAzdkOp3l5eRSPtf73oPu4i3ZzIKkUSRmQjAt/2YNhEbgnUG9b/sv3hwYwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5751
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_02:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040044
X-Proofpoint-GUID: POP-RK8Ld_c0iwRSNK3RIW9yCJvYIYBW
X-Proofpoint-ORIG-GUID: POP-RK8Ld_c0iwRSNK3RIW9yCJvYIYBW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/Refactor-btrfs_ioctl_balance/20220503-163837 
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  for-next
config: i386-randconfig-m021-20220502 (https://download.01.org/0day-ci/archive/20220504/202205041423.NVVJIHSj-lkp@intel.com/config )
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/btrfs/ioctl.c:4493 btrfs_ioctl_balance() error: double free of 'bargs'

vim +/bargs +4493 fs/btrfs/ioctl.c

c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4484  
0f89abf56abbd0 Christian Engelmayer 2015-10-21  4485  	kfree(bctl);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4486  out_unlock:
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4487  	mutex_unlock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4488  	if (need_unlock)
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4489  		btrfs_exclop_finish(fs_info);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4490  out:
c696e46e6ec2b3 Nikolay Borisov      2022-05-03  4491  	kfree(bargs);
                                                              ^^^^^

e54bfa31044d60 Liu Bo               2012-06-29  4492  	mnt_drop_write_file(file);
c746db1b6ed99f Nikolay Borisov      2022-03-30 @4493  	kfree(bargs);
                                                              ^^^^^

Freed twice.

c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4494  	return ret;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4495  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

