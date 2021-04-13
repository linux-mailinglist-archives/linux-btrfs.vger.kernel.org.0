Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9135E4F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Apr 2021 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhDMRZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Apr 2021 13:25:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47281 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232521AbhDMRZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Apr 2021 13:25:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F7CC5C0085;
        Tue, 13 Apr 2021 13:25:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 13 Apr 2021 13:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=FAxzhQis+VzV9EuRK6sBuAnym9g
        l5bJPLVFhKy7PrYc=; b=szxYHLzcBwBq9zApoa9+sFTJqxzBP/McWn5QbFp8NNE
        IRbzbidDyUzfVqgag70t527ZiyL0vrzWvKhodYD/rH8kBBaJ8aYTo6SCPD6mmam1
        RrbQ52b9mFh1swiFMAya7WupYbp5nS3J62T32XWsFJFucoNWtjYsQmI68E/VjV/u
        mgWPzIiZvwzYFh2hmGxXRZHBFHk4ZLS5Om7BDWaFUmJXud6tQIXhCo2H3sGMEWki
        iauHVjV0i0Re3pUU4kL5sERZ1Npxzm1xbxase+qHlTXM4PY/I21++t2Ztw8HtmjS
        VEKqI7U4h5/jmRFpcMSg6lj2pFrKHJ+0fNhQLm0VBMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FAxzhQ
        is+VzV9EuRK6sBuAnym9gl5bJPLVFhKy7PrYc=; b=LRDXE0WyZzif/OQ6WPaLAp
        AXMgVS5bzs1FJ3jek4+RPhcVCf/dMyleQXzrrhd18FJ1j0ukzvINWPLk4xBvmH6d
        sb72/nZrPpBhegYzl6mL17GmHfl5bRkufKBmWTGWiLBAp7sBpUBATaH1kUF6DvWq
        PURKmlGw8fSTPAc4Sao6FyITLy2xjWv0t9/TqI9EM0EnLpESHObEr08VN4Q7sd3V
        RFWRbvOk2LNNnvXXmlq+SeRKnXfs6/h3ynmMXmhamMggvPHD4DoqNZ8cBOzWvyc7
        68Ky7Nk8k/XXc1DRrICrFqqCcVjjqMG29vdTlZVB2ivCgPQf7iz9JZokwBRzMT7Q
        ==
X-ME-Sender: <xms:8NN1YC834B6lDKJcC-nbz3LTi8osr_McQCv6Juerkm-8K7l7ZjZrFQ>
    <xme:8NN1YCvVVYBgnqO5MsOb1c36_ndznz8Odd9ifdMtw0ZEVwa5C2t4BOUYLRcqWB2ez
    wkeWAniz9uKmtjM4wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucfk
    phepvddtjedrheefrddvheefrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:8NN1YIC9FIciUHrazurDGJoNeSNA-iOkHlT9fAUXL7fLpD03HY7uOA>
    <xmx:8NN1YKcb-RzT3C9F4PTpV1mnFmGfibMY7aaMzf3_rMQ0pv_oIhi4JA>
    <xmx:8NN1YHOUILFqBzOIf69P27WoVjC7fmzT4txw7yDIyxpeitpv3qwgdQ>
    <xmx:8dN1YMq08gAWupX5dEC6DREyOnanSFhBeDs0C9kHD-TNXsuuLf9G6A>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id EEEDE1080066;
        Tue, 13 Apr 2021 13:25:02 -0400 (EDT)
Date:   Tue, 13 Apr 2021 10:25:01 -0700
From:   Boris Burkov <boris@bur.io>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] fs/btrfs: Fix uninitialized variable
Message-ID: <YHXT4kIrs28daRER@zen>
References: <20210413130604.11487-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413130604.11487-1-khaledromdhani216@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 13, 2021 at 02:06:04PM +0100, Khaled ROMDHANI wrote:
> The variable zone is not initialized. It
> may causes a failed assertion.
> 
> Addresses-Coverity: ("Uninitialized variables")
> 
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index eeb3ebe11d7a..ee15ab8dccb5 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -136,7 +136,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
>   */
>  static inline u32 sb_zone_number(int shift, int mirror)
>  {
> -	u64 zone;
> +	u64 zone = 0;
>  
>  	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);

Thanks for the fix.

I assume this was dug up by coverity static analysis rather than hitting
it in a live system?

Since there is already an assert for the pre-condition 'mirror < max',
I feel like it would make sense to also add one for mirror > 0.

>  	switch (mirror) {
> -- 
> 2.17.1
> 
