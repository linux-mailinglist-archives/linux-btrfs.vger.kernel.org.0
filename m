Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4789767811
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 05:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfGMD7K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 23:59:10 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38016 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfGMD7J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 23:59:09 -0400
Received: by mail-lj1-f169.google.com with SMTP id r9so11162655ljg.5
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2019 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epZpEIW2yC3lYWygQNSprS80WUZtMzeXAO2hTg8fFn0=;
        b=JTSaM0aF7KLxp9seE4lWBSrYVFAA8E1Ie3vLqeQm4SltA16YZ0LBCKIYPZBXcQdhT7
         EYVvQhjZOQc+tZTpHQ/mGrGQRta0sfcBilwswaTdhhQTPqmC9oupK61SQv1yj2uV84ZE
         4YZGhynKafqB5w/GkASB7d3IxgjAYFdcwhrSmr7/rUEfDA+nHcFXpmsojwqfUpt9uObP
         0stEDUq6YtOJGI9D6/o6qEDazTWIVsUSdpbLoVKP86LczyakSfDiW4O+/IobSoSUnxZl
         DdkBYgpZOAk1Qk3qIhpi2mPKK6R3R2MC33vco18sXMHBJNj8iC845pGu/GfEmT1NANVf
         xA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=epZpEIW2yC3lYWygQNSprS80WUZtMzeXAO2hTg8fFn0=;
        b=B8D9KhToTVMKCgqW+5FzlYbuNapoE9rVew+fhdMy8xQ+tZb7dt4S8RXl7uIVerllFU
         9jMN4XFb3rg6au9s46Cwh/eLvTfSwf7+Ss/uu/2ml8z4+Z7o6hobRmWjJa8ixqmkd731
         lOv2QSjSz8u4bH4AKGdj/bRx5B7c+qDhby1U7IfEGae3GK8h1KgqJ7j4hsDZGYeFRTVf
         N+1yxdXtE2GCwzQ6HSxOZROXlezVhdG4fUEmAkaM7pxidabU2Fm6EUbt1S2BiXztT1FV
         dBtZ7geNaqjLHHZLkuWjEOoupUO6E6dRZgGmVY4WLYOA02GxqqeTKDh99jE0hnLuxAD3
         v1YQ==
X-Gm-Message-State: APjAAAUBNaq+2zw6M+FCqFQP7v4/U0QVXnzuuJMuhs8hkmGD1YP2zWFm
        4uVTrvnK5wFqUWKoIqyt5C+6ZYGq+Dk=
X-Google-Smtp-Source: APXvYqza3R9bhXtLBajnLWl3agK6AcrqFl2V6E9O29fCRVj1CpxZ2aVolVNTiVmhrJjqwJyotqykmA==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr7680583lji.231.1562990346779;
        Fri, 12 Jul 2019 20:59:06 -0700 (PDT)
Received: from [192.168.1.6] ([109.252.55.203])
        by smtp.gmail.com with ESMTPSA id t1sm1765704lji.52.2019.07.12.20.59.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 20:59:05 -0700 (PDT)
Subject: Re: find subvolume directories
To:     linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
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
Message-ID: <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
Date:   Sat, 13 Jul 2019 06:59:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712231705.GA16856@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

13.07.2019 2:17, Ulli Horlacher пишет:
> I need to find (all) subvolume directories.
> I know, btrfs subvolumes root directories have inode #256, but a
> "find / -inum 256" is horrible slow!
> 
> Next idea: "btrfs subvolume list /" is really fast, but its output is not
> always direct usable to find the subvolume directory.
> 
> Example output on a SUSE system:
> 
> root@trulla:~# btrfs subvolume list /
> ID 257 gen 2280099 top level 5 path @
> ID 258 gen 2280769 top level 257 path @/home
> ID 259 gen 2280947 top level 257 path @/opt
> ID 260 gen 2280098 top level 257 path @/srv
> ID 261 gen 2280954 top level 257 path @/tmp
> ID 262 gen 2280187 top level 257 path @/usr/local
> ID 263 gen 2280099 top level 257 path @/var/crash
> ID 264 gen 2280949 top level 257 path @/var/log
> ID 265 gen 2280099 top level 257 path @/var/opt
> ID 266 gen 2280954 top level 257 path @/var/spool
> ID 267 gen 2280947 top level 257 path @/var/tmp
> ID 270 gen 2280222 top level 257 path @/.snapshots
> ID 453 gen 2280954 top level 270 path @/.snapshots/128/snapshot
> ID 1235 gen 2280099 top level 257 path @/var/lib/machines
> ID 12392 gen 2123118 top level 270 path @/.snapshots/1065/snapshot
> ID 12393 gen 2123120 top level 270 path @/.snapshots/1066/snapshot
> ID 13273 gen 2176640 top level 270 path @/.snapshots/1089/snapshot
> ID 13274 gen 2176651 top level 270 path @/.snapshots/1090/snapshot
> ID 13553 gen 2203681 top level 270 path @/.snapshots/1103/snapshot
> 
> There is no /@/ directory in the default filesystem because of:
> 
> root@trulla:/# stat /@/.snapshots/128/snapshot
> stat: cannot stat '/@/.snapshots/128/snapshot': No such file or directory
> 
> root@trulla:~# btrfs subvolume get-default /
> ID 453 gen 2280954 top level 270 path @/.snapshots/128/snapshot
> 
> root@trulla:/# mount | grep " / "
> /dev/sda2 on / type btrfs (rw,relatime,space_cache,subvolid=453,subvol=/@/.snapshots/128/snapshot)
> 
> On this particular system I could remove "@" from the subvolume path to
> get the subvolume directory:
> 

That is just coincidence because @/.snapshot subvolume is mounted on
/.snapshot. It could also be mounted under /var/lib/snapper (insert your
path here).

> root@trulla:/# stat /.snapshots/128/snapshot
>   File: '/.snapshots/128/snapshot'
>   Size: 198             Blocks: 0          IO Block: 4096   directory
> Device: 27h/39d Inode: 256         Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2019-07-13 01:03:08.543830085 +0200
> Modify: 2019-07-13 01:03:37.336445461 +0200
> Change: 2019-07-13 01:03:37.336445461 +0200
>  Birth: -
> 
> But what if a btrfs filesystem does not have a toplevel /@/ directory, but
> anything else, like /this/is/my/top/directory ?
> 

btrfs does not have "top level directory" beyond single /. It is
entirely up to the user who creates it how subvolumes are named and
structured. You can well have /foo, /bar, /baz mounted as /, /var and /home.

> Will be the first output line of "btrfs subvolume list /"
> always look like
> 
> ID 257 gen 2280099 top level 5 path this/is/my/top/directory 
> 
> ?
> 

If /foo and /foo/bar are subvolumes, then /foo/bar will have higher ID
than /foo (because it must have been created after /foo) so /foo will be
listed before /foo/bar in default sort order. Whether it will have ID
257 is entirely up to whoever created this filesytsem and its history.
