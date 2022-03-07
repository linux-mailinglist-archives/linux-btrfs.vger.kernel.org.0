Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6E4D0829
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiCGULn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 15:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCGULm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 15:11:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2F36146
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 12:10:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so129855wms.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 12:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=hKQtdi7rbDyl7YOJOq4gZvW3IzDE/uFyYAXvVKT16cs=;
        b=gqbdVe0VKK0kHGLx8jMDfCtXkMJt5jVuFkWAeJTrU5AFhO3/ya6dLqwaeuPzFIq63I
         K6fOEjIs0EzE4IxYHRnq5NUETdDMxEZ65Wds9tKcSV26jo9Ack35k3XD7B6nSnvc0lvs
         wVM/wbtM6fX0fPEvK8BGwKuQ8AwyYdqYUVsxQCdPOchO1qucS1D9Pk2tONy3/IDHSh5e
         CBSp/EZYUpZNJSVmbY1Zl0fmDNicdjJcwygpji8JYl2D/7+E2Fym7H0a4rV+9o7pSrqw
         D5+ClASEi5myUCgceRJn9XvpIikIupRolIuiERrFjSKMxxodavOgE8NTrCZywkDHBxzr
         15pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=hKQtdi7rbDyl7YOJOq4gZvW3IzDE/uFyYAXvVKT16cs=;
        b=AjH+3nOXhaN2kIn2IrulShUSdnemBsJknUQZeAFNJB+kCZFqChC1TK6q6Ah3A58bZq
         bWjHEjQHx3lLUyA9WYCZCVDMpObxs0uG2or7PMwXm7lanvUzR9mw0AiDfQdTkmC1z+h4
         z6ZnC3nJPKuzvqhrIUgEnoZ3KQhy5FawBcZk/fqBZCEPZKblUbRS9ns3e+QfGTUycbta
         v/A6GpJBmSdLSawpx455Q39JGoE8xgYgXMos9rL6wOue4v7Hi68JoeycjpHjUkN+mpFg
         Woyj6o0BMhzBPf5LOJqrW2A25Q35bnmVOwFRKcuwNvYTJjS3xwKN0PskrKmeGj5dQ1OA
         fMFg==
X-Gm-Message-State: AOAM531GyaJmUwWQ+JvmOc0bK9EvuuJ6UsBqd/EmqfbEkwhOr5BW3o7m
        rmrPey3KVlWtexRO7Atla0gc/P6eub0=
X-Google-Smtp-Source: ABdhPJwuYpbMvC8OhBX0MZapc/J5U8BZLtNdyz9zAo2rTD5gfTPuwLpjI48aNceD9Lhx6lgrtmGarA==
X-Received: by 2002:a1c:a9d1:0:b0:383:39cb:506 with SMTP id s200-20020a1ca9d1000000b0038339cb0506mr516500wme.71.1646683845921;
        Mon, 07 Mar 2022 12:10:45 -0800 (PST)
Received: from [127.0.0.1] (p4fd0b664.dip0.t-ipconnect.de. [79.208.182.100])
        by smtp.gmail.com with ESMTPSA id g26-20020a05600c4c9a00b00389a48b68bdsm263913wmp.10.2022.03.07.12.10.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 12:10:45 -0800 (PST)
Date:   Mon, 7 Mar 2022 20:10:45 +0000 (UTC)
From:   Emil <broetchenrackete@gmail.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <1cb1e7d9-51d0-4c2e-8cd1-6b02d045bcad@gmail.com>
Subject: Recover btrfs partition after accidental reformat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <1cb1e7d9-51d0-4c2e-8cd1-6b02d045bcad@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I did a boo boo and reformatted my btrfs partition with NTFS (used the wron=
g /dev/sdX). It was a single drive with standard options (metadata dup, dat=
a single) and it was the only partition of the drive.

I have not written any data to the ntfs partition.

Is there any chance of data recovery? The only thing I found was a backup s=
uperblock:

[bluemond@BlueQ ~]$ sudo btrfs insp dump-su -s 2 /dev/sdh1
superblock: bytenr=3D274877906944, device=3D/dev/sdh1
---------------------------------------------------------
csum_type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0 (crc32c)
csum_size=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 4
csum=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x69883d2a [match]
bytenr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 274877906944
flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( WRITTEN )
magic=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _BHRfS_M [match]
fsid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6dc337f5-2146-4aa5-a9c1-8faf1=
e2994c5
metadata_uuid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6=
dc337f5-2146-4aa5-a9c1-8faf1e2994c5
label
generation=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 7004
root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 436338688
sys_array_size=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 129
chunk_root_generation=C2=A0=C2=A0 7002
root_level=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0
chunk_root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 22020096
chunk_root_level=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
log_root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
log_root_transid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
log_root_level=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
total_bytes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 2000397864960
bytes_used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 125869297664
sectorsize=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4096
nodesize=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 16384
leafsize (deprecated)=C2=A0=C2=A0 16384
stripesize=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 4096
root_dir=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 6
num_devices=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1
compat_flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0
compat_ro_flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( FREE_SPAC=
E_TREE |
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 FREE_SPACE_TREE_VALID )
incompat_flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x341
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ( MIXED_BAC=
KREF |
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 EXTENDED_IREF |
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 SKINNY_METADATA |
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 NO_HOLES )
cache_generation=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
uuid_tree_generation=C2=A0=C2=A0=C2=A0 7004
dev_item.uuid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
c86cfd6-fc28-4f99-9b4a-6bd3546aa523
dev_item.fsid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6=
dc337f5-2146-4aa5-a9c1-8faf1e2994c5 [match]
dev_item.type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
dev_item.total_bytes=C2=A0=C2=A0=C2=A0 2000397864960
dev_item.bytes_used=C2=A0=C2=A0=C2=A0=C2=A0 131021668352
dev_item.io_align=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
dev_item.io_width=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
dev_item.sector_size=C2=A0=C2=A0=C2=A0 4096
dev_item.devid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
dev_item.dev_group=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
dev_item.seek_speed=C2=A0=C2=A0=C2=A0=C2=A0 0
dev_item.bandwidth=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
dev_item.generation=C2=A0=C2=A0=C2=A0=C2=A0 0



I tried using photorec, but the btrfs partition was pretty fresh and I had =
a ntfs partition with lots of data before that so it finds all kinds of dat=
a from the old ntfs partition.
