Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5487674147
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 19:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjASSvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 13:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjASSvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 13:51:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E431C53547
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 10:51:50 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JGwhmW025292;
        Thu, 19 Jan 2023 18:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4nvepbvlV67gId+0XRlBNC2rgKQRdkk9tdZFGXgmNyQ=;
 b=p1DfC+c9YEKaIeE7HhD4YIey0ZdQZ6q5gZ7P4L4pfvCXKbl7ROf3ro0/92994YaJ3NdX
 BrK3yLU9hPmov7mqXCPdVfvd/r/OFsmxKxP5T6qsC6wxNLA/UzFs9uGIGV4JaSfYpKVe
 Sc8QJsBBJvEhCpnTTz5igBWOtA8cVkA+ZQfFXp6LCRPNXbPX8OpSOqRqEeXNcVHb17nJ
 z/Mbfh/KmsLHliiLik8lATnh7Edj2hb2d1mobS8A1oZHF/JDBRxKhyo8jmUUlVgRNUkL
 YAyz6C+1WUH+CB/ZGJ7wFR/VocFmGrOfxdn/MlvO0Smceg20XSGOHlhelLBK54x00gp5 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n78958kqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 18:51:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JHj8d2004850;
        Thu, 19 Jan 2023 18:51:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2ut8ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 18:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrKt0z8tMG6bs7XlTqEM8juhq9GTBLcDzQ1wA2bnKCmjTFhu1VZnuA4eQ7aupMzy8hlZ5Iw9qxA+s/WU/wFTyqNDxoYQq719mBTKxMxIh0bD9ePQmx+1t6GFFmtJDxEuHXQxdrhWycDKbOddrt9baxTbCupsbcRZMCNYsGPAIYUaYA8j80tjZ+F8B/l8R9k2xBlUQPwhEsXzRVsXLGK+v8NjQTo9k8f8wn2BsSu6Y13dA2y0rUs5CP7UY33cAelUU5xwG2re0KkO8wZefyJKF2LZDIioWs5R3W7qWUv5r5Q1RsAMyTzBasB8ckD0cBseYGsYMKFwf24RFE0VnfGDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nvepbvlV67gId+0XRlBNC2rgKQRdkk9tdZFGXgmNyQ=;
 b=Y+NsWT4YBf8e/+b3bYMbDFE0bvTqsd1CZtQXXbPSwwbAtIUVUVsRPMafj0gPWno2j27JtxYcEleYV7xT1ebu9Qkf/eaQcgOfJLc5XupaQL3SEkcOlBC+MkJpR3483Ic9UgLLY5u53Ha0OfD+OaxTR5pY5lW2PMqaQ0/11/dx2uU1XzqViGz1K2XFS9RV858f347v2t5asNI0v3aw6r754o/2nFHBamEYZmnkv051uZoILbMh/cKmTDc6XcJWPFTghavGeqQV00k7vyedSTYylvardHfNNq682etIZ8ZQ4Hxkp9peI6lW7ZXt4aEWZHslHo7JgvyYgBvWViHKy+6Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nvepbvlV67gId+0XRlBNC2rgKQRdkk9tdZFGXgmNyQ=;
 b=NLuqnnGrll+nT9oh1yeiSoJXSWJXldt41B82Fr6S2QTlQ5byhKkO9k6BRYfic9KVvVj7QBsSE9kVF7sjnwVWPdu4zLVckDf1Fbl+EsoXcNxiZ0qphbFUkv677esPO8LaSAZoYtlV2KBNvnhoUjmmeYkWpN2P0wZ1a05syEIbtx8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6266.namprd10.prod.outlook.com (2603:10b6:208:3a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 18:51:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Thu, 19 Jan 2023
 18:51:26 +0000
Date:   Thu, 19 Jan 2023 13:51:24 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: new lockdep warning about registering a non-static key
Message-ID: <20230119185124.znt5j3zamcopntzz@revolver>
References: <20230119151929.GA29005@lst.de>
 <20230119161530.GA767320@falcondesktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119161530.GA767320@falcondesktop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f3ead6-932b-42b3-74ee-08dafa4e2b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMSNdQbTF4XEs4Pl6B9h64mGut+SxKYWJAMHL2OohfvYmlC7OISyZTmnYmqIjMGro3J+EFKOywm6Mdf7IsZpuRXitHEE/hchB2cq4Qera84ByiSvQ19hy+DKARZonKkt0YU5lNswd6NnIKdPi0ZSAjdRw2VDHKjAVc+9tdu9RT0TCxjTIcOwLyLpMkRE3qcXw/kd0BCRIt1tNvd+/f8+e5sAKwUVkIMO/U6d7SEWeFQmYtsJKJbrcWPwYr2JWzYv7UqHDWofbENfq5j/K5NzQ7f6pUA0reOJ/V7UkRxA9BWl1csY6T5fBYcAVtp32m74ApP4pYwsQukB3n2nD+qoblBzBsiyVEiEhog0qAH52Z2dXAiFk9mBDxmNiI9Z+ilpnfG/Uwpt06C7M7XCxYKhcfvrCpHSwvCE+VFlScfyRoPskMNLYG69y95L8EnCG6Dq0M4pOJxN52pbXnLsZllqUd1RzC93WceviGm8UsIyv/sRcXm84rt4Ph/1KOFfZRFv74HyKG6XsXVtrnXtybjbVvPyDLoPV5IlgBLJbOf2ESSpMwGTq++Uqubc3bHUvQA36nS+yuN6TFbqLL+6GmS2OgwdamPlxMjOL4JlFl93i0BVppLYjTOPChSyz+EziLqE3kxtBqQuVK5lnPecrdAIjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(66946007)(316002)(66556008)(38100700002)(86362001)(2906002)(8936002)(5660300002)(66476007)(8676002)(41300700001)(186003)(33716001)(9686003)(26005)(6512007)(1076003)(83380400001)(54906003)(4326008)(478600001)(6916009)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8ZOP3TraYBusRrk0g9cf+sP8zkoHb3VxL/nbga0Kx2JErwntJ8ok4JOJkO8?=
 =?us-ascii?Q?AOUrKsF6SxpuKf3jVlpG4CGGXCR8vdvlgOgL7W3pqT2RTWRjWPNYcXv8tmkF?=
 =?us-ascii?Q?0ppVZ8cY8cWQgvNwCUkkuEzp60L17HxV8WR0+PMzq5m6AVjdPtalahh7Tm0x?=
 =?us-ascii?Q?HebJPznbC72DjgjKQebTfBoQ2MJt91sNFQ6CAY+qVsW3e+LjFkRqXB7ksRVD?=
 =?us-ascii?Q?yhL9Brqg0Vh+TRd6061f+WTj2wRzajCkYYY9SiCFa1cN71txm1GfnxB3wSdz?=
 =?us-ascii?Q?neQE1loj1fpZZIHgCdBjOD7ak2bOdoBWZB8clKBXlG875rrBsmL/7Othue+p?=
 =?us-ascii?Q?IYxNX0YBeKqNfK/ZgLc5MAvJBC8NvEu+uVlP00CjIi97VB0XrJArM6nWuVzH?=
 =?us-ascii?Q?snA6qcvl5KEAqlAL/Zdnslpa2iGxUZMhgXK5NtlIikn6xot9Rk8r7Qknxnof?=
 =?us-ascii?Q?31hq91YORAL8Hhw98//8ttrWyZsZKNL8CpkopNO1rtWssbYMxM77BMZ3nL8b?=
 =?us-ascii?Q?YukvaJQnsoDAM+NZvNgrDVriiyrnDfAImTqaYSCqZVxq8KDt+2ZX7U094LZ8?=
 =?us-ascii?Q?CxcFheCy6G9Wj2rkFvRkOpNAPulyf22rh6tOAmaqeGnfEqSa7BrZuCDywHqU?=
 =?us-ascii?Q?bvWynYzGhWA3xbMy0NFHo6GJR01gkPIX+SMffItk4NJHR44jr5xTjUJMFEN5?=
 =?us-ascii?Q?0l4UxWzPw0GQWv+/3qXOSgijLYXRFF0PgMOPZAW3Uqcvf+r2VE/CYEMTxHpp?=
 =?us-ascii?Q?Lugb+shJaUoGLkCoGjFOZjXnA1qCw+60O7ETdjNruvAe71+0P3lga4qZNJlD?=
 =?us-ascii?Q?bVHXUQg/Nvue0H/UqVdy+4gTPyNyS131qvobGYwU8UXtlEjIujIkve5fW71i?=
 =?us-ascii?Q?eMZ8jSSAwc1CHvGV5EEbaeSnjC5YrAssLEGkGO3cM/UjKNwEWowRbtVsL7Mi?=
 =?us-ascii?Q?+eRCYieAmft/p1Qq588mlluYtkdKF7gTa0QkQri+Dz2P4zmY6n1XhJVFITpK?=
 =?us-ascii?Q?pUZjbaayFQYpSmxQYW3sMwFD23Igcaov/M2LuLCd06iXTkVnTB6QLYoHO9b0?=
 =?us-ascii?Q?Am4ME3pllRDQpJ6vXtucysJFgc1eRYms6lxlVKwOjox8JTTEASuetvSMWjIu?=
 =?us-ascii?Q?k2+joGvKYimJuF2h1YLvrgtcl/6sit+g8JIhRzrOGLGr4uq562onywx3/Dsl?=
 =?us-ascii?Q?TsYKUjVbR76y81RileO04GOgiE3gioIyAnE/UB3/0f0sDpDrczvMkq3avCYA?=
 =?us-ascii?Q?VRbTLMQEjG3FSshW8ho5RN500SpP4HBnlzKk5alz7lBHj32/ibb6yUMj7+Ml?=
 =?us-ascii?Q?YZO0N0xgx+N50RQusfgXnPM1tk1jg7gq9f8amUUy1ixGUQ87pxc/354frWJb?=
 =?us-ascii?Q?Voaj9VIiUy+/rJpxkaMdYSgcbT5xSmJxNA+Gn3mwkLyqrLHFWhx8YVOW36MQ?=
 =?us-ascii?Q?10R1Mhqo5qIdetBlmV70gUE+OzMlgFONVjYF6WQhFUf03MYOp91P65oz76Pc?=
 =?us-ascii?Q?Bu9uRoXGXXU42LFdTI2jffSeUpJexXZXnayKhnD+lYdyz9IvK9ATX0f+M9+a?=
 =?us-ascii?Q?VdKYCxiptdp3tYJkw/7n6SVtlrPCSUVUJaKZ91M07jTfzZNM0BCXSDEDxZWq?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yvUTXhhde1zFN/kJDo1ANbE77I00urT/eIB6Z290xbwmCiAW8nvMahYE3or6uWV9vRKXHjOBUbfEwkgtMXShjSmMiSUhOIHh18mc6fs8w2NH4Egilxy92udv85SfwNXmFZYS5XpVqvLPu63NvgOwbpDov/uHfpYNkSVpMwMxnDWV3Tf2wwyhYLMv8hD7m0WOok3IQxc1rdLFUmBc0M7M6H2mYGVy+ZrIblHkPVtuEjkQOPNsyoz3Um4bFZZf+V4CWGY9IiKiGQ4dfs+If/vwmpIr8xFTrA6lKAGVAXti80y+WuE/JKqOu7f4ckjUj5PUj+R8IJe1DoUOFecOylbg4mEClJtifI5UJi7EZ5EFnKtNw6cdywOahCeV2qWAWKM+qf8jQzeGXnmhD7Looz6MvoTPcPXw72JKacCqfcKRPpeCoqGRXlubsbdjdA6WlRnmq+WzdhZ1/6Nv595PqeaaTFc+mYAyzK5V/FRoq1QltFxCUh2DPyO7QmqLvTR1naOEnDmCAgvUT9kRQibx8c/6Mr3y8DwOXau9Y7gXhGTeWW0xt2FSZj+r8kTBzXGqrCcKec4AsiWO9eHRR06YCUbX7+uuHjhYDbDHpRQzA96v8oN5d0I404O+Q+KbFnncVMxJVSmg5EkccpB4jCd+0JujkjOuz9fTYp8hfYifxSTeOPbw/V9leXrpzKJApSHI+jkB/E3qzZcUyUi4VhzBl57mqOjxwUm4QVvAKTP2V5iimCbtWZbMm03486lDZQcQG8L5sc4lBBNHhO1/GeptO94lJIiOWhGyYpXzyt9jQi/8Xa7UjQ9T+EFILfihVqMXpKcsKGusMZY8id2aTeHrc3iIl11VjFO1N2BkQwqj1Gd/Wig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f3ead6-932b-42b3-74ee-08dafa4e2b0b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 18:51:26.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88vgngXOBqyyPaYOj7+0HlHTmPr5G6HN0Jm1lfAqP1AbRUnfXlxgabYLiHwC16X18ClcdYpBO9ePj/Cqr4uPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190157
X-Proofpoint-ORIG-GUID: hc-sQwxiQtCENxBYAhS8N1m9iKWyUDqE
X-Proofpoint-GUID: hc-sQwxiQtCENxBYAhS8N1m9iKWyUDqE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

* Filipe Manana <fdmanana@kernel.org> [230119 11:15]:
> On Thu, Jan 19, 2023 at 04:19:29PM +0100, Christoph Hellwig wrote:
> > xfstests btrfs/168 on current misc-next:
> > 
> > btrfs/168 1s ... [   32.860171] run fstests btrfs/168 at 2023-01-19 15:18:17
> > [   33.224255] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum
> > alm
> > [   33.224835] BTRFS info (device vdb): using free space tree
> > [   33.229739] BTRFS info (device vdb): auto enabling async discard
> > [   33.442266] BTRFS: device fsid 62b088c0-2f9a-490e-a6d8-e661c167c616 devid 1
> > )
> > )[   33.489483] BTRFS info (device vdc): using crc32c (crc32c-intel) checksum
> > )alm
> > )[   33.490135] BTRFS info (device vdc): using free space tree
> > )[   33.494829] BTRFS info (device vdc): auto enabling async discard
> > )[   33.495469] BTRFS info (device vdc): checking UUID tree
> > )[   33.566003] INFO: trying to register non-static key.
> > )[   33.566400] The code is fine but needs lockdep annotation, or maybe
> > )[   33.566813] you didn't initialize this object before use?
> > )[   33.567172] turning off the locking correctness validator.
> > )[   33.567527] CPU: 0 PID: 7480 Comm: btrfs Not tainted 6.2.0-rc4+ #331
> > )[   33.567930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > )rel-4
> > )[   33.568665] Call Trace:
> > )[   33.568830]  <TASK>
> > )[   33.568996]  dump_stack_lvl+0x5b/0x73
> > )[   33.569256]  register_lock_class+0x48d/0x4a0
> > )[   33.569541]  ? __kmem_cache_alloc_node+0x28c/0x340
> > )[   33.569854]  ? kmalloc_trace+0x21/0x50
> > )[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
> > )[   33.569871]  ? cache_dir_utimes+0xac/0xe0
> > )[   33.569871]  ? finish_inode_if_needed+0x14d1/0x17c0
> > )[   33.569871]  ? changed_cb+0x1c1/0xbd0
> > )[   33.569871]  ? btrfs_ioctl_send+0x1d6e/0x2080
> > )[   33.569871]  ? _btrfs_ioctl_send+0xd9/0x120
> > )[   33.569871]  __lock_acquire+0x6d/0x1ef0
> > )[   33.569871]  lock_acquire+0xd2/0x2e0
> > )[   33.569871]  ? mtree_insert_range+0x86/0x170
> > )[   33.569871]  ? btrfs_lru_cache_store+0x3e/0x1c0
> > )[   33.569871]  _raw_spin_lock+0x2a/0x40
> > )[   33.569871]  ? mtree_insert_range+0x86/0x170
> > )[   33.569871]  mtree_insert_range+0x86/0x170
> > )[   33.569871]  btrfs_lru_cache_store+0x5f/0x1c0
> > )[   33.569871]  cache_dir_utimes+0xac/0xe0
> > )[   33.569871]  finish_inode_if_needed+0x14d1/0x17c0
> > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > )[   33.569871]  changed_cb+0x1c1/0xbd0
> > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > )[   33.569871]  ? lock_release+0x145/0x2f0
> > )[   33.569871]  ? read_extent_buffer+0x92/0xb0
> > )[   33.569871]  btrfs_ioctl_send+0x1d6e/0x2080
> > )[   33.569871]  ? _btrfs_ioctl_send+0xf3/0x120
> > )[   33.569871]  ? rcu_read_lock_sched_held+0x36/0x70
> > )[   33.569871]  _btrfs_ioctl_send+0xd9/0x120
> > )[   33.569871]  ? __lock_acquire+0x397/0x1ef0
> > )[   33.569871]  btrfs_ioctl+0x11c1/0x3230
> > )[   33.569871]  ? lock_is_held_type+0xe3/0x140
> > )[   33.569871]  ? find_held_lock+0x2b/0x80
> > )[   33.569871]  ? lock_release+0x145/0x2f0
> > )[   33.569871]  __x64_sys_ioctl+0x80/0xb0
> > )[   33.569871]  do_syscall_64+0x34/0x80
> 
> Oddly I don't get anything reported here (and lockdep is enabled), but it's
> easy to see why it happens.
> 
> We're passing MT_FLAGS_LOCK_EXTERN to mt_init_flags(), as we don't care
> about locking in btrfs' send, and because of that mt_init_flags() does not
> initialize the spinlock:
> 
>    (maple_tree.h)
> 
>    static inline void mt_init_flags(struct maple_tree *mt, unsigned int flags)
>    {
>        mt->ma_flags = flags;
>        if (!mt_external_lock(mt))
>            spin_lock_init(&mt->ma_lock);
>        rcu_assign_pointer(mt->ma_root, NULL);
>    }
> 
> However at mtree_insert_range(), and other mtree_* functions, mtree_lock()
> is called unconditionally, which always tries to lock the spin lock, as it's
> defined as:
> 
>     #define mtree_lock(mt)		spin_lock((&(mt)->ma_lock))
> 
> But the spinlock was not initialized, as the whole point of MT_FLAGS_LOCK_EXTERN
> is to skip locking (unless I misunderstood its purpose).

It appears that there is a misunderstanding here.  The
MT_FLAGS_LOCK_EXTERN flag is to specify an external flag, not that you
don't care about or won't be locking.


> It seems mtree_lock() should be something like:
> 
>    static inline void mtree_lock(struct maple_tree *mt)
>    {
>        if (!mt_external_lock(mt))
>            spin_lock((&mt->ma_lock));
>    }
> 
> And the equivalent for mtree_unlock() as well.

The mtree_ family of function is part of the simple interface which
handles the locking for you.  If you are going to use an external lock,
then you should use the advanced interface.. but you have to use a lock.

Perhaps the mtree_lock/unlock() pair should be expanded to WARN_ON()
MT_FLAGS_LOCK_EXTERN to catch this issue?

Where did you get this idea about how the locking works?  Perhaps a
documentation change is also in order.

Thanks,
Liam
