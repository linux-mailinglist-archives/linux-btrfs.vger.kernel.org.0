Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE69973CD7E
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jun 2023 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjFXXrH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jun 2023 19:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFXXrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jun 2023 19:47:06 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02BAD
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 16:47:05 -0700 (PDT)
Date:   Sat, 24 Jun 2023 23:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687650421; x=1687909621;
        bh=L5eWkpu0L1EZBLANFTWtZl2j3h7ujc7XuC3wGGxzzus=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=KjUsLmerAbTSJr9xYFdHdELzunq70nuTJ7NxJmx6jQCeIzkO9tKQvGly1rusxs7aO
         GD1dSuu/lu24oUUm98rebsg/6ZiWqGmMn6n9jOeOtb4d0JxdcOqS/Ircv8V35oFwx+
         IY1CZstSXIMB5Nlv9NIVQDgc8lkbk0/rnBqpzXAlHE8WW2r7S1y/Tz7wZx+6mfcuH+
         WnbLcBfdzVTHTkiasBNgFMYO4S6IcAdq5jIAGctoxZLQEl7LfZFh7gTz6CRPpkPY+m
         EaAWI76MUU4coho3vnkTVE3/LLEGrmOB2VQrifGoQyohFxuKNFuvYiB83jaJx9+euE
         ildIljtHV/P1A==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   notrandom98234 <notrandom98234@protonmail.com>
Subject: Btrfs shrink user failure
Message-ID: <7C4AZLXJxx6RBljNuhgqY7rfGiHUD9OZJKFLaR1MGbEzcvKSFAh_3arLVskVMfHkbnt7VA6y_YXbZg_eQ5R0UKSZytj_8X_yAUj8wXu40Ys=@protonmail.com>
Feedback-ID: 33659913:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,I shrank my btrfs too much, and now=C2=A0btrfs seems to be missing 2.1 M=
B of data at the end.

[23368.040870] BTRFS: device label endeavouros devid 1 transid 22521 /dev/d=
m-0 scanned by (udev-worker) (144690)[23463.852308] BTRFS info (device dm-0=
): using crc32c (crc32c-intel) checksum algorithm
[23463.852342] BTRFS info (device dm-0): using free space tree
[23463.877154] BTRFS error (device dm-0): device total_bytes should be at m=
ost 442379534336 but found 442381631488
[23463.877187] BTRFS error (device dm-0): failed to read chunk tree: -22
[23463.878731] BTRFS error (device dm-0): open_ctree failed


Opening filesystem to check...Checking filesystem on /dev/mapper/luks
UUID: ed20b6bd-ac51-403a-b2d6-3797de4ea122
[1/7] checking root items
[2/7] checking extents
ERROR: block device size is smaller than total_bytes in device item, has 44=
2379534336 expect >=3D 442381631488
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 98553413632 bytes used, error(s) found
total csum bytes: 95213404
total tree bytes: 829259776
total fs tree bytes: 661422080
total extent tree bytes: 47677440
btree space waste bytes: 163491925
file data blocks allocated: 187938603008
=C2=A0referenced 111398690816

btrfs-progs v6.3
Label: 'endeavouros' =C2=A0uuid: ed20b6bd-ac51-403a-b2d6-3797de4ea122
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 91.78GiB
=C2=A0 =C2=A0 =C2=A0 =C2=A0 devid =C2=A0 =C2=A01 size 412.00GiB used 96.02G=
iB path /dev/mapper/luks
