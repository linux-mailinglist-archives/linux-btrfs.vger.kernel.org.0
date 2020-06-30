Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0120FCBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 21:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgF3T0x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF3T0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 15:26:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C6C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 12:26:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so8871299plk.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 12:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=eYIuXNkLGDVrU0J+z+KIeHoWDw/CAVxBIRhmhxIeIx8=;
        b=jweHdt50CF9ZGb+3WF6eU8W8E5v3p8vqXLwIEck01H0Qv9UZQ3Zr/KL8cq9LQ6pjZs
         vrGa/2gLpgIGvPlF/huoL3/58/+6/y49iGjUqPRCBs43GUVfnuK63E1nZUHxZlozgn9i
         idpZvu4JY560gBLIelbal31ywNxaqO8ABtHBLJYcUIZA0/cthc3hNe5ZOiD+UzX8pUup
         VU18tUVSNWmntiumO0B8gzDM3MGS5vFtl+KQ6Rt3m9yn/3cDuCWoijIxDoGdyDrrncaV
         SpQ5N+0uWG7LMIcIHs359rhebx0I8dL9S54tFFAN85C2eRQZ0W4sg9v6p+OsGCbdl+7s
         3uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=eYIuXNkLGDVrU0J+z+KIeHoWDw/CAVxBIRhmhxIeIx8=;
        b=XlOHD3v3sEgm4ezC0IrzUg3DyYowCrQ2sQpyJfXRHDGxSHUv3jGrNrUEqpVzBF/3N5
         6zwzBo9WRNX+nHcKHn+gpkA5ofHUu6ODK9aASf/EVVoQmHbGnocfNnfMMDcaEnFIiuNr
         ya+673EyLnLX2I4NkWiWaWEUvBNiosKvqdcMfFY2+ePGENLVzFgojKSL9RJt4dyDywpX
         hdcG8yzLmbRHgwRptGQBxIuSbcm1HKCt8ZAAs75J4OMG6H9LrxtOUp0q8qIRcewq5uZb
         pCit44x8U/8ApUaX5vk6+QsFzB6/fN7atOeQj3BL1JrKwQerD0o0Z/hgsinEIpNc96NG
         4tZw==
X-Gm-Message-State: AOAM530wX8038Ac3mx4zw5nYbKUHGG6a/12UEXtcxuno05K9W0pY7+IR
        CpWaHVULgAPYNDq3ZZGzdFlKjgbzb5U=
X-Google-Smtp-Source: ABdhPJy/l2rHsLjhuZFfAp0ZOP2dO8lReirnCHCk7VPdSGVIS8gwrieX/nEtec3lDaA8s8TZ5Ewm2w==
X-Received: by 2002:a17:90a:2a4d:: with SMTP id d13mr16640583pjg.195.1593545211778;
        Tue, 30 Jun 2020 12:26:51 -0700 (PDT)
Received: from [192.168.0.23] (c-24-4-127-117.hsd1.ca.comcast.net. [24.4.127.117])
        by smtp.gmail.com with ESMTPSA id a12sm2942928pjw.35.2020.06.30.12.26.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 12:26:51 -0700 (PDT)
From:   Illia Bobyr <illia.bobyr@gmail.com>
Subject: "parent transid verify failed" and mount usebackuproot does not seem
 to work
To:     linux-btrfs@vger.kernel.org
Message-ID: <c49e3370-c2b9-59a2-b578-9b5750951f25@gmail.com>
Date:   Tue, 30 Jun 2020 12:26:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a btrfs with bcache setup that failed during a boot yesterday.
There is one SSD with bcache that is used as a cache for 3 btrfs HDDs.

Reading through a number of discussions, I've decided to ask for advice
here.
Should I be running "btrfs check --recover"?

The last message in the dmesg log is this one:

Btrfs loaded, crc32c=crc32c-intel
BTRFS: device label root devid 3 transid 138434 /dev/bcache2 scanned by
btrfs (341)
BTRFS: device label root devid 2 transid 138434 /dev/bcache1 scanned by
btrfs (341)
BTRFS: device label root devid 1 transid 138434 /dev/bcache0 scanned by
btrfs (341)
BTRFS info (device bcache0): disk space caching is enabled
BTRFS info (device bcache0): has skinny extents
BTRFS error (device bcache0): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache0): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache0): open_ctree failed

Trying to mount it in the recovery mode does not seem to work:

(initramfs) mount -t btrfs -o ro,usebackuproot /dev/bcache0 /mnt
BTRFS info (device bcache1): trying to use backup root at mount time
BTRFS info (device bcache1): disk space caching is enabled
BTRFS info (device bcache1): has skinny extents
BTRFS error (device bcache1): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache1): parent transid verify failed on
16984159518720 wanted 138414 found 138207
BTRFS error (device bcache1): parent transid verify failed on
16984173199360 wanted 138433 found 138195
BTRFS error (device bcache1): parent transid verify failed on
16984173199360 wanted 138433 found 138195
BTRFS warning (device bcache1): failed to read tree root
BTRFS error (device bcache1): parent transid verify failed on
16984171298816 wanted 138431 found 131157
BTRFS error (device bcache1): parent transid verify failed on
16984171298816 wanted 138431 found 131157
BTRFS warning (device bcache1): failed to read tree root
BTRFS critical (device bcache1): corrupt leaf: block=16984183013376
slot=36 extent bytenr=11447166291968 len=262144 invalid generation, have
138434 expect (0, 138433]
BTRFS error (device bcache1): block=16984183013376 read time tree block
corruption detected
BTRFS critical (device bcache1): corrupt leaf: block=16984183013376
slot=36 extent bytenr=11447166291968 len=262144 invalid generation, have
138434 expect (0, 138433]
BTRFS error (device bcache1): block=16984183013376 read time tree block
corruption detected
BTRFS warning (device bcache1): failed to read tree root
BUG: kernel NULL pointer dereference, address: 000000000000001f
#PF: supervisor read access in kernel mode

<a stack trace follows>

(initramfs) btrfs --version
btrfs-progs v5.4.1

(initramfs) uname -a
Linux (none) 5.6.11-050611-generic #202005061022 SMP Wed May 6 10:27:04
UTC 2020 x86_64 GNU/Linux

(initramfs) btrfs fi show
Label: 'root' uuid: 0a3d051b-72ef-4a5d-8a48-eb0dbb960b56
        Total devices 3 FS bytes used 6.55TiB
        devid    1 size 3.64TiB used 1.62TiB path /dev/bcache1
        devid    2 size 7.28TiB used 5.21TiB path /dev/bcache0
        devid    3 size 12.73TiB used 6.80TiB path /dev/bcache2

I have tried booting using a live ISO with 5.8.0 kernel and btrfs v5.6.1
from http://defender.exton.net/.
After booting tried mounting the bcache using the same command as above.
The only message in the console was "Killed".
/dev/kmsg on the other hand lists messages very similar to the ones I've
seen in the initramfs environment: https://pastebin.com/Vhy072Mx

P.S. Please CC me, as I am not subscribed.

Thank you,
Illia Bobyr


