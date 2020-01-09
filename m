Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B943135B9C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgAIOqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 09:46:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46417 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgAIOp7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 09:45:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id r14so6101159qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SFZqJ8Nn9uuDwjWLH3Xlj//0xwT/Gb1qpz5jwHt+NyE=;
        b=fIwoNz2Lj5q+kSC8fLlg+YU1ac8Bq0mrVLP3eJsMqWd2aF45IAIQt7AYgJ4/RCWMhP
         Q5/DpRdDP15mk4Yv0ajGtZVogBpFMCJGVUw7VdJsKs5U6qAEESDzskzO10Y+EV7cJ2Et
         1nu4VOKn7ewTFvVaMAhd9Pu3CSKUUQ5M6L0RAXlfB3bhVl8WhtW1Mtme4+GHUk0bG6F1
         QSM1/H+Ub+C2zl7yq951b1g56Z+WXUgpMSlS2vL6hqOYDHLYK8N/nbCCo3H1cE1rHsX+
         knGieMwni9XLQpcDq7i+ufZZhdHUhaGSvjOQVBenhT/WkOVc17Khe0aOvscJSpRCp4PM
         iuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SFZqJ8Nn9uuDwjWLH3Xlj//0xwT/Gb1qpz5jwHt+NyE=;
        b=BQZUcMlE0qr3C4b06gWlowNwJVdD+SmhYZ+9n9gulFLXMRqWbQs3zhw5L1O0zZ860y
         BFCp6pS6kV2jGveO8xdEBlWblMCCD/pzmJchtLHmFEGdC3N0mnXoGkaQNIGCYE76Lys8
         jJtLHr23fZFlJxgUsPRrwuO/vUfflrhUrzhyNO+imPRmOte01E5Hw1vtOYbeBDWdjxM/
         W7sOOGTANSEvH0X4xaxTGE9Xya0bKZ3zeKiHUt+aDP7M65ZJzo6qWlqLTK45fmN2kNOP
         fwlBWjGaYTJZpBkUjILZSQRdskRWehFU9JA1G5+L5COdqo4G5VvVKQCcyM9S3a7gu1b+
         OL4w==
X-Gm-Message-State: APjAAAWmX81KvcPAgphHau6wTE+2YWOg4Z65nyRM+M+d7ENSvoKeqzUB
        scYV1YwQm7z5UfqShza2dhmY9Z+5Mgy80A==
X-Google-Smtp-Source: APXvYqxpXZRxbVJw/Hc8MyIQ2g1lAfQoBdlohy3vWvRXZMaMQjh7vZJc/55xiVvr/vyLsabTPOJQ7w==
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr9876824qkj.36.1578581158362;
        Thu, 09 Jan 2020 06:45:58 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k4sm3330339qtj.74.2020.01.09.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 06:45:57 -0800 (PST)
Subject: Re: [PATCH v5 4/4] btrfs: statfs: Use pre-calculated per-profile
 available space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200109071634.32384-1-wqu@suse.com>
 <20200109071634.32384-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7704892f-311e-2db1-76f9-a43e1931315c@toxicpanda.com>
Date:   Thu, 9 Jan 2020 09:45:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109071634.32384-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 2:16 AM, Qu Wenruo wrote:
> Although btrfs_calc_avail_data_space() is trying to do an estimation
> on how many data chunks it can allocate, the estimation is far from
> perfect:
> 
> - Metadata over-commit is not considered at all
> - Chunk allocation doesn't take RAID5/6 into consideration
> 
> This patch will change btrfs_calc_avail_data_space() to use
> pre-calculated per-profile available space.
> 
> This provides the following benefits:
> - Accurate unallocated data space estimation, including RAID5/6
>    It's as accurate as chunk allocator, and can handle RAID5/6.
> 
> Although it still can't handle metadata over-commit that accurately, we
> still have fallback method for over-commit, by using factor based
> estimation.
> 
> The good news is, over-commit can only happen when we have enough
> unallocated space, so even we may not report byte accurate result when
> the fs is empty, the result will get more and more accurate when
> unallocated space is reducing.
> 
> So the metadata over-commit shouldn't cause too many problem.
> 
> Since we're keeping the old lock-free design, statfs should not experience
> any extra delay.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
