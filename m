Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17863FBD4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 22:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhH3UMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 16:12:31 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:44708 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhH3UMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 16:12:30 -0400
Received: by mail-lf1-f52.google.com with SMTP id s10so8823446lfr.11
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jZEfzAy5uj7b+GMwr8YRz5GROc6RuRgiy+DAW+hklE=;
        b=DH1D3uedcw/yx9QGEGynCuL+zFmUVTrVS+A6oB7+4Qi5L+vJj3P/VB+qcHZMDKIVmz
         7xNvIK5mP1MnIFGGnIBMEKqwW1n/UVtA26QP6bCPvfkB4up7YqACocRzGVpAkd0764Ic
         9DaSZfm3HuKcScmSyzNWCouzxS5RCRf5kvOmuTtD9iwWoRQJ57omysuJHtejnCIVF75E
         N2AlOWeGNzN5ieFuzRrWaO0+J+SnQ6tSpTFe4b1Um2R2eKPwFE/yAH5qGbjZOjBjSd+4
         7uea6i9gWoo0RyzX3Ewqs1QrR27hlHzHaNSKkNYSzfIZ5PjS4FkEsNl9gYLbsvw1f3Jg
         5tWQ==
X-Gm-Message-State: AOAM530YB5eC+E4rSmlz6kMADYb4YBD45yRWx2YzdxVTAS8BesoSoi5R
        S9zWT0QoiogaieQk9Fa2Aw5kDmu/Tpol93h9NUxn4Tuc/n0=
X-Google-Smtp-Source: ABdhPJw/Uo4E5JyN5li1LqQp1oCUuvJ0aGaJt7OdWrO/n4l/eAlSZzfrYy48My4C+B423vWV8hAtqLmJVplZZoNL7Jg=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr10283624lfg.411.1630354295496;
 Mon, 30 Aug 2021 13:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com> <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
In-Reply-To: <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Mon, 30 Aug 2021 13:11:24 -0700
Message-ID: <CAOaVUnUOm3kaNPFriH3OdOEiVMyyv=8sCE+SdUXMZSMBQwtAYQ@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is it the destination inode that matters? The inode of places.sqlite
on the destination is 400186.
