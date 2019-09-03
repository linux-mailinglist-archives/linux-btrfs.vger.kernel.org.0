Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7648DA748B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfICUUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 16:20:25 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38417 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICUUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Sep 2019 16:20:25 -0400
Received: by mail-wm1-f54.google.com with SMTP id o184so929207wme.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=BE2McOE3MrwgXkJ+dy/Yy/wX9eD+gAAWqhAR08yLE2c=;
        b=T8OP1ZcF2swj8vTaZyhff5HS75vuczd44bqRGXkWrIIBdG6rv413dYpowO3TgCBa34
         155UOnnRMRpUZBubOEGZRDFECXm5wHD4u2OdGRCfmpeTGBqekYvVFRrEfVPphNdQGIHO
         9Dyz1dNONZ2NfIFBz3IKcygw1cciL9z0y9Q3oYdW7xNv5kJ8vvLvjPbkdLYzKOAABeAg
         oekgWatYG9EFYzTjlT6LoTuEqvrA7WLvkPz+Zd89+gA5D+nxX9p+cA/e2gFP2U60wA0T
         ob8VznvQRqLmqR4fb/I8Xozy4RbQzW5SvFgi2atDhHe7X180SWP0xdlv1LZ84vCjimQK
         0pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=BE2McOE3MrwgXkJ+dy/Yy/wX9eD+gAAWqhAR08yLE2c=;
        b=jeGOF+i/epSpI0E7tl8ks/HMIusqqA/aDzXRXf7oLFmoa1qh2H3ChteW6/NnOP6V99
         0lHUcX7VFgaWT/LUtKbzxF+JFUgEy26YZAwiQy+/gadIrrhvSiZAB+41QINGK8mnSAVr
         Vxt6fPLNH2gCWt7EDrFLUmcuBB2+fPe8Pmmxm6KxmQCNqGa3Mk1Z57cKDp5xpfBFw3la
         C85VEggmSCgzy1dMtNddNxkN2E/YrCoaRQQt+kQc2C0mXW1HMuzqEPl+Wek77zGNqiq0
         4uFecgKdKnDIaBwEqn3Jcm15ucqwXo4KdoTMoYZKIvq35nRqEXuvUAouK3QQIeE/YRjV
         IDYg==
X-Gm-Message-State: APjAAAXOzL3WcEiFLA3fzzq+dh1syTBnKIQtZbtVhVdR15xBBG8VASd0
        E/7retq+3/W8uoy/TSq17jyFP25OzPM0U4WsAKrAWoLBuQABRKgFEpNkTonGIG+LCLGRPT3penE
        MAGw0nS3ukNYFa3SAk75U1Q==
X-Google-Smtp-Source: APXvYqyLJnXBqPuBTR0HrvHBZQkAA4/i1gxomctc5Cot98ehnAlS2EToUEyBKGwcoMq8KLPMSIlk2Q==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr1369856wmc.140.1567542021633;
        Tue, 03 Sep 2019 13:20:21 -0700 (PDT)
Received: from [192.168.42.1] (84-112-118-202.cable.dynamic.surfer.at. [84.112.118.202])
        by smtp.gmail.com with ESMTPSA id o17sm23575841wro.72.2019.09.03.13.20.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 13:20:20 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Edmund Urbani <edmund.urbani@liland.com>
Subject: Unmountable degraded BTRFS RAID6 filesystem
Message-ID: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
Date:   Wed, 4 Sep 2019 00:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

two days ago my btrfs filesystem became quite slow and the logs showed a
lot of I/O errors on one of the HDDs. I ordered a replacement drive and
tried to remove the failing drive from the filesystem (btrfs device
remove). That removal command did not finish but just sat there without
any output.

