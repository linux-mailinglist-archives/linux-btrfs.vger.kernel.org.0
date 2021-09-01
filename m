Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC53FE258
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 20:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhIASaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 14:30:04 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:41857 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhIASaE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 14:30:04 -0400
Received: by mail-lf1-f42.google.com with SMTP id y34so877859lfa.8
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 11:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0mMqPiz2pYzsaAAsc4FAO8doltfuP30eZzeDehrrlk=;
        b=MxRgMBU9e89TwV0kBecJY+MBcW88gQvn58Hj2fTK0GFj6LP4GGofFW9ku+Cb3tYPwo
         JT4PKTEYVA4baL5vdCkuF+XT0ZQdDqmEiq+9NNE/IooOiLYMP/Wd6rPyF2Ajaqfy9WWH
         oDC77+NfYY+h0xwZqF/mPTivEMg7Cfxoz7Yr+dz/O4m4TNDYRQuRCvm3w+HH2cV6Xt+a
         /uPC0xeiTdHASgf05A3IFTrKNJlMti/kb6zlJz8FdwqGIze13Itd/9IdHbW+dd9BO6QA
         pz8gtItZ3B6kCsHrsnwX2cQAsnNW+FJpzOpadRmz9RCtWOFwCFezi4a0mbu5SuvLPXv2
         cSbA==
X-Gm-Message-State: AOAM530OvS8SYkDI9rNQMbtIL5GW+iqQ+bn4kJIhPyqTmsahmVL5saUc
        y8drwTFj0JKu2iffIpxG3iXxu1jZ0XLEkE9QGXquotd7
X-Google-Smtp-Source: ABdhPJySg7rbaai/9BEYeYlcIXAl0aNm2vF346TP7FtD6nYTiXdeubyEvg1QPjc8LkwWqcSExX9ePnjW4zrcUAAQmcU=
X-Received: by 2002:a05:6512:21c3:: with SMTP id d3mr565517lft.226.1630520945922;
 Wed, 01 Sep 2021 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
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
 <CAOaVUnW6GzK6ANOUz4x+BBXz90sgaT_TJuQUm869CYa6qH2KSA@mail.gmail.com>
 <ce80dccc-f829-5193-a97b-262c669fb29c@gmail.com> <CAOaVUnUTA8Anepp3dhnzXXEGjgeeM=VwTERZvWMH6ptrNHZOjg@mail.gmail.com>
 <06e92a0b-e71b-eb21-edb5-9d2a5513b718@gmail.com>
In-Reply-To: <06e92a0b-e71b-eb21-edb5-9d2a5513b718@gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Wed, 1 Sep 2021 11:28:54 -0700
Message-ID: <CAOaVUnUvKu7QC=nRUzj-nMYxEiUy7xcHx=e3J6vJsaQ_AkVzmw@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> There was proposed patch to clear received_uuid on
> clearing read-only subvolume property, but it has never been applied.

Exactly this was about to be my next suggestion. I don't know all the
details, but it sounds like that makes sense if matching
received_uuid's is considered to mean the data is identical.

> What will surely work is cloning you root subvolume and switching to
> clone. If course you will need to restart all replication streams
> beginning with full send of new root. But as it looks like you will need
> to restart it anyway.

I will give this a try. Thank you very much for all your help diagnosing this!
