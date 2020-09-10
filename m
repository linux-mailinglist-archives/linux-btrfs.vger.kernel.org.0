Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86EF26488C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgIJO7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbgIJOv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:51:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0FC061796
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:49:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so6248069qkn.11
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qz+hHNy/c/Fv175Is182eG/q1j7b7kIxdcsGdJAhlR4=;
        b=iROqYDQQ56ul6BFmv6oMBDXJSfO85xwsUEQTF3B6CuN2p0zHch6z8wyiwLIO3v6+XH
         xkGi2Kyn+K0jdz/7YPXiH5Xk/d9JtYigyPVF2uf/jKWs9x0ZpAXOc+0h3toNoJeF+68u
         hycDzIXu7dbJVs6yJAzgYzYJckRiKN42PvVxQ1tFG1FospqQLra6KDPEh86PzjpzdNiJ
         1Qiitxw+ohr0ZG/E2SOHyO5Z/UXOwHbC2yYEbVGsHdi4sEzC4iRb+64CluwekWqUwrK8
         SRytrCVGNqyrz0RlsUUawAiSwSb0YWN4dsuIyIYQ/nbVNgOU9oP+D5yoj4b6+q3AmUMc
         Hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qz+hHNy/c/Fv175Is182eG/q1j7b7kIxdcsGdJAhlR4=;
        b=EH3Yjd/lvKW8wnDuB+3e3zOupcH7jPNqXcHfkDse7K1Ez86HhsI4kmFwGJEmyrINqm
         61jmRcmJWWvW3s5XwWyHYb82bBYO2m3ZZ0QJ2TlC5FlItKOj6m2/kmacOWw01HXA6eSI
         5DAZsa+UssipuLDS/wDKG++hq0jSzmO3QZdVqBEIcUt7Aj4TQIx1WAuqC88InshIL4F7
         wJTj2pTeFrlK6Qd3nvsOSKRS0DnRh9Y5o9caXODQa7qsIRTWO/JIsbYBJPOrUufcFKCP
         cYSwQe7dpUSBPPF15yTaOBvakjNv9qwYO2qAFsV/mdjxVaiVJZc8LPuTeohUHNxCLwpC
         eecQ==
X-Gm-Message-State: AOAM5338/9bzIU1tB0fzNYo9N6I82QdiR0n6f32T3CtW/iggbqT5OJDR
        +HwCX0jezdhbgKDeMQl5z923Jg==
X-Google-Smtp-Source: ABdhPJzEBR6ILDV9PUQmgH4/7HIzc8IwHfbAtZO8AlkkhgguKki58LVfkrmiFSelsmfnaHu2c0objg==
X-Received: by 2002:a37:44c7:: with SMTP id r190mr8078355qka.253.1599749379615;
        Thu, 10 Sep 2020 07:49:39 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c40sm7730265qtb.72.2020.09.10.07.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:49:38 -0700 (PDT)
Subject: Re: [PATCH 5/5] btrfs: rename btrfs_insert_clone_extent() to a more
 generic name
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
 <708d9e3e76a589d5362b063f01d1d1c58c0e4184.1599560101.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e8d0dec0-a234-344b-e8b7-ba7028c523de@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:49:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <708d9e3e76a589d5362b063f01d1d1c58c0e4184.1599560101.git.fdmanana@suse.com>
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
> Now that we use the same mechanism to replace all the extents in a file
> range with either a hole, an existing extent (when cloning) or a new
> extent (when using fallocate), the name of btrfs_insert_clone_extent()
> no longer reflects its genericity.
> 
> So rename it to btrfs_insert_replace_extent(), since what it does is
> to either insert an existing extent or a new extent into a file range.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

