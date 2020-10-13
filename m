Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26E328D06C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbgJMOkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbgJMOkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 10:40:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5222C0613D0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:40:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o18so29034ill.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2GsykO5vD8hKipFsgRGzZhuBcxijfEfuP7oTRJAAhlU=;
        b=Seia2Elzc0yu8zJKoUprehjWHMYI2hI16COEUftQ5nh94i/7FxyMt4vt7bMxB+GN/K
         YHsCRhfW/p73Uz/8UENPaOLW+W2zVMbsX9XyIoV/EdkMOUzv23CjSJIkiWOV3KbsGEix
         TkSonojDS+dkt5GdaOebe/5M9px/lV4G4bUw/duS5QQ4ACfn4mKJcidMhhJHxngerj6s
         CtnOXF1XKcgbBfHhdJJczgYQer0GJJQyr6CpvOSnYEQFdf2inb66L1BUkXngkWn+tQ/r
         7Y2ZU+XZUqN8ANbxeuWuEgSZvHkKgNyiwL1EWSHDmPo10nVmTBvk9hd6JLOv5ncQRi+S
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GsykO5vD8hKipFsgRGzZhuBcxijfEfuP7oTRJAAhlU=;
        b=W0hUqvb7Rw5KXKhQJYACGcRHMykq+RdXjkc+YtjZa0ARaXNbxAEPiyLH/W5DgQaf/a
         cVWmWKAPiM90GLhDclOXZYFk1YCAfxod92HFnhljlm3AyxlomX7qEq04oH+lQdR8E875
         Yz6Yy5wP1M9rUPUEtti/f99ZOQsGya5zLZ4PxTcBhYR0aWFl1ZN6CkICb+ZYC1TvRWnk
         F48Q1LiZxfN8fnq9xD6p48pj78ILrY6BxuXLUMrXJAlx1vYXU57p/Tmsc1u3EH4qmUf8
         RhPt8deaBzRO5VyLS08iX9e5esufOWmDKESbsgrJtrY9IF8GsY250MrWtFmfAPoHMNJ+
         HFzw==
X-Gm-Message-State: AOAM530ihQ6ghD+FwDf8F7/8ZFyAb4BoNg9WUf8d9LlKth+h+SqDiIfD
        6rXef4cxNwMEfhEVztqgu8OrELXpY5e2zA==
X-Google-Smtp-Source: ABdhPJwS8EtZK+KxU8uo85FxzN6V0jREVR7usWJ8oolYeKhtoLJKWTSALGNOeEBntAW3ADyHlO/zWQ==
X-Received: by 2002:a92:9a41:: with SMTP id t62mr233215ili.202.1602600033853;
        Tue, 13 Oct 2020 07:40:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1096? ([2620:10d:c091:480::1:d057])
        by smtp.gmail.com with ESMTPSA id d7sm10698297ilr.31.2020.10.13.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 07:40:33 -0700 (PDT)
Subject: Re: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1602499587.git.fdmanana@suse.com>
 <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f5be6de5-99ef-2349-be83-e8271568b42e@toxicpanda.com>
Date:   Tue, 13 Oct 2020 10:40:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/20 6:55 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we drop the last reference of a zone, we end up releasing it through
> the callback reada_zone_release(), which deletes the zone from a device's
> reada_zones radix tree. This tree is protected by the global readahead
> lock at fs_info->reada_lock. Currently all places that are sure that they
> are dropping the last reference on a zone, are calling kref_put() in a
> critical section delimited by this lock, while all other places that are
> sure they are not dropping the last reference, do not bother calling
> kref_put() while holding that lock.
> 
> When working on the previous fix for hangs and use-after-frees in the
> readahead code, my initial attempts were different and I actually ended
> up having reada_zone_release() called when not holding the lock, which
> resulted in weird and unexpected problems. So just add an assertion
> there to detect such problem more quickly and make the dependency more
> obvious.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
