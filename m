Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC62328E7F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgJNUoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 16:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgJNUoq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 16:44:46 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03321C0613D2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 13:44:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 67so940152iob.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+aY6Y4Fu8fkz6dEU/rqw5o2tWjXkkN7Ep0a4N3FYHb4=;
        b=Vbg+qHnOIF2O9u2gHF7Z2jJKsze2YxqDW+k8g2/285OXjW3tPIzHz9Qv/yJe+gX4AD
         Kfs3kQZiG8OnrD3Us304Rz5xtKlGb8wboCd3nxdCyFqy8Kg0WY9p5/yx+ywWk0Ga5yA2
         CRU2hFTKUdeT645O+MVwKDZgybqeOTMmZM5ABWTqynqhmmmQ12vIqLa6KfsVvvymhOTW
         xGCYdVoQZzxhQZcrgT4mmNav9r1AbDROu4I4FV+pJanva7j3WllUz8V6hhLWjN338/pe
         t8H+7qO6EB7Br5ngeqrbTt3SSFbJcVBi18+CVLRF92alDXvL/RP/sZLp43ICxPz10eWh
         DxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+aY6Y4Fu8fkz6dEU/rqw5o2tWjXkkN7Ep0a4N3FYHb4=;
        b=cWHrpMY9rxH41NS1n0L/VD3+1yqBalXPGS7XBEVDPlr4NPTckHe2G59gm3sn3MpmJt
         c36oohinWJ6EOzDbJvD1rvq9qIRAqyIQY17H9ZcI2neAj+kfPbaDgyrMbUOUHchOJ9V3
         /rwCtU5X05uFcGUxPniWKw2+xj/UQJBlxgpUi67lgAq7r4h4COVTEfOk4iyQ0/vGi5vU
         fiBVs7hJVkYtvK7YMvWILZvOGlSzW4ZGn/lEe7uII1iWcR8Gm9RMdTM/pi02GxbGU/Ku
         EorGQigoXQ+9Y9JPL/DxdMpf09QmZhVHJVsjB9pxqYAE7t9csok1G064NPnKwTfiWUk1
         lVWQ==
X-Gm-Message-State: AOAM533IvEbjsCZ4SuCw/b4W9IoVRERc9T5dbnWUVykVlt9b9f9txHj1
        ESQVKOT0cP22in54hL0MohKHi7YNOSwiBQ==
X-Google-Smtp-Source: ABdhPJwXEbaazPV9jgorXUIQ6mQM9WwU9feG5FerYtnklEsefZwqnWmW7AAAFOrOPLgnsZ22PhhdxA==
X-Received: by 2002:a05:6602:2ac9:: with SMTP id m9mr990676iov.20.1602708285293;
        Wed, 14 Oct 2020 13:44:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1116? ([2620:10d:c091:480::1:6b7a])
        by smtp.gmail.com with ESMTPSA id e11sm569574ilp.7.2020.10.14.13.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 13:44:44 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: Fix divide by zero
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, quwenruo.btrfs@gmx.com,
        Qu Wenruo <wqu@suse.com>
References: <20201009010910.270794-1-dxu@dxuuu.xyz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <59853d19-2ead-9ac9-33ea-06f88218374d@toxicpanda.com>
Date:   Wed, 14 Oct 2020 16:44:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009010910.270794-1-dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/20 9:09 PM, Daniel Xu wrote:
> If there's no parity and num_stripes < ncopies, an btrfs image can
> trigger a divide by zero in calc_stripe_length().
> 
> The image (see link) was generated through fuzzing.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209587
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
