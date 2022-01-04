Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70315484832
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiADTFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 14:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiADTFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 14:05:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D315C061761
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 11:05:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so299983plg.12
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jan 2022 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+gLYj6rchkeMl01FLrHia4uRov/evgThk7mzqbyobCQ=;
        b=ZYjJndef+CzisOVMELp+nKi5NPw04VJaA0wdqricrD9tpuR+/q7A2vwiSlUq8TRJ0z
         +QzE9YA2ETqWJGXgZio4hCqKk+yhdch4VeAmlV0BJJG82CknyG5lU0eo2ZOsREnqX2KT
         NBfrTtilCsJ4cCYfaYmDzwjzF8xK1UeDhpc/pY8xXv0aamFYxsM0lhujVVkE/UrWwQN1
         Cx9WjxrwkMnT8aGbgFqn7HDQbaEpJKXUY/Opc19N9tdtynkD8zpjuey+8QOkoAh0ZFUZ
         zO6uhxOfrKrCrsG/lAHC1RZly/9LQZLW6UOlmENR1/2C0YtmgZzaicPHm0hbzUa5QTiA
         AVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+gLYj6rchkeMl01FLrHia4uRov/evgThk7mzqbyobCQ=;
        b=uxdBQSIAUuWXeghe1Y0PH/0bo4fplsT7OWHa/KHSr6RfswPqqbHK0SfCZSGZ5NzaAW
         snBeKtm2+LED5FkIuwsUQPBWroMqn1qNLdxUFsXxaIjTgXKham9S0f/lT1+ZfKFnCDYs
         ms9b9IaB4/zYzK8piGwplVmY2Vrtygq02GpG9EQK277Bh/jeqxHv8hG75LljcRc0T853
         AiD4UQHx1n5JeZwetRDQYOr6W2bAa64obhuOMa8fy/AXVDJy2vHUQRNj9hzQYxMVDHNj
         Cr5W4uKWV2xrwtxDsJhQd31dHIvVZXIfRqdxouvRUTj/MBGE3c5RHydA9DFzAvAAodpU
         LYPQ==
X-Gm-Message-State: AOAM532Xb9oKa3ck6Ynb7eUUfh+7f+tNWsDLSpc8aXRpcIFULdWO3E1B
        UNKEP1qvvj5eZ+fEOzXWzPCGWu4fGvuSAQ==
X-Google-Smtp-Source: ABdhPJxOKG7SEp9fOKazFTYh04EX8gujNBtAZNV2m0GducygtoWTy07XXQ5r3HkHcLd1U/VwLtG//w==
X-Received: by 2002:a17:903:1250:b0:149:907d:afdc with SMTP id u16-20020a170903125000b00149907dafdcmr32962171plh.59.1641323115012;
        Tue, 04 Jan 2022 11:05:15 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:7bfc])
        by smtp.gmail.com with ESMTPSA id k62sm115342pja.23.2022.01.04.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:05:14 -0800 (PST)
Date:   Tue, 4 Jan 2022 11:05:13 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 12/17] btrfs: send: fix maximum command numbering
Message-ID: <YdSaaeYkkS5TfI8Y@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
 <20211118142359.GE28560@twin.jikos.cz>
 <YZahWPMfY5CLXTa6@relinquished.localdomain>
 <YbJGAtRjYAinr4Ak@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJGAtRjYAinr4Ak@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 10:08:02AM -0800, Omar Sandoval wrote:
