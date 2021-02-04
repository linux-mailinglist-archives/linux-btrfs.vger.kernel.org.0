Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671030F178
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 12:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhBDLDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 06:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbhBDLDb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 06:03:31 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763DC061573
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 03:02:51 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id d3so651229ool.7
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Feb 2021 03:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rozsas-eng-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jOGoLNecQKNm+RxLwSHWZiVDiRmpqn3u5F46oSHH70w=;
        b=IZku3VIIr4WNkvtceOkQcNskcfEE8ar+cn2g9VhlK/mRsPYDPkyrgv2gYarXJj1e+B
         LfyxXzEvU3bbOa1wM27HlQE6y7yyQ3FiXMvrzjYUPICfILrWGh+yEapPwt3NhU59c4ew
         GznUiW8Pty/iQjrc6O/g84XQLX6rdeKcuGffNLOEV591qSCovNYu2Z0aeLvOyXWPv5WK
         Qn0suzFCpAdTmgPeHy6u3WvliG7qmCIOhOLiqoguhvzDoxft5WmY7i2P25AXAfkRdwc/
         4bRUbGn2kgL671z9yOH96ISBLa9SRxI2sBq7s1tNq+5gORs9g9vVbmcNCvXX1rUtZku6
         YC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jOGoLNecQKNm+RxLwSHWZiVDiRmpqn3u5F46oSHH70w=;
        b=AebQSIyw87ObA1wUdnBAxiiZEngxPOl/cm9APqOO1HYBd+e9RS6eM8WkS/EgVA8MzK
         Cl2fSjJ0aVTPlTW2hSYorHramO/w6yrixgEcK1X4N5bWt4+vQiOrEOGpawVTs4XSEbF2
         8k/FJGeO1BWLjkhuFn1JuFSE6Dp8vGQe3QsyIdbfVYg2vbOK7wK9jPeX+HVJtXdeiDqN
         1twtmjJPrJ+UK83HP8Pi24a/2pVFCZndYdXQM07x9+94a9Z539mPy7WHe2xwpeX25elR
         PaWj+a5XzKNa/ypWuhxA7TKqLopj5jLyMJdCzWKv+sPTRpa2MpGzeTYjJHJhA4PC+WRJ
         ahRg==
X-Gm-Message-State: AOAM532WA4FNsDTmZTdbPCPk0KchmtxxGG1Jkh9jGbr+J8buWoxeaK0B
        t/F3su+mPx6TXCQmsyAoMXLGmkA77ONJKM3HQ9ixxbqTzvT5Qw==
X-Google-Smtp-Source: ABdhPJw/rpLuzfEadLA6kPEXT8IqUq/wujXu2oKGiaWoWCgUs1YEHnONktS5l3lH03nYM0fGQCzQXTAegPbc1YeBpuQ=
X-Received: by 2002:a4a:dcc6:: with SMTP id h6mr5315642oou.89.1612436570404;
 Thu, 04 Feb 2021 03:02:50 -0800 (PST)
MIME-Version: 1.0
From:   "miguel@rozsas.eng.br" <miguel@rozsas.eng.br>
Date:   Thu, 4 Feb 2021 08:02:14 -0300
Message-ID: <CAP5D+waHS3rMdcYdv_++X8n8wgLjm3cC2=Tv34ZPzi=Ku4Ozog@mail.gmail.com>
Subject: btrfs becomes read only on removal of folders
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there,

I am using opensuse tumbleweed on a desktop.
More than 1 year ago, I setup a rotating disk to use btrfs and things
went nice until yesterday.
I was done with Civ VI on steam, and decided to remove the associated files=
.
I've started to remove files and I got the message the file system is read-=
only.

kimera:~ # findmnt --real -l | grep /mnt/btrfs
/mnt/btrfs                /dev/sdc2                           btrfs
rw,relatime,space_cache,subvolid=3D5,subvol=3D/

kimera:~ # cd /mnt/btrfs/miguel/Steam/
kimera:/mnt/btrfs/miguel/Steam # \ls
GameOverlayRenderer64.dll    bin_steamdeps.py
fossilize_engine_filters.json  linux64   servers
steam_subscriber_agreement.txt  tenfoot
ThirdPartyLegalNotices.css   bootstrap.tar.xz  friends
       logs      skins                    steamapps
   ubuntu12_32
