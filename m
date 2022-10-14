Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEC5FF357
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJNSES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJNSER (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 14:04:17 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1D1C1177
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 11:04:16 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-35711e5a5ceso52992437b3.13
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rEeI41LUxbcbRBjg/57H1N/v6EUlmFL1b4PK+toZCQQ=;
        b=qwOhsssnQlPY1bUkUlBlRqWc/i2jCx8PqJyo3emkJ2sprMRRJjPk2+7FP7WLdW3k9Z
         Z3sqbZJ9kc7/XsZlkazLPSr1tiGFxoqQdkeU9+n70zBCXt0Slrt/DmcGrADv41V8VSbg
         acdHhnky/tC5EHQ2FMDDJyHC+mQHM/CTmEP8ptugq8+LqjJyqkqDJxkY0ivuHDkL6gcz
         z1dtQBUs3HQUebTJXfRbyTbxDXRhlQLKH5ehqzDaRSRGIsbc2rKCjuYsVWUPjkgAJHdF
         aFBgB1cc3eo1Ky7IzwBoPOlfsOUa69epIN8putcoZwkbK8iPo68Oq6OcKcaUp5cYns78
         L3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEeI41LUxbcbRBjg/57H1N/v6EUlmFL1b4PK+toZCQQ=;
        b=SiUQqQi5WA2dPhZXoAJfZmn6Bu3ErE4jaoAoVN+S2NzJnQIPkdxyREsndliift7WxT
         Ar5hHNFO/w09Qt2IqtOdktuQs80CRRBI73a26OOKKrVwAOPBg13kqv+UbjnhAqGR+NTo
         f61sLwzf1O2NjylEaLX2uAC5gdb2lK9/fizveWs1zp2g3RaC3BQ4l5d46V53y40gZ37b
         YQ7kOljXNZnZnkxDj+l0Ok+LMswcG+cfyQ+gOy9Y2TVsyOvuuulgsDCxKOETIgaZ9YSv
         9DbA2LYjLZGeaLr0e53oKd7xkCM4eVScGBKJ5ZMmx596+J9jcGa00mOse/4Qzh5KwHYj
         /Eaw==
X-Gm-Message-State: ACrzQf1Y2YHGeHqKj8moYVTVYTgWr6WHdhmV+lQdicCl3iyrlzvOvc/X
        Let5f+S/uKmVeOiEJ2/SK5jo3Rn9MDL0ASPJaiZT+nxpXXlEsQ==
X-Google-Smtp-Source: AMsMyM6kPpra+IgCaRnN2F8DJv0PevMX0/8FrffjPSrie/LhdspktOvf+sRxMqmkdx45oMbuOMcR3sa+jcz1a//E3x0=
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr5446918ywl.67.1665770655606; Fri, 14
 Oct 2022 11:04:15 -0700 (PDT)
MIME-Version: 1.0
From:   Nikolaos Chatzikonstantinou <nchatz314@gmail.com>
Date:   Fri, 14 Oct 2022 14:04:04 -0400
Message-ID: <CAAQmekd_X=XSZWq+JN0vq+vyYJTxdvsZJBCuCeqEDkz=RVW0NQ@mail.gmail.com>
Subject: documentation of swapfile and nodatacow
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello list,

This question popped up during the writing of a swapfile
guide. Following
<https://btrfs.readthedocs.io/en/latest/Swapfile.html>, I chose to put
the swapfile on a separate subvolume which does not get
snapshotted. The steps I have:

  btrfs subvolume create swap
  chattr +C swap
  chmod 0700 swap
  fallocate -l 1G swap/swapfile
  chmod 0600 swap/swapfile
  mkswap swap/swapfile

I'm uncertain about the chattr step. In
<https://btrfs.readthedocs.io/en/latest/btrfs-man5.html#mount-options>
I find the note

  "This means that (for example) you can=E2=80=99t set per-subvolume
  nodatacow, nodatasum, or compress using mount options."

which applies for mount options. On btrfs(5) I find under FILE
ATTRIBUTES

  C      no copy-on-write, file data modifications are done in-place

         When set on a directory, all newly created files will inherit
         this attribute.

         NOTE:
            Due to implementation limitations, this flag can be
            set/unset only on empty files.

This says that the +C attribute can only be set on files, not
directories, although it explains (in theory?) what should happen if a
directory has that attribute.

To summarize, I'd like to ask:

1) Can `chattr +C` be used on a subvolume? Is it different from mount
   option nodatacow?

2) Should the man page be reworded 'only on files that are empty'?

3) Should the readthedocs page be changed to include the subvolume
   creation step and remove the `truncate -s 0` step?

Regards,
Nikolaos Chatzikonstantinou
