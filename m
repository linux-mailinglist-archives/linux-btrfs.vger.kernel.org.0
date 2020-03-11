Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B4182088
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgCKSQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 14:16:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42073 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbgCKSQu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 14:16:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so3022170qkg.9
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CjzuKJHWPneXXrfzWyekzmT3fCCMqKuYOSJQbq+NbEI=;
        b=gSOzMb64pk7yb2AXxuMwOITUuKJWEbCxOBRN5kp/wFsJjPUzermvSouzd7NFccW+8T
         amvIPpGpFqFNvgvO6tKOkdtY3BHQEsqBdW+wdsV67waa62fGHnQwvriWIFFuKmcWa+MM
         Qubg+fh+vjKQXp7fpyydgEtnXADH0fWs+Qt+9aRO03UxtfKRW1Fzw0/8Eypjhck/3eZ5
         1veog2iiFcujwamST2WOTwOGHUGPxUVeAJn8Ls0nCPZXrIV+XE9FsTH5mflIbCqWsVDS
         U8/ul557KPXC0DKTAJ6/HXbIczt4E9eTy5ZtgSXehZxMFpobPyBea+8AVtKQmc7UjiFD
         yexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjzuKJHWPneXXrfzWyekzmT3fCCMqKuYOSJQbq+NbEI=;
        b=QwqOa7HyG9c1qh2PsaINCtLhHkeRwv4unW6qBSlyYuAbzYmUhch+geMJ7nXcvlu7J8
         z8x/PTy6cQGlChtQN+AZxablPUjvt9zs6CVWqt4BM81+fQO97MhZ6QzNFtHZ5ucb2zr7
         taDQtAmIx/0sJDRwQF/36ZtCu9mmJn5KwimxKNNJYljESRetXWmIFWRE9yfVEE23BgQg
         L/XOnePJurggYFbmSOlUS+/pFn+REj5n9e+h6U7y9she24kS71T3q5wrTEm/45qzuWpP
         80WCaeVCnpLqAOsexw2LMZnspO9hokMKMEJ4XELuSl4veWVaK7WWGZsdTOYGQVKIIdlD
         CJvQ==
X-Gm-Message-State: ANhLgQ2iOLS18PIMZaFL+fYO+j1VUD0AtE+VmuJ0bv1rd+Xl6G4Q381X
        zAbrIJ7ln6FR0eFETgoej+LtOA==
X-Google-Smtp-Source: ADFU+vuU/q0ItLyxmwzFRYWYh51WDRFnffmkwDNfl9iTljsEn+5kIccSQX6VUEDHl2zAcx6VEVZvqA==
X-Received: by 2002:a37:9f58:: with SMTP id i85mr4110927qke.186.1583950609147;
        Wed, 11 Mar 2020 11:16:49 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w2sm25968977qto.73.2020.03.11.11.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:16:48 -0700 (PDT)
Subject: Re: [PATCH 14/15] btrfs: get rid of endio_repair_workers
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <222e3f12f3a9130ec95d0c52be44b497989f8370.1583789410.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <29bee7b0-1c28-5698-55b1-9c6572d0b2ad@toxicpanda.com>
Date:   Wed, 11 Mar 2020 14:16:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <222e3f12f3a9130ec95d0c52be44b497989f8370.1583789410.git.osandov@fb.com>
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
> This was originally added in commit 8b110e393c5a ("Btrfs: implement
> repair function when direct read fails") because the original bio waited
> for the repair bio to complete, so the repair I/O couldn't go through
> the same workqueue. As of the previous commit, this is no longer true,
> so this separate workqueue is unnecessary.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
