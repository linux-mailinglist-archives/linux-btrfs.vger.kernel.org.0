Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C22124F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgGBNk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgGBNk5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:40:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053DC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:40:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so25584122qkn.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N8Apmy4ZTTxo9Py9Y+fwUDHdCIAxS0fH77UnbV9zLik=;
        b=kzBUDAwDogrW9ODwvK1Z0o6iaqsD4obGlUa3N/bRVdXZiKv/rilXvWZSQ2qgaf6WsA
         +RZ4luyHcE9m2WCBgfAOjNySQ5xKVVYVq+TDNr/fHCRR6713RT0VvxcAIsGQCC0huuDB
         sn9pXNO2VIHZzrn7rCWGwlZkL2HD+Uaj+1MUURoCtuyjIszhtl759CGgoMhgP0Rnvpbt
         Sq0AUo3j3sF3ePginTlIarVFEFflEBT9kTZL4+6lHFbIvXQhTX4meS7eo3TWPUnxj/O1
         sxQyE4RLge/EWjNGbV9lt3F3BiFWEa9rjR+EAng8Qp2F8DJZ3aF5uDOBVHUQeGrfyoB6
         nLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8Apmy4ZTTxo9Py9Y+fwUDHdCIAxS0fH77UnbV9zLik=;
        b=fzJDMwgwGrf/uaCXA11fMo+XMkqf1yvNwWIwbODYiVMwJ825/q7VadlstiaveFzubc
         ZyQXzrVs59VrvDsk2UBeOx+qjvE8akwOgLtsbOmmNYKPLFaXlL42UflabcaID/fqrvCf
         4ZBWsinjSEx3vOiTsOQnh4G8ElVaELq5AxfxXx3Xo7lWSsotowSz+oG6nMvv2Y7E/9sg
         8M3TnFEWY2I7jljYuDCRNsbezgdZa/4ostJUn7Nx6tKU83AmyN0o99HMzUGNEwNqSEPa
         ICaV097OAHE/sfCm3xep2A1gYRuSdAjNI6vAksE50csgc1yvApwvLMGdZOeqQ/8JvPx+
         r+JA==
X-Gm-Message-State: AOAM532TLFMg0CICVEzctrBgxy6tSmkw5tQzC1sqXAGE03IMKXdZcG/q
        oz9ZPNq6ExzSF3bmqn2RjH6cpDNQx3Lg5A==
X-Google-Smtp-Source: ABdhPJwn6ogfcDBrBD6TEuZmpB3/yp83erSuoy7mMwouEqCOC7nkSI1BfpTN5y0Ro4Uf3xEi3cFaTg==
X-Received: by 2002:a37:6392:: with SMTP id x140mr26107226qkb.269.1593697255320;
        Thu, 02 Jul 2020 06:40:55 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f41sm8793245qtk.55.2020.07.02.06.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:40:54 -0700 (PDT)
Subject: Re: [PATCH 1/3] btrfs: Introduce extent_changeset_revert() for qgroup
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
 <20200702001434.7745-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b716bb32-b5e6-54a5-ac42-ca559dfd2d3a@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:40:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702001434.7745-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 8:14 PM, Qu Wenruo wrote:
> [PROBLEM]
> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
> reserved space of the changeset.
> 
> This means the following call is not possible:
> 	ret = btrfs_qgroup_reserve_data();
> 	if (ret == -EDQUOT) {
> 		/* Do something to free some qgroup space */
> 		ret = btrfs_qgroup_reserve_data();
> 	}
> 
> As if the first btrfs_qgroup_reserve_data() fails, it will free all
> reserved qgroup space, so the next btrfs_qgroup_reserve_data() will
> always success, and can go beyond qgroup limit.
> 
> [CAUSE]
> This is mostly due to the fact that we don't have a good way to revert
> changeset modification accurately.
> 
> Currently the changeset infrastructure is implemented using ulist, which
> can only store two u64 values, used as start and length for each changed
> extent range.
> 
> So we can't record which changed extent is modified in last
> modification, thus unable to revert to previous status.
> 
> [FIX]
> This patch will re-implement using pure rbtree, adding a new member,
> changed_extent::seq, so we can remove changed extents which is
> modified in previous modification.
> 
> This allows us to implement qgroup_revert(), which allow btrfs to revert
> its modification to the io_tree.
> 

I'm having a hard time groking what's going on here.  These changesets are 
limited to a [start, end] range correct?  Why can we have multiple changesets 
for the same range?  Are we reserving doubly for modifications in the same 
range?  Because it seems here if you find your changeset at all we'll clear the 
io_tree, but if you can have multiple changesets for the same range then....why 
even bother?  Thanks,

Josef
