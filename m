Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0714C7F15
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 01:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiCAAUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 19:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiCAAUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 19:20:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172523BFA
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646093956;
        bh=4J7kjDOhv+y9GF3GmHIvc0t1/d/qoZliboyJGujAzuM=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=HzUc5Qa3aEw9+PS9T5vbNlVjmLn7ntt8TbtmsnVaey2jYkcC2nkG0WrEEJoAWdsb6
         w7llzjqkXmHGqfbaraPBzW0bh938MEtRzOPK/vFcYlhIsW+BmHBFNO/Q3qYX+EtZYB
         jC4p1eGAUr/eVEysfDE9d4Xtk6Xp/c0w4HrjyisE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63RQ-1oHtk31tCy-016RZw; Tue, 01
 Mar 2022 01:19:16 +0100
Message-ID: <d408c15d-60e2-0701-f1f1-e35087539ab3@gmx.com>
Date:   Tue, 1 Mar 2022 08:19:12 +0800
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
 <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
 <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
In-Reply-To: <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6FLPXvLkEoefxkhvnwkKyG/iwIVGyNqIlZEMTFquxpTvmBbQQuo
 f7gZ4Iq02+4uO15GU1B4NJnYlEjnQ2NcfKKcKwK0fMOFIRpKh1RXGrvXkB06+PO2KMKhJF8
 KV5XE7vgLKDUYZ0cQJPT5nik0G92LPtdJh3kwh51za0DoU6syeyb/gJ1T2Re8aQRXBpu0Hu
 tNk/FHlKeqnPRinxNHb+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5uEC631Qjhg=:TtjH4/j0KNKMu7QiB44UIO
 VpRC8NNTA/Wnvn1lKQsQHXrypMNmz6sVSRAAFBD9LOUDOLeyKAQy8GclrkyN7k3Uczsw3QIEF
 ubefrO1JBgPNQlnek31KdkNj1allV5D49RI6zZ51tD3pJTZOSp5lUuKJFToteUhwoEerOhfdZ
 67yyT6OSIAQq3Lrg4YQC0OViUQvdQ8ywpDhXmhwXKZDW90l6tucW7I8Z1EHO9Cglr0o3o3j2I
 aQwOlmgBYAC2v9jjnKsq6oi2atIyho/k8dY0m6xuDbZ9krWm8IrOGMV+tl52Z14U5CnZu/3uG
 IV6SVC5OzreIOiyMYCk5NxQ2b7EGq7yQFEhZH/FKAANvQpN9EbcaK8p0T3xXYOVWXxYRQgwd9
 SKFY1SoVXCuzbZ0LQuuDLmgqG3YjIMToUeelwb9gUgZ6AFfiKM5b+2/7xlS6lpK6vfShENMy8
 9MrsFGBBMvYxl92Oz9MbND+Bq8gpefNh7jQd0FUeXaGMQD+WngDslvT8zw4A6iVbuiizoXEvT
 Fr57nRvhVYM0mDNZUJU+x8RE6/JawDs0DZxfgChRdRQ/LmCd+ca46SPz6zV8spi3UhDt3Et4O
 WXcWsvCeOlxChoJYbnnt6aAC7nJWIt7YWt1N8e+6f+WfyBZUkh1i3dfdWfng5QuYWX/ya1FTs
 PJPbk43xhBL7RJys6Ismvx7x7GpgG1e8di8cYcgUqbcWmr1ITQVSo6zGdknFnBmyISyD5kSW3
 QUhbWiWRziAi4Stywgrf2TXCUx0HlPmSx1tAnp8jZLtUfrJcuvzpjPnZxT3yufVBldB9QNAUy
 FxROxbEfJrcacOsl/RlUkXvu/jG8WllkC2Tysd38mn+SsFmY3YBJJxXJVD5lT411RzdJYhpX9
 aj1KTd1vL8/+wKDiMGjqnViWG7nA40GkW1liwj3ffcUFWiWRmx+gkxlzVWM0QGpHD2ulYSyXF
 tLUKYbR4k2M7EXORaFGv4tjOEF7K/axl5hYt/tBv+c1rWNflkYN7CHwBTorFoJM993pdNSdTH
 gpp8wyxttkBPt0s2IWT97gD7ya7bZHaSi0WQxSwwlAUoJAHvKW2sH1dmKApfEVk2W5hAxndkE
 fSFmkuTXU+WY/M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 23:24, Christoph Anton Mitterer wrote:
