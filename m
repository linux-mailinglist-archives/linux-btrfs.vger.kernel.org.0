Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244E311A660
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKI7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 03:59:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38489 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKI7G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 03:59:06 -0500
Received: by mail-vs1-f68.google.com with SMTP id y195so15214628vsy.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 00:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TXIQg/wgeewh3eYV1E4488hNuDaERIgAJMHSp24r5sw=;
        b=sP+EZpXdch48UTTyZgIMmkylVrdHskntb3U+OgfXLCoqdjFKGGwAEKzgIgA08whkHz
         Nexheaec5H9Lw6pD6ojQOPFRR4u/sMR3K5wn10tt6De/kZ4WNQ3Yt/zGoFadUhz/aNLK
         38AWpAcD3mSQFVGCa2FZ0QHG0Rzlnnm6tBTkvMGe/eZfpyxNbTM/nPZwRDQQLzyUEppf
         KVKu52v0BE9gkOgsUZvoRh+TlXbZc5dLXtblwlxiWLBM3V9bK18+cksUfB4w3uTARLSb
         USCECXrVl/xZsYDhr4ezL+LBpz/KoWJO34VBdpkZ8PYKqFnKS/CpZHmiDCIG38MXycrM
         cVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TXIQg/wgeewh3eYV1E4488hNuDaERIgAJMHSp24r5sw=;
        b=LKoZdJw1f6FYWW8voRNxvUdONEtUT/EHaC7fEgdMWmD9SxZswLLhMQ5ZWcTv2/n/Hx
         aYyYbi+yRlKYa6IO3mqJTnjH8zjnbAV138E1mR/WUbMak0NfMC+5SEAUvCbXLpw9e4mz
         RACgtJ/hVRQabjCl3xu+5a5IEbzdm+vsLRUSy7qZ7j9s2Q+qxlABtHygTwl6I8KtiY+e
         LcHRJ18HxjzFwjliiePAKVcnti3bkEGoagojARWlhZfWD8eKjYfNtJE4q7qHulJpWFCe
         3GEnj5n+KflgNAgnvVEaThnFYkoT1DV1VjJB5tyxqlSAhLhgK9Qb5+sOr65SJLcwlKW7
         OOEg==
X-Gm-Message-State: APjAAAW8h2P9oNAWnF4F9j468/kELhLCBUHsDtb70ET2tkDiBnQplGPC
        2Yq5a0k1MuPLTNgn4syyZP5M1lfsqbzEFzdsgUw=
X-Google-Smtp-Source: APXvYqwgBcpGEDuvPklYMNxzHQET6hxvUAJO808T8x1V1JioGObc4eyGDFIi6GCkj/qj9dzZZEf6KduRCrNkbJ7TuQQ=
X-Received: by 2002:a67:af11:: with SMTP id v17mr1312125vsl.99.1576054745010;
 Wed, 11 Dec 2019 00:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20190628022611.2844-1-anand.jain@oracle.com> <20190703132158.GV20977@twin.jikos.cz>
 <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com> <51c42306-b4ae-a243-ac96-fb3acb1a317c@oracle.com>
 <20190902162230.GY2752@twin.jikos.cz> <20190903120603.GB2752@twin.jikos.cz>
 <20190912175402.GM2850@twin.jikos.cz> <CAL3q7H7nbp_kmeEZpRL7KpwhXSA6=QCcwzXT-f0szrwRmW-ohw@mail.gmail.com>
 <3a3acd6a-ed5b-bc35-58aa-f76f7704a240@gmx.com>
In-Reply-To: <3a3acd6a-ed5b-bc35-58aa-f76f7704a240@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Dec 2019 08:58:53 +0000
Message-ID: <CAL3q7H7CPNx9uhQxwRqC3FTNVD2HtsPN21y26RN0ZjF+MPqaTA@mail.gmail.com>
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 1:45 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/10 =E4=B8=8B=E5=8D=8811:42, Filipe Manana wrote:
> > On Thu, Sep 12, 2019 at 10:39 PM David Sterba <dsterba@suse.cz> wrote:
> >>
> >> On Tue, Sep 03, 2019 at 02:06:03PM +0200, David Sterba wrote:
> >>> On Mon, Sep 02, 2019 at 06:22:30PM +0200, David Sterba wrote:
> >>>> On Mon, Sep 02, 2019 at 04:01:56PM +0800, Anand Jain wrote:
> >>>>>
> >>>>> David,
> >>>>>
> >>>>>   I don't see this patch is integrated. Can you please integrated t=
his
> >>>>> patch thanks.
> >>>>
> >>>> I don't know why but the patch got lost somewhere, adding to devel
> >>>> again.
> >>>
> >>> Not lost, but dropped, misc-tests/021 fails. So dropped again, please
> >>> fix it and test before posting again. Thanks.
> >>
> >> With the test misc/021 updated, this patch has been added to devel.
> >> Thanks.
> >
> > So having updated my local btrfs-progs from v5.2.2 to 5.4, I started
> > getting 4 test cases from fstests failing:
>
> Was running with btrfs-progs v5.3.1 before, so not hit the bug...
> (And some notrun due to missing make_fail_request config)
>
> >
> > Am I the only one getting this? It's been a while and I can't have
> > been the only one running fstests with progs 5.3+.
> > Is there any fix around for btrfs-progs I missed in mailing list (with
> > devel branch the tests fail as well), or a plan to update the tests?
>
> I'll look into the test case to fix them, since most of them are just
> bad golden output, not a big deal to handle.
>
> Thanks for the report,

Thanks for looking into it.

> Qu
>
> >
> > thanks
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
