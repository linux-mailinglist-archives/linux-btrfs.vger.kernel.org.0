Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414964C6356
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 07:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiB1GtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 01:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiB1GtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 01:49:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A646668
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 22:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646030914;
        bh=AplWYW50XKyoQwzMPP+Yq5tZnTOV7ORFHgio2Lk1MAs=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=TmqFTw+KLW1loxnFSZxXqze57NugHded8c9yBx6ldaKSYL0imyYXbqwvb32rq4oH+
         IJ5pfrDZVqZzqYcqXBDpfOXrGCfKEO24dUKy8lTk4KhAEvNT0Tgh4zeEDLgw6qPePO
         0Sn//C3jlZaun87PzySN9/vA8WzTu6zeUUhbhIw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6DWs-1nHy8H2ixk-006hda; Mon, 28
 Feb 2022 07:48:34 +0100
Message-ID: <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
Date:   Mon, 28 Feb 2022 14:48:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
 <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
 <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
 <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
 <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
In-Reply-To: <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bzn03BP4BCE6+C9x3BMDoGtPifqA2qJd2rj4xqwL6VCmIz2T/VF
 sjrfqQaggPvcPq+fEy6rjemlABlFB1syRHoMdmXa8f+oT6x8D6o/Qvty6msIQthkjzhKnq1
 IdLoCG1mmKLbL2OWbHmm+967jjQ2pEnW6c5CDBV3WNdoe3wnF8wbeAB0uFgJ2eHDvR62PX9
 BWAKEtYymXqLfY7ERqgzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y03rXwP1Ay0=:p9Gtj8ANAkXgmiHdho6zUj
 IwhnM8CMw1DxnGE0YC/olPtCYzpI8xr+79rDSVp6JrhdnQhFq2kx0XUhLaUrszohWdUxwaQaZ
 zS2Zst7nNMYtNf/13YKbHL2wvCt8MGo2QQ9ZNPaBFn3BCRkl8CZEx2RyJFQf7pXYT/ApjIiZf
 C1rxS0bBreXj9GlD3gbhKJT+lThTT+v3swRApeh33KkZwQJn/yJpRRWP03pC80Eb7yPQWU9EG
 bQ0Clg+YCWk2w0Cg/6iVsiXKwxudrJhoFNBp/8oa+RhpOlJb4o9ZOaqP5/1Apz+CNsSLKk9PD
 s05HXLHu8Ea0/zP9bNlSEg6AMWEVV8TiMKstAZGlF3Hv9qHlb1hx6Gy58RWscNqnB/A71SVK7
 JlI0qoS7GOeCARvSGHr1za+e8+wifNyav/94oj3TLINDpDj/hT5ogiqB0aCO9LbyEzwS2rD61
 3EBRBceSGlfq1BdpvNqE6pjbHlGxPIuG0L4okOYAXZFUJefknIWSsq1jdMkNcubq5QfUzWcyL
 LSPbQCnVAYGrKQUiNnK5Wa3043Wnaw0ABmspva6kpR+D6rfIF82OQVV70AOIxhq6ZcA1We/DO
 0kUFXI7w3kY+Y6tMqAdqcOk8eFt49HRGDmT2hTko6M7KSWGZMVxqsZD0UmI+bMcNA7atKlDux
 xFdrFz2lFp13jFYf6QA9neHYUbMsJDWuGQYHAsLxH7+ToMKb7z6W2c/uIL5DVKvQU7i0fK8RJ
 sQOpZpU+3fVeHzb6a96n9MDYetpVSKUnnhC39JckdCB47Gzdy41ozhiW0UViQ3MB5H6IW8+py
 r/q0EGCmL8LUUi1s0i2g8/KCEVIYLO0bKxfJmvNX4+o2JWJM4003FRrvlNG8t3RABwOR438az
 t7fdw05ncvucoeTP2djGghtETuF+nfKGRdDw22mc2kYR/uBUu/S0CrIomXnnT784fM4eiQnOH
 WObf57kssRtT8CqCialT5hIJRZsKoRn73TRDSEhSK7I13ofrFcXdUiA2UvEa2ce3XfKDnsnuF
 YT4Ep+syh3P1GwkqBz3mM1vg9eH+3kH3bJGVyVnQFX/ug567v2XS5zAmd7fAfEYwuvmk9hHlQ
 trzdIuQd+BPAUs=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 13:32, Christoph Anton Mitterer wrote:
> And I still don't understand this:
>
>
> On Mon, 2022-02-28 at 08:55 +0800, Qu Wenruo wrote:
>> The corruption part is a tree block in checksum tree (ironically).
>>
>> This corruption makes btrfs unable to read (part of) checksum tree
>
> You say the damage is in the csum tree... is that checksummed itself
> (and the error is noticed just by reading the block in the tree)... or
> is it noticed when the (actual data) is compared to the (wrong) data in
> the ckecksum tree and the mismatch is detected.

Btrfs handles checksum differently for metadata (tree block) and data.

For metadata, its header has 32 bytes reserved for checksum, and that's
where the csum of metadata is.
Aka, inlined checksum.

For data, we put data checksum into its own tree, aka the csum tree.
It records the logical -> data checksum mapping.

Currently, if btrfs has any thing wrong searching csum tree, it will not
even submit the data read.

>
>
>> thus
>> unable to verify a lot of data.
>
> How much is a lot? I copied the whole fs before, when I made the
> backup,.. and I got errors only for that 1382301696 and that one
> file... all others, tar read without giving any error.
> Is that exepcted?nd out which files are affected by that part of
the checksum tre

It really depends.

For the worst case, if the generation mismatch happens at a very high
level, the whole csum tree can be rendered useless.
In that case, almost all data can be affected (although the data on-disk
may still be OK).

For the best case, it's just a leave got this corruption.
In that case, if you're using SHA256 and 16K nodesize, you get at most
2MiB range which can not be read.
(Again, on disk data can still be fine)

>
>
>
>
>> For memory bitflip, since it's corrupted in memory, the checksum will
>> be
>> calculated using the corrupted data, thus the checksum for that tree
>> block will be correct, thus scrub won't detect it.
>
> Could that part of the checksum block have been rewritten recently?

Depends on the generation. If your current generation (can be checked
with btrfs ins dump-super) is close to the number 262166, then it's
possible it's rewritten recently.

Thanks,
Qu

> Cause I send/received that data at least once in the past to another
> fs... and I would have assumed that any error should have shown up
> already back then (didn't however).... so the bitflip must have
> happened recently... after the affected file had been written to disk
> originally (and after it's checksum had been written originally).
>
>
> Thanks,
> Chris.
