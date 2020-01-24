Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A513914866D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbgAXNzj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 08:55:39 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37336 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbgAXNzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 08:55:39 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so1539458qtk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 05:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbuQC0x+Ebr4oDWOtwaDYEWK9YrkOelQsBbA+umI/zo=;
        b=jVwGumTHcAVmlIY131KKM3Gw1VFNbgync3f5Fs4p34RmxeuIMn0dDPXxMbCA75r8kJ
         B57Omvy7qe5oC5iDbk8fZXLOzdoCmo5LNf5nHoqw3xE73oNrChmMzr3rrm0s2DnHOdxb
         N+vfIrctFzfpQf0t2oTehhmysRV14C+iUNyCA8WWFHMFOZTGzvIdDekaQuu8VZVNmHc1
         tneE2/syk6kkjETJU7W6/JO+WL8UtWPOxqDn+aQFtGzyYYlRDxpYVW13Gsfthj4oc7qe
         ASncGfjA6Sw1HIN/bWWjU9i0j5fTBSVm7x0d5KauFQ7JQknkc2Ni5h15n8GAR4p+vzyE
         lv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbuQC0x+Ebr4oDWOtwaDYEWK9YrkOelQsBbA+umI/zo=;
        b=ZRr1OoClAIEQCoBOVRR+4AbgPt07FFSpH4G/pRmOHAgrsOneFo8wxITZhc4U4ksNGJ
         0ArOxpSi0ncMgEVMcHH0cqaTmkCggLQ1BtSg/e16Eev9EUJK8pv617fM8S3pirvsTYNU
         Ah+HGlkPmiBXhCLEr7D7bcx2WWt+w9zUYEmm66auXru9O40Gn3lXB0Ntn08jm2hyAa2a
         Ku24YUDunGW32G+IrXUYdzeh99+RyfaTGuFO69OAsF84WNsR/4/FtWS7pPXgHkrYwvL8
         mSKnv53MAqtcj8AiiP6rRTbfd2P3GqWKL+Noq2S/51ONtdGKTU8VVkW2MGL+S6iM6XL2
         0Lyg==
X-Gm-Message-State: APjAAAU+7zY1DVfz2udNexN3Lv3SMfXEiqksFALpE+uJzjIxXPG4RqMv
        ZD+xMdIbVsJsVLa4xLO/E2P1BQ==
X-Google-Smtp-Source: APXvYqzyNCtjydKLwx69vNvU6PSamyU8mCxWzrh8dhp3WKVA5eRZyPX9qbdDTLiKOwMRFnnvmw1Svg==
X-Received: by 2002:ac8:3886:: with SMTP id f6mr2183114qtc.160.1579874138363;
        Fri, 24 Jan 2020 05:55:38 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::68b4])
        by smtp.gmail.com with ESMTPSA id k22sm3091117qkg.80.2020.01.24.05.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 05:55:37 -0800 (PST)
Subject: Re: [PATCH] btrfs: add test for incremental send for file with shared
 extents
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200124115213.4133-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3863949a-5d64-9919-877d-0ee02be1b02c@toxicpanda.com>
Date:   Fri, 24 Jan 2020 08:55:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124115213.4133-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/24/20 6:52 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation works correctly when a file has
> shared extents with itself in the send snapshot, with a hole between them,
> and the file size has increased in the send snapshot.
> 
> This currently fails in 5.5-rc kernels (regression) but is fixed by a
> patch that has the following subject:
> 
>    Btrfs: send, fix emission of invalid clone operations within the same file
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
