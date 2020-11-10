Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE96C2ADF44
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgKJT0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 14:26:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10836 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbgKJT0D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 14:26:03 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJOxoA025717;
        Tue, 10 Nov 2020 11:25:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cBT5PR2JeGBNUgAPb7RHkRJPn3QqofArtbbke2qQbkY=;
 b=msc3StAFH+W6bBr+zuVBndumVaI4yqHYQYQgsyhsHlLrJGr7ixbhzFMFdYKI9bEx1MKT
 n1GA+qLUafiYenm2NZyCd3KDmO8fdHv4C9rrzg9/KhuHMQjzspoUfQH/by3oBnTYIc47
 edtp79llzZmH3wk97lGdBEqRwc7+fsCRKpA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pch9vg4x-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Nov 2020 11:25:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 11:24:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEUoDXtE2ZsfXp1VJTH1CP2k+MVqFpwx38BZrKM5Pm12ZQTFAJ8wMJir5zZInEhsJth0BncWZWFuJesXA5HvxnAN+HABVxWp/uI7lht5vfAnQL98i5HAXCmB/VzoRAeiKlT/4/knuHMDzVRW/e5n/qP6zvBiRnYnIUnel4XMdIkemG/BriGLLwUOqDz3PcHcbu+jHsyY7WXamjnDuDuDz9FaO90fzHvNFc0OJP+Z1qnM3SrvJ/lo1ekNiYhaLjpFGvtUCsxwdb9K2HAvbh8xG9il98PIcxwy1CMWn1M2CMt9ObkG98x6ttsvJUb+s+KIhQanCrFv4C3StRxA+M3zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBT5PR2JeGBNUgAPb7RHkRJPn3QqofArtbbke2qQbkY=;
 b=FwtJ5mSSonRsdX+J6EAF1uMRD9sfGmBRakJpqd5I/ZTfXdKPjTr+JV1eS4pBs5+17nj4ZRrUIPaDV5LeiITC0hOORvbhQXjec+QiRkA7DYteE3EaLSBXrUu8QpQNurS5XPdRW56trN+9PwPn+MbxN7wDZ79CPZcwsPVcDLWdIFAe2bUQ2/5auQf3i1rqhGolNLiF3QR/lOzdYuzje2qfnXBX9ZOriPejhHudtXijyLp2MqvfHgyHCUCrcml6Lm+awsBaTwKahxbfWG9kIRQIN9AbGA8eG5un6GQwIa5c9IfqQbkTDWw4pGu5WYmH+0pLOkMZq6MfJn9KXe/Qh/uQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBT5PR2JeGBNUgAPb7RHkRJPn3QqofArtbbke2qQbkY=;
 b=LiJFqrOH6fa7il+3qzsAGz0KC+SfZkj2rZdwoBXANjSaZDK07uuXv19hoSqoh95V9hUsaTia8mgFMdp6/V0MCDozP+19rjI69eZPloZ2uQbDEFmg4Qqg9HPilfrB8NIydHcHmWz27Le7ROk8np0alGTbX2J3uicObLd0lxC1/GE=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SN6PR15MB2301.namprd15.prod.outlook.com (2603:10b6:805:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 19:24:40 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::988:2e42:b8ca:d347]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::988:2e42:b8ca:d347%9]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 19:24:40 +0000
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
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/9] lib: zstd: Add zstd compatibility wrapper
Date:   Tue, 10 Nov 2020 14:24:35 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <4ED61269-0F19-46EB-ACE3-C6D81E0A9136@fb.com>
In-Reply-To: <20201110183953.GA10656@infradead.org>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-2-nickrterrell@gmail.com>
 <20201106183846.GA28005@infradead.org>
 <D9338FE4-1518-4C7B-8C23-DBDC542DAC35@fb.com>
 <20201110183953.GA10656@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; markup=markdown
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.101.208.204]
X-ClientProxiedBy: CH2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:610:38::26) To SA0PR15MB3839.namprd15.prod.outlook.com
 (2603:10b6:806:83::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.196] (172.101.208.204) by CH2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:610:38::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Tue, 10 Nov 2020 19:24:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37346c73-784a-4a6c-ebbb-08d885ae4528
