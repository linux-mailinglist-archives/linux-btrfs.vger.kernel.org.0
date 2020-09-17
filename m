Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4026DFE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgIQPmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 11:42:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31094 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728097AbgIQPQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 11:16:22 -0400
X-Greylist: delayed 2795 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:16:08 EDT
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HEOM3t021946;
        Thu, 17 Sep 2020 07:28:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=agTxKaqAVoCtTsETVEdQq2b9zMJZlv9JPP0RSxlOtgE=;
 b=bQNbsCcYNZEICd+McZhkRlmXS2aLGVcFWsYSD6mAS9hufNAAkeJJ8Y0pPo1U7DGDcJmK
 ZQBsmeC6LyCVE88SNVIN72FytQj4ryeyCcvCFhqn73CHzQsEbPSfy2t8zMXikPTPSgQL
 +Z+C4TQPB6RkRIKHV9ak6u1ppnFwlvPAjrs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33kwpxjyju-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Sep 2020 07:28:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 07:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUgKTsOqJOIRrpHijezgnzO1ZZduSj0KV9KTfpO0sWC1JkqThegp0CXDotQ3ywiIltD/92TUFRRMyL6F55cYJX5i92DivbiE7oqre214L78bxlSoR3ffKBmf+om3393flDDStXo/cx9rfzzNMDeLLhoelF3Xrs9/Xl9aBeBtQo242z8+qhdv7jcf3HO/MoQpNNYnR4mtM2ZuExCI/KOd/WVmSbnRjXvX3z0ZsmfTOMc+Kg+iTa7VYYgSrPwPb97idMtapbc64lNhn8fOrxndoAjMa7T+j+qjglCmztUgtP1XYC96lB8aBZUjmU9WU9JB9+IB5tC7HvuFC7sfVoyRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agTxKaqAVoCtTsETVEdQq2b9zMJZlv9JPP0RSxlOtgE=;
 b=a/2Cq+GylMBbv7TkbUFmCdAHVdsAI9oxVmEPEseX8lBxyuEMumUZYe+xdFwejtRlsZsyvp7FhIa2xlq55dCgG4IPiDszSxynQ/11SI9juLWfp0uWawgV3HXFNQQ1YD/WxgkWazxfCbLaEiCdBZhaTPUMPlWVdYTpAJsS+tjynhX1vVu0TrJWa/MTMK6Le1EY0lp27HVBqGh7C83859TNysK8rJs2jSH6IHsX89ftYPVo60eHAj1+u9kbxch5LHkw4ciuqBe/4dDJiuTBhLuW5z9CbcMVjEUST++FAaRM1d8dg7dxCVnOikgzecJcwLT7nqXOlWdcqCAOvk9r6OWGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agTxKaqAVoCtTsETVEdQq2b9zMJZlv9JPP0RSxlOtgE=;
 b=BNVYfRD7LHNvwh/OxmWZAIFgkW1AMvmGs2s1E40SKCju/Xps0nZGw3G0MV2my8UVKmYlgnhrAs3+NRy5fjyY14cCE4dfY1mCTs5ebjDzfAZzJ0HaArwGcRi3kkeegnsnC7nl29+a35ZLTHP6TbWJwNbMvXD8s/hHqaLInl/Aw/I=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by MN2PR15MB3584.namprd15.prod.outlook.com (2603:10b6:208:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 14:28:18 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6%6]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 14:28:18 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Rik van Riel <riel@surriel.com>, Nick Terrell <terrelln@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        <squashfs-devel@lists.sourceforge.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Date:   Thu, 17 Sep 2020 10:28:15 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <2073A599-E7CA-476A-9B4B-7BC76B454B9A@fb.com>
In-Reply-To: <20200917100458.GA28031@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
 <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
 <20200916143046.GA13543@infradead.org>
 <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
 <20200916144618.GB16392@infradead.org>
 <4D04D534-75BD-4B13-81B9-31B9687A6B64@fb.com>
 <b1eec667d42849f757bbd55f014739509498a59d.camel@surriel.com>
 <20200917100458.GA28031@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:208:134::33) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.170.31] (2620:10d:c091:480::1:c860) by MN2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:208:134::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 17 Sep 2020 14:28:17 +0000
