Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F61E3D9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgE0Jcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 05:32:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgE0Jct (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 05:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76620ABD1;
        Wed, 27 May 2020 09:32:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7D9FDA72D; Wed, 27 May 2020 11:31:50 +0200 (CEST)
Date:   Wed, 27 May 2020 11:31:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: remove pointless out label in
 find_first_block_group
Message-ID: <20200527093150.GZ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
 <20200526142124.36202-2-johannes.thumshirn@wdc.com>
 <fce3d7f8-23b8-b417-f5d3-3f6af7738118@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fce3d7f8-23b8-b417-f5d3-3f6af7738118@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 26, 2020 at 06:24:49PM +0300, Nikolay Borisov wrote:
> 
> 
> On 26.05.20 г. 17:21 ч., Johannes Thumshirn wrote:
> > The 'out' label in find_first_block_group() does not do anything in terms
> > of cleanup.
> > 
> > It is better to directly return 'ret' instead of jumping to out to not
> > confuse readers. Additionally there is no need to initialize ret with 0.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> I personally prefer returning fast aka the way you've done it but dunno
> if David is a fan of this. In any case:

I'm not and the pattern that should be used is a mix of both. The first
part is for the 'obvious' cases:

Early exit from function can use return, eg. when a feature is not
enabled, when there's no cleanup needed, when the return is inside an if
and is not nested

For the rest it's recommended to use the goto and single return as it
may be a big chunk of code with a lot of nesting and a return somewhere
in the middle reads harder.

In example of find_first_block_group the first 'goto out' after
btrfs_search_slot would be a candidate to convert to return, but the
rest is inside a while loop so goto is preferred.

It is also important to keep one style and switch to it eventually and I
think that the goto + single return is quite common nowadays, exceptions
exist in the old code.
