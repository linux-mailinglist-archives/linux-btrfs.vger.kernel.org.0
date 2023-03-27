Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1446CB05E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 23:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC0VGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0VGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 17:06:24 -0400
Received: from mta-p7.oit.umn.edu (mta-p7.oit.umn.edu [134.84.196.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAC6101
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 14:06:22 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4PlljV1VSjzB8pbX
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 21:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E84hR5QJLnr0 for <linux-btrfs@vger.kernel.org>;
        Mon, 27 Mar 2023 16:06:22 -0500 (CDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4PlljT6VyRzB8pbZ
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:06:21 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4PlljT6VyRzB8pbZ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4PlljT6VyRzB8pbZ
Received: by mail-pl1-f197.google.com with SMTP id k17-20020a170902d59100b0019abcf45d75so6320589plh.8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1679951181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H39JaZQjoelyIR3FKp58WyEZeMD8e7W2H0mE6XwogbQ=;
        b=hloQ11cBIrisiuvIkc3X1e+hU/ZaSyyA80J6MCizm4napTXpnlz6GmyrBKFHyE4lk5
         WhhoJ4IeQnaST8fWzx2N+RUzYOnzmJ0TMgTNoPYzKqU37beZq8Et2x/oISDtZbqWwRpp
         Gx9tWsW9/vgQskd9N8lkDbnGcxhSIynylGZkn8aek5IlTpMEHop4L4clCsPVFIz1tfyt
         y+zkJ5iUphexc1igWn3Gv+e5xdMxDXao5a838rkSYYwD5VUlTtv/cQKo+/+dRDbPA29M
         4EvhZ2S1TmnV3aAtRVGY3kN+TeRr70hwTL4poN7f166OY/q+kaI2ZIbY+rXSff1Rwb9U
         Uyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H39JaZQjoelyIR3FKp58WyEZeMD8e7W2H0mE6XwogbQ=;
        b=NMqAHZylInmOksksd+JzjDuFxisFHE30jPhfJKgduGdjz2XQwho4m0xsdTqH8KD1em
         khU9rrmEwBHQQONnRDpKFkyAKhQZoAL8NXc7eOjfT/yeXxOPBW+DiUcXdI3+5KFog9T1
         t6+PyhOYedTtCz1DYySmSBUHqhiu+36/TVXGUyIHG5yuXjb7Nt2HzEqT6XyR4D+2gMXX
         9Kv3clYnzAQApiIQ9M35DplGgwHyxget/v8tSFfrD4t5FGgSVOXh7BoQW6VR3IJpI9+2
         CncI567VZFqqoh+ca6P181FHAkXr1QpVwb7Hs9DfK0fXl8m8GXZ2xFSJeW7vnQoPyHug
         1quQ==
X-Gm-Message-State: AAQBX9d6FsS2da2O6ol8I2uBvhuJrwO6lhlvMifP4T9oE4wINHtI49WJ
        fylLNYIvouzPR5cj/LBhB0XAl8W6tEsBUNbvcI0zW6SKkoO9gzw2KbMFfsfgHj4nfC4mgzryu6S
        FChquGWg2sfWKFOZyeG8CAerSmPHILWOT9TVYGUxqhNQ=
X-Received: by 2002:a17:902:ef94:b0:1a1:c109:3700 with SMTP id iz20-20020a170902ef9400b001a1c1093700mr4570194plb.7.1679951181517;
        Mon, 27 Mar 2023 14:06:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/v/E2kQNEl16LO+wktEb+j75RkB3Un4CcK7HAkLxAwh+fUvg/XSUQKg6EYoO2rCTgvBqe0mg6/TPgW1AceAo=
X-Received: by 2002:a17:902:ef94:b0:1a1:c109:3700 with SMTP id
 iz20-20020a170902ef9400b001a1c1093700mr4570186plb.7.1679951181259; Mon, 27
 Mar 2023 14:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com> <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
 <CA+H1V9zb8aO_Y37vdwbubqHZds__=hLe06zx1Zz6zdsDLUkqeQ@mail.gmail.com>
In-Reply-To: <CA+H1V9zb8aO_Y37vdwbubqHZds__=hLe06zx1Zz6zdsDLUkqeQ@mail.gmail.com>
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Mon, 27 Mar 2023 16:06:08 -0500
Message-ID: <CAOLfK3Uokj64QcBypkfr7X79qQ9235o=bv87RJtRSKjupKUQLw@mail.gmail.com>
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

Hi Matthew,

On Mon, Mar 27, 2023 at 3:32=E2=80=AFPM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> If you want something like this, you will want to have those
> subvolumes outside of the root subvolume. For instance, My BTRFS
> subvolumes look like this
> / root subvol - The subvolume which is created on mkfs
> /@arch - The subvolume I have mounted as /
> /@home - The subvolume I have mounted as /home
>
> If you do something like that, then you prevent access by having it
> hidden in the root subvolume.

Do you know if I can retrofit my current btrfs install to implement
the structure you've suggested?

To my knowledge I've got my root filesystem mounted on the "parent" subvolu=
me:

root@ziti:~# btrfs subvolume list / -a
ID 256 gen 606645 top level 5 path <FS_TREE>/@rootfs
ID 257 gen 606389 top level 256 path @rootfs/subv_content

root@ziti:~# mount | grep btrfs
/dev/nvme0n1p2 on / type btrfs
(rw,relatime,ssd,space_cache=3Dv2,subvolid=3D256,subvol=3D/@rootfs)
/dev/nvme0n1p2 on /subv_mnt type btrfs
(rw,nosuid,nodev,noexec,relatime,ssd,space_cache=3Dv2,subvolid=3D257,subvol=
=3D/@rootfs/subv_content)

The subv_content subvolume is just for testing and can be deleted.

Thanks for any pointers!

-m
