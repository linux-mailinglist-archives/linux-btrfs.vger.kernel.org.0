Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCEB3B5DE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhF1MWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:22:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:56926 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232939AbhF1MWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624882783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0GedsWt5LeCsxBjzTJtosUf5BOtt6SnxtzKSeGHpkc=;
        b=N2nPcyNVNZQcFeisUhcqAO2u5Rlwom1FUu2sg1XMVePv3uwh0WA7ge9FanF23l+eaS2X59
        064zwbLBWY3/j8HoJuqlJVn93FGVbK4LjSup9858SlFU30jVOzmsW40/+gkhGtw7cZA9Kp
        clAIfc933buSJpUAi9ZJWd5HAsND0Do=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-FC-HSgG2OLCMVjn2S9c8_A-1;
 Mon, 28 Jun 2021 14:19:42 +0200
X-MC-Unique: FC-HSgG2OLCMVjn2S9c8_A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnsUOHY1viFEkF/nblAjEUssnGPWoCZXmYFsUGqA4ex34GYLulsg6s0cy2/UI1CU/HAIi2YVTGdijstBH3sJ9G7/8aececqMXoGxDD+mckAq4529ZkCHm4frVMuuSm7QKYkA5ltFQ0EjDcslPd5+sF0olZM/Q5RXOEkF7QoULE3kK2i5HOsWFDh0PiZRYoGJV5QT8XoN59Yd60kUb1lfjH8lurF34zJSZaR1Bw7PPuSw+luYI0UjrBSimlIXiyHoc3D8Z7AwXB8ZYlElaM81qvTBm3HSTS17VrdBltGTD+q7wLeSZGYos9QnRK9qgSqC4awyOnHGUNBuBDr5izaWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCNiJ86kDBWbqdJs99LblVxkdqotAoFIX2D5GxhNPa4=;
 b=N5GVBB7qc+IbMHS3zCZG4wYTDDX5VYiXqIUlzjdsbQXs4hewv+lEBH85fTXgIJI3C8l4S4uCHaeNKHyZhG5CQm6puePY/3sBns9xK0iWgT7QmF/fI6sj8LNBr0hHvzEDEaxXuc/5ReDpKqENZMLvcgkTiIA3ggBT3LBbF6M3cF2e2xlgxVGYGw+/2h2e7wGs6pM2sj4iztCLz83VbifcMYTAnyPictQOAwcUi6hkVD+DkK/M3/J7A3ugSV4jVddN7ajzkGK9UWhR/nZG8ac7NLRaMu1uDMHztfZDQbYozBs8cweyrh8ydVXflmlVITH5ZxhwsMBeQ0YVDUwo6ZdBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: yulong.com; dkim=none (message not signed)
 header.d=none;yulong.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4902.eurprd04.prod.outlook.com (2603:10a6:20b:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 12:19:40 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 12:19:40 +0000
To:     dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
 <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210628120435.GC2610@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Message-ID: <ce9083c7-ed1c-1248-484b-3b8650734f52@suse.com>
Date:   Mon, 28 Jun 2021 20:19:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210628120435.GC2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 12:19:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c2f037-cd81-4730-8290-08d93a2f00ea
X-MS-TrafficTypeDiagnostic: AM6PR04MB4902:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4902A4DA2AF8F062A6B21AC5D6039@AM6PR04MB4902.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q8bwS3DNwZPTYzOh4kJfiVm3BczxpfGbmIQagnQ5PHehcLFMo8Kql1hlv/WgZEJSUNiSEHk/wWw/aH+eWsix72EJFCkrjoUV3ep8PJEpejj3WXHtfLeuwnWJfsJm4/h8cl/RyWosV6Vuqhq5oSK/OIvRkqHr/J4GOjiM9AdMozxIhycRW0jfkL2p43Fl5Yp5KabslbAk/WygAkNpUOifUPlMdJhcDe9mOPsjp7kx0mTh7+x0ksoXH7+0IYB11Iej1Tu5QgJeU1lqTb+lya65SX9uO+Jo6sklvvYxK7h/uqD8Hs5XG9xMh0QYJjlS+UQedAbgY3P14x1Wh7WF2mRPv6M7CGjrrHZSnWAtFVS37lx2PIAiRQ55vpQhyKjZj/K/38RGTW5oIrKHhBOWLII8XIvnWwnLM36sEvvk1MlkFMtKeCxiYPqc4mTTbwhAY0GYLWTe8XM7BY+o1gFldiYk5XKT48F/CHvmmANcsLP3EJb27bxL0pqtyLu73rffaxsJ4hAzoSuiV2Tslic+gCYD47IYz9d3IvDEazacX7P3ZQqj8tfRin69ee9OEBLGFHJB0jbJy+uBRUa86TFrkBi1557Peco3MYIDlttABdKKgYddmPUBYUzS7kVMmhvOdWkQvGnXn8zyeKWePnBbMoqX4lfl/VJ+DOuJ+azUF9WrsIHXuTczdz1pcDJcZzBsTRGcXvTWn6jCAjqIa2xDc4Etazb6Y7wbqY9I5d0VOCMJXOYHNe84okJEH3C1DwS+RhDKOHSpr0KxR+QD838dBbjDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(2616005)(6706004)(316002)(8936002)(66946007)(83380400001)(66556008)(36756003)(38100700002)(66476007)(16576012)(110136005)(956004)(8676002)(6486002)(921005)(6666004)(31686004)(26005)(186003)(31696002)(478600001)(86362001)(5660300002)(2906002)(16526019)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cenV2a1mlVYJ+wFQSy18ccXRBWWghAlACpvBli81Z8hXsnDyChqRRaIyMPXa?=
 =?us-ascii?Q?9sX7xDLmrSaIbKH275Hzbzzc8qtd3rRyecsSZyameRwkYedp/bV8oDbpApGP?=
 =?us-ascii?Q?3KnOfGtnHVNtrNSti7KuUIC8B+5KHnKvAt9DJY8nmZu3E/r3/uBtcWanZpbF?=
 =?us-ascii?Q?+p/U1/Llntv4IWTr0K2+wUa8LRDpa7DMkgI5C3H5bk2hG/5f3AvGmXrOFPU/?=
 =?us-ascii?Q?YIkWHxf2n6a2WcuLakl/3qTuejoiYh64G28KrjWrnL+kxR5/9ntG4g9/5GEM?=
 =?us-ascii?Q?oKyI6oiVDPfEfMZGzgqqZnFEo7om42MH2F2pYvoVCWyjfSPnNILfGnnSHEAk?=
 =?us-ascii?Q?deFmOagPkaSNnA4V7M/l99V2if5JPo41fwnxjACnUHp8125VQ5DWyHJh/MQ9?=
 =?us-ascii?Q?WBDfTw+Rzxhpfa2FCjTHw2YWeehxYWGZhszke1xJNF3v28GYQifu/p3ldpne?=
 =?us-ascii?Q?/m5hX+Mwhmqv5odxwJ/m9x0Csd/R+SgpqrfOnUykVO68XY5r4PIS5l9q5hxS?=
 =?us-ascii?Q?94zqRj98+Of9tAYWBHglcOsLk15gR1w+uYxlseiV9YfOSN2oeQmDc8ifIhRM?=
 =?us-ascii?Q?5dAWEo89VOMx5ft02g3ZCKIYYxGACNiePii4qa2my5KEgrDmaaaAmgdTBZDq?=
 =?us-ascii?Q?E9kRWNeEPtLW4yddhTctJ23C6ZeY/r/d1DTtMcL6F8NCagFwgDGK5FjswkVt?=
 =?us-ascii?Q?2vgcY2OiTdjVwKdjHPJ/spbrk6l+TmU6GL1KzC3ZPmyjqo/gt0ElAo9EWCMV?=
 =?us-ascii?Q?/Qik9LyY5/skS3LITg3zPbnkBcYkWQR5A03/CRAiL9ZVmO5g3rrQhFJI+cbl?=
 =?us-ascii?Q?x/28mbivgtDLRRhpevcsZ/BcHm+RqXZRTjEoWD405Km2Bv+L4uYul5Uj1p1u?=
 =?us-ascii?Q?ALHE+o0zajYDAeb6gAi6s9zVWxh0MUAwOpIGoi4GDLX68JN+FaLCvp+EMNHo?=
 =?us-ascii?Q?2u0DaKbWf0TGdaXlvTdVfdVzsc803yfFCiIv5TMulwjI+CF6r+VZY2oOAXrH?=
 =?us-ascii?Q?JOEAxAWZvd9TiAjplYJ9mA4BKN3aHd/XIXGkue9XbXl26geYI0v+5o2NFF1d?=
 =?us-ascii?Q?X90tNir4KKpfe5BhZ1SLWdIMxL/dFeuDTweO6sWECdu14wtt343yAaEmBnYR?=
 =?us-ascii?Q?ojW63QMPtFnGzlE4TNsq1thOok1mho3znBboambGVMmdDPN0wu9R3+0G7rUL?=
 =?us-ascii?Q?vFv82lS53TZ55PdAYgodNOsSsmk3T03DNmfEeIWXfGX2daWweNEcodk5zv97?=
 =?us-ascii?Q?5+t9Qht2+M1+bH5aeO6wiDLh7L7K5KXTRqKgciffV9q7SAHNSqc9EWTnHcSu?=
 =?us-ascii?Q?qYHa+YXLDC1scHyw0MXaydWb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c2f037-cd81-4730-8290-08d93a2f00ea
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 12:19:40.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOxUNFT4lFiA3jfmYEwnHMVD78gFCJpcKz4lwaHAkrpOVMMOti02tCEAbmZ6SLGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4902
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=888:04, David Sterba wrote:
> On Mon, Jun 28, 2021 at 09:48:40AM +0000, Damien Le Moal wrote:
>> This one is actually a good fix :)
>=20
> It's not a good fix and has been posted several times already. What
> needs to be done in this function is to propagate error codes from the
> whole call tree starting in that function. Removing code triggering a
> warning is perhaps the simplest thing to make the warning go away but
> the right fix needs some understanding of the function and context.
>=20
> The patch also comes without any explanation so that does not help to
> back the intentions to remove it. Reveiew of such path is "Please
> explain".
>=20
> Replying to patches attempting to fix the warning (and not the code)
> does not seem to help, it's just pointing to the previous iterations.

