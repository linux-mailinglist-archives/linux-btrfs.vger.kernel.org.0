Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34913DF94
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 17:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgAPQFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 11:05:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34730 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAPQFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 11:05:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so19278029qtz.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gc3py9UBWiNK/cKXsjedMrUzYeD4Eg0Xm+IR66/FEkA=;
        b=D/rT6eML6+9pi7wjybuOzWfsuwBxocZnoKDBjAqLnWLwqSOHOZA6odhZod60152z3/
         b9+kypm9Fly6dfTQ8NS2hiRlpo8NIh+e/0ubTPM1vTYZ9DptgsWahk18MRt987tDkNo6
         OF1NkqUwk9yUyUo50y/TzeVlPHUNJC/NScdHiUrbmOFHw42Xh+Ot/Ny5tYqwBXn6gALE
         zbs8gnPp6Q3aKFDDUY5LVR1SaN/ktWXfZH4r0WmkcluzHbgD4Ci/eOqLR7p+XEEzh6aT
         i65kDnXkA0FPPb47B1z6MZgjRaffYkkNUbnS18cPGX1H+7C93+ocwteTZgUEuKp639Bg
         VY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gc3py9UBWiNK/cKXsjedMrUzYeD4Eg0Xm+IR66/FEkA=;
        b=XUw7S4qfjEZBseYjxNpEffj4KohrXKnjpiqLD9qeLsBTe5m8iqQOa1TuaxVwBg6bul
         2dj/B09DGdsYNFRVF/ZXjSr98dIURhRIodahXZKLyJJvbzEOgiB42nIJZ6vPJW7QbMwn
         EVjr9V2ZlVOHJKERb8SXvrfQUMvdM7iC59nXafNPrCjLPS0IcnnW6BLuDfmcA0xBKYpr
         YLJ1It9fPrcp8t/9kSzkgGBc9/HJ+HeDH85cb/zuPKNr10GwSUk2VqV2yX5xReNMvszE
         /U+edtVb1LrGJ8rIudHWQRUbKi5GDZoR2ySOk0nOQpavyXNtYEL0sRHQAkr3BFMbzs3m
         epgw==
X-Gm-Message-State: APjAAAWM9fMBur/N3LXAR7G0YlMYqc79AouvpU+6WxGYGAGe7iskEXmh
        uYQS+AQWqEComaH13dUyE2xk+1sb3mTsZg==
X-Google-Smtp-Source: APXvYqwmtdqn1U86Aqsdnjfmg46sFO7c4aexk+J9IbLXz260G7Va5uRNi0hM3XrvkUedl+zirX/WMw==
X-Received: by 2002:ac8:342c:: with SMTP id u41mr3148055qtb.86.1579190712445;
        Thu, 16 Jan 2020 08:05:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id q5sm10153726qkf.14.2020.01.16.08.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:05:11 -0800 (PST)
Subject: Re: [PATCH] generic/527: add additional test including a file with a
 hardlink
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200115132216.24041-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <785ebd3c-89cb-0079-782c-9fd1e07116fa@toxicpanda.com>
Date:   Thu, 16 Jan 2020 11:05:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115132216.24041-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/20 8:22 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add a similar test to the existing one but with a file that has a
> hardlink as well. This is motivated by a bug found in btrfs where
> a fsync on a file that has the old name of another file results
> in the logging code to hit an infinite loop. The patch that fixes
> the bug in btrfs has the following subject:
> 
>    "Btrfs: fix infinite loop during fsync after rename operations"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

What's our policy on adding a new variant to an existing test?  I thought we 
preferred to create a new test for these sort of things?  If not then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I have no strong opinions either way, I just know it's come up in the past.  Thanks,

Josef
