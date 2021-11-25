Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6B45E07C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhKYS0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhKYSYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 13:24:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E14C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 10:13:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x6so28797339edr.5
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gv+HQYkMF2MUdwH7i5Rls63Sav/Z6H1TGrZ+exMMaZQ=;
        b=TItRyyYyk4ENYxCUQ4Qsl3l6tZLo/FYeFCqpdiBNSGTaisgS2/ZoqSG/jbgW+X7inj
         iq4iqO/R43G4MV2H+P2Wfu6d4eSHT28liGzs2PrK7DA3wxxtZGxPg7gc6oUzfEYJZefq
         EnMeRVfLN7yBg4Vf3gPpuSzCNtdwPuZ69RxxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gv+HQYkMF2MUdwH7i5Rls63Sav/Z6H1TGrZ+exMMaZQ=;
        b=AQAaruw86+Z3dhVebfku4he0QgNo6xaDl3nszSHSqQLoAaBW0Duyaksk+GKITKeDtR
         XOGIa5O33wwvf8eQXuwmsPC5lr89H8q16ehIh43rg9pA5BZeAV06CjR9rMpNya4V8e2I
         bEghkNBjOnYjWcaCaHUwTVNf1LDBKg8vIGDJJIzVwfVQu+yWjr0UvXTlUO6yBMSrAAa/
         2SeMMkK6rf3tBJPmTz3iv7W6yrwNRmY46CAz5bCrpJAiNte2e4SyvnsUno30lWjAkiAg
         +lDzI40uo9iv8LZay2nfST1lm0XI/+j4+BpTuHe1RNSlwBjR3HugwBCLujHJFRhG9XG0
         44WQ==
X-Gm-Message-State: AOAM532eE5YqrSB21lLoafOZYKCSvX6bj475COsDrmD24tg8hKboxB6p
        trwewzVaU82nUiFFjTkwYR5DI3VDjcza3Ksq
X-Google-Smtp-Source: ABdhPJyM1cuqcTX1w5x+F39faUob6oxZNktQO2cBmK4HEJSA2Vb0UuAHX7UwAp2yUUO8+QUIreEf2Q==
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr33278927ejy.443.1637864023157;
        Thu, 25 Nov 2021 10:13:43 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id w24sm1955558ejk.0.2021.11.25.10.13.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 10:13:41 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id l16so13405405wrp.11
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Nov 2021 10:13:41 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr9078200wrn.318.1637864021623;
 Thu, 25 Nov 2021 10:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com> <YZ9vM91Uj8g36VQC@arm.com>
In-Reply-To: <YZ9vM91Uj8g36VQC@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Nov 2021 10:13:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
Message-ID: <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 25, 2021 at 3:10 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> For this specific btrfs case, if we want go with tuning the offset based
> on the fault address, we'd need copy_to_user_nofault() (or a new
> function) to be exact.

I really don't see why you harp on the exactness.

I really believe that the fix is to make the read/write probing just
be more aggressive.

Make the read/write probing require that AT LEAST <n> bytes be
readable/writable at the beginning, where 'n' is 'min(len,ALIGN)', and
ALIGN is whatever size that copy_from/to_user_xyz() might require just
because it might do multi-byte accesses.

In fact, make ALIGN be perhaps something reasonable like 512 bytes or
whatever, and then you know you can handle the btrfs "copy a whole
structure and reset if that fails" case too.

Don't require that the fundamental copying routines (and whatever
fixup the code might need) be some kind of byte-precise - it's the
error case that should instead be made stricter.

If the user gave you a range that triggered a pointer color mismatch,
then returning an error is fine, rather than say "we'll do as much as
we can and waste time and effort on being byte-exact too".

Your earlier argument was that it was too expensive to probe things.
That was based on looking at the whole range that migth be MB (or GB)
in size. So just make it check the first <n> bytes, and problem
solved.

                 Linus
