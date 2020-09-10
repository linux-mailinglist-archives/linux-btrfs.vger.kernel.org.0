Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FAA26517C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 22:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIJUzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbgIJOtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:49:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5CC0617AB
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:48:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so5007645qtn.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=idvTn8PJYOWup9Gu1QL7AJdBnuW8md4zfpd7QTc8P9s=;
        b=ChZGIDLNw0hGKusk/zvzIbMZHP0dgThhqjazB1ekF/Q/HTg+JdGwIiOkol0O4YBcfF
         7cVFZNwyVnrKxXMydmeRowZwwvly/+ss+z1ii56o+DKCoq2LaWwpP0eWfGhGhVF9MpfF
         fF8VQpT53d3T3AVNVnCtXFXrkGBuQ88a7WmNmCijmqFc2rEq+SDDAYZff0trAPuEBF7l
         deCkBjvORQiK984sirbkcXyLT1unKjkq26oQ8AwmsGs5peiX8S4JURgqDeEdd0OJrku8
         fpRqy2oPQ2+GxgXKXxkWjCBWBw+QM+ONOOfGdxbJf2X3Fg6lxHTXTuNLfbuEeCDzDD7N
         0nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=idvTn8PJYOWup9Gu1QL7AJdBnuW8md4zfpd7QTc8P9s=;
        b=jj0an9BaISTwXd3HVpiyb42v3JoGGR2fLOmbI1PuEFqpRuoEsbxj/NEKEo42NiMCPE
         6PXiy4gIYD4dJEGW05TVspaJFGbZ8Q0fgDrJUK27D//UISeCjMVtfOolZSG/yPwhOCaJ
         UWA5GI+ZATGro8qsBMXI6JR6SYbyzirFoevheePeUrogkfPaMCACMaeXUEaimFuBwbmK
         cVthAYwfv0AxCVlpkFSIMGvYtJPXZJZL9UQUvI9ZJKfPp6BA3cQqA3a7zyq3ctph5hOL
         PvFk/ZbAp92na6YsaWf/Szng7EB6Dok/pcMjRhek6AcC9Yr0dOn3oMmAr/zcsldUtT4v
         fn6A==
X-Gm-Message-State: AOAM531BYXnWC1NPa3rf/0UtefANwK0fyFO4K6w5eOI6TSF9d80BzQi1
        4ZHVFFn4mV9jaqFgDKFuEBCKQyUKBhV2U7Mg
X-Google-Smtp-Source: ABdhPJwI4GitioLSYaNLv98r/kEYp8Ht3X+zlaS4A0CQJlPbIrPlBw/EHfiaySqILeH+Pdr7cK4L0Q==
X-Received: by 2002:aed:2fc5:: with SMTP id m63mr8024101qtd.313.1599749337575;
        Thu, 10 Sep 2020 07:48:57 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r64sm5037232qkf.119.2020.09.10.07.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:48:56 -0700 (PDT)
Subject: Re: [PATCH 3/5] btrfs: rename struct btrfs_clone_extent_info to a
 more generic name
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
 <45f5d723d70e55ae720abb9422ac9c0905f35f4b.1599560101.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a8385b2e-83c6-9384-1b69-03d1a8e71e11@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:48:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <45f5d723d70e55ae720abb9422ac9c0905f35f4b.1599560101.git.fdmanana@suse.com>
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
> Now that we can use btrfs_clone_extent_info to convey information for a
> new prealloc extent as well, and not just for existing extents that are
> being cloned, rename it to btrfs_replace_extent_info, which reflects the
> fact that this is now more generic and it is used to replace all existing
> extents in a file range with the extent described by the structure.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
