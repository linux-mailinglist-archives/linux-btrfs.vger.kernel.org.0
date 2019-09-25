Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C40BE7F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfIYWBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 18:01:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfIYV5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 17:57:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so383114wrx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRaL0+YS5rj6s+2XnqIZFcFwIDExpIG/qJHDXItzUKw=;
        b=xLGUnUUTW/AFOH8bv0esc8BsDDEijeCUO7SivRzYvv+VSEOj8fCWlQbMn7z1REhwdl
         yxu/+LzbYXHTdSK6P6spjTPh3YoawmSpVjPnNDjk2Kvdnz0ZIVZmdCf+9WiXwkBe8UkA
         n+wWHafWfcr190aYgSRBiflP6/VbwfJQtk61/az8UHtG33LKQfVV9fQeblWbl/rYMTbt
         Wr54gHrzLB26JxIXTni61Io1+LYyhr1dXpmfAVCsyXqKOLkDqWTma4QT12gig9fSrKtc
         6BpAAhLguV20n5OfJkB/BsHX5Rm8diJaGd2dwaiDs8ndd2SKaQpYNgJEb5+vq9DBOdA9
         ns8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRaL0+YS5rj6s+2XnqIZFcFwIDExpIG/qJHDXItzUKw=;
        b=TkXFD8EaWMe/mtvYqrqa9BFj/thTnKNuumDTTI38rWAmVU70LOv28f+y4xMN3c23Df
         LJqpXuTeA0tf0F1wXIJrQdqwhqAUlYodylSe3Vbr7gIwhOrVyjzvVh1YWVZLLcEXH+gj
         N8GdxxZ7SX9tcoA6vTQwfU77UYVLQIsLq8U4CJNvHOQzNvjt2OwfeHcKkoAHzvoI3GJl
         1zwYFt2Bkcwpu7B/anlq730+AiwhyQFXeyIP0lSVuzHNFcirGg9JVVay+hij6hhkPHwO
         fQsngMnjelvEpjCWkTdlj1E4O/AT0zQlyQ83aU2NHXRMkh9/PNo6FY9p3c1DTFFRn9+T
         KaRQ==
X-Gm-Message-State: APjAAAWq86uWEpSnhA9L+LNikmPh4cwdR8Du3nxo+Pri6bsl9B7fPkdz
        QyuY87cHaC4drbmxmL4acW/KpzD1+bCYXcPEgDp3Sw==
X-Google-Smtp-Source: APXvYqxbRvD+MkfxjIxR0Dhj+KvraWa0yFzTytmESqndZOwPS693FMXyzGHpGZSy/sceB/c9RX06hYM1KWrfLF+CQUk=
X-Received: by 2002:a5d:4241:: with SMTP id s1mr343615wrr.101.1569448625740;
 Wed, 25 Sep 2019 14:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
 <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
 <20190925193434.ieyj4oo6vkxmjtnw@matt-laptop-p01> <CAJCQCtQKypCbxksq5+XCwRy8enPkfZBaOgzS0SN2un+A1GELtA@mail.gmail.com>
 <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
In-Reply-To: <20190925213231.kaqlq4ph3kgfgs5q@matt-laptop-p01>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 25 Sep 2019 15:56:54 -0600
Message-ID: <CAJCQCtTyxZA6Lf+q16mkbzHdP7B1p07u8RnLdTEFsQRRLjAmcQ@mail.gmail.com>
Subject: Re: errors found in extent allocation tree or chunk allocation after
 power failure
To:     "Pallissard, Matthew" <matt@pallissard.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 3:32 PM Pallissard, Matthew <matt@pallissard.net> w=
rote:
>
> On 2019-09-25T15:05:44, Chris Murphy wrote:
> > Definitely deal with the timing issue first. If by chance there are bad=
 sectors on any of the drives, they must be properly reported by the drive =
with a discrete read error in order for Btrfs to do a proper fixup. If the =
times are mismatched, then Linux can get tired waiting, and do a link reset=
 on the drive before the read error happens. And now the whole command queu=
e is lost and the problem isn't fixed.
>
> Good to know, that seems like a critical piece of information.  A few sea=
rches turned up this page, https://wiki.debian.org/Btrfs#FAQ.
>
> Should this be noted on the 'gotchas' or 'getting started page as well?  =
I'd be happy to make edits should the powers that be allow it.

Should what be noted as a gotcha? The timing stuff? That's not Btrfs
specific. It's just a default that's become shitty because if the
crazy amount of time consumer drives can take doing "deep recovery"
for bad sectors that can exceed a minute. It's incredible how slow
that is and how many attempts are being made. But I guess on rare
occasion this does cause a recovery, while also making your computer
slow as balls. Anyway, this 30 second timer is obsolete but kernel
developers so far refuse to change it, arguing every distribution that
cares about desktop users, and users who use consumer drives for data
storage, should change the timer default for their users using a udev
rule. Except no distro I know of does that. This affects everyone with
consumer drives that have deep recoveries, mostly common with hard
drives. But it's especially negative on large data storage stacks
using any kind of RAID. You'll find this problem all over the
linux-raid@ achive, it comes up all the time. Still.

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

--=20
Chris Murphy
