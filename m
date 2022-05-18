Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAE52C636
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 00:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiERWZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 18:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiERWZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 18:25:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19A20D248
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 15:25:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i17so3092480pla.10
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5zyEX9VRLTU6Wgrxklp343VSnob1yhTuTbII5cfVB5Q=;
        b=ocjfCpy1WY4SsHr4uK9vY9q8ZCbxKBQlauyvOjo/+tBObHFSEJBTA5kkF39fWir88j
         0QPO0uQsCDKxt1UnnQD6dDueIec+XUIKddvlfXP61TEiXkAJPX4B/chsEfCHRzl9unnl
         fEi5j1WzQU3FAHuAD/DYq1O4JjYYUYXW6FC5Mr3i4BAE9V2XSdzH+r+P8xhvdpVPA8fW
         D2lI6931mFGt8izcq2Rguq7LwlNIvW7RAU1uPXqzCT5hIYGaEu2WUsrZJoR/HHa4XJHg
         sFx7qG4plqfkuVtysW8aACadR10g4wS8ao9kbLhg+PiLTA9runBP3b4pDFe1UPS/3rE9
         UI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5zyEX9VRLTU6Wgrxklp343VSnob1yhTuTbII5cfVB5Q=;
        b=6MXY3YMZmikL5sY/PfwiT6dJvytZPS5MXK7yOnSPoZ7ZrAKnPlwckhBd2qjCyMNmjo
         bVRrIhovF8RWVdwBNV+YJWLxOkxBPG4XgPJTusrT8Fw2JDUuLI9JA4LVO8yJuc539NyO
         fqga7N3ZEAR/6hSxS5r1rxn6zwn2vQ6RykBXUgVCA1JD2DZsajtkdRL/Zk+6FSX6I+W1
         7obabIV84HE+6ogNjsibqCe9KNaXCpRglPAZISOQyNJ7rdUiyLSIdIJ77yktUeMjKF4F
         yApBD5EDZVRB9LaPLoMAvcVLj+NXgz6mZu4VIv1dFP4mTL1YC+T03qwqavlRRpCZIq9S
         DLoQ==
X-Gm-Message-State: AOAM532hX8I+OcwfF1qgX0x1wZ4bKgwNIjKKWD3N76SAPSse5iCPHkuh
        7ZxhIdeHD0y43Myl3hpxxSqW86pewd8mCA==
X-Google-Smtp-Source: ABdhPJy+MlbtWWrAzT3YxFrBE3RQ0LVIDEJlj8JtggLAXzsTmufwPxdE2vXTXmPq+1Kfu3FFo4uvsA==
X-Received: by 2002:a17:90b:1d90:b0:1df:d0ae:1443 with SMTP id pf16-20020a17090b1d9000b001dfd0ae1443mr919930pjb.122.1652912736789;
        Wed, 18 May 2022 15:25:36 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:2d0d])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001619b47ae61sm2205650pld.245.2022.05.18.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:25:35 -0700 (PDT)
Date:   Wed, 18 May 2022 15:25:34 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v15 3/7] btrfs: add send stream v2 definitions
Message-ID: <YoVyXsuWEOX6dtXE@relinquished.localdomain>
References: <cover.1649092662.git.osandov@fb.com>
 <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
 <20220518210003.GK18596@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518210003.GK18596@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 18, 2022 at 11:00:03PM +0200, David Sterba wrote:
> On Mon, Apr 04, 2022 at 10:29:05AM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This adds the definitions of the new commands for send stream version 2
> > and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
> > chattr), and encoded writes. It also documents two changes to the send
> > stream format in v2: the receiver shouldn't assume a maximum command
> > size, and the DATA attribute is encoded differently to allow for writes
> > larger than 64k. These will be implemented in subsequent changes, and
> > then the ioctl will accept the new version and flag.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/send.c            |  2 +-
> >  fs/btrfs/send.h            | 40 ++++++++++++++++++++++++++++++++++----
> >  include/uapi/linux/btrfs.h |  7 +++++++
> >  3 files changed, 44 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 9363f625fa17..1f141de3a7d6 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -7459,7 +7459,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
> >  
> >  	sctx->clone_roots_cnt = arg->clone_sources_count;
> >  
> > -	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
> > +	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
> >  	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
> >  	if (!sctx->send_buf) {
> >  		ret = -ENOMEM;
> > diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> > index 67721e0281ba..805d8095209a 100644
> > --- a/fs/btrfs/send.h
> > +++ b/fs/btrfs/send.h
> > @@ -12,7 +12,11 @@
> >  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
> >  #define BTRFS_SEND_STREAM_VERSION 1
> >  
> > -#define BTRFS_SEND_BUF_SIZE SZ_64K
> > +/*
> > + * In send stream v1, no command is larger than 64k. In send stream v2, no limit
> > + * should be assumed.
> > + */
> > +#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
> >  
> >  enum btrfs_tlv_type {
> >  	BTRFS_TLV_U8,
> > @@ -80,16 +84,20 @@ enum btrfs_send_cmd {
> >  	BTRFS_SEND_C_MAX_V1 = 22,
> >  
> >  	/* Version 2 */
> > -	BTRFS_SEND_C_MAX_V2 = 22,
> > +	BTRFS_SEND_C_FALLOCATE = 23,
> > +	BTRFS_SEND_C_SETFLAGS = 24,
> 
> Do you have patches that implement the fallocate modes and setflags? I
> don't see it in this patchset.

Nope, as discussed before, in order to keep the patch series managable,
this series adds the definitions and receive support for fallocate and
setflags, but leaves the send side to be implemented at a later time.

I implemented fallocate for send back in 2019:
https://github.com/osandov/linux/commits/btrfs-send-v2. It passed some
basic testing back then, but it'd need a big rebase and more testing.

> The setflags should be switched to
> something closer to the recent refactoring that unifies all the
> flags/attrs to fileattr. I have a prototype patch for that, comparing
> the inode flags in the same way as file mode, the tricky part is on the
> receive side how to apply them correctly. On the sending side it's
> simple though.

The way this series documents (and implements in receive)
BTRFS_SEND_C_SETFLAGS is that it's a simple call to FS_IOC_SETFLAGS with
given flags. I don't think this is affected by the change to fileattr,
unless I'm misunderstanding.

This is in line with the other commands being straightforward system
calls, but it does mean that the sending side has to deal with the
complexities of an immutable or append-only file being modified between
incremental sends (by temporarily clearing the flag), and of inherited
flags (e.g., a COW file inside of a NOCOW directory). I suppose it'd
also be possible to have SETFLAGS define the final flags and leave it up
to receive to make that happen by temporarily setting/clearing flags as
necessary, but that is a bit inconsistent with how we've handled other
commands.
