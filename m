Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B3488EBD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 03:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiAJCpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jan 2022 21:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiAJCpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jan 2022 21:45:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3352C06173F
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jan 2022 18:45:19 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g14so5784277ybs.8
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Jan 2022 18:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=umcVBZ9DarDM7RtJpYQmR8G5p+Xtkllo3/fdus9p87Q=;
        b=Y134XhHQh07OnejGWGl2cWz8X7uiC1WE8T0H2aDGy8rQL60i8Z4vYAbOs7gTUiuWp3
         QbFDkr+zb+uiGtXaztgcq5oe/1ukghGu+8xwAedkHbkQhndnx85S3CMnxCPeDeeDNSfk
         BSqZyAd1zEIfC16D8kYrYPNAGRXv6KdDPJfQv4T1KNAQBSG2doMO5w508T+IWEBjJNyV
         9kkTMnOKa9nqWEo9OztFXLlZTI//iP7kZ+1KN2UTwXpT1Ld3H7oJsZ3u5oEwDKKxo0BZ
         zAChyTWStjTN0YTQRem0+YjoGkJ02kNgkQfhM/ZwNmvPaRgJ26d1DgrzpMnMLsTIRWIL
         1qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=umcVBZ9DarDM7RtJpYQmR8G5p+Xtkllo3/fdus9p87Q=;
        b=wUsg2MUhQJifql80j8XxHtcmKo7TXaqrFo2Uq/Q4XbxLraatss99dRXLJBqpFM6LQ+
         x7omgC3PsWAx5ZcmL9EYIQ3geL1OWIw7QJN/6EfvRwvNi+EtDYzisFhBU18fPcyCAna0
         gsTGoWOZDKwwICULoZuTBzgBbjcrQjR/D13mc7eybOB/kjEn3DGYf6c0C90kNm9ZnAIa
         H/TCgDwAVHuvjTz9nKtxBsD1Z2OLx9NKkqqXMpA2rXVscUkHqMbj51W2HMLXHSKpJF7p
         NSDWBSQf52VR7j7TWof72WVOKSBRGqmMlFWx0tcjWdOJk3pQ+rOj4BOGktKm6mDWIhvr
         r3lA==
X-Gm-Message-State: AOAM532qm94H3Z+DGKYwyNc9kGUaZufsLykPUROm5w8RBXYNWOVMI4Rk
        8JM+l9zREJnToBMX5HEWh0ZT6GtJgRapXBq4LYV5pv6Gp5w6IfOp
X-Google-Smtp-Source: ABdhPJyoFhOaVZ+NdYRlbPD9Y03oHk5DIX7UyUHe1lxAxXWBoTv4m5tm8rt177mseAuM0VgE8LZCp6ZarHu6eFo7yIg=
X-Received: by 2002:a25:cdc3:: with SMTP id d186mr93278557ybf.400.1641782718687;
 Sun, 09 Jan 2022 18:45:18 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 9 Jan 2022 19:45:02 -0700
Message-ID: <CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtTbXfOiKsGZxkPVb1g2srWg@mail.gmail.com>
Subject: btrfs send/receive segfault
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel-5.16.0-0.rc8.20220106git75acfdb6fd92.56.fc36.x86_64
btrfs-progs-5.15.1-1.fc35.x86_64

I'm seeing a crash during send/receive. The destination does have the
source subvol, but it lacks received UUID for some reason, so this
might be the instigating cause of the segmentation fault.

$ sudo btrfs send -p debris.20190114 debris.20220109 | sudo btrfs
receive /mnt/tsrif/
At subvol debris.20220109
At snapshot debris.20220109
ERROR: clone: did not find source subvol
Segmentation fault
$ sudo btrfs sub show /mnt/tsrif/debris.20190114/
debris.20190114
        Name:                   debris.20190114
        UUID:                   872216a7-658e-444b-9583-11378eea6703
        Parent UUID:            11cbf558-b602-6e4c-852f-6eb5efb672f1
        Received UUID:          -
        Creation time:          2019-01-14 12:24:11 -0700
        Subvolume ID:           3091
        Generation:             41292
        Gen at creation:        25612
        Parent ID:              5
        Top level ID:           5
        Flags:                  readonly
        Send transid:           0
        Send time:              2019-01-14 12:24:11 -0700
        Receive transid:        0
        Receive time:           -
        Snapshot(s):
                                debris.20220109
$ sudo btrfs sub show /mnt/first/debris.20190114/
debris.20190114
        Name:                   debris.20190114
        UUID:                   482659cd-c93a-5a4b-954d-6bee2fc7ce7e
        Parent UUID:            -
        Received UUID:          872216a7-658e-444b-9583-11378eea6703
        Creation time:          2020-05-06 12:19:55 -0600
        Subvolume ID:           422
        Generation:             5916
        Gen at creation:        462
        Parent ID:              5
        Top level ID:           5
        Flags:                  readonly
        Send transid:           564
        Send time:              2020-05-06 12:19:55 -0600
        Receive transid:        540
        Receive time:           2020-05-06 13:03:27 -0600
        Snapshot(s):


