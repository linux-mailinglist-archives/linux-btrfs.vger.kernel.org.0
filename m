Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E75AAC9E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfIET6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 15:58:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37869 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfIET6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 15:58:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so3576161wro.4
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2019 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKMK7TepegX+bpUNqtRThs2a2cjHOy3LgO+6dEmOo3A=;
        b=HEwavy35cG5vR7gfwh+xPBQBIg8ZcomKVk5CFwnbsGMtjYy7FjRv6ofXTf4seQ3NUB
         KY6AqYnolvC7xuSFghpSOM5L/YZBADg8uhInjEa5lr0ZIPD5Be+Ay7HEtmCBeshjWGSn
         3v/YfK5j7JDaiVFoX39QABePHjoWTd+HeI/NaXd++irjD73cvzMtqPG52T9/UkEBaKjE
         ACLcmv6nQhSOw39MWlY9Y1mC+LP1S4st/Wsi9V+DMqrs5tw4lxuoKU5kvZrbhKDzOFe/
         bzy5BPh7zCXE7Qb3ktW9gomKQ3kGiDRERCMcIgOOM0GKJKSojNxw1KbBBCg8w6x1GVGP
         F2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKMK7TepegX+bpUNqtRThs2a2cjHOy3LgO+6dEmOo3A=;
        b=pxxjF9fwVMn4J8eDNX2/gvkLZzqpvdyjO3B3nf6dLusCwhExZn6mgQkwKZvN+guEYj
         dfveObBScfVbxd+2RgfBk0zusFCKPVEfhG/yJtA4NfosmKhW8VqumA/QoVoMTsxN73iZ
         EP8IASgxn1nmSsb0oTmnfaHfP31CjOyR6RUD01HiRxzIHgG2bT7Oqu2qPiwrVTaoZ/Vx
         1nhqKy9+Hn+zojYs0QgiQDPxopAlR2w3y6EpPE1F1qHKBUOMbnW80PZoj853Vu+uvVuQ
         f0tGZRnU0advww/mXP+QCJ7orgr/NK0NEuF9BE0DazYLnChngsZs3rQPqRPXqvtmsJ8s
         SEyw==
X-Gm-Message-State: APjAAAVbBIwWnuiyoyTmgBo7TCIuw5JpzgjUVc3JALd63AFMS8sIRg4z
        WzSCGnguULUVskegwxtJou6ptwqYKwAnh/CJqc0PjqfOxdlG8A==
X-Google-Smtp-Source: APXvYqx9juoUk/Pz+N9w1JivQBjcQInyREuK+ODWEZJEJFtZbhBjY5oXUMlP1+aLfNAalgj7Uysw7hTSIvmEYTpTvRM=
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr4044992wrv.12.1567713487452;
 Thu, 05 Sep 2019 12:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com> <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
 <51d54d67-bfd3-ee18-d612-330d07d9f714@liland.com>
In-Reply-To: <51d54d67-bfd3-ee18-d612-330d07d9f714@liland.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 5 Sep 2019 13:57:56 -0600
Message-ID: <CAJCQCtSAmCmonFBSBiMCrn+1X__WHDvHgLwWFyScvnfOGRD_4w@mail.gmail.com>
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Edmund Urbani <edmund.urbani@liland.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 5, 2019 at 1:18 PM Edmund Urbani <edmund.urbani@liland.com> wrote:
>
>
> On 04.09.2019 07:36, Chris Murphy wrote:
> >
> >>>
> >>>> I have tried all the mount / restore options listed here:
> >>>> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=comments#comment-543490
> >>> Good. Stick with ro attempts for now. Including if you want to try a
> >>> newer kernel. If it succeeds to mount ro, my advice is to update
> >>> backups so at least critical information isn't lost. Back up while you
> >>> can. Any repair attempt makes changes that will risk the data being
> >>> permanently lost. So it's important to be really deliberate about any
> >>> changes.
> >> I'll let you know, when I have the new kernel up and running.
> > I think you should have all the original drives installed, and try to
> > mount -o ro first. And if that doesn't work, try -o ro,degraded, and
> > then we'll just have to see which drive it doesn't like.
>
> Things are finally looking up. I have replaced both sdb and sdf with
> ddrescue'd copies. sdb had some 10MB bad sectors and sdf 8KB which could
> not be recovered.
>
> I am now able to mount the volume again. :)
>
> btrfsck /dev/sda1
>
> Opening filesystem to check...
> Checking filesystem on /dev/sda1
> UUID: 108df6ea-2846-4a88-8a50-61aedeef92b4
> [1/7] checking root items
> checksum verify failed on 34958760591360 found E4E3BDB6 wanted 00000000
> checksum verify failed on 34958760591360 found E4E3BDB6 wanted 00000000
> parent transid verify failed on 34958760591360 wanted 3331734 found 1544337
> checksum verify failed on 34958760591360 found 04DEBA71 wanted B9FBE54D
> checksum verify failed on 34958760591360 found 04DEBA71 wanted B9FBE54D
> bad tree block 34958760591360, bytenr mismatch, want=34958760591360,
> have=27967614209536
> ERROR: failed to repair root items: Input/output error
>
> Anyway, I am about to mount it read-only again to try and backup a few
> things. And once I am done with that, should I run btrfs scrub?

Did it mount with ro alone, or did you need ro,degraded?

I'm a little confused by the i/o error, which I'd expect will also
produce a message at the same time in dmesg that will hint what the
nature of the i/o error is. That suggests some kind of hardware issue
still exists, even if it is an uncorrectable sector read error. For
sure rw mounted scrubs can fix those thing, if enough redundancy
exists, and those copies aren't also corrupt. But I'm off hand not
sure whether 'btrfs check --repair' can fixup bad sectors like scrub
can.

Anyway, I suggest 'btfs check --repair' is a last resort, no matter
the version of btrfs-progs. 'btrfs check' alone is safe. So in order:

* you've done these

*dmesg
*btrfs check --readonly  ##safe, makes no changes, maybe gives a hint
of the problem
*mount -o ro
*mount -o ro,degraded
mount -o rw  ## all devices available
mount -o rw,degraded

I'm not sure a read only scrub helps much. It might be interesting?
What you really want is to be able to mount rw with all devices, and
then scrub.

But even rw,degraded is better, because you must be rw mounted to make
scrub repairs, and also to do device replacements. I personally would
not do a degraded scrub, because that scrub requires reading the whole
volume. If you're going to read the whole volume anyway, you might as
well rebuild the bad/missing device, so that you can more quickly get
back to undegraded/normal RAID6 operation.

If you can only mount 'rw,degraded' we need to see 'btrfs fi show' and
the kernel messages for the failed mount and the successful degraded
mount, so we can figure out what devices are affected, maybe why, and
then what the next step is.

Anyone know if latest kernel and progs now reliably supports 'btrfs
replace' for RAID6? For a bit it was recommended to do it the old way,
with 'btrfs device add' followed by 'btrfs device delete'. Main
difference for the user is that 'replace' requires that the
replacement drive is at least as big (in bytes) as the one being
replaced and also that 'replace' will not resize the volume after
replacement is finished, that has to be done manually. Otherwise I
think it's preferred?


-- 
Chris Murphy