Today the new drive arrived. Device removal still had not finished, but
the filesystem had entered read-only mode last night. I shut down the
system to replace the defective drive. However, after the reboot I am no
longer able to mount the filesystem at all or recover any data from it.:(

*****
uname -a

Linux phoenix 4.14.78-gentoo #1 SMP Mon Dec 3 09:25:24 CET 2018 x86_64
AMD Opteron(tm) Processor 6174 AuthenticAMD GNU/Linux

*****
btrfs --version

btrfs-progs v4.19

*****
btrfs fi show

warning, device 8 is missing
warning, device 8 is missing
checksum verify failed on 71133554540544 found B52922D9 wanted C8FB97CF
checksum verify failed on 71133554540544 found 9820D207 wanted 189B50C0
checksum verify failed on 71133554540544 found 9820D207 wanted 189B50C0
bad tree block 71133554540544, bytenr mismatch, want=3D71133554540544,
have=3D7227596181724576485
ERROR: cannot read chunk root
Label: none uuid: 108df6ea-2846-4a88-8a50-61aedeef92b4
Total devices 10 FS bytes used 14.71TiB
devid 1 size 2.73TiB used 2.04TiB path /dev/sdg1
devid 2 size 2.73TiB used 2.04TiB path /dev/sdh1
devid 3 size 2.73TiB used 2.04TiB path /dev/sdj1
devid 4 size 2.73TiB used 2.04TiB path /dev/sdi1
devid 5 size 2.73TiB used 2.04TiB path /dev/sde1
devid 6 size 2.73TiB used 2.04TiB path /dev/sdf1
devid 7 size 2.73TiB used 2.04TiB path /dev/sda1
devid 9 size 2.73TiB used 2.04TiB path /dev/sdc1
devid 10 size 2.73TiB used 2.04TiB path /dev/sdd1
*** Some devices missing

*****
dmesg (after attempting mount with -o degraded)

...
[ 8904.358084] BTRFS info (device sda1): turning on discard
[ 8904.358088] BTRFS info (device sda1): allowing degraded mounts
[ 8904.358089] BTRFS info (device sda1): disk space caching is enabled
[ 8904.358091] BTRFS info (device sda1): has skinny extents
[ 8904.361743] BTRFS warning (device sda1): devid 8 uuid
0e8b4aff-6d64-4d31-a135-705421928f94 is missing
[ 8905.705036] BTRFS info (device sda1): bdev (null) errs: wr 0, rd
14809, flush 0, corrupt 4, gen 0
[ 8905.705041] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
4, flush 0, corrupt 0, gen 0
[ 8905.705052] BTRFS info (device sda1): bdev /dev/sdf1 errs: wr 0, rd
10543, flush 0, corrupt 0, gen 0
[ 8905.705062] BTRFS info (device sda1): bdev /dev/sdc1 errs: wr 0, rd
8, flush 0, corrupt 0, gen 0
[ 8909.565118] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.565978] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.567462] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.568439] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.569861] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.570695] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.572146] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.572969] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.574175] BTRFS error (device sda1): bad tree block start
12170572967447269873 34958581399552
[ 8909.574189] BTRFS error (device sda1): failed to read block groups: -5
[ 8909.635991] BTRFS error (device sda1): open_ctree failed

*****
btrfs check /dev/sda1

Opening filesystem to check...
warning, device 8 is missing
warning, device 8 is missing
checksum verify failed on 71133554540544 found B52922D9 wanted C8FB97CF
checksum verify failed on 71133554540544 found 9820D207 wanted 189B50C0
checksum verify failed on 71133554540544 found 9820D207 wanted 189B50C0
bad tree block 71133554540544, bytenr mismatch, want=3D71133554540544,
have=3D7227596181724576485
ERROR: cannot read chunk root
ERROR: cannot open file system

*****

I have tried all the mount / restore options listed here:
https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=3Dcomme=
nts#comment-543490

... and all I keep getting is "bad tree block" errors. Superblocks seem
fine (btrfs rescue super-reecover found no problem). I am considering
trying "btrfs rescue chunk-recover" at this point.

Could this help in my situation? What do you think?

Kind regards
=C2=A0Edmund


--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.

