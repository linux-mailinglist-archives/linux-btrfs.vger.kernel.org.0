Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956820707F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbgFXJ4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 05:56:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:50364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389762AbgFXJ4J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 05:56:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5D47AD25;
        Wed, 24 Jun 2020 09:56:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB14CDA79B; Wed, 24 Jun 2020 11:55:55 +0200 (CEST)
Date:   Wed, 24 Jun 2020 11:55:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: start deprecation of mount option inode_cache
Message-ID: <20200624095555.GO27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Steven Davies <btrfs-list@steev.me.uk>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200623185032.14983-1-dsterba@suse.com>
 <076d047d33676d78e882feb74a2f0c4f@steev.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076d047d33676d78e882feb74a2f0c4f@steev.me.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 08:37:13AM +0100, Steven Davies wrote:
> On 2020-06-23 19:50, David Sterba wrote:
> > @@ -827,6 +827,8 @@ int btrfs_parse_options(struct btrfs_fs_info
> > *info, char *options,
> >  			}
> >  			break;
> >  		case Opt_inode_cache:
> > +			btrfs_warn(info,
> > +	"the 'inode_cache' option is deprecated and will be stop working in 
> > 5.11");
> 
> "will stop working", but perhaps "will have no effect from" might be 
> more explicit.

Thanks, that's better, I'll update the patch.
