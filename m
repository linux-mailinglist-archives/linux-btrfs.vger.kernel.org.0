Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED9415392D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 20:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBETi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 14:38:27 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35924 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBETi1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 14:38:27 -0500
Received: by mail-wr1-f52.google.com with SMTP id z3so4250815wru.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 11:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+G2KuQmbXVnl8TZg3wA1JEWpsZjrZWk2yI4FM02QCGY=;
        b=p6I2zPID0KhiXXv4GYtqVOK7AkE36LbKJOrQ7t2ZQofJ4t3yDtKhuE8JzGaxwBF2Ho
         47ZWxC0Kco/bRXb9vWcOTfH5sbZ3TLFRWSOvsZX8eh2sEolsMHiSCQn5peXfUHeoM/NA
         7rBHAKKouEW5CWruDeS/t72lnp1n6hr+1E8wpyDqjBi0VVV2b/qpuXtJar2qCVvSCLw2
         2FqAP5+YprFoi1DlHgHbCcLZMNACoFn2qI+JkwsgM5G9nulmsdoXX6qZ/shuWX8njnyT
         lEUOloShnmOua+TcuxhoWErrYB5v6ewr+Ey8Wl31HUBcCtO+Tw12RZiwAR5wSxWukcAO
         FSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+G2KuQmbXVnl8TZg3wA1JEWpsZjrZWk2yI4FM02QCGY=;
        b=e6Lhga/ThHeIOGultHj4pggmlu0YptJKb2rlC1uGliwcFSJZVH6TOzc4ps2JiXQpDg
         O82FxpBk6CHBfx+VHBzUt54u5JzI4n+2O+K0qj8B9ro0rIVuvDyLxFHtsRcIb+HmW5Ic
         p/NJvUef5JvAL9JsEizdL2nHBNpP5NtpTlp+tRkTghQRgHNDw7SsGrgXSr8FUvZDFt/n
         YtpC+3Kzue5G30Y1dG9e6JmEmn93C5Y0fWsNApPYd6M8iS6jSBtWcdmTm5lY2/sNRg9q
         MKA86ai3JUpF56LXCBzp9l1P//DMwzniLwIALRbyx0Gov4GmYQ6ZKxs+i4pkBaoiH87z
         yvjA==
X-Gm-Message-State: APjAAAVbibxYQBQyeiRTFcGYykEtUb49n9NwjYJ4vhnYeCIJofT9vS/C
        nnjkGsquzB49V78ZNUnu36g6cHgPJxkCQyj01CU/pQ==
X-Google-Smtp-Source: APXvYqzk/KH1qzbRTrfeQwkN5Z4mcxU61eOZXaQQUk6cw7hQJzD0kKQN98CUKlV3ABoKLmNL+lskxbWcSo6uKIvkcf0=
X-Received: by 2002:adf:ab14:: with SMTP id q20mr87580wrc.274.1580931505228;
 Wed, 05 Feb 2020 11:38:25 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKE6m=n1JTfFqBy33D9n1WFTjuuyQ_q+X=jF7+tNCYsLfg@mail.gmail.com>
In-Reply-To: <CAEOGEKE6m=n1JTfFqBy33D9n1WFTjuuyQ_q+X=jF7+tNCYsLfg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 5 Feb 2020 12:38:08 -0700
Message-ID: <CAJCQCtRWvdhowyu9s-nA40bdEdUYGGh8P07B9QqFdGySDGAOdQ@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 5, 2020 at 8:29 AM Chiung-Ming Huang <photon3108@gmail.com> wrote:
>
> server ~$ mount -o subvol=@defaults,degraded,nossd,subvol /dev/bcache4

Is this file system always mounted with the degraded mount option?
It's in /etc/fstab?


-- 
Chris Murphy
