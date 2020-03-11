Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3FD1820DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgCKSeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:34:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40878 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgCKSeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:34:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so3089544qka.7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNJznAoMVOQ8MtJEOziZO0FjxnEh5OzEFuxUs4Lnc/4=;
        b=yLgZMb4Noinil3cpIDzoiEYHH3Otui87IDNeCdNXwkgI1WOlR+cgUNl8e4BKO6qHAP
         WuwVrHHZruoxFEVYE62ngP/eswvpyFc3sELL5qvb9MElglQ4gAFmzwlZOZM4Nyt7obXQ
         vaq9hr0MM71kE+8UkgnPjg18sZrqwxt2W1IRC69oqFXuWz37twM6kjQEpVkVhJkQE1ph
         dIUdNG210Mx+lQfBidYXZMrHzlHoS6q+aCabTU8/Jpa857j1MshmwOAWw6QVTasdZ1gX
         hZZ1Mj/cIKpuLe3tyEWlxqyvuqScH8gyITCIdlJ0NjXw1xKTVsX2oq3HTopnxQ30v8Qr
         iGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNJznAoMVOQ8MtJEOziZO0FjxnEh5OzEFuxUs4Lnc/4=;
        b=VJDkXnZmfnZB72cUfADeGLF+L7nJMZcjTb11KM0G1rHTsedLMEkGolWXN92hv0kjDI
         7l4CprW28j4JhUKvIC+34c71k0Z6UrXxfVVJzaKuY+SDCNbMbYzz6/J3XR4VKR9G8dem
         /COabh2bs1Nvj1MnyOHuST7BeW2p83xypl6lqRpi7/qSwwN0+Om+k5m4alwewaOxGElJ
         Tz8wqyWHUYd2juY0Tv2CfJA0GKdGTCgZoDQptLQMzDSt12eQSFQcuWSFca7aFpHqDS57
         c/WxNQlgj8UbNORnfTVYtFVlqCXZfJN0k3HbDtMHoQ6vFzUj4pOS0LM4DADR+8WqEMVJ
         apPg==
X-Gm-Message-State: ANhLgQ3SWfBvRiYxWAnRjXtZBXjDgeNS0Bt1bKydMYHZQTrZQ6qjeOHG
        o1Su+5v2cCJuI7H0CCBkC5jK0WhOmsE=
X-Google-Smtp-Source: ADFU+vuSPIs1zjLQwrjjJZqNrGrjVhORHzTbRQQK5NYP2x+Xuri9eksW+pgnawE4BjAoT4Wafjnwcg==
X-Received: by 2002:a05:620a:1092:: with SMTP id g18mr4057925qkk.80.1583951649319;
        Wed, 11 Mar 2020 11:34:09 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o14sm6229893qtq.12.2020.03.11.11.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:34:08 -0700 (PDT)
Subject: Re: [PATCH 05/15] btrfs: clarify btrfs_lookup_bio_sums documentation
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <2ee5f090b52dc23569bf94a5a2609dfc49ac4a4b.1583789410.git.osandov@fb.com>
 <a7522f01-8aad-bdcc-4576-4c73d7719bc9@toxicpanda.com>
 <20200311182325.GA296369@vader>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5b647dbd-ba6a-4428-1780-6045b13821e1@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:34:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311182325.GA296369@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/11/20 2:23 PM, Omar Sandoval wrote:
> On Wed, Mar 11, 2020 at 01:56:44PM -0400, Josef Bacik wrote:
>> On 3/9/20 5:32 PM, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> Fix a couple of issues in the btrfs_lookup_bio_sums documentation:
>>>
>>> * The bio doesn't need to be a btrfs_io_bio if dst was provided. Move
>>>     the declaration in the code to make that clear, too.
>>> * dst must be large enough to hold nblocks * csum_size, not just
>>>     csum_size.
>>>
>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>> ---
>>>    fs/btrfs/file-item.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>> index 6c849e8fd5a1..fa9f4a92f74d 100644
>>> --- a/fs/btrfs/file-item.c
>>> +++ b/fs/btrfs/file-item.c
>>> @@ -242,11 +242,13 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>>>    /**
>>>     * btrfs_lookup_bio_sums - Look up checksums for a bio.
>>>     * @inode: inode that the bio is for.
>>> - * @bio: bio embedded in btrfs_io_bio.
>>> + * @bio: bio to look up.
>>>     * @offset: Unless (u64)-1, look up checksums for this offset in the file.
>>>     *          If (u64)-1, use the page offsets from the bio instead.
>>> - * @dst: Buffer of size btrfs_super_csum_size() used to return checksum. If
>>> - *       NULL, the checksum is returned in btrfs_io_bio(bio)->csum instead.
>>> + * @dst: Buffer of size nblocks * btrfs_super_csum_size() used to return
>>> + *       checksum (nblocks = bio->bi_iter.bi_size / sectorsize). If NULL, the
>>> + *       checksum buffer is allocated and returned in btrfs_io_bio(bio)->csum
>>> + *       instead.
>>>     *
>>>     * Return: BLK_STS_RESOURCE if allocating memory fails, BLK_STS_OK otherwise.
>>>     */
>>> @@ -256,7 +258,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>>>    	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>>    	struct bio_vec bvec;
>>>    	struct bvec_iter iter;
>>> -	struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
>>>    	struct btrfs_csum_item *item = NULL;
>>>    	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>>>    	struct btrfs_path *path;
>>> @@ -277,6 +278,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>>>    	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
>>>    	if (!dst) {
>>> +		struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
>>> +
>>
>> Looks like you have some extra changes in here?
> 
> I mentioned it in the commit message: "Move the declaration in the code
> to make that clear". It looks weird to document that the bio only needs
> to be a btrfs_io_bio if dst == NULL and then always get the btrfs_bio,
> even if we don't use it.
> 

Apparently I can't read multi-sentence bullet points.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
