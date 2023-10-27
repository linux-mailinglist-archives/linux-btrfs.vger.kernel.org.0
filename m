Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14C7D9C7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjJ0PFB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjJ0PFB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 11:05:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7BC4
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 08:04:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso327279066b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698419096; x=1699023896; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uxzzm19NNglQuW/+K7VNjscbS97wXIRPx7RdEjcWRww=;
        b=A7JH9hKQqyT2779YVF50CMBf5kUyG5pTUUtYCaYUDJxKn7Xmt60rJtAcLFYwojdEys
         ngUyIq8Rr/QpwJwLnBw0aewsvklUz3s02+pHhazTUEguhj/kyNmXLy9Tf9xmpiT7ZCRC
         czeKc64bDRuDmMhWJmM+ce/8QNTO+Z2AcAAUk2SKahxHDRxAqldh2hzpGH21lgHYZPTw
         0KPJd9EfMv7goZykGW9Hw9rcA0lGOOVVmVg7WHGOruaTElFLeT+G0RpeCXvxRNp5fIeS
         M3q32i0+/qwq4nOwuiQC6V5nvXfZeUhw6HgxDL1Kvh7d7eu/uYSqM+uC8Erv2Y0SFih2
         DIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698419096; x=1699023896;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uxzzm19NNglQuW/+K7VNjscbS97wXIRPx7RdEjcWRww=;
        b=vW48vJ6YRBQlNxIabRwWWEfXpLCuasO8iGRX1QMuAai4mhVQY+00PPMdAgdqmecaa7
         PxxyNjbPE0VHIVspp2kGo/zof1/vqDY7r1YUp9csxf7YCyuqhEYBh5dBUalZCyKxyJpE
         OY/iFTXAygXiWxgmlFDDw75ehgwOuKdlQqxlNl0ERvRswbHa0tc5V2tkZ96oosz9ab2M
         80qSc56CQoqIKlGKgvjArfUJQkrOg3O/FAF6Zt5ylImICVE58h9J6gfBTWULU/EXu0Ad
         ImYeekOnCdTs6YIfV3v/oehTmWbik6v3mECZPgi9Y09wWVtJUiyLNB6tBIlhEGJWj2fl
         Zueg==
X-Gm-Message-State: AOJu0YwMnmbzQeRseKvETcuCw5XVhz3+MqIZBeDx2Am+4vBzZLaJQ7UQ
        T7z9znFifoIQ/jgsWlnEMHEBx+9F2LFiyMxNnT8D1IqD+5M=
X-Google-Smtp-Source: AGHT+IGe+c4C93ySAxq+lo+INL+a3O+CdyigFOyllJoX+TJeNYB7Emfz82kxqOa5e/b/nMSQdCS6Q8XtsySBK2xZQfo=
X-Received: by 2002:a17:907:cbc4:b0:9d0:6108:9944 with SMTP id
 vk4-20020a170907cbc400b009d061089944mr1464637ejc.43.1698419095931; Fri, 27
 Oct 2023 08:04:55 -0700 (PDT)
MIME-Version: 1.0
From:   "Werner I." <theweio@gmail.com>
Date:   Fri, 27 Oct 2023 17:04:44 +0200
Message-ID: <CAFYMhu0VRKCZOFE3AUKpY6zRftqFTQ6dpsa4sVpYyBhxNHLTYQ@mail.gmail.com>
Subject: Help with USB HD needed
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

after a power outage one of my btrfs formatted USB HDs can't be mounted anymore.
A btrfs check gives me:
btrfs check /dev/sdb
Opening filesystem to check...
checksum verify failed on 2896434544640 wanted 0x49cf072e found 0x3837717b
checksum verify failed on 2896434544640 wanted 0x49cf072e found 0x3837717b
Csum didn't match
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

I tried mounting it with rescue options to no avail.
The data on it is not crucial but would be very nice to have back. I
should have copies on an decommissioned server but that would be a
pain to set up.
Help would be very much appreciated. I did NOT use the repair command!

Here is the output of the questionnaire from the wiki:
Linux omvn100 6.2.16-11-bpo11-pve #1 SMP PREEMPT_DYNAMIC PVE
6.2.16-11~bpo11+2 (2023-09-04T14:49Z) x86_64 GNU/Linux
btrfs-progs v5.16.2

Label: none  uuid: 1397d17c-5789-47a8-958c-c603f7b47365
        Total devices 1 FS bytes used 13.19TiB
        devid    1 size 16.37TiB used 13.21TiB path /dev/sda

Label: none  uuid: 6d5c6ae1-86df-4863-9ef4-19d4e5bc05e7
        Total devices 1 FS bytes used 3.59TiB
        devid    1 size 4.55TiB used 3.60TiB path /dev/sdc

Label: none  uuid: 359cd817-936a-4451-9dc7-e8ee7910a448
        Total devices 1 FS bytes used 3.95TiB
        devid    1 size 4.55TiB used 3.95TiB path /dev/sdb

