Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2CE5971
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJZJX7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 05:23:59 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33479 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJZJX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 05:23:59 -0400
Received: by mail-ed1-f46.google.com with SMTP id c4so3850611edl.0
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2019 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHfvhE6ACfDxt3rWPEhospfJ/F4pPZm2qnTeFA3YM0M=;
        b=Qp5Bkv/hCUTp/9sSpIfRTx3Aw74EFRvLtMQJrnP8SpC5rNCcx6gcyAMp3PXU5LJcFw
         E4zinADlLHYl9O5vRCJFsynWGgr5/Pex0086+19TSGXkWeqBIjgBzUMCoGY/8RzlVdhY
         uyuYn1V8HV/T0XjOKb/1CNyrHUC4V8W0Fr0f+Y8wf2LnAoHU+G7SXLxZOpa8QLE1znEW
         5Rh3DJmecBdqvS5wP1v428BVOvKpY54zBPaMs7c4T5/qlIWmG81iK3D+9Ui/223C9pGw
         NLRZCpATNswFJy3zt9MmvFEmtUQRN6NkW8WYf/9XVDQtn1tw5Gea8FAlV9bo4Phq+3+P
         seHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHfvhE6ACfDxt3rWPEhospfJ/F4pPZm2qnTeFA3YM0M=;
        b=umLSyGwH0dSiL12njNALtBe/elm7Yyakd5VCu/L8tJ3qb8JrUNln4IqiTvYp2/TSPr
         BLPQvrdgG7xagL133SR1zr374uKRLKP1CBjiqnHbm+tbIa5fCD5dV8lHfZVnoos7Ut1m
         oOGuRGXfrcNmScEaxs0ljKAyuzTZkyRffseDpegxvtcmmDJA8gHek0jhC8gRi+1qkLNk
         Ck9NBtEvbYS/N5Fte7Po0SsxegWpwZQ9nWJXx33pIJwg8pCvsQcI5jj0OWg2Hu7KWVOH
         n/IZufTuL/vNP0NLIETRlrhsXyQro6KCbHiHLzPWUHsPehr3+4pJoiRZQbgamXgI7g6H
         hnvQ==
X-Gm-Message-State: APjAAAWJd5kyuz2R5eE70yrp3MDz5f5U7AARvi7JsPxV+w370i2h69Hu
        pCGlPlaRuhhdJijflY281Di7FcmJ675w9NKayA==
X-Google-Smtp-Source: APXvYqxHok7IqhMZ0bGyfZAjNYfS1rueVNvUr6Xgg/mQIEFrBxGbopc1CEE0UNb2tvJIFeV/Xrlk3q8koC9YQSQZhxs=
X-Received: by 2002:aa7:dcd4:: with SMTP id w20mr8419745edu.52.1572081837413;
 Sat, 26 Oct 2019 02:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com> <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com> <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com> <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com> <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com> <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com>
In-Reply-To: <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sat, 26 Oct 2019 11:23:20 +0200
Message-ID: <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Sa., 26. Okt. 2019 um 02:01 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> It's already working, the problem is, there is a dirty log while
> nologreplay mount option doesn't really work.

For the record, I didn't try to mount using nologreplay, only
notreelog. (Apologies if notreelog and/or skipbg imply nologreplay.)

> You can btrfs-zero-log to clear the log, then try again using skipbg
> mount option.

I don't think I can, actually. At least, zeroing the log didn't work
back when btrfs check --repair was still in the table. Admittedly,
that was using Ubuntu eoan's 5.3 kernel, not yours, and with their
btrfs-progs (5.2.1); I don't think I'd gotten around to compiling
btrfs-progs 5.3, yet. So if you think trying again with the
rescue_options kernel and/or latest btrfs-progs might allow me to zero
the log, I'll try again.
Alternatively, using backup super 1 or 2 got me past that hurdle with
btrfs check --repair, so if there's an option to mount using one of
these ...?
(Output quoted below for reference.)

> > $ btrfs check --init-extent-tree patient
> > Opening filesystem to check...
> > Checking filesystem on patient
> > UUID: c2bd83d6-2261-47bb-8d18-5aba949651d7
> > repair mode will force to clear out log tree, are you sure? [y/N]: y
> > ERROR: Corrupted fs, no valid METADATA block group found
> > ERROR: failed to zero log tree: -117
> > ERROR: attempt to start transaction over already running one
> > # rollback
> >
> > $ btrfs rescue zero-log patient
> > checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> > checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> > bad tree block 284041084928, bytenr mismatch, want=284041084928, have=0
> > ERROR: could not open ctree
> > # rollback
> >
> > # hm, super 0 has log_root 284056535040, super 1 and 2 have log_root 0 ...
> > [...]

> And thanks for the report, I'll look into why nologreplay doesn't work.

On the contrary, thank you! It's the least I can do. If there's
anything else I can to help make it less likely (something like) this
bites me or anyone else again, just say the word. Also, I'm curious as
to the state of the data and btrfs restore doesn't care about
checksums, so I'd love to be able to ro-mount the image sometime.

Cheers,
C.
