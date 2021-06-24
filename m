Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C83B3508
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFXRy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhFXRy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 13:54:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A28C06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 10:52:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a11so11662369lfg.11
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXzv5t4y0ItgHpXo4Gzuok1AzI9JsF+CNwoC23K+8YE=;
        b=M1HAJTPdELMbDEt8h2s5dhQionIdNRDyHkNhfhY1syeLAo6/VFxObkI/f+lokkkGcE
         j1HF+yGNhbzK/YGIdkZj/X9CQbrxvaqIgb7AlEZBjCOvczeO+Yej2paumVA8emA9rYXt
         mJQ5FMh8uo9EwCuu5+YVha+P+lPLPqVdEafsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXzv5t4y0ItgHpXo4Gzuok1AzI9JsF+CNwoC23K+8YE=;
        b=W/NB4Y22J0Z5krRr0YU11mlX9VuBY4w4bVmrZ6rTVzeih2Yw4impWDvCUNUwP6YF8e
         m5mHhE8trMpyms6E5cDZhONWctajJWBzz26jiuDXdIl02Z1051eE7uG/zMsRKuGWJ+Iv
         Al22i3FNZT4ct2VSjc4NjF2/+vlb9MEdiTu663jKRoNA0Xnk2cloE/+9VNhyngir6VQU
         kfKRiug4HCMeIkNE0dGax/WGcfHK9CjskNyS+s4iDd/61ys+15FpBHrGcHQYYjQllktU
         cejb6lBubl0P0d9ctrJW+1WLSDp6nB0qj+kJ90bA1mE+5Oj3P2oEEn67dSbqzIZ/rdPR
         e8Xw==
X-Gm-Message-State: AOAM5316r0EoCzzE5zAN6m9Optt3JQVO2zOlyPupprmbXxuZtqrkoJTm
        H8LRQLHhSZcnNhowhG6qqOc6k2vpT8vzVNlL
X-Google-Smtp-Source: ABdhPJyaTcKZIQYXYKgzbD2PmViBsOcXEwrX7OqTvfA5FP8/MLgjr35GE+UB7Vm9++s22r3YHQTung==
X-Received: by 2002:a19:600f:: with SMTP id u15mr4768731lfb.149.1624557155557;
        Thu, 24 Jun 2021 10:52:35 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y24sm344166ljk.79.2021.06.24.10.52.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 10:52:33 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id d13so8861521ljg.12
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 10:52:33 -0700 (PDT)
X-Received: by 2002:a2e:7813:: with SMTP id t19mr4741466ljc.411.1624557153074;
 Thu, 24 Jun 2021 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain> <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area> <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk> <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk> <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org> <YNQi3vgCLVs/ExiK@relinquished.localdomain>
In-Reply-To: <YNQi3vgCLVs/ExiK@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 10:52:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
Message-ID: <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 11:15 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Thu, Jun 24, 2021 at 03:00:39AM +0100, Matthew Wilcox wrote:
> >
> > Does that work for O_DIRECT and the required 512-byte alignment?
>
> I suppose the kernel could pad the encoded_iov structure with zeroes to
> the next sector boundary, since zeroes are effectively noops for
> encoded_iov.

Ugh.

I really think the whole "embed the control structure in the stream"
is wrong. The alignment issue is just another sign of that.

Separating it out is the right thing to do. At least the "first iov
entry" thing did separate the control structure from the actual data.
I detest the whole "embed the two together".

            Linus
