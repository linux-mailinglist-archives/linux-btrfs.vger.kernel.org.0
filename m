Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29794402B88
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIGPRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 11:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345005AbhIGPRM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Sep 2021 11:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6977C60EB7
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027766;
        bh=aUdSV6sqE6cOYm43ZQ9rjw2m3r+nZLe6Iv8b3jL3zng=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=mQrghjJBDSyYRp3cLMs8QwWqGsqfAh77OSWTtHMXYknCjVeqsF9l4lHiyUxjguKj7
         E6nij/wjOfnvevifXupgal8rSViFg1cy0LuY1UF+55URpdPdAQXWgg4qbwNMO9ASmF
         BwYIAoUWulPJ5+U+ZOVwPJ4DGPsDpYE/zCVn4GU1rr4Q37GhWEMtcH80wYMfJU6FGp
         iRzgaZLMBIpUjM/jZWuaWXyF+oezoa8MEoSDMYbkgaS4j25V5EOdD6ObtbpWGA97/l
         MspasutjxInYjowXYwHK3YMCV6BV7axUuYmPG3DsTR4qFWSzKNXRXt5s8SIECARRKB
         gURpFSMYeDOwA==
Received: by mail-qt1-f179.google.com with SMTP id 2so8223753qtw.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 08:16:06 -0700 (PDT)
X-Gm-Message-State: AOAM531tLVh0NbdORKIjs5A5n2Mb6BqPMmOXgrWXWIdMMh137Kk7zGPo
        Cuu3HMVYxvsTSJPLRarws0S/qBBzJasqpLCaUO8=
X-Google-Smtp-Source: ABdhPJxSYnJUBBBxrryq34LiW2syGYaEM1TYMbiC4IN0pVT3pqoDAUU42LwtdgCi3VZ+DN6aWJ0nbbNmBl9/OBZ/GU0=
X-Received: by 2002:ac8:7354:: with SMTP id q20mr15975678qtp.329.1631027765641;
 Tue, 07 Sep 2021 08:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <f9dfa4183e5c84f71c3f50d504e3d6cdc43b0ae9.1630919202.git.fdmanana@suse.com>
 <20210907112653.GK3379@twin.jikos.cz>
In-Reply-To: <20210907112653.GK3379@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 Sep 2021 16:15:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4A=R1giRgNMEvgjnqsyrZiSOk2+6=y2cTVogLcpn-2VA@mail.gmail.com>
Message-ID: <CAL3q7H4A=R1giRgNMEvgjnqsyrZiSOk2+6=y2cTVogLcpn-2VA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix mount failure due to past and transient device
 flush error
To:     David Sterba <dsterba@suse.cz>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 7, 2021 at 12:27 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Sep 06, 2021 at 10:09:53AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When we get an error flushing one device, during a super block commit, we
> > record the error in the device structure, in the field 'last_flush_error'.
> > This is used to later check if we should error out the super block commit,
> > depending on whether the number of flush errors is greater than or equals
> > to the maximum tolerated device failures for a raid profile.
> >
> > However if we get a transient device flush error, unmount the filesystem
> > and later try to mount it, we can fail the mount because we treat that
> > past error as critical and consider the device is missing. Even if it's
> > very likely that the error will happen again, as it's probably due to a
> > hardware related problem, there may be cases where the error might not
> > happen again. One example is during testing, and a test case like the
> > new generic/648 from fstests always triggers this. The test cases
> > generic/019 and generic/475 also trigger this scenario, but very
> > sporadically.
> >
> > When this happens we get an error like this:
> >
> >   $ mount /dev/sdc /mnt
> >   mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
> >
> >   $ dmesg
> >   (...)
> >   [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
> >   [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
> >   [12918.890853] BTRFS error (device sdc): open_ctree failed
> >
> > So fix this by making sure btrfs_check_rw_degradable() does not consider
> > flush errors from past mounts when it is being called at open_ctree() for
> > the purpose of checking if devices are missing, and clears the record of
> > such past errors from the devices. Any path during the mount that can
> > trigger a super block commit (replaying log trees, conversion from free
> > space cache v1 to v2) must do the usual checks for device flush errors,
> > just like before.
>
> Why did you choose to set the global bit instead of passing a parameter.
> AFAICS it's only checked inside btrfs_check_rw_degradable so no deep
> call stacks where passing that would be cumbersome.
>
> I've also noticed that all callers of btrfs_check_rw_degradable pass
> NULL to failing_dev, so that could be cleaned up before adding another
> parameter.

Yes, I didn't notice it before, my head was on multitasking with other problems.
I'll send a v2.
