Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB12E14DF7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 17:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgA3Qyj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 11:54:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:49088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3Qyj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 11:54:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39A8CAD22;
        Thu, 30 Jan 2020 16:54:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DC348DA84C; Thu, 30 Jan 2020 17:54:18 +0100 (CET)
Date:   Thu, 30 Jan 2020 17:54:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: relocation: Add an introduction for how
 relocation works.
Message-ID: <20200130165418.GX3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200116050407.81267-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116050407.81267-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 16, 2020 at 01:04:07PM +0800, Qu Wenruo wrote:
> Relocation is one of the most complex part of btrfs, while it's also the
> foundation stone for online resizing, profile converting.
> 
> For such a complex facility, we should at least have some introduction
> to it.
> 
> This patch will add an basic introduction at pretty a high level,
> explaining:
> - What relocation does
> - How relocation is done
>   Only mentioning how data reloc tree and reloc tree are involved in the
>   operation.
>   No details like the backref cache, or the data reloc tree contents.
> - Which function to refer.
> 
> More detailed comments will be added for reloc tree creation, data reloc
> tree creation and backref cache.
> 
> For now the introduction should save reader some time before digging
> into the rabbit hole.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - New line after section title to improve readability
> - Don't mention "to relocate some extents" part for the objective.
>   As that only happens for error case.
> - Grammar fix.

Added to misc-next, thanks. For documenation, please try to spell out
all abbreviations or short forms. For example 'bg' is 'block group' and
RO is 'read-only', etc.
