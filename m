Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3A1345DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAHPML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 10:12:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:33840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgAHPML (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 10:12:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D088DADE0;
        Wed,  8 Jan 2020 15:12:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F70EDA791; Wed,  8 Jan 2020 16:11:59 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:11:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
Message-ID: <20200108151159.GI3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
 <20200108150841.GH3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108150841.GH3929@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 08, 2020 at 04:08:41PM +0100, David Sterba wrote:
> > >> +static bool have_reloc_root(struct btrfs_root *root)
> > >> +{
> > >> +    if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> > >> +        return false;
> > > 
> > > You still need a smp_mb__after_atomic() here, test_bit is unordered. 
> > 
> > Nope, that won't do anything, since smp_mb__(After|before)_atomic only
> > orders RMW operations and test_bit is not an RMW operation. From
> > atomic_bitops.txt:
> > 
> > 
> > Non-RMW ops:
> > 
> > 
> > 
> >   test_bit()
> > 
> > Furthermore from atomic_t.txt:
> > 
> > The barriers:
> > 
> > 
> > 
> >   smp_mb__{before,after}_atomic()
> > 
> > 
> > 
> > only apply to the RMW atomic ops and can be used to augment/upgrade the
> > 
> > ordering inherent to the op.
> 
> The way I read it is more like smp_rmb/smp_wmb, but for bits in this
> case, so the smp_mb__before/after_atomic was only a syntactic sugar to
> match that it's atomic bitops. I realize this could have caused some
> confusion, however I still think that some sort of barrier is needed.

There's an existing pattern used for serializing set/clear of
BTRFS_ROOT_IN_TRANS_SETUP (record_root_in_trans,
btrfs_record_root_in_trans).

Once upon a time there were barriers like smp_mb__before_clear_bit but
they got unified to just smp_mb__before_atomic for all set/clear
operations, so I believe I was not all wrong with using them.
