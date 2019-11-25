Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59B10944F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKYTjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:39:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34365 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYTjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:39:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id bo14so7056730pjb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MBxWDkXpERqkSDmMhodvqUg0A3hHgxZWxKtcdO3owk=;
        b=G/S6X4qW+KCWwWsTZ30hKhGDTXPozUY6KO/wTOF/NqESVUfZHxKMK73KWqEolwpFfX
         lKSB+c+FzIJBcLbOSNo46LFaDsPdEoEciWzAftJwOAEQ2ulyPRkuaeezuodFmgV1t6Yx
         n9PI8sBPYl9WSdpuCSMFL4nosfJNY5xmX8OI840P6tOaKB4R2yzAWwT1ja1uNK/nLJ88
         tlE47Lw9vZXQehP24l+aL1+TrKflLmdA8qtiMp18GH3qj1FI37PSo8ki07agaWKcQOWF
         QA3O/YYkgC5Dse0/r0itGSnTzPZDCESmxCIVh3jBGU00aJleVObXdq9iMF8juutD+Wtv
         Fq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MBxWDkXpERqkSDmMhodvqUg0A3hHgxZWxKtcdO3owk=;
        b=RozPS2IixK95SFjlzWtcj2+/MXO/PfZs5OrWeVaftt5iALT4yOk3JKsJ50tivOqdcI
         LPtEnwNntwzXZy3agqv69hPbKgxCpGWQVvOT6IZJ6JThPEFOkpLDbOFjqgfumR7iImUs
         3D4JYxySwqAZG5kx3cXR9sH5Tb217fCdHx0UDG9LNhiNpjUvnYNGJZptv0D9d0XFTLzy
         rp/u41g1BUDkodrzmU6uEhoSuK8hwspUn0Vbyzk2nvXW8GJLBXJsw3RpW7XwaYE+rpJA
         7b4zU8sw3bZgcndhoCPiuviAoCIXML5vky0MswLQpHvFF1bFbEWXDnLcEzCtWxAwdJfe
         +CtA==
X-Gm-Message-State: APjAAAWZoKZni6kuwKo6ahQAC+4nRvZWwNCD/5hTFtlDPtpNaWL95oIj
        l4YaCU3ZqejcWsQRrNLLxcSlOZE/Ymyg7qlS3w7Grw==
X-Google-Smtp-Source: APXvYqx0q4HEgjD9JrP4AWKwnmjTpmQfvZt9298pmTr4dcYXx0tuesGY7w6SO8LAaYOR3ISzbub2FdLnmwHNpUQZsz0=
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr29731936plo.223.1574710759582;
 Mon, 25 Nov 2019 11:39:19 -0800 (PST)
MIME-Version: 1.0
References: <201911220351.HPI9gxNo%lkp@intel.com> <CAKwvOdn5j37AYzmoOsaSqyYdBkjqevbTrSyGQypB+G_NgxX0fQ@mail.gmail.com>
 <20191125185931.GA30548@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191125185931.GA30548@dennisz-mbp.dhcp.thefacebook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Nov 2019 11:39:08 -0800
Message-ID: <CAKwvOdnaiXo8qqK_tyiYvw5Fo4HvdFzrMxLU7k62qEWucC-58Q@mail.gmail.com>
Subject: Re: [PATCH 05/22] btrfs: add the beginning of async discard, discard workqueue
To:     Dennis Zhou <dennis@kernel.org>, Chen Rong <rong.a.chen@intel.com>,
        Philip Li <philip.li@intel.com>
Cc:     kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 25, 2019 at 10:59 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> On Thu, Nov 21, 2019 at 08:27:43PM -0800, Nick Desaulniers wrote:
> > Hi Dennis,
> > Below is a 0day bot report from a build w/ Clang. Warning looks legit,
> > can you please take a look?
> >
>
> Ah thanks for this! Yeah that was a miss when I switched from flags ->
> an enum and didn't update the declaration properly. I'll be sending out
> a v4 as another fix for arm has some rebase conflicts.
>
> Is there a way to enable so I get these emails directly?

+ Rong, Philip

The reports have only been sent to our mailing list where we've been
manually triaging them.  The issue with enabling them globally was
that the script to reproduce the warning still doesn't mention how to
build w/ Clang.

In general the reports have been high value (I ignore most reports
with -Wimplicit-function-declaration, which is the most frequent as it
shows the patch was not compile tested at all).

Rong, Philip, it's been a while since we talked about this last. Is
there a general timeline of when these reports will be turned on
globally?  Even if the directions to reproduce aren't quite right,
generally there's enough info in the existing bugs where authors can
rewrite their patch without even needing to rebuild with Clang (though
having correct directions to reproduce would be nice, we could wait
until someone asked for them explicitly).

-- 
Thanks,
~Nick Desaulniers
