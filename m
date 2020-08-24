Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00887250719
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHXSCK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgHXSCF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 14:02:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C695C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:02:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g26so8297648qka.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GWeZRispZT9vQbQktYeXxjTBhlOoelcaA714J4CCZsM=;
        b=1JaVzW8cnmh7Gp57P+q8aOh29zjCvAlC60C5YXU5mRkzdsnOUkv4b0bO3wJmDUFUIa
         NifXsKRB9te6m4r6uHSsd1QPSZFmUYChpXMndw+/43BIgWi13ZyqUs3xgp6x2RpgtGs6
         ZSTt1sivfj3R5gn0hOzsmJzf29mUS/XDqB+wgfIOaHjrgvJnzALpJmlMjPJU+9WkTiB0
         BB3aSDFc86nyEyEQgW6azy9MfPRsXfPealNBqY7IN5Q9aTY7TQZ0MTqy1gUZtr/HOi2G
         /HymJFVJRlLhpdzaZ8UlgKRtjtwIU6y7Xve0apJzHfskME+MzMfBJr1ZiBg07X4phwNW
         U7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GWeZRispZT9vQbQktYeXxjTBhlOoelcaA714J4CCZsM=;
        b=mhowY2nP2K824mPutFM0+tAEUIAcr+o8+PCOUbzUkKj270zo5VyHOGtX9rndrKEkpi
         oe8sNjYD3gKoHqsHZTZ+L4PTAoFbIlw7L3K3obdcONLl6ybE411yC2X+/oi3sGXY7EBc
         uugR9fmCuQ+IsZ8XrwBmxB5C7yPwUP533X/IizzRahdrnr0UdiN8CPCny3ki9XtVVNI6
         rszXSnrwjY18u4bZN1TlR5wGvTSCoOkFrkkJX16BeY2t4Ql/rZdWzam+XJtNC4FTiYkz
         1UdZREM0Fimamcr3Qn9S3YD1MU0i6RfSvDqnlvcnNjOXJtLYesN5jhVGIJB+HUEnczzb
         hLVw==
X-Gm-Message-State: AOAM5324omWFJ9nNid5qvu7tThCZFMt0kReQ6Cz9UHyQ9Oid/T/kkNlm
        wcf9fxHskwDHpuM9+saaAncUq1quxWbfjsWJ
X-Google-Smtp-Source: ABdhPJwVweuhFMzibqW81WRxxgZwkXKbCewxBfVm9qrUqwLe0zavrr9I7dfToqwXpui98DuRbeSiVg==
X-Received: by 2002:a37:89c2:: with SMTP id l185mr5748523qkd.41.1598292124517;
        Mon, 24 Aug 2020 11:02:04 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y194sm2041241qkb.116.2020.08.24.11.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:02:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: qgroup: fix wrong qgroup metadata reserve for
 delayed inode
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200724064610.69442-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0024edba-5cbd-2da9-8ed1-42cc46414c90@toxicpanda.com>
Date:   Mon, 24 Aug 2020 14:02:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200724064610.69442-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/24/20 2:46 AM, Qu Wenruo wrote:
> For delayed inode facility, qgroup metadata is reserved for it, and
> later freed.
> 
> However we're freeing more bytes than we reserved.
> In btrfs_delayed_inode_reserve_metadata():
> 
> 	num_bytes = btrfs_calc_metadata_size(fs_info, 1);
> 	...
> 		ret = btrfs_qgroup_reserve_meta_prealloc(root,
> 				fs_info->nodesize, true);
> 		...
> 		if (!ret) {
> 			node->bytes_reserved = num_bytes;
> 
> But in btrfs_delayed_inode_release_metadata():
> 
> 	if (qgroup_free)
> 		btrfs_qgroup_free_meta_prealloc(node->root,
> 				node->bytes_reserved);
> 	else
> 		btrfs_qgroup_convert_reserved_meta(node->root,
> 				node->bytes_reserved);
> 
> This means, we're always releasing more qgroup metadata rsv than we have
> reserved.
> 
> This won't trigger selftest warning, as btrfs qgroup metadata rsv has
> extra protection against cases like quota enabled half-way.
> 
> But we still need to fix this problem any way.
> 
> This patch will use the same num_bytes for qgroup metadata rsv so we
> could handle it correctly.
> 
> Fixes: f218ea6c4792 ("btrfs: delayed-inode: Remove wrong qgroup meta reservation calls")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
