Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C57228B19
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 23:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgGUVZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgGUVZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 17:25:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC07C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 14:25:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so22545428wrw.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N699xl/0B5Qyzywuh9B970fIP7VAB+EupmjIliCssXU=;
        b=I/A3OPmbR+en3iEvV10u6e+gt2vQnLRsleiRuWZaNqPHlZuHUNlN+L9/AB8qHeEvGz
         3M4GSyMGAWRYZtQ4yW2G85OmyQEChK+B/GQzIUrOqL3vz+vJOBIYa9zY4BBiX2u5Ahdm
         wtXOLgG0fMTP0+GIR+a5yL+LK9mG0Hb/nCKbYFam5G/UWPdJtqbqfIAgQDM3lel83cAd
         8CNQb6DtNBzHOIMx2k1RXYQf8y+1fGCA//zBu+j1QQW08VvxAcUJP2bofIDJhLxyy/7J
         s42rbiEV4FJvZ03qOYfkTNirRFBs0cKdJvMsR5CTRYDuxJe9p+lYxpaOYT8oE1rsFWOg
         p0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N699xl/0B5Qyzywuh9B970fIP7VAB+EupmjIliCssXU=;
        b=PlfrtxktioC85A8GLP9YCUR3US0UJQokxNh2wyoTpdCREykIcN46Tpyb7D58hXNMsO
         I23ix6EO2k/cKtXH8FsPEqxqsIM1fv5TypM9zTAna8qmdxGR7F8GWb1smx0hYJFhvR3H
         sBnCcL491j7ONwvDarGW++S8mA1GlenX/88fs/OBvlrmgHfhGTl8Kq3EOi4n5h7p3B3O
         L2IWkN46LvlQ3074T+QdHKQXGGqwGqj3fN3DnuUf8kZSwgbHPa4kVOhlitvBHoAhY+s6
         9iKN9LrPkvtISustkP+PdzSfWKZ1k03dPbRUnjihxLFX1wVPeTKL2B6cPU1mFCugIIwL
         h+ZQ==
X-Gm-Message-State: AOAM533feZL4SxhVDZikuFlek8Omv8tT895NR81RHljc9MxKHkrst7qv
        AaZlNvvXraHHhmr3qBAACrwBnK1eiHDBFhSo7OXWh4l6
X-Google-Smtp-Source: ABdhPJyjxZoTUjIZDR1eeQQhEgOFwL+iM0OBh48hZWhluyWdO8vys4Pvh8UTr4nGlVlSu65j+HA2bUvqbDqvErUbEgE=
X-Received: by 2002:adf:a19e:: with SMTP id u30mr14473177wru.274.1595366742746;
 Tue, 21 Jul 2020 14:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200721151057.9325-1-josef@toxicpanda.com> <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
 <20200721171626.GP3703@twin.jikos.cz> <870ffc4d-00c2-53bb-578b-6dffc85f86b0@cobb.uk.net>
In-Reply-To: <870ffc4d-00c2-53bb-578b-6dffc85f86b0@cobb.uk.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Jul 2020 15:25:26 -0600
Message-ID: <CAJCQCtRyxTOhWTCvwMmEtz8VjuzF+xszFiUJTkpdx1Lqtn6m2Q@mail.gmail.com>
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 11:35 AM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 21/07/2020 18:16, David Sterba wrote:
> > On Tue, Jul 21, 2020 at 04:56:55PM +0100, Graham Cobb wrote:
> >> If it means "only filesystem" that doesn't make sense to me - the whole
> >> thing is the filesystem. I guess "only data" might be more meaningful
> >> but if the aim is to turn on as much recovery as possible to help the
> >> user to save their data then why not just say so?
> >>
> >> Something like "rescue=max", "rescue=recoverymode", "rescue=dataonly",
> >> "rescue=ignoreallerrors" or "rescue=emergency" might be more meaningful.
> >
> > From user perspective the option should have a high level semantics,
> > like you suggest above. We should add individual options to try to work
> > around specific damage if not just for testing purposes, having more
> > flexibility is a good thing.
>
> I would also prefer not to have checksum checking disabled by this "try
> harder" option. I would imagine turning on "ignore whatever checks you
> can to get me my data back mode", retrieving all the readable data with
> valid checksums and getting errors for things which cannot be verified.
> Then I would make a decision as to whether to enable another option to
> even provide files which the filesystem cannot guarantee have not been
> corrupted because it can't check checksums. Even if that is all the
> files (because the checksum tree is destroyed) I should have to make an
> explicit acknowledgement that I want that.

It would be nice if this rescue=all mount option, continues to spit
out noisy and scary warnings about the problems encountered. Including
corrupt files with path to the corrupt file. Just avoid face planting.
I assume rescue=all implies ro (possibly also nologreplay).


-- 
Chris Murphy
