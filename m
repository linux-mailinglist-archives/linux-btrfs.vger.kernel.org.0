Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE324C246
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgHTPfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgHTPfM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:35:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65232C061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:35:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g14so2654262iom.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=59HyUWzgFHtjW9LWaOZ76fsWtzO56A4rfTDU2tBFCg4=;
        b=YbHhccVhoXJdD9TTREk634Xb2GtfMMqJPtVMGs2fzWhYLi5gDt280z8WZlJC4Z5aB5
         q7AABU6Rzl5AZ5fcgOE7tuzWFyT6IXQpzGgqY9ngqXQJ+URH0kxENjSY+y1fnrNz34lu
         /eWxeMl9lAi9AS8F46eo7Whr1vKcURyKtq5n80oQQRVaEHl3wl+RKAq+qbC0HKuxxt+g
         QCzTbaiV7+k3Dk4eo62Efu/tkj/GltV07qtVpq6CQNKPc4402Xx2g0peXuqdHykEb7NF
         8ZwMSCTjBD4GJwdfvqH22f/eEOf4+efXgG/GxH79XtjaR4TLNNwilu8YLTsvMVjaCGlE
         BokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=59HyUWzgFHtjW9LWaOZ76fsWtzO56A4rfTDU2tBFCg4=;
        b=He+nCEBZePCxVvaW3ux/4won9D1guqBzWKGzLzGwHSHnhws2a815vejhRuuNV7jLks
         frlnLlEiTZgyeylQCTyeoZ9QLkxiFMBnAemP7l8QXbB63sZzaDe9wpIkiPChpja92zoj
         pjvePS2Q9eWhw/DJjdcSbEz3a1PKVX7w2wfUUEp9/ANSAHGyIjqtgQPpmJOldv+Jywjd
         /E49Uxog1sdyHXdF7bPW3PLeG4gj+XpHb+ihJnkRijOu4rMkgazAUQcnuXDjYws3IVtw
         JV1mSxZZLg/seDCfjLmlNS13iV5n5D8+1oDGUqFs8hFxSeMknR5O1F02j6EkVSbol/6H
         3C7w==
X-Gm-Message-State: AOAM533eruZYFTb50IFFk/dqUqxqvJvY5g7WMxiRCFE1qg3ea6GA0qHc
        /+Zc4mDzCBqS47ryYsEMBVXnrSeeyytL1VIg2FQ=
X-Google-Smtp-Source: ABdhPJzlwQJsXT/8iJObOgjDtGvHlco+4Zp6w9jsNeIO5KllzNO3ICxI+DvyNRXOPToTu3z2Y8g1nOOJVGOYZD4UHLQ=
X-Received: by 2002:a02:84c1:: with SMTP id f59mr3742090jai.106.1597937711454;
 Thu, 20 Aug 2020 08:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <33c25613-1cd4-ffdb-0b79-5058cf5e2ced@toxicpanda.com>
 <CAEg-Je87or5MNL0Ttea+Hh5Bp=oMFEtt01JVJooyXQycscsMAg@mail.gmail.com>
 <e457e4d3-1b63-641f-f19d-7d818c46d16e@toxicpanda.com> <CAEg-Je-s+rO1s3yYRH+7Ji5Wrxvf_u1VC=gj+NvZUVrQAYq3Ww@mail.gmail.com>
In-Reply-To: <CAEg-Je-s+rO1s3yYRH+7Ji5Wrxvf_u1VC=gj+NvZUVrQAYq3Ww@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 20 Aug 2020 11:34:35 -0400
Message-ID: <CAEg-Je91i9J-D_rBcHe5ThQOV-W387mbRGg=o_eiRA9HASh_LQ@mail.gmail.com>
Subject: Re: [RFC] Tying in github issues into our workflow
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Pierre-Yves Chibon <pingou@pingoured.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 20, 2020 at 11:31 AM Neal Gompa <ngompa13@gmail.com> wrote:
>
>
> There's a basic REST+JSON interface as well, the API documentation is
> present on the /api endpoint of any pagure instance, like so:
> http://pagure.io/api
>

I should clarify here that "basic" means simple, not incomplete. Most
(if not all) actions in the UI are possible through the API.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
