Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF59D9722F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfHUGVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 02:21:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:45818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUGVM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 02:21:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C09EAEB3;
        Wed, 21 Aug 2019 06:21:10 +0000 (UTC)
Subject: Re: Unable to mount, even in recovery, parent transid verify failed
 on raid 1
To:     David Radford <croxis@gmail.com>, linux-btrfs@vger.kernel.org
References: <CABJoFDA-ZwF3ZDpajHo3288NcV+_NO5BAsXv7yTe_hqqRNv0PQ@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f0574fc5-5343-5b9a-fda9-60ba947d88c9@suse.com>
Date:   Wed, 21 Aug 2019 09:20:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABJoFDA-ZwF3ZDpajHo3288NcV+_NO5BAsXv7yTe_hqqRNv0PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.08.19 г. 21:17 ч., David Radford wrote:
> I have two 2TB spinning disks with full disk btrfs in raid 1. I am
> unable to mount the disks using any method I have found online. I've
> attached what I hope are the relevant logs. I had to edit them down to
> meet the file size limit.
> 
> uname: Linux babylon 5.2.9-arch1-1-custom-btrfs #1 SMP PREEMPT Mon Aug
> 19 06:41:35 PDT 2019 x86_64 GNU/Linux (Standard Arch Linux kernel
> compiled with Qu's new rescue patch
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637)

SO what event predates this inability to mount? Did you experience any
hard resets - system hangs etc that prompted you to reboot your machine?
Have you changed your kernel recently ? There really isn't much to go on
in here? At the very least DO NOT run any of the repair functionality in
btrfs-progs just yet.

> 
> btrfs-progs v5.2.1
> 
> [root@babylon ~]# btrfs fi show
> Label: 'linux'  uuid: 3fd368de-157c-4512-8985-2be93a21a371
>     Total devices 1 FS bytes used 102.48GiB
>     devid    1 size 119.24GiB used 110.31GiB path /dev/sdb1
> 
> Label: none  uuid: 2507581c-dec0-4fdd-afe7-1f7c7ff66c6d (this is the
> one unountable)
>     Total devices 2 FS bytes used 1.54TiB
>     devid    1 size 1.82TiB used 790.03GiB path /dev/sdc
>     devid    2 size 1.82TiB used 790.03GiB path /dev/sdd
> 
> mounting with usebackuproot and rescue=skip_bg results in
> [ 1088.130629] BTRFS info (device sdc): trying to use backup root at mount time
> [ 1088.130633] BTRFS info (device sdc): disk space caching is enabled
> [ 1088.130635] BTRFS info (device sdc): has skinny extents
> [ 1088.135907] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.151587] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.151605] BTRFS warning (device sdc): failed to read root (objectid=2): -5
> [ 1088.151902] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152134] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152143] BTRFS warning (device sdc): failed to read root (objectid=2): -5
> [ 1088.152519] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152633] BTRFS error (device sdc): parent transid verify failed
> on 30425088 wanted 18663 found 18664
> [ 1088.152640] BTRFS warning (device sdc): failed to read root (objectid=2): -5
> [ 1088.153462] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.153690] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.153699] BTRFS warning (device sdc): failed to read root (objectid=4): -5
> [ 1088.154714] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.154915] BTRFS error (device sdc): parent transid verify failed
> on 343428399104 wanted 18163 found 19034
> [ 1088.154921] BTRFS warning (device sdc): failed to read root (objectid=4): -5
> [ 1088.261675] BTRFS error (device sdc): open_ctree failed
> 
> btrfs-find-root log attached
> 
> I do have partial backup but it is a little outdated and would really
> appreciate help either fixing the filesystem, or finding out how to
> recover it with as minimal loss as possible. Thank you for the help!
> 
