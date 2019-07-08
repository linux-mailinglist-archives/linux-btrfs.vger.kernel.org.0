Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE291619BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 06:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfGHEFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 00:05:07 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34881 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGHEFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jul 2019 00:05:06 -0400
Received: by mail-lj1-f182.google.com with SMTP id x25so7645097ljh.2
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jul 2019 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anSNdiYo0FDueoHjohe4+6Ntn8MezXi5ye/wLShOk5U=;
        b=qRQhzK/yRwu0lLZ2eKzoSvUvvQhnGAqWvOgvHjlzGHUGnQwJvvUEVXD4P7EJ3jm0VC
         MUItJALpKXkyB5TTMFv91R2o048AdiYOwZXzs//LTP+4i84JbeoWZxS3+ZH+kUDDU33o
         RuAbK5siBX9RSMGeqeU+LEJak5sZwYVpIeK6VBQfbQgsvgNPPzuGYnIYlh6/EQEKaBQT
         c1R3jYd1tpTJPODukmDddH+EB8uMiH9BQuDVS+fKk9P+v3GF/e4FawqyKX+AANx4MwQY
         eihgt/CT+KoOK+TNrb2YtIV33WQC5PPykm5n9VQBxO21/09Xks3B0PYeUQ9JcE4gjqYg
         /WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=anSNdiYo0FDueoHjohe4+6Ntn8MezXi5ye/wLShOk5U=;
        b=dB1Z2kKl2F4WxkVKaUaj0/XjrHO0hRO43g018xql8RfKbG4GQXIXr7S1qycN0is1qS
         AV4siiottivnVbF3GwamPeZEzw3+54new+Wn27lRmbVhGtb3T8JDq4IoKyN8eCDfcCdo
         DQYIVVlTquggOhhS/yVbHoZ87wVRJ7er+G2VPzcztMXDeF/fwNkuFSOq+qI3alTWrPjc
         weTlh8zCElGAGP4ot4uVrFgCp7vVOta050ExfUKRd+6lOUru8Aol5kKFUFfyshBKgSWR
         xn65M3lpEjS6d2HztEtv2IcKMdBrMtb5Xl6Ns84kIdcaLqcWFyWnALr/fNv5vy9vH/mc
         W3sA==
X-Gm-Message-State: APjAAAUOFrfsEDq67tHJI67ggNmX2M9HeL2xahikdkOmMvLD6VhYnosa
        i79IlABsrDwGWgtqxeeGQTu28B0Q
X-Google-Smtp-Source: APXvYqySbtqRUYMzH06gciRPvycgXfJN29lFLu7qMFsFx+YaNDryL2+ITW0olKfZeYW7e3FDBPpkSw==
X-Received: by 2002:a2e:5b0f:: with SMTP id p15mr8695210ljb.82.1562558703670;
        Sun, 07 Jul 2019 21:05:03 -0700 (PDT)
Received: from [192.168.1.6] ([109.252.55.59])
        by smtp.gmail.com with ESMTPSA id b11sm3364673ljf.8.2019.07.07.21.05.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 21:05:02 -0700 (PDT)
Subject: Re: find snapshot parent?
To:     linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
 <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
 <20190706204339.GB13656@tik.uni-stuttgart.de>
 <774d3e3d-bf1a-a3a1-b21c-45a3a353e5bc@suse.com>
 <ffa57dd3-51c8-66f8-a53e-be28df79e0d3@gmail.com>
 <8bc57b91-fc13-979b-a25a-b7a16094d09a@suse.com>
 <20190707221837.GA15143@tik.uni-stuttgart.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <243cd969-9ee1-e031-894c-f99b63c630bb@gmail.com>
Date:   Mon, 8 Jul 2019 07:05:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707221837.GA15143@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

