Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5903C8480
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhGNMix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhGNMix (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 08:38:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BFC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 05:36:02 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y38so2924940ybi.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Jadq2eY89u2XALiGk1q5HW5jRWVAq6ct+OiU9qoR+A=;
        b=QuRKodW2ZDi6IxIsOaFTDFjnZELEfAFXLUHwKEEo/Hfp/5022Ti4ttTk/QcLETyXdg
         Ck12rhLpfYzJN9EoWkTYRosYitNDxAcW+Y4rAQAQhzITzYgFhcw4Xx5zUhiu3mNDU5ks
         /Vp9axZFCk+v/EXovI01r4K+kq0sXE2GkFR+Lt6lnTiN4mcYFxuxZk5yLHh95BYOIPjx
         VYWeNhu24JF6NRc0Q87l6BmKyQ6isLGRQoYI8f9rfrIQSsUHiQoiV/RY9hbWHZJUweKq
         EXMO48txsa0RnQe3JW4pewhRgJOedc9gqiCdsbZqZkSH2k56SzvizoC4nXkZLd3nx8fN
         H4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Jadq2eY89u2XALiGk1q5HW5jRWVAq6ct+OiU9qoR+A=;
        b=cUlyV9GTDGecUQc5AU31WXz1H2J+pSm5yFqd3ZBTAWl59PIFCrt7v2f+KHF46rgZoZ
         v/PeX+HbT2zvji2Z6eAi0QS0ZxvQi1aF5r6BN2M/wkg3FnkBgBtcXwaoxfnt2se47PfU
         HZNJGS14fCL/d+glxRmxWG4oeNiozxLMTExz222wFjL6mKoDTguNVRsyV4h1kwoLdHQ2
         rm0WggT4SwG5Jt3xHV/L5fHfI0Pggw87Gd56rEu4/lfL6vkNQ2UChpl8Vjg0U+G8A9iR
         SLgh1kBxjX/BHK4nBgcpQ4sDGgiI0xIqPJ4QjBviykiHUQlrYrl1Pd3sG6QGs8uglOlf
         AAlg==
X-Gm-Message-State: AOAM533JXV9IN6Q+8MFmQaJp5ALb2OZXQhm5U+A7iyDmAL1jx43G3nKY
        QJI7vw29IITPD/KnkMUjta5D2lhhD0cVn1Ku/WA=
X-Google-Smtp-Source: ABdhPJwrnLwZ2keoZHU4ZK9St1VTlCR8msRS8Da6L7ckIhx63G7NyajsyLnFCYlDJdU3/Qe6K2qndxZC7QmadIUDD5U=
X-Received: by 2002:a25:7786:: with SMTP id s128mr13132136ybc.354.1626266161164;
 Wed, 14 Jul 2021 05:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
 <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com> <db80b801-9e7d-ce2b-15dd-84b30faf19cd@gmail.com>
 <2a29adba-8451-7550-a6f1-835be431953b@gmx.com> <762a5060-e38d-ccef-293d-c05389d5b0af@gmail.com>
In-Reply-To: <762a5060-e38d-ccef-293d-c05389d5b0af@gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 14 Jul 2021 08:35:25 -0400
Message-ID: <CAEg-Je_2rMu-Y_Qu0tvD85_jnSTGtvkZxE0d7VTASCxCBSdZZg@mail.gmail.com>
Subject: Re: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
To:     DanglingPointer <danglingpointerexception@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 14, 2021 at 5:22 AM DanglingPointer
<danglingpointerexception@gmail.com> wrote:
>
> Yes noted.
>
> We're aware of the write hole risk.  We have battery backup for both
> workstations and automation to shut it down in the event of power-outage.
>
> Also they are lab workstations. Not production.  Data is backed up to
> two locations.
>
> The primary reason for RAID5 (or 6) is economics.  Money goes way
> further with RAID5 compared to other RAIDs (1,/10,etc) for the amount of
> data store-able in an array with the reliability of being able to loose
> a disk.  I'm sure there are thousands of others out there in a similar
> situation to me where economics are tight.
>
> Would be good if at some point RAID56 can be looked on and fixed and
> further optimised so it can be declared stable.  Thousands of people
> would further flock to btrfs, especially small medium enterprises, orgs,
> charities, home users, schools and labs.
>

Btrfs RAID 5/6 code is being worked on[1], so this will be fixed
eventually. I personally look forward to this being resolved as
well...

[1]: https://lore.kernel.org/linux-btrfs/BL0PR04MB65144CAE288491C3FC6B0757E=
7489@BL0PR04MB6514.namprd04.prod.outlook.com/



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
