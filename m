Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0376C51
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfGZPFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 11:05:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbfGZPFg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 11:05:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3D96ADF1;
        Fri, 26 Jul 2019 15:05:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85BAADA811; Fri, 26 Jul 2019 17:06:10 +0200 (CEST)
Date:   Fri, 26 Jul 2019 17:06:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in
 insert_inline_extent()
Message-ID: <20190726150609.GE2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190724021132.27378-1-baijiaju1990@gmail.com>
 <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
 <800ae777-928f-2969-d4dd-6f358a039e48@gmail.com>
 <1b708c0d-8ea1-3898-0340-9cbce1fc2602@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b708c0d-8ea1-3898-0340-9cbce1fc2602@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 24, 2019 at 10:57:24AM +0800, Qu Wenruo wrote:
> On 2019/7/24 上午10:33, Jia-Ju Bai wrote:
> > On 2019/7/24 10:21, Qu Wenruo wrote:
> >> On 2019/7/24 上午10:11, Jia-Ju Bai wrote:
> >>> In insert_inline_extent(), there is an if statement on line 181 to check
> >>> whether compressed_pages is NULL:
> >>>      if (compressed_size && compressed_pages)
> >>>
> >>> When compressed_pages is NULL, compressed_pages is used on line 215:
> >>>      cpage = compressed_pages[i];
> >>>
> >>> Thus, a possible null-pointer dereference may occur.
> >>>
> >>> To fix this possible bug, compressed_pages is checked on line 214.
> >> This can only be hit with compressed_size > 0 and compressed_pages !=
> >> NULL.
> >>
> >> It would be better to have an extra ASSERT() to warn developers about
> >> the impossible case.
> > 
> > Thanks for the reply :)
> > So I should add ASSERT(compressed_size > 0 & compressed_pages) at the
> > beginning of the function, and remove "if (compressed_size &&
> > compressed_pages)"?
> 
> My suggestion is, ASSERT((compressed_size >0 && compressed_pages) ||
> (compressed_size == 0 && !compressed_pages))
> 
> And keeps the original checks.
> 
> Anyway, just a suggestion.

Agreed, the assertion would be good, covering both cases in one
statement at the beginning of the function.
