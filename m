Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A31309E6
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 21:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgAEUgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 15:36:41 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41783 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAEUgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 15:36:41 -0500
Received: by mail-wr1-f44.google.com with SMTP id c9so47533297wrw.8
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luQBzjnH6xWlH++eIf5lubCa02vnLmFrEcPWm5hgf5s=;
        b=NWIGl1pvNip0xXWSZ75aKPfj8alk73Ycft29yofh2rePmyfihbQ5+wBzwbc+gdgnz9
         VBoqG/AS4ehAkU/HQo5Y+GpPgbtCucDmp+XD96kWOHhi4wjzamjjPNb9igeUulxnmRV8
         YkZh4+BOiVJN3KvX3CP3U4SxcPwiZVtUyumJt0Mp3CETzjsK2Xa63lj3krAiBet+JGFG
         JWz46nsFyHq/QpVpVafxLyAco2IjrnSn9us9D3UcXnV6lDByv2UHhB2unhD/xuorykc/
         4CeDjLO4Z947J44Q8yX/7ngISdy+dJ2b64mwg18OcHSYfY3k1J32rBdiMS9TMvMgvqUM
         EN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luQBzjnH6xWlH++eIf5lubCa02vnLmFrEcPWm5hgf5s=;
        b=KyHHWewW3jRWmnSu1NNrFGk1pCy9dIx7X4xtslgRNf+/2Se1xottEH29dP/F1drjrA
         BgTqh1jTEiEwNh1p6SWLJdqp61Zd2NCp6V3FxaErxg+na1phTJ/AX+6o3KSDuognXr7r
         asbjcw2kljDWknx+1Y8ec2hxRsmyjbOUSqlTgoKQsEx1Vp1FtWC032mXVS7OyO/rmce/
         4lw6jrRfviTxWDTpXUvsIJcqbQ8LYpRMRrSq7hf1Pj+N7Y7sq0Ih2RlPoNOk04PzOiQX
         wOi1JM6jLeyRI43XQeQ9OzrkgqFLGN/auiB6G1YOICn2uggAi7nMUDE/m0t8FaYw3rsz
         Fh9g==
X-Gm-Message-State: APjAAAUHPucyaXB8dXBiO/LRHmTdjBeQAqva7o33EIzDzRnxVuB+z1T3
        onn5nrmrA6INoiu7GdQnT0laideXS2bZnB9YOv3jUg==
X-Google-Smtp-Source: APXvYqzghMu1S+dmw5OG/EQD0BRn08m090hUYJSFReJjn/3Wgas8BgJHDZ0MlpAXQE9SI/tsacvYnylmyfhG2I6LkGA=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr100634334wre.390.1578256598948;
 Sun, 05 Jan 2020 12:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <BF92D4FB-0FBF-49F8-A32D-60D56C41AAEC@icloud.com> <CAJCQCtSXjqxuo2jNJfJ8z_tqsE53ueJyEcOG54fPrPQiYT4vLg@mail.gmail.com>
In-Reply-To: <CAJCQCtSXjqxuo2jNJfJ8z_tqsE53ueJyEcOG54fPrPQiYT4vLg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 13:36:23 -0700
Message-ID: <CAJCQCtRzfhR_8F60fakr1-A4jACSZRn5Le81dcqpziYr3U=0tA@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Christian Wimmer <telefonchris@icloud.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 5, 2020 at 1:34 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> > 2019-12-23T00:00:10.762538-03:00 linux-ze6w systemd[1]: fstrim.service: Failed with result 'exit-code'.
> > 2020-01-03T11:30:45.742369-03:00 linux-ze6w fstrim[27910]: fstrim: /boot/grub2/i386-pc: FITRIM ioctl failed: Input/output error
>
> 10 days.

11 days, but doesn't really matter. Still need to know why
fstrim.service is being called. Maybe a cron or anacon job or
something else is calling this unit to run. Or maybe even more than
one thing is doing it.


-- 
Chris Murphy
