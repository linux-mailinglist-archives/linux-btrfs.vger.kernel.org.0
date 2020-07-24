Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1288122C081
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXIQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXIQM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 04:16:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24267C0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 01:16:12 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id k4so7382398oik.2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCgSWvwb1B+RGs97YSVEfMV8szqq2I+kvtZNNduKn8U=;
        b=Qx2VQnP59OVnHhkCJMTgqtLfU3e7yol6VHYZjWXiyCBk4tLazZaN5NDD26nrxCCQlt
         0q7t+fSSF13d0OZbNKTtz7k7meJ6o66xiiufW+85yagMjDViJt+8k7C6HukM1TrYuDWY
         YdqAkbnny8rnx8ppny9uh+yjzVm1AWg3wR9q9TNkFjloRd8/3pjN/vSbYKq1hbP4V4Xb
         mIkGV4LXoi1sblkPJ05aMoyJuI3RCcssBUJmOQB8qNvJROHi6rqvctVxvPdNKgS3v6A6
         CrgqFQHP4/Finjkrcs5DRmim1CF90ds0fA53+QC+Yp9Jzu8or39vljx54/sde/hIHUV1
         Mx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCgSWvwb1B+RGs97YSVEfMV8szqq2I+kvtZNNduKn8U=;
        b=TrxYFYit4lU1zyMJGnyQp5/VwbTzL0qf0k8p+D77RS6lqarRq43eMT6IzT4PUwVDA2
         GGAlS3aVbqWIuDjyxmUMkML3s7IFVrCmZjxRX8xrY5ezybON3uj97iJbxkM8lQOHe6o+
         t+AHvHM5FJeNtCx3lNRRS4jacPQWcLIIlJb3eSRx+gXz2G9D34yqiNYdWCjp08qH2Ofq
         reicUqtP1ksrGK/8n/I7csgwOiVc2n4oJHk01ylknsUXmaItXURKpGKqLJ6j2jE9NNsC
         0Ri7Idil6zB6kZVxjO5udntVk1zbrFKh55ZTlNybDQeX8IX1h4OrzO6Kj5Tyzh7Mm9rA
         Fdjg==
X-Gm-Message-State: AOAM532B7Ueh8asmZELWVlK3z8bBSWyurVZOHAcaCOrPH2J4MXwSYjmS
        OrIiOYDAz3XqoYBiEpaYIN7QpJDxT+c40qO7xZOH/FqaKY8=
X-Google-Smtp-Source: ABdhPJxnWo+7Rp8zYs7KcFaCa9ms4sq2ZL4VBQCuZk7agmLSRaFCkvd+0twNv3mQhVWqJyvbWhDoVMX2ueVXgxv8oIU=
X-Received: by 2002:aca:5fc6:: with SMTP id t189mr7165911oib.88.1595578571321;
 Fri, 24 Jul 2020 01:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBTU=JuEsRX7YXzMJMELy63TXrm3J6onKnhGSOOzTnnMBg@mail.gmail.com>
 <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
In-Reply-To: <CAJCQCtS6eS7a+wHR__A_aDujANWNJEmUMApjChVMk1WNuZ0BKg@mail.gmail.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Fri, 24 Jul 2020 09:16:01 +0100
Message-ID: <CAHzMYBT8a9D817i2TRqdRiJFdmF-c3WVyo6HNgbv8bJqqOyr5g@mail.gmail.com>
Subject: Re: df free space not correct with raid1 pools with an odd number of devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 5:40 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> Looks about correct? 1.36TiB*1024/2=696.32GiB
>
> The discrepancy with Btrfs free showing ~1.3GiB more than device/2,
> might be cleared up by using --raw and computing from bytes. But Free
> rounded up becomes 698GiB which is 1GiB less than df's reported
> 699GiB. Again, it might be useful to look at bytes to see what's going
> on because they're each using different rounding up.
>
>
>
>
> > Same for 5 devices and I assume any other odd number of devices:
> >
> > 5 x 500GB
> >
> > Filesystem      Size  Used Avail Use% Mounted on
> > /dev/sdd1       1.2T  3.4M  931G   1% /mnt/cache
> >
> > btrfs fi usage -T /mnt/cache
> > Overall:
> >     Device size:                   2.27TiB
> >     Device allocated:              4.06GiB
> >     Device unallocated:            2.27TiB
> >     Device missing:                  0.00B
> >     Used:                        288.00KiB
> >     Free (estimated):              1.14TiB      (min: 1.14TiB)
>
> 2.27/2=1.135 So that's pretty spot on for Free. And yes, df will round
> this up yet again to 1.2TiB because it always rounds up.
>
>
>
> --
> Chris Murphy

Thanks for the reply, I was referring to the available space as
reported by df, total capacity is correct but please note that df
reports for both the 2 disk and 3 disk pools about the same available
space, 465 and 466GB respectively:

2 x 500GB

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       466G  3.4M  465G   1% /mnt/cache

3 x 500GB

Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       699G  3.4M  466G   1% /mnt/cache

Jorge
