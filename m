Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F602A872D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgKET2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 14:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKET2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 14:28:50 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B90C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 11:28:50 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id da2so1262122qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+aYHqsBNH7FvG1cjfVfGk5W5THbUgEDUI69L6b9VKWo=;
        b=jCzj7ylToW8/ut/EuRGnmSKqR7mtAAhLf7cUIEZXZ5/JgGlUFrf+K/syB+sD9IKmAj
         PK+o7L9dAL75zmH1HOzBiASbkPUeik1oEsv8OYD7Mcns80YPjnc8cybDCRh2X2WVJPWo
         +jAM1yGMfpu+E7XkjFFMtfS7JZfDqoMayLopMLuPM3yOLAaL5WaVoOoUuHNpvLC8RBKe
         haNwEE04dSD0OpyAEJv55Qi8RrPwyBT2S5jSbJbFmQyoCQ1RtB3pwlWa38BRcl79ozBO
         HpC3F5jzkh9HIAgU3abf3qw5GtbmRvEf8uzQVDBNVAO1hqijskgtGPxbttCgk+7yfzwl
         ldZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+aYHqsBNH7FvG1cjfVfGk5W5THbUgEDUI69L6b9VKWo=;
        b=SmDPsvNRyO/6UPbvD85jcB+Lce6dwDCPRpkoAo18KWyw0SrkkF3PHEcarI855TXbqT
         MXwVHrLhX4hXCu8yYzPt3U6hxMuyZuH9CUX0M18t4g5j1GDOE6SXFnceL3p7ES2eP7VZ
         wRRxQiCCSqYHh5boHKH1p8imHHo2IChbyrf7ZpizyQbbKtsW1cHVnqEWBztkcmLIbURt
         h6ZFKm5q6lQSdb/dRdz1gu5HB9KbkwTYGDWtHo9kAPgMSRunflNo7F8UCCkginqJVAVS
         wE+2JHnqE9ixe1VCxOAiwziSKaNxwGFNa0edvBet4HYSAmhehMe8fGIx37RcGAjgjLCy
         Bq6g==
X-Gm-Message-State: AOAM532ZvHFWNsltWxnAV03IJoQzUJK1euXPYN0a5O7DxYA6qklMuhbn
        yaevRJspf/sm4HZzBAVKI5vbbzBpCQbhq2dn
X-Google-Smtp-Source: ABdhPJxekeYTmw4R/4VCsEeObQQ4OFLxaFXJJmCBLYlUGubtvYsMY6RzHOA/cFTQN44qr0EjVwsdLw==
X-Received: by 2002:a05:6214:16d0:: with SMTP id d16mr4058195qvz.38.1604604528338;
        Thu, 05 Nov 2020 11:28:48 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q1sm1531583qti.95.2020.11.05.11.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 11:28:47 -0800 (PST)
Subject: Re: [PATCH 00/32] btrfs: preparation patches for subpage support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fd706714-c4ae-b1a7-44e8-68249b94bbde@toxicpanda.com>
Date:   Thu, 5 Nov 2020 14:28:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/3/20 8:30 AM, Qu Wenruo wrote:
> This is the rebased preparation branch for all patches not yet merged into
> misc-next.
> It can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage_prep_rebased
> 
> This patchset includes all the unmerged preparation patches for subpage
> support.
> 
> The patchset is sent without the main core for subpage support, as
> myself has proven that, big patchset bombarding won't really make
> reviewers happy, but only make the author happy (for a very short time).
> 
> But we still got 32 patches for them, thus we still need a summary for
> the patchset:
> 
> Patch 01~21:	Generic preparation patches.
> 		Mostly pave the way for metadata and data read.
> 
> Patch 22~24:	Recent btrfs_lookup_bio_sums() cleanup
> 		The most subpage unrelated patches, but still helps
> 		refactor related functions for incoming subpage support.
> 
> Patch 25~32:	Scrub support for subpage.
> 		Since scrub is completely unrelated to regular data/meta
>   		read write, the scrub support for subpage can be
> 		implemented independently and easily.

Please use btrfs-setup-git-hooks in the btrfs-workflow tree, I made it 2 patches 
in before checkpatch blew up on something that really should be fixed. 
Generally I'll just ignore silly failures, but for a series this large it really 
should cleanly apply and adhere to normal coding standards so I don't have to 
waste time addressing those sort of mistakes.  Thanks,

Josef
