Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5286166071
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgBTPHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:07:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36268 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbgBTPHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:07:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id t83so3856144qke.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUSW77EmT9F+lIor+VQ1fdeNfl9AmiAT10sz0QfXrEw=;
        b=0keusj6LETtmpVfS8sAo4IWhqThovWGaMheNjuXP2yMY9UnSBzdv/hKIyVu0gHMBmz
         5UY5dDBEix2cnAwZeakc+23QxggjmgEDHzddnDQpF6rv6h/aaIJk9V0Xw46vzd2b1Exo
         Vz9lGrDfbjBMlwBhU6t1yuCpeSvYPUc7mh7eC8I9KfNmAAACR/vGSBwVA4+tIwq0bYZO
         zBFMMh53LO/D5vUQaz6Wb16mbPpakzV7CFgd8IuxB2PbWd150N9cG1G/+oXtQE8iRVpt
         TljIVUC3K6te3Z0THeZvz7qTigGNAcQ3xqlbINWI9eaYw3lVB0lfD1ofF4pEZM3+zI/S
         DFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUSW77EmT9F+lIor+VQ1fdeNfl9AmiAT10sz0QfXrEw=;
        b=OxwvuaLn6iktacNMcgTOKmxVRW4bkf4+4zRnhP+ooQmf5CexsIvzOp67m7oLCsAbNs
         TYHCrKJW8Q/28W62v9+UhvnIjAPcorQywJldU7Np5RJIJvmubASOYMc9H+T+XZK1y0p0
         u5zRCK3aLcXVI9/iQKZ8RNY+PFPtBCNbyXL+YDg1CPSwto9hdBvE42dE7BGIVuYbyO96
         e5eg3BoA+VV0svf6klA2ng8sUy43onFwi+IWv1eh1Ri7oLfk7Vyg5Gn+Z520I3IbsfiT
         LUdD7JQuI0mH9IrmenNOogeqIp1ur+UYzq9KW0csLkukf9Vun0H1QBX0tWMU9Q58GhMA
         +hfQ==
X-Gm-Message-State: APjAAAXaIPoIqq8FcS/Sz6MnLiNKZk73TCG3JbaxfY1xHT1oi4jrJPw9
        u7tsxcwSpTW4bJEiXMKVVNj7cA==
X-Google-Smtp-Source: APXvYqz9Ayy1oH5iYBu/DiElA6AWSzz4xgKbeDkFXSzGDCXKdH1lYAxXkuOVbaT26i5LN+OPo4J+9w==
X-Received: by 2002:a37:bd6:: with SMTP id 205mr24768693qkl.361.1582211225276;
        Thu, 20 Feb 2020 07:07:05 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p13sm1741740qke.131.2020.02.20.07.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:07:04 -0800 (PST)
Subject: Re: [PATCH v5 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200218090129.134450-1-wqu@suse.com>
 <20200218090129.134450-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <106cc417-34ba-2c13-46cf-6645fb1bd28e@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:07:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218090129.134450-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/20 4:01 AM, Qu Wenruo wrote:
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
