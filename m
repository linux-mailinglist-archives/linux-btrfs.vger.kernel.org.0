Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB82D7BA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 17:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391678AbgLKQvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 11:51:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:35696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389489AbgLKQul (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 11:50:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8C14ACF1;
        Fri, 11 Dec 2020 16:50:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A21E8DA7A1; Fri, 11 Dec 2020 17:48:23 +0100 (CET)
Date:   Fri, 11 Dec 2020 17:48:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: print the eb flags for nodes as well
Message-ID: <20201211164823.GM6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <15066ba6ad8acaff53242f7cc4580874c42ce411.1605802617.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15066ba6ad8acaff53242f7cc4580874c42ce411.1605802617.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 19, 2020 at 11:17:04AM -0500, Josef Bacik wrote:
> While debugging a corruption problem I realized we don't spit out the
> flags for nodes, which is needed when debugging relocation problems so
> we know which nodes are the RELOC root items and which are the actual fs
> tree's items.  Fix this by unifying the header printing helper so both
> leaf's and nodes get the same information printed out.

This newly prints one more line for node, like

node 41070940160 level 1 items 34 free space 87 generation 7709536 owner ROOT_TREE
node 41070940160 flags 0x1(WRITTEN) backref revision 1

the same already exists for leaves

leaf 41070944256 items 12 free space 515 generation 7709536 owner ROOT_TREE
leaf 41070944256 flags 0x1(WRITTEN) backref revision 1

I think this is ok though it would be better to have that on one line.
That the offset block address is duplicated should be enough for
grepping or matching against other data, the line would be overly long
otherwise.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.
