Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2631C29DA4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 00:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgJ1XS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgJ1XRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 19:17:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7EDC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 16:17:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m9so770328qth.7
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DTZigPiFRXRL9ENLHUXKYgZG2dQTjBVBKahdpyavHg0=;
        b=ArbrFuTxxJf29KN62hE37qFSzRDsV5pnMFp0qbbr6v7JzF5k1oNyC9wC4Q2CFD/0Y/
         giqwcor/zS0YXyDKrFmpkDI93CfndVZIryTfCaXBsQ+cG8Qzd0wqvpYDgqtSqK/nKipc
         rlwybz8W2LDgaQYzDSUYxrYezm+ERbuYVfUB6QrCTZFH9T64bsMRpusDFONJ14nrTWEv
         HJ7L3qYefvNkhosBsDFPOUAMl31cd9ljIItoBgqC4FFtSVqKSx5kg8FwpnxZtVi2BQjg
         Avn3GlCJ2uzeoPsfisuKuBHFF6fYJIIF1s0KZ8uUyWaFxtzvGJQ4ciE+UGA70c2u7bEM
         G9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DTZigPiFRXRL9ENLHUXKYgZG2dQTjBVBKahdpyavHg0=;
        b=XtDGh8BGTvqC83x6xkv9GjNS/pIkQVmYYJHr6qVcR8S2svFKxPI3Zbu9agyj4jaIsA
         vB4NBOKKMMAmVocWsCO22GSMXIOChSSdL6DSsXpD37oGEr11o4JoRsHQODpEJWFIR+mr
         1klBq0N/FdKzJIaJJschb1KcDlIY61+8YqiMUju9io7gYv4LEmyjPhyxeG4igr6rXzwR
         dHvqasO/SuheXS1NWW4s7aB1LgGP2x4OTgh1G62ewHpwd9GwENRi/UoUynu4Q7E3tLXL
         Oprcjetlx1/khaNeYVPSKMYXpOW88k/xQqQ8n/oALSAvtNFS35l5gemrTosbHAC6nAKf
         Od/g==
X-Gm-Message-State: AOAM531DxVyDI4egnQs87sI5uyfWbSdkBlRlRm2z9tuthDywlbXRjQLK
        EE1hO57Ef3qFLYUzMnvZfN9ExMQq78zp1aXc0bQ+Mc21
X-Google-Smtp-Source: ABdhPJwnVASQCijnJNldChzh3yh5MBueeEyVlGMh9JfMstaa2gfvxHylvJO3zvMB598Ep9geKtQrfxSAUOyVFBAu9OM=
X-Received: by 2002:ac8:6b0c:: with SMTP id w12mr6615303qts.347.1603889307234;
 Wed, 28 Oct 2020 05:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZtGM1Gia7FjunVN4+r4uikQeAPTYAU53QCcT=QQTyt1bg@mail.gmail.com>
In-Reply-To: <CAA85sZtGM1Gia7FjunVN4+r4uikQeAPTYAU53QCcT=QQTyt1bg@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 28 Oct 2020 13:48:16 +0100
Message-ID: <CAA85sZtk=ho0J-nnMx4xM+WiPmjUwb_sm+BGZExAS=LcQV7ggQ@mail.gmail.com>
Subject: Re: questions about qemu io_uring/dio
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, so how about warning about incompatible mount options and not just
swallowing them saying nothing?

It's kinda assumed that it's working IF there is no error messages... ;)

nodatacow doesn't work on subvolumes, important information to know! =)

On Wed, Oct 28, 2020 at 12:25 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Hi,
>
> From what i understand, DIO is supposed to be supported...
>
> But when i switched qemu to use io_uring it seems like the filesystems
> on the VM:s get silently corrupted... (they also run btrfs, and it's
> thus detected)
>
> The system is mounted as nodatacow, I can't set +C with chattr so I
> assume that the images are actually noncow
>
> Any ideas?