> On Mon, 2022-02-28 at 14:48 +0800, Qu Wenruo wrote:
>> Btrfs handles checksum differently for metadata (tree block) and
>> data.
>>
>> For metadata, its header has 32 bytes reserved for checksum, and
>> that's
>> where the csum of metadata is.
>> Aka, inlined checksum.
>
> Ah, I see.
>
>
>> For the best case, it's just a leave got this corruption.
>> In that case, if you're using SHA256 and 16K nodesize, you get at
>> most
>> 2MiB range which can not be read.
>> (Again, on disk data can still be fine)
>
> It would be interesting to see how much is actually affected,...
> shouldn't it be possible to run something like dd_rescue on it? I mean
> I'd probably get thousands of csum errors, but in the end it should
> show me how much of the file is gone.

As said, no real file is damaged.
It's just we can get csum.

So go rescue=3Didatacsums, and verify the content if you have backup.

>>
>> Depends on the generation. If your current generation (can be checked
>> with btrfs ins dump-super) is close to the number 262166, then it's
>> possible it's rewritten recently.
>
>
> Hmm, I assume it's just "main" generation field?

Yep.

>
> Then the number would be *pretty* much off. Which makes the whole thing
> IMO quite strange... as said, the file was written around 2019,... and
> it had been sent/received at least once.
>
> So would expect that the corruption or bit-flip would need to have
> happened at some point after it was first sent/received?

I guess the corrupted csum tree block happen at that time.

And fortunately that range doesn't get much utilized thus later
read/write won't get interrupted by that corrupted tree block.

...
>
>
> On Mon, 2022-02-28 at 14:54 +0800, Qu Wenruo wrote:>
>> It may not be a single file, but a lot of files.
>
> Shouldn't I be able to find out simply by copying away each file (like
> what I did during yesterday's backup)?

Yep, that's possible.

> Or something like tar -cf /dev/null /
>
> Every file that tar cannot read should give an error, and I'd see which
> are affected?

That's also a way.

>
>
>> As csum tree only stores two things, logical bytenr, and its csum.
>>
>> So we need some work to find out:
>>
>> 1) Which logical bytenr range is in that csum tree block
>>
>> 2) Which files owns the logical bytenr range.
>
> Is this possible already with standard tools?

We have tools for 2), "btrfs ins logical-resolve" to search for all the
files owning a logical bytenr range.

But we don't have to tool for 1), maybe you can use "btrfs ins dump-tree
-b <bytenr>" to check the content of that corrupted tree.
>
>
>
>> No common operations can help.
>>
>> But I can craft you a special fix to manually reset the generation of
>> that offending csum tree block, as a last resort method.
>
> I guess, if you'd say that the above way would work to find out which
> file was affected, and if it was only that one (which is not
> precious)... than I could simply copy all data off to some external
> disk, an just re-create the fs.
>
>
> If I'd delete the affected file(s) would btrfs simply clear the broken
> csum block?

Nope. That generation mismatch would prevent btrfs to do any
modification including CoW the tree block to a new location.

Thanks,
Qu

>
>
>> We have a way, since v5.11, we have a new mount option,
>> rescue=3Didatacsums, which can do exactly that, completely ignore data
>> csums.
>
> Ah :-)
>
>
> Thanks,
> Chris.
>
>
> PS: I'll start the memtest now, and report back once I have some news.
