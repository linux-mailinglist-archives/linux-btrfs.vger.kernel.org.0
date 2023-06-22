Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1B73AC4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 00:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFVWEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 18:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVWEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 18:04:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7B1BD0;
        Thu, 22 Jun 2023 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687471440; x=1688076240; i=quwenruo.btrfs@gmx.com;
 bh=IDjnpMmtBtiaCUNcP3HNZdGUMXCA+qqhrZy2VbJrKOk=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=Ub643avCI8YJ7Uk4uMH5V9L0u/fTwYwLW/53jp9fMTLXw5XGv3pMoL+8OBtBEVGMZvT4y67
 671KhFMYDohLbr0AqTUn8pysWkdjoIRmgtw8+rOHnW5VMZbEUJnpIXo42eD5vFKvBuhVNfl80
 z8SkuULS/9QSjj0bajJZUgUjurSRICR/FNA6mv5/6Ze6bLRosXpVLEhgGFQokzuR5lmZTFWlQ
 bO0FO/NhFYLBehgtknjEha2BWdZ4ms3t9ydIOv0OJp+Ug2YfDf87v/LfJguL+vrxt6P2gu2je
 vXWQvVUY5MMRZdJnexArMXACoNW5gScTOfkZV9ggYeT1uqLN2XDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1pcIAs2VwD-00apyi; Fri, 23
 Jun 2023 00:04:00 +0200
Message-ID: <d97babbd-eab8-19cf-4839-7740f5642399@gmx.com>
Date:   Fri, 23 Jun 2023 06:03:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230622065438.86402-1-wqu@suse.com>
 <20230622172303.GV16168@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
In-Reply-To: <20230622172303.GV16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:atBximK2LWhctrZa0Zw7x1FLDeZQ203JNc/jpGTWLOsyGgIvpdI
 YqtowsCS226vAPwjucnLauMMdJQYshWEAMtk8j/LHLmeWsq/50IrIjPEd5r5s2Ew2wSRzEv
 rtlnkDlCA+HETRPUgsYrox72r39xIcWejuZ1ZZkxgcYGDSByKDO8jLMy/dGobGEl5ch01Pt
 fPOJwNK81v/QCx9wEfCMQ==
UI-OutboundReport: notjunk:1;M01:P0:tGQmkymaqSI=;tvroFha9IfLSEpAfikdFav5VhoA
 SGXY4O2wzpWVXmjIzDidAEEF7x+bP337wwK0woT+YX63I9FxmUmQxgJv6yf57RSrKmH/Skojq
 WSUW/zbVG+2kZ6j7rnxVpfAMYfksQ9xBD75gXdDt7tXOfmuh29M0WJ4UJ1xs21V/Ksq19kULU
 dO1pdJMt8LSwE1uHDG36H0PKHwoh/WA2N4M7EXU57D1lKksmLY1P3e7l8C0iCd3Shpjodmx1H
 jRXqaM73bknOrvTcpUaYy7g7qKbL+UMv+PbcAZY+HYbIOGhNfArl1bAX0+vdYe3m5XM0UeeHK
 fcWfxlyMffZbDGB7Bw8swjGIqFwYZnca3JFN9RSE7Ne+jldQfP6JCJHpo6VAjGaI+TV3T3lwl
 RvzxhQmr08MsPsiQfAXR/emJplpqNg0fj8zZp3p30ZbHJBDLYUnSk7DfE0AmDLCDi/rzaQBha
 cgyQjjh5AzlHDzNO5hmArwWPPT5VZafhDvgZ7sHofk4blPt7RefTwjEt7RLQhrWfTnWv3Tm2K
 GNYWsUNeHXqGZXL2YCS05vMry02eTbyLAU2wBIO2PeQ0zHaqt+Ld8cwJby7iYbrxqhDoTuUwm
 r8Pt8GN6ANFScGVaBlU4n7LxTn8TgVKVQyCtksVJdvUJHtRo4P/+tx4DHMnux4f/9bYR2lIfK
 up25Vw9csmX58ZyOKqN6kMwyoVynXJ2BD7dLR0gsEeogz+7DBaKRZxqRPGJGZeDSLUWDaKdOW
 vB0WTrtxfEyQi3WJ5EWj7cRjl0H6hZRQKIq6kESJjSojNNAZzuNngVgsGbHZhhGeOL7m35g8U
 20HwfDpl5dDn4Gt7QFqtFPCPKxQz3jj8HzEKa+2mmwEavYvrkBStsmHIz4wzMbhvAmuWJs6G0
 P5d0ib02oRfaYNYFzxcdUIwJZYhu7nMtJFgknaNEoXdnmNS+JzePCS9r+I4RlJzga3fS1V4fU
 DDPCR2Y2t4dxQg6XHVA1heJPaFI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/23 01:23, David Sterba wrote:
> On Thu, Jun 22, 2023 at 02:54:38PM +0800, Qu Wenruo wrote:
>> There is a recent regression during v6.4 merge window, that a u32 left
>> shift overflow can cause problems with large data chunks (over 4G)
>> sized.
>>
>> This is especially nasty for RAID56, which can lead to ASSERT() during
>> regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled=
.
>>
>> This is the regression test case for it.
>
> I am not able to reproduce the problem with the previous fix
> a7299a18a179a971 applied

Well, it's 100% reproducible here.

And the missing type cast is indeed the cause inside btrfs_map_block():

         if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
             (op !=3D BTRFS_MAP_READ || mirror_num > 1)) {
                 bioc->full_stripe_logical =3D em->start +
                         ((stripe_nr * data_stripes) <<
BTRFS_STRIPE_LEN_SHIFT);

Obviously @stripe_nr (now the full stripe number) * @data_stripes can
reach stripe number beyond 4G range.

And a left shift would lead to overflow, causing a too small value.

This would trigger the ASSERT() in the raid56 code of rbio_add_bio().


I'm not sure why it didn't trigger in your case, mind to share the
seqres.full?

Thanks,
Qu

> but not the additional one so I can't validate
> the fix and will have to postpone sending the pull request.
