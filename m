Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3562834B6BE
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 12:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhC0LJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhC0LJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 07:09:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE3C0613B1
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 04:09:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j9so6338968wrx.12
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n9XajhCMZXcKPAgb9PP/GuZKoIoRQbOUqA6cTbEQOr8=;
        b=IiQP08Nrj81wozTzSS5k8Zo08YZ8gdl/Mr3Nn78g4nj43Heh5MZ2oVQdAceYkweQDF
         A0VzVzTfr+yNmfhz34V4LDKK4puJLbZqF1aQc7zfob0DoOxXiJN3vOZNAjqk22UlpKiB
         yEZXMQgNTYJFySf2K/WhmGcLOX2SPB1fAIkWJLHpVVQ3GwvVpyR8wvK/DId/2O4pmDKX
         WMp0bky0IJ90M2BkUc6WOyTO5abSPkb/1uWQyllbK6FUGniLJJ905EOeOX6/yPngccvN
         lTDoEsWJX7G3y+PXf0GCfvuqeLWl//h9jz+49R0FsDbs/7G8TA35uuB4yfeANj6RVHIC
         jSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n9XajhCMZXcKPAgb9PP/GuZKoIoRQbOUqA6cTbEQOr8=;
        b=DCoij1nmbUdLtFHGKOyhmC7sCpY3oWp0gLXY1dNqxmeQtudlHOx2KT/1EGzJb49HBt
         4kUKTyE2fW6dFw+dq76tNNFH7SOhLAE3dkPKvMK/U0c8xYMLXttj/Hd8vMF6kDQCh5zs
         uRcUGRqsp7cSYoGzvHRtKPlT6WvTizcY1rVulDV1AHfyI+/miqzf5OY/OpyOn3VofGSa
         fEOzoj7CrufHtCGq8cQJ1UsT7bnqEVElNd36Ntmc6jaMSLgxLOTzJ3C1Yv1Zc8k6VHxx
         7UoKkjWmaslh6VwBlIj43mIT3TmRacyl7Uz3z7CewU6P3xt25Cs4NiHXjrGnPZ/oINts
         Xntg==
X-Gm-Message-State: AOAM530lCOYggfQ89uR8l0BIm8TuM7ne5cFlONlhbA3FTkFaRHwBIGTP
        ZdgGZOSoYyp2kJvJYPOaEkzrAfZcZ45I19VfycbTwSFNM2o=
X-Google-Smtp-Source: ABdhPJx1zktKiVgtwFRD4IwwZ/q5PqeM2hL5svG7iASCHX/ePylTLaIabSlAjWD2SLvXl47aHbYgwrVLOn8oflvnNBo=
X-Received: by 2002:adf:ec0b:: with SMTP id x11mr18549305wrn.175.1616843372359;
 Sat, 27 Mar 2021 04:09:32 -0700 (PDT)
MIME-Version: 1.0
From:   Thierry Testeur <thierry.testeur@gmail.com>
Date:   Sat, 27 Mar 2021 12:09:21 +0100
Message-ID: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
Subject: Support demand on Btrfs crashed fs.
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear btrfs support community,

after a bad power event, my 9 years old Btrfs has crashed.
This Btrfs partirion is on an 8 disk mdadm array.
After a few try on different options recovery found on "forums", have
alreday tryed some

btrfs check --repair
btrfs check --init-extent-tree
btrfs check --clear-space-cache,......
btrfs rescue super-recover
btrfs rescue chunk-recover
btrfs rescue restore
btrfs rescue chunk-recover: result on pastebin :https://pastebin.com/9aHewZU4
.....
....
  Chunk: start = 26461360619520, len = 1073741824, type = 1, num_stripes = 0
      Stripes list:
      Block Group: start = 26461360619520, len = 1073741824, flag = 1
      No device extent.
  Chunk: start = 26490351648768, len = 1073741824, type = 4, num_stripes = 0
      Stripes list:
      Block Group: start = 26490351648768, len = 1073741824, flag = 4
      No device extent.

Total Chunks:           13797
  Recoverable:          12233
  Unrecoverable:        1564

Orphan Block Groups:

Orphan Device Extents:
  Device extent: devid = 1, start = 20624466509824, len = 1073741824,
chunk offset = 26284193218560
  Device extent: devid = 1, start = 20625540251648, len = 1073741824,
chunk offset = 26285266960384
  Device extent: devid = 1, start = 20628761477120, len = 1073741824,
chunk offset = 26288488185856
  Device extent: devid = 1, start = 20630908960768, len = 1073741824,
chunk offset = 26290635669504
  Device extent: devid = 1, start = 20640572637184, len = 1073741824,
chunk offset = 26300299345920
  Device extent: devid = 1, start = 20641646379008, len = 1073741824,
