Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFF2523B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 00:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYWfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 18:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYWe7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 18:34:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A361C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 15:34:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x5so667380wmi.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6vE+MXdbFsU+RZzsjHqTLsvpByFuqh5mngsAE+hm4E=;
        b=EJCux+fawP5sX4GITqExwZNW3PhZM0taddZz8HdvAldM/9W1cFbaz+RhNLw5lBnk6E
         8iBppWZ0ecmyt+ShKJGbhwqWQMceBTuJtnCJSfLtlVKlyP2axmUXfgys8TAa/1QndIue
         pYq8divUG0pjTx1lwNyk2OHQbwFg3FNhf361n7+FtU9Gf3S60OkbB9XwxaXlQuRdTQ7X
         AEdNr9qeQ5kJ3VBramM5vY9psER1L0lvwbNaJuT6vRdZFyQs4uqi0IpmtecFaM1c6vRC
         aFJA/NEx0GBRP7UPfroH0IHntmPKmfgy02FMF/WwHbF+8K61QsMipwPn/5MOnn3ZqwbN
         08pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6vE+MXdbFsU+RZzsjHqTLsvpByFuqh5mngsAE+hm4E=;
        b=lxI24MhJyOjSN/Z9bq4DuSJ2g9jc/u2vHNNACWcOqjTEQ2ZnoSo0d9iq6nEWIijrRo
         N3ivv1QC2TbvXbeB/vsNQbJ7PmYNMuBPxtOtuyv5heQi3JnzOzcABsSwIRwLCX8H/oGO
         rtroYTyLLWAGE3z25zND9C8aX9wrBeRaul2Aqj3UzAs+eGniuaOROCkaoUZSoJ37hwyc
         bE23+sfGIDuwbIHm94sDL2l8oTFisXOYAgLIMvAB3lQUQOcnUOj1VHixdx5YCVNMT/Ar
         tCKhgL5z+bLqB/AiAFs1FhZ7TDRsQ7epNu8uxRKnMrSrXGA5BoXJMxp3kKhnYHyK54Ex
         F6Lw==
X-Gm-Message-State: AOAM533YHvhn27qOuTPmys8YOgAIPENI/G/y6TZiwsMBdL5WA5uVZvGy
        7Lx6AF4SJlZOWIMuinSeDWu4XeNXeFfmthT0vLV57A==
X-Google-Smtp-Source: ABdhPJw+g3xbDIuDUxRcUEZ3hWMpz6yf0tvZZBcQ9Jn6gwEj4uZTv51ghaeSfhD1t6dyj9v//wjnKfQ2ns6/V6j/SxU=
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr3904915wmh.168.1598394898019;
 Tue, 25 Aug 2020 15:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
 <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
 <CAJCQCtSqe_oqRZWYP7iLJcGQnzZkC4vmoYVTm_9RPb8eb0-E6Q@mail.gmail.com>
 <BfU9s11rmWxGNQdKqifkB1JKOJcgqAN49OZdV4LAOgo1W2AguRebwCPVosOiMVjMTzuSmsk_Efbkl02s31niRqtCS67WJ9S7_s4jiK9afeA=@protonmail.com>
 <E212ihR5U8HVCyaalepkxQUX3wOj6IXd1yUFHj-PFFtyU7ma-A49vmB8QwfQG5gUVo2nCMbVpPo7C2ccooRO0ExVrIbdLP9sBpnjMOcefHo=@protonmail.com>
 <lyGE8gPEf9cUEMJceWoJWD_ibk4viZXU0yG5VzbNe9yueGbkcnl1FkJrFZZufhWd5y2vNOgAwfYSpJ4Gia5Tow4wdmQXiGuETdyuNmnemJY=@protonmail.com>
 <CAJCQCtR3gbJxJn24qyDfHWh9kQG7BSC=NnoGHmRKPnaQ+P7yyg@mail.gmail.com>
 <8oT9s0Jlzpgp2ctPAXOixSR03oOiPXaitR0AiOkNdBsYHwjPMfjK7CoVAPXuvj71hiUTH-fKoSevAM-To8iSPPBvGRvZeBkU0Nd1_NPonyU=@protonmail.com>
 <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com> <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
In-Reply-To: <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 25 Aug 2020 16:34:15 -0600
Message-ID: <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com>
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

On Tue, Aug 25, 2020 at 2:47 PM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> > Yeah but is / the top-level?
> >
> > btrfs sub list -t /
>
> ID      gen     top level       path
> --      ---     ---------       ----
> 258     94017   5               var/lib/portables
> 259     94017   5               var/lib/machines
>
> > mount | grep btrfs
>
> /dev/nvme0n1p2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=5,subvol=/)
> /dev/mapper/home-azymohliad on /home/azymohliad type btrfs (rw,nosuid,nodev,relatime,ssd,discard,noacl,space_cache,subvolid=5,subvol=/)
>

It might be that for each extent there's a mix of shared and unshared
extents so maybe you just got unlucky and hit a block that isn't
shared in that extent.

Try more of those shared addresses. If you can do python at all,
there's python-btrfs
https://github.com/knorrie/python-btrfs

He gave this example, which I don't follow because I don't do python
at all, but the vaddr is the filefrag -v address from before * 4096.
You could just iterate by incrementing by 4096 and stop as soon as you
get two files (or two inodes). And then us find -inum to track down
the inode numbers to files.


https://github.com/knorrie/python-btrfs



-- 
Chris Murphy
