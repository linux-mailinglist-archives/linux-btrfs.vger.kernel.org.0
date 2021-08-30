Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD13FBB1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhH3Ri6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 13:38:58 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:39725 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhH3Ri5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 13:38:57 -0400
Received: by mail-lf1-f47.google.com with SMTP id m28so2570129lfj.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 10:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09+ALqrdbs/9ZXRjoVIQqcK78i7MrrIPjvLNx1c33T0=;
        b=OctqUIIzD2qQydgg/Z+Fr3bp3Stky7AJjD50ycDVqXmtJ5ZFdrgT0+NfJSazj6VLAz
         z99Wg4jdzFgUgNKkXkz3T0uX+ZrAK+9UyOMPClbirwaw7WFR4cdOfK1Ts7LRE/5nzGtt
         BmAgbQe7Tq8qSLeqr53JEW93wUYd5Vb7XdaVn7xq1X3e5ODrC5EyPGWZOo8WiJZBpFjE
         VDcO0xhtskX26u6U0b6NQxujF1u7YQFAaKvyuq6nYLhoGUto8+TgaLA+v3kqNGiDhjLL
         vHAumgc/4AtPn2EqLelztoMEXbt+PYJ7B4pdWn05Z14O5UzqINCHtCo4L/r7ha66vlOB
         iSWw==
X-Gm-Message-State: AOAM532DG0yloOVrPZ0r/X6ItHQcPfm+zOSS8jFOVXOzdp/vKwGJoHLm
        sZCXJCKwXdSPUZodQTgmVtEu5IZiQfrELZOxb46K9+nO7do=
X-Google-Smtp-Source: ABdhPJwQGsAqxKhRqM7tWrka0Vp6NcYevzC1yv7Bn43/W1Tz8yO0/LE+G+q7WpvUhadiLwS4hdG1KWTB4Lw+rA1cAnI=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr9891263lfg.411.1630345082672;
 Mon, 30 Aug 2021 10:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com> <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
In-Reply-To: <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Mon, 30 Aug 2021 10:37:51 -0700
Message-ID: <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I still have the snapshots, and will try and test with the debug patch
later today. I am actually using -c. I was doing this using snap-sync
(https://github.com/wesbarnett/snap-sync), which uses -c. The full
command for my test is:

btrfs send -vvv -c /.snapshots/327/snapshot
/.snapshots/374/snapshot/|pv|btrfs receive /mnt/backup/test

This is taken directly from what snap-sync does (just with the added
verbosity). Is -c potentially part of the problem?
