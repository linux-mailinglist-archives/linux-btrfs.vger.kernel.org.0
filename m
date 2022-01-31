Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D124A475F
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jan 2022 13:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiAaMkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jan 2022 07:40:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47682 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234545AbiAaMkC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jan 2022 07:40:02 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VATkEB007212;
        Mon, 31 Jan 2022 12:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HXcpcfLUwiczsuRwhi0U0spx++F+Zc6oPfEaUgGVuh4=;
 b=ASDkcKkhNQso8AziRyiYyCo24zK7LFFyfaZ0lqVopwuJQ2M1a244rfbeqVein/F82zL1
 Clww3yDf8AZpZmr62fKabeDzhsjR8Gxt1kFLWnRICWLK3HT+TiAI1fCY3RazwVT6bBc0
 yA4tvi3Qla/fc/+TceC5X3Zk8RAyx/ZHBXxjKwznc2gwRF+9jQHTYXcq+6K0KxQrhlj3
 jRM0aCnw+xfjh4w7BMxwuUXwt0pY4VMO1ZZMS7ij/1TyEQjQoMX8a5wXdzq6LRZFiHKE
 jcKcdtvsfV6GeTnVFv/aBEyn26CaGmeBgludD9oY2tiW3UF6wtpR+pbLGy3tHbwHJJQG Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvx4uuwm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 12:39:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VCZJx0164474;
        Mon, 31 Jan 2022 12:39:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3dvtpwv324-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 12:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSTaotvWlk4sPQr/MO1lL538/yQWcigAm28sm8DBOWuOHNvLeOrsz+ppC70BUmVi5JFUhrw66EwwqOnOLDMaDUHPkZxChPvxxIUaJk8Nwz/WzxYQvLTsVcDTljzExmcw0Yz//rD3HgKWiYjo+MNQMNS4ij8dEu3NyqHx5qGIF/RehFfrgysCEFQjnGIEl/sQStDUWychMPfTuwovJh/MRQH74eFZP0rVwkw4PpL6JxzJ4kE/zxZ/OPl8u38eI3m48+3q3iJwXJztpv+VE3bZewQ+0Cj7mXLUoOV8hoRn80zjdzQVx9Xf7KBI/VySco4WArdY0ju2JNpwTM4xGFfKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXcpcfLUwiczsuRwhi0U0spx++F+Zc6oPfEaUgGVuh4=;
 b=UvKa66RvCSe1E+DOH/UjGqKQ09jOl1jNnXRq1GXh/KEc+kZZXzy3RjNbglsqvYvW/rrNpvL0a0Lyv/1x1JKngb+l1zO//orsJDyjXePisd5Zmqt2rCwLXoBlaXzH7B4w15CyWP5RSc1MynZjGxpaonZ/cFMlKYEYnRyld9cnwDwgG6n8wzYwIJ8MuScu7wIHS5Yoyd2PG7c/l7zvo25Kl4zONr8+nRVFArJ7fUFCh9nVoOdCyZF04smPTKNwjVdTI1qW+/OSQlhRuT5Fy8UNLKp7gqker6bK6UFInPUsAifHvv4XQw781VoJzDe0BlpkJBuZGfvOgcwlKcZNKkPRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXcpcfLUwiczsuRwhi0U0spx++F+Zc6oPfEaUgGVuh4=;
 b=GOcIF1IsMX/V4qwacHdKgtzknEdF056uHCb/Namk7TAMYs2Br3QZD88s+zBcCftuseYMkj6vwCqSXKF2oV4HG/q99PFR24LlQi/uOX4/2/8kNItqK8ZBsVGagJNGOZYZ4gPZdYIdVx7XXPBHSyd5nNJSLGCWjltKAm2iSSnCmB0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3178.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 12:39:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 12:39:51 +0000
