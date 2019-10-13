Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED9D53C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Oct 2019 04:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfJMCMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Oct 2019 22:12:21 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37898 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfJMCMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Oct 2019 22:12:21 -0400
Received: by mail-vs1-f68.google.com with SMTP id b123so8713020vsb.5
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2019 19:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c9JWijPWjClWb96KIjXDC0CUgoJGM9SktqrQH8GfRLc=;
        b=gffzYozJg8qmHk/xM8H2+aTre1XzPHhRZiTIntZxZjCEZV2IYOBVHRjF25T/bH9il4
         bc4Frxypp3AfJeO3Qg4WsMVQ/IeYco0erwhCguFx5+bLceVM00QdiuZuaz/os7KdMocz
         saEbc6AtqfyhS9ueKH07i//SDBHTDPdwjS5tMfwEx91D4hHy7yxrL1k9RKAqBaPhqaYd
         18sMwOgnxXrBTrdjSiSGxCsgtYdQPGOlf4olFR+opGlkmg7sVwevd380jRJ5a31Mem4B
         LAqooR3yuYGNACUuPoL6fClP/Gh3CxSYkQYrG/lF/ULhOQWxSmZs8uh1jBW8P+goxToH
         WUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c9JWijPWjClWb96KIjXDC0CUgoJGM9SktqrQH8GfRLc=;
        b=GxlOdpkMpWyTTxRBuYJNnd7fNE9Lalp2TUVYuOR0gwgkxIG0voFRuP5tOsf0XCoBXC
         xB9LBKogHJX7OndkiAnBLU/NC+6HXDvbzTxJL6V3BBQv8S7ENrRz84Lir9OpTMIbjqKA
         Soxs1PUVSOh2UHJ7Lb8DUraJbiV2uevfPoki5nf/+4AWZKosI/12D2jW4mabNkQEQpmg
         Im5n9fDptYdueTikUrWDZcDiNx98DEtMkBtoNREBicG+lEkMltAcUGbpDr/igN581lZR
         wqbxtSO/YA7dVHCDlYqa0LjG3nZRnny3huZ0PE2Rs7ld4soVH4JCZpF9KfhGgXHv2bkx
         fS4A==
X-Gm-Message-State: APjAAAWKVh/O/ZZ7sQck2FTKWTxASy4hXbxasAkI3FKuIMUCFChgFQ7Y
        ZZC+0tjIPn2+rrEAkgu/Q4OyFLRChKyF1AMcrXTjAxNn
X-Google-Smtp-Source: APXvYqzgMPvyC6ndKON1Od28jWYY3MDofqjoCQYKEI0aiNzojzj/nTSiQ3infJqsVxvEAQixPtIAKGkGBTlfTpxCtio=
X-Received: by 2002:a67:fe47:: with SMTP id m7mr13961172vsr.100.1570932740463;
 Sat, 12 Oct 2019 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
 <CA+X5Wn7YTu_xc2n8aAO1S37HUDxW2Trst3iau-YiZnNC3SpacA@mail.gmail.com>
In-Reply-To: <CA+X5Wn7YTu_xc2n8aAO1S37HUDxW2Trst3iau-YiZnNC3SpacA@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Sat, 12 Oct 2019 22:12:08 -0400
Message-ID: <CA+X5Wn5TvJzz4=89W7SZoN3d9d9MZeJvjmhjqPAQkd4SxrDKKg@mail.gmail.com>
Subject: Re: 5.3.0 deadlock: btrfs_sync_file / btrfs_async_reclaim_metadata_space
 / btrfs_page_mkwrite
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 12, 2019 at 7:32 PM James Harvey <jamespharvey20@gmail.com> wrote:
>
> On Sat, Oct 12, 2019 at 7:29 PM James Harvey <jamespharvey20@gmail.com> wrote:
> >
> > Was using a temporary BTRFS volume to compile mongodb, which is quite
> > intensive and takes quite a bit of time.  The volume has been
> > deadlocked for about 12 hours.
> >
> > ...

Not a one time fluke.  Attempted recompilation of mongodb, and BTRFS
deadlocked again, on a different spot but almost as far into it as
before.  Similar looking sysrq-trigger, included just because I'm
already replying saying this wasn't a fluke.  http://ix.io/1YsR
