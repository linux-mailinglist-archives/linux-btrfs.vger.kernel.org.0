Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B460166081
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBTPJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:09:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36261 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgBTPJQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:09:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so3080579qto.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ts3TuJBaR4oSpJuBgqD/oHUUKI8A0EX1qKsoYTrfSG4=;
        b=BmjUZ76LPRhin4GcyihIc50bJ8pCpRxlwmIcWnPZc7zvxomhf7TRM+hvPeRoQOxSst
         Hvza6HO3KSu4yp/i3DI0MN1IeCAJaFZ0sEhyFR/OOT/HSJg4ZPAQ2QLawrALicjnd3qw
         ddPA2EIa1PTsKrjyuG71pig7gJ8wYw3+pdZEOXbtDWZxt1iTeSApKyhpnV6bdBhP8Ykz
         ze7SNxSfQnfSe3iiBqW6Zt53O/38f3BgttvuPUly5qd3LO1u5Bma+2jT2nT7nhmcX7SS
         RwDHf+jISf5JXF7gktmLRWy6FS0f7fQ01L/Vk/0ET+COsAjYfvUCIpPZiwToiLEhVhEO
         Tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ts3TuJBaR4oSpJuBgqD/oHUUKI8A0EX1qKsoYTrfSG4=;
        b=W1r/Jt5NtERjtgOWp+qTk+Is/Vd0V2hEq1VGE8MoZqSzcJuDVV/hZYCKFqWKutg1Wz
         O7SUGoOlvw6A8VCSa+7C9goxe4pdm6NTRcpeLebIPHXiDHu86+1Yt5F4aRglvH0dKw57
         n2oJ9Rv3xfAjI3OAhLw9Q+Cxwzvp/xFvBqy7dahPsNDW1xjeq8snE3zjwL+soq0YQnOJ
         wUv28+Ic2bP2+334P7nE9/AqzhrlnxQWG5lDd0yqHz5lXBy3nSQXCglGGU355CizZZU0
         /BzuIE+wpYpG2/rvUXCOcC21SvH0TQrt7fFNj8VWoaTWGyKslvhU7kS98shjqHvf5va8
         h3Mg==
X-Gm-Message-State: APjAAAXKXdZT51TGEsW1Ncfq8GQRNI8DpavEVvzNKBKX2qI7h9cO8wjm
        o77Bfkc0k2kGVv5yt8GQjQX5Lw==
X-Google-Smtp-Source: APXvYqxGnN8Mjpn8LyDwbbxskbGfVyvaBXrc2Pz4/JUVRj2B0IdhVSTxrm6fqEuoTFbefOzKafWowg==
X-Received: by 2002:ac8:1835:: with SMTP id q50mr25839220qtj.210.1582211355822;
        Thu, 20 Feb 2020 07:09:15 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a2sm1763819qka.75.2020.02.20.07.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:09:14 -0800 (PST)
Subject: Re: [PATCH v5 3/3] btrfs: relocation: Use btrfs_backref_iter
 infrastructure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200218090129.134450-1-wqu@suse.com>
 <20200218090129.134450-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9c480f4a-ab7b-afa6-3f81-5842e2874ca2@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:09:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218090129.134450-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/20 4:01 AM, Qu Wenruo wrote:
> In the core function of relocation, build_backref_tree, it needs to
> iterate all backref items of one tree block.
> 
> We don't really want to spend our code and reviewers' time to going
> through tons of supportive code just for the backref walk.
> 
> Use btrfs_backref_iter infrastructure to do the loop.
> 
> The backref items look would be much more easier to read:
> 
> 	ret = btrfs_backref_iter_start(iter, cur->bytenr);
> 	for (; ret == 0; ret = btrfs_backref_iter_next(iter)) {
> 		/* The really important work */
> 	}
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
