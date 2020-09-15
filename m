Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF38626AC7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgIOSsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 14:48:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:48702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgIOSrj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 14:47:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81563ABD2;
        Tue, 15 Sep 2020 18:47:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35F71DA818; Tue, 15 Sep 2020 20:46:25 +0200 (CEST)
Date:   Tue, 15 Sep 2020 20:46:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     dsterba@suse.cz, A L <mail@lechevalier.se>,
        linux-btrfs@vger.kernel.org
Subject: Re: Changes in 5.8.x cause compsize/bees failure
Message-ID: <20200915184624.GI1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        A L <mail@lechevalier.se>, linux-btrfs@vger.kernel.org
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
 <20200915081725.GH1791@twin.jikos.cz>
 <20200915183438.GG5890@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915183438.GG5890@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 02:34:38PM -0400, Zygo Blaxell wrote:
> On Tue, Sep 15, 2020 at 10:17:25AM +0200, David Sterba wrote:
> > On Sat, Sep 12, 2020 at 07:13:21PM +0200, A L wrote:
> > > I noticed that in (at least 5.8.6 and 5.8.8) there is some change in 
> > > Btrfs kernel code that cause them to fail.
> > > 
> > > For example compsize now often/usually fails with: "Regular extent's 
> > > header not 53 bytes (0) long?!?"
> > > 
> > > Bees is having plenty of errors too, and does not succeed to read any 
> > > files (hash db is always empty). Perhaps this is an unrelated problem?
> > 
> > The fix is now in stable queue, to be released in 5.8.10. Thanks for the
> > report!
> 
> And hopefully 5.4?  5.4.64 is also affected (and also fixed by Filipe's
> patch).

Yes, complete list from
git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git :

./queue-5.8/btrfs-fix-wrong-address-when-faulting-in-pages-in-the-search-ioctl.patch
./queue-4.14/btrfs-fix-wrong-address-when-faulting-in-pages-in-the-search-ioctl.patch
./queue-5.4/btrfs-fix-wrong-address-when-faulting-in-pages-in-the-search-ioctl.patch
./queue-4.19/btrfs-fix-wrong-address-when-faulting-in-pages-in-the-search-ioctl.patch
./queue-4.4/btrfs-fix-wrong-address-when-faulting-in-pages-in-the-search-ioctl.patch
./queue-4.9/btrfs-fix-wrong-address-when-faulting-in-pages-in-the-search-ioctl.patch

