Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44A4938E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353893AbiASKti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 05:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbiASKti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 05:49:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5203C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 02:49:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x22so7577279lfd.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 02:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MegydTG9Bk5/SowoOJSEKDAbDONmATxcY/sHZkiM3wE=;
        b=TyAivsRQlMp860IWGfBSXExQTmilEImlWN/twnJOBpmjjvt3BB1CArhA/pA8pL9e8B
         NPMzkrFtcUCCFBQOmtmQ1F/UiXvM29M27yYvZ2EI96CRjEw3+XKoRfw8mdEFxc+eI3Nh
         3chqG7RKUMH36XOfZwr5lsW+PpaSMtBQzITc8+4a/X2mWvo156h4STFnY/HT/dToxuzw
         ZjW3Xj7r9D9dK8cipwzTNMJ3uHeYwLvndvDEJsBkKDm5KJXWgzZqASOqDrxXviA40fe6
         heVXJIln4H0B7UvWbrEG2w2bykQE0QXA0EMYNlfUjmejWK77ZYTgypG9FS2xKNl4pcvl
         EmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MegydTG9Bk5/SowoOJSEKDAbDONmATxcY/sHZkiM3wE=;
        b=RuJ1Czi8sZmm7vGFB3AJPIneikU6NoBmnGQPFu+Dbll4pnPwjYn7vEjZKq13QOzymD
         ll2ahCGxGaHqei31WSVWEqm+Vi0M6SMcEzqsAlcLfN3csthMyfE/hUVTIvV5OmzdFGZy
         RR7SbxyrLIqfljH+g4WeNBv6gtYN4PF5NpwIREBRFmGIcDTp3fYBf5o6YKt/Zsie0wWp
         vyMg6Y5J6lyUN5G5SSfB/DB/+Wg+p/MP+UNn+n+7oMEVe3W6YU/zaleqXvmeWZ3LPaEB
         /iRQ2WL0Lo3FJ+hwwyOQ+V5lQ4HVDKfejXqdlW1HrklqojPWfgCZCnJpHZAtPyrLUiGc
         9NFw==
X-Gm-Message-State: AOAM530ZEwRR6JP3mPM2hjumItx3JEKupV/G9X8+NmX5dZ63OpqZYCZF
        UDPQ8O7h0Cyzl69dnornhazIl0qIT3qMhhS8Vyx5dapkzm8=
X-Google-Smtp-Source: ABdhPJxYlj6+Bc66Qnofdi1aLWdsz0VEh2aks+ZXmtfjLMF1FquuoUL5U3xM6xPqW7AquNsh4CT7Ckv2fEgHL24BoZY=
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr16668583ljj.141.1642589375936;
 Wed, 19 Jan 2022 02:49:35 -0800 (PST)
MIME-Version: 1.0
References: <1642323163-2235-1-git-send-email-zhanglikernel@gmail.com> <20220117134441.GG14046@twin.jikos.cz>
In-Reply-To: <20220117134441.GG14046@twin.jikos.cz>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Wed, 19 Jan 2022 18:49:24 +0800
Message-ID: <CAAa-AGm4VUDFNZwe_rY4cJ0XZfXGdGRh0tPhSq-WOZYLVcPgDg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: allow user to insert property
 compression=none to file.
To:     David Sterba <dsterba@suse.cz>, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Old behavior:
# Insert compressed none in the file
$ btrfs property set file compression none
$ btrfs property gets file
# no output, (none value converted to empty string)

New behavior:
# Insert compressed none in the file
$ btrfs property set file compression none
$ btrfs property gets file
compression=3Dnone
(with compression=3Dnone inserted in the file's xattr)


Convert the attribute compression=3Dnone to an empty string "", which was
introduced in commit df11e2787b5b57ecdb313f2725dc5c9a5e549576(btrfs-progs),
according to the comments, in the past it seemed that the empty string
"" represented
no compression, but after commit 5548c8c6f55b(btrfs-devel), the
character The string
"none" means no compression. so the command
"btrfs property set <file> compression none" is not working.

David Sterba <dsterba@suse.cz> =E4=BA=8E2022=E5=B9=B41=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=B8=80 21:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jan 16, 2022 at 04:52:43PM +0800, Li Zhang wrote:
> > 1. If the user adds the property "compression=3Dnone" to the file,
> > remove the code that converts the None string to an empty string.
>
> This is related to 5548c8c6f55b ("btrfs: props: change how empty value
> is interpreted") and needs some explanation that what it does on old and
> new kernel. Maybe some backward compatibility code in progs is needed to
> take the version into account.
>
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > ---
> >  cmds/property.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/cmds/property.c b/cmds/property.c
> > index b3ccc0f..ec1b408 100644
> > --- a/cmds/property.c
> > +++ b/cmds/property.c
> > @@ -190,8 +190,6 @@ static int prop_compression(enum prop_object_type t=
ype,
> >       xattr_name[XATTR_BTRFS_PREFIX_LEN + strlen(name)] =3D '\0';
> >
> >       if (value) {
> > -             if (strcmp(value, "no") =3D=3D 0 || strcmp(value, "none")=
 =3D=3D 0)
> > -                     value =3D "";
> >               sret =3D fsetxattr(fd, xattr_name, value, strlen(value), =
0);
> >       } else {
> >               sret =3D fgetxattr(fd, xattr_name, NULL, 0);
> > --
> > 1.8.3.1
