Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FB6F363E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 May 2023 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjEASuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEASuS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 14:50:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6DC6
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 11:50:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so393440a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 May 2023 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682967014; x=1685559014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJsDytAkzpo1N72CvaRaEHpBmg/KeBVFFxmvg3mMNXA=;
        b=adBwuu89iCtYiMyq/Oqh8jtUUMQ30inGM2uqK/ZHob/SJ4G1/fYcRRHlo3Ur28aqjG
         7Bbs3fkzZ+xptL3cAD+rvmD2wBUaCCGlfQXnvpatD4jFv4WpOqtMZdzS3wmt7gma7jsF
         Zjkw9PDgEj0xOgyf3JGDXm48Y2XoOEnOGDaBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967014; x=1685559014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJsDytAkzpo1N72CvaRaEHpBmg/KeBVFFxmvg3mMNXA=;
        b=bpfrIy3t6iCO8KiqJcI3epL+5QrGFOFDC5b+7CxarxHVslbX0JlBMVYF90v+H5W4st
         EOBno48L1S22onqJsySxuwRS0PvTKkvFW9ub6ic/RsCwv0jhlSy05Shd0z6pcnX0B/bD
         p2WxwVgjcpB5XyKlWY2JMmvwOYdiJhCX0KiwQKGGCxhcprepRJvSb8WNE9iGnchr1+6s
         MiDNwcEYTpfEvY09cEuZUqE4hc3SXfAEbpwuBzg9nRnLrZwZw2kmGPLiR2D5QRo/pR88
         +PlHKgMhtZqFhG4zAtua/7ALjiF2Ya9KE2y3OqnF/P2H53jkZ9PAQgoUl9I9N+B+xklC
         jB5w==
X-Gm-Message-State: AC+VfDwGC0XlwoY758bL305FD5wPWRNanFnVyOkIadpP1cLCOW6EdLvn
        O3WC8IPEQSVIPj1ijIf0+Hh4WiBJmWaoisGirRd5Kw==
X-Google-Smtp-Source: ACHHUZ4qLLcWDmuQierXshIatuUzQzexYNItygblmXZWozs/8tU6uO7ePCFtw1ac9HyNVD0gdqO+VQ==
X-Received: by 2002:a17:907:988:b0:94f:17b7:c4b9 with SMTP id bf8-20020a170907098800b0094f17b7c4b9mr14398376ejc.42.1682967014507;
        Mon, 01 May 2023 11:50:14 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709065ad300b0095381e27d13sm14854266ejs.184.2023.05.01.11.50.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 11:50:13 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so2592755a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 May 2023 11:50:12 -0700 (PDT)
X-Received: by 2002:aa7:d8cb:0:b0:50b:cff8:ff1f with SMTP id
 k11-20020aa7d8cb000000b0050bcff8ff1fmr310706eds.42.1682967012421; Mon, 01 May
 2023 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000de34bd05f3c6fe19@google.com> <0000000000001ec6ce05fa9a4bf7@google.com>
In-Reply-To: <0000000000001ec6ce05fa9a4bf7@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 May 2023 11:49:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWUZyiFvHpkC35DXo713GKFjqCWwY1uCs3tbMJ6QXeWg@mail.gmail.com>
Message-ID: <CAHk-=whWUZyiFvHpkC35DXo713GKFjqCWwY1uCs3tbMJ6QXeWg@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] BUG: unable to handle kernel paging request in clear_user_rep_good
To:     syzbot <syzbot+401145a9a237779feb26@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@suse.de>, stable <stable@vger.kernel.org>
Cc:     almaz.alexandrovich@paragon-software.com, clm@fb.com,
        djwong@kernel.org, dsterba@suse.com, hch@infradead.org,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ Added Borislav and stable people ]

On Sun, Apr 30, 2023 at 9:31=E2=80=AFPM syzbot
<syzbot+401145a9a237779feb26@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:

Indeed.

My initial reaction was "no, that didn't fix anything, it just cleaned
stuff up", but it turns out that yes, it did in fact fix a real bug in
the process.

The fix was not intentional, but the cleanup actually got rid of buggy code=
.

So here's the automatic marker for syzbot:

#syz fix: x86: don't use REP_GOOD or ERMS for user memory clearing

and the reason for the bug - in case people care - is that the old
clear_user_rep_good (which no longer exists after that commit) had the
exception entry pointing to the wrong instruction.

The buggy code did:

    .Lrep_good_bytes:
            mov %edx, %ecx
            rep stosb

and the exception entry weas

        _ASM_EXTABLE_UA(.Lrep_good_bytes, .Lrep_good_exit)

so the exception entry pointed at the register move instruction, not
at the actual "rep stosb" that does the user space store.

End result: if you had a situation where you *should* return -EFAULT,
and you triggered that "last final bytes" case, instead of the
exception handling dealing with it properly and fixing it up, you got
that kernel oops.

The bug goes back to commit 0db7058e8e23 ("x86/clear_user: Make it
faster") from about a year ago, which made it into v6.1.

It only affects old hardware that doesn't have the ERMS capability
flag, which *probably* means that it's mostly only triggerable in
virtualization (since pretty much any CPU from the last decade has
ERMS, afaik).

Borislav - opinions? This needs fixing for v6.1..v6.3, and the options are:

 (1) just fix up the exception entry. I think this is literally this
one-liner, but somebody should double-check me. I did *not* actually
test this:

    --- a/arch/x86/lib/clear_page_64.S
    +++ b/arch/x86/lib/clear_page_64.S
    @@ -142,8 +142,8 @@ SYM_FUNC_START(clear_user_rep_good)
            and $7, %edx
            jz .Lrep_good_exit

    -.Lrep_good_bytes:
            mov %edx, %ecx
    +.Lrep_good_bytes:
            rep stosb

     .Lrep_good_exit:

   because the only use of '.Lrep_good_bytes' is that exception table entry=
.

 (2) backport just that one commit for clear_user

     In this case we should probably do commit e046fe5a36a9 ("x86: set
FSRS automatically on AMD CPUs that have FSRM") too, since that commit
changes the decision to use 'rep stosb' to check FSRS.

 (3) backport the entire series of commits:

        git log --oneline v6.3..034ff37d3407

Or we could even revert that commit 0db7058e8e23, but it seems silly
to revert when we have so many ways to fix it, including a one-line
code movement.

Borislav / stable people? Opinions?

                         Linus
