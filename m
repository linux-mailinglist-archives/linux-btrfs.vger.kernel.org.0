Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713BD1B4EF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 23:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDVVNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgDVVNi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 17:13:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D4C03C1AA
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 14:13:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so4291072wrb.8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMbo1hfv7672r6Y1gjIi8DM9ub3GdR5lVUEkM+9248Q=;
        b=vdbricFV7pWpLLiE4mmIDhqI3ffQJYbo/idS/FoK13Q57CLN0IFxe7BoISBFOSmM6L
         bS9cV+50Qd4Fim9UIrrWzYKNu3vuqS9bN0XbIeIGexvpXhmAlSa+xL7kMXNPzXowMQy1
         7Or7gjqRDrR7rEDTRs3XajbWnWSWHG0L/jcMoMl/SvA9w2xakrGi+rWwQYRB/UUe4xOh
         iWtOatsP8OsUO1PNgU1mucMNEFhq/kF5FVP5MwfpQEL136xodwAoNd3PksADbML8wpp4
         JUeO1dIz55G3rqsRRXWnnM/zpx/jAJrVxZBRXawMyDtq0HyqZV+rqcDVkaldfKs+5Lb6
         JjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMbo1hfv7672r6Y1gjIi8DM9ub3GdR5lVUEkM+9248Q=;
        b=nV5ZKjxCrnqSu8IzuKv6+awIPiq0HBMlpjWTiZOZA3D3OsI+Skm8jLM262OItkYAHh
         Ub4aQ5auZ9PVnZSCsw4a5htDZrwqyFY56UmzHiBXz0lDkzH5AqtRuiwCn/tspJwziiIf
         2JSfCRsOMBsOYZAS8Wk8ZFyvelvG8sKrqkhUISJjUjd1dYgYS8s+KGZO+wr4f0Ltkcd5
         Um0U72Af0O9hi4sk6aEmoQAkAbzWp0W1EvBHkSCKvZMBgz/oIiM1Zd+yX9Z4hJED7jy0
         17TMjrIpM3bwRNP8vVmYwytdC4WLZBUoYysRnYdN74z6kIAFjNZR2ngpeoSO36OZbLlL
         i+ug==
X-Gm-Message-State: AGi0PubquUpKzUXlMQddJLu7YgLZn77PSmJmjeF/yWUvkwxwYNXmmc8S
        MKdAsgdjmAeIrypcWh0a9opR0JgwNuhTt6bTstbn7M+MWM4=
X-Google-Smtp-Source: APiQypKxbXItcHN8RXafuqa2mD7GekOcxQXK3D5o3KmcITjpK0KbB7ysIVhh4t/Pv/Go4P3Ivk6hiQBzXZrZDuu+In0=
X-Received: by 2002:a05:6000:1242:: with SMTP id j2mr1063523wrx.274.1587590016064;
 Wed, 22 Apr 2020 14:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
 <20200422104403.GE32577@savella.carfax.org.uk> <d59a8a2e-2aae-0177-a0a8-6c238776814a@peter-speer.de>
 <20200422110646.GF32577@savella.carfax.org.uk> <e000c0cc-132d-04ad-dcfd-d808efbff76d@peter-speer.de>
In-Reply-To: <e000c0cc-132d-04ad-dcfd-d808efbff76d@peter-speer.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 22 Apr 2020 15:13:20 -0600
Message-ID: <CAJCQCtTrRshj-oQrJEgaAR=wmuUtTT0fYsFAM0W6QtwUBBgw-Q@mail.gmail.com>
Subject: Re: RAID 1 | Newbie Question
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I haven't looked at the wiki in a bit so I'm not sure if it points out
two common gotchas:

Mismatch between SCT ERC and SCSI driver (used by libata and maybe
also usb) timeouts. Btrfs needs explicit read errors on bad sectors to
do automatic fix ups, same as md.
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

There's no automatic degraded state for Btrfs. And it is not a good
idea to add the degraded mount option to fstab, as it can result in a
kind of "split brain" corruption. In the case of member device
failure, at startup time the mount will fail and you'll need to
manually mount degraded and fix the problem resulting in the need to
mount degraded. An alternative is maybe modifying the current btrfs
udev rule, to timeout after a decently long period of time to ensure
it's really a case of needing degraded mount, rather than merely a
slow or transient effect that just needs a delay so that all member
devices are available when mount is called. But I don't know if udev
has a concept of waiting. For mdadm this is done in the initramfs.


--
Chris Murphy
