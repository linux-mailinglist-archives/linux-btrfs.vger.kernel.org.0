Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8226C281463
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbgJBNnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 09:43:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387768AbgJBNnq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 09:43:46 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092DhAZ8012646;
        Fri, 2 Oct 2020 06:43:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 mime-version; s=facebook; bh=J+YdCu8/gBpXoHZ9M9fM+xboKuiKNgfwLD9imvik/eo=;
 b=hqifwXY7FNQSRb5YXduDwKc+kneOgrtliIl6zNhUTfGWDEX1AhktYSZRL/068vSqR724
 ht5un1ZMmfcaIXttGkTYmPPGvTtXx9mEzWE8rYGbaC05ifJxgtUS8f9oCxeNdonRYty9
 +XUJch7QAmhK9//Cv1bJ3gWfbfrjGYw7bSA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33x0n214w8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Oct 2020 06:43:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 06:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jK844WG8sIdUIXcCMyANtqzLaEhhewjSxQ1Y8zzZQImXoIHu71LcmeP436cftp/gwPvEUOggc4liTK0D/lxWE4mIEAFyQwCOVf064GfXBmILMrLYEzB7LVdys1o0DwozXJ5qPvxp6I9oDu4SXr+0T/oy0S2ixkHaQDhDQlPphD7ueNK8lei4x/d2TxJtmLeuecjhc69jI0VDxONdKYNFAN0wZoAWe/DnCAFr1hWvGRXen0mi0vWLi9KTZAYz5YwusZh0KrUh4NzJ9ZwTztwvq6946ugvNk635t7RrWBDEA4cIBGAv2eE+15LA3zFDu7l0xh227SOdFagNm2FfKOFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+YdCu8/gBpXoHZ9M9fM+xboKuiKNgfwLD9imvik/eo=;
 b=J9RX3RUtmtCs5jAEppSSm1W0ICUCoDEMUR1Zjy3oq4CziQ6DuARYKcbnTOVcjl/pOMo4BKcWeq4MVggWdk0dvKenq9KaG0eIZAu/EavYSSQAWQT2ICknI8Woyx6Oa66YWgeqiGybETlKs32AVsKWMRvSbsVmFpTzWYo4vNTwKaOBy5aNL8VXUlHFm33MWNo9HaxGxCOnU/0miKR9n7iFPamyjLYTACy14idRzoRm3Kc90iaM/PCkfwytKu4nt9CQ5LPUqtchyjOVb4Zz942nkEPThp6aDkbTuGHSS4bXBdn2xc58nLbbabaEpZM4Iw4IQnreirPkkAK3/ALiW9Jpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+YdCu8/gBpXoHZ9M9fM+xboKuiKNgfwLD9imvik/eo=;
 b=kdGXPLLd2CLA2zoc8pgNeFr9+UR7ORtfPM6Hl2AT6EuNfY/Byc6atvq3RQX9TuexOWHLmgBduTeMDjIY1tGE5PhW6OE9Q+FMx1PEpAPb6sMI8utxjwBV4rBlpHwVFBwUGU84GPYktzPbuNCHj1lgKcHPTWIYL0+qEgJGCuX1WXw=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by BLAPR15MB3825.namprd15.prod.outlook.com (2603:10b6:208:27c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 13:42:32 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::31f2:99f0:d90d:76ab]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::31f2:99f0:d90d:76ab%7]) with mapi id 15.20.3433.038; Fri, 2 Oct 2020
 13:42:32 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Nick Terrell <terrelln@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        <squashfs-devel@lists.sourceforge.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/9] Update to zstd-1.4.6
Date:   Fri, 02 Oct 2020 09:42:29 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <3E8AACF8-5168-4D19-B47F-8611B292D540@fb.com>
In-Reply-To: <20201002065454.GA29993@infradead.org>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
 <20200930065336.GA13656@infradead.org>
 <8743398B-0BBB-424E-A6A7-9D8AE4EFE8ED@fb.com>
 <20201002065454.GA29993@infradead.org>
