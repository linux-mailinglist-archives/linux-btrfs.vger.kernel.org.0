Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05F22AC485
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgKITCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 14:02:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729499AbgKITCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 14:02:17 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A9IkkrF029856;
        Mon, 9 Nov 2020 11:01:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uUx68W1m/8eobVREYYtDo2r2JVQp1vcJGillZ24qmYo=;
 b=hl44ChDmEvscaPjhi/qJcTwCvNRf/3apXIVzCHUEW7T/u0a84/VUhE47Ne26JnV1raVx
 etwXXCbdZ+h4uLOlk6VAhjTnQbvMR10XDLcIwzeSLPpp1ri3p59aIJE3TPwHqH+ujSsQ
 /8nFWazCyKiDgBBKMQOtFM/cDcS31aQPNmA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pch9p715-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Nov 2020 11:01:50 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 11:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoDp9X6bv+reb2VkVSoOes1e2av9G6g5xLytEQmbzedf3XGnMW+zvmu9mj6gyZxNRPthAz8avXipp4SoW0lKcyzzDka8Yl4cLP+C0Sv3lL0V8oONKrJhRfVaSBzbYgoW/JIvJ8aXUa5AOk0DyI4Yw+zh93MLtS/fJvwbxYjqDqp3f8YfogbTkU7fnZRHD4X8hAPn+9kuboCVqrJqOmiX52Q2ZXLLE+MPb/r+EKCDXyovJVNIguDUyZMerTteHbdf8Ej0oG1RKsJXyIZn+jnSW/cAx8tyDyDAqpvumHkBuaapHEEeYtFyHUZGFpGAStusQBnI0N89ENCZQPUZsziU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUx68W1m/8eobVREYYtDo2r2JVQp1vcJGillZ24qmYo=;
 b=eO8vzZkjSn11tajoRmcnamdmgDji56jeL5Pv3fMHyr8OIbBMIxHfa/UezEeHz+zHpzppLGHd4JoPcH7dQloCp3Z3QyhPSYNN5p7oEsz0BAzkqIyviKs8G7nbSfylumbBHKvDBINpSPMdIdQGR2JgOkW6qUibE0khEU1PBUqAtxRR1OmcqIK3xMJ7ZBcYuyjPuPTk7vGibBlo/uPzM+BhzcLm+bS+D2KFg+jT5ZTEjSRN5bPLuN1/gaO1P0n9PKl15l/+Jm5a5rfky9VQ73f8lhZuGLlIFr1+LPn3+DBhKUTU65Iw2jIel6bCIrsrJ2ENWDow07gUmWw6HYVnmjlU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUx68W1m/8eobVREYYtDo2r2JVQp1vcJGillZ24qmYo=;
 b=OS+SIkasGP7JijugLnkCQ7haueteGt9GBZSNWu5xDW9oNSeR8Yh64ImKqli7Yv5Mdyg0nic1CIqa1QA8Zh7yTwsNHxRZEtCrF46XmkREnSbAIPKPTufLAnK8KWnRxroW1zAP3DMkzM3F0/ndMVMWsXW1DGLgPV+xYxJ/71KmZ5c=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SN7PR15MB4208.namprd15.prod.outlook.com (2603:10b6:806:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 19:01:46 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::988:2e42:b8ca:d347]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::988:2e42:b8ca:d347%9]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 19:01:46 +0000
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
Date:   Mon, 09 Nov 2020 14:01:41 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <D9338FE4-1518-4C7B-8C23-DBDC542DAC35@fb.com>
In-Reply-To: <20201106183846.GA28005@infradead.org>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-2-nickrterrell@gmail.com>
 <20201106183846.GA28005@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:4280]
X-ClientProxiedBy: MN2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:208:23e::23) To SA0PR15MB3839.namprd15.prod.outlook.com
 (2603:10b6:806:83::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.60.106] (2620:10d:c091:480::1:4280) by MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 19:01:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94506b6b-fa3d-4053-2b2f-08d884e1e7ab
