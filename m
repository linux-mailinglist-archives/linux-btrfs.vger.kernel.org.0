Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0B467CE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbhLCSBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 13:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhLCSBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 13:01:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C227C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 09:58:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so14492357eda.12
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yea/SdPe3Gf0ohGg/Nl9Dqn2dARuQKMuNBUEpNaPxnk=;
        b=Ubriqb40c1PZS+79Dl6j67Ias5PFWYTrTRHRXKNlc7sSYxaE9wYBjxyC2ET6CeH0H/
         LnH8SbyKY9szc98MCI90ie9zcuBu5Y34WfRd/GMLJtle5kfVh0AwRKnG8MJLoubu8YDL
         ZU4vQrHR4IY6sZT9u+4VyXu0CNyY4uP8EmYUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yea/SdPe3Gf0ohGg/Nl9Dqn2dARuQKMuNBUEpNaPxnk=;
        b=rjarzJsIw8BEfCxsCNqOo7NQil1SuUTRI6UAGoBfjlo/kqqXTEzo4/Mrmq2vpc6y32
         RaGAVsPT41mNLSWuHXpLFcWaNjyI8KvrQgRStXnwdQPxVL4U7RUgowUyzdhSCGFqA5kM
         erxsTOsV468mfR5BlEmjMhhA+MdfM1/6UOk2fACn2NgPF4s/Z/8qgrS8ep0SBtWepReM
         BDVTHKwU4MyG4VegdeedcOOoEjXET4iFCb82F3YORCRggAMAoczvrgRf8AWF+Xu7q9XP
         7rdywrW3mlP8Gsho4e40q3tlWHyi6gJpNMnh/s09yAdUPKTe2BCsOHRcsROG0qtCmlh1
         A2PQ==
X-Gm-Message-State: AOAM530dpijorkrZZ9xai/hTXgUl1/iaUnjGGHTWkTV3IuI7lIhhsQgf
        I1sm6bDogXfHw5sDmCM5FfJdt0ReQevXBAYJ
X-Google-Smtp-Source: ABdhPJyRhuf3Xajbs0LoVasMQOJpwIUdI9NknS3j/TG4xW8CTfsglEQM+YBXOzsfxJXa/sCnTCMoUw==
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr27883835edc.328.1638554294757;
        Fri, 03 Dec 2021 09:58:14 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id e1sm2326701edc.27.2021.12.03.09.58.13
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 09:58:14 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2798758wme.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 09:58:13 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr16117373wmc.152.1638554293325;
 Fri, 03 Dec 2021 09:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20211201193750.2097885-1-catalin.marinas@arm.com> <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
In-Reply-To: <CAHc6FU7gXfZk7=Xj+RjxCqkmsrcAhenfbeoqa4AmHd5+vgja7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Dec 2021 09:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com>
Message-ID: <CAHk-=wiQAQTGdMNLCKwgnt4EiAXf7Bm6p7NQx5-31S9-qPD8jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Avoid live-lock in fault-in+uaccess loops with
 sub-page faults
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 3, 2021 at 7:29 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
>
> We're trying pretty hard to handle large I/O requests efficiently at
> the filesystem level. A small, static upper limit in the fault-in
> functions has the potential to ruin those efforts. So I'm not a fan of
> that.

I don't think fault-in should happen under any sane normal circumstances.

Except for low-memory situations, and then you don't want to fault in
large areas.

Do you really expect to write big areas that the user has never even
touched? That would be literally insane.

And if the user _has_ touched them, then they'll in in-core. Except
for the "swapped out" case.

End result: this is purely a correctness issue, not a performance issue.

                       Linus
