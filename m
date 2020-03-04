Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C56179870
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgCDSze (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 13:55:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39689 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 13:55:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id e16so2718049qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 10:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f/Wc7uqG1cNORb6bzPd5jp244nd9e8KnpJQrCpu+tJo=;
        b=riFAZkSAvS+UV1CFTEalRudUG6QnOsBPB6w70y9tzmhifVIPzrptI/fWK1/wlO9C20
         CNnrVcNsM25l7eWG6FEsVxsvrxuQ7IMGTaw3kCZU0WVTCDUBKt1Twd+U9uU9UHJFmSK2
         rr4qtZ3GnEkJIaB3YTwZg38opVNhxjLSa10hg0R8tLsLwY0eecDOCj/0GRLTRthCq127
         ss7TTgDMri9Vl/QOn0Q0o/PZOpWkcG0lkojMeZOKO3DkkLpa5R5O5R5B0IN4einaErcR
         rUZ89HQC5mhS8G8N7x3kfqx/C5pqu3HsHjkP3Cm2S1Gsy87bQOqm0yVC8URBZEqyasgM
         Bd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/Wc7uqG1cNORb6bzPd5jp244nd9e8KnpJQrCpu+tJo=;
        b=de7+Wcup0KAKJhYNWga4IJOTZBIhDflEauG9CBjjMk+jziJANHr3haeiAg2V+8N/i8
         t6sA/ek+LG8n44G2bBWyJKeUgMdUA5RwnBnSiyPQJ//YlqB7rbe6Ro2+NajUG/rb4YzU
         Q8nxv2BQOELGFbyF9zENRwai7slkSQoqjsFNsBYENlG+Z47usp+3LJy9nGe2VaDzlbQ8
         5X+5taX/6iXgMzzSexMp/6EXwOMdSQDoZC+bV6UlwXiWT1oWigUJRYhxpXxE92VmiMS1
         KzPR38q2joZ79Chb9oKUDadJ3wFSsQ6IhJKVPx2nfCm2HD2sVHnFXwcASVRqAmDEVsJ/
         qFcg==
X-Gm-Message-State: ANhLgQ2Y3ybLVnrepZXQc7ktwtfmBZipPm1qHYC+TF2Rb6IRpxT+uWKi
        rxSO5gtaNJdi01JlSj3q4/5pAawk5Zc=
X-Google-Smtp-Source: ADFU+vtz5ByzXN4YRGUANU9O5A+wrSkgBzsu10HFRn1HddZxDSszGILPZavVnlhjziiwpvOTY1GIrg==
X-Received: by 2002:a37:4d8b:: with SMTP id a133mr4338778qkb.14.1583348131597;
        Wed, 04 Mar 2020 10:55:31 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f5sm12236394qka.43.2020.03.04.10.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:55:30 -0800 (PST)
Subject: Re: [PATCH] Btrfs: make ranged full fsyncs more efficient
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200304103404.5571-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <31fce27a-510f-3f63-a029-2722c6e20b05@toxicpanda.com>
Date:   Wed, 4 Mar 2020 13:55:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304103404.5571-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/4/20 5:34 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit 0c713cbab6200b ("Btrfs: fix race between ranged fsync and writeback
> of adjacent ranges") fixed a bug where we could end up with file extent
> items in a log tree that represent file ranges that overlap due to a race
> between the hole detection of a ranged full fsync and writeback for a
> different file range.
> 
> The problem was solved by forcing any ranged full fsync to become a
> non-ranged full fsync - setting the range start to 0 and the end offset to
> LLONG_MAX. This was a simple solution because the code that detected and
> marked holes was very complex, it used to be done at copy_items() and
> implied several searches on the fs/subvolume tree. The drawback of that
> solution was that we started to flush delalloc for the entire file and
> wait for all the ordered extents to complete for ranged full fsyncs
> (including ordered extents covering ranges completely outside the given
> range). Fortunatelly ranged full fsyncs are not the most common case.
> 
> However a later fix for detecting and marking holes was made by commit
> 0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync
> when using NO_HOLES") and it simplified a lot the detection of holes,
> and now copy_items() no longer does it and we do it in a much more simple
> way at btrfs_log_holes(). This makes it now possible to simply make the
> code that detects holes to operate only on the initial range and no longer
> need to operate on the whole file, while also avoiding the need to flush
> delalloc for the entire file and wait for ordered extents that cover
> ranges that don't overlap the given range.
> 
> So this change just does that, making any ranged full fsync to actually
> operate only on the given range and not the whole file.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
