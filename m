Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA125312C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgHZOYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHZOXb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:23:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38BC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:23:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so751205qvo.13
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jgd/R4yKozWgWXDxAK2kPIWdPu+bUBLOkYug4q9pCkc=;
        b=tGCofcEdM5ccMO762iY2hJ6dg8hm8ZvUzWLthmHwXZGG1Dz2j1DJ3bjCbZxm/w87fs
         TByFrfhC6WQkj1U5j5ZI9YJ0DlEkLnK2g+iPzeBb70tFB1zWWwL+fSYvxZ26Mc83TF47
         CQbYH1YizZl3DsVSPraSebYfO0irnPff89pBKwsYoJfAn8vhjWzuRRuCwm/WCBL7SERV
         p42RrLLhYcvMtUoR8jXz/MKNPMcHy7/On1ybouRxVeePAsSwLW6HbtyLgqDnFup4kzRQ
         ZBmqi8YSOTNgykCSi9twDpEgGaW6BihRtnXv6Z9uEZu9BQyv3Weq82whCCBxlO5ShWNI
         fzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jgd/R4yKozWgWXDxAK2kPIWdPu+bUBLOkYug4q9pCkc=;
        b=h/YNqvvwW92UCAuyGQ66ge2nsYbury10ZN/tASmq/0TU6xxsgklEztnKX4c/TawvsA
         aT9+dYGETbSOPOeGtt9MJvripjuN5EzcTxksr2LePNqpjURYeBLywMKlwlkfcFq6HARt
         MFdK1y5LoGlqCV2jmdqzfdbKFbcYONK8OULtrg99FCqFHYJeEqlCQwolUjQey9C+7rcZ
         2AozGtYMCiF/gWTY2BdkSCF1/jpw0wjtJR9gdGtOWexVD9DgW7lZYkDwjPxVhEoPN2DJ
         2uF0CFjFD8356ShLcyQbifwi9WaUTjlGNL/d6GcoZbaZiqUcG6hAMeHEWx8WWBzN//+C
         FYKA==
X-Gm-Message-State: AOAM530YqJ5Z2yto8fniJL1HcF8dj9nNkxXR8RqCxPOLc4J58kdvsO3Y
        srddNCOE5GM2scZRCgFRdSlq2Q==
X-Google-Smtp-Source: ABdhPJxM6fm3nZKsemv6eNa2Iic7G0FtwwJ4mjxAiJMTS/N8fTgttHBOHkK4kW9SSAscmnvVUCfFIg==
X-Received: by 2002:a05:6214:13b0:: with SMTP id h16mr14028984qvz.207.1598451809932;
        Wed, 26 Aug 2020 07:23:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id q126sm1709780qkb.75.2020.08.26.07.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:23:29 -0700 (PDT)
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
To:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200804175516.2511704-1-boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c2c5399a-dd71-4285-2f09-adea1e1e6fa7@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:23:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804175516.2511704-1-boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/4/20 1:55 PM, Boris Burkov wrote:
> Currently, btrfs_ioctl_subvol_setflags forces a btrfs_commit_transaction
> while holding subvol_sem. As a result, we have seen workloads where
> calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
> legitimately slow commit. This gets even worse if the workload tries to
> set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
> 
> Change the commit to a btrfs_end_transaction so that the ioctl can
> return in a timely fashion and piggy back on a later commit.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I think we follow up with a btrfs-progs patch to make syncing an option with 
setflags (or hell do it by default and make the option to not sync).  Having the 
commit here was arbitrary and not needed.  Thanks,

Josef
