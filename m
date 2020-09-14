Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E21268FC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgINPYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgINPX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 11:23:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA4C061788
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 08:23:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v123so432080qkd.9
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Sep 2020 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P88sZPJFN6pjg1/rBpYAr1dfE1xKLYR1psgTh/kSK58=;
        b=v2zsmXoaQHuKuTLSI56DmnLoufgGGU+J/f3LjvF4v34Q6KPI5HyPGTQ21jiSPhwAQ4
         lk9t/YRRXcRGIsRYd5083WF78DCqO1tKVw68gA8p5BbhvGBZGiMTEHDJ3cHeyO2qoQuF
         UOWzUWKkVpqbU0LjZYrd6/+nmJ/ecw3Hqz6SFnfWKqRClyuzq29c95lRUzEh9pkOtDk1
         5COpR0vOdB4Xt/6byyDqdU3Xa0lks2yq83AqLbGoWL8Vt7X/VL8aUQev5EqXuPloVd60
         sRD5pm3oXwf4sV8zGwzb+QoANX7JwaWE+fQaANGSx9dpQmUF/TDx81WZf+V6H2Ep+0MJ
         0AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P88sZPJFN6pjg1/rBpYAr1dfE1xKLYR1psgTh/kSK58=;
        b=X57exRgSjfgWa8E4GGOLPjEVsNB8oCxjXrOCV+Kye4GSEfSi2STXoUFUSBlUig2a05
         pLPAaXwBJHYaCDcVb8o/iIAOpOTez633q1JiO0rxI7ROYUB/X9ttN4J4hYJhzfnFYO9f
         RlWgXFQ/9+qk1UMAmQiebzgokErjBLtZTYHr2BYKbESq/TmgAm8M8TYjAgogw+OFWpEg
         rWDKAmXC+PeFx+an6o0isXMQZD2wjivyZI334mGLB8sdpA25iUcE2JjEXteYTSrrHG9s
         wqkvoLcOww7ni9N3dvUIeZo3+VRweeCM/xL+y+5eMOuKw4pTCIET8XPlSmi2fReDKiT9
         K4ZA==
X-Gm-Message-State: AOAM531XIvnEM3RtX+cJuDzjMPM3KFASVJFhnwjhloteoOcZvrXQhDGI
        /PZfjS7V1ZDCZvEW4CJvhLjjVkgFpbsWf2vG
X-Google-Smtp-Source: ABdhPJxML7P5UFyuwupKlgmXyBQeG9Wy/uhuMqnzQOUkcnJmkuMVG/chGT9OuwkebrxHYqRoM3c6dA==
X-Received: by 2002:a37:e211:: with SMTP id g17mr12791704qki.417.1600097004283;
        Mon, 14 Sep 2020 08:23:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::111c? ([2620:10d:c091:480::1:9b22])
        by smtp.gmail.com with ESMTPSA id f64sm5006681qkj.124.2020.09.14.08.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 08:23:23 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix wrong address when faulting in pages in the
 search ioctl
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8c2f5f20-3868-4291-5bed-b571c8ae61a0@toxicpanda.com>
Date:   Mon, 14 Sep 2020 11:23:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/14/20 4:01 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When faulting in the pages for the user supplied buffer for the search
> ioctl, we are passing only the base address of the buffer to the function
> fault_in_pages_writeable(). This means that after the first iteration of
> the while loop that searches for leaves, when we have a non-zero offset,
> stored in 'sk_offset', we try to fault in a wrong page range.
> 
> So fix this by adding the offset in 'sk_offset' to the base address of the
> user supplied buffer when calling fault_in_pages_writeable().
> 
> Several users have reported that the applications compsize and bees have
> started to operate incorrectly since commit a48b73eca4ceb9 ("btrfs: fix
> potential deadlock in the search ioctl") was added to stable trees, and
> these applications make heavy use of the search ioctls. This fixes their
> issues.
> 
> Link: https://lore.kernel.org/linux-btrfs/632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se/
> Link: https://github.com/kilobyte/compsize/issues/34
> Tested-by: A L <mail@lechevalier.se>
> Fixes: a48b73eca4ceb9 ("btrfs: fix potential deadlock in the search ioctl")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ioctl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5f06aeb71823..b91444e810a5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2194,7 +2194,8 @@ static noinline int search_ioctl(struct inode *inode,
>   	key.offset = sk->min_offset;
>   
>   	while (1) {
> -		ret = fault_in_pages_writeable(ubuf, *buf_size - sk_offset);
> +		ret = fault_in_pages_writeable(ubuf + sk_offset,
> +					       *buf_size - sk_offset);
>   		if (ret)
>   			break;
>   
> 

Eesh, can we get an xfstest for this?

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
