Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456BC3FBD7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhH3Uli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 16:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhH3Ulh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 16:41:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95966C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:40:43 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c206so10030128ybb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rE6fxA9549BnEQ+EYVOlpaHBoZIs66OZ+9CO/PUQNOs=;
        b=BJgaxkCin/A+44OTHHsQYqLRNzZw9mgbk+jmeP6wM23PfYBhH/VtXUg/0HT0oXMKX/
         OE3LXBE+SFuaZSKdO1+s7qKoIMZNQjLSDrqrCNh/AgEPSRXiJxYwebv0lP77dlbsRnfV
         XzlI+LaCO0Rup4eDtbyLduCYbkrIOzvs9ggvJr7Ef+kuPewaRmLYJ8m2chwgwfVUD3kb
         a2GllAY52S2CqBxUYYGzYUk5froaySGGoRtWOSALmA8ehyJogRqDazBOvv4vd4UYqQwx
         nSKYy/fwqvV5j2VIXYYUB8Zh0cWgSPEBhFmexjSzPnvLHhGnh/bO0HXJXbNb6+LhwSfN
         p6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rE6fxA9549BnEQ+EYVOlpaHBoZIs66OZ+9CO/PUQNOs=;
        b=eYxBZO7kDpAtg5RKffJUwg3nLQ2fpoDlctRPCLoJxBgqPmJ6L6sZYWIO3gJYIBKVxf
         bVeG8WNeWhnaRxwbcBkz1vombj1r9mjxWftk1XVpdQ/YzJ+PQcJdAP5J2HU9RpTsCdkE
         z5Csk3jsPzhx334OPNuC9xHxdAFsO6J9OmNma+REHpBvm0n9urT4ltNlvBUeWq8ErTde
         kupvGLAZGrdtKSTboH9Yt+2CVJAG3JUWt8w9rIytsIJXsqznORKNQmeJvY6Dr2e7fbq4
         IZSiouqohzfIh3Ps3QuTOjUqR6/AciGHRYg03ZMUPymO255zQ4va6hXNPjTLQ5eY9GQV
         e7hw==
X-Gm-Message-State: AOAM532B74NQMB1RFLr+xEs33fFz6bt2zCfnkiIGlF4z159VLdJ34EdT
        y3JXt7xMpG0j1C+NbvBxLMeHlktQmZzUEgWVUhTZxQD3NpmAEfGI
X-Google-Smtp-Source: ABdhPJyuEfG/+leoglCNvZAN5cAoCmHXM9BnFFwQJ6ENd7WkiCxPNFzyJX89meqw49wUQk4lDf0M+ap5wmD7PKedyHM=
X-Received: by 2002:a25:be48:: with SMTP id d8mr26424760ybm.521.1630356042880;
 Mon, 30 Aug 2021 13:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSXKHSToLeOOconR_nKeuk8RjGjT7_z2QvV9=2zHfYB6g@mail.gmail.com>
 <CAJCQCtSjuEg8LAedxaqpRCOEq5BgegB7=QVJP8Sq3iZUFWn1rw@mail.gmail.com> <CAJCQCtQPvw23CGvR307L-VyPSpZi3ovC3N+xp7OaMNrxSWir_w@mail.gmail.com>
In-Reply-To: <CAJCQCtQPvw23CGvR307L-VyPSpZi3ovC3N+xp7OaMNrxSWir_w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Aug 2021 14:40:27 -0600
Message-ID: <CAJCQCtSC4mx6cNf3mGDOEeWhJaTXK8s+WNWRTRDMt99k8O3LPw@mail.gmail.com>
Subject: Re: 5.13.8, enospc with 6G unused
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following the add device, filtered balance, remove device dance:

Overall:
    Device size:                  27.52GiB
    Device allocated:             21.52GiB
    Device unallocated:            6.00GiB
    Device missing:                  0.00B
    Used:                         21.15GiB
    Free (estimated):              6.30GiB      (min: 6.30GiB)
    Free (statfs, df):             6.30GiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:               55.50MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:21.01GiB, Used:20.70GiB (98.56%)
   /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835          21.01GiB

Metadata,single: Size:520.00MiB, Used:456.52MiB (87.79%)
   /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835         520.00MiB

System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
   /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835           4.00MiB

Unallocated:
   /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835           6.00GiB


So it's back to functional again but does seem like some kind of bug
that it had not allocated another metadata block group sooner when it
could have. Once all the space was locked up as data bg's, it was
inevitably going to get stuck like this.


Chris Murphy
