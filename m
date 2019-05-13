Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E771B1BB86
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 19:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfEMRGH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 13:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbfEMRGH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 13:06:07 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C4621019
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557767166;
        bh=lhoBMedr1HhnUx+2B4IPQxHzoYCGnJu0tFu/s3n5Cj0=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=rvp9tjWcHfdxmbzbmir4APzzH5eDBiaqCNZ905xmTjvVJnKZVEGJU8eKfNho/Hi/m
         IRDSX8eUr+2FISf/qAz2QFagiuciOgj45gqoGDcSos/s/7VSRpNzUpMTrYQaXG3AnP
         CmT+FJnHRHNaTrkwxj5xnbhS5kIupsDysW4Gf54M=
Received: by mail-ua1-f44.google.com with SMTP id t18so2067315uar.4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 10:06:06 -0700 (PDT)
X-Gm-Message-State: APjAAAVsgGYKHIOtQ2NryO05sYi1mGw5sEgM6do0S6yShqzwMDaO6HxU
        QP62HK4OYUgeFHQllgzJC3Ft7W1s0yIJTTWHx7w=
X-Google-Smtp-Source: APXvYqwqO9+zXr3H8LujAerY9N1FJ8mc+1HO5lEZxIsG0l/rHXPLGv3Z9TFxCLfvGp+/2PLsuf0u/+M/9LiLxGOibFE=
X-Received: by 2002:ab0:1e2:: with SMTP id 89mr1211490ual.0.1557767165800;
 Mon, 13 May 2019 10:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190415083018.2224-1-fdmanana@kernel.org> <20190422154342.11873-1-fdmanana@kernel.org>
 <20190513155607.GD3138@twin.jikos.cz> <20190513160704.GE3138@twin.jikos.cz>
 <CAL3q7H7SQEr-jm9tvM8LM_tt6xqSNUU6DLnx3Mmg7n86_y6z1A@mail.gmail.com> <20190513165853.GG3138@twin.jikos.cz>
In-Reply-To: <20190513165853.GG3138@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 May 2019 18:05:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5v8+A5X4sLS_O2NGYcZxhBKauw4LgbXp+36iHkRow+cw@mail.gmail.com>
Message-ID: <CAL3q7H5v8+A5X4sLS_O2NGYcZxhBKauw4LgbXp+36iHkRow+cw@mail.gmail.com>
Subject: Re: [PATCH v2] Btrfs: fix race between send and deduplication that
 lead to failures and crashes
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 5:57 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, May 13, 2019 at 05:18:37PM +0100, Filipe Manana wrote:
> > I would leave it as it is unless users start to complain. Yes, the
> > test does this on purpose.
> > Adding such code/state seems weird to me, instead I would change the
> > rate limit state so that the messages would repeat much less
> > frequently.
>
> The difference to the state tracking is that the warning would be
> printed repeatedly, which I find unnecessary and based on past user
> feedback, there will be somebody asking about that.
>
> The rate limiting can also skip a message that can be for a different
> subvolume, so this makes it harder to diagnose problems.
>
> Current state is not satisfactory at least for me because it hurts
> testing, the test runs for about 2 hours now, besides the log bloat. The

You mean the test case for fstests (btrfs/187) takes 2 hours for you?
For me it takes under 8 minutes for an unpatched btrfs, while a
patched btrfs takes somewhere between 1 minute and 3 minutes. This is
on VMs, with a debug kernel, average/cheap host hardware, etc.

> number of messages that slipped through ratelimiting is now over 11k,
> which is roughly 150k messages printed overall.
