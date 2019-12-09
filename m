Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223351179A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 23:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLIWtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 17:49:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36929 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLIWtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 17:49:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so6517023pjb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9mOOFCrDSsp9wW00HKYGXlpUOpwU84BQVF4h1AqWZ7g=;
        b=Ke7Ykk7vgW5eo3UgctY6m9SHjnPSi9JExovCG4Zzt7rwJjQjAwksbng0aEJGgKErWG
         oTqd4xVntwMtwHFQYwrH7koIc69al/uz8bsDvFgN83kAT0uBW+jSItss3yv32I56nJ9w
         YZGc2LPqohp3x4Aj9tNapl8IzKU13PrHICzw0FANQmMgfnENabVtbOv7XnZgxzNltRYG
         lrQoX95ciSH208bRS4+rCOs2xoadqaSVvSPIE1RMnro7fqISG2D4wbkm8uLYF2bPHTTD
         wqzE4OvrEoqi9/iqFiAZknDfacfIvZe8alYBjIhd+28aKwEUInz72BGqOtkR565AXuiJ
         JtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9mOOFCrDSsp9wW00HKYGXlpUOpwU84BQVF4h1AqWZ7g=;
        b=jSXnr557+RHU7RTfMSk9hjREn+DkZXSyIb2LSsXzIVwbauon99VEkgPYgV4tw1DERN
         WULVbU1kISSJHHyouVtwRTbBLM9Y9yY56hqkijCd2CfdbRSwvLafThch1wvAimnY8Tcl
         flu8bQUNy1EDNSdMopmZdntR0ub0V3ha9bremG4sdkkeV5vwazbZFvh6pZCWqvX7o+/x
         1JQsVLQtW66Lje7eoFrCnonDJXpuwuHDjNYcJWkEtmOPkIlfJCzK5hUxknW4u6mDXUay
         pQDDhYIH0lPtPPx7wWFTup/k/4xNHgsEsTBgIYzvt6QAOHE7ENA2+QVihFTu9vvr9vb5
         DCmw==
X-Gm-Message-State: APjAAAWNnl2tMqDBPgvh0OsgL1Pgv9ucLf2eYT655BojpNaT2SAuFD9d
        qQj8s8WZTzctJ4MxJvMCskfNIE6e
X-Google-Smtp-Source: APXvYqzSVPNkDy7GnR4DCTCUB22EnNrist/FZio9Dq9KxrqufuUaGvCMXZYqorYQMLhmeaeZaOFWIg==
X-Received: by 2002:a17:90a:3ae3:: with SMTP id b90mr1709790pjc.62.1575931739749;
        Mon, 09 Dec 2019 14:48:59 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id f13sm507110pfa.57.2019.12.09.14.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 14:48:59 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
To:     David Sterba <dsterba@suse.com>
References: <20191205112706.8125-1-anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <454f1d49-d093-4957-2025-19995373cdf9@oracle.com>
Date:   Tue, 10 Dec 2019 06:48:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/5/19 7:27 PM, Anand Jain wrote:
> Patch 1/4 is a cleanup patch.
> Patch 2/4 adds the kobject devinfo which is a preparatory to patch 4/4.
> Patch 3/4 was sent before, no functional changes, change log is updated.
> Patch 4/4 creates the attribute dev_state.
> 
> Anand Jain (4):
>    btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
>    btrfs: sysfs, add UUID/devinfo kobject
>    btrfs: sysfs, rename device_link add,remove functions
>    btrfs: sysfs, add devid/dev_state kobject and attribute

David,

  Is there a chance that partly/fully this could get into 5.5-rc3?
  1,3 are cleanups and 2,4 are feature add.

Thanks, Anand

>   fs/btrfs/dev-replace.c |   4 +-
>   fs/btrfs/sysfs.c       | 130 +++++++++++++++++++++++++++++++----------
>   fs/btrfs/sysfs.h       |   4 +-
>   fs/btrfs/volumes.c     |   8 +--
>   fs/btrfs/volumes.h     |   3 +
>   5 files changed, 111 insertions(+), 38 deletions(-)
> 

