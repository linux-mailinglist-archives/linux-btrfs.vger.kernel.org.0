Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A019F166079
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBTPIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:08:13 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46392 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgBTPIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:08:13 -0500
Received: by mail-qv1-f65.google.com with SMTP id y2so1999853qvu.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puw7OfTSiwVS9EqBzYUwccBf0DMnA/uq7YTgjAvSfpU=;
        b=QgIHfcExqZOKbg19F5brUn7+4gUUSc6yrDrxCAazrfEabNxvdQWJjVV5GnUfwJ5MGN
         tK2qKfRwr4lv5elhtDmb9AvXP9mupVaCxEO+aglaQ8TcFPeWJFPpJVPfzFkSCXRJg6ur
         EzJg9o9Any4pB/O1ewLE2B2C2HvOZHSKxcp1ymwslUqQuvM9l9fOM2c5IZIxyY9EttZK
         rkqjzCiTI3Y99Ph4ro/0LuKx/q6Wu8tvBizofkhaDv35DrTpXmQTOQQ8w60O4Zu3Fy+H
         OXeA607SpfjS8TLCkx7rpSbaPGux1hVO8VQ8QDG+CSv4yMFKvLa1x1dEzhV1QwZZ+1fh
         4nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puw7OfTSiwVS9EqBzYUwccBf0DMnA/uq7YTgjAvSfpU=;
        b=pK7HKO9/Nm+I1pqOcUTHaqmyFFNmiMAD2CJ/E0tg5bWTqS/ipwJr42MeQ71yly1i4y
         4um8BAsOrnLCmEOFsbAnPNV6Lxh2eHR5wa7sXr3T78qStNfiZLhtPiFLNt+NZjg4P/PG
         nJcY5vf07FD62TQox7/CNQIHwSytPB8ehz/n3ezdpIxc8mVQVxjYT8p4FEpmQm11TZcQ
         +dQW03PJiybopLZ+PV5QZkOBwt2nqRIhnGwVJRq2OUO8tO6ucZc2eu8syCwDeP67XCNb
         PHWPlYhHXDnBMqDkiP3xTrS1CI4UJQfT109eAXAswpELy6e7xiHf1hDGGem/lP0Ab0eO
         f37g==
X-Gm-Message-State: APjAAAWjOnX1QYC6IVlXgmVJHH8ZVgSYrr52dx2Yz4yzAMjxG3xt2LXL
        p1Hb6182G6KK3ujcUvkxsM/IkQ==
X-Google-Smtp-Source: APXvYqxMBWuLsFPuoYq91f/Uhzzpbr3BDFOLYhu8xVj81EsFCaQsJKmGW0E8ZNzhgf0wJaAhgjUmog==
X-Received: by 2002:a0c:b61c:: with SMTP id f28mr26361927qve.101.1582211290845;
        Thu, 20 Feb 2020 07:08:10 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c14sm1674818qkj.80.2020.02.20.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:08:09 -0800 (PST)
Subject: Re: [PATCH v5 2/3] btrfs: backref: Implement
 btrfs_backref_iter_next()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200218090129.134450-1-wqu@suse.com>
 <20200218090129.134450-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e4f1dfe9-a8c9-74d4-8c04-9c29b9dd8cd7@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:08:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218090129.134450-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/20 4:01 AM, Qu Wenruo wrote:
> This function will go next inline/keyed backref for
> btrfs_backref_iter infrastructure.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
