Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7298D1027B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 16:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfKSPKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 10:10:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44597 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSPKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 10:10:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so18066347qki.11
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2019 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BpBhEouCGQ7AMO0bH6neGzBc4KXjbuRUF3TdPb5FwS0=;
        b=uJ8aMf97Y6chDpFg4AE72xaAj1C587CBuEIyJmAZvc2M0N1i6GxR5YwvJ//sFvT9MC
         ItMrxalxAsQ5wE3t1gUAwZ1ofmQUMfuVs+h05g0p2qFG7PzRMdtv0H9DFH2JcK908vr+
         H7sHYjC+tvvuj6M4Ozog3bRiqNFC/8EOfD56zyYmqCZSfSFWo4VoSKGIWuMter7cEf9n
         9/k4X+ooiGSCIjlt5Y8dh4yC1nfib6n5LqMtZlOfLXnSqoOOBmY7i5Y6tTagNBbi0+9Y
         I7RBiHP2vKdY5tGXYiLR9EQEO4awZkxsQp6ur45HgXBqVEe/iyB76uqLrPNu+MgeIAzg
         ZQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BpBhEouCGQ7AMO0bH6neGzBc4KXjbuRUF3TdPb5FwS0=;
        b=KRqw4shuZrHeMXcdFcRk0wowNl5L76fdZAkRI0sPqvz/3xl72m3EIVTVrif3t4E8oc
         qNRDNC4tUK5u50PCrn9ugMZ40z+V+aQSCxWRsxfIb5vqUIazj2H8oSSNNFPHhzGw7FN6
         VRCsmUoqMSG3P7hFMIzvXiub/1KwM7q0TmggJ/mwuy6UdZpHadX8eNEb/VJYa7gUShyz
         ImXqb10J/NczjiaeAX19qoAzBnfG3oQVAoXFnqAUuzoQY2s2/f3zqnRsOXS3qzJZHDvn
         1U6x/pLOsvDJNlTfXal+3kd4f47Ezt8w3eKVksqA1apeFYiqePwSGiBTEcdjeuEvd1iv
         Xutg==
X-Gm-Message-State: APjAAAUfEZGjxJOLVD96JyezkCrPbIuaFsNZ9/FiHpxjxduJRK/gvat8
        6qRTDmIls6iKEsCWnjjSVYsR2BGaEhSZBg==
X-Google-Smtp-Source: APXvYqwdR7Xg5tUYktz3RA/Rn3ExzDOn0QW8rGEtgfEdmxjFt/zAnlLeKtEVhihL7eUZBCajsCrMkg==
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr23761944qkg.71.1574176241827;
        Tue, 19 Nov 2019 07:10:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::61cf])
        by smtp.gmail.com with ESMTPSA id l93sm12306412qtd.86.2019.11.19.07.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:10:41 -0800 (PST)
Date:   Tue, 19 Nov 2019 10:10:39 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v2] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
Message-ID: <20191119151039.2ncacrzi4grjttrt@macbook-pro-91.dhcp.thefacebook.com>
References: <20191112151331.3641-1-fdmanana@kernel.org>
 <20191119120733.25827-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119120733.25827-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 12:07:33PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the NO_HOLES feature, if we punch a hole into a file and then
> fsync it, there are cases where a subsequent fsync will miss the fact that
> a hole was punched, resulting in the holes not existing after replaying
> the log tree.
> 
> Essentially these cases all imply that, tree-log.c:copy_items(), is not
> invoked for the leafs that delimit holes, because nothing changed those
> leafs in the current transaction. And it's precisely copy_items() where
> we currenly detect and log holes, which works as long as the holes are
> between file extent items in the input leaf or between the beginning of
> input leaf and the previous leaf or between the last item in the leaf
> and the next leaf.
> 
> First example where we miss a hole:
> 
>   *) The extent items of the inode span multiple leafs;
> 
>   *) The punched hole covers a range that affects only the extent items of
>      the first leaf;
> 
>   *) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
>      is set in the inode's runtime flags).
> 
>   That results in the hole not existing after replaying the log tree.
> 
>   For example, if the fs/subvolume tree has the following layout for a
>   particular inode:
> 
>       Leaf N, generation 10:
> 
>       [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]
> 
>       Leaf N + 1, generation 10:
> 
>       [ EXTENT_ITEM (128K 64K) ... ]
> 
>   If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
>   up dropping the two extent items from leaf N, but we don't touch the other
>   leaf, so we end up in the following state:
> 
>       Leaf N, generation 11:
> 
>       [ ... INODE_ITEM INODE_REF ]
> 
>       Leaf N + 1, generation 10:
> 
>       [ EXTENT_ITEM (128K 64K) ... ]
> 
>   A full fsync after punching the hole will only process leaf N because it
>   was modified in the current transaction, but not leaf N + 1, since it
>   was not modified in the current transaction (generation 10 and not 11).
>   As a result the fsync will not log any holes, because it didn't process
>   any leaf with extent items.
> 
> Second example where we will miss a hole:
> 
>   *) An inode as its items spanning 5 (or more) leafs;
> 
>   *) A hole is punched and it covers only the extents items of the 3rd
>      leaf. This resulsts in deleting the entire leaf and not touching any
>      of the other leafs.
> 
>   So the only leaf that is modified in the current transaction, when
>   punching the hole, is the first leaf, which contains the inode item.
>   During the full fsync, the only leaf that is passed to copy_items()
>   is that first leaf, and that's not enough for the hole detection
>   code in copy_items() to determine there's a hole between the last
>   file extent item in the 2nd leaf and the first file extent item in
>   the 3rd leaf (which was the 4th leaf before punching the hole).
> 
> Fix this by scanning all leafs and punch holes as necessary when doing a
> full fsync (less common than a non-full fsync) when the NO_HOLES feature
> is enabled. The lack of explicit file extent items to mark holes makes it
> necessary to scan existing extents to determine if holes exist.
> 
> A test case for fstests follows soon.
> 
> Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
