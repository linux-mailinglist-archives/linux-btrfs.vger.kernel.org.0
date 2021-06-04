Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848F739B3DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 09:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDH3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 03:29:21 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50772 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhFDH3U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 03:29:20 -0400
Received: by mail-wm1-f43.google.com with SMTP id f20so550667wmg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jun 2021 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3M4wWjyVQ2dLY0qost7U7PeAm1yMeIlZUjp3OOER3w=;
        b=iIPA2DxEQOLMUUX5UK0GTf6XHMeT/3GdTVzQk/NL81DGFvP7T5tdp4gHUPn21O9b4Y
         xZ1glf77gO7Njg4rwiCvim2VGHcfY79tU9otj09bwuf4ofZKOQNnP9Rx7X72vl+16sIr
         OLKKUwG3gfxx5m5S3vKTaE4/1Qx6e2fI/xlb4KAcQbwZauCc8DJgeIpzm8Kjp9iCqyGk
         e7RCN2XrBLokcSQoNDvxEgCuNQZBPTywBq5txksnCmqhZyKIH2SGhzsRrL+cz0RhIT/X
         mllmTU20DduwbwIYf3HiZ9DP2YXpK7NQkT44HPXaiTZO8r6LLIOJXScxQd5wGG0gmoVP
         KW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3M4wWjyVQ2dLY0qost7U7PeAm1yMeIlZUjp3OOER3w=;
        b=OJJxH1VYiY4s+FuaWQN6jcLigzWBpv83FjYM+MuoByt6Ku9rzhaZUfuN8VQYXIvI+g
         uaNQhGsDec54/PgbCPABo66h5pMSr5YjBrhCQE8gY+1vdDjYYvmK771t+9B3tvScCUf2
         9JSJqxig5Q8LThfPcvqdqOgpX1mGtqnFhBR04RtD50FqNVLTSPmD3tlbsef6dQZooZA3
         OaeINnLSklX5jD/MXpZ7O3yzYDjNDEw3IAMGZg4nEhBJ0xNqQb1qfoCDOZ5T3Wr5z80S
         NpQWSB0IdQAWGr+irucY7oJlQ6PPD17wmUa3x0FOkDJNc9ckj4CFyIu6sDvctfcjmRgA
         lE6A==
X-Gm-Message-State: AOAM530qm2/XT+/6AcJonQUeISSX+XB6OYZriEe8rADDE8BUeGfkYNbr
        gfpne1M4s4BSp+6OWO4PxUOfaLaeqpgkB5Kyjca8PA==
X-Google-Smtp-Source: ABdhPJxB7NJNDaMWw3/MisHfK4naivgHE4r9gQyZRdIk0YcRQ5t/i1fIOaMVmLiiM4aS2gMub0f+nDK4bajUSy3mg5Q=
X-Received: by 2002:a1c:b783:: with SMTP id h125mr2204357wmf.182.1622791580723;
 Fri, 04 Jun 2021 00:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <2440004.yYTOSnB24Y@shanti> <CAJCQCtQLYHb7G4YTmsY_cHsBHDzXM6-qQ39YNGHp2mk0mLkLEw@mail.gmail.com>
 <4030217.cPEZuEdVPn@shanti>
In-Reply-To: <4030217.cPEZuEdVPn@shanti>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 4 Jun 2021 01:26:03 -0600
Message-ID: <CAJCQCtTkmUs9DUO41Dwf8t9FQ+zKkKoQY=1mFByJgihaRBM-=w@mail.gmail.com>
Subject: Re: Scrub: Uncorrectable error due to SSD read error
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 4, 2021 at 1:07 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> Mount options look like this.
>
> rw,relatime,lazytime,compress=zstd:3,ssd,discard=async,space_cache,subvolid=257,subvol=/home
>
> I am removing "discard=async". I thought this would be safe with modern
> SSDs.

It should be. So now the question is whether it's some kind of defect
with this particular SSD. Or if it affects make/model. And if it's in
the deny list for mainline. And if upstream is aware of any issues
with this model.

> I always used fstrim manually before, because I was aware of SSDs having
> issue with discard, but when BTRFS introduced queued or batched discard
> I thought I give it a try on a modern SSD.

Completely reasonable.



> > So the drive is not handling queued discard properly is what I
> > suspect. It gets confused. Face plants. Libata then does a hard reset
> > to try to get the drive to come back to reality. And then another
> > discard gets issued and the drive wigs out again.
>
> Thank you. Where did you read this from? I find it challenging to interpret
> the error message the kernel ata layer puts out. They are very detailed and
> I think that is good, but I just do not understand most of it.

Oh man lots of emails on linux-raid@ list over the years. And other
people decipher them. I don't understand most of it either.


-- 
Chris Murphy
