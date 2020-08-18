Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE7C2488A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRPFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRPFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:05:03 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291FEC061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:05:03 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v1so7825574qvn.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TLPwsPGrmRNyksSVovC45U+LY/NGqYumobZK4pzlgOQ=;
        b=sD8YPrFCWs+crUDDcGouN0RQ3RCkgsacg8ugnnhacpGnQhMJXJdMQXG42nUlIJ4N5K
         LGSyWdUoyRwuZiQXO1HsIvsCp6VKk3HzccmMnV3MkY4P7YDmbRsjl9NHewFFJRqmeXzF
         AgLSzxhkB8dDf0q5dQVg+pyqWzkqTML+iOUI57ewQvoRDQrv+55Wu8/w/nBfVd1NxIb5
         nFtNRFqhYiEBlWZrkBeSFb5S0eSWhgAdsXK+lVYI6edO0t/VC9tW3X+hVK1a9ARplA4T
         NQHXjPI0NkHHNO11ywsaIUeWGpwRvKRP6X6TEZBs1XZOTwnypzjAQThgLjYQqZn8wvAo
         9Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLPwsPGrmRNyksSVovC45U+LY/NGqYumobZK4pzlgOQ=;
        b=Ua/Lb5e/0oXmWwq5eM9W0Z7ZtQVoA0zcaIVSuF4ABNpFyypBNNCR1LFC67ztaFBsPj
         c546SsQEXR20k2i8qh1Yo7UNnNqqZhWeQ6+dG6vPZ837rGeir0iDKUeJLM/rL831gPlu
         EX0yFeLTqCQ8XFg+WIE4w2irYq+WBYPZQp7UsztYcgXl8ebOylkFTAj0INCIvxDAY3wZ
         FoEKTmSxrqmWrF+gYGrjqPJJTjxlX444XTOaNAej7FR2vpoY9XmpVRkhjGG5/jSZW5Ng
         PqNw8XRdYA4SuA1DJlhnZPwUbJGKaDWtWSmvYXJRylEC/gh6gP2XU1N3+WY5X6TGcYDR
         xh3A==
X-Gm-Message-State: AOAM531GrraVs83NjDXHcReDUAy+Qwma7StE6dLqhlSpGp2Mmr653k9Q
        oZD2YYYCzmhKOnlgme+XQElY14rGZgI8i6m8
X-Google-Smtp-Source: ABdhPJyFdkbDS18/WTDuZsigFS8mnrXqSNa2vSWNkhPrSaiG3F7zupOLgUDdBELqlDLqGXDBado/ow==
X-Received: by 2002:ad4:56eb:: with SMTP id cr11mr19341361qvb.170.1597763101974;
        Tue, 18 Aug 2020 08:05:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id f39sm25771799qta.59.2020.08.18.08.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:05:00 -0700 (PDT)
Subject: Re: [PATCH 3/5] btrfs: Make close_fs_devices return void
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <abf8e5fb-408c-cc1e-a62e-518f443b164c@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:05:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/15/20 6:48 AM, Nikolay Borisov wrote:
> The return value of this function conveys absolutely no information.
> All callers already check the state of  fs_devices->opened to decide
> how to proceed. So conver the function to returning void. While at it
> make btrfs_close_devices also return void.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
