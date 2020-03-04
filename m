Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9836F179257
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 15:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgCDO20 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 09:28:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:45112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDO20 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 09:28:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE522ABBE;
        Wed,  4 Mar 2020 14:28:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5DEF0DA7B4; Wed,  4 Mar 2020 15:28:02 +0100 (CET)
Date:   Wed, 4 Mar 2020 15:28:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Output proper csum string if csum mismatch
Message-ID: <20200304142802.GU2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200120093205.37824-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120093205.37824-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 05:32:05PM +0800, Qu Wenruo wrote:
> Introduce a new helper, csum_to_string(), to convert binary csum to
> string.
> 
> And use it in check_extent_csums(), so that
> "btrfs check --check-data-csum" could report the following human
> readable output:
>   mirror 1 bytenr 13631488 csum 0x13fec125 expected csum 0x98757625
> 
> Other than the original octane one:
>   mirror 1 bytenr 13631488 csum 19 expected csum 152
> 
> It also has the extra handling for 32 bytes csum (e.g. SHA256).
> For such long csum, it needs 66 characters (+2 for "0x") to just output
> one hash, so this function would truncate them into the following
> format:
>  0xaabb...ccdd
>     |       \- The tailing 2 bytes
>     \--------- The leading 2 bytes

Kernel prints the whole checksum and also 2 on one line,
btrfs_print_data_csum_error. The short version is ok for quick comparing
but for consistency do you think it's too bad to print the whole
checksum? Eg. when I see errors, copy&paste the checksum and can cross
check with the kernel messages/logs.
