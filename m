Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6A14329E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 20:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgATTrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 14:47:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:48046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgATTrJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 14:47:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 46AC8AC66;
        Mon, 20 Jan 2020 19:47:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0D91DA7E6; Mon, 20 Jan 2020 20:46:51 +0100 (CET)
Date:   Mon, 20 Jan 2020 20:46:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: KASAN splat during mount on 5.4.5, no reproducer
Message-ID: <20200120194650.GO3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20191228200326.GD13306@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228200326.GD13306@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 28, 2019 at 03:03:26PM -0500, Zygo Blaxell wrote:
> 
> [...etc...it dumps the same stacks again in the BUG]
> 
> The deepest level of fs/btrfs code is the list_del_init in
> clean_dirty_subvols.
> 
> After a reboot the next mount (and all subsequent mounts so far)
> was successful.  I don't have a reproducer.

For the record, this and other KASAN reports regarding reloc root, is
going to be fixed in 5.4.14, "btrfs: relocation: fix reloc_root lifespan
and access" (6282675e6708ec78). Thanks for the reports and debugging
help.
