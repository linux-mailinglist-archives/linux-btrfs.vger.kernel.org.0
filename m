Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ADF2B2BF4
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Nov 2020 08:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKNH26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Nov 2020 02:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKNH26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Nov 2020 02:28:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902C0C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 23:28:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p8so12792559wrx.5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 23:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zPN3DSom69sxZqiLUlWiVulzKwUBQxiGA+h1RjD1XPQ=;
        b=Xjtbj/+ZoNpWXXzB0dfvg1Ygg613JQh9JZ0zsnpUnKan8n7ijiJZYOMN3qI1F4ApLz
         P86edpx2nXKMkKuQj6m5nj7a3jEhS+EECdnXM8qWyc9OyKb5vHupUurjMvOsH34/liPt
         ZKI8yKcyI9EwtWym+SW2mKxP1kep2R0LD3B9oTjcDTv4FUjQWBV3GGBluOZ42rrnRlg9
         2DZGItTgZbJmmBLXGIacs7To8w7bDrCHf9inFHUXRVZW3JUCbySiza+0bXBRmqFM0rSn
         DdwJi++Xe6hJN3VIj/wWlbuxUbdx05C87i2PzxirSMbgnrtehMrIw63hSUvKXrCOkyJR
         412A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zPN3DSom69sxZqiLUlWiVulzKwUBQxiGA+h1RjD1XPQ=;
        b=XV0a8U/YrwbeyW8V1HBgc+4o5LH4EZ+48h18pKE1hkp1Km7MkvMIfrkJ4Sz5G1y2yX
         yi+XK3mZFvigQxbnC30rkDcfdfe4WDJ9MYNen6PSUcUjaHjanp8WYjzrNGL2XJAWr6qq
         yQlYz93NdbIVF/078Y0vVZEe4O5Itxzy4l25qeb2286udcG8BvfhDJcAMvWTSdZrZdSN
         q1YG3rcjwFo/lxe7qqR3wKKp+PDp0qDBwz70M/Gv3VzMjp4G8gNgR1pan6Tma4w2F7c2
         XiTvfqiURxkdniHlOEwt26NKLamclTWYGtE6nPwBTgS9EQEwvkFzZ7hHX/ubjmWjQdqH
         LTNQ==
X-Gm-Message-State: AOAM533+AFYAzd5JjZZuKBgPNEKIpwMgFkdwugFWsinkcFm+ndyQPJnf
        6ioR9n+BJG75iRmnE9MFE1uoAmC8UDlcKWkfyAg977kSI2Kmhc2t
X-Google-Smtp-Source: ABdhPJwHw7fhkJ/WF3Sw4vLCZr8U3ZMktegA6yYyUggw7H/GLGwkmtjLxYa/X8g/fgNXtMMd1bIZ801ZHRi44U0kR1g=
X-Received: by 2002:a5d:488d:: with SMTP id g13mr729888wrq.274.1605338935207;
 Fri, 13 Nov 2020 23:28:55 -0800 (PST)
MIME-Version: 1.0
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
In-Reply-To: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 14 Nov 2020 00:28:39 -0700
Message-ID: <CAJCQCtSxFH0CgoDm53BsqUMymkf2NnwiMwFbN+VBsXvzJe5YLQ@mail.gmail.com>
Subject: Re: bizare bug in "btrfs subvolume show"
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 10:58 PM Lawrence D'Anna <larry@elder-gods.org> wro=
te:
>
> Hi btrfs folks.
>
> I=E2=80=99m encountering what looks like a very strange bug in btrfs-prog=
s or possibly btrfs itself.
>
> If i just do subvol show in a terminal, it works
>
> root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs subvol show /data/
> /
>         Name:                   <FS_TREE>
>         UUID:                   853d0925-fafc-4b69-9efa-b970fb93a419
>         Parent UUID:            -
>         Received UUID:          -
>         Creation time:          2020-09-28 22:44:37 -0700
>         Subvolume ID:           5
>         Generation:             56582
>         Gen at creation:        0
>         Parent ID:              0
>         Top level ID:           0
>         Flags:                  -
>         Snapshot(s):
>
>
> but if I redirect standard out, it fails!
>
> root@odin:/home/lawrence_danna/src/btrfs-progs# btrfs subvol show /data/ =
>/dev/null
> ERROR: Subvolume not found: No such file or directory
>
> same result if I redirect to a file, or pipe it to cat

I can't reproduce the error with kernel 5.9.8 and btrfs-progs 5.8.

--=20
Chris Murphy
