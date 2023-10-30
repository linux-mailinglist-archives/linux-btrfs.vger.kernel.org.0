Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE0C7DC2FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjJ3XMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 19:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjJ3XMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 19:12:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B866FF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 16:12:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso506699466b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698707557; x=1699312357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9soNDg/CzKcFVIkPX7HzsMrN43wo2kJXg9OOVu3o/I=;
        b=fdZ8SEJq6yfsQNAiq0g71R1jSj+uX04cD3JIVyPTL6iLvMh9tFzLeoAvlWep/D1VgO
         3ooBXJxMJoDpwYEyRPm6EWfjP5mWWVr/0YwRCn3lEeVsGBH6xfUacG3BShwoK1Tr8rcq
         tqEI97S9do9F6VQCtxJXSe6myaOSbu7j4dup0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707557; x=1699312357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9soNDg/CzKcFVIkPX7HzsMrN43wo2kJXg9OOVu3o/I=;
        b=B0Ey4rW7BPdvNMVb+Pm56Xi61kmpBc6ZIAhtugq2dJHwGfqqhnqvAKh4oyyYAxi2qa
         RG8Q+4G95m7TUbRBQWprzjHg5jMqrPyjEJwgiX7g6xAUGf2Rw1bqhFY70mnGM4691w6e
         /+l02ARMaq+MYVKhDw0TaOoo/knCIZs0dB6nJ6osUBfHoe4p8L8dCDFM3xGKs3dUYEYN
         ig+W+VrVaaPbQaPO8faG131WMjCqsrclzaECwnBVJGgxlvMrtSv20zm9aLF1by5/VCSM
         WcEl6RzU+fSQUZPKojvFhO9cCbX3LSWy+1oTOgGu+LLQIc1nHxNzmQN8VJopqq677gdb
         oTVA==
X-Gm-Message-State: AOJu0YyC40sDYO/GJFHTDphn1dMkz/cZDmfXM5QcoehrGGk/4lHzVLN2
        mK3TFpfAZr66x3EF8CqzyYdMSr6+1vfxZ1yRKVrOCg==
X-Google-Smtp-Source: AGHT+IGqLBDuMPi5FSdrLf0CBzmN5YOfe24ZgNteLHe/gvhFnEWAykLFFCHGCoG8X6ZH6INO5rOeIw==
X-Received: by 2002:a17:906:730d:b0:9bd:a75a:5644 with SMTP id di13-20020a170906730d00b009bda75a5644mr10112456ejc.16.1698707556772;
        Mon, 30 Oct 2023 16:12:36 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id gw17-20020a170906f15100b0099bcd1fa5b0sm17474ejb.192.2023.10.30.16.12.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 16:12:36 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso506697466b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 16:12:35 -0700 (PDT)
X-Received: by 2002:a17:907:25c4:b0:9ae:4776:5a3a with SMTP id
 ae4-20020a17090725c400b009ae47765a3amr9873098ejc.39.1698707534524; Mon, 30
 Oct 2023 16:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area> <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
In-Reply-To: <ZUAwFkAizH1PrIZp@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 13:11:56 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
Message-ID: <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.de>, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 30 Oct 2023 at 12:37, Dave Chinner <david@fromorbit.com> wrote:
>
> If XFS can ignore relatime or lazytime persistent updates for given
> situations, then *we don't need to make periodic on-disk updates of
> atime*. This makes the whole problem of "persistent atime update bumps
> i_version" go away because then we *aren't making persistent atime
> updates* except when some other persistent modification that bumps
> [cm]time occurs.

Well, I think this should be split into two independent questions:

 (a) are relatime or lazytime atime updates persistent if nothing else changes?

 (b) do atime updates _ever_ update i_version *regardless* of relatime
or lazytime?

and honestly, I think the best answer to (b) would be that "no,
i_version should simply not change for atime updates". And I think
that answer is what it is because no user of i_version seems to want
it.

Now, the reason it's a single question for you is that apparently for
XFS, the only thing that matters is "inode was written to disk" and
that "di_changecount" value is thus related to the persistence of
atime updates, but splitting di_changecount out to be a separate thing
from i_version seems to be on the table, so I think those two things
really could be independent issues.

> But I don't want to do this unconditionally - for systems not
> running anything that samples i_version we want relatime/lazytime
> to behave as they are supposed to and do periodic persistent updates
> as per normal. Principle of least surprise and all that jazz.

Well - see above: I think in a perfect world, we'd simply never change
i_version at all for any atime updates, and relatime/lazytime simply
wouldn't be an issue at all wrt i_version.

Wouldn't _that_ be the trule "least surprising" behavior? Considering
that nobody wants i_version to change for what are otherwise pure
reads (that's kind of the *definition* of atime, after all).

Now, the annoyance here is that *both* (a) and (b) then have that
impact of "i_version no longer tracks di_changecount".

So I don't think the issue here is "i_version" per se. I think in a
vacuum, the best option of i_version is pretty obvious.  But if you
want i_version to track di_changecount, *then* you end up with that
situation where the persistence of atime matters, and i_version needs
to update whenever a (persistent) atime update happens.

> So we really need an indication for inodes that we should enable this
> mode for the inode. I have asked if we can have per-operation
> context flag to trigger this given the needs for io_uring to have
> context flags for timestamp updates to be added.

I really think some kind of new and even *more* complex and
non-intuitive behavior is the worst of both worlds. Having atime
updates be conditionally persistent - on top of already being delayed
by lazytime/relatime - and having the persistence magically change
depending on whether something wants to get i_version updates - sounds
just completely crazy.

Particularly as *none* of the people who want i_version updates
actually want them for atime at all.

So I really think this all boils down to "is xfs really willing to
split bi_changecount from i_version"?

> I have asked if we can have an inode flag set by the VFS or
> application code for this. e.g. a flag set by nfsd whenever it accesses a
> given inode.
>
> I have asked if this inode flag can just be triggered if we ever see
> I_VERSION_QUERIED set or statx is used to retrieve a change cookie,
> and whether this is a reliable mechanism for setting such a flag.

See above: linking this to I_VERSION_QUERIED is horrific. The people
who set that bit do *NOT* want atime updates to change i_version under
any circumstances. It was always a mistake.

This really is all *entirely* an artifact of that "bi_changecount" vs
"i_version" being tied together. You did seem to imply that you'd be
ok with having "bi_changecount" be split from i_version, ie from an
earlier email in this thread:

 "Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
  the change cookie, we really don't need to expose di_changecount in
  i_version at all - we could simply copy an internal di_changecount
  value into the statx cookie field in xfs_vn_getattr() and there
  would be almost no change of behaviour from the perspective of NFS
  and IMA at all"

but while I suspect *that* part is easy and straightforward, the
problem then becomes one of "what about the persistence of i_version",
and then you'd need a new field for *that* anyway, and would want a
new on-disk format regardless.

           Linus
