Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC86439E92
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhJYSgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhJYSgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 14:36:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA93C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 11:34:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id m63so28296767ybf.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShP5mfVlafYsKX5YxUr7FchhDv89fnIXD9ALvKPU9AA=;
        b=h1coKi1dXMFGQ4gnJyGqSW3+fyUR4/g25LbS8qZCW0kvQK03lc522DwyCcHJwP1O8+
         icde1iyl3k6DzcCKdGMHpgwUlQClsO0dARa7dHd5fBpszJ8xO0Xo/oojeEBxbfU39hcQ
         3OJZwlJovLg14c5oCQ5PXpkb9ML5lrg5HlQFL+DJ73FKMRYYUIX75tCywAZqca5h762Y
         yVn4dyY3/a/0+O68sKj/BhQREiwkbKGQOGXL84KtEfeV5g9JGINy0d7bL8JN1sOAJmbl
         elZHl0T9PAhri6971+fU6JOhbgBmGbKFxD9YgLZHysOoqBp5RoNna8dfRsk2raIV+NZT
         QLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShP5mfVlafYsKX5YxUr7FchhDv89fnIXD9ALvKPU9AA=;
        b=t/ykt40T4fWAgP4hBnY4i3Bf/exqpFFMrXW9+cIYfUkYuW9jxkN9wcC34/z+5N2xIx
         70C+UnV17tXSHO2S04+g0AHNPX56TWwRNiyYKs6kz7epvdOdgozkNzivLX2+05mpq0do
         DrjhHLNeW9oIEZwG9TNvkyUf0vCyB7dNddI37OmkFk+OIASjLOPBpbF0Y4tW6r68DGjz
         HRga2kLrNdipDYvSIOUgZFpH0WzbpgXtaii3NDSvGcWgqY9AtdU7EmIerLVFUyV0a9zy
         AanQRsZonWjRXLNg92P0kyOj/OIORbpZg2o9Z5kJltu1lfESfhug0xzZpNi+ZYdSuHkR
         VACw==
X-Gm-Message-State: AOAM530W633IsOFh0HQ8Nz/qwgtx9inex5axRhq6aSGe9V0oj6/BH/J7
        zom40STDptvCJ/YqOegwEp9k/4SsWB5ZWxkwPztoyQ==
X-Google-Smtp-Source: ABdhPJy8aZfDC6EFtWf7JQR2/OxrY7NeL1kEXuImH0P49aw+HySXElf0l9T1n7CTWXmoAevMm9NOeTUjQvxgUSjRtx4=
X-Received: by 2002:a05:6902:102f:: with SMTP id x15mr17888034ybt.341.1635186857096;
 Mon, 25 Oct 2021 11:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
 <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com> <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
In-Reply-To: <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 Oct 2021 14:34:00 -0400
Message-ID: <CAJCQCtTBg0BkccvsiRA+KgGL6ObwCqPPx8bb=QZhcaC=tXUsBA@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > Vendor ID:           Cavium
> > Model:               1
> > Model name:          ThunderX 88XX

I still haven't hit the WARN_ON. But weirdly I'm not getting the oops
with 5.14.14 but can hit it with 5.14.10... though the sample size is
small. And it definitely is smelling like a race. I'll keep trying to
hit it with 5.14.10 because I want to see if this WARN_ON will get hit
and give us more information.


--
Chris Murphy
