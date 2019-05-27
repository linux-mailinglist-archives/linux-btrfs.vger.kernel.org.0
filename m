Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB602BAB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfE0TaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 15:30:24 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35887 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfE0TaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 15:30:24 -0400
Received: by mail-wm1-f44.google.com with SMTP id v22so448375wml.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=AUfHFHhuWc17hi8N9ozftDsmpGL/w3Yos2bezV89OAM=;
        b=KIViLi5xa0z8bpXFpMbctCcQXVBw94i2yPdwLao0XhKvdWoU/8Mq1zvz56lv+dgGLs
         3FoGN7eWuRqkVEZj+BHKdxMgn4KNUeTvJf+FAAOaWttItTpGaarhUo6gVF+vKiDIMxgB
         6X+0to1kz5qNfDYXkwtzvcd2AePBL0OEQeJyabfjjsFnLX8vcA/dffXl7xFpzrUIlugY
         8P+qLJKhPOnMpsQP7I5tA30hMDEBtyLgRsqAGLtr8cBZy9PO07JuqJFxjqHZbVORKmL+
         VePjtVX4ftbhdHFWeZujXWuBFe41pED2h9UQ8JK8jM3gGJvZZK0o8CzCSRq1LIaEOtIc
         ieOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=AUfHFHhuWc17hi8N9ozftDsmpGL/w3Yos2bezV89OAM=;
        b=Sm6EUFZDa2lS7TbzI06iZod68kMGjk8grsym59jaD1TJe8Z/lo9ma0oaF6FNXofse3
         Ug+eBk9T8/TgXBzsi/l3OThxtBBTZWCWhrcYCDbjGzWdAh3R5QArj1exb5KCuTv9FDTF
         1dAKMixxWCjRsO4s/+x+K80KB0ODT56x1jP1nlx7kFrARiHEktwLAF+pU7yCpsE0HmBK
         0g9SGwzUT+fRWHFcZ/bcLA3b529N2VIrJoo81co9mRPuGOtY+zTSgK5F8lYfJ22njt77
         swWRZ4MuaCDL/QPft7PpEFVUQdq3DoQFI8WICJmp/QGig4n54cYnVzl2fPSn1W/cTCg9
         356w==
X-Gm-Message-State: APjAAAWQSb8AXU+xSSTot1AfZmQaLMQS93Vpx3JPbQY01Nr1g8dLJ6Eg
        e7ZhxtRhOLJWjVxCAqubidQuW8vt
X-Google-Smtp-Source: APXvYqwJFv3iCCEdM5kD1XQ1koSW7C5/SKa0yj0meTvWk0lXs24n2pnR5JfJit+ugs87OwFXlv39/w==
X-Received: by 2002:a1c:ab83:: with SMTP id u125mr375173wme.131.1558985421603;
        Mon, 27 May 2019 12:30:21 -0700 (PDT)
Received: from ?IPv6:2a01:c22:7a08:2000:8408:3b6c:2702:da2e? ([2a01:c22:7a08:2000:8408:3b6c:2702:da2e])
        by smtp.gmail.com with ESMTPSA id g5sm2889169wrp.29.2019.05.27.12.30.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:30:21 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Fgrauper <fgrauper@gmail.com>
Subject: How to repair FS with single unrecoverable Chunk?
Message-ID: <75d2487e-5a4d-7222-3c76-fdd7c4a5a985@gmail.com>
Date:   Mon, 27 May 2019 21:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello. I did a bit of an oopsie while moving/resizing partitions.

I currently only have a single HDD in my System which has partitions for 
system, home and mass storage. During the installation of a second OS 
(Manjoro) I aborted the installer while it was resizing the mass storage 
partition after it showed now progress for hours. Now I can't mount it 
anymore.


----------------------------------------------------------------------------------------------------------------------

$ mount /dev/sda2

mount: /mnt/a498076c-d538-41d1-8519-68c9acca0c3f: wrong fs type, bad 
option, bad superblock on /dev/sda2, missing codepage or helper program, 
or other error.

----------------------------------------------------------------------------------------------------------------------


The check and restore commands all exit after reporting false checksums 
and a bad block for each super.


The output of btrfs rescue chunk-recover -v /dev/sda2 shows this: (last 
few lines)

----------------------------------------------------------------------------------------------------------------------

   Chunk: start = 977134419968, len = 1073741824, type = 1, num_stripes = 1
       Stripes list:
       [ 0] Stripe: devid = 1, offset = 980364034048
       Block Group: start = 977134419968, len = 1073741824, flag = 1
       Device extent list:
           [ 0]Device extent: devid = 1, start = 980364034048, len = 
1073741824, chunk offset = 977134419968
Unrecoverable Chunks:
   Chunk: start = 978208161792, len = 1073741824, type = 1, num_stripes = 1
       Stripes list:
       [ 0] Stripe: devid = 1, offset = 981437775872
       No block group.
       No device extent.

Total Chunks:        915
   Recoverable:        914
   Unrecoverable:    1

Orphan Block Groups:

Orphan Device Extents:

checksum verify failed on 477044244480 found E1255A0B wanted 1DA1E71B
checksum verify failed on 477044244480 found E1255A0B wanted 1DA1E71B
checksum verify failed on 477044244480 found 839751B1 wanted FFFFC17D
checksum verify failed on 477044244480 found 839751B1 wanted FFFFC17D
bad tree block 477044244480, bytenr mismatch, want=477044244480, 
have=9079178223823991933
open with broken chunk error
Chunk tree recovery failed

----------------------------------------------------------------------------------------------------------------------

I have no backup of this partition as it's all data I that's stil 
somwhere else (local code repos, Steam libary, ripped CDs, etc.), but it 
would safe me a good chunk (pun not intended) of time if I could recover 
at least some of it.


Genaral info as asked for in the wiki:

----------------------------------------------------------------------------------------------------------------------

output of dmesg | grep BTRFS:

----------------------------------------------------------------------------------------------------------------------

[ 4453.292256] BTRFS info (device sda2): disk space caching is enabled
[ 4453.292259] BTRFS info (device sda2): has skinny extents
[ 4453.383280] BTRFS error (device sda2): bad tree block start, want 
477061251072 have 276290951248713
[ 4453.393647] BTRFS error (device sda2): bad tree block start, want 
477061251072 have 18374762347131585792
[ 4453.393665] BTRFS error (device sda2): failed to verify dev extents 
against chunks: -5
[ 4453.436276] BTRFS error (device sda2): open_ctree failed
[ 4457.570646] BTRFS info (device sda2): disk space caching is enabled
[ 4457.570648] BTRFS info (device sda2): has skinny extents
[ 4457.574983] BTRFS error (device sda2): bad tree block start, want 
477061251072 have 276290951248713
[ 4457.575099] BTRFS error (device sda2): bad tree block start, want 
477061251072 have 18374762347131585792
[ 4457.575106] BTRFS error (device sda2): failed to verify dev extents 
against chunks: -5
[ 4457.608350] BTRFS error (device sda2): open_ctree failed

----------------------------------------------------------------------------------------------------------------------

output of uname -a:

----------------------------------------------------------------------------------------------------------------------

Linux florian-AX370M-DS3H 5.0.0-15-generic #16-Ubuntu SMP Mon May 6 
17:41:33 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

----------------------------------------------------------------------------------------------------------------------

output of btrfs --version:

----------------------------------------------------------------------------------------------------------------------

btrfs-progs v4.20.2

----------------------------------------------------------------------------------------------------------------------

