Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC4264FD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIJTwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbgIJPEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869BEC061757
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 08:03:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so5095872qtw.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZmU0kMq1byN5OKDsxAUZ+ObaxWiqZhUZe4UVfrSpDgw=;
        b=qkkjB6RcSqqXJ6O9SDlIHNdCeDZ1udVvobmZpz+jUYiZsqEqmHQjYZ81ml565wtfoa
         y52EMjV3dLYI8oN0MeuOUszo4usWjRdoLqNB32qU5ucnpXhGMfNvR2RybxCHnaZJRQvR
         18te+q+yKYVyANn5yUiQAe4sqhb1AMA/xo5eUapBklta+yWyhxAMPLB+11KeLF+A/Qln
         93pe3E0JCH5UqJE1C6+ToVcLlwh0nWJsNVdwrMeLUjvz36HQk36kqoEfoyZJ/MNZAC7P
         PM5EyUrZR5vTKTdqpKP9ROLKAkSyQzETZOdGWd6XPEE6iaUN/HGxyfHJK4iYfc7gpQKF
         y5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmU0kMq1byN5OKDsxAUZ+ObaxWiqZhUZe4UVfrSpDgw=;
        b=DsT6vrt/Q0ohjBO/z3kcn519NvpZLOt9FvU5p2WQWBnIkfisFhyRJTbV56v9zrheac
         Yho5gyewXc3Wgda9wUebWVl9uXJuvUzUy/L7Yl7Pwb1EEHjyVlppU6aaDaEL0U2PWcYL
         q+GHgCBv64tB9ngxTUfztPSWJ74or9XrELkubhj0wuywA5hH7T+pdmslM29pS2liOD+v
         F+RwuL4SUgqd1oGX6uQ/htsGyLEM/1jRzl7Vztw5bK0bYyLAiNCmbGuZ3HlQQLNHTnbJ
         iID7YolHvgQD+DmeXYmPItv/rehsfsKNE+hlLu4SZ2VRJzyrqwVjeiaXcpuARnt52J8Z
         iXpw==
X-Gm-Message-State: AOAM533WuNAQCxwjdKFfVnJR2bM5qwusfX1aOgvb1nEpoIh+BXZOf0La
        5S9xlX1+EPQW0bkH22zvC4XZUBLBV/rRZCdj
X-Google-Smtp-Source: ABdhPJw3whodd92Xpo0YnTw4IIfJE4oi4BPXj6Ii8Pbu5dJUHt2lW8kgDd6QoNNI/Fzhjw5pOf1fZQ==
X-Received: by 2002:aed:37c3:: with SMTP id j61mr8509585qtb.11.1599750219384;
        Thu, 10 Sep 2020 08:03:39 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g131sm6387617qkb.135.2020.09.10.08.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:03:38 -0700 (PDT)
Subject: Re: [PATCH 09/10] btrfs: Sink read_flags argument into
 extent_read_full_page
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-10-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2a2670df-a778-6987-bef9-dda93e2f519e@toxicpanda.com>
Date:   Thu, 10 Sep 2020 11:03:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-10-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:49 AM, Nikolay Borisov wrote:
> It's always set to 0 by its sole caller - btrfs_readpage. Simply remove
> it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
