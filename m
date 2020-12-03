Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0962CDB04
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436614AbgLCQTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436555AbgLCQTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 11:19:23 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE30C061A4E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 08:18:37 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h20so2586367qkk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TWydgTKZDE3Hr9r5fZYdznX3/pJLx0UYb3gyaltxrTc=;
        b=VC3H/vaZsYkfQTHQ8uygD7luF0olXNzgi9hUtcm77ywQCxngtd50eDGYWqejJPOkCe
         +tqeT/1PIqhq4EuKskRfREOi0s5KFHRGQcBgmD+0fDVGKn2AZN1ISm958KdGSb8XhNTO
         43J3g7lsWp+mGNyZlZj1N+myQLDqfcVizB6JhPpq6eCah1/4fMJvY/S96/NeyYYUI+UE
         b6tekB0EzZaBj8BCbJWF/sOnA2aiIMqB4qotmM8u1U6EjIQkzzt+tiiZRDehSJAbZ7+Q
         5uqCDjJcKyqszZGvqVXawBLPwz3Xfk0EnGi/cGwmaES5Iy1Ol6ZA8V7CHbk/5/T/POjZ
         SvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TWydgTKZDE3Hr9r5fZYdznX3/pJLx0UYb3gyaltxrTc=;
        b=ghO6/p9SDVIVdSfzi79uKg5JMcRse4Ds596Ejaub29ThizNTmhjO8LMs4m+5lV/asA
         JUe9VF3OByL4DpU0tnkVY2LL/U5B/2cBTnrjVZhgd/WOhGhWEq6w3Y6VcDConN6R9Sqd
         KKCOg5viGW6d31AMK3KVTB/hxxvOydAf+0wtp6Zmk61rMeZJJ9fAvtsRzmP6bKa/BbGj
         nOtU+YCI34/fDmOM07VzwUnJb7PafNE7f0IhFJmXjUKsXJIvtDV/4ZvwX44irw7xm/xb
         5sOe9DiuHW3r5lY9GrcjhYnGyg5nwtiqzdWqiYdBG11Z0CpQgBMU/6PZ0xo1fcHZPkAQ
         bG3w==
X-Gm-Message-State: AOAM531tuPR9Af3gEfDNxZvhl0aOzgg6h7l8BI5STJj6IjMO6pNnCmek
        3o2zta/6eFscQDykDRFbpK1fVg==
X-Google-Smtp-Source: ABdhPJyC/wT3Ecq6rWUIuBpZR6e2KrqR2lbddNAg88nbg9eTskq40Osiyb6d7sWcXnCuwcQCkVJRNw==
X-Received: by 2002:a05:620a:21ce:: with SMTP id h14mr3644408qka.363.1607012316249;
        Thu, 03 Dec 2020 08:18:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s130sm1756527qka.91.2020.12.03.08.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:18:35 -0800 (PST)
Subject: Re: [PATCH v3 30/54] btrfs: validate ->reloc_root after recording
 root in trans
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <60d12b7256e6877061eaa9df99ce2ed1f0f3d012.1606938211.git.josef@toxicpanda.com>
 <81983f16-ce45-dfbd-4b91-ac6970209fc6@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0f390458-d975-3843-3128-e2919090e2cd@toxicpanda.com>
Date:   Thu, 3 Dec 2020 11:18:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <81983f16-ce45-dfbd-4b91-ac6970209fc6@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/2/20 11:49 PM, Qu Wenruo wrote:
> 
> 
> On 2020/12/3 上午3:50, Josef Bacik wrote:
>> If we fail to setup a ->reloc_root in a different thread that path will
>> error out, however it still leaves root->reloc_root NULL but would still
>> appear set up in the transaction.  Subsequent calls to
>> btrfs_record_root_in_transaction would succeed without attempting to
>> create the reloc root, as the transid has already been update.  Handle
>> this case by making sure we have a root->reloc_root set after a
>> btrfs_record_root_in_transaction call so we don't end up deref'ing a
>> NULL pointer.
>>
>> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> The fix here is mostly based on the fact that pointer assignment is atomic.
> 
> But I'm wondering if we can do it better by using something like
> spinlock to make it more explicit.
> Or is such root->reloc_lock too overkilled?

We are essentially doing that already, as these checks are _after_ the 
btrfs_record_root_in_trans, which does the appropriate locking and such.  The 
"race" is resolved inside of that function itself, so we will either have 
->reloc_root set, or we won't, but it won't magically change between exiting 
btrfs_record_root_in_trans() and us checking root->reloc_root.  Thanks,

Josef
