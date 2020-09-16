Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54126CDAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 23:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIPVDm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 17:03:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25410 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgIPQPB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GEK016023430;
        Wed, 16 Sep 2020 07:21:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=etrroz13TiaCLCbsxTpY39RWGrIeG0ErfV5IujprH5I=;
 b=L4NR1zlywwWuh8wQQNjjRW1fX0iLj3ZpYyE5GUytW7UlHU8UqRHIB4m13ZJHuvZ2R41K
 BpIT89U8kXv7PzyfrcQ451uuoTrzcf+T2H98uycZ3L6CT9uTuI+ZtOT+8FJmkH2chY2m
 ihAYinv7DTm3SK111RCjrn7G7ntN7oI1mOc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5nbkucn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 07:21:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 07:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCtTig7gClBSwiAE42XiLqviAxPkMJbI3uCtm4qzv4cMBUYe82xXgnOmlI2kpQaNq2p5b5GkDLpOZc71hKzZ3B23CkqDJzdpWu5DrbGdmkSmdh5DHbu6voOpYAug5n/7zMZS2ZjI20i6/BHQlZDC4R1k5DbW9YHvCHbciH/AEcUW8O5Bh2QSaN13KK2HnDzPGNAOroKQoHl3r5KYPYopeK7sFcA9lxEMAqXVBIp50FYBnvOjdD/lkg90AH1CJWQgg0TqAiWVK4eYAYm3f0qJzkyD4imh8rqKOl/YRRoHzZLBiYIPr9jepaSx487GIdu8a8ZT7HSkYxbnDcKVGIhsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etrroz13TiaCLCbsxTpY39RWGrIeG0ErfV5IujprH5I=;
 b=dUlq1Otm0IMrT8h0EMrPdvpaVtOhxR8QElHZATk5ubvgWxy2YZROfSa+zQYXyOPN/m9FOn0EP0083INFIMKVIfdE8FhSnhbfeCdCBQS6Jpe6zJc6X+g0DhcdH4dsTYuJlGQABftgegMrp19NemHb8cYhTfIEQ1NZCsliXJjxuKTtQiR+jqDIHr3Mnq19zPgOBPFwDyTleACr1yTzqs1FAqSLI2ixXvXeBZOhk46Ddz8KxstPXQFB1qOCAb/AwajWn1qopMtOsqFWKeU+hyyy4/4aA37oAK83vyWe2WlDOkokMNsF++FHoczYWXOeUgGIGaZFp4Is6MJhvWkCbWfNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etrroz13TiaCLCbsxTpY39RWGrIeG0ErfV5IujprH5I=;
 b=PbtVbKx494ZapUNkekJxc6Iy4c9SH2NH7lGOJ+YMPp3O7YahSieXuKcxBGVV98cX5vSUGuF9Yj9CCrrrqUAaoHfmSlXhONrLqUXaNCvlGBhaFWduNYg1JSAf84REKC1sMGEh0VifjEI0UmqUXiBRmDzctpe5QcWAbogfoNunAZw=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by MN2PR15MB3728.namprd15.prod.outlook.com (2603:10b6:208:1b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 14:20:56 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6%6]) with mapi id 15.20.3391.014; Wed, 16 Sep 2020
 14:20:56 +0000
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
Date:   Wed, 16 Sep 2020 10:20:52 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
In-Reply-To: <20200916084958.GC31608@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.1.1] (2620:10d:c091:480::1:60bc) by MN2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:208:1b4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Wed, 16 Sep 2020 14:20:54 +0000
X-Mailer: MailMate (1.13.2r5673)
X-Originating-IP: [2620:10d:c091:480::1:60bc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96fcc2d2-e1af-4bf3-22b5-08d85a4bb97a
X-MS-TrafficTypeDiagnostic: MN2PR15MB3728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB3728DD06D46CCF28FCFECFFFD3210@MN2PR15MB3728.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy/NdzNrQQ3GlHtolqw2vPdqIg0tXKt0yh4XLW+qm45TOLSO6TFm0474HrQqo/wi3eqw9vbqscO93CDNIEej4YqkIKbFhyL4IUH8cO3+W+WMdvX8EJFwbAwrKAl9XvTvajhnedIxHK9zFu7J0trerimsq16F+c6u+UrIFV7SDLXuyKIHiH0HiB6Nquy8d4jVumrUctwbvoS7Nxl+8Cqw0cNOBD/RW8va7ZAYFwdnseHdXdRHTSmEw2sHfLUVImrUP/Aq3OigG6LwN+9mz06mxIDb+OJr43Yg0V4x7u6qQ7iqUfaCJt1quOuPOo92wxh5CuqN+gEO0ychvK7tqFoyQP+tttrAtNjlvAal37hl7Z3xM59E/vq5KEeK8t4289GHLQTAKhw+xnvaaDifdUAsJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(36756003)(478600001)(16526019)(186003)(33656002)(8936002)(86362001)(4326008)(2616005)(8676002)(956004)(53546011)(6486002)(4744005)(316002)(54906003)(5660300002)(6916009)(66476007)(66556008)(52116002)(2906002)(66946007)(556444002)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gg8rPw6CIqkqO5cHtdfgcbj6Qm6AzI3RA00aJzdvYZ1HDZagpcPM2Dnray9ComqldpXJ6Iq8z99PPCKNOZrBSfPWKJ5ksDIco1WaqYxDcWH9+ibq5HT6zd+zQrMPYehqrsESV6NmUw7E/uv4E0J0AH/fMF/998UDHUDCMxki7kc9YPx5MlnCO0mnRTcMiTc3VhS4DKiQFaXWYur/dWMzXntS2/oTagyc+MyAVQij3iurra+gqmj/ndOsxON3ahLTDWyjH61pOknMCCNweH4DHk6ugyJD/RVKfWD7x7ZOM6VSamm4iK0NGqV1iD5xE+oNn0Nz2J8sp/33A+zDbsMnxtB5LyHbFPDcOx0wczCroALXOSyXyzXmzmOStw1RxIvaL5qmeIZG/4xCXRgLn42LnLuQIBIAgVgjGRpagCJEnUF4ZV0hYijF4hWJLR4dsnFzAm0Z47dr0OMTm8naKmUFyIyCe11Ve0e5yknDXMwRQlOoR+z2KbB579MdKSstDjpWw8pnnxa+kJsQPMMIhzDKetbCO/PHBR8LZYS9MviUD6xTzK1OiasA73lgY0rP80ItL2N+8upLN8ZDVjsY/s2UAxxiJ/zVCdbJk7v7q5ClA3U6eA+Xkvo1C7MD+Byves7jGfTIRcqc0IHCaXqdPODww3oJLiH+Zb/lq8zmSrA9hjdkQCPmmILNeFvIeUPMDON7
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fcc2d2-e1af-4bf3-22b5-08d85a4bb97a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:20:55.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSkC3A7D43p5YUjlhtAVCYLGPjh03ZQjWSkMlPf31Y2Z5M7p4neS6Wumx7RABP+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxlogscore=863 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160108
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16 Sep 2020, at 4:49, Christoph Hellwig wrote:

> On Tue, Sep 15, 2020 at 08:42:59PM -0700, Nick Terrell wrote:
>> From: Nick Terrell <terrelln@fb.com>
>>
>> Move away from the compatibility wrapper to the zstd-1.4.6 API. This
>> code is functionally equivalent.
>
> Again, please use sensible names  And no one gives a fuck if this bad
> API is "zstd-1.4.6" as the Linux kernel uses its own APIs, not some
> random mess from a badly written userspace package.

Hi Christoph,

It’s not completely clear what you’re asking for here.  If the API 
matches what’s in zstd-1.4.6, that seems like a reasonable way to 
label it.  That’s what the upstream is for this code.

I’m also not sure why we’re taking extra time to shit on the zstd 
userspace package.  Can we please be constructive or at least 
actionable?

-chris
