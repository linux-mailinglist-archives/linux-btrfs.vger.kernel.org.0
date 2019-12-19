Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D62126FDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 22:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfLSVnj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 16:43:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46930 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLSVni (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 16:43:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so7423530wrl.13
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 13:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ihanWHWz6b8K6ld3QupOfRaC4IHt8jlzZ23q5Ha0iM=;
        b=Y/Tb/OqNFj/m76gBn9ijpk7+gXOs1borkS16haueA1dttD9tOSm1NlJBEh8QdXgA89
         4P5F8wz1VADE6cCENPOe5HKVK51mQF+sTRCLwZ/ZIq3pHITK9Vf+1xQ2ucJZyn5Ql23U
         TQKOMWiDcOgyQmJeDnNavE5OimQuv14HTDkZO6CoMple9DFahHEGDokqrbPM8pVc4UOL
         EkztEdlqnFXQpN2iL8va8eq8EmsCga7os5gWAgzYE+ZB3EaadDqu+jTqteroA6AmPEVO
         ZIHwn8nBRdLJ/8GXHUIDKrRGjK18PFoZzyMAF2Jo4VXjJOVFwa8YnVNBr+eZxXY+S6ZW
         QYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ihanWHWz6b8K6ld3QupOfRaC4IHt8jlzZ23q5Ha0iM=;
        b=Nx8fe1Snr3bhhtV1h6mdMJWHs33nJYP/7sAM62TOocZ4aYxFMyzt1M30/8RlxvkKY0
         r4Qo9LPWjB1VI0RI/9klFJQsb2gepa/Fs8R1j57NEAihZrKT37nmO6zXOqRmlJ3+e6sY
         LyThoZcnT/wmuxvVjlgvcRf/5a1zED8qiMXkzy3TRyC/XZOZK33nqsvmsYTJJ6+iNW0R
         QqWOkedjqWpqRKzcZxBoKWLsLbFG2JQ5B33S6S+UvVfrBpVAmBvgwzKx2i3ImqIs+bfK
         I/2LIAhwHf2bGIt6krZo+P3iErCLHuxeGn99wTrgkPDxfjylYMgaC/mOLEfMfRKd0aXD
         n++Q==
X-Gm-Message-State: APjAAAWJBls8dNTeVvmqM7rtqCnTqBfA0SvF37vVAuY8PieK5oKIey6h
        YhmloyKF+Lzrn/lNKzoHqbC2Uxb8Si4zSeOvciBA31VApYOxCQ==
X-Google-Smtp-Source: APXvYqz+law7zzkwB27axVBIq6vkip27MxuVlFYN+TxEbAyoq+LswmKA1BxfBCAY1VEd7Rc79cKrnHOWdLtVekKm8bk=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr11961312wrn.101.1576791816185;
 Thu, 19 Dec 2019 13:43:36 -0800 (PST)
MIME-Version: 1.0
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de> <1774589.FgVfPneX5p@merkaba>
In-Reply-To: <1774589.FgVfPneX5p@merkaba>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 19 Dec 2019 14:43:20 -0700
Message-ID: <CAJCQCtT_gBQsqTVvWkT=JzYgZaJqUtTxX6NErGwT3F_v8VCC=g@mail.gmail.com>
Subject: Re: How to heel this btrfs fi corruption?
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Ralf Zerres <Ralf.Zerres@networkx.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 19, 2019 at 2:35 PM Martin Steigerwald <martin@lichtvoll.de> wr=
ote:
>
> Hi Ralf.
>
> Ralf Zerres - 19.12.19, 21:00:12 CET:
> > at customer site i can't mount a given btrfs device in rw mode.
> > this is production data and i do have a backup and managed to mount
> > the filesystem in ro mode. I did copy out relevant stuff. Having said
> > this, if btrfs --repair can't heal the situation, i could reformat
> > the filesystem and start all over. But i would prefere to save the
> > time and take the heeling as a proof of "production ready" status of
> > btrfs-progs.
> >
> > Here are the details:
> >
> > kernel: 5.2.2 (Ubuntu 18.04.3)
> > btrfs-progs: 5.2.1
> [=E2=80=A6]
> > 4) As a forth step, i tried to repair it
> >
> > # btrfs check --mode lowmem --progress --repair /dev/<mydev>
> > # enabling repair mode
> > # WARNING: low-memory mode repair support is only partial
> > # Opening filesystem to check...
> > # Checking filesystem on /dev/<mydev>
> > # UUID: <my UUID>
> > # [1/7] checking root items                      (0:00:33 elapsed,
> > 20853512 items checked)
> > # Fixed 0 roots.
> > # ERROR: extent[1988733435904, 134217728] referencer count mismatch
> > (root: 261, owner: 286, offset: 5905580032) wanted: # 28, have: 34
> > #  ERROR: fail to allocate new chunk No space left on device
>
> Maybe the filesystem check failed due to that error?
>
> Just guess work tough!
>
> You could try adding a device to the filesystem and then check again. It
> could even be a good (!) USB stick. This way BTRFS would have some
> additional space and maybe 'btrfs check' would complete.
>
> May or may not work, no idea. But I noticed that the check itself
> mentioned an out of space condition so I thought I'd mention it.

It's bogus.

> #    Free (estimated):            134.13GiB      (min: 134.13GiB)

I don't recommend  adding another device until the problem is
understood better. Hopefully a developer can respond.

It might be helpful to upgrade to a 5.3 or 5.4 kernel, which has more
consistency checks. If there's a call trace produced at mount or
during runtime it might give a developer useful information.


--=20
Chris Murphy
