Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F0216E49
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGGOBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 10:01:44 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.12]:49663 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbgGGOBo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:44 -0400
X-Greylist: delayed 1324 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2020 10:01:43 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 75FAC40129179
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:00:29 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id snndjXbwEwgQAsnndjq9pn; Tue, 07 Jul 2020 08:38:17 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BBYLuCgndn29Unmqcpo6gAn/WrqHk/7aIEYEDvVkRMc=; b=vm9JyB0oBMD4d0BeFxD+c3dovp
        X4jSBD9IdhQ4WmdL7O9ClrO3HRpaMWutiX0yRzRsd16+35UdOikSfEm+e+ioK7UMTFS1NE7qinkUK
        DwvERgcbyIkenP8zTJcBzZQgV6h9V++/rKBXMS2ptxQvU3PI8EEPiznYCJbBMStC2ezPG+YUGPjBV
        vsy3+KAUaZDnYcpx4wrs9yxoNn3ViyM/84FCOi6Vskek+vI90UB6Ut//Y888qosVbRUeEeEyVIGgK
        8vPw5UYs0xowrl/QreZzaT2BTy9v6ok3V8qiJ+nAg0gnzWmcSkJp7n9kwSTymSgDFNhkJaNTVIWvS
        tOjgW24w==;
Received: from 189.114.217.89.dynamic.adsl.gvt.net.br ([189.114.217.89]:42220 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jsnnd-000Ebr-9L; Tue, 07 Jul 2020 10:38:17 -0300
Message-ID: <1d6dba979bea152600c90e76fa041325ad09188c.camel@mpdesouza.com>
Subject: Re: [PATCH] btrfs: ctree: Add do {} while (0) in
 btrfs_{set|clear}_and_info
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Tue, 07 Jul 2020 10:38:13 -0300
In-Reply-To: <14b394fd-b338-63c9-a8a3-ba3c725f1e79@suse.com>
References: <20200706145936.13620-1-marcos@mpdesouza.com>
         <14b394fd-b338-63c9-a8a3-ba3c725f1e79@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.114.217.89
X-Source-L: No
X-Exim-ID: 1jsnnd-000Ebr-9L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.114.217.89.dynamic.adsl.gvt.net.br ([192.168.0.172]) [189.114.217.89]:42220
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2020-07-07 at 11:34 +0300, Nikolay Borisov wrote:
> 
> On 6.07.20 г. 17:59 ч., Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Without this change it's not possible to use these macros and
> having an
> > if-else construction without using braces.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This change would have been better accompanied with another one
> showing
> intended usage. If it's part of a bigger rework then postpone it and
> send everything altogether.

Yes, this is part of my fscontext btrfs port. Ok, I'll send this again
again along with all the port patches.

Thanks,
  Marcos

> 
> > ---
> >  fs/btrfs/ctree.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index a256961c0dbe..cef0489a1523 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1278,18 +1278,18 @@ static inline u32
> BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
> >  					 BTRFS_MOUNT_##opt)
> >  
> >  #define btrfs_set_and_info(fs_info, opt, fmt, args...)		
> 	\
> > -{									
> \
> > +do {								
> 	\
> >  	if (!btrfs_test_opt(fs_info, opt))				
> \
> >  		btrfs_info(fs_info, fmt, ##args);			\
> >  	btrfs_set_opt(fs_info->mount_opt, opt);				
> \
> > -}
> > +} while (0)
> >  
> >  #define btrfs_clear_and_info(fs_info, opt, fmt, args...)		
> \
> > -{									
> \
> > +do {								
> 	\
> >  	if (btrfs_test_opt(fs_info, opt))				\
> >  		btrfs_info(fs_info, fmt, ##args);			\
> >  	btrfs_clear_opt(fs_info->mount_opt, opt);			\
> > -}
> > +} while (0)
> >  
> >  /*
> >   * Requests for changes that need to be done during transaction
> commit.
> > 

