Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849061E4D50
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgE0Srw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgE0Srg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 14:47:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CDC008634
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 11:41:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so13001705wrp.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PWNMZFYDlyQB4xa2P67RaXs3SsINgtYYV4uVegCiE50=;
        b=O5BNeYRDou/1Ddic0mE/rtmpYGt9KXsU111IPk+JrGiywMmKTtvO1ZYKMWSqRqyH1J
         NkpmYi2Y6hjV04x1KBfZVW8lFdcf00D3pxKuIr4Mf324hpNl+0IGVkg+Y1zV0xPVtddU
         HbGUbm6/0yzl6XgPs77NdRPeXxb6HtWcvY2boceEOvwDWIrifIIj7p2KwENgF/nV1bXi
         peSzFJPnNb7gthQMSij4smJErwdD8UPT9CDjRlkJDyoMRMSzlcMw7idF7AxeEgQEgLBc
         0MNSn/K4Re6nnWAAzODhjPaNzlCBEs/ZKIivUArogl+PbgNHioUmcsu9p9FnS6ZjB/xr
         OjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PWNMZFYDlyQB4xa2P67RaXs3SsINgtYYV4uVegCiE50=;
        b=NeN24ihqJpsON4BVghyudyR5Htv3ElcdxKfziQ2kdadJA0h+ad84hdBre1v9iHaRt9
         ai64G6lDb2GUnXEibkW/br5NGoE3ov2v3idFarTrveRVqrjytXvlUrCmDzTmpxcwLR5+
         E3Iq7Q82FcitVkDQLHAcxjqfil2ix8U2yJQKUH/0vt+VPam4+RUmDrAFdNHFxgupoN0Q
         bSTVSBPNyXeco9pJ756XkfU2PdU5fnl1WYh5AAhQM46WPi7rcjTq3CHgNJK7a02DjhrC
         i36Kp7pTmcXNPFc0d4Z/+F9h4vp6CZXbux/XzThUgC3UvY4CjxA3T9+XqdU02Djsc8Cd
         RxBw==
X-Gm-Message-State: AOAM533BGouRuGQJXkW8i/Vx+8l11Xgm0W7MhLSMVKBfv0prc7cRdTdN
        2MrtRTQAAVYVkBYZBKWlw/XugS1BHp3W7Jzs+gSMqw==
X-Google-Smtp-Source: ABdhPJx5h6fA9dSeSHd5qX+wLv/eEgrw6zjx2jHRdX1nGjNWWnYXzuTt+UQLlN3DlXnhbD5u2kc/O6FRbxPmmgH4FBg=
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr17118329wru.252.1590604871090;
 Wed, 27 May 2020 11:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
 <CAJCQCtSyJp0LiaO246NcEX-p7rk8-h1NocW4o4rJgN=B1Kwrug@mail.gmail.com>
 <46fa65a3-137b-3164-0998-12bb996c15ef@gmail.com> <CAJCQCtTmcRfrZEtdnUgF0CkFFWDW-d5-LtM4SFKO4F7Xr9ai_A@mail.gmail.com>
 <0d3b740d-a431-cca0-3841-a85e49ffff9e@libero.it>
In-Reply-To: <0d3b740d-a431-cca0-3841-a85e49ffff9e@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 May 2020 12:40:55 -0600
Message-ID: <CAJCQCtTt0cusvmo-W3vUqmWNbGeH1f3JFSD4gLNBE2_38avd9A@mail.gmail.com>
Subject: Re: Planning out new fs. Am I missing anything?
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 10:23 AM Goffredo Baroncelli <kreijack@libero.it> w=
rote:
>
> Hi All,
>
> On 5/27/20 8:25 AM, Chris Murphy wrote:
> > On Tue, May 26, 2020 at 11:22 PM Andrei Borzenkov <arvidjaar@gmail.com>=
 wrote:
> >>
> >> 27.05.2020 05:20, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>
> >>> single, dup, raid0, raid1 (all), raid10 are safe and stable.
> >>
> >> Until btrfs can reliably detect and automatically handle outdated devi=
ce
> >> I would not call any multi-device profiles "safe", at least unconditio=
nally.
> >
> > I agree.
> >
>
> Checking the generation of each device should be sufficient to detect "ou=
tdated" devices. Why this check is not performed ?
> May be that I am missing something ?

But transid isn't unique enough except in isolation. Degraded volumes
are treated completely independently. So if I take a 2x raid1 and
mount each one degraded on separate computers and modify them. Then
join them back together, how can Btrfs resolve the differences? It's a
mess. Yes that is obviously a kind of sabotage. While not literal
sabotage, the effect is the same if you have alternating degraded
drives in successive boots.

So you just cannot use degraded with either fstab or rootflags. It's
bad advice to anyone who gives it and we need to be vigilant about
recommending against it. Maybe the man 5 btrfs page should expressly
say not to include degraded in fstab, or at least warn there are
consequences.

--=20
Chris Murphy
