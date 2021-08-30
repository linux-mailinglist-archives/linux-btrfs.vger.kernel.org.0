Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56913FBD2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhH3Tx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbhH3Tx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 15:53:56 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74933C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:53:02 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id gf5so9026370qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Fe+HznumnxKKIZDcA2KBs6zAgwpU1GEnNMESfbfxOLw=;
        b=aZtUCXDT/uCAaWtvgx6yC7m6H9CB92Llq8mRn9TNGUt1e6IlbK6TFsLa9/Oz9sV3TA
         P2s5WDuLc65fNkjAD7HMkJWVkfAs07wRhvoIpIlkjblI7o3Uextp2U5KHZN5iA0H1VWL
         sB3SkGgCPpClOR1tfmPWUNpwRB/4ZYPUIkYFHKYxHFIP1XrpdMU329jYxnbTEUyr5A82
         jYe0y2WmNV/b+oWGHK4toBGtCbJ9o3lHNEJYJRxdXC4C3kUGQc/T6xF/Ad7pWVaTv1vv
         XMEefA7z135viS++x/q773mBDTKNQc6H0rMSnK2qSygDGJExypHh12gwlulVBfSkcL7C
         8jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Fe+HznumnxKKIZDcA2KBs6zAgwpU1GEnNMESfbfxOLw=;
        b=oD1SMesHIFHlbQqQ82aEEblCRW+4nxGnHB3J9Ra1nafuwq/eUYh1mRCM+XoPheUCF8
         GeHoyPC1hyZ5RtdY0PXLHH2OS4Y+rZ39gvBaq8J5gi1i9DzCkjywGmKQlUs0V5gDe5BY
         2JHF3iVfxUp+poy1EYLwKjKg1YJeK4kqfhstdd5XIpvXAvkpZF0rTYNrDfG/RLyMyCcy
         Kg2rLpnKTpqtUYDMM8rlfMI3C28CDMDtZE9urPBy/GdXNTvo6i6KCz9coz+SsR+7WTKK
         w1cPgi7e6mtoO7RJEFnxEo3iS4s3CCkP0Pv5HLrp360ccwnVq01D6O6w1k7TuWWo7joK
         F02g==
X-Gm-Message-State: AOAM530bjUPdLKruckYfvohLly0oPCp8yi/0+QgS80pZHSNqQRneynQ1
        R32+VaiwdXZPLZ1ASpWLw9s4S65qW1omgEwf06BfJ8JK
X-Google-Smtp-Source: ABdhPJyK/abU+oWCtX+2lGasmIa8kMyev4lQ6Lhd4Ccrq96i4L9bhcOg3d0nj0/oRj6J1u/6CsDml7xF80kD6ZURTYA=
X-Received: by 2002:ad4:4f50:: with SMTP id eu16mr24463482qvb.27.1630353181659;
 Mon, 30 Aug 2021 12:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com> <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
In-Reply-To: <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 20:52:25 +0100
Message-ID: <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 8:08 PM Darrell Enns <darrell@darrellenns.com> wrot=
e:
>
> Yes, those are the correct IDs:
> $btrfs subvolume list /|grep '\(881\)\|\(977\)'
> ID 881 gen 35385 top level 453 path .snapshots/327/snapshot
> ID 977 gen 39922 top level 453 path .snapshots/374/snapshot
>
> The only thing I get in dmesg when running with the debug patch is this:
> [   97.010373] BTRFS info (device dm-3): disk space caching is enabled
> [   97.010375] BTRFS info (device dm-3): has skinny extents
> [  209.435073] BTRFS info (device dm-3): clone: -EINVAL other, src
> 400186 (root 2789) dst 400186 (root 2789), off 79134720 destoff
> 79134720 len 4751360 olen 4751360, src i_size 83886080 dst i_size
> 83886080 bs 4096 remap_flags 0

Hum. Are you running exactly the same send operation, with the same snapsho=
ts?
Because there are no errors for inode 400698 (the one that previously faile=
d).

That means either the previous send operation was not running, but
instead some other for other snapshots (roots), or it ran with success
and those errors are from some other send operation with other roots.

Also, do you have any dedupe tool running in between the send operations?
If you do, that might be doing deduplication on the snapshots and
changing the extent layout of the inodes in a way that makes the
previous send that failed to succeed now.

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
