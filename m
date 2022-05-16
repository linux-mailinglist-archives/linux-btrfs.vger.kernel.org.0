Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2495F528601
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiEPNyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiEPNyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 09:54:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855CBE99;
        Mon, 16 May 2022 06:54:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GDidnq009283;
        Mon, 16 May 2022 13:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=sK2bz+jtOoq9xACevDfHqFlvSLVpZ2/jEgfPXCrrLdU=;
 b=cYCW+Cx2oJ189S25kX3E1KHApTCzC2RQKsLeGIaf79iONMnEX73OkwLADaKrjxjtG5t2
 os1EzrCxTujGDg169Lc5IN1OWfVAbbFnsG6ynmmKjX7/GY+zvUajLzH7IWyt/EjXfVYX
 xbFqF3grmuONiEUUP+EadLnGxUdFFtcyG6uurZXy+WoCALdFkzYCz248B2rC/OcZMI1M
 ezieCbkLrnVkDeP1SM4KsNqMM8NMWud2AH+vVWv8D3yqE+gYUJEJHCTa9lWb1M1NUhjK
 hJjnMm/B9qZf9SVuFaya9u1CWX7jzKa0SZbJmaK9kuFLj37Nol5oa0rUAZKIj+bk0tD2 og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytka59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 13:54:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GDjoYZ034867;
        Mon, 16 May 2022 13:54:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v1nxgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 13:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efnROO9LdHoleA1yt48h9EwYbpjVdlBrUXcbCOAmbksLNe4RoqOOdHY4xZg9guu67iJ6ZeyJB4gJE6aUgtWBJtEecgBeukjPi1L9xtiHx8Zf2F0UelsV/Jez4eoDQCaowe5mjJ1Cyd5vomEvi/nOCelIkBraxiBHycrxrtxunJWHB1S7YqPbs+NTQoUgde+9vBBCHWXgRIKGte4XLQOl57dfsPH1J7bVfa8YSgGyGsYIhGcmI+z9a0QhbW5SEhuGvYTJFTkt/QpV/b7vfWqJ0QM72vxrFdNS4grQhzIF4uqYRqpAMvnVpaytmOjPkqNc4V9lzSUibGtgyPh3OkSjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK2bz+jtOoq9xACevDfHqFlvSLVpZ2/jEgfPXCrrLdU=;
 b=ZqEbPd7v2sGNT627PMATiRmQbWpf+7URFuVds7tsB40yJYoSkWM4IDnwYW1kWixDpGKc62RWmiuxvzoNyz6v3FjhIKK9Ysy8BMLMFbi4eKZVkjVnA2VMr4JKzeJWTU1GpMprZLsEerC68/J0UJuiVFoXKoxWfSWDeZ4S1iHmSBLSBO4QzGxSk3iVDBsjEr7kFF8f69Kh7o5PsPqfeZtawdRVCGdnJKqRE/8o6lNCvrJEEI6kUTz8umOCYqIQ8DwzWNdVh3QbM4P+ocIrRlPPUGlxjnTRgvCMM9YgO0KvUanCN/moQDdX9bqvjm3Ebdka7bu2r+kLkDPRTTKszQ5iJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK2bz+jtOoq9xACevDfHqFlvSLVpZ2/jEgfPXCrrLdU=;
 b=S4CNYPaswmm3HuVNVHeJFqA+G4U2+ZJkr2kwm+colt1U0nY4fjbSAU1vq+Weu3i8VzMfgAMAHxP0PWzi0ETeDwqRfhJhvnoSzwc787T9sA0jWoOltHxP1ikE5VcifNtlHMvh/3Oim4NN+uaE5RQ+xlOi0eAMfxxp/cU27ZTuN0o=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3245.namprd10.prod.outlook.com
 (2603:10b6:208:124::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 13:54:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:54:18 +0000
Date:   Mon, 16 May 2022 16:54:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix an error handling path in
 btrfs_read_sys_array()
Message-ID: <20220516135407.GM4009@kadam>
References: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
 <120e4c34-da48-7d86-4a50-c31a3804600d@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120e4c34-da48-7d86-4a50-c31a3804600d@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60082c3c-0bdf-4172-f9d7-08da3743921a
X-MS-TrafficTypeDiagnostic: MN2PR10MB3245:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB32459D98E850DB9C0D82ADE48ECF9@MN2PR10MB3245.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/Yirx0ykOEUKQ+vznUHhn2cbQ2+xzkBAvfaIQgi64m+bRdD9auQdr9RrexmuAASwbsR+aJEHwbZhd17HMak++wkkJDsKFweIMiDJ6WErKCg+Dh5xgeBldMZaf6PJ+DNBWqpAsuMT4PRrdreMktfUmvvpbtpNLgANmdqju4SF+/c+yDFx9OpPyC9tL1u8ZkOW+7uRRqV+QrAi17CfnCvVjc4a88p39bmzk5UmpDHJkxPQbJj7U/RzzocHc8HIlhFAHlMalE0tToEMzA8wGoN1DzPTF61Fsv6GqmN01E8IJx1oeigepfw6W7nSuShKWjXqtXVf08mUy9MwtMYkeM8SejFarJOEOS3CMUkbO4igjbpMafRtgn7h1/CKFmjnbIZX1/bUAAYI8qNZCIgWfEt1xCOgt+lhN2vzUKe4nFDKg5NGKNPGA8nKX7NoLxT1593ZR+aXfk7jPTyw4W1TrvSwrxdNx+JsWTtN3+R6qSJ95SVkwpu5HnmCTwIhQx4rDv2pIy8vlI2/colbtc5zHelGjgWILSYLLPlFAFazyz0EBe6Q5aES6zZME+MT8XcrMHHh2jumHU4GpwVjE5Z+jvT4T3bFiklQcieExkj9+P44VjpTgfPX8V+dM3atmVKiwulSfQeVAb01n3kxe/NZl1NUVSWGxw7exvCf7pjKpUee3R1D4VvO8PyFzLaWOR8bTi4nyd6/ezWr8u4SOZ1ocd+8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(44832011)(6512007)(86362001)(4744005)(6916009)(508600001)(53546011)(6506007)(8936002)(33716001)(9686003)(26005)(316002)(66556008)(66946007)(8676002)(4326008)(6486002)(54906003)(66476007)(83380400001)(1076003)(186003)(52116002)(2906002)(6666004)(33656002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0EsqlojCFKFhncqadW6tynBhT6k5Uk+db+kvXXeLoFDUirb5oo/4tDHpstL?=
 =?us-ascii?Q?k/BhmlomvVfblapaBDImsO+7u5Se4b/j7fe6j86rVtil8PS23CiFM2WzX/x7?=
 =?us-ascii?Q?KPw/jMbXql5a9UnBQi5HrwktXFjTMmbBCHnX7nPPsw8r7Fck9B9qUDeBu/fK?=
 =?us-ascii?Q?/fDUwgmTXg2pIVKJ/sp48XMB5O9cRUrEPMAdEPO2zFHeJteOvjOQrgRLO9lc?=
 =?us-ascii?Q?JDIw7tTfVqTBLLjlFmf/qQjoDvwXkRHjG8ndJXsU8trhYLrYPJmlGqqDcO5f?=
 =?us-ascii?Q?aRxlj+7gErjv+HPwbKa0rUeW6AL5lpaQzWVGIzYIdLPGA9bgC36oFlQ+D7Ln?=
 =?us-ascii?Q?AW9En6gjo0bpvjaFj4r8/PnPaa0oMmhGJJm0qHsdODLRSEGCwscDZCFxgGds?=
 =?us-ascii?Q?Iy/TU+6WakfsKHh+g/fJnZEk4SRowCVAtYE1Z/csLM4qWJA4ANDnXzOf76+N?=
 =?us-ascii?Q?4njPbolGYfi5NzDTrP62PkjTUxYAlIyLoYW1C8Yuu/fZbnpsk0IMKIP6nck8?=
 =?us-ascii?Q?ZWwfv56D0RrA2iXtIp1AnYcOKRXkfEXeSrkF9bpTu4dhFZggTdzkJbZOhUIH?=
 =?us-ascii?Q?37j/B23Nzmm7FCxUqNlnhSHS675QsIQIr7XEUmR0EsHs0Q7tGYfV2erKw4wk?=
 =?us-ascii?Q?GvrWrEn0QScHCB+cREYBWKs2A+MTavSsVBs1o9PbS2fGHybefk3WVGHzzyQB?=
 =?us-ascii?Q?meco53v7PAzKVHRoTDNv3NwuPJ56MpzFGv90+XzSU4zHqZG8sXlBxAUuBOcg?=
 =?us-ascii?Q?9gxIxhpa6Zh5WHwUmEy21SM2s7nKA5xw5xknqWjUxSB0WoBZQNaWvTHCN8kg?=
 =?us-ascii?Q?tO4rRoVDS4KcZyZrpxmJVRU5g04AhiKMbQFjx/tYc+oPKPH7qsWZk4fVeGI8?=
 =?us-ascii?Q?LYMoH0FBymn6rXk6YwntuvPf3qz7Q4imev4+WXRzeQiU4g/R24khVaeXM1UY?=
 =?us-ascii?Q?hD1sRqgTUV/rodIv4wU2KMtrL6r3CdqeMNj+CKOKHN5qR+EfJ1NwwRwJtiDK?=
 =?us-ascii?Q?2lmhw+tzwTDK/idBgAgwBQ4cMc7SJOXwthSoHiNL1Zn79BWXStMF8SAQrfJ/?=
 =?us-ascii?Q?xrRYQaOmwha8on7PFg5g/3pWqms8XtIrc72e6lckBK7iq1IaSdgVkcJpBOh1?=
 =?us-ascii?Q?0ewbkByYmurknh9utZ60JklB44qPSrHhw1xaEj1aCZ/ItaX5kRwwn/VCCAOZ?=
 =?us-ascii?Q?rFxsPvsLc7Y0vmUcTau5CobmC111dPrBck6xov3LBnQqdx3oC1tw6hw5wv7s?=
 =?us-ascii?Q?cT6Plfs/kOarlA6ivmNVCXx8dTKDTjoeMRQIAxP2h7mYht1Qp8RXaTxqFcQU?=
 =?us-ascii?Q?yYIhJ1fBye8I5QdS2WtTPN0fp6RvZfFlGc8J0jh3IFuQIT7KFkWSkkRDqr6K?=
 =?us-ascii?Q?XXPGIinlcSfUA34YGNmS1c5ROMhRodcW1NLPWnsDFoliGDjlbLR+z2KnEPw6?=
 =?us-ascii?Q?KyffFU/bRq6hyFl4ZgSK/2ND1KnMQUrXtJoAxig8SqVsaQPuku8GzYr8qtog?=
 =?us-ascii?Q?+3uCYxB2gD4l9g2ai0hsImvLUK/Hd/7gMr1wf+iGY4xWbhqcJImDsMmO+PNR?=
 =?us-ascii?Q?GJbnw099UJ1v28dsZP7pNP4/n3oGSRXVvd/YLP4eSPL/n0upiQzXt9l3ar4/?=
 =?us-ascii?Q?Ia0gTNynczvzoFr9c7RuWXPsRkcEwzeRqInxESwa0e5+0F0yn1Mld0ycEPZZ?=
 =?us-ascii?Q?0noGb4SszFsckeE5xnPZ7e3t14r6fkvDEmCZtpX9ZxDyRyNaKoAk+2H+FuzB?=
 =?us-ascii?Q?+eN0WYS6w4epIFjdemxRP1KckI+fBI0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60082c3c-0bdf-4172-f9d7-08da3743921a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:54:18.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHguFOnlFzqqj+ZqFOz6R2Jgf/8srJfJmzyvM650s+OgJxSnYHMwgC/YkfT0kLf+zESsNt9DlBA0G+fZPCFV/M5iw0/wD/EWiJCnjF725lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3245
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_09:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=869 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160077
X-Proofpoint-GUID: 1PGAeYy9qI77H1C_7h2wMLFkJQsPM5GL
X-Proofpoint-ORIG-GUID: 1PGAeYy9qI77H1C_7h2wMLFkJQsPM5GL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 15, 2022 at 06:57:25AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/5/14 20:01, Christophe JAILLET wrote:
> > If alloc_dummy_extent_buffer() we should return an error code, not 0 that
> > would mean success.
> > 
> > Fixes: a1fc41ac28d3 ("btrfs: use dummy extent buffer for super block sys chunk array read")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> All my fault, thanks for catching it.
> Qu
> 

I sent this patch in January and David was going to fold it into the
original patch but it got lost.  Thanks, Christophe!

regards,
dan carpenter