X-Mailer: MailMate (1.13.2r5673)
X-Originating-IP: [2620:10d:c091:480::1:c860]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47d3ac0e-6266-4753-a2c5-08d85b15ebf9
X-MS-TrafficTypeDiagnostic: MN2PR15MB3584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB3584BBAE97AA8C91CF08946ED33E0@MN2PR15MB3584.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kw/QaqoXQLlxXQGNtWvfnRH+mCG85BkJsCRRElu0Iq5oqlwzjuw1y7UEe166g8Hk66bgMwAJUAdd9VTp1QQ3DL2bveNs3B5brXLs2Gr27ihcyIfXjh9DjN6pJGdpLdEjZXZtdmQWuvN2/beopeWnaazIz/SLSFQazPD6j9oavWxmTMTMDo6h4s0uWXcHqMGtorPv7vhLQBM8gxDXi9ugz8udSimCz6NEX2wdW7spsF7JIO6Ar/QWHoSLD/F36NPghFTh1ZJj1HiBeYttTWUMB8mEetCCAvALHIAtEUgQ509dTsFoT49CzOch7pIXOckJcgUvxMtWiBuGt8yAeS3aL3UnJ537y9zPRACR5YYw94gwWaqBgNMlE0r09ZcelITp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(33656002)(7416002)(478600001)(8936002)(6486002)(66556008)(6916009)(16526019)(4326008)(36756003)(66946007)(316002)(66476007)(186003)(5660300002)(83380400001)(8676002)(54906003)(2616005)(86362001)(956004)(53546011)(2906002)(52116002)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: t8JpnR/Qn/k275ulHL0LUkuCb5OBPDlz4HZf//4saf9odDHQppwOpNIbf8Frq/vEDvJETcrStDkBpuD5Qmo0n9kkf1Pl8H00jxQZBCCyMfNzZ0JINUeF8tD0AjdETfd7FihKx4Ak+cSGxEHXg2D7Ao33v0da1wyUjSCdZ5cbO5derQIjPHQmRjI3/gfND0QuBEaCHbll8YJI/A4t/pzv+6lpHh5SvzDqSRl+cBt9FOsxmAaynXYhz1NepfShPCjXdSKbtYU+8kqCGfTTsZnMv9Xc8+AcQGa+P/yGvgSlBHD0Vi5InBNgS/R+/JvbJhlGODD6MyAVW+czn+02Jlaha90lA9Lxm2zU7ACrtfpD9pK0DnMDtEZBqhl7jh+frDc5NHiuVPMnJZUl4kroMW8FuiyKpwu5dUFKr+4QdgBj3/nuc9pN3xdj5CvyjQBxzvQkyxJxf5nfD0hAMS2wxy33osqe2wAr5xt13aSBufvXTKa+s3PZi0PN3vo6johnrIew+yWMip6h3ou/WhdhhfP39k7ylOXTHClg8CSbc52hHIs1BUdwRNb2p0Q/EFkX2xSW4S8bvYDkAn2V0pgwJ0RYk7QPPOQFicadVAdElS5AIHTm+ZMJbL6wVKbgVCQlfp+UL406WfCSJKG0sQaGfNn4gUMCPEZz7Jx/Hflhy8gL1XEwTVEiXLHWpjEJyitnm6hD
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d3ac0e-6266-4753-a2c5-08d85b15ebf9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 14:28:18.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2p4K+6TnJpnZ+K/tdCk3thuo8YrQDHf/Utkz6lHaISnzA5opWKjuNWKfJ4foMFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=780
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17 Sep 2020, at 6:04, Christoph Hellwig wrote:

> On Wed, Sep 16, 2020 at 09:35:51PM -0400, Rik van Riel wrote:
>>> One possibility is to have a kernel wrapper on top of the zstd API 
>>> to
>>> make it
>>> more ergonomic. I personally don???t really see the value in it, 
>>> since
>>> it adds
>>> another layer of indirection between zstd and the caller, but it
>>> could be done.
>>
>> Zstd would not be the first part of the kernel to
>> come from somewhere else, and have wrappers when
>> it gets integrated into the kernel. There certainly
>> is precedence there.
>>
>> It would be interesting to know what Christoph's
>> preference is.
>
> Yes, I think kernel wrappers would be a pretty sensible step forward.
> That also avoid the need to do strange upgrades to a new version,
> and instead we can just change APIs on a as-needed basis.

When we add wrappers, we end up creating a kernel specific API that 
doesn’t match the upstream zstd docs, and it doesn’t leverage as 
much of the zstd fuzzing and testing.

So we’re actually making kernel zstd slightly less usable in hopes 
that our kernel specific part of the API is familiar enough to us that 
it makes zstd more usable.  There’s no way to compare the two until 
the wrappers are done, but given the code today I’d prefer that we 
focus on making it really easy to track upstream.  I really understand 
Christoph’s side here, but I’d rather ride a camel with the group 
than go it alone.

I’d also much rather spend time on any problems where the structure of 
the zstd APIs don’t fit the kernel’s needs.  The btrfs streaming 
compression/decompression looks pretty clean to me, but I think Johannes 
mentioned some possibilities to improve things for zswap (optimizations 
for page-at-atime).  If there are places where the zstd memory 
management or error handling don’t fit naturally into the kernel, that 
would also be higher on my list.

Fixing those are probably going to be much easier if we’re close to 
the zstd upstream, again so that we can leverage testing and long term 
code maintenance done there.

-chris
