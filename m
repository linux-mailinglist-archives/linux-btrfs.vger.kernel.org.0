Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3BBCBDC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403874AbfIXPv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 11:51:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403832AbfIXPvz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 11:51:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71A03B01C;
        Tue, 24 Sep 2019 15:51:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3EDE4DA835; Tue, 24 Sep 2019 17:52:15 +0200 (CEST)
Date:   Tue, 24 Sep 2019 17:52:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 08/12] btrfs-progs: add option for checksum type to
 mkfs
Message-ID: <20190924155215.GY2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190903150046.14926-1-jthumshirn@suse.de>
 <20190903150046.14926-9-jthumshirn@suse.de>
 <20190924142653.GT2751@twin.jikos.cz>
 <20190924153411.GA8395@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924153411.GA8395@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 05:34:11PM +0200, Adam Borowski wrote:
> On Tue, Sep 24, 2019 at 04:26:53PM +0200, David Sterba wrote:
> > On Tue, Sep 03, 2019 at 05:00:42PM +0200, Johannes Thumshirn wrote:
> > > Add an option to mkfs to specify which checksum algorithm will be used for
> > > the filesystem.
> > > 
> > > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > 
> > I'll change the option to '-c' so we have the most common options as
> > lowercase letters.
> 
> -c is used for compression elsewhere, I'd rather avoid this confusion.

Fair point.
