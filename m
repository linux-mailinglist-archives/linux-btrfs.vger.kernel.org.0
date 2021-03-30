Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB40534E8E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 15:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhC3NWZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhC3NWR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 09:22:17 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC593C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 06:22:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m132so17425204ybf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Eaw3SQXoVdrvXR5g/vBWIpbieA53gqriimZjfPm+D5w=;
        b=VV/moKqT3ZkzjQ1KIA1HrbTJoetNut05HoOIYYw5JoqHhZYjsp/7JRyJQxLyBBhqjE
         WfNyz1ofpM/sHWvWWSeNrcUQ5i1R529bXvrFXmFiuhA3Qph9SEVtND8z1trS/zkim4jI
         FNJ1uXPf9kTPWxodPE+oPjCB+26OXiJpXS1d7ODGozqcDDZcXR2gHmsC1opyuAN+dxWm
         v4u3ONHgiwugXvtSHvqI0PbALBEhEhIcGU9aMbHNWuPyydS/l1YDGl4DnQ7phrDdn83r
         ujcse5EOGF5ZJ0jN5GgIf0Hg9eDMVySLshqNmh/ymdhRonvrOk7kqkl47a/fHIhNdDIr
         R8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Eaw3SQXoVdrvXR5g/vBWIpbieA53gqriimZjfPm+D5w=;
        b=hZOgiPYKht/+b3XYrfLPjXarz+beAMzdpbb74I1/1v2PTkuo1HEEZL1KOCg1h9/CVo
         XjPlzvlRqfefeUAGqk45RjN/YqptmVlRQzDjUuiYYMpql4hb1IeVuWDaJntqgyQ3A6K3
         EoYTcA37vSIDZ9/6wGWD59mx1AP3OEI9PSS1ByJCaLZgxhOVQbh8WUCSZ2cg5HSXmp30
         ThA5xqPFOB+aPE22ZEYz8qcmTenVb8PW7Rf0sDyFmCVBzkvVNKuvQW/WMgDqJCldVp7k
         ++V3dvVk5AVJ5JdsSPE7uU1KMJqjn0gkqX1KWIMxyiEuy/J3lR8SHlFMYuGvyxFjKhSZ
         RuwQ==
X-Gm-Message-State: AOAM530Cr35MPm4ZaXmHrzfxkOjnnCXoUN9r2vXvWsoOHFEkUMGEDE+/
        x+WBW/LwQbfiKQWjyI87xOjPiHCZVA8eioVSTWA=
X-Google-Smtp-Source: ABdhPJyWnoiZhbTAuGcf1ub9PWJp84wqpOLCK13X9fC8LE2uGxiArjGzDqICXE6mI0iyWAe0AyFx5P7+rm125CNBRUw=
X-Received: by 2002:a25:d10b:: with SMTP id i11mr39530235ybg.0.1617110535926;
 Tue, 30 Mar 2021 06:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210317200144.1067314-1-ngompa@fedoraproject.org> <20210323155032.GH7604@twin.jikos.cz>
In-Reply-To: <20210323155032.GH7604@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 30 Mar 2021 09:21:40 -0400
Message-ID: <CAEg-Je9X-4NEa_TDcU-m_xM1J+0kf03gXT1F1vgp2CyEUU9K=w@mail.gmail.com>
Subject: Re: [PATCH 0/1] btrfs-progs: libbtrfsutil: Relicense to LGPLv2.1+
To:     dsterba@suse.cz, Neal Gompa <ngompa@fedoraproject.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Sheng Mao <shngmao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 23, 2021 at 11:53 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 17, 2021 at 04:01:43PM -0400, Neal Gompa wrote:
> > This is a patch requesting all substantial copyright owners to sign off
> > on changing the license of the libbtrfsutil code to LGPLv2.1+ in order
> > to resolve various concerns around the mixture of code in btrfs-progs
> > with libbtrfsutil.
> >
> > Each significant (i.e. non-trivial) commit author has been CC'd to
> > request their sign-off on this. Please reply to this to acknowledge
> > whether or not this is acceptable for your code.
>
> Thanks! I think we have acks for all non-trivial contirbutions. For the
> record, the trivial one are:
>
> * dbf60b488e3b ("libbtrfsutil: update btrfs_util_delete_subvolume docs")
>   a comment update, clarifying usage
>
> * 2e67bf0ed69d ("btrfs-progs: docs: fix typos in READMEs, INSTALL and * C=
HANGES")
> * b1d39a42a4ef ("btrfs-progs: fix typos in comments")
>   treewide comment typo fixes
>
> * 01e35d9f53eb ("btrfs-progs: treewide: Fix missing declarations")
>   code changes, but adding static or missing includes
>
> * 9fd37f951be6 ("btrfs-progs: complete the implementation RAID1C34 defini=
tions")
>   copied definitions from kernel code
>
> I'm not sure about the commit adding pkg-config spec file, it's not code
> but it's beyond what I'd consider trivial. I've added Sheng Mao to CC,
> please acknowledge the change.
>
> * 4498fe1a2a7c ("libbtrfsutil: add pkg-config spec file")
>
> I'll update the changelog with all the reasons for relicensing that have
> been brought up.

I consider that trivial because the only actual part in libbtrfsutil
is the pc file, which is a trivial templated data file (I had one that
I was preparing to send that looked exactly like it, but Sheng Mao
beat me to the punch). The autofoo is part of the parent btrfs-progs
project and is already correctly licensed anyway.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
