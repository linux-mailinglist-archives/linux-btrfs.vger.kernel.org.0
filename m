Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0481E22C49C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXL5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 07:57:02 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:38084 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgGXL5B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 07:57:01 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id ywJujonTmzS33ywJujzQMv; Fri, 24 Jul 2020 13:56:59 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1595591819; bh=n5TnpeVi37i0slkXUuT4FiuWweyAIJ7Xk7cGP3H8fxI=;
        h=From;
        b=SHjEVPzQ+2mfnXmWOc/J9cftPMhNEw0cSt45nG1alLRpArFoitMt7tr8r3c3NqxQK
         Sf53/fMGxUE5R/UQpGJ0+/MT75BraZq2A2F30mmNuP6cfq8Fz67QE7kZ7YSVfXE8Uj
         KFESJvfdKhsax+Z+zPPmpPwzpDDNVkIlQ5+x3SvYDqqA7XO1LK/L9FNxY6A9S3fh9F
         4UDL/mKmxU/konRPqlkPXLw/2n81jAYrSbFdE6cKIOXr020v1bio1Et9vOh9diWO1H
         IBHu7nJbOLMbiPoqs2+XhFFnYStp6m4uMcO9oPwJVc2rPAnz0QAKnp0KLT01YpDIIn
         t3g+HzWAX23lQ==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=HGwcGsW0Rqe67ayeVLEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Chris Murphy <lists@colorremedies.com>
References: <20200721203340.275921-1-kreijack@libero.it>
 <20200723215325.GB5890@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <a4074100-b006-7d64-e22d-779ad15191c0@libero.it>
Date:   Fri, 24 Jul 2020 13:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723215325.GB5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL1cgiICeVzuTyQ8U0xzAwnqeB8idMfoIWxQSF/RkrZlDLlSDDbeSk8HkPobBF3CARypPn7PKo2dxUMr1nueosvKWiDkZDrHC3jAKFnk3guAxB+GbOfU
 lMTDxQXnUzg/k2dYH4CzO03MPEtJtSpyVYodWV4Xg19y0RevwV98CztZIEBua0zryGDIP/fHPJqmqL2gYAKZXoyv/PXOkngfhqU4li1Ti74LPfY6LxEIZDuI
 fG0VjL07/LCIRkiQn2Gzdg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/23/20 11:53 PM, Zygo Blaxell wrote:
> On Tue, Jul 21, 2020 at 10:33:39PM +0200, Goffredo Baroncelli wrote:
>>
>> Hi all,
>>
>> this is an RFC to discuss a my idea to allow a simple rollback of the
>> root filesystem at boot time.
>>
>> The problem that I want to solve is the following: DPKG is very slow on
>> a BTRFS filesystem. The reason is that DPKG massively uses
>> sync()/fsync() to guarantee that the filesystem is always coherent even
>> in case of sudden shutdown.
>>
>> The same can be useful even to the RPM Linux based distribution (which however
>> suffer less than DPKG).
>>
>> A way to avoid the sync()/fsync() calls without loosing the DPKG
>> guarantees, is:
>> 1) perform a snapshot of the root filesystem (the rollback one)
>> 2) upgrade the filesystem without using sync/fsync
>> 3) final (global) sync
>> 4) destroy the rollback snapshot
> 
> The idea sounds OK, but there are alternatives:
> 
> 	1) perform snapshot of root filesystem
> 	2) chroot snapshot eatmydata apt dist-upgrade (*)
> 	3) sync -f snapshot
> 	4) renameat2(..., snapshot, ..., root, RENAME_EXCHANGE)
> 	5) delete snapshot
> 
> (*) OK you have to set up /dev, /proc, /sys, etc, probably a whole
> namespace.
> 
> This may not play well with maintainer scripts on some distros, but it
> does mean you don't have a half-broken system _during_ the upgrade.

Also Chris, suggested that. However I don't think that it is a viable solution:
1) as you pointed out, most of the maintainer pre/post install scripts assume that the system is "live". So I don't think that it would be possible without auditing and updating all the packages.
2) what happens in case of unclean shutdown during step 4 ? To me it seems that we are performing two installations :-) The first one is at step 2 and the second one is at step 3. Moreover a move between two subvolumes is not allowed (it like a copy)
higo@venice:/tmp$ btrfs sub crea sub1
Create subvolume './sub1'
ghigo@venice:/tmp$ btrfs sub crea sub2
Create subvolume './sub2'
ghigo@venice:/tmp$ touch sub1/file1
ghigo@venice:/tmp$ python
Python 2.7.18 (default, Apr 20 2020, 20:30:41)
[GCC 9.3.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import os
>>> os.rename("sub1/file1", "sub2/file")
Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
OSError: [Errno 18] Invalid cross-device link


This means that there is an high risk of an incomplete write in case of unplanned shutdown (even tough clone is allowed...)


> 
> Sometimes when I have a really problematic upgrade I rsync the system
> to another box, do the upgrade there, and then rsync the system back
> to the problematic box.  As a side-effect it also allows me to do a
> verification test to make sure the upgrade worked before throwing it
> onto a production system.  The snapshot/rollback thing would be a
> local version of that.
> 
>> If an unclean shutdown happens between 1) and 4), two subvolume exists:
>> the 'main' one and the 'rollback' one (which is the snapshot before the
>> update). In this case the system at boot time should mount the "rollback"
>> subvolume instead of the "main" one. Otherwise in case of a "clean" boot, the
>> "rollback" subvolume doesn't exist and only the "main" one can be
>> mounted.
>>
>> In [1] I discussed a way to implement the steps 1 to 4. (ok, I missed
>> the point 3) ).
>>
>> The part that was missed until now, is an automatic way to mount the rollback
>> subvolume at boot time when it is present.
>>
>> My idea is to allow more 'subvol=' option. In this case BTRFS tries all the
>> passed subvolumes until the first succeed. So invoking the kernel as:
>>
>>    linux root=UUID=xxxx rootflags=subvol=rollback,subvol=main ro
>>
>> First, the kernel tries to mount the 'rollback' subvolume. If the rollback
>> subvolume doesn't exist then it mounts the 'main' subvolume.
> 
> This could be done already from the initramfs.

Ok, this means that we have three possibility:
1) do this at bootloder level (eg grub)
2) do this at initramfs
3) do this at kernel level (see my patch)

All these possibilities are a viable solution. However I find 1) and 2) the more "intrusive", and distro specific. My fear is that each distro will take a different choice, leading to a more fragmentation.
I hoped that the solution nr 3, could help to find a unique solution....




> 
>> Of course after the mount, the system should perform a cleanup of the
>> subvolumes: i.e. if a rollback subvolume exists, the system should destroy
>> the "main" one (which contains garbage) and rename "rollback" to "main".
>> To be more precise:
>>
>> 	if test -d "rollback"; then
>> 		if test -d "old"; then
>> 			btrfs sub del "old"
>> 		fi
>> 		if test -d "main"; then
>> 			mv "main" "old"
>> 		fi
>> 		mv "rollback" "main"
>> 		btrfs sub del "old"
>> 	fi
>>
>> Comments are welcome
>> BR
>> G.Baroncelli
>>
>> [1] http://lore.kernel.org/linux-btrfs/69396573-b5b3-b349-06f5-f5b74eb9720d@libero.it/
>>
>> P.S.
>> I am guessing if an idea like this can be applied to a file. E.g. a sqlite
>> database that instead of reling to sync/fsync, creates a reflink file as
>> "rollback" if something goes wrong.... The ordering is preserved. Not the
>> duration.
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
