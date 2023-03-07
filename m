Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7226AF900
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 23:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCGWjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCGWjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 17:39:21 -0500
Received: from a48-112.smtp-out.amazonses.com (a48-112.smtp-out.amazonses.com [54.240.48.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99FA2189
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 14:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=wkxprsfqo3bnmdtpdm6y55lcwbvdwiri; d=corrosivetruths.org;
        t=1678228455;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        bh=QZWOcF6lUpYmBrfN31JhwkvfV6HDpaimOIGKvktl2dI=;
        b=Hs9thb/NFW0HIw0lMXaX+zIaBYNKR57gKFDTkul7lQ8bSiy00H1WE1YE4A2C8jJE
        Xm4d9PN9Uz3IXlMcZv9ipGlqNpxlAw9VwUmI0R35Nwsw5pjYfKpbCT44WecctrlKaKn
        oXLIf9OJpuIAYzWU7ULFOpfUHSuoltDJCB11H/c8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1678228455;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:Feedback-ID;
        bh=QZWOcF6lUpYmBrfN31JhwkvfV6HDpaimOIGKvktl2dI=;
        b=i5ykPCN6g6Tc639nrJRjHOFplzmICasBPxmVk6HzWnOHrI0dLU+dqZHZ+HYuTeUF
        I18FSFFz97VqehGhrvFDuT8Y7gx2VGkV1S7EM4mrZAgR/gQKhHA120dacrvDMpMH6k3
        OW3Sh2P5ydNfjbIH/1ftlSaOFx7M0vDz3uaXuAW4=
X-Gm-Message-State: AO0yUKXtLC7uIZyAnLFLUxANEaW/cidvkQLgdm2IoJJTsLzMWStUtlWH
        c+Ru/+1TIElcgA1kNfTWdQUjbtNT5Tv81se8kSY=
X-Google-Smtp-Source: AK7set/3n4a5ZP7AselLnIx1QhiTkJkhfsEeORoQpN42wKzMKuGuU2yFetsiuQLgzK2z3nS+5uDH3s9nY5lIe97IyCE=
X-Received: by 2002:a17:90a:e28d:b0:237:2516:f76a with SMTP id
 d13-20020a17090ae28d00b002372516f76amr6018739pjz.2.1678228453886; Tue, 07 Mar
 2023 14:34:13 -0800 (PST)
MIME-Version: 1.0
From:   Peter Robertson <Peter@corrosivetruths.org>
Date:   Tue, 7 Mar 2023 22:34:14 +0000
X-Gmail-Original-Message-ID: <CALkQC7AnCvD==feSqk6Ej_tgZRj9c0KRthO3AiBdU9ZeunL2cg@mail.gmail.com>
Message-ID: <01000186be35fe14-2fa48fef-0749-4b63-be82-a02a85cd3024-000000@email.amazonses.com>
Subject: Uneven raid1 allocation on current longterm kernel (6.1)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Feedback-ID: 1.us-east-1.0GUZPCeaMsyB/T+GFHfEuGhg70RD9nDE8t0u6z88p78=:AmazonSES
X-SES-Outgoing: 2023.03.07-54.240.48.112
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

Recently moved from last longterm to current longterm kernel. The
unallocated space isn't evening out like it was under 5.15

Base state is this:

Overall:
   Device size:                  12.74TiB
   Device allocated:              7.55TiB
   Device unallocated:            5.18TiB
   Device missing:                  0.00B
   Device slack:                    0.00B
   Used:                          7.42TiB
   Free (estimated):              2.66TiB      (min: 1.79TiB)
   Free (statfs, df):             2.39TiB
   Data ratio:                       2.00
   Metadata ratio:                   3.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                  no

           Data      Metadata System
Id Path     RAID1     RAID1C3  RAID1C3   Unallocated Total    Slack
-- -------- --------- -------- --------- ----------- -------- -----
8 /dev/sda   2.47TiB  4.00GiB  32.00MiB     1.16TiB  3.64TiB     -
9 /dev/sdb   2.47TiB  3.00GiB         -     1.16TiB  3.64TiB     -
10 /dev/sdc   1.94TiB  5.00GiB  32.00MiB     1.69TiB  3.64TiB     -
11 /dev/sdd 668.00GiB  3.00GiB  32.00MiB     1.16TiB  1.82TiB     -
-- -------- --------- -------- --------- ----------- -------- -----
  Total      3.77TiB  5.00GiB  32.00MiB     5.18TiB 12.74TiB 0.00B
  Used       3.70TiB  4.19GiB 560.00KiB

After fallocate'ing 2400g I get:

Overall:
   Device size:                  12.74TiB
   Device allocated:             12.24TiB
   Device unallocated:          505.99GiB
   Device missing:                  0.00B
   Device slack:                    0.00B
   Used:                         12.11TiB
   Free (estimated):            320.93GiB      (min: 236.60GiB)
   Free (statfs, df):            90.91GiB
   Data ratio:                       2.00
   Metadata ratio:                   3.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                  no

           Data    Metadata System
Id Path     RAID1   RAID1C3  RAID1C3   Unallocated Total    Slack
-- -------- ------- -------- --------- ----------- -------- -----
8 /dev/sda 3.18TiB  4.00GiB  32.00MiB   466.99GiB  3.64TiB     -
9 /dev/sdb 3.62TiB  3.00GiB         -    16.02GiB  3.64TiB     -
10 /dev/sdc 3.62TiB  5.00GiB  32.00MiB    16.99GiB  3.64TiB     -
11 /dev/sdd 1.81TiB  3.00GiB  32.00MiB     5.99GiB  1.82TiB     -
-- -------- ------- -------- --------- ----------- -------- -----
  Total    6.11TiB  5.00GiB  32.00MiB   505.99GiB 12.74TiB 0.00B
  Used     6.05TiB  4.19GiB 896.00KiB

Leaving 233GiB unusable, whereas under 5.15 the unallocated space
would even out so I could write to the very end of the array.

Unfortunately I can't show the actual result under 5.15 as the fs is
block-group-tree enabled. Not sure where to go from here. I want to
file a good bug to allow this to be fixed so would appreciate advice &
commentary, especially on how to investigate this to give a better bug
report if that's possible.

Devid: 8 started off half full with single data, then filled the rest
of the way with (two devices at the time) raid1 data before balancing
the single data as raid1 over the rest of the array (then four
devices), so it's probably more full at the end than the beginning of
the device, but figured only the unallocated space is important? This
is the only thing that stands out about dev 8.

Here is an example of from before I converted this system to use
block-group-tree:
https://www.reddit.com/r/btrfs/comments/103wn7e/uneven_raid1_allocation_on_nonlts_kernel/

Linux Portal 6.1.12-gentoo-dist #1 SMP PREEMPT_DYNAMIC Tue Feb 28
08:41:06 GMT 2023 x86_64 Intel(R) Core(TM) i5-4440 CPU @ 3.10GHz
GenuineIntel GNU/Linux
btrfs-progs v6.1.2
$ journalctl -k -g btrfs (snipped for relevant fs)
Mar 07 21:54:16 gentoo kernel: Btrfs loaded, crc32c=crc32c-generic,
zoned=yes, fsverity=yes
Mar 07 21:54:16 gentoo kernel: BTRFS: device label Store devid 9
transid 809455 /dev/sdb scanned by systemd-udevd (359)
Mar 07 21:54:16 gentoo kernel: BTRFS: device label Store devid 11
transid 809455 /dev/sdd scanned by systemd-udevd (369)
Mar 07 21:54:16 gentoo kernel: BTRFS: device label Store devid 10
transid 809455 /dev/sdc scanned by systemd-udevd (358)
Mar 07 21:54:16 gentoo kernel: BTRFS: device label Store devid 8
transid 809455 /dev/sda scanned by systemd-udevd (370)
Mar 07 21:54:23 Portal kernel: BTRFS info (device sda): using crc32c
(crc32c-intel) checksum algorithm
Mar 07 21:54:23 Portal kernel: BTRFS info (device sda): using free space tree
