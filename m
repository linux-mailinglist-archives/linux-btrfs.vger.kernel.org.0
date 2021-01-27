Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5CC30611A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhA0QgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhA0QfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:35:20 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CFC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:34:36 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id a7so2253806qkb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ybzT36fPYmS7Vk9WtHr3bzngiZgQ32L9fHGfiANkhhQ=;
        b=2GEX4QjUdFEcxyNYrd/IsL6/Rxho/QbBYTDLcaVxZVykcfxNaBo057m6fRjAqhrf47
         Lxw14QNmSCePDkZXwvdzw3XH9jlAcHOpdIckciVvMiEU88ZLPBKLrG+f1LEzU9hC3F/4
         WNZfI3GyDyFWSlh0Oo1NaLT6ZV8f4QsSmoDkT1PEQSdQCs+iYZf0Y+/XFTNFMJ6guLRW
         bg/HNJodp9ad6oKAJ/bWd43BbgmeHiDFWiCSX3g8Y7oLm5ytOVEsd7A0A/5sWP807Rex
         4Olk+wM3pf5ViOQDchR4nmCZQJSf058FgeEuufIR44t70HhdrlcctQn/Gw/7i7aMGdrj
         7X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ybzT36fPYmS7Vk9WtHr3bzngiZgQ32L9fHGfiANkhhQ=;
        b=UfJEeSrLks1kLLiCbvj+vrRJrBARzTTgS/DF4PEr4oORhUZLrAezk2hvzqmTFYVN6U
         IH0Nl3usTTnoJ7DE5TrMKocEdMizyTzGeEP0+mZgyLi89GrCFTJHfmSRh4YRyN8Gti7V
         iDUdt5WBnz7AcknkmKsCU1sZ3t3Xz/lLmYhf0+vdNBYeEARZauEkaQy1bVzf4Dt2e6rR
         lW0R6Mb5Tdmwh3Dl8ek4Ol9/+2fmLe+SLH+PU7X4+aVGCoKhk1pwZiLouwrpDv+Buzf5
         s+LxQ7QrMgYbCqaQLH2GeFx376SNydvAVqEB4kjr3tdCffY95+tRatvnFgLaKoD3wDb6
         LTYA==
X-Gm-Message-State: AOAM532dKOBHfNOSKjFjEQYChcd2aUXxqAF/wKvWbqi/LKCu7ETq+NEe
        pj4Jp6O2PaGZa/7lwtVMUXkIHq9wOtFW0wR/
X-Google-Smtp-Source: ABdhPJxHgKch1HX+rOjN2W6uDl/bCKPRqN3lPN/r0/4e5lCRbJWOPzcHGpKiT5U4Zrf9NDDUIpL8cg==
X-Received: by 2002:a37:4e05:: with SMTP id c5mr11353409qkb.349.1611765275690;
        Wed, 27 Jan 2021 08:34:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y135sm1575497qkb.14.2021.01.27.08.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:34:34 -0800 (PST)
Subject: Re: [PATCH v5 08/18] btrfs: introduce helpers for subpage uptodate
 status
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-9-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6519117a-e742-b637-9206-10ac7912758f@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:34:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> Introduce the following functions to handle subpage uptodate status:
> 
> - btrfs_subpage_set_uptodate()
> - btrfs_subpage_clear_uptodate()
> - btrfs_subpage_test_uptodate()
>    These helpers can only be called when the page has subpage attached
>    and the range is ensured to be inside the page.
> 
> - btrfs_page_set_uptodate()
> - btrfs_page_clear_uptodate()
> - btrfs_page_test_uptodate()
>    These helpers can handle both regular sector size and subpage.
>    Although caller should still ensure that the range is inside the page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
