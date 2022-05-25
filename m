Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0B533652
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 07:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242227AbiEYFLO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiEYFLN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 01:11:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52435FCE
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 22:11:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c19so21107672lfv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 22:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=B9EEsaS11NTPcjZWYS+3NCdMVTpVsnufwOGn0FaRK8w=;
        b=g3zdqnS3oTuluHeu3q8Q5OTuv7tOTfurAoUU+J89QnlLiPBeDsu133Oi1mxIAS6p5q
         8ggN9ekJUUznry6mJw2biJB2iHfvQ9J8PSqccMTE+V1nIdShi2z8MPGclYNbXrGkde2B
         I2bRASFu9QMPxwgbwEaK0Ue9Um/CjMOt1hFjfWhBISTqJkYmzDr5rUxNOQaO+Zdh68XO
         36CnIwXezFB6W2BU9lve6weCB7rZYV2YGvBK5zMwQTi8cV6prGIK0fDNF+CcuA5ISk8f
         pvPiKKBVTDPzp7c5R8DtGmmHCK9Rj2RGmDceaa3O6Kc+uhfLqTr3Uwu/h+LBm1Fhu5vn
         FCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9EEsaS11NTPcjZWYS+3NCdMVTpVsnufwOGn0FaRK8w=;
        b=UlMGYvMDgDUNRsvaOdx2RD0vgjjfuFM9mBuvNP03uQw7kveeD5tW2jzd3n60lWr0Tt
         1XTn8Hxhx1+kTV5H+SDywuP07FGC+ogATg4dGtf9I9mT4LwaujmEngBf/MBCNz4d/x4j
         tp6YeRVgchCmBmbII1JZJu0iVNxw7OLce7gnE5Sxvoi7TXplKS5RqJxysFtihFlgt5rJ
         IlJr3W9fHNo+vde1HoDAcYAZg3V31Ekm9PiUyg9XfUDQeimF11XVhj+7ZTR2r3E/lrt+
         zHsh1BAByUsGJDsiuj0irGad5/i7M1jzZbiGbBYDJ/kDEUzT7MdmDqxHmHsaJ8bZpAyI
         y6/Q==
X-Gm-Message-State: AOAM532GRA/+9wXnpU/rzA7LKi4iS9qEHPUMM1wrYY4Tr7uukIAEl15x
        6OeXYdWzy8ieWacw45LRuo9/60zAiJJ2Cg==
X-Google-Smtp-Source: ABdhPJxI+ygll/EyT0WduHaJVBtSF9NR27CSWAErMwnK+3kaRlIVak0EjAYkbcTpmDY+OMx3AYQAXw==
X-Received: by 2002:a05:6512:3d1f:b0:477:bfe7:5521 with SMTP id d31-20020a0565123d1f00b00477bfe75521mr21809628lfv.533.1653455468647;
        Tue, 24 May 2022 22:11:08 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3365:3f8a:f369:3402:2fea? ([2a00:1370:8182:3365:3f8a:f369:3402:2fea])
        by smtp.gmail.com with ESMTPSA id l9-20020a2e8689000000b0024f3d1daeb5sm2813662lji.61.2022.05.24.22.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 22:11:08 -0700 (PDT)
Message-ID: <30c67374-ba93-b613-147b-2fc855419d5e@gmail.com>
Date:   Wed, 25 May 2022 08:11:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: cp --reflink and NOCOW files
Content-Language: en-US
To:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24.05.2022 22:02, Goffredo Baroncelli wrote:
> Hi All,
> 
> recently I discovered that BTRFS doesn't allow to reflink a file
> when the source is marked as NOCOW
> 
> $ lsattr
> ---------------C------ ./file-very-big-nocow
> $ cp --reflink file-very-big-nocow file2
> cp: failed to clone 'file2' from 'file-very-big-nocow': Invalid argument
> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
> 
> My first thought was that it would be sufficient to remove the "nocow" flag.
> But I was unable to do that.
> 
> $ chattr -C file-very-big-nocow
> 
> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
> 
> (I tried "chattr +C ..." too)
> 

E-h-h ... you tried to set this attribute expecting it to be unset as
result?

> Ok, now my question is: how we can remove the NOCOW flag from a file ?
> 

btrfs silently ignores changes to NOCOW for non-empty files.

NOCOW also implies no checksumming. Enabling COW will require rebuilding
all checksums for existing data. I do not say it is impossible, but this
is certainly much more involved than single bit flip.

And disabling COW will (potentially) invalidate all existing references
for which checksums are already stored, and those are likely read-only
and cannot be changed at all. So it is only possible if it is verified
that no other references exist.

> My use case is to move files between subvolumes some of which are marked as NOWCOW.
> The files are videos, so I want to avoid to copy the data.
> 
> 
> BR
> 

