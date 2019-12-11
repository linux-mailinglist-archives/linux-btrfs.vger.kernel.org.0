Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF011BC3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 19:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfLKSwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 13:52:30 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:32891 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLKSwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 13:52:30 -0500
Received: by mail-wr1-f44.google.com with SMTP id b6so25266211wrq.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 10:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=il06i9LVx9NHqJfXo0+i84jwoeoS56JouSguk20WoFU=;
        b=oE6uzqTSAz5x006ohcSHL+rRdXwe7xRt+BmvAXVE6qVQOKZsABMoXBF0tBFAYLueNF
         kLw163BlAwSs2pffWljLLbvzS69FDOAszWZoMDpKEmsX+UH+eoMRzYsZjVcrre+QsixG
         87vZWCuHYw4PzscsG/RnUbGkDVz2Fq94PtIOYXc9Rc3+v3dmPl46VPAJm2Qbf8YC6jaI
         U92moxBUTkhAfkV18wQOBO8pMEncbIPqENZHHlDds8WGgp9PwJaZS7/KdYrB5nDibNso
         bTRa8p8WJP/4eOaLdh/b2R2IhLGYCKflPIsIaJZbr96fawyFu5oXa6oLKmbprgZlWie0
         tytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il06i9LVx9NHqJfXo0+i84jwoeoS56JouSguk20WoFU=;
        b=VAFhGovXsS+b8sWGR5hnB69B7EHgONe2YdlPvR3SexDeM72dlwWga9lmrR0ROSHXYd
         kOIHfyiT2OflaTsZH4139dFzqRrnvWRjpydbDUiRjl4JnXKkPKazaf8iynXFpVpfH0aP
         195jL1tNVTB2Dnr0E9k0JvYOKDoo3eZTdcFnyPvPMf9SdkWC8QyECmFudIm3rCYY1K2n
         DtpAC/cNVNcYWpYAfCDV3oDUX6vxgdzkac7PsscXPASXiWXIj9zJlRKJNqrkJi8hAwRL
         ABTBpsKIQtspCuv2+quND7yq2MVYgnmY1LUE2C+22kxmDOFPFLDIPCjhlx+m5qpjr6Xb
         PazQ==
X-Gm-Message-State: APjAAAW2cToGkt+NwW+zzwiznBMBNZUdEwb4Hae9T27BnU/RKKFQO3LS
        QJUrxXXdQvjeY8GFquJwcqxhzl+XuR5dKv9DabXCxw==
X-Google-Smtp-Source: APXvYqxoxAIhGXS4ft88IVtsu47QWhBEIRrMUqljw5tk7phdMDCt/Y7Y6XBvB4yyT9bNgOy/eewbrSD2doV/f7+woJ4=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr1411513wrc.69.1576090347433;
 Wed, 11 Dec 2019 10:52:27 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <CAJCQCtTq4xwyqo_2sFkh+M63GX8MEDq5zGuRr9ZUptO+-KVCYw@mail.gmail.com>
In-Reply-To: <CAJCQCtTq4xwyqo_2sFkh+M63GX8MEDq5zGuRr9ZUptO+-KVCYw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 11 Dec 2019 11:52:11 -0700
Message-ID: <CAJCQCtSygDsK0O_OdzbyC0OHayqVyTwjogqXh2tUUfcJ4cR=og@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 11:37 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Dec 11, 2019 at 6:11 AM Cerem Cem ASLAN <ceremcem@ceremcem.net> wrote:
> >
> > This is the second time after a year that the server's disk throws
> > "INPUT OUTPUT ERROR" and "btrfs scrub" finds some uncorrectable errors
> > along with some corrected errors. However, "smartctl -x" displays
> > "SMART overall-health self-assessment test result: PASSED".
> >
> > Should we interpret "btrfs scrub"'s "uncorrectable error count" as
> > "time to replace the disk" or are those unrelated events?
> >
> > Thanks in advance.
>
> This is a bit old, and there are more recent papers on better
> approaches. But as it relates to only SMART attributes correlating to
> failures, it demonstrates there's a big window where failures can
> happen and SMART gives no advance warning.
> https://www.usenix.org/legacy/events/fast07/tech/full_papers/pinheiro/pinheiro_old.pdf
>
> If you are doing 'smartctl -t long' or similarly have smartd
> configured to do the long test periodically, and if that test never
> shows a failure, that means the drive thinks it's doing a good job :D
> If you assume the drive's error detection is working, then no errors
> detected by the drive means the data on the drive is the data the
> drive computed the checksum on. That leaves the drive's own
> controller, memory cache, and everything before that (connectors,
> cables, logic board controller, logic board RAM, probably not CPU
> memory or the CPU itself or you'd have a ton of problems) which could
> contribute to corruption of the data that Btrfs could detect that the
> drive firmware will assume is correct.

Last sentence is a bit sloppy wording. The drive firmware doesn't
assume the data is correct; it produced a checksum predicated on
(likely) already corrupt data; therefore the internal read back and
error detection based on that internal checksum recorded with that
sector data indicates the data is correct. Ergo, it has no way of
knowing the data is bad.

There is error detection (CRC) used between logic board controller and
the controller in the drive, because connector and cable errors are a
known source of possible problems. This may or may not be recorded or
reported by SMART in attribute 199. And it may or may not get reported
to the kernel (it really should, and probably usually is). So if you
have any of those, there's some small but non-zero chance of collision
where errors are happening but not detected. This error detection is
really a low bar, it's not intended to compensate for regular error
induced by a bad cable or connector, it's designed to be a red flag to
take action.

-- 
Chris Murphy
