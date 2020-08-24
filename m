Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78672508C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHXTHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 15:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXTHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 15:07:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A3C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 12:07:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so8531508qkb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R75/wZTikTt0dNTcj+8KTcBIGTQfY/v0lLDNE3h5aPk=;
        b=MBJv4eE1xnKeRqSFDQCwWlzSev2kiL+ncGq5jQOgy3izjJIYTm2Y6MEcjp0oJW0q1o
         e/w6HCnc391P7dWRcoDJ3jDK/SxXpVvTrOdLFW5MJaECgAAQRFhck8CFlVQY901DGBKB
         tuZqoa8mDWC1Noqpepr6FsegTPR9bZGPkNWW1lydKzDlOAJjakcwx9dgaqB5aQRhC5L4
         OKiYG0UYQVFCAl6m0LHNp4uHq7hJ6LRiQcURlzjNBPVEpdS5FVAA0OdwK3TQnhGjopXr
         eHtuZXhOZ3Ton4WCP1M5XmcOZDmeHoypdDZpE6uUVEecl7QA/xeLBftAwhzryUDmHWaV
         fWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R75/wZTikTt0dNTcj+8KTcBIGTQfY/v0lLDNE3h5aPk=;
        b=lWPYot8auswLV82CaSFEGRy+mTd0hL0KfqSrsirmK0IzPhkKDiPPY6praAHVAtc1mQ
         pa9jVZriW6fxZPC8LuN3zf5H20ALN0rBvva4V1focPY9I0rusiCk+mNdgkA5ohO3SQNc
         klDq4VJ6wktiqhWMDjJILYGAF7IFr/hvAT0TBANYHH3UODPgHBpryT1cJMGjy8Ll7J44
         Q64aitI7WImbneirnsKDXMCwLGAufUPB76Nw2fzUoiBE3hj6TXrVeGcn0IZMDc+gVu9l
         GmoAhFDbSz1UFHD+S6JzW7OZEjrkp4/xk7groAwfoeGUOZ6+tyKKHGNWrm8mxOwz3wq/
         95Ww==
X-Gm-Message-State: AOAM533FDrvXuPCfj9WMHCSF88DwVufsOgi1/7T4Ps2sk4owjrAPRZkA
        Wr6RkgAAZm4d/vbR00l9IGJ/Mw==
X-Google-Smtp-Source: ABdhPJy4J3uTjy2b5+ekxQKyEmxAWH4Mr/4vOy6XlkoSPF63/8phyu7dlNnBE88VTtGX08/XzP/j2g==
X-Received: by 2002:a05:620a:404f:: with SMTP id i15mr6018093qko.322.1598296035271;
        Mon, 24 Aug 2020 12:07:15 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d20sm10031235qkk.84.2020.08.24.12.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:07:14 -0700 (PDT)
Subject: Re: [PATCH v5 3/9] fs: add RWF_ENCODED for reading/writing compressed
 data
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <9020a583581b644ae86b7c05de6a39fd5204f06d.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1ec3bd15-65b3-a258-df4c-bef4f8401b75@toxicpanda.com>
Date:   Mon, 24 Aug 2020 15:07:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9020a583581b644ae86b7c05de6a39fd5204f06d.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Btrfs supports transparent compression: data written by the user can be
> compressed when written to disk and decompressed when read back.
> However, we'd like to add an interface to write pre-compressed data
> directly to the filesystem, and the matching interface to read
> compressed data without decompressing it. This adds support for
> so-called "encoded I/O" via preadv2() and pwritev2().
> 
> A new RWF_ENCODED flags indicates that a read or write is "encoded". If
> this flag is set, iov[0].iov_base points to a struct encoded_iov which
> is used for metadata: namely, the compression algorithm, unencoded
> (i.e., decompressed) length, and what subrange of the unencoded data
> should be used (needed for truncated or hole-punched extents and when
> reading in the middle of an extent). For reads, the filesystem returns
> this information; for writes, the caller provides it to the filesystem.
> iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
> used to extend the interface in the future a la copy_struct_from_user().
> The remaining iovecs contain the encoded extent.
> 
> This adds the VFS helpers for supporting encoded I/O and documentation
> for filesystem support.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
