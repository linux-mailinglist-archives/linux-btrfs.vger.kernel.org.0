Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87651230E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfLQPwv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:52:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42822 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfLQPwv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:52:51 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so2703389qvb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euijH+83jii7JzHUrECbBqFT7WeW+Nhi4IzOJkiDJGI=;
        b=kBDNkw0YY2PIwn/SGocfh0P+HSUgeSYZ3MiQ0OS3MSJncVzHvU7NHPEKNeMgHs8RmJ
         CaVbkLzcoJOLaegbFUITWDI6t2yCLsYlTsrk2zVXzl6Gmyk8/lVFer2Z05PaM+adH85o
         oyuOKADeGCTP2tKwebIZjn/cmdSwrXeNulxPhNVx/ajVyBtgASJDvVqYzp9mC70ZASKI
         FGxASyfLksXBLSrtdH2M6Y48cNOiuZNDtzyDBDO/Qp2Vrpv/UZ103oV5KCjZ4zDE4Xz+
         McwzGmpZ/Zl9qGn+5yiil/mAwIK/gfFvnq1pceM5XU5ub9GB2n2luyBjkx0gj/+YBpsa
         PtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euijH+83jii7JzHUrECbBqFT7WeW+Nhi4IzOJkiDJGI=;
        b=Ae8NPDFm283XSvqKmmQy3x9fap7QYxZZmdMzTUpiMQrkkXz5muYPmfcYgNQPN7vouR
         5rPvZHR7qpfb2G2+gOxHJr4hjEfB4FouTAWbHwAEM0X936sJbB9zUqp9jp4AB2fUZmhY
         +xKpty6qHOZrFaY+aFzb+WoZVOS2eKm6Kv63hmi/728Pkj9LDtESsulvIN4KBpVukTLC
         6NTf3LoVpA0fE5TkMNv3CWZYCMw451SuFEoXaSx2RC4qhfchQ9stBCeFkteuGn/YSal6
         2cqomRCwm27GEvkDIimJjO6p1zFw8VOg3bz1q1oofer5Znza2PXHPB87/ErfzPkBtITI
         j6jA==
X-Gm-Message-State: APjAAAUK6TMVAkh9LQSTsTm3rfbVj3smzk8Q3y0jbXpjUqGHW5yfoatp
        lWbbGrG+lVkrgRVXwS/dc2Supg==
X-Google-Smtp-Source: APXvYqwkat85lNTVGiOenaYThCNyCW5eFMy0MF8/SjIL3VuARZPNXwRlwLOBot1gF9FTJa9QFgHryg==
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr5366804qvp.68.1576597970271;
        Tue, 17 Dec 2019 07:52:50 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm5374937qtn.65.2019.12.17.07.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:52:49 -0800 (PST)
Subject: Re: [PATCH 1/2] fs: allow deduplication of eof block into the end of
 the destination file
To:     fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, Filipe Manana <fdmanana@suse.com>
References: <20191216182656.15624-1-fdmanana@kernel.org>
 <20191216182656.15624-2-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b091e6fc-cc28-f4b5-26dd-a8a07a154d58@toxicpanda.com>
Date:   Tue, 17 Dec 2019 10:52:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216182656.15624-2-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/16/19 1:26 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We always round down, to a multiple of the filesystem's block size, the
> length to deduplicate at generic_remap_check_len().  However this is only
> needed if an attempt to deduplicate the last block into the middle of the
> destination file is requested, since that leads into a corruption if the
> length of the source file is not block size aligned.  When an attempt to
> deduplicate the last block into the end of the destination file is
> requested, we should allow it because it is safe to do it - there's no
> stale data exposure and we are prepared to compare the data ranges for
> a length not aligned to the block (or page) size - in fact we even do
> the data compare before adjusting the deduplication length.
> 
> After btrfs was updated to use the generic helpers from VFS (by commit
> 34a28e3d77535e ("Btrfs: use generic_remap_file_range_prep() for cloning
> and deduplication")) we started to have user reports of deduplication
> not reflinking the last block anymore, and whence users getting lower
> deduplication scores.  The main use case is deduplication of entire
> files that have a size not aligned to the block size of the filesystem.
> 
> We already allow cloning the last block to the end (and beyond) of the
> destination file, so allow for deduplication as well.
> 
> Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
