Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982BC15701B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 08:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgBJHxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 02:53:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42371 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBJHxF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 02:53:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so6240419wrd.9
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Feb 2020 23:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyQd70ya7rrKTCzFJcMrPD9bmnFJlNgRSItSG0htLwA=;
        b=OoS2VI3B3Qye+gmIOch+nSAjTilRI4CLtIrKor8kZVcBKlGrsf0di/GZH8YE008IUL
         dx5zUe6MU0o2pUgr2St2TdlnECHaok/nObSeIRbRXwx0Q1vWKv3t/lW1xtxejC6FCBGL
         C2rLvD3fGtEJUbhUzQq/2/aobi/wusjxMdGCbWhIUX+o1Or5EqgmUZa6BM9G9O5eAdhL
         j8mod9Nk3cqmFUClpnJgfws3vuPmbFzyTFcSYgBvApctfhgVKClf7w44T2/+4GjStq6m
         l/Jw5FnrcH/sEinlKkqZrcmQBCIzdH6Pyb23SmXPaZYi+7SMq+fBtdgKiwwz2e3ZPxUg
         2ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyQd70ya7rrKTCzFJcMrPD9bmnFJlNgRSItSG0htLwA=;
        b=e3Yb0/Y2/LUsKeyeFK6CDNdUF2Xu/SKpPQwkLkYIRLQ8zrTKWNqxCgRd2wRHv8tY1f
         7wi8oxB2Kcq6nAvX6pFLvowPCZ9AeZUVwhhRiArCsx/JD3ELec8SibfxGg5f3M066KeY
         xGgyZho/586zckTwoL4Aj1S/cnhdQgOYBZVpc2HOyCnrk4gejyvWQos0KYn14/IpAJnb
         3jr8H/ASsc6i1y4jD+M/CIGtXt+eaRkbVDiMvtK6JlNEbQyIb2lZuDSG+OjU9tInAmAq
         NKm7CSCqE7BWw4vrG9TZ/IEWU/jJj30AbWS62ibetGGqPSPm8W05cnPRym3Lm4y9UMGg
         ba+g==
X-Gm-Message-State: APjAAAVK4CB6jWCoMAjXMcyINfdeDSgTt9DN9FUw8ZJLOaWYX7L58lgi
        o4nR/r1mbbHXaO29yJFfQcSoXcq+Ep36CROD6S9BFw==
X-Google-Smtp-Source: APXvYqxVLuh3UIjj7hXWVZ6/inhtUFb940Fi0XnliuiA4DwJgsfw60rXlLdNNb30Rf4Wb6VbEZmc1GF8gyDP6EvgFVM=
X-Received: by 2002:adf:8564:: with SMTP id 91mr347923wrh.252.1581321183644;
 Sun, 09 Feb 2020 23:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20200209004307.GG13306@hungrycats.org> <CAJCQCtRzMqPREP5U=8ZoCY0fMEsX_ng4tH3pHbQwJfrdk-MNmw@mail.gmail.com>
 <20200210051809.GJ13306@hungrycats.org>
In-Reply-To: <20200210051809.GJ13306@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 10 Feb 2020 00:52:47 -0700
Message-ID: <CAJCQCtTX4uvig8O4fjzhVcjyHk5E1FFRPpi6cCOzdqq0zjj-mQ@mail.gmail.com>
Subject: Re: data rolled back 5 hours after crash, long fsync running times,
 watchdog evasion on 5.4.11
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 9, 2020 at 10:18 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Sun, Feb 09, 2020 at 06:49:11PM -0700, Chris Murphy wrote:
> > On Sat, Feb 8, 2020 at 5:43 PM Zygo Blaxell
> > <ce3g8jdj@umail.furryterror.org> wrote:
> > >
> > > Upon reboot, the filesystem reverts to its state at the last completed
> > > transaction 4441796 at #2, which is 5 hours earlier.  Everything seems to
> > > be intact, but there is no trace of any update to the filesystem after
> > > the transaction 4441796.  The last 'fi usage' logged before the crash
> > > and the first 'fi usage' after show 40GB of data and 25GB of metadata
> > > block groups freed in between.
> >
> > Is this behavior affected by flushoncommit mount option? i.e. do you
> > see a difference using flushoncommit vs noflushoncommit? My suspicion
> > is the problem doesn't happen with noflushoncommit, but then you get
> > another consequence that maybe your use case can't tolerate?
>
> Sigh...the first three things anyone suggests when I talk about btrfs's
> ridiculous commit latency are:
>
>         1.  Have you tried sysctl vm.dirty_background_bytes?
>
>         2.  Have you tried turning off flushoncommit?
>
>         3.  Have you tried cgroupsv2 parameter xyz?
>
> as if those are not the first things I'd try, or set up a test farm
> to run random sets of parameter combinations (including discard, ssd cache
> modes, etc) to see if there was any combination of these parameters that
> made btrfs go faster, over any of the last five years.

Nope. It was a yes or no question, not a suggestion. I don't
understand the problem enough to make a suggestion.


--
Chris Murphy
