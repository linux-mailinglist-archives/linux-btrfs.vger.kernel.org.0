Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6812A26C648
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgIPRnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 13:43:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727286AbgIPRmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:42:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08GENV0n018359;
        Wed, 16 Sep 2020 07:43:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ieW6KiqQio3FA1DISC0MefsZ3JqqUiZEZ8eALwoClx8=;
 b=D9VAESAEh7AsemIaB6h4npVRqbN1iPK8AhCvq2QlBW7M5yXs8nt4sr7lTlgCU14DZAGq
 jYPpJIndKkDQMffwXtMOA5Jzl+BNXZq/B1aZmMUaQ3VQI+fFKPYXwKBXP1czhZaYKjks
 Ozuwyhake4p1W1MgLs0TlYsfGiy63bfrFmE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 33k5n7by1c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 07:43:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 07:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6T1An6FPlhIoZt1G1QBM/zjRh9iorinj5BcC/nJtFGI6YKMFJaliy0ygArUdqKwKHxUEVc3nK52my+Kg00/v3J5Tg1G5PUAhq08uX7bO/pMjTcCmcRk9U3atFRFSG/H7pLRqsBCEvi4OyXBfWawPkXdxdiwb/EGm2OiaeG9+6y06HmYZ6H52wTxkOX+A2F9HNAaCT9Q0V4YkAEm5sxO/mg+4qdtnzu/6YkUv2TbC3/ixxAz0HFMlTyU2WscvrBMRBrQyPdEYcnqXtW9AyzyNPQWfX6C3Z9J3lJqS+sUUz9Fcnw0GXGg74gr/GeICjOlfddetqtiCGw5buclC3nrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieW6KiqQio3FA1DISC0MefsZ3JqqUiZEZ8eALwoClx8=;
 b=emzkx2MbaH1TfxAsxGBVQOpURoFSg8njnFhilzVac6n7H89C87kx3iNSb4c/X67Ch+xNUb5fY38uXXQdPJg2rzTt4oWCDWkCWnBVBDcsFtmw/UZcwJgku7p1Ae0C2aD9+bsZO8xLeH6jEVe5o94ae2eXb0r6BiuBAB1wxR65os7RciZrjGzuqPIojjYDS58PPgbaTn2wYNUtxgL/Un/jGS5GEugThKQawp+ZlWJTqExQVazWvX5yNGryQ3I13AYR8tNvO/1dPDfglW9atdXFVYmQhZQdX/kUAaAoj9wXYkr6C4WlLwbKRq9WvDEeYxU1Ob+7SUbB+G991ogAhY+XuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieW6KiqQio3FA1DISC0MefsZ3JqqUiZEZ8eALwoClx8=;
 b=UcSJJOGyiI3t8pXZOob0475p3/isBOup23sq+NyqmwiGKlP8+4jvMePPV6//Crmpf6/+T9Ja14BJsj5Omol0Js76eMeXwk6ShVbUm3Frc9sVie3zhteaizsZ507ntk/eU6oD1oALa8T7zUzyCPmVLUWur1RODv7uUcV3XrTJ6hI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by BL0PR1501MB2130.namprd15.prod.outlook.com (2603:10b6:207:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 14:43:08 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::bd7a:9d1e:2fd0:34e6%6]) with mapi id 15.20.3391.014; Wed, 16 Sep 2020
 14:43:08 +0000
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
Date:   Wed, 16 Sep 2020 10:43:04 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
In-Reply-To: <20200916143046.GA13543@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
 <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
 <20200916143046.GA13543@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0062.namprd19.prod.outlook.com
 (2603:10b6:208:19b::39) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.1.1] (2620:10d:c091:480::1:60bc) by MN2PR19CA0062.namprd19.prod.outlook.com (2603:10b6:208:19b::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 14:43:06 +0000
X-Mailer: MailMate (1.13.2r5673)
X-Originating-IP: [2620:10d:c091:480::1:60bc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e45f87-73fb-4441-699c-08d85a4ed37c
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR1501MB2130335FAF87C026B464C3E9D3210@BL0PR1501MB2130.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOVi0X+Pq3jnBnkt2KSVJ+zdTmRmKJWAont4IYrkxwcOgLD2Yfd45ahGiobV2+WFp/NrtTdjEnSKtLh+aPaagBirq1fDfnhfnniOw+JLKFq4SRktUUEW3IiYcoolHxTVookSFqvtC5ekMdtYgm9nkLLdlPb4Etb8PplW/2vqNQk1WYOv1I0S2ykNdgZ1jpIYRLWaHyW1vc6OBQlrNUAuorCZCNt+q2thgzaY1KQ5IdPsO2Qd1pSMOuSjkMerPrxIyremGco2kjiSgOjM49bXLNS9hEIv1JL9bplhDp8dgUWexgLs+shoBHq8zMqK3Gg9Cs21/Od7eKy188px7sh0WRtp5hovF/FyOoacd70j+wdrdnUNzmLcyFr+k7bICnqi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(2616005)(956004)(8936002)(83380400001)(2906002)(478600001)(52116002)(86362001)(66946007)(66476007)(66556008)(316002)(53546011)(6916009)(4326008)(5660300002)(186003)(16526019)(54906003)(36756003)(8676002)(33656002)(6486002)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: GDIgRxwbLOJF5maRjeRld/E8FunLVHHIjfHJlMvmoMaWAIdp1oe5hIAZSh5kcyXod/7fFcqJ8J1sTM5RLFoojq9M+J2Hxi3QRK3UdQieAB48U4xCa9iAmhBkLq7ecQYVbU558H66MsV3QRZuyDDOZv4WLvgOvHyBp0v0jBGTduAT2mHGieaaa4WRZZC1KVIZLF+zGpSahCxR6KtOZ8nB5PQzuRpfUjvbtd/t3W1/AYFuz1yd4loLh6bc5+1VP8NhPQLfgMkyCjadmbuCTzWznQJZNRuk57pidxjH6SetKP4vUYzSnx51mSBql43PtaYZenyIZNCG5T7IHuRr9oNPEA+Tx2co+OzQJn1xqRX7WqanU/kACcF7Ab7NqXMMX0NR34cy9Guw2YbyAZ6kGuK0RT3y7kkjI/nB16EFR9qkHV5iDTdBrmShaa28d+QIQb5ilOrGCHxtBD08z2+d9c61+SLGWwzqn+f/TxWBz9cJBo2bPWcX2Eq7phmJmJIk8chu32VyLZ/+s3FnTbSzubcOvsqTnuLDk1XaW8Q/Y9wqNtp/Go1XiYum0nxmb27ghgLjHpD78rBXvmHFka2Mi1RUIFgeMJYHZ9k93USuGm0Nl56GWrIdj3nl9YHxp/uKvE3de6khRWBrPX9fQoARrrRC02x2Vdu2clYqMmKI16KpcztI1ImcTOq0JkpiM8lLkEP+
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e45f87-73fb-4441-699c-08d85a4ed37c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:43:07.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz4NptFbpw0ZxNiAtwEwmGHdo9ZQXTqy5PunPTvqcWr5VAX9Xy6f7GIUDBMjni/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2130
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160109
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16 Sep 2020, at 10:30, Christoph Hellwig wrote:

> On Wed, Sep 16, 2020 at 10:20:52AM -0400, Chris Mason wrote:
>> It???s not completely clear what you???re asking for here.  If the 
>> API
>> matches what???s in zstd-1.4.6, that seems like a reasonable way to 
>> label
>> it.  That???s what the upstream is for this code.
>>
>> I???m also not sure why we???re taking extra time to shit on the zstd
>> userspace package.  Can we please be constructive or at least 
>> actionable?
>
> Because it really doesn't matter that these crappy APIs he is
> introducing match anything, especially not something done as horribly
> as the zstd API.  We'll need to do this properly, and claiming
> compliance to some version of this lousy API is completely irrelevant
> for the kernel.

If the underlying goal is to closely follow the upstream of another 
project, we’re much better off using those APIs as provided.

Otherwise we just end up with drift and kernel-specific bugs that are 
harder to debug.  To the extent those APIs make us contort the kernel 
code, I’m sure Nick is interested in improving things in both places.

There are probably 1000 constructive ways to have that conversation.  
Please choose one of those instead of being an asshole.

-chris
