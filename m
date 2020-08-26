Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36DE253996
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHZVP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHZVP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 17:15:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E1C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 14:15:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so3236820wmi.5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnJiUe6UEPuimoi4zUCtLDtJMXsUXBCU/TVQshlMsEk=;
        b=k+cCTd+9CHmhFY/m7bs8TOLGkm7J69ZNs4sHVNhkIhR8n2jKh1BXTLoGyIUGJ6Al5s
         MJS9BIpoeukI0gMXCvGikY2JPSQK9WQDiPxo6O8CgJExr5wDWSoAaGlDIjI+uTzZx68P
         GUMK4DKe5LFzEIZAQG4jIWMNG6xwqpWH/y6ImzFofFS2kKXkK182/uzi4x5nVuBkGOHJ
         M9IpTptyWfR9A7ivNT4sio+nS2GPKy3MDWpVfOw61Lkv0QiC2sHKyJXEGDcjD2VltDk/
         XCFFMbByZE61xcD4mjSL9lvUzufpi4e0ZBEHp2wsPHUppg4BwbEQ6j6JvHUBwiytu3Ug
         Dkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnJiUe6UEPuimoi4zUCtLDtJMXsUXBCU/TVQshlMsEk=;
        b=UviexHiPgwZSlTXP+yj5kqIQFbiC4R8LOiMB6qvZK0uXgv9XVjQOJis7b9BGThnpkD
         ywzD5vkoio1qf/Te3h46d+SBDw9KzdjlKmfXP+4foPEKDsfC+rsYlY/xWEEW7zwTar9y
         3wOTuPovmwXpd8V/EcMLp6Xcl0/FezRhOYIOxTQltwA5z6oChji0GYinPDYugPFkAOCU
         +eMWqC3sGl19m85ffBB8Hh6rx5Ycp2uVWpreEOUngG5bvshU4nEID7XYSXmImAi24/kU
         mRQBrOcn8TiNKZm5kL5xUDbjYrHR5plYal2g3L4PRpANKvoHsYoT7nbyQCZQuajk/IAD
         Hbbw==
X-Gm-Message-State: AOAM531rhfZc++Sk4EHytXJvxTXfbJFHYELI8t+Hwbtm6c0PB3ZGq13k
        ueRBGm/ArMgff13r31EgIc1vVMDgf9RCBkFYP3ilYvozXoPoPA==
X-Google-Smtp-Source: ABdhPJzH72O+h6BQYg0oRfyKqALg0OVtCYS1DN1+6MFd0guYLG/PConUXyp/MMyEygUhrhKSZBXR9inp9kuXLa+xvGQ=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr9088311wmc.182.1598476526818;
 Wed, 26 Aug 2020 14:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <CAJCQCtQH3h=NNr6PX3HZp7SbkgqZtNNdihi4aBMFvx+DN79XeA@mail.gmail.com>
 <6LDov933WqF3kLH8jtkEh-pfK6pRe0o6-Y9l3NcO2mVhswDL7rhbHyda71OnztoJKfgqqQT9jj1Ba52lz_ugNFmmRtzN33BlSa5pCvds0F8=@protonmail.com>
 <CAJCQCtQDt=x7WCX7KhWz_pPn4yB1YdZm9jN29jRuQDFy=ZTOjA@mail.gmail.com>
 <emBWetDIaC_TYsBRNRlPcz-yLjIOxlhIBny_K9bTqHxLO_kdKRZlGjMoHrVj4CwZ8aZAnMcXEyCj95vBFBxxOvJ1AANQr1sbeQ_CfZOrTH0=@protonmail.com>
 <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
 <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com>
 <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
 <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
 <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
 <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com> <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com>
In-Reply-To: <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Aug 2020 15:14:42 -0600
Message-ID: <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrii Zymohliad <azymohliad@protonmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 3:08 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Aug 26, 2020 at 3:06 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > OK is the sysfs output from before or after the homectl resize? And it
> > matches with the second strace fallocate -l 300g ?
>
> Figured it out. The sysfs is the first strace before the resize.

Shoot. I confused myself and am not sure, so I need you to tell me
which strace that sysfs goes with, the 403g or 300g.


-- 
Chris Murphy
