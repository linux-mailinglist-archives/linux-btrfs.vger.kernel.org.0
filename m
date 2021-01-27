Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124C3306123
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhA0QiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhA0Qgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:36:38 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917AC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:35:57 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e15so1806345qte.9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TQFLOpawvUNG01yLQLARrzlMAhROnD8mvRxh6LPDD7o=;
        b=fV5f78T/bGAGMgZvN57KKKR2jn5z6Lg5Q1uxfGbE5S41HpYt3GmHuI4srBlElTOW2w
         8zu30E6EL/48q/1/SN4MQ4pVnKZsqWYPUwLlNsKqPmjxYQBHx0U0QToOCve530xlKm4J
         tbcZIieH2/ybAwuQD64cmeRyDdounY+etdIYS3wrCYsFad33wnrBPWkpHf4D9mt/30r8
         5R5FPlwqG6+9X69oVH5dtAVHqc9x39lBBKQ6oQVGIBd7YlzxVRYps3PwkeBXJ500Gy+m
         S51shzyDAeqRPqjpSdqsqqAQAvpLa66Cgn7qhDe3lM1QYjxe0V5fUuASc7ANO5trHjrK
         VDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TQFLOpawvUNG01yLQLARrzlMAhROnD8mvRxh6LPDD7o=;
        b=F3b6Voa7Etvwuhn9KOV+6Uufk0ICZ5uSX9DdykcUGhxNbxt5xFXK/o6uBA+HOnyE5+
         xG1c5wOAjDQ5YdLK5ZDf8rbCCqLCjLIDqYfKiM3Mw4daegT0qabmumc7V1br6puy/xRi
         uGjbkby6Q9b/WZ6sO/1o9uFr/mGYLsGO0ys11E0r6kWUBc4Q5t5HbQbwuf3B5atPpDDF
         Mp8KbzYDxzjYkOUq4iICrEZWF9Z78HUb7nSR4wkYN1sRlndNndpjss6M6a11kHYxUKQw
         +aL9sDit+Kh1oLXsi2FCooTQI8yK0d1gsQ47K/eT/X/rh4Vvzt5GBcuFakujKL/juMmS
         nOpA==
X-Gm-Message-State: AOAM530t2JzKGPOYseK5ZscvE2d+Ecc0HeMvIO5GpL5JUA5P8pn0SCTt
        LcQx8SNv8G79MT52t6WaU2nxxg==
X-Google-Smtp-Source: ABdhPJw9UXPVt28ITmisWirX0kCnkq9KDZ0K0Fu4wxF/d/sF0D92qFzDlSInAnOXSSYwcxBhYJj5PQ==
X-Received: by 2002:ac8:4058:: with SMTP id j24mr10528057qtl.8.1611765356852;
        Wed, 27 Jan 2021 08:35:56 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p12sm1568197qtw.27.2021.01.27.08.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:35:55 -0800 (PST)
Subject: Re: [PATCH v5 11/18] btrfs: support subpage in
 btrfs_clone_extent_buffer
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-12-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7ee4c9c5-e466-33b6-b8b4-6053990890d7@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:35:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-12-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> For btrfs_clone_extent_buffer(), it's mostly the same code of
> __alloc_dummy_extent_buffer(), except it has extra page copy.
> 
> So to make it subpage compatible, we only need to:
> 
> - Call set_extent_buffer_uptodate() instead of SetPageUptodate()
>    This will set correct uptodate bit for subpage and regular sector size
>    cases.
> 
> Since we're calling set_extent_buffer_uptodate() which will also set
> EXTENT_BUFFER_UPTODATE bit, we don't need to manually set that bit
> either.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
