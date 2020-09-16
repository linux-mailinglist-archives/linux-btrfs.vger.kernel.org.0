Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A151C26CC8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIPUpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 16:45:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbgIPRDY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:24 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08GEhx9R027417;
        Wed, 16 Sep 2020 08:01:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F/IgRPmpLMsVBjyhQhLJOo0Q/FZh4fDXDjxSC9qGoHo=;
 b=NkrakJVGCBV8D+8XukpYdcMNJWqvrFPp8bzyebTLGoTAyTk2vT2Uh8Sd7WdFD6lKKnGe
 k4eVBbGUMpIKpK9VY2/INs83awWB71maWu7hV14lCM/I+3/uoACGJK2Xd5IzCX5SzcSi
 vNDO4IocTQkcwPg++I+ZqUOUUfNs5FkbO9M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33k5p841fv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 08:01:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 08:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdvaMz+o0qb44on2a3DOirlshW4MmGaJX6VVZelokkbC6K45LBSr/fDEVqLCFwlYZjDWXoNmsFyGjWkS1K2kBDQ/bzC5dx4brnUgCN/FLvz685n6NUAIDQEFMam7VMEnUPdX0gzhozqB9JxYP27dDGrP/45J5qyOopADRXekXVxzTMFvL5nY+c+bXDTyO4FNaK3CZ91x5Fy6oaBk++MaKPcd2p0zJmbYPvN4u64hcqjEzVT6q1i1DWZXclQXMvEqD6h64nXmJuY+7WQ33ketutnvzs/L2LqTEgAiiTAY8BruMlBH/TWTV5G2CXR6Yk/a9b0KMLhc4Gi06m/SLiVQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/IgRPmpLMsVBjyhQhLJOo0Q/FZh4fDXDjxSC9qGoHo=;
 b=G5rt4FffP4+xP+06f5YzSCvlNWubPD3BI4Vf/x5CBU9SI46UIojjTP8uESjsyAeidqd7rbx38dkLc5OpxfJDxhzOSYzFiKW3W5uKRZJW81w70VFZNnD8Bh5CFnHNE+omWW9ll1UPDYfvca9IoVoUt+SjuHJrIQaKC+3+Hhpu4LvQ/Th2GjrUHGI8ziTezAiNi3k5Is7X9+lXsSQvA1sCyYgATSCi+2iGbBER8O+EgXccsMjFd+ReHQheRC0dlnUiJ53Tjp5/RLty0APUknrfbbxMHXEpmfLr3UwOz/N5CTnhse9BEb/fxJjD/1QegVwoAFvS8is9CNqah6YZsxIx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/IgRPmpLMsVBjyhQhLJOo0Q/FZh4fDXDjxSC9qGoHo=;
 b=iULZA98C2l15yyxeVp3IiUrFDZ5r6Y09Wk4GUflNkUBEyVjPHw8UrrM18QgktV4TdZz1EqWNRVsrYlxCKNuUlBdvh3YsjlRRMTiQx7jjQHiTLZzDoV7q8ulP3IMJ2+B0h6q19UCdU2r9ZDQMQBpnvY85LVnWo9HB4rJEY/Y6mn4=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by MN2PR15MB3632.namprd15.prod.outlook.com (2603:10b6:208:1b9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 15:01:15 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6%6]) with mapi id 15.20.3391.014; Wed, 16 Sep 2020
 15:01:14 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <squashfs-devel@lists.sourceforge.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Date:   Wed, 16 Sep 2020 11:01:11 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <E412C519-27B8-495D-BF52-3EC4D161D1A0@fb.com>