08.07.2019 1:18, Ulli Horlacher пишет:
> On Sun 2019-07-07 (12:12), Nikolay Borisov wrote:
> 
> 
>> root@ubuntu-virtual:~# mount /dev/vdc /media/scratch/
>>
>> root@ubuntu-virtual:~# btrfs subvol show /media/scratch/      
>> /
>> 	Name: 			<FS_TREE>
>> 	UUID: 			80633e8d-fa8a-4922-ac0c-b46d7b2e2d81
>> 	Parent UUID: 		-
>> 	Received UUID: 		-
>> 	Creation time: 		2019-07-07 09:09:15 +0000
>> 	Subvolume ID: 		5
>> 	Generation: 		8
>> 	Gen at creation: 	0
>> 	Parent ID: 		0
>> 	Top level ID: 		0
>> 	Flags: 			-
>> 	Snapshot(s):
>> 				snap1
>> 				snap-ro
> 
> 
> root@fex:~# lsb_release -d
> Description:    Ubuntu 18.04.2 LTS
> 
> root@fex:~# btrfs version
> btrfs-progs v4.15.1
> 
> root@fex:~# mount|grep /local
> /dev/sdd1 on /local type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)
> 
> root@fex:~# btrfs subvolume show /local
> /
>         Name:                   <FS_TREE>
>         UUID:                   -
>         Parent UUID:            -
>         Received UUID:          -
>         Creation time:          -
>         Subvolume ID:           5
>         Generation:             1633457
>         Gen at creation:        0
>         Parent ID:              0
>         Top level ID:           0
>         Flags:                  -
> 
> No UUID!
> 

Neither here on different versions of openSUSE. Note that it also
mistakenly displays subvolumes as snapshots (I assume, it simply
compares NULL subvolume UUID with NULL parent UUID in this case).

bor@leap423:~> sudo btrfs version
btrfs-progs v4.5.3+20160729
bor@leap423:~> uname -a
Linux leap423 4.4.180-102-default #1 SMP Mon Jun 17 13:11:23 UTC 2019
(7cfa20a) x86_64 x86_64 x86_64 GNU/Linux
bor@leap423:~> sudo btrfs su sh /mnt
/mnt is toplevel subvolume
bor@leap423:~>

bor@localhost:~> sudo btrfs version
btrfs-progs v4.19.1
bor@localhost:~> uname -a
Linux localhost 4.12.14-lp151.28.7-default #1 SMP Mon Jun 17 16:36:38
UTC 2019 (f8a1872) x86_64 x86_64 x86_64 GNU/Linux
bor@localhost:~> sudo btrfs su sh /mnt
/
	Name: 			<FS_TREE>
	UUID: 			-
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		-
	Subvolume ID: 		5
	Generation: 		338
	Gen at creation: 	0
	Parent ID: 		0
	Top level ID: 		0
	Flags: 			-
	Snapshot(s):
				@
				@/var
				@/usr/local
				@/tmp
				@/srv
				@/root
				@/opt
				@/home
				@/boot/grub2/x86_64-efi
				@/boot/grub2/i386-pc
				@/.snapshots
				@/.snapshots/1/snapshot
bor@localhost:~>

bor@10:~> sudo btrfs version
btrfs-progs v5.1
bor@10:~> uname -a
Linux 10.0.2.15 5.1.7-1-default #1 SMP Tue Jun 4 07:56:54 UTC 2019
(55f2451) x86_64 x86_64 x86_64 GNU/Linux
bor@10:~> sudo btrfs su sh /mnt
/
	Name: 			<FS_TREE>
	UUID: 			-
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		-
	Subvolume ID: 		5
	Generation: 		26638
	Gen at creation: 	0
	Parent ID: 		0
	Top level ID: 		0
	Flags: 			-
	Snapshot(s):
				@
				@/.snapshots
				@/boot/grub2/i386-pc
				@/boot/grub2/x86_64-efi
				@/home
				@/opt
				@/srv
				@/tmp
				@/usr/local
				@/var/cache
				@/var/crash
				@/var/lib/libvirt/images
				@/var/lib/machines
				@/var/lib/mailman
				@/var/lib/mariadb
				@/var/lib/mysql
				@/var/lib/named
				@/var/lib/pgsql
				@/var/log
				@/var/opt
				@/var/spool
				@/var/tmp
bor@10:~>


