Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B631620B955
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgFZTc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 15:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZTc5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 15:32:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36388C03E979
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 12:32:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so9820145qkb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NNEJG/O1HQshyZfsr0+70oajTodBv6zbNHEry2Ddbpc=;
        b=Lwe3JZDAqem1EM8iQjnlTY5ESem0se1AqD0LQl66NKrL3PodA7g9iIxKwq3yQvsVF+
         U/PhpKkFgCEGbeJT7s3tQlfrZjtTY1dHVisRHrJwmvJ/HL5rZ06E7k2O5VO4u/T/b+Bo
         SXcVu9T9wc0oJEindGsE3Diztn66emo06aPrd0jCD6s9QlExllLa4G2QQdHz/oJUSYb3
         3XlE1proWwLR8/ysoyLLS8QNu5Bh4vvNZVoRmyZDhHWrl4sAZKAsE6NVsg3AwbVnM+Ox
         E9a6WmviNVWULM4w13dLB5JaxVZ1OdsHqhk7OK02IGlSEhKLDvsYzfPENu2UrSnVDjFH
         /MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NNEJG/O1HQshyZfsr0+70oajTodBv6zbNHEry2Ddbpc=;
        b=itijb6G+DcXemdLfSzNmE+eXQUo/Uz+f/imL2AZ3rrJf89x6oQ5t1KqJxS1wjMcTIQ
         UwD5y9GKPoIcrSeegyuiHC2+xkbbvXm2mUzOqGpy4ACj7JB8jjNqhikG04sHO2L9kF/Y
         VS6j5LnlkM5EtscV8qunO57izO09w4dgI3wDG0NwPglwdUplvoJ50S54+xk2dzwft4jr
         8/U9q5FUT4BZaSoswCM+o60pL8YOE4f3b7RL23Jk/vLBtqiyHQ7JoXwqiL2AWf+0UR9u
         azv7+cuqICCMTBd6DiPs8J37qEbHybOll94hRwsoLcvKFkZOrr3Gxl0RvPuIczShfYUr
         pzkg==
X-Gm-Message-State: AOAM530H1IwrLASGl5EGJTfVeutuIv9FTBH2yoFQkf/oAmIgvZClEFQB
        4xCSW/JLhSB5vWnYZ8bYeKj10elXsdOkU6tuPQEGjQ==
X-Google-Smtp-Source: ABdhPJzsKI9MuWz4treRM4E1krjpXHwNX+akbSdSfaK3IqqZiEvJkkRIdmqa9Ce+TFvcg11jXoUFPTGWaCV4hpfCdDQ=
X-Received: by 2002:a37:93c3:: with SMTP id v186mr4352339qkd.288.1593199976321;
 Fri, 26 Jun 2020 12:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de> <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de> <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com> <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com> <CAJCQCtQQJkwB-Yt+ogQUXSZLVxNzTWw0voorALSwfKLXBz7pHQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQQJkwB-Yt+ogQUXSZLVxNzTWw0voorALSwfKLXBz7pHQ@mail.gmail.com>
From:   Tim Cuthbertson <ratcheer@gmail.com>
Date:   Fri, 26 Jun 2020 14:32:45 -0500
Message-ID: <CAAKzf7ka0nUt221nU4DunxfHSK+OXe7fZ=ECt=p_C+zLi4RrRg@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oh, no. No fstrims were run during the short length of time that I was
trying discard=3Dasync. I run my fstrims, manually.

Tim

On Fri, Jun 26, 2020 at 11:41 AM Chris Murphy <lists@colorremedies.com> wro=
te:
>
> On Fri, Jun 26, 2020 at 9:40 AM Chris Mason <clm@fb.com> wrote:
> >
> > On 26 Jun 2020, at 8:08, Tim Cuthbertson wrote:
> >
> > > ---------- Forwarded message ---------
> > > From: Chris Mason <clm@fb.com>
> > > Date: Mon, Jun 22, 2020 at 10:57 AM
> > > Subject: Re: weekly fstrim (still) necessary?
> > > To: David Sterba <dsterba@suse.cz>
> > > Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
> > >
> > >
> > > On 22 Jun 2020, at 10:23, David Sterba wrote:
> > >
> > >> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
> > >>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
> > >>>
> > >>>>>> You need to check fstrim.timer, which in turn triggers
> > >>>>>> fstrim.service.
> > >>>>>
> > >>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
> > >>>>>
> > >>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
> > >>>
> > >>>> I'm familiar with the contents of the files. Do you have a
> > >>>> question?
> > >>>
> > >>>
> > >>> You have deleted my question, it have asked:
> > >>>
> > >>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
> > >>> unnecessary?
> > >>
> > >> You need only one service, either from the fstrim or from
> > >> btrfsmaintenance.
> > >
> > > Dennis=E2=80=99s async discard features are working much better here =
than
> > > either periodic trims or the traditional mount -o discard.  I=E2=80=
=99d
> > > suggest moving to mount -o discard=3Dasync instead.
> > >
> > > -chris
> > >
> > > Apparently, discard=3Dasync is still unsafe on Samsung SSDs, at least
> > > older models. I enabled it on my 850 Pro, and within two days I was
> > > getting uncorrectable errors (for csums). Scrub showed 12,936
> > > uncorrectable errors.
> > >
> > > While I was trying to recover, a long SMART analysis showed the actua=
l
> > > drive to have no errors.
> > >
> > > Then, the first recovery attempt failed. I had deleted and recreated
> > > the partition. When I was copying the backup snapshots back to the
> > > SSD, uncorrectable errors showed up, again (4,119 of them after
> > > copying one snapshot). I then overwrote the partition with all zeros,
> > > and when I copied the snapshots back to it, there were no errors.
> > > After recovering my filesystem, scrub still showed no errors. So, all=
s
> > > well that ends well, I guess.
> >
> > We=E2=80=99re using this on a pretty wide variety of hardware, so I=E2=
=80=99m
> > surprised to hear this.  Are you able to reproduce the problem?  Is a
> > periodic fstrim still happening?
> >
>
> I'm curious if there's a possibility of confusion/conflict between
> scheduled fstrim combined with either discard or discard=3Dasync.
>
> As in, if it's a big enough concern, maybe the scheduled fstrim needs
> to get smarter and parse mount options, and automatically deconflict.
>
> --
> Chris Murphy
