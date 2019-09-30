Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FCEC2291
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfI3OA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 10:00:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40549 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3OA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 10:00:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so7802811qkb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YyFaiWxpZyLpxFNQ4ZgtgO/IsdzGfkP9MRfAmUd/lwA=;
        b=ThQl2mqmHtDm/T+V4qHVCAIkTInbweHSyZhCO+F/03eME0bbmhQTPR6/bfmgiivLXj
         il+2LP9Ga/c4aJ2UlzNMYLZjT0NHDz5LyV/4kAZIzuZxGH52ga/md1KK3Zyl93/0Gj9J
         iLD90NEg+ymKzx080dfvtsWj2wIRYRLdvfWBBjGxSD4khX80E7r/CzRO47u87vKcb0Rg
         GBKbxNyVdKdKX3Ro5B4lnRUvUPU8G3J/dGO2Yl6vD01NKTB2mMC/aQy7JHO7NuL69EoY
         GIcgf4urKIMSfZFEDg0odrZukYgknnlp0LitaEd7ldniAChvZg2ruBPSuEPBVg/q3PHZ
         7p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyFaiWxpZyLpxFNQ4ZgtgO/IsdzGfkP9MRfAmUd/lwA=;
        b=WMQrr+Na45oK9IKoeaTpCPIEkfVGwSJvoI8yixyybgwLr+FmvaKzUaP54R10Z1d76M
         OR/JVc2DwiVbPbyYsjpOrq6WGzrtGJKpntez0hlJ3p/pAKnyv5cw99xO+6dz2V9YZzJ3
         upbXZRAuD3dV8T5J0bh7+YgG+B7TrJRs9nsQhkmL+nl01XX7yiZXcih93+dbe/ctfWLm
         jWBusNOBhevncidhH4S7YQJj0s5DJ7frHY94qHkP5xqn23MLe7+/vsC+yl3ajHbP9Awl
         e+YhS+WFS//WVPr5FtR4+FVCIyaXa1efJ/fByahqaWaUR9fo4owX7oB+7JSPOPX7St0X
         HnAw==
X-Gm-Message-State: APjAAAUAiG+oiV0Y31/rWo0c+jYloAvh/hvGMBBnSq0fapzooMMJzNHO
        wzX1UNupvfF50ZW9NmSDQjSC+Cu3iRxygQ==
X-Google-Smtp-Source: APXvYqzolUSwDsr+92dec7AD6K3QGDdWBZLL63GXf/xfAl5M5eRapF7Ef6h6raLVUDCKUkk1jNqFRQ==
X-Received: by 2002:a37:85c7:: with SMTP id h190mr30141qkd.233.1569852054760;
        Mon, 30 Sep 2019 07:00:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6909])
        by smtp.gmail.com with ESMTPSA id l23sm11326589qta.53.2019.09.30.07.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 07:00:53 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:00:51 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix memory leak due to concurrent append writes
 with fiemap
Message-ID: <20190930140049.h4s6vahgaoyyxlwy@macbook-pro-91.dhcp.thefacebook.com>
References: <20190930092025.31118-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930092025.31118-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 10:20:25AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we have a buffered write that starts at an offset greater than or
> equals to the file's size happening concurrently with a full ranged
> fiemap, we can end up leaking an extent state structure.
> 
> Suppose we have a file with a size of 1Mb, and before the buffered write
> and fiemap are performed, it has a single extent state in its io tree
> representing the range from 0 to 1Mb, with the EXTENT_DELALLOC bit set.
> 
> The following sequence diagram shows how the memory leak happens if a
> fiemap a buffered write, starting at offset 1Mb and with a length of
> 4Kb, are performed concurrently.
> 
>           CPU 1                                                  CPU 2
> 
>   extent_fiemap()
>     --> it's a full ranged fiemap
>         range from 0 to LLONG_MAX - 1
>         (9223372036854775807)
> 
>     --> locks range in the inode's
>         io tree
>       --> after this we have 2 extent
>           states in the io tree:
>           --> 1 for range [0, 1Mb[ with
>               the bits EXTENT_LOCKED and
>               EXTENT_DELALLOC_BITS set
>           --> 1 for the range
>               [1Mb, LLONG_MAX[ with
>               the EXTENT_LOCKED bit set
> 
>                                                   --> start buffered write at offset
>                                                       1Mb with a length of 4Kb
> 
>                                                   btrfs_file_write_iter()
> 
>                                                     btrfs_buffered_write()
>                                                       --> cached_state is NULL
> 
>                                                       lock_and_cleanup_extent_if_need()
>                                                         --> returns 0 and does not lock
>                                                             range because it starts
>                                                             at current i_size / eof
> 
>                                                       --> cached_state remains NULL
> 
>                                                       btrfs_dirty_pages()
>                                                         btrfs_set_extent_delalloc()
>                                                           (...)
>                                                           __set_extent_bit()
> 
>                                                             --> splits extent state for range
>                                                                 [1Mb, LLONG_MAX[ and now we
>                                                                 have 2 extent states:
> 
>                                                                 --> one for the range
>                                                                     [1Mb, 1Mb + 4Kb[ with
>                                                                     EXTENT_LOCKED set
>                                                                 --> another one for the range
>                                                                     [1Mb + 4Kb, LLONG_MAX[ with
>                                                                     EXTENT_LOCKED set as well
> 
>                                                             --> sets EXTENT_DELALLOC on the
>                                                                 extent state for the range
>                                                                 [1Mb, 1Mb + 4Kb[
>                                                             --> caches extent state
>                                                                 [1Mb, 1Mb + 4Kb[ into
>                                                                 @cached_state because it has
>                                                                 the bit EXTENT_LOCKED set
> 
>                                                     --> btrfs_buffered_write() ends up
>                                                         with a non-NULL cached_state and
>                                                         never calls anything to release its
>                                                         reference on it, resulting in a
>                                                         memory leak
> 
> Fix this by calling free_extent_state() on cached_state if the range was
> not locked by lock_and_cleanup_extent_if_need().
> 
> The same issue can happen if anything else other than fiemap locks a range
> that covers eof and beyond.
> 
> This could be triggered, sporadically, by test case generic/561 from the
> fstests suite, which makes duperemove run concurrently with fsstress, and
> duperemove does plenty of calls to fiemap. When CONFIG_BTRFS_DEBUG is set
> the leak is reported in dmesg/syslog when removing the btrfs module with
> a message like the following:
> 
>   [77100.039461] BTRFS: state leak: start 6574080 end 6582271 state 16402 in tree 0 refs 1
> 
> Otherwise (CONFIG_BTRFS_DEBUG not set) detectable with kmemleak.
> 
> CC: stable@vger.kernel.org # 4.16+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
