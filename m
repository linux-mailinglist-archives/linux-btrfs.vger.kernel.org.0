Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2AC4C6362
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 07:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiB1Gyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 01:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiB1Gyu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 01:54:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA87473BF
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 22:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646031250;
        bh=0k9MQ8lqSIqfpG0YdUCGRQqCDzC7mlZbN8b5chhzIr8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Y3vyTw7bP49Wrkdlk5/ABkDyNOQ8shGJ8ADGvEgMuuiLUzmViha7v9dGrmDOSwvXG
         wvYPK3XkA+G0dE4qtHZNmkol+XMWkSfezOTnqiW97F1ZM1vRoNwkfatGFC7j8qVY7z
         ul54XgMkCzY41qLXPoa4eTu6/z60cOZZl8ru2/aI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ3t-1njdRs1qFB-00WHfa; Mon, 28
 Feb 2022 07:54:10 +0100
Message-ID: <bac97a5b-dca8-b2d3-c386-a0ef26a6b0ff@gmx.com>
Date:   Mon, 28 Feb 2022 14:54:06 +0800
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
 <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
 <cc0d3de26d74f5342681f011459049db8de24765.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <cc0d3de26d74f5342681f011459049db8de24765.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e9NkUOGsv8G9ho3MPltwZ9+7pVECthFjwT6clY18+zF1QGHJDft
 7WGFXvUZzvToxK5SPVgyeTu0ahOt+3t+C1bIYpIU3Jb+E25+pgnnO07W1QS9V8syWFWCh5c
 9VT9Z2hTCK5R7PyR3YQzgmcTK1OQWxSC1ItgX+7eqgepGLpPicpweiYPzLW29/LBSpxOQRH
 ogJc8oVC1/rd6ri0X4cdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tW7LAqGTRX4=:B6O8x/wt+eVTCmnuKlpu+C
 UUV4++T/CHzLmrEPXTqjL8AsNwGdXAJikDqgQTK56yckKrU+w54ZdyB+ZYS5cxP5UL4zOrIb9
 V7pMj1z1nvlK3A6zAmYiMcogk0RciBFTl4GjkSB/3LKRmNIuzXvxvfBt3hh3QFEZ1xIHG53QI
 C3dZyU9p9dp7D3UeAnKywH5lhj48HO3b7YQDWYQnHlkEqytaicMzFMoXAbZ8xPhxxFRqHDsIk
 7RjCO+8k4Pl6fw0YKJKgY9PYDNMYViF4LgwyOhZDEnrnAKn+XJHO20MyaZAx+PnAMSs7l5APB
 Xu5BfwrYVuSC3b4bO59bctP4lQ9i7snohJWLvVRm0sL0sQW2ucM4iAFHGjfWCpx6+CXWpfYAz
 NuDzjI4sfttHEBBfXFkBf2YMzwFWD+5Aydl7Hd7oBa4CH8OGTEu9YFZ2ufbgCJYGQvwC3Rrit
 X4jwo9Om7CzKxhDkdXz7wuJvOkoxRZwuuvIee86C7EuCHPw+upqUj8th9rqeQ4veGN8jKxK28
 U5HSm4Ix8btXGEtdmAbIz5PuYtM5siww5KDyBX4SpvzPsuyfmqk6fmi01qw8aTC0NrKQFKqtN
 TvFFLvBmsPYgWBzfkNCH4bBL6u5obblbHkBlvMcgHriHN/aMD4zxZPzf+JWHgkdoS8vVRMySJ
 5F3I4uAVp6ietTbh6R3dKoHnXebKJMLdC8dGKnvD3C6QhbyXjIdfRejmSuo8spVW6s6srazvS
 V8U716hd2qMEwDK/lf0Zs/E5fHRjjSsNID4hENYnWhajKEoNoNwKGK/h7nhoJNki5RPf8MfQ4
 nf+wS3VQzEwfF2dNnGly8HJEfQR6JbEPbTQ8h+2WDr01G5kxC7IYg6NKTZKPocMumER8dCZEb
 F+o1YIja37jhmnoaAJGm2ZgFIS50/+dh1wnTshOK6TesOgl+EK4v9i6N5eUaCdo3IGbpkFD+5
 FXQ0lltdk2aJ88QOXOnBghb/uia6xmLTZjTd7+CxcljeeQ2a083dUMBkWv2d+Fc03D9RDf2Yg
 0CqIcQC/347I+FiBGZhHd+IUIB2jg/AMVmhCevWG6wKtOl0hcj8MSh5wMJBR3owDdPtaWTNHk
 b8O59jkPCmmc8s=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 13:19, Christoph Anton Mitterer wrote:
> On Mon, 2022-02-28 at 08:55 +0800, Qu Wenruo wrote:
>> The corruption part is a tree block in checksum tree (ironically).
>>
>> This corruption makes btrfs unable to read (part of) checksum tree,
>> thus
>> unable to verify a lot of data.
>
> I see... so, can one find out which files are affected by that part of
> the checksum tree?

It may not be a single file, but a lot of files.

As csum tree only stores two things, logical bytenr, and its csum.

So we need some work to find out:

1) Which logical bytenr range is in that csum tree block

2) Which files owns the logical bytenr range.

>
>
>
>> Please note that, scrub only checks the checksum.
>
> Sure, and it fails, presumably then when encountering that broken block
> and stops completely:
> Feb 28 05:56:11 heisenberg kernel: BTRFS error (device dm-0): parent tra=
nsid verify failed on 1382301696 wanted 262166 found 22
> Feb 28 05:56:11 heisenberg kernel: BTRFS info (device dm-0): scrub: not =
finished on devid 1 with status: -5
>
>
>
>> For memory bitflip, since it's corrupted in memory, the checksum will
>> be
>> calculated using the corrupted data, thus the checksum for that tree
>> block will be correct, thus scrub won't detect it.
>
> I though that would depend on where/when the bitflip happens... i.e. if
> it happens on either the data or the csum, after the latter has been
> calculated but before both are written.
>
>
>
>> The problem is not in the file data, but that checksum tree block.
>>
>> Unfortunately there will be no good way to reset that bitflip using
>> btrfs-check.
>>
>> It's possible to manually reset that generation and re-calculate the
>> csum to fix the fs.
>>
>> But it needs to be done manually, as no tool has taken bitflip into
>> consideration.
>
> So how to do it then?
>
> If I could determine which files are all affected and if it was e.g.
> just that one,... would deleting it help (assuming that this would also
> clear the broken part of the checksum tree)?

No common operations can help.

But I can craft you a special fix to manually reset the generation of
that offending csum tree block, as a last resort method.

>
> And if not... how can  recover? Recursively copying all files to a
> fresh fs would also fail, I guess.
>
>
> And is there a way to read the content of the file while ignoring the
> csum errro?

We have a way, since v5.11, we have a new mount option,
rescue=3Didatacsums, which can do exactly that, completely ignore data csu=
ms.

Thanks,
Qu

>
>
> Thanks,
> Chris.
