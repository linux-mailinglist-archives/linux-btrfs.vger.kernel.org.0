Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD629CD51
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 02:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ1Bi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 21:38:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:60412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1833001AbgJ0X1a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 19:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D8B5AED9;
        Tue, 27 Oct 2020 23:27:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2258DAF58; Wed, 28 Oct 2020 00:25:54 +0100 (CET)
Date:   Wed, 28 Oct 2020 00:25:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 10/68] btrfs: extent_io: remove the forward
 declaration and rename __process_pages_contig
Message-ID: <20201027232554.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-11-wqu@suse.com>
 <20201027002812.GY6756@twin.jikos.cz>
 <6ec61a07-1263-cd39-0e0c-6709e23abc82@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ec61a07-1263-cd39-0e0c-6709e23abc82@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 27, 2020 at 08:50:15AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/10/27 上午8:28, David Sterba wrote:
> > On Wed, Oct 21, 2020 at 02:24:56PM +0800, Qu Wenruo wrote:
> >> There is no need to do forward declaration for __process_pages_contig(),
> >> so move it before it get first called.
> > 
> > But without other good reason than prototype removal we don't want to
> > move the code.
> > 
> >> Since we are here, also remove the "__" prefix since there is no special
> >> meaning for it.
> > 
> > Renaming and adding the comment is fine on itself but does not justify
> > moving the chunk of code.
> > 
> I thought the forward declaration should be something we clean up during
> development.

Eventually yes but commits that only move code pollute the git history
so there needs to be some other reason like splitting or refactoring.
Keeping the prototypes is not that bad, if it pops up during grep it's
quickly skipped, but when one is looking why some code changed it's very
annoying to land in some "move code" patch. I'm trying to keep such
changes to minimum but there are cases where we want that so it's not a
strict 'no never', rather case by case decision.
> 
> But it looks like it's no longer the case or my memory is just blurry.

The list of things to keep in mind is getting long
https://btrfs.wiki.kernel.org/index.php/Development_notes#Coding_style_preferences
