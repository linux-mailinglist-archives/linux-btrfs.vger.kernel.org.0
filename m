Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4533B239F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWWm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 18:42:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWWm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 18:42:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ABA5221962;
        Wed, 23 Jun 2021 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624488031;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OgE/NZKnt/M0/aCdj7tn9NDZeKvuvp07A8QAHAQkDSc=;
        b=kT+L1t+orxLCKC1GaTiWNk1b3yJpZXRMMrdTcF2VL8VRxCuzO0M3PWl69F0+/BUryeNwCi
        6/aCa1wDXh6D3FkiV48K7DHbcIpTerqtOnwpaxOLo8j8NhJC5sseRPc+NZEaQZCKmGiq+X
        eeaB0VmdtcBGozNhWB+YAu9JfPN1B4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624488031;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OgE/NZKnt/M0/aCdj7tn9NDZeKvuvp07A8QAHAQkDSc=;
        b=8SZfrf/cFfXOfvDNZytwpIg9USefsSBtyHjhJLaMnUuIO9IGTF9QzRk45ShnRtYYvbeBld
        5JVgVjYrK8/XWrDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A47BCA3B83;
        Wed, 23 Jun 2021 22:40:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35D07DA8E8; Thu, 24 Jun 2021 00:37:40 +0200 (CEST)
Date:   Thu, 24 Jun 2021 00:37:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] btrfs: experimental compression support for
 subpage
Message-ID: <20210623223740.GQ28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 01:55:21PM +0800, Qu Wenruo wrote:
> Qu Wenruo (8):
>   btrfs: don't pass compressed pages to
>     btrfs_writepage_endio_finish_ordered()
>   btrfs: make btrfs_subpage_end_and_test_writer() to handle pages not
>     locked by btrfs_page_start_writer_lock()
>   btrfs: make compress_file_range() to be subpage compatible
>   btrfs: make btrfs_submit_compressed_write() to be subpage compatible
>   btrfs: use async_chunk::async_cow to replace the confusing pending
>     pointer
>   btrfs: make end_compressed_bio_writeback() to be subpage compatble
>   btrfs: make extent_write_locked_range() to be subpage compatible
>   btrfs: only allow subpage compression if the range fully covers the
>     first page

Some of the patches seem independent and potentially could be taken into
5.14 now but I guess the whole subpage could go in one big batch to 5.15
so it won't help you much anyway. The significant change is the last
patch and so far I think it's acceptable.