Content-Type: text/plain; format=flowed
X-Originating-IP: [2620:10d:c091:480::1:504f]
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.10.224] (2620:10d:c091:480::1:504f) by MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Fri, 2 Oct 2020 13:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649b3745-3c8b-4014-f79b-08d866d9033f
X-MS-TrafficTypeDiagnostic: BLAPR15MB3825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR15MB382523E849622A96D357D538D3310@BLAPR15MB3825.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyQeqWgUGDE0KgpPHpxBp7wnE9wRM4Fwyjoqc1sKZGq3wjQPiZL76jR/V6lJVX2TZ/DtLVqR7VdYCt9ZLIqfp3BKRLg9mnfcbs25nZqvtTbuss2vpMe2eoc2egqg7Dt3lAzZVptOrV8PrnFi5nZRTjlCJ9mF3dQMZLyoPkzIKthjh6R3KMtFWGSLaAQhyGv0sn6NkUwQmH+Y5YORsX7uD1fNAUaIvInnje7bSQvDwYfbsplMXPi7PhkN8mA6BTfTTxUtP5/e8b0mA2m2UIOR86XaqSLGWHvsvP0y+Pajq18giKhA1a13xnxdKgaiRGnb/JYRW6A2Jt6RB3E2YahVulncKsUBq7rUmYrQxqZ8wM1fH7hMJp3CHERgGShFogO9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39860400002)(136003)(366004)(956004)(2616005)(53546011)(36756003)(7416002)(8936002)(6486002)(186003)(16526019)(33656002)(6916009)(2906002)(52116002)(8676002)(66476007)(66556008)(4326008)(66946007)(86362001)(316002)(54906003)(5660300002)(478600001)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: I3ctoQiMgj4rWODCXNc9qsJUYEJPf9GEoJ6K4AvAziDBmAomIJwkcGqOrzncQpXIw/o5zzZ17W/y1JF/98Gf9qBzKDHkfjCl/b7RbWb95b+aSS1lBuXeOTG1Tg9W+9IGjzROjL0p6uaSP44RDIXFR06tXOzLEHuA+Y3mydS+HNp5PXIUqMlJXOrNV5SitbVoaV9BSNu2ubFYK6KcJDZ6VoXVUMisoInC2tPXB7lkir2PbsjxmsRD9cp/1T4NMJw5NofUBBt9AjiA0K4lYV24LvSOJGsyPL0jiATPbBnDhKyoGJDZEhPRV4i3XvLgG4/SU6QoeEJfY3rLFLKM0ijAS64P3GKwJnENTPCOxgciF4oWorpu9GmMWe/tDxIoVT/ZjbW8DzNrrlt8RggHTPlKAmVtsJhJFAf1FmONACnxxWOSNFaevJgbsufwwo0lf7xANC3cjlcCid7n4akYpW8MCGhmcg2ztX1vvNBkhzlnj9eCg3pznbUfNpm32sTidD2PHlTPU2A2q1Po6APxgZjCjxg8EmXzIBRt89VicL/6R+km01YkAXUjYFJHj8SCZ5ZbzMBbOjy4oVT3z1ldbQSvRXPLAJYYqXBpJm6K53LvwvQg2D+PvSz7vNF3nXKucKZGR1JlPSLjwOjVtkS6kVNpkArtG4ExnPO9+yiLdUGvN0jFAxKN1fBvcUu8hmLrx1sj
X-MS-Exchange-CrossTenant-Network-Message-Id: 649b3745-3c8b-4014-f79b-08d866d9033f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 13:42:32.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAQNArK7NmQyAyCOUbcs2FCALEaH25eIcUlFcHQgzEfY6PYrMXi0EokvyZ5GaNts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3825
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_06:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=799 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2 Oct 2020, at 2:54, Christoph Hellwig wrote:

> On Wed, Sep 30, 2020 at 08:05:45PM +0000, Nick Terrell wrote:
>>
>>
>>> On Sep 29, 2020, at 11:53 PM, Christoph Hellwig <hch@infradead.org> 
>>> wrote:
>>>
>>> As you keep resend this I keep retelling you that should not do it.
>>> Please provide a proper Linux API, and switch to that.  Versioned 
>>> APIs
>>> have absolutely no business in the Linux kernel.
>>
>> The API is not versioned. We provide a stable ABI for a large section 
>> of our API,
>> and the parts that aren???t ABI stable don???t change in semantics, 
>> and undergo long
>> deprecation periods before being removed.
>>
>> The change of callers is a one-time change to transition from the 
>> existing API
>> in the kernel, which was never upstream's API, to upstream's API.
>
> Again, please transition it to a sane kernel API.  We don't have an
> "upstream" in this case.

The upstream is the zstd project where all this code originates, and 
where the active development takes place.  As Eric Biggers pointed out, 
it also receives a lot of Q/A separate from the kernel.  I think we gain 
a great deal by leveraging the testing and documentation of the zstd 
project in the kernel interfaces we use.

We lose some consistency with the kernel coding style, but we gain the 
ability to search for docs, issues, and fixes directly against the zstd 
project and git repo.

-chris
