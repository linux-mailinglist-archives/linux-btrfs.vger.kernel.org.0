Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41819AEF97
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436784AbfIJQc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 12:32:59 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51636 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQc7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 12:32:59 -0400
Received: by mail-wm1-f54.google.com with SMTP id 7so290632wme.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBgs1vTripQPGETOC9BrXmidAXKYBlUt6OidX02raiY=;
        b=EL9dCYqc6petwcm0LT6waXHG65axMs/ijCtx4SA7s42tb2EHtokGu5kIoZDIOCvr57
         scAcErvktMMgO86mR+JGVPYnnuneVnb0pD4w9KhuEWxj31zlS0G5txDeyn/EJvmTWZtM
         et6y0jwWj54Oc3opco2bSw9ajcp4mO6isHlOk+DcCM+DaelRdj8cVpSjkvLmv96T+qUV
         CY6Gvbv1dLWDyrGi/MzJ3cCegGAq7FUaH3S6TbXE2LrGoGHpS2Zdw351HKeiKm8zfYZi
         7AAgiBjbPOmG71DwmQMZBRqtt8oCDE5pfrUv953B+EwUIplW5WlZgF32V8v6Y3Av0L5h
         5OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBgs1vTripQPGETOC9BrXmidAXKYBlUt6OidX02raiY=;
        b=mzgfaQvE/inOLmb6Xa1wlwkDZHkiPOscGNUYXq/lE0a8LZI2B2KXVMm0ec0VMVF5Ol
         oXoAofKb38PP5CXBeQdz/8i0esY0lCnqLv+lhlpmy5MlAD8mmRIz/XZCOZ3XMEPy+rzD
         Pi/E+fwPLQV8i6Z74ZBE0F9P7MRfC68l4uvulWQzJehXBe5kM/c2uBTCYy7qUcTy7j7e
         2A60TBlBSRHpxrZ0/3Vr6SYj6zzGK3PIYLOOnUdiCptKsb5zY/h5+WPERCjrS0q55Qlf
         l+JiUv92HikhinIhM7H2wXi/4CacYE07ioLzv19+dZAkTyNUAb+i5nb9Bt5d/gCvV5IY
         YGYQ==
X-Gm-Message-State: APjAAAU2IhqDS9CktHJMZj34PH6ItfSQDEfhGx89z9AXLeVdt/jLZZ1k
        BUc0078aOI9QbHcHsNuk0ZQu8Pqv1RFTC09gClvd3gJksBk=
X-Google-Smtp-Source: APXvYqyS5uYCDKG5NkBrFx5UcgbU0/9AMS+GUJnlw1HXT4HcoEcK/caXbOiIa7QbHf9GL78fRFVL6AOKmZy40PzN6BM=
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr305647wmg.8.1568133176544;
 Tue, 10 Sep 2019 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQueeFf=4m0Y2t3Qxzh_qT=PKwY5CPe4MmBb1wx3xyDfg@mail.gmail.com>
 <OSBPR01MB3367B6E4521888148EB778BFE5B60@OSBPR01MB3367.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB3367B6E4521888148EB778BFE5B60@OSBPR01MB3367.jpnprd01.prod.outlook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 10 Sep 2019 10:32:45 -0600
Message-ID: <CAJCQCtQZBdXcLdgF9yShz=7iT9E2krC=U8MrcPYkW7g=CeB2Hg@mail.gmail.com>
Subject: Re: user_subvol_rm_allowed vs rmdir_subvol
To:     "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Super. Thanks for the reply!

On Tue, Sep 10, 2019 at 3:29 AM misono.tomohiro@fujitsu.com
<misono.tomohiro@fujitsu.com> wrote:
>
> Hello,
>
> (It seems that you already have answers but anyway...)
>
> > Came across this podman issue yesterday
> > https://github.com/containers/libpod/issues/3963
> >
> >
> > Question 1: For unprivileged use case, is it intentional that the user creates a subvolume/snapshot using 'btrfs sub
> > create' and that the user delete it with 'rm -rf' ?
>
> Yes. The problem with "btrfs sub delete" is that the permission check is only performed to the top directory(subvolume).
> Terefore unless user_subvol_rm_allowed mount option is used, "bttrfs sub delete" command is restricted for unprivileged user.
>
> >
> > And is the consequence of this performance? Because I see rm -rf must individually remove all files and dirs from the
> > subvolume first, before rmdir() is called to remove the subvolume. Where as 'btrfs sub del' calls BTRFS_IOC_SNAP_DESTROY
> > ioctl which is pretty much immediate, with cleanup happening in the background.
>
> Yes.
>
> >
> >
> > Question 2:
> >
> > As it relates to the podman issue, what do Btrfs developers recommend?
> > If kernel > 4.18, and if unprivileged, then use 'rm -rf' to delete subvolumes? Otherwise use 'btrfs sub del' with root
> > privilege?
>
> - "btrfs sub delete" if mounted with subvol_rm_allowed
> - "rm -r" if not mounted with subvol_rm_allowed
>
> > Question 3:
> > man 5 btrfs has a confusing note for user_subvol_rm_allowed mount option:
> >
> >                Note
> >                historically, any user could create a snapshot even if he was not owner of the source subvolume, the
> > subvolume deletion has been restricted
> >                for that reason. The subvolume creation has been restricted but this mount option is still required.
> > This is a usability issue.
> >
> > 2nd sentence "subvolume creation has been restricted"  I can't parse that. Is it an error, or can it be worded differently?
>
> You cannot create a snapshot of a subvolume which is owned by other user now (apparently old btrfs allowed this).
>
> In summary, subvolume deletion by unprivileged user is restricted by default because:
>  1. a user could create a snapshot which was not owned by the user in old btrfs.
>  2. BTRFS_IOC_SNAP_DESTROY ioctl only performs permission check to the top directory.
>
> I think 1 is not a problem anymore, byt 2 still remains.
>
> Thanks.



-- 
Chris Murphy
