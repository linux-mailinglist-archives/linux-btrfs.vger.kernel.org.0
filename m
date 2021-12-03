Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2896467C72
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbhLCR1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 12:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbhLCR1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 12:27:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21EAC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 09:23:58 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id f186so11382608ybg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQ3JbRUfMNSLx0dkHg1qpT7IZlR+73G5CGvCNDTBew8=;
        b=VftEAseOZm2G8vVIwL/BL8WPj6ArxtmupgFX5ntNw+RKSGxWki/U37pjGFKReeImW+
         fbcq4tOLJemrmVtMSHSVw6Aj6stHy/DThQ4jC/udSNEOAJDIdLxH4y4kfISoePFb6Ub7
         0OIgJqBwtcNGuGSHYdMfCsFYoGxPF5+zgjDgJkya6Rahp6klDSPGjQ/aEVXUbaJvu6qg
         PdVfpQOOfN34OSHz9/FhVVCOxWbDjCLUfhAgl7foF3XNmxabtajZReATqNQuCsW2z7zI
         8Ie0bEFTqR/NyOTGDYHK5AMQtWE8YuRY8IG6OsZi7mJqF2Y49rJHoNaRtuskhZLf+Mig
         CrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQ3JbRUfMNSLx0dkHg1qpT7IZlR+73G5CGvCNDTBew8=;
        b=HPOQ3IayZUFjdc5Y2RTcEYxVlnRaAhuqPP6ITtue096a+q5VQo7ll5Yb4e8TN49/px
         W7W9L0M/+0nbOjf6nbVbB8ouLP8Qx6onqfbk9E9gNljmmTFOzGmFq0MY/cA4f456ad/K
         rPcn5CReZ0vR1KWLnDrrxCYQWogdck/HMW+5lowgP8Hjbfo34EirxXNvxbueNWy8cVTL
         rlp+wAaHVNXE9ax1+uoCdvCgd1uZdTeS1laeqwJdHQNYyx0pkQJXPDD1raYCaHjR/Wfk
         GO0NZOGICmBBZELfLss/hZKXMLToeU/X159DT2XFdCu64avQOykILMRaDZdRSDTpVfb3
         bqdA==
X-Gm-Message-State: AOAM533di/RsIJUQ/qMBytmtOOuczjn6/S5lvsfpkujhzOWp7L74jxk/
        CZ9djC8YvBtIccLn8796Wd4yhsorfOxZtjYVwYkz5gtrRtfgS/gfz9w=
X-Google-Smtp-Source: ABdhPJxFdTbvn2MOsHE4rP9YMvye3fe08fY9rB+JYAKjyjBcizMXSiCavLyxRglM4PqAVBcKT5F13r1koya4QRSMN/Q=
X-Received: by 2002:a25:6c86:: with SMTP id h128mr23218461ybc.618.1638552238040;
 Fri, 03 Dec 2021 09:23:58 -0800 (PST)
MIME-Version: 1.0
References: <c5af7d3735e68237fbd49a2ae69a7e7f@wpkg.org> <PH0PR04MB7416465C59F5F339FA87AB839B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <93111e00ad2e42738d65d426f82ad17f@wpkg.org>
In-Reply-To: <93111e00ad2e42738d65d426f82ad17f@wpkg.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Dec 2021 12:23:41 -0500
Message-ID: <CAJCQCtROaF5cO=An5z2gxXCo8_87V1G0JQqdFCSspj3Bjfax1Q@mail.gmail.com>
Subject: Re: kworker/u32:5+btrfs-delalloc using 100% CPU
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I just did a Fedora Rawhide installation in a VM which has kernel
5.16.0-0.rc3.20211201git58e1100fdc59.25.fc36.x86_64

The installation depends on loop mounted squashfs image as the source,
and rsync as the copy mechanism. In top I see quite a few high CPU
btrfs-delalloc as well, more than expected. I'll redo the installation
and see if there were any deadlock warnings or anything like that, and
if not I'll grab sysrq+t during the heavier btrfs CPU usage.

The guest uses virtio drives; and the host uses NVMe.

--
Chris Murphy
