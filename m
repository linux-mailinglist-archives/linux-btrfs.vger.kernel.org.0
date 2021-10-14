Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD642DDFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhJNPXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhJNPXP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:23:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA8C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:21:10 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b12so6088195qtq.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P99WPv2L/TrBaVJDnFD3EaovA6sCaVetg3XnLBcR9dg=;
        b=qggW8kPy9FM/VpTs+O12oKFo/Aakw6Uil7pSzNbsQ4qCO6Xa5lnZweHqkY4QauzzT4
         g+22YM3HPTq6m8wKTwTyU/lkIVVL7bPa5AaQg+0cOgBvvD3/1g/bKVq26JZmpAYDqYNm
         XpKgvaj2tZqbd2zKwLc3/qu/MxKRgXIkxz0PQ6hzUOzaZhV2z/W90mBwUVf1rYk+6Fzx
         mZq3WxQaA4xPEV6yFSIqYviVZF5Xfo9LdktqCq7+fmtW59HAIzkgopmgLdECfe1ODVWv
         9kNN1WkLY6D7S2TOSRL/RWXMBtpfGTmOn2mPsSujrv1zWqW5lRNVUECxqcUdv3qSdtIh
         npxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P99WPv2L/TrBaVJDnFD3EaovA6sCaVetg3XnLBcR9dg=;
        b=JfK8TkD0SfrxU/K9japIBxx6UoYMK4rzqaiOOiSHjldndb2r2ap5EW9D/Qj7cAuN/k
         n3Ta2i1C8SBx3ujiwj2AcYv4gE1wht+fdM5NHpT7EEUdQBUSaZhJqWLrEPeajsWGu/Yq
         l/QO7RYfvEDB2AOS4IWt5ymEu3v6fy4Su8OkrKkBo1s7EWr2ijdOz8iIuIN4np7l7Jkc
         7LkbQjLxbe/obzs8Df8HmHwrGCHdynkabRiGsgUQhXtcX6aY8YRM8q7qrP6cTmY/DA0B
         6IktN6V5v7N8mJrN5DmfFqO/d/VvTJy05HjA+/yctGq2Ui/fNbsZsuTN84RBs7JRiM2m
         bD6Q==
X-Gm-Message-State: AOAM533D7x5VVdYBC334rttTQ0XBDB/6NOZPowbJB1PPKmY9/HVbQKCg
        oOPqUkms2umk3b+El0M9VHT8MELaVp0r3w==
X-Google-Smtp-Source: ABdhPJxZhgUpsm3AV7btUrKv499l55DinakV66IEm/QhDUijGeNpp4NiKGifFCzfhY5RYH+H4uq6AA==
X-Received: by 2002:ac8:4111:: with SMTP id q17mr7350123qtl.407.1634224869401;
        Thu, 14 Oct 2021 08:21:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z19sm1451928qts.96.2021.10.14.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:21:09 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:21:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: update comments for chunk allocation
 -ENOSPC cases
Message-ID: <YWhK5PxiNDd9+Sra@localhost.localdomain>
References: <cover.1634115580.git.fdmanana@suse.com>
 <9f380113bce520afd26c5e1029c06a346334eae0.1634115580.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f380113bce520afd26c5e1029c06a346334eae0.1634115580.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 10:12:50AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Update the comments at btrfs_chunk_alloc() and do_chunk_alloc() that
> describe which cases can lead to a failure to allocate metadata and system
> space despite having previously reserved space. This adds one more reason
> that I previously forgot to mention.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
