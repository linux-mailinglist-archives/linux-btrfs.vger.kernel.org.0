Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619983F4C8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhHWOoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 10:44:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD17C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 07:43:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b64so5560694qkg.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CGcAXNHtsBOucwdVI+8JbB7ambAccLANu0/h8unEEx0=;
        b=LAQ5UudMkN44ml+XkqTs1u/jmtKm6d2vWC2LpLRqiFos3Aa5RdMILPo+WStJ0mK8LB
         Du/t6wGmEk5YAS4xn0hkvtuP2tcYg+DiYsXK+tPAjTUCUA68CSIukxLICOdT4xoM0Ws5
         dVl8s4v8ghjpG4qjXuGEcuzSWXXoKMLTYhY98lGKAUBPbFGPxB2WH3fAr6fDVhA1vnge
         uGvw+a6M1fvHYWaA8kU1S01Z9C2u8uoh8shitsKgsb5sBzVcg5YjlfCqMR+oDn4ljdN5
         Z3c3+kKviCOlnJdJWgNNCgER757bSPsqCJcbwdzsWAN2yxxNNXYDOvOiwk6A0tzurO38
         Lj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CGcAXNHtsBOucwdVI+8JbB7ambAccLANu0/h8unEEx0=;
        b=l5JTlm/rbI+iCJfXdU2X9TaeOD8P6kU2ZK9g9aVPf2kZ93q+XxtxJWNMM09Wh94g2Q
         ZUtI1IYbOOKGcGOvI+nGPa3Vvh3G5aA0Y94Tt0wsRjgHp8yTHZNnbdpo02GvgzqL12VF
         eXQ1jeX2e0HGxAcT3RMmsQ7rz2jnfPTTEHsFZtUTns0m/umQJPupKRP3jg89taP/pgv6
         UBgWoCH5m33qSrwygBcUeuW6PhsChGZU4DiYMN09lSI6zWPTXjxCvJkIu79kiM3UrWyr
         hjwZyOfmc9pucpTJ4iRQmuv7meqCuZc2yfwbWNew5BdKe1Mv33Jo5xnIzXcgY6GbvMil
         3M5w==
X-Gm-Message-State: AOAM533Fk1eW3GpAe8xLF07z79Y3BPNVvOX54RPEHD9JudXn3UyHB9sv
        /hY56bJpF7miU2vY3syUqSwlVwo6DFvGZMWJRCU=
X-Google-Smtp-Source: ABdhPJyjBZY7hEkDLLqVdtqPEzJR9fnvON8eoB2+WRA6w7wZoi02zIEk7NML+4QrY0VejUoG3lWvbjfqZ8yUFPeJVpA=
X-Received: by 2002:a05:620a:916:: with SMTP id v22mr4044717qkv.338.1629729818574;
 Mon, 23 Aug 2021 07:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
In-Reply-To: <db939df7-412d-aaef-c044-62fd2d8b2e7b@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 23 Aug 2021 15:43:27 +0100
Message-ID: <CAL3q7H4NPxdNwpB9LM0FM0bTTTnUtdN6m-6oyg7XzB-B7baCtg@mail.gmail.com>
Subject: Re: Mixed inline and regular extents caused by btrfs/062
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 8:06 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Hi,
>
> Although I understand current kernel can handle mixed inline extent with
> regular extent without problem, but the idea of mixing them is still
> making me quite unease.
>
> Thus I still go testing with modify btrfs-progs to detect such problem,
> and find out btrfs/062 can cause such mixed extents.
>
> Since it's not really causing any on-disk data corruption, but just an
> inconsistent behavior, I'm wondering do we really need to fix it.
> (This is also the only reason why subpage has disabled inline extent
> creation completely, just to prevent such problem).
>
> Any idea on whether we should "fix" the behavior?

We had a discussion about this not long ago:

https://lore.kernel.org/linux-btrfs/20210506070458.168945-1-wqu@suse.com/

And yes, as you found out, it's quite easy to trigger scenarios of an
inline extent followed by non-inline extents.
Both fsstress and fsx can trigger it often, plus I remember writing
test cases that explicitly exercise those scenarios to verify that
either extent cloning works as expected or send/receive, like in
btrfs/205 for example.

Yes, there's the case triggered by fallocate, but also the case
triggered by a compressed inline extent, representing PAGE_SIZE bytes
of data, followed by other extents. This case was discussed in the
past too:

https://lore.kernel.org/linux-btrfs/20180302052254.7059-3-wqu@suse.com/

Currently this one isn't triggered anymore, but that's due to a
temporary regression in 5.14-rcs reported yesterday by Zygo, that
results in never having compressed inline extents.

I still don't consider it a problem. The code paths have been
exercised for years, reads, writes, cloning, send/receive, etc, all
work as expected as far as I know.
Having the inline extent always brings a performance benefit when
reading its data, so I don't see any advantage in changing the
behaviour - doesn't make the code faster, shorter or easy to
read/maintain.

Thanks.

>
> Thanks,
> Qu



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
