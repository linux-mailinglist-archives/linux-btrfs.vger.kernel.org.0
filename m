Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEC145D10
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAVUXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:23:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42000 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:23:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so624017qtq.9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/arTa3krJhTfmJlyqVGNTQkFUrwlPiK9/xBaOn72dc=;
        b=H8eli337d1qGhjE/Y2dPhNQoOsARXgR29WD4I9g8S4FZbKqbBQ5lwIKP/LQaTalgw8
         CgG93ZASYHjuX/PReEZlGpViYhlzPZQRZ/dWkfthTmhrkWRUd9w14Y147nLE7dy/q/g4
         LPWoAANb1Ohae0NkRIFa4F6NIRgZYpc2Dlb/xWCBmBW1XkFOO7Z1oz/lArBlm9UhMWVC
         AKXCZriJ2J+0wxYi5GjJ/UNN/wwIE+b2oEEMFoQ5BrAZpWGHVtCgY3UAfz8R9jCBUIw4
         rzr3hk79asQeGrULC9Gv5rGvmvUFOEucs8jj6EOAmsyJDgVT1MQ/6RnERtTvzJ+T6Z2A
         JYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/arTa3krJhTfmJlyqVGNTQkFUrwlPiK9/xBaOn72dc=;
        b=OwK2kUAWho0Svfu3J1gFjcXYC9WxiSVffTJAkU8rdDTUjgNje6h62QhzfjPIPUZeMq
         1EhetXn1PnoBXEXf5bISnHAUQqhbAAi73aifbWG/s5YTIQBMah+VdyalI2SKfuXdhq+t
         JJyARRu6O/bIvHEUcsyHXlE+9S+FExB8HkZEJmsBNFS6wyVO1szBcqk0fzXC+DaAqJ4t
         Elu/CflfdEEEfm9oFlgqZCi1pw/AeHhjz3lQuwsiidFMuQc/QczXTDPxAAPtEwNgDxYo
         4NpWGOtCtZHm13VEsNLlsSSZ71lTmwF7IAFhPnHyYZ91Q6PuhDimcpJAIFdPz+W+/cnQ
         V2Eg==
X-Gm-Message-State: APjAAAWYoRwz8mDGv8UvP2vHlZoieDdK+rGNPv1EwxiolnoBiQtqOsMU
        UIxdnxba1BzZ0SyxPzhgxgJgQp7/NpaJoQ==
X-Google-Smtp-Source: APXvYqzMqMOewKwRgj1hVbAxeFlLBLnMm80kTE5RB8R64i3QOuXONjsjOiYlEFjGxkye7QZzwKI4qA==
X-Received: by 2002:ac8:2bb9:: with SMTP id m54mr12699463qtm.150.1579724619221;
        Wed, 22 Jan 2020 12:23:39 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id 184sm19019202qke.73.2020.01.22.12.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:23:38 -0800 (PST)
Subject: Re: [PATCH] fstests: remove test btrfs/130 from the dangerous group
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200122122233.1931-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5631fa5a-ebde-c090-92be-38a8e093d7c7@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:23:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122122233.1931-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/20 7:22 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> As of the linux kernel commit fd0ddbe2509568 ("Btrfs: send, skip
> backreference walking for extents with many references"), the test is no
> longer dangerous and it's fast (takes 1 to 2 seconds on a modest vm with
> a debug kernel). Therefore remove it from the dangerous group and add it
> to the auto and quick groups as well.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
