Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3588D2FDEC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 02:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbhAUBZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 20:25:13 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:22375 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731119AbhAUBWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 20:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611192049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2izCF/lvmFaLxftrckYtao/ODDIDacwiVccFWAEmRA=;
        b=KBaV3JiIWPpa18hwoFHfqBNlLpbp4Fx885qlAFoUj7Nzcu8eEXIJBkHTtNV/boZIpmoG+E
        vR+QuDibx23doeKqQQL6+0+KS+B9exGi61y2eSLGq3PfFl++Np8j3l49d3yE2/lNnXW4iQ
        KpU5jY5ng7TJrktaoNSugW+udKFwDUY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-r-3NML_IPb-vtZMMLr58jw-1; Thu, 21 Jan 2021 02:20:47 +0100
X-MC-Unique: r-3NML_IPb-vtZMMLr58jw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHbsnsFV8Ps03BMn8fPROPIvV823DMXpBK/7z1yqyfFeHYq6L5DAnBMD4lxGrI0SdsS2mkpaDKFYiR9gHU4TYZfZWQWtzaRiZ17dxRNnte+fyW2p2afr1n+wLFr56xL8jHqJsSBhO3G+aGYfxmMfuh1zx6Z6yws1YdDvjuUn2TsY+DjWYox5XaLPxdyNyts84Lw2CuiUxSllHvIlJRErOMTo18r15PPFEaDjAjfgrksZWp7lKofrH5lzz2DLjVrzwp9Dzlr9JT0l9cfJR6PppJxRW2yG1C2OyO6lHAX+zKvHvj4mmE7y5CA6vT5sVQLdqnyNe0/mIVH+EaQixrWfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUeh0aZkT5PTxaCVeHw/cCaf9DK5x2yqkXmSj2IMEqs=;
 b=NejqTNejS++TvAOorr8hT7g2ZXdUmnOaIdyYVfiqK33Vi/uTjIkFkHqZa8pewKtWVivIuQlVhVVp2kJLM4rOi6+GsKgX5VGWa4O9hkJDJ8ooX5tI3kGvjtcespXEEK3gYV83VLThDxlV0e7Sc0ZQCHf4iP28O2eq2kN2AgiYX3x1kq0qqsINnIeyLVoW0v7qD5RmCO79/q+hPipYFetbDqvx0pMmZJr64yUOnBWjKJahwpJMu6tOg+V0/EpfNc/FdJQUj6GQ1M5Ea0U/tuib0NB1DcxIyco5SPALKzC7j9p+8VG+I74hEvXHpA98PBJnGgLLzA9vSTdz/ViaXRytyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VI1PR0402MB3360.eurprd04.prod.outlook.com
 (2603:10a6:803:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Thu, 21 Jan
 2021 01:20:46 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 01:20:45 +0000
Subject: Re: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to
 handle subpage case
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-5-wqu@suse.com>
 <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
 <a58c8366-f3b5-a152-92be-c7252891a7c6@gmx.com>
 <8a1f085c-4701-c32f-37e6-72c99fa2074c@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <05a4af18-cc90-6695-6e92-6fba9d8aa44d@suse.com>
Date:   Thu, 21 Jan 2021 09:20:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <8a1f085c-4701-c32f-37e6-72c99fa2074c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::24) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:e0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.5 via Frontend Transport; Thu, 21 Jan 2021 01:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91925dc7-99e9-4e51-6fb4-08d8bdaac71b
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3360:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33604E4FFA9B909E5C254F3CD6A10@VI1PR0402MB3360.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cT3DtilW0G81Xl4EHnrQxaXhT4xNB71SYQj/ExuJmsppphsNgvD1as4RM5oij3fgSna3MnM3c/f+c6/BTN2YIlVhISRedTKPQiCqWY2Qsu26iDWHOBgfpWZgzSqk9KQFyFl/4vGjHt8a8QRid+z8QtKjZIUvKLinP1g19KhJ8ibtcj9tqyDg66TYUwkY/IWWExTvIipXWfdguByk8PUr6nor2EmJl5TABVImSf1JuT8L5rcR7Sj/G16iPXpBg4RLWBAVxQDSfmbpclTC+ADOI+hZsO0atQlZNrmMInjfDlwF+4IMEMQ59AcdnkMiFLM/Ek3tsKdaYn9JTJE6n/MdkU24W/A/jv/aDtIqlhfb+WLVKR93aoO7zCrNWJcvImPwl8hFl0/Ewu1Jl9HzL0q1W1eZ+q5lnYUJf66HdJOSkH67c/ltNauFx2F9R9815Ub8/QDluoPl6rQlWDVjX7xde/toLDoaxJYO0odn4yuZbdUf6m3FrWAyNky1NSH+85Uo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(53546011)(8936002)(31696002)(66556008)(478600001)(2906002)(83380400001)(36756003)(26005)(6486002)(186003)(16526019)(86362001)(956004)(8676002)(316002)(66946007)(52116002)(66476007)(6706004)(16576012)(31686004)(5660300002)(6666004)(110136005)(2616005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1Vmh/H79Xsk+5qP3KXkJf31i7Cmg/fekZZuvR8fe9V6D+N06ZcsJAO71wwdh?=
 =?us-ascii?Q?zsabkt9tfRbFUAPUZoGuaOdOJzV5mrV6d49pXdRCuUYPdcbfJW9pxh9z3ZB2?=
 =?us-ascii?Q?tJ7huT/cPXLWuYty9H7xmrhC7ffXj/1/5qfgSiTJ3mhhrMPa2C9Hf9exWAlP?=
 =?us-ascii?Q?QgJrdyOI6EhjVQjOWXNGYt0j/Xi695/wSZdAzZQ8E1DhkRkV62q5Mz1xbOJa?=
 =?us-ascii?Q?NRpFugUbguq/vSMcJUA34iQlXlwvD+RyTVpY6rZTsAKZnTHpFTyooOGSADMW?=
 =?us-ascii?Q?hjmUuhYx5+WH50xYnNUrGrdvGfVV712w60ymygkNBk3MAB/TGIHYeBxNB/VN?=
 =?us-ascii?Q?IUNmKfPr2D3WKiBXxTIg7EJs32Pa2woTAHNUZNQlPBC7nUPj6kOMwvptBjjR?=
 =?us-ascii?Q?wDfmRxO6Asva+ibzlD0agHshZtpSLYIiubUFf9Kp2/HE4M35JvhqmGl0sr8Y?=
 =?us-ascii?Q?uMTRxpSzUfXwXcztbsd8kZudnhNDkJ0joyr14x1S8i0DiKFLNgXh/TimfobP?=
 =?us-ascii?Q?vTyxTlX2qSLZ2cyVh0ctNqstgKepAon+0ppG8sZ5TH19l+sGdsIUBeep/Tj6?=
 =?us-ascii?Q?+RhOPee14WfeS5XyeAn1N9CYcTPVnrNKlhwgaS6nNFDgH9sWO87eJyGrgOMh?=
 =?us-ascii?Q?qw8sJ17LVblWCK7yTo+UZ/Nhs4rD9wVwyugYQcGlo7ftu24lQbdsvQh7KCX/?=
 =?us-ascii?Q?d5zthuNQ3ZLlKZ2H54MyTsY/uXHjoedN/2jAaddwW1OqI2pr4IVJtmWteWIu?=
 =?us-ascii?Q?LRji2C4TexOOkNme1riqdlDkZylxoJrOeK5J+9QTuCEu1rH5gUpRhYq+xYGR?=
 =?us-ascii?Q?DY6PH/7UOPgxjGZRmbv7YxA4UhMeYfRdJShAOqDh+9cGtNnUagK3kHLv1OaS?=
 =?us-ascii?Q?rxYwSZq98Kpksuv++k64spcrxWoR98VWaohah00fBf6ygxQkBttxIIzMEKok?=
 =?us-ascii?Q?cgVpsvP+AEofwOMkd6mqbAyMfX8Fke9Y/NB9s3t9StXNdSUuq4wNv1GVqAMH?=
 =?us-ascii?Q?OVmZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91925dc7-99e9-4e51-6fb4-08d8bdaac71b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 01:20:45.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLd91vFEq1MsnYisLIU66p7RlmF+PFR5oKs4R6ALzN/ElkIRmJhYaB6rcqHZr0O7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3360
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=8810:22, Josef Bacik wrote:
> On 1/19/21 7:27 PM, Qu Wenruo wrote:
>>
>>
>> On 2021/1/20 =E4=B8=8A=E5=8D=885:54, Josef Bacik wrote:
>>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>>> For subpage case, we need to allocate new memory for each metadata=20
>>>> page.
>>>>
>>>> So we need to:
>>>> - Allow attach_extent_buffer_page() to return int
>>>> =C2=A0=C2=A0 To indicate allocation failure
>>>>
>>>> - Prealloc btrfs_subpage structure for alloc_extent_buffer()
>>>> =C2=A0=C2=A0 We don't want to call memory allocation with spinlock hol=
d, so
>>>> =C2=A0=C2=A0 do preallocation before we acquire mapping->private_lock.
>>>>
>>>> - Handle subpage and regular case differently in
>>>> =C2=A0=C2=A0 attach_extent_buffer_page()
>>>> =C2=A0=C2=A0 For regular case, just do the usual thing.
>>>> =C2=A0=C2=A0 For subpage case, allocate new memory or use the prealloc=
ated=20
>>>> memory.
>>>>
>>>> For future subpage metadata, we will make more usage of radix tree to
>>>> grab extnet buffer.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0 fs/btrfs/extent_io.c | 75=20
>>>> ++++++++++++++++++++++++++++++++++++++------
>>>> =C2=A0 fs/btrfs/subpage.h=C2=A0=C2=A0 | 17 ++++++++++
>>>> =C2=A0 2 files changed, 82 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index a816ba4a8537..320731487ac0 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -24,6 +24,7 @@
>>>> =C2=A0 #include "rcu-string.h"
>>>> =C2=A0 #include "backref.h"
>>>> =C2=A0 #include "disk-io.h"
>>>> +#include "subpage.h"
>>>> =C2=A0 static struct kmem_cache *extent_state_cache;
>>>> =C2=A0 static struct kmem_cache *extent_buffer_cache;
>>>> @@ -3140,9 +3141,13 @@ static int submit_extent_page(unsigned int opf,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0 }
>>>> -static void attach_extent_buffer_page(struct extent_buffer *eb,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page=
)
>>>> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *page=
,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_subp=
age *prealloc)
>>>> =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D eb->fs_info;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> int ret =3D 0;
>>>
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the page is mapped to btree =
inode, we should hold the=20
>>>> private
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * lock to prevent race.
>>>> @@ -3152,10 +3157,32 @@ static void attach_extent_buffer_page(struct=20
>>>> extent_buffer *eb,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page->mapping)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_assert_=
held(&page->mapping->private_lock);
>>>> -=C2=A0=C2=A0=C2=A0 if (!PagePrivate(page))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attach_page_private(page, =
eb);
>>>> -=C2=A0=C2=A0=C2=A0 else
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(page->private !=3D=
 (unsigned long)eb);
