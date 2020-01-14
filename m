Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1124013A004
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 04:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgANDkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 22:40:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgANDkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 22:40:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so10710803wro.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 19:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyJAkg8aa3mv6RAd82V8wWwbNWKelnz8l2wTMYxyoXI=;
        b=sJWsSRCt6Mw7/bNfc+bA4sfbk99O5Q6cF+sW1FI10xB+glshmWDR5znHeYtvdTQQV+
         AoToZXFxoG/+V0S+ozenOz2xVhdCciQuIDQGVaD1bwoahzJtqYDRkyokaJ6tkZiwwoFv
         GfSr+6SE8bzFAf2clJoXNqsiYBNGv9kvDtllq6QPV7U8c79bbycUPwNuSxDNEDvhamXG
         AN3peEJm6xLMocEMmoCTd8a6+2eArLFz8Imx70Fllx4ngw79aiHPmzz8H6u9bFzfjoQb
         uAJ0irvqBzA39mwCSDmUiJLfXemUqVxKN+nEWXCV1WeWr3qbxywGXHmv4q/2PHUgscgt
         pNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyJAkg8aa3mv6RAd82V8wWwbNWKelnz8l2wTMYxyoXI=;
        b=AoqUC3mShCRRF+u2AtNtwlPCKHe1cdrrA5LX6pqOgiWt/v0K5eBBbBRs2i511USSsG
         v+5qBcXYHNJuEcDD3fitSAziLu30cDe4QDv2jjO/yC4cVKPDyahQcdNckTPPT2vTXb6v
         Ext3WW6m1F5kgpTfMuoAkwpqicPQnpzKzkmPTZNDNnSWgsPxec3u5KlAdGRD0xSZUOQr
         3+juoseEfznsee2rVWXBqsLBkH6BGYb0W0F1J6HAv2wDvwxpCfLoRjcKwT9zZ8evV4s5
         71xpqyW71m6FKmPTAS4Y2nb3eEGV6wty7gPzcpYUAU7oVuIWvKZraul0fRF+dzsMNO0i
         mMKQ==
X-Gm-Message-State: APjAAAWFLdfwR329HVfA7zFO29q34m6glgtc3EuQpMmGj96sFacqJP6P
        4fFj0vb+FVf8srwzev9n0RkrPlAXIabQhAziMO/Iqv5l9Ws=
X-Google-Smtp-Source: APXvYqzv4qIsGHgmd5MToRAEFk3Hrix5LZ0F6NcIpEoCE7+9HFMXsIQTpydJ1Od9QlBQbNn4fHasqQkCMxCsCmTXPV8=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr23129002wrm.262.1578973213746;
 Mon, 13 Jan 2020 19:40:13 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
 <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com>
 <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org>
 <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com>
 <CAJCQCtSmDx10PQvA8j58NcGyEV9La5FRLYj=q-EHTTXwJF+8ZQ@mail.gmail.com> <alpine.DEB.2.21.99999.375.2001131807440.21037@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.99999.375.2001131807440.21037@trent.utfs.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 20:39:57 -0700
Message-ID: <CAJCQCtQic6e+uYUDD_Bt0yQUteCw7yRbB06K5SPHMwrRRZzk9Q@mail.gmail.com>
Subject: Re: file system full on a single disk?
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 7:16 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Mon, 13 Jan 2020, Chris Murphy wrote:
> > This is the latest patchset as of about a week ago, and actually I'm
> > not seeing it in 5.5rc6. A tested fix may not be ready yet.
> > https://patchwork.kernel.org/project/linux-btrfs/list/?series=223921
> >
> > Your best bet is likely to stick with 5.4.10 and just use mount option
> > metadata_ratio=1. This won't cause some other weird thing to happen.
>
> I have remounted the file system with that option set when it was still
> running, but it didn't do anything (as expected I'd assume), its usage was
> still at 100 percent.
>
> Now I had a chance to reboot the system (with that option set), but usage
> was still at 100%, so I ran "btrfs balance" once more (although you
> recommended against it :)) and a reboot later everything seems "normal"
> again.
>
> Thanks for the explanations and hints. I must admit it's kinda surprising
> to me that these ENOSPC errors are still happening with btrfs, I somehow
> assumed that these kinks had been ironed out by now. But as you said, this
> may have re-appeared with 5.4 and it's not a big deal for me right now, so
> I can live with the mount option set and wait for 5.5 to be released :-)

If you have a bugzilla account file a bug. You can put me on the cc,
use bugzilla@ instead of lists@, and then you'll get a notification
when this is fixed in a future Fedora kernel. You can just wipe out
the whole template and copy/paste your first email in it. That's
enough info I think.




-- 
Chris Murphy
