Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE21EA859
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgFARUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 13:20:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFARUb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 13:20:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DA86AC9F;
        Mon,  1 Jun 2020 17:20:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A928DA79B; Mon,  1 Jun 2020 19:20:27 +0200 (CEST)
Date:   Mon, 1 Jun 2020 19:20:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/46] Trivial BTRFS_I removal
Message-ID: <20200601172026.GA18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200601153744.31891-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 01, 2020 at 06:36:58PM +0300, Nikolay Borisov wrote:
> Here are 4 dozen patches that "bubble up" the usage of BTRFS_I from internal
> functions towards the external interfaces. Still far away from a complete
> cleanup but a step in the right direction. The primary goal is to unify the
> internal interfaces by always taking btrfs_inode and only use vfs_inode where
> it makes sense. Also reduce the clutter and line lenghts that BTRFS_I brings.

Looks good on first pass. Please go through the changelogs and reformat
lines that are longer than 74 and fixup various space damage you find on
the way. Thanks.
