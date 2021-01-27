Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB2306076
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhA0QCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhA0P5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:57:03 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D343C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:56:23 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id x81so2167255qkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X0Cr+UznUnPZv/ZAZL5pSwqewa6DOpatwGq7+IjKAjQ=;
        b=DEVIXXm8k/cI/V0KqNCg27l+SlaBdYN/3qmj5aTGp/2xZSSuW8jDl9/ECIFzLzWK1J
         1jdIfLA9fO/9QXT+gAfHLR0FiGh/zqFv2rz0dZoK3Fh1YCbTjE5CLz0DJlBpVbhCQgiN
         auUCD5vHsVMpd6MWdVomKRpHmaFeabUpZIdwuFCK8AsL5XYpVDHk8/gwJIazQzOXDdem
         UwnQ3KKs1PouolNhwZhroGaugvB+AWJruQTenYidKMOGxPpglxs5vLgoY9WN9PujeWNa
         G1vuVpwJ139wIfjbDYfpzLstzF5l+S37C5P23B55LG4uInbZYJycYnsNMJSRavmCfoNL
         Spzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0Cr+UznUnPZv/ZAZL5pSwqewa6DOpatwGq7+IjKAjQ=;
        b=ctZVyz2mdTdhZ89r9e9cIWK2kMc2iOBs0hcn7lXcBSigXUGbS88AE1YqlSPOm5NH7r
         aXQBxb7YQXtN1JHg01w3ubrsOhXXrwfdlwNdSKqv/5DYx7yGp+EniZ733YEoPQT96IiD
         Myg04TvL1xzPJpjo4C8Gk1ybjTtplab3i3M7Vlc4ar1VdS1aqbH88aZwUyTFDnRPep/o
         ijKaqKN8FQq/puGf5l+ZKkwsN4LoW5eoP8AN21M/Ehi7WJZQYC4D03yQAU/p9kcr8Sp6
         tKfPZ9q7MK/iJQrAHrisZzFPnijABqFmussCMq5MjmaGtTtB7ZYDb/0m6L90RzD43qT5
         eCoQ==
X-Gm-Message-State: AOAM5338SAstxtV1dqcgr/wTOg2LftD7YnQp/zkeaJpqG3eSZyTPw2Sj
        /BcHN0FOY/B4C4zk1nwpWW8+nKxFjuZOogK5
X-Google-Smtp-Source: ABdhPJx8gf55vIv6iIrvoMAo65QViwOFBpNQVSMbmKrQsVIH4zpA2Va+lNOrOgov7tzUwdm86jNuaQ==
X-Received: by 2002:a37:9e04:: with SMTP id h4mr11017393qke.258.1611762982402;
        Wed, 27 Jan 2021 07:56:22 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o76sm1393286qke.104.2021.01.27.07.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:56:21 -0800 (PST)
Subject: Re: [PATCH v5 02/18] btrfs: set UNMAPPED bit early in
 btrfs_clone_extent_buffer() for subpage support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <722ac4cb-f865-adb0-3766-92ed6be59011@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:56:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> For the incoming subpage support, UNMAPPED extent buffer will have
> different behavior in btrfs_release_extent_buffer().
> 
> This means we need to set UNMAPPED bit early before calling
> btrfs_release_extent_buffer().
> 
> Currently there is only one caller which relies on
> btrfs_release_extent_buffer() in its error path while set UNMAPPED bit
> late:
> - btrfs_clone_extent_buffer()
> 
> Make it subpage compatible by setting the UNMAPPED bit early, since
> we're here, also move the UPTODATE bit early.
> 
> There is another caller, __alloc_dummy_extent_buffer(), setting UNAMPPED
> bit late, but that function clean up the allocated page manually, thus
> no need for any modification.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
