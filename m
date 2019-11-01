Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C736CEC522
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKAOzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 10:55:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39329 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfKAOzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Nov 2019 10:55:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id t8so13247004qtc.6
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2019 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NiI6f9HM5k9LcFeeBX6Tv9+K1BTlG6yQirpfWcV6V5g=;
        b=lwR8MenVgI9cOuxrEXooco2/mlJoCnWwAK3dvpWuLfqmI0sbx8xrVGixnxjjJObmYr
         P8JKwY+uQ+Bv98cjqNw99yzQykdCUvqScphvryKKok9cV9TKd7PXZl5lBsx+dhAWZsvk
         eK0487lJFs/DzOn28R9wUajn+dPt9AsCJgrO87ALVQIGngpW0uS/NfehGhbE9UOfQnNq
         ufJ0IseWkGnDBkq/WPTmlBOOr3oHbGHRPzXWmLnxRPuK3WxBA83ts0bnmE6mVRytONAK
         KNeqzhOgzy6YDTyeESas64KXZHoQDvEGrvYqLQcLjdBpxFeW9WFKMIQ6ZrPivTnLLsSk
         Mhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NiI6f9HM5k9LcFeeBX6Tv9+K1BTlG6yQirpfWcV6V5g=;
        b=E2CZM68AGZwRApQkxoLH3VQjQPgX1x+EXU9a1xi/ZlOSKoYGtU4oGr2+8iiadb2H0j
         /Wv4sO6X7IVcfiNH5qmXUFa4Iirq8TQ93ykX/sLSmqP0khvg+RZJ9tNPaWpxFmdDy8jj
         I/ulybGoFi3UitknQXeo36bP4sa7B/WyJi9d6j7u2VVxTxyd7yspkbMLGh12LFOgqijg
         fw0L1MW5S5MyWg7jDJ7Yyo2NQETs14s5Ak2bIY+humGNnlLm3qeK8Npz9thYv9kb5/4C
         2tiplqozkmbPF3iN9r3KNivX6o2r6QBF5Fw248K4GsWEyOzp/egUMpaPa2f35eFNo7aO
         q2fg==
X-Gm-Message-State: APjAAAX+Nzo3MmUassiUQnAQ4lSMpX1H2ssSjVoiZMdYfIuiUQ07UEzr
        NE2zKqo4bKmdvtWPapbu4NQv/ozeQnTeO9IgyB6WCMm6
X-Google-Smtp-Source: APXvYqySSvWdxO7V5R6dRxw9KYJnoP336fR8cnjUtjjYzAt5xUqYiFpUkllzjYbB1d2Wfx1xVD5pCYYhUcu+PKgkHnM=
X-Received: by 2002:ac8:720f:: with SMTP id a15mr503524qtp.112.1572620121126;
 Fri, 01 Nov 2019 07:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572534591.git.dsterba@suse.com>
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 1 Nov 2019 10:54:45 -0400
Message-ID: <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
To:     David Sterba <dsterba@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 31, 2019 at 11:17 AM David Sterba <dsterba@suse.com> wrote:
>
> Here it goes again, RAID1 with 3- and 4- copies. I found the bug that sto=
pped
> it from inclusion last time, it was in the test itself, so the kernel cod=
e is
> effectively unchanged.
>
> So, with 1 or 2 missing devices, replace by device id works. There's one
> annoying thing but not new: regarding replace of a missing device, some
> extra single/dup block groups are created during the replace process.
> Example below. This can happen on plain raid1 with degraded read-write
> mount as well.
>
> Now what's the merge target.
>
> The patches almost made it to 5.3, the changes build on existing code so =
the
> actual addition of new profiles is namely in the definitions and addition=
al
> cases. So it should be safe.
>
> I'm for adding it to 5.5 queue, though we're at rc5 and this can be seen =
as a
> late time for a feature. The user benefits are noticeable, raid1c3 can re=
place
> raid6 of metadata which is the most problematic part and much more compli=
cated
> to fix (write ahead journal or something like that). The feedback regardi=
ng the
> plain 3-copy as a replacement was positive, on IRC and there are mails ab=
out
> that too.
>

What's the reasoning for not submitting this for 5.4? I think the
improvements here are definitely worth pulling into the 5.4 kernel
release...

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
