Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA102F23C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390885AbhALA0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 19:26:00 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:44863 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404136AbhAKXdf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 18:33:35 -0500
Received: by mail-oo1-f53.google.com with SMTP id j21so163078oou.11
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 15:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8YC2I/TKRvDkDZiHt7DVeYw5z13R8YE9r70HSi+ZwNw=;
        b=R4QT1Fd5lHWvPG7wfLquHKrbBkqp4KYCr1Vg2f9drP1UNrv/+GGC0w2F7xwPq6gv9D
         575LjTp5XloGeDNiZOvbAbCpxT7nGQMk1+LWCVy99BjIN23iDOnoaY1pfieyP1c7Us7K
         jrrhAaiTBC+2RwlhtthoGQYTXYckBbltWedTisLp+8Vrj5RxcVm7e7Z9eh+Oqfk9mPUI
         co3259idJo0lwtAerFamfD9AgIVoNiKUpcWCAFWICUeAY9qvgk5AlddV4aU+8BJGW3ek
         SErdSQmP/44APOpoX/1BZp6egkWB3CIrM6KY+SjID0vbfQA+88ysh3yB0IiApUSyD+M6
         DP7Q==
X-Gm-Message-State: AOAM531C7BQ6j0FmiwmmjNN6kBSCZDnS2BRIW/Bz4K9MAjwBJFxw3H0T
        bkDTMaTuoamPWfItPh91rY1YaAu9CfDcZ2iHlCNBwpwnflo=
X-Google-Smtp-Source: ABdhPJwfkQRIFUInK6me8foSfa/O4teC8RAMBIIm3e3JBmsMEnJ7KnVo6K9FAvnGBzQvV6atIPHTIs+KGJfhxLVzbOE=
X-Received: by 2002:a4a:896e:: with SMTP id g43mr1070052ooi.24.1610407974639;
 Mon, 11 Jan 2021 15:32:54 -0800 (PST)
MIME-Version: 1.0
From:   Ole Tange <tange@gnu.org>
Date:   Tue, 12 Jan 2021 00:32:43 +0100
Message-ID: <CA+4vN7xn4h8HjnkE5wpKw6VMrf9NCLCyheme2PspgheG3DmmvA@mail.gmail.com>
Subject: Btrfs compression ratio > 34:1 possible?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am trying to use Btrfs' compression on some highly compressible data.

I try to make zstd give better performance than 34:1.

This:

   $ truncate -s 1T /tmp/btrfs
   $ mkfs.btrfs /tmp/btrfs
   $ mount -o compress=zstd:9  /tmp/btrfs /mnt/btrfs
   $ head -c 10G /dev/zero > /mnt/btrfs/zero
   $ du /tmp/btrfs
   313672k

shows a compression ratio of 10737418240/312724/1024 = 33.5:1

But if I run:

   $ head -c 10G /dev/zero | zstd | wc -c
   336655

I get a compression ratio of 10737418240/336655 = 31894:1

That is around 1000 times better.

I understand there is some overhead in Btrfs, so it is expected that
it is not possible to reach the full ratio. But it seems there is
little to no difference in using 'compress=zstd:9' and
'compress=zstd:3' on highly compressible data.

My guess is, that data is chopped up in small blocks (1k?) that are
each compressed. If so: Is it possible to make these blocks bigger? I
think that would make sense in general when using higher compression
values.


/Ole
