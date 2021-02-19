Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9B631FB99
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 16:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBSPC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 10:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhBSPCy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 10:02:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197FC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 07:02:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so3499924plh.8
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=pGDui+8cdPEblUjYv4h4891jiAT3mT4/1fVM+J7NwIQ=;
        b=AUU6uZV0Bg1/FOkPbn2ctS7gxsHSqCnRJ2/El5YiIA+4QJUsc0D2DPUjTYJzQNDkaP
         DOnpMGuklm+B4tkYKbE8eadxsjxkTY6vEPb0VB3KetylpTVhWOcpSCgvsnhodSqSXzsq
         B5QJm4BFeyaK5ZTl2BS5cWPCOdaigyFVeZyUK0vjA/9NyTEcBD4myJjlYVjjFl/chFKU
         kIfPxHsCigF5zKkOsAnirmWbnftKqAMekNQCzIJFc5WI32lMtP/2u+lTiNzHKoSIqP5v
         AyswNEbMlQKMuWflW3u9VWCTvLW3QY37LnpS8I806S9b9wUMKeefRzAG9uI1q5rnIKB9
         NYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pGDui+8cdPEblUjYv4h4891jiAT3mT4/1fVM+J7NwIQ=;
        b=LMwUd/LpHa0UcagoDO58nQ0zuBfRgZKG6klZIhUviz5VsL6MCcyC6+v7wQ7Pnh3CUJ
         LflipXtLa1Fy+QANLk4en2yMtOQr5brk089T/m8c4XnsZQdeb6XoPpVaymTqHLZz5VFB
         YNIcHUwhYgZqB7/77DMJ2zhrRkK5GeZ0iNGVrcvDfKttivri4TX+7ywRJsPGhVC34v37
         +HPJZ1dBwL9eon9i7ZjuPvyrMqRVm96Wy0XGZBeua5HERxBjt8l4kEv733ao2m8TeeOK
         7IGLYVhLp5WNR7UCNAgOPi5Nond0kIh17sS8wVx55HbDEoToVodMrxZaOX0kq0d0J+3Z
         zxTQ==
X-Gm-Message-State: AOAM530QaErJpphfX97q3x6mFiqSM8YHOjSHxsvizOnhMLUMudltyZaj
        JM7J3dJlycKX1FY1ENYHUFpKQ+HLEDw=
X-Google-Smtp-Source: ABdhPJySpShKMfh+6Pz/m7TBaZ8bcREMyQm+FleWRj50epX1pfY9QmiXjznsp264zW9emq96Lhj+QQ==
X-Received: by 2002:a17:90a:5a0e:: with SMTP id b14mr533929pjd.165.1613746929709;
        Fri, 19 Feb 2021 07:02:09 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f30:4900:7285:c2ff:fe89:df61])
        by smtp.gmail.com with ESMTPSA id fw18sm3540515pjb.46.2021.02.19.07.02.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:02:09 -0800 (PST)
Received: from localhost.local ([::1] helo=ddawson.local)
        by ddawson.local with esmtp (Exim 4.94)
        (envelope-from <danielcdawson@gmail.com>)
        id 1lD7IF-0005Il-Ew
        for linux-btrfs@vger.kernel.org; Fri, 19 Feb 2021 07:02:07 -0800
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
 <CAJCQCtQGyHJjPwmKxwxCBptfeb0jgdgyEXF=qvGf-1HBDvX1=w@mail.gmail.com>
 <80058635-0bd9-05cc-2f5e-b4986a065be3@gmail.com>
 <CAJCQCtTCKSC46kNaoENdEpCNTxB1_MeD6PHwbmtRnJdbGWBswA@mail.gmail.com>
From:   Daniel Dawson <danielcdawson@gmail.com>
Subject: Re: corrupt leaf, unexpected item end, unmountable
Message-ID: <222cbf70-b1e0-c290-fa0c-f0a7cf6495f0@gmail.com>
Date:   Fri, 19 Feb 2021 07:02:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTCKSC46kNaoENdEpCNTxB1_MeD6PHwbmtRnJdbGWBswA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/21 9:03 PM, Chris Murphy wrote:
> Once everything else is figured out, you should consider converting
> metadata to raid1c3.

Got it.

> The new replacement is devid 0 during the replacement. The drive being
> replaced keeps its devid until the end, and then there's a switch,
> that device is removed, and the signature on the old drive is wiped.
> Sooo.... something is still wrong with the above because there's no
> devid 3, there's kernel and btrfs check messages saying devid 3 is
> missing.
>
> It doesn't seem likely that /dev/sdc3 is devid 3 because it can't be
> both missing and be the mounted dev node.

It seems I was unclear. I removed the old drive prior to the
replacement, hence degraded mode.

A while ago, I imaged the drives, to see what I could do without risk
(on another machine). Turns out I was able to mount the filesystem using
-o ro,nologreplay,degraded and copy almost all files. A small number
were unreadable/un-stat-able. Fortunately nothing critical, though the
OS may well be unusable.

(Also, in case you were wondering, memory testing has revealed no errors
so far.)

> If a tree log is damaged and prevents mount then, you need to make a
> calculation. You can try to mount with ro,nologreplay and freshen
> backups for anything you'd rather not lose - just in case things get
> worse. And then you can zero the log and see if that'll let you
> normally mount the device (i.e. rw and not degraded). But some of it
> will depend on what's wrong.

That doesn't work. It gives the same errors as when I tried to run
check, but repeated once each for extent tree and device tree. It just
can't get past this problem.

At this point, I think it's best to just reinstall with a fresh
filesystem, and not make the same mistakes. Thanks for the help, once aga=
in.