In-Reply-To: <20200916144618.GB16392@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
 <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
 <20200916143046.GA13543@infradead.org>
 <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
 <20200916144618.GB16392@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:208:178::48) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.1.1] (2620:10d:c091:480::1:60bc) by MN2PR19CA0035.namprd19.prod.outlook.com (2603:10b6:208:178::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 15:01:13 +0000
X-Mailer: MailMate (1.13.2r5673)
X-Originating-IP: [2620:10d:c091:480::1:60bc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5342ea6-4555-4981-e137-08d85a515b7c
X-MS-TrafficTypeDiagnostic: MN2PR15MB3632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB36322E9AEEC651D0BE9A36D7D3210@MN2PR15MB3632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ezEEsuSyX4bWwVSZ6S85A4Wo4yocrgyAmHwrylqjDMdAvzZzO8bwZio/xjg1ful5QIX3rY21Q14pz3Svcxncp//cCobSzfvQF/Wb5r1Ed5nmrZvbdMOXT/g2QbpXbNW1XMm33FQ8Ja4dapMNUg9+f+vu9n8Ive8Cvlw+OwMlUco04wCq20SOV7q4oFv5mDWKkGuHcXp5LYvlQTmBtsPM93VMNqowvOtE4OP51NNyHHmx1tZ0Olw+hXVosBZGsJcGovgjNA2469pY2BvHzx82l6Ij4C8NZz6Dq/2RKmXiZssi1+6lirhN6qxm9r+ZHgcV+Le5V3St0KZ9k8uugwldUpn850EFk7z7LAl6mVBUVS4KaBAAvOjxF3Xbvby2ln+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(86362001)(956004)(53546011)(2616005)(6486002)(478600001)(4326008)(36756003)(6916009)(316002)(33656002)(186003)(54906003)(8676002)(2906002)(52116002)(66946007)(16526019)(66476007)(66556008)(8936002)(5660300002)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UpN9Ci5fPFDFL1tl0HIleiIBIxSbVYJvNjV3E8o4ESJwOCTEInI1Mh5p9bkma4Az3VGdf3opI88N0xXiBkY3/SzhJDyLRHiHGL5oxsz/qsAmcf2HPQ+x2iMt+G1qfKjwM9MoB+YFnY7vxcZuWv2bunsyzGMiY6mpTK8WQQGdJLUNSMV+rZqAnF9HGXXEcY+HG7Z/uYKinvkfXg2ysgngKacRo8r+yPfwyyF+mBiP4OHpys9+1bGHHXOZChQYVHUCoaX2opdiqTlwtz9VBXjvES8Pqn0JBSln9v1mIT8mw5UFJ8fTrcwR1SHqRSCGtosB0Uq76n8yJ+uXJnI1Jgq5UIjVZISbuPAnaqZRkWJSQJ6HCy+fwXENzgOBb1O948ahQoBY+/YrH+Cd6Y/TUOwNnWwjxFhVzPLYb7E6JXUcdhfQS542c/zBoeTY2rW271rvaGBXaLFxi2aUNheUtVyxMAKFp83QIMXopDi10L2nOH8o62vV66mDnjXKKfrOt8ibmttgzQK3yr9WHLcReKIxpBQmAoILt8NDOVAf/7sIfu8VCa/zLDXi/hn1UdebNGpDsn37GOAyF2cy+vF9of6jvHscISX8d5lXxjYU0PeK2rnHesnEtZruAJC0Y/+3W1kAglgvFNWqmaz7itL7TA3PiBQgVhuh7tLQKHysfgDThwJLmg3Ofxoaxec6xk5Zcpho
X-MS-Exchange-CrossTenant-Network-Message-Id: e5342ea6-4555-4981-e137-08d85a515b7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 15:01:14.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2ZStGvYFaveCFoYaH/rWEZjjLyI6Woln2N6yd/ftPyPGSoWibIe2m7070BccSnq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=786
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009160112
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16 Sep 2020, at 10:46, Christoph Hellwig wrote:

> On Wed, Sep 16, 2020 at 10:43:04AM -0400, Chris Mason wrote:
>> Otherwise we just end up with drift and kernel-specific bugs that are 
>> harder
>> to debug.  To the extent those APIs make us contort the kernel code, 
>> I???m
>> sure Nick is interested in improving things in both places.
>
> Seriously, we do not care elsewhere.  Why would zlib be any different?

Is the zlib upstream active?  Or trying to sync active development with 
the kernel?  I’d suggest the same path for them if they were.

>
>> There are probably 1000 constructive ways to have that conversation.  
>> Please
>> choose one of those instead of being an asshole.
>
> I think you are the asshole here by ignoring the practices we are 
> using
> elsewhere and think your employers pet project is somehow special.  It
> is not, and claiming so is everything but constructive.

I’m happy to advocate for more constructive discussion for anyone’s 
project.  I tend to pick threads where I have context and I know the 
people involved.

The kernel best practices are pragmatic.  As one of many users of any 
established-non-kernel project, there’s a compromise between the APIs 
they are using for a broad base of users and us.  I’m sure they are 
interested in improving life for all of their users, while also 
improving maintainability for us.

-chris

