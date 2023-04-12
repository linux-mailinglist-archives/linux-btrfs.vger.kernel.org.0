Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494416DF7A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjDLNta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjDLNt2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 09:49:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F887ABF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:49:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54c12009c30so327222977b3.9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1681307366; x=1683899366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FffUcDNzBTXx+AQOiyZaNLmJxQHYNmK44m9CytV1nBM=;
        b=ICqGTTWgPICzQrW0ZWMJEr/m0tLMnJeiAgrRwQoJFdYKPjaYHEJ3F+/Hz5rZAwWcfG
         GlSpEXnlSOpxpEfyFYB/WAksinMNORRjUs62ThnaUMSXn+4GVzN+uKi12BYiHqi7ZgYJ
         HQWaMDQhK+AfxIQ+cjSHfEBCRZN/7acS52xHpBNL1F4bTKbJiYvs7OWl6ePLhtGI2IvK
         1hbrakCYzXZhLpmxr/0SRhxW9ZjZ3ubf/J4UxOEYCvdcyrdTN0jqqM0fY6+sl7bhtUQi
         KBB0xG2FkmAQ9PnWvs1xFRrAABoCY9evKn2eRI15fk5llZHf/nDBJqzeHFvatrkLRbql
         r5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307366; x=1683899366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FffUcDNzBTXx+AQOiyZaNLmJxQHYNmK44m9CytV1nBM=;
        b=u3ORSzC6lQioZNVpRdOlPz1VcHCvkb2BFTtpL/6LeE60Y27UiuCiOxthZ2xl3reL43
         PEI9Va3VvF97Lm/LIUEx5lYxJgEs8yFthR3HpqcK1JfWtM5POPvZf+H2PKnP6jK/om5G
         0i1R6AJEO7Zzc8QderpPTkpbWpXyx+DOgopqyeVYkwIFYFrrhaDgpXcX85yiquSUILOz
         jk9u4UdVRmDyPK+6n1Hy6IgppiuqgCHPBn6Uj+BrCLDjPQTfrLm1eKJtDZdSY1wojYNX
         MPHOr/hnkRW9y1hJnb9jc2cdy2tJ8CUdKyL+1CpO+b9xgDc8BD0VaCv8YlKOlpLBak0f
         4+LQ==
X-Gm-Message-State: AAQBX9cEYUkju9EsM9iChRsQgDCoLPw8KoKpY05JpjqI/FIt1kXvW699
        mHDKbST9XgOdR7451JoDwc7/bVZG92uF8XbpxCS5YQ==
X-Google-Smtp-Source: AKy350b+M7QqYdgCYapViDiBYi5U6s77PsCN6yZ4hLhm7OrFw7C27ZQbie4g8tE49Q9JxaTbq1KBjg==
X-Received: by 2002:a81:7207:0:b0:541:4561:544d with SMTP id n7-20020a817207000000b005414561544dmr2171358ywc.43.1681307366585;
        Wed, 12 Apr 2023 06:49:26 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i133-20020a81918b000000b0054f666625afsm1316770ywg.7.2023.04.12.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:49:26 -0700 (PDT)
Date:   Wed, 12 Apr 2023 09:49:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Neal Gompa <neal@gompa.dev>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Message-ID: <20230412134925.GB3162142@perftesting>
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
 <CAEg-Je_BJpdr+K8rA_NHzykBRT6qmGjzfei3NCzjWBW2kVObmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_BJpdr+K8rA_NHzykBRT6qmGjzfei3NCzjWBW2kVObmg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 11, 2023 at 09:45:34PM -0400, Neal Gompa wrote:
> On Tue, Apr 11, 2023 at 3:22 PM Sweet Tea Dorminy
> <sweettea-kernel@dorminy.me> wrote:
> >
> > Recently a Meta-internal workload encountered subvolume creation taking
> > up to 2s each, significantly slower than directory creation. As they
> > were hoping to be able to use subvolumes instead of directories, and
> > were looking to create hundreds, this was a significant issue. After
> > Josef investigated, it turned out to be due to the transaction commit
> > currently performed at the end of subvolume creation.
> >
> > This change improves the workload by not doing transaction commit for every
> > subvolume creation, and merely requiring a transaction commit on fsync.
> > In the worst case, of doing a subvolume create and fsync in a loop, this
> > should require an equal amount of time to the current scheme; and in the
> > best case, the internal workload creating hundreds of subvols before
> > fsyncing is greatly improved.
> >
> > While it would be nice to be able to use the log tree and use the normal
> > fsync path, logtree replay can't deal with new subvolume inodes
> > presently.
> >
> > It's possible that there's some reason that the transaction commit is
> > necessary for correctness during subvolume creation; however,
> > git logs indicate that the commit dates back to the beginning of
> > subvolume creation, and there are no notes on why it would be necessary.
> >
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > ---
> >  fs/btrfs/ioctl.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 25833b4eeaf5..a6f1ee2dc1b9 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -647,6 +647,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
> >         }
> >         trans->block_rsv = &block_rsv;
> >         trans->bytes_reserved = block_rsv.size;
> > +       /* tree log can't currently deal with an inode which is a new root */
> > +       btrfs_set_log_full_commit(trans);
> >
> >         ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
> >         if (ret)
> > @@ -755,10 +757,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
> >         trans->bytes_reserved = 0;
> >         btrfs_subvolume_release_metadata(root, &block_rsv);
> >
> > -       if (ret)
> > -               btrfs_end_transaction(trans);
> > -       else
> > -               ret = btrfs_commit_transaction(trans);
> > +       btrfs_end_transaction(trans);
> >  out_new_inode_args:
> >         btrfs_new_inode_args_destroy(&new_inode_args);
> >  out_inode:
> > --
> > 2.40.0
> >
> 
> Wouldn't the consequence of this mean that we lose some guarantees
> around subvolume creation? That is, without it being committed, we
> would have a window in which the subvolume and data can be written
> without being written to disk? If so, how large is that window?

It's the same as a normal directory, we create a subvol and then create a file
in that subvol and start writing to that file, then lose power before the
transaction commits, we lose everything.  The same would happen for a new
directory.

The only concern here that's different is with the directory case you could
fsync() the new file and it would all go into the tree log.  As pointed out
above the tree log stuff can't handle a subvolume that doesn't exist yet, so in
the above case if the user fsync()'s that new file it'll commit the whole
transaction and everything will be fine.  Thanks,

Josef
