Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B62BF88
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfE1Gpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 02:45:53 -0400
Received: from icts.hu ([195.70.57.6]:36588 "EHLO icts.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfE1Gpx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 02:45:53 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 02:45:52 EDT
Received: from [192.168.6.104] (80-95-82-11.pool.digikabel.hu [80.95.82.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts.hu (Postfix) with ESMTPSA id 53E6F269E451
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2019 08:40:40 +0200 (CEST)
Subject: Re: parent transid verify failed on 604602368 wanted 840641 found
 840639
To:     linux-btrfs@vger.kernel.org
References: <5406386.pfifcJONdE@monk>
From:   =?UTF-8?B?U3phbG1hIEzDoXN6bMOz?= <dblaci@dblaci.hu>
Message-ID: <2a6df734-4c39-2f8a-7d8f-c627c2c15f76@dblaci.hu>
Date:   Tue, 28 May 2019 08:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5406386.pfifcJONdE@monk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Dennis,

I experienced the same, the problem is with bcache + gcc9. Immediately 
remove the cache device from the bcache, as it prevents more damages to 
your filesystem. After it downgrade gcc to 8 or avoid using bcache (with 
cache device) until the problem is solved by upstream.

Please see here for more information: 
https://bugzilla.kernel.org/show_bug.cgi?id=203573

This is a very serious issue I think, but in my case I could save all my 
files after reboot without bcache cache device (except 1 insignificant 
one), but I guess you might need backups (I hope you have).

Good luck,
László Szalma

ps: i use gentoo, not fedora by the way, so it is general issue with 
gcc, i read reports with gcc9 + 4.xxx kernels too.

2019. 05. 27. 23:33 keltezéssel, Dennis Schridde írta:
> Hi!
>
> Yesterday I upgraded from Linux 5.1.1 (built with GCC 8.3.0) to Linux 5.1.4
> (built with GCC 9.1.0).  The next boot was extremely slow and the desktop
> environment (KDE Plasma) never really started, but got kind of stuck in the
> startup screen.  So I switched to a VT and pressed ctrl+alt+del.  The next
> boot stopped early with following message:
>
> [T445] BTRFS: device label <...> devid 1 transid 840641 /dev/bcache0
> [T599] BTRFS info (device bcache0): disk space caching is enabled
> [T599] BTRFS info (device bcache0): has skinny extents
> [T599] BTRFS error (device bcache0): parent transid verify failed on 604602368
> wanted 840641 found 840639
> [T599] BTRFS error (device bcache0): open_ctree failed
>
> How can I recover from this?
>
> The filesystem should have several snapshots (created by snapper [1], on every
> boot and hourly).  Will they be of any help recovering my data?
>
> Best regards,
> Dennis
>
> [1]: http://snapper.io/


