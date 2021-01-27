Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9243230611C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhA0Qgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhA0Qff (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:35:35 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F20C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:34:55 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t63so2307680qkc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zJx5daZ2qlG6dbwbIfLWdvPtan/DZhj5bNigO3D4vmo=;
        b=nyFsvAzsCriDCrUREzEyIpRpIJ3R8548sFYTNz/H027OjmzQGo7w8V3LngtDVVjhw5
         zMgE+hLkbnjCccPyfGGg6c5ERGBZy73tZ8fUEtzG/a83neE8IZiEtR6nEdo7KO21FH8Q
         f2x303+My5VBL0753PDLwKR1JijBQoPUhxEHTbsACMNmOxOPEHB+Homc5sp9OVThsxl7
         BrjQ0mu2MaPkM9YTnsKe0usfxVCVAEG/jWdtYHMI/SWYZi7j3tHTHijxJxuQKRocxQZV
         6Eo7o6aqsBHikeuL8/lFfHN5u46QeTXudceaax99M21f6jN3ZPHv7J8tFVy4w38MnZzv
         K38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zJx5daZ2qlG6dbwbIfLWdvPtan/DZhj5bNigO3D4vmo=;
        b=Qf51hx3xeP80cZJiF7PDL+oGQcdrDRHYzh/GeshqCtMVCEKQ5aI2oSvNHRc1mKCi9z
         JIJ6Ez8OplcUFwil75lY6zrFu7ytPIs2xDfRXYZSERiT7lHH7zoeWmMPYKGhWT6+8xol
         g1w2P3vfOr7PcUK0kNFWwIAvhP+6xv+vfh17dWzMcUQc5ELgXZrJzEyoFxp7rQFsBUuO
         T8QczIdbnNhNqrdjpUEGKpnHc0XBRjL9iw0wFFUvDYRSYFYPQe8WXmllcynpTksY3VfR
         WQPl2zoI2iCx6jrH13S/8GWY9p4vg9VUL96ftAXBHufBHUqaQESe6eMrevzI2RCxre7P
         QNVQ==
X-Gm-Message-State: AOAM532JrVOfZcUvVTSejl6msXeYOLQtnYBN8RxgFET317mWuHWGq1ZC
        odJZ7s7WRJKtx7GJsBqhTIRU2A==
X-Google-Smtp-Source: ABdhPJwOwv2TyMGKKOT3idjZkGFH2lpYH76tCVa/1OFot1+xzfR0NUlCWqUegZqt5s711FQxZxvanA==
X-Received: by 2002:a37:7641:: with SMTP id r62mr11466897qkc.227.1611765294808;
        Wed, 27 Jan 2021 08:34:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o10sm1523181qtg.37.2021.01.27.08.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:34:54 -0800 (PST)
Subject: Re: [PATCH v5 09/18] btrfs: introduce helpers for subpage error
 status
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-10-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <06035378-f808-7db8-edc8-3f4e15344e92@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:34:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-10-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> Introduce the following functions to handle subpage error status:
> 
> - btrfs_subpage_set_error()
> - btrfs_subpage_clear_error()
> - btrfs_subpage_test_error()
>    These helpers can only be called when the page has subpage attached
>    and the range is ensured to be inside the page.
> 
> - btrfs_page_set_error()
> - btrfs_page_clear_error()
> - btrfs_page_test_error()
>    These helpers can handle both regular sector size and subpage without
>    problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
