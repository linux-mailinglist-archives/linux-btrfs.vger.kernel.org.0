Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8EA264881
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgIJO53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgIJO4s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:56:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F31C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:56:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so6344536qka.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dB7qrt80f9KC0Ac5GMXDKRV0rBQx1A6ayy12J3DhbaU=;
        b=YUjEq/SF2OCDq54al2m9fb7kYE3hqa/Eo8gunLJ9bT8/Z4wlJ4b+XdmeZOOycAnTRs
         MABCWbHSD+Q9miycpV53MW15eqX5vZcW7uAG7lnOKKORRY6/TggSuhgrO5GXfmjDmlTJ
         48SNQKb4h81rBB803q2ESN9fEGmDFzEexRFaaeb7ySPK7QrwUDIWDiJJzeeQoiXcGSi0
         N13XLIIHOoNp4/hXLiUKdSSNZ8HRaaIBBmc72YYzRPLUrK8yAuZnYw2LbqF6x1bj05q8
         jE0ckrcTcOGS4W15RV2hq6KxlJDBOE7r4w1ggat3OXeEB/u6Q1s3el+SF/eheB4RGdz8
         el5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dB7qrt80f9KC0Ac5GMXDKRV0rBQx1A6ayy12J3DhbaU=;
        b=AWpnZh7rZ6hIprwQwMdd2KvRuxIjBbJcsN6H28fvWaAraRMzr8TkcUX9Menyn8nkOH
         QDdodvYMRs2IX6jIrbeFZhiD02K7rZEsyRLRrGtjFCaMa5Ijqq2+x+WBgtsJZX7Ff+VE
         Npou+yYDHwHZMUCDFfz0p3rsgl/1K1t41N/duF2HpWdqd8bULpSho2bzYstFC2DkZ+tM
         8TSR/OdPlBO2Ud/jH6x1XPlvoGzeBU2it61uaMSYHbZWipglvxJ2+xuyj0cDfD6I7eWu
         PcpRlrk5ZLIFhuJELVGDcuaGYODvUJIGNAB3sIYTNMdqqh1yUwMPO22gSLWEL5CxVGlP
         lTrg==
X-Gm-Message-State: AOAM532IFKtFUXe9gF+12f274Eo2/k5M9q7andWPize7aSh9dPwzBQda
        DqNy0HlZPfIRYvEiMZNehqTdP8dGmR8Rkff+
X-Google-Smtp-Source: ABdhPJysO96CT1bmRX0RhoMULbWyM1Ye77kFIMNvfybwdNzKUENCgnK6u2YCLjknRQ/DOLfiABs04Q==
X-Received: by 2002:a37:6301:: with SMTP id x1mr6822914qkb.323.1599749805868;
        Thu, 10 Sep 2020 07:56:45 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e188sm6506676qkd.55.2020.09.10.07.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:56:45 -0700 (PDT)
Subject: Re: [PATCH 03/10] btrfs: Simplify metadata pages reading
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <09182e67-e5d4-cb10-a55c-537c4fbf9155@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:56:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:49 AM, Nikolay Borisov wrote:
> Metadata pages currently use __do_readpage to read metadata pages,
> unfortunately this function is also used to deal with ordinary data
> pages. This makes the metadata pages reading code to go through multiple
> hoops in order to adhere to __do_readpage invariants. Most of these are
> necessary for data pages which could be compressed. For metadata it's
> enough to simply build a bio and submit it.
> 
> To this effect simply call submit_extent_page directly from
> read_extent_buffer_pages which is the only callpath used to populate
> extent_buffers with data. This in turn enables further cleanups.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/extent_io.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ac92c0ab1402..1789a7931312 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5575,20 +5575,14 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>   			}
>   
>   			ClearPageError(page);
> -			err = __extent_read_full_page(page,
> -						      btree_get_extent, &bio,
> -						      mirror_num, &bio_flags,
> -						      REQ_META);
> +			err = submit_extent_page(REQ_OP_READ | REQ_META, NULL,
> +					 page, page_offset(page), PAGE_SIZE, 0,
> +					 &bio, end_bio_extent_readpage,
> +					 mirror_num, 0, 0, false);
>   			if (err) {
>   				ret = err;
> -				/*
> -				 * We use &bio in above __extent_read_full_page,
> -				 * so we ensure that if it returns error, the
> -				 * current page fails to add itself to bio and
> -				 * it's been unlocked.
> -				 *
> -				 * We must dec io_pages by ourselves.
> -				 */

I'd rather change the comment to indicate that we failed to submit the bio, thus 
the page is our responsibility to clean up, and thus we need to do the 
error/unlock and io_pages dance.  Thanks,

Josef
