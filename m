Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC78521D797
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgGMNwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMNwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 09:52:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CDC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 06:52:53 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h18so5787227qvl.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D4xea+/r92X4M9SX3ifcduy8t3A5uHTTJe/daec/RT0=;
        b=NtvqCwKPDfW2Mw+FHjebRLDa88ZaRPA3fK75DdgX/1ym9v4E6Evv1EMridQM0xBO88
         TQ0nE3+nzKIBuAsfjeLPXudujVmy+fwvphJmOXkdlxG+su+hxHaIItV1ntQIn/llACbt
         ROGOKM7FvOtol0HVZgukX/T7wq8WcUOWzE9dMkrJz8C2kLOassGXjo094wX2fSGPmiBW
         0GMzBUaIdi2N8HAAwwSYStz2w0Nct/6pehQH5PFz41y86u/2qEvWNRlvXFvPv2kaEYpk
         WSa+PQ1p0oPFup1ZaqaYd0i5FeB9nlMWIMqJwKWfV3f2mbNlXo3oc97GE7UF0IhRfdc6
         pvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D4xea+/r92X4M9SX3ifcduy8t3A5uHTTJe/daec/RT0=;
        b=iw8cDdt+f6/RJWsWfWdfemRIE2KRhMkmgreSF8fC77I0mQkylNV+DSSJ38HCc+037D
         sX0qym4XcwVPG3Z3FhD6LRrLWEXcvQ7bN9OQ3bWbBuD9dMFdj8kmGa5s9hR7Xvd38Bsa
         K1lFJK+3sIFn/XoygHqWcdqHzhz0DL2505FArO2b8cZTUbs/crC+bE/e+YY3z1fDQJDe
         /2gXsTkpd/yz7chVLRZ2P/o3NNa3EskSnDGhWXr311PzWfiIiuyDjGwm1n1tYkUxpQ97
         75ZeO73waucUc/e2B+34fyQ8e/eafY5ZHr4vN35j7GeK9ZT02MSOHnsNuRTLTj6CdrZ7
         9Heg==
X-Gm-Message-State: AOAM530oNcvg9qltz20RoIS7N57Okb5xXeCP1eUxdGwWPoDIDMYR6FBh
        SCKZ9fjzX4VQVGINBctWANDRvk6vqMCeFw==
X-Google-Smtp-Source: ABdhPJzNDp6si+UVKveuAa2Va+zH90Z/r2KNZCm3Y+8UBVJrPULDIbDXz4V/8OLOmKvscTNKpoZhbA==
X-Received: by 2002:a0c:b284:: with SMTP id r4mr63570222qve.141.1594648371934;
        Mon, 13 Jul 2020 06:52:51 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l67sm18899831qkd.7.2020.07.13.06.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:52:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] btrfs: qgroup: allow btrfs_qgroup_reserve_data()
 to revert the range it just set without releasing other existing ranges
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200713105049.90663-1-wqu@suse.com>
 <20200713105049.90663-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a3c672fe-4fb9-c623-fe8b-89ecce8cc3f2@toxicpanda.com>
Date:   Mon, 13 Jul 2020 09:52:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713105049.90663-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/13/20 6:50 AM, Qu Wenruo wrote:
> [PROBLEM]
> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
> reserved space of the changeset.
> 
> For example:
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, 0, SZ_1M);
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_1M, SZ_1M);
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_2M, SZ_1M);
> 
> If the last btrfs_qgroup_reserve_data() failed, it will release all [0,
> 3M) range.
> 
> This behavior is kinda OK for now, as when we hit -EDQUOT, we normally
> go error handling and need to release all reserved ranges anyway.
> 
> But this also means the following call is not possible:
> 	ret = btrfs_qgroup_reserve_data();
> 	if (ret == -EDQUOT) {
> 		/* Do something to free some qgroup space */
> 		ret = btrfs_qgroup_reserve_data();
> 	}
> 
> As if the first btrfs_qgroup_reserve_data() fails, it will free all
> reserved qgroup space.
> 
> [CAUSE]
> This is because we release all reserved ranges when
> btrfs_qgroup_reserve_data() fails.
> 
> [FIX]
> This patch will implement a new function, qgroup_unreserve_range(), to
> iterate through the ulist nodes, to find any nodes in the failure range,
> and remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
> the extent_changeset::bytes_changed, so that we can revert to previous
> status.
> 
> This allows later patches to retry btrfs_qgroup_reserve_data() if EDQUOT
> happens.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