>>>> +=C2=A0=C2=A0=C2=A0 if (fs_info->sectorsize =3D=3D PAGE_SIZE) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!PagePrivate(page))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at=
tach_page_private(page, eb);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WA=
RN_ON(page->private !=3D (unsigned long)eb);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Already mapped, just free prealloc */
>>>> +=C2=A0=C2=A0=C2=A0 if (PagePrivate(page)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(prealloc);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (prealloc) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Has preallocated memory=
 for subpage */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&prealloc->=
lock);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attach_page_private(page, =
prealloc);
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Do new allocation to at=
tach subpage */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_attach_subpa=
ge(fs_info, page);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>>
>>> Delete the above 2 lines.
>>>
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>
>>> return ret;
>>>
>>>> =C2=A0 }
>>>> =C2=A0 void set_page_extent_mapped(struct page *page)
>>>> @@ -5062,21 +5089,29 @@ struct extent_buffer=20
>>>> *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new =3D=3D NULL)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
>>>> +=C2=A0=C2=A0=C2=A0 set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>>> +
>>>
>>> Why are you doing this here?=C2=A0 It seems unrelated?=C2=A0 Looking at=
 the=20
>>> code it appears there's a reason for this later, but I had to go look=20
>>> to make sure I wasn't crazy, so at the very least it needs to be done=20
>>> in a more relevant patch.
>>
>> This is to handle case where we allocated a page but failed to=20
>> allocate subpage structure.
>>
>> In that case, btrfs_release_extent_buffer() will go different routine=20
>> to free the eb.
>>
>> Without UNMAPPED bit, it just go wrong without knowing it's a unmapped=20
>> eb.
>>
>> This change is mostly due to the extra failure pattern introduced by=20
>> the subpage memory allocation.
>>
>=20
> Yes, but my point is it's unrelated to this change, and in fact the=20
> problem exists outside of your changes, so it needs to be addressed in=20
> its own patch with its own changelog.

