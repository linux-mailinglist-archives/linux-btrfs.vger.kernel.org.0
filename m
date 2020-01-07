Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE51329A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 16:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgAGPJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 10:09:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43807 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgAGPJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 10:09:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so7369qtj.10
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 07:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6jQcElx8+Umro5S7+A6uC5pOcr2HaJAQ+/rC7j/65rM=;
        b=HavZbh65rsHM3S6wPHfImgPjuf0o69Gowghj3C1rTSQSoTLwxGtgsCbzz6XEIn5VEG
         uc7B7WQvvwRf62uUZxxBQD+GB4eI01+zanZrCqH81+3TYUm0hxey6CCTs4lHYGZ6vDST
         vSji+Wo3TtKR1TZXXzb6kUuOFdATz8/sMiVpvniFMsPiAGU2uTYCfTDYLBn2GAi/xJhV
         RlrtEzjyn0oJ+aEhdF1+2twCCQFpUcwjQYsxrHRyR/nVRE+q+r6SZYCHkH/scnjdQ5lP
         doKMw80RBAtTfD4UaZw3bhytSK97/lAstIDYF0XnkYgG4nISEJFNoP1KGkRj3OUkX3e0
         apnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jQcElx8+Umro5S7+A6uC5pOcr2HaJAQ+/rC7j/65rM=;
        b=NxigpKrf3TYZi9rIV/sIKzmpM4NpsfsJL2anzhxpUQ4x5meAa8kFxUphTm8IE3KHeB
         +F30LjOk+xTDmalsbLZ5ZSSEhS6PXs59IEMu7VyrcvGVxCV9USiMsBvPclgXYl8bgzfD
         X3Fd/xp1dlKY7RF8O2bR3R9JDD2vcKqllUnp/rTJL6704dVi/S24LH0pcddjzNJbSmGl
         nQ0kUmGESrklNqnJf+L24tvfrMapHzkDGpDtNhPn4XRah6jzBwAJEdKPXgbvQhRP4pM7
         KQ55kGJFnPeNVMTB0qZWfu8Yfmx4EUs97QbiiPzRTnp0zZcu4N8pCeg22X1HtkYaerSC
         1c7Q==
X-Gm-Message-State: APjAAAXm5jPjNmqSKfasQqy+aYme8fUBTX+LfAItg/EROag5m5wh5ze8
        xJpi8sRBWbQNdbuk+qL2K2aQk/gyCf7mvA==
X-Google-Smtp-Source: APXvYqy0KSstD/PbBc/Ixc8lTYcGMxYbFrLkiKjh45JWC6eJ9cfusT+llucHMGblTw1FNs2bt9haqg==
X-Received: by 2002:ac8:8e7:: with SMTP id y36mr80310376qth.26.1578409774319;
        Tue, 07 Jan 2020 07:09:34 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l62sm22620700qke.12.2020.01.07.07.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 07:09:33 -0800 (PST)
Subject: Re: [PATCH] btrfs: kill update_block_group_flags
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200106165015.18985-1-josef@toxicpanda.com>
 <4bc7e4f5-c370-4e0e-405c-5d3aa67f95b0@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5d39b16c-627a-1472-2d4e-d6861ec03c8f@toxicpanda.com>
Date:   Tue, 7 Jan 2020 10:09:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4bc7e4f5-c370-4e0e-405c-5d3aa67f95b0@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/7/20 6:08 AM, Qu Wenruo wrote:
> 
> 
> On 2020/1/7 上午12:50, Josef Bacik wrote:
>> btrfs/061 has been failing consistently for me recently with a
>> transaction abort.  We run out of space in the system chunk array, which
>> means we've allocated way too many system chunks than we need.
> 
> Isn't that caused by scrubbing creating unnecessary system chunks?
> 
> IIRC I had a patch to address that problem by just simply not allocating
> system chunks for scrub.
> ("btrfs: scrub: Don't check free space before marking a block  group RO")
> 

This addresses the symptoms, not the root cause of the problem.  Your fix is 
valid, because we probably shouldn't be doing that, but we also shouldn't be 
forcing restriping of block groups arbitrarily.

> Although that doesn't address the whole problem, but it should at least
> reduce the possibility.
> 
> 
> Furthermore, with the newer over-commit behavior for inc_block_group_ro
> ("btrfs: use btrfs_can_overcommit in inc_block_group_ro"), we won't
> really allocate new system chunks anymore if we can over-commit.
> 
> With those two patches, I guess we should have solved the problem.
> Or did I miss something?
> 
You are missing that we're getting forced to allocate a system chunk from this

alloc_flags = update_block_group_flags(fs_info, cache->flags);
if (alloc_flags != cache->flags) {
	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);

which you move down in your patch, but will still get tripped by rebalance.  So 
you sort of paper over the real problem, we just don't get bitten by it as hard 
with 061 because balance takes longer than scrub does.  If we let it run longer 
per fs type we'd still hit the same problem.

In short, your patches do make it better, and are definitely correct because we 
probably shouldn't be allocating new chunks for scrub, but they don't address 
the real cause of the problem.  All the patches are needed.  Thanks,

Josef
