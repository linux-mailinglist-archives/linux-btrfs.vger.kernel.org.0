Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBD1698E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfEGRrL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:47:11 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41814 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEGRrL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:47:11 -0400
Received: by mail-yw1-f68.google.com with SMTP id o65so12135729ywd.8
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGRr6w1pSja22p5YiWcfrTDDronnqrfgN9MQFfg+UUI=;
        b=1+tU3ZXXjIA94/INdWd5Rvuy9QOPpUJ+aH+S0kmPseJCqGOCInQ6oMh1E8qfBgqKhJ
         7+vSLR4fIN0nVxwU0NEXa3nrn28c/6cf8tKX58hH2zZtH/XRkTt/D73CaqeI3SQzmMPk
         aqVEroXDt4/1BxASxlsZhV0gC5I/fnCp0WvwUqP1g44cZhM39U6gR/h8wd3aNl+/X9nh
         SlgFfAoac63gBlXE2xNNBzab+eaIJsKzCPm6heV+20bXkGBtdTWLt5QDoWZ+ES4BsPrM
         a7hXr45ir0mcgZq+bBFsutp8/j7pxJ7Tc6Pd0hBgfXt4rwjIsez/S4MYFA2zbpLEaWXp
         bVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGRr6w1pSja22p5YiWcfrTDDronnqrfgN9MQFfg+UUI=;
        b=GROhsqHqy7S7YjPqqsAI14TIO9Sg1P9Zf5YzQjxp0BXn6fbv9/0ZWjAEOmGcJmZhTa
         GFOSrRufpOUXvtrNpZZqQ+96FOCbrXsmbWMCeglZzQqtMJeqYDm8PheXo5ajkF1lXMlb
         xndMobygCGU2fJO8ui8ThUXK5ec2qtAxoUXsfNKPDeVBSBU73Nbw4FZs7G1M1zeSRfpL
         7DkvFjGiTttEurk0ZfpDzTwnORtYmV+yOfRm0XlII5WKUUj6MCDV8IeZ1oFdA77AFas0
         t0hIL7C1XcwIrpQXMpQk6/KjQFDmEwTOKDFgHSY7Mg9v571VbZBsEa5I2Um3lYQieNt8
         CaMQ==
X-Gm-Message-State: APjAAAV2FkECmWtkVNp41C/ZGGf2iJ+9GjkIuy3Do78nipqf4urArCln
        Snw3VsWvT7WWiHfBYs8ieuDwPYoA1+4Qv0BY
X-Google-Smtp-Source: APXvYqwuAmURiZYmy+k2pF1zJ2iGW7SYXasphAyFX2r0eIQF6jB3skbOwFHjWUqZxsJV5g+nrKBBRw==
X-Received: by 2002:a81:794c:: with SMTP id u73mr23182265ywc.447.1557251230409;
        Tue, 07 May 2019 10:47:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id l17sm2637923ywm.31.2019.05.07.10.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:47:09 -0700 (PDT)
Date:   Tue, 7 May 2019 13:47:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: avoid fallback to transaction commit during fsync
 of files with holes
Message-ID: <20190507174707.ttjywym3xpn3s23w@macbook-pro-91.dhcp.thefacebook.com>
References: <20190506154351.20047-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506154351.20047-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 06, 2019 at 04:43:51PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we are doing a full fsync (bit BTRFS_INODE_NEEDS_FULL_SYNC set) of a
> file that has holes and has file extent items spanning two or more leafs,
> we can end up falling to back to a full transaction commit due to a logic
> bug that leads to failure to insert a duplicate file extent item that is
> meant to represent a hole between the last file extent item of a leaf and
> the first file extent item in the next leaf. The failure (EEXIST error)
> leads to a transaction commit (as most errors when logging an inode do).
> 
> For example, we have the two following leafs:
> 
> Leaf N:
> 
>   -----------------------------------------------
>   | ..., ..., ..., (257, FILE_EXTENT_ITEM, 64K) |
>   -----------------------------------------------
>   The file extent item at the end of leaf N has a length of 4Kb,
>   representing the file range from 64K to 68K - 1.
> 
> Leaf N + 1:
> 
>   -----------------------------------------------
>   | (257, FILE_EXTENT_ITEM, 72K), ..., ..., ... |
>   -----------------------------------------------
>   The file extent item at the first slot of leaf N + 1 has a length of
>   4Kb too, representing the file range from 72K to 76K - 1.
> 
> During the full fsync path, when we are at tree-log.c:copy_items() with
> leaf N as a parameter, after processing the last file extent item, that
> represents the extent at offset 64K, we take a look at the first file
> extent item at the next leaf (leaf N + 1), and notice there's a 4K hole
> between the two extents, and therefore we insert a file extent item
> representing that hole, starting at file offset 68K and ending at offset
> 72K - 1. However we don't update the value of *last_extent, which is used
> to represent the end offset (plus 1, non-inclusive end) of the last file
> extent item inserted in the log, so it stays with a value of 68K and not
> with a value of 72K.
> 
> Then, when copy_items() is called for leaf N + 1, because the value of
> *last_extent is smaller then the offset of the first extent item in the
> leaf (68K < 72K), we look at the last file extent item in the previous
> leaf (leaf N) and see it there's a 4K gap between it and our first file
> extent item (again, 68K < 72K), so we decide to insert a file extent item
> representing the hole, starting at file offset 68K and ending at offset
> 72K - 1, this insertion will fail with -EEXIST being returned from
> btrfs_insert_file_extent() because we already inserted a file extent item
> representing a hole for this offset (68K) in the previous call to
> copy_items(), when processing leaf N.
> 
> The -EEXIST error gets propagated to the fsync callback, btrfs_sync_file(),
> which falls back to a full transaction commit.
> 
> Fix this by adjusting *last_extent after inserting a hole when we had to
> look at the next leaf.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