X-MS-TrafficTypeDiagnostic: SN7PR15MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB4208A4C50179B40EE646951AD3EA0@SN7PR15MB4208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAPplgbAkZN0LiGHM1OB8c8J0ESznYV9tfrfcNHJ1kgGC1W58orPD9bnJw+/lg2wc04WWWa1E9K+C3AKffbW/h8Y6p2Q65xjLvfQpwfkpvQcRd/1KTMzK8k1qBjCuM2OxQYFG6PAklaSFWwKQxh/CernTKsw583khUAZZwdHH1ls5Hu0tpJXYfh2srbss+b+REvgs1ZmuC4mMYZ9mN354WRdUGpm/wys3s7pMkFP/08OsjRnpIgwTH7fYbsT+81TUn4BVjtKqbIsD/ui8019F3OieapNzCg9V8Pkm/pA/X/CKMxLKOerKYX+4ST+D4mpo211Lr68as9YIucjv8A9zJl6G5R1Hy9TK2p6do2SiK+ccs+l+uZOT7maUIrjst9E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(6666004)(83380400001)(4744005)(186003)(16526019)(54906003)(478600001)(52116002)(956004)(53546011)(2616005)(316002)(33656002)(6916009)(2906002)(6486002)(5660300002)(4326008)(8936002)(36756003)(86362001)(66946007)(7416002)(8676002)(66476007)(66556008)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: LKuWbyihmdcXQvAe71W+fd7Heu6swaXoYKG2POtQMZW0vEzD6bxP9Op+h0RHjiuVc09PNbpGfVQYrWgRH0uoYdP4kDVzVsyzDlIHs9nNbFoWdjB6H0G3JVptBYUzrCln4xRbOVXM4DUdsEHf9w5QUNjDyzlU7PifKDpSSpvraJOnaf6Eu2uE4NeP15ooIUWzWn5A4JbrnY2Z/xrp7rioouKapFmcB+7OixQ0dcucWaUMh11T4Ob8+fE2Awzs4Ma8Wtv3e4+bg00AjO25/6389QBViS1qWs4zjmdg7VAergnMnfNL5jALZK/7w+OP9FM+JlmSU4IjK6ZZlyaWf3cpE7O2x/XzUWt118y2yUoRD/uRAJ25f01HYsrUbJX4U7UiZVRhrnx6qf4dZouLp90QugXVenEM/POV5XrNzg+UYTY25NAStbww9iAa9ZUDujwbM6n+FEXuYGCU8r2ASkqtGLrOu4qtqq/cdmEBormDIBLT6t3Lq8H32HbL5BMJ+Ywmq3jUaTcOYAJ724ow1Ezyna+D/wV+TGDPfFLAnZNk9UOlzySjAtUvZmKRxMYkPcur/hlYNvwhi+bzy4WN3wmvN2Je4VvSlUEEvfiOIw2WjJXgySmHRYaNunR7sluyXTiO6S4vikHkoyQDgCMGsVecOBdBJn36odsSvw8rd1RoF6qzL9Zer14q6//Ujrc1JzGXqXEZFqrS01s6xVAz03krXoFu3EHET5uQPWDkqjp7z4fq2ShMHZVY2GMrwhS2Rk3vy0hv3w64YKcgY98TlnCrTSTfGswrWKKXR2oT3tpeYsf3RUlegGftWGzpQcg+RlBS/Qk+ktXXfRJW29HI8LLTckcjJ0v6VO0/au9unt76SeLqegAgwz6dmhKCzCx1n7hbm3eyNNZ7/p5CyTvXwUGbTa61gqJy9wTha1dMC4NGov0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94506b6b-fa3d-4053-2b2f-08d884e1e7ab
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 19:01:46.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbcnldzPRJkF4amd8+XG37Ft3P+vVfE1wXGLyV3vyFDwlMkv/eXoTvAcsPX2zQLu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_12:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=743
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6 Nov 2020, at 13:38, Christoph Hellwig wrote:

> You just keep resedning this crap, don't you?  Haven't you been told
> multiple times to provide a proper kernel API by now?

You do consistently ask for a shim layer, but you haven’t explained 
what we gain by diverging from the documented and tested API of the 
upstream zstd project.  It’s an important discussion given that we 
hope to regularly update the kernel side as they make improvements in 
zstd.

The only benefit described so far seems to be camelcase related, but if 
there are problems in the API beyond that, I haven’t seen you describe 
them.  I don’t think the camelcase alone justifies the added costs of 
the shim.

-chris
