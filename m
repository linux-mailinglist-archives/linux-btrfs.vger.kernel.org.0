Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D462429F441
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 19:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgJ2SrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJ2SrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 14:47:13 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E8C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:47:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n5so4074616ile.7
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZMJD2zxwtZbknZmbE9hMjmVxqfUx6UsvLNnDLJbJcpk=;
        b=1hHkDOAPy0yqt8erRkYfJ7nfmKCrzuzHfFx6YQrMIus1HXpH7iS60AGZ0N2/5rwGL3
         u3YG3nIPrK0uhp4GV/Fj2xKrSmhOjlI/yo0ZT6DJTrv3NLIgQsHLfuT4s4xNIyRes61v
         WM/CHVmN4otOwLp9qJs1dFSJPOliNTz1SQr1P08jYNA31V+hOrpeEfG/WSXnUM62pC9X
         pOGOPQNkIayD8gcv4YCVWsFEzP8zTaNRzGJs0U0GSEEtRKMOMD6hFrmn3KgI+6fUvZeg
         wCUcEcneS7Cu7Cv4KPCUQFI8HrOlkwWsCltYqUGra09uXHO5heXAiL93BPDcUXLFwVTI
         PzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMJD2zxwtZbknZmbE9hMjmVxqfUx6UsvLNnDLJbJcpk=;
        b=mAKmDqMDkMGw7/p/flHfvYPlpp3JTJVI5rALsQ9mkbC+B0kCdV4InBhhUc8eP4heXd
         4GcJ1iUH6X/SxFOYfevbiqJ018ci52oqSC08F9uqcpTiQHNrozuYjqG6HYCIJwwEMYJD
         ognHhP11mbT5gt6kIrzIWAYsTL+zzm7hDgTLwo23eezz9v7e/14RYLtMfD61H1+ml7MN
         bSujZ9H/aZbvffGoR+FdUdaZ6mHSEYszbfs4WCCx7qlA48ph5wPtzHSBs0GYVnR0Iveb
         OOgB5QXfoJo5KfEM44mNFvA0kmShsT3uxJtjCdFBl1mJKpgqtTVaxIRt/uC/9Vr7ZrUg
         b43w==
X-Gm-Message-State: AOAM530TcloC2SUiSH/c8dtXCasj8+k5gcSUM4MIswwPd2blq7N9/jsr
        DHSPqpAi/bq3Wj5QzYG9R8iDW50taqU0+g==
X-Google-Smtp-Source: ABdhPJztc6owKAot8PQqr2tAXyU5aLndjeNs0+KBsrJOFcx8ZbzmCui1c/m7tI2NkfaXnjfVPQaMRg==
X-Received: by 2002:a05:6e02:928:: with SMTP id o8mr4458379ilt.47.1603997230877;
        Thu, 29 Oct 2020 11:47:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1376? ([2620:10d:c091:480::1:18c8])
        by smtp.gmail.com with ESMTPSA id v15sm2968702ile.37.2020.10.29.11.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:47:10 -0700 (PDT)
Subject: Re: [PATCH 0/8] Misc cleanups
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603972767.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <26a7f0e0-b887-550f-6f1d-ad00d4eae009@toxicpanda.com>
Date:   Thu, 29 Oct 2020 14:47:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 8:01 AM, David Sterba wrote:
> Clean up:
> 
> - lockdep keyset definition
> - accessors for various b-tree items
> - message updates
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
