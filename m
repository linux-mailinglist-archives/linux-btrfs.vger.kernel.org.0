Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADE6CCADF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjC1TqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1TqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 15:46:02 -0400
Received: from mta-p7.oit.umn.edu (mta-p7.oit.umn.edu [134.84.196.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801F2122
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 12:46:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4PmKtJ4SyCz9wBbx
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 19:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WMtpbnywwBaS for <linux-btrfs@vger.kernel.org>;
        Tue, 28 Mar 2023 14:46:00 -0500 (CDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4PmKtJ2MtXz9wBcC
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 14:46:00 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4PmKtJ2MtXz9wBcC
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4PmKtJ2MtXz9wBcC
Received: by mail-pl1-f200.google.com with SMTP id f6-20020a170902ce8600b001a25ae310a9so2551219plg.10
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1680032759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=947igMRJCL1W5Tdly4rh8etCANKMnY12oSHMO6E/Ysc=;
        b=VTiQGskZZqMYBFwcr57lQsK3NKw27gxUeEnwGYZr8VuYW86HI8E8Bln0MfdXv1LcnM
         vW3PoRNNr2QGEbcTf31Mkth2MmtdAqALyURPK2/mGz9RfKrSC0Q7R/lnR6+VB5NGLrVd
         xYfgOenTDEj0Bo/zermFk2XOSSgJiEXbCw10G57iqkRaVmpG1fu+/VWmk9+jcjoJDTbF
         bjCc7SIPlNykYpYdLL+BatImVxnygJ10zJq7nNfFf+kgimlCsMUYa4M1s7/rac1dPW5d
         6mwP/poLkyg/yWV2aHeqkkwPZeS+QSjPEqxq4fsscYtlBgLvp+GP038vxfw1f+Jwl51l
         i9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680032759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=947igMRJCL1W5Tdly4rh8etCANKMnY12oSHMO6E/Ysc=;
        b=wg1xaUbG1zVYGtVm16T+pdNPCe2D2BrP/9NtHkjVrNHQV9NLsxkaBEK32PAre6dnzt
         6UZbLXvvAfB/Qm3neIrvMilMsYhHWHkEhclZQb/V7p47s8gbtXe9sYdUCiv2fBQoLpJE
         e2IJB/o7dhZM66zZQ3sSsfnUB3eknFvY45kS5ejZV2fxKyUzrXt7Hx5En8R+UidUcnPq
         DTp9nSQKZkNdIS2/fmbdAib43B4/264wDeN7upvpB+IbJ9KPQkVdYHCiDOOMTYW2C0ML
         SrYH4KJqw3k4/w9v8BSS7FrjX3ugy7V00lTtD2GgHo5XhPXCKBJ4AF6EQb/txzM01z5A
         Cqew==
X-Gm-Message-State: AAQBX9dRCmp/DS8mAQgkRYluhlOnamxIeehPGzol0l5KCy5PPGTTFM9C
        Ic9ho1ZG2wq7Spv8V56Rgpjx0xJ3A5p5XnDP5+DPQ1jbMllCkY3Eg0kMVDQSRx8iJIyShPirtAQ
        ZNukGFyjhye5+eeGOliUwRnzORv07rTu/a2FUXN05jNwej4hUSPGsOQ==
X-Received: by 2002:a63:e501:0:b0:513:429a:1389 with SMTP id r1-20020a63e501000000b00513429a1389mr3293396pgh.0.1680032759446;
        Tue, 28 Mar 2023 12:45:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZknNjiNCrOTnG3mpk9y2R/1PlKGhYWYg2xMBhOkmRAiDgs9rtJSQBmPcBKYRmC7wgDfyw4TPVVLhOdkNSMBu8=
X-Received: by 2002:a63:e501:0:b0:513:429a:1389 with SMTP id
 r1-20020a63e501000000b00513429a1389mr3293389pgh.0.1680032759175; Tue, 28 Mar
 2023 12:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com> <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
 <CA+H1V9zb8aO_Y37vdwbubqHZds__=hLe06zx1Zz6zdsDLUkqeQ@mail.gmail.com>
 <CAOLfK3Uokj64QcBypkfr7X79qQ9235o=bv87RJtRSKjupKUQLw@mail.gmail.com> <CA+H1V9zmpna9Ncov-15einQ0pLevy-1zF-nSvJrzgz7Mp_TrHw@mail.gmail.com>
In-Reply-To: <CA+H1V9zmpna9Ncov-15einQ0pLevy-1zF-nSvJrzgz7Mp_TrHw@mail.gmail.com>
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Tue, 28 Mar 2023 14:45:47 -0500
Message-ID: <CAOLfK3Um8uwJyvyn9V4YLAXvv7JDAPF9t6KHDi-Q49XYoZf2Rg@mail.gmail.com>
Subject: Re: subvolumes as partitions and mount options
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 27, 2023 at 8:42=E2=80=AFPM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> It looks like you already have it mostly set up correctly. You will
> want to mount your filesystem somewhere without specifying a
> subvolume.

Sure. Things are starting to make a little more sense.

 Then you can put all the subvolumes you want "hidden" in
> there. This should be as simple as unomunting /subv_mnt, moving
> subv_content to the btrfs root subvolume,

Right. My rootfs is mounted with a subvolume option, so I still can't
get at the "root" subvolume:

# mount | grep btrfs
/dev/nvme0n1p2 on / type btrfs
(rw,relatime,ssd,space_cache=3Dv2,subvolid=3D256,subvol=3D/@rootfs)

Thusly, I would need to unmount my root partition (presumably through
a live-cd or equivalent) and then mount:

mount /dev/nvme0n1p2 /mnt

and create my subvolume:

btrfs subvolume create /mnt/@foo

then boot back into my system with the regular root fs mount entry in
/etc/fstab and then I can mount the subvolume as desired:

mount /dev/nvme0n1p2 /path/to/foo -o subvol=3D@foo

It looks like I can mount the root:

sudo -i
mkdir /btrfs-fixer
mount /dev/nvme0n1p2 /btrfs-fixer
btrfs subvolume create /btrfs-fixer/@foo
umount /dev/nvme0n1p2
rm -rf /btrfs-fixer
mount /dev/nvme0n1p2 /path/to/foo -o subvol=3D@foo

Not a bad work-around.

Thanks for all the help!

-m
