Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10884B321B
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 01:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354454AbiBLAm3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 19:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiBLAm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 19:42:28 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA27D7F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 16:42:26 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qk11so5657360ejb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 16:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+QOlDqIXOVlojMTV6ofaPHn84LiN3rB8h+7jGqZbHQs=;
        b=krkw9wHdiGhpzbmKtgQsmUIvE/dLwDWvwwsPmh4YURyiqvIjXYguj0XBIZf5vy103/
         Yi5DyW9e2wwVePkCZ6HnfnMQTbIqsJpIuCbGPW9jJZ4N/A13rzwiNNrdQw3XKNgLFl6s
         c8mNpkLf+N2/0bAr7Z1ms+iR1iGWtNzXwIVhhK0ZIllXLfXjfYQo6HKyOElpvPzvsZ8m
         vWUf2591OgemYbSQkjtwWIj3xOk3uG6r6Ku1mesttuiRKon29mNowVEl1tHwVFI3DyYl
         sQfMAgOdzriBQT/2z6tylQDTq94/pZERh9GdS6phzqbOmm9J7hzIbr7clWcQIruCBCFR
         Cf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+QOlDqIXOVlojMTV6ofaPHn84LiN3rB8h+7jGqZbHQs=;
        b=1qAt60uPJnlcXytOXWS10S0Z+AfJt5TQVdM9xU0iukBq1EcUGVfrjxd11K99z4VQbe
         a/Q6LW0K8HXrZMFkniB5BpMGh8vMaz/yOqMcfH+nSO7XSjX0h4ZaN9UEDFy7KnYp9Rjx
         LSkmD0Whe84DP4W6Z3GadB2QMNb92ZZ4vPnmxXv5n3nZCTEyFvdMWY68P7Tu+EoSEb39
         TGtxDcu104TOmMx2btFejAiaNN2zaCTbEhPQSf3rMMd95rBAOzch2KDleaSSvu+Z0fGA
         a0UvVUaclwYO5w7h1+b2fRTUF+i9G6n+s9+gRhfTvhGs/w/Vdic5CGVwHoJK5TlM1GNO
         u+pQ==
X-Gm-Message-State: AOAM530E3jvNAylMz3YMXrOw6HHRF/Rnrs4i89B0IImDPrMvbWddPdQV
        atI2xrwGwbpmGDKd/VBbIkV80ntTp/H7UKtMT7RkL3FIb0iLBA==
X-Google-Smtp-Source: ABdhPJwv4AGL14tJ4WdR0MxmpP8/+N8DlqGElMykcw9REemdBDTVytJuhxOpTxK2qnTK2GaxD0bxwlf2KmoAQas7NPM=
X-Received: by 2002:a17:906:778f:: with SMTP id s15mr3031377ejm.437.1644626544562;
 Fri, 11 Feb 2022 16:42:24 -0800 (PST)
MIME-Version: 1.0
From:   Gowtham <trgowtham123@gmail.com>
Date:   Sat, 12 Feb 2022 06:12:13 +0530
Message-ID: <CA+XNQ=hiF0us76Odk=0Kc5d2qoviY2OL2+KJnkJUSRjozGRGwg@mail.gmail.com>
Subject: BTRFS FS options on eMMC
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

We are using BTRFS on eMMC as our application needs it. It is fairly stable.

Seeing errors like below when we powercycle the box (which cannot be
avoid for our test case but done occasionally)

Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.
Begin: Running /scripts/local-premount ... [    4.334033] Btrfs
loaded, crc32c=crc32c-generic
Scanning for Btrfs filesystems
[    4.390977] BTRFS: device label rpool devid 1 transid 64872 /dev/mmcblk0p2
done.
Begin: Will now check root file system ... fsck from util-linux 2.34
[/usr/sbin/fsck.btrfs (1) -- /dev/mmcblk0p2] fsck.btrfs -a /dev/mmcblk0p2
done.
[    4.448780] BTRFS info (device mmcblk0p2): disk space caching is enabled
[    4.448801] BTRFS info (device mmcblk0p2): has skinny extents
[    4.464891] BTRFS info (device mmcblk0p2): enabling ssd optimizations
[    4.464915] BTRFS info (device mmcblk0p2): start tree-log replay
[    4.485747] BTRFS: error (device mmcblk0p2) in
btrfs_replay_log:2287: errno=-22 unknown (Failed to recover log tree)
[    4.485794] BTRFS info (device mmcblk0p2): delayed_refs has NO entry
[    4.579954] BTRFS error (device mmcblk0p2): open_ctree failed
mount: mounting /dev/mmcblk0p2 on /root failed: Invalid argument

Q: I would like to know what are the proper BTRFS FS options that we
can use for mmcblk devices and if the below options would suffice.

BTRFS details

Feb 10 15:03:06  kernel: [    0.974788] mmcblk0: mmc0:0001 S0J58X 59.3 GiB

And current options used are

# mount -t btrfs
/dev/mmcblk0p2 on / type btrfs
(rw,noatime,compress=lzo,ssd,flushoncommit,space_cache,subvolid=264,subvol=/@/netvisor-1)
/dev/mmcblk0p2 on /home type btrfs
(rw,nodev,noatime,compress=lzo,ssd,flushoncommit,space_cache,subvolid=257,subvol=/@home)
/dev/mmcblk0p2 on /var/nv/log type btrfs
(rw,noatime,compress=lzo,ssd,flushoncommit,space_cache,subvolid=258,subvol=/@var_nv_log)

Kernel: Latest 5.4.x on Ubuntu 20.04

Regards,
Gowtham