chunk offset = 26301373087744
  Device extent: devid = 1, start = 20643793862656, len = 1073741824,
chunk offset = 26303520571392
  Device extent: devid = 1, start = 20645941346304, len = 1073741824,
chunk offset = 26305668055040
  Device extent: devid = 1, start = 20838141132800, len = 1073741824,
chunk offset = 26497867841536
  Device extent: devid = 1, start = 20839214874624, len = 1073741824,
chunk offset = 26498941583360
  Device extent: devid = 1, start = 20840288616448, len = 1073741824,
chunk offset = 26500015325184
  Device extent: devid = 1, start = 20841362358272, len = 1073741824,
chunk offset = 26501089067008
  Device extent: devid = 1, start = 20842436100096, len = 1073741824,
chunk offset = 26502162808832
  Device extent: devid = 1, start = 20844583583744, len = 1073741824,
chunk offset = 26504310292480
  Device extent: devid = 1, start = 20845657325568, len = 1073741824,
chunk offset = 26505384034304
  Device extent: devid = 1, start = 20846731067392, len = 1073741824,
chunk offset = 26506457776128
  Device extent: devid = 1, start = 20847804809216, len = 1073741824,
chunk offset = 26507531517952
  Device extent: devid = 1, start = 20848878551040, len = 1073741824,
chunk offset = 26508605259776
  Device extent: devid = 1, start = 20849952292864, len = 1073741824,
chunk offset = 26509679001600
  Device extent: devid = 1, start = 20851026034688, len = 1073741824,
chunk offset = 26510752743424
  Device extent: devid = 1, start = 20852099776512, len = 1073741824,
chunk offset = 26511826485248
  Device extent: devid = 1, start = 20856394743808, len = 1073741824,
chunk offset = 26516121452544
  Device extent: devid = 1, start = 20858542227456, len = 1073741824,
chunk offset = 26518268936192
  Device extent: devid = 1, start = 20862837194752, len = 1073741824,
chunk offset = 26522563903488
  Device extent: devid = 1, start = 20867132162048, len = 1073741824,
chunk offset = 26526858870784
  Device extent: devid = 1, start = 20868205903872, len = 1073741824,
chunk offset = 26527932612608
  Device extent: devid = 1, start = 20869279645696, len = 1073741824,
chunk offset = 26529006354432
  Device extent: devid = 1, start = 20870353387520, len = 1073741824,
chunk offset = 26530080096256
  Device extent: devid = 1, start = 20875722096640, len = 1073741824,
chunk offset = 26535448805376
  Device extent: devid = 1, start = 20876795838464, len = 1073741824,
chunk offset = 26536522547200
  Device extent: devid = 1, start = 20877869580288, len = 1073741824,
chunk offset = 26537596289024
  Device extent: devid = 1, start = 20882164547584, len = 1073741824,
chunk offset = 26541891256320
  Device extent: devid = 1, start = 20883238289408, len = 1073741824,
chunk offset = 26542964998144
  Device extent: devid = 1, start = 20884312031232, len = 1073741824,
chunk offset = 26544038739968
  Device extent: devid = 1, start = 20885385773056, len = 1073741824,
chunk offset = 26545112481792

Invalid mapping for 23079040999424-23079041003520, got
23080114061312-23081187803136
Couldn't map the block 23079040999424
Couldn't map the block 23079040999424
bad tree block 23079040999424, bytenr mismatch, want=23079040999424, have=0
Couldn't read tree root
open with broken chunk error
Chunk tree recovery failed



Informations required for support:
uname -a:
Linux UBUNTU-SERVER 5.8.0-48-generic #54-Ubuntu SMP Fri Mar 19
14:25:20 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
btrfs --version:
btrfs-progs v5.11
btrfs fi show:
Label: none  uuid: f4f04e16-ce38-4a57-8434-67562a0790bd
        Total devices 1 FS bytes used 24.71TiB
        devid    1 size 18.83TiB used 18.67TiB path /dev/md0
btrfs fi df /
not mountable fs, so no results.
 dmesg |grep -i btrfs:
[    3.869542] Btrfs loaded, crc32c=crc32c-intel
[    3.927255] BTRFS: device fsid f4f04e16-ce38-4a57-8434-67562a0790bd
devid 1 transid 524941 /dev/md0 scanned by btrfs (260)
[  667.478169] BTRFS info (device md0): disk space caching is enabled
[  667.722168] BTRFS error (device md0): parent transid verify failed
on 23079040831488 wanted 524940 found 524941
[  667.722181] BTRFS warning (device md0): failed to read root (objectid=2): -5
[  667.742931] BTRFS error (device md0): open_ctree failed


If someone have any idea if i  have a little chance to get at least
some of the data back, i will be very happy, as the last found backup
of this massive partition was an 5 years old.
Sorry for my English.
Thierry
