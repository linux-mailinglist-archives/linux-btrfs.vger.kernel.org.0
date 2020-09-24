Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DC2770B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgIXMQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 08:16:19 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.91]:39833 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbgIXMQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 08:16:19 -0400
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 08:16:18 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id B5AB2400CC019
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 06:54:55 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id LPpvkAxQ4BD8bLPpvkKz77; Thu, 24 Sep 2020 06:54:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n4pzCiu3+y0WUo1q1TMs6Uj/K/FGbzEb/h9IBW5KjME=; b=SjjYzkfKqRd8el6/AoCqZ9ti2G
        kzWJcNH/7haSLXPWyW06JbA7gkIgrbl8JUBSQGZDJpcuTI5e7S3dYjmxBKzKkjOE27iDIeB+bRjsA
        QQ3IsORpNqKojvsnKDgg0wKplAR6gQdU11mwyW1SapLxOdTFaSd0w9SIcNxSG+yKy1kqlBZhqz32Z
        hO/QNYseCZFKAIyOwsiyct4k1vszPplueFe05c9zsKShIUDy5rnYsJ65+kicBhqfnLKW49au8gkzu
        yXHDPNHbyfLI5fVdu/rwoO2282BFTiVesImT2dEQMwQ5Va+hgsrIhnyoyKEema3bp5YVVsI1Dv5ay
        VZvRlCRw==;
Received: from [179.183.202.67] (port=35166 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kLPpv-001Wta-5o; Thu, 24 Sep 2020 08:54:55 -0300
Message-ID: <cd7b29bb4546ca82b511d254edcf6219f28a37c6.camel@mpdesouza.com>
Subject: Re: [PATCH] btrfs-progs: convert: Mention which reserve_space call
 failed
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Thu, 24 Sep 2020 08:54:51 -0300
In-Reply-To: <528b370d-c594-6530-62aa-ef9067a2e275@gmx.com>
References: <20200923171405.17456-1-marcos@mpdesouza.com>
         <528b370d-c594-6530-62aa-ef9067a2e275@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.183.202.67
X-Source-L: No
X-Exim-ID: 1kLPpv-001Wta-5o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.172]) [179.183.202.67]:35166
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2020-09-24 at 08:08 +0800, Qu Wenruo wrote:
> 
> On 2020/9/24 上午1:14, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > btrfs-convert currently can't handle more fragmented block groups
> when
> > converting ext4 because the minimum size of a data chunk is 32Mb.
> > 
> > When converting an ext4 fs with more fragmented block group and the
> disk
> > almost full, we can end up hitting a ENOSPC problem [1] since
> smaller
> > block groups (10Mb for example) end up being extended to 32Mb,
> leaving
> > the free space tree smaller when converting it to btrfs.
> > 
> > This patch adds error messages telling which needed bytes couldn't
> be
> > allocated from the free space tree:
> > 
> > create btrfs filesystem:
> >         blocksize: 4096
> >         nodesize:  16384
> >         features:  extref, skinny-metadata (default)
> >         checksum:  crc32c
> > free space report:
> >         total:     1073741824
> >         free:      39124992 (3.64%)
> > ERROR: failed to reserve 33554432 bytes from free space for
> metadata chunk
> > ERROR: unable to create initial ctree: No space left on device
> > 
> > Link: https://github.com/kdave/btrfs-progs/issues/251
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks pretty good, but can be enhanced a little, inlined below.
> 
> Despite that, feel free to add my tag:
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> > ---
> >  convert/common.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/convert/common.c b/convert/common.c
> > index 048629df..6392e7f4 100644
> > --- a/convert/common.c
> > +++ b/convert/common.c
> > @@ -812,8 +812,10 @@ int make_convert_btrfs(int fd, struct
> btrfs_mkfs_config *cfg,
> >  	 */
> >  	ret = reserve_free_space(free_space, BTRFS_STRIPE_LEN,
> >  				 &cfg->super_bytenr);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		error("failed to reserve %d bytes from free space for
> temporary superblock", BTRFS_STRIPE_LEN);
> 
> It would be awesome if we can output the free space.
> 
> Just the largest portion is enough to show that we're hitting a real
> ENOSPC situation.

Indeed, I'll send a v2 printing the free space tree when ENOSPC
happens.

> 
> Thanks,
> Qu
> >  		goto out;
> > +	}
> >  
> >  	/*
> >  	 * Then reserve system chunk space
> > @@ -823,12 +825,16 @@ int make_convert_btrfs(int fd, struct
> btrfs_mkfs_config *cfg,
> >  	 */
> >  	ret = reserve_free_space(free_space,
> BTRFS_MKFS_SYSTEM_GROUP_SIZE,
> >  				 &sys_chunk_start);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		error("failed to reserve %d bytes from free space for
> system chunk", BTRFS_MKFS_SYSTEM_GROUP_SIZE);
> >  		goto out;
> > +	}
> >  	ret = reserve_free_space(free_space,
> BTRFS_CONVERT_META_GROUP_SIZE,
> >  				 &meta_chunk_start);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		error("failed to reserve %d bytes from free space for
> metadata chunk", BTRFS_CONVERT_META_GROUP_SIZE);
> >  		goto out;
> > +	}
> >  
> >  	/*
> >  	 * Allocated meta/sys chunks will be mapped 1:1 with device
> offset.
> > 
> 

