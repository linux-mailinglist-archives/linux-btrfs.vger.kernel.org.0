Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C389930FFD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 23:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBDWCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 17:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBDWCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 17:02:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CBBC0613D6
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 14:01:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b3so5363197wrj.5
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Feb 2021 14:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8sGAQOd3O/bYdKuZdclagG6lySzRFALfYIx3FwPJQY=;
        b=TXC95fQjoH7S1DGJ/q5m13UmgHG2Ic5wJ/K2CmCBiTCzsYHhnZt1PfgaMDdRyok6y5
         YxCrpmPEk4Qeuyx/DN9s44TGDhhkbMp4P8QRDXM94yfoA/YyCjXrwf0Lujf2M8nNnEhw
         aj0bmdubNO+kMVsYl2eGRzmU0gcJHFoEKR5FL9uqu6qQXs2oY2cLg5aqqJ3eC24s/BtE
         vBeyXvb9rkPjYIYmTfgTM1qRMHFgzsWRfMNt6gMKr6ppr1jZe/5QXYFvBDkuKja+Tzvy
         7azw+8MHfxfAgrx/OML2UipXLQj2x11BPYtZtKCLodz8E/uNCxku0ganLOpTuYZHZPG7
         qEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8sGAQOd3O/bYdKuZdclagG6lySzRFALfYIx3FwPJQY=;
        b=fRyvbnq5eFQqbhCuK7GLPUOk9tABYEnWbOap6xdFc2ykRRRtyiJtBcAbF+I9MyuiLN
         hm0U6VGhbmHOzkwC/uLIcZ+4NeaEBqZSe2OmrREMUoEgUdGZDQFQP2xI3NhmYjB5LBwi
         1TtCvKIRGS9PKR75DIXFjyOoL/0J+LYHW+Rq2SmYdXwhb3weg6gqH7iXi95YnSjm46MY
         jMq+5lgxPVpGcrE/W5zkH++Olqeg/JwRNAN42D884QwkMVTI3Or2BukBBa3FqObe82Gz
         zsi9DNOot3oHAuqqSJ/mMYWYIfPDjagYlm66ka2REHJHtfyiTAx/43aBwGXHlJ+W0XnS
         X3yA==
X-Gm-Message-State: AOAM533fWXam5g8eRt2+I/ejy2YPzLcPXVNg21PLiNW0OdXuBWoRia3q
        pZvoagTMkfyhSItMJEuLTFj9CZsAHrUDfC0L6DSdG+aNLRtH/QRL
X-Google-Smtp-Source: ABdhPJwKrnp8p9bArqVMI5rRiAr+bbFZsPMsTy2CfsG8CxjFwRSGw4296y8x56pEUL0xNkjLGP30XbET+tXHpS4KB7o=
X-Received: by 2002:adf:ec52:: with SMTP id w18mr1477923wrn.65.1612476094627;
 Thu, 04 Feb 2021 14:01:34 -0800 (PST)
MIME-Version: 1.0
References: <CAP5D+waHS3rMdcYdv_++X8n8wgLjm3cC2=Tv34ZPzi=Ku4Ozog@mail.gmail.com>
In-Reply-To: <CAP5D+waHS3rMdcYdv_++X8n8wgLjm3cC2=Tv34ZPzi=Ku4Ozog@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 4 Feb 2021 15:01:18 -0700
Message-ID: <CAJCQCtQGXXhHwGXaR605b+B==F_Mt=pOO2ae=sgPP0S0KCkS0w@mail.gmail.com>
Subject: Re: btrfs becomes read only on removal of folders
To:     "miguel@rozsas.eng.br" <miguel@rozsas.eng.br>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 4, 2021 at 4:04 AM miguel@rozsas.eng.br
<miguel@rozsas.eng.br> wrote:


> https://susepaste.org/51166386

It's raid1 metadata on the same physical device, so depending on the
device, if the metadata writes are concurrent they may end up being
deduped by the drive firmware no matter that they're supposed to go to
separate partitions.

Feb 02 13:43:37 kimera.rozsas.eng.br kernel: BTRFS error (device
sdc2): unable to fixup (regular) error at logical 557651984384 on dev
/dev/sdc1
Feb 02 13:43:37 kimera.rozsas.eng.br kernel: BTRFS error (device
sdc2): unable to fixup (regular) error at logical 557651869696 on dev
/dev/sdc1

This suggests both copies are bad.

> So, what is going here ?
> How can I fix this FS ?

I would do a memory test, the longer the better. Memory defects can be evasive.

Take the opportunity to freshen backups while the file system still
mounts read-only. And then also provide the output from

btrfs check --readonly

It might be something that can be repaired, but until you've isolated
memory, any repair or new writes can end up with the same problem. But
if it's not just a bit flip, and both copies are bad, then it's
usually a case of backup, reformat, restore. Hence the backup needs to
be the top priority; and checking the memory the second priority.

-- 
Chris Murphy
