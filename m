Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6F1793A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 16:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgCDPgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 10:36:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:38870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCDPgX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 10:36:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F4BBAC67;
        Wed,  4 Mar 2020 15:36:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 928A6DA7B4; Wed,  4 Mar 2020 16:35:59 +0100 (CET)
Date:   Wed, 4 Mar 2020 16:35:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: dump-tree: Introduce --nofilename option
Message-ID: <20200304153559.GW2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191111072435.28677-1-wqu@suse.com>
 <20191115155207.GW3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115155207.GW3001@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 15, 2019 at 04:52:07PM +0100, David Sterba wrote:
> On Mon, Nov 11, 2019 at 03:24:35PM +0800, Qu Wenruo wrote:
> > In the mail list, it's pretty common that a developer is asking dump tree
> > output from the reporter, it's better to protect those kind reporters by
> > hiding the filename if the reporter wants.
> 
> That's useful. Can we name it '--hide-filenames' ? You describe it in
> the text and I think this expresses what it does and hopefully will be
> clear to random users what the options does.

> Idea to consider: print a placeholder, like "name: HIDDEN", to keep the
> format of dump the same. It can also simplify the code.

So with the above implemented, the option is now --hide-names and prints
HIDDEN instead of various names.