Jan 09 18:51:21 fnuc.local sudo[5393]:    chris : TTY=3Dpts/1 ;
PWD=3D/mnt/first ; USER=3Droot ; COMMAND=3D/usr/sbin/btrfs send -p
debris.20190114 debris.20220109
Jan 09 18:51:21 fnuc.local sudo[5394]:    chris : TTY=3Dpts/1 ;
PWD=3D/mnt/first ; USER=3Droot ; COMMAND=3D/usr/sbin/btrfs receive
/mnt/tsrif/
Jan 09 18:51:21 fnuc.local sudo[5394]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by (uid=3D1000)
Jan 09 18:51:21 fnuc.local sudo[5393]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by (uid=3D1000)
Jan 09 18:51:48 fnuc.local kernel: show_signal_msg: 4 callbacks suppressed
Jan 09 18:51:48 fnuc.local kernel: btrfs[5395]: segfault at 56 ip
000055939d4efc6d sp 00007ffeb50978a0 error 4 in
btrfs[55939d497000+9b000]
Jan 09 18:51:48 fnuc.local kernel: Code: 58 5a e9 4e fe ff ff 66 0f 1f
44 00 00 41 bd fe ff ff ff 48 8d 3d 33 82 06 00 31 c0 e8 bc bd fd ff
4d 85 ff 0f 84 96 fe ff ff <49> 8b 7f 58 e8 ba 81 fa ff 4c 89 ff e8 b2
81 fa ff e9 80 fe ff ff
Jan 09 18:51:48 fnuc.local audit[5395]: ANOM_ABEND auid=3D1000 uid=3D0
gid=3D0 ses=3D1 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c102=
3
pid=3D5395 comm=3D"btrfs" exe=3D"/usr/sbin/btrfs" sig=3D11 res=3D1
Jan 09 18:51:50 fnuc.local systemd[1]: Created slice Slice
/system/systemd-coredump.
Jan 09 18:51:50 fnuc.local audit: BPF prog-id=3D68 op=3DLOAD
Jan 09 18:51:50 fnuc.local audit: BPF prog-id=3D69 op=3DLOAD
Jan 09 18:51:50 fnuc.local audit: BPF prog-id=3D70 op=3DLOAD
Jan 09 18:51:50 fnuc.local systemd[1]: Started Process Core Dump (PID
5398/UID 0).
Jan 09 18:51:50 fnuc.local audit[1]: SERVICE_START pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dsystemd-coredump@0-5398-0 comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
Jan 09 18:51:51 fnuc.local systemd-coredump[5399]: [=F0=9F=A1=95] Process 5=
395
(btrfs) of user 0 dumped core.

                                                   Found module
linux-vdso.so.1 with build-id:
34559f148f176282c9dee6b448c7dbb357a60316
                                                   Found module
libgcc_s.so.1 with build-id: 88564abce789aa42536da1247a57ff6062d61dcb
                                                   Found module
ld-linux-x86-64.so.2 with build-id:
b43118df1fdb4c0aff150b6f8f926bccdec2a7f0
                                                   Found module
libc.so.6 with build-id: 644dac2c66a6e0b32674f0ec71e7431bd0c06a63
                                                   Found module
libzstd.so.1 with build-id: 0f6e793c8bbdb5bb5683c5b9e61aadfcb7a7454a
                                                   Found module
liblzo2.so.2 with build-id: c83f77cc751de75374d5763f4f3a6c483fb2f738
                                                   Found module
libz.so.1 with build-id: 5903f5c355c264403e4e7cdc66779584425ca3b8
                                                   Found module
libudev.so.1 with build-id: 7422938010fad35c79a9a6cb017799a1cc575e7f
                                                   Found module
libblkid.so.1 with build-id: 96be27216d8d6d7ba3694ca503cd1b07f60fa539
                                                   Found module
libuuid.so.1 with build-id: 2dee14d2566e86111e3f0a235ad58a0f27b8f826
                                                   Found module btrfs
with build-id: 92f57ed8ec33cf3c8979c29ccfe55cd3a6e19996
                                                   Stack trace of thread 53=
95:
                                                   #0
0x000055939d4efc6d process_clone (btrfs + 0x6ec6d)
                                                   #1
0x000055939d4d2d4c btrfs_read_and_process_send_stream (btrfs +
0x51d4c)
                                                   #2
0x000055939d4f0e41 cmd_receive.lto_priv.0 (btrfs + 0x6fe41)
                                                   #3
0x000055939d498c9d main (btrfs + 0x17c9d)
                                                   #4
0x00007fc3eb8f8560 __libc_start_call_main (libc.so.6 + 0x2d560)
                                                   #5
0x00007fc3eb8f860c __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x2d60c)
                                                   #6
0x000055939d498ff5 _start (btrfs + 0x17ff5)


result from coredumpctl gdb, thread apply all bt full
https://drive.google.com/file/d/1exrFFYEtgDs8BEkt1JWbNWUaQOSDRolc/view?usp=
=3Dsharing


--=20
Chris Murphy
