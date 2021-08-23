Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC053F5181
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhHWTqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:46:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54220 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhHWTqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:46:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C26722043;
        Mon, 23 Aug 2021 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629747963;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeNikHSWw2/vYFvuyEdce5f8PH61qjhFbcfgXJ1pyBs=;
        b=oFprr0oWyrT8+1A1QZDsbz28wAjr/sxbha5N80Y9qcel3qzhggS10ReOBayvQFLXPm6YtC
        Kddo1SU9cvY+0giQIut771AlXTvzNo1aVS8SQqKjFZUtZFQFE3bzN5VYNg8JHExlk2hNM7
        QUmitfmolIhgcTaf1EZsp3L5Po0Ftrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629747963;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeNikHSWw2/vYFvuyEdce5f8PH61qjhFbcfgXJ1pyBs=;
        b=jxeCW9ekpgvErBv7BCLfw8fZsGOL33+rT3MUi2/VjNDUdTxwNnuGr0W5kjOathkE7OyteI
        50lkfjjZ74pDKMBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 75110A3BBA;
        Mon, 23 Aug 2021 19:46:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01079DA725; Mon, 23 Aug 2021 21:43:03 +0200 (CEST)
Date:   Mon, 23 Aug 2021 21:43:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/11] btrfs: defrag: rework to support sector perfect
 defrag
Message-ID: <20210823194303.GS5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 04:12:31PM +0800, Qu Wenruo wrote:
> Now both regular sectorsize and subpage sectorsize can pass defrag test
> group.

> Qu Wenruo (11):
>   btrfs: defrag: pass file_ra_state instead of file for
>     btrfs_defrag_file()
>   btrfs: defrag: also check PagePrivate for subpage cases in
>     cluster_pages_for_defrag()
>   btrfs: defrag: replace hard coded PAGE_SIZE to sectorsize
>   btrfs: defrag: extract the page preparation code into one helper
>   btrfs: defrag: introduce a new helper to collect target file extents
>   btrfs: defrag: introduce a helper to defrag a continuous prepared
>     range
>   btrfs: defrag: introduce a helper to defrag a range
>   btrfs: defrag: introduce a new helper to defrag one cluster
>   btrfs: defrag: use defrag_one_cluster() to implement
>     btrfs_defrag_file()
>   btrfs: defrag: remove the old infrastructure
>   btrfs: defrag: enable defrag for subpage case

The patch 9 was taken from your git repository. Patchset now in a topic
branch, I'll do one round and then move it to misc-next. Any followups
please send as separate patches, thanks.