ThirdPartyLegalNotices.doc   clientui          graphics
       music     ssfn9115004176610272489  steamchina
   ubuntu12_64
ThirdPartyLegalNotices.html  config
installscriptevalutor_log.txt  package   steam
steamclient.dll                 update_hosts_cached.vdf
appcache                     controller_base   legacycompat
       public    steam.sh                 steamclient64.dll
   userdata
bin                          depotcache        linux32
       resource  steam_msg.sh             steamui
kimera:/mnt/btrfs/miguel/Steam #

kimera:/mnt/btrfs/miguel/Steam # rm -rf appcache bin clientui controller_ba=
se
rm: cannot remove
'appcache/httpcache/00/00d317630ee7d0825dc6a4cd5ce9f91f50e6993c_da39a3ee5e6=
b4b0d3255bfef95601890afd80709':
Read-only file system
rm: cannot remove
'appcache/httpcache/01/01edefade28afe779bad14a9d5ff954b0f4c4e60_da39a3ee5e6=
b4b0d3255bfef95601890afd80709':
Read-only file system
rm: cannot remove
'appcache/httpcache/01/0116c6a41aee246e028415352052bd79d323fc1f_da39a3ee5e6=
b4b0d3255bfef95601890afd80709':
Read-only file system
...
rm: cannot remove 'controller_base/bigpicture_mouseon.vdf': Read-only
file system
rm: cannot remove 'controller_base/gamepad_generic.vdf': Read-only file sys=
tem
rm: cannot remove 'controller_base/basicui_gamepad.vdf': Read-only file sys=
tem
rm: cannot remove 'controller_base/basicui_neptune.vdf': Read-only file sys=
tem
rm: cannot remove 'controller_base/basicui.vdf': Read-only file system
kimera:/mnt/btrfs/miguel/Steam #

The associated kernel messages can be read here:  https://susepaste.org/802=
72017

The current usage is:
kimera:~ # btrfs filesystem usage -T /mnt/btrfs
Overall:
    Device size:                   2.37TiB
    Device allocated:            348.06GiB
    Device unallocated:            2.03TiB
    Device missing:                  0.00B
    Used:                        287.07GiB
    Free (estimated):              2.09TiB      (min: 1.08TiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              349.28MiB      (used: 0.00B)
    Multiple profiles:                  no

             Data      Metadata  System
Id Path      single    RAID1     RAID1    Unallocated
-- --------- --------- --------- -------- -----------
 1 /dev/sdc2 346.00GiB   1.00GiB 32.00MiB     1.16TiB
 2 /dev/sdc1         -   1.00GiB 32.00MiB   898.97GiB
-- --------- --------- --------- -------- -----------
   Total     346.00GiB   1.00GiB 32.00MiB     2.03TiB
   Used      286.15GiB 470.45MiB 64.00KiB
kimera:~ #

Then I ran btrfs scrub (btrfs scrub start /mnt/btrfs) and got the
following kernel messages during the scrub:
https://susepaste.org/51166386

And scrub ended with the status:
kimera:/mnt/btrfs/miguel/Steam # btrfs scrub status /mnt/btrfs
UUID:             af3bd7fe-5796-4248-9917-3e71a5a56ec6
Scrub started:    Tue Feb  2 13:43:34 2021
Status:           aborted
Duration:         0:02:37
Total to scrub:   287.07GiB
Rate:             106.22MiB/s
Error summary:    verify=3D79 csum=3D5
 Corrected:      7
 Uncorrectable:  77
 Unverified:     0

So, what is going here ?
How can I fix this FS ?

Sorry to not know so much about how to fix a btrfs, it is my first
experience with btrfs since I migrated from Ubuntu to openSuSE more
than 1 year ago.

my system:
Operating System: openSUSE Tumbleweed 20210121
KDE Plasma Version: 5.20.5
KDE Frameworks Version: 5.78.0
Qt Version: 5.15.2
Kernel Version: 5.10.7-1-default
OS Type: 64-bit
Processors: 8 =C3=97 Intel=C2=AE Core=E2=84=A2 i7-3770 CPU @ 3.40GHz
Memory: 14.6 GiB of RAM
Graphics Processor: GeForce GTX 970/PCIe/SSE2
