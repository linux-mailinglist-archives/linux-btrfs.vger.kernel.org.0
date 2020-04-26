Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2277F1B90D8
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgDZOZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 10:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZOZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 10:25:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244DC061A0F
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 07:25:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so16605000wmk.5
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KHbdadN8LRBy/kAo+cYS+PNqS+7Rmu7w94Y8iv4BVSw=;
        b=gbnP8CydQx1+RWL8iKJwl/ih5jmIxa5hZhUYdyMEU0uXNDvgM1c42OqDCJxpriXtli
         KOtCNcw1VdN9PyPAR9gbEFc+X95mYShVrmhFVImLZmYYBHi9IFHZg4HXKplt3YdVrm0O
         Bayq0u81nKKS8O5yz2dPGwb1kaynyzoQ/e391CERiJASuG4B6EOMzrdEyj0RcBDVw+Qh
         e+DWljKHdyHK5wb2KrbRQIJQFAuo/3kz2scvxWipkWQf0RwjDz2pr+3/R2bx9yZ6S0ZR
         PpAGuaMPjghxoHbnmjQ9Njx/kC/U1VW/3MIKY+06R4mdSxuuQ8s7G5kRoKD3K8nL0SzL
         KUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=KHbdadN8LRBy/kAo+cYS+PNqS+7Rmu7w94Y8iv4BVSw=;
        b=GEY3Z5IhughxMntDwUcS048Q+lO7dSWX0ZoZMkt1AtEbogDtw+L5hZuNTfrQ1QNOjm
         HBHnIBr8jOTCQ8+aCH1++5w+3R6KkytNizH1bEXS8Oz2c1rnD2T0QqEweMzjaF/Ha5mj
         73OLCzMvDWO2ozkGeyudzuU7enEEGQAePgiNPmHi0blbgflH1SGXV2LlRNJefQ6U/hEk
         XofaIrDxp77nnsqyFjrHrTfAQYbI4zRjxY2YOi+RrFpZrIFVhwQz84vfdtAKIvTobhg3
         te9nMMlx50ciWzD72q3lkOvxZGsiRrl/b4RI9d+cK/qJrkGLJ2i5HigWUaQKnbpKE4D6
         cv5A==
X-Gm-Message-State: AGi0PuYaw/YL+QUs11XkPIqZQ/TUNQMSiK5mXHPcp8BdY29iqRTijbUm
        Uwti2j8DXWZbCJNH/cHm6szwD5li
X-Google-Smtp-Source: APiQypK1qr9yQjrPMLu4zbxd/cjlIJ5tJm/RBeduWwl6OFr/Hxh3Dre9PLkTMwHL++0UtVHxm7RlGg==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr20613122wmf.166.1587911146539;
        Sun, 26 Apr 2020 07:25:46 -0700 (PDT)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id v16sm11395863wml.30.2020.04.26.07.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 07:25:45 -0700 (PDT)
Subject: Re: Btrfs native encryption
To:     Nikolay Borisov <nborisov@suse.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>
References: <CAEg-Je8zM4xq7GEG+cphKkR6wjquwG3jv9bbJ88chzrZUEzuYg@mail.gmail.com>
 <59e1e1e4-b856-8784-3c4d-3fbd7a724cf8@suse.com>
From:   Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
 /dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
Message-ID: <7512bb89-65b1-edcb-9572-6afa2e07fd2e@harmstone.com>
Date:   Sun, 26 Apr 2020 15:25:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <59e1e1e4-b856-8784-3c4d-3fbd7a724cf8@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Last thing I heard was that Omar Sandoval at Facebook was looking into it. I never heard anything back about my patches, though.

Mark

On 26/4/20 3:14 pm, Nikolay Borisov wrote:
>
> On 26.04.20 г. 16:54 ч., Neal Gompa wrote:
>> Hey,
>>
>> I was looking into encryption in filesystems (for supporting sane full
>> disk encryption), and I noticed that there was some work last year on
>> this: https://lore.kernel.org/linux-btrfs/20190109012701.26441-1-mark@harmstone.com/
>>
>> What is the current state of this work? Is it just the same as back
>> then, or has there been changes?
> No changes, btrfs currently doesn't support encryption.
>
>> Best regards,
>> Neal
>>

