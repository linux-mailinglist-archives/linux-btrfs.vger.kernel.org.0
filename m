Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183E04C6074
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 01:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiB1A4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 19:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiB1A4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 19:56:07 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F046C1F3
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 16:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646009727;
        bh=5cIWMMAtK++LOG9cVkpltnYAB1tQhjvO91GA1eL3c44=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=beAhsb65nH9+IzOBujCyMEitkF5nP1lVjtQPP5aKwVyJGG3aHSiUwdFD59zs1H8Sx
         Uf6hD5u/hCHJD4SvLB8pQPDs+9qC46KTQHM8xOOrpcdMbYbXa1BtiJ8KzDneFXw4mN
         ESW1eZhs3Q/f6alFThvjfuvaiBLl2bZPxsix+bP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgesG-1nq5ti31qO-00h2Zy; Mon, 28
 Feb 2022 01:55:27 +0100
Message-ID: <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
Date:   Mon, 28 Feb 2022 08:55:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
 <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
 <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZXAnhDFnsLgiVxjPtDbmoT2K+DLBDv8gI4ugxBa9sFLKXaOat6v
 BrRpJmTrJ3QkPg1e7muRKS61LoFsYUaSFGmAc9QBMrXKWOYtX1B/4N5UkSPHeNCFPucOXVN
 x9XKSm7gNRaOi6jHBzqsi8s73U8KjZbzAjl3Q/gzmBpPYjgjGjvN4SHBCjNH1frs2E3DS9I
 eD7dA2KfRtiQHxXJAmF+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQuqvF67dLs=:Oac+MEE3v9wVSCHKqmfjQO
 wYkc6pSHk6qlrAwpMwcPruQG+GwBih7AGY9TTawtZM/KR2aHalynGKYXrGjdohUR35nXLNzMV
 6jAX9MRH9wcf3sRkNTxoRDeVN8ll0hasf1JfwXysMy3RA0/Gkr2tcAnfYS6pFlJ4XWqJrwjlf
 M6ztR4nTRRmT3pGceWyx894wIbSKdojcjGfOHH2W0O0qzL2Kf9xRAxnp4fv0ie0IB6ehiZcj0
 ajUAgN+mwNEVmP1SQh6d4vZwfaJPn+4QdRWaoBkOIt8PVQYAaqOnM8pL21749WMTgtZj6t9BV
 ByW6W99wloouk+kKkc7EDJkdZREOjS4sFX+TGJWW6ACXCHLCBEu+rOJt+U1FCBiGHMqXDQqFO
 AcHH1d6XTMpfJNDv/+xZ+1JDt/WA7Gck7GlLkKRA3F8RGkbjrNB+UBdgz4ao0O6UV1ccHeCAO
 uyxnzSzDkrt9HOduWwp8XAgQpk/CREC+TVJ107fpN+N99AU1VFj6yz8m72YYWnl7MuQqWZk/D
 fLv4KuBpEQJ14H1rVCL3jMIj649Aa8Ax/lYgvMINEzAEmSaFYXOo/La3k+0r2EU8hR384aSHW
 3nA91e5/qrmKF+B59YFrOYKbj87xXftvkdCwqbsJ3tzJQfOqoiyngwoCd06/D/EyK+LI5Q6/x
 2uXNVa9fYtT2BBB8DoVXD9KVTiUETHzK4mn/ehQNaQdKdHeUI+w4jJ24PtQmJ+66bqO9T9udB
 jcx9tYQRrGzAPFscz0ozRzIQwpi0cvaJ98i4CM4JFx4lOlZSOcoOIxobGnYHJkr+CxCSuEDjC
 I7xqDj1knDiQOJS6SnLJ8xM2+j27QUFMWQQ7VzdASSSX4/xl3S9Cgy1ObcgL2zKGxmVqo/Z7f
 jbOs/5XKaGeGFzCKQCk9SgZjTODF0EiCv2LorE3FhH0SEuJOZA6ngOkDfUtWFYu/HzezdyKjH
 K3Dz6cnFB8hdzFuMpVVuy+BRO9IH2c6e/0pTiSLiKzkfpN7DOiWb/pr8beDKmNKjYdbrxvOxe
 WlNtLQhrjBYVoOecNaODhJkkURJqpIF0y8gJdjY/2SYjS/S1ejbnOJGLSrqM5LDy7jbq1H3fk
 6QQ3nwH0DLYfMw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 08:38, Christoph Anton Mitterer wrote:
> On Mon, 2022-02-28 at 07:26 +0800, Qu Wenruo wrote:
>> I checked the transid:
>>
>> hex(262166) =3D 0x40016
>> hex(22)=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00016
>>
>> So definitely a bitflip.
>
> Hmm... would be a surprise, since I copy loads of data over that
> machine, which is always protected by some SHA512 sums.
> But could of course be possible.
>
> I assume you mean the bitflip would have happened when the data was
> written? Cause reading it reproducibly causes the same issue.

The corruption part is a tree block in checksum tree (ironically).

This corruption makes btrfs unable to read (part of) checksum tree, thus
unable to verify a lot of data.

>
> But shouldn't a scrub have noticed that?

Please note that, scrub only checks the checksum.

For memory bitflip, since it's corrupted in memory, the checksum will be
calculated using the corrupted data, thus the checksum for that tree
block will be correct, thus scrub won't detect it.

> That file was created around
> January 2019, and since then I've had mad several scrubs at least.
>
>
>> Please run memtest on the machine.
>
> Will do so later.
>
>
>
> Anyway... is it recommended to re-create the fs? Or is deleting the
> file enough, if a fsck+scrub finds nothing else.

The problem is not in the file data, but that checksum tree block.

Unfortunately there will be no good way to reset that bitflip using
btrfs-check.

It's possible to manually reset that generation and re-calculate the
csum to fix the fs.

But it needs to be done manually, as no tool has taken bitflip into
consideration.

Thanks,
Qu

>
>
> Thanks,
> Chris
