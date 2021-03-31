Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF934F8C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhCaG2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbhCaG2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 02:28:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44BC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 23:28:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c8so18408607wrq.11
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gibSjFL6O4lCYN53qC3xaBSu58gAaUodble8H/gMY1k=;
        b=enn4QUzcBobFfLIZMmPvX1iLKPpALCJ82DQrBUbihAjgtWm5sUJhBc7Z2bxWZfZPj4
         eECbgcAHnznhdiXzvF6OYMy2Hv9Wo9mjEPvvT6clT63ZUXKIX5N0MkxYZBXGWJDWakv9
         Bn5v2XrBMNkROhrtXbZPbim24y4Ead/0GDiXpB7W8rwLzLwyv7kdvybcY3aFMtV2SnCi
         xplBwQ/iu5vkCdXmgqt++DPlOXVMWhwbfPG+Pkwx6FT9vk+m5Vf37BptvMndwKThT0vK
         36/odcCXCg1AlQPvSgTR+UODmA548n/1SUK8C9RSOj4F5EvVHy9VioEYhOnLSG48eXEt
         Hbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gibSjFL6O4lCYN53qC3xaBSu58gAaUodble8H/gMY1k=;
        b=VC8BJygXih6O9EysPhLGNdEr5JLl0wjitH+9LS5YFLWJCreyRKAXZP2BvRY/sgAkr8
         dK+eVVjJrVMXg1YNeCy11MoAhag/KuWC85et6H88ZLfG58SozJl+3XTHf2Ra+/xONRah
         2v2uqz2gjpHaapHKiHeoFENKbbybZ9jaUiiHpTwMl9dzGpKu8xZQL/IRALn077+8mz1L
         q3rWzBdsxwTC5dqppkMw/PACCNBcgGQ7zC+PZhW4y5KjUTra0B16+oH8lkspQjlEFkLC
         zqIPj332v1E04hyCA1DkHJttmJZx9AjoEJhHoGnp48CGhQyBtn+u5hhZV4KXy95lIbHH
         3JHQ==
X-Gm-Message-State: AOAM531zagcfShXssP88I2pF260GWaM+IZB0aBCKdPNzu5wDFl3uesaJ
        t9ZK0FEunHdZZRXHl6rhbiqRYyjFDed82aYaCpt1/vu16mQwhTwf
X-Google-Smtp-Source: ABdhPJxjAzORhiF7lEQhPq/GnPESOr0sKefAnj63vf7ivFyibvokD/33qdazzXUZ4f0kz0lI198/idN72h3Wkn8rSIg=
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr1743471wrz.42.1617172087989;
 Tue, 30 Mar 2021 23:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
 <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com> <em7b647410-6346-4e95-b97a-f45ee2de0037@desktop-g0r648m>
In-Reply-To: <em7b647410-6346-4e95-b97a-f45ee2de0037@desktop-g0r648m>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 31 Mar 2021 00:27:51 -0600
Message-ID: <CAJCQCtQH=k_h7CyRLysea0NgqadPnOVtVTGzdU9pG69RRhqL+g@mail.gmail.com>
Subject: Re: Re[2]: Filesystem sometimes Hangs
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 30, 2021 at 6:50 AM Hendrik Friedel <hendrik@friedels.name> wro=
te:

> >  Next
> >'btrfs check --readonly' (must be done offline ie booted from usb
> >stick). And if it all comes up without errors or problems, you can
> >zero the statistics with 'btrfs dev stats -z'.
> No error found. Neither in btrfs check, nor in scrub.
> So, shall I reset the stats then?

Up to you. It's probably better to zero them because it's obvious if
the numbers change from 0, there's a problem.


> 5.10.0-0.bpo.3-amd64

It's probably OK. I'm not sure what upstream stable version this
translates into, but current stable are 5.10.27 and 5.11.11. There
have been multiple btrfs bug fixes since 5.10.0 was released.

I missed in your first email this line:

>[Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdc2): turning on sync d=
iscard

Remove the discard mount option for this file system and see if that
fixes the problem. Run it for a week or two, or until you're certain
the problem is still happening (or certain it's gone). Some drives
just can't handle sync discards, they become really slow and hang,
just like you're reporting. It's probably adequate to just enable the
fstrim.timer, part of util-linux, which runs once per week. If you
have really heavy write and delete workloads, you might benefit from
discard=3Dasync mount option (async instead of sync). But first you
should just not do any discards at all for a while to see if that's
the problem and then deliberately re-introduce just that one single
change so you can monitor it for problems.



--=20
Chris Murphy
