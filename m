Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080314025AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhIGIya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 04:54:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56644 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbhIGIyT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 04:54:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42C591FE03;
        Tue,  7 Sep 2021 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631004793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ME0aIBYcYc1+7Ur+yxutEhpgbu4JA+PKtibcSK+TvFM=;
        b=HLrAlKH5HM8TxFMdtxzPnpRjRk5JJmtL587bKCGx3FljdZGF6rowiL7x4PF7KTqahQDIbi
        V44x1pNfXvRme1NRFxz+nKz4GjQRzCWxApoSrXbWn267PztwcVslfmo6mDWw4zLpyqTD6x
        KDjmrNqxolC3arZTJY1OBqbsaPJV+sI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1D55212FF9;
        Tue,  7 Sep 2021 08:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6MyvBHkoN2GRJwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 07 Sep 2021 08:53:13 +0000
Subject: Re: [PATCH 1/3] btrfs: rename btrfs_io_bio_alloc() to
 btrfs_bio_alloc_iovecs()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210907074242.103438-1-wqu@suse.com>
 <20210907074242.103438-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b3a4ed49-c3f4-dda1-4657-f9a913632c21@suse.com>
Date:   Tue, 7 Sep 2021 11:53:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907074242.103438-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.09.21 г. 10:42, Qu Wenruo wrote:
> Function btrfs_io_bio_alloc() is pretty similar to btrfs_bio_alloc(),
> the only major difference is the number of iovecs, and whether bi_sector
> is initialized.
> 
> Thus there is no need to add the extra "_io", which is only going to
> cause confusion.
> 
> Rename it to btrfs_bio_alloc_iovecs() to be easier to read.

The only difference between those 2 function is the fact that the latter
sets bio->bi_iter.bi_sector. So I'd say those should be turned into 1
function which takes the vecs as parameter as well as the bi_sector.

I've checked all callers of io_bio_alloc and we always have the sector
when allocating the bio. And this can simply be renamed to
btrfs_bio_alloc and be done with it.

<snip>
