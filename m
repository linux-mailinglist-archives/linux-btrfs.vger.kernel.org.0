Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0520E4769A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 06:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhLPFgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 00:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhLPFgH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 00:36:07 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 21:36:06 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k2so36697968lji.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 21:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kOVjm3PjER9YxPnqWqgxrOMMkY4gQ/80Fc1fdnQFfqU=;
        b=JZXpfE1bBA0P5jcckRbjxoccIjjWqRrdVh+J4CclIoUiQy87U/v4B1QZcsqh2Am797
         5kbdfhhZd6+wAriY3Qi1cxeIvBBsYpYtq2MPGUsbO5cj7dapkif99hb7y43sdcRL269B
         WF5AGkFgMStggrcUqke2V8QkGOcxemfEoLdNPJGTfeDgKdfJxwT7u1zlLYPFcD/Jq0Wa
         h5t9DjrBdCaIkpC7zSxqhMn66C9+/zmCWLRtMae9HuPpiY2rO6JYQ9Mwmiki1emKSVth
         87cwkqGE3Makt2TMOcQcTjN4t5myxYi+cYaJFORD3fMCvALmYw5YNtMdF4rquxVozexc
         grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOVjm3PjER9YxPnqWqgxrOMMkY4gQ/80Fc1fdnQFfqU=;
        b=NusSJ1WCyUrxQ48LxYnJkHD1JVMGeQ71teZOe1ZFfNMgXO2zJrvM0nhRhicvA6BtLo
         4s5wkIyl77nesnNKEoSm3yWPU0bt28Pk8yUpfC7F40SyHjKODGi0Wvi0zktcAvK2TcUV
         OjQhKgpmdHpI+XyzWaWlloqNp2R9EbYwz2Gf3tmqbd/hWpQE4GDNfU11miheY0u8HB8l
         1aaozHmHxckbaTLkFF1QK7YTaPnrAd85X3ty4uVtoe1kvm84h1H4Swywwt+eRsXyqDHx
         3rbSQk1ucW0281oYDN/9yNYwKXOvDF9EsaJqnQMvPBKuGBPPIMJnMlMbqh8k1DendXr8
         UeYg==
X-Gm-Message-State: AOAM533kDbVnQMzqBkUqYh3ukO048xP8NzHylRjrve7hRfu+zkTBZugk
        CQB5FNBweV89/GQoHlolRfk1en45Rbs=
X-Google-Smtp-Source: ABdhPJw+prYToJYrrUGTJCZMsURfduS3FqJl+AFg2AI7ywBx8+HT24VjKHdlNgdi+qHa3svBzF2bXg==
X-Received: by 2002:a2e:530e:: with SMTP id h14mr13030522ljb.256.1639632964870;
        Wed, 15 Dec 2021 21:36:04 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:9e59:823f:f54f:8d84:334b? ([2a00:1370:812d:9e59:823f:f54f:8d84:334b])
        by smtp.gmail.com with ESMTPSA id x37sm145905lfa.287.2021.12.15.21.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 21:36:04 -0800 (PST)
Subject: Re: receive failing for incremental streams
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <b68822f1-0ad7-8434-6aa1-553e264e232c@gmail.com>
Date:   Thu, 16 Dec 2021 08:36:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.12.2021 23:27, Eric Levy wrote:
> Hello.
> 
> I have been experiencing very confusing problems with incremental
> streams.
> 
> For a subvolume, I have a simple incremental backup created from two
> stages:
> 
> btrfs send old/@ > base.btrfs
> btrfs send new/@ -p old/@ > update.btrfs
> 
> The two source subvolumes are snapshots captured at separate times from
> the same actively mounted subvolume.
> 
> On the target, I attempt to restore:
> 
> btrfs receive ./ < base.btrfs
> btrfs receive ./ < update.btfs
> 
> The expectation is that the prior command would create a restored
> snapshot of the initial backup stage, and that the latter would apply
> the updated stage.
> 
> The prior command succeeds, but the latter fails:
> 
> ERROR: creating snapshot ./@ -> @ failed: File exists
> 

You need to restore it in different directory. Each send stream defines
subvolume and you cannot have two subvolumes with the same name in the
same directory. 

> Since it is obvious I cannot usefully apply the second stage to a
> target that does not exist, I am puzzled about why the process performs
> this check, as well as what is expected to have success applying the
> update.
> 
> How may I apply the update stage to the target generated from restoring
> the initial stage?
> 
> 

You misunderstand what happens. btrfs receive does not update existing subvlume.
It always creates new subvolume by cloning parent replica and applying changes
to this clone. Parent remains in its original state and read-only.