But in this particular patch, it's really doing proper cleanup.

The truth is, the whole function, btrfs_destroy_delayed_refs(), only get=20
called when a transaction is aborted, and to cleanup all pending delayed=20
refs.

Thus in this particular function, there is nothing to return an error,=20
since we're already erroring out.

And in fact we should use void for btrfs_destroy_delayed_refs().

Thus opposite to my initial thought, it's in fact OK for the cleanup.
Just one step left to change the function to return void.

And obviously, with all these comment above added to commit message.


If this is from some guy with years experience, I would definitely bark=20
at him, but this is one really looks like a newbie, thus it's more or=20
less acceptable.

Thanks,
Qu
>=20
> Everybody is free to run checkers, find the warnings and send patches,
> that's fine and that's how open communities work.  But in this case
> we'll probably have to put a note in code not to touch that particular
> line/variable.
>=20
>> Just did a make with gcc 11 and W=3D2 and this warning does not show up,=
 but there
>> are a lot more warnings about unused macros and some "variable may be us=
ed
>> uninitialized" in the zone code... -> Johannes ?
>>
>> There are lots of warnings about ffs() and other core functions not in b=
trfs
>> code though.
>=20
> That the higher W=3D warning levels are too noisy and have to be filtered
> or specific issues fixed after manual selection. We've recently added a
> more fine grained list of warnings that would apply only in fs/btrfs, so
> if you find more that are worth fixing and then enabling by default, no
> problem.
>=20
> Some set-but-not used could be useful to point to code to analyze if
> it's not obscuring some bug but given that thre are lots of instances in
> the system includes we can't enable it.
>=20

