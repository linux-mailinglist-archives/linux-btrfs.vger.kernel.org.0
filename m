Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFFC3FD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJAS2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 14:28:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42534 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfJAS2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 14:28:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so12217794qkl.9
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2019 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jp6HxZcJLw5YfhlsWMDzaXRHAFoWLF9q41S/6Nbbz1U=;
        b=LLwsBQX5Fx84fXPoo6BAP5Yt3MhQDM/kPhX5lzxKVHYqp5fqITUSH9IuPOB8BvpUBh
         0uqgTjZ96hA2xDt4H+gSqp1fkqSpDvwSsgqzdrhGblLDAU5WxBS1IG7gn+jzyj7lzLM0
         +ZQl5xVnjWIUXgsH3s2Smjw6ZfWvnbW/zI6QMUN/BoPzOvhGInQvqtu4wprjj5E8UQSa
         UBUjppcBOqWA0zstfaZvUdlIe16bX8ZyOSURN5Ul6xGcsqvPbnyntoY/xo2T4O/r0L86
         m0+qFMrEjVuCw6V0bvMSYhequ8WD5NsEAbmfLBDaw+FZkwhWOui5brBMu9iZm4UVHqIQ
         Xeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jp6HxZcJLw5YfhlsWMDzaXRHAFoWLF9q41S/6Nbbz1U=;
        b=GSAT9mviDMqinA8QeMHT+XG+KD/pS5y3gwhlBZ7wLe2bjGfDABHtRWdX9/pg4KtvgE
         jgEqMBsIAgPQbjEWWftwtPKYSI1b/BYPZe2e5PLn1IGEgeSu3U1yCpjvEDaxL3U15H+h
         Kf9FgpgLPJOYBNhP5BIzAmfsdGLmb6/eQvTE98+yswgMdrPyDjLCmZgz5F4iGetS3yRu
         i+KbaBw2CAhiEpBHuzASEBYC6HJEYa0gKL/T92IQaPaoKrPoIF6iVX4jwa0b+h8+jZbZ
         fULnLfe0jz13P5OMtE/D06z0pC7R7ZOhnPGMpG6/RZ9BvE+0eMhtM8LAtWUrM5YqOZgw
         iGgw==
X-Gm-Message-State: APjAAAWgiXh+MNNO2KWzuZAFUebtz9hvIzCNlIXs+tlc9IYg0DrI/29N
        zVg3G6if513QCtyVXIbXNMioLw==
X-Google-Smtp-Source: APXvYqyHY6O+3koWUhDmW4P6w3Syg2S7i9/Y5eEEYyvX3PlxTc9R6nvc4sqHCiddZvTl6tUMuYoQxA==
X-Received: by 2002:a37:5086:: with SMTP id e128mr7740201qkb.471.1569954485980;
        Tue, 01 Oct 2019 11:28:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::cf71])
        by smtp.gmail.com with ESMTPSA id o38sm10568079qtc.39.2019.10.01.11.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 11:28:05 -0700 (PDT)
Date:   Tue, 1 Oct 2019 14:28:03 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH][v3] btrfs: add a force_chunk_alloc to space_info's sysfs
Message-ID: <20191001182802.pbywx2wn6uve2onq@macbook-pro-91.dhcp.thefacebook.com>
References: <20190805183153.22712-1-josef@toxicpanda.com>
 <20191001182350.GH2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001182350.GH2751@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 01, 2019 at 08:23:51PM +0200, David Sterba wrote:
> On Mon, Aug 05, 2019 at 02:31:53PM -0400, Josef Bacik wrote:
> > In testing various things such as the btrfsck patch to detect over
> > allocation of chunks, empty block group deletion, and balance I've had
> > various ways to force chunk allocations for debug purposes.  Add a sysfs
> > file to enable forcing of chunk allocation for the owning space info in
> > order to enable us to add testcases in the future to test these various
> > features easier.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v2->v3:
> > - as per Qu's suggestion, moved this to sysfs where it's easier to mess with and
> >   makes more sense.
> > - added side-effect is mixed bg forced allocation works with this scheme as
> >   well.
> > - had to add get_btrfs_kobj() to get to fs_info, not sure this is better than
> >   just adding the fs_info to the space_info, am open to other opinions here.
> 
> I believe v3 is the latest version, but I don't see the new file being
> added to the debug/ directory (ie. /sys/fs/btrfs/UUID/debug/)
> 
> As it has been discussed, whether to make the file always visible or
> only with CONFIG_BTRFS_DEBUG, I'd rather keep it debugging-only. The
> testing coverage should be sufficient for fstests that are run with the
> config option and not giving users a knob to paper over allocator
> problems sounds desirable.

Just ignore this one.  The btrfsck patch is more important.

Josef
