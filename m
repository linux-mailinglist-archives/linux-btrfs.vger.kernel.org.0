Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD96186015
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 22:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgCOViy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 17:38:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39223 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgCOViy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 17:38:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id f7so15931185wml.4
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Mar 2020 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uxtEuCfGzDUoldZQqG1Kdx5ZDtqD6Oc39YesWaTooIY=;
        b=tbubAAgoVGmG6PDmAv4n3AX8e6YvL8gWhooFMOzHxvffS4ZQU6LvQVGMCxIgM0DWTC
         u+rlFtdGXWSc51OWsYfCL9UlHdFMZlI2Oy0uKcaGPjqwXmxGkCTfTNYKDjzIT5ZJ71DX
         YDo7/aoej1g/BcB26LGfAnMuohgCV6+sFOmODEGg18wlhyMXzjuooiuVLxlFhK2VibDs
         LDHctDxHgrbPtNwCn2dJ6zl9XVOO3zJf31X+AB5ISXHAiL96iBJC5ePuFdqvZYAQDOef
         1PxzeZ8TMZrKv1j2tgPfVD6E1VRwxlzPElxeAQfgSVBsPVeHVDGhmstgrqpcGTzeGN8B
         /exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uxtEuCfGzDUoldZQqG1Kdx5ZDtqD6Oc39YesWaTooIY=;
        b=qxh8gQuJpnUhsieOP/khbuUV/3p5r25wZCMzdCEvf9QlOdRGf9lrehXHiLpaW54pGW
         ggiYrkNwyRMkaq4NHBncKkYckr+KrSTfcrdjNE4lj8lBP5py9MMpoNMITcoYGv/raw4s
         e2FOvH1t8BXTyD+HZ7vmrZ/LYiX8ZwUYjprdJdAz4NXRfGiqW65O2TqsysFAyWrx3y9W
         pGmh0zpBrn+vX+zbptzjGeaPhlfJBn8gTyS8ioERD7ThSNxydpixVt2goUmMstsvyiln
         Sp/XkNJlw2L6a+qVNN4caGXG2hYbjPM5BMTxT3sGmB5JjanuKtMigc8emoGyTq0d6iQ6
         0qmQ==
X-Gm-Message-State: ANhLgQ3ml+QW9fD0OSNLgedKWvVQznMdrsF/3+mBgOjrvBwCEvc9VIjC
        AlmZR+8w99SfO4/rwh/MOKYPT8tJaRYCQJFtcldshw==
X-Google-Smtp-Source: ADFU+vu2o3qi30GM+gNhPeeZDoYYuJ/5EptMFwLMMq2MF6sgqls0jUrVZ0HzGBGHCh82w+yzcNpgd3yHxzvyGKH1uQI=
X-Received: by 2002:a1c:a50d:: with SMTP id o13mr23169656wme.128.1584308331241;
 Sun, 15 Mar 2020 14:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <1584301243.085416989@webmail.futurefoam.com>
In-Reply-To: <1584301243.085416989@webmail.futurefoam.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 15 Mar 2020 15:38:35 -0600
Message-ID: <CAJCQCtQtvc9OucHNH4o6i2Ozaxfd6+-RGOWLydHpmNGkb4=ykg@mail.gmail.com>
Subject: Re: 100% disk usage reported by "df"
To:     Russell Mosemann <rmosemann@futurefoam.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 15, 2020 at 1:46 PM Russell Mosemann
<rmosemann@futurefoam.com> wrote:
>
> df displays 100% disk usage when 119GB is used out of 9TB on a freeshly-i=
nstalled system. The issue surfaces when disk usage is somewhere over the l=
ow 100GBs. Existing systems with lots of data that were upgraded to kernel =
5.4 do not exhibit this problem. Other freshly-installed systems with less =
than 100GB do not show this problem. It is unknown if they will exhibit the=
 problem, as disk usage increases. btrfs reports the correct disk space, an=
d the system is writable. I wiped the drive, recreated the file system and =
the problem reappeared after a couple of days, when disk usage exceeded 100=
GB. Files are being copied with --reflink every day. Snapshots are not bein=
g made, and there are no subvolumes.
>
> # uname -a
> Linux vhost361 5.4.0-0.bpo.3-amd64 #1 SMP Debian 5.4.13-1~bpo10+1 (2020-0=
2-07) x86_64 GNU/Linux


Fixed since 5.5.2, and 5.4.18.



--=20
Chris Murphy
