Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4262B145CDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAVUHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:07:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34041 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUHJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:07:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id d10so1058045qke.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5jHFUuqjuk4+okTmI6Of3GV8fxdM+jHj1L8g2DTNk3U=;
        b=NFgP112WUqX9bzeUgTWaYOqMshPYfeACOCnYauluvN23/ksumiNVeVGhQo1M9hEUBK
         Eb7qIhKCF1fWLSMR4YsEeGRkKsuahqZfs2hreZaClx4u3Wp0rx7CoyZydeX9GCJwRwnl
         bFxYOm5j8nFJQ5oZFXmLNrgliBnz4OfxHWUdfcvobM7mC6wtiqszqAJfAWGBhG+YbjyP
         1KQEWUrMAs44+RaF+prnXuwsER4/avuuXKn5J0QG//N9j7Qi4/jwBZE+vIShECDxX+F6
         El6z3huKLsK6a5eM5B8mpT9AcRKM7NK3AhR6EvGEfKbZPg5GwHZVqV6UDoV6hGh9mu1v
         FZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5jHFUuqjuk4+okTmI6Of3GV8fxdM+jHj1L8g2DTNk3U=;
        b=O3hijY+bsY1HyuK5/EVICgm0vGf4BGLnzd9bGlFxhgunF2ELNrI0RWLpuQPn8POAz5
         GC5E+0RIWh7LTDkM9MESpw/3ygRbsPKZopqrBaBPxMRBQ2ab72Zzdgen4Z3n0acFosJO
         rzfDlvN/cHzqMW0MxdXPwg9KGGT6khwh2113/mZ/tLAI8h4yraH1xsZFIdrqNhEZhlhD
         SaaEtQbyhO4scmPjX8n9HrEoS0Gtc5Ct7kj2kj6y4g0VOsPBb8Or2PkPm27OrZM6q1pY
         oCP5sX1gFlTZWj38x0zbd1JLtBN2EBG05xa+/U/3ne+YDWhetHFVDU/P1SjNCs2GLRz8
         SkAg==
X-Gm-Message-State: APjAAAWuqj837qVPibfRvtxrBcApde4LuYpT+fBalu3ZsVgCamEDiaqU
        Jngx5F3igjOlhI4n5uNbzvU0X2uGZ9bhGA==
X-Google-Smtp-Source: APXvYqyCFHjXEEhX7B+DNf8wtR6pAr4F78HnPXwocbUJB0eJIHK/RsJXhbbUZnM6sVvgAqz+kFuByg==
X-Received: by 2002:a37:b842:: with SMTP id i63mr12112718qkf.451.1579723627546;
        Wed, 22 Jan 2020 12:07:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id c207sm3014763qkg.36.2020.01.22.12.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:07:06 -0800 (PST)
Subject: Re: [PATCH 07/11] btrfs: Make pin_down_extent take btrfs_trans_handle
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-8-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6bc8e72b-4697-c476-4904-1a6c32f487d9@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:07:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-8-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> All callers have a reference to a transaction handle so pass it to
> pin_down_extent. This is the final step before switching pinned extent
> tracking to a per-transaction basis.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
