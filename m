Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCADA3FDEC9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhIAPim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbhIAPil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 11:38:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53833C061575
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 08:37:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t4so3447865qkb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=x2KZAz3CSYjixjWYYzedSNWi/Ii4YPdZ0rWLPXN915A=;
        b=TYFTAHAWi/NG0bEkbzYk0svCoO+FAvAmvA9JzU7ntoosQSQdOAaPE7WIha8kNES0Su
         M2kwTbfWsH3pYH7kfcTK6aGYFKsqy1eS0kRe5R2BTw/Q8QrIN+Vs/7umiOKzrTY7ps2F
         9yOqkR9MSM2KSuahwiNmYqmpX6vo6VwWDTyaCgFlFYjI+Q/dThHSQkiQVRHAXzqnDIKd
         g0Giz2bDmYPjnUSIi8Q+RSoalJ8Mqe2DIiR0qy2BO42xM7eyidYY46ogn8VrMwCi83Za
         UsZPaeLYkoNZLFGCAE2eqrTpucP2mP3teqEo67l/j9h9DOR5lqSjonCiag2q/fRtxUk9
         ZE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=x2KZAz3CSYjixjWYYzedSNWi/Ii4YPdZ0rWLPXN915A=;
        b=kKdEaTyOh5BbXTTpjiO+GcXeoTu37utf8s6mSAru3ZY2YYPf/veglULyw47dHOed/+
         qUvCtxD/znbeN1qCYPSOs5n5tuPTxBCi0abMz3zbhpjAI8/le8R0YnpFAkpqV0ZE6itb
         D9125gScU57TamaAf3JRg1gWoALlkdDin1BcG3zSaL3n9K0DWCrEMypWPeJljBLCXSlR
         y0R1qzxCNLtWPB0zm1mIw0XT7lDJJlKfVP4PZqQ8c5WqLRnxXTngf6e5f0pzhw6OEfFr
         Gn/6EJIovzyVU3oP3aUfkmDucegCLchLifxDZBdYe1YpbS8i02pzNOqSw5nSZ31Z+a52
         kMJg==
X-Gm-Message-State: AOAM533QEcDGEuZJqMgWrFnhI/s94ErSLuoFsskVgC+AWc/B/nnXFsvP
        eXHYcjrqF7/S8Iuk8nLF4JQQOOSjo6G3JX9F2eM=
X-Google-Smtp-Source: ABdhPJylXjoCyMM/zlBHhozq5267Yz+gzkfX+A7tOOMVqfJz86PBSPppkk5XgQjHRXtpI7i46HUghx3k0d81iq/j25w=
X-Received: by 2002:a05:620a:916:: with SMTP id v22mr230305qkv.338.1630510663585;
 Wed, 01 Sep 2021 08:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com>
 <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
 <CAL3q7H7vTFggDHDq=j+es_O3GWX2nvq3kqp3TsmX=8jd7JhM1A@mail.gmail.com>
 <CAOaVUnW6nb-c-5c56rX4wON-f+JvZGzJmc5FMPx-fZGwUp6T1g@mail.gmail.com>
 <CAL3q7H6h+_7P7BG11V1VXaLe+6M+Nt=mT3n51nZ2iqXSZFUmOA@mail.gmail.com>
 <CAL3q7H5p9WBravwa6un5jsQUb24a+Xw1PvKpt=iBdHp4wirm8g@mail.gmail.com>
 <CAOaVUnXDzd-+jvq95DGpYcV7mApomrViDhiyjm-BdPz5MvFqZg@mail.gmail.com>
 <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com> <7a858635-2491-cccd-0a29-d1a1d0c9d313@gmail.com>
In-Reply-To: <7a858635-2491-cccd-0a29-d1a1d0c9d313@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 1 Sep 2021 16:37:07 +0100
Message-ID: <CAL3q7H7q58ft3sFJ9n_sy8f4NvoXTcrjyghpsgWc34L2iG4MbQ@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Darrell Enns <darrell@darrellenns.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 1, 2021 at 4:34 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote=
:
>
> On 01.09.2021 17:50, Filipe Manana wrote:
> > On Tue, Aug 31, 2021 at 5:48 PM Darrell Enns <darrell@darrellenns.com> =
wrote:
> >>
> >> It's btrfs-progs v5.13.1. Debug logs are attached.
> >
> > Ok, now I see what's going on.
> >
> > Somehow you have at least two snapshots (with IDs 881 and 977 on the
> > send filesystem), that have the same 'received_uuid' -
> > e346e5a1-536c-8d42-ba33-c5452dec7888.
> > So these snapshots were received from some other filesystem in the past=
.
> >
>
> Is there any reason "btrfs receive" does not show actual id of subvolume
> used as clone source in its log messages?

I don't know... No one found it useful before perhaps.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
