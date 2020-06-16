Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9741FB1ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFPNWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 09:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPNWJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 09:22:09 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E1120739
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592313728;
        bh=l+TxiyQQZJDkH597zkfjaLOObOQIQnSOclVsbqt6WpY=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=1gqE3PKyyF8emw80CESrHpGg1A7EWyaWMeOE93DGg27z/MtRR1MJmmS5evPIZwsTe
         vwcWJMudcBDjTWGMtmFzSC0OoLF/8LYfF6R60nyeToe5pwCh5tYi7qKQPLj8zzH8XT
         uhyEkJQNVGmXseVXpJU1Ltzitjvwyr3oJPYQBvBU=
Received: by mail-vk1-f175.google.com with SMTP id n22so4782815vkm.7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 06:22:08 -0700 (PDT)
X-Gm-Message-State: AOAM530jFinu7uNeprLqU/uo9SCyk5/kx+KD+W1ioL/T5kKKRZQI3AyE
        5l1wCxL6cGkHTWNBqMry15K5r+aXmbbT3LkXYGU=
X-Google-Smtp-Source: ABdhPJxjxF17yPh8f/ldG9vA9tovt4FcDqKvklCg4rTbQNOq3I2mUakIXEha0e+vSpMxitP6YU2I7kJ8Fa4SjlzzNeU=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr1604624vkc.14.1592313727917;
 Tue, 16 Jun 2020 06:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200615093844.287269-1-fdmanana@kernel.org> <20200616131225.GB27795@twin.jikos.cz>
In-Reply-To: <20200616131225.GB27795@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Jun 2020 14:21:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5PrvKc-HaG8t3JGbmc+VfGERpXfKML5h0_Juvz9wMe3Q@mail.gmail.com>
Message-ID: <CAL3q7H5PrvKc-HaG8t3JGbmc+VfGERpXfKML5h0_Juvz9wMe3Q@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: check if a log root exists before locking the
 log_mutex on unlink
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 2:12 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jun 15, 2020 at 10:38:44AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This brings back an optimization that commit e678934cbe5f02 ("btrfs:
> > Remove unnecessary check from join_running_log_trans") removed, but in
> > a different form. So it's almost equivalent to a revert.
>
> I very much prefer the bit to be the synchronization mechanism, the
> logic is easy to follow instead of the cryptic barrier.
>
> The original patch came with numbers to support the 'not needed and no
> perf impact
> (https://lore.kernel.org/linux-btrfs/20190523115126.10532-1-nborisov@suse.com/)
> but it probably wasn't triggering the right load.

The patch was tested without the other patch that fixes bugs in the
"inode was logged before" check, so no regression should happen in
that case.
As I mentioned in the change log, it was fine from a performance point
of view before the bug fix, after which the hot code path can be hit
again.

And 5 processes only will probably not be enough to detect it in many
environments.

>
> [...]
> > The test robots from intel reported a -30.7% performance regression for
> > a REAIM test after commit e678934cbe5f02 ("btrfs: Remove unnecessary check
> > from join_running_log_trans").
>
> Thanks for fixing the perf regression and points for the test robot too.
