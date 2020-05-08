Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3A1CA10D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 04:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHCs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 22:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHCs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 22:48:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BBC05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 19:48:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m12so3788785wmc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 19:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP+1TMxHGuNAb/fzCHJvH41HRxk0SnuQetQmawiWZ80=;
        b=Q2N79aN7IWr6zl9irZGxYkRt7dIAfMCRJCi9u5dFvg1AyZjVs22b7ZJSAzmPL+s0IT
         VTHeGl6Xrdeu0bIR8jnNloztuVUVY3tS/v2g8mg8QVUFxorW1KZZdPGjkVPtGSa5b+GR
         vpS8U/VD4JPvG71EFgN+IQAEMEQQ8pfA23g3apr2z1vNCHlZ50uuSXlCd/JOXZPirDiL
         R4ZaCQKQTYKutnugXHD9285Eet6blrUy0WRfuB5C7eI7jrfrKTCtUwQDPrOlkyAioCmO
         Lx+KjByelFKMRi7vVccUpVJdCLHE2ud49A8yMDE8e0Qvdd/P1nBhKbL0fVwgf4D5w6Mp
         oJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP+1TMxHGuNAb/fzCHJvH41HRxk0SnuQetQmawiWZ80=;
        b=ANVu4emJwORcGyDk3AuyzulQpU4mb7EYwd+KAflPJaisY2IcAKI05mgS5F+8PFVwSo
         kcfeFpBEj83zL5vArpiF5jNFB3NFqf9Nm2iijCQExjFdXNvvDc2nXWCnQ7BBXan6rWH+
         IFYELtQ8yRRAK7nv/fUhC0hdRxgTTEvPgI+qBpS1NN8EMpdhS/KGvpO1Unw0lYyboX5J
         ZSCNzH+GUvj+EjQmI1i1UtkFiwpDtw91LgcQsuOpiWMmeJIA1xkOIIaG/f2wGDrkstFm
         vMZF3AVvQHR4LfxVU7En/WefOEBbNVdRDP6QGh1/MhskeS/20mJ2T2Mb+d22AATkQBSG
         49+g==
X-Gm-Message-State: AGi0PuYD86k+sacLHiRr0yLyB1aNIXlobfKGaBO9bm5SoCoTB7a+JObJ
        qFwaJzTyy77ljHzVySKL/aKk2ICva85ijNNCxQ031N14oTlzWg==
X-Google-Smtp-Source: APiQypLAhsigdYdZNWtxbvWIx0Mzj3XeheEIFUxWJQ3RERvV/sBlVG9TVOe3zkO5xEvmh9G9962RDnGj6oxB9B6CXoI=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr13760716wmc.11.1588906107316;
 Thu, 07 May 2020 19:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au>
In-Reply-To: <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 7 May 2020 20:48:11 -0600
Message-ID: <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 7, 2020 at 8:32 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 8/5/20 12:26 pm, Chris Murphy wrote:
> >> One thing that might be relevant:  On the original scrub, I started it
> >> on the mountpoint but initially cancelled and resumed it on the device
> >> /dev/sda rather than the mountpoint.  Could that trigger a bug?
> >
> > Maybe. Try it and see.
>
> I just want to get a scrub to complete normally first.  So far it's not
> making a lot of progress.  More visibility into the process might be
> helpful.

>Rate:             112.16MiB/s
>Rate:             111.88MiB/s

These are hard drives? Those are reasonable rates. It's typical for
drives to differ ~50% from outer most to inner most tracks. Depending
on the chunk layout and progress, the rate may vary, including between
drives.

-- 
Chris Murphy
