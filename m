Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7DA22EC1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgG0M1Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 08:27:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgG0M1Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 08:27:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C446CAB7D;
        Mon, 27 Jul 2020 12:27:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 436F5DA701; Mon, 27 Jul 2020 14:26:47 +0200 (CEST)
Date:   Mon, 27 Jul 2020 14:26:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
Message-ID: <20200727122647.GK3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
References: <20200721203340.275921-1-kreijack@libero.it>
 <20200723215325.GB5890@hungrycats.org>
 <a4074100-b006-7d64-e22d-779ad15191c0@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4074100-b006-7d64-e22d-779ad15191c0@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 01:56:58PM +0200, Goffredo Baroncelli wrote:
> > This could be done already from the initramfs.
> 
> Ok, this means that we have three possibility:
> 1) do this at bootloder level (eg grub)
> 2) do this at initramfs
> 3) do this at kernel level (see my patch)
> 
> All these possibilities are a viable solution. However I find 1) and
> 2) the more "intrusive", and distro specific. My fear is that each
> distro will take a different choice, leading to a more fragmentation.
> I hoped that the solution nr 3, could help to find a unique solution....

IMO bootloader or initrd are the right places to do the mount test and
eventual rollback. What kernel provides is to mount the subvolume, it's
up the the user to supply the right one. When I read the proposal the
option 2 was the the first thought that can be implemented with the
existing kernel support already.

Distros take different approach to various problems, and this is fine.
Here the list of fallback subvolumes, naming, where it's stored or
whatever may differ and the kernel provides the base functionality.

It would make sense to push that down one level in case all distros have
to repeat the same code and there would be an established way to do the
main/rollback switch.
