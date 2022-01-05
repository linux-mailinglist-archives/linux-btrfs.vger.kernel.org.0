Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FBD485A1A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 21:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbiAEUjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 15:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbiAEUjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 15:39:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760AEC061245
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 12:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED176192C
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 20:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769BDC36AE9
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641415154;
        bh=KhWH8qeCreGzFePdAWJqhwXQTtHutBcnYXm4oIfBVRE=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=gKgQpjtKJJlOiWtfvbA2C2JnDkKaOx62aeEnTm0YWNEIitsgO5b5Zz+1vcoZVWzrN
         AFGSgCy52Adwdltq+M6ie02EKgDWk4HMYPrFqsJ1e8HnCP4Yck7O4TjYOQ7V6chVbV
         e186k18lFBHK0bnI3QHdMOBIQK6TD/nBQGWkv4mojdNGJD51QJHvL4MmIC+XkB4cMq
         9KK6nS3A848RcWkwEfFBc+AdzbNfGhe5uSrHIIhGonGJzX4UKAaMoA+Jb6ptQzfOFo
         5Xxjf3xbbpmpJEl+s5zm7kTf5kmUS1mxDQbExFdY+SEdTHU8m8Cb3p94Z8vLTbka7w
         HmhmEb2tfnbpg==
Received: by mail-qt1-f174.google.com with SMTP id p19so188405qtw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 12:39:14 -0800 (PST)
X-Gm-Message-State: AOAM5315+xVhwIMq+ipcco3wW1ta/NwYidhgcBRncTiJdiMLUo5HDmUA
        rWAQunETuSiWlQTUYgy8wE06yQI2TduWpWtOuCM=
X-Google-Smtp-Source: ABdhPJxnjnQooCfyF6jZMXaSVIVphZuVzlY5+iGK1WEZhFbch4OwhgO5muBKr0LpwdOAiDHD2NLDH8anP60yo/EBOQI=
X-Received: by 2002:ac8:674d:: with SMTP id n13mr49167158qtp.491.1641415153530;
 Wed, 05 Jan 2022 12:39:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home> <20220105183407.GD14058@savella.carfax.org.uk>
In-Reply-To: <20220105183407.GD14058@savella.carfax.org.uk>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 5 Jan 2022 20:38:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
Message-ID: <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Hugo Mills <hugo@carfax.org.uk>,
        Filipe Manana <fdmanana@kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 5, 2022 at 6:34 PM Hugo Mills <hugo@carfax.org.uk> wrote:
>
>    Hi, Filipe,
>
> On Wed, Jan 05, 2022 at 06:04:38PM +0000, Filipe Manana wrote:
> > I don't think I have a wiki account enabled, but I'll see if I get that
> > updated soon.
>
>    If you can't (or don't want to), feel free to put the text you want
> to replace it with here, and I'll update the wiki for you...

Hi Hugo,

That would be great.
I don't have a concrete text, but as you are a native english speaker,
a version from you would sound better :)

Perhaps just mention that as of kernel 3.17 (and maybe point to that
commit too), the behaviour is no longer guaranteed, and we can end up
getting a file of 0 bytes.
So an explicit fsync on the file is needed (just like ext4 and other
filesystems).

I asked for an account creation before seeing your reply.
Anyway, if you want to do it, go ahead.

Thanks.

>
>    Hugo.
>
> --
> Hugo Mills             | "There's a Martian war machine outside -- they want
> hugo@... carfax.org.uk | to talk to you about a cure for the common cold."
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |                           Stephen Franklin, Babylon 5
