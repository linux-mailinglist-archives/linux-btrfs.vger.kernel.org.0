Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B31AE3B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgDQRVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgDQRVK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:21:10 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA05208E4;
        Fri, 17 Apr 2020 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587144069;
        bh=6WPFBPtYcHGVPHEbxpbEcnG8YF08lIs6XX8dPj3Hkmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rKbItC8dIZVRPFeczfKyHUMVu6ViM7c3MQCYWOrM0X1k/OUVBfl6yPb1Xg9EFojkC
         dzO8/wDUxjY9vV9nApJXDEsdu94DTZeogBHVuBb+s+oLntYxUlieVbNQBMMwYHoedq
         /OJSjeaBse/Is6BkuoNL/7ssI7M9U/p7OSeMVoYU=
Received: by mail-vs1-f53.google.com with SMTP id t189so1645913vst.7;
        Fri, 17 Apr 2020 10:21:08 -0700 (PDT)
X-Gm-Message-State: AGi0Puaw1UkPj3UkoiR41XW7C4w0XRAPA2oxLstQQP04n/ppRfBgFj7e
        ZuYQGBtZHxfsz3sZCh2WZtQD0S2fuBuBZfECFkQ=
X-Google-Smtp-Source: APiQypJoAV2teHYDYpS8a6zcGXsuyxE5vIQMDh8K0Z62iOQKxbXwz5xNrUrqIQSeUVQioH/oRGcSSlVQnzQH47IdSEQ=
X-Received: by 2002:a67:fe0e:: with SMTP id l14mr3138319vsr.90.1587144067791;
 Fri, 17 Apr 2020 10:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200408103627.11514-1-fdmanana@kernel.org> <20200408181208.12054-1-fdmanana@kernel.org>
 <20200417171050.GE13463@bfoster>
In-Reply-To: <20200417171050.GE13463@bfoster>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Apr 2020 18:20:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5U2+pky9Z1x0SHsKCGDkfs8vSkpu-ayf8fNdddCZ2p1Q@mail.gmail.com>
Message-ID: <CAL3q7H5U2+pky9Z1x0SHsKCGDkfs8vSkpu-ayf8fNdddCZ2p1Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] fsx: move range generation logic into a common helper
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 6:10 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Wed, Apr 08, 2020 at 07:12:08PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have very similar code that generates the destination range for clone,
> > dedupe and copy_file_range operations, so avoid duplicating the code three
> > times and move it into a helper function.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > V2: Turned the first parameter of the helper into a boolean as Darrick suggested.
> >
> >  ltp/fsx.c | 91 +++++++++++++++++++++++++--------------------------------------
> >  1 file changed, 36 insertions(+), 55 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 89a5f60e..9bfc98e0 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> ...
> > @@ -2004,63 +2034,14 @@ test(void)
> >                       keep_size = random() % 2;
> >               break;
> ...
> >       case OP_COPY_RANGE:
> > -             {
> > -                     int tries = 0;
> > -
> > -                     TRIM_OFF_LEN(offset, size, file_size);
> > -                     offset -= offset % readbdy;
> > -                     if (o_direct)
> > -                             size -= size % readbdy;
> > -                     do {
> > -                             if (tries++ >= 30) {
> > -                                     size = 0;
> > -                                     break;
> > -                             }
> > -                             offset2 = random();
> > -                             TRIM_OFF(offset2, maxfilelen);
> > -                             offset2 -= offset2 % writebdy;
>
> It looks like this writebdy bit is lost in the new helper...

Yes, thanks for pointing out. I'll send a v3.

>
> Brian
>
> > -                     } while (range_overlaps(offset, offset2, size) ||
> > -                              offset2 + size > maxfilelen);
> > -                     break;
> > -             }
> > +             generate_dest_range(true, maxfilelen, &offset, &size, &offset2);
> > +             break;
> >       }
> >
> >  have_op:
> > --
> > 2.11.0
> >
>
