Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB1242009
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgHKTAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 15:00:32 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BDC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 12:00:32 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so10236619qtq.12
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bvPZ3S0Nltzacc3bM4kJu7Xvs36B8ZouJnaLKK6CGGI=;
        b=0uLR4Gi/idvafVDjSKdn/ww3dqjg5D5XIBFwReCiGIgRU+ce0YreRz/yPDPjFxjuyt
         Lhkj3nMD812r59kLB983I6dMxJ5BQRAS4VBmAKw/CazvK1s/afMZt/JwvRs69DOGmp81
         KaNL5WIvBR4UXBR2vPIySCUjOI0zTQJ4TqhYKvgKADpJ6Dfzj0v0aXx/LoX6XMudh3lB
         ipWNjL+xe688mXFfZ6EPQhdDzYWYk0eam3Cnel19zZfH1FjUzBv/MTdRXqv9OgA2Aiyy
         ZkAOKvh3Mw3Do9GQZMt2dJML7Eaj35gW5OKr06aeImrJEvRRk87gLeNUuyJIKFr7idPJ
         DGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bvPZ3S0Nltzacc3bM4kJu7Xvs36B8ZouJnaLKK6CGGI=;
        b=sIW5TjHttbZc6mdCDXkjRAwTfVgSaDWnWQv1TvAodAfe+MZ+F3yhATTI1JcgjcBGJD
         iruPGyJY/kbF5l89E+8wBZfHo5wMjfKv2kFpYON6EqXIryf/sgirYQWuXm5zmcUoCWDg
         A2tGRArU9xejlQD8Ki+W9BnsxmjTKAk4rQP/xtut6vjlga3w/CV/ZqprUGPRTzL6aUsn
         zsvjx3YcQJH+taNp9NU/68z2GHcJG1MgQ3LigxOX3T6uAvTd0Xc0tqWK9D/BDA0VRkB9
         nB4UQ9GkJcUe8u9OitkCgB+BUDJbf8B6VDS5a1ym7z/Heh7xOYGbHpF8YNI/778oipSv
         2GvQ==
X-Gm-Message-State: AOAM5334jbSnBy/DSNxDmy7Vx+WzxzWo+gZcG/i52bwCRbtlvhD0NS6T
        fTzaWlFPIEFtxPf3X8GMu+RXEg==
X-Google-Smtp-Source: ABdhPJwm3994NuX8fPiBha2Dyqy0Qw+fl9dINAkPztgMhuF3pAfNdPTXSB1mkptDui+GSxVaRA6KCA==
X-Received: by 2002:ac8:f15:: with SMTP id e21mr2640299qtk.123.1597172431933;
        Tue, 11 Aug 2020 12:00:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t83sm17887917qke.133.2020.08.11.12.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 12:00:31 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: --init-extent-tree if extent tree is
 unreadable
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <20200728021224.148671-1-dxu@dxuuu.xyz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6cfaabf7-a97a-9167-3932-3c2413c1b553@toxicpanda.com>
Date:   Tue, 11 Aug 2020 15:00:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200728021224.148671-1-dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/27/20 10:12 PM, Daniel Xu wrote:
> This change can save the user an extra step of running `btrfs check
> --init-extent-tree ...` if the user was already trying to repair the
> filesystem.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
