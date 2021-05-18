Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0298D38812D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhERURV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhERURU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 16:17:20 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660AC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RTZ6eDAfSBhyfd4veNUxm3DqCkkF0sd+ADxwnOE3bpk=; b=pzvO/ZM1YQGGpde4OZx2e0oOno
        YVU+XNNuGVPQmncXmQtSaTNHyY1ftAabCqVn8z+KZJZt5TrvfaDnM01zdaSJSq4A1TFylqlK7SnJM
        AgqYN4AlSQsimOOyojDztdo9FYEsn25PHpTSgkltyvyR0fBiFnz1CAEIUXgGvKouJEz7nM7xsoIX0
        SiHEGXbIq+KcHMNhFlBp3l2LvhiQPlYGuH9R02vYjNLHY/vdR0BQ0OGwFiObwCeSTnq1yFz4i8UEk
        vrIw/aCgacRjsiWEcT5osZjlUid6GMO5ya0b2Q1uBYvVjGYOnODxTyL3dOu1AyLaSxeMCwDkCRX8M
        vM51viDQ==;
Received: from [2a01:79d:3e82:abf8:218:f3ff:fe5e:5fc8] (port=39634)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1lj68E-0003lY-Jq; Tue, 18 May 2021 22:15:58 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210518144935.15835-1-dsterba@suse.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <45403ea9-221c-c7eb-faa8-50c9da8e38e9@dirtcellar.net>
Date:   Tue, 18 May 2021 22:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.6
MIME-Version: 1.0
In-Reply-To: <20210518144935.15835-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba wrote:
> Add sysfs interface to limit io during scrub. We relied on the ionice
> interface to do that, eg. the idle class let the system usable while
> scrub was running. This has changed when mq-deadline got widespread and
> did not implement the scheduling classes. That was a CFQ thing that got
> deleted. We've got numerous complaints from users about degraded
> performance.
> 
> Currently only BFQ supports that but it's not a common scheduler and we
> can't ask everybody to switch to it.
> 
> Alternatively the cgroup io limiting can be used but that also a
> non-trivial setup (v2 required, the controller must be enabled on the
> system). This can still be used if desired.
> 
> Other ideas that have been explored: piggy-back on ionice (that is set
> per-process and is accessible) and interpret the class and classdata as
> bandwidth limits, but this does not have enough flexibility as there are
> only 8 allowed and we'd have to map fixed limits to each value. Also
> adjusting the value would need to lookup the process that currently runs
> scrub on the given device, and the value is not sticky so would have to
> be adjusted each time scrub runs.
> 
> Running out of options, sysfs does not look that bad:
> 
> - it's accessible from scripts, or udev rules
> - the name is similar to what MD-RAID has
>    (/proc/sys/dev/raid/speed_limit_max or /sys/block/mdX/md/sync_speed_max)
> - the value is sticky at least for filesystem mount time
> - adjusting the value has immediate effect
> - sysfs is available in constrained environments (eg. system rescue)
> - the limit also applies to device replace
> 
> Sysfs:
> 
> - raw value is in bytes
> - values written to the file accept suffixes like K, M
> - file is in the per-device directory /sys/fs/btrfs/FSID/devinfo/DEVID/scrub_speed_max
> - 0 means use default priority of IO
> 

Being just the average user I ponder if this feature is an absolute 
hard-limit or not? E.g. would this limit be applied all the time even if 
the filesystem is idle? or is it dynamic in the sense that scrub can run 
a full speed if the filesystem is (reasonably) idle.

If this is or could somehow be dynamic would it be possible to set the 
value to something like for example 30M:15M which may be interpreted as 
30MiB/s when not idle and 15MiB/s when not idle.

I myself would actually much prefer if it was possible to set a reserved 
bandwidth for all non-scrub related stuff. for example maybe up to max 
75% of the bandwidth always reserved for non-scrub related read/writes.
This would allow the scrub to run at full speed if no other I/O is is 
taking place in which case the scrub would be limited to 25%.
