Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F18306125
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhA0QkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhA0QiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:38:17 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B14C06178A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:37:36 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so1312389qvd.13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wbuAwqup3QWCd/9/u9yAoTwr9mSRNQXWgARVLjg4Zyw=;
        b=Q5ZF3H8sbk4q6YVPI4zXTKK2qJ5+0bO68jjzXHTLrJlCCV4IO6WENi37qZ2m4ecQfn
         C/UZK9tC4Nmi4nCWKl6sHmHOtPoI3uzWG8JjA5EIK72aM2aDDe95x6WYWUsEIfHFe6Am
         lgHSnJlkx6Au+eCK+++RTWUInK9UKRdxjqt0QXAB5M15TiQbl8mrwtgFAp83R0jxywfy
         u0H8skKeSQWrnGpIG+shbnTpXHpULQ2FX6NiNZij+kca+TN9mQMKASr2lAcGf50is/1i
         g2fENvPm9ee+TZ+eBa3kh/yZCp1pe9KXfW7tjD+CxKKcb0yfGtkyClow55Iil9yvOEU2
         zgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbuAwqup3QWCd/9/u9yAoTwr9mSRNQXWgARVLjg4Zyw=;
        b=Apgz/Hd5WtszvwfbvNWrX02cjXeuZ7YOJ9mfbQGf2urSFQ8bSS/L1iHrZmFbCYlSxa
         Ao6JrJp7o8V5ynMGWZ3pHE3VYyv6mGKIt5LTyLNQdSo098RhAU2GEyrgWfllgRlLAafV
         eysJAbyCsVmOOvdCpzKYDBhwDCIhiUnm1aLv7XiIQXSAUFI3Q5XRtOi96EZJSKd+zLBZ
         u4YxgK+htfviD8hi8rq65kQoxolKSHEPluQwVQq7w4PitqGq28AM3Zl7H/1r91ROt4iN
         APOLikBxq/o+ZXtaumJW7O83rG6xgivucR29tGssnC9h6FNTBKcwytwsSeqbdhk9CMZj
         uDAw==
X-Gm-Message-State: AOAM533ldrWvVTTdcFDpkDmHL/C6g/S3roedwl/oBf2j/eVpK1D606TS
        6sEY/7ueYQrgfX8O118aROrgJN1Ojjx30BZu
X-Google-Smtp-Source: ABdhPJyixKAIIi+2ATRiwKpipLYJxCMuPtDjTlvew+fZLd3E1GfpPuEzPiTXkmOUHyoQHCl+CkbWJQ==
X-Received: by 2002:ad4:40c5:: with SMTP id x5mr11082320qvp.15.1611765455981;
        Wed, 27 Jan 2021 08:37:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z22sm1548703qtq.31.2021.01.27.08.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:37:34 -0800 (PST)
Subject: Re: [PATCH v5 12/18] btrfs: support subpage in
 try_release_extent_buffer()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-13-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <60161d44-0506-d220-623c-10c4ac435104@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:37:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-13-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> Unlike the original try_release_extent_buffer(),
> try_release_subpage_extent_buffer() will iterate through all the ebs in
> the page, and try to release each.
> 
> We can release the full page only after there's no private attached,
> which means all ebs of that page have been released as well.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
