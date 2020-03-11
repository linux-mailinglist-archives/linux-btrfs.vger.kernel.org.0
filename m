Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CECC7182086
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgCKSQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:16:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34332 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgCKSQG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:16:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id 59so2316357qtb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/Mmsx5FlxzO0dqbhw9zouW3Day5vBG5VqAICmXOmG8=;
        b=ItRUiC/0O5QIkmax1pQvcct2IR47Doo87vvavhDAR2peodJtZ+T5GVCo6Hy+InozMT
         GrM4mVIFCHzVPrrlYKyT/d6xIpz+8M0T+T7s+cXFX6ntVyW7+CUk9MsZHWuwcpE/fev4
         pJWwLMT+JHxHt1Bb1Xv104UDNaGl171vxtPvSYQOjRPhW4lCcxjqo5E9rq5RvrIR4mbw
         eYMpTNEbLYw/s16OIh2edEV8NmansurK/rqIevcy6ItZMlBrXDKKtOfjVPLMNar1ZHCt
         6tBCG/spkbhZKiDNxbzvEIn3NTu0EBDvGOT12VpMkeHhik7uHYb9g6tw0femdO6Eq0JK
         2ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/Mmsx5FlxzO0dqbhw9zouW3Day5vBG5VqAICmXOmG8=;
        b=oIDUebzCy3/3iPDN0Xz9+CouToT+nY+SWeA824Knv4rQ6KajUo3AoBKxg9morqLoY2
         lpKEMBumiGZsmBFGqek60xDXBF+HIdVvgtTr3tyfFcKeLCg1My4ETgj2xokhpO2QwoWD
         1yk3nQ+L5VktsTALsOcDoP0CpRAD8sLTnbU9ewMmDKvv9PNRpe/ltBzkvVl8FTwPcYGk
         iqmnY44YUE3dmqpP8aNwXu1t3gr4LgU3a7KePe0Ao8eIT/PSBO9LbHAqrH/OOwVDPys1
         KikLrMuCYadj9EgYm+B6iqAUZM+XtyNzPLOBgRUBSg9mcjY0gBX1MgcZDLItAqCL3ET7
         E3HA==
X-Gm-Message-State: ANhLgQ0gJX1+9DiVGZ0RD0J6VjNaUWiJzFYdWiam1JQ2cqD2LmJv7Dzk
        Pib8xAXx4ZOKiI3ArIwW7Sbtjw==
X-Google-Smtp-Source: ADFU+vs5v5iiob4xGq82KLdMUN3o+FldzoFl5/qq7XUd85diFV5darWaXBRd/5cUAsTmmYWCpRJGHg==
X-Received: by 2002:ac8:6bd1:: with SMTP id b17mr3825314qtt.28.1583950564779;
        Wed, 11 Mar 2020 11:16:04 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d72sm5426367qkc.88.2020.03.11.11.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:16:04 -0700 (PDT)
Subject: Re: [PATCH 13/15] btrfs: simplify direct I/O read repair
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <34e67c2f-94d6-d824-bb66-8165c62fb1c1@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:16:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Direct I/O read repair is an over-complicated mess. There is major code
> duplication between __btrfs_subio_endio_read() (checks checksums and
> handles I/O errors for files with checksums),
> __btrfs_correct_data_nocsum() (handles I/O errors for files without
> checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
> for retries of files with checksums), and btrfs_retry_endio_nocsum()
> (handles I/O errors for retries of files without checksum). If it sounds
> like these should be one function, that's because they should.
> 
> After the previous commit getting rid of orig_bio, we can reuse the same
> endio callback for repair I/O and the original I/O, we just need to
> track the file offset and original iterator in the repair bio. We can
> also unify the handling of files with and without checksums and replace
> the atrocity that was probably the inspiration for "Go To Statement
> Considered Harmful" with normal loops. We also no longer have to wait
> for each repair I/O to complete one by one.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Man that was a doozy, took me a while to realize we only ever use our ->logical 
for DIO.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
