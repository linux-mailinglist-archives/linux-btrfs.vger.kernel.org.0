Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCB31B2F1
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Feb 2021 23:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBNWFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Feb 2021 17:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNWFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Feb 2021 17:05:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EBEC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 14:04:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so6809931wrz.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Feb 2021 14:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5UrvzsKKdluy35FdFhLAdVtgRD+f8RkLG9xGG/39+4=;
        b=DNbjy0UlWk6DX5TFekQyCYCd87nX73SgPG4hJK3728BRH1X5rEEB/QLFgLQ3Fy1xYA
         9xKFSnL6Dt3DvoR2T+gvPN9TmiheSfYnF5+WPT05gQW5Bsafj6TRkbmEw61Cjsxen9Bv
         51gYnp+8aCm0cKGKrgvhiad7C+6moZqRDT0+lvwRSlKjy9OepCWwd7lzGZWCQHw5qf+T
         igzL0nvL54K4j+ovUJoQvDfHYoRtYBT7DagY+tHXUa55Ass4OOFgjCZVrys/vvcpJbys
         L59EecNUcDSMe5pzzcgFPoOax1QvhK9hu6fXjUoulS+jGEqG+b6Vd8mhMvSujdMUzTuf
         2Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5UrvzsKKdluy35FdFhLAdVtgRD+f8RkLG9xGG/39+4=;
        b=HQ2uvjTdLVbEEWTTzPv9hL9V2zhP2+FQJkyLrwzsL4Rip5bveOxc20YjoD9gy4pQsg
         6qntEKlMgjZKG+6If2zuwCQquZZnbfDbLSoucgK6Ie0otkGJ5dEku/R2H5ZbIilYfA2J
         vcai/81HkjXUkjrygcSKwJJd7pfVFMEB3wiemedN9yqT/enJ9ae2BriL1sHGYZ3U2ivC
         +JerbqXuJ+oxpZNBsxLqGZqQ27AzU90QXfeoodrYlpES2ApK4zEZrAD3jIm4M8NY+s+Y
         Oe6ZpD+8nHMWRoRNWuewOVLs1RHN8Wsg02EN9fjLw+O2LGiJIzSlNPXp3IsqpzL/Prmk
         hs6g==
X-Gm-Message-State: AOAM532ky+jEQ5SU/Zh+uDIOAlVfybovybYlRD2QrxZnysNtoEo8vECI
        Xq9Q+APrPE2L4vNp1K3BsZeiTUJpd9Wh/YducV+Yiw==
X-Google-Smtp-Source: ABdhPJyZLXpGdK+Cd/tzF+63ZAx/YC7NHqlAKXoG7a4fHEpG8j2V8vMokoGf0YdInJDX/7CLlmEmXf2+eCrHFwtv2S8=
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr15642086wrq.274.1613340275307;
 Sun, 14 Feb 2021 14:04:35 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
In-Reply-To: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 14 Feb 2021 15:04:19 -0700
Message-ID: <CAJCQCtQQXRujFppMNJMePsLEMJPf0rjyOuG2S4kCZO4i_YLAoQ@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Can you also include:

btrfs insp dump-s

I wonder if log replay is indicated by non-zero value for log_root in
the super block. If so, you check if: ro,nologreplay or
ro,nologreplay,usebackuproot work.

--
Chris Murphy
