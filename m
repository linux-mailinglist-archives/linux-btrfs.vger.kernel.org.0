Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6D429C6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 06:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhJLEgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 00:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhJLEgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 00:36:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE2C061570
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 21:34:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n8so79840005lfk.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WRj3BHJc76STqhIj5G2kzIrZTfcvZHkQwWIu+naLpZA=;
        b=Dg7ZW4dAVdfeUjDLEELwDqLtSw0WKLKuxYkqwgcJIJqciDH8kP+5xxlsUpfo+9+WJh
         DdU1WJW4QxLnmlx9cvKzoDWvPifH77hj4h6qIry9X8AXLcDShS0cB2ti+w6CdLw3e7P+
         HhxUE4ZmOcBUPodokmc5gX1CdnPUyVcMRofxwhVP/RdYcV5VjCOnfSTmG5ySCvgSL+WC
         Mx+RHrOJ6PGGr/xVzddqdknt75X19wSV8mqzmIp8qa768AB/a3FsEhGFxzCjZhR/mqM5
         aBqwbAycGmx5+w/bYgYeCkxYd0h/UKk4NizyFXob+eyzFYq14Vet7oE142xOT1XK8B6k
         jLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=WRj3BHJc76STqhIj5G2kzIrZTfcvZHkQwWIu+naLpZA=;
        b=4WfWHinXRUcgJb6Y5jfflw5HES0SYi2r/K5+7QXz4cYvxnX2VZZmFb5Olpj8v9H3dv
         MmakbtPdRVIZquyciHkm0VWE8uz0zXZ9oHgZKEtj+7iPXNSYi1Mt3Br6LaD7jR9ACqM2
         +LdzLvek3FcayYS+MWk9pXENi1vxbREz0ux/kiaaHgMJLV1PCvcwH9xQdA6T3ARjDePW
         k1kkiFf4JP4514SEf+aaW3VtB1hT9Wfau476InFzL0qpmI/5lkTOQwXZEUc1ehNZVTCk
         nJB6VatN+brFstqOXIJ5HNqbcWCJCwBbRjsNpbQ+ke4quMR8upUZ3+4Jc/IGyD32e7XG
         pbPA==
X-Gm-Message-State: AOAM530yBXrKe0FLJorWXqIQG0nhLaaho3mGbgT42HtlUe0/T7QFG/H9
        dbOvvG+pB02EdPIxk/DM7+5Hv734nwlvhZB24pA=
X-Google-Smtp-Source: ABdhPJySNg0KdxLAHZYcbfptIkOHQ/j1/MezMl+3aTf0CuhArCDYuCxLHGApnORw8FUAotLd9A1TbsLOEbbvWglV9yE=
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr6025787lji.5.1634013282376;
 Mon, 11 Oct 2021 21:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <1633367733-14671-1-git-send-email-zhanglikernel@gmail.com> <20211011151728.GS9286@twin.jikos.cz>
In-Reply-To: <20211011151728.GS9286@twin.jikos.cz>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Tue, 12 Oct 2021 12:34:31 +0800
Message-ID: <CAAa-AG=EfthLHSSE7zNyPxFccMqDLTSFN7X4vy8SKVSoCd3uGw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: clear BTRFS_DEV_STATE_MISSING bit in btrfs_close_one_device
To:     David Sterba <dsterba@suse.cz>, Li Zhang <zhanglikernel@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Great, thanks!

David Sterba <dsterba@suse.cz> =E4=BA=8E2021=E5=B9=B410=E6=9C=8811=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 05, 2021 at 01:15:33AM +0800, Li Zhang wrote:
> > bug: https://github.com/kdave/btrfs-progs/issues/389
> >
> > The previous patch does not fix the bug right:
> > https://lore.kernel.org/linux-btrfs/1632330390-29793-1-git-send-email-z=
hanglikernel@gmail.com
> > So I write a new one
>
> This looks correct, dropping the bit when we decrease the missing device
> counter. I've added the patch to for-next for now, thanks.
