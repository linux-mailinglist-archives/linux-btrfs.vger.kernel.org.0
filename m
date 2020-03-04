Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0117999E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 21:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCDUP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 15:15:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDUP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 15:15:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so4105041wrr.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sczAFzvorqWkbbfMdM6cuyPT4Q8mQ3/cr/Xrm9RLhRA=;
        b=aW7saE3UDYHNY/S52YHy9ocze8mRn00P31ACbiW3Fzyf4j60wLQhOe43PLXn4RHuPn
         6QFSGbyvkDirRKsy1Yc2qLu+JYrZSCYCNXNIyUp51eVVJnYFZUF6s4tyhB8gr6KWoTUd
         chE1XDuw5P1+sxzVlgZt0ubd6mTbndxhViPpaYk3hAzMlDmSYNCHbl+sI+a6g4TEq2Px
         j/6eOX0hrODXaVAQe3N9xx5NinZLn183cerx/ThzMaA6oHp2sfF/MY0p7+kNy+cKpXrq
         qK+ma7jI8tJDhJrZDI6bzIsUHaEruGqFJojjW+pf0vfjb9IGpLkF6NIhVL4gUWa3BBwn
         m4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sczAFzvorqWkbbfMdM6cuyPT4Q8mQ3/cr/Xrm9RLhRA=;
        b=FwGfD1WdfLG3tJAMA1iJAkARu0b6mJz+g/nv2gyGzsmpKX9UDPuk5WS+5BBR3dYL/J
         veQ/lldiQCK5nG4+zkXQGrGtcF0re3Ahw7geoJ3c9Eizhlo9VPUk1gJoqIAGPJrUxifj
         EU2N+09KsgOB7dbnXCmgYVuCdaL25XLye8utdVS1FDr3tyf10UXvUppIMup5rwbMXnmf
         KeOawcCg2E7JiWJg7Fiztyery1q1Evm47F1Vd1rFZMrxZ/gZ4XwEiBck/p2OhPYwO4zC
         fz3py/tL/bU2LkcuTpwksI7AjaHoAWcbUWW5B2wrZq1QRuG5sKZBkHKMa2dLlP+1GMYI
         rktw==
X-Gm-Message-State: ANhLgQ0aiMspT4Occp013VhjegdURhgQXSdLNSWODd38V4jm9YzXvGqx
        wt7df2HW7Uz31Lf4AG8NUrQdsm8k+hROhzOGP6jMGg==
X-Google-Smtp-Source: ADFU+vuk50Aga6E40/av+Hx3eR+9Ohm5EcQZVkzyjOZwU0B4jACpSRzILMQ9hZbrsHgNKq9E1oy/fB3aIWpRzTYKq7k=
X-Received: by 2002:a5d:5043:: with SMTP id h3mr686218wrt.274.1583352926197;
 Wed, 04 Mar 2020 12:15:26 -0800 (PST)
MIME-Version: 1.0
References: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
In-Reply-To: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Mar 2020 13:15:10 -0700
Message-ID: <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
Subject: Re: problem with newer kernels
To:     Arun Persaud <apersaud@lbl.gov>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 4, 2020 at 12:30 PM Arun Persaud <apersaud@lbl.gov> wrote:
>
> Hi
>
> I use btrfs for a partition (/dev/sda2) and when I try to boot with a
> newer kernel (on openSUSE tumbleweed), the system doesn't finish the
> boot and goes into an emergency console and I get the following error
> (don't have a log at the moment, but can produce one if needed):
>
> BTRFS critical, corrupt leaf...

Complete dmesg is needed, thanks.


> However, if I boot with an older kernel (5.1.10), everything works OK.

Sounds like it's hitting the tree checker which is much more
sophisticated in kernel 5.5 than 5.1, so the problem is still there
it's just that 5.1 doesn't complain. What is the kernel history of the
file system? Was kernel 5.2.0 through 5.2.14 used?

> this was with btrfs-progs 5.4.1
>
> both didn't find any error or repaired anything, so they suggested to
> email the list.

That's unexpected. What about:

btrfs check --mode=lowmem /dev/


-- 
Chris Murphy
