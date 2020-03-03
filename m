Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9411784D2
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgCCVWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 16:22:18 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45920 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgCCVWS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 16:22:18 -0500
Received: by mail-qv1-f67.google.com with SMTP id r8so5927qvs.12
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2020 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yMMBANE3tNezRt6NcXxHFD/pqFxGZevL6fCwu4I8lD8=;
        b=kNJvAZPpup2U42fYxPG6NUW6cpIDxnxbz3qOPGIwP3HxljVHG9pMGGc/PGqZF+sy6k
         oDDWTQYmrHVwUOxOlmGYOMrGnt4W9tbO+gJb2NLGWo17Pj6SFnUHetSU1FS+I0RViBub
         2dn6dZYjGGrRz4KdN/N+B/U571sTOX0mAgSq2DSyJzS5h8lNzOLs0OdbX32z9gUaPoE0
         TiJO5zIJk+vRX0AqdGEqY++Ja5B2d+OTxUkYVh4fnFJrAk1R0SxeI6zxb3eC7vpyEwWg
         2Smr6+BkIqTxHH+tOiMv+4+bN8yupoWhniQPNSgYr6Wh/q2K9PICnl74EbCrm1heLmYT
         rbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yMMBANE3tNezRt6NcXxHFD/pqFxGZevL6fCwu4I8lD8=;
        b=nmu0xi2A96+8DsNi3CjhKGx1C/kpZDmrSlD1EFUrKYExzF0UsJq1BKTJA3fyIzViQc
         o9OaUUc33p2VSKWiQ7EGVHlA+8h00sRyhab6Khai0bBvBIm+f7fTD5SpuhF5M2Ul+e37
         8f6e9QzRObWsbZSMms65ZgJLh9BTa2/PdGixw3Z3z/GUv1CSkOif0gCNBOl8ZGHObkO2
         xLGADhILNgR8hivtx4cKS2//IbRUBWDom6CTgkZNLgKSS15/Qzugb0pJKtY21VILUmo3
         g76dOZ4mqY3lrtJEi7mp0iZHGlcESLNbe2xmWc4PyBi6PB1ntEgKKHbLfe+8hL1IFef4
         BLwg==
X-Gm-Message-State: ANhLgQ2wn4lRst7mD+ZyVdvporSYkOWl/yx8ZygypcggPJnlYm00iC29
        +oLLAF9m+ZCSsmqqR06CE8Uw6v9ZUL0=
X-Google-Smtp-Source: ADFU+vtw5ngU7EtvhbPdMyzHl6MnsJ1nI7EM7J9d9oPUClIEfVvCDooWl5ND/E7hnWEfZ6btwSN4CQ==
X-Received: by 2002:a0c:f707:: with SMTP id w7mr5812894qvn.46.1583270537040;
        Tue, 03 Mar 2020 13:22:17 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a7sm7530811qtw.28.2020.03.03.13.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 13:22:16 -0800 (PST)
Subject: Re: [PATCH 00/19] btrfs: Move generic backref cache build functions
 to backref.c
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200303071409.57982-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b6520f1a-4849-4390-6aa8-e08e69bebcd8@toxicpanda.com>
Date:   Tue, 3 Mar 2020 16:22:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/3/20 2:13 AM, Qu Wenruo wrote:
> The patchset is based on previous backref_cache_refactor branch, which
> is further based on misc-next.
> 
> The whole series can be fetched from github:
> https://github.com/adam900710/linux/tree/backref_cache_code_move
> 
> All the patches in previous branch is not touched at all, thus they are
> not re-sent in this patchset.
> 
> 
> Currently there are 3 major parts of build_backref_tree():
> - ITERATION
>    This will do a breadth-first search, starts from the target bytenr,
>    and queue all parents into the backref cache.
>    The result is a temporary map, which is only single-directional, and
>    involved new backref nodes are not yet inserted into the cache.
> 
> - WEAVING
>    Finish the map to make it bi-directional, and insert new nodes into
>    the cache.
> 
> - CLEANUP
>    Cleanup the useless nodes, either remove it completely or add them
>    into the cache as detached.
> 

I've found a bunch of bugs in the backref code while fixing Zygo's problem, you 
are probably going to want to wait for my patches to go in before you start 
moving things around, because it's going to conflict a bunch.  Thanks,

Josef
