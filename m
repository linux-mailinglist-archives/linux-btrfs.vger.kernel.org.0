Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD36B39D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 10:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCJJON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 04:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjCJJNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 04:13:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA9E0619
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 01:08:38 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1qAzse322P-00aq4b; Fri, 10
 Mar 2023 10:08:22 +0100
Message-ID: <fa92c65c-fb11-938a-20a0-4e0d7965b3f3@gmx.com>
Date:   Fri, 10 Mar 2023 17:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 17/20] btrfs: don't check for uptodate pages in
 read_extent_buffer_pages
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-18-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gkEMVZrbACIYn+2vFu3E2OCkmTOO2PwEUtqKDX4fB4kkM6oAcYF
 2mXs3YYkNcu/dm4r6Wv0SwGk7T+Cjx3G9VqlBZ+Jkx/6ZyNAhcrT0E8EpID13v+kjPKI1Lz
 6M5Wnac4Ik2pMQdN1z/9hmGsTlImOo/svF0EVmlQsAp69cA7dWkH74aJnZCqkinK657dUfx
 nnDYEsEOA88VVtnzMHGkA==
UI-OutboundReport: notjunk:1;M01:P0:THfIGB9/mzU=;ILIlvuvc1GjMfSs7gAlop4VSayA
 BLyqkOXx27VAjbiPHuXYduRR5I1L4mBz04zOBUJPLCJRF8AI3eEGVe8s9LhSJoSr+uvBoRxm0
 IsXKYoPoig3WQKnOqz6hgABeL3AF+Mc9QoDH7lGA2oojhtW55g1YmTyzQi0BVqkRzmjPW3OO9
 FBa0NAtzEeFYirJLQ3qPLw9jXYOfH+qd4kDwI6kiyL+DjQFJw9KAyeynXX8pXygcMWQ5DsSme
 2d2Pjrlne+k/QkT6L9V1BuYyAWk71RaKamVhEl1M8eYnI3A8gHfdA+i6Uc9yGuF2+z80GD9vw
 xWepMAvd/T8SwvTy5NXwPILjX847u6zcXltUmU1XbXOrajU77+LfN4dawbiKmgeJD2gCKDUPG
 o+ZdS9l69297D2TEzL1uCw+zU96mDZiCihRlJJ3VFEVZtjkkmFWppHOujcpNMwVKlaEhx0AIc
 ez6ntsTI5SB8n6au4KlHsxnTqci2L2cdTvbIwh//+X2jhrbk62N806MFY6x4qpN32UeYuOzgg
 KjXxj3+8BRl2vjIKieCOenfbcbmie+er8ccSA6fZQZP4jFLKJ/zW0jlAMFImRN+brcJmasmND
 WkI8guxH3TahPJPEyH6pmGH5Yt495BdbO1iBERdkushPXjaoLmg1cOZvXb+dZL8AG4DT3xBgF
 EQ9Qr9nLsWdosQ+GuCkTfacHFAed4S7/aNLV2CpzW8fA9U9qXvIfCPFieJ3IFC/oTjSnmWysP
 hdWyhc0NlPJ8UMGTMOQ6fL7JfVAFMkPCHyGeTv3YuKjpUPvxdicOrqe8XDdMq4laUL6Ox33ad
 pqULx1M3l65Xqxec0v2CbV0m2L1iaJTHd5d8FWxQUEzY+0ClvN7IXH3BtGy6D/W7c8xZaF6AL
 QH1DuC+W6YmScOwXbR5+QOsiHVSGXHMNJxfyuQZCtIe6LMHTHRAyqULIfyfRQvWWYD2OFfUvr
 PSbzQA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> The only place that reads in pages and thus marks them uptodate for
> the btree inode is read_extent_buffer_pages.  Which means that either
> pages are already uptodate from an old buffer when creating a new
> one in alloc_extent_buffer, or they will be updated by ca call
> to read_extent_buffer_pages.  This means the checks for uptodate
> pages in read_extent_buffer_pages and read_extent_buffer_subpage are
> superflous and can be removed.

Can we rely completely on EXTENT_BUFFER_UPTODATE flag and getting rid of 
PateUptodate for metadata?

Or the PageUptodate would be shared by some other common routines like 
readahead?

Thanks,
Qu
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 88a941c64fc73f..73ea618282d466 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4138,10 +4138,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   			return ret;
>   	}
>   
> -	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
> -	    PageUptodate(page) ||
> -	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
> -		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> +	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)) {
>   		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
>   			      &cached_state);
>   		return 0;
> @@ -4168,7 +4165,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	int i;
>   	struct page *page;
>   	int locked_pages = 0;
> -	int all_uptodate = 1;
>   	int num_pages;
>   
>   	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> @@ -4203,21 +4199,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   		}
>   		locked_pages++;
>   	}
> -	/*
> -	 * We need to firstly lock all pages to make sure that
> -	 * the uptodate bit of our pages won't be affected by
> -	 * clear_extent_buffer_uptodate().
> -	 */
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -		if (!PageUptodate(page))
> -			all_uptodate = 0;
> -	}
> -
> -	if (all_uptodate) {
> -		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
> -		goto unlock_exit;
> -	}
>   
>   	__read_extent_buffer_pages(eb, mirror_num, check);
>   