OK, that makes sense.

But it needs be determined after determining how to handle dummy extent=20
buffer first.
>=20
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D alloc_pag=
e(GFP_NOFS);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_release_extent_buffer(new);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attach_extent_buffer_page(=
new, p);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D attach_extent_buff=
er_page(new, p, NULL);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pu=
t_page(p);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_release_extent_buffer(new);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(PageDir=
ty(p));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SetPageUptodate=
(p);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new->pages[i] =
=3D p;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_page(page_=
address(p), page_address(src->pages[i]));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
>>>> -=C2=A0=C2=A0=C2=A0 set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return new;
>>>> =C2=A0 }
>>>> @@ -5308,12 +5343,28 @@ struct extent_buffer=20
>>>> *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_pages =3D num_extent_pages(eb);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++, index=
++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_subpage *prea=
lloc =3D NULL;
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D find_or_c=
reate_page(mapping, index,=20
>>>> GFP_NOFS|__GFP_NOFAIL);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 exists =3D ERR_PTR(-ENOMEM);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto free_eb;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Preallocate page->=
private for subpage case, so that
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we won't allocate =
memory with private_lock hold.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The memory will be=
 freed by attach_extent_buffer_page() or
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * freed manually if =
exit earlier.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_alloc_subpag=
e(fs_info, &prealloc);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
lock_page(p);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pu=
t_page(p);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ex=
ists =3D ERR_PTR(ret);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to free_eb;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>
>>> I realize that for subpage sectorsize we'll only have 1 page, but I'd=20
>>> still rather see this outside of the for loop, just for clarity sake.
>>
>> This is the trade-off.
>> Either we do every separately, sharing the minimal amount of code (and=20
>> need extra for loop for future 16K pages), or using the same loop=20
>> sacrifice a little readability.
>>
>> Here I'd say sharing more code is not that a big deal.
>>
>=20
> It's not a tradeoff, it's confusing.=C2=A0 What I'm suggesting is you do
>=20
> ret =3D btrfs_alloc_subpage(fs_info, &prealloc);
> if (ret) {
>  =C2=A0=C2=A0=C2=A0=C2=A0exists =3D ERR_PTR(ret);
>  =C2=A0=C2=A0=C2=A0=C2=A0goto free_eb;
> }
> for (i =3D 0; i < num_pages; i++, index++) {
> }

This means for later 16K page support, we still need to move=20
btrfs_alloc_subpage() into the loop.

But I totally understand your point here.

I'd put a comment here explaining why we can just allocate one subpage=20
structure here.

Thanks,
Qu

>=20
> free_eb:
>  =C2=A0=C2=A0=C2=A0=C2=A0kmem_cache_free(prealloc);
>=20
> The subpage portion is part of the eb itself, and there's one per eb,=20
> and thus should be pre-allocated outside of the loop that is doing the=20
> page lookup, as it's logically a different thing.=C2=A0 Thanks,
>=20
> Josef
>=20

