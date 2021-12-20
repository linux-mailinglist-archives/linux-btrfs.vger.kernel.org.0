Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D278147AB09
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhLTOJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhLTOJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 09:09:26 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE1C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Dec 2021 06:09:26 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f186so29136438ybg.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Dec 2021 06:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqWtSMr+NNCtF0m8AHok+8p1CiTnGPD0Urt2/qLoZhg=;
        b=bBYWkQ45zB88Jk2o1OmZaCMNFj1T9kcZahLFCD1JkrZbWJ9hqiGgNhgZNZysa6QlOM
         7zfCG0DNyxTO+TwqhrjJQ1ODCZd5eMpzftLvfZ6c7O2vmS5+9pbWmyFpHFG/eTE3rMUN
         8PITWZ+Efd8/e3O0hyFmuC3KDMfHjd1AVLwPbWtZHzJ991fUL0AeIU2bLPqGW97kUFbE
         2iWhtmAZ3efA/9rnf24136iltdL2MOstoLd1DKl0UY1kh2UHJDNBheMs0tT6DIKzRft6
         6WfFehRidY/se8U+M6jQGvrY9OLw8UhJY7l5D60zApkxFmGsQo44V19LOXrj+Yj2kl+g
         LG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqWtSMr+NNCtF0m8AHok+8p1CiTnGPD0Urt2/qLoZhg=;
        b=B5HrWm8y56Vc29G6XBol6czd87guyH1w0kId6SSbU0VSezlWG3m/lBow0syA3aINoV
         piwqXn0zQPKYp0aKgn7tYcauhqs+yLmHxnyY2d+tVcpap4ZVPVwrtMFiQMcl2YgxjPcs
         FL8UhksCmRlN+5JcLoI8kqZd3X+gSsTf8uZxCcfa4z8ZtKrjQ4BFyZ0YPe7VYyBZ7PLz
         YmLBB0uO+Mu+zbEELa6U6eSomTbdDm1eazf9Z0NV2V+0sTmMh0YxDMgAkMObqzMylM/Q
         +z6aiqehJtZuxmfxUt1MdDJnc5xa8ANkitfx/h2FUstSSsEbvojxhnQpo+9S41yQwheq
         M+Jg==
X-Gm-Message-State: AOAM532oz1Xh/jTy9ge1iW/aS1jeETOrGQCKYZAcvZ9UjlhGmw3CSD9L
        gPcGJeqmCoKkO82eJpR340WC+YYrtV2Vn01nuZlP+d/o
X-Google-Smtp-Source: ABdhPJzaGKTk1SPJG3+lmITKDikwATFAOiZctYzDPNF6lDGtCsZHwvJvxK5xbCM4LsAhZayEovWFZdIu+uVzFqQCTRw=
X-Received: by 2002:a25:70d5:: with SMTP id l204mr23837720ybc.193.1640009365807;
 Mon, 20 Dec 2021 06:09:25 -0800 (PST)
MIME-Version: 1.0
References: <b4d71024788f64c0012b8bb601bdba6603445219.camel@stj.jus.br>
 <CAMnT83t1WXvX210_UEfNy7Q4dfKkgJn2j=AMNB9zbVAPU3MEfg@mail.gmail.com> <68123ebff72088e42ae1840210161ffee6622087.camel@stj.jus.br>
In-Reply-To: <68123ebff72088e42ae1840210161ffee6622087.camel@stj.jus.br>
From:   Vadim Akimov <lvd.mhm@gmail.com>
Date:   Mon, 20 Dec 2021 17:09:09 +0300
Message-ID: <CAMnT83tsE8axxesVzcAzGO=kgLEJwchviJBs+-WUkB7ADKz=yg@mail.gmail.com>
Subject: Re: Recommendation: laptop with SATA HDD, NVMe SSD; compression; fragmentation
To:     Jorge Peixoto de Morais Neto <jpeixoto@stj.jus.br>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

On Mon, 20 Dec 2021 at 16:45, Jorge Peixoto de Morais Neto
<jpeixoto@stj.jus.br> wrote:

> Is that experience from before Bullseye?  I heard that the Bullseye
> installer has better Btrfs support.

This is my experience moving from ext4 to btrfs on several laptops,
desktops and servers. Probably your distro has the support right
enough for you, I don't know. If it doesn't, however, you can always
redo it the proper way afterwards.

> Does Btrfs unsuitability to QEMU VM images relate exclusively to
> synchronous write *performance*, or does it also harm SSD lifetime
> (assuming nodatacow and raw format)?  I intend to give my VM a second
> disk image.  One image will be on the SSD (holding system files) and the
> other on the SATA HDD (holding user files).  The NVMe SSD is probably
> fast enough that the VM will have overall good performance even with the
> synchronous write slowness you mentioned; but would it excessively wear
> the SSD?  Do I have to create an ext4 partition on the SSD just for the
> QEMU VM disk image?

Sorry, I haven't got any spare SSDs to perform my tests on them.

> I am aware Btrfs has official support for swap files (with some
> restrictions), but is it reliable, efficient and light on the SSD
> lifetime?  The Debian wiki recommends against swap file on Btrfs
> (although some parts of Debian wiki are visibly outdated).

AFAIK kernel uses file swap as a list of extents on the disk not
accessing FS for the IO. Therefore, btrfs is perfectly OK for file
swap, provided the file is 'nodatacow'.
