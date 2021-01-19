Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10BB2FC26C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbhASVfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbhASV2K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:10 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0CC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:27:28 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o18so5197912qtp.10
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jPCEWf56BAvi2yKBOhtUa6ftBhfyYzu2lNMvfc/uqNg=;
        b=Is3IyTFbDJsYh0hPMc4tS5RYB5tBEjlnduDABbTIMRsoxCczx5EA5ZSi/+jvZDZ5t/
         ZuBeqATRMtsOK1oeRpsSImKhetqr761HZU+BMChKiNiqT7VZma08RWD8LghAkpbOsfQ3
         ng/ocdBARRMJhxQdne8A14ny2yAxOKhQ0enSpB6ZGxDC5rcCw6H+YISI9zP7/7s8Rdqc
         xGCCKUeAi7cQ8qisiEmSG0tEzaKePiDvMorsPKHMyfCibUVeS79WUVxREhD/lFyiaYnV
         EpjzZfQTA4ZF27GJI1/LN/MprpMwQkFx2c3PV5lYA2mELUTwC5qGinHiYM43yT8vfawx
         ybmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPCEWf56BAvi2yKBOhtUa6ftBhfyYzu2lNMvfc/uqNg=;
        b=odoAsx1vwjD4qyqZosvEdjjXDfjkFFrir1i0pT8EymWi3WzGclVaIoFAj2F65MD4EF
         /ZTEMJDJaTJxRG5Mlch/w6Pg1xFCkPxYciMivjAzHhVaXjP3/uD5redXwNJ6OEaDCjAf
         9nkqc7uGEnUPNU8y3Fu1MwXBcjjBOxBanOp5Roa6Npt2aADaEAQKZeACe6Jp8z7809o9
         L9jUhLiMmlCVHtkuEIFGou5q3mGHOvUrBFBIn+vacHZPGx7WwzVU/X4dTxlE5b0stqh9
         fymF0Zrct8uLUGaJ/C/EKI7Fi9odNj1RDQXqpWkeOtcM83lxwcvMmQAwX6f+OBUvKbfi
         kXDw==
X-Gm-Message-State: AOAM530VFh/X1CY3BmMn+9386oFs70qG2IG/sUy2ovKGZPSUW7b+8Ss5
        wwFHCrBDHd/andy1DZhZH7/ios/ur/G54zNRxl0=
X-Google-Smtp-Source: ABdhPJyqU6AEmNnHMp4nLqcOTxg5Oeciy19ae0JJVvojA8UVfBI8OuCA0a6BJ8ugZTggG8rmVWdltw==
X-Received: by 2002:ac8:524f:: with SMTP id y15mr6268585qtn.266.1611091647421;
        Tue, 19 Jan 2021 13:27:27 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id 9sm13495202qtr.64.2021.01.19.13.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:27:26 -0800 (PST)
Subject: Re: [PATCH 01/13] btrfs: Document modified paramater of
 add_extent_mapping
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210119122649.187778-1-nborisov@suse.com>
 <20210119122649.187778-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8a5502f3-be55-897a-c987-f1ec57efedc8@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:27:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119122649.187778-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/19/21 7:26 AM, Nikolay Borisov wrote:
> Fixes fs/btrfs/extent_map.c:399: warning: Function parameter or member
> 'modified' not described in 'add_extent_mapping'
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/extent_map.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index bd6229fb2b6f..aa1ff6f2ade9 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -388,6 +388,8 @@ static void extent_map_device_clear_bits(struct extent_map *em, unsigned bits)
>    * add_extent_mapping - add new extent map to the extent tree
>    * @tree:	tree to insert new map in
>    * @em:		map to insert
> + * @modified:	bool indicating whether the given @em should be added to the
> + *	        modified list, which indicates the extent needs to be logged
>    *
>    * Insert @em into @tree or perform a simple forward/backward merge with
>    * existing mappings.  The extent_map struct passed in will be inserted
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series once you fix up those two spelling mistakes.  Thanks,

Josef
