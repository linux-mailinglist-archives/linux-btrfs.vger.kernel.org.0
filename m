Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F69214EEB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 15:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgAaOqh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 09:46:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39228 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgAaOqg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 09:46:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id w15so6751340qkf.6
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ehNzPRHAaCEu1TFL16kplpY/B6W2qSGPcTAQ+xBxmzI=;
        b=s10BDD0gelNU5SVA8nbBIioWYAVVzKJfDm2rVN2co2cx5fqyeS9AATxVT2UE0p7xEa
         KO9qxj2eduotPoEUjuUaVgra7lrCJI9wavPAFXYLSsOMlZskVapDxwNJxWJEDLN4RxnL
         ASwTwLe8IW5auMrm6CmfT8fHfLy7zELuymyeYnZMeAR8g779VCLnjEry/uPBKrj23bQ6
         yhMBKrQwpmHUU3Li5DoRkSvyTqkz/HZAww3hyyqt1k0lB3hLOdwLUpIUDhi23EXQLYUw
         Z0S0OnrNkYh8dz8mZF9KXXlNyN5N0j+deZxyBhrJ3KA4PJKFjUkGBiO0j4S2+M5ey9zs
         7kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehNzPRHAaCEu1TFL16kplpY/B6W2qSGPcTAQ+xBxmzI=;
        b=bNywk5VKHwUa5rq5E3RvWI4bAX6tynZJIMgthEjwjAdO4Lae9FO6zY9emY7Fw7Ym72
         Fe3MzRWsL21E1TMxV5zy5sfcO4ivB5AjZCvA03E3RjgBWbCWfdsvfN7hKdnyvWO6NX3A
         73/Wja0dYVB7eW/c4rg3ojrhc30NyVwTFfsJMVQc8EAFGqzEM4hIfQPK0LK2C+xV8aPI
         UMnJumR5J79KmmnB9KAtWiTw7QPKTIWZ8bKojaS+BEUtnAD/c3Yz06k+sMK6o8wBH+hn
         13Hg0IInLsqgNHUh850IPAj3c9D2witAMNAsUCoN/zQXxjYeSyxeuRK2529mAY1opof5
         2qWw==
X-Gm-Message-State: APjAAAWxWQgQfe2j9BbG50UxOsxxUrkdCQefXBu6jVBhWyRveX9cQuUu
        U02gj+ESsvz+WHRtWCl6OKLLmnr/E+Or7A==
X-Google-Smtp-Source: APXvYqyxFmjQJdV41SdBi01xGEDQSugEFvKlbuYvRu2dCnu5f/f4b+eTuKAbr1Vusj6UvFY11yYX3g==
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr10080913qkl.13.1580481995220;
        Fri, 31 Jan 2020 06:46:35 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::981a])
        by smtp.gmail.com with ESMTPSA id t38sm5244540qta.78.2020.01.31.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:46:34 -0800 (PST)
Subject: Re: [PATCH] Btrfs: fix race between using extent maps and merging
 them
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200131140607.26923-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0c3ec3a8-632c-6a01-86e0-a60ce072e8ad@toxicpanda.com>
Date:   Fri, 31 Jan 2020 09:46:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131140607.26923-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/31/20 9:06 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a few cases where we allow an extent map that is in an extent map
> tree to be merged with other extents in the tree. Such cases include the
> unpinning of an extent after the respective ordered extent completed or
> after logging an extent during a fast fsync. This can lead to subtle and
> dangerous problems because when doing the merge some other task might be
> using the same extent map and as consequence see an inconsistent state of
> the extent map - for example sees the new length but has seen the old start
> offset.
> 
> With luck this triggers a BUG_ON(), and not some silent bug, such as the
> following one in __do_readpage():
> 
>    $ cat -n fs/btrfs/extent_io.c
>    3061  static int __do_readpage(struct extent_io_tree *tree,
>    3062                           struct page *page,
>    (...)
>    3127                  em = __get_extent_map(inode, page, pg_offset, cur,
>    3128                                        end - cur + 1, get_extent, em_cached);
>    3129                  if (IS_ERR_OR_NULL(em)) {
>    3130                          SetPageError(page);
>    3131                          unlock_extent(tree, cur, end);
>    3132                          break;
>    3133                  }
>    3134                  extent_offset = cur - em->start;
>    3135                  BUG_ON(extent_map_end(em) <= cur);
>    (...)
> 
> Consider the following example scenario, where we end up hitting the
> BUG_ON() in __do_readpage().
> 
> We have an inode with a size of 8Kb and 2 extent maps:
> 
>    extent A: file offset 0, length 4Kb, disk_bytenr = X, persisted on disk by
>              a previous transaction
> 
>    extent B: file offset 4Kb, length 4Kb, disk_bytenr = X + 4Kb, not yet
>              persisted but writeback started for it already. The extent map
> 	    is pinned since there's writeback and an ordered extent in
> 	    progress, so it can not be merged with extent map A yet
> 
> The following sequence of steps leads to the BUG_ON():
> 
> 1) The ordered extent for extent B completes, the respective page gets its
>     writeback bit cleared and the extent map is unpinned, at that point it
>     is not yet merged with extent map A because it's in the list of modified
>     extents;
> 
> 2) Due to memory pressure, or some other reason, the mm subsystem releases
>     the page corresponding to extent B - btrfs_releasepage() is called and
>     returns 1, meaning the page can be released as it's not dirty, not under
>     writeback anymore and the extent range is not locked in the inode's
>     iotree. However the extent map is not released, either because we are
>     not in a context that allows memory allocations to block or because the
>     inode's size is smaller than 16Mb - in this case our inode has a size
>     of 8Kb;
> 
> 3) Task B needs to read extent B and ends up __do_readpage() through the
>     btrfs_readpage() callback. At __do_readpage() it gets a reference to
>     extent map B;
> 
> 4) Task A, doing a fast fsync, calls clear_em_loggin() against extent map B
>     while holding the write lock on the inode's extent map tree - this
>     results in try_merge_map() being called and since it's possible to merge
>     extent map B with extent map A now (the extent map B was removed from
>     the list of modified extents), the merging begins - it sets extent map
>     B's start offset to 0 (was 4Kb), but before it increments the map's
>     length to 8Kb (4kb + 4Kb), task A is at:
> 
>     BUG_ON(extent_map_end(em) <= cur);
> 
>     The call to extent_map_end() sees the extent map has a start of 0
>     and a length still at 4Kb, so it returns 4Kb and 'cur' is 4Kb, so
>     the BUG_ON() is triggered.
> 
> So it's dangerous to modify an extent map that is in the tree, because some
> other task might have got a reference to it before and still using it, and
> needs to see a consistent map while using it. Generally this is very rare
> since most paths that lookup and use extent maps also have the file range
> locked in the inode's iotree. The fsync path is pretty much the only
> exception where we don't do it to avoid serialization with concurrent
> reads.
> 
> Fix this by not allowing an extent map do be merged if if it's being used
> by tasks other then the one attempting to merge the extent map (when the
> reference count of the extent map is greater than 2).
> 
> Reported-by: ryusuke1925 <st13s20@gm.ibaraki-ct.ac.jp>
> Reported-by: Koki Mitani <koki.mitani.xg@hco.ntt.co.jp>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206211
> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Eesh that's bad, and I went to look at our statistics and we're hitting this 
like ~20ish times a day.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
