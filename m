Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7227CF3D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjJSJRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjJSJRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 05:17:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F9B98
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 02:17:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so8060a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697707030; x=1698311830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEyDbtqB+udvOtvaRFHUtqkxP21cSIdHZt9QvgU76Yo=;
        b=gUJNtTYMrP5DGqoqxGj9WuqZk22rfp9lcd62KUldL91ausAgz/MBXtVh9xH3wIyciJ
         n0j5YQ91PA60pk+gW3M1D2a4rvwRchL3gFD5qlGrLxNYMevMZZX51yQu9vRRUIMC5dzx
         7yb9s+qTdgXD/XusbB0f8zHj0ZuVBTaEfbxgZz3su1xeGfg2TUKfqnOLa2CxO45TOVB4
         TCY5i4NhjEa6euMXefLFjM167qtiXoQdybBq4/xyC3lCZt2gmFZq+kl2s4kslU13KBMk
         pZZmwzols+DXQM3+sjj+cBKLmr2l7Nlteu2hI6Bba6jzF81StfMv4MCtOBt9TPHrdf71
         aAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697707030; x=1698311830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEyDbtqB+udvOtvaRFHUtqkxP21cSIdHZt9QvgU76Yo=;
        b=aNVMCsJ9ozI3jgRW6v5oJj+shb3dKD5s+LPEXI3HN6Z+utTdnp0HQl05tjpzm4zgy6
         SAAGZh86YC+oYNfD6Tkw/PflTn0piry2Zn8We/ZtjKAMznjRmNsA1xutGuylaxUT+qu1
         OuKj1MI6EkoAFfGmHOymGjwZyOyNEYAaERA7m7wLCY1GL5e6+iqFCmqvyHEmrTH5U0Wa
         kOIbvucEmEkz4FBG/O56iUfXAIKM0BFC4MxE2XiJSQ/2b6mxDaXvLmtE07YiDDeKrSri
         ZyVme2lJoWm1uThuceml88tx2iNwip5Bo762Rf1T6P8sIjqyJjv+ygrifZ/ZQS3bFtOQ
         H4Gg==
X-Gm-Message-State: AOJu0YydNXc92nwdOMr595EmgsIxtB7tW2ZgR/ZJjHFBM8iOmzcNexEv
        Y8bDh40V8cWEQ2NC/DBw5+iUHP99u7Il0Undu+Jh/Q==
X-Google-Smtp-Source: AGHT+IFEEOs06c4WLSibf/51HO7uvqmnfpk/QYoWjbqqV6cbgP/iEpuh1W4eTm4WVvsBFqs3xdA3t1pCVl57WxJ/c9c=
X-Received: by 2002:a50:a45a:0:b0:53d:b53c:946b with SMTP id
 v26-20020a50a45a000000b0053db53c946bmr92741edb.2.1697707030233; Thu, 19 Oct
 2023 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230704122727.17096-1-jack@suse.cz> <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain> <20230822101154.7udsf4tdwtns2prj@quack3>
In-Reply-To: <20230822101154.7udsf4tdwtns2prj@quack3>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 19 Oct 2023 11:16:55 +0200
Message-ID: <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Jan,

Thank you for the series!

Have you already had a chance to push an updated version of it?
I tried to search LKML, but didn't find anything.

Or did you decide to put it off until later?

--=20
Aleksandr

On Tue, Aug 22, 2023 at 12:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi Eric!
>
> On Mon 21-08-23 22:35:23, Eric Biggers wrote:
> > On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
> > > Writing to mounted devices is dangerous and can lead to filesystem
> > > corruption as well as crashes. Furthermore syzbot comes with more and
> > > more involved examples how to corrupt block device under a mounted
> > > filesystem leading to kernel crashes and reports we can do nothing
> > > about. Add tracking of writers to each block device and a kernel cmdl=
ine
> > > argument which controls whether writes to block devices open with
> > > BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> > > this flag for used devices.
> > >
> > > Syzbot can use this cmdline argument option to avoid uninteresting
> > > crashes. Also users whose userspace setup does not need writing to
> > > mounted block devices can set this option for hardening.
> > >
> > > Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd=
9@linaro.org
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> >
> > Can you make it clear that the important thing this patch prevents is
> > writes to the block device's buffer cache, not writes to the underlying
> > storage?  It's super important not to confuse the two cases.
>
> Right, I've already updated the description of the help text in the kconf=
ig
> to explicitely explain that this does not prevent underlying device conte=
nt
> from being modified, it just prevents writes the the block device itself.
> But I guess I can also explain this (with a bit more technical details) i=
n
> the changelog. Good idea.
>
> > Related to this topic, I wonder if there is any value in providing an o=
ption
> > that would allow O_DIRECT writes but forbid buffered writes?  Would tha=
t be
> > useful for any of the known use cases for writing to mounted block devi=
ces?
>
> I'm not sure how useful that would be but it would be certainly rather
> difficult to implement. The problem is we can currently fallback from
> direct to buffered IO as we see fit, also we need to invalidate page cach=
e
> while doing direct IO which can fail etc. So it will be a rather nasty ca=
n
> of worms to open...
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
