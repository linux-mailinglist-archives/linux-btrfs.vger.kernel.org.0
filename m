Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D700305B1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 13:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhA0MVQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 07:21:16 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:47603 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237029AbhA0MQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 07:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611749687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0NpeEGuwxRVKWj2ldUl05mhkKnByOgfz8qwwVAe7mQ=;
        b=TIS8sjXy80Bl2WFC2pTw+TIl369c2ablmYDRyimoujwSpmnHeVAOq/xKobNfjd66stiv5a
        iFXplr582klBr26uOq1afkmWNOYmbA3obHi2lKbGaBngZJHxDCI6+H95PA7/NXhUZVDLHA
        xL9fABrHpbAQgy1SlgkUl5A+ircL2Dk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-PL2BRQ7ONxC3E9DD8mBS-w-1; Wed, 27 Jan 2021 13:14:44 +0100
X-MC-Unique: PL2BRQ7ONxC3E9DD8mBS-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT0Lw6vYyrDc4IBpuelomGpgtrAErlWuWIPyMLQlrCzn0xLusNMC3B3FbamoDpGx5tz7/fU3Awh6vz+0nwToky7IU9Ch4Si+JC2jMxTjZdqd4RuGVao8TOara9g9M2BpVyON6LesZiPiZJ1XBIMAii37Rfk2NccI+cQHc/Wa5Kk84vnvulA12SDQtpZJWCsGPlAg3yhvLhZouat22b5iXpv6UD6nZa+0nXRsi9ON55U4tfE+W+Eq+A4jJ0XNsRb885D/1XZS/qvb/xd3sudNNVxL0jY3oNBeU4Dq18I4RW71atgLUGgBgVDXIVnolQrCYrrCCrG1/digrwvmS3RTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm83BEIDaYqujyjyzc7nSCu0Cgr24LC3VEHxdvSVAig=;
 b=EA50xORnDNsfD8sHXX7fcn7OqP2uL0NWIowZxdIml61v0CPTPoHl1C27XdpO/TihSAQM1rqyAgiMR0Ah3oYxGo8zrYsf9qQCJi8AgPvkheN22pP2BrNlMzaLtGG3Gds6QwwatsS4OFIyLLxAZkRohb2hz0Ctqbg7G2iAjGxQ9cJ1oOy+jK3ybQfctDo/lEn3JNn7uc+pSaU1CadNd8g0OkjN6666bGkmLFetCo3fWJJluNftEDqQjGUk0s+bcasJJ1MP8tMDqkIAStk1yCVw0js7p4M8YWuPEuSH3CZB/utZ1+4iolot4AYLBZzpLS5Vs5MhhUBDa5IFIjXfo3N/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VI1PR04MB7071.eurprd04.prod.outlook.com
 (2603:10a6:800:128::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 12:14:43 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 12:14:43 +0000
Subject: Re: [PATCH] fs: btrfs: Select SHA256 in Kconfig
To:     dsterba@suse.cz, matthias.bgg@kernel.org,
        Marek Behun <marek.behun@nic.cz>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
References: <20210127094231.11740-1-matthias.bgg@kernel.org>
 <20210127120146.GZ1993@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <5ae76d50-a52d-6f0e-1f23-335cb32f0371@suse.com>
Date:   Wed, 27 Jan 2021 20:14:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210127120146.GZ1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:33a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 12:14:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805fee36-5180-4c9f-7fc1-08d8c2bd20e0
X-MS-TrafficTypeDiagnostic: VI1PR04MB7071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70714DF29497532B22FEED2AD6BB0@VI1PR04MB7071.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71qI+YmM7XPetwLgpvLhcCZFPvfRnC/5qW5SiFQsbDfpIZyNJoPHxbNczgMUjspQ07uXrXk6IR7aNOXXBb10FhwwCD8Z/L208rMnvVa6TsQCLMxq9GzuCJ4+f6BWUPboKeW+tLUQ1Eooc8DWZ5oVMDEeEsvRT0MhXyFpiqXfe5teiDBe4vpdQWnMRBIBy3yAtHHwGoKoGFetbd6b7izsWMCum6xOkJyzZto2qvTaeQ4qEFAeyxvFG9wAlkgYpy4LaHMpuMJ/7Cpy78a+NVlgPzFj+7cCVKOZHwQ0vfbeWpwrV7sOA/N6Jn8uQYmXy1JPJ1w5cF/SxFTbJYg16bBqBeXJ+4EvBuRQYDHggKVQZNRLqKy60NFh+XpCrytmBesovE48uFHPB5SOyu1rhi+MEAWxld3hkeSeOySU1Hasc8Zkr41rmJpNk+XkdMczTtq+5f4elD+hn3OapkUpALlxsgmvIEx32Svb+3w0y62VSgxq59rVMtVTeJUzZBI8lrJqxpFY5MrIAoK+/XllAVNPQxiA+sTlX1FPMMBx/wZoJBRAaXDSf8HNB+j1Iked4MbMjTI+QfLkGZWYNxC0Y3njztIn/zfTWotSN99JDaqTexY6FASa6DkQ02KQCYLJQdNA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(376002)(396003)(136003)(86362001)(6706004)(2906002)(31696002)(8936002)(6486002)(6636002)(52116002)(316002)(66946007)(2616005)(16526019)(956004)(8676002)(110136005)(186003)(83380400001)(5660300002)(66556008)(66476007)(26005)(6666004)(16576012)(478600001)(36756003)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XK4jO0nNThksBbqyoAWYgxnmZTpCr4KZgyrWxaIMVJGPQKY6urh4wUIvY6tp?=
 =?us-ascii?Q?52Yxt4oidsE8EUX0xEhzq1iJ1yJARSy9DUOnwV0p0yD5uNLr8R28b1g3aiol?=
 =?us-ascii?Q?pXxdkdGWNqokTjDhlYFpvy7m8MibBpBOgeQQtSNg5B3Z10udrxDfoyuiXZDr?=
 =?us-ascii?Q?w8oyC02+lDI/b+qlgGvO59w2hM3KIk4WsV4tLPRTRTBtvNDNfGF9jXqhcV0T?=
 =?us-ascii?Q?9Gaj0xKdq3EU12QKWfFmeM3NCJZH2OezuBhi/f3l2Z9BQvzrpQ9hZp0MdX8s?=
 =?us-ascii?Q?dFtXkPwPtMRI2wMmP6iBCTBeDrEEi7zMJH1rFli+STMuemyovd8d7GeCW4/R?=
 =?us-ascii?Q?7jokEpZReIcKw+4g7MLok8hJPnU88JKRclPIYDs7XtrOJyH1qrVZpPhypqhn?=
 =?us-ascii?Q?aipRuN9voHVxVeI8CaxgN/n+rSv1UI7DTRPlx0qKsF2GPW7bE8wuGhA5LQNi?=
 =?us-ascii?Q?EH+Zmc4VqHYiyer7H43lDIWZFcjlCN4FR/gUhzA8s5F1tZPInQ2BFSt7UHIQ?=
 =?us-ascii?Q?uYCCZbTkMqtSfmN8YuHHB4M+QTHOxIW72LsBH7lBqtPkRO0L3TcsO6P9JcOo?=
 =?us-ascii?Q?kkKdZABBxCMT6JYZnZUb0o5v57YlmsP3qPQgVT5Di4NaAK1m3PiKcaa2xoa2?=
 =?us-ascii?Q?iFMLCe6BrlfJ4+N+4qTDmjRBaUUht1sX0F18saSG2j2/RXv2GFn082yjoI0n?=
 =?us-ascii?Q?eJExYfsq3sFkZcIlr//kY0P3Y1Xety6EoAqAMStHw2DRl32gVHoBNVvpUVWO?=
 =?us-ascii?Q?22W5/AG5ST7O5x7+h41RXRm0Hhs2a9T50/cBXHYy9L/2+wIeTVAnfbmAWvbs?=
 =?us-ascii?Q?3zYqLdRAF2OIbSQwISav64Jd1rq+oo0dwnJc0ZekJl3PM+ICO8m9IHSTqkPo?=
 =?us-ascii?Q?yxaHi/1okv3wrT7jnmEgieUy3iIO5igpwauhhi3PtACtFheEgoHK3P/8hvXB?=
 =?us-ascii?Q?qHqs5pNnD3jzef2mkldDat7AGIEsVlklzOy2kpQ16xtFHh1CrY4sniSqY7eY?=
 =?us-ascii?Q?2oRLU7ytXTcnlHryFv6zB5Uus7ZIla+QP6qLDUMFJHtEKY/3i3B+AhuMjpiB?=
 =?us-ascii?Q?Yjx5n+Fe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805fee36-5180-4c9f-7fc1-08d8c2bd20e0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 12:14:43.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45j6pR3rlIxKGbb1rLBh3fQVfcLM3YjTQHDgwgQhKQwCv/5y+yPzyNLp+g4olOoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7071
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/27 =E4=B8=8B=E5=8D=888:01, David Sterba wrote:
> On Wed, Jan 27, 2021 at 10:42:30AM +0100, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Since commit 565a4147d17a ("fs: btrfs: Add more checksum algorithms")
>> btrfs uses the sha256 checksum algorithm. But Kconfig lacks to select
>> it. This leads to compilation errors:
>> fs/built-in.o: In function `hash_sha256':
>> fs/btrfs/crypto/hash.c:25: undefined reference to `sha256_starts'
>> fs/btrfs/crypto/hash.c:26: undefined reference to `sha256_update'
>> fs/btrfs/crypto/hash.c:27: undefined reference to `sha256_finish'
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>=20
> So this is a fix for u-boot, got me confused and not for the first time
> as there's Kconfig and the same fs/btrfs/ directory structure.
>=20
Well, sometimes too unified file structure/code base can also be a problem.

Considering I'm also going to continue cross-porting more code to=20
U-boot, any recommendation on this?
Using different prefix?

Thanks,
Qu

