Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C135FF8A0
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Oct 2022 07:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJOFhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Oct 2022 01:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJOFhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Oct 2022 01:37:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0606A6D9EB
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 22:37:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3573ed7cc15so64301917b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnRXmL6Mwh0ThyXrVvoa1cb3cJyVI4f1V9p3sh3CDys=;
        b=T2DJJLq7rlkEecNgjSC0ATCYP8TAx/iuCzU8D/Ky6Z/ImlivfX3eJ2Dpaz0QSyUOkI
         P/6WJvetTdlpYMLInMNLvCaDZVXrCKp4vx6pRu01Ghgmkd9Te9TCg6kGqAidR4JO45ug
         wJVpcAjBGO++PEAfr/2cxMOvFRqRJOic0gCV+2/osadzr85zjW46JvldUSd6yEir/E9j
         YznvcTu89YVhCcPJHqOEQMOrD/BJ3omW1XK4YAcqWqyFBqfnUITOZrh8dVCBBfS/NeLt
         NG91uQrxSUpD0e04RsarQXahtGVrwNjHhCdJDGZ3gtYQZkCg1BLOXKb/8PeNH/xQ7yad
         XvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnRXmL6Mwh0ThyXrVvoa1cb3cJyVI4f1V9p3sh3CDys=;
        b=EEtWEOuPxt4SiwFcrmZcI+FXgN9sGzgSNh1AzaCMrvrsusTnyirgrKPM3YcnuYwylg
         hp912ClJVUN8Da1zEvFNru0hl/hZxz+eqLS7HbYcnoWIlF8CNIxJYDs1oPGXLlMV7YDK
         C7NUeVZcj1isKLD6zMQrY9UU9QgH2xL6Yi/4dDUmKT1h/OPGKSvG3eQsazc0ZeQ+S/X1
         ngCmgdt3PlJ4IKeOLoWnYrvC3ZI0/SuQuEzbIuGIBHFrB0RM4ScMrkSjVNKV3BVVh+pS
         zGyN3vze9WdMMdQtrengCE50G4R6qaQ4nAL4sSbhFTubVyc7g6g3bkHbqDcwpYJL5ojq
         ApJw==
X-Gm-Message-State: ACrzQf308cwrt/SFeKANoYxvZnTBKXQQUghsfsmZ8kQyJ9qbJvVlZVjN
        WV4d0FDhiwJWUHk3sM61jxkZ4ZrCNTMW1/CKEMiOIndprBMPUA==
X-Google-Smtp-Source: AMsMyM406pOkeZUjTm6fw4f5dUzAm+jkFgNTdvGACYiHOsN7yA+TynmNoDajFG0d5Rlqa3iinhTG1AVK+WEH7A5nD18=
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr1018546ywl.67.1665812254195; Fri, 14
 Oct 2022 22:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQmekd_X=XSZWq+JN0vq+vyYJTxdvsZJBCuCeqEDkz=RVW0NQ@mail.gmail.com>
 <d345acda-9095-318f-9de6-b3eb83dc6921@gmail.com>
In-Reply-To: <d345acda-9095-318f-9de6-b3eb83dc6921@gmail.com>
From:   Nikolaos Chatzikonstantinou <nchatz314@gmail.com>
Date:   Sat, 15 Oct 2022 01:37:23 -0400
Message-ID: <CAAQmekdjMKAT_VRErYKmJ+aHjakWhvE_NgcQyCZ_jNF5ePUpVQ@mail.gmail.com>
Subject: Re: documentation of swapfile and nodatacow
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 3:21 PM Andrei Borzenkov <arvidjaar@gmail.com> wrot=
e:
>
> On 14.10.2022 21:04, Nikolaos Chatzikonstantinou wrote:
> > Hello list,
> >
> > This question popped up during the writing of a swapfile
> > guide. Following
> > <https://btrfs.readthedocs.io/en/latest/Swapfile.html>, I chose to put
> > the swapfile on a separate subvolume which does not get
> > snapshotted. The steps I have:
> >
> >    btrfs subvolume create swap
> >    chattr +C swap
> >    chmod 0700 swap
> >    fallocate -l 1G swap/swapfile
> >    chmod 0600 swap/swapfile
> >    mkswap swap/swapfile
> >
> > I'm uncertain about the chattr step. In
> > <https://btrfs.readthedocs.io/en/latest/btrfs-man5.html#mount-options>
> > I find the note
> >
> >    "This means that (for example) you can=E2=80=99t set per-subvolume
> >    nodatacow, nodatasum, or compress using mount options."
> >
> > which applies for mount options. On btrfs(5) I find under FILE
> > ATTRIBUTES
> >
> >    C      no copy-on-write, file data modifications are done in-place
> >
> >           When set on a directory, all newly created files will inherit
> >           this attribute.
> >
> >           NOTE:
> >              Due to implementation limitations, this flag can be
> >              set/unset only on empty files.
> >
> > This says that the +C attribute can only be set on files, not
> > directories, although it explains (in theory?) what should happen if a
> > directory has that attribute.
> >
> > To summarize, I'd like to ask:
> >
> > 1) Can `chattr +C` be used on a subvolume? Is it different from mount
> >     option nodatacow?
> >
>
> chattr +C is not used "on a subvolume". It applies to top level
> subvolume directory and then is inherited as per documentation.

Correction: Can +C be used in a directory and is it different from
nodatacow in a subvolume?

> > 2) Should the man page be reworded 'only on files that are empty'?
> >
>
> Which man page? Man page you quoted (btrfs(5)) already says it.

The meaning is different; my proposition clarifies that the "only"
rule applies to files. Otherwise, I explained above that it is
contradictory: it implies +C cannot be used in directories, although
it explains what its purpose would be there. Alternatively, a
different rewording: it can be reworded to say "only on empty files or
directories", if that is true.

> > 3) Should the readthedocs page be changed to include the subvolume
> >     creation step and remove the `truncate -s 0` step?
> >
>
> Why should it enforce any particular layout? It is up to each user to
> decide where swap file is located. The commands in documentation work
> also when file already exists.

The page has "To create and activate a swapfile run the following
commands:", which means the swapfile is created, it doesn't exist.
There is no reason to force the layout. What do you think of creating
the subvolume to indicate the inability to take snapshots? Wouldn't
most users want a dedicated swap subvolume?

Regards,
Nikolaos Chatzikonstantinou
