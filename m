Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB34E681B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 18:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243776AbiCXRzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRy6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 13:54:58 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111E541A6
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 10:53:24 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 8CBF3807B4;
        Thu, 24 Mar 2022 13:53:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648144403; bh=5TsMrsL2gRtlj+GDD1+bdr4ro4q1lysm2Nfo/T5BDV0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R0dapGmU+ywOi/Xv/w2MpTnPy4xJ9ex1gZWTE3EWB8LmK3vQ9FO1cn6gFZ02nkI+s
         uv9hZwpQTKtEc1Sp2Hw9WDgPRvEafoO3wg/u6gPOquTe3Tlw9Xaj3hePxK2wkAfyZE
         QoHQpnppMoApGREMvFacphQdmQuUqQWc44X6yR2dfsJW1YMn4rb9hq/QKGrD7kndOO
         DTAwlu8yi9eURRQOKV4LizJxYR/ECDIFjgGnyhXRAOyPw4sAgpC7zhXfH2LsOFuXBk
         TgKtZAvf9UUZzH3z6KX9+kAA8Qv0bp/iwf0xx8+61k6N6HXwjxw8mmGSYlwajPwJPp
         EWRh3Pn7mmuKg==
Message-ID: <9c515569-2a58-7ed5-e4a5-e274092ac12b@dorminy.me>
Date:   Thu, 24 Mar 2022 13:53:23 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v14 0/7] btrfs: add send/receive support for
 reading/writing compressed data
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1647537027.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the 7 kernel patches:
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

On 3/17/22 13:25, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series adds support for sending compressed data via Btrfs send and
> btrfs-progs support for sending/receiving compressed data and writing it
> with BTRFS_IOC_ENCODED_WRITE, which was previously merged into
> misc-next. See the previous posting for more details and benchmarks [1].
> 
> Patches 1 and 2 are cleanups for Btrfs send. Patches 3-5 prepare some
> protocol changes for send stream v2. Patch 6 implements compressed send.
> Patch 7 enables send stream v2 and compressed send in the send ioctl
> when requested.
> 
> Changes since v13 [2]:
> 
> - Rebased on latest misc-next branch.
> - Dropped ioctl patches which are already in misc-next.
> 
> 1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
> 2: https://lore.kernel.org/linux-btrfs/cover.1644519257.git.osandov@fb.com/
> 
> Omar Sandoval (7):
>    btrfs: send: remove unused send_ctx::{total,cmd}_send_size
>    btrfs: send: explicitly number commands and attributes
>    btrfs: add send stream v2 definitions
>    btrfs: send: write larger chunks when using stream v2
>    btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
>    btrfs: send: send compressed extents with encoded writes
>    btrfs: send: enable support for stream v2 and compressed writes
> 
>   fs/btrfs/ctree.h           |   6 +
>   fs/btrfs/inode.c           |  13 +-
>   fs/btrfs/send.c            | 324 +++++++++++++++++++++++++++++++++----
>   fs/btrfs/send.h            | 142 +++++++++-------
>   include/uapi/linux/btrfs.h |  10 +-
>   5 files changed, 395 insertions(+), 100 deletions(-)
> 
> The btrfs-progs patches were written by Boris Burkov with some updates
> from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
> Patch 6 implements the fallback to decompressing. Patches 7 and 8
> implement the other commands. Patch 9 adds the new `btrfs send` options.
> Patch 10 adds a test case.
> 
> Changes since v13:
> 
> - Rebased on latest devel branch.
> - Updated the btrfs_ioctl_encoded_io_args definition to the version that
>    was merged into misc-next.
> 
> Boris Burkov (8):
>    btrfs-progs: receive: support v2 send stream larger tlv_len
>    btrfs-progs: receive: dynamically allocate sctx->read_buf
>    btrfs-progs: receive: support v2 send stream DATA tlv format
>    btrfs-progs: receive: process encoded_write commands
>    btrfs-progs: receive: encoded_write fallback to explicit decode and
>      write
>    btrfs-progs: receive: process fallocate commands
>    btrfs-progs: receive: process setflags ioctl commands
>    btrfs-progs: receive: add tests for basic encoded_write send/receive
> 
> Omar Sandoval (2):
>    btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
>    btrfs-progs: send: stream v2 ioctl flags
> 
>   Documentation/btrfs-receive.rst               |   5 +
>   Documentation/btrfs-send.rst                  |  22 ++
>   cmds/receive-dump.c                           |  31 +-
>   cmds/receive.c                                | 347 +++++++++++++++++-
>   cmds/send.c                                   | 100 ++++-
>   common/send-stream.c                          | 165 +++++++--
>   common/send-stream.h                          |   7 +
>   ioctl.h                                       | 151 +++++++-
>   kernel-shared/send.h                          | 146 +++++---
>   libbtrfs/send-stream.c                        |   2 +-
>   .../052-receive-write-encoded/test.sh         | 114 ++++++
>   11 files changed, 993 insertions(+), 97 deletions(-)
>   create mode 100755 tests/misc-tests/052-receive-write-encoded/test.sh
> 
