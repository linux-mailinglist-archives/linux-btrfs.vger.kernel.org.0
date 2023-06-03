Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C27721198
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jun 2023 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjFCSwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Jun 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFCSwe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Jun 2023 14:52:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CACA
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Jun 2023 11:52:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso4798088a12.1
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jun 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685818351; x=1688410351;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vePfZj0VmfcpN9f2UHRADB0qcL+Jwy6NEMaozgbQ3jU=;
        b=PTM0vuv7HVLB4HmUFqf44LYLzognhxcnlLCLJlREYqQ8WYk4KF4I81YbU8edZDUd/l
         msIRjWnERrN7ejqsJYWAERGkqG0eP7W9pXuuUwlc/DtYBuawpR2J8uN9m66dWbwNWQFx
         OoHwKjL59n0Nd8c+9GAwt9ZMdXyiJcGyVfUwXhSF9AjYs5+TzXl/Phhe1eBeBQ5rWw3q
         6ypr7WNLts3N8pqqCDa8mh7jft+cqvo5nmJW5ei4oOLg55iMvisxhC3uR37HceOgK+T1
         s5wcECHnmZ/RqfbUgEpDME7YK94nHOwCGLaww6UwVBmSOtpLjsdOtpMcN6O+Q4NmeurY
         r4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685818351; x=1688410351;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vePfZj0VmfcpN9f2UHRADB0qcL+Jwy6NEMaozgbQ3jU=;
        b=iGNlQzMkps8xDILtPGLUpGrIUYmvh3DAbHY5OvyxVrljlGLDY06/w3hao0exGn++Lg
         Luv1VSslG8hAqB0dXE7A499Cm3mehW6gGVJKdCGduqcWVmGwggjGFa5fnxjMATnRq7OV
         F++Gzh1kbPDHygGqwAZqtzTNjITM+X4IO0bZS/hLAFB+lG+KmO5jLAJLV2vmpHnnkSrM
         +5awHOXl0LM6FclMYI/ujTzECvVCCcb+kV8NVlCpyY7K21l/bJOrxez8tkSJPXOTY/5t
         A65mJ0an8nRPbNB8RbcLdmEbHhl/Dd/HRF33ccedn3StaZxz9s54Znhq3ueVPoaoPTCV
         p1cA==
X-Gm-Message-State: AC+VfDxuUz8DEeW1VaRAxsjf+ZpYoVSx938mFlrpGd1IZEMbnGE1Catf
        8c3JWOFTVIqisMGyfHidxe3E5xVJH1jxAJfDQ9YQjXd1E/E=
X-Google-Smtp-Source: ACHHUZ4qIsm9N7GZj/Y1OJQmnWVsmPcgSu/YZ7N0qd1lY4E2vW+N69AL3jwB2LAuQAlmmHce8ZQZ9RTGOGZ/QKAmh+g=
X-Received: by 2002:a17:907:3e14:b0:973:344:6a39 with SMTP id
 hp20-20020a1709073e1400b0097303446a39mr2176621ejc.76.1685818351322; Sat, 03
 Jun 2023 11:52:31 -0700 (PDT)
MIME-Version: 1.0
From:   iker vagyok <ikervagyok@gmail.com>
Date:   Sat, 3 Jun 2023 20:52:19 +0200
Message-ID: <CANaSA1wZfn5Gxg_dU33WbamchVtWDU4GpXazn8ep-NJKGNaetA@mail.gmail.com>
Subject: Different sized disks, allocation strategy
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I am curious if the multiple disk allocation strategy for btrfs could
be improved for my use case. The current situation is:


# btrfs filesystem usage -T /
Overall:
    Device size:                  32.74TiB
    Device allocated:             15.66TiB
    Device unallocated:           17.08TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         15.57TiB
    Free (estimated):              8.58TiB      (min: 4.31TiB)
    Free (statfs, df):             6.12TiB
    Data ratio:                       2.00
    Metadata ratio:                   4.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

             Data    Metadata System
Id Path      RAID1   RAID1C4  RAID1C4  Unallocated Total    Slack
-- --------- ------- -------- -------- ----------- -------- -----
 2 /dev/sdc2 4.18TiB 13.00GiB 32.00MiB     4.91TiB  9.09TiB     -
 3 /dev/sda2       -  7.00GiB        -     2.72TiB  2.72TiB     -
 6 /dev/sde2       -  6.00GiB 32.00MiB     2.72TiB  2.72TiB     -
 8 /dev/sdb2 5.72TiB 13.00GiB 32.00MiB     3.37TiB  9.09TiB     -
 9 /dev/sdd2 5.71TiB 13.00GiB 32.00MiB     3.37TiB  9.09TiB     -
-- --------- ------- -------- -------- ----------- -------- -----
   Total     7.80TiB 13.00GiB 32.00MiB    17.08TiB 32.74TiB 0.00B
   Used      7.77TiB  9.95GiB  1.19MiB


As you can see, my server has 2*3TB and 3*10TB HDDs and uses RAID1 for
data and RAID1C4 for metadata. This works fine and the smaller devices
are even used for RAID1C4 (metadata), as there are not enough big
drives to handle 4 copies. But the smaller drives are not used for
RAID1 (data) until all bigger disks are filled (with <3TB remaining
free). Only then will all the disks take part in the raid setup.

I propose a simple change to the strategy where btrfs is still filling
up the big drives faster, but doesn't wait for ~7TB used on each big
drive, before it starts to use the 3TB drives as well. It would be
nice if all disks would be used corresponding to their relative free
space. IMO it wouldn't change the behavior for big setups with
same-sized devices and would make rebuilds and drive wear much easier
to anticipate on smaller setups. I browsed through the kernel code and
believe that this could be a very simple and contained change - but my
C knowledge is limited. Something in the ballpark of this:


diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 841e799dece5..db36c01a62be 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5049,6 +5049,14 @@ static int btrfs_cmp_device_info(const void *a,
const void *b)
        const struct btrfs_device_info *di_a =3D a;
        const struct btrfs_device_info *di_b =3D b;

+       if (di_a->total_avail > 0 && di_b->total_avail > 0)
+               {
+                       if (di_a->max_avail / di_a->total_avail >
di_b->max_avail / di_b->total_avail)
+                               return -1;
+                       if (di_a->max_avail / di_a->total_avail <
di_b->max_avail / di_b->total_avail)
+                               return 1;
+               };
        if (di_a->max_avail > di_b->max_avail)
                return -1;
        if (di_a->max_avail < di_b->max_avail)


What do you think about the proposal?

Thank you and best regards,
Bal=C3=A1zs
