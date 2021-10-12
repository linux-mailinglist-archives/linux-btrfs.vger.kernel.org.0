Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD842A2B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhJLK7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 06:59:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:33185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236097AbhJLK7A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 06:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634036216;
        bh=hNbpB9G86Y/RV1c0yhgsokbEkxpX1K14oXEszD9Io6I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=F5ljZXpgD0AY/jje0Hn0YNXfmNwfIqI8/nzchWiN9THXO5khSUCYetht/4p4p3XRz
         e8kGWCH5ok1+KXs4VP5bNIy3y+CDdGth7ovmtU1XZOEmXKuqU8BOXuSHvbOuKeJiDR
         nfOXj+F3fBVXJ/aIK4Yb4JNLT02lKjeiF6Lvr1uU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1msT2L1Xww-00rUlr; Tue, 12
 Oct 2021 12:56:56 +0200
Message-ID: <d1aaca93-5371-a3ef-df41-915dbdd5077e@gmx.com>
Date:   Tue, 12 Oct 2021 18:56:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: test-misc: search the backup slot to use at
 runtime
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012083712.31592-1-wqu@suse.com>
 <20211012101230.GV9286@twin.jikos.cz>
 <c2919020-bbdd-be93-7293-a2270df45dfa@suse.com>
 <20211012103444.GX9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211012103444.GX9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vAkopjPb4R4QBgxefc4S7mBCH0LEwVC7kGvLp3GbHiv0yB0mi50
 QMAi7Xzuu2vVGIwHcyWfEgumFaE2Njwghu7B6pRzmI6T16tbMB4R0srnnM8Bv0vWDZa7k9U
 qjTHepZ+5kOycDgjTskZ5dOUoeDR3CyTuHyFjBJarchN6P353/kxFxPulKa8rgidwi5LAcK
 +sg/8CMRvk76SzhGJ26kQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vuvgKqIzNUo=:xILAOBHJBpQVXIZZTcRMI2
 rv08QyOS3o8vxu4BMGww5L2LbTktRS/HZXYXKdd9lXalY9pKTjAUZRbYpxhmS8yCNYsWZEZT9
 oyjZ3affVqTu2ybKfcuwJpVyUi+FGVkZBLLsQQxiWw9BGrhHlmruFDE4rOinRNB83Am2NvfPw
 HXthtCIgbe5gSI7/R04XJBfmoWSgI4Y+nrPzjhSuXgZUBQvUR4+sGCBIkbHph8ctq1WT+37Bb
 hhsoxz3E5QJpDybWpyymexSFMmN5n230zzy8s4SO4BdBwXdfwIxPGwlEcxjw6y3oUpMnsf1pl
 /U7qzwhrTVTPyR5IWqKTvS5JSbT+B3qrYE2QBjndv0VzY7vYCzv0pkdG2JcxX8dsuUroZeyF4
 5Pv+5l4wPj47+CZB8yWnaGVYTiXOMMjZmdQtwhvdOXCbnahkfGJDJ2wsmkRurP6ovH3tIuCM1
 A7jwh3IPnAnhJ4yybrIjzE5zm0PeFrnHVN3gGntaJVRdv0ffhy9XZA0cN6U1EkPysnd/d6LP7
 L+aGsts1qREbrY6DwLykoYGiNxbIg1G1tYxky57xi+TVc5DSBXF5DmiCh1HUL2z+AsLhyH+Fk
 J/cu6mQbXUuoD/s++1n24dKqGGdWKgK27/9Lu1qcB+GA/QfeVcCAdGDAruRi+CYc4Ufo08uyn
 re03aIaB1B1VB40bAvz118b7vxsfKZFfjF2kC4y/ypUpa8xbdQi985DoTyJvw6tNYkxvY3cVr
 xmdSSP0yUTPiiQE/EvdSnpqZ2G0ijxb/+uC2i2y6GCcrd+rRmqkXR/q0t0V86zmSZtdOqyX+O
 8ee1U+2ovdHpl9pzDSzKlKqyjHM/iVPCsL6nfvljFoTRulfzm01K/5Q3DewijJ0I1/7f2Y6nU
 w6m3KYLS/m9nKZsz9QCXWFB83nN/NmzRxnZlZTw57s1b8ml+S2lIDlImWmLl1WkyPV5e+s+KN
 L+aKfaoGG3zJgx8MUXNxqeClO0Ue0jkjnytEnHJ429Xf+WwADuV0OkkQ0xD8vhLl48Emywqu4
 cokl4t4s9azUpCli1QtSiIJsQoSbzRCCaK6Dl5UZHMaSfWZ6GdRS5aiGEpZOVT7HsJP1BU+3J
 RsmAvmAldIbBNc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 18:34, David Sterba wrote:
> On Tue, Oct 12, 2021 at 06:19:44PM +0800, Qu Wenruo wrote:
>>>> +slot_num=3D$(echo $found | cut -f1 -d:)
>>>> +# To follow the dump-super output, where backup slot starts at 0.
>>>> +slot_num=3D$(($slot_num - 1))
>>>> +
>>>> +# Save the backup slot info into the log
>>>> +_log "Backup slot $slot_num will be utilized"
>>>> +dump_super | grep -A9 "backup $slot_num:" >> "$RESULTS"
>>>
>>> Please don't use the $RESULTS in tests, it's an implementation detail
>>> and there should always be helpers hiding, in this case it's run_check=
.
>>
>> In this particular case, won't run_check dump all the output into the l=
og?
>>
>> As here we only want the grep result to be output, not the full dump_su=
per.
>
> Sorry, I was not specific, what I meant is:
>
> "dump_super | run_check grep ..."
>
> so only the result of grep ends up in the log.

Oh, that's a super awesome trick.

That's exactly what I want.

Learnt a new trick!

Thanks,
Qu
>
>>>>    run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f=
 generation "$TEST_DEV"
>>>                                                       ^^^^^^^^^^^^^^
>>>
>>> Please always quote variables (unless there's a reason not to like for
>>> $SUDO_HELPER).
>>
>> Forgot it again, but it should be safe as $main_root_ptr should just be
>> a u64 number.
>>
>> But yeah, I should quote it...
>
> I know in this case it's clear there's a number, the point is
> consistency of the whole testsuite, so one does not have to think if
> this unquoted variable is ok or not. The initialization may happen in
> other context or lines away or the variable name could be misleading.
>
> IIRC I've seen some commands fail and instead of a single word in the
> output there was the error message. Quoting makes it fail at least
> somehow safely instead of letting the variable words be interpreted as
> individual parameters.
>
