Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63FA3B9ACE
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 05:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbhGBDLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 23:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhGBDLC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 23:11:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68189C061762
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jul 2021 20:08:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j34so5726449wms.5
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jul 2021 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SyavSA9BFBu3SliOGftzgSnWgxryiy9zXMSsqzHSixI=;
        b=1RkFAEta3HkQZbQTbhkSSRyWE9VPqqLwbYDZWAZll+AVbWLDtW0RYFWgqVNnJUS/Su
         eC4EHNmwm+/B1DQU7ZZ9ght33fWBNK21Ph0G0WCFhbdgysJTKz2u/VrWLDyLJ6VJYfOz
         Iu+aOiV3UIASD8MuaaA5NtOshVFrcP+asAR0TrvbXd6/ZKyIs3QPWj4fezx1f91ETOOW
         /8Y4FfbIzTYnpMJlUJPJIrbz98B2up9YCAi4wJmvOrE3wHXA6mqD+mOWBSL0J8xdSpv+
         rbv02GRlxtclR4UhwQ6vx+QSfVv5o3EHnZoeCtD31vd5fOtB1pbs92QI1evSA1YXzYbU
         BBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SyavSA9BFBu3SliOGftzgSnWgxryiy9zXMSsqzHSixI=;
        b=le54gVdcVsaYFCA4aCA6IcKDq2BCcyxUM5mzvukpo21ordqHadcVCFu3R3FHz8EcMH
         vQAw2+RBoBmjwxKLmAzN6TJYhQs7XEhNtN/9yvHYWbILPfHFWIpBTKT0CWx5VbCSG23/
         c6lAAO7vSe2VD2xOeynKA5vC2sYj6XPr5mjBMOllQ0fFWHSyqNZ7CUwd3IFDryIxbfzT
         qRmxCjQEL+6EAcspyc0c4HHsr9PZE5jQa/5nnLWvqjufME+K3HixJ0rwANw4+6tKyXb9
         ft/F/anyhBMmmxCMygZQjhC5lI2cGbYSIqF9vVhVebgKlvGP2nqrdMWMzrkUGFuQ0Vdc
         juYQ==
X-Gm-Message-State: AOAM532yfD4ftkIRwGQwduEz8ipJfDj6zafU5ckNdEbdHvlmiw+NNEp+
        umIEIIX2MwmF2zo7MT95WNKq90LKPC8hN3YQVjpwjA==
X-Google-Smtp-Source: ABdhPJxWM4mTSgNthXSULyNFjA4c5BUIbwK0qBNWz0dSc11uK3pIAX2zGmj+JBpjkTUrE4dNqkXLh8XiL8sLd22fbjU=
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr14017737wmk.124.1625195308630;
 Thu, 01 Jul 2021 20:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <d29726ca253ba1b8ff43ff00852347bd2c876b4d.camel@scientia.net>
In-Reply-To: <d29726ca253ba1b8ff43ff00852347bd2c876b4d.camel@scientia.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 1 Jul 2021 21:08:12 -0600
Message-ID: <CAJCQCtSajD-w=h9_aaz9W0tF_8ThC4fofRMOyoXCbzGxGCfObQ@mail.gmail.com>
Subject: Re: auto-detect and set -o discard?
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 1, 2021 at 7:30 PM Christoph Anton Mitterer
<calestyo@scientia.net> wrote:
>
> Hey.
>
> Right now it seems, btrfs doesn't automatically set -o discard,
> depending on whether or no a SSD is detected.
>
> The FAQ entry https://btrfs.wiki.kernel.org/index.php/FAQ#Does_Btrfs_supp=
ort_TRIM.2Fdiscard.3F
> seems to imply that this was done because of several reasons:
>
>
> - dm-crypt security issues
>   =3D> that should be a non-issue, because AFAIU, dm-crypt itself simply
>      blocks any TRIM/discard, unless cryptsetup=E2=80=99s --allow-discard=
s is
>      specifically set when opening the device
>
> - disputed performance benefits
>   =3D> Is this still questioned?
>      I don't have any concrete benchmarks, but I mean using TRIM is
>      what probably every SSD manufacturer suggests?

It varies depending on make/model but quite a lot of them have said
it's not necessary because they properly over provision their drives
and the FTL is able to adequately infer no longer used blocks when the
FTL detects overwrites. So they say.

The reality is that it's going to depend on the workload. Cheap
devices may not be suitably well provisioned, or they may bog down
when many synchronous discards are issued along with ordinary reads
and writes. Most devices for most workloads are adequately managed by
a weekly fstrim.timer which is often enabled by default by distros.

Heavier write and delete workloads might benefit from discard=3Dasync
mount option, new since kernel 5.6.


>
>
> Another disadvantage of not auto-detecting this is that - with default
> mount options (i.e. no discard) - VMs and the like, wont give back any
> space in their storage images.

Sparse file VM images increases tracking cost and associated
performance impact. The best performance comes from a preallocated
file and not making it sparse. Or using logical devices like
partitions or LVM logical volumes.

But also, VM's tend to not pass through discards by default either,
similar to dm-crypt. So in any case additional configuration is
needed.



--=20
Chris Murphy
