Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC5439B2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJYQIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhJYQIb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 12:08:31 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8DC061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:06:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bl14so12286744qkb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0kDjCc6ZFaUFkqbBKjwSSo6YIxcNwlxYaX9qxLjUls=;
        b=3oalY9iNlWNPZ1OESbAbPXkszjNhB33V5mceuI/TK5XnYdVWHcQ6mKlTw13T992epp
         g0l7EZJBf8HTfy/tbcrGz8XDeDZya88wBRrIA/yS5oM6jhEnaX88oohuGSsi8Hcjdax8
         yK2J8AY/UYQa3kUHCtyNmQgrITbiJDNQV2rddXqyxLYuIOjJmqPAWzd0NKUB5RjO7rex
         L+6czavS0Ja8+m4cyIXx7iwxjExLgtqFcpftZzZkf2DCt6XnyQEhlKck/WxVsWMuuHPp
         zOIVuDr6TrbbQe3XMNpCGU8RFMoWbm9S3Vz6bc7y6JA87q6TCN6jmbeMLjtgrFVBOWMY
         rxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0kDjCc6ZFaUFkqbBKjwSSo6YIxcNwlxYaX9qxLjUls=;
        b=WUJBemvsNc1tDYAF7vjpSD0jtgXJSpRCw+poOUn8j4unqKjTFOUzcfkNMkTWwTQj0e
         KK2xP/bjUML8tR+PAvYWo6nOp4tD3pHhhw3kCIctukv1tNEIgMFGkFUAo9YxqMFbCKQD
         86KX8uEKdBhXiaNJX/LUaLhMQnfPT115EuqjxhRQcbiLKm/ncQqQxlEr1tQdiw0KUkm4
         Nqh+zS1ZQ8DDXENBLKv30wchhiu4yv6k4tAiShdNTemiJbsOnInrrcdu4SON0dsI4dZ+
         FzJuhwqCPjFG8zl5bwffutIcj8SPyOpnCzbxUN5JvaayfEDf/L2RppX8uR7BrkQ8870s
         GIkA==
X-Gm-Message-State: AOAM530JcMfyGpu1b5wF/4bq7Dh7GZJoaZ6U4XNq/K9W6ZesNSsQ+wNz
        wI3YlF+Y4l+csnZYR6Nji59mpn+aqqwRQA==
X-Google-Smtp-Source: ABdhPJzJhbHFkuQt4csDpufc3/PlTeznR2GIFVhB+B93D3rQQusZj56q9TzaX024TYdUy+FyBODL0w==
X-Received: by 2002:a05:620a:2587:: with SMTP id x7mr13975742qko.181.1635177967849;
        Mon, 25 Oct 2021 09:06:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v7sm8645248qkd.41.2021.10.25.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:06:07 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:06:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/6] btrfs: only copy dir index keys when logging a
 directory
Message-ID: <YXbV7r3Il5TseHcR@localhost.localdomain>
References: <cover.1635155473.git.fdmanana@suse.com>
 <9c22f976b9bc0a5725d80f2a365316c1ea3706ed.1635155473.git.fdmanana@suse.com>
 <YXbO/lfI2RvMNz+W@localhost.localdomain>
 <CAL3q7H43awVpO8_xXo_g9U+P2dJo_5Baj4MHq6JaKps7NceEAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H43awVpO8_xXo_g9U+P2dJo_5Baj4MHq6JaKps7NceEAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 05:01:12PM +0100, Filipe Manana wrote:
> On Mon, Oct 25, 2021 at 4:36 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 10:56:25AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Currently, when logging a directory, we copy both dir items and dir index
> > > items from the fs/subvolume tree to the log tree. Both items have exactly
> > > the same data (same struct btrfs_dir_item), the difference lies in the key
> > > values, where a dir index key contains the index number of a directory
> > > entry while the dir item key does not, as it's used for doing fast lookups
> > > of an entry by name, while the former is used for sorting entries when
> > > listing a directory.
> > >
> > > We can exploit that and log only the dir index items, since they contain
> > > all the information needed to correctly add, replace and delete directory
> > > entries when replaying a log tree. Logging only the dir index items is
> > > also backward and forward compatible: an unpatched kernel (without this
> > > change) can correctly replay a log tree generated by a patched kernel
> > > (with this patch), and a patched kernel can correctly replay a log tree
> > > generated by an unpatched kernel.
> > >
> >
> > This took me a very long time to grok, so it deserves more explanation.
> >
> > The problem I had was how this worked in general, and I was missing the fact
> > that we're only calling drop_dir_item() if we find the name in the root,
> > otherwise we either goto insert if we're DIR_INDEX or bail if we're DIR_ITEM.
> >
> > So whichever we find first in the log, we call drop_dir_item() only if there's a
> > conflict.  Then the heavy work is done once we find the DIR_INDEX item.
> >
> > Which means that the only work we do if we find DIR_ITEM is drop_dir_item(),
> > which we do in the case if we find DIR_INDEX and the item is there.
> >
> > This is why we don't actually need the DIR_ITEM to properly replay the log for
> > older kernels, because DIR_INDEX does the same work, and actually does the heavy
> > lifting of adding the BACKREF's and such.
> >
> > This took probably 30-45 minutes for me to work out, and I'm only 90% sure I
> > have it right, so an explanation as to why it's ok for older kernels would be
> > very helpful.  Thanks,
> 
> Is the following fine for you?
> 
> The backward compatibility is ensured because:
> 
> 1) For inserting a new dentry: a dentry is only inserted when we find a
>    new dir index key - we can only insert if we know the dir index offset,
>    which is encoded in the dir index key's offset;
> 
> 2) For deleting dentries: during log replay, before adding or replacing
>    dentries, we first replay dentry deletions. Whenever we find a dir item
>    key or a dir index key in the subvolume/fs tree that is not logged in
>    a range for which the log tree is authoritative, we do the unlink of
>    the dentry, which removes both the existing dir item key and the dir
>    index key. Therefore logging just dir index keys is enough to ensure
>    dentry deletions are correctly replayed;
> 
> 3) For dentry replacements: they work when we log only dir index keys
>    and this is due to a combination of 1) and 2). If we replace a
>    dentry with name "foobar" to point from inode A to inode B, then we
>    know the dir index key for the new dentry is different from the old
>    one, as it has an index number (key offset) larger than the old one.
>    This results in replaying a deletion, through replay_dir_deletes(),
>    that causes the old dentry to be removed, both the dir item key and
>    the dir index key, as mentioned at 2). Then when processing the new
>    dir index key, we add the new dentry, adding both a new dir item key
>    and a new index key pointing to inode B, as stated in 1).
> 

Yup this works for me, thanks,

Josef
