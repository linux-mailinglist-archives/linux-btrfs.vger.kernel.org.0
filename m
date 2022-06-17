Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF75B54F9C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382532AbiFQPBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381652AbiFQPBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 11:01:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11A3E0F1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 08:01:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE6D21F86A;
        Fri, 17 Jun 2022 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655478067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rK5jkBbT8fKvrL8fWMVIxBmBdUNBA8dareKMbSOiXPg=;
        b=qB3ccUZwy4WHnXeDwEAvuMv9eawkUtjGKYA2IWqkEwQhQSqRzQ8Q8fkEODOfBcNQLJgkUV
        uLcGUIbkq5BU1k9hr/YYrK81jz8y+7P1ZVpyHpLxpcJussHMFTijEiXRLh2ymzXq7sh2bW
        O4XsKTFb5FtwRwqyKj6ZH7UptVOapag=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B1581348E;
        Fri, 17 Jun 2022 15:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7eAqIzOXrGJ5PQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 17 Jun 2022 15:01:07 +0000
Message-ID: <a2dd54d7-ea9e-8647-261c-7d622f536f53@suse.com>
Date:   Fri, 17 Jun 2022 18:01:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: don't limit direct reads to a single sector
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220616080224.953968-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220616080224.953968-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.06.22 г. 11:02 ч., Christoph Hellwig wrote:
> Btrfs currently limits direct I/O reads to a single sector, which goes
> back to commit c329861da406 ("Btrfs: don't allocate a separate csums
> array for direct reads") from Josef.  That commit changes the direct I/O
> code to ".. use the private part of the io_tree for our csums.", but ten
> years later that isn't how checksums for direct reads work, instead they
> use a csums allocation on a per-btrfs_dio_private basis (which have their
> own performane problem for small I/O, but that will be addressed later).
> 
> Lift this limit to improve performance for large direct reads.  For
> example a fio run doing 1 MiB aio reads with a queue depth of 1 roughly
> tripples the throughput:
> 
> Baseline:
> 
> READ: bw=65.3MiB/s (68.5MB/s), 65.3MiB/s-65.3MiB/s (68.5MB/s-68.5MB/s), io=19.1GiB (20.6GB), run=300013-300013msec
> 
> With this patch:
> 
> READ: bw=196MiB/s (206MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s), io=57.5GiB (61.7GB), run=300006-300006msc
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/inode.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6f665bf59f620..deb79e80e4e95 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7585,19 +7585,14 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>   	struct extent_map *em;
>   	struct extent_state *cached_state = NULL;
>   	struct btrfs_dio_data *dio_data = iter->private;
> -	u64 lockstart, lockend;
> +	u64 lockstart = start;
> +	u64 lockend = start + length - 1;
>   	const bool write = !!(flags & IOMAP_WRITE);
>   	int ret = 0;
>   	u64 len = length;
>   	const u64 data_alloc_len = length;
>   	bool unlock_extents = false;
>   
> -	if (!write)
> -		len = min_t(u64, len, fs_info->sectorsize);
> -
> -	lockstart = start;
> -	lockend = start + len - 1;
> -

The limit here has direct repercussion on how much space we could 
potentially allocated in btrfs_submit_direct for csums. For 1m read this 
means we end up with 256 entries array (provided a blocksize of 4k). For 
crc32c that's 1k of data, for blake2/sha256 that'd be 8k of data. It 
would be good to put this into the change log to demonstrated that at 
least some consideration has been given to this aspect.


In any case perhaps putting some sane upper limit might make sense?

>   	/*
>   	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn't
>   	 * enough if we've written compressed pages to this area, so we need to
