Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D535E78F933
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjIAHio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAHio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 03:38:44 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4110F1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 00:38:38 -0700 (PDT)
Date:   Fri, 01 Sep 2023 07:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693553913; x=1693813113;
        bh=WYuyoPZBbRWXJJvwnyUJDSdJctxA6xr5hguki/7c3xs=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=ej2IgczKKgiPKcVLJX2ZqToRcF06wwvQDe7usbtUAa4UUVRid4OAeW/JIs9pfytN1
         pn8/zd8P8eCXiQ70Zw+YFMKQJBpCDnb0aPGk9mDd9Ke4GEAihT7k1oDj3IIXsyBEsD
         Ze77/nc/vvsW4vyFNsHCD4EbQ0QPV4XK8GXuduxuFh9hL6x93fxzCcdkyqC3KjiSiE
         /zJ09qWwQxnDiY6qos2lefu3pwG7hCWWHp1hZD3AEb0q978pCnxYqQnOaYBE+bv4eZ
         11qvJ+UrxhTVpbTrpQet9DzquSDi804AdnM7izIXg3CSl7TB27jW8vZ72eNLv+zi2Z
         Dk69xlc37AEpA==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   notrandom98234 <notrandom98234@protonmail.com>
Subject: Corrupted after multiple forceful shutdowns
Message-ID: <UwXYhs4amR33Eh6Hct6Rq0cpIRr0-Tjg4HvlpD1V9Q_6e9IhXcxxhbz6BUIrabFawS6wduY0Z6HgJSo9CEj1Vy1sIRugFRvLCDA43OUao3s=@protonmail.com>
Feedback-ID: 33659913:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey, I managed to break my btrfs again..
I had to forcefully shutdown multiple times (like 12+) due to a issue unrel=
ated to disk and now I can no longer mount btrfs....
The secondary disk gives "unsupported/invalid hardware sector size 4096" an=
d "ERROR: no btrfs on /dev/dm-2" when mounting but I hope that is only an i=
ssue on the kubuntu live environment..

-- diagnostic --
fi show:
Label: 'root'  uuid: 7e486848-9a64-4f36-abf1-cecb1b7c171e
        Total devices 1 FS bytes used 115.64GiB
        devid    1 size 223.26GiB used 153.02GiB path /dev/mapper/crypt

mount:
[  480.712140] BTRFS info (device dm-1): flagging fs with big metadata feat=
ure
[  480.712144] BTRFS info (device dm-1): using free space tree
[  480.712145] BTRFS info (device dm-1): has skinny extents
[  480.713920] BTRFS error (device dm-1): bad tree block start, want 103612=
416 have 17126188627709133626
[  480.714236] BTRFS error (device dm-1): bad tree block start, want 103612=
416 have 8743983881084155753
[  480.714242] BTRFS warning (device dm-1): couldn't read tree root
[  480.714533] BTRFS error (device dm-1): open_ctree failed

zero-log:
checksum verify failed on 103612416 wanted 0x42f43bde0ae40f0d found 0x0fd72=
531e6454ed0
checksum verify failed on 103612416 wanted 0x9895f43e1ff3d61a found 0x3cd6c=
30b4e62e77e
Couldn't read tree root
ERROR: could not open ctree


mount backuproot:
[  501.840688] BTRFS info (device dm-1): flagging fs with big metadata feat=
ure
[  501.840692] BTRFS warning (device dm-1): 'usebackuproot' is deprecated, =
use 'rescue=3Dusebackuproot' instead
[  501.840694] BTRFS info (device dm-1): trying to use backup root at mount=
 time
[  501.840695] BTRFS info (device dm-1): using free space tree
[  501.840696] BTRFS info (device dm-1): has skinny extents
[  501.842357] BTRFS error (device dm-1): bad tree block start, want 103612=
416 have 17126188627709133626
[  501.842644] BTRFS error (device dm-1): bad tree block start, want 103612=
416 have 8743983881084155753
[  501.842650] BTRFS warning (device dm-1): couldn't read tree root
[  501.842945] BTRFS critical (device dm-1): corrupt leaf: root=3D184467440=
73709551610 block=3D74006528 slot=3D0 ino=3D119572, invalid inode transid: =
has 45277 expect [0, 45276]
[  501.842950] BTRFS error (device dm-1): block=3D74006528 read time tree b=
lock corruption detected
[  501.843222] BTRFS critical (device dm-1): corrupt leaf: root=3D184467440=
73709551610 block=3D74006528 slot=3D0 ino=3D119572, invalid inode transid: =
has 45277 expect [0, 45276]
[  501.843225] BTRFS error (device dm-1): block=3D74006528 read time tree b=
lock corruption detected
[  501.843228] BTRFS warning (device dm-1): couldn't read tree root
[  501.844379] BTRFS error (device dm-1): parent transid verify failed on 8=
6867968 wanted 45273 found 45276
[  501.844659] BTRFS error (device dm-1): parent transid verify failed on 8=
6867968 wanted 45273 found 45276
[  501.844663] BTRFS warning (device dm-1): failed to read root (objectid=
=3D7): -5
[  501.844938] BTRFS critical (device dm-1): corrupt leaf: root=3D184467440=
73709551610 block=3D71024640 slot=3D0, invalid root generation, have 45277 =
expect (0, 45275]
[  501.844941] BTRFS error (device dm-1): block=3D71024640 read time tree b=
lock corruption detected
[  501.845210] BTRFS critical (device dm-1): corrupt leaf: root=3D184467440=
73709551610 block=3D71024640 slot=3D0, invalid root generation, have 45277 =
expect (0, 45275]
[  501.845212] BTRFS error (device dm-1): block=3D71024640 read time tree b=
lock corruption detected
[  501.845216] BTRFS warning (device dm-1): couldn't read tree root
[  501.845388] BTRFS error (device dm-1): open_ctree failed

btrfs check:
Opening filesystem to check...
checksum verify failed on 103612416 wanted 0x42f43bde0ae40f0d found 0x0fd72=
531e6454ed0
checksum verify failed on 103612416 wanted 0x9895f43e1ff3d61a found 0x3cd6c=
30b4e62e77e
checksum verify failed on 103612416 wanted 0x42f43bde0ae40f0d found 0x0fd72=
531e6454ed0
bad tree block 103612416, bytenr mismatch, want=3D103612416, have=3D1712618=
8627709133626
Couldn't read tree root
ERROR: cannot open file system
-- end diagnostic --
