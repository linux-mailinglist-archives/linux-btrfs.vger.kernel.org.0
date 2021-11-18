Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC84562F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 19:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhKRS5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 13:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRS5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 13:57:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858EC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 10:54:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g19so6948509pfb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 10:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bcFIKm6OUM2zm4fjkRqvDV+QTI1Au7nfVIZhzUXt1V0=;
        b=GrvLhf/x1AIv8LmlqYNF21B0yMb1JWF0nI6qviANdqx2nUC94Urod8/PzWmAAGvBp+
         2oe7QJrioBzSe5F2+c/tt/XX/8Ze2hhvJMnhLCDAT8zE5x7qv7IlR1Jw8kFilEtZxG8Q
         CozoISPSJD95D1FSR1u4crKckSIi4NIrMP0Z9h04u1tB6As+zP5+kV9NCh/m+Fib9f7w
         lTpK+QvxwaYvVz1cwcILci+iCgF8hQD0G5doMdJPAMi7J+EBeMwGJq9GFOEftW3wvSQB
         hI1SW5CJmoHDD/YZjBoiUEKx81onL3cZlJXEtX0XpgnizWs4M5kmKZRMowwjVUbsGIz9
         dCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bcFIKm6OUM2zm4fjkRqvDV+QTI1Au7nfVIZhzUXt1V0=;
        b=Tp/RCK9168QXrKq8V09Fy63rkh/KpI6yGmRmR0ihvm8Q2bCBTHUWD+rqZ1hm+d1+5B
         Qw+Dg5+ZmP+pQ3ySeGIft0Id5Xhscla4ZrrYzFAGjBA4Z+GQuQQf3zKplnXEKdzmimp+
         deAUMWB7vkcNDjazt9od1lDpo3RtgCcNlgKJNWnv3eG0SsHhBzM5NJr3dE6DpjfaaEjE
         Q1mwYcnbZBFko/J0Gx8OOZYcEQKBKoGJRCdjcn7/oQE/frZLwbIKjKLxfj/pf7fKa/1z
         1ekknCMKQ/+bddIGQlGkL/YlO54onTZsHryPLVwpm+xyA2Piuwh4jf+eiejxRn49ivpP
         jpHw==
X-Gm-Message-State: AOAM530qXzYZZoAScprsbuqRedWZHnUuYd9UL0Jl8dsr1wr05brW0Sdt
        RpP3CqIvxCDM8RP2xJbbsvfYGQ==
X-Google-Smtp-Source: ABdhPJyJ7qrd2Bl+2g6goa8URdo+/ibyaMyG1fHqkzZbOQT3j28SrZlEoiyzR0Q92pd61IdR+b2dFw==
X-Received: by 2002:a05:6a00:80c:b0:49f:de3e:e475 with SMTP id m12-20020a056a00080c00b0049fde3ee475mr17316940pfk.27.1637261658916;
        Thu, 18 Nov 2021 10:54:18 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:174e])
        by smtp.gmail.com with ESMTPSA id f21sm357875pfe.69.2021.11.18.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:54:18 -0800 (PST)
Date:   Thu, 18 Nov 2021 10:54:16 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 12/17] btrfs: send: fix maximum command numbering
Message-ID: <YZahWPMfY5CLXTa6@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <bc324fbf99e8a792719da7bb96f5dcf4964904de.1637179348.git.osandov@fb.com>
 <20211118142359.GE28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118142359.GE28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 03:23:59PM +0100, David Sterba wrote:
> On Wed, Nov 17, 2021 at 12:19:22PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
> > _BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
> > version plus 1, but as written this creates gaps in the number space.
> > The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
> > accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
> > has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
> > 23 and 24 are valid commands.
> 
> The MAX definitions have the __ prefix so they're private and not meant
> to be used as proper commands, so nothing should suggest there are any
> commands with numbers 23 to 25 in the example.
> 
> > Instead, let's explicitly set BTRFS_SEND_C_MAX_V* to the maximum command
> > number. This requires repeating the command name, but it has a clearer
> > meaning and avoids gaps. It also doesn't require updating
> > __BTRFS_SEND_C_MAX for every new version.
> 
> It's probably a matter of taste, I'd intentionally avoid the pattern
> above, ie. repeating the previous command to define max.
> 
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -316,8 +316,8 @@ __maybe_unused
> >  static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
> >  {
> >  	switch (sctx->proto) {
> > -	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
> > -	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
> > +	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
> > +	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
> 
> This seems to be the only practical difference, < or <= .

There is another practical difference, which is more significant in my
opinion: the linear style creates "gaps" in the valid commands. Consider
this, with explicit values added for clarity:

enum btrfs_send_cmd {
        BTRFS_SEND_C_UNSPEC = 0,

        /* Version 1 */
        BTRFS_SEND_C_SUBVOL = 1,
        BTRFS_SEND_C_SNAPSHOT = 2,

        BTRFS_SEND_C_MKFILE = 3,
        BTRFS_SEND_C_MKDIR = 4,
        BTRFS_SEND_C_MKNOD = 5,
        BTRFS_SEND_C_MKFIFO = 6,
        BTRFS_SEND_C_MKSOCK = 7,
        BTRFS_SEND_C_SYMLINK = 8,

        BTRFS_SEND_C_RENAME = 9,
        BTRFS_SEND_C_LINK = 10,
        BTRFS_SEND_C_UNLINK = 11,
        BTRFS_SEND_C_RMDIR = 12,

        BTRFS_SEND_C_SET_XATTR = 13,
        BTRFS_SEND_C_REMOVE_XATTR = 14,

        BTRFS_SEND_C_WRITE = 15,
        BTRFS_SEND_C_CLONE = 16,

        BTRFS_SEND_C_TRUNCATE = 17,
        BTRFS_SEND_C_CHMOD = 18,
        BTRFS_SEND_C_CHOWN = 19,
        BTRFS_SEND_C_UTIMES = 20,

        BTRFS_SEND_C_END = 21,
        BTRFS_SEND_C_UPDATE_EXTENT = 22,
        __BTRFS_SEND_C_MAX_V1 = 23,

        /* Version 2 */
        BTRFS_SEND_C_FALLOCATE = 24,
        BTRFS_SEND_C_SETFLAGS = 25,
        BTRFS_SEND_C_ENCODED_WRITE = 26,
        __BTRFS_SEND_C_MAX_V2 = 27,

        /* End */
        __BTRFS_SEND_C_MAX = 28,
};
#define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1) /* 27 */

Notice that BTRFS_SEND_C_UPDATE_EXTENT is 22 and the next valid command
is BTRFS_SEND_C_FALLOCATE, which is 24. So 23 does not correspond to an
actual command; it's a "gap". This is somewhat cosmetic, but it's an
ugly wart in the protocol.

Also consider something indexing on the command number, like the
cmd_send_size thing I got rid of in the previous patch:

	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1]

Indices 23 and 27 are wasted. It's only 16 bytes in this case, which
doesn't matter practically, but it's unpleasant.

Maybe you were aware of this and fine with it, in which case we can drop
this change. But I think the name repetition is less ugly than the gaps.
