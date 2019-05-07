Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7316983
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfEGRod (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:44:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40426 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfEGRoc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:44:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id 18so9100196ywe.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9aNdbSAxXhNWutUyQkbLS4DIOgcjK8w4r4/EtpAV08=;
        b=Mt4wTer80As9s0cpFUkhh/yGWNnSBWkCa1p2LULSuZH3y5550y/bHkMqLoRZtOBUyV
         5BNcawFvbKdCRcMoqyPSxxbVWOZJpp9gSqrpOxRRqLhWbbpvXv4T4xcEXcDCBVtR0RNF
         N99TwIsq+LRVNbTSI1NhpMBHaUwBp4tuBhp0JQeTZ+HxrrXy3HNZl1n9NgOPLc5DcU/n
         DhisKIenjfqpD5A20I3KmC/swUMlJuX2bc9arAr+NSL/0Uij3W3a41MUE0pzrt5+/Kui
         Njm/tvyMfBTCEy83dE5VE80uq1CF59nAdxfW73G6UlH8YWwW7tGUAZ9RyYRvzR1kWz64
         bkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9aNdbSAxXhNWutUyQkbLS4DIOgcjK8w4r4/EtpAV08=;
        b=Eq+SCE7SgaBeKQNEisHPUpO3vXYzbJdy+8swR5ZpcWdYKj85nkjdQXZnyEjW9JrIta
         bPe3DoEFHYqdrrLemzCCXWUGPF7dbs5Kls6kDJaYZ3uS3za2cAbrKyrqHH3MKa0Turv6
         GSD+puy6AAFN5Eei1Xh127Fn8xCXLAJ9743OWTGlnqLHvz40eDMGVLhMdfk5WYz/CPzr
         AwIqF5R6JlDbjPrTnVUg7FzVCbNYDV0YPDrOtS/5t0BVAfs/MrpQGJtr5m4XDQmvSR5P
         Y3EQ0LXYcIwxE8RyqdINTX8jSV4T2W3hJj9cdHAcN9VpQIXx0PtAqlrYgxUbRVh3dT0G
         XxbQ==
X-Gm-Message-State: APjAAAUdjtyAVP+x2UZlU6bG4fygmpGHA3QLLyrpTfL0pDRs5sv4BLyC
        u/rt31rr65kY2hu1/UcV959huA==
X-Google-Smtp-Source: APXvYqyfpnwG6h+3sIMciNI22Tv++ToklCurocUqGoOSies/AFfq6oDgcUsJblpblgDVNP5lBJI+fg==
X-Received: by 2002:a25:138a:: with SMTP id 132mr3974539ybt.127.1557251072112;
        Tue, 07 May 2019 10:44:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id 132sm2102185ywu.106.2019.05.07.10.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:44:31 -0700 (PDT)
Date:   Tue, 7 May 2019 13:44:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: fix race between ranged fsync and writeback
 of adjacent ranges
Message-ID: <20190507174429.vhyk4lqqvnja4zlx@macbook-pro-91.dhcp.thefacebook.com>
References: <20190506154402.20097-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506154402.20097-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 06, 2019 at 04:44:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we do a full fsync (the bit BTRFS_INODE_NEEDS_FULL_SYNC is set in the
> inode) that happens to be ranged, which happens during a msync() or writes
> for files opened with O_SYNC for example, we can end up with a corrupt log,
> due to different file extent items representing ranges that overlap with
> each other, or hit some assertion failures.
> 
> When doing a ranged fsync we only flush delalloc and wait for ordered
> exents within that range. If while we are logging items from our inode
> ordered extents for adjacent ranges complete, we end up in a race that can
> make us insert the file extent items that overlap with others we logged
> previously and the assertion failures.
> 
> For example, if tree-log.c:copy_items() receives a leaf that has the
> following file extents items, all with a length of 4K and therefore there
> is an implicit hole in the range 68K to 72K - 1:
> 
>   (257 EXTENT_ITEM 64K), (257 EXTENT_ITEM 72K), (257 EXTENT_ITEM 76K), ...
> 
> It copies them to the log tree. However due to the need to detect implicit
> holes, it may release the path, in order to look at the previous leaf to
> detect an implicit hole, and then later it will search again in the tree
> for the first file extent item key, with the goal of locking again the
> leaf (which might have changed due to concurrent changes to other inodes).
> 
> However when it locks again the leaf containing the first key, the key
> corresponding to the extent at offset 72K may not be there anymore since
> there is an ordered extent for that range that is finishing (that is,
> somewhere in the middle of btrfs_finish_ordered_io()), and it just
> removed the file extent item but has not yet replaced it with a new file
> extent item, so the part of copy_items() that does hole detection will
> decide that there is a hole in the range starting from 68K to 76K - 1,
> and therefore insert a file extent item to represent that hole, having
> a key offset of 68K. After that we now have a log tree with 2 different
> extent items that have overlapping ranges:
> 

Well this kind of sucks.  I wonder if we should be locking the extent range
while we're doing this in order to keep this problem from happening.  A fix for
another day though

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
