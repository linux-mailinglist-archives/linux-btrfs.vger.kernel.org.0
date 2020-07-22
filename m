Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1F2297AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgGVLsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgGVLsQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 07:48:16 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA08C0619DC;
        Wed, 22 Jul 2020 04:48:16 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m6so951173vsl.12;
        Wed, 22 Jul 2020 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0z8NGosiowpulBYuDo3x5SEsE4TnpRKmPp0hH/c8aQY=;
        b=TNuMj3v/EFmaS+RdQcKGzkTcPJV20WYwMdwNQj89l5lonQmQvIwcgS13Edqf9AsWBk
         5/w1xREI3DOvIVVWsTyHKZFqXOpyiTQ034cijwyOxicMhdAopMD3a0Wvj7mcQ2MDUiC1
         foNXo4zqP2BDossTu1nvSvHi2TY27DV+Ksj5WO2df6pDX+HIvQ38DHglqR1Bb2zIKrLL
         pC/Esf5iGGdrvHHtGdDMRZH5TjtVthmgc5AWXjOcTGJY4Ps3SxtnK6l4LFG/nPoWREu5
         duaoIDDvtxArKsz2ntr22J6fJCS1P94pBKDi8HcvZgCi7Lt5Xuqozt7AnF9h2yzfHvyc
         voXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0z8NGosiowpulBYuDo3x5SEsE4TnpRKmPp0hH/c8aQY=;
        b=B8RtS/HVHJEmtyri+Os7ErBKFM+afomC6EIuXEiOHJRaWqKNQdseFu5BS0csHyGp6n
         0u/YROQjP4bZOmLAEqzvlPE8GUECXaPRG60vBhfhXjIE8R/QUjhr2bly/MIz8ZPH45DQ
         0D3Zed/BvNsO0oiRKoDjUUxHliKr68AhiuMISWNoX4bD1vVPyalAgGGRuecN7KEeDfCw
         ONe+LFX5k3ZBtghaPNtLanyF4YFb3m2UKk0tvuiXC1ia20tPKWfnAtGU6d/GOkzYLu9C
         2rCS6DRLP6DPu7IzHM44QMlXRF6yNKFHFNi2bQHyMyzHy+xn/FPDwcvyog+raVazj36X
         2g4Q==
X-Gm-Message-State: AOAM533aiB7OP1BDi+Az96DCE6xTq7EO7q3rLFLdHmFUUxT3DHF8jnkv
        BmRaijnHvEA+E9Q8q5myazUT07Qbg8hMP7OwcCM=
X-Google-Smtp-Source: ABdhPJxjodQmM4nI3Q5O4MnEPf4NyO9eAQlr0WxKoWxy3aQtjl6wKD/Pa4cb33eCXy2y0YfbKmk2ycysT9MSspXcVW8=
X-Received: by 2002:a67:7241:: with SMTP id n62mr24455952vsc.206.1595418495670;
 Wed, 22 Jul 2020 04:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200721124630.3112-1-marcos@mpdesouza.com>
In-Reply-To: <20200721124630.3112-1-marcos@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 Jul 2020 12:48:04 +0100
Message-ID: <CAL3q7H4mO7ni5sfKZ8UQ68J4i+-sRy=vNJmx2L0jO+oGFHZLgA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: 210: Ignore output from "quota rescan" after
 "quota enable"
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 2:09 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> Command "quota enable" triggers a quota rescan, but it can finish quick
> in some machines leading to the next command "quota rescan" to be able
> to start scanning again, and then printing "quota rescan started" making
> the test fail.
>
> In some machines this don't happen because the first rescan initiated by
> "quota enable" is still running when "quota rescan" is executed, returnin=
g
> -EINPROGRESS from ioctl BTRFS_IOC_QUOTA_RESCAN_STATUS and not printing th=
e
> message.
>
> Ignoring any output from "quota rescan" solves the issue in both cases, a=
nd
> this is already being done by others tests as well.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  Patch v1 can be found here:
>  https://www.spinics.net/lists/linux-btrfs/msg103177.html
>
>  tests/btrfs/210 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/210 b/tests/btrfs/210
> index daa76a87..13d1a87b 100755
> --- a/tests/btrfs/210
> +++ b/tests/btrfs/210
> @@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/=
null
>  # by qgroup
>  sync
>  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
> -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
>  $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
>
>  # Create a snapshot with qgroup inherit
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
