Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D517D72CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjJYSDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYSC7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 14:02:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDEE5;
        Wed, 25 Oct 2023 11:02:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc44736f2so399701cf.3;
        Wed, 25 Oct 2023 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698256976; x=1698861776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUt/Ak32KyRE/CxwMT6mH08uSIb++k2Eovg2EcVvQiA=;
        b=envLRNYxXi/KRiWJZ8ivE5p9GjsuqoRQX+IDWSpq3Y9UhXty/9HuHadyq5OfJV7NRv
         ArvuMi+8QDf9zemta7HXHn+G9HKxtPMetiEIuCoebh9rMVJwyaee5l3kPF0UezyvXHN4
         KWFes/fGrCp5w6RjGk/kbjLPNDQgT3B9ax/eX+oM3ViEKoLLEX1HKX9r5cV3ssrusAmJ
         H4CQh2u6fCI5KpBdouUbrOWeo9efDMNgPSuYrQj2UFgj5X1isZApz/FZsX//hXV+BAUF
         YoyBr+p+AttPOxlvGRLFx+Y3N4MABHvHAe1Y/Wema/dONzd7JRyb4SCFkkETIYj+tDdz
         /gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698256976; x=1698861776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUt/Ak32KyRE/CxwMT6mH08uSIb++k2Eovg2EcVvQiA=;
        b=eXURsG94BolHAlsRFlx1KOS5GmpJ9fsHLRN4YBqmoxVFAHtd6kQJmF4PIuKU+nOyJF
         dGZDa8B8sWLi9qyHH1WkpeRHKdJhnFgUPmhLcCmXh/zrWrISd7OiWiRZYQsIyEZPCHaK
         6QKJW6aKpd+dR58dr81CJxArIw/mofuk1Q4GD0qc6FLFXcdFqA2wp0xyj3YCFZGX7Tpg
         vrY7Bs9DzylAITclERt+XMDDpsYP7H7ky2WEB+1fWobk0VuZ5rIhZdnanJLq2lfXRLOp
         f8DTygkZE1KGIWAOMCo1T4zktGLl5cjEDvSK/dI5D6/yg1xd99zCIfMg2akApV8mCpBO
         ON/g==
X-Gm-Message-State: AOJu0Yycx3wliWolVKlLnOyaZQV+gddYdXdyZ5le3NJHBPczsuIw3yvL
        jwNiFCw3m2zyiG+RDHI0aISVuv9VHouEnA0pUfQ=
X-Google-Smtp-Source: AGHT+IHVQA03QmPoGDRQA0xRLgQsYkDscvM9WRmvepXr5v0PCJUBKWbK69Tipff1ijZduB1z6VC2cq/K0i0/T5ro5Bg=
X-Received: by 2002:ad4:5c4a:0:b0:66d:627e:24c0 with SMTP id
 a10-20020ad45c4a000000b0066d627e24c0mr21300439qva.38.1698256976394; Wed, 25
 Oct 2023 11:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231025135048.36153-1-amir73il@gmail.com> <CAOQ4uxg2uFz8bR37bwR_OwnDkq5C7NG+hoqu=7gwSC5Zjd4Ccg@mail.gmail.com>
In-Reply-To: <CAOQ4uxg2uFz8bR37bwR_OwnDkq5C7NG+hoqu=7gwSC5Zjd4Ccg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Oct 2023 21:02:45 +0300
Message-ID: <CAOQ4uxjJFyXUOP_46O9erdCEmwctBc8BVJU_jTzyX4d+m0gFyg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 8:17=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Oct 25, 2023 at 4:50=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Jan,
> >
> > This patch set implements your suggestion [1] for handling fanotify
> > events for filesystems with non-uniform f_fsid.
> >
> > With these changes, events report the fsid as it would be reported
> > by statfs(2) on the same objet, i.e. the sub-volume's fsid for an inode
> > in sub-volume.
> >
> > This creates a small challenge to watching program, which needs to map
> > from fsid in event to a stored mount_fd to use with open_by_handle_at(2=
).
> > Luckily, for btrfs, fsid[0] is uniform and fsid[1] is per sub-volume.
> >
> > I have adapted fsnotifywatch tool [2] to be able to watch btrfs sb.
> > The adapted tool detects the special case of btrfs (a bit hacky) and
> > indexes the mount_fd to be used for open_by_handle_at(2) by fsid[0].
> >
> > Note that this hackacry is not needed when the tool is watching a
> > single filesystem (no need for mount_fd lookup table), because btrfs
> > correctly decodes file handles from any sub-volume with mount_fd from
> > any other sub-volume.
>
> Jan,
>
> Now that I've implemented the userspace part of btrfs sb watch,
> I realize that if userspace has to be aware of the fsid oddity of btrfs
> anyway, maybe reporting the accurate fsid of the object in event is
> not that important at all.
>
> Facts:
> 1. file_handle is unique across all sub-volumes and can be resolved
>     from any fd on any sub-volume
> 2. fsid[0] can be compared to match an event to a btrfs sb, where any
>     fd can be used to resolve file_handle
> 3. userspace needs to be aware of this fsid[0] fact if it watches more
>     than a single sb and userspace needs not care about the value of
>     fsid in event at all when watching a single sb
> 4. even though fanotify never allowed setting sb mark on a path inside
>     btrfs sub-volume, it always reported events on inodes in sub-volumes
>     to btrfs sb watch - those events always carried the "wrong" fsid (i.e=
.
>     the btrfs root volume fsid)
> 5. we already agreed that setting up inode marks on inodes inside
>     sub-volume should be a no brainer
>
> If we allow reporting either sub-vol fsid or root-vol fsid (exactly as
> we do for inodes in sub-vol in current upstream),

Another way to put it is that fsid in event describes the object
that was used to setup the mark not the target object.

If an event is received via an inode/sb/mount mark, the fsid
would always describe the fsid of the inode that was used to setup
the mark and that is always the fsid that userspace would query
statfs(2) at the time of calling the fanotify_mark(2) call.

Maybe it is non trivial to document, but for a library that returns
an opaque "watch descriptor", the "watch descriptor" can always
be deduced from the event.

Does this make sense?

Thanks,
Amir.
