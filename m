Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9CAE9213
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfJ2Vcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 17:32:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfJ2Vcx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 17:32:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37CA6B3C6;
        Tue, 29 Oct 2019 21:32:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80FDEDA734; Tue, 29 Oct 2019 22:33:01 +0100 (CET)
Date:   Tue, 29 Oct 2019 22:33:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] btrfs: access eb::blocking_writers according to
 ACCESS_ONCE policies
Message-ID: <20191029213301.GC3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <cb93f314165c09d91cbbeb7a1d4ee59b54496220.1571340084.git.dsterba@suse.com>
 <270b6d1b-9304-80cd-4104-b55e8df99a8a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <270b6d1b-9304-80cd-4104-b55e8df99a8a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 11:42:29AM +0300, Nikolay Borisov wrote:
> On 17.10.19 г. 22:38 ч., David Sterba wrote:
> > @@ -294,7 +299,8 @@ void btrfs_tree_lock(struct extent_buffer *eb)
> >   */
> >  void btrfs_tree_unlock(struct extent_buffer *eb)
> >  {
> > -	int blockers = eb->blocking_writers;
> > +	/* This is read both locked and unlocked */
> > +	int blockers = READ_ONCE(eb->blocking_writers);
> 
> Actually aren't we guaranteed that btrfs_tree_unlock's caller is the
> owner of blocking_writers meaning we can use plain loads as per:
> 
> "The owning CPU or thread may use plain loads..."

That's right, I'll remove READ_ONCE and leave a comment as it's not
obvious from the context.
