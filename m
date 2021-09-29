Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F122141BF6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 08:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbhI2HA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 03:00:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhI2HA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 03:00:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A81DA223CE;
        Wed, 29 Sep 2021 06:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632898756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2gGhlL+1mJq1wqApYzO12t+xEiG/WjixF2bVBiE/Ik=;
        b=kZoNJqLHRPaHkjTYKCLdq82oNUmoCDSdMsVL6UJYqxERkH+aAJ9+100F2KEmL+QjU3A2Si
        eSFvnzNhWtV23JI6l3j11UzrDCiApfiT/TObfoKTajlwy4tk08udKD9Jy7rojk0/2LA6x3
        qXMNPP94jQw2YLLQBL7iFm2/vG42rQw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B63414070;
        Wed, 29 Sep 2021 06:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L10CG8QOVGHVXQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 29 Sep 2021 06:59:16 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
Date:   Wed, 29 Sep 2021 09:59:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.09.21 г. 2:03, Anand Jain wrote:
> On 28/09/2021 20:37, Nikolay Borisov wrote:
>> Currently btrfs-progs will happily enumerate any device which has a
>> btrfs filesystem on it. For the majority of use cases that's fine and
>> there haven't been any problems with that.
> 
>> However, there was a recent
>> report
> 
>  Could you point to the report or if it is internal?

Internal

> 
>  Kernel message has the process of name for the device scan.
>  We don't have to fix the btrfs-progs end if it is not doing it.
> 
>> that in multipath scenario when running "btrfs fi show" after a
>> path flap 
> 
>  It is better to use 'btrfs fi show -m' it provides kernel perspective.

[146822.972653] BTRFS warning: duplicate device /dev/sdd devid 1
generation 8 scanned by systemd-udevd (6254)

[146823.060984] BTRFS info (device dm-0): devid 1 device path
/dev/mapper/3600140501cc1f49e5364f0093869c763 changed to /dev/dm-0
scanned by systemd-udevd (6266)

[146823.075084] BTRFS info (device dm-0): devid 1 device path /dev/dm-0
changed to /dev/mapper/3600140501cc1f49e5364f0093869c763 scanned by
systemd-udevd (6266)


btrfs fi show -m is actually consistent with always showing the mapper
device.

> 
>  What do you mean by path flap here? Do you mean a device-path in a
> multi-path config disappeared forever or failed temporarily?

flap means going up and down. The gist is that btrfs fi show would show
the latest device being scanned, which in the case of multipath device
could be any of the paths.

> 
>> instead of the multipath device being show the path device is
>> shown. So a multipath filesystem might look like:
>>
>> Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
>>     Total devices 1 FS bytes used 192.00KiB
>>     devid    1 size 10.00GiB used 536.00MiB path
>> /dev/mapper/3600140501cc1f49e5364f0093869c763
> 
>>
>> /dev/mapper/xxx can actually be backed by an arbitrary number of path,
> 
>  It is not arbitrary it depends on the number of HBAs configured to the
> storage/LUN in a SAN.

And this precisely means that the number of paths is arbitrary, based on
particular configuration.

> 
>> which in turn are presented to the system as ordinary scsi devices i.e
>> /dev/sdd.
> 

<snip>
