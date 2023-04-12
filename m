Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B76DE9D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 05:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLDSd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 23:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDLDSb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 23:18:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E50119
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 20:18:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g3so11357853pja.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1681269510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTzf86zAv2fU3C/eN/0tX6Qjb72nN2ZOHZq+wIvYYEk=;
        b=RIm6qfQDAE0Gvz8EmVP4usexgRsGP9V/jIqls91dsJNT85XwtaGY8OPFulpCxkIEk4
         vd1CrUN1XT/s9k9NS9Z+V99y7RX29V7R9a9VZzITy3cVmE9hTRU9XNV6+yDeQf7n5qyf
         dtXOF3uA5knLC4fM3FOa6eJk7WllE1rz75WFFSthumGqgwhenqTIWQU5MyJZ+hPDyGBX
         tpVfTf5Z1vv4udhay0UI5TDrPQWqmcRsjacWZEYmoM2I+oaHVz2L2aKEktSnw0dEGkGx
         Vq2BZOUc2q6kExZKSQAUI3o0C9emWKB2Vh6KZqJnPdWxcyqxEdK80KlWeVm6DNwN7OYe
         dvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681269510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTzf86zAv2fU3C/eN/0tX6Qjb72nN2ZOHZq+wIvYYEk=;
        b=WKq3Zc4qCuIsIiJ0Z18HTUQuj5c8gAsu0h7AoT5n+LeQffkSaOP39cWT8SsW4vstSz
         xE/cwmdPRoDal1rtXaCHWrwuhuyaQzF2pca70Z4qUC0XzGIG+IbbQ+mcAZxsd7xAHH7Q
         EFoRsN4KEUETmrdISXaxm/Or1Q7+iNLc4iLKg5idZ+g3zFokgAEC0BbIxl4U2q/AUlA1
         ZlZfpR24OsjEIjO1ed41K8V8WQiBSgFUSEybtk0b1FQr7TFnr8j+SwHVAz9PQm/SUOZP
         351ous8Ws7dM9a3CZFtumHw9VjrWfgAcsKYSJ6er1R8QdLpRwahe4Tze2jVFgGtSarqa
         4agA==
X-Gm-Message-State: AAQBX9c8TWvuGtJ20FXsyor875IZk2A1FfkYuqyGmzJPiUFlyp8Hoaqb
        Rkt4v20futLOZBiW73zi1FV8Kolwy7EiEMfWQHREzA==
X-Google-Smtp-Source: AKy350bEvRaL0tcbYZNXJN9S8MKTlfNUtm72wryf0f0tx94/6m3Gotj2MFJG8+gujGf5Bd9bxftN0Q==
X-Received: by 2002:a17:90a:45:b0:23f:a4da:1203 with SMTP id 5-20020a17090a004500b0023fa4da1203mr6850168pjb.19.1681269510087;
        Tue, 11 Apr 2023 20:18:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b0019f9fd5c24asm7362321plo.207.2023.04.11.20.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 20:18:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pmR06-002L8o-E9; Wed, 12 Apr 2023 13:18:26 +1000
Date:   Wed, 12 Apr 2023 13:18:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrey Albershteyn <aalbersh@redhat.com>, djwong@kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230412031826.GI3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <ZDTt8jSdG72/UnXi@infradead.org>
 <20230412023319.GA5105@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412023319.GA5105@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 11, 2023 at 07:33:19PM -0700, Eric Biggers wrote:
> On Mon, Apr 10, 2023 at 10:19:46PM -0700, Christoph Hellwig wrote:
> > Dave is going to hate me for this, but..
> > 
> > I've been looking over some of the interfaces here, and I'm starting
> > to very seriously questioning the design decisions of storing the
> > fsverity hashes in xattrs.
> > 
> > Yes, storing them beyond i_size in the file is a bit of a hack, but
> > it allows to reuse a lot of the existing infrastructure, and much
> > of fsverity is based around it.  So storing them in an xattrs causes
> > a lot of churn in the interface.  And the XFS side with special
> > casing xattr indices also seems not exactly nice.
> 
> It seems it's really just the Merkle tree caching interface that is causing
> problems, as it's currently too closely tied to the page cache?  That is just an
> implementation detail that could be reworked along the lines of what is being
> discussed.
> 
> But anyway, it is up to the XFS folks.  Keep in mind there is also the option of
> doing what btrfs is doing, where it stores the Merkle tree separately from the
> file data stream, but caches it past i_size in the page cache at runtime.

Right. It's not entirely simple to store metadata on disk beyond EOF
in XFS because of all the assumptions throughout the IO path and
allocator interfaces that it can allocate space beyond EOF at will
and something else will clean it up later if it is not needed. This
impacts on truncate, delayed allocation, writeback, IO completion,
EOF block removal on file close, background garbage collection,
ENOSPC/EDQUOT driven space freeing, etc.  Some of these things cross
over into iomap infrastructure, too.

AFAIC, it's far more intricate, complex and risky to try to store
merkle tree data beyond EOF than it is to put it in an xattr
namespace because IO path EOF handling bugs result in user data
corruption. This happens over and over again, no matter how careful
we are about these aspects of user data handling.

OTOH, putting the merkle tree data in a different namespace avoids
these issues completely. Yes, we now have to solve an API mismatch,
but we aren't risking the addition of IO path data corruption bugs
to every non-fsverity filesystem in production...

Hence I think copying the btrfs approach (i.e. only caching the
merkle tree data in the page cache beyond EOF) would be as far as I
think we'd want to go. Realistically, there would be little
practical difference between btrfs storing the merkle tree blocks in
a separate internal btree and XFS storing them in an internal
private xattr btree namespace.

I would, however, prefer not to have to do this at all if we could
simply map the blocks directly out of the xattr buffers as we
already do internally for all the XFS code...

> I guess there is also the issue of encryption, which hasn't come up yet since
> we're talking about fsverity support only.  The Merkle tree (including the
> fsverity_descriptor) is supposed to be encrypted, just like the file contents
> are.  Having it be stored after the file contents accomplishes that easily...
> Of course, it doesn't have to be that way; a separate key could be derived, or
> the Merkle tree blocks could be encrypted with the file contents key using
> indices past i_size, without them physically being stored in the data stream.

I'm expecting that fscrypt for XFS will include encryption of the
xattr names and values (just like we will need to do for directory
names) except for the xattrs that hold the encryption keys
themselves. That means the merkle tree blocks should get encrypted
without any extra work needing to be done anywhere.  This will
simply require the fscrypt keys to be held in a private internal
xattr namespace that isn't encrypted, but that's realtively trivial
to do...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
