Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F04250875
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHXSvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXSvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 14:51:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AE9C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:51:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p17so4317686wrj.8
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tw69/iCtvurYS0X+D6HztWyEMimPk9fd9afeESfHsXU=;
        b=HAzaGxeR0eG3AWzEpzbtsGbVhcxOj57xoWPCm868f2Ka7/nhDSFbyRE0Xdn+OrcSx9
         gfkw/BedF0Jj36eXG0yRHu7EyzG7UAITzymLRlgrp775TA+s8HDFdGNoYpQ7z8XmLK5d
         6/y/gkBwW2KKhOfcR1Toz8W5EJuZfR0c8aLkIJ840D2++vSoVXoNIo6H9nGjqFADYTBb
         5N23BvHxqczk+xy45/Gfx+UknBg5FcSMGBaVNprLjXzgV4MdG60WU74GoBMqh5P4T8Dh
         FjTJ39FN8r/O8xwNrLcG/hG1mLTQW1n9xF+FbuSI4+ktiYlOMaNDlYmxUUDvDktJ9uqP
         TpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw69/iCtvurYS0X+D6HztWyEMimPk9fd9afeESfHsXU=;
        b=p+Qtw6fRSYRo8YLMFAmMQRIborEC0gFPKgVySAz98Hf3PAvsfbFfFZLG8N/Mk6X116
         6j9TLng3UE7WBpgdAKNv7VUOsKz8qjFybodhc8y0DTYxI3P0ejK0ubdLcm5ChvNAu50H
         lH/RDqfIWRF2knAWWg0jk1oR66/sauBh3JaONoPnZARU3LfGLwHMczEXfxEadUji1zUM
         EnC4ezV+78R6iYBtQs4c1iM4oCiQJT9tuh17M8zAA3ul1tqM812YI+A7fN7x9UQqnLfC
         uT5AZ1P6//qk4Tfjiw9TnNqMefbB87Pz1AXiSoylQlQxe7Tsr/6Qzq4FnJS5kcwNu8Wl
         UDqw==
X-Gm-Message-State: AOAM531roqbQpzt/TOR1v2Sjgw4M3Av3Z1tR3cfUZuD1vJN7IKVJ36lw
        5IXO3GG9vSTEVomD8tK8QtLTRdjueFibeQBrYJ1RBQ==
X-Google-Smtp-Source: ABdhPJxcoaE+CazYlgDRTo5+SJYrRoX5rEYXVlMILlqZd55qEfi6+2RFMrlanKGhRF0RmQN2QVDFhL1ubmo30BPgRBw=
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr6244830wrx.252.1598295111309;
 Mon, 24 Aug 2020 11:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
 <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
 <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
 <BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk_Efbkl02s31niRqtCS67WJ9S7_s4jiK9afeA=@protonmail.com>
 <E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=@protonmail.com>
 <lyGE8gPEf9cUEMJceWoJWD_ibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=@protonmail.com>
In-Reply-To: <lyGE8gPEf9cUEMJceWoJWD_ibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Aug 2020 12:51:09 -0600
Message-ID: <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 24, 2020 at 2:33 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> Sorry, my bad.
>
>     # homectl update --luks-discard=on azymohliad
>
> Does the job. I can log in again now. Thank you very very much!!!

Seems like bool should take either yes, true, on, or 1. But I'm an odd
duck. Anyway! Glad it works.

Next question is to find out why you have shared extents.

filefrag -v /home/azymohliad.home | grep -m 10 shared

Any of those shared lines that doesn't also include unwritten (ok
maybe unwritten is fine but I only tested shared without unwritten),
use the value in the fourth column which is the physical_offset start
(filefrag calls it physical but on btrfs it's actually a logical
extent).

The value for my case is 1001165..  so I can do the math in the command:

# btrfs inspect-internal logical-resolve $[1001165*4096] /mnt
/mnt/libvimages/fedora.raw
/mnt/libvimages/fedora.raw.bak

That found the two files that share that extent. From that we can find
out why you have shared extents for your home backing file.

Note: I think this command wants to be pointed at the top-level of the
file system. It failed otherwise.


-- 
Chris Murphy
