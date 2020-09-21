Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2456727329F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 21:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIUTQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgIUTQa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 15:16:30 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2668BC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 12:16:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so16384999qkj.7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6UK6pFGt9egleebc1ma/B/6425Pzzz2Y948T88H5mEs=;
        b=ubUJwzRgnJoOGCxpuXvFu5hwLnlqkI78ayNPsbzfbWH2n4SrinrgDcdZIjJ5qVsNp2
         TLWawpYZ9ZzxPdE+pa00LqbUbf4afC790T6KOo7H9rqyihjhC0ODnxiAudiZIi4ZrnQ4
         niI8JOpbk/ZC00TsyaT/Ahq8YasUpvrMrV+5diB+AYypjO7zgov0zLd5WntjVPa8eLs+
         r0Gc07YcfkWZ/t+TKv2NqlftUjEVELmUOdZF/CDExAItHi+Xc/Ju35QwJzYcs7N686zx
         qRvOyYtoTTuQVrOPC02qtSc8Z/I5ZHsx83oCzIoM1sGPIuus+NT7/gZimERHnGG5rpp7
         j/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6UK6pFGt9egleebc1ma/B/6425Pzzz2Y948T88H5mEs=;
        b=oTPI/ylebQuzICWE/8UheOAUTtDheAU6w5PJilFQ/bl2M+UVGPE7xQHTWDxnkgU3/0
         TQtmvKSHh8D6c0bS1WWOl8AN6AVDdClnEX/IdZKe/sq0CTIuc7hM/6p9SlJF8RsFOtO5
         952uOvwRkvgk1oOF3ej8VJ+mOYlbdrXQYvuZh/00M/AfrtURIccWjibKWl63+QcXA/cI
         QOrdB7bjx7LmJimQUpyTobUC8DwGZBBBJpxwoY3jqXxm1sw/+Nud5c0SJJCct9aVflhx
         Lr01vjg0V5hvYzA1AnUTaCJvGcP2RRlYExYCFmURDmTWec6eIt8FCEe8mlgw2mURF4Qy
         qU7g==
X-Gm-Message-State: AOAM533jLGqvaQKpl5e3SQH7aA3+hUpEPYLBwXUU3CMxIWUzal8e8Opd
        DGve6MNdoh5AQu1lFFslzCGh0w==
X-Google-Smtp-Source: ABdhPJyfFgFQ6bgnGMeqGOJza3rfG2I98DGz6A1LI3DAKBmxeDqA2k81igukHqPELXpCTdyvE0Rexw==
X-Received: by 2002:ae9:de85:: with SMTP id s127mr1216977qkf.59.1600715789207;
        Mon, 21 Sep 2020 12:16:29 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y7sm10748586qtn.11.2020.09.21.12.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 12:16:28 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Fix potential null pointer deref
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <a.dewar@sussex.ac.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200921191243.27833-1-a.dewar@sussex.ac.uk>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <def529e1-3d7a-aee1-f4dd-d4d3d46b9f2a@toxicpanda.com>
Date:   Mon, 21 Sep 2020 15:16:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921191243.27833-1-a.dewar@sussex.ac.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 3:12 PM, Alex Dewar wrote:
> In btrfs_destroy_inode(), the variable root may be NULL, but the check
> for this takes place after its value has already been dereferenced to
> access its fs_info member. Move the dereference operation to later in
> the function.
> 
> Fixes: a6dbd429d8dd ("Btrfs: fix panic when trying to destroy a newly allocated")
> Addresses-Coverity: CID 1497103: Null pointer dereferences (REVERSE_INULL)
> Signed-off-by: Alex Dewar <a.dewar@sussex.ac.uk>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
