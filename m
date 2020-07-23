Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5722B71B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgGWUCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 16:02:03 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:43208 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgGWUCD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 16:02:03 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id yhPkjch2DzS33yhPkjvww0; Thu, 23 Jul 2020 22:02:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1595534520; bh=QzbbJcRlpCeVEsVGP2Jzf5oIyazDFKzoq0Ix8zGzq3E=;
        h=From;
        b=EfpWaKeXI+OIrOvKNYDP/8Aslk9PgUeAebjj4L5CF/clx5wbe6DvIkimCLQOLVOAy
         cgTMS6k6PNImPxxjPiRTtetjsJE6jNDeuKnz9w7wwLB01ofJvArkhNzPnhCyWI0vh5
         fDr1mf+hU+A+Qzh8HYonsdNQWJRz+MsyiR7daBWOb86agBHxcOzLitNtYkFLdOQNl2
         bL3kG+cD0UHCdQapqI6qj5d9+BFLaFcswp89g/xrG/Hi1T3UTk3zb7JLl4ZJwez74Y
         9JGqhEPu+ptEplpcK2Dc+ab1mWvyFhH8O2eJ8ucXaV4EjBGAhr3fFGb3BSDiOYaGDF
         WaCFQDG9EUvEA==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=FSydnwZyAAAA:20 a=Ye9q-bpsAAAA:8 a=k_FK-2JuAAAA:20
 a=OBBw11hQ-LK4APZSOAAA:9 a=QEXdDO2ut3YA:10 a=_9h_Gf2_qasA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
To:     Nicholas D Steeves <nsteeves@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20200721203340.275921-1-kreijack@libero.it>
 <87imegh018.fsf@DigitalMercury.dynalias.net>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <ee2b3e4c-3cb2-964d-f3f5-4a9a84669a73@libero.it>
Date:   Thu, 23 Jul 2020 22:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87imegh018.fsf@DigitalMercury.dynalias.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKZlPlcCCZQx9NZbj7MYEqMsbG83NCoJmeZNCZyUvLm44eFSVcygnO3VDPMLVL0t6imQWNYCAs8VHtNcb45vVWK9NNXkvk02NeukB/niZD6npadoi+Pa
 lldHjtGyXqvyqBucj+0gM4N6ioSxEOvgmVSEekDriVjTV6gyyePdebYqLRIJqqRLk6cwkq2u/q9BGgAEcmZUN3IW8+9YlJCYH04=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/22/20 2:21 AM, Nicholas D Steeves wrote:
> Hi,
> 
> Reply follows inline.
> 
> Goffredo Baroncelli <kreijack@libero.it> writes:
> 
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
>>
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
>>
>> Of course after the mount, the system should perform a cleanup of the
>> subvolumes: i.e. if a rollback subvolume exists, the system should destroy
>> the "main" one (which contains garbage) and rename "rollback" to "main".
>> To be more precise:
>>
> 
> I like the idea of defaulting to a known-good snapshot on unclean
> shutdown :-)
> 
> Is anyone on this list aware of grub-btrfs
> https://github.com/Antynea/grub-btrfs ?  It's not my project, by the
> way, but I'm curious what advantages your method has compared to the
> alleged ZFS-like Boot Environment support of grub-btrfs?  

Looking at the script, it seems that grub-btrfs updated the grub.cfg when a new snapshot is created (using the systemd capability to trigger an event in case a certain filesystem change happens).

It is a nice idea, however it requires to regenerate grub.cfg at every snapshot. I think that it increases the likelihood of having a corrupted grub.cfg in case of unclean shutdown.

However, I think that grub definitely has the capability to boot from a rollback subvolume. However, this means that grub is needed to rollback the system, which is an too strong requirement.

Update:
Looking at this answer [https://unix.stackexchange.com/questions/415049/generating-menuentry-for-iso-images-dynamically-in-grub-cfg] it seems that grub has the capability to generate dynamically a menu on the basis of the directory structure

> In particular,
> I wonder if the problem have already been solved solved due to that
> project's snapper support, and if it just needs more exposure, general
> testing, and integration for other distributions.
> 
> Oh, and to get apt to trigger snapshot creation:
> https://github.com/stefxh/apt-btrfs-snapper
> 
> Iirc there are a couple other apt-btrfs snapshot creation projects
> 
> Best,
> Nicholas
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
