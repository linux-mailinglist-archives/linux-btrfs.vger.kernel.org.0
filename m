Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1DF2EAA09
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbhAELhl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 06:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbhAELhl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jan 2021 06:37:41 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D16C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jan 2021 03:37:00 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e7so24581993ile.7
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jan 2021 03:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IE7RXtqv3etjnunXBxFvX7qVFCp1hEGvjybD8xdEFhQ=;
        b=ND7ipgjQfNmEz/mWzDwlu1ZDvUi9gN5tkiNSzEF9WteWmyvSddtD8VeoQHn3i7vN8x
         Q53Hu2SBEDoBWQhNcwKhv2eJi/YhY+ARHQihSMsBLWEuTt25PMXIbJ0EwstT8h+psY1P
         2UWAk6konlUspMUNl5ANHaWK5YtAZhaNsXqlzgcO7zq7+1pc3J5raKFmMFBC6Sz8x7dm
         /hgFO4WHAC9eyv9N9KiILzk+M1QaNq2DbYoGN+hxyAyb7mIfD3wYqgxsl2umT3qejdqE
         FHGdV/csg7SKYc4lQCr9YRRoI4t9eUHRj+5iujuNZgjZ9vTrrw01WKsRCzX14+AjY0a6
         O9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IE7RXtqv3etjnunXBxFvX7qVFCp1hEGvjybD8xdEFhQ=;
        b=NyDsCtsrlfZaxI/xM/4uTYtlnYsYwfQamrU1iJgV89kmJzbKIa5iMpvl6dkI/0WANA
         pm18AXTJfU9X8iLkISpPAeyIMxm346+TRdYkbPqlbsEUBVzCa/WsbqSO/N0lOSPp4tnM
         ZdtNu11tBBx9sQRcqGA5eVeOW0mvFUIDh0k0MkDrBwnic5SSBodAAR5VDEIBtkSzRV+a
         Zu2SQ5M4EVGkhiEFlhTL/T9uzrETY7+Kgj1hVkloiOXbr+gHV7dVC16GNzVLnSY4hEUN
         4UAG62ZOogQ6lYpaqLdv68hhkOaSnzb2W0INbpAHl8I0V0evapVIHUAep/J3W8Dl8nOt
         1gWw==
X-Gm-Message-State: AOAM5337Jwn+hCWTW8VLyhzxtRgaTQ49s1GFzv/Xn//g4sAdIXpgAMyx
        ejdhRwtwei7bNCJChSit23oEdmrvqZlXcZcRGW8Ca7Th8Dw=
X-Google-Smtp-Source: ABdhPJy5/DeVFVyabX6/DNHRox4eqbjvVvcP70dQzvRl5FRG+B4YRfwONZVesW+TzvjVvyDLyHQsPzRfwdhZRL4TaXY=
X-Received: by 2002:a92:c0cc:: with SMTP id t12mr73602022ilf.299.1609846620006;
 Tue, 05 Jan 2021 03:37:00 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXtjtNHCjgYwFR+urPdyvYnpBd7p1V8hvh3h5SyDtnTg1Q@mail.gmail.com>
 <CAJCQCtToocNb3WOqPLAv-HLDvbPeGR6A2AcCb3XA7u0jkCwOyQ@mail.gmail.com>
 <CAMaziXs8mVgBtJFNoOCzEAn8Gu56fSQKbOQta2Vy8-kt8e-oBw@mail.gmail.com>
 <CAJCQCtQ304GibZLANvTM_rQPcvSSJymZ=BbxpiFsO1oMmWvpSg@mail.gmail.com>
 <CAMaziXstF89D=KMDDPd7qYyKjV-ire6zNwMuz2F=wm6SSWg+jQ@mail.gmail.com>
 <CAJCQCtRA6G4QEEeRZpe88W11mhezNwQmhvJrE2-EweTfsz=GNg@mail.gmail.com>
 <CAJCQCtSWogp2pMTar-DQUuf7p-PUC2ymOkiwg-sYsP=UCvSzcg@mail.gmail.com> <CAJCQCtQm6DT_38L3ntH297Rgg7pLxNp30p==jH9ZBOu22+BQJA@mail.gmail.com>
In-Reply-To: <CAJCQCtQm6DT_38L3ntH297Rgg7pLxNp30p==jH9ZBOu22+BQJA@mail.gmail.com>
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Tue, 5 Jan 2021 17:06:48 +0530
Message-ID: <CAMaziXt8QsNv4C7MFmMvxwjVR4TsDJ86UY5gPmppjNa0Baq-Jg@mail.gmail.com>
Subject: Re: BTRFS partition corrupted after deleting files in /home
To:     Chris Murphy <lists@colorremedies.com>,
        linux-btrfs@vger.kernel.org,
        Community support for Fedora users 
        <users@lists.fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 5, 2021 at 5:27 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> New new plan, ngompa built it for us in Fedora copr.
>
> sudo dnf install
> https://download.copr.fedorainfracloud.org/results/ngompa/btrfsprogs-robustimg/fedora-33-x86_64/01858610-btrfs-progs/btrfs-progs-5.9+git20210104.5fa05dd-0.fc33.1.x86_64.rpm
>
> That will replace your btrfs-progs with josef's special repo with the
> better -w. Later, you can revert back to the original:
>
> sudo dnf install
> https://kojipkgs.fedoraproject.org//packages/btrfs-progs/5.9/1.fc33/x86_64/btrfs-progs-5.9-1.fc33.x86_64.rpm
>
> But there's no urgency to revert, it's the same thing just with this
> btrfs-image enhancement.
>

It worked. Installing the COPR build worked without any problems.

But I did get this on the console:

parent transid verify failed on 55640064 wanted 44146 found 44438
parent transid verify failed on 55640064 wanted 44146 found 44438
parent transid verify failed on 55640064 wanted 44146 found 44438
Ignoring transid failure

You can find the metadata image over here:
https://drive.google.com/file/d/1MIwwtKvt8zQxrMomhvtBZXx_0au2-Pw6/view?usp=sharing

The file is over 300 MB, and compressed with GZIP. Let me know if you
are unable to download it.

No file names are obfuscated, I did not use the -s option, so
hopefully that should help you.

Let me know what's next.

PS: I have messaged you on IRC #fedora.
-- 
Regards,
Sreyan Chakravarty
