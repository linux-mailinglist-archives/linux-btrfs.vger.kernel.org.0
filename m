Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7607F1C23FD
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 10:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBIWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 04:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgEBIWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 04:22:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8792C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 01:22:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f18so4642247lja.13
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mv6SlC0tt3Xm1WfE2et8HtHDgz6QBYaaxT03onjAGpI=;
        b=jgzq3TV0yUVNQI5jcq6iowPz/1uZPleMq5bdnlxKW69jJNT+cA0hh+HDA8qYGcsCHH
         gqEzQezi/ZQaJRDVdNmzpDSwD9uVHgccxulqmkfnMMF7cb/SAYkOZqEMA4guFcPCC/I3
         JVyrzzMuFBABuPcGzaI8mrr2Vch2VjefdZTjWB5viM8wlZXuKBwDwM6rLTJkDrDMZHDa
         a42mWTPMlm0yjeRUOhydj1+jNl0i4SyBdWaGqff8lWR9y399ibVDN3Pac8amgcjgXhuB
         f820w0LQTqV16WEC4SHSIFeGQiGRNBujW9TYjjFGMN3Neb+tpL7+ZOQccx8Y16bVIcvD
         x8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mv6SlC0tt3Xm1WfE2et8HtHDgz6QBYaaxT03onjAGpI=;
        b=qJQY/ZyYEmMDmP4Pgha1tpaps7lDyQMnryNBxexszqoWglctriqJKY5995WO2VPUH3
         qIck7oUXw11Tizt1AV6ohn3EdI26SBGsBjxExkZWkVbn6WUyjeVNs6VPARUTVWsjJyHk
         JJkmj2RUzFen9Nev6FtDG0SbSlc0pM5WjoaCLtU7Mf85TPRbcCxpL/A0M9ZnvHFSRlNa
         n9hdxHYIVUGhnEjQKwkeTsLwY/VQf+lUX4kQjuKR9IqmouSXqRNNTl+Pqf69z2O+uftN
         37iJjgvPtZJm82i+vn2W6Pnhcpwj4NQbKzHzXN9/O/uW4baua/ue2ZT6a46Gbg+YLbiD
         TEaA==
X-Gm-Message-State: AGi0PuZesRy2+9T/7dsebqs5gQrIGVvxqTbFMTDFP5prv4krADJ2TT3Y
        IK+V+p0dTmf1BB/jQEln6kABHmKXnotug8em3uxoog==
X-Google-Smtp-Source: APiQypItarhibzRLB50mgBYkxNyE2xibC65mcGSvcgaIwcgXuD034xGB1SQqaCyhsaZmqN6rPNrmSR2BktovqGerGR8=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr4328973ljj.176.1588407757887;
 Sat, 02 May 2020 01:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net> <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org> <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com> <20200502074237.GM10769@hungrycats.org>
In-Reply-To: <20200502074237.GM10769@hungrycats.org>
From:   Phil Karn <karn@ka9q.net>
Date:   Sat, 2 May 2020 01:22:25 -0700
Message-ID: <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 2, 2020 at 12:42 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:

> If you use btrfs replace to move data between drives then you get all
> the advantages you describe.  Don't do 'device remove' if you can possibly
> avoid it.

But I had to use replace to do what I originally wanted to do: replace
four 6TB drives with two 16TB drives.  I could replace two but I'd
still have to remove two more. I may give up on that latter part for
now, but my original hope was to move everything to a smaller and
especially quieter box than the 10-year-old 4U server I have now
that's banished to the garage because of the noise. (Working on its
console in single-user is much less pleasant than retiring to the
house and using my laptop.) I also wanted to retire all four 6 TB
drives because they have over 35K hours (four years) of continuous run
time. They keep passing their SMART checks but I didn't want to keep
pushing my luck.

> If there's data corruption on one disk, btrfs can detect it and replace
> the lost data from the good copy.

That's a very good point I should have remembered. FS-agnostic RAID
depends on drive-level error detection, and being an early TCP/IP guy
I have always been a fan of end-to-end checks. That said, I can't
remember EVER having one of my drives silently corrupt data. When one
failed, I knew it. (Boy, did I know it.)  I can detect silent
corruption even in my ext4 or xfs file systems because I've been
experimenting for years with stashing SHA file hashes in an extended
attribute and periodically verifying them. This originated as a simple
deduplication tool with the attributes used only as a cache. But I
became intrigued by other uses for file-level hashes, like looking for
a file on a heterogeneous collection of machines by multicasting its
hash, and the aforementioned check for silent corruption. (Yes, I know
btrfs checks automatically, but I won't represent what I'm doing as
anything but purely experimental.)

I've never seen a btrfs scrub produce errors either except very
quickly on one system with faulty RAM, so I was never going to trust
it with real data anyway. (BTW, I believe strongly in ECC RAM. I can't
understand why it isn't universal given that it costs little more.)

I'm beginning to think I should look at some of the less tightly
coupled ways to provide redundant storage, such as gluster.
