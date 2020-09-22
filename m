Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7112E27446B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIVOiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVOiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:38:22 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC3C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:38:22 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z18so9632796qvp.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2EHH3rPiew16angxSvvIWNQqvLKHn4S2Rp5Bgjvh1bY=;
        b=Gp2Piy5vGIlLmgfJd9Fo8uRd8oTm+M0xtJj+Lb+qt7ZWYFCiwxKtpV+QfzB3VatdUt
         sFFusFGq7OJ3mn1dRI6YBdN9WqJBoozd/J/LaF0JKryeRMvLubUqNnu7xKi67lDsa4u7
         VZKdgrAEdaOjMuIBC011p4LYzl0z1NzHcNfKkH5i8yFiuIrGeEkGFhrX25DZr2rkKeKv
         TIHpi4sLNxo6FYfThd0Qp3oTjgUI8jp8QR7H/QUoxX859dYqqJIs/S1JrPFLA5PGHGGo
         xk4CqKZcC0K/0AAmn6XBi3w8y+QdBwgN/bYlv3420V3i4xa8ewncFgt/tPvyYcF2IlTQ
         IMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EHH3rPiew16angxSvvIWNQqvLKHn4S2Rp5Bgjvh1bY=;
        b=cH06J0nvKocF+HsKzG2ylLmM2qF3++n8qsMu8RswmD+mnU0FP8XTTi0DAetuNzFiEI
         TZEdJG4Yn7go1Auvw7JcWqeMv7kRZ253ktKKtV5yjabdtIKyMoE/fnwvpcylQv1Bas8L
         ueOr0Wj5d+kKUIGuYypRvgnnTV+p0xoHUsYYilkDsQG5O1WlHtVRQvmTnJICbtA8f/XQ
         JjfVHOFZewW3dCUtE6dz9QC1cpvApdWcsl7WF4jOpe9MXZQI5Ss4EMjrPsSj+9IsLGw7
         fOsLQnjsA4fTgZegFYV1sgQcPO4EbTUMz9kKF0Xa6NycvJQTYmdo3vA79xwtjWwl1jY7
         +aTw==
X-Gm-Message-State: AOAM532/ILySENr4nV1/2BaPKW/+D77jgahmncCayiRlLu5faDXMNb8+
        rqUg1z4LVLcA5wXqTV+/d/AZPw==
X-Google-Smtp-Source: ABdhPJwLe+VuCfU/YUhOgiYjNqM+1JiU2X8rK40snfenc9xHvY1cenqeAQ3M9JztH4eqqzfBjPzmig==
X-Received: by 2002:a05:6214:929:: with SMTP id dk9mr6250519qvb.60.1600785501731;
        Tue, 22 Sep 2020 07:38:21 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r187sm11216424qkc.63.2020.09.22.07.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:38:20 -0700 (PDT)
Subject: Re: [PATCH 07/15] btrfs: Move FS error state bit early during write
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-8-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4f3cc6fc-2940-ec07-59f3-4d54fdba6b08@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:38:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-8-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> fs_info->fs_state is a filesystem bit check as opposed to inode
> and can be performed before we begin with write checks. This eliminates
> inode lock/unlock in case of error bit is set.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

The check was there because remove_file_privs may have tripped the error 
starting a trans handle.  That being said we could easily have been set before 
now, so this is fine

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
