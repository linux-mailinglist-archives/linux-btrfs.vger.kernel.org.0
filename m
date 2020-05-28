Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C681E665F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404504AbgE1Pk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 11:40:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404383AbgE1Pkz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 11:40:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SFbgUH058633;
        Thu, 28 May 2020 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2pZQ3FFFAjhEjYIl20+Oicz9Kd0LHzwCA2mYWurJ9Co=;
 b=mw7F3ed0l7QsC18U2hYst615+VY5wv+n1IvS6XsSiXADTx3GnSxzZuPBWvsgQ2sAHG3l
 idHxg64FnS84t5n87xlK0X7DpyO0TZfqKLxuFndm9BJ8FLX8bq6jdduPKCe9500lXWEw
 sD2JjEv5HjdxwO78opjX26lzv4MqYH6Wbcoaal2bUPAVFAKa8yYSebO1h4B54d9UkFWb
 RXBpBEjuAoYOd3TddCcrZoQvCWlaxBSlB8mD0pGZ03UbWXzZWDCTLzk8A8kvXQrdXJ8I
 YHD/k1K3+Np+gDkKf3We74rqhWRCShH/jktMiFQVPhDsXodf2nPDdIUu9cwMOCGnwjZE EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8r5rmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 15:40:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SFbdtV113870;
        Thu, 28 May 2020 15:40:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31a9ksq871-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 15:40:19 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04SFeG6Z008441;
        Thu, 28 May 2020 15:40:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 08:40:16 -0700
Date:   Thu, 28 May 2020 08:40:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org, dsterba@suse.cz,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/7] iomap: Remove lockdep_assert_held()
Message-ID: <20200528154014.GA8198@magnolia>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
 <20200522123837.1196-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522123837.1196-4-rgoldwyn@suse.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=1
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280107
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 22, 2020 at 07:38:33AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Filesystems such as btrfs can perform direct I/O without holding the
> inode->i_rwsem in some of the cases like writing within i_size.
> So, remove the check for lockdep_assert_held() in iomap_dio_rw()
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/iomap/direct-io.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f88ba6e7f6af..e4addfc58107 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -416,8 +416,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  
> -	lockdep_assert_held(&inode->i_rwsem);
> -

I could've sworn that I saw a reply from Dave asking to hoist this check
into all the /other/ iomap_dio_rw callers, but I can't find it and maybe
I just dreamed the whole thing.

Also, please cc fsdevel any time you make change to fs/iomap/, even if
we've already reviewed the patches.

--D

>  	if (!count)
>  		return 0;
>  
> -- 
> 2.25.0
> 
