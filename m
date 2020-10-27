Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78A29C247
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820255AbgJ0ReM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 13:34:12 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37227 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1820237AbgJ0ReG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 13:34:06 -0400
Received: by mail-qv1-f68.google.com with SMTP id t6so1062528qvz.4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Oct 2020 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=89d5DfL29eJjNJvFhHUr0ov2NLezkQ68RK9DhyCzy8U=;
        b=KkDulwcFK6Btsy1hgj2OxxMuKkn9HAlAtA6Flrzm88AOTbnGinlpNIDg7CFlDpJA6U
         AeA7jh4kmdVShTH27cgEY1/5Xdw5XI/hX2gpnivFPlcY8GCk9JEY5j1nI33xBpES6uig
         1Spp1Xj7tyQH+gSrCx6u1BGG747WIiGV6xVH1llS5+GUPvnTXOXWLpsJ8d+hUWwyQXr1
         bZakYWa30ICK5cdZxrL6Kx1tqBcWGD/7qB2gnFkpn58lsb8VFvU/ZkvSUyxxOEaaSrEn
         wK+3TzqrulIE6VjiaT9qwmrJT+vSbGpLFSsDLO7RhvWxEEaC67I+RX+cRQydvlOfrp8b
         NKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=89d5DfL29eJjNJvFhHUr0ov2NLezkQ68RK9DhyCzy8U=;
        b=Vtd8pH4AY0DzPCh3wFpDwta7MMqKZv4gUpDSgaAsW2vOJe0pBnvMxgMo6VYnOqkfvd
         W26CsXyyP4wkjwFAbE2d6u4W1Qe7/M97HBfzWpmI9QWOCtQ2ELpXrUHDfbkqqVtYjImz
         AvrajPr3z0ivDorDYftmJSXUA+YZsobUGPiqgpzMkbPPAoWHMPVW7qjH0H6mQxG0Lali
         00C+YXPsBYpEeehZVOU8IiEoQzWkzjsWrvsbkBEwnSIoU94cB36Hn8ItaZfseyT25C6z
         WnVtdIKt5r76lNQrmpXez22eW9gvcWb/6P6yP4t5z5akeS4aJ32E4KHSDqjHWw/e0ncM
         NCow==
X-Gm-Message-State: AOAM5327CQY6dM4MNQnqAWbNwylPLeRBAr4auvrkAp9YkpdlbD4dtpyG
        d0Z+NRV8wjPZTFVEmTdZZjUtBdjdeAJXYm6o
X-Google-Smtp-Source: ABdhPJyC/ZNe176zFCpiZcOKyCao8Aci+2ZEjTuX3x4wC+1V0l1ceiKF2dE3vwcglP8xj11omHuWWw==
X-Received: by 2002:a05:6214:4af:: with SMTP id w15mr3547238qvz.51.1603820043940;
        Tue, 27 Oct 2020 10:34:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a10sm1146429qkc.79.2020.10.27.10.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 10:34:02 -0700 (PDT)
Subject: Re: [PATCH] btrfs: do not start and wait for delalloc on snapshot
 roots on transaction commit
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bb2b1573dc60b8e743e8675fab5a13c15e7dcc85.1603802247.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b251d96d-4f29-1b64-23e0-f45831c1c452@toxicpanda.com>
Date:   Tue, 27 Oct 2020 13:34:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <bb2b1573dc60b8e743e8675fab5a13c15e7dcc85.1603802247.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/27/20 8:40 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We do not need anymore to start writeback for delalloc of roots that are
> being snapshoted and wait for it to complete. This was done in commit
> 609e804d771f59 ("Btrfs: fix file corruption after snapshotting due to mix
> of buffered/DIO writes") to fix a type of file corruption where files in a
> snapshot end up having their i_size updated in a non-ordered way, leaving
> implicit file holes, when buffered IO writes that increase a file's size
> are followed by direct IO writes that also increase the file's size.
> 
> This is not needed anymore because we now have a more generic mechanism
> to prevent a non-ordered i_size update since commit 9ddc959e802bf7
> ("btrfs: use the file extent tree infrastructure"), which addresses this
> scenario involving snapshots as well.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
