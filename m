Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD50ADE0C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 23:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfJTVoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 17:44:12 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41347 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfJTVoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 17:44:12 -0400
Received: by mail-wr1-f47.google.com with SMTP id p4so11604102wrm.8
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2019 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+yHy0dyq7QZMnnboJ0/RrF+o/h5SxLwNqZhC+Pn/+8=;
        b=QxPmV/RrRTyK6dVQF1h5S6q8QPhMTt0V13A0hBgpsfd2pJkOF/OHwbxF7NI/jHhDcx
         oDqaxL6X6zNG1JuMeL2gJJNBqblFJCCnN7P1qdgJFLJkme+Fb4yrOm/GYG2RKr/aV8Ss
         1PgXBhYZGhbqgdLqKc5oHU87L2QuGKiqsj531ix38wAaOmgZ4KwPU2a8L4qbqpO+8d51
         UeItsxRV91jKcJol9VjE3rMZnYb6ypamh5Z3QOJdSi3GixGlMEzbPOdDEbdjsnV0xjNO
         zcouxA/N8MwwUjrIuBFtnOPHIPi6iqFUCDE7jtMYVP+Xed5GxzLQ4NbYLTgQ8GzK6TxU
         j+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+yHy0dyq7QZMnnboJ0/RrF+o/h5SxLwNqZhC+Pn/+8=;
        b=LR4004nqDQSkPpzhDMIVhxVsqh5VvrdkOdR2WAHZ4rd9MdQyTpl2bv+uBJFinIjDAk
         iYlGPLCskbjLjJIO9l65YdmfV0REKbrk+1LH18MRjJjZugGKEBjMerEPSmfzHvAHY11V
         pZtoGPVlWC78tyaLcDmhCLYLAfST/M6i9dP3FXY8xY7y3dL0vcz/YOD6OGjWYMsfH8Ul
         n+U1yN0eZXxQud/n10mqjg+7nayfgL+QLqaQl4QRy3lE+2DTPgOTEDjAqsnQ9Ix6755G
         yfZiEYQLesepatyHaG6YSpHdesjNYqJADZvFXbWc2o/0nBCjuzcPadikYeZn+gTdYpkn
         bdag==
X-Gm-Message-State: APjAAAWo80R3Pmx4gCC0C/Ip10p73bYkYj0G37x7Au4WFg0QOKn6pPls
        Pz4OpCnUMF9yD3BCnU55Z0c5+0kjeTmo3lI4SPSmGg==
X-Google-Smtp-Source: APXvYqw5rK5cZg9f6V5Bs6zWkgq6opOpUWNpjxRajmpp5iq3wb+trIcXX4l1R60ezs+5YrpNXYFWiet+Rbv+YHrj5ZQ=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr946317wrq.101.1571607850302;
 Sun, 20 Oct 2019 14:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com>
 <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com> <CAGmvKk4wENpDqLFZG+D8_zzjhXokjMfdbmgTKTL49EFcfdVEtQ@mail.gmail.com>
In-Reply-To: <CAGmvKk4wENpDqLFZG+D8_zzjhXokjMfdbmgTKTL49EFcfdVEtQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Oct 2019 23:43:52 +0200
Message-ID: <CAJCQCtSe-H12qu6dUWfD3WJAA+i=Z-G9ZM5M_wqOBJCv0+VcvQ@mail.gmail.com>
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Supercilious Dude <supercilious.dude@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 19, 2019 at 12:18 AM Supercilious Dude
<supercilious.dude@gmail.com> wrote:
>
> It would be be useful to have the ability to scrub only the metadata. In =
many cases the data is so large that a full scrub is not feasible. In my "l=
ittle" test system of 34TB a full scrub takes many hours and the IOPS satur=
ate the disks to the extent that the volume is unusable due to the high lat=
encies. Ideally there should be a way to rate limit the scrub operation so =
that it can happen in the background without impacting the normal workload.

In effect a 'btrfs check' is a read only scrub of metadata, as all
metadata is needed to be read for that. Of course it's more expensive
than just confirm checksums are OK, because it's also doing a bunch of
sanity and logical tests that take much longer.


--=20
Chris Murphy
