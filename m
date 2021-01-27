Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804C53063AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbhA0TCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 14:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbhA0TCl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 14:02:41 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCEDC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 11:02:01 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v3so2232920qtw.4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 11:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+zdCQYNroZr7KRa8Sz4mdHYhkladr93tpiW6/fYQBU=;
        b=nJ6wViNiFJY9ooDT/V80WsdnqBMEY3+j7SV97WqD93+WNxmNatmd+QfuUTX/tSwj0A
         83+TfuaY0/IQXXbUNDyPad0xzse7p6X+MqeqMYOwIeBuFDH4FiUydTZz788bTMA+MmmX
         ZUP7d8qrkWN4SgfSvzlfSBZsIfoIl1DhGf7GCbtqxlsacmA/l+hB/23ztc4pNWDruvoy
         DBfQDF+8R1K/lOPUTXVYpbxGVkYypy4r7tRP2LtbYPg6T8nnCNp4RXAG+FsXBPXVhw3j
         waERPrmyqLUqIc3qX3uvO2TISSTaM/3T8Q97qx4tOxrQ2lzhbANLdPo5jXKZFw2MiHun
         F6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+zdCQYNroZr7KRa8Sz4mdHYhkladr93tpiW6/fYQBU=;
        b=YDCaT9fTnwWbJLkIKAgQeK6Ecq7O8xcTmjK5fLllJUYiJjd9BOspqLlLyZLPt9luZQ
         tkKmDiglPzvzbtbMGKvXv296iOP3wK/nRlPcOi1i8a0gW6krtjQKvouPbxwHHVWC7U77
         Oyn2Nq9DFx2C4v9T0kcImXK++XscM2qrmHbu2HV6cF95ztJa38qH+RwWCIFNyvUmdQ2p
         eSzzX07Y7h1AZyNlT7YcAdTMDTCgO8sbnxJOyO4CDh92nKCTPU5ww/BugQf9XX3nZEws
         4LirBBhhT7VwUAJ3uqPtmVWqzLg8zF529mpYJCLqdgh9UqPrAI4mPNSZWGEaHbD5nDvo
         2icw==
X-Gm-Message-State: AOAM530OgxE2oIIHrZNLLVRWfRB4HbVKBCfQLJCaqcOYY10rPH3c5z51
        ozirTX9vR5Sdby3xYz2VrolZnxyIrJuHfBg0
X-Google-Smtp-Source: ABdhPJyG5pn4hfZ5Ld8Tvrwwg0/91hGf827U9FpU8djYqILn4GeufPZPjDz0Xc7J8TfAwOxsp0HiOQ==
X-Received: by 2002:ac8:6c50:: with SMTP id z16mr10970890qtu.112.1611774120771;
        Wed, 27 Jan 2021 11:02:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s11sm1686226qks.136.2021.01.27.11.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:01:59 -0800 (PST)
Subject: Re: [PATCH v14 41/42] btrfs: serialize log transaction on ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <cf8cd6170bd2283524a89a8192eeaba769a98fd6.1611627788.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <76dd9d7e-0a49-2775-2edb-b0fbdc358455@toxicpanda.com>
Date:   Wed, 27 Jan 2021 14:01:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cf8cd6170bd2283524a89a8192eeaba769a98fd6.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/25/21 9:25 PM, Naohiro Aota wrote:
> This is the 2/3 patch to enable tree-log on ZONED mode.
> 
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at the
> time of log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same mixed allocation problem.
> 
> This patch serializes log transactions by waiting for a committing
> transaction when someone tries to start a new transaction, to avoid the
> mixed allocation problem. We must also wait for running log transactions
> from another subvolume, but there is no easy way to detect which subvolume
> root is running a log transaction. So, this patch forbids starting a new
> log transaction when other subvolumes already allocated the global log root
> tree.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
