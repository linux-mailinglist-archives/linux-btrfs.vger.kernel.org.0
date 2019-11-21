Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C618F105A6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 20:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUThO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 14:37:14 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54450 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUThN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 14:37:13 -0500
Received: by mail-wm1-f53.google.com with SMTP id x26so4762654wmk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+xdEEzkA9LwhBCSr8qrT7T5IOqVgRis4aRBgs4yd0y0=;
        b=lc2/uVpQQUA5g8Dk6ZukFwSZkmmsCjTCWT+Awn8PBa9w4KeXdTtHe3zGlEhBRooSXq
         GC4Vj56Qr0WuBQTcZELL9XuHkaK5P9GpGj77pOIjLsholxcw+mgZthOrAICw8DjVKKRu
         mIiwHJSC8wTnIDUKrsnqvRi+GBVjvok8epw4zyrvFvDeczEajwLXCBXk/Kn4cktvrm0y
         eZFco4ym08XKb2fWsWMWUqlB/v/5GZu12aL1G+W2zWMuEoOHEHBBZA0zYr9qGxnf+/sj
         oN7hCTmmJo2uHKPNr3kWJC67v4XhlNVTi/ZqBwFwUJJAJcmRYtn08jMLco+slgu2LWtg
         83GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xdEEzkA9LwhBCSr8qrT7T5IOqVgRis4aRBgs4yd0y0=;
        b=F+Jc/XCdSCjFle4hpvbw3hBcjBfMDXMU7nY/uoVeYXn+fv+7aC+3v1oji3A58sGi/H
         9smYCl8tvuaU994zDvKBhX5KHOKx3CghJoeAlzzb7bTQXuj5Gq8eUg2e3vkngQ6F4DxQ
         9xhLTqzaLNC4YaNfecI8sDIRMNMI2A2DvLoUTtv9k+bq4zJllFvSHLm7nJpr/MCWgMOv
         gpSdIIWNLN6Pi2vjoH91RoC1ntTp5IA/CPMIfPYXLxcV7mU6pRpO1tp/N4h0LvoHC6u7
         kT077mW6+MSLPy84s89OyU8L6jqmDsAx7wYaEsjqp11iPdKjd3NL14oxuJbmqC4HtZT8
         LMpw==
X-Gm-Message-State: APjAAAWJGjgLjLd7yfVuRzDlSaT63D6KldpdeC5yUhJYVlY5tZ5f3QUI
        VKfQyRxYN75jRJ4ZT6YnAXcZerhw
X-Google-Smtp-Source: APXvYqy6vkXOoCETNXRUEe7fegZfiv8rjHMUzL1TzViOyjFLOFm+SPVat4ng7KDyGR7XSyoKFKtGRQ==
X-Received: by 2002:a1c:9917:: with SMTP id b23mr12178366wme.42.1574365030118;
        Thu, 21 Nov 2019 11:37:10 -0800 (PST)
Received: from ?IPv6:2a02:6d40:2ba9:e00:8d82:4b05:4e66:ffa9? ([2a02:6d40:2ba9:e00:8d82:4b05:4e66:ffa9])
        by smtp.googlemail.com with ESMTPSA id v184sm745022wme.31.2019.11.21.11.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 11:37:09 -0800 (PST)
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com>
 <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
Date:   Thu, 21 Nov 2019 20:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 21.11.19 um 17:44 schrieb Christian Pernegger:
> No to deduplication, maybe to quotas. It's possible that Timeshift
> enables them, how can I check?

You can test with:
 $ btrfs qgroup show /
 ERROR: can't list qgroups: quotas not enabled
but none of the tools you are using should activate qgroups I think
(at least btrbk does not). 

> Just had another episode:
> 2019-11-21T17:17:01+0100 startup v0.26.0 - - - # btrbk command line
> client, version 0.26.0
> 2019-11-21T17:17:01+0100 snapshot starting
> /mnt/timeshift/backup/btrbk-snapshots/@.20191121T171701+0100
> /mnt/timeshift/backup/@ - -
> 2019-11-21T17:17:01+0100 snapshot success
> /mnt/timeshift/backup/btrbk-snapshots/@.20191121T171701+0100
> /mnt/timeshift/backup/@ - -
> 2019-11-21T17:17:01+0100 snapshot starting
> /mnt/timeshift/backup/btrbk-snapshots/@home.20191121T171701+0100
> /mnt/timeshift/backup/@home - -
> 2019-11-21T17:17:01+0100 snapshot success
> /mnt/timeshift/backup/btrbk-snapshots/@home.20191121T171701+0100
> /mnt/timeshift/backup/@home - -
> 2019-11-21T17:17:01+0100 delete_snapshot starting
> /mnt/timeshift/backup/btrbk-snapshots/@.20191119T161701+0100 - - -
> 2019-11-21T17:17:01+0100 delete_snapshot success
> /mnt/timeshift/backup/btrbk-snapshots/@.20191119T161701+0100 - - -
> 2019-11-21T17:17:01+0100 delete_snapshot starting
> /mnt/timeshift/backup/btrbk-snapshots/@home.20191119T161701+0100 - - -
> 2019-11-21T17:17:01+0100 delete_snapshot success
> /mnt/timeshift/backup/btrbk-snapshots/@home.20191119T161701+0100 - - -
> 2019-11-21T17:17:01+0100 delete_snapshot starting
> /mnt/timeshift/backup/btrbk-snapshots/@home-chris-.steam.20191119T161701+0100
> - - -
> 2019-11-21T17:17:01+0100 delete_snapshot success
> /mnt/timeshift/backup/btrbk-snapshots/@home-chris-.steam.20191119T161701+0100
> - - -
> 2019-11-21T17:17:01+0100 finished success - - - -
> 
> I had a tail on the log, these came out in one go, no larger pauses.
> At first I thought, just my luck, here I am lying in wait and of
> course everything works, then the mini-freeze happened. CPU usage in
> one core spiked during the freeze, but I couldn't switch tabs from the
> graphs to the process list in gnome-system-monitor. Top it is, next
> time.

This is an interesting observation. I believe this means it is happening when the snapshot deletes are actually going to the storage,
which usually happens only _after_ btrbk is finished (in case you catch it with top, a kernel thread "btrfs-cleaner" should be doing this job). 
Another interesting test could be to adjust btrbk configuration to:
btrfs_commit_delete = each
which will ensure the delete_snapshot operations are flushed to disk one by one, so the freeze should then correlate to the log
(and might be converted from one longer freeze to multiple, contiguous smaller freezes). 

Sadly, I have no idea on why this would freeze for you (well, it's the only actual I/O-heavy part when you don't do the transfers at this point in time). 
But maybe Qu will have a good idea. 

Cheers,
	Oliver
