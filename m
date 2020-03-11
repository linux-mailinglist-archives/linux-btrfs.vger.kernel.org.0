Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3176181FDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 18:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgCKRqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 13:46:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33611 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgCKRqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 13:46:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id d22so2248155qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T4d4jIRQBOQaWObZCt2XjqNaQ6fQF1xGmgQsytBUoZg=;
        b=X95kAo5JyRfoILvSRPRsUASfN3BJdd0AuKURGreNUJsP/Cq0K+BPoHTXjPleEFEABn
         BZZFI8yuqfil2SY+td21/aH/ORAL57wpcnN32Nf3cnWrnLUXmaxH/7aWToDpF5xqvqdx
         4h9x7fv2v39TDAML11C9LbAbF7ZUUeh6eYS04QfHoM908tNbWZMjy6+3DiSpcHmn7Swr
         zTPQUYdP6nhTeUFKdfJrLFxampnSEuJHstwHfLBDyTx4SW73rPiVB6X5PTKjWSWINOSd
         avgVch8vJT5xZOv+G+JzxCZefeFaW2V8Kh3fB1gX27hAaR9V7li0jA060/egvJB7ltBP
         23eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4d4jIRQBOQaWObZCt2XjqNaQ6fQF1xGmgQsytBUoZg=;
        b=rGPJWsamwm+AXVgVwkQlkIy9+0TaxXflVpVZrhDJfTYnARyHiIAcqniQup0aLoKfKU
         iLXdZuhp1tcQp8oiCiXGPoAqMTwdVxMgPt3vvJWBTU/ipx8wjZlZEemAArf9dAZw2RmF
         SbkgxGCM7W8KWYDjlxcMcRHvqpJ6phtZXPodJFql1mQRg2wB4LR492PIewTJsUW46Bup
         hC/vP05YpdqyxtTzquDluBXnR8v0NOQGBqs9htOOAMunBM+fpFehoXY9cPGJ6Zn8Oixw
         SGBz7OL2eai2bEK+gr4rQ5OSq3Y2OPQKQFQ6N5+26WYzqAuVHZoK/hwmO9nSTL3VhSkH
         qgIQ==
X-Gm-Message-State: ANhLgQ3oRBE4nbfj1c9kGD7wVbLomvjIE58SpIRlTJ0lIp1SUlJOm2+o
        NdOOhkqrT7n2UGCU362kCWo5VQ==
X-Google-Smtp-Source: ADFU+vv9hDNzH8Q/2UjJc+sW4AF5hXNKDEBA6uPtI5UF8ZfQthR3CO/OBgX4jhu7ioYGX15g2YpwPg==
X-Received: by 2002:ac8:4906:: with SMTP id e6mr3767017qtq.178.1583948771602;
        Wed, 11 Mar 2020 10:46:11 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u13sm25382323qtg.64.2020.03.11.10.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:46:10 -0700 (PDT)
Subject: Re: [PATCH] btrfs: test power fail after a ranged fsync when not
 using the no-holes feature
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200306175102.5539-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e3a0230f-1232-043a-f095-e3e0e9c1d0b5@toxicpanda.com>
Date:   Wed, 11 Mar 2020 13:46:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306175102.5539-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/6/20 12:51 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test a scenario were we fsync a range of a file and have a power failure.
> We want to check that after a power failure and mounting the filesystem,
> we do not end up with a missing file extent representing a hole. This
> applies only when not using the NO_HOLES feature.
> 
> This currently fails on btrfs but it is fixed by a patch for the kernel
> that has the following subject:
> 
>    "Btrfs: fix missing file extent item for hole after ranged fsync"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
