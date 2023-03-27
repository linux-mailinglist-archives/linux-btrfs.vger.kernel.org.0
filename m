Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8556CB004
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC0UcM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 16:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjC0UcK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 16:32:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9623A88
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 13:32:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id cn12so41310865edb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679949127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxp1EVdxVt8qlgHHKRG1Y7JI739jemUCra2HGP0osqs=;
        b=kdO7Qf89IMudj+gY/SG4heBdZ4wo1S9XTXF2Ttni93ebq92A84iSMKr00z1EhNQJme
         GQz9RK1N8Vp6GjJ6WtE2NGFktF5knVOCVWmfkOXGy9nRYKrdvdtXsA78or0IeG6OBQHJ
         88WnkZd878Q7vTLKVHn+TRGlkdggiJuiopG9XBbY79U2o2DsUp+XJV6WC/1HXumk9mgy
         vbToDGJYAr5nUNlw6/jITcYeWiv9qoAqIZ/2hAg0JffGfBrMm0gCdMJE46ggJFtOT6Yx
         9LyvHiiq/+4gt4EbiBwJe0aI1w+addXwObWdBD3gZcjC3ON5G668YkR1ZqmhwKlVtHBd
         4AUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679949127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxp1EVdxVt8qlgHHKRG1Y7JI739jemUCra2HGP0osqs=;
        b=AqeTiqJzU0sPt0aV71Ha0DSgMR1kZmY0RIMi6hcMsRXA4ErlZLIxaDMPp2GE6jYQEL
         5gHgKMfRM6Q2trJGINwoEf6gfxwxui826rE4NiOvrPiFeHAtxO+arRiHmpgfN9pfcAWM
         OGfvsX9zyuLjr4+XoegYk+AE4+5K5j8IanAUC0xZ9XG3Bp2tN0jmUNLpwRbSxqt0tbdh
         4xavzB6sOa0pk8o3oVEGxxRUKenWeJxtKLIQmh38MIMfexbqm/2HhCKP8ps+Du2idV1p
         ECWT0Xfg5IeeBcWBi2ifHWU7/8y+lC0PJ21WbjNkgMI2nK4kWLTzn00vZA2s9M4t0oeX
         rs6A==
X-Gm-Message-State: AAQBX9dZ+yva9FbY/TFUEP2osJgLUxB/1AW4KpiNG4CpaCpWh1bdgnJA
        9+0xIiruHEtTQlnoDn2H70yoUNln7Ze+pRKdi9nc/J1r
X-Google-Smtp-Source: AKy350ZhAbNGG7Dk/MvDf8X2ay3M9oHTbtgnF5cmpXVM7gHcdNR7T2ftUvI575n9CNG0a+sZy+lqDcT2OGgzA0tb+sQ=
X-Received: by 2002:a50:bac7:0:b0:4ad:6052:ee90 with SMTP id
 x65-20020a50bac7000000b004ad6052ee90mr6444036ede.7.1679949127131; Mon, 27 Mar
 2023 13:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com> <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
In-Reply-To: <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Mon, 27 Mar 2023 16:31:56 -0400
Message-ID: <CA+H1V9zb8aO_Y37vdwbubqHZds__=hLe06zx1Zz6zdsDLUkqeQ@mail.gmail.com>
Subject: Re: subvolumes as partitions and mount options
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If you want something like this, you will want to have those
subvolumes outside of the root subvolume. For instance, My BTRFS
subvolumes look like this
/ root subvol - The subvolume which is created on mkfs
/@arch - The subvolume I have mounted as /
/@home - The subvolume I have mounted as /home

If you do something like that, then you prevent access by having it
hidden in the root subvolume.

Matthew Warren

On Mon, Mar 27, 2023 at 3:57=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.edu=
> wrote:
>
> On Mon, Mar 27, 2023 at 2:25=E2=80=AFPM Andrei Borzenkov <arvidjaar@gmail=
.com> wrote:
> >
> > On 27.03.2023 21:48, Matt Zagrabelny wrote:
> > > Greetings,
> > >
> > > I have a root partition btrfs file system.
> > >
> > > I need to have /tmp, /var, /var/tmp, /var/log, and other directories
> > > under separate partitions so that certain mount options can be set fo=
r
> > > those partitions/directories.
> > >
> > > I'm testing out a subvolume mount with the subvolume /subv_content
> > > mounted at /subv_mnt.
> > >
> > > For instance, the noexec mount option can be circumvented:
> >
> > "exec/noexec" option applies to mount instance, it is not persistent
> > property of underlying filesystem. It is not specific to btrfs at all.
>
> Agreed. My email was more about subvolumes and the mount point has the
> "noexec", but the actual subvolume doesn't - so there exists a path on
> disk where folks can exec the same file by circumventing the mount
> option by directly invoking the full path under the subvolume.
>
> >
> > bor@bor-Latitude-E5450:/tmp/tst$ ./bin/foo.sh
> > Hello, world!
> > bor@bor-Latitude-E5450:/tmp/tst$ mkdir exec noexec
> > bor@bor-Latitude-E5450:/tmp/tst$ sudo mount -o bind,exec bin exec
> > bor@bor-Latitude-E5450:/tmp/tst$ sudo mount -o bind,noexec bin noexec
> > bor@bor-Latitude-E5450:/tmp/tst$ ./exec/foo.sh
> > Hello, world!
> > bash: ./noexec/foo.sh: Permission denied
> > bor@bor-Latitude-E5450:/tmp/tst$
>
> Agreed completely.
>
> If an attacker can gain access to a system, I'd like /tmp to be
> mounted "noexec".
>
> The attacker can execute the foo.sh via /tmp/tst/bin/foo.sh even
> though the bind mount (/tmp/tst/noexec) restricts the executing of
> programs.
>
> That seems to be the position I am in right now with subvolumes as
> opposed to an actual partition.
>
> If I create a separate partition for /tmp and mount it noexec, there
> is no backdoor bind mount where the attacker can execute programs
> from.
>
> It seems mounting subvolumes works similarly to bind mounts - is there
> a way to mimic /tmp being on a separate partition and mounted with
> noexec using subvolumes?
>
> Thanks for the help!
>
> -m
