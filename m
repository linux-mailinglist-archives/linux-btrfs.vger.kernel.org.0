Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48D02F881E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 23:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbhAOWER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 17:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAOWEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 17:04:16 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC89C061793
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 14:03:36 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id et9so4713919qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 14:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BI7NmpJ8bb6Ryf6z7JDJSpiAPrw0wXW+V+3D6pFFPP4=;
        b=zT/XDvR0DDjHutPcSmbdNheGNE2vTq489LcaWpBzHR6KFg3arUrjznQSLt53RYoUYc
         062FwPpcHI3n+bIiQLk6qYQ3GtRL6sTVrBl3bb1+6UclNoZxxBt+JyegfcjkHy9shDNZ
         M5R3QhNhZ8Gm1kWm7vU/tb7xkzCKAw4EsyvH8n4/KaMg/BHFxuoO0kiHU5XDeiSu13gM
         tdWabdQmfydUc/nSZYEVVkOAFjWY8xnGd0XB+Z0gwGOg2SYwyAqRo/D4yIGeMefgUQvp
         4MhfTMIN4+mfeRsMq9ntkQaH4LV46QSKK5gShK3Lyn53AVY8OlrOgI51pNu5jyJWUVWt
         TXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BI7NmpJ8bb6Ryf6z7JDJSpiAPrw0wXW+V+3D6pFFPP4=;
        b=L6W+M4Gw2OCpfenDUWk3nlWkVtmu0bqL//alacP0YAgLxKjTFu5HMRFQo7grggoQDk
         8yCkERtIsLA/jY1V3oh6ZXNRBdb8+MdTKB9vzG454zpp5prZip7QzcPmft+YMZ/vtTis
         2ywli3PFDRPnzjlM5lpX4Bw5z00ycwb9xKNMtjDh1O8lpx9Lzf8xUpfgnNmH8pnMuSf1
         yD3Ksjt0Ar/eaHGV7lYhc1Q0dVlRjx12GYYgt1QSqGH9YPeIGkVFlOUjANr5X33C6YjX
         tKV0vrWg+dNuZAcFz5E8WLt9/0Cyb9+XmbztDiFdQK6lb6KGvhk387qJrV14AdaTNkDj
         BgAw==
X-Gm-Message-State: AOAM531GXfDNqRmU/Olb21RacoEJWKU9elbXIhRVd6m/wH1/WI+PKOSW
        jiR18NXM5vCAMgOsETjfBUet8A==
X-Google-Smtp-Source: ABdhPJy84w//V2a86cpwW34/OVJ6oIcEoSgdqnDzutmJ8gO5nFYD0WYb1eN0xClPl1zYF5rRI90t3g==
X-Received: by 2002:a05:6214:a14:: with SMTP id dw20mr14125886qvb.43.1610748215770;
        Fri, 15 Jan 2021 14:03:35 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11e1::105d? ([2620:10d:c091:480::1:cc17])
        by smtp.gmail.com with ESMTPSA id i13sm5756623qkk.83.2021.01.15.14.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:03:35 -0800 (PST)
Subject: Re: [PATCH v12 01/41] block: add bio_add_zone_append_page
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <8d02dae71ff7ec934bc3155850e2e2b030b7dbbe.1610693037.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <53a3b32d-c0ba-aa8c-1f2c-bed851cdf806@toxicpanda.com>
Date:   Fri, 15 Jan 2021 17:03:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8d02dae71ff7ec934bc3155850e2e2b030b7dbbe.1610693037.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/21 1:53 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
> is intended to be used by file systems that directly add pages to a bio
> instead of using bio_iov_iter_get_pages().
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
