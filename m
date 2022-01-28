Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1049FFE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348778AbiA1SBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbiA1SBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:01:47 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB3C061714
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 10:01:47 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 9so8766965iou.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0EWJuG5tv18VvKYaHX0TnNgrAkW3Xrx1UtZ6SJ2Vxg=;
        b=pLpy/C2JtPBG6MevAT+p1hpiRo/u3h59gjXGDKMGgbwc+b2c9ijL2p9/F9Cj1fjuCk
         trEmlsRm1DcgpErK/jws8dcVqa+j+gCPcvz21eiYybacdeOwYh7KF7gooZKMV6uEBkaE
         gL6tt0kRB/sCeMw0JZxjyBhNBHG9Pztbi/hMGKS/XcM13Z7b/sTIeMlEc3FdgYLSVz/a
         Nqev+gIPfEiRNk9HpdZjYX2qqA9fhY7GeHz68KyVqYntAGQ5GcAOIap0IY8HNLkBRmnf
         RJKZLGCmQTM6NmMBc/DKuQf/GzXT/CuSkiYnXGUFEbD0E+QEcmyH9BrzMfX8KyvfIHAV
         YSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0EWJuG5tv18VvKYaHX0TnNgrAkW3Xrx1UtZ6SJ2Vxg=;
        b=iQZs49WI9Apu+IsaT0uXH0vqtvVsbhl/7HncbkVzLuPyMXzoaEy5WFnW1g/esW4nTn
         fJgBybhOd+jD4h+bD5VZaiGnokNGS07N+tVguL+JLUKnqtwqsT16H4Jrosn+dOvv1uYX
         rof9YNaNfeJnUbDWXzIoZvvRMlo8caj6tW4YHr3j+i4nvw9Qb22IvvzIgIVxArQOurZq
         do8TfaY9QWRCuENUXEIqhRirgAWjPQvEGyTvS8LkgyGiJtANpAMvmDrjiGy3bnYWV8m/
         Gl/O3znWQR0BnIoY3an/4q2uqEJQEbdArkLl2R8v2W40HevVoFwJdRe+GHg0682qEqhF
         b9Bg==
X-Gm-Message-State: AOAM532bX4jNCPNSugxmHL40NjAVCyOFLwABX1lhkTIojizD73lqw/bW
        BPg433ZB5Bls6dAmQMgRuzoiHCxk4Xmb7u/fN+A=
X-Google-Smtp-Source: ABdhPJyowFQwCwoMMS47DyblKZnRp/ehKS59Ozcf4e3V9Slie9JKSy+6+aLxQGBA0EJFzysYsYiV/lMjhXXeONz7wvo=
X-Received: by 2002:a5d:9248:: with SMTP id e8mr5753670iol.4.1643392906855;
 Fri, 28 Jan 2022 10:01:46 -0800 (PST)
MIME-Version: 1.0
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com> <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
In-Reply-To: <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Fri, 28 Jan 2022 19:01:20 +0100
Message-ID: <CAMthOuOnYUn_szauqRbx2yy_U+2Zrs5WUWmwKHLC5k3x13qKpA@mail.gmail.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Remi Gauvin <remi@georgianit.com>
Cc:     piorunz <piorunz@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 28. Jan. 2022 um 17:05 Uhr schrieb Remi Gauvin <remi@georgianit.com>:
>
> On 2022-01-28 6:55 a.m., Kai Krakow wrote:
>
> >
> > Database and VM workloads are not well suited for btrfs-cow. I'd
> > consider using `chattr +C` on the directories storing such data, then
> > backup the contents, purge the directory empty, and restore the
> > contents, thus properly recreating the files in nocow mode. This
> > allows the databases and VMs to write data in-place. You're losing
> > transactional guarantees and checksums but at least for databases,
> > this is probably better left to the database itself anyways.
>
> This might be critically bad idea combined with BTRFS RAID,, BTRFS does
> not have any means to keeping the Raid mirrors consistent *other* than COW

Yeah, it's not better than traditional RAID but it's probably also not
worse. The question is: Is it worth the massively negative performance
effects on database and VM workloads? At least in this case: probably
not because it's on HDD. You're buying a consistency feature for a
real high price, doing an online replication to a standby DB instance
may be a better choice.

However, there are cow-friendly file formats: qcow2 for VM images
seems to work fine for me (I just disable compression because it
creates those vast amounts of extents, and rather let qcow2 do the
compression - which is read-only but well), raw format, although
simpler, was really hammering on btrfs even with nocow. For databases,
at least WAL mode of sqlite seems to work fine without too many
downsides. Not sure if other databases offer something similar.
