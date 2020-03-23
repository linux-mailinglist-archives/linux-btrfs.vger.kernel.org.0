Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3CF18F506
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 13:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgCWMvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 08:51:25 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45431 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgCWMvY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 08:51:24 -0400
Received: by mail-qv1-f66.google.com with SMTP id g4so354015qvo.12
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M83pCfW4UR/+hTYKgGBSJvkvkUInpjBt2rUVsG0xoLo=;
        b=BxeA6Ls1JR9XZXOx7QTvWeFA8xi6at1kjnDwfQegDQYFbzJAS7lt6+db2CEG/WpYrE
         i4XMuZeeIhyBLrjXg91o5KlqkiBaeQiPY8cid8n6Q4fAqC1isxpI1IUhWPPn/IsCvHIz
         wPhOiLFJpD5ai3vqhK6umRnrddt7d5oLOoKRHd2siNU4ev3ZCeWwQafj6C9ZeC4wB1K9
         4fp8VBiU5j7zyys9tAI5WW6Zlg3DOIZH/dZHtHgOcEqErgvrJD1vqf1qZtoeg5NuA62n
         v/HX65tPBaxo37LXCCEv1zQxKwd7CNVc75kR4kCltiw++jhm02SdFkY3kR8UW1bg4xuc
         ip5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M83pCfW4UR/+hTYKgGBSJvkvkUInpjBt2rUVsG0xoLo=;
        b=EfMFF2jR7m1GLBYRvTj0k7mP2uLzv0SRu+0ThnJK7vianD/+FX9/TKFSNPQLQ98ugY
         vN1rfhaICIJHx485WqfUKFvSYMHkp77/5SV6JtHFtfadvjT9DVhTlISvvhNsT+3AFeuE
         UZ91O0HaoD40oRCPB2u7Ix38gZ5HFFGYM3TI57KC2TmRb6GX2AIYKXKHLOE2RJnJIPHH
         Rxc3kAzJNvnGHqAhQXAZk6vQt4x1hcLII7ueakSCZfnauujwjCC/jtIFyZNOAxUAAatF
         cWL8nE8HhYqgXMWrjbrqgUXK9x0a3joWjd4LH1Bz8gs6wZ/DWDTq9TFk0Y78zCwXlONa
         cOYg==
X-Gm-Message-State: ANhLgQ1VvqgO3vN/XBSVdwngqFS3/HqqHYHdBAHzlHdTUKCG2Vo7T4hN
        FJ6TbwABcbyNur4WzjK3aWdWPg==
X-Google-Smtp-Source: ADFU+vuzu1nN15MNCeaOONH1QmlG3R4bOGRM8rm0BBeKf6WmXRGwjHzBspj4IJKhqDMEcvXqwUwM4g==
X-Received: by 2002:a0c:e98c:: with SMTP id z12mr20936298qvn.64.1584967883399;
        Mon, 23 Mar 2020 05:51:23 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c40sm12542703qtk.18.2020.03.23.05.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 05:51:22 -0700 (PDT)
Subject: Re: [PATCH 01/40] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200323102416.112862-1-wqu@suse.com>
 <20200323102416.112862-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <48072b84-3c49-5cfc-521e-c71a62f182d4@toxicpanda.com>
Date:   Mon, 23 Mar 2020 08:51:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323102416.112862-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/23/20 6:23 AM, Qu Wenruo wrote:
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
