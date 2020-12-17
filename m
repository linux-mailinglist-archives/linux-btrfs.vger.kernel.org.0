Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C292DD53B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgLQQ2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 11:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgLQQ2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 11:28:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAACC0617B0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:28:12 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z11so26883460qkj.7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mbzpBCGhU9THHRTBeA0Ip/ckdVw6fJqozA0HkKle2iw=;
        b=mMXFZjZ4YlUV0B7m3xspeeIn34tloJCGPlaqVUZcFhAWk+J6rptSqFSpyGzNCnv3ZS
         8VizbX+mGaOki0fFn+rsH7RLCLHSpJSyxFxy+LWVS4z/R1vnEG/iJ5DqB6/AR41jFIyP
         pHnJAjZdP3UMR4MOXBuUK/j2HZwvCYiSEszp9tx+8lmcHncjtG29KdwBqnXZxysFXYW3
         uQz6SPo1WepHh4NFErLTjQC+A6QsF52wPvcbxVsuSPGnR1UE8vFaUSWRUA4rzJvcA0mE
         bFD9nv3ITtZnIux28Z7AArJXh4UCdjWYpCMYmopvEs8ze5WOpy6/NfvbIGFCS4H2ofoE
         71xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbzpBCGhU9THHRTBeA0Ip/ckdVw6fJqozA0HkKle2iw=;
        b=IFEiUpyaoN+09cF84+6yjnd9TfI2KxXCOech2S9fkNZ5LG2VYFc17qmz8Su1L8w2fd
         IxXDCykkPR4iuzOej/o+pr/xMOoBqslr1p0Gkcygn68Of3VyiEB8raeUKpc0ht44GiNs
         1+pP7CrMDTWSqY8FKsx94v0q42+74niBvA/s47UhsilaHxyJfhfCYIPpagun3wbLEwTz
         Uy9h+lggRE/mk/TBseMMaGQXwYmczUHXYxK9/WEQPX7XvF5PPDtR2VMPwgEwASWm0Wlb
         N2qo8s+fZq5Kxb1qzvp+T+2NBz3ME3HxElg93PkDBdx+OeMMhqh+OS1SUNaW5y55nuG6
         z8ug==
X-Gm-Message-State: AOAM532+hE6Gmi918FvXwNBIFmH0BpASslZw+ZYyrQfOVnw2xBzzwzZW
        lgnvtQ91jEyM4Ptk6oyLuYqmBg==
X-Google-Smtp-Source: ABdhPJy8FqS4glcub/9s1peMCvYhZFtSztHuBt5ioA8vAnElOXM7NyzQ6Os/FiOo0I4XGrBbpF6jyg==
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr45201qkl.132.1608222491965;
        Thu, 17 Dec 2020 08:28:11 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm3422571qtg.85.2020.12.17.08.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:28:11 -0800 (PST)
Subject: Re: [PATCH] btrfs: test incremental send after removing a directory
 and all its files
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <ea077f0f8a54ab3ea303494e45eb1b166de7e758.1607602049.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1a37ce73-ba32-ef51-3e0b-052eaa483d35@toxicpanda.com>
Date:   Thu, 17 Dec 2020 11:28:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ea077f0f8a54ab3ea303494e45eb1b166de7e758.1607602049.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 7:09 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation succeeds, and produces the
> correct results, after removing a directory and all its files, unmounting
> the filesystem, mounting the filesystem again and creating a new file (or
> directory).
> 
> This currently fails on btrfs, but is fixed by a patch that has the
> following subject:
> 
>    btrfs: send, fix wrong file path when there is an inode with a pending rmdir
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
