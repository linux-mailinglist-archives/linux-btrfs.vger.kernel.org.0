Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD31836238C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhDPPJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhDPPJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:09:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF0C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:09:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f19so11440911qka.8
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pY7n6s9b489WWwQjAjNN7rgKmnpdKkK5K8KvJrJ1aIU=;
        b=HbqVUxNa+P7Iob28PHuhWV0HvkR0A0mbyqLDtWGOVltZLNuqUnQTvVPQw2HouVFoHe
         9tnsBJgNEumVfGtrNk+eWwg71cL/ofx3ue5mHG3aEbJjOlsqZoHxft6/a/w7dLPNCNsk
         sc19KJ4dsFxyjdicHQAqXnfPpQC0xh4VQmuYQct7VHDGrUhjpo70BeR2mbYjAaYwyEOR
         dbkaw8y3yUbBiFitZOKaz4WT0/+PEklVG/pydDtYugGb/XdHqPEgVIJPTy1gBH2Zjx4i
         O4Jb/KfMm1TDFU8YmqgWMUnvXnj+yHkJmZMDf/BjY1oa3DvXPp30Xn4U1WAHIBtIkk0X
         b7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pY7n6s9b489WWwQjAjNN7rgKmnpdKkK5K8KvJrJ1aIU=;
        b=TE7WUVf8yT3MOPnSJaNzFkELb9BCZbrlt3SZfvvz0mnCwL1+y4ElgcDoUgrpceOqn+
         KVXipvGWyWgeJn9lXWKDAMZXnMqlSX1pROpgDldQ3ZbAWOvhzufN11J2leBrlGiqlVQF
         3rbE+AxJP8BXJ1kMu5/HVVEL3Pv7UkdIbIr2K9yVx3O27KZPkHQ3KaopoXSZKp/ejCD6
         HX+yJ6bezy3Xf7jASuVIZUGxDcOGqj0zedJWEriVt8yFzLGMQrHEIAIq4ACi5/xXoRXb
         YKvG3EfONbQ2++aahjEX9r9cNTy1kd9OT7GhJr7RBiZU0zCqYzCS2HMSsH5ajr7/3MHW
         717w==
X-Gm-Message-State: AOAM530LtyYOk1sd54RY69NhjeZr2+WwJJG8jT493jq3iaDutIE4vXnW
        UatuqT+g8dpkqDJXeOplmueditgthpZUlg==
X-Google-Smtp-Source: ABdhPJyEZUCAgFJocW9/hgZfXYq28/r0WmCkjal1Rmu9rRnTRFbo3MNnct//tO3enf+rJb6s36HrVA==
X-Received: by 2002:a05:620a:408d:: with SMTP id f13mr9080189qko.312.1618585748765;
        Fri, 16 Apr 2021 08:09:08 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a10sm4251357qkn.123.2021.04.16.08.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:09:08 -0700 (PDT)
Subject: Re: [PATCH 16/42] btrfs: provide btrfs_page_clamp_*() helpers
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-17-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <85c8dd66-c2e4-10df-9618-61d125663b7c@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:09:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-17-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> In the coming subpage RW supports, there are a lot of page status update
> calls which need to be converted to subpage compatible version, which
> needs @start and @len.
> 
> Some call sites already have such @start/@len and are already in
> page range, like various endio functions.
> 
> But there are also call sites which need to clamp the range for subpage
> case, like btrfs_dirty_pagse() and __process_contig_pages().
> 
> Here we introduce new helpers, btrfs_page_clamp_*(), to do and only do the
> clamp for subpage version.
> 
> Although in theory all existing btrfs_page_*() calls can be converted to
> use btrfs_page_clamp_*() directly, but that would make us to do
> unnecessary clamp operations.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
