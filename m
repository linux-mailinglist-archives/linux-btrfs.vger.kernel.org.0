Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6924B5F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 12:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgHTKaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 06:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgHTKaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 06:30:01 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F3C061757;
        Thu, 20 Aug 2020 03:30:00 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y8so780908vsq.8;
        Thu, 20 Aug 2020 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Qg3A9azXTYzEStqTHLXceDz2W+fZzhg+lzeoaL+mzUE=;
        b=VG8wvQxSkd1NSEH/je3qFzZetY9vSIS6KPnVSrq+SsZkDB4kag2fMFyWhdE6Qhctyk
         oaIcW7XSb4rioU+Rh90HxsfVELb1N0z6hR/JQAYq74wzfzYjI7VJi1qVg+rjcU1/18UB
         Ux343pXSYpPw317W50CvxGhou99xMN7IXNi7+yTftlv5hyaduEBv3oEoj+udGpKT4dOh
         JuIAxUtfj87CWsxQAjDaSJRejYqf6qMK8E48+zuB14K7KDIqV9ARAknEADyKgAsCi7Gx
         dmw5YkgLAKpKHhvoq8Y2SEMXEGZlY8FjAbYZ3w85vKwKaXxvMxlkLZoDUiIuQFu5wfxk
         Tf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Qg3A9azXTYzEStqTHLXceDz2W+fZzhg+lzeoaL+mzUE=;
        b=nU+zkHxr0LstKOTobGaZEEU+yqEDQyxM4KoqpKCR8bvppZCpajxsm9lEs7F4jEqQN8
         NFLWxkgsEqGQwSz5Hlkq0fm/JwuCYO8d/WIMfHSSukzkts//ORaSoMugc3+H3XvI0HLY
         00LtMQZtkR2FH5z/KAQqBAsbzNY0BIqzln9Z8ehDok2lbDiNZPvn0YvoMbnYZT7bWQt1
         2QUzgWz8n5Uz3ZFk15VItFU4i+LCaydNM9Ns2lorV9ixUvrw/ZnF/6s/jUBWlEa7ciEF
         0WzyXlU3jfj110xVUB8jCf7bfH0HbpjKhx8iYucLkEt9c7AGdjr1pYpnA72nyJjcK14r
         1/sQ==
X-Gm-Message-State: AOAM530tHVDnE7kM6zJ1bHZgcQrZLn5W0EGN3AyBg5Tk5X1XPKuTDhwP
        +SN4p5MVvNLGwnefE5zGSlh4NNArBdjs2Yv5cmwAus7T
X-Google-Smtp-Source: ABdhPJw3aRKMS1R2Rgo/jVmXbsZHeEdN1ZUkKrDloTVWHXVB/BMKu9WoNblhv0u1Y0ODuvbH9eFFLOV0Yj7yPzoENcA=
X-Received: by 2002:a67:3015:: with SMTP id w21mr1195760vsw.99.1597919400028;
 Thu, 20 Aug 2020 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200820093006.26458-1-nborisov@suse.com>
In-Reply-To: <20200820093006.26458-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 20 Aug 2020 11:29:49 +0100
Message-ID: <CAL3q7H435F+SvLjxVGFTpV7gLtb1X_bB_+Tu4eOwOwUUrErvNw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/205: Ignore output of chattr command
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 20, 2020 at 10:32 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> With newer kernels, containing upstream commit f37c563bab42 ("btrfs:
> add missing check for nocow and compression inode flags") chattr would
> produce an error :
>
>   /usr/bin/chattr: Invalid argument while setting flags on /media/scratch=
/foo1
>
> That's due to the aforementioned commit making the checks stricter. This
> is not critical for the purpose of the test so it can be safely
> ignored.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/205 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/205 b/tests/btrfs/205
> index 66355678f7d2..ab4261488ebe 100755
> --- a/tests/btrfs/205
> +++ b/tests/btrfs/205
> @@ -48,7 +48,7 @@ run_tests()
>      # extent. It has a file size of 128K.
>      echo "Creating file foo1"
>      touch $SCRATCH_MNT/foo1
> -    $CHATTR_PROG +c $SCRATCH_MNT/foo1
> +    $CHATTR_PROG +c $SCRATCH_MNT/foo1 > /dev/null 2>&1
>      $XFS_IO_PROG -c "pwrite -S 0xab 0 4K" \
>                  -c "fsync" \
>                  -c "pwrite -S 0xab 4K 124K" \
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
