Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91E1230AC7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgG1M6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 08:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbgG1M6F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 08:58:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85B8EAFF8;
        Tue, 28 Jul 2020 12:58:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54207DA701; Tue, 28 Jul 2020 14:57:33 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:57:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
Message-ID: <20200728125732.GS3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200728015715.142747-1-dxu@dxuuu.xyz>
 <20200728113837.GR3703@twin.jikos.cz>
 <0ccb18f3-d4eb-9978-b4b6-157cd7c922f0@gmx.com>
 <0f91c4fa-e9b4-c170-78d8-0e8fe932ccd0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f91c4fa-e9b4-c170-78d8-0e8fe932ccd0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 28, 2020 at 08:12:40PM +0800, Qu Wenruo wrote:
> >>> +trim_trailing_whitespace = true
> >>
> >> Does this setting apply on lines that get changed or does it affect the
> >> whole file? If it's just for the lines, then it's what we want.
> >>
> > At least from the vim plugin code, it's just for the new lines:
> > 
> > https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5ebadcba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494
> > 
> > It just call the replace on the current line.
> 
> My bad, %s, it replaces all existing lines...

So this would introduce unrelated changes, but it seems that we don't
have much trailing whitespaces in progs codebase:

  $ git grep '\s\+$'
  btrfs-fragments.c:
  btrfs-fragments.c:                              black = gdImageColorAllocate(im, 0, 0, 0);  
  crypto/crc32c.c:/* 
  crypto/crc32c.c: * 
  crypto/crc32c.c: * Software Foundation; either version 2 of the License, or (at your option) 
  crypto/crc32c.c: * Steps through buffer one byte at at time, calculates reflected 
  crypto/crc32c.c: * Steps through buffer one byte at at time, calculates reflected 
  kernel-lib/radix-tree.h: * 
  kernel-lib/radix-tree.h: * 
  kernel-lib/rbtree.c:            node = node->rb_right; 
  kernel-lib/rbtree.c:            node = node->rb_left; 
  kernel-lib/rbtree.h:  

filtering only the sources. So let's keep it in the config.
