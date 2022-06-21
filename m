Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F78552D2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbiFUIh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiFUIh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 04:37:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB163BF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 01:37:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EFFB21E13;
        Tue, 21 Jun 2022 08:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655800676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/+POUtb0hLQcKoQOYJpJvzBIK1gTBbkZtrX4pujvu4=;
        b=nUcd9ZLdWtH9pDF1l0thIz1sFe00omPfD6qVnuSl/aO0v6cWeNpHG55pZ4VUJkXVMdZIiS
        jYfxByd7ojDNJVNP221akjN8FCduHxy3A5YXpVasSl92G1aqdWuHyp3cjjttiUTIiBSKGr
        ZdXSFMYelIT+1ZCnxSQfgDd2yo+2UyU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B822413A88;
        Tue, 21 Jun 2022 08:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NPBLKmODsWLWCwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 21 Jun 2022 08:37:55 +0000
Message-ID: <f1d81d56-b948-73c7-3bf4-3129af53852b@suse.com>
Date:   Tue, 21 Jun 2022 11:37:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220621062627.2637632-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220621062627.2637632-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.06.22 г. 9:26 ч., Christoph Hellwig wrote:
> Btrfs currently limits direct I/O reads to a single sector, which goes
> back to commit c329861da406 ("Btrfs: don't allocate a separate csums
> array for direct reads") from Josef.  That commit changes the direct I/O
> code to ".. use the private part of the io_tree for our csums.", but ten
> years later that isn't how checksums for direct reads work, instead they
> use a csums allocation on a per-btrfs_dio_private basis (which have their
> own performance problem for small I/O, but that will be addressed later).
> 
> There is no fundamental limit in btrfs itself to limit the I/O size
> except for the size of the checksum array that scales linearly with
> the number of sectors in an I/O.  Pick a somewhat arbitrary limit of
> 256 limits, which matches what the buffered reads typically see as
> the upper limit as the limit for direct I/O as well.
> 
> This significantly improves direct read performance.  For example a fio
> run doing 1 MiB aio reads with a queue depth of 1 roughly triples the
> throughput:
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

LGTM. However I think a more appropriate subject would be "increase 
direct read size limit to 256 sectors"


Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> 
> Changes since v1:
>    - keep a (large) upper limit on the I/O size.
> 
>   fs/btrfs/inode.c   | 6 +++++-
>   fs/btrfs/volumes.h | 7 +++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 33ba4d22e1430..f6dc6e8c54e3a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7592,8 +7592,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>   	const u64 data_alloc_len = length;
>   	bool unlock_extents = false;
>   
> +	/*
> +	 * Cap the size of reads to that usually seen in buffered I/O as we need
> +	 * to allocate a contiguous array for the checksums.
> +	 */
>   	if (!write)
> -		len = min_t(u64, len, fs_info->sectorsize);
> +		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_SECTORS);
>   
>   	lockstart = start;
>   	lockend = start + len - 1;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index b61508723d5d2..5f2cea9a44860 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -354,6 +354,13 @@ struct btrfs_fs_devices {
>   				- 2 * sizeof(struct btrfs_chunk))	\
>   				/ sizeof(struct btrfs_stripe) + 1)
>   
> +/*
> + * Maximum number of sectors for a single bio to limit the size of the
> + * checksum array.  This matches the number of bio_vecs per bio and thus the
> + * I/O size for buffered I/O.
> + */
> +#define BTRFS_MAX_SECTORS	256
> +
>   /*
>    * Additional info to pass along bio.
>    *
