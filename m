Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CC4836D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiACSb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:31:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiACSb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:31:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 996A1210F7;
        Mon,  3 Jan 2022 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641234685;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpepkSBzO94d8huSS7Gq5ikqSFdnOscDTdRnSOl9CSc=;
        b=BqdOKKdTIY4NtAQQ7MvaLo12+Z+b2uRyO89kU/9GB9PYely7UKuK+22uE72K9yakDSfSk9
        MIkrKI6LNYQ8pox7Eh3b/4IaTNfBmnV+pruD65RmWT6DIqFMy72WnNXIVXc2ljrtIw5N88
        lvivfhDujX3Ol79mXuxR2ANLArwFdks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641234685;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpepkSBzO94d8huSS7Gq5ikqSFdnOscDTdRnSOl9CSc=;
        b=fHxbG6Qkc80zXQGogDg4b3UjqRQ1Q+JGzLRH3Dfv6/EhIl949sJ3VQo8G7eSnSnyO5lGki
        3RPE+ekw+bgZuSCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 91F6CA3B81;
        Mon,  3 Jan 2022 18:31:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 95C2DDA729; Mon,  3 Jan 2022 19:30:56 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:30:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: respect the max size in the header when
 activating swap file
Message-ID: <20220103183056.GP28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <639eadb028056b60364ba7461c5e20e5737229a2.1639666714.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639eadb028056b60364ba7461c5e20e5737229a2.1639666714.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 03:00:32PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we extended the size of a swapfile after its header was created (by the
> mkswap utility) and then try to activate it, we will map the entire file
> when activating the swap file, instead of limiting to the max size defined
> in the swap file's header.
> 
> Currently test case generic/643 from fstests fails because we do not
> respect that size limit defined in the swap file's header.
> 
> So fix this by not mapping file ranges beyond the max size defined in the
> swap header.
> 
> This is the same type of bug that iomap used to have, and was fixed in
> commit 36ca7943ac18ae ("mm/swap: consider max pages in
> iomap_swapfile_add_extent").
> 
> Fixes: ed46ff3d423780 ("Btrfs: support swap files")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
