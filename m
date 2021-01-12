Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07D02F34B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392201AbhALPxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392191AbhALPxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:53:22 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F243C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:52:42 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z11so2201737qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3VOirjeOIr8hFRm3h3Xp5mZuV+8C+76qUAIeoSHnuRs=;
        b=UD+st9PzLlClludf4uK5aFj+zVbeUU1a2TLuK04qgHnlgPAt/AOudNFQWtJlRebu7N
         f17RzYFk0zMzc7ZH+ay7DM/9vB5cf0pVrs0c6VdQgtEGkZMlLlioS/rZkY2dvdXOy0ML
         BXKWAVZPfGQfiz/Ofje4Ih0YWLOgdLwYlCvUvw0wMuhwWV6dmETlBD+Y2y14vcfs15uU
         HgLXCit1veUlQQyBqkZxKI/veK0gfCa5099+vs+hAmbaILlazZtKsCvrdQRYtzJlnrkr
         jS6l76MX6pazYYZmZvyqdHDldKVhIBZ0hejfWWocoeNVk8ewiuFNO17SZo5RFLJmx5HF
         HRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3VOirjeOIr8hFRm3h3Xp5mZuV+8C+76qUAIeoSHnuRs=;
        b=fFm4wj+zg21FJ8s+PSGWPEyw1sAHg8hP4SHWYU4RtlQ+2GbJUhHEWKctksdjtQVWWs
         OhGPXN7pd2rGSs3aYAWmsQjh3O18KOv9I894C5sYao2EUm3bts4RS5OYXVVCE07t2b6u
         /CLT98yc+aCExcW64D8tpbteFj5uuiAZOvjcj3D5cZgyNPefpQgh5P4TrhX14ek0qe1c
         i1IIJ7jmVwhvbN4hidp5PnuKi6zhXUVw8mu3kLZeibaUibigDGCDoE3V4wkDGnQvOEGW
         MXO+Wr/QzqKUhDmCx5/gQOEVnJOGxoX+neULQAqvaBTctVHldxVfAyNPtb6tmpbpI0go
         d9YQ==
X-Gm-Message-State: AOAM531tJJjt4INWNCBYMdumokr+C0E5tisLi7C4Bf1kw9auzx51lQfC
        N+Jiugu6VepH5IraQLOiLyem9FLgCte6AK+z
X-Google-Smtp-Source: ABdhPJzXxc0ipRQINJ/p5shNULsus/jkY3XyvKky1a1zVgoSEOFq0r4Vr7GaLVcEOgm6Ss77yCP6Aw==
X-Received: by 2002:a37:2796:: with SMTP id n144mr5369005qkn.471.1610466761282;
        Tue, 12 Jan 2021 07:52:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q92sm1239635qtd.48.2021.01.12.07.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:52:40 -0800 (PST)
Subject: Re: [PATCH v11 16/40] btrfs: advance allocation pointer after tree
 log node
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <a26bdfd95d5416bbaf49411cea69bee2f06e947e.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <19ac727e-4232-8a2b-d36c-ab34eecc22ce@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:52:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a26bdfd95d5416bbaf49411cea69bee2f06e947e.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> Since the allocation info of tree log node is not recorded to the extent
> tree, calculate_alloc_pointer() cannot detect the node, so the pointer can
> be over a tree node.
> 
> Replaying the log call btrfs_remove_free_space() for each node in the log
> tree. So, advance the pointer after the node.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