[    4.729108] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
devid 1 transid 444227 /dev/sdb scanned by systemd-udevd (306)
[    4.866283] BTRFS info (device sdb): using crc32c (crc32c-intel)
checksum algorithm
[    4.866291] BTRFS info (device sdb): disk space caching is enabled
[    4.921450] BTRFS warning (device sdb): checksum verify failed on
logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
level 0
[    4.921461] BTRFS error (device sdb): failed to read block groups: -5
[    4.922819] BTRFS error (device sdb): open_ctree failed
[    5.307709] BTRFS: device fsid 6d5c6ae1-86df-4863-9ef4-19d4e5bc05e7
devid 1 transid 7866 /dev/sdc scanned by systemd-udevd (307)
[    5.391947] BTRFS info (device sdc): using crc32c (crc32c-intel)
checksum algorithm
[    5.391954] BTRFS info (device sdc): using free space tree
[    7.983815] r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full -
flow control rx/tx
[    7.983825] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
[    8.432017] audit: type=1326 audit(1698404351.369:2):
auid=4294967295 uid=65534 gid=65534 ses=4294967295 subj=unconfined
pid=777 comm="node" exe="/usr/local/bin/node" sig=0 arch=c000003e
syscall=324 compat=0 ip=0x7fa3b2807152 code=0x50000
[    8.805952] audit: type=1326 audit(1698404351.741:3):
auid=4294967295 uid=65534 gid=65534 ses=4294967295 subj=unconfined
pid=840 comm="node" exe="/usr/local/bin/node" sig=0 arch=c000003e
syscall=324 compat=0 ip=0x7f9d7d23f152 code=0x50000
[   26.539848] audit: type=1326 audit(1698404369.477:4):
auid=4294967295 uid=65534 gid=65534 ses=4294967295 subj=unconfined
pid=873 comm="node" exe="/usr/local/bin/node" sig=0 arch=c000003e
syscall=324 compat=0 ip=0x7fcfd93d5152 code=0x50000
[   54.280616] BTRFS info (device sdc): auto enabling async discard
[   54.581643] Initializing XFRM netlink socket
[   54.963182] br-ad8d222d3210: port 1(vethd61e22d) entered blocking state
[   54.963187] br-ad8d222d3210: port 1(vethd61e22d) entered disabled state
[   54.963270] device vethd61e22d entered promiscuous mode
[   54.963609] br-ad8d222d3210: port 1(vethd61e22d) entered blocking state
[   54.963613] br-ad8d222d3210: port 1(vethd61e22d) entered forwarding state
[   54.963951] IPv6: ADDRCONF(NETDEV_CHANGE): br-ad8d222d3210: link
becomes ready
[   54.964030] br-ad8d222d3210: port 1(vethd61e22d) entered disabled state
[   56.496029] eth0: renamed from veth003002b
[   56.527852] IPv6: ADDRCONF(NETDEV_CHANGE): vethd61e22d: link becomes ready
[   56.527880] br-ad8d222d3210: port 1(vethd61e22d) entered blocking state
[   56.527883] br-ad8d222d3210: port 1(vethd61e22d) entered forwarding state
[   94.658751] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
devid 1 transid 444227 /dev/sdb scanned by mount (5159)
[   94.660625] BTRFS info (device sdb): using crc32c (crc32c-intel)
checksum algorithm
[   94.660632] BTRFS info (device sdb): disk space caching is enabled
[   94.715833] BTRFS warning (device sdb): checksum verify failed on
logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
level 0
[   94.715843] BTRFS error (device sdb): failed to read block groups: -5
[   94.717287] BTRFS error (device sdb): open_ctree failed
[  500.689477] audit: type=1326 audit(1698404843.392:5):
auid=4294967295 uid=65534 gid=65534 ses=4294967295 subj=unconfined
pid=14849 comm="node" exe="/usr/local/bin/node" sig=0 arch=c000003e
syscall=324 compat=0 ip=0x7ff8e0fc0152 code=0x50000
[  914.697510] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
devid 1 transid 444227 /dev/sdb scanned by mount (15368)
[  914.699197] BTRFS info (device sdb): using crc32c (crc32c-intel)
checksum algorithm
[  914.699205] BTRFS warning (device sdb): 'recovery' is deprecated,
use 'rescue=usebackuproot' instead
[  914.699207] BTRFS info (device sdb): trying to use backup root at mount time
[  914.699208] BTRFS info (device sdb): disk space caching is enabled
[  914.754095] BTRFS warning (device sdb): checksum verify failed on
logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
level 0
[  914.754106] BTRFS error (device sdb): failed to read block groups: -5
[  914.755479] BTRFS error (device sdb): open_ctree failed
[ 1339.551770] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
devid 1 transid 444227 /dev/sdb scanned by mount (15754)
[ 1339.553887] BTRFS info (device sdb): using crc32c (crc32c-intel)
checksum algorithm
[ 1339.553895] BTRFS warning (device sdb): 'recovery' is deprecated,
use 'rescue=usebackuproot' instead
[ 1339.553897] BTRFS info (device sdb): trying to use backup root at mount time
[ 1339.553898] BTRFS info (device sdb): disk space caching is enabled
[ 1339.608755] BTRFS warning (device sdb): checksum verify failed on
logical 2896434544640 mirror 1 wanted 0x49cf072e found 0x3837717b
level 0
[ 1339.608765] BTRFS error (device sdb): failed to read block groups: -5
[ 1339.610229] BTRFS error (device sdb): open_ctree failed
[ 2650.074709] BTRFS: device fsid 359cd817-936a-4451-9dc7-e8ee7910a448
devid 1 transid 444227 /dev/sdb scanned by mount (16646)
[ 2650.076404] BTRFS info (device sdb): using crc32c (crc32c-intel)
checksum algorithm
[ 2650.076413] BTRFS info (device sdb): enabling all of the rescue options
[ 2650.076414] BTRFS info (device sdb): ignoring data csums
[ 2650.076414] BTRFS info (device sdb): ignoring bad roots
[ 2650.076415] BTRFS info (device sdb): disabling log replay at mount time
[ 2650.076416] BTRFS error (device sdb): nologreplay must be used with
ro mount option
[ 2650.076497] BTRFS error (device sdb): open_ctree failed

If it's needed I can send a dull dmesg log later.

Thank you,
Werner
