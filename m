Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3C719063
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 04:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFACJk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 22:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFACJj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 22:09:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78912121
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685585368; x=1686190168; i=quwenruo.btrfs@gmx.com;
 bh=ABUrQZYchvZNqIIqKesPHEPUT5Qr2zVMGyKK3B0R4SQ=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=ho9EjRPkhcC0HIb5n8R9hk0hrBeNF9lsOMKsbnFQ+03C7bb4TRfhLg8RJpLBqXxAR6OwtmO
 /RwrdiwJtVD9qHx6HzLBqoxCc8ngI+dBeq43Mqd4Ay0M+lHoINoO/rA8oyJpaodCd7XSXhK5m
 YCL2n+Z7QLjBOKl6UnzQRW5aQ7k8HSj5FS4vUYI0NV3NnVBm6GXsgmO9RiteC6xhrsERnljQW
 JZLReby8FQw+JoQ0l/tmoIM8v2BXEx2BFxjPCM5Y7STXnqigFY5z++9iKnwQ9qpPhzlt6H0DE
 jWARtDNocXj+Od3EqNJJi47B9mCFTTJtxncQGuu2bJwbIgIya0Bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fmq-1qFIDf34au-011w9E; Thu, 01
 Jun 2023 04:09:28 +0200
Message-ID: <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
Date:   Thu, 1 Jun 2023 10:09:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: new scrub code vs zoned file systems
In-Reply-To: <20230531141739.GA2160@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yh24OqkbWZRjIC7FaufYwx1GEwhrRJpKLLzF2L2cUnkSM4k2o2/
 hPrkLb8Wh+jwDtnL/0fJbtAoOJ5omUHVcDZXYl/Ea3jEARLfHQgBRCykppN6muT5hJmgrxa
 Gi8eQ7AEvUbqi2+30suwDs92tiYgZEQYrqHnlr6BaXWqarhypsSNZvvgzECNq4TPgV/KdWr
 zYvijUpjtrzSymlZqLR/Q==
UI-OutboundReport: notjunk:1;M01:P0:XBWirGWPxRU=;ARNTG2vB76GUFbi7DZSUz8/KKFQ
 FJyAJ3usddkrRk+Ffgu0WxRGQIRwyjUo64lZRt3rwuF6icJ2ZL0iKBfOJ6iBGn8xM5S398f81
 UBgkK3kiUm/2v08HeCs7KfKgh0ALUNSkw0NXIWGXRInbPBOVJj2qelkeQkz9ildEXEW4RTjoh
 T07JAWgDeYBphssRQouS5sPV9c/8tqNwSj7W3Q2ZLfkN1jeNpvf8YWocFalFaPDrfhx51O8Dq
 ZMwShiArZIj76Z3CUJas4ngJ7UNeMvFPnmZ83UtOMtH/rNhuJonynpDp3NvBf5fzv99cey/DM
 1o0o76bBzONDVaa5C0IZLBK7BMgT3ShlqIKGEF9G7hN4oiPs+bMy50lOR4IBYv0i+lVXdmmAp
 XdoVgS7j+tug/oGS+tUFpygRl8ju2QCzBvAoQ8vD/N25tTOUYbybZhhqMRMnlhBKFxmhE/eGN
 5GI/JnYjfQcuAy/7eiCgVr+j/dBgpIeyWdufexPgTyO0+tp64v5ZtaBAAc0+1qqa5Li3I7rUp
 DkGfI2lJHwAm4I3nVPadAPH1AJZ80S6giQ0c8QdAnWaBTyzvo89gcU5QkQdf55mQOyTYtr6r2
 C0erxICLmMRUw1Tu8PxHTDcEewncY5Lb95pdtIb87KgIBFkBUdm28xAwrtdIDnWXOER9x91jS
 DIFlwdiIFSnSR5kt9pv2QnUjUZeLZ/l63tTmYjlA6eX11Y02p3WWHmy6xTHGPq5VOtCaPZa2H
 NwFBrkS5PpQhODue382HFraNSzYKN+6el/O6n55dKLU/JUt75eH2fV6v925P1pZD/h7QIT13p
 b6jaY1Qu2ZQscpi+S0jjmOiZGibX0FlwEsVb8ctyXEm9qUSFrSv3eX0S3zq/qUFeuA6FMYTf7
 eODdvpB/6chfGvCNi2FSq8vRh1jzbE6SbPl2o1W2MWNCX+zfp5I2SHrh8LzT5bB27ap7kx5Ih
 lKlrjrGJAUcpkyeNcerVoPQvbwE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 22:17, Christoph Hellwig wrote:
> On Wed, May 31, 2023 at 02:04:05PM +0000, Johannes Thumshirn wrote:
>>
>> Heh and this has never actually worked IMHO.
>>
>> I did a crude hack to bandaid scrub:
>
> I think the better approach is to:
>
>   a) branch out at a very high level to the zoned code in
>      flush_scrub_stripes, or in fact even higher given that we
>      don't really care about tracking stripes.  The write
>      side of scrub has to work at a zone, not stripe level for
>      zoned devices

So far the various wrapper around the write operations work as expected,
and hide the detailed well enough that most of us didn't even notice.

E.g. all the zoned code is already handled in scrub_write_sectors().

The crash itself is caused by the fact that end io part is relying on
the inode pointer, that itself is a simple fix.

But I'm more concerned about why we have a full zone before that crash.

>   b) don't create a new relocation thread per zone, but run it from
>      the scrub context.
>

That's a little too complex, the problem is that relocation is a
completely different beast, too different from the scrub code.

But I agree the repair part for zoned needs some rework, it's not
working from the day 1 of zoned support, but shouldn't need that a huge
change.

E.g. we just record that we need to relocate the bg, then after the
scrub of that bg is fully finished, queue a relocation for it.

Thanks,
Qu
