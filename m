Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1798146726D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 08:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378793AbhLCHTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 02:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378786AbhLCHTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 02:19:30 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208F6C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 23:16:07 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so1431614oov.4
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 23:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0QE/cB8hot+2g1JVsEdgY9x2CUO4uU7bJfSJphU83AQ=;
        b=AkaJ4bZpzsPbApLENULokJ0NPutpMg415aXhtlS0X2cBbl4sJOeWVg756v3Cjn0dl8
         UoGL4jmvpTOVEgGgR9wM7XLrEwEmltEciEQHQQJLyDRkBP+TM1INViXIb1CmBF9eVZGa
         EXy0c61Aq+ibUAv/veQ+0bkr9dT1jyR/dzzEYXdQreBUkvAgv6R02/I/Njw2Ce5B1bI8
         UciU1xFNcOUa3X7Ez0yASS3xSVKbx2ULhsYbB5FbkKvZUnmDSR3PnAuhg0KHQVw+X3I+
         FFHF4wfUlLSF0Hg0kiUoi+tO6HKpxImZzqRbje0lwlgpmBDuaDsk3Yf6kBZMVnXqWMYi
         Ne9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0QE/cB8hot+2g1JVsEdgY9x2CUO4uU7bJfSJphU83AQ=;
        b=CzgkdvhuyEa/91X80Zs02HVilqEWWm7DfbV3DxrXt5vrxjadK5Wi/6s/d7KNSdojGs
         ZfvVOqtRcEbBTgPMOireHwId9q8/kRjGP9ci7GAVA0wwKamv9PAZ+bHbSraEBYsvnzUu
         zctm2D2IbPpSmkVRsA3pcEf5VZAVdDueQ3xI7GJa485wmyZt0Hu4HrgNkz0gWNDuGI9m
         96Y9HnLzrFJo6dEnNhQhDyTpjd/MVh3yKMfcYddOk5v4ltXAjnwRDkZbwGBRv2GaiM0D
         VJUS3BLUD24BpOXDGvT+tT8qBskpRHJ6BhRwAFUCqAbNFWpsdcDxgASlPzIcnIF9lmSm
         12tA==
X-Gm-Message-State: AOAM5310IwlcyiQJeYkWH82Q5zy8TlDsTaSwBVnG/JUQVRRMTUEeh1la
        /7kcyRIo1+VCp8ZJND6r9OdGxo4iaQmDbCOCcoJfEHzOggM=
X-Google-Smtp-Source: ABdhPJzp+ypO8kf+/ulLjnBzRNRCeHwk9kB68yc8MgCfrCwGpJ1KVObuzCFYuKbs3hKquuZ2WakiY6i+Bqcp2lFFNiE=
X-Received: by 2002:a05:6830:90a:: with SMTP id v10mr15171924ott.223.1638515766234;
 Thu, 02 Dec 2021 23:16:06 -0800 (PST)
MIME-Version: 1.0
From:   Adrian Vovk <adrianvovk@gmail.com>
Date:   Fri, 3 Dec 2021 02:15:55 -0500
Message-ID: <CAAdYy_mU14KxdwG+-KoyHfA+t34SZnXGmxMTcd2d7Y_dhMKHDQ@mail.gmail.com>
Subject: Question: Cryptographically Sealed Subvolumes?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

How possible would it be to implement a "sealed subvolume" in Btrfs?
By that I mean something like fs-verity for a whole subvolume. The way
I envision it working is: I'd make a subvolume, populate it with
content, and then "seal" it. This will go through and generate a
Merkle tree of the contents of that subvolume (which I'll call "the
seal"). Then, at any point, I can recompute the subvolume's seal's
root hash and compare it to a known-good list of hashes. Also, reads
that don't match the seal would fail.

I see this as something that provides functionality somewhere between
fs-verity and dm-verity. Basically, if two snapshots have the same
file content and metadata in the same directory structure, they should
have the same seal. Filesystem-internal details (like where exactly
the data is stored on disk, compression, filesystem UUID, etc)
shouldn't be part of the seal (unlike dm-verity). It would allow users
to quickly check whether or not two subvolumes have the same content
inside

Apple's APFS has something like this implemented:
https://support.apple.com/guide/security/signed-system-volume-security-secd698747c9/web.

Ideally, this seal mechanism would be compatible with the
authenticated-btrfs work being done
(https://kdave.github.io/authenticated-hashes-for-btrfs-part1/) to
protect from offline modification to the filesystem's writable parts

From my understanding of how Btrfs works, this should be feasible.
Perhaps even Btrfs's existing checksum infrastructure could be reused
here (but probably not). It could probably reuse Btrfs's fs-verity
support, and just make additional Merkle trees for the directory
structure. But I'm not familiar enough with Btrfs internals (only been
doing a couple of days of research) to say if and how this can work.
So, I'm referring to the experts!

Motivation for this: I'm trying to implement a fully verified boot
chain in my OS, but one of my requirements is that the underlying
filesystem remains writeable. To perform an update, my OS downloads
the new version into a git-like repository, and then does a
"checkout". This creates the OS's directory structure, with hardlinks
pointing into the repository. At boot, the initramfs switches root
into this directory structure. With the seal, this process could be
made more secure. I'd download content into the repository, then
create a subvolume and do the checkout into there. Finally, I'd seal
the subvolume. At boot time, the initramfs can verify that the seal's
root hash matches the hash I computed at OS build time. Thus, the
subvolume's contents match the contents of the OS I built. Thus, I can
verify that the OS hasn't been tampered with in any way!

The benefit of something like this over dm-verity is:
1. I could create as many sealed snapshots as necessary. If I use
dm-verity, I'm stuck with an A/B partition scheme and can only keep
around 2 copies of the OS
2. dm-verity will force me to pick a single maximum size for my OS,
and then use up double that on the users' system. This is infeasible,
because different variants of my OS are vastly different in size (the
normal variant is only ~3Gb, whereas the development image is a full
7Gb).
3. I could dynamically install overlays on top of a base image with
this model, without pre-generating & distributing a full filesystem
image for each combination at build time
4. I get to keep using Btrfs's compression, CoW, deduplication, and
multi-device features

I think providing a middle-ground between fs-verity and dm-verity
would be beneficial for other projects as well. Perhaps Flatpak could
use sealed subvolumes to do verity on each app installed by the user.
It would definitely go a long way towards improving security on Linux!
I'd love to hear your thoughts on something like this. Thank you!

Thank You,
Adrian Vovk
