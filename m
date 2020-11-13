Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139D82B2594
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 21:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKMUeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 15:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMUeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 15:34:10 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8FCC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:34:08 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i12so7686160qtj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SfJC/J3ABut+CL7f3+uBnf50DKA1EWCJ03tSnuUQuzE=;
        b=AO9ozngOpsfoErSd00K3fzNzUJlV2dvhKAvlIVJQZpQ4cy+xF/P5gR/zuco58IZCSa
         uuHRtPgBkCO7PiJd1SLeKoMky7J9TF8xV3sXh9w4I0Yj+15JatbyfJJhJ3rt45Ex6W7b
         Wptf1o0S+QkDjaCz+bRiaq6/Qh1IgPbuHIBhNUBJ7SD+RzwKJpdmdCBThQHCfKc1eum9
         Z9xNN3QxmlsWJdSrlLBbss01AsKEkzO3+9QG1g3WEH10Aiffh8ntoRLBTepbYSHH4drQ
         Hyl3oUxB+Gp4pQ/Yca9PAb1L9ZN2NNOKwK10BHyDiK2g45tgBR4K8mi+Ji10R3vEcU7j
         7z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SfJC/J3ABut+CL7f3+uBnf50DKA1EWCJ03tSnuUQuzE=;
        b=OD1nti29Op4KfCRIpdY5YUps6xvs5NL5oJG96ttAl6iOSF2PpVfCKl9kW9Vj1PKwPD
         dUFSf9GRMAATebc6X1mInskMbP/P3MePDeQCyOwHkET8+NWYfW4Hq8PsDUqJV5LS5m3C
         VuRDtmjjyUiFwptjh/SXGWIQ5hsPzPaEHMO/Tm8c50uYMNJRrEwyp07ZUaMJCGEeNGHX
         9o4fNOJQ+9ayiRVCZKaLz3gIgTBNzsDhvkQdupUnWzsihUvNc4YV+VP4kdOJYWchZoo0
         QQYC8JxnW9G4g1+TE3jmJOcDvRJwPvnkIMx+UQ1QLKahUNXSOLpBrSO+sDdE8Fr8SBEc
         SrWA==
X-Gm-Message-State: AOAM533zLLuwCBLlXH/H4pL7BI+jd8JrPOtFb/i2SCjxuINOuCbdvX/8
        W50UqavkQ1hB+EgRAkk/hm2nig==
X-Google-Smtp-Source: ABdhPJyRqEIXKBRUzewGzTjispcLaIPUeHbkwnEeLTNRJln5qEfFHdM8xuuN0SrcBO3JXhDEDFWffA==
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr3765284qtw.293.1605299646881;
        Fri, 13 Nov 2020 12:34:06 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k31sm7197557qtd.40.2020.11.13.12.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:34:06 -0800 (PST)
Subject: Re: [PATCH 0/3] btrfs-progs: rescue: Add create-control-device
 subcommand
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Cc:     kernel-team@fb.com
References: <cover.1604013169.git.dxu@dxuuu.xyz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <325731df-ef69-41a1-0a4c-fae63b7b24b8@toxicpanda.com>
Date:   Fri, 13 Nov 2020 15:34:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <cover.1604013169.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 7:17 PM, Daniel Xu wrote:
> This patchset adds a new `btrfs rescue create-control-device` subcommand
> that acts as a convenient way to invoke:
> 
> 	# mknod --mode=600 c 10 234 /dev/btrfs-control
> 
> on systems that don't have `mknod` installed or when you're lazy.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/223

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