Date:   Mon, 31 Jan 2022 15:39:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize offset early
Message-ID: <20220131123930.GJ1951@kadam>
References: <20220128123558.1223205-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128123558.1223205-1-usama.anjum@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55eff63-6e37-4bea-415b-08d9e4b6c651
X-MS-TrafficTypeDiagnostic: DM6PR10MB3178:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3178A48BCCF8EF3C512424DD8E259@DM6PR10MB3178.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHkaxYQvtmeNW8+7GTv3gDAZMuxzNzkOBAngnyMIeS8zxtGTBDG6OgtCyiV7SVfg+86BwC0Pqud7V0bQjMr5x1bLNWK8KEylkZhERgsfREn+f3JJqtmjgWHE/1Z2jfp2KUD6O1jBauJGfSF9S76fi+j6nFEbQyx3zs+iTVx2TRvxMIfwLW2QasYClVjqWzXeumCH4WTBLuDYiO9DZYP7fXOr1mCYzEjVk9UPk9EjsrhimILPBdw0Kl9tzmuSvxVW/Qhk4xz6i3jqjaP9wNWj6GIS8lgvJuw+sKaaSeQtAP2G3OER5rP0TF5bTV7jMIedZ5kPdT4+4AH6jEYq3mw0SDkTPXKwmeMPOhwaaoYDq59toGsp3yzjGbSSEBWv4vLQUVvFbLIU5ZYoYpddUoJ4+V8bJ2ZE3/4oA7dKAUzK8wTyvIBr0dbbKhFkk37fQ7+vIqMXDYrQmjKmZCK99FF0ZPDyTyp0PZv6kIHBwKizVvEPRtfwkNQ7C8MfgS7aZuuusLAvAmo89VFFYnJqhwm8sNd7jTgVF41gfLHux7QYSBWdZYP47cY1dQB2Whg9v3dkPv57vns3WIdxsS7ejN1OqXr6EEqcuMpCUnew1I3ITw98UwBxQZZtgfU+BOnwr0DPg7OlhYjOBmSkPQRsVGjoUJRDfV/dG5l5Y9Mst4I6g06FSm219ePTF3BOt5R0Fsyj/QzVKFsD7kzLtYZU9T/LAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(66946007)(66556008)(66476007)(8676002)(44832011)(6666004)(8936002)(5660300002)(83380400001)(2906002)(316002)(54906003)(6916009)(38100700002)(38350700002)(1076003)(186003)(26005)(9686003)(6512007)(33656002)(508600001)(52116002)(6506007)(33716001)(6486002)(86362001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3PgMdDFfzTQf4v3taDch7mQCWX5DxtDJ8vjdHAr5vrr6VBliwbvvkwoqkmwm?=
 =?us-ascii?Q?gh6vauuwI68cw77eTnPPajObvqPxOvFYH2ZfaWvZUmROlvDv4Bm6pT7rFaWu?=
 =?us-ascii?Q?YBha7P62m27BKjglltcMjgoEdidWGUfuFwl5UfbDzT7VZdfpkdvLjt/HRV1Q?=
 =?us-ascii?Q?KXbspfuY/Hle47PFrBQOtxek9OlVNXgOzHuDthr1DQupfTaIHPLjQiBpKQjJ?=
 =?us-ascii?Q?HV/0Kmh6do1/hlbDBjAWfsRp+jIaSf31AKynz2dcHY+BSJnaqY8tz2G9lTG1?=
 =?us-ascii?Q?g/RoPJZMezf6lbqrQk8QspBiLxAZNETAMVlF6LG6WWDYrQKnz66Kr2MAKVuO?=
 =?us-ascii?Q?KS0VK2dNeqsLRpL+qK+aehE92zE7Kgh/rgHEEQQ5T274IuFP986AG9wzJRZP?=
 =?us-ascii?Q?t1/xQ65HdrA3qC15Tulh8FolrPkPmxwro3FcPpqWSzc8x3olX59Rsbzz7++k?=
 =?us-ascii?Q?EvfRCiAj85P8fDvByLGKjG02HejIx6kTPqdONn4B+vfN4gt1rxGYQ2Elko4R?=
 =?us-ascii?Q?/ZMTPaaDTr2eF8uBfXQLPYaaQm6kYR46eBlYFi3CGV79RPBpLwXoV3Q1BfKl?=
 =?us-ascii?Q?NoImc0xxDx6a7650ZxdZCMCYqLJlRGvpbM4CGFGxrirBIgTRt3ylMN+Wj62s?=
 =?us-ascii?Q?cczEgSyMSRhnUWQbEugal32FRg2ysMvyGXYfVI8lU9i7UGQ91H17ZZf75fhC?=
 =?us-ascii?Q?mdoZULdOLeoZTl/N8ULhACCvPT3jhidlwQIho+S0TMxq8GY/byxuJWhJYQfU?=
 =?us-ascii?Q?vkkpTNDMqPILU0yWa1my97GFJjh58BzhSQirJHpBHFrybTHTUvHkA8T+fC21?=
 =?us-ascii?Q?Y4Iu+6Q59x5XPe2upXyUcRhlBKd6Pv225ksozF2Yuqs+UU0kaCOgjhN3L9RD?=
 =?us-ascii?Q?dzOcCj1Kb5AkwWy/htaUMEuteaCm/DcK/2u8pDMOY61lE5fpFJ+oestILT7B?=
 =?us-ascii?Q?410zH6tydcdqPNx+VpvlQJdk12qORJk3cKogMcnXKCcS8emrV+FP16oiqn9K?=
 =?us-ascii?Q?og8bxwZVgue+hRZNAqtcSP6P0YxOi0XZkMF8RUpEROqoD+oNFEwKwCzHz+Et?=
 =?us-ascii?Q?ORuM5G47lst/EpXUJTP8YGOMo5XgF7rn21EtNabo+55kmge9X8mF3a/BSzbT?=
 =?us-ascii?Q?3dfRAvuM5d3rgPceACFpnERqkLBxi7U2pYjqXLTacOHA55ae/ffsUJsEolIa?=
 =?us-ascii?Q?VAd3Yl6XtdMm0Zoh22GdFwHINwEoDeKpGVOY3V0BLD/co1nFPdyTDfP7Mq00?=
 =?us-ascii?Q?yQbgreP15AJKGQcMZdn+uHTl6PiaMySJ6ADHsl1omNHC99jL2rYMCdmc8X/Y?=
 =?us-ascii?Q?ASc1x+w6+bL/xsgPW76S+KEtlOGha+vXnR3q8ZuZrl3PDUDLT9t1x1bxni8L?=
 =?us-ascii?Q?KUWKeA++ELGaVbp7g1DG48LEapUjSChK0sHH7khe3bXtdSk60Rx2oLiCr6ie?=
 =?us-ascii?Q?gMlYKeuAHraERL1J1AAcqoPfoomqpYiidwmgbLDP2cqFBUndWeuHXGGsf/Mh?=
 =?us-ascii?Q?jLCt3CxJ4iXj+JCiiPKWIk6SpVvqNPVlMZciw8cWbM//NYvOSjxDAIVZ6evA?=
 =?us-ascii?Q?GVQK6/ajjTJQXEQ/OFxfGWkpor9McGrtKNu3mzwOgoiN/Dh/78dxrXQOhfcf?=
 =?us-ascii?Q?PnoGdKldLUwtbhEBBLq/oiuHIIo7t1pFtJAivl90rwdguhCraSJqBZwZ2NoU?=
 =?us-ascii?Q?A7AVfg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55eff63-6e37-4bea-415b-08d9e4b6c651
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 12:39:51.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ6LX5iwSfOZ66ScvO5NGQGHLQ93X6WidOaZ6kpbZ1PB4jOnaI7dri4WD8psb5RyL3VmEfQ7FKy3XQdNoWPVYn7kCx/VsVQ2a4dF87/0suw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3178
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310084
X-Proofpoint-ORIG-GUID: ZGucQzhxtR87jMr6iep1rs-uYxd8YkC_
X-Proofpoint-GUID: ZGucQzhxtR87jMr6iep1rs-uYxd8YkC_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 05:35:58PM +0500, Muhammad Usama Anjum wrote:
> Jump to out label can happen before offset is initialized. offset is
> being used in code after out label. initialize offset early to cater
> this case.
> 
> Fixes: 585f784357d8 ("btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  fs/btrfs/scrub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 26bbe93c3aa3c..3ace9766527ba 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3530,7 +3530,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>  	u64 logic_end;
>  	u64 physical_end;
            ^^^^^^^^^^^^

>  	u64 increment;	/* The logical increment after finishing one stripe */
> -	u64 offset;	/* Offset inside the chunk */
> +	u64 offset = 0;	/* Offset inside the chunk */
>  	u64 stripe_logical;
>  	u64 stripe_end;
>  

The same checker which complained about offset also complained about
physical_end.  Please don't post random half patches which aren't going
to fix the crash.

If you don't know how to fix it, then just report it to the original
author.  This one was already reported.  (I think.  Anyway, consider it
reported now.)

regards,
dan carpenter
