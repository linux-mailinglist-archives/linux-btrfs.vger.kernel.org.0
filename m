Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723AD31CD2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 16:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBPPtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 10:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhBPPte (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 10:49:34 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01152C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 07:48:52 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c3so9147435qkj.11
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 07:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9edAs0nseDg9TvXiZylAJ4oS3FlHxnBMfe2ThGci0G8=;
        b=JpDaxuPJ8J57SU3byNZlo3nXDW6FQ4gDJGg6bT4ZspW40ynvAI2MxczTHZikyA0fhT
         Jpmn2PUayj6JCgcl/SXd5A7AQzv0YRwsiENuWnInHzSsPeJc0m2QslMC00TnFXvqGjnH
         pyPVEFvM7nhkwXsPE0i2gLf1Wm4E4TZaL9DXQuC56SNhmZ2biJ5DTEfZKCYvc/uxEFnC
         XUalalPxVNsUJgHE3p8KQPZj6/EyAbDEVi1qc3Y3Nx9DLYb6PKmMp0/E0qjsl4kXN8a7
         +nwje/QhouHMNQc9096xBiECY1VJC8+ZVWuTmYeFmD9s2frmU60jVirH5T56fIkzYz+q
         aSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9edAs0nseDg9TvXiZylAJ4oS3FlHxnBMfe2ThGci0G8=;
        b=ElG0aHpvg64c85zSGNp3+vcrSQ+cjgP3PsO7MnAzvZ0io7vdbAlUiIl7nWc2aKtgdC
         7Y3e7lIXvfWggV6/t1bUG9dJfl4kU54MOgOoTPC6ZTU2utVRn+fOrHmhY9c9kYpkmwWc
         HmJHuquYyz2Nib5YMHQ6SV0p0z37QUTZA4MyLawCSl2LZJQVI86mMQKQrJkEqwJSOXa/
         xH33k118r2XbE//NCD5buG6L6njXN9f+WrAqewB5lv/fP41c0eaiNGEG3Gyj8TpUAMgY
         3os6T3D+FIq7ZxiqImeHPfWPZ05IKOxrxWM5dTN1BBHiQrKSnEwsjk9u5AhYyE0zbM7e
         7U9Q==
X-Gm-Message-State: AOAM532GRS4ptg3fLlcUPH24hyqxAffZe8yo8JI0VcB0/RofC52UGXjA
        PjZQwBY2cL0sjnV0dp/l3r0N3Bxa+lDsOrhp
X-Google-Smtp-Source: ABdhPJxj5bwF4bBynAG4VToHxSVXCX+Sl1YlksEyZ+IMoW28m7lmQYg2pDNxog70kCJXotY+48MlPg==
X-Received: by 2002:a37:b404:: with SMTP id d4mr20398119qkf.183.1613490530764;
        Tue, 16 Feb 2021 07:48:50 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm15162065qkj.9.2021.02.16.07.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 07:48:50 -0800 (PST)
Subject: Re: [PATCH] btrfs: fix stale data exposure after cloning a hole with
 NO_HOLES enabled
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <07067d184eb90be19874190df45cc83f06186307.1613473473.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <40803a05-1f71-b648-4b59-dade906e48cf@toxicpanda.com>
Date:   Tue, 16 Feb 2021 10:48:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <07067d184eb90be19874190df45cc83f06186307.1613473473.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/16/21 6:09 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the NO_HOLES feature, if we clone a file range that spans only
> a hole into a range that is at or beyond the current i_size of the
> destination file, we end up not setting the full sync runtime flag on the
> inode. As a result, if we then fsync the destination file and have a power
> failure, after log replay we can end up exposing stale data instead of
> having a hole for that range.
> 
> The conditions for this to happen are the following:
> 
> 1) We have a file with a size of, for example, 1280K;
> 
> 2) There is a written (non-prealloc) extent for the file range from 1024K
>     to 1280K with a length of 256K;
> 
> 3) This particular file extent layout is durably persisted, so that the
>     existing superblock persisted on disk points to a subvolume root where
>     the file has that exact file extent layout and state;
> 
> 4) The file is truncated to a smaller size, to an offset lower than the
>     start offset of its last extent, for example to 800K. The truncate sets
>     the full sync runtime flag on the inode;
> 
> 6) Fsync the file to log it and clear the full sync runtime flag;
> 
> 7) Clone a region that covers only a hole (implicit hole due to NO_HOLES)
>     into the file with a destination offset that starts at or beyond the
>     256K file extent item we had - for example to offset 1024K;
> 
> 8) Since the clone operation does not find extents in the source range,
>     we end up in the if branch at the bottom of btrfs_clone() where we
>     punch a hole for the file range starting at offset 1024K by calling
>     btrfs_replace_file_extents(). There we end up not setting the full
>     sync flag on the inode, because we don't know we are being called in
>     a clone context (and not fallocate's punch hole operation), and
>     neither do we create an extent map to represent a hole because the
>     requested range is beyond eof;
> 
> 9) A further fsync to the file will be a fast fsync, since the clone
>     operation did not set the full sync flag, and therefore it relies on
>     modified extent maps to correctly log the file layout. But since
>     it does not find any extent map marking the range from 1024K (the
>     previous eof) to the new eof, it does not log a file extent item
>     for that range representing the hole;
> 
> 10) After a power failure no hole for the range starting at 1024K is
>     punched and we end up exposing stale data from the old 256K extent.
> 
> Turning this into exact steps:
> 
>    $ mkfs.btrfs -f -O no-holes /dev/sdi
>    $ mount /dev/sdi /mnt
> 
>    # Create our test file with 3 extents of 256K and a 256K hole at offset
>    # 256K. The file has a size of 1280K.
>    $ xfs_io -f -s \
>                -c "pwrite -S 0xab -b 256K 0 256K" \
>                -c "pwrite -S 0xcd -b 256K 512K 256K" \
>                -c "pwrite -S 0xef -b 256K 768K 256K" \
>                -c "pwrite -S 0x73 -b 256K 1024K 256K" \
>                /mnt/sdi/foobar
> 
>    # Make sure it's durably persisted. We want the last committed super
>    # block to point to this particular file extent layout.
>    sync
> 
>    # Now truncate our file to a smaller size, falling within a position of
>    # the second extent. This sets the full sync runtime flag on the inode.
>    # Then fsync the file to log it and clear the full sync flag from the
>    # inode. The third extent is no longer part of the file and therefore
>    # it is not logged.
>    $ xfs_io -c "truncate 800K" -c "fsync" /mnt/foobar
> 
>    # Now do a clone operation that only clones the hole and sets back the
>    # file size to match the size it had before the truncate operation
>    # (1280K).
>    $ xfs_io \
>          -c "reflink /mnt/foobar 256K 1024K 256K" \
>          -c "fsync" \
>          /mnt/foobar
> 
>    # File data before power failure:
>    $ od -A d -t x1 /mnt/foobar
>    0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>    *
>    0262144 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    *
>    0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    0786432 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
>    *
>    0819200 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    *
>    1310720
> 
>    <power fail>
> 
>    # Mount the fs again to replay the log tree.
>    $ mount /dev/sdi /mnt
> 
>    # File data after power failure:
>    $ od -A d -t x1 /mnt/foobar
>    0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>    *
>    0262144 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    *
>    0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    0786432 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
>    *
>    0819200 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    *
>    1048576 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73
>    *
>    1310720
> 
> The range from 1024K to 1280K should correspond to a hole but instead it
> points to stale data, to the 256K extent that should not exist after the
> truncate operation.
> 
> The issue does not exists when not using NO_HOLES, because for that case
> we use file extent items to represent holes, these are found and copied
> during the loop that iterates over extents at btrfs_clone(), and that
> causes btrfs_replace_file_extents() to be called with a non-NULL
> extent_info argument and therefore set the full sync runtime flag on the
> inode.
> 
> So fix this by making the code that deals with a trailing hole during
> cloning, at btrfs_clone(), to set the full sync flag on the inode, if the
> range starts at or beyond the current i_size.
> 
> A test case for fstests will follow soon.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