X-MS-TrafficTypeDiagnostic: SN6PR15MB2301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2301D2B9E8C6804C722D7FE8D3E90@SN6PR15MB2301.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsRwZQFU5v+llwo6OOtvCfaXSiaZR2+ylhzRvgAh6YEDUb5VD9KStuLQsLsA+JRG1xNlLEXlttQLzjSoLW4JbCSWg/LnXzh2+vSPOfh4eL0UYPUOYTbI2g87nQq4hg4EFJKlATdHExlabYsODgnQeQAmmNgZOhtUUnNYdRD2mjPR3NlHe0feStmBoJkLARzgnzPZf+QGq0cyMYkejYRF6Td2khoHWd8p56uMX2Vyr6akbl9th3ANYjJ11yiDXiI5WZKicm9VOlj8QybwdRSpAgjbDD+UYAvppOH/TZWefJ8+QIbm1C1BrHw0/gMT1KBHIGEml5XZoFS3NrPKdGakXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(54906003)(52116002)(7416002)(2616005)(478600001)(5660300002)(956004)(26005)(53546011)(8676002)(66946007)(8936002)(66556008)(66476007)(6486002)(6916009)(6666004)(16526019)(83380400001)(186003)(2906002)(36756003)(16576012)(86362001)(316002)(33656002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sjX+3CXvKprmGU/WqNOyOMXLWtSptHiweM17SUX/en8GudQMQFFWiDwK3SkYD+xJ6nmVZ23O41bMymSZhYXaS62sAn02782m9Ui8E+rVbcnXb4KvUUvKctDizhyq7PARpMUIfzdoe+jupqNok5sVZTaCJLg42CtE4eddVlY53joo+U0EOzMwlp27iC3Fh+yG5nz99Jpo+yxhjKZM9PQMVE9ecJiKm0/t/nIZHTxL8/DEgefViPRp+ZvKriLyEUaAtyJvxSWXFtxjs2VCQxdNuR869k2BQYJ9aZrqWr3FTwjlcqkSLmEryqhmMKCaUzW/Uph6+JMJInJYpcA1+iNUIKXkI1ca8LmOc/JCszWHhBkb1Av6L8fQDiKptxr/NpKvsDN28CK3kGiSozX2SX/NtO3fTr8K4L93j+khQb4NBjFEXIIUZ91bHXH1NXQD7UIMKR+utj3EJsYDiMy8Bmb4i3pLmOJl+7M8pq82gmgdY/BxbO2hEE2i6w6pAvNmtca++kHdbWJivXoVfVsB2AGxbK9Ps0bn0F/4Gk/sF36rMJrkDOKMBR3UyZNZspppNKiiAnsIuh5CcKZWbcSkH3TSerQBowVBfzY1dWsznAaRf6W6fB3z2FR7yn/xaTP9Q/KKYGP9I0mLZEr6IRJyoOa/xscbS/9TY5cJH8QIg58qDigPfXXsjZ6Mb8I9ct9NOmbMEq+ANKNsGMXCPbCzTQ0idrUWZFgZSurcgNRuFZfHv0S7ahbrTIMItP3KF7UqVg14UFfbkWManDuMkRwz17sYGnP98RC+3abDWD+WE0QqTIWb0060sgTOGRt2OxomvoQJEmKPdWe3n6yindNeY5Ep9EfF57FUOAP0m+OsiyjuOdsLVeok8vlE8Dq2c1tlwnt8NkdbHUJdCrz9uWBD/fcneA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37346c73-784a-4a6c-ebbb-08d885ae4528
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 19:24:40.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATvWmPIS1uKdEm4nOglBBH5ITeq4GLYdNJY0EOXxhgusFVO+HHh4F1eq/abxaDnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2301
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=974
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10 Nov 2020, at 13:39, Christoph Hellwig wrote:

> On Mon, Nov 09, 2020 at 02:01:41PM -0500, Chris Mason wrote:
>> You do consistently ask for a shim layer, but you haven???t explained 
>> what
>> we gain by diverging from the documented and tested API of the 
>> upstream zstd
>> project.  It???s an important discussion given that we hope to 
>> regularly
>> update the kernel side as they make improvements in zstd.
>
> An API that looks like every other kernel API, and doesn't cause 
> endless
> amount of churn because someone decided they need a new API flavor of
> the day.  Btw, I'm not asking for a shim layer - that was the 
> compromise
> we ended up with.
>
> If zstd folks can't maintain a sane code base maybe we should just 
> drop
> this childish churning code base from the tree.

I think APIs change based on the needs of the project.  We do this all 
the time in the kernel, and we don’t think twice about updating users 
of the API as needed.  The zstd changes look awkward and large today 
because it’ a long time period, but we’ve all been pretty vocal in 
the past about the importance of being able to advance APIs.

-chris
