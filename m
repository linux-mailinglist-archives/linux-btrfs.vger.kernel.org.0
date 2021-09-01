Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB203FE17E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhIARxx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:53:53 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43618 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhIARxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:53:51 -0400
Received: by mail-lf1-f50.google.com with SMTP id m18so638844lfl.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16DFtPQ1Tf1lNSsIGeEnjkRKbBcl7fCm1gMvscCHXj8=;
        b=OSykWq0WzxRc6D+AYOSBalqHk27NkrZw7j48pmzhPWwfq0WvkXpUHdhI4hh+V3TOTr
         eC0UoKYxSwr5Vn8RyqiHXr4XVbMIHqKxDWrwSW7alNMeXcvumNulwU0Y2rVhFeWJNFfB
         rU8Bw/B/XAbZNeY/0l8FaecbAr1B5sA7bVX5R/uIq148gBzPONxJytCDAAgplWEyPc3D
         aHNs1R2ixJCq4QMWSjrS6tJbhY3+pomu7p90o49CmeQYb5bwRTCodgAMq7IuFg6hI1QK
         yhfHnnt8nVwiGjBYTMv06Gm2T8p8BFJbuGOsT0wszsdc7X1ziR+VZ/UNKnQzWp6T0FUV
         TCgw==
X-Gm-Message-State: AOAM530RuNXyosC/dwuL6H6qi/4uyXJdJIqSki+rTFIhaXDLALANyK7E
        31p3+nPUjwhzj1glRcyVLNNRGC4epkhMhYhvlTUXrC8K
X-Google-Smtp-Source: ABdhPJwa1cCj5f6fK4xng7ZpKo/FjMJ0Im7l0E0XlqjiBKq82H4/EuHNgt3ZBWI/lFg9YSgBzqcEfOGZgJY4iJQDD4k=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr434324lff.411.1630518773722;
 Wed, 01 Sep 2021 10:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
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
 <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
 <CAOaVUnW6GzK6ANOUz4x+BBXz90sgaT_TJuQUm869CYa6qH2KSA@mail.gmail.com> <ce80dccc-f829-5193-a97b-262c669fb29c@gmail.com>
In-Reply-To: <ce80dccc-f829-5193-a97b-262c669fb29c@gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Wed, 1 Sep 2021 10:52:42 -0700
Message-ID: <CAOaVUnUTA8Anepp3dhnzXXEGjgeeM=VwTERZvWMH6ptrNHZOjg@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Most likely. Did you simply make received subvolume read-write?

I believe so. Is there a different way of doing it that would have
avoided this situation? On a new subvol, would the received uuid
normally be blank? Any suggestions on how to "fix" mine?

(resending this message for the list, because my mail client decided
to it HTML last time and it was blocked)
