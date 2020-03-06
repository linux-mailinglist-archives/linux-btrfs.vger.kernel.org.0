Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A507917C5BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFS5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 13:57:44 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33699 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFS5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 13:57:43 -0500
Received: by mail-wm1-f54.google.com with SMTP id a25so10027845wmm.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2020 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEL7Twz6zV9sQ3hr1crsZCLEMYSYV6AepRFnAD2EZxM=;
        b=F+7tNbST5GyuyKo3Ky9a0LzHjCZRVDl2Ohmy/kMstcihcEQuSJHTZiMvmjTHNeAziT
         z4827+FYj9UIfS62yetwrg4XbnGmO59J6lWDxaosyjpGiSe1jfE6YVgGciUyYI7xgdl6
         gU6ssu4FPxgQCXgxwHp4TX90f0MUMBbnwRQft3pyi059uwKCzn4XtjKDPy3IDg9nvqb9
         2ICmlRRIP2IhxprMJfJMQj4gjrNCTEV9lm4/LQw+uDtUFBaFN8JaEE+lhddMmO09js2C
         xqPwqPD35l95SiGewYGZrffMGDquLor9neoYMflyaKMe3cgSFKI+wT1OIkmUuUx+WtWf
         yJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEL7Twz6zV9sQ3hr1crsZCLEMYSYV6AepRFnAD2EZxM=;
        b=bo5/dW4CrR9+aLGP3UkJppkUmWWZUvhV3HQBN2HIjH7DGZKhLwa9N6dhBeQVx0sklB
         wkFjT1v7zkTqsHkv6kHZvnqfnZQ5/VEPI2iqlpgvyRMiP78CD0cPLrB+DCinbpUTuBdZ
         QGd/b8ONxQIfsUEEo3FkkZC9AwzHQ9rgR6a5UOVnlxD+SZ+/ymKSI7hjtByEFKoBm5iY
         sp1KObiyKM4LTc/Kz1fWFcKNF6Tx0uvLC9rByLBeZS+qOjmbyGKxJHLP0DzTyfP546cZ
         PhbGygz6+kFbn7Ve2tTGCy3l7/G9CdXVEXHkz2FYfT/EJsDpI2RH3Y9My+WG+jTP5DTL
         j43w==
X-Gm-Message-State: ANhLgQ1d8v0Wv1H4jxZLpADeA2uT6G/E2tRccL7eQk58z9mUXEWBpoG1
        6doNEI312qqYBKIRwG2JCOIe+1x7YHW41khI1Zcc7A4e
X-Google-Smtp-Source: ADFU+vvcvsghm7j3fA5PArv4a8XPGTnMXZsslPlC/nFm2hxi7yrqcR09ALPcjvdDFAXifgDfiyuT0RS6gzxp0OieaS8=
X-Received: by 2002:a05:600c:301:: with SMTP id q1mr5476872wmd.182.1583521060564;
 Fri, 06 Mar 2020 10:57:40 -0800 (PST)
MIME-Version: 1.0
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
 <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com> <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org>
In-Reply-To: <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 6 Mar 2020 11:57:24 -0700
Message-ID: <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 6, 2020 at 10:05 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.org=
> wrote:
>
> Hi Chris, and thanks for your help,
>
> Please see below...
>
> Le 02/03/2020 =C3=A0 07:43, Chris Murphy a =C3=A9crit :
> >
> > The transids are close so it might work to try -o usebackuproot. If
> > not what do you get for:
> Unfortunately not...
> > btrfs insp dump-t -b 8176123904 /dev/
>
> btrfs-progs v4.15.1

That's too old to really be helpful these days. It's not something
most anyone on an upstream list is keeping track of anymore, what it
can and can't do, what bugs are fixed, etc.


>
> parent transid verify failed on 8176123904 wanted 183574 found 183573
>
> parent transid verify failed on 8176123904 wanted 183574 found 183573
>
> Ignoring transid failure
>
> leaf 8176123904 flags 0x1(WRITTEN) backref revision 1
>
> fs uuid (blah)
>
> chunk uuid (bloh)
>
> item 0 key (TREE_LOG ROOT_ITEM 258) itemoff 15844 itemsize 439
>
> generation 183573 root_dirid 0 bytenr 8176107520 level 0 refs 0
>
> lastsnap 0 byte_limit 0 bytes_used 0 flags 0x0(none)
>
> uuid (bunch of zeroes)
>
> drop key (0 UNKNOWN.0 0) level 0

That's it? Is this trimmed? This block is for an empty tree log leaf,
and it's not failing csum but transid match. Was there a crash or
power failure? What do you get for:

btrfs insp dump-s /dev/




>
> >
> > btrfs-find-root /dev/
> Command not found
> >
> > btrfs check /dev/
>
> Unhappy
>
> Reports transid failure, then :
>
> check/main.c:3654: check_owner_ref: BUG_ON `rec->is_root` triggered, valu=
e 1
>
> Then eventually aborts.
>
> >
> > btrfs check -b /dev/
> >
> VERY unhappy with lots of verbosity
>
> (Sorry, the machine isn't booted, I have to type everything by hand...
>
> ...any clue ?

No there really isn't enough information, there's too much trimmed
away. The best bet is to always provide too much information and let
devs filter it themselves. Otherwise they have to spend time asking
for more information, and then context switch. And also the
btrfs-progs is too old I think for this list. I mean, maybe someone
could make heads or tails out of it, but the upstream list tends to be
pretty much active development. And older versions are the
responsibility of the downstream distribution.


--=20
Chris Murphy
