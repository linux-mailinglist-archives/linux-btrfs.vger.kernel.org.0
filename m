Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DCBF9734
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKLRfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 12:35:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46103 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKLRfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 12:35:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so9664063plt.13
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 09:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJidACwwJfQPuKrp5xBQT8SHhnmaVaIM/Nqu+TMmy6A=;
        b=EB5EekGoDWiQAAGN4jfzoVlc6R4R3EY18y7cCOS7kWK9gsMlaXV66KUvgULQcVnyTB
         jcOe+ZSnt32fniP5zFRfUCBjZ5a5t5xWWSM5L/b7E9KAC3OoRiYkQVIt+Mlwl4KS1GWE
         QmNHfs+YsNDZofc0vuiWO+eRluuB2zuKXeSWG3QiTlZ9B7nXwwkDXDPXW5nK8wDRWlid
         gtL4chFGSsKIAziWfEf9J03UX/dCtJep449znphvDt31daOssvW7+Edq3x9GIvuTfqiu
         Gcg3GqiSDoFDS2cy9+fD3I0Q9Kff+8UK+DzbL+2EADGz5AkQEZPxhykudbsNrT2DzYiX
         nbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJidACwwJfQPuKrp5xBQT8SHhnmaVaIM/Nqu+TMmy6A=;
        b=Qt5/0VqAUrIh7O9A/CVV21S3V0ead65ZXtlnX4lvMfBJlZjBi6GrOi5HB/jbBcS0jy
         2IH56InL06pjh2iq6EuR1ocyruV6GI/CNYaKOEKy9M+FoDcZAFUkh5pF57I4ooQ+fZgi
         J+aXYdomKVykhA7KqmqN2c1wei2srx3JLoaVUvB1lmX5ryY/syyDHEk8qCRXTiSX4ejd
         q6jJ131aWiQog96qidokjvUZJ8r5xineCXxsP3ARKn3/TOSdry0Pn2O6FJI3XmyQ/gAZ
         x6fXPj9KbtgbxH2RpGsgZUalFBcqOXcBm0rUzMTcTSRuf+hlezspSWa08T7bg98rEPOz
         51ig==
X-Gm-Message-State: APjAAAUvYxW61QD9Xunjnvz9cvEL55VcUr3mh/CinpUkaK1zdYCzmp++
        ukapaHW0VecJBStsi6OF6HgQ7MmuKB0R5g==
X-Google-Smtp-Source: APXvYqyqASFwJyF8sWx3Kxy9NaFjt9zjEoJKbE0l4HAbPg2Rpd6WosG2g2bqdW+MGvMlEE6Jz0tCHA==
X-Received: by 2002:a17:902:76c8:: with SMTP id j8mr7669108plt.122.1573580101651;
        Tue, 12 Nov 2019 09:35:01 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::1:1c21])
        by smtp.gmail.com with ESMTPSA id f7sm22603700pfa.150.2019.11.12.09.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:35:00 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:34:59 -0800
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
Message-ID: <20191112173459.7c6piekqjfjidjon@macbook-pro-91.dhcp.thefacebook.com>
References: <20191112151331.3641-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112151331.3641-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 03:13:31PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the NO_HOLES feature, if we punch a hole into a file and then
> fsync it, there is a case where a subsequent fsync will miss the fact that
> a hole was punched:
> 
> 1) The extent items of the inode span multiple leafs;
> 
> 2) The hole covers a range that affects only the extent items of the first
>    leaf;
> 
> 3) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
>    is set in the inode's runtime flags).
> 
> That results in the hole not existing after replaying the log tree.
> 
> For example, if the fs/subvolume tree has the following layout for a
> particular inode:
> 
>   Leaf N, generation 10:
> 
>   [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]
> 
>   Leaf N + 1, generation 10:
> 
>   [ EXTENT_ITEM (128K 64K) ... ]
> 
> If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
> up dropping the two extent items from leaf N, but we don't touch the other
> leaf, so we end up in the following state:
> 
>   Leaf N, generation 11:
> 
>   [ ... INODE_ITEM INODE_REF ]
> 
>   Leaf N + 1, generation 10:
> 
>   [ EXTENT_ITEM (128K 64K) ... ]
> 
> A full fsync after punching the hole will only process leaf N because it
> was modified in the current transaction, but not leaf N + 1, since it was
> not modified in the current transaction (generation 10 and not 11). As
> a result the fsync will not log any holes, because it didn't process any
> leaf with extent items.
> 
> So fix this by detecting any leading hole in the file for a full fsync
> when using the NO_HOLES feature if we didn't process any extent items for
> the file.
> 
> A test case for fstests follows soon.
> 
> Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This adds an extra search for every FULL_SYNC, can we just catch this case in
the main loop, say we keep track of the last extent we found, and then when we
end up with ret > 1 || a min_key that's past the end of the last extent we saw
we know we had a hole punch?  Thanks,

Josef
