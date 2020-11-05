Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5279C2A8632
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 19:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgKESjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 13:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgKESjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 13:39:33 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F31DC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 10:39:33 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so269536qkl.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SDyzkoxjlFVIHJNh+9GbsKTM8185sF/pSKE9oDStsn0=;
        b=GlNL13gj8ZRCGh0v0Ovz2jLeovtyEfQf499eRLmIAl/KF/XhdK+y/6zP241biDjjnM
         xEUrjP7K0VjYZ+OR8CQFH9xjkCo98V9Q364g938P/lp46PnY7KlfpHkV5U/vkfJUW+9+
         FLvSMt0UTtulZG+0HyLBBW35lYrHeYMQZIOTL/uzdUBGhi65zc8uC+TkBK2JMkaleyMO
         dNCK3E8JgdffvYciiFoUIsd69JBcJgy6azwxoPS24mQcwvxbuqQPlJMEskWNvKVXn0QN
         YUiPJNiMngPngtxScaq2zcB6P50MecvScYM4E1YympqNRxde8AkhRGJWDx6yvw1sWMXd
         0uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDyzkoxjlFVIHJNh+9GbsKTM8185sF/pSKE9oDStsn0=;
        b=E5MMUp0X+DwX6con80kpiJusZ8rjbx0DOJ05+cOxfqIGqxl6WRqFxKG0mLME7/ifqR
         iKq6iruZ/gJlaXhOEUK+r+c8MOG62fWK7jCrt9JfJ2HvDsBDka3HLsUllMWRwZPYi/fk
         UxpfnUdCqSCCcQ/cNjfrs4CVlEnKi7DW/RhGQytm1pMPTcKKDwTv5Y+ikX31+OMYH7E/
         ebugcPl8PL6/cIA+Tul2VIMacemNrfU488fkETULhpT0Wj4t5L59BNq5LzovuqWcbHxz
         BdTiqNf/ZUjiOlUHpF1h3tdwDHzVq0nFVkVuc5wZA1ev6vZSFPvBntzdim7cmYpJ6bbV
         l7Pw==
X-Gm-Message-State: AOAM531XyZM4KGmnwzaOSSoJON55a1nJx8MlTORtR59MVkcdRZBUcDGJ
        uhfinerEh6/P9zgodvxC91CvCpnRfgF+qD57
X-Google-Smtp-Source: ABdhPJxntmQFeoMRh0R3hZjLLC6AcoUAfRZgTncEQlI2L3pDFFRMXedcmYbvLFm2lw+PzUk4CMPK1g==
X-Received: by 2002:a37:4ca:: with SMTP id 193mr3498104qke.346.1604601571999;
        Thu, 05 Nov 2020 10:39:31 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l14sm1455066qti.34.2020.11.05.10.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:39:31 -0800 (PST)
Subject: Re: [PATCH 2/4] btrfs: refactor btrfs_drop_extents() to make it
 easier to extend
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1604486892.git.fdmanana@suse.com>
 <e18124431f5c0617dd0c2fcd16e2b439b32193cb.1604486892.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <178a832e-90ec-4a4e-1953-224b55f4de49@toxicpanda.com>
Date:   Thu, 5 Nov 2020 13:39:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e18124431f5c0617dd0c2fcd16e2b439b32193cb.1604486892.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 6:07 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are many arguments for __btrfs_drop_extents() and its wrapper
> btrfs_drop_extents(), which makes it hard to add more arguments to it and
> requires changing every caller. I have added a couple myself back in 2014
> commit 1acae57b161e ("Btrfs: faster file extent item replace operations")
> and therefore know firsthand that it is a bit cumbersome to add additional
> arguments to these functions.
> 
> Since I will need to add more arguments in a subsequent bug fix, this
> change is preparatory work and adds a data structure that holds all the
> arguments, for both input and output, that are passed to this function,
> with some comments in the structure's definition mentioning what each
> field is and how it relates to other fields.
> 
> Callers of this function need only to zero out the content of the
> structure and setup only the fields they need. This also removes the
> need to have both __btrfs_drop_extents() and btrfs_drop_extents(), so
> now we have a single function named btrfs_drop_extents() that takes a
> pointer to this new data structure (struct btrfs_drop_extents_args).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
