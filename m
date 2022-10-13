Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ACE5FD907
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJMMOu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 08:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJMMOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 08:14:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E42FFFA6;
        Thu, 13 Oct 2022 05:14:28 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.26.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB3786600368;
        Thu, 13 Oct 2022 13:14:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665663255;
        bh=S+BNjC705jMWNIoRpFbauuWJfWYy/25S3l4WLgp8d7s=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=R02fEA9lIFS+CGwB4Dhu1zlIYvMUEp9NcoMhHFhfZXxhSCZsdsmSgwdDg3fEkVR5H
         UG9UHdS4prrx5bA+qZOUpr/uD65Hjqnkbh7t9HjzfmCkTTJKIkA9MzWqrnn53F8nak
         FKNccQwlFJblMVfWJW7mXJXTSb/fzmZRKrbpacSGsCnYa7Ltn705bLjxjjvpgXTqEo
         YbkkY+XTkjLgFWr+Va+7ETGijytbjmZGNnfXq4RHpFGwwkj/ZzV4e1R9/tXubrM/hD
         rFbFH7I/x1GJIpIKb6i9xO+Vjd5NK8QNggb0zDFLEgA27Oi36MNWc4238b8xUqst2z
         QWuSqabFEVgog==
Message-ID: <c8d135f8-8fbf-2314-9efc-ec172233150f@collabora.com>
Date:   Thu, 13 Oct 2022 17:14:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH RFC v2 00/16] btrfs: add fscrypt integration
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cover.1658623319.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I see no comment on this RFC. Is there any next version?

Thanks,
Usama

On 7/24/22 5:53 AM, Sweet Tea Dorminy wrote:
> This is a draft set of changes adding fscrypt integration to btrfs.
> 
> Last October, Omar sent out a design document for having fscrypt
> integration with btrfs [1]. In summary, it proposes btrfs storing its
> own encryption IVs on a per-file-extent basis. fscrypt usually encrypts
> files using an IV derived from per-inode information; this would prevent
> snapshotting or reflinking or data relocation for btrfs, but by using an
> IV associated with each file extent, all the inodes sharing a particular
> key and file extent may decrypt successfully.
> 
> This series starts implementing it on the kernel side for the simple
> case, non-compressed data extents. My goal in sending out this RFC is to
> get feedback on whether these are going in a reasonable direction; while
> there are a couple of additional parts, they're fundamentally minor
> compared to this.
> 
> Not included are a couple of minor changes to btrfs-progs; additionally,
> none of the fscrypt tool changes needed to use the new encryption policy
> are included. Obviously, additional fstests will be needed. Also not yet
> included are encryption for inline data extents, verity items, and
> compressed data.
> 
> [1]
> https://lore.kernel.org/linux-btrfs/YXGyq+buM79A1S0L@relinquished.localdomain/
> 
> Changelog:
> 
> v2:
>   - Fixed all warnings and known incorrectnesses.
>   - Split fscrypt changes into their own patchset:
>      https://lore.kernel.org/linux-fscrypt/cover.1658623235.git.sweettea-kernel@dorminy.me
>   - Combined and reordered changes so that enabling fscrypt is the last change.
>   - Removed unnecessary factoring.
>   - Split a cleanup change off.
> 
> v1:
>   - https://lore.kernel.org/linux-btrfs/cover.1657707686.git.sweettea-kernel@dorminy.me
> 
> Omar Sandoval (13):
>    btrfs: store directories' encryption state
>    btrfs: factor a fscrypt_name matching method
>    btrfs: disable various operations on encrypted inodes
>    btrfs: add fscrypt operation table to superblock
>    btrfs: start using fscrypt hooks.
>    btrfs: add a subvolume flag for whole-volume encryption
>    btrfs: translate btrfs encryption flags and encrypted inode flag.
>    btrfs: store an IV per encrypted normal file extent
>    btrfs: Add new FEATURE_INCOMPAT_FSCRYPT feature flag.
>    btrfs: reuse encrypted filename hash when possible.
>    btrfs: adapt directory read and lookup to potentially encrypted
>      filenames
>    btrfs: encrypt normal file extent data if appropriate
>    btrfs: implement fscrypt ioctls
> 
> Sweet Tea Dorminy (3):
>    btrfs: use fscrypt_name's instead of name/len everywhere.
>    btrfs: setup fscrypt_names from dentrys using helper
>    btrfs: add iv generation function for fscrypt
> 
>   fs/btrfs/Makefile               |   1 +
>   fs/btrfs/btrfs_inode.h          |   3 +
>   fs/btrfs/ctree.h                | 113 +++++--
>   fs/btrfs/delayed-inode.c        |  48 ++-
>   fs/btrfs/delayed-inode.h        |   9 +-
>   fs/btrfs/dir-item.c             | 120 ++++---
>   fs/btrfs/extent_io.c            |  93 +++++-
>   fs/btrfs/extent_io.h            |   2 +
>   fs/btrfs/extent_map.h           |   8 +
>   fs/btrfs/file-item.c            |  20 +-
>   fs/btrfs/file.c                 |  11 +-
>   fs/btrfs/fscrypt.c              | 224 +++++++++++++
>   fs/btrfs/fscrypt.h              |  49 +++
>   fs/btrfs/inode-item.c           |  84 ++---
>   fs/btrfs/inode-item.h           |  14 +-
>   fs/btrfs/inode.c                | 547 ++++++++++++++++++++++++--------
>   fs/btrfs/ioctl.c                |  80 ++++-
>   fs/btrfs/ordered-data.c         |  12 +-
>   fs/btrfs/ordered-data.h         |   3 +-
>   fs/btrfs/print-tree.c           |   4 +-
>   fs/btrfs/props.c                |  11 +-
>   fs/btrfs/reflink.c              |   8 +
>   fs/btrfs/root-tree.c            |  20 +-
>   fs/btrfs/send.c                 | 141 ++++----
>   fs/btrfs/super.c                |   8 +-
>   fs/btrfs/transaction.c          |  43 ++-
>   fs/btrfs/tree-checker.c         |  56 +++-
>   fs/btrfs/tree-log.c             | 261 ++++++++-------
>   fs/btrfs/tree-log.h             |   4 +-
>   fs/btrfs/xattr.c                |  21 +-
>   include/uapi/linux/btrfs.h      |   1 +
>   include/uapi/linux/btrfs_tree.h |  26 ++
>   32 files changed, 1525 insertions(+), 520 deletions(-)
>   create mode 100644 fs/btrfs/fscrypt.c
>   create mode 100644 fs/btrfs/fscrypt.h
> 
