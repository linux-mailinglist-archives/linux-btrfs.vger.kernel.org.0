Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805B8267B8A
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgILRWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgILRW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 13:22:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D29C061573
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Sep 2020 10:22:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e22so3106673edq.6
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Sep 2020 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kixOzjoZeQAvbP6FTVx7P0nmvT/IgPPGmwFeq8FBqKw=;
        b=Hagqh2eWovqaJLx/fRuxzTbfzeS0ZJ1rF7SLCkcVE8+75akXHGrenv2Xv7drh8hMDJ
         yi0VqGu3FgKHk8REHrS4/ri783mpN2jKd2qNvR/iohSLP+OsGRDdgxHeJm0DDvU9c0Kl
         XBLAdR9ZOyflP8c4riCvvG+4ZUX3oCxroUJflltYkQixb6yKYVwP98cPgqFw2Vo2NtZ0
         Kzh79roHZGc+uoaP2K2aDOHcphEirM1jSQn/OeUKXQZoDWucOOsN1GILOua2YdHe+RtF
         ZMpB5V0BRqpRhpAztkLBiJ1Mw3VftJpQCEHAPPD4KfO9KOHblIj40VJCHJwggfBwQ/i3
         CmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kixOzjoZeQAvbP6FTVx7P0nmvT/IgPPGmwFeq8FBqKw=;
        b=ItqUHUlRqA1fK65wnphnh++qUL4Ux8krda1lPkJc2TD5YTOVRdcdFvqwNa5mpteYDL
         eCaInJnluj0uhr7rHsZQ8KNzhhNS0NUnwASiAyQZbtpcPMSoNjt12KqEKhjhqxp0RbdD
         W9g+9h1lEYHz7zgIfe4sjAaW8dkzg+TRtV43hyov5HE7BK8vldLCQYHRPF09uXOfck+j
         oMGE8Jh3/My08AgY+X73+d2JtqHhm12dQ2ugDF2pjh5lxh+wIlfLUuZpMc/MnPWuFK+l
         B+SUYmdvFshvvDoWfT6uPjZPiUe0OK1L35rRQLmEQD6ElbPD59hz8to+yAoXxcrE1eZK
         XsyA==
X-Gm-Message-State: AOAM532Cn1lNUXA6/hdiaaL30gEXmIxqbgaGRE2hcDHVS3I8xH5KjPmu
        R0ZOYBSvoR2YL+HlVZIUhRL7coZrwRY=
X-Google-Smtp-Source: ABdhPJzsgTkB0bi1AXHZTj+3/fWuG6rsWIs3LBRDeuWuDIF9axbkmMTQnEVQdHDkCTt2X3zou66EKw==
X-Received: by 2002:a50:d9c1:: with SMTP id x1mr9421902edj.283.1599931344947;
        Sat, 12 Sep 2020 10:22:24 -0700 (PDT)
Received: from ?IPv6:2a02:6d40:2bd5:1400:25ad:87dd:5fd5:2a41? ([2a02:6d40:2bd5:1400:25ad:87dd:5fd5:2a41])
        by smtp.googlemail.com with ESMTPSA id a5sm5300227edl.6.2020.09.12.10.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 10:22:24 -0700 (PDT)
Subject: Re: Changes in 5.8.x cause compsize/bees failure
To:     A L <mail@lechevalier.se>, linux-btrfs@vger.kernel.org
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dccf4603-ee16-37e0-11b2-d72f8956a74b@googlemail.com>
Date:   Sat, 12 Sep 2020 19:22:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 12.09.20 um 19:13 schrieb A L:
> I noticed that in (at least 5.8.6 and 5.8.8) there is some change in Btrfs kernel code that cause them to fail.
> For example compsize now often/usually fails with: "Regular extent's header not 53 bytes (0) long?!?"

I noticed the same after upgrade from 5.8.5 to 5.8.8 and reported it to compsize:
 https://github.com/kilobyte/compsize/issues/34
However, since it's userspace breakage, indeed it's probably a good idea to also report here. 

Since you see it with 5.8.6 already and I did not observe it in 5.8.5, this should pin it down to the 5.8.6 patchset. 
Sadly, I don't have time at hand for a bisect at the moment, and at first glance, none of the commits strikes me in regard to this issue (I don't use qgroups on my end). 

> 
> Bees is having plenty of errors too, and does not succeed to read any files (hash db is always empty). Perhaps this is an unrelated problem?
> 
> 
