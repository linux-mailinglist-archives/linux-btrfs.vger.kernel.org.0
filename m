Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE467D43DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjJXAS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 20:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjJXASz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 20:18:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDB110
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 17:18:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a6190af24aso618508166b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698106731; x=1698711531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iY8F6Fplz1VZOzDrso9gBBR3Wotc9sRtBic5aJbz6WE=;
        b=NFkz4IY8yN89v12HPfLxH+qlwrs2qNUsUulQ5ZRSJHMsg3pU5tq9gXsABmSrkxlrZd
         +cRzmR+NOKzFXMaXPlivzyfHFXat73apu1eFNdnDXH/Jv4LOkb2G1Qk1OMkR5mP7BlgM
         pFm3IGzM7xd1KOPF2yN8/pws6EU2LMbNoCyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106731; x=1698711531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY8F6Fplz1VZOzDrso9gBBR3Wotc9sRtBic5aJbz6WE=;
        b=c8KNKO1pw6qM658erziFkRSwc1EUI+6cAuvMwoRXtimSMsRp3Jco5k0HVfNYNA4/ls
         zFFeZOUvQGP69tL9FbGJnMvLbcUWT3utQJbjtoe/q3XTdCRbpW9PUX3jMjJsec5ltFKu
         HwM5j4U3BRdBlPG3qlx14Wl8EpFtcunsgL7xw4zZjqe7nfPjby/B7x+oWhQX+NqIVBYC
         Hskb46hxiMwQXlvrPIHcZvJahvZ2RQgiSx+nxOsDVpOmNgyTAxizSFG4EH0py1T48umk
         kEqC5p8cpiOtfTC9i9zz/O8NKsn7mbVhV/zbE19EjPJxZk0MUmdCjix29xvZadbSBTZ9
         l5jg==
X-Gm-Message-State: AOJu0Yz0Vw6Mz3t32cpY2oZbzoqICuKs+hnv9ekYqxDLCT5SeecQ708W
        wchPXlijUZJLMx+DY7iLYGxLCPp9gPyJOX0zJ6y2FN22
X-Google-Smtp-Source: AGHT+IH5gpV0wEeQ3SbbUOMzZVZVq2fUkg1ez8vCFVIu2+Opvedo0Lk/VLfTrNDy/E3KgM6WjLnGsQ==
X-Received: by 2002:a17:907:a0c9:b0:9c5:cfa3:d030 with SMTP id hw9-20020a170907a0c900b009c5cfa3d030mr8667361ejc.54.1698106731588;
        Mon, 23 Oct 2023 17:18:51 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090651d600b0099bcd1fa5b0sm7414613ejk.192.2023.10.23.17.18.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 17:18:51 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so614431766b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 17:18:51 -0700 (PDT)
X-Received: by 2002:a50:d795:0:b0:53e:467c:33f1 with SMTP id
 w21-20020a50d795000000b0053e467c33f1mr8315209edi.8.1698106710154; Mon, 23 Oct
 2023 17:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
In-Reply-To: <ZTcBI2xaZz1GdMjX@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Oct 2023 14:18:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Message-ID: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
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
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
>
> The problem is the first read request after a modification has been
> made. That is causing relatime to see mtime > atime and triggering
> an atime update. XFS sees this, does an atime update, and in
> committing that persistent inode metadata update, it calls
> inode_maybe_inc_iversion(force = false) to check if an iversion
> update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> i_version and tells XFS to persist it.

Could we perhaps just have a mode where we don't increment i_version
for just atime updates?

Maybe we don't even need a mode, and could just decide that atime
updates aren't i_version updates at all?

Yes, yes, it's obviously technically a "inode modification", but does
anybody actually *want* atime updates with no actual other changes to
be version events?

Or maybe i_version can update, but callers of getattr() could have two
bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
one for others, and we'd pass that down to inode_query_version, and
we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
"I care about atime" case ould set the strict one.

Then inode_maybe_inc_iversion() could - for atome updates - skip the
version update *unless* it sees that I_VERSION_QUERIED_STRICT bit.

Does that sound sane to people?

Because it does sound completely insane to me to say "inode changed"
and have a cache invalidation just for an atime update.

              Linus
