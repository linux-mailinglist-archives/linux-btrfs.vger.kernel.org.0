Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7C2506DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHXRtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHXRtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 13:49:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434DC061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:49:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 92so1405701qtb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tpc484uRp7hkTe+toaoEDwr/cTZkofXqM1Ryzp5uLPA=;
        b=yZkfQiTw1IGHzOo+ieMrUFjj7nC7GRmJ2qwmiqoKRQge07cTaMJN8lKluap+y57c8Q
         nDgs+HAxSGRhpOyLJLwdXbkT1m6iayJMJzlWrLh7WJNLvoRUZbufX39K6VIIfafzIoVe
         Yt2KTXLXITFlcWIuut+mdCVDVOdOAAmKHIspUzHTgUpxslplHUnopyp8M0+3W3zLeO7z
         mlsTWQjYNj4aEdy3TiSUZaHG3Q6biwGkVIOdE8TzVmsiZJ/2FH72l4JkQ20A4nkCzBjG
         7zqPOKzq/XE7Ra2qRhwMgUjAHFBYodNIBIC86GYXwvFkmsvVBVVZF3yUCP+14fG8t0U0
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpc484uRp7hkTe+toaoEDwr/cTZkofXqM1Ryzp5uLPA=;
        b=QQub+g5eLlPK0dE7WJLKlYVF4Z1BAt5m9JKeQR4I4TTFvmVC+iWkErNnKjB7KDbAgk
         22+iPDEYxwkYJXA+bN5E9x4dYnr+9gT9rXfZQnttbbJZ/XtmGp3DWla+CMmArB5H9pN3
         0wPxCeS/PRnO9Rk356uotPomqdygV2mwFeoLHlV5+PaSUSLQSwyayZcYOgNAjfDYaejx
         630uOotOWIJbLF1L1P76ri7+mRBkz9gESRwRnPly8WsrfGcmBA9oNHHSgBfCucVoNwXb
         rFRG6+/VQ+nkDSF7W12vzc8EWdhMGWG0Pv3UPW3CxCeslQmQWVYeMCmPi6RBBqMMTSF7
         vwZw==
X-Gm-Message-State: AOAM533oi+BXwp2o8XXbdFASC4SEYVOo1PjGFzaruu0i1LBh7AoU9i53
        Vkw7iKZsDqXOdYdyvkEX6RX4CHvT4ewMejxL
X-Google-Smtp-Source: ABdhPJxFZsXm+TSUR4TpS2N+FmiAihT73qC4JpC8sFH/8nPffTXtI3PwNMKRQDfEt8734oX0t1Sh2w==
X-Received: by 2002:ac8:4892:: with SMTP id i18mr6006220qtq.360.1598291359813;
        Mon, 24 Aug 2020 10:49:19 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a6sm3547385qtc.13.2020.08.24.10.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:49:18 -0700 (PDT)
Subject: Re: [PATCH 5/9] btrfs: add send stream v2 definitions
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
 <c3c83c0889781ab3e44bb02373b86979b4426bc8.1597994106.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2f6e57fa-dad9-b896-a935-ab98c1e538c9@toxicpanda.com>
Date:   Mon, 24 Aug 2020 13:49:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c3c83c0889781ab3e44bb02373b86979b4426bc8.1597994106.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:39 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This adds the definitions of the new commands for send stream version 2
> and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
> chattr), and encoded writes. It also documents two changes to the send
> stream format in v2: the receiver shouldn't assume a maximum command
> size, and the DATA attribute is encoded differently to allow for writes
> larger than 64k. These will be implemented in subsequent changes, and
> then the ioctl will accept the new flags.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
