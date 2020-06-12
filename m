Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62631F7D16
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLSqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSqU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 14:46:20 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE74C03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:46:20 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so4813041qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9/NRoi3N5btW+GkWR9nezt4D94UVzOVAt3ZE0q0Ktbw=;
        b=C58Md6VkbL2H/eOrsZCkLic6AK/Ye+ElsfWifE+b16JJLb/467aKl7P7VI+2yzKnAD
         602086Jacw1Yys4reWuHIrMhpZiuSWtPFqJnjUQrjlyvTPIfwA8mMAfu5GSP7veozlz0
         2NVAzSK2WfQsxJ/faCT7HiaF3NWDk4PqkMqB0AfEWExE4O9LfTpM5miQ7mcZUDDVYIHX
         ot8qG3F1wRtmj0Lfgh4LPMiLZgMihh/KWq2ugfJs6EqhvwNdo+G3nUrIDYsMShOemgjr
         OkRl7cNJyDl/F9bjMbPKmusNwH77uloFvjs5sMSi9J8Dy1IgnBKBDF34QZ2QoWXS2rH0
         GZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/NRoi3N5btW+GkWR9nezt4D94UVzOVAt3ZE0q0Ktbw=;
        b=YCoGp3KqTlysAfqZJBo8g5qHTTItIuLRhjfJywb2xEMgnAsEjBsVyBvQq5BDwyy+1y
         u1QAKHLFAe2vLLbzqL2De26truvBHtPx2OF6uYiHyv58MsRWjkSEP/eyMiO0M3BiStrB
         Pjas5ouM1FXAnpTMsuh+amMtr3OfFY0GiIp0wIF24yu8R+QR+lmi8oyy+9CmxGSgVASX
         E+b4CZzwxm8gjzhDh9/Gp+L53oJg+cGcvHCJZZgsqnOSb0BJjYQ7q4F9JUCvDHqPRCG0
         7NhW7malrOLugaI0SmSh7JEpmDg7441+aWJqbcW83qzU23iU6omV46lt3USdO6yu9bn8
         31bw==
X-Gm-Message-State: AOAM532+npNvdWNGFqKUlPzOjCOaOOQ2TpEo9OWbrH5ZsqCIj+8Ds3XY
        5DAcLm+kB5Jm9WxOfz9qQY6gD3TcKfqZwA==
X-Google-Smtp-Source: ABdhPJwYxfrkkxF4Q+i2m2OtTPahSlmZVpF4jaqcuRUbzUqE+vpMNNS7fuWY5VecqLDDa0Gju5//sw==
X-Received: by 2002:a0c:d444:: with SMTP id r4mr13890120qvh.67.1591987579846;
        Fri, 12 Jun 2020 11:46:19 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::11c4? ([2620:10d:c091:480::1:487c])
        by smtp.gmail.com with ESMTPSA id k6sm5223610qte.52.2020.06.12.11.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 11:46:19 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] btrfs: inode: refactor the parameters of
 insert_reserved_file_extent()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <53a233f4-52cd-dedc-0099-31f9ff3c5bdc@toxicpanda.com>
Date:   Fri, 12 Jun 2020 14:46:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610010444.13583-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/20 9:04 PM, Qu Wenruo wrote:
> Function insert_reserved_file_extent() takes a long list of parameters,
> which are all for btrfs_file_extent_item, even including two reserved
> members, encryption and other_encoding.
> 
> This makes the parameter list unnecessary long for a function which only
> get called twice.
> 
> This patch will refactor the parameter list, by using
> btrfs_file_extent_item as parameter directly to hugely reduce the number
> of parameters.
> 
> Also, since there are only two callers, one in btrfs_finish_ordered_io()
> which inserts file extent for ordered extent, and one
> __btrfs_prealloc_file_range().
> 
> These two call sites have completely different context, where ordered
> extent can be compressed, but will always be regular extent, while the
> preallocated one is never going to be compressed and always has PREALLOC
> type.
> 
> So use two small wrapper for these two different call sites to improve
> readability.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I like this,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
