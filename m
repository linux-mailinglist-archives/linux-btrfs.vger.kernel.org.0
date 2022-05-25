Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717AF533543
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 04:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiEYCUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 22:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiEYCUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 22:20:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB93ED25
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 19:20:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s23so20085705iog.13
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 19:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUvnzAlUJFVDIbRY8BXBuYo/9zfk6JPDjEmCFsqz9jw=;
        b=ZkXeHN/ZhTJEfXqA82OZ33YoQaxuIMrC2t/QPiJ1Wj5+hQvhrQMokePNh5nJ8fAqCY
         zAW+Ox/UmmVPfHlp91Ky60d0B71LpYX9wPTe+Ci/yN1MPTo7Qm6Qjga6sjimlJfVSbUj
         P+q4Y+xAjtFzdtMul4LYN+pj6YZhB4BK7Uq49CBrpP404WmlGcsweV1nkrNqWfnRx0lM
         gQX4S9Vd+2T9VF2JOL2LOdyfSTsc/38xeCCOoqYZ18cx6jn+vCs6BbLpFj8Z5uJgqRSJ
         gIFK2XPvNTSZ6b+ffmg8CJ3jXw2oKeF5minUoaVRwJ+tfTPfk5oSx0V4LaFC7xA7a1jH
         OVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUvnzAlUJFVDIbRY8BXBuYo/9zfk6JPDjEmCFsqz9jw=;
        b=4oTtinroq/YId6TxR9vJOHOuqS9BNZGutcKm5sio9f/vASFDJqQjpWJhJZUwsKSYh9
         pU7YXDRsiJOHqbL3Au4alIZ8cG1oAX1pj8creUFo05PG1/8nxVz/h3HkBmmy6+JC/nKO
         zRoUBCVrTe5+WGrRTsLVcmx7XifCsseJq8UUNxlN9A/M/dMJ9lq1AJwkgYL0eZ/QVedd
         U5Y2SH7T8pzT3nNWeY6+LBZMLIx0fHqv9fOcY4OLltJPq8bbo9jwGA/VBD239WVwYv3h
         BpndYKNHhOE1wLvfRf28PeNcp4aHt9963SaLG0lNeqvIhJW52zBBzDpBZY81heGPmw5R
         TwGg==
X-Gm-Message-State: AOAM533BzcvbKO3v7p1zSZWK6dHA/WmpYx9h4hBWey7tA09enhioLrXn
        IAARDuwGFQkAKu2FdhEA4+GhyJuwj5uzzqcqNi3kzm3v
X-Google-Smtp-Source: ABdhPJxPiTOupiHirW6vANEiusdD/nAiJUoYbMOI3GTMCvFnhb8ODoqZW8IQznEmoMtegsmoaoQQCfS+Ikh02UQcQ3M=
X-Received: by 2002:a02:cca8:0:b0:32e:7683:2400 with SMTP id
 t8-20020a02cca8000000b0032e76832400mr15975506jap.15.1653445203587; Tue, 24
 May 2022 19:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
In-Reply-To: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Tue, 24 May 2022 21:19:52 -0500
Message-ID: <CA+H1V9zNSiJgXj6w8i2syhm_4qeaxkYPZHuxLgjmfP-jjGMYBQ@mail.gmail.com>
Subject: Re: cp --reflink and NOCOW files
To:     kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo,

You can only reflink files which are COW. If you want to reflink files
which are NOCOW, you have to copy them to a COW file (eg. cp
file-very-big-nocow file-very-big-cow) and then you can reflink it.
It's recommended to keep everything COW unless it has many random
writes like databases and virtual machines.

Matthew Warren

On Tue, May 24, 2022 at 8:19 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> Hi All,
>
> recently I discovered that BTRFS doesn't allow to reflink a file
> when the source is marked as NOCOW
>
> $ lsattr
> ---------------C------ ./file-very-big-nocow
> $ cp --reflink file-very-big-nocow file2
> cp: failed to clone 'file2' from 'file-very-big-nocow': Invalid argument
> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
>
> My first thought was that it would be sufficient to remove the "nocow" flag.
> But I was unable to do that.
>
> $ chattr -C file-very-big-nocow
>
> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
>
> (I tried "chattr +C ..." too)
>
> Ok, now my question is: how we can remove the NOCOW flag from a file ?
>
> My use case is to move files between subvolumes some of which are marked as NOWCOW.
> The files are videos, so I want to avoid to copy the data.
>
>
> BR
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
