Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF2F20EC6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 06:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgF3EYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 00:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgF3EYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 00:24:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A01C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 21:24:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so9331403pgb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jun 2020 21:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=eYIuXNkLGDVrU0J+z+KIeHoWDw/CAVxBIRhmhxIeIx8=;
        b=OIdtDZ9aknZll+p6ZMhsA5F1+qXRydHyzLz71C4ccc1vzSNKmoGeXhhnCzdBtmjBPV
         K0X/1zU30nTBWmmQHe5TMv58gxpxKPGu9S8lDhaz8YsJbJzenbYREVTHD37hu6JIzamJ
         WVF3+/OlVZjvYzhnzkF5BIkmY3MWCKUhSqyigyl9bZSQJwHIjagZUhrNGaf6YFqDSxVy
         ONlzAwZ7H5j8ozjTLMCC+rPQl7A5iGdF8HKgu/LgSyTFlDVJ3dL3XXy40E49UtRUZuwy
         DC7xJ8/v2y9fUVVWQujwsveH9scyfyyQP9/r1rRGJPfkHqgc8rpMT8GC2W7jlJir8bvk
         KHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=eYIuXNkLGDVrU0J+z+KIeHoWDw/CAVxBIRhmhxIeIx8=;
        b=k1vQ6G7wDwb4ZgdnRLDZD1yEsGOWYs7wdXe1cpZd4f2k/9hwL5J9jhq7f8iEv01oYS
         I2q9EVkybwrs7SrqHmIKMuA21IjVc2yALwAcCNkEGExxDN3YI8rXM59vMpwKuYRfHZuN
         WfJpnn1h1PTlgEYm+AXq2SzHV7OM5Q1T+n2UAtvRKOWWXQz9q6u1LzHceGRBV9/gO/S0
         bjOpnYrStvFjwIo50uQuvJ3dmy3DpRe3YtTpB11mzITU8e/tZzNV35k4TLB4OebPSbEa
         1C8OXymugj93mQSmBAsduLyhg7hbc+J4Ej/Y1j09NFqhqS5k1LJZI20KMZ7qRvtZO4Jn
         uW5g==
X-Gm-Message-State: AOAM5330zIoncAmejxZc5YtIbQAUgKz2iv1qUdPTsbRbe1Je3tdoa4sO
        agm9dC3m2CtidjtR6nj1bfjxcqmNou4=
X-Google-Smtp-Source: ABdhPJwYVtDtZCC0iclEDRJ7gCcN1HEHt8GoMGAridRpsvqCuNNs6l9tQ0/ewMiq4lvHEw5yl+M8aw==
X-Received: by 2002:a63:6884:: with SMTP id d126mr12910941pgc.341.1593491093600;
        Mon, 29 Jun 2020 21:24:53 -0700 (PDT)
Received: from [192.168.0.23] (c-24-4-127-117.hsd1.ca.comcast.net. [24.4.127.117])
        by smtp.gmail.com with ESMTPSA id s10sm864320pjl.41.2020.06.29.21.24.52
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 21:24:53 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Illia Bobyr <illia.bobyr@gmail.com>
Subject: "parent transid verify failed" and mount usebackuproot does not seem
 to work
Message-ID: <d6163f73-2890-1815-45cb-6a6de2d81749@gmail.com>
Date:   Mon, 29 Jun 2020 21:24:52 -0700
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

