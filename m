Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2196B1227BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfLQJb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 04:31:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQJb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 04:31:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBH9OXrW187603;
        Tue, 17 Dec 2019 09:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4QXMNWLgrmfAb/HFVYpcY+5mUbXbBD2zgjGgUWf0UiU=;
 b=by4jb7IEbjwh0cK+Kz7AxznhlS4PzTyJPkkdT3vFE19zUYintOLb4fp/1FlnwO6p1wh8
 /5Jj0ck8EUF6ZkOIkwq0sedcDs/rhB5mEK+p1OENAB+42q7Luke5xCmXkXZv2PhdG61c
 n9ED0nX3r+8NjKCtMu3cbKbI0SbDturcZyVzcwWnNN/217cJpKzwGh0pqkb2w77geuur
 +LxkTDtvQ6YqEsV7ppG0csiP26CnmjddFoUWtkOMXDaJZtB/I6ligEzqbURHv8y/lU07
 Vgy19HLH91DZD4frG3PaEr9cyhd7nqMUwNoEbnpve3WgRv7AktEjbk+dwkWaJ58nDoyE bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wvrcr57pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 09:31:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBH9SjuA050258;
        Tue, 17 Dec 2019 09:31:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wxm4vcka5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 09:31:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBH9VNWb026277;
        Tue, 17 Dec 2019 09:31:23 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 01:31:22 -0800
Subject: Re: [PATCH] btrfs: use helper to zero end of last page
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20191216185038.14913-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4ca3c941-c3c0-2128-e206-01a9eb96953e@oracle.com>
Date:   Tue, 17 Dec 2019 17:31:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191216185038.14913-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912170083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9473 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912170083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/12/19 2:50 AM, David Sterba wrote:
> The zero_user_segment is open coded in several places, we should use the
> helper. btrfs_page_mkwrite uses kmap/kunmap but replacing them by
> _atomic variants is not a problem as they're more restrictive than
> required.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/compression.c | 15 ++-------------
>   fs/btrfs/extent_io.c   | 39 +++++++--------------------------------
>   fs/btrfs/inode.c       | 10 +++-------
>   3 files changed, 12 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index ed05e5277399..299fcfdfb10f 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -602,19 +602,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   		}
>   		free_extent_map(em);
>   
> -		if (page->index == end_index) {
> -			char *userpage;
> -			size_t zero_offset = offset_in_page(isize);
> -
> -			if (zero_offset) {
> -				int zeros;
> -				zeros = PAGE_SIZE - zero_offset;
> -				userpage = kmap_atomic(page);
> -				memset(userpage + zero_offset, 0, zeros);
> -				flush_dcache_page(page);
> -				kunmap_atomic(userpage);
> -			}
> -		}
> +		if (page->index == end_index)
> +			zero_user_segment(page, offset_in_page(isize), PAGE_SIZE);
>   

  Before we zero-ed only when the page offset is not starting at 0.
  Can you confirm and update the change log if that is ok.


>   		ret = bio_add_page(cb->orig_bio, page,
>   				   PAGE_SIZE, 0);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 394beb474a69..d6b3af7f1675 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3093,31 +3093,18 @@ static int __do_readpage(struct extent_io_tree *tree,
>   		}
>   	}
>   
> -	if (page->index == last_byte >> PAGE_SHIFT) {
> -		char *userpage;
> -		size_t zero_offset = offset_in_page(last_byte);
> -
> -		if (zero_offset) {
> -			iosize = PAGE_SIZE - zero_offset;
> -			userpage = kmap_atomic(page);
> -			memset(userpage + zero_offset, 0, iosize);
> -			flush_dcache_page(page);
> -			kunmap_atomic(userpage);
> -		}
> -	}
> +	if (page->index == last_byte >> PAGE_SHIFT)
> +		zero_user_segment(page, offset_in_page(last_byte), PAGE_SIZE);
> +

  Here also.

Thanks, Anand

>   	while (cur <= end) {
>   		bool force_bio_submit = false;
>   		u64 offset;
>   
>   		if (cur >= last_byte) {
> -			char *userpage;
>   			struct extent_state *cached = NULL;
>   
> +			zero_user_segment(page, pg_offset, PAGE_SIZE);
>   			iosize = PAGE_SIZE - pg_offset;
> -			userpage = kmap_atomic(page);
> -			memset(userpage + pg_offset, 0, iosize);
> -			flush_dcache_page(page);
> -			kunmap_atomic(userpage);
>   			set_extent_uptodate(tree, cur, cur + iosize - 1,
>   					    &cached, GFP_NOFS);
>   			unlock_extent_cached(tree, cur,
> @@ -3202,14 +3189,9 @@ static int __do_readpage(struct extent_io_tree *tree,
>   
>   		/* we've found a hole, just zero and go on */
>   		if (block_start == EXTENT_MAP_HOLE) {
> -			char *userpage;
>   			struct extent_state *cached = NULL;
>   
> -			userpage = kmap_atomic(page);
> -			memset(userpage + pg_offset, 0, iosize);
> -			flush_dcache_page(page);
> -			kunmap_atomic(userpage);
> -
> +			zero_user_segment(page, pg_offset, pg_offset + iosize);
>   			set_extent_uptodate(tree, cur, cur + iosize - 1,
>   					    &cached, GFP_NOFS);
>   			unlock_extent_cached(tree, cur,
> @@ -3564,15 +3546,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>   		return 0;
>   	}
>   
> -	if (page->index == end_index) {
> -		char *userpage;
> -
> -		userpage = kmap_atomic(page);
> -		memset(userpage + pg_offset, 0,
> -		       PAGE_SIZE - pg_offset);
> -		kunmap_atomic(userpage);
> -		flush_dcache_page(page);
> -	}
> +	if (page->index == end_index)
> +		zero_user_segment(page, pg_offset, PAGE_SIZE);
>   
>   	set_page_extent_mapped(page);
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f27377d8ec55..24337de25a8b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8308,7 +8308,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	struct btrfs_ordered_extent *ordered;
>   	struct extent_state *cached_state = NULL;
>   	struct extent_changeset *data_reserved = NULL;
> -	char *kaddr;
>   	unsigned long zero_start;
>   	loff_t size;
>   	vm_fault_t ret;
> @@ -8414,12 +8413,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	else
>   		zero_start = PAGE_SIZE;
>   
> -	if (zero_start != PAGE_SIZE) {
> -		kaddr = kmap(page);
> -		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
> -		flush_dcache_page(page);
> -		kunmap(page);
> -	}
> +	if (zero_start != PAGE_SIZE)
> +		zero_user_segment(page, zero_start, PAGE_SIZE);
> +
>   	ClearPageChecked(page);
>   	set_page_dirty(page);
>   	SetPageUptodate(page);
> 

