Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5DF38C930
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhEUO2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEUO2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 10:28:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A933C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 07:27:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k4so8769383qkd.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AhklF2v4fnn1JXFoLF0YcSGwEHda0PK56nrL07qs4CQ=;
        b=fKQAA9fMQZdAHxUJWwjJwMmb6mfXRog850bKzYQP2tNXJdGicx12X9B0nUI73W7ZP9
         gxpbHpV1YktUm2U5VJ6Gi09K6Z28ecnaqDAxXITc4mVk7pzM515XSDsFXS54DyWzNAUJ
         vYBraREAjQLv/YnWDQKH6jK5TYIO84RITjZ2x4q6A11UeC3ef8FCPk0q+ZRKyijGFaw7
         MUlfLIHmJ40oHsLNxGommHnfYmtgQ8f1DW4MByBpLwY48JT4p5ZI8NotVXVwV4T5f5Aj
         Q1BYaP2CBwglG8KovWCStZePyLyfDgLaZdkZUuKN/hfbaDa9/SSTmi8eYsGd7EG79Pjc
         Y+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AhklF2v4fnn1JXFoLF0YcSGwEHda0PK56nrL07qs4CQ=;
        b=gwr+cAjx5REiAa2NStPvrMWWvVtYmt38Qe+hAEIKohBmoGMfJJlv+eAjEF7hCPHNt9
         zrSzrcXVjU3jdR+k+pUwF5MDkwZp7KfQQEj+J0mVUN0zsYIWhazJhF1NI7j3TJjzVBdY
         3V9XhCRrlEYjdoczVR8PMjIQ4aentft+j8Bw0PhiIJqoOls4PV3cVWom52HmkMvTgiWF
         1MHf8qKrGesyaRV3P9Mw4IGwPSzJZp09o/b9Kiq7Q6q0kpVYXYwzpXmX0VmDyEkM2m9A
         eaI3S6NLVL0ls+0rwGKOE+0PRwtUy/9YGIn3WjoaTL+U8gJW8uuOwOTQQs5qt+eEW+tG
         5UmQ==
X-Gm-Message-State: AOAM532QckoqFMBiYv/p3mg6GU9SvFBrJD5ClP+llh1pYsXRe5v1Chl4
        ua/o3yScyHox8FnZ9d95+V37FQ==
X-Google-Smtp-Source: ABdhPJwMCSrC2pZP/W2XgmyyyPFVJ11CzYNEBFypg17nvI1xtjpVQ4Fg6oUkshCq8lSZ2vD8t9X0/g==
X-Received: by 2002:a37:e11:: with SMTP id 17mr12717133qko.499.1621607230519;
        Fri, 21 May 2021 07:27:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id x21sm4390536qtr.31.2021.05.21.07.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 07:27:09 -0700 (PDT)
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
Date:   Fri, 21 May 2021 10:27:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210427230349.369603-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/27/21 7:03 PM, Qu Wenruo wrote:
> There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() in
> end_compressed_bio_write().
> 
> It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
> which is only supposed to accept inode pages.
> 
> Thankfully the important info here is the inode, so let's pass
> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
> make @page parameter optional.
> 
> By this, end_compressed_bio_write() can happily pass page=NULL while
> still get everything done properly.
> 
> Also, to cooperate with such modification, replace @page parameter for
> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
> Although this removes page_index info, the existing start/len should be
> enough for most usage.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This was merged into misc-next yesterday it looks like, and it's caused both of 
my VM's that do compression variations to panic on different tests, one on 
btrfs/011 and one on btrfs/027.  I bisected it to this patch, I'm not sure 
what's wrong with it but it needs to be dropped from misc-next until it gets 
fixed otherwise it'll keep killing the overnight xfstests runs.  Thanks,

Josef
