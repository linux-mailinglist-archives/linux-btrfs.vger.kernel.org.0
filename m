Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA1D5978
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 04:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfJNCHp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Oct 2019 22:07:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36480 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbfJNCHp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Oct 2019 22:07:45 -0400
Received: by mail-ua1-f66.google.com with SMTP id r25so4535989uam.3
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Oct 2019 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/5I08vUyMM9u/kxwpQ6aulDAeDayPDq67d+lcNB8Gz0=;
        b=RPaW8erLphGBwgkL578g8Poz9fkPQMdWTdeuqdMOfzoHfi2OQ3XYLI3dqiXgywWW2M
         pdgFW2TAwECFMIi1KboSijh0Y13OOOtlpJqAfsK2K/trX/1d88zHXNVCHc2pELPLUmwM
         PzhjDN46JBembM2u8t4jHuRDkhYumaYuTeURz5DarVyqOsKxDTmaGEYxwvFbs4oT0alA
         LBAFCIeS5D5tAASZP1flDzX1WH+pPIVyZ8nXvsSO073rqumx0u+C+3syI8KDDRhQqhHu
         c+gbpcvdoE+BvHMis6PsZazIOFnge4CHg8MhdIy5IEE1l/XqeNdUOCjxx1i2c6Uy7mUD
         9ZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/5I08vUyMM9u/kxwpQ6aulDAeDayPDq67d+lcNB8Gz0=;
        b=M5bpm5JJ7AWI1S80Qc2wGzWRvmb2nieM2pbR+y+knbByCttfTW2PZr2T832cacBqZb
         oLjrViPHKxrU3/Qb+E5DNT4q2Cb3LqXKh47TMcLcuEMuu08rVDzVSHubJH2qStkVkuT2
         bVZBkB/gV7BCB93muAj+5aWCCQvYpqv2tBHdEJqDWA4KkB0wPjUUG9CYb6RjXZ2Kbg+3
         bCezobO5S5eGOopX3WRdK6bxAc+mZ5bdyNDRNTn3KCa0L6rfrAI7fa4ZiW5b0R3qnMNf
         Os/aPkW7uPhe6RllO5aAjwdD+t1CloBoWEU0PlySKltpHpN1VvWlrsEJ/FCM/YF2W9aM
         k7JA==
X-Gm-Message-State: APjAAAX6hohhlfqpN2lgw+utqvpbxwBn6FqOT04Riu/a7ixHZSwmm0RM
        uSUqrTxP0oDh+qUJdPVNHMbsjWTQXhWIehnRUAyvsKU464M=
X-Google-Smtp-Source: APXvYqwqTDXbse0GBcKs3DUKTnkR+E1U9+ycIC3EUl499KUW8frnkZj+K7ZYX9mZUH/616ejV2j8atQwIYRFgoL8wig=
X-Received: by 2002:ab0:6994:: with SMTP id t20mr8947822uaq.124.1571018863863;
 Sun, 13 Oct 2019 19:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
 <8c0f8fff-5032-07b6-182c-1663d6f3f94e@petezilla.co.uk> <CACzgC9gvhGwyQAKm5J1smZZjim-ecEix62ZQCY-wwJYVzMmJ3Q@mail.gmail.com>
In-Reply-To: <CACzgC9gvhGwyQAKm5J1smZZjim-ecEix62ZQCY-wwJYVzMmJ3Q@mail.gmail.com>
From:   Adam Bahe <adambahe@gmail.com>
Date:   Sun, 13 Oct 2019 21:07:07 -0500
Message-ID: <CACzgC9iSOraUua7YtPz-gsvNRF_6Fp3mvkBenETMsVNwnjvuuQ@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Until the fix gets merged to 5.2 kernels (and 5.3), I don't really recommend running 5.2 or 5.3.

I know fixes went in to distro specific kernels. But wanted to verify
if the fix went into the vanilla kernel.org kernel? If so, what
version should be safe? ex:
https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.3.6

With 180 raw TB in raid1 I just want to be explicit. Thanks!


On Sun, Oct 13, 2019 at 9:01 PM Adam Bahe <adambahe@gmail.com> wrote:
>
> > Until the fix gets merged to 5.2 kernels (and 5.3), I don't really recommend running 5.2 or 5.3.
>
> I know fixes went in to distro specific kernels. But wanted to verify if the fix went into the vanilla kernel.org kernel? If so, what version should be safe?
>
> ex: https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.3.6
>
> With 180 raw TB in raid1 I just want to be explicit. Thanks!
>
> On Fri, Sep 13, 2019 at 11:16 PM Pete <pete@petezilla.co.uk> wrote:
>>
>> On 9/12/19 3:28 PM, Filipe Manana wrote:
>>
>> >>> 2) writeback for some btree nodes may never be started and we end up
>> >>> committing a transaction without noticing that. This is really
>> >>> serious
>> >>> and that will lead to the "parent transid verify failed on ..."
>> >>> messages.
>>
>> > Two people reported the hang yesterday here on the list, plus at least
>> > one more some weeks ago.
>>
>> This was one of my messages that I got when I reported an issue in the
>> thread 'Chasing IO errors' which occurred in mid to late August.
>>
>>
>> > I hit it myself once last week and once 2 evenings ago with test cases
>> > from fstests after changing my development branch from 5.1 to 5.3-rcX.
>> >
>> > To hit any of the problems, sure, you still need to have some bad
>> > luck, but it's impossible to tell how likely to run into it.
>> > It depends on so many things, from workloads, system configuration, etc.
>> > No matter how likely (and how likely will not be the same for
>> > everyone), it's serious because if it happens you can get a corrupt
>> > filesystem.
>>
>> I can't help you with any specifics workloads causing it.  I just
>> notices that my fs went read only, that is all.
>>
>>
