Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33B307433
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 11:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhA1KxT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 05:53:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:49954 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231226AbhA1KxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 05:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611831121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHNXSwUVA07yXv+BfWlys2LX5HtgfNv57YgaDrnLAi8=;
        b=ZU35T1YGSYZRy7W1bbo0LwVYnWZNVAZ5Wn0HIDgXzxO2PUNC8jKHRf0roFaa8Ek442aUuh
        vkWz3pACeDytEVSVi4Ts5yRTJIg5YqLsHG6bBEMLLJbauqkoD3fd2vQMAWtIBRsKOl1vGZ
        UzF6zAQIR6cpXRZMmOrIeFS6osdT3rs=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-ZZR9GEE5NLm_A9BR4awkUQ-1; Thu, 28 Jan 2021 11:51:58 +0100
X-MC-Unique: ZZR9GEE5NLm_A9BR4awkUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2bZQb2nVF/HHJnyEyuZ8wqd3vt/CZ1nOGdFklpec22SkyXMOf+MRJ2632Aa4CmIRNbBjXNyGsSp7sHq7YzwrEWsO9AwVISlx2G0fYqpRWyNrZAoMdjQoCwFCOdohaBuVkfzZ03rqlHPtSFebzMvGMLvYXp5KFu82ZVRFEv8ukKcJe2wAozu5KSHLEq/Ntd+yd21WfL/cLfgzhrqb+QQweu+Zl4BCMcEKYgeXd0mcS7FA+Vu+TPGjfbAYNefSBiAG8KTJ+IQ0fm4P+3w6iOaWdhdoGM7kRU/h9kXKZalNreEb6b6qIU8LJow9NjSjCXNzxcUGhNg8yYrCYKXmL2r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWOfd97j+p4xKDvdl5QN3CyfPBorL1VSE5zlirbzKHo=;
 b=P8z5i3/1DwetrEe4zIlrS+YxvhTRWO8+Y7qA8y8BkHr7xA2fqSJhYboa2Xc3jBsjjM3RTf8ZQugcZjfNwTfOn+Bsi01iQGTCJMgD0cl92EVkMJ4cScVS+jbb2phApL/JI/YmWWiBhZBFjrhjK8Z9pvrNas3oxQ0Z3gZzKmAQMXOOOCtIiuz4kv7LHKzKJoCgghTsTJY5GRSumWD9Rsoq0Q3oBYnivkazEvNB2mrZrTiHSugdMzqA8pKNdsk/TPPTChE8JYGn4iRhjuolelgmeHB0aLOHy4dhoINb2YbCN0HVgaIEfatNufecC/NJbCLVrYlomGURvGMEhU1g+GbeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VE1PR04MB7279.eurprd04.prod.outlook.com
 (2603:10a6:800:1a5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 10:51:57 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 10:51:56 +0000
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <a448ea77-957b-b7fc-c05a-29a4a13352b8@toxicpanda.com>
 <e370c8d6-8559-c8a0-9938-160e003e933b@gmx.com>
 <20210128103452.GG1993@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <4e3811e2-a639-fc40-390e-afe9efef0e29@suse.com>
Date:   Thu, 28 Jan 2021 18:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210128103452.GG1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: PH0PR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:510:f::33) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by PH0PR07CA0088.namprd07.prod.outlook.com (2603:10b6:510:f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 10:51:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68882ca1-6069-4ed2-4b6a-08d8c37abb20
X-MS-TrafficTypeDiagnostic: VE1PR04MB7279:
X-Microsoft-Antispam-PRVS: <VE1PR04MB72796AF002E52480E2B44F81D6BA9@VE1PR04MB7279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJs6vsh53cchKiF1w8PmbvQjqXvK1tbdiQnUBKEjNRmljpgFz+F73vx/bl+KwMJh2vhJUXKmB+G4Ohc9m5Fbq8T9HFIBg+1kteCTXAXXDP9fNJiTdjrigkct5kzTGV5jA1fZv6WPVTXP6dG8dmtd6j3a3iNFzmijXbZk/e941UsQs4rseGlDYFVPOGGmS8tbVfOl9nzO1pXPOnxnAmstK54lqAux8pz3mRlcP7/BWkfWSeGExRnNyz24mn5+wOXuC45729JBsTPoUAHK5T90BVok6d4Svsw1x1WspQUr5q19pMpo8oJ2vrXKsQbY2bBGqqxf3E9PPAiW347AYV2GM4NEZVI9RwAmJGD3yHjT7HFy1XMrc4r0ufP/huxc1mJSInsN42MTU6DYvVi5PIOsTBKUOvIzWg6n6c+hJMkjoemLdj8KofLodKOJGV5uYCAtkBBMlD+/v/UnRJNHsxxCizN4brZl9vmQQXrjeOSxPqqOsSB7qFbozxL7s7ud9my9F3cxPaPYIF20D7SVckTEnRZJBp2Mn5nIvf+tyxMLLykKrLP5qyFv39HJypHyZmNwmghO6d19p7N4F+9PjzLPfcUh3RaF4HxeIu7RW7sCo2doi3rdQEpLHhKM6okpQkFw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39840400004)(136003)(396003)(376002)(52116002)(2906002)(6666004)(86362001)(66476007)(8936002)(66946007)(36756003)(66556008)(5660300002)(6706004)(2616005)(956004)(31696002)(186003)(26005)(16526019)(6486002)(16576012)(83380400001)(110136005)(316002)(478600001)(8676002)(31686004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J/yWPkpnshZxpVB+b9zJGDYmeUdwwLMLlLiwC11/DCSs82RJF63OtCXok64R?=
 =?us-ascii?Q?N8ZiLPoqcHmBauiRCyaoiKc4JnLR/Rs4FZbwl6iUGyz2gEU69XF3rrtXjfBt?=
 =?us-ascii?Q?zlmkfKutfxdYmOo99b7dbORKT+fGY4uYo+zTjMZqOLJv8pR3vzYlLK+Ira9i?=
 =?us-ascii?Q?goAaYJtBmPOp/yNwoXgiE+B7VR24VEtK9NvYGcs3I5m1MT4/GqDLTZ6ryPkL?=
 =?us-ascii?Q?7FxTbwunhULOr23Ws/VTQLkyVFqb4aiJPWsCd6cwdQaJNvEzmMvrZRmYvlkb?=
 =?us-ascii?Q?vPrxe/KaCVG40E5Ac6ID0lsVtdHNK0CBmNgp+BalQ/qaszYz2eSDJhetvs2J?=
 =?us-ascii?Q?QNcbl/kPVhL5VuFxddIn4VtJpthtmS/RoDnRMOBimufhXC/OE9TwrFKQUzer?=
 =?us-ascii?Q?in2+LUZgXyJluWiR78AYOhL1ZIziaLrQUUsbiPFZCNUGCUET2C/+YYzj1wue?=
 =?us-ascii?Q?c0Krwr/DEpgynzmiI6WRFFP8UHz6WuzUz5djU9MP53kpLeAh2eFmzsajrncD?=
 =?us-ascii?Q?u+rPfm8XT28Fr7NEMSrT1fBGVDhDQdTGxj4T4R4Bs9mq+WjCCkb878u94ZhW?=
 =?us-ascii?Q?9iC78D2DikOpfiCpp9kYN1jE0YWOVrY0YtqDYDDKPXp/ijhPASCRtsCbRkF7?=
 =?us-ascii?Q?7d6taeKJQaNF+NQlV38F8aOvmzIorIckCuueX9aKQYNuxTRVIbb8mTL2ghLK?=
 =?us-ascii?Q?nnUf0hpbEjaz2bGghXj2FCiQ0qe080yQwttadkkiHuB6Q7AOISzu6dBA/L5d?=
 =?us-ascii?Q?L8CJPP5xYjyvR3gHrTZ70jCktIuVUrtndFC2CrLVVGTcCJxg7mhxho70m50j?=
 =?us-ascii?Q?2z8z5xHN3eC/ixWd5p73LF258iW2Ny6oJi/S3FqDCAXe6EV19l4pY2UdMMJO?=
 =?us-ascii?Q?11/RWetlwbTAZKxw0ZsuTO7VtoL5Cdl2l8NYok3vYPyver5K7pNMqPciqmnl?=
 =?us-ascii?Q?lismqWIlL5HruhViq7YLwzl4jnDFFhvjxTLF5XfrasGKAKhwGRPe0jyijQSJ?=
 =?us-ascii?Q?U2H3kLuFs+eiWDKTi7lsv89XxluQpoiK93XZnNzagK4XqJzcK5fYYrxxc4jb?=
 =?us-ascii?Q?LdsXcaTy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68882ca1-6069-4ed2-4b6a-08d8c37abb20
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 10:51:56.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFGKZTTs87MRFGMiME0aqdmCDPrSTWX6u4av5jmjZQzMTGTv3PRXtQJMdF49K1n4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/28 =E4=B8=8B=E5=8D=886:34, David Sterba wrote:
> On Thu, Jan 28, 2021 at 08:30:21AM +0800, Qu Wenruo wrote:
>>>>  =C2=A0=C2=A0 btrfs: support subpage for extent buffer page release
>>>
>>> I don't have this patch in my inbox so I can't reply to it directly, bu=
t
>>> you include refcount.h, but then use normal atomics.=C2=A0 Please used =
the
>>> actual refcount_t, as it gets us all the debugging stuff that makes
>>> finding problems much easier.=C2=A0 Thanks,
>>
>> My bad, my initial plan is to use refcount, but the use case has valid 0
>> refcount usage, thus refcount is not good here.
>=20
> In case you need to shift the "0" you can use refcount_dec_not_one or
> refcount_inc/dec_not_zero, but I haven't seen the code so don't know if
> this applies in your case.
>=20

In the code, what we want is inc on zero, which will cause warning on=20
refcount. (initial subpage allocation has zero ref, then increased to=20
one when one eb is attached to the page)

But maybe I can change the timing so that we can use refcount.
Current code uses ASSERT()s to prevent underflow, so it would be=20
sufficient for current code base though.

I'll investigate more time on this topic in next update.

Thanks,
Qu

