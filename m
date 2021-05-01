Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51437092D
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhEAWRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 18:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEAWRH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 18:17:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B82C06174A
        for <linux-btrfs@vger.kernel.org>; Sat,  1 May 2021 15:16:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j7so1057556pgi.3
        for <linux-btrfs@vger.kernel.org>; Sat, 01 May 2021 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FC5H6hpD83z677fcJM/42XqAF8RDtIWPuMyopdMO9NM=;
        b=RmcKrhJMp3eC2H2KNg+Cz7R+TaWEh/M1CWgXk3sZtwTR3f9EAmqGSKsa44xJIj3KCO
         YlL0SNY2sm2DtJevtz7GgspZDUn1Qhhi4J1jSKWSKb+Q/byGmsjUwDtHABGutdJ2wutS
         Ppc0D9/e+d6FxXbRO0HEfDW9Nfa3pVACTYWD2aDYmFb6WM4ztnra5a8Ci5f0YWEYrpud
         WA/x/RKZ8pxzejqmqAYBmgLDc8l+9K4R8WiZGr5i/rqoHiTh9i39bzVVWFNKi7kFHaO/
         4flESPtIY1PM6eTBFCLHZKqdsY73NqvHj65GZPFzFnMzf8URZvZ2m1ZGrmQoh60aB+aC
         f7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FC5H6hpD83z677fcJM/42XqAF8RDtIWPuMyopdMO9NM=;
        b=QcGL8vVu6vDw1ps8nUzgKtnY5DmkszRp2DEplIHjdBiycnY2xI4l+ITJJdLWviuha8
         S6KBkgO9r0p7MpsZbPVAioU8rCUTd2gbVSMgDkCTdY6AQWJZ0qEmngyVd9Ugvsqawn+t
         jdn7O5jGLra9wR3pwCehLyzbwusSec8Xcgbej5EAnd0se3yzlheWnw3n3voJhmvnJgi7
         zDnC6UV/Ozsxln3Sqjs6JUXRswRbQRADqzvsBoxCdIF52BSP9dLSkfiuQzFL2QtA/I7S
         VHh1sJYpoVink+adqILSnmSXjgyOghtfv5cWXm613WIanMXwKpQncN4/oA2UaiLqGlnt
         EIxg==
X-Gm-Message-State: AOAM531PAPTrCUDUcYnMQc7z05TeO2tDGiAjIaWtq19knQgSeWMieTrb
        znPgspWVNjOqj5r8etLoPTg1moNO+Zg09ybNFENgV6/h0sZ/fw==
X-Google-Smtp-Source: ABdhPJw1BN+6hy8hw8esIlMLxLzbFiQdUCQK1AaKZrUpuKeGTnIwxjKUiSYIgXvprtm8x8+pWQ2bcpPQby93SlHTZ/Q=
X-Received: by 2002:a63:5a50:: with SMTP id k16mr10970522pgm.185.1619907376781;
 Sat, 01 May 2021 15:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
In-Reply-To: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
From:   Yan Li <elliot.li.tech@gmail.com>
Date:   Sat, 1 May 2021 15:16:06 -0700
Message-ID: <CALc-jWwGKFeFcsoMGeEO2tRG1cTi2-3_YO7K-cqVk74Ycg06+Q@mail.gmail.com>
Subject: Re: "btrfs replace" ERROR: checking status of targetdev
To:     linux-btrfs@vger.kernel.org
Cc:     Yan Li <elliot.li.tech@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 1, 2021 at 2:39 PM Yan Li <elliot.li.tech@gmail.com> wrote:
> $ sudo btrfs replace start -r 3 /dev/mapper/open_offsite_bak5 /mnt/offsite_bak/
> ERROR: checking status of dm-13: No such file or directory

If I run the above command in the /dev directory, it would segfault
instead of reporting the error. Now this looks like a bug in the
`btrfs' program. Guess I'll have to compile the latest source code and
try.

-- 
Yan
