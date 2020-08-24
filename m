Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3659E25070A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHXR51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgHXR5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:57:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13193C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:57:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so6832837qtm.10
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pfHqfcJoh7NwydFXCDDvp+Qm8dM//7KjuHgjqMAgk24=;
        b=Bxwh1OkqrkG9vqKdqDgMzpEudLHzjgsU4laz6Ku6V/wf9soGv7L3YPfydnottjJt4K
         FRdUTrK2WxHUa7+xvQhonTo5VXZP1CrUv2ndiZ/0E2+Po5AK808PNheVslseT1z6xm0b
         qK9ILN24Ptjkz2irK/NNL0d3MBkghj2cEJg925RVd22/FniLu1LB6gKQy3cRilkCJ+A9
         q266mEGTuTCRMbxYzirDDVD44AOV1/caR5b+LHs/6qCBFI+X+yKyk1HVr6ptuus4Ln9D
         DZWkg/q7mW9CMwTSuaUYG3Za/2sDZv5gtRD7313sIDKo4xesMB9gTUotk2rvt3zXcrfh
         B0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pfHqfcJoh7NwydFXCDDvp+Qm8dM//7KjuHgjqMAgk24=;
        b=qtNYc/JIq6W9apHLY86/4KZjVd4h9tki7AFjmcH4sPHde5FHey8W004yyf9IcDsXsR
         C7iO+ApaGEUQ/0+05gnGUjR3G8ZmuEGlJBUop/IAhZsjLiMdXbuttlsrc/ZtX3aBXzSS
         r4Vo46xAjKQxXECF+e3QrhClaLu8KPDDm7jVyLGAlMQfNMXgt43EqPDiIqQ0fFXD2cq+
         /x0wUl5Ya7552EV0svS4dYGJKhtI1G+wFhQSBZJeWOC81LNks18jQ+83asXgeXxv30va
         iMFVWiD0mwbPOudxrmqRz33Wc64VsdF/7K6VFwbYRriSBqJzvZF/vYdp09j1AWY325zs
         Ucpw==
X-Gm-Message-State: AOAM532I6GDLNrIi2SY0BhclTyijwqr8oFHeCB29BJR+mzbGaGp2loya
        uTxz096RiV/M0vQbZ9IWVmhXsnQ9wYpVhEHW
X-Google-Smtp-Source: ABdhPJwo8GZO/xch6KTtdlxty7JGIocvkmjC3c5w4Ipx+tcSIaK+BRxo7VEcugoj8Xvy47ievMuz5g==
X-Received: by 2002:ac8:2f2c:: with SMTP id j41mr6082112qta.258.1598291844103;
        Mon, 24 Aug 2020 10:57:24 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t1sm10020793qkt.119.2020.08.24.10.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:57:23 -0700 (PDT)
Subject: Re: [PATCH 6/9] btrfs: send: write larger chunks when using stream v2
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
 <eebf24d3b42ef50a19ba9bc38ed5210d0cc87157.1597994106.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a5cafc52-a278-d51c-92fc-6b52b88147e7@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:57:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <eebf24d3b42ef50a19ba9bc38ed5210d0cc87157.1597994106.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The length field of the send stream TLV header is 16 bits. This means
> that the maximum amount of data that can be sent for one write is 64k
> minus one. However, encoded writes must be able to send the maximum
> compressed extent (128k) in one command. To support this, send stream
> version 2 encodes the DATA attribute differently: it has no length
> field, and the length is implicitly up to the end of containing command
> (which has a 32-bit length field). Although this is necessary for
> encoded writes, normal writes can benefit from it, too.
> 
> For v2, let's bump up the send buffer to the maximum compressed extent
> size plus 16k for the other metadata (144k total). Since this will most
> likely be vmalloc'd (and always will be after the next commit), we round
> it up to the next page since we might as well use the rest of the page
> on systems with >16k pages.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/btrfs/send.c | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index e25c3391fc02..c0f81d302f49 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4799,14 +4799,27 @@ static u64 max_send_read_size(struct send_ctx *sctx)
>   
>   static int put_data_header(struct send_ctx *sctx, u32 len)
>   {
> -	struct btrfs_tlv_header *hdr;
> +	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
> +		__le16 tlv_type;
> +
> +		if (sctx->send_max_size - sctx->send_size <
> +		    sizeof(tlv_type) + len)
> +			return -EOVERFLOW;
> +		tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
> +		memcpy(sctx->send_buf + sctx->send_size, &tlv_type,
> +		       sizeof(tlv_type));
> +		sctx->send_size += sizeof(tlv_type);

Can we add a comment for implied length thing here?  I was reviewing this in 
vimdiff without the commit message so missed the implied length detail.  Thanks,

Josef
