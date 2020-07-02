Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE321246D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgGBNTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBNTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:19:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2591C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:19:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b185so14945723qkg.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1JPIsEEGkkXaJe6PijWi1PBXs42CN34+tX9K4lxtor4=;
        b=HHaRvnS8MlnvjrooPyFJRvITPqs33uSIqdrpW15eVxe4AlxdKc8d39Lz9yj1xwIzmF
         m7D6bt/StDfB+8KzVS5bMwsfNxHidfgEaPlV9vBqS5gjQdg3IXUjcBLdVIzlMWIl7FsB
         Zdx5DqVUTQwodERYodeyX2+AWJs4XnvZMXThzQpR5G+OLbU2F67SQLxiepqWZM2mP5w4
         YNP+biGbeFXJPkQn+A8KBN/sX3uqT1j79BEYEN/uTKYNZ16qEWNNSmkjDjyccRqFJC4E
         LxyRcfPIZAamUgwFx7lgOoJc3E4uMQ3bbn9D0mwgrrLw8C1fPcryFHQCkYMw/hMamGZv
         LghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JPIsEEGkkXaJe6PijWi1PBXs42CN34+tX9K4lxtor4=;
        b=cp9TjvGUg3bNJvS07PT+FQIYa1ji/dj6i465KLfgRXjb+5W2thp8nIMo0xTnQzw/1O
         5tGaGfBwWRAWnBO03PWhvjXBCue1R4n+XHLcEHpQwQmUOYF4dQaUkLiRUtLyvnfYp8RR
         fmXFKIuf3lQiQ/d9d+5Flf4+0OJp1rtMhFj6Ts+qNUuVzhOJAEPitHoTtcQsvqIznOwd
         3LSa2RJvLcmmNeviunGDP4d9bQJQI4yH/exnuSDkVGs5wvAD0N04aWSWLjgw1vkffocm
         iNSHQ5FKgd8Ks24SSKws1/jkJcJNQ2EXA8SbRygVxX26kZ307v8TT8Mik8woAPyf+MLP
         oG9A==
X-Gm-Message-State: AOAM531kgRY6f4EP73p1zU11HAWF2VPATnTBGX8idwtt1ncBNcQwOv4z
        W0VdYIzbHEkj06l82HTGjXHfbyEFJxhFAg==
X-Google-Smtp-Source: ABdhPJxkI4JbL+OmSkEM139NZ62BgHESbzaA/tkhDEg67TH1Txn16kv586SXaEvWRXFwj9LJUt2fSA==
X-Received: by 2002:a37:4592:: with SMTP id s140mr29378453qka.245.1593695955454;
        Thu, 02 Jul 2020 06:19:15 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s52sm8429322qtj.52.2020.07.02.06.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:19:14 -0700 (PDT)
Subject: Re: [PATCH 6/8] btrfs: Remove needless ASSERT
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-7-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1883c39a-90c6-7888-23f3-8a14b9000c22@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:19:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-7-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> compressed_bio::orig_bio is always set in btrfs_submit_compressed_read
> before any bio submission is performed. Since that function is always
> called with a valid bio it renders the ASSERT unnecessary.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/compression.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index c2d5ca583dbf..db80c3fa6c08 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -244,7 +244,6 @@ static void end_compressed_bio_read(struct bio *bio)
>   	 * Record the correct mirror_num in cb->orig_bio so that
>   	 * read-repair can work properly.
>   	 */
> -	ASSERT(btrfs_io_bio(cb->orig_bio));
>   	btrfs_io_bio(cb->orig_bio)->mirror_num = mirror;
>   	cb->mirror_num = mirror;
>   
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
