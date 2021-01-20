Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B552FD722
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbhATR3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 12:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390668AbhATOs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 09:48:59 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EEAC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:48:18 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id bd6so10969899qvb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dln3XFyhCbgFGgSEPM7B/sw0NahOV+TwefiSUNAv9hs=;
        b=r2PmHQnfCFZkI7xms0U64a3d3E3ee5qj35zUmpG7ZZebPFsofWENd+KNN4DykEHQeS
         SG4+7y/Ko8v8xzwcSm4fQkvkhlRP4E7R4r92ht7GY5PyD2MbO2mN8gck8kfi4XX8465d
         eLtrNu4PAC5PnwUvYJItFTFZYp0VzuGc/g3FGdJ0URX6fhnZUL8CfaMLgK35hbDvrf+E
         eHUVS8hU5mS7cBMQR5GZKiDz4qELcfXMho5qlmcy5+KxMx+1ThDY4ES+SNUwJ+lsjPdy
         5177xaWi+z6gvaboF4+eaS65WKyUJW7lJodMe58a9rraJoRz1XbgQLLP1pDx4D3PNV6J
         I5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dln3XFyhCbgFGgSEPM7B/sw0NahOV+TwefiSUNAv9hs=;
        b=cEG/VelBYhpLqQKh8RWd/RqNhY5e4D6OOFkkLBeAEmss/8CRuPLfHzUcIwe6URDEld
         KvXCLGs86muA7DO5WeW9egTlO15PpYJF65xJVco8CMBVlSAE1wXEbGe6EkOrDp+VCvhB
         8bEjWtlQqLOmL8Xi1Y5XcuLHgJIG6ZrFJE9qfpDmeQUOLJdocZttsmN8l/lvrKBSUozA
         PVDM1ECzHDXflFZgb9lcDsuZ2qQGNNWz5d6kCBW+ivO47S/mMSyG3Cx2j6qdQxYCpnUI
         yAp0iy5ZewW1idIEoH2lCGB9NmW2OLoWuonKss7//mfdHYNCtXuVvkTLwG3fRvV85/dB
         aXYw==
X-Gm-Message-State: AOAM532xaHEVE+t2S/semQiBbj00k8DDIf3ru1xdqPmVWpAwqfzgQknB
        gBTnTt6wUzYqLgjQ30EqwC4e9GV4pEvXabjSgxk=
X-Google-Smtp-Source: ABdhPJz2o5C6Z9UBl4j+OxOzFAOlmRKZuKbUv9xDgSISzY3t/PE32tMwxMKnNPsttvkBBMpGfQIbEg==
X-Received: by 2002:a0c:c211:: with SMTP id l17mr9739903qvh.53.1611154097154;
        Wed, 20 Jan 2021 06:48:17 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i65sm1466656qkf.105.2021.01.20.06.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:48:16 -0800 (PST)
Subject: Re: [PATCH v4 07/18] btrfs: attach private to dummy extent buffer
 pages
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <565f8da3-1fb7-d46f-b84c-19e4a784041f@toxicpanda.com>
Date:   Wed, 20 Jan 2021 09:48:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> Even for regular btrfs, there are locations where we allocate dummy
> extent buffers for temporary usage.
> 
> Like tree_mod_log_rewind() and get_old_root().
> 
> Those dummy extent buffers will be handled by the same eb accessors, and
> if they don't have page::private subpage eb accessors can fail.
> 
> To address such problems, make __alloc_dummy_extent_buffer() to attach
> page private for dummy extent buffers too.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

We already know these eb's are fake because they have UNMAPPED set, just adjust 
your subpage helpers to be no-op if UNMAPPED is set.  Thanks,

Josef
