Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF502FF365
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 19:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbhAUInq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 03:43:46 -0500
Received: from corp-mailer.zoner.com ([217.198.120.77]:56606 "EHLO
        corp-mailer.zoner.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbhAUInA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 03:43:00 -0500
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 03:42:58 EST
Received: from [10.1.0.142] (gw-sady.zoner.com [217.198.112.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by corp-mailer.zoner.com (Postfix) with ESMTPSA id 100131F240;
        Thu, 21 Jan 2021 09:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoner.cz;
        s=zcdkim1-3eaw24144jam11p; t=1611217872;
        bh=LhdkzCe0B9giBQ+0UOUUTxKvsgbkx2KBIhveYfnlfBw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IEkqYjJ7Mk00+bug1BQOaAlUhEEwG2Bj0tq0gfV3Oe17Y+/b2vCsyTf1hY15P2kkt
         jSugnROXXuWPRYXjJLP81756rQH3+qcm1sXo46F1/Oun+wtd5eKoTwXldYRyVjii8n
         Rqow1MlCDOwgtodavDAg40BC5fqrshA0wX7ghkINBV1EFArh7USTyedfe8VoQEI1zy
         BGc98IyWjaxAY5JNL2DqlnIfBy71aYVpYczZToE7/olGcPAxQ0W5+1n4Kl7qBN5V8A
         b82zZCbcIDQlm7H04oze+OYx/Oflz5wjY7bWcGdPnSpw9/OB7wxk1iEm+1ZPMZ6aqn
         0o1cB9n2JqbcA==
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@libero.it>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <20210119231244.GM31381@hungrycats.org>
From:   Martin Svec <martin.svec@zoner.cz>
Message-ID: <7b7e081d-228f-291e-1cb5-fcee8aca0b69@zoner.cz>
Date:   Thu, 21 Jan 2021 09:31:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119231244.GM31381@hungrycats.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Content-Language: cs
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

Dne 20.01.2021 v 0:12 Zygo Blaxell napsal(a):
> With the 4 device types we can trivially specify this arrangement.
>
> The sorted device lists would be:
>
>         Metadata sort order             Data sort order
>         metadata only (3)               data only (2)
>         metadata preferred (1)          data preferred (0)
> 	data preferred (0)		metadata preferred (1)
>         other devices (2 or other)      other devices (3 or other)
>
> We keep 3 device counts for the first 3 sort orders.  If the number of all
> preferred devices (type != 0) is zero, we just return ndevs; otherwise,
> we pick the first device count that is >= mindevs.  If all the device
> counts are < mindevs then we return the 3rd count (metadata only +
> metadata preferred + data preferred) and the caller will find ENOSPC.
>
> More sophisticated future implementations can alter the sort order, or
> operate in entirely separate parts of btrfs, without conflicting with
> this scheme.  If there is no mount option, then future implementations
> can't conflict with it.

I agree with Zygo and Josef that the mount option is ugly and needless. This should be a
_per-device_ setting as suggested by Zygo (metadata only, metadata preferred, data preferred, data
only, unspecified). Maybe in the future it might be useful to generalize this setting to something
like a 0..255 priority but the 4 device types look like a sufficient solution for now. I would
personally prefer a read-write sysfs option to change the device preference but btrfs-progs approach
is fine for me too.

Anyway, I'm REALLY happy that there's finally a patchset being actively discussed. I maintain a
naive patch implementing "preferred_metadata=metadata" option for years and the impact e.g. for
rsync backups is huge.

Martin


