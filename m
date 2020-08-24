Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E9250466
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHXRCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgHXRB7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:01:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F7C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:01:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z3so3743645qkz.7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=k9G6TJaxfbk3znEPiV/cG1lb1RLiPYu7Vhx5uVC7Tjw=;
        b=FJ5QFDQapM9dI3T//TOtl59JUqyGhwLS6Uio3UC0APrwExN6NPIqobBgDGCq5dP0OJ
         ntV5ejQhFCuHwntpnR+IjiPqIda1Fw7Y61Ch07AqlWgo8JRfBU8/m+8qLwCWXSPmnLJL
         6vD1oUlqF9JJQ66Q89DdXysV6/bquYUkeu1ircc5Cx6SXeSZifdhRpOEsXoXyeDGX9gv
         iDE3sFBLy3aFb4s8BQPJgr6prrt81wLdWX+M9hCGhd/ghTx6bchgy1OJMdtAWxPFzaGu
         j9OBeDOpDU6qMHPEihPonqm4Vi0JEaiXwaIZN2XIiuxvxUCMxCgBdFGpZGxS+702diPj
         HRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9G6TJaxfbk3znEPiV/cG1lb1RLiPYu7Vhx5uVC7Tjw=;
        b=kwHiN9PiopuRpgyRCiUGRYf95mb45j6OzPWjscqelL+fBKX3o4qYDW28HVF8FzGNrn
         ecTMIGb6CnsjpOiITxL/QcVTOpi195A+IhuQu2AFqQ0D1v+UvLHx6NKf/uB2/Zr9P9HS
         gmNtIkz1GlGpx9IP79Vl6gVR/OCyZEgKNqmBkfOEiYOAeDNekyxiRtPtxLylFkkdTy5v
         +Mlh5vMHFuDzS8FN16H9x5DxtTZCsgBkCSD9n000mgy1rQQ5Y/sDsB/ykUqqhFXzNNG4
         unHuVnLBl++zXRni7ghptvBqX8YUnPvhTSrUWkkdsNG6j3Z8+Zo5DFgmzhoTt24QMFoc
         rYMg==
X-Gm-Message-State: AOAM5318zQELi/fxHH9zSfKOgBb8dzMt4iFt/H1+wG3oAN+X/kMFG0rW
        ugXktZwXKM2CCSUeDYh8+tVcZhVQDWXlV5OK
X-Google-Smtp-Source: ABdhPJyGKggLyyO/Kmb64UrFP4pyYf9YTe6aTsXnIUR7EQuAFjef1+IO5zMEeKmvIVMlv0VIrSehKQ==
X-Received: by 2002:a37:8ac2:: with SMTP id m185mr4976258qkd.201.1598288513324;
        Mon, 24 Aug 2020 10:01:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d202sm183403qke.38.2020.08.24.10.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:01:52 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] btrfs: refactor btrfs_buffered_write() into
 process_one_batch()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200824075959.85212-1-wqu@suse.com>
 <20200824075959.85212-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4370e9d5-5137-a406-4580-54d9e0bf5e39@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:01:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824075959.85212-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/20 3:59 AM, Qu Wenruo wrote:
> Inside btrfs_buffered_write() we had a big chunk of code in the while()
> loop.
> 
> Refactor this big chunk into process_one_batch(), which will do the main
> job.
> 
> This refactor doesn't touch the functioniality at all, just make life
> easier with more headroom for codes.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
