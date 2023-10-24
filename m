Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDF7D46A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 06:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjJXELF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 00:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjJXELA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 00:11:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F4B11A
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 21:10:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5079f9675c6so6356977e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698120655; x=1698725455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R/DnLkXKcbtHeIdj2lNteiEcRFjQW0/FCeNT137Lkzs=;
        b=H1znKBTvR8Dtpn1RvannnzT4eVrs+3dMxIZaC1Wj9QVCzSTtvguQaXDVvDiWR/ImXr
         iV/IZ2Ra7f6Gwu2EgfX+fW/ekeTCtJiGi1SkF46h7/HG+oM/LeA6YqQ750mQ6oVmZLW2
         358cLs0K2urRk0tB0K0VA5haX4+C5LgHDrEE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698120655; x=1698725455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/DnLkXKcbtHeIdj2lNteiEcRFjQW0/FCeNT137Lkzs=;
        b=JlLvtRrTLrR7oqIt7LK2qqlw2HTZXYT7sP4FNErzG1L4Us3scd+9ha+RREJTNexHVo
         1CVHCChG1MFpr3ef/h3r1ECOO0rqqhLa2NWUm7KrNVYtYsz4iga7qKm9kmALj/xkCBA8
         6I+QXzGVXjicrer5twH2HF4tZLN90ol7YPKeU/rRYF+byk49fzBSUsdUkoRqWSEiEh+Z
         EdDrfGv8njm56WBIkVoTQz25z5xkOnjyDF2LX4ehXDGjzBDfFIF4BupoD+CIF7noA1KA
         p10Hy3i9YmiJKWecbIsiDF6oLBS1NsiluYD14spRJQP0HgDW11DBW2ryfNLp3E9lhqTK
         +0nw==
X-Gm-Message-State: AOJu0YxZfeUquVi8qGEPN5pHDrgtxMw1RYxiaus+0cX7zNtJNGiLoSKE
        rqZ8KFG0rDfp/yRqBm0tO9wK4Aa4n3UX+mhhEEeCaT1V
X-Google-Smtp-Source: AGHT+IGV6WuDBYYegsVCmd5TnXPWhoO5DnGe24AciSDQuX+3rTiy17WhLhfoZ4dtxuFlV2CuZVgBOg==
X-Received: by 2002:a05:6512:783:b0:507:c7ae:32cc with SMTP id x3-20020a056512078300b00507c7ae32ccmr7537587lfr.41.1698120654784;
        Mon, 23 Oct 2023 21:10:54 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b00507a3b0eb34sm1953077lfs.264.2023.10.23.21.10.53
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 21:10:54 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6372073e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 21:10:53 -0700 (PDT)
X-Received: by 2002:a05:6402:274e:b0:53e:8e09:524d with SMTP id
 z14-20020a056402274e00b0053e8e09524dmr2329463edd.5.1698120632873; Mon, 23 Oct
 2023 21:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
In-Reply-To: <ZTc8tClCRkfX3kD7@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Oct 2023 18:10:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjUWM8VVJxUYb=XfqvrS38ACS8RxK2ac9qGp9FDT=USkw@mail.gmail.com>
Message-ID: <CAHk-=wjUWM8VVJxUYb=XfqvrS38ACS8RxK2ac9qGp9FDT=USkw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 23 Oct 2023 at 17:40, Dave Chinner <david@fromorbit.com> wrote:
> >
> > Maybe we don't even need a mode, and could just decide that atime
> > updates aren't i_version updates at all?
>
> We do that already - in memory atime updates don't bump i_version at
> all. The issue is the rare persistent atime update requests that
> still happen - they are the ones that trigger an i_version bump on
> XFS, and one of the relatime heuristics tickle this specific issue.

Yes, yes, but that's what I kind of allude to - maybe people still
want the on-disk atime updates, but do they actually want the
i_version updates just because they want more aggressive atime
updates?

> > Or maybe i_version can update, but callers of getattr() could have two
> > bits for that STATX_CHANGE_COOKIE, one for "I care about atime" and
> > one for others, and we'd pass that down to inode_query_version, and
> > we'd have a I_VERSION_QUERIED and a I_VERSION_QUERIED_STRICT, and the
> > "I care about atime" case ould set the strict one.
>
> This makes correct behaviour reliant on the applicaiton using the
> query mechanism correctly. I have my doubts that userspace
> developers will be able to understand the subtle difference between
> the two options and always choose correctly....

I don't think we _have_ a user space interface.

At least the STATX_CHANGE_COOKIE bit isn't exposed to user space at
all. Not in the uapi headers, but not even in xstat():

        /* STATX_CHANGE_COOKIE is kernel-only for now */
        tmp.stx_mask = stat->result_mask & ~STATX_CHANGE_COOKIE;

So the *only* users of STATX_CHANGE_COOKIE seem to be entirely
in-kernel, unless there is something I'm missing where somebody uses
i_version through some other interface (random ioctl?).

End result: splitting STATX_CHANGE_COOKIE into a "I don't care about
atime" and a "give me all change events" shouldn't possibly break
anything that I can see.

The only other uses of inode_query_iversion() seem to be the explicit
directory optimizations (ie the "I'm caching the offset and don't want
to re-check that it's valid unless required, so give me the inode
version for the directory as a way to decide if I need to re-check"
thing).

And those *definitely* don't want i_version updates on any atime updates.

There might be some other use of inode_query_iversion() that I missed,
of course.  But from a quick look, it really looks to me like we can
relax our i_version updates.

              Linus
