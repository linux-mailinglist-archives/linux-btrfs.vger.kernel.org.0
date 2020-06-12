Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42311F7D26
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLStp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLStp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 14:49:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C2C03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:49:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q8so9942841qkm.12
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e8iXmURzqdSSml+OGphvO9SZpBQZwTsKbBGzHT3Wy+E=;
        b=v6FCbXCdrFCdQzAqBGp+XBM/pVQYOH9LipwzhxaBwItU4wtpczhtOxXXCwcwi/+jYw
         ungfdJVe+edZwhyGy9qXdcr1dx26CdpEQTqHQsAwbJZ6MnGaB7BxZJUlJdYCnZvv7trx
         9HkW7S33SxAoLQNhi5DFqCTsDMjougQr3hBHddm8wCi6w1461oLfwBcR6WVDmDEtkYzG
         os9S0WrAwobtc29zwboZJ6hrWrxdYW86udJ7IFxBCuaE9hMSL8gNY2nIXZsZlB67c3Kv
         dn+SGBPNqHy80kF2QR3sKCOpSvr3FUGQ2EUWXSowY7igeOljdxyiC42jHyeR2fu1/EjC
         e2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8iXmURzqdSSml+OGphvO9SZpBQZwTsKbBGzHT3Wy+E=;
        b=lwK9AgqBQdjI5OKN3CZ9E4vwL0MYZ89FNHmT1DImdI6neivYHDNOfN4RLzGUSnZVLY
         UQyJzi9uAwr3y/HxmEVayIHKUNvWqxhCsHUQlziG3rpmsnwHIHJShnAbDuTDnqiK1+k9
         7F+mRMCHKmSKSynUcFpj0OnGF8uZ/HEC55gjPCgqrLejLaV+kWQsUbOqPOEnuM1Fzbkv
         nkZBpiePelaj+4OnlxpJJv+WoiWAB/vG9d8bcjRrES+NEK8Lk/BEjt4L/2vZfh3z1oEe
         F2PWqQGIc3nVhmdIU0h6sUl06d+YeaM0Z4hGoqufIrMkg/mBhXgqmjiAql9oQMAuhXUb
         CKfQ==
X-Gm-Message-State: AOAM531Z5pygy0y99A6rrLrN79nCIzBW2BoqWoQNSJwhjJnEb2Ew4OPp
        N2P2cC49Sm3ooVF78zMTuiU8B9067w1BPQ==
X-Google-Smtp-Source: ABdhPJw3IWTLrxOpdvElpbQb0XB1k14AR0TGDDXZaBxmPFA2CIEvzI7ATqMkiu/imNQ2SJ1DDCdItw==
X-Received: by 2002:a37:674d:: with SMTP id b74mr4551285qkc.108.1591987783858;
        Fri, 12 Jun 2020 11:49:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::11c4? ([2620:10d:c091:480::1:487c])
        by smtp.gmail.com with ESMTPSA id p63sm5134315qkf.50.2020.06.12.11.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 11:49:43 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] btrfs: file: reserve qgroup space after the hole
 punch range locked
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f85d51eb-e557-4372-ee10-8829325aa21a@toxicpanda.com>
Date:   Fri, 12 Jun 2020 14:49:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610010444.13583-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/20 9:04 PM, Qu Wenruo wrote:
> The incoming qgroup reserved space timing will move the data reserve to
> ordered extent completely.
> 
> However in btrfs_punch_hole_lock_range() will call
> btrfs_invalidate_page(), which will clear QGROUP_RESERVED bit for the
> range.
> 
> In current stage it's OK, but if we're making ordered extents to handle
> the reserved space, then btrfs_punch_hole_lock_range() can clear the
> QGROUP_RESERVED bit before we submit ordered extent, leading to qgroup
> reserved space leakage.
> 
> So here change the timing to make reserve data space after
> btrfs_punch_hole_lock_range().
> The new timing is fine for either current code or the new code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
