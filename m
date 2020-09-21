Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA6272713
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgIUOcd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgIUOcc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:32:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284AC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:32:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so15149103qkn.11
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6dZ3EvzRkCcCGT/GK1udb+gln1If7UAoQ4HyiwtMBQA=;
        b=WG7b0iQIVC1Z7Z1LNc+Y+U7eao3v7UJjvvJZDte6WzSv2RhZ7XhZ5T9Fln+sYAbiA1
         j34NrogjD9q5sytKAkjKN6LqM+yfVnvbf/blMxagAC678cloRRjH9nvEL/zJq2zq/Vhw
         RMnUfnNoHG0aBXl3OS0X1tEenNB2Xt+8Iwp5xP4UrVWzXmiGMqTfRNxb64xKSac+fIcs
         zPjlAyh0SJnTIV0T9cW/xhic1ss6fGzEUA5Rg+WCLrVCoLxbkv5jhSYFMK2iGZS3Wdg6
         4M1cu6TP+EkA5vVPqo5gZTO+DTopevHFxAQSqskp6hX79t0blCi+BKc3khxdmvxH7qIZ
         HSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6dZ3EvzRkCcCGT/GK1udb+gln1If7UAoQ4HyiwtMBQA=;
        b=TZu8l6ZBj+7IoeIT953sYYcMsppH0I4Q0DNY60rl4A4EoUvH5iD1w7DdrzPzP9G7zM
         1Wl6ydgeJf9sDxytz9Z36i051TYhHbKCskjuv65g4g1HYVsCWZQpabvoWOHuyPmN2/OI
         QUeQ/G3Wj4EFmZ20y61BpWhzzmDJqT+ztonliVS5ToktZhhhSrm5gEtnLtd0NGZb1dxh
         +a9OENkQqy8IjmBvbcyztVtFdFdexWl9T75Cvm7mtW5s9WaiB6Aq3DneTFEz9G4xp9nI
         EFdWYgqwAMJEn1tQ6dDunXc+LHjb3HRr/FQN5aB1T6cQO77TEm/f3dE+qrCJzLoOX3k+
         X4gg==
X-Gm-Message-State: AOAM531ORRDDx4+c/22btgpoU96QLXrUgdPTETIMk9ZOZ55/uNWapPoa
        /TN+ZsVVAS+maM0qn++9iL7pWcX/rnjt5Ehn
X-Google-Smtp-Source: ABdhPJwC25YuXXsNzkaMfQbN9xeukPmKL0pWGXzl5iT1HPQ7U8fLCi1AP0+gdJtBRVhvK5Fhg3MQbw==
X-Received: by 2002:a05:620a:1274:: with SMTP id b20mr82424qkl.220.1600698751809;
        Mon, 21 Sep 2020 07:32:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z3sm9130259qkf.92.2020.09.21.07.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:32:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs: test incremental send after swapping same file
 with two directories
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1600693732.git.fdmanana@suse.com>
 <86d811965c984a6b16afa12ecb7e6e7512780ba6.1600693732.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a85ca026-17ea-144d-dd8b-169e11081b28@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:32:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <86d811965c984a6b16afa12ecb7e6e7512780ba6.1600693732.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 9:15 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test an incremental send operation after doing a series of changes in a
> tree such that one inode gets two hardlinks with names and locations
> swapped with two other inodes that correspond to different directories,
> and one of these directories is the parent of the other directory.
> 
> This currently fails on btrfs, the receive of the incremental send stream
> fails. This is fixed by a patchset for btrfs which has two patches with the
> following subjects:
> 
>    "btrfs: send, orphanize first all conflicting inodes when processing references"
>    "btrfs: send, recompute reference path after orphanization of a directory"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
