Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE96300729
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbhAVPZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbhAVPZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 10:25:19 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81145C061788
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 07:24:35 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n15so751791qkh.8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 07:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=62MG5B/ncqLFJMCPey88hP/CHS6L6DB9Q0Ol9XSuCU0=;
        b=eu+aytMOKIcLG7CoJGMlIIGYbOrANii2MOrd/d1r7QJJrjPiS8AS04T+mxYjh5ONo6
         oPtTXJ+nhSi34vv5ql9Wo9fbBE1pIS0wY3ciONxzkt5Q3pNGyPiD5Xjzd+c/osFYomDF
         ZdrncByxIGpz/7XID5uF4JMYMpbtTkKDkGGkWE46h/EBIy2TZQDK3rnDCa4HNcN5XVVb
         6/j5M+kPQwxUAR3cone+QA9q5HcVDynZ7Z08cTusxkLGXVg0c4hQRcDJ+8wvusTmgynu
         bli5EYVN4+/38/fB+RuuWZac8ftiDJKkVCXc5qatiiJ/rlmJo1KaB8qGT4SEj00lU0dm
         GIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62MG5B/ncqLFJMCPey88hP/CHS6L6DB9Q0Ol9XSuCU0=;
        b=YcpSgOS6gAgtJ67cyn8Axyeef19nTtJg3i0271b9PJ90iX1y/PyBUPm4lE3yecNQR6
         vMp4LkLQQIN7n9nNabNrDn6eQa68vyIcpP/b2evP8Fk1eX06h771XviHBo7+j5R14r3p
         e67yBr0n69XIJdKrsvGFWjpJxQVhlwiPQWO2Zt+mwzD0ef+qApRwliqLnUqnf0kGkHhg
         yGx7b3c6SLKmCvECpVrfHSc/EqitaTngF7zN1JayNwShpaoO5dJTGu2BER7AIsPk3erM
         oubOqm7Kz3PwgzYBFVZ2nS/3ooiVgtp+MdpyWk7e7n9LldBu+g8YnRH6whTohDiXM05k
         TNIw==
X-Gm-Message-State: AOAM530sB2IqFOVsGciKqNP/PBR7R+lOUq3Zm+U9wCXjhHb12DT3UdTv
        aD0P6gX6lsmczLtFj2fKFIis8g==
X-Google-Smtp-Source: ABdhPJy/9I03HGLRDPxWYhmODRNbrqIlmbhzU7iLkesDoviBLjKir9yrAu73CgWO7rgAbVaHgne8Jw==
X-Received: by 2002:a37:aec5:: with SMTP id x188mr5386628qke.144.1611329074636;
        Fri, 22 Jan 2021 07:24:34 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j23sm6023312qtr.79.2021.01.22.07.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:24:33 -0800 (PST)
Subject: Re: [PATCH v13 26/42] btrfs: save irq flags when looking up an
 ordered extent
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <8537c12ab50510bf029ff6c780a0ce2a850fa603.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8405f0b4-ccf0-5b0d-f71a-31857642b2ae@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:24:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8537c12ab50510bf029ff6c780a0ce2a850fa603.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> A following patch will add another caller of
> btrfs_lookup_ordered_extent() from a bio endio context.
> 
> btrfs_lookup_ordered_extent() uses spin_lock_irq() which unconditionally
> disables interrupts. Change this to spin_lock_irqsave() so interrupts
> aren't disabled and re-enabled unconditionally.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
