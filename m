Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2234015455F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBFNrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:47:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:36124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBFNrs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 08:47:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2EBFCAC23;
        Thu,  6 Feb 2020 13:47:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 074E3DA952; Thu,  6 Feb 2020 14:47:33 +0100 (CET)
Date:   Thu, 6 Feb 2020 14:47:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/8] btrfs: drop argument tree from submit_extent_page
Message-ID: <20200206134733.GW2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1580925977.git.dsterba@suse.com>
 <a54487df38bbbd4f6149b2a7bbe86247fe5c532e.1580925977.git.dsterba@suse.com>
 <150ff69f-996e-7cfb-02ad-2193224f9b49@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150ff69f-996e-7cfb-02ad-2193224f9b49@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 06, 2020 at 01:58:22PM +0800, Anand Jain wrote:
> On 2/6/20 2:09 AM, David Sterba wrote:
> > Now that we're sure the tree from argument is same as the one we can get
> > from the page's inode io_tree,
> 
> 
> > drop the redundant argument.
> 
>   I think there is/was a plan to drop the btree inode? should we need
>   this argument if the plan is still on? or any idea if it still can
>   be implemented without this argument?

That's a question for the one implementing the btree inode removal. As
there are several possible ways how to implement it, with different
trade-offs and such, I can't forsee if this particula parameter will be
useful or not. And keeping things around for theoretical needs of future
patches has proven to not work so we've been removing such artifacts.

The exception is of course for patchsets that are in active development
and would have to revert the cleanups.
