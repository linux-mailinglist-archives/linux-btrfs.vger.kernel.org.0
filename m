Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251B5231C62
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2J7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 05:59:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:53840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2J7p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 05:59:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02B13AC37;
        Wed, 29 Jul 2020 09:59:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59E2ADA882; Wed, 29 Jul 2020 11:59:14 +0200 (CEST)
Date:   Wed, 29 Jul 2020 11:59:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
Message-ID: <20200729095914.GZ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <0b039506-577f-05a1-2109-565e8c5c2a04@gmx.com>
 <C4IFM8SN79ND.2BH0DOVF4VXEG@maharaja>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C4IFM8SN79ND.2BH0DOVF4VXEG@maharaja>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 28, 2020 at 10:26:58AM -0700, Daniel Xu wrote:
> On Tue Jul 28, 2020 at 6:00 AM PDT, Qu Wenruo wrote:
> >
> >
> > On 2020/7/28 下午8:57, David Sterba wrote:
> > > On Tue, Jul 28, 2020 at 08:12:40PM +0800, Qu Wenruo wrote:
> > >>>>> +trim_trailing_whitespace = true
> > >>>>
> > >>>> Does this setting apply on lines that get changed or does it affect the
> > >>>> whole file? If it's just for the lines, then it's what we want.
> > >>>>
> > >>> At least from the vim plugin code, it's just for the new lines:
> > >>>
> > >>> https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5ebadcba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494
> > >>>
> > >>> It just call the replace on the current line.
> > >>
> > >> My bad, %s, it replaces all existing lines...
> > > 
> > > So this would introduce unrelated changes, but it seems that we don't
> > > have much trailing whitespaces in progs codebase:
> > > 
> > >   $ git grep '\s\+$'
> > >   btrfs-fragments.c:
> > >   btrfs-fragments.c:                              black = gdImageColorAllocate(im, 0, 0, 0);  
> > >   crypto/crc32c.c:/* 
> > >   crypto/crc32c.c: * 
> > >   crypto/crc32c.c: * Software Foundation; either version 2 of the License, or (at your option) 
> > >   crypto/crc32c.c: * Steps through buffer one byte at at time, calculates reflected 
> > >   crypto/crc32c.c: * Steps through buffer one byte at at time, calculates reflected 
> > >   kernel-lib/radix-tree.h: * 
> > >   kernel-lib/radix-tree.h: * 
> > >   kernel-lib/rbtree.c:            node = node->rb_right; 
> > >   kernel-lib/rbtree.c:            node = node->rb_left; 
> > >   kernel-lib/rbtree.h:  
> > > 
> > > filtering only the sources. So let's keep it in the config.
> > > 
> > Great.
> >
> > BTW, it would be better to mention we use editorconfig as the unified
> > formatting config.
> >
> > As most of us are using vim, which doesn't support editorconfig by
> > default, thus we need to install that plugin manually.
> 
> Sure, should a hint about editorconfig go into the `Development` section
> of the README.md?

Yeah that would be useful, thanks.
