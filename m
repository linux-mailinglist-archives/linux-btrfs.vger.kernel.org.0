Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F75529931
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 07:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiEQF4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiEQFz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 01:55:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1F86365;
        Mon, 16 May 2022 22:55:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H2jcJr009400;
        Tue, 17 May 2022 05:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=QXCLd21P8qig4brstakDn5ENsG2mCJyMrVEoI6YC2CA=;
 b=D5TW7MLicvIEzp/vkaXmXHOCa3cW05ES28RUAn10K5x67VJYZTyr1b5CTf8EW3+q1PGo
 IOGheuxckFGpIuXO4WqllhSNsvn25NEKhi0MNRa0EPr2ThojaNWb2o6Ie9VxbSuiTadG
 4O89sO7p93Lm7AfpRbVv54uBUVZRNKCgHyVstMr07ofMIetXCthupaY4uUwz9RqwbUtT
 6ZghPnkYOZA7k8M98s+JAqaT2xN9nP+tviN3LBC3OaXqsV6jCwsES0Up/bs2n0zYtD8o
 ceYj2OP0DJeHyRwlR9V9plkMR9m7cG8Rok9jovatwYe8IQakqQvTnZ/0wQlu9UaHodY9 AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytn632-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 05:55:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H5Z00r028394;
        Tue, 17 May 2022 05:55:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v2qf9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 05:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQp8u1DXyi9lNwrT/oncdfXCaoAC0LO14s+wjHSOSvUgdUoo7Muqfr3djawLyppRzFMD6m4WDqB/2I1gDefk5XFoLp9KSoITqajJUsTciK+tAEPeG+zaXWnBzy/uMyCdWIbznymvaTkZ2JYxN+/ejfSOCQftj9EA5ximeAIbk+T8J7tQK2cZniqNr+Bkw9kwzm/rT1veG8VvHDR+ib9Wf3Rrnr3+lh+3FLBrnIrs+7u6yvfMHnzy/1AODK90VC+Mx864+nhAv9A8d6K0QOxcQjRQDOk+K252IATLzjtWmbG1CqeyxoPx488569odOq5OLV6fHL0elk9+6mNbK5qw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxJzAdQp0xIW8NIZx3sjAzEois3VLQwbfb3MTE1t7Vc=;
 b=iADQ8rPpl3R1++QZfn5YWqObtmLnc1TPJNs/T4Gu3RhSBv+TtFf6aanWX6eMDsqxY8ue9Qdl9F9bgpcmNiJw14MA9foK0h/s2/7z3S9TOzFU9Q3tJZ+fhsIordQPwEQ1X2l1wtNlO+kDh+HrPQWGj4zWXOoIEl+OfhEuFnr1Of+Sfj/PbXOsidEUZC1QBK6Yy10TNG004b9yioWuat4rYskxqjndc88CwsxkgpKc+fAiTe6YqJUxDIUyfxOT4kZtOypnWYk8HqvwAergo3xMfvBLwIXHi7liZGAQlSSYAMgE9q0tHIRwCxHb8YSMyniRO5OJPBDfjC7/Y7iWaHqKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxJzAdQp0xIW8NIZx3sjAzEois3VLQwbfb3MTE1t7Vc=;
 b=XFSJpgiJaHmGOxQGE+BZ5XbGzGCIXeeB4G3SCEzhCV6n92AK2+x6komZ5XyT/03aTYnwGdIDse+YvYh59nDhIY8UXSBHP2gRa1CQJyxsux0Chrh4otEe6a2DemeSkPRG3j6JdeX9CLS3Tp/4hEOCwDGOWq+GmbD70FdI+gXxqbQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4526.namprd10.prod.outlook.com
 (2603:10b6:a03:2d6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 05:55:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 05:55:39 +0000
Date:   Tue, 17 May 2022 08:55:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix an error handling path in
 btrfs_read_sys_array()
Message-ID: <20220517055528.GO4009@kadam>
References: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
 <120e4c34-da48-7d86-4a50-c31a3804600d@gmx.com>
 <20220516135407.GM4009@kadam>
 <20220516150148.GX18596@twin.jikos.cz>
 <bbabdbba-9700-2cb6-beac-6566fd84ee3d@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbabdbba-9700-2cb6-beac-6566fd84ee3d@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::30) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd15425e-be95-4fcf-eb28-08da37c9defd
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4526:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB452602D4B7937DD160653BB48ECE9@SJ0PR10MB4526.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzhgPIiI7XuxfBQfmUSIzH1XQwv2YnLgReOPk1430qBeMEx78L9BGsgx0eRg2e+hm7LDOV36FTniMvBHP+YW3DdUoOJsmU6uvg+HIULgXcq/Wt2DOs/fUFQuDdU69qp6zd0zf/aknLFloIc8FJCbEjIOPF+48YMPdHp9eDtskkVWoA7uyDM/6f+OMm5VmUcz7+nsUjc7WbNv6djnfw7d+/lHug/jzraUHlrXH8sQgeNfDgnVv0DJaVI9+FK19ICXERnSgEkojjUOzqbS0iecfLZ5UaE2p3NcsDVaAy1qXnhWDrtd0jHgQDv6KrWipTfofa8Nw+Lf1nHLzw05N6NgNE/y41QvQqNBrGkuFn0oEEZtBvS1x+881Elzz2YmD3eXPL7QkP5N4naeRO/El49E+cxUI9Os1IRAypwaOg0+KBGxCvj5jY99gbEGwDw6brhMqMdO0g4WP5XeAbpSguHd8ky4pLUzAiE1DZOH6TykGJqUSpnlJXr0w9ySL3quDbxz7whzXQGy/soTAExU75YD0HAgQpZWk/R0yPOFiNHOeH21soyhBooOnr+7kLoIG7yC4Ipw3rvY7ZlpRDYq0851c5NRq962F/pA/ZytwzJoOeBI5hsy/88uHSpxzbonzWkkldBZZKKIY8Aug1wf4U9YeA5ecZXNNda6WeoNa2UjtDrE1hAWGTWntPqmKJ0cbtBictsJZjnAAY7mSie4mp3QPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(1076003)(8676002)(8936002)(38350700002)(6506007)(6486002)(7416002)(2906002)(26005)(5660300002)(6512007)(6916009)(186003)(316002)(9686003)(83380400001)(44832011)(66574015)(66476007)(52116002)(38100700002)(6666004)(4326008)(86362001)(33716001)(66946007)(53546011)(508600001)(66556008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tA7uJErrh+soiTUno36WQVA8XE2ECzVYZNm85O3lm7RJ5seykWQGepTJkR?=
 =?iso-8859-1?Q?94guMhNVY+Ji+sH7+AM19HDbrBJDm+/KMz3TPQSj1dsJh7wPZGJrIvpyQe?=
 =?iso-8859-1?Q?rzsrpuhWJdiPfN+dR8B+R18Nu+UD/fqj1dqjUVZcKmMHuCj/9jUaH3hfYn?=
 =?iso-8859-1?Q?nVtpPrmmshMthQZsWJVuHzOsbxt9m4kg3bnicJMsXPKivkbgn7u6Y/wiBA?=
 =?iso-8859-1?Q?ZO47z4xGvAOu7yr7bzkXnrouLoEktbh5Q77FqMEp0wQWQhmEJy4eEQsWpo?=
 =?iso-8859-1?Q?vrLXkIAI3NQR6O13zjEN+TqBpW4WFdD1EAVdeUHYePCCdI+hzHT3lsprez?=
 =?iso-8859-1?Q?8EsN/MajMMDJIkEPBXYrilEcc/ENetVnaoGPFp01IQYuakFp4OZY6NKV7v?=
 =?iso-8859-1?Q?pA6UK5Yy9zBgWy3ulw6UZ/+X0ET7MBjFbBFaNb9DK/vCBfHxR744g5z/mm?=
 =?iso-8859-1?Q?jduXlzwGfkvNqsCm0ePr3fo8I3w5kwf1SV+JQjaSIWWc/zFnIX8tXRT6TY?=
 =?iso-8859-1?Q?WYfQh/LxCL096ApUHzIeO+vZtW7YrYeh5dmGiOCR3Yisml6PrgQXD+nJ0C?=
 =?iso-8859-1?Q?+/ilpqVN5bBYFuBdrnQAWy9bfzbOt+yMTXm1yhKofMDjXB9HE022a3WXni?=
 =?iso-8859-1?Q?P8ENzfWUIFKDAIxEXqJKkvpV3aZn36vWDTxVdc65BcUXgsw/e45qQt6eWw?=
 =?iso-8859-1?Q?14tZdfc7vn3qlUkTjR+ZYXbPsFzlyNQ5FIAo5R+6HMvzgBb+LQm47eqZC6?=
 =?iso-8859-1?Q?iT07DqVxDWabDblD+99OCcB77QiZH+L3TS+908e0WmZGV3u0JC7SL8umgn?=
 =?iso-8859-1?Q?v3c66wCTQVHMqkWBJDs5mse7KvLvFK687b+YSrqSNVRw0PmySYotcrAbLo?=
 =?iso-8859-1?Q?UTyrcWwmnz/Xylin7NUGcD3r/p39NhY34frYv0qskYI5AAiOf+U2tFp9Xy?=
 =?iso-8859-1?Q?EI2bZtVV+3p7+5KwInYDuqOEQs84Zto15WBs3eLWrtXl4YC0aaruCtC/pH?=
 =?iso-8859-1?Q?dbGI5k7JFXIOXnw583mbpUz9trUwmZSTHIjWnEznYYoZ3yPw+4KQz9+xCT?=
 =?iso-8859-1?Q?RfpNQE4CgAfLjY0zXjrDPqeBfe5Y2wxnAj+SIgY5YVDr2PBB0kon35xS6V?=
 =?iso-8859-1?Q?96vxtsCqqqa9rPCLSKnYTdA/Li8a4+hPx8y2nSPQPKwIRSTAhtu9VifdpD?=
 =?iso-8859-1?Q?NuwEAQEmQg0qCSLvWikrMA9HT14xJ3mScKHsO05AMASo9Nrq62gkKPnpWm?=
 =?iso-8859-1?Q?EvavPqXQMAtBSt2eCGlaZ5f6m8lIHnW7TT4fLaBOPcCENfx41r4r+r181W?=
 =?iso-8859-1?Q?bb4tR/YVMmbaZHB6OzIggZZVlOhnE9qtA5QpmCD03k7qO5/nJ77WphYfKM?=
 =?iso-8859-1?Q?0JHVXSHQ21E1A+P+pWnjJLhrNmmxmOQqyBCRak/WFIvSuLR7qka1U5LBHn?=
 =?iso-8859-1?Q?2s29J0dVWgThzuvX07GEI0LxUTS4F+EuYeolKcsJhbveuu39VvJ+VYvkrW?=
 =?iso-8859-1?Q?Vxf8vOpOz6qljCMlMBO9XsRyOCBgNaftLUtS4zYPkdGPpDXrwoTRYB88E1?=
 =?iso-8859-1?Q?EG5AWuQpU8eoO9oe1WHMnLYDvwnfdlVvNm8b75Q/9QiKDpqgaSz1TOrgMA?=
 =?iso-8859-1?Q?mkRM1s9RRyi+s9DNJFgbV+UUAztUnZpeqr5BhrSxIMkHufQ9RW8eFW5HWc?=
 =?iso-8859-1?Q?waAyJ7hALG67+blkPgbSmV0sgnmc8M8MDchEtb1OV3CweVLv0M/0fbMnz5?=
 =?iso-8859-1?Q?sto9vqjBsTd5n5lASnxj7abyt1aqLV/z9UcQbuWhH5AIbsg+JmGYx4Nn8m?=
 =?iso-8859-1?Q?H134X9draSAjVDBL2yFtv0JKZfAyD5o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd15425e-be95-4fcf-eb28-08da37c9defd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 05:55:39.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv5LjV1vcRfJXtZ8ULu1r/TRbUk8G2JH6saQIbG4+kKpiJJs9pnQ2FSjU1s03OcyVB7GVk6JJfw5hq6D1W1A6+I7wjopIl/pwCJ5X8q5QBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-17_01:2022-05-16,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=812 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170034
X-Proofpoint-GUID: 0OH5fvNZrPLjKLzOzxhpu_Md5trYD9sI
X-Proofpoint-ORIG-GUID: 0OH5fvNZrPLjKLzOzxhpu_Md5trYD9sI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 07:42:23PM +0200, Christophe JAILLET wrote:
> Le 16/05/2022 à 17:01, David Sterba a écrit :
> > On Mon, May 16, 2022 at 04:54:07PM +0300, Dan Carpenter wrote:
> > > On Sun, May 15, 2022 at 06:57:25AM +0800, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2022/5/14 20:01, Christophe JAILLET wrote:
> > > > > If alloc_dummy_extent_buffer() we should return an error code, not 0 that
> > > > > would mean success.
> > > > > 
> > > > > Fixes: a1fc41ac28d3 ("btrfs: use dummy extent buffer for super block sys chunk array read")
> > > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > 
> > > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > > > 
> > > > All my fault, thanks for catching it.
> > > > Qu
> > > > 
> > > 
> > > I sent this patch in January and David was going to fold it into the
> > > original patch but it got lost.  Thanks, Christophe!
> 
> Hi,
> 
> Not exactly.
> Your patch was:
> -	if (IS_ERR(sb))
> -		return PTR_ERR(sb);
> +	if (!sb)
> +		return -ENOMEM;
> 
> Mine is only:
> -		return PTR_ERR(sb);
> +		return -ENOMEM;
> 
> So for some reason, what you had reported was just half applied. (or half
> fixed by someone else)
> 

Oh that's interesting.  I must have seen the same Smatch warning that
you saw and ignored it because I got confused which patch I had sent.
The kbuild-bot also tried to send a warning, but I squashed it for
the same reasons.  So in terms of process issues and avoidable bugs this
one is partly my bad.

regards,
dan carpenter

