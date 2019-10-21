Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE3DEA32
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfJUK60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:58:26 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40557 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJUK60 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:26 -0400
Received: by mail-wr1-f54.google.com with SMTP id o28so13409591wro.7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=N7wXEJJzgoDMmcjS01G+O/ErNsKZkI81gsf3sH+hjjY=;
        b=RIttMzBqf1j7Zo499DsxI3HpDHWvYn3OLfz5l706U8joIuLV170KQkDl5WZdF7aaf8
         XxT3rlVk9jeQkT4xSNYCtRjzBDK42Uwk8YtpSS5w+jYoPOWLG5etPc3waR+K1hOW6Lzp
         rqMx1YKIMaxGPPRmpKH6mnnH5ElKeM4i1NCJutnT3SUVHNX7ngbPBhjOs55lTv60QYf9
         xDMPTN2rlrplJmUVti8ZsbWqMp9ef+ogOxNYd25HEXft80heLJkXzRbDeAkllKVbAbdk
         EoavcbwMW3k2D/gQeE9gP7ET7UUmLTKjaqZbQU93FluiLh1I8FLYdLYnodWGCj+kDXnH
         VKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N7wXEJJzgoDMmcjS01G+O/ErNsKZkI81gsf3sH+hjjY=;
        b=ifhwHpN8MznFrnpikSOlkkKvr9vck+JtxSvCQ/sqcGzXLPP5OXpt2WI4FGj1SQKMgV
         FCWh06HqiRniN99l9COVpHAtUpNCdhMhSZG30rAjf8qzgMxiSdiLKq5Kd/dyMl7Vcbmp
         rs96Q+3EUHbk0SMwlurbXi7n8UZCJ9arm2quFCiph2UK4Md6Tbc/YOgTghOy86zs7241
         J+NDqDv1B3glldvuyU2e5nbYjUqZaWlnCDB0D01syDLzhBxSKF0jaaL1Lzdm5vL8CdpJ
         yvZ/dXZiJ4TCd8HWauNg4g8wfXVSPvwc57sUTtRkEvfYRGkkooJqwz7Oa9CnQqM2xtrN
         AhrA==
X-Gm-Message-State: APjAAAVAC+mbO6a1A9MufS/8dleNuDYo/TjcVArXptssF2o9tW4fJcEu
        VUO65Nh5iFdXovg/4EAkUhYj/8acv4AXiBHHRGIETrO5
X-Google-Smtp-Source: APXvYqxrzQ7nsJV2wK69+JH8m7pYZidPX6MwaZgztrBS1dYVOFsJHJHqx/ltfeoiyDaJt022J4W72SYf3pBab4FntFM=
X-Received: by 2002:a5d:444b:: with SMTP id x11mr19409688wrr.207.1571655503557;
 Mon, 21 Oct 2019 03:58:23 -0700 (PDT)
MIME-Version: 1.0
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 21 Oct 2019 12:58:12 +0200
Message-ID: <CAA7pwKNn3BTb1Dxu9mOVoBvk0ftXfcEcFLwXEgiUEkwcwCWOcg@mail.gmail.com>
Subject: Lots of btrfs_dump_space_info in kernel log
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm running Debian Testing with kernel 5.2.17-1. Five disk raid1 with
at least 393.01GiB unallocated on each disk. No device errors. No
kernel WARNINGs or ERRORs.

BTRFS info (device dm-1): enabling auto defrag
BTRFS info (device dm-1): using free space tree
BTRFS info (device dm-1): has skinny extents

Mounted with noauto,noatime,autodefrag,skip_balance,space_cache=v2,enospc_debug.

First btrfs_dump_space_info() is

BTRFS info (device dm-1): space_info 4 has 18446744073353838592 free,
is not full
BTRFS info (device dm-1): space_info total=10737418240,
used=9636544512, pinned=0, reserved=27066368, may_use=1429454848,
readonly=65536
BTRFS info (device dm-1): global_block_rsv: size 536870912 reserved 536870912
BTRFS info (device dm-1): trans_block_rsv: size 0 reserved 0
BTRFS info (device dm-1): chunk_block_rsv: size 0 reserved 0
BTRFS info (device dm-1): delayed_block_rsv: size 20185088 reserved 20185088
BTRFS info (device dm-1): delayed_refs_rsv: size 868745216 reserved 868745216

and current last is

BTRFS info (device dm-1): space_info 4 has 0 free, is not full
BTRFS info (device dm-1): space_info total=10737418240,
used=9664561152, pinned=458752, reserved=2523136, may_use=1069809664,
readonly=65536
BTRFS info (device dm-1): global_block_rsv: size 536870912 reserved 536821760
BTRFS info (device dm-1): trans_block_rsv: size 0 reserved 0
BTRFS info (device dm-1): chunk_block_rsv: size 0 reserved 0
BTRFS info (device dm-1): delayed_block_rsv: size 0 reserved 0
BTRFS info (device dm-1): delayed_refs_rsv: size 556531712 reserved 498647040

with lots more in between and no other Btrfs kernel printing preceding
it since mounting.

It's the first time I'm seeing it but I have always mounted with
enospc_debug since it always seems too late to add the option when you
finally need it.

What does it mean? Should I be worried? What to do? No apparent problems yet.
