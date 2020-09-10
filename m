Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51B826488E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgIJPAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbgIJOv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:51:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764BC061757
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:49:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so6250286qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gY/Jm7xP3SwUvAykmN9/KsiLchSsfrfQsShdsmp3hvQ=;
        b=qHHKtvQ8QpkqyXX/7wF9cqP61ka53RzEkcbA+xM4weO09rU6plBcX0kFsjwUC8/q1L
         EQbssvczFSe2ZYbq940r9MQf9pdCJfK6JmaJvg5NQuCAVAX/zk50v7m2ptVpyXDrQeOh
         Vshh+tw+IhojxGYyeymSjN76Gcs5p45vU8dngowjZlmOAUM1oAg3CWm10+B2TDJ7Szvu
         Dt5m6JFOQ9XUF8MWbm4JRyh9iodck3+aNrxMpDwbKN4m1hTI1DFl0PgF1VuSRhr6OAsw
         RbDkfTLQPKguTrQWmZvHXyiWpRUgqMEyddShUHKqQR8iT6iY/gYqImXCoRpBcY4akFPY
         aeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gY/Jm7xP3SwUvAykmN9/KsiLchSsfrfQsShdsmp3hvQ=;
        b=YLIwXKjYc5TWngTha0IhOAHfrhiskoyyvmPLyQhZz4INHlVIUeNydSIzgvoSv8yYXB
         MM3LsZKDJKLMm4gxQzwuf32Ew0H6FReV70Lk8cJQffNgKKT2ka2myH5FD5Dp+Yg71xac
         vkLQf4K5tjsFilm3v+f3RqT3jy0X4WYgJjA4PvkmIQAHA+78pAxrOSvKjGR2zBk7F2Gk
         RVs+fKbmSLx/NVVGMfJkQlEUjHlwesCtToVWqSQslhX4icmXRbgg1Ge5jkxVfkd9LNJ5
         B8NlhxtaVMtQ1uMiCm5580wqM9UPXtEAEdvTL33iHeQoC1QxhLwJRcdVui5nsWpj3d53
         U2dg==
X-Gm-Message-State: AOAM532Gd76YQBUiV/3XQ71t4Cl68S3zq6IDofznZoexkqF+bW0TMbrZ
        I+g3Lc9/s5QkIDvrwhkHAAXRgYmvupUcygck
X-Google-Smtp-Source: ABdhPJxbMHcZ159a+3wD86kSUx8Jr5cFpmKki8dZTVzpdHMa10J0B5AO2Px+XVZJuRTan3HFNfpxeQ==
X-Received: by 2002:a37:6481:: with SMTP id y123mr8152160qkb.464.1599749361215;
        Thu, 10 Sep 2020 07:49:21 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f13sm6868632qko.122.2020.09.10.07.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:49:20 -0700 (PDT)
Subject: Re: [PATCH 4/5] btrfs: rename btrfs_punch_hole_range() to a more
 generic name
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
 <7e911d8b38d65c426738e53ac205eac94105c87f.1599560101.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f8fcfc28-787e-6bc7-e03e-78548f8985f9@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:49:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7e911d8b38d65c426738e53ac205eac94105c87f.1599560101.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/20 6:27 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function btrfs_punch_hole_range() is now used to replace all the file
> extents in a given file range with an extent described in the given struct
> btrfs_replace_extent_info argument. This extent can either be an existing
> extent that is being cloned or it can be a new extent (namely a prealloc
> extent). When that argument is NULL it only punches a hole (drop alls the
> existing extents) in the file range.
> 
> So rename the function to btrfs_replace_file_extents().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
