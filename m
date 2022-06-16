Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D151254DAC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359198AbiFPGfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359133AbiFPGfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 02:35:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899856B2C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 23:35:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31772f8495fso3848897b3.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chary.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ffop07+pV4/r147mTLt0wIVwUKtH5NpdwNMadLLUB3Y=;
        b=m4BAuar2kcY10d70/HlYbZNl8mwcuU73WNRhDOan3aNvFXbe0G7AqYVmesUcJAkIPm
         qYfCywF96OYfpnoDeLBiM5aIZKwK6RSQwCR5RNd5S8aP75tHdifNexIJUuDsuqgRNYYV
         BldIlE9GsRMSWRM5iLZt9n9GKfSJq4v+vRpVL1axRP03FmOnjqezoCBWwoA/oSC/Hvtg
         7KMIzcyXTuxivYXEtYgqpNdOQhFgJ1r56uYWG2WYuUkZhG0KdbuQrNPTnVggqSAMBcIw
         6IiZ8W9i9nI7RfrWGb8Ft2zpxVZV2whNeNOBi6l+AhDjWljCUSCgeD5abzGsZSDmMsEA
         MTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ffop07+pV4/r147mTLt0wIVwUKtH5NpdwNMadLLUB3Y=;
        b=azBZtrzqoZaCbw1vxEkLmJEqh0BhlwM7R6CLHw0igwTjbaR5t8m3UwkFBxJmDg0UyI
         7rleqx6HDmypJ6XEn0/j6jy2L5NZSzFaXQytYK2BX/jyqRN72KZI2wZZcSbFGzyFt2UV
         lEVlSm8xRtUFXCRp2KM7pxtMkXmRX8bgnSh2+TdhSBKGxg3MTKXEUntyp4TUhhkhdAYc
         CZHPQt3SXXjA6Q1pdItYz9D11RS+iQq173Kl2wr1Z3/4UgLeXcLAA0X969H0Ez0mtwhM
         dJSBj1COYmfHtzEOnrvE3/Ss5VXJNmTZfzeooV8+1hR92VBc2OHq9md8pbimLCMbtMXf
         RntA==
X-Gm-Message-State: AJIora+WE7keoYSfccBVFyiS3iHST0Pqwpd7tSW8ZOBjpbEv2PcdDyrA
        qi6GCDXvzLRTuBvYzwN3emg0p2BeEPrt8M7asQXC1ZRvEXYgGQ==
X-Google-Smtp-Source: AGRyM1sfvRLMDokOYrws4DPfaVkp2xBy6UFb8P+T4MBQBmQT82dXITX4TQEXNclo0xzrP72PcTy65tssK8MabFYPLKk=
X-Received: by 2002:a0d:d386:0:b0:314:65f9:f9bf with SMTP id
 v128-20020a0dd386000000b0031465f9f9bfmr3889513ywd.370.1655361334067; Wed, 15
 Jun 2022 23:35:34 -0700 (PDT)
MIME-Version: 1.0
From:   Zachary Bischof <z@chary.io>
Date:   Wed, 15 Jun 2022 23:35:08 -0700
Message-ID: <CAORbthAd1ibxvQ00poJeByvTngNtDAtSeL6BcfUuaAN2c97CrA@mail.gmail.com>
Subject: Repeating csum errors on block group with increasing inode id
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,

I'm running into some issues when I try to delete or resize a device
in a RAID 6 data volume (RAID1C4 metadata). Basically, when I run a
delete or resize command on this device, it tries to relocate a
particular block group but hits a csum error. If I re-run the command,
it finds a csum error in the same block group but with the inode
increased by one. The csum errors occur on root -9, which from the
btrfs wiki/mailing list I've figured out is the reloc tree. Here is a
sample of relevant logs from dmesg:

[  203.248225] BTRFS info (device sdo): resizing devid 8
...
[  809.703041] BTRFS info (device sdo): relocating block group
185056628310016 flags data|raid6
[  833.688667] btrfs_print_data_csum_error: 337 callbacks suppressed
[  833.688669] btrfs_dev_stat_print_on_error: 15 callbacks suppressed
[  833.688681] BTRFS warning (device sdo): csum failed root -9 ino 280
off 9034416128 csum 0x63066980 expected csum 0x5764eda5 mirror 1
[  833.688681] BTRFS error (device sdo): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 150, gen 0
[  833.688749] BTRFS error (device sdo): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 151, gen 0
[  833.689485] BTRFS warning (device sdo): csum failed root -9 ino 280
off 9034420224 csum 0x5d9a36af expected csum 0x5b59723b mirror 1
[  833.689497] BTRFS error (device sdo): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 152, gen 0
..
[ 1387.923903] BTRFS info (device sdo): resizing devid 8
[ 1388.094073] BTRFS info (device sdo): relocating block group
185056628310016 flags data|raid6
[ 1410.117987] btrfs_print_data_csum_error: 337 callbacks suppressed
[ 1410.117996] BTRFS warning (device sdo): csum failed root -9 ino 281
off 9033695232 csum 0x406573b2 expected csum 0x286f7488 mirror 1
[ 1410.118008] btrfs_dev_stat_print_on_error: 15 callbacks suppressed
[ 1410.118011] BTRFS error (device sdo): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 157, gen 0
[ 1410.118020] BTRFS warning (device sdo): csum failed root -9 ino 281
off 9034416128 csum 0x63066980 expected csum 0x5764eda5 mirror 1
[ 1410.121966] BTRFS error (device sdo): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 158, gen 0
[ 1410.122623] BTRFS warning (device sdo): csum failed root -9 ino 281
off 9033699328 csum 0x08248cb7 expected csum 0xf7931ed7 mirror 1
[ 1410.125626] BTRFS error (device sdo): bdev /dev/sdj errs: wr 0, rd
0, flush 0, corrupt 159, gen 0

This continued for the next dozen or so consecutive inodes. I've used
inspect-internal to check a few inodes at random and for all the
inodes that I've checked that point to files (a number referred to
directories) I've run a diff against copies on a backup and found no
differences (though now I'm wondering if a corrupted file was copied
to this particular backup). As a side note, I did switch to
space_cache=v2 since this volume was created. In a previous message
regarding negative root numbers (-9) on the mailing list, Qu suggested
running scrub to find the offending file, but running scrub on this
device completes without finding any errors. I'm still running scrub
on the other devices (one at a time) but have yet to find any errors.
The high counter number for "corrupt" in the error messages above is
from me repeatedly trying unsuccessfully to see if using any other
commands will get around this problematic block group.

Anyway, I'd appreciate any suggestions on next steps to delete the
device. Is there a way to clear out the reloc tree (if this makes
sense)? I was wondering if the inode in the error messages has moved
to the next inode because the previous was repaired when read? Would
it make sense to repeatedly try to delete/resize the device until it
gets through all the inodes in this block group? At this point I've
seen dozens of errors like this, but wasn't sure if I should stop. If
this approach does make sense, is there a way to monitor progress
(e.g., a list of all the inodes in this block group)? Alternatively,
should I consider it a lost cause and reformat?

Apologies if answers to any of these questions were already covered
somewhere else.

Cheers,
Zachary
