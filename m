Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB6E5E10
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJZQb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 12:31:27 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41446 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJZQb1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 12:31:27 -0400
Received: by mail-ed1-f42.google.com with SMTP id a21so4344505edj.8
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2019 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjPL86eKvnsxnYoW2xBgBD96TVWmmG0VYt3MXsuI0H4=;
        b=Q0d9LVv1md3paoH81QnTTYByMklXsYlzs7hlMOa9d4WTvdK7VV8zbeENFLwOGvD4rD
         3+nNTWO97eTVUv39SxG3rP2f+QP2LbLsJIQijPIvYNQWeYgPVA61BDejeZ7N9Ya5OYdi
         QvysMaNo4QebV5TKHOWe/hHULJX0GHLvOxDjMqXpOS5ti4TQ4YnLQnrWP51w4zLKQPc2
         J1ZN6cOREcnl7clu3rve6YWFXqa3iwK2p/IzhvH2FKlPQ6+xjysLu5oA9aoxHa9GLzzQ
         Z4s4dR7AX/A3y+pZ7eoGmpcywy8MYlFDjPJ62VObkieFGICvy5PjIhUoIH8JH/9cmlSZ
         V8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjPL86eKvnsxnYoW2xBgBD96TVWmmG0VYt3MXsuI0H4=;
        b=SsvPPcrCKsie63GxNtb7t/Ee5DPtfSBIErQDUqE0FAsOdTw10ZmAfPswZ/33HmS9/E
         HFEVG76ESUDyEGiJPAW4R97UaYBvqOglehivslAO0zlHwkzUMrf2uXl31i5+5IIw7879
         Q8xmpz8OnATG1og2bbTEiKoHlh/pMznVLOi7eMS/j6fkdqcupvrimSTQ3iZY87tsoSiM
         DxIqu5pJsS3x3Mx4S7SsGODC5hhXSAAMq3IzWjGdT7F3apqpDlqGLAY30Ocxd3QaZrpY
         uDYa95WF12BrPgZsgkhGVscYLOir21KM4L1JbTXaFX0PSrFnmUv7//ZMaA4XoDS99YBh
         YNSA==
X-Gm-Message-State: APjAAAVU57yLUKl6dAIynpqM4C7ORQLoaSp1LOmvES/e2opYD3u6Dyqg
        CFi1QpW67Ha8veLCQQZNj77veiRmII5seuJW6w==
X-Google-Smtp-Source: APXvYqxK+Zz0g0BJZqfhKzkmNIIwsyinq+5G2awrHI6Tex8PVJ3AurnvIL+Q2xnBepe+a3OrGKBpPR3JSxXsG0BxQeY=
X-Received: by 2002:aa7:de03:: with SMTP id h3mr1808795edv.275.1572107485531;
 Sat, 26 Oct 2019 09:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com> <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com> <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com> <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com> <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com> <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com> <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
 <4a329da3-81ba-3240-8d76-6509dbe2983a@gmx.com> <CAKbQEqGOJjNAFMitAU=coVboaat9pi5b-6DxFg4SOON+6bfJ0g@mail.gmail.com>
 <0d48803b-b8f0-2ab7-dade-d92067b91202@gmx.com>
In-Reply-To: <0d48803b-b8f0-2ab7-dade-d92067b91202@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sat, 26 Oct 2019 18:30:49 +0200
Message-ID: <CAKbQEqFccH9=WsGy23CcCu-KSVWYrwffF6faRADH3oauJhgkdA@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Sa., 26. Okt. 2019 um 16:07 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> Mind to share the csum error log?

Certainly. That is, you're welcome to it, if you tell me how to
generate such a thing. Is there an elegant way to walk the entire
filesystem, trigger csum calculations for everything and generate a
log? Something like a poor man's read-only scrub?

> I'll fix the bug and update the patchset.
> (Maybe also make btrfs falls back to skipbg by default)

I appreciate it.

Cheers,
C.
