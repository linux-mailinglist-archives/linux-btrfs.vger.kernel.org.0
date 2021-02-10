Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D2316AB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 17:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhBJQFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhBJQFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 11:05:06 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2AFC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:04:25 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v3so1872981qtw.4
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vWMh0ttac95aV6wXLGVtvseMLVxZT4WzhboTV8D41OA=;
        b=IYCeUBmgWiNEm9CAb3ENBFvZto/T8d4Z5It2E0xgQSiEZtuTF25mXUPV+eDInkP1F6
         Y3Jk0NO4yLsD+2QiCz/gyOqeLi1sANoLwn3FNI+poYEK62ZWSHbWDWuPGcx4v1j07ilt
         Q41jwcjLRGdOgeuFZqviXniFFwsrc1i9S4uV+beERQ2kE0euougiqPOdb9DcT/59sxOZ
         fPjfjNynSt8kHemOpYzrsFB3XpXSX7nVAC2xEAnarEHSK1MnKoL9CgaohsCMxbrp6Ldh
         Z/AOLkDLSAkOY7ZKO9zRoWkXGsx+KZr2gJ+0+UgC5vNKKT9rOCb9DqcprzZ/wuDKddz9
         bCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vWMh0ttac95aV6wXLGVtvseMLVxZT4WzhboTV8D41OA=;
        b=eC9vCMnI92v87wz18Qmn43lKtjDNNrsafpW38t2oh+fs5sEGwJ0SKX4A4OzclAS5dM
         lTfZMwBmu7nCev2vlJ9Mu59BRAzvjw/W0XrleJJ3AXXrii/a1oRgXFxo2he2nFaNWZ64
         0GQPq6Qyb6UalA0fTddwXC01O9tmzrrQEQnga3Ir6liqbEqKH1IUMIRO92HZanaU4HCn
         XIm7ZpPuDGuPyJ8A8JfjjFobp+oZud06O/b6SIFixbbSlR3Q1+qCUzm3+UcyyvFgbUZI
         187kset4Drb1kUr9KKlud4OA9FGa1+2VzyN8rnxa3Pc+8/nOcWeYu7Yy2yaLb07mbblA
         HtTg==
X-Gm-Message-State: AOAM530ykimmMRcL+PP+1Z0CXXuMF5pF2YKEvJTPIkCvlQlbX3uu8XXH
        mGc0IWKR9tDNdz+WgMQsiMP/yA==
X-Google-Smtp-Source: ABdhPJyYBMKQDDA+f08DxFIJowHsI7B55kE+1YebLicE4xDHzTCWcAGO0ovW3t50+g6ECeDFuqrF7w==
X-Received: by 2002:aed:3964:: with SMTP id l91mr3387064qte.32.1612973064545;
        Wed, 10 Feb 2021 08:04:24 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm1534375qti.22.2021.02.10.08.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:04:23 -0800 (PST)
Subject: Re: [RFC][PATCH V6] btrfs: allocation_hint mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210201212820.64381-1-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <df7f0dd3-d648-ea9f-2856-7034a6833a51@toxicpanda.com>
Date:   Wed, 10 Feb 2021 11:04:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201212820.64381-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
> 
> Hi all,
> 
> the previous V5 serie was called "btrfs: preferred_metadata: preferred device
> for metadata".
> 

A few general points up front, first I'd highly recommend reading our patch 
submission guidelines

https://github.com/btrfs/btrfs-workflow/blob/master/patch-submission.md

specifically the 'Git config options' section, as it tells you how to apply our 
git hooks to your local repo.  This will check your patches for all the 
automatic formatting things we'll complain about, that way you don't have to get 
bogged down in those style of comments in the review.  For example as soon as I 
started applying your patches I was getting a ton of whitespace warnings, these 
are better caught before sending them along.

Also try to develop on Dave's misc-next branch.  I realize this is a moving 
target, so I'm fine with massaging patches so I can review, but again everything 
needed massaging.

And finally for a new feature we're going to need an xfstest or two in order to 
merge them.  I realize we're still working out the details, but the further you 
get into this it would be good to go ahead and have a test that validates 
everything.  Thanks,

Josef
