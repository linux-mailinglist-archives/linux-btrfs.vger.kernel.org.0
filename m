Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE34316606A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBTPFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:05:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44840 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgBTPFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:05:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id j23so3044852qtr.11
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R7MHs7TlxXq5gs2REyfBkCI5XXcRajjHFZu2o+s6uKM=;
        b=itxNBePbYqeRG/c04IgbDBirVryHz9IPnIdpkz2Vkn3fOWqcDkCRjMKeevOi12EjJ5
         awmFLCDvL4b9EZAvX0mqqNCByItpzMREthnE+Y0btir53PwRU+vOZwBckP3tBs2IM0F0
         r95oNd8CMKUCmjdEvFRkJeJ3PbMP2OHvS1uFESksq/RMG7ChOqAshG9TnNlk2hwcIZ6z
         ZQLxYwWoMnTp8NUFdxRqhhRbww5GDeVqLhnMYd4Eix3oFlJad6k6B+is+IHVGxF0fwy+
         WeJtZxtskYeZZlzw/VzzWN2rUXUO/oMwp8bNnGsWIaNc+hri9RKN7sRJ5bM6M//h4Ur3
         tBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R7MHs7TlxXq5gs2REyfBkCI5XXcRajjHFZu2o+s6uKM=;
        b=gExaq3jnhk4p1KWzxLhV5Bu2gcHA0OxRgZjyCoD7KObilkpXBTa5gvI6XIT+zTEzVR
         8x+uYA11DQI6sW886HvBGLm/Xzo5lBJyqv9A1BO/pBZKzeNYumyQU6Pps1TK/TODpiU5
         XK6sMJP17XiZzb+bKLhtjo/zbMvk/7EO8uxFH2XdF+xKBKQ+M3pvJ8qH0LrkFhYckXk1
         L8ppYVrYExf7ZKZW2WlRvFQi3KjWTgGPg9bH0156MaPegdsGk04aTQ5ByHS2EBXFdA2Z
         LPrOKpaRY984ZIMF42kGxD0ABVk8Aji2uOyl0GXryPu4STGGa92jKEcOiTODP/Choibx
         ic2w==
X-Gm-Message-State: APjAAAUQ+nvuTVMimLKOoIwdsnMlKcw0IKJpx8Bu9PboNGj/77N+nuCu
        SCN7q7kba03l6V8bLtK8AunIcQ==
X-Google-Smtp-Source: APXvYqwaSAn8xbgowQ8SYHZdyUcjBV+Y+KskbavNfVmvWv+N2NDD68tAj4hEpM8B+t5FlVPRnZ7bzQ==
X-Received: by 2002:ac8:cb:: with SMTP id d11mr27136594qtg.22.1582211129127;
        Thu, 20 Feb 2020 07:05:29 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h6sm1888289qtr.33.2020.02.20.07.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:05:28 -0800 (PST)
Subject: Re: [PATCH v4 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200218065649.126255-1-wqu@suse.com>
 <20200218065649.126255-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8e5a2584-3c5f-e73c-522e-98543ff0e3ad@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:05:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218065649.126255-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/20 1:56 AM, Qu Wenruo wrote:
> Due to the complex nature of btrfs extent tree, when we want to iterate
> all backrefs of one extent, it involves quite a lot of work, like
> searching the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed
> backrefs.
> 
> Normally this would result pretty complex code, something like:
>    btrfs_search_slot()
>    /* Ensure we are at EXTENT_ITEM/METADATA_ITEM */
>    while (1) {	/* Loop for extent tree items */
> 	while (ptr < end) { /* Loop for inlined items */
> 		/* REAL WORK HERE */
> 	}
>    next:
>    	ret = btrfs_next_item()
> 	/* Ensure we're still at keyed item for specified bytenr */
>    }
> 
> The idea of btrfs_backref_iter is to avoid such complex and hard to
> read code structure, but something like the following:
> 
>    iter = btrfs_backref_iter_alloc();
>    ret = btrfs_backref_iter_start(iter, bytenr);
>    if (ret < 0)
> 	goto out;
>    for (; ; ret = btrfs_backref_iter_next(iter)) {
> 	/* REAL WORK HERE */
>    }
>    out:
>    btrfs_backref_iter_free(iter);
> 
> This patch is just the skeleton + btrfs_backref_iter_start() code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
