Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448882124A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGBN2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgGBN2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:28:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C0C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:28:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so25533271qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YVmFF2w8/IuEd5wix2cE9rLg98Fxdc9No2c7d0NXXrc=;
        b=XB5IEsMs9uHZqzFQAtPDECR+G9PIPbBiJhfhik+I1zjXaRFhfiVL2Gk/4xc8rFB5OC
         qCn1Wuo2DbN6D8r1cv8GoTOwQ/8vRYHze+jqVZnyr6Q5unXenE3OPQlSCKFyYWJqOCwp
         P4Sh9hTbVhrLgcE0he8Hm3ZI+l0z1dpZmXAuUfpo6C9XmDERkGA699ldBAdEk9ixHwx7
         O2kMWsqN9X5X+GDQKMzVv07Dpwxzc8V43GXskX4Jihy6fn0uq/jZEgh5Evi8l2GwBkmX
         rHQpO9XUrULFkgP5DmG8ou2TCjtKQSG8NsNO/wMfLZqr0B8qMpGdn8Z2f58j0cWz7+uI
         G1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YVmFF2w8/IuEd5wix2cE9rLg98Fxdc9No2c7d0NXXrc=;
        b=MPQJXLYLJmy+ytW8V0Tca5d1Zs6LLSINerIKmLUZmTfmmMn1T1Tgj9mknfIqX21NVT
         ieptnbiVPF/rrHA4yb2VLK3vgcq9FViLbxlSv+Qbg5WvJOBopNOINF2sMF97OF/aEBX/
         +FPiGz4hNHbClKczFZCR5JfxZgHZgYr4PBxb8HrL/+3Y3CqaDdaLVs5KRU7Z/DJ4PFVp
         7F5K2b5I4pQxLoZ0QOtxwgLoBYXTbmJvyzi69raG4LrOfLP7Y/pTmfxybpI5RMN6u96h
         aYs7WbBjJr1/DAgGAie9/On1NJhKjEF8P2XicW3cFmqjlpFnPM+GgVYftbXAFDe/lAGX
         4f6A==
X-Gm-Message-State: AOAM530yjnykUid0iO6N+O3Kw5u52MGv8tPTQnZ428j4nw/sPAJyi6qZ
        RIyI3gZoIC5RenXZibZLqt7RL+toYn81+Q==
X-Google-Smtp-Source: ABdhPJym1ovX8XBbRq0Luw1BacsZxjOe/kzFmGnfHhajSdjtlwgCz/ECyWN0eJ9FcheaO3752vdTWQ==
X-Received: by 2002:a37:a151:: with SMTP id k78mr29174354qke.24.1593696512719;
        Thu, 02 Jul 2020 06:28:32 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h52sm9002318qtb.88.2020.07.02.06.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:28:31 -0700 (PDT)
Subject: Re: [PATCH 0/3] btrfs: qgroup: Fix the long existing regression of
 btrfs/153
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702001434.7745-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ed428325-cd27-0c49-14d3-9a041fa9a8ab@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:28:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702001434.7745-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/1/20 8:14 PM, Qu Wenruo wrote:
> Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
> btrfs/153 always fails with early EDQUOT.
> 
> This is caused by the fact that:
> - We always reserved data space for even NODATACOW buffered write
>    This is mostly to improve performance, and not pratical to revert.
> 
> - Btrfs qgroup data and meta reserved space share the same limit
>    So it's not ensured to return EDQUOT just for that data reservation,
>    metadata reservation can also get EDQUOT, means we can't go the same
>    solution as that commit.
> 
> This patchset will solve it by doing extra qgroup space flushing when
> EDQUOT is hit.
> 
> This is a little like what we do in ticketing space reservation system,
> but since there are very limited ways for qgroup to reclaim space,
> currently it's still handled in qgroup realm, not reusing the ticketing
> system yet.
> 
> By this, this patch could solve the btrfs/153 problem, while still keep
> btrfs qgroup space usage under the limit.
> 
> The only cost is, when we're near qgroup limit, we will cause more dirty
> inodes flush and transaction commit, much like what we do when the
> metadata space is near exhausted.
> So the cost should be still acceptable.

This patchset fails to apply on misc-next as of

     btrfs: allow use of global block reserve for balance item deletion

Thanks,

Josef
