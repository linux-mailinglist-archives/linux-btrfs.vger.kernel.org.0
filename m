Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7525B399
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBST1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBST0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 14:19:26 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45DC061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 11:19:26 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t16so31978ilf.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vEQQX4uMCwDnc4vtNsriROjtdua6NHjnOXbxeJbFXyQ=;
        b=amI4qDvswUR8gUCM0Fdd3BRCPNq7eGMj85oSUJD4bHP04E3kAHQEu59oRiq49ws0MN
         2nqsF3MKTk58q5pPJ+Lphxg0/DZcfQ4J1O3oHmUeDUYuQ8HytJYgOZpeR72xl1IgQTrZ
         C8IFA1NBb3b9At2HQ0I1jxzKwB/FgXISqq65xxH9RDzZ/IzJ962QzSh7ikprNHUNmzlT
         FmrKr5dx+KnOSmiLxL21s+u3iqIWDqxd9XTo6W9EeEIZqrNEscWHPP++GLyR0XvXP67B
         +DqKXJTx8abSVdbiN1Zu+DA90E+ge6g/zqbZTp+PtZCpYtFa6CJxw1dri3BaLoySaI78
         am9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vEQQX4uMCwDnc4vtNsriROjtdua6NHjnOXbxeJbFXyQ=;
        b=bvrOL1L+hpy9YVQXSvze0UTHs6mSUTgkdArFkzIwGXay3vxEQ7S6cOFJwEBMP5hG4W
         Z9fiN0XQmgX103mT3l39m1VjdLzQK+oWq7A0xIox0jkX7TApkZaMDNkOK2+9IW4lx9zn
         yAhimE90AFganQiO3ZiWK9299uxVro9dNqsDxtbCuKZKPwkINbjcJ3gEv5Iyf0TmHs+6
         6y3iznGkNTrPyEskIZXdtH6a/Ud2/9gFPC0iYBoLLCSRm5N1ZvnL0GsSVGnRaLsUf6PF
         Z90lUA8ZQZtyZZziu8zS/FPaee1XbWy4znbGCeYMjwquGhuLLuw2eLJuns2ftI6eqYQf
         Vc+Q==
X-Gm-Message-State: AOAM5327HjAIrNFf8yjXJ1dqxgS5sVFlBNAjYNai0kFN56LodI3U+5oP
        ggScgqX1Se7QDmc1FhPgLAZnT2nSU9+ulsGWmE5rRalSuc625k9F
X-Google-Smtp-Source: ABdhPJzNr40fJw4PrU7gnnnu9GVkrEYtTgQT4VL2Cd/kzdevHmUCXeglWkKyTTC4Njr50GWuB2iPHQ7QibkPeTvnDss=
X-Received: by 2002:a92:d482:: with SMTP id p2mr685469ilg.9.1599070766098;
 Wed, 02 Sep 2020 11:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
 <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
In-Reply-To: <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 2 Sep 2020 14:18:50 -0400
Message-ID: <CAEg-Je8YbAh+945EzjruJUfx08mfw99XGbZcGO+YZy=ggb0yEw@mail.gmail.com>
Subject: Re: About the state of Btrfs RAID 5/6
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 2, 2020 at 1:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 9/2/20 11:10 AM, Neal Gompa wrote:
> > Hey all,
> >
> > It keeps coming up over and over: "Btrfs RAID 5/6 is bad, therefore
> > Btrfs is bad". I know in practice that most people don't use the
> > raid56 modes for various reasons that are unrelated to this, but it's
> > frustrating and annoying that it keeps coming up.
> >
> > I know that Zygo recently posted about how to use RAID 5/6
> > successfully(-ish)[1], and previously David Sterba tried to work on
> > this[2]. The result of that was the new raid1cX modes, but we still
> > have the raid56 modes.
> >
> > What's holding back Btrfs raid56 from having its status[3] updated
> > from "Unstable" to "mostly OK" or even "OK"? I know that Synology NAS
> > devices use Btrfs and support raid56 using mdraid, why not fix the
> > native RAID features so that layer can be dropped?
> >
>
> Honestly there's just a lot of things that need to be looked at right now=
.  Poor
> Zygo is waiting on the delayed refs flushing work I did months ago becaus=
e I
> still haven't gotten back to fixing relocation.
>
> At the moment my core priority is getting all the normal parts of the fil=
e
> system working properly, and I've got probably 18 months of hell left bef=
ore I
> feel like I'll be able to look up and address the multi-disk aspect of bt=
rfs.
> RAID0/1/cX modes all work well and are well understood, and that feels "g=
ood
> enough" to me for right now.  I know Johannes is working on something mag=
ical,
> but IDK what it is or how far out it is.  Thanks,
>

That's fair. I just want to have a better idea of what's in the
pipeline here so I can figure out my messaging and roadmap in Fedora.

Downstream in Fedora, we have a tracking item for documenting that
raid56 should not be used at this time[1], and I just want to collect
information for the purpose of providing a more complete picture as
part of the documentation. Today, Anaconda will not expose the ability
to create raid56 btrfs anyway, so people using that configuration will
be relatively rare. But having a good story about it is something I'd
like to have, if possible.

[1]: https://pagure.io/fedora-btrfs/project/issue/13

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
