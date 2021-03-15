Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379FE33BFB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 16:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhCOP0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 11:26:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCOP0F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 11:26:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AB16AE1F;
        Mon, 15 Mar 2021 15:26:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF732DA6E2; Mon, 15 Mar 2021 16:24:02 +0100 (CET)
Date:   Mon, 15 Mar 2021 16:24:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pierre Labastie <pierre.labastie@neuf.fr>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: build system: Fix the test for
 EXT4_EPOCH_MASK
Message-ID: <20210315152402.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Pierre Labastie <pierre.labastie@neuf.fr>,
        linux-btrfs@vger.kernel.org
References: <d7b1445f25866bf5c8d5016b7cd7a94e68f67dd8.camel@neuf.fr>
 <20210314184913.5689-1-pierre.labastie@neuf.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314184913.5689-1-pierre.labastie@neuf.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 14, 2021 at 07:49:13PM +0100, Pierre Labastie wrote:
> After sending the first version of the patch, I realized that it
> was flawed, because of some formatting by the MUA. It took me
> some time to set up an MTA so that git send-email works. Now the
> patch should apply cleanly. Please remove the present paragraph by using
> git am -c. Apologies for the inconvenience(s).
> -- >8 --
> Commit b3df561fbf has introduced the ability to convert extended
> inode time precision on ext4, but this breaks builds on older distros,
> where ext4 does not have the nsec time precision.
> 
> Commit c615287cc tried to fix that by testing the availability of
> the EXT4_EPOCH_MASK macro, but the test is not complete.
> 
> This patch aims at fixing the macro test, and changes the
> name of the associated HAVE_ macro, since the logic is reverted.
> 
> This fixes #353 when ext4 has nsec time precision. Note that
> the test fails when ext4 does not have the nsec time precision.
> Maybe the test shouldn't be run in that case?

Good point. What's the way to find that out? We can create a sample
ext4 filesystem and do a runtime check or parse it out of debugfs dump
looking for the features. I think it's the 'extra_isize', that's what
manual page ext4 says and that the patch adding 64bit timestamp support
checks when reading the extended timestamps.
