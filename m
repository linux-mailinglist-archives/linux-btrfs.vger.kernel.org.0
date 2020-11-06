Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0172A99E5
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 17:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgKFQ4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 11:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFQ4Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 11:56:24 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D439C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 08:56:22 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so1673812qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5DPyLTvKCkZu5/xFD6a34X8cFJzkX/jTMspZzaDlUQY=;
        b=xdEJ3w3LAKxJ/k6A1HSOj4ibxzb/mFf9TjV0OHVUssWPVpWT0S5+Wt0Vtjyf54jUVh
         fRDmilERMoxrzC1rjr9008Ou4qGDJfTeplCp3sDcEg2FYv4163//zwGIAO05sgq90sKe
         j+HfBY8a91ehEGfTtOo9i2l748XN0hfNyutnGDP3CA0Xo4UGF0XLHqQTJVtCZWIqWgG/
         wGRQXigjLJlyY4Oq47mI5Pg8MqQQyqBGgHc1KE9NtzeQmQ8apb92ciLmokuoBqz6RW9C
         2WxXcl74tFsixTVuOQkvmgIuG9AUy6lW8Ch26E1jVtIHqI5EATbCH9SAgxHYNmcTP1Dp
         c5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5DPyLTvKCkZu5/xFD6a34X8cFJzkX/jTMspZzaDlUQY=;
        b=Pt8kx0dIVghBuCuzWxDVJZp+en6PE7UGWAqrmvA5Uwq13QF3MgX+pZDHnSu3v6ORHB
         RWZF1hbZss7yHiLcFkiOP5Ob07U0UeUKK4iESKN0KFfjxSdYpJo3Gf9k7gBAI03Fppp/
         Zq5vzseYvSk5WibF72Wp/yqzwDM/p+Zffgi7fwcrnFa1vMRGobdiUEjfzpmlKnYGUbcV
         d5OYGUllTFdnOvnrTe+Vp8jecRk2BfNN01OFok4epPngQVOs5BU5wa+uX8Asg61o6aeo
         ZnaroGmRxxuW446IYOctfFTmZ5yeGOzfPaq29r/FueyVbX1rSjm/3Uh40Ebmn4fKAtO3
         dfww==
X-Gm-Message-State: AOAM531CQmfONjbx77WxoM6A5fJrMJfvrGNJX+XI/xeJgHc4CqJbMsX5
        ueKGupAZI55YLIeaYfgaMP6C2w==
X-Google-Smtp-Source: ABdhPJxbmBraJRitK4KYTTO6kbkOZY/riJXgxnRTQI6jFzcjNJjdK+QcZv7cjY5nvT7omtDrVVa/OQ==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr2456795qkb.305.1604681781870;
        Fri, 06 Nov 2020 08:56:21 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y17sm849348qki.134.2020.11.06.08.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:56:21 -0800 (PST)
Subject: Re: [PATCH 2/2] generic: test for non-zero used blocks while writing
 into a file
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1604487838.git.fdmanana@suse.com>
 <97125f898446b152fd759eba2f2c5963d3daadc0.1604487838.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b2ffc7e2-32d6-3bbf-c54d-bc1629be6e61@toxicpanda.com>
Date:   Fri, 6 Nov 2020 11:56:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <97125f898446b152fd759eba2f2c5963d3daadc0.1604487838.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 6:13 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we keep overwriting an entire file, either with buffered
> writes or direct IO writes, the number of used blocks reported by stat(2)
> is never zero while the writes and writeback are in progress.
> 
> This is motivated by a bug in btrfs and currently fails on btrfs only. It
> is fixed a patchset for btrfs that has the following patches:
> 
>    btrfs: fix missing delalloc new bit for new delalloc ranges
>    btrfs: refactor btrfs_drop_extents() to make it easier to extend
>    btrfs: fix race when defragging that leads to unnecessary IO
>    btrfs: update the number of bytes used by an inode atomically
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
