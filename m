Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE631D102
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBPTcl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 14:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBPTck (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 14:32:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B873C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 11:31:59 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id v5so17708731lft.13
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 11:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vlad.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzXEL3xNHt3ceCucousjjD05957DGpQH5A8JIr5KSq8=;
        b=WK6XrJuPsQ/eRtD9M0hoHv6AzCxs/VULScbm8ygtzjPeLGKzv9/LHFvYtLInngeQYD
         MeuhPb9I5N/lNTtLTdqrPKTTr3tY/2Hx3yFdoUxqRXVFEkuszX2RXr1PlBdhU8hWwNi1
         oCJj0Z4yxoA1RRsXWGzt2dVzVzE/eRIWLJLRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzXEL3xNHt3ceCucousjjD05957DGpQH5A8JIr5KSq8=;
        b=eoATAzglYtCDqTS7b1X3oOXfpQOCtOzkP99hJgc+l++XjK0FlqhiyNOTmtYBoL7vMz
         dOmGdpFCANUArwJkmRkSQ1Y0B/JczaFj342CplUvcAHih3mOaMFZg4YKyFPAqsSVRhC5
         /Lg8QUv3ILUEq7kltf7LFa1ffWXzFSP73dGKmxkfZ1fRYSW37GQyZ3Zh+vws0iNCB9Kp
         IZdzD1ODV/eWRCs3CaGZGsidBYN2NtJ9OWoxgEDqVdmJFMi/xj2IWlpbxYcJWps3tYG0
         1w1hj/68D9mEPWeyd8BBrvxVR+4Z/bDGkATYoLikgt3/wv/vaTBXOiy/hRm/7JRZyswf
         OZ2g==
X-Gm-Message-State: AOAM53086Gi+rf76Vrc7Gezqe8KTyt9R6kXwYSE0Lb7W0iGWpTf54dDt
        fhhagnHPBptCi7jJuAuAkrRMXCHQsf/RySOwXN3NZ4n+lyjkMexO
X-Google-Smtp-Source: ABdhPJwEtOynkCcRCbmNXtSYdrHRMBI/k/9z0Madir9wZAch11c1ci40B4eyXy3vLcV+fsfhb5vTuiRDOIW4s59XzLY=
X-Received: by 2002:a19:5d56:: with SMTP id p22mr12064621lfj.360.1613503917727;
 Tue, 16 Feb 2021 11:31:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com> <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
 <aeed56c3-e641-46a1-5692-04c6ae75d212@gmail.com> <CAFTxqD-SpnKBRY9Ri9xWFfNgWuHYVggYwCPdyXgF6ipUAzxNTg@mail.gmail.com>
 <20210216174906.iv5ylu3p7jn347kb@tiamat> <CAFTxqD_RgvZTPCZywE28nW==PjT5N68_8q7zr1Te-VAiHMp1oQ@mail.gmail.com>
 <fc5db83a-1e2b-2653-e402-a52907573b6b@bouton.name>
In-Reply-To: <fc5db83a-1e2b-2653-e402-a52907573b6b@bouton.name>
From:   "Pal, Laszlo" <vlad@vlad.hu>
Date:   Tue, 16 Feb 2021 20:31:21 +0100
Message-ID: <CAFTxqD9ddCc97cS2KwnxdGxC5Pea23kJmNyxro8Q7OMwjXbgFw@mail.gmail.com>
Subject: Re: performance recommendations
To:     Lionel Bouton <lionel-subscription@bouton.name>
Cc:     Leonidas Spyropoulos <artafinde@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks. Unfortunately, this machine with this file system can boot
only with 3.10 kernel somehow. Now it is started, and I hope it can
hold the line while I'm creating another machine with a different FS.
This is not a criticism towards BTRFS, this is a criticism to myself
to not thinking enough before implementing this service

Thanks all for the help

Laszlo


> open_ctree errors with healthy but slow filesystems.
> IIRC x-systemd.mount-timeout=infinity in fstab can be used to avoid
> these errors.
>
> Best regards,
>
> Lionel
