Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067FD1230E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLQPyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:54:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44931 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfLQPyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:54:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so8620337qkb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FrgXCPHR9btMfeIdHTbNWeV8ODv6lZgUMr2Q8WrtSfU=;
        b=Lt7hmhHgk1ULmrhWVVIVTh9/nBksNGhvqgPabJnM39tzJbSYjxP2D0l2wz/gp7jUqQ
         iEONNUEnpCZikJEX9BB0IgddIZlsWm/yGmiYVcC/Pzlbj/fWjAX8TvIwS8zU9CNaW2+B
         lkZS2h74jEzCoU9V7IpPebyZbbubrq1GQRQlahyupZ/QrVvcqfm+1bdyKPpsWU5mZHRN
         xmMkZYP9d9HjDN3RBU+dytfOuptGMMNyQR7tAgJ/UBMeafGtI8eTc1XoJjeEv+I2NIhB
         zefYFPLJBctLpxLTDILZwVmd/QKrO5qzdSmIn4X4o5Vj+YmiIyj6dHZbZhPf9I4fLDSx
         3KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FrgXCPHR9btMfeIdHTbNWeV8ODv6lZgUMr2Q8WrtSfU=;
        b=JfPPbXioBLBZtJ9tVaZeEUJym+FO48ItFB9C9QYtQ5krMJzE7viSMiRNHQZpZ1HrT3
         8eNB1KeTJ+bw3hY6Xx7Rr9tn6Fc03IU3Q9ll8vRiyaqDtNZCGZdw7tFBsUk27vrJzXs9
         ORyHXV9Lncv0gGaBVjtiKKlMpjpyCuacxUFxBVBlJCvgnpocmRg783XlJuCFp7KcOcog
         RFDOA4OdhBZQUNomdIYYLjgDnTqow2rQg7I7Y1uMlVzNl9m+l0kQiKBx6IroSGtA6F27
         wNFEMd6zWHxxlerkuyU1DUsuwkBJ+NDHhcqGHbEuKNUi9lYgF4O5UwAUgLfTw/x+JlHG
         kD8g==
X-Gm-Message-State: APjAAAXAXeX7XDB4Uic8LDtR+KSe336GVnuGbBBRcWDsaJw8veU4auTG
        4bYRfqzTFqABV9v/2gelDxWoDA==
X-Google-Smtp-Source: APXvYqzVMoQDJClWFu9ICaWjnEyOV+odOCrnXNeEyYQghjzGiTd/2S2YEjZKErLWvWxVX7ZwMgq0qA==
X-Received: by 2002:a37:9c7:: with SMTP id 190mr5366537qkj.425.1576598061928;
        Tue, 17 Dec 2019 07:54:21 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm8309016qti.10.2019.12.17.07.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:54:21 -0800 (PST)
Subject: Re: [PATCH 2/2] Btrfs: make deduplication with range including the
 last block work
To:     fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, Filipe Manana <fdmanana@suse.com>
References: <20191216182656.15624-1-fdmanana@kernel.org>
 <20191216182656.15624-3-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <48d51dc3-b2c0-baa4-bfed-0194485db11f@toxicpanda.com>
Date:   Tue, 17 Dec 2019 10:54:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216182656.15624-3-fdmanana@kernel.org>
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
> Since btrfs was migrated to use the generic VFS helpers for clone and
> deduplication, it stopped allowing for the last block of a file to be
> deduplicated when the source file size is not sector size aligned (when
> eof is somewhere in the middle of the last block). There are two reasons
> for that:
> 
> 1) The generic code always rounds down, to a multiple of the block size,
>     the range's length for deduplications. This means we end up never
>     deduplicating the last block when the eof is not block size aligned,
>     even for the safe case where the destination range's end offset matches
>     the destination file's size. That rounding down operation is done at
>     generic_remap_check_len();
> 
> 2) Because of that, the btrfs specific code does not expect anymore any
>     non-aligned range length's for deduplication and therefore does not
>     work if such nona-aligned length is given.
> 

Does anybody else rely on this behavior that needs a change like this for their fs?

> This patch addresses that second part, and it depends on a patch that
> fixes generic_remap_check_len(), in the VFS, which was submitted ealier
> and has the following subject:
> 
>    "fs: allow deduplication of eof block into the end of the destination file"
> 
> These two patches address reports from users that started seeing lower
> deduplication rates due to the last block never being deduplicated when
> the file size is not aligned to the filesystem's block size.
> 
> Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
