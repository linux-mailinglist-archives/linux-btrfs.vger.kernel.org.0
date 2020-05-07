Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546581C815A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 07:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGFK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 01:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgEGFK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 01:10:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A3BC061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 22:10:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z6so5183926wml.2
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 22:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zgGCCJH925u7DjK29pIfLT+i1PX/2eNPLqNdpo3ER4=;
        b=D4G0emR0kbxLBfTelubOuLPZVZgnC0YOoAlYt1S3AZCSy69VlbCWiYtepmz6CMoZAh
         29qX/kuEcHB0WcPeWebSuig2G23beWarUcT/iI9s7GQ4Dd+yl1KyY+6w2hXdEacvVqm/
         vaBc9jelyJZjrxBnNc0WqBbtdtzKzNk5LlT82WgfigWCQX8EHa1U7Gx+Gz4UoZPe98oX
         H9Fa+MlBN+NsVE8uRNpXzQoQkY4B31Dgpk4yAAdCF1ocJlsZMHtdTeEz5hnZkbk8V4RN
         w45YZPFCYtpNVi1lgxpNOoDZdrXaSRZI5qOrZSYEiVPDXBMnuzWOhEF9LgnHXmgLwdXc
         IQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zgGCCJH925u7DjK29pIfLT+i1PX/2eNPLqNdpo3ER4=;
        b=j7oPaPH+FTNGCbtfYG0FkCO1s1aZZDBPeh5AU7T+6pD5OgOs9CfYqV31Qv4951siZ1
         gjSi8khg8nxsFUS1/xN5Zrnl46Z88uNy7fYuKtMNobYnlQornSVZ1TmT0DaIRMfxNyUn
         RMxeKeVT+Wki/3k0f6IRItpr+JLnQ8bzNQw+UcZ23/kdsaPOA+4zsi69SO4kt0bll/2D
         KiXaIucKzO0Hw6RVtnEVTlO6raBv6C70rtF0GgwUBdw5Zv9MCXeV/Lk7VieiE7jDgj5v
         UmfalHjCaJlbYikaCtB5KUsYWdWvDP1brV1UplgBvofVTsiqr9Isei6bVvQCISawgmkk
         Fm9w==
X-Gm-Message-State: AGi0PuYy7OroG9gGPgQG4y5IUZKi4XF1wV/PKkO6QfU3604R8JvinmmL
        uU/k1rdWoVhnV7AtXjSzhAQvUDbOVHobv90RD1B9AWs1VVw=
X-Google-Smtp-Source: APiQypLgzxvFgr4ywlWnDaycMVILzqJ8SWjeGDY1lAy4AOU1jiKOjtghoZXzRquXeI+pwZ6l+WpygsIgZT3DMVPiCt8=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr7873131wmy.168.1588828223016;
 Wed, 06 May 2020 22:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com> <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au>
In-Reply-To: <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 May 2020 23:10:06 -0600
Message-ID: <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
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

On Wed, May 6, 2020 at 7:11 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> > $ sudo btrfs fi us /mp/
>
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              7.32TiB
>     Device unallocated:            3.59TiB
>     Device missing:                  0.00B
>     Used:                          7.31TiB


Bytes to scrub should be 7.31TB...


> $ sudo btrfs scrub status -d /home
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub started:    Mon May  4 04:36:54 2020
> Status:           running
> Duration:         18:06:28
> Time left:        31009959:50:08
> ETA:              Fri Dec 13 03:58:24 5557
> Total to scrub:   3.66TiB
> Bytes scrubbed:   9.80TiB


So two bugs. Total to scrub is wrong. And scrubbed bytes is bigger
than both the reported total to scrub and the correct total that
should be scrubbed.

Three bugs, the time is goofy. This sounds familiar. Maybe just
upgrade your btrfs-progs.



-- 
Chris Murphy
