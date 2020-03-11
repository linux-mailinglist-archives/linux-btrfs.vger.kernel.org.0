Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033DE18201A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgCKR4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:56:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38621 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgCKR4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:56:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so2969989qke.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pJNQewbYcpI6mbgzGhgTH71DFFTmaYHJfTwIVwXPu8g=;
        b=iFiRtrvmWfZ9+sIDcbd5+zxCeCWCNPbCpS2+911qoOln5LPnZBVXy7sakEKdBKDh8N
         J5huTztKx/7Y2rKAEFOqtAlUMVAKOVlLKjrHuFrgwf3sE6sj8qHmeKq6r3GpfbVmmEuQ
         aZ+pBkjzGEM5xAyaAj8AXh4ceBPYgaCrpHix+sJ0on9donBemGvTGFfJOJN7ZwOLuW81
         UB89+vuI4Yh88wF+C9nA2vWTHPCWxouFUrISyhTV02wAH6wkav3w5+YhO643/Sa3p9mL
         K0sxPgoqpPpzuZ916v0PNgq2NSjchRugc9tvm7pSixVD85fxYYE9rJjjQI9FIJlzX94H
         V5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJNQewbYcpI6mbgzGhgTH71DFFTmaYHJfTwIVwXPu8g=;
        b=dsPoO9VnTMH7VB/MXPO/h2MdnffCVoB8UlCt5nOempIpXy0ouSsKKgerUAl64RTRku
         g1UjOmRfrXprEqXwT/qJZjp6+rw5rFkHtqOI+RtlmTcgU+mKeSMQ8XVQldMsV0Xvrl1p
         cn07MYXjeHz84/l5QKZFkIJGaL4FwMTl0ixInPaHjel0ibEU0xmAmH7Znxc84ga/zg8M
         2rEWn6hK8Qlv0Oxz2bVIplF2TPnWYT+6G35jVkdsY+ZSiAtqdp+lJKe9UmV3KaebJ2N4
         fdS1pcwM+d5bCIJxCzsy78gPBA4Q/11DciwczJKiNep6fwRe36HrjKaI9YEn4a1cQLu0
         SrWw==
X-Gm-Message-State: ANhLgQ2MLuPb/6NVXnev/w0w+yC9SSrkFsZgyKOJe9360HHDjO6zSHc/
        j10CTdSvEQuhB00mSSBgnAzqvA==
X-Google-Smtp-Source: ADFU+vtrKyvEm4uklp5LFvDd+L5p7UHQ/RTlWQNiipBWbYKeDB43oQ+n1ur8qOP0RKkyhWXfftUlGA==
X-Received: by 2002:a37:a057:: with SMTP id j84mr3984517qke.108.1583949406311;
        Wed, 11 Mar 2020 10:56:46 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d137sm19933766qkc.99.2020.03.11.10.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:56:45 -0700 (PDT)
Subject: Re: [PATCH 05/15] btrfs: clarify btrfs_lookup_bio_sums documentation
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <2ee5f090b52dc23569bf94a5a2609dfc49ac4a4b.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a7522f01-8aad-bdcc-4576-4c73d7719bc9@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:56:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2ee5f090b52dc23569bf94a5a2609dfc49ac4a4b.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Fix a couple of issues in the btrfs_lookup_bio_sums documentation:
> 
> * The bio doesn't need to be a btrfs_io_bio if dst was provided. Move
>    the declaration in the code to make that clear, too.
> * dst must be large enough to hold nblocks * csum_size, not just
>    csum_size.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/btrfs/file-item.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 6c849e8fd5a1..fa9f4a92f74d 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -242,11 +242,13 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>   /**
>    * btrfs_lookup_bio_sums - Look up checksums for a bio.
>    * @inode: inode that the bio is for.
> - * @bio: bio embedded in btrfs_io_bio.
> + * @bio: bio to look up.
>    * @offset: Unless (u64)-1, look up checksums for this offset in the file.
>    *          If (u64)-1, use the page offsets from the bio instead.
> - * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
> - *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
> + * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
> + *       checksum (nblocks = bio->bi_iter.bi_size / sectorsize). If NULL, the
> + *       checksum buffer is allocated and returned in btrfs_io_bio(bio)->csum
> + *       instead.
>    *
>    * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
>    */
> @@ -256,7 +258,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	struct bio_vec bvec;
>   	struct bvec_iter iter;
> -	struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
>   	struct btrfs_csum_item *item = NULL;
>   	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>   	struct btrfs_path *path;
> @@ -277,6 +278,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>   
>   	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
>   	if (!dst) {
> +		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
> +

Looks like you have some extra changes in here?

Josef
