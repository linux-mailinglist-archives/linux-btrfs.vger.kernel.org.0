Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71555F2E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 03:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiF2BlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiF2BlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 21:41:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C16252AF
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 18:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656466865;
        bh=Mgh6GpcVYx/rYDWIwnSClfH6GngeEz8fNAlGj9uUiJc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=PRV9DlDc6GNwutWLlUpE1UW3NIHVU6H7kmk6JlNKFL7NO1HTZxLnvctOij083wuWA
         ip2D8kjcuGdlyUc37bUJ2wnbxS208BLFo8NpQailq4ju4gOsEid3ddhNhX8jt7qwaU
         /qeNyJtRqVGojEQQZIk/0Wn57gCsYoihYR74mLsk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof9P-1nHKQ539B3-00p2Jq; Wed, 29
 Jun 2022 03:41:05 +0200
Message-ID: <8728cb97-6bb6-fae9-025b-42bd1a439386@gmx.com>
Date:   Wed, 29 Jun 2022 09:40:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Tom Rini <trini@konsulko.com>, Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
References: <cover.1656401086.git.wqu@suse.com>
 <20220628141708.GJ1146598@bill-the-cat>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
In-Reply-To: <20220628141708.GJ1146598@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4cebTUJIiPO7+NBMRZERKrkPZtn4e1sMamamdtPGgz7/PydPbOH
 yR2nsTNBPGmyNF5SXa9y5NqMlQe3jkUVDru2HRmT0vhEHXgNNdfYwyYwFmDFbavIu/Q5Hat
 PTg3TJ4QBESn6cP94Vq6rrCkYHq++o00bkiFKv8XTM3SpB9nIE9fsP18BrAEVGWGpG674ad
 rfleXQkNxMRr2MMYn/DVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XjT6VYOD70g=:yPtk1nuWJSCuNOrf8Quy+z
 En32Lti6iJzDe8niNmqnxUu7oVFUCdRRTlcHKGm3gqN7ZG28iVIk4txFWVABxmTw35kbAvk/L
 ID8GegLv3dH47kUqtMcu1ufJgZrCWB+sjWB1+QMwxuN5O1Ytl7C3MiigYb8ExzEuBfHYoCPsg
 Rjoby+Zqms2y4j16CZc5LlRNeT9nwJ5eYZL+YU3MhUup+IhLBmZkkkQn1ew/C3duas2aQwxJt
 0NVFbAbPG425zyAgbF2mveXE1bCs/KtkFbFpY/MmckxDZSXVG/PeTYMblG/cEgnzjUNRThhvF
 dtHf0RAQ+eoztoB/M5DGB6FoEgDSU0hXsqpT2P0qFBGbLEiftALfZCuGHzhWqr4mOILrcT/5Y
 m4Mmedrv86Pi6LGtO6a+QiJBeqUxFgaeUkqBT3kAyx0/2C0n8w8f+ICkps2xgpHH13UpCwLUm
 2ZgnnK4/9MW7mZG3Hu9fUN/PUEcmgRjOvgcKWTl4ImRCmi1Lm7YdA4XaH1bu20+uzgCr7t+2i
 zsf/MGjMvTl0Ue2+BPUQHl3OEW6UzEoy3z3iFwaiaAFgPyab1+y/iaEzUTO508iuXNZX44gIV
 7xrX2qIepwOFdYIWqzPHjliMUveIbJWTo+ILLeVsYc3fdWvNsXzHboJ6taPXt8GO1DvMapTtR
 7+s7KdvlFnONE8Nuhq0g9fB+Z7JS41vb7Q+qXBmGVwkz0cerBOiuHH7Em5Xzo6REpZQ2eJxim
 m/anM3BWLJU8fi8u57LgTz9WPRwTgDay3+CjLQ6pyJba6poWU+84EobiHIGCS/KM8KZ6WE2st
 AIrienpZcz//8Ehn4Guc4w6kfyOe8rWlsxG+g8BYUq8XtryEkcw3R8WrwRpLPq6HS75gtYUil
 Edxn1IiJqragm2m0KJ696QX+N6YSzUa53a6ahQWQA8FAWIBlLwHTLQN/eCBQk3wmEvbV11S1O
 9ypD0Sx3W4dzeyeOwtkePP28CTWu5FtPEYUl7tYxs8gN563VSFGveK4HArWqg4d/nmfhD7EQs
 f5tKOIUxMOPpzw+uaPW+USXZmRp9cmmoqo9u8W9tbJ4DvtEVIvfxdGW5z1DG57iMH4rqEQzBC
 sAotFYtChSIT0i1Ej3pQuXMwFf9yaJ3LhN0Q1oJmXXLl9rcaO9sc/S6yA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/28 22:17, Tom Rini wrote:
> On Tue, Jun 28, 2022 at 03:28:00PM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
>> just pass the request range to underlying fses.
>>
>> Under most case, this works fine, as U-boot only really needs to read
>> the whole file (aka, 0 for both offset and len, len will be later
>> determined using file size).
>>
>> But if some advanced user/script wants to extract kernel/initramfs from
>> combined image, we may need to do unaligned read in that case.
>>
>> [ADVANTAGE]
>> This patchset will handle unaligned read range in _fs_read():
>>
>> - Get blocksize of the underlying fs
>>
>> - Read the leading block contianing the unaligned range
>>    The full block will be stored in a local buffer, then only copy
>>    the bytes in the unaligned range into the destination buffer.
>>
>>    If the first block covers the whole range, we just call it aday.
>>
>> - Read the aligned range if there is any
>>
>> - Read the tailing block containing the unaligned range
>>    And copy the covered range into the destination.
>>
>> [DISADVANTAGE]
>> There are mainly two problems:
>>
>> - Extra memory allocation for every _fs_read() call
>>    For the leading and tailing block.
>>
>> - Extra path resolving
>>    All those supported fs will have to do extra path resolving up to 2
>>    times (one for the leading block, one for the tailing block).
>>    This may slow down the read.
>
> This conceptually seems like a good thing.  Can you please post some
> before/after times of reading large images from the supported
> filesystems?
>

One thing to mention is, this change doesn't really bother large file read=
.

As the patchset is splitting a large read into 3 parts:

1) Leading block
2) Aligned blocks, aka the main part of a large file
3) Tailing block

Most time should still be spent on part 2), not much different than the
old code. Part 1) and Part 3) are at most 2 blocks (aka, 2 * 4KiB for
most modern large enough fses).

So I doubt it would make any difference for large file read.


Furthermore, as pointed out by Huang Jianan, currently the patchset can
not handle read on soft link correctly, thus I'd update the series to do
the split into even less parts:

1) Leading block
    For the unaligned initial block

2) Aligned blocks until the end
    The tailing block should still starts at a block aligned position,
    thus most filesystems is already handling them correctly.
    (Just a min(end, blockend) is enough for most cases already).

Anyway, I'll try to craft some benchmarking for file reads using sandbox.
But please don't expect much (or any) difference in that case.

Thanks,
Qu
