Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D7A80A8
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfIDKsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 06:48:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34284 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDKsq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 06:48:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id a13so23819343qtj.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MP/Ddwx2H57lHXI8hI3UOtaNzy0Sj2Wk0zQyjASbdA8=;
        b=0VpSv91PzgwLYgwJ8y79l7OWEl6fe2CyF1UNm5H3MXAY2/OZ1lsCTClL+sl3y7uHox
         Y488BneV4nanJ5b4fppLKH5CptMky1kot1u75wBkIKlm0S0ndGR10iQO8Coedx9HoY04
         52aY9YXX5xL3i+/eYth+dHcahW0LJm55lFFYncUeFJu66TE/Nv4s2MafbVrpI+OAkLGH
         7PCnkHxzEDwm4Njl4KGgEOy6fopSy9LqvFgaLWiM4QR2qv6Rhqh2qAGen0zx32aPxrYn
         MbJpu9xZR8ufbhKDbqG9VtlhIkyOMRaXcu+pO+cb+iIEORjyKPofb7T0BJMPj5Qv49tN
         qaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MP/Ddwx2H57lHXI8hI3UOtaNzy0Sj2Wk0zQyjASbdA8=;
        b=KrBBCBx7SReNyGEnxVZbUbO/pmXLZVRGDUpVfBwpuUuSOOdyC1uJwtV/wfLgcNgTQc
         8FrDxx+uUHIl4cIgF9fb1aQ3WvAZ4pVFG4VCuYaN8kOar8FEJBuj2kYgLNDr8wD3F21W
         i7P3Fn9Ig4Swo9i59OobGULowxF/2Z4ZNAX90pir5mCXFwCD/i+e/cakx2cPo84jPmhc
         lNmLaDl1d0djJQSCfDEbpntbvcjE84B9SnavrjTO+LIESh9GjA3DB3Lcflh9pJJJGssG
         CrFSIfcynogmo7/RebeeSj8aY3KYm4ZSNamzr5tCsQJ/kwV9dRqesCKVvAEduJY9neb8
         OUCg==
X-Gm-Message-State: APjAAAVtt/bXuTmemQK9PpfSPFNaPNh23LYBPJBdtHl4PhNw8SbE832I
        1oEzU72biaVG3Q8pjZIjNsznSA==
X-Google-Smtp-Source: APXvYqy9YQ0/2reW/VTGMpa4DXBhBkGNEzIVdalaRtiveZv63Qt93WqHFW4lXIHIBl+Qp7GKVG9S9Q==
X-Received: by 2002:ac8:2d8b:: with SMTP id p11mr28963753qta.220.1567594125444;
        Wed, 04 Sep 2019 03:48:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::48d2])
        by smtp.gmail.com with ESMTPSA id e7sm4095977qto.43.2019.09.04.03.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 03:48:44 -0700 (PDT)
Date:   Wed, 4 Sep 2019 06:48:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Hongzhi, Song" <hongzhi.song@windriver.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: Bug?: unlink cause btrfs error but other fs don't
Message-ID: <20190904104841.nrdocb7smfporu7m@macbook-pro-91.dhcp.thefacebook.com>
References: <49edadc4-9191-da89-3e3b-ca495f582a4d@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49edadc4-9191-da89-3e3b-ca495f582a4d@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 04:02:24PM +0800, Hongzhi, Song wrote:
> Hi ,
> 
> 
> *Kernel:*
> 
>     After v5.2-rc1, qemux86-64
> 
>     make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc
>     use qemu to bootup kernel
> 
> 
> *Reproduce:*
> 
>     There is a test case failed on btrfs but success on other fs(ext4,ext3),
> see attachment.
> 
> 
>     Download attachments:
> 
>         gcc test.c -o myout -Wall -lpthread
> 
>         copy myout and run.sh to your qemu same directory.
> 
>         on qemu:
> 
>             ./run.sh
> 
> 
>     I found the block device size with btrfs set 512M will cause the error.
>     256M and 1G all success.
> 
> 
> *Error info:*
> 
>     "BTRFS warning (device loop0): could not allocate space for a delete;
> will truncate on mount"
> 
> 
> *Related patch:*
> 
>     I use git bisect to find the following patch introduces the issue.
> 
>     commit c8eaeac7b734347c3afba7008b7af62f37b9c140
>     Author: Josef Bacik <josef@toxicpanda.com>
>     Date:   Wed Apr 10 15:56:10 2019 -0400
> 
>         btrfs: reserve delalloc metadata differently
>         ...
> 
> 

I meant to reply to this but couldn't find the original thread.  The patches I
wrote for this merge window were to address this issue.  Thanks,

Josef
