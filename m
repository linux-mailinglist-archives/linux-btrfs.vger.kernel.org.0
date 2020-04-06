Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30D19F3D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDFKvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 06:51:20 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38545 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFKvU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 06:51:20 -0400
Received: by mail-vk1-f194.google.com with SMTP id n128so3836469vke.5
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=p+WQF0Sc0cs/0vlIjQLudmPD+sYaaBr7oTqIFHNiF+w=;
        b=uIpufd1g1/VrQL8Ubo27eRUzVP9h60Y8tpYu96NqwyWNdcrzuaYtCGjawZ6vi5nqI1
         jR4e9sF/zTuip/xcSHq80K52FgmbI5f6Oe/r1P8atcIp0OswCDrb5y+jUc1K3krNfRWy
         OJ4DG91TYNq9IhUWo4CyQfRQMGqCf7VHAw1rCOpEOf0cCzWEnJBNrqf9yoV5XGbph1HW
         JIRI8gdpAtordbXDpj/wGTugiD4J8DfJOd3x+uzKzL9HK+xIlzT7Rfw3tBzatlqX8vkn
         XyqZ+NRTd1pqIp7PB1F14xO6sWARpWrXsD0ukjtBC51L2ScNdDbxz7GPHKzBZ3s5Aa36
         Qdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=p+WQF0Sc0cs/0vlIjQLudmPD+sYaaBr7oTqIFHNiF+w=;
        b=q8Q4CU8HOvtztHIp4WrTGK+DIC4WdWLFoUN2fl3m6qXOXeNKcYkInzvy5H+k6FDHLY
         ewIi1OzVpzmwfM1xo9R2ioboQFQkVYp3qvMb5ZHeRkbYYXEyVJo1GALMFa97O+n00OVi
         lfRKyZhH9swpIlgXBcTzlIh/NShfi7N8JT0nl8fXD+Din761MD2IAzVlbhrkXVsne2rS
         5A/piCRqwwZsFVNtCEamPMKmMMfeMFc5aFm5X5339X6pPh4/biQRElRQHSxvUkM+EiJc
         WRB35nM3YKFRoqPO/qW58lSzfdCM1OhnX2abOBMWx/sysc587LGA/bL0dsT5Ux+6dH2/
         ZvHg==
X-Gm-Message-State: AGi0PuboJyiyu19fHuSnPioLOC3EzlJL0Uwkp6satWsP32bPODYyoTEJ
        qiMk/IUtXzmLUilRyVcheZqYNryMb9pbonKT5uAdjA==
X-Google-Smtp-Source: APiQypJhFfz17uzqoLp7GbciLn37aQ5OcRfifx4m2S1DgVlngG3HUYyNMH85sJsIHWX2Jcu7kIieR1Qyn/PaO01PQ1o=
X-Received: by 2002:ac5:ccb9:: with SMTP id p25mr14359871vkm.69.1586170279171;
 Mon, 06 Apr 2020 03:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200404193846.GA432065@latitude> <CAL3q7H4xya8EuBhGsX4gs8V6xdNWpJhjhJj0-KdUJhMnDjHjXQ@mail.gmail.com>
 <20200405145121.GA952734@latitude>
In-Reply-To: <20200405145121.GA952734@latitude>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 6 Apr 2020 11:51:08 +0100
Message-ID: <CAL3q7H6zYuCw8e7Ufn7iiAhys85rHQhFBr2EeK62jyhF1yShMA@mail.gmail.com>
Subject: Re: unexpected truncated files
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 5, 2020 at 3:51 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> On 2020 Apr 04, Filipe Manana wrote:
> > On Sat, Apr 4, 2020 at 8:52 PM Johannes Hirte
> > <johannes.hirte@datenkhaos.de> wrote:
> > >
> > > While testing with the current 5.7 development kernel, I've encounter=
ed
> > > some strange behaviour. I'm using Gentoo linux, and during updating t=
he
> > > system I got some unexpected errors. It looked like some files were
> > > missing. Some investigations showed me, that files from shortly
> > > installed packages were truncated to zero. So for example the config
> > > files for apache webserver were affected. I've reinstalled apache,
> > > verified that the config was ok and continued the system update with =
the
> > > next package. After this, the apache config files were truncated agai=
n.
> > > I've found several files from different packages that were affed too,
> > > but only text files (configs, cmake-files, headers). Files which were
> > > writen, are truncated by some other write operation to the filesystem=
.
> > >
> > > I'm not sure, if this is really caused by btrfs, but it's the most
> > > obvious candidate. After switching back to 5.6-kernel, the truncation
> > > stopped und I was able to (re-)install the packages without any troub=
le.
> > >
> > > Has anyone ideas what could cause this behaviour?
> >
> > It's likely due to file cloning.
> >
> > I found this out yesterday but hadn't sent a patch yet, was waiting
> > for monday morning.
> > I've just sent the patch to the list:
> > https://patchwork.kernel.org/patch/11474453/
> >
> > Since you are only getting this with small files, it's likely the
> > cloning of inline extents causing it, due to some changes in 5.7 that
> > changed the file size update logic.
> >
> > Can you try it?
> >
> > Thanks.
>
> Yes, this was it. Installing the second package for triggering the
> truncation was a coincidence. Installing the first package (appache
> here) and rebooting triggered the error reliable. With portage (the packa=
ge
> manager from Gentoo) everything is compiled and installed to a a
> location on /tmp. After this, the content is copied to the target
> location and seems to be done with cloning. With your patch the problem
> doesn't occur anymore.

Thanks for testing it.
I'll add reported-by and test-by tags to the patch.

>
> --
> Regards,
>   Johannes Hirte
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
