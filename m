Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A438267C1E
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgILTps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 15:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgILTps (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 15:45:48 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329CFC061573
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Sep 2020 12:45:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cr8so6944340qvb.10
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Sep 2020 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Hs6TcuQitY1nvEfkuXyVkzxXR/QogY0gKQWbp5AkrSI=;
        b=U0d/6n+pJVk14RqKNjDZikCJ3lQ0AB/YP77G0Fw4syCHZ+R6eOBYrsDgzm3bqixDlC
         vTmPKaJj6Q9oDDARFHJZqlzMOmCT8OeJ3zwBhsX6n34zfQ+fykHRqEj2EyOzn5kg7Kay
         1fiWTkB2e5NOuYYK67OZ0kTmuue3VEpDe0DKcz0/UerjavbE4vKwWVP+WB9GYH5+pGTc
         M8MvynivVGlXQjD1gXj0a3gRSHuz/NW1Gh/rsocEpjVm9iNtc0hlFwzP6aZemkE7J4Nd
         DnARDMEyYnzA0DvBpxQlyUimX6YM/h4yjKykTVB+ZtsU1erUTw4aTtsUi8MHmtrABbAJ
         05Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Hs6TcuQitY1nvEfkuXyVkzxXR/QogY0gKQWbp5AkrSI=;
        b=IjAZzeaeB26UvW4Pmalc/Kza3TZtj8N/tigytj7jBJvpY2dAlRnHhCg7CQH/FFMlIB
         0uZ3tfEauJugYt264gVKCVYK3J3yAfHGdJAI/Hd9q4Oo60VbLpHpnrlS54oKt93pUdr0
         fJgSPhuah+FEc5AY3cCxMbWt1JTueWKPvtmbjAcdEEuJYexxqbR4KFu3cXWs48rfMFSW
         iewvfglDc0J6attJGnDnkbZTfXY3iTEnSwfcF7RA4XN0w4j15zwLs5zdGusg/pbK3dyx
         MktvUD+Q1UUeQKM/rpwhDRskBJrwoVpe5eMm7MfCcnAm7xPv7/nAKFWkLVnqghlOHkX6
         XVLQ==
X-Gm-Message-State: AOAM532Ix0QbqhqWKnUUQlIPwcApQofx2dgJkJnVFwGvI6rpRTw0gY9d
        jOLdO+w08CJAw3ni1fD8Um7+/84yOwals9u3Wxc=
X-Google-Smtp-Source: ABdhPJwI+Y66Luwx8YCgTpw3sFALl0d6NImAW5+ez8t4FEZoPfgCHAgFIHTbpkS2XLtCZoaFIbXEpTpzXFTeZAvNnCU=
X-Received: by 2002:ad4:568d:: with SMTP id bc13mr7342156qvb.107.1599939944427;
 Sat, 12 Sep 2020 12:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se> <dccf4603-ee16-37e0-11b2-d72f8956a74b@googlemail.com>
In-Reply-To: <dccf4603-ee16-37e0-11b2-d72f8956a74b@googlemail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 12 Sep 2020 20:45:33 +0100
Message-ID: <CAL3q7H4s1W33DovgTJRAr3qTh+wjPZqbiHUjmvPMqQ=rce8YMQ@mail.gmail.com>
Subject: Re: Changes in 5.8.x cause compsize/bees failure
To:     Oliver Freyermuth <o.freyermuth@googlemail.com>
Cc:     A L <mail@lechevalier.se>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 12, 2020 at 6:27 PM Oliver Freyermuth
<o.freyermuth@googlemail.com> wrote:
>
> Am 12.09.20 um 19:13 schrieb A L:
> > I noticed that in (at least 5.8.6 and 5.8.8) there is some change in Bt=
rfs kernel code that cause them to fail.
> > For example compsize now often/usually fails with: "Regular extent's he=
ader not 53 bytes (0) long?!?"
>
> I noticed the same after upgrade from 5.8.5 to 5.8.8 and reported it to c=
ompsize:
>  https://github.com/kilobyte/compsize/issues/34
> However, since it's userspace breakage, indeed it's probably a good idea =
to also report here.
>
> Since you see it with 5.8.6 already and I did not observe it in 5.8.5, th=
is should pin it down to the 5.8.6 patchset.
> Sadly, I don't have time at hand for a bisect at the moment, and at first=
 glance, none of the commits strikes me in regard to this issue (I don't us=
e qgroups on my end).
>
> >
> > Bees is having plenty of errors too, and does not succeed to read any f=
iles (hash db is always empty). Perhaps this is an unrelated problem?
> >

Can any of you try the following patch and see if it fixes the issue?

https://pastebin.com/vTdxznbh

Thanks.

> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
