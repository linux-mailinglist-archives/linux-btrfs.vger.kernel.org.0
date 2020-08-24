Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F224F112
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 04:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHXCY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 22:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgHXCYZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 22:24:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8AEC061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:24:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so7112708wrc.7
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sope9m/9zgwwT3uOu7Yc6A2puavzLP5I5WDesnhrxtw=;
        b=iTyDSHblHGnAhfZx4ES4ygYj/+jSDe1vrWTUlUm8vwOHbipaX2gkPYJgseoK401l02
         Bl2u/24uOsnvYlu+FocK64EiZ0zrU4Vn/ufAakslwQnRdNI4cqemGjaZoPsHAYrf9cms
         P/3OPUdXUmyzrVJbHZAa2YJl32Ml+pMkGyIKRHyhjXWZ22F1K3QfZtKlsTlpmoUCtz89
         J52syElXmeNS5em7ahBgzqLvZYh0+Ub+tki5bNe2iSq6TPJBeTxKH+ezYS9yVpsbe5zR
         to6cXPL2fRK3BxaqO4jaUf6KzaZur59+xzjjVcJaOtflaJfOuj9uyT8JPgTHYzWLUzFm
         h7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sope9m/9zgwwT3uOu7Yc6A2puavzLP5I5WDesnhrxtw=;
        b=h3FeM8fiHoAm+/pz9Zn/wpY/daLjuqkYPlW+VUHFuMbEYbHomlQDtkLCG5BMojYjkU
         xo8JmHDpu/vDstl37YVspVOf2xGUyGIlkWL3N1ch9CJ7B9bQxFQ8Vbltfg+HDk6YkM6O
         XKk/TNT9rN7xARzRdRJB0390clecHXxkPantVLvGTTs0H680530G7HnSbh8ZdFBVcJGq
         BT4pjd3z2alvKjk0208O6H20pA6KY2OcBuEf5WA4Q79a4PobGNKbZv9j6B5qbzYi7xiT
         zwlEEEVhCcfeHCHBnqHA8uKDRKkXnQsQbaASieGe8x+x7TDvrwZnOZNM60ZzhIpqRuSR
         s6FQ==
X-Gm-Message-State: AOAM533hguC5mH+2tpOMHgV5PrsyP2MPyDgEkWYUhw8r3c64ZumTebh+
        DXMvV5UAa+udK6D2e9lU399OQUcKMX3uWDcIRlnBHQ==
X-Google-Smtp-Source: ABdhPJzUNCbB/B7GnwBblW2x6gpF5cC9XnwFBj6fqWFmY1UeSxPEhN+q/7Ig5YI0L8CrhUTVuWrv/71yXvSMxFKDquA=
X-Received: by 2002:adf:8401:: with SMTP id 1mr3585295wrf.274.1598235862100;
 Sun, 23 Aug 2020 19:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <20200823153746.GB1093@savella.carfax.org.uk>
In-Reply-To: <20200823153746.GB1093@savella.carfax.org.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 23 Aug 2020 20:23:40 -0600
Message-ID: <CAJCQCtRFQhTLsNBu5iO=Fhd7YHdMm643J8KRPUnC0aBjGH9Yrg@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Hugo Mills <hugo@carfax.org.uk>,
        Andrii Zymohliad <azymohliad@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 23, 2020 at 9:37 AM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Sun, Aug 23, 2020 at 03:31:47PM +0000, Andrii Zymohliad wrote:

> > btrfs fi df /
> >
> >     Data, single: total=475.43GiB, used=299.28GiB
> >     System, single: total=4.00MiB, used=80.00KiB
> >     Metadata, single: total=1.01GiB, used=437.05MiB
> >     GlobalReserve, single: total=61.03MiB, used=0.00B
> >
> >
>    The / filesystem is a clear case of needing a data balance. See
> this link for what to do:

If it really needs to be balanced, it's a bug. It's 2020, this is a
5.8.3 kernel, we can't keep telling people they should baby sit Btrfs
in such cases. And also it's not clear it needs a data balance.


-- 
Chris Murphy
