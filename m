Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1281D5F6C
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 May 2020 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgEPHaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 May 2020 03:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725807AbgEPHaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 May 2020 03:30:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C81C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat, 16 May 2020 00:30:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z72so4865529wmc.2
        for <linux-btrfs@vger.kernel.org>; Sat, 16 May 2020 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ggeFNKFz0/HBodYA2pv51Sghwgg56ANLHdrC/PYL4zM=;
        b=d/wqQVcwm56aKBmOkfv47HyYKtFYmGcOjevJ1RfynL2NYBB4nSAdy4ygCifycrdJkZ
         1FxCvdymLKHtccK961Sb/Y3FJdfHm4OYguXuNgKjtSe3n+J6uYrT/0+YISJLByfFTY6J
         Zyt4i0ctTR3S1VKw696HLhakxTPN7BRaKYs89QkRWdB9PIP+bcf2y7rF69uCiGPg+/mo
         b7dNjf7GR/jlGHC5pv+tnLYlCB3JSrb7E69gwmQeBOCKrFvMyjBu0RG8AgZWZSrwPfgT
         O3WGAMXzSyeCuu5GesyMkFRcqJxKu2j98Ozk1pJHn4NAmrn7f7Vibi8AfnWi61RjrgBe
         URYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ggeFNKFz0/HBodYA2pv51Sghwgg56ANLHdrC/PYL4zM=;
        b=uIaJ7dan1K1UP8LCM3lbI6IL49JJWq7zjOc4vg7EW5lb1qNF2Vx5KlYgXk0iyNDzOk
         PduBzsSe1KQBFbbjxdRzxBczSqx7B3n8G6RAJKAIryw3p5g6GC2dFZs9WTjNwnBYhrpw
         YCtp+aYWEPUZuGz3MpB4npxN7xdpqlmwTL+w6vpVUyOQymX3xPDdGRQ9go23w6YnaLob
         Lsju0kQA3jNm82yArgz5lToQMs9+2ICMX/XU/nmGVbbhc2UapYALFdfD0Wevw8vwSyAk
         mTMSvdFC4guJqgl/KznrGK7o5c3D/DfVM3obYsUC4oxEfJ6MFWfWpl6z79AycCQLtyKr
         NcgA==
X-Gm-Message-State: AOAM530e8BS64PE9BXZDvIpgFf2DLRO7BKzap54hZp/2rqv2IlLN4BgS
        Mu0mWk/qC/Ek3lFh7bS+9uRHYfJ42UwVHOWgakwRq86d
X-Google-Smtp-Source: ABdhPJxvzrsStCyvmtiJKJIuJBMYzpeKp/+xxOvxCvAJcrqAXfIgSzm1ppmjaKT0hUXG9+jMj6kXwS+lrJvgcvWYWMo=
X-Received: by 2002:a1c:6402:: with SMTP id y2mr8210054wmb.116.1589614201819;
 Sat, 16 May 2020 00:30:01 -0700 (PDT)
MIME-Version: 1.0
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Sat, 16 May 2020 17:29:50 +1000
Message-ID: <CACurcBtz0f+him1=0Vw_PzF0n74OhVZSnsYkTfJJiD10DTbF=Q@mail.gmail.com>
Subject: Mount options in kernel boot line or fstab?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've currently got my system set up so that all the mount options are
specified in /etc/fstab. Should I change the ones for the / volume to
be specified on the kernel boot line in my bootloader (in this case,
refind)?

    # /etc/fstab
    UUID=3Dcd1a16e7-8183-4e2d-9496-f3795128e83f    /    btrfs
rw,noatime,space_cache,autodefrag,subvol=3D@  0  0
    UUID=3Dcd1a16e7-8183-4e2d-9496-f3795128e83f    /home    btrfs
rw,noatime,subvol=3D@home  0  0
    # =E2=80=A6

I saw recently in a previous message on this list that everyone should
be using space_cache v2 by now, and I'm not sure which one my volumes
are using. Is there a btrfs command to find out?

Robbie
