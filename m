Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99833FE109
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbhIARRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:17:44 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:44904 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhIARRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:17:43 -0400
Received: by mail-lf1-f52.google.com with SMTP id s10so404092lfr.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hjwW8yGInC1JFxC3md8KZX2zmGTkwGSrlupbvYL/Kg=;
        b=F2fyIxx6BNr0jpjc0jtyNPt5EA/mjNVskhEQ7M4oPOxWRV8yqNPyHxpxdNLTkGEH3D
         Shau8WXQfSSufKJyR6A1ehHAzrUvNNGop7DjoTQBk5lN6l+ZyKRXt5JN6ioZZJ2VjAYj
         KEtbLtF92XJ28YZPRgpFmf2P8b4UK8vGDHcmaoSQ4V3zbmFwnCK+wRRD8aza+1mqo4gb
         kmYZ08d/ASVTO/y+mqOTosYs1BJfkssC7twDW26VkuOQjvWpzc01+jdt/wMoDCSZfR8n
         UyW0qZacVCmzT2nh502FNVI5N/MT6PPPHljH5jC3PNtZ3MIAf2w2SKwYvj+D0WMwQPfV
         oDMA==
X-Gm-Message-State: AOAM533I2VPBiRwSlSlPzQWi1qYJ/S9iM6Y/NTqhSEIsg86fYHNRF2+z
        UiHkyy+20oKxmZ6/kYUQH3v4VtJEx1Gsz/eFUY4RMTbOY4w=
X-Google-Smtp-Source: ABdhPJzYYVdjovbyptBV2S+w/M0yV24SBwFhUp/FrmEAG1yiixGHXkDjK9MnH7nKGeXyfnHBpt8v8q7cQR/Pv3kdaJ8=
X-Received: by 2002:a05:6512:3f90:: with SMTP id x16mr381932lfa.518.1630516605385;
 Wed, 01 Sep 2021 10:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
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
 <CAOaVUnXDzd-+jvq95DGpYcV7mApomrViDhiyjm-BdPz5MvFqZg@mail.gmail.com> <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
In-Reply-To: <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Wed, 1 Sep 2021 10:16:34 -0700
Message-ID: <CAOaVUnW6GzK6ANOUz4x+BBXz90sgaT_TJuQUm869CYa6qH2KSA@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm not sure how this would happen. These subvolumes were all created
with snapper (snap-sync just calls snapper). They were not received
from another filesystem, and I don't think they've ever been RW
(unless snapper for some reason does that?).

Received_uuid is actually the same on *all* my snapshots, and it's the
same as the original "@root" subvolume as well. Is each one supposed
to have a unique received_uuid? Is this somehow because my "@root"
subvolume was originally created by receiving from another btrfs?

$ for x in /.snapshots/*/snapshot; do btrfs subvolume show $x|grep
Received\ UUID;done
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888

$ btrfs subvolume show /
@root
    Name:             @root
    UUID:             073ca458-1147-7b45-84ae-ecf19a852c1c
    Parent UUID:         -
    Received UUID:         e346e5a1-536c-8d42-ba33-c5452dec7888
    Creation time:         2021-08-07 20:15:54 -0700
    Subvolume ID:         256
    Generation:         131171
    Gen at creation:     6
    Parent ID:         5
    Top level ID:         5
    Flags:             -
    Snapshot(s):
                @root/.snapshots/2/snapshot
                @root/.snapshots/116/snapshot
                @root/.snapshots/157/snapshot
                @root/.snapshots/272/snapshot
                @root/.snapshots/294/snapshot
                @root/.snapshots/315/snapshot
                @root/.snapshots/327/snapshot
                @root/.snapshots/340/snapshot
                @root/.snapshots/362/snapshot
                @root/.snapshots/374/snapshot
                @root/.snapshots/385/snapshot
                @root/.snapshots/406/snapshot
                @root/.snapshots/419/snapshot
                @root/.snapshots/420/snapshot
                @root/.snapshots/421/snapshot
                @root/.snapshots/422/snapshot
                @root/.snapshots/423/snapshot
                @root/.snapshots/424/snapshot
                @root/.snapshots/425/snapshot
                @root/.snapshots/426/snapshot
                @root/.snapshots/427/snapshot
                @root/.snapshots/428/snapshot
                @root/.snapshots/429/snapshot
                @root/.snapshots/430/snapshot
                @root/.snapshots/431/snapshot
                @root/.snapshots/432/snapshot
                @root/.snapshots/433/snapshot
                @root/.snapshots/434/snapshot
                @root/.snapshots/435/snapshot
                @root/.snapshots/436/snapshot
