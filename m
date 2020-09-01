Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D93259D09
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIARXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgIARXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 13:23:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AADCC061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 10:23:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so2392473wrn.13
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C9q4KpsnPZEtIPU8sBBED8DWjwkAANS/INbGcBTyILE=;
        b=qF6pXcVJLUfCycbQBPgdIC2CjP9kjSdVTnI6AYOVQMtdd/EyxVkSRkublyKtRelJo6
         e6/j0XU1flKC8G3/7UBszuU+1sGbIbSMzIZXGSysLtbeJLJxaFIfPJIDFoTu+0VOOKBp
         Z0SHXTd7HsX7cwjlMl1cvMiI+pS4w3aB8UYEpUOaREis5uLuEuY+HpQ80A9CHZik3WSe
         17vjMha6nA8ZGqHfhpwRBT+aLWkXFtP5zENYfNxr1fXCqPVfoX68uI5OtpZqUKiehBC7
         AxFmamSoltCRsdHxra7/VMbYmvGjk4WY6P3m3ka6bFCuk8aQ04BofuXjrXPm94a0B+iP
         7Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C9q4KpsnPZEtIPU8sBBED8DWjwkAANS/INbGcBTyILE=;
        b=nxvUPG/AS8hgJF9BmngoLi4Gkz37N6QbJYxwBKzT1XgpB6mjR2ju5x6CN1SrGnEYxm
         OOPyyHwXMDf/LkU7ziG4H5t+MIVRD9wIuKhqA/SNxGLG+r2buPmT1E7XaSfqTQ352/4r
         I8zW9GlphJ/PEXG7KZUPs+TfyaFZxSxD5j71JMnwnp0adLLKo0P4GUDw6SmSLwOyLR3V
         2ujjCiZPzM1GcgYrE9374U/LEb+ggLtZLxqToF71BSnNYdzbgN8kwbhf8RFTavFLXK8e
         QMFtGq4RPrKqI3c9EfS0BbFo6TN0Zk7PtlbuH0mhluUbLmRWF8HYYXjWj6oHvy5h73vt
         EHWw==
X-Gm-Message-State: AOAM532nlffnYgwrynLNmqJu+ON2tk7Usu6O3eSSwemuqX6JxcmAGd5h
        NHDBQOnCj4cOdJxojLvpklZivxnCQsBas1ZLvoAhCqP+yj2UPw==
X-Google-Smtp-Source: ABdhPJzfUmFz2CElJa2SU2rDynRKmGFyAuvjmXRKiwkyHV3L00lqjzfnJku7hVg9kO21s1jsXTtWBNQPstFCtVOAKcc=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr2928825wrn.65.1598980989733;
 Tue, 01 Sep 2020 10:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
 <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
 <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
 <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com>
 <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com>
 <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com>
 <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com>
 <CAJCQCtSB3QrA74tAH=_Fa-f8WWXJUANgt1_0PRbLcDUgBho-GQ@mail.gmail.com> <OpaR4q6qHHmnUMeRS6_aPu4cgwiwIXFIuVFcCyTJ5tR96gqj0wjAJDnspXY0SydaKgAD79u8CxC_8-XiSRkL7kkDf-Oqmz5-awgn4g4-eqw=@protonmail.com>
In-Reply-To: <OpaR4q6qHHmnUMeRS6_aPu4cgwiwIXFIuVFcCyTJ5tR96gqj0wjAJDnspXY0SydaKgAD79u8CxC_8-XiSRkL7kkDf-Oqmz5-awgn4g4-eqw=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 1 Sep 2020 11:22:20 -0600
Message-ID: <CAJCQCtRzKvPr=wipKcg_s4mgPjHB-W10sEJM8F_cC_GgFmA=ng@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 1, 2020 at 11:06 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> Hi, sure!
>
> > 1.  ls -li /home/azymohliad.home
>
> 43141 -rw------- 1 root root 322122547200 =D0=B2=D0=B5=D1=80  1 19:57 /ho=
me/azymohliad.home
>
> > 2.  filefrag -v /home/azymohliad.home | grep -m 10 shared
>
> 87954: 52756487..52756516:  291198215.. 291198244:     30:  291722503: sh=
ared
> 87955: 52756518..52756522:  291198246.. 291198250:      5:             sh=
ared
> 87956: 52756524..52756528:  291198252.. 291198256:      5:             sh=
ared
> 87957: 52756530..52756530:  291198258.. 291198258:      1:             sh=
ared
> 87958: 52756532..52756534:  291198260.. 291198262:      3:             sh=
ared
> 87959: 52756536..52756546:  291198264.. 291198274:     11:             sh=
ared
> 87960: 52756548..52756553:  291198276.. 291198281:      6:             sh=
ared
> 87961: 52756555..52756557:  291198283.. 291198285:      3:             sh=
ared
> 87962: 52756559..52756578:  291198287.. 291198306:     20:             sh=
ared
> 87963: 52756582..52756595:  291198310.. 291198323:     14:             sh=
ared
>
>
> > 3.  Pick any line, multiply the first extent (4th column) by 4096, this
> >     is the bytenr
> >
> > 4.  btrfs inspect-internal dump-tree -t 5 /dev/nvme0n1p2 | grep -C 10 <=
bytenr>
>
> No output for any of the extents above. For example:
>
> 291198215 * 4096 =3D 1192747888640
>
> Then the following produces no output:
>
>     sudo btrfs inspect-internal dump-tree -t 5 /dev/nvme0n1p2 | grep -C 1=
0 1192747888640


OK it will take longer to search but omit '-t 5' and we'll just search
the whole tree dump.



--=20
Chris Murphy
