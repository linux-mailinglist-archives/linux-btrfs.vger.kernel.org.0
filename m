Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F80917C0F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCFOxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 09:53:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37153 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgCFOxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 09:53:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id l20so233603qtp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2020 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5dVCsBLlpcPciBlxV6XUOyQP4hX4NakGhhdj+WALw8=;
        b=cT08tfQp0bx4R2WHgyxvRZSmsjY5Z0A/WfezRe346NhEzsidUPH1t6A8D6Lh+99ZOo
         NW19usviJkMb0Bttew2c21doD9KtyHZ7/auO/gMrE0vL9G6ysttOFtpNTwmsZ3QYagvS
         u5kNTCbK8an5tlGC+T/EgOHylF2HFtKA/SxQOhZ563rfUKqG2YtjJtQtK9yUPCVzYnM/
         TD+vXjCaJlvt8Qanc/CIXBcngHjdFyG8Bd1k5k2INBlzEjGVqRDZQNZglNF11vdsumvf
         ZpZOXVz6BgoYtTGOVotvPuT7QhFXA4R/QtMdUibo7hOcCGaPr9B+DlJk1qW+U8Y75xzF
         ODBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5dVCsBLlpcPciBlxV6XUOyQP4hX4NakGhhdj+WALw8=;
        b=td2X42x02+CSDDmhDqUxZF89jnO3yO0sKiHttQa+AAf5P+bNdcYlko/2f7GOiPuquJ
         JlWP48V3Hw84hCtCnbQjL5mkxwjFKm3X9kS2bYHniWtRAQo0t6YLslShhcBUpUwuD2Kr
         OqEO3B0xyS0QPc8fmL+/euEz8ZErs3Nt1BoVx7xzOGTMm8K+JovfhGH0eZzjfU4cqBmF
         DWB8+R0J+huUevsrdY8ILVxjD7PCnz1emqavj92a83Vwcdth5KK5a+lVJ0640BzPJbYt
         vGfXjHKgE+thSgDJ2GyiZU+cQbhYYsdj1t7Guw6JPvA/tm5R/thy5hzfxbr3Nji1cn34
         /mDQ==
X-Gm-Message-State: ANhLgQ35Zhhc+sdaF2duKhih6HXejO5dct56gu5UECuBt6OFhqOs9S0j
        z6/lMryyorIHlOhAC9K6ExPWWQ==
X-Google-Smtp-Source: ADFU+vvuaJjW09CHPk3NAH0y9c7WE0URkuiFlewQVMz7Q7Z20qQP2Ihcy0wzwm0eU3j66jHiy/gXfg==
X-Received: by 2002:ac8:7955:: with SMTP id r21mr3175979qtt.289.1583506400930;
        Fri, 06 Mar 2020 06:53:20 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x44sm16744069qtc.88.2020.03.06.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:53:20 -0800 (PST)
Subject: Re: [PATCH] fsx: fix bug where zero range operations never use the
 keep size flag
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200306123517.16729-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56679ef6-4f41-63a8-9ab5-941b22143924@toxicpanda.com>
Date:   Fri, 6 Mar 2020 09:53:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306123517.16729-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/6/20 7:35 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are never using the FALLOC_FL_KEEP_SIZE flag for zero range operations
> even when we intend to use it. So fix it by setting that flag for the
> call to fallocate(2) if the 'keep_size' parameter is true.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
