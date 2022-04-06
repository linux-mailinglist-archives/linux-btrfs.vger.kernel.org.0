Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538E94F6CF0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiDFVjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiDFVhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:37:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B9EE4DC
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 13:51:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r2so4442889iod.9
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5QuozJn8SJm6ZtmTj2iM2rklI5jRjBkh+B7y5qWT2w=;
        b=QPrEj+zIcZOik+sduxnDOSXLH7lP17+byfNuwf52XDJGZbqNnEqT9TAFU9+8/gES/6
         1hJSSf8U5L0g8I699hgOGg4K2bLMt4vC2iqlxM0Ael4e1mXsDqfV+wn04xTYIWVn03Va
         SFU0E0fv7VeSIWLmexwQx8sJLR88A13SpliKYUJDjkfH4BTQXm13/JwqrRRZ/gj7Tcwn
         P2Hs/gV4/z86sHLE0ZmdOClTeK5hR+rNHq3vJM/VNJWR7t7qnT4fDBEDFlW5111sUI/j
         OdosKqOmmgNkfHDp3DEL/MfAEhghGO0aDL4W4jA0WywFGrqXci3k3csygBlPdoEGy0Wx
         Pnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5QuozJn8SJm6ZtmTj2iM2rklI5jRjBkh+B7y5qWT2w=;
        b=ry3HtfVapFl+ozH24XVhrvmxaBJYKJq3L+GdDy91EpNPinIqfKr/JBuQOrPFxpesGz
         3m69O7CpCJGPljFLAPzC1CC+CpeZOuI7C/2jW2GcYHh4zmjtrGm2WgnsuEqwrcFWI8VI
         gu8eKhh/0s5PeKNAZGTY2GIRDlHPuJE1TtvL8EH9zOV9LOYVuoQo+GTtcHFYLUrLl+IJ
         ds9naNeMjODLNlRR7Dfyg+xjGPdBp8Yf21KroMlHC5PZ6BnmlFJEYcu71XlLLqIhAfrE
         tqkHLVPy3YjtLyNqoWpjp7aFlnNPwU03PbHqgYqzm4Ff5huiHHYxvqW7kNbwyZcyp/Y6
         lXfg==
X-Gm-Message-State: AOAM530/6CVmi9TrCQU+RUePn5nb4tPggCaNLZpk0iqbIkbNSc+2MdOb
        q5D9a1KGGZP0ETGG3FaD4Cgx8bDfSuLtWqTzX0aezvSgaNE=
X-Google-Smtp-Source: ABdhPJwazdpcBwYllykVqoLlgk03O8KGedXrzXGzc2f2b7HDasTW7ymwnIkq8GChrWQtzyxnO+FvhXGGqCGmR7SwQ4M=
X-Received: by 2002:a02:b10f:0:b0:323:9bba:a956 with SMTP id
 r15-20020a02b10f000000b003239bbaa956mr5571513jah.313.1649278285096; Wed, 06
 Apr 2022 13:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org> <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org> <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org> <20220406191317.GC14804@merlins.org> <20220406203811.GF14804@merlins.org>
In-Reply-To: <20220406203811.GF14804@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 16:51:14 -0400
Message-ID: <CAEzrpqdLm+Kwp9AWtPvxEBHXXm3wb_NhGLnhxsAsEXhufstPPw@mail.gmail.com>
Subject: Re: figuring out why transient double raid failure caused a fair
 amount of btrfs corruption
To:     Marc MERLIN <marc@merlins.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 6, 2022 at 4:38 PM Marc MERLIN <marc@merlins.org> wrote:
>
> This is an interesting discussion, so let's make a new thread out of it.
> TL;DR: I think btrfs may have failed to go read only earlier, causing
> more damage than needed to be, or some block layers just held enough
> data in flight that partial data got written, causing more damage than
> expected.
> Figuring out the underlying problem would be good to avoid this again.
>

There's a lot here, and there's a lot of good information, but in
general btrfs should never fail like this.  We have a lot of power
fail testing and error handling testing, but this is very limited.  I
found a bug last year where we would write an updated super block that
pointed to garbage if we happened to be fsync'ing at the same time we
were committing the transaction and got an error during the
transaction commit phase.

We can't do anything about the disks lying to us.  If a disk has a
wonky FUA/FLUSH implementation then we're just sort of screwed.
Unfortunately because our metadata moves around a lot we're waaaaay
more susceptible to this failure case than ext4 or xfs, their metadata
is relatively static they can put humpty dumpty back together again
relatively simply.

Btrfs needs to

1. Go whole hog on error injection testing.  I only barely scratched
the surface with my bpf error injection stuff.  This is on our roadmap
and I plan on devoting developer time to this, but clearly that
doesn't help you right now.
2. Put a lot more effort into disaster recovery.  What I've written
for you is an idea I've had in my head for a while.  Some of this
failures aren't catastrophic, we can generally pretty easily put back
together a file system that resembles something sane by simply
stitching together blocks that we find that are close enough to what
we wanted.  Unfortunately this gets back-burnered because in reality
this doesn't happen that often.
3. Test these btrfs+dmcrypt+mdraid setups.  Every time I notice one of
these catastrophic failures it generally involves btrfs+<something
else>.  This is likely just because it's a timing thing, you put more
layers you get a wider window in per-io races, you're more likely to
be sad in the event of a failure.  However it would be good to make
sure these layers are doing the correct thing themselves.

We need to be better about this scenario, both in making sure we don't
have bugs that contribute to the problem, but also that we have the
tools necessary to recover when things go wrong.  Thanks,

Josef
