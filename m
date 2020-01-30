Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC20B14E46C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgA3VJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 16:09:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32975 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3VJo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 16:09:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so5979465wrq.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5n1hZ1Jvsku/UJ8K4eOv1YKLqiKbKWiNW2XMlpzggl8=;
        b=MUYCjzBYXMDHaFZi4132i61ItCoJzPxu5ZkuwQkBsccZjOC3LnjPl4Uca2epCAizAL
         6OruDsu2uucrLowTIl6x09zqtfcbztxTH8XDn9hf8njxHlU6nEmYpSnUqEjIdsZpB6tX
         6LckBtJfWt6Yvv3P0JaPIOfFsAK1ae+Ht8T4/VDD7bxQ/V9tG8YBNzR/Q9XeDPB9quNE
         Xz1lSszyNKt8tL49ORBbo2nkOEO/x/b4CPdpAMT1n9vxbczZM0d8D27dpOC+xznS4GW2
         qGe6Cusefclmga+eYbmHUzn6Fe3BC/3zOFsKafhc+W94BHFixR2aUxizhWTcQ1f5jKEj
         yXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5n1hZ1Jvsku/UJ8K4eOv1YKLqiKbKWiNW2XMlpzggl8=;
        b=lFAS+/uH5NUb/ms54vg+SAa7sB1t7uGOV8yuItqXz2MoYb6OLvln3rW3dVXCIBaluH
         uoYR9kmWp0nnEalBlgJeR1A1eWTjv9q5CDIj4kKDnK7SWrE0KiR/98vtgel1u8OhcpdS
         dy9U2wZ6cgKSqL1Ki4rPYzAxeL9IPP7C4DC71GY7qM3fs4eX500wcbN530RxKEwwbXSH
         1p+CQmqL2QOcrhlfFgxjlpX9xAgZxlHxxW3r/EVbGLEU9Kq3ssIvlGC4aZdXxpZowE7S
         T2Md9EgB1Fip4i3Jioi4g2lb/gK9GS7xIK7ikRumGTolZl7+YiMWqheyWV/dge54NYCb
         tyEQ==
X-Gm-Message-State: APjAAAXSSDn2y+wT2CIS8U6hEJ8YUytA1lKJNRXsZ9tPPy5mnOn7MupM
        ZezXIrY5GO8rwh2ewz4Y+eEp6+gCDopKfe/bP5j21Q==
X-Google-Smtp-Source: APXvYqzroQ3EFq+KLBJ/mWJUAGoj7+P0I3T+eM/V1q04hVBk46MNJ95n+zphsHcmq/cU7GXiF+pISgrf/Gi34oLV3mo=
X-Received: by 2002:adf:f308:: with SMTP id i8mr7622837wro.42.1580418581166;
 Thu, 30 Jan 2020 13:09:41 -0800 (PST)
MIME-Version: 1.0
References: <112911984.cFFYNXyRg4@merkaba> <10361507.xcyXs1b6NT@merkaba>
 <CAJCQCtQgqg2u78q2vZi=bEy+bkzX48M+vHXR00dsuNYWaxqRKg@mail.gmail.com>
 <21104414.nfYVoVUMY0@merkaba> <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
 <ab7f3087-7774-7660-1390-ba0d8e6d7010@toxicpanda.com>
In-Reply-To: <ab7f3087-7774-7660-1390-ba0d8e6d7010@toxicpanda.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jan 2020 14:09:25 -0700
Message-ID: <CAJCQCtRq5Q25sqW8wrfiYecnMg3Q+XjTuChdCU=cg9AwboVtCQ@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 1:59 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> The file system is fine, you don't need to balance or anything, this is purely a
> cosmetic bug.

It's not entirely cosmetic if a program uses statfs to check free
space and then errors when it finds none. Some people are running into
that.

https://lore.kernel.org/linux-btrfs/alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org/

I guess right now the most reliable work around is to revert to 5.3.18.


-- 
Chris Murphy
