Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C613722FE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfETJK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 05:10:29 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37571 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfETJK3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 05:10:29 -0400
Received: by mail-vs1-f65.google.com with SMTP id o5so8469075vsq.4
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2019 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4yBWukTDw6yk7nUCxZVIJqWE0PiKnsdpDGdzxD1nZEM=;
        b=VK9aCkcNifwTHK1AjX9YUwr5rEak+awjchlpWhm8GxN/C0WGbg1RNi7gNX7kQjW/y0
         LjAstLYhEpY/uy3BHwm/mH8oS4F/ZvmDAIOjcYZllQKMFapfZrMbdBWJvNAq+1Ynedy8
         6GdBSYu5O5zN9r8Yh9IN3zFnCtNvgjaq0XtPQo5X8NtqnpUJQCmWS+i0PxNe6MvSpK9u
         uc/GOLOo7EfvrOhya1thzGXiwShTuSrQZZoiWoPvUSq0idz29dcY6KiSugQm0PKznkka
         di3jSEJIlsTEy96z4ajEX4Te7xMixr+3tPNlSRw+yd0RhKqBkQVQugcZc7MU2Oe33T8q
         Y4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4yBWukTDw6yk7nUCxZVIJqWE0PiKnsdpDGdzxD1nZEM=;
        b=nkq9QdvKaYjsKKN056eMNYlNyA1dM3YqBimtnd96v9hygeO9nfPAxMOegx11Hpme4J
         nLru9AFc4Doc2PRaSIdADr9U+5OemSeYizU+JSnAqsUwZ0w8gmFIHlkghR06TMx3WoWu
         Hd6d6jwPaY93Dz8RzNRwh4Goj0q1LxHQTII5XhO2wt02I4hAoynkEOWZw5Q2Y1RRTUSU
         scilBp53vCpYGGHaeQAp9gdj9cmsz08F+2edt10n4lLFLzBhX3T9ONt59jhV9Fc68CA0
         LrYmT/1WSj7/aSVCftegKw9UUdbhxSBI+syx3trN9on/yQCuTE4ARYVW+1HVg+AeXbyZ
         YfHw==
X-Gm-Message-State: APjAAAU1gLHlwgXlmB1r5OyKCHxcw0Jl0gCsmc+NzbzmT0975aWIWlKY
        8oiwKvsiy0m/B2kGcZTB0W9iBULtCe1sRqzOYVbDoQ==
X-Google-Smtp-Source: APXvYqw6Rypw3WtatLJo23irSfC/pQBVYP8RKBp7WPhEF6S3pxNFY1bP7j1IoZHjTjbx5qoTAlTouv2gcJ70W77PuCc=
X-Received: by 2002:a67:e891:: with SMTP id x17mr21976183vsn.206.1558343427660;
 Mon, 20 May 2019 02:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190520081142.23706-1-nborisov@suse.com> <560224d9-28ec-033f-c7c0-f324576e5e04@suse.com>
In-Reply-To: <560224d9-28ec-033f-c7c0-f324576e5e04@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 20 May 2019 10:10:16 +0100
Message-ID: <CAL3q7H5MHYhrvLnqHagkmLS_cey6Bc-nZh-21ivGjbSPjZ76+Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Simplify join_running_log_trans
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 9:23 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 20.05.19 =D0=B3. 11:11 =D1=87., Nikolay Borisov wrote:
> > This patch removes stray smp_mb before root->log_root from join_running=
_log_trans
> > as well as the unlocked check for root->log_root. log_root is only set =
in
> > btrfs_add_log_tree, called from start_log_trans under root->log_mutex.
> > Furthermore, log_root is freed in btrfs_free_log, called from commit_fs=
_root,
> > which in turn is called from transaction's critical section (TRANS_COMM=
IT_DOING).
> > Those 2 locking invariants ensure join_running_log_trans don't see inva=
lid
> > values of ->log_root.
> >
> > Additionally this results in around 26% improvement when deleting 500k =
files/dir.
> > All values are in seconds.
> >
> >       With Patch (real)       With patch (sys)        Without patch (re=
al)    Without patch (sys)
> >           80                                  78                       =
                       91                                              90
> >               63                                      62               =
                               93                                          =
    91
> >               65                                      64               =
                               92                                          =
    90
> >               67                                      65               =
                               93                                          =
    90
> >               75                                      73               =
                               90                                          =
    88
> >               75                                      73               =
                               91                                          =
    89
> >               75                                      73               =
                               93                                          =
    90
> >               74                                      73               =
                               89                                          =
    87
> >               76                                      74               =
                               91                                          =
    89
> > stddev        5.76146200581454        5.45690184791497        1.4240006=
2421959        1.22474487139159
> > mean  72.2222222222222        70.5555555555556        91.4444444444444 =
       89.3333333333333
> > median  75                                    73                       =
                       91                                              90
> >
>     With Patch (real)   With patch (sys)    Without patch (real)    Witho=
ut patch (sys)
>         80                   78                     91                   =
   90
>         63                   62                     93                   =
   91
>         65                   64                     92                   =
   90
>         67                   65                     93                   =
   90
>         75                   73                     90                   =
   88
>         75                   73                     91                   =
   89
>         75                   73                     93                   =
   90
>         74                   73                     89                   =
   87
>         76                   74                     91                   =
   89
> stddev  5.76146200581454    5.45690184791497    1.42400062421959    1.224=
74487139159
> mean    72.2222222222222    70.5555555555556    91.4444444444444    89.33=
33333333333
> median  75                   73                     91                   =
   90

Great.

How was that test done?
Simply deleting the files with nothing else running in parallel?

How does it behave if while the files are being deleted,  there are
concurrent fsyncs on other files of the same subvolume, that is, while
the mutex is held?

Because that check without holding the mutex, is likely there for
performance reasons.

Thanks.


>
>
> Here's the perf data without being butchered.
>
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >
> > This passed full xfstest run and the performance results were obtained =
with the
> > following testcase:
> >
> > #!/bin/bash
> > for i in {1..10}; do
> >     echo "Testun run : %i"
> >     ./ltp/fsstress -z -d /media/scratch/ -f creat=3D100 -n 500000
> >     sync
> >     time rm -rf /media/scratch/*
> >     sync
> > done
> >
> >  fs/btrfs/tree-log.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 6adcd8a2c5c7..61744d8af106 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -188,10 +188,6 @@ static int join_running_log_trans(struct btrfs_roo=
t *root)
> >  {
> >       int ret =3D -ENOENT;
> >
> > -     smp_mb();
> > -     if (!root->log_root)
> > -             return -ENOENT;
> > -
> >       mutex_lock(&root->log_mutex);
> >       if (root->log_root) {
> >               ret =3D 0;
> >



--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
