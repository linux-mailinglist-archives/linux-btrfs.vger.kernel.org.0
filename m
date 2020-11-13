Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33322B2379
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKMSQk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKMSQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:16:40 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B2C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:16:40 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so7293531qtb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ta4nsiuBQKKwIxZAMy4jt9+0v/YPnigr5yCgaSH+JmI=;
        b=TceBT/HkHxx0Ygku6cnJ7Ho/+GT1HY61iK5C64/aeHbr8rh67zXvhSU2z0Ej7SLVZr
         pLs29KK11vajmlr+CoWDLtD2L29PgA+mrK/MWFZCAQvfWbLMQK5V6eh+MyaxDWov3fE1
         Av64S+L9F776Ph5ULdf87Cz5sOQWW/8c2KPQo5RBI9v9mWR4GV9jyuVb9MIHsu5LXmzP
         Pd94RUqSUXJvSPgmDXR7EAIjwqJFYh/WSjP78Y5ombSfpf1sQxJLZzKjptoIQC/cAlM5
         huj/QTMNUPmHqDsOcZNN7qlMaJy8PURWxih+cRNwuEfsV7jWD0es5nVl5vazZeGieCNj
         4z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ta4nsiuBQKKwIxZAMy4jt9+0v/YPnigr5yCgaSH+JmI=;
        b=TypF3mlKvNthnXhBzDP9/TIiiRjz49aSlhRcOXprMGHcWudjURk/WOg+QlL4dOr8TC
         6d9enradU6HvC6+w2/n5Iqj26nAT2cG+XiL64JORO4cK/y7TiyIf2ChcH3q2L6zTDX2p
         65dCusAgAiU96QUKSB+d9b/IfrwXyCIPOJvFwMJI1o6FeA/CYrm97cJ+Bk0x+4hTnIKr
         8a8kc02qJxq0X0frqhbJ1wrGTVZ27DEG8kIMJgJlIPcqKXeVUx3ZshIC4lbV1iX9YbwK
         ztFTQXX1ghXN4mX5O7XJ9S38qvgAc5lhTpMvfqaCyIcPHBpFUGjwOIC/L4BWbjOb95GY
         vhXw==
X-Gm-Message-State: AOAM532Zt3RyK7wQi3n9ME7P9Jq/DulqwhEq5nmJdx+sFgMamrscK6rK
        1UdMEf4rU2t3YTR2HTQSVsWdO1nWl9TxNg==
X-Google-Smtp-Source: ABdhPJx5zQW3F5HyUiciVhtXV7SlQj8KjxWzW6juZHrOyjfD+xC5MmV1AlesNr3tosdkYtMaNnXI0g==
X-Received: by 2002:ac8:7b3a:: with SMTP id l26mr3042766qtu.42.1605291399057;
        Fri, 13 Nov 2020 10:16:39 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 5sm6940410qtp.55.2020.11.13.10.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 10:16:38 -0800 (PST)
Subject: Re: [PATCH] btrfs: skip unnecessary searches for xattrs when logging
 an inode
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <eb0d75e48d9dcc438cc618e0a47be8e299e22649.1605266359.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d7bd02c6-0ea3-4d19-17af-254c1768e6cb@toxicpanda.com>
Date:   Fri, 13 Nov 2020 13:16:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <eb0d75e48d9dcc438cc618e0a47be8e299e22649.1605266359.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 6:21 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Every time we log an inode we lookup in the fs/subvol tree for xattrs and
> if we have any, log them into the log tree. However it is very common to
> have inodes without any xattrs, so doing the search wastes times, but more
> importanly it adds contention on the fs/subvol tree locks, either making
> the logging code block and wait for tree locks or making the logging code
> making other concurrent operations block and wait.
> 
> The most typical use cases where xattrs are used are when capabilities or
> ACLs are defined for an inode, or when SELinux is enabled.
> 
> This change makes the logging code detect when an inode does not have
> xattrs and skip the xattrs search the next time the inode is logged,
> unless the inode is evicted and loaded again or a xattr is added to the
> inode. Therefore skipping the search for xattrs on inodes that don't ever
> have xattrs and are fsynced with some frequency.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
