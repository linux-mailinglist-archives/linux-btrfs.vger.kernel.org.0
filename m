Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57514285E45
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgJGLgJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgJGLgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 07:36:08 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1EC0613D2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Oct 2020 04:36:08 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id q7so1923536ile.8
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Oct 2020 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=SjlU4nFMf3GMh7dbK7gS4x/cIhLYrdaJOzhsLdU2lU4=;
        b=R+Gk/+vxqoB36XlZ2yq/DGiBO+fBzRveT6vz17Mz23iCfwKr9ccjuZFw67KL8F7/ZF
         TXmNBpbLdGC7UrTblrfr7qFT/kbn4EY02muaW1iFlZFzaaeu7+J18PQsRS70UWeJsmR9
         Hpk/aCAGO0Ve8dQ5xFdlB4b7Q3LBnckWEczwzCUKgYFCVJshNfHzxkIEat4HJmvyRld0
         E0fu8isfuyDDzs5MPNkDplQaKnh0cp8/2zkBILmdwxeo6EAs39GoO3tIKNl64S31KeOE
         pQLJTK5fWAUxQGkgO++8Jd4agGkXB5iPjlrR/5JwI2+ynGA2KbQny/Qt6xZ/j866KNna
         JgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=SjlU4nFMf3GMh7dbK7gS4x/cIhLYrdaJOzhsLdU2lU4=;
        b=Bp7SHh6Nhl8//wByTXom5KHVSaBWIxEg1c5dtH35hWy0Gbe7pvOGPgNWS0XTXUGC5w
         bSjKH/MbSNzfCbJtbnrjm9YlQxEZQIkzfWPjUrqahpML+NnAKme6qcwla1gayivfFPro
         VXzfaNuFOcMaurT0nIWhdl5F3HFJhRY7gby+J4GGMwMNX9PeTblTYeP9bbIRXKOcQGcq
         7Gt03avAMDX6WlKrd2OUlGlUoyT0Qy1GsTXHXL1vi3kLCo6kRQUlzW2vJ9ZfCWIqAkz4
         D8qqwMVvLZPhvzrbTFgTrOD85dctxe4lXAgW3vcKUjAQ5YpqZU4HFS65Ga0M8WAg5ISe
         v1lA==
X-Gm-Message-State: AOAM530hyA8MKttvVumC4T3o/wF65qzIv/lyGXfilORsY7BZDooSNxix
        hD3jZTiwDCcY0BEonELUNXP2cng4c4m9PqUHPvCEI1y//uo=
X-Google-Smtp-Source: ABdhPJzAL20LWNV6VZMHtEcHAc8NqrJjRm681bUIkeU0mLpNVeWapN9OGP6jB2YbIvtxAHbo7WefwznmruE2QhWBcBc=
X-Received: by 2002:a92:9ec7:: with SMTP id s68mr2267104ilk.143.1602070565482;
 Wed, 07 Oct 2020 04:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA++hEgxkGhnbKBhwuwSAJn2BtZ+RAPuN+-ovkKLsUUfTRnD1_g@mail.gmail.com>
 <20201007100757.GB11861@angband.pl>
In-Reply-To: <20201007100757.GB11861@angband.pl>
From:   Eric Levy <ericlevy@gmail.com>
Date:   Wed, 7 Oct 2020 07:35:54 -0400
Message-ID: <CA++hEgy9xZgcevY_YkRKgnBQNuT=OkZexr47Ofhkqcb=53-URg@mail.gmail.com>
Subject: Re: de-duplicating +C files
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What is the practical utility of the attribute? What is the benefit of
the constraints it enforces, for example, in the case of swap files,
for which it is required?

On Wed, Oct 7, 2020 at 6:07 AM Adam Borowski <kilobyte@angband.pl> wrote:
> Why?  It's just that the flag is misnamed, it should be "overwrite in-pla=
ce"
> as it doesn't block CoW in any way.  It works like most uses of the word
> "CoW" elsewhere: a page is CoWed once whenever it's written to when its
> refcount is more than 1.

On Wed, Oct 7, 2020 at 6:07 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> On Wed, Oct 07, 2020 at 02:29:34AM -0400, Eric Levy wrote:
> > Recently a discussion [1] began about the desirability or risk of
> > applying a de-duplication operation on files with a C (no-CoW)
> > attribute set. The controversy rests largely on the observation that
> > calls to Btrfs currently fail for de-duplication between two files if
> > exactly one has the attribute set, but succeed in other cases, even in
> > which both have the attribute set. It may seem more natural that
> > success depends on neither file having the attribute set.
>
> Why?  It's just that the flag is misnamed, it should be "overwrite in-pla=
ce"
> as it doesn't block CoW in any way.  It works like most uses of the word
> "CoW" elsewhere: a page is CoWed once whenever it's written to when its
> refcount is more than 1.
>
> You can already reflink by snapshotting the subvolume that contains your
> file, thus there's no point in blocking explicit deduplication.
>
> The behaviour when trying to dedupe a -C extent with a +C one is less cle=
ar.
> I'd argue to either:
>  * prefer the -C copy, or
>  * refuse (current state)
>
>
> Meow!
> --
> =E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
> =E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Imagine t=
here are bandits in your house, your kid is bleeding out,
> =E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 the house=
 is on fire, and seven giant trumpets are playing in the
> =E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80 sky.  You=
r cat demands food.  The priority should be obvious...