> On Thu, Nov 18, 2021 at 10:54:16AM -0800, Omar Sandoval wrote:
> > On Thu, Nov 18, 2021 at 03:23:59PM +0100, David Sterba wrote:
> > > On Wed, Nov 17, 2021 at 12:19:22PM -0800, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> > > > _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
> > > > version plus 1, but as written this creates gaps in the number space.
> > > > The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> > > > accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> > > > has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> > > > 23 and 24 are valid commands.
> > > 
> > > The MAX definitions have the __ prefix so they're private and not meant
> > > to be used as proper commands, so nothing should suggest there are any
> > > commands with numbers 23 to 25 in the example.
> > > 
> > > > Instead, let's explicitly set BTRFS_SEND_C_MAX_V* to the maximum command
> > > > number. This requires repeating the command name, but it has a clearer
> > > > meaning and avoids gaps. It also doesn't require updating
> > > > __BTRFS_SEND_C_MAX for every new version.
> > > 
> > > It's probably a matter of taste, I'd intentionally avoid the pattern
> > > above, ie. repeating the previous command to define max.
> > > 
> > > > --- a/fs/btrfs/send.c
> > > > +++ b/fs/btrfs/send.c
> > > > @@ -316,8 +316,8 @@ __maybe_unused
> > > >  static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
> > > >  {
> > > >  	switch (sctx->proto) {
> > > > -	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> > > > -	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> > > > +	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
> > > > +	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
> > > 
> > > This seems to be the only practical difference, < or <= .
> > 
> > There is another practical difference, which is more significant in my
> > opinion: the linear style creates "gaps" in the valid commands. Consider
> > this, with explicit values added for clarity:
> > 
> > enum btrfs_send_cmd {
> >         BTRFS_SEND_C_UNSPEC = 0,
> > 
> >         /* Version 1 */
> >         BTRFS_SEND_C_SUBVOL = 1,
> >         BTRFS_SEND_C_SNAPSHOT = 2,
> > 
> >         BTRFS_SEND_C_MKFILE = 3,
> >         BTRFS_SEND_C_MKDIR = 4,
> >         BTRFS_SEND_C_MKNOD = 5,
> >         BTRFS_SEND_C_MKFIFO = 6,
> >         BTRFS_SEND_C_MKSOCK = 7,
> >         BTRFS_SEND_C_SYMLINK = 8,
> > 
> >         BTRFS_SEND_C_RENAME = 9,
> >         BTRFS_SEND_C_LINK = 10,
> >         BTRFS_SEND_C_UNLINK = 11,
> >         BTRFS_SEND_C_RMDIR = 12,
> > 
> >         BTRFS_SEND_C_SET_XATTR = 13,
> >         BTRFS_SEND_C_REMOVE_XATTR = 14,
> > 
> >         BTRFS_SEND_C_WRITE = 15,
> >         BTRFS_SEND_C_CLONE = 16,
> > 
> >         BTRFS_SEND_C_TRUNCATE = 17,
> >         BTRFS_SEND_C_CHMOD = 18,
> >         BTRFS_SEND_C_CHOWN = 19,
> >         BTRFS_SEND_C_UTIMES = 20,
> > 
> >         BTRFS_SEND_C_END = 21,
> >         BTRFS_SEND_C_UPDATE_EXTENT = 22,
> >         __BTRFS_SEND_C_MAX_V1 = 23,
> > 
> >         /* Version 2 */
> >         BTRFS_SEND_C_FALLOCATE = 24,
> >         BTRFS_SEND_C_SETFLAGS = 25,
> >         BTRFS_SEND_C_ENCODED_WRITE = 26,
> >         __BTRFS_SEND_C_MAX_V2 = 27,
> > 
> >         /* End */
> >         __BTRFS_SEND_C_MAX = 28,
> > };
> > #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1) /* 27 */
> > 
> > Notice that BTRFS_SEND_C_UPDATE_EXTENT is 22 and the next valid command
> > is BTRFS_SEND_C_FALLOCATE, which is 24. So 23 does not correspond to an
> > actual command; it's a "gap". This is somewhat cosmetic, but it's an
> > ugly wart in the protocol.
> > 
> > Also consider something indexing on the command number, like the
> > cmd_send_size thing I got rid of in the previous patch:
> > 
> > 	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1]
> > 
> > Indices 23 and 27 are wasted. It's only 16 bytes in this case, which
> > doesn't matter practically, but it's unpleasant.
> > 
> > Maybe you were aware of this and fine with it, in which case we can drop
> > this change. But I think the name repetition is less ugly than the gaps.
> 
> Ping. Please let me know how you'd like me to proceed on this issue and
> my other replies. Thanks!

New year, new ping. Thanks!
