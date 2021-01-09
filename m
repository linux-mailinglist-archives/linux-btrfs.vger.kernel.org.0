Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0576F2F0338
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jan 2021 20:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAITql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jan 2021 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAITqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jan 2021 14:46:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0789DC061786
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jan 2021 11:46:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o13so31344685lfr.3
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jan 2021 11:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2J4Si+FKWBMRi/oxEANdGsp1uaNtMJp2I3bkh8LFH3M=;
        b=WwNZAciQ0HznH2S9HLiTusrc9OekVxlEQqMzS+Sg/MLu/0jJlcvqnS7QlKz4UXK48P
         mUsupiwf+bGwhxGz1N7NECjbiwclCQuiXgzaBCNHazejddc6kUNVi82JydCxxgG3xfjq
         T6WF9z4CJyhfJNKNbL70HX1ntNmt05Ed+fKumAPMIc6H5WPL8UmztITtgI3F6Xlzs7kN
         qDhl1kFW2xD07uwkY77TIxSwDKd0eIWD8Y+evVAIHBQhZ8ziz7ilnSoIJdwqRRx3HUuL
         JaZ1/zKXwd8ev+PIcqdq2TdHrPc+BtUavy5/dMUOb+dijxlD6zpGz5m2SmbWVYi03tvM
         BETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2J4Si+FKWBMRi/oxEANdGsp1uaNtMJp2I3bkh8LFH3M=;
        b=Au0SstrfvOgnbxa8iDpdUC59lNCE+YSWLWqb/osjjTNzHV5eDT2cakCUW8622kSXyd
         5vk0YS4vJEiUzJY/zDyVhCK/fHjngiTysCry8Iq5UzdCXdm9swSwXCVw0O8I8w2/xK9a
         c1ZRZWa5netT1bOPu/a9PiJZzLIp/fGj62EC45F8z9aOKIAfHziHoXa9yWhLNsga9IAV
         1s9OXCZvqWWhI+8D35qR7Oq3l5ZEvQncX4zDlTIyuOS1UeS8f4tt+8Sh4zY7YF4XIvlI
         Mfeh6pROGMs/wxr3Gon/SEZ61HR3xTlTaYVcYHU2lno45Wi0cO2qXFO6Gx6PPv1Xfhwq
         uQqw==
X-Gm-Message-State: AOAM530QF2gcnBaq+lTDVosRsqzuSHd0lSudzkwlBOcmjMlJD0W+Y6hU
        E4f+7yYfySFa6/Ly5YWskZnD7H1kNy8=
X-Google-Smtp-Source: ABdhPJzLn4sN5yb+hoEo7PH0vcnNAYKh2Ee8ihOmv5ErIp8PhmOeSIWR9vUhNdXx0uzAWhBwN3iewQ==
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr4280053ljc.411.1610221558439;
        Sat, 09 Jan 2021 11:45:58 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id q17sm2496473lfa.32.2021.01.09.11.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 11:45:57 -0800 (PST)
Subject: Re: cloning a btrfs drive with send and receive: clone is bigger than
 the original?
To:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
Date:   Sat, 9 Jan 2021 22:45:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55cef4872380243c9422595700686b79@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

09.01.2021 19:01, Cedric.dewijs@eclipso.eu пишет:
> ­I've got a drive with data, and 3 snapshots of that data. I've transferred all the snapshots to another drive using btrfs send and receive. The send drive has 3.62 GB of data, the receive drive has 4.99 GB of data. It seems like the snapshots don't share data between them that was unchanged.
> 
> How can I transfer the snapshots in such a way that the snapshots only occupy the difference between the snapshots?
> 
> The data on the original drive is organized like this:
> /mnt/send/storage/ <= here's all the data
> /mnt/send/storage_snapshots/ <= here are the 3 snapshots
> 
> The data on the receiving drive is organized like this:
> /mnt/rec/storage/ <= this folder is empty
> /mnt/rec/storage_snapshots/ <= here are the 3 snapshots
> /mnt/rec/btrfs_receive/ <= here are the 3 files generated by btrfs send 
> 
> How can I transfer the snapshots in such a way that /mnt/rec/storage/ holds the latest version of the data, just like on the original drive?
> 
> In detail:
> # mkfs.btrfs -L SEND /dev/sda3
> # mount /dev/sda3 /mnt/send/ -o,compress,noatime
> # mkfs.btrfs /dev/sdd2 -L DATA
> # mount /dev/sdd2 ./mnt/rec/ -o,compress,noatime

I can think of at least two reasons

1. Inline data is not shared and compressing increases probability of
inlining

2. I believe only extents that are aligned on and exact multiple of
filesystem block are reflinked during send.


> # btrfs subvolume create /mnt/rec/btrfs_receive/
> Create subvolume '/mnt/rec/btrfs_receive'
> # btrfs subvolume create /mnt/rec/storage_snapshots
> 
> # btrfs subvolume create /mnt/send/storage
> # btrfs subvolume create /mnt/send/storage_snapshots
> # cd /mnt/send/storage
> # /home/cedric/mkfiles_and_md5.sh <<generates/ change data on the send drive >>
> # btrfs subvolume snapshot -r /mnt/send/storage /mnt/send/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
> Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/storage_snapshots/storage-2021_01_09-1301'
> # /home/cedric/mkfiles_and_md5.sh <<generates/ change data on the send drive >>
> btrfs subvolume snapshot -r /mnt/send/storage /mnt/send/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m%S)
> Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/storage_snapshots/storage-2021_01_09-130120'
> # /home/cedric/mkfiles_and_md5.sh <<generates/ change data on the send drive >>
> # btrfs subvolume snapshot -r /mnt/send/storage /mnt/send/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m%S)
> Create a readonly snapshot of '/mnt/send/storage' in '/mnt/send/storage_snapshots/storage-2021_01_09-130146'
> 
> # btrfs send /mnt/send/storage_snapshots/storage-2021_01_09-1301 -f /mnt/rec/btrfs_receive/storage-2021_01_09-1301.btrfssend
> At subvol /mnt/send/storage_snapshots/storage-2021_01_09-1301
> [root@bcache-test rec]# btrfs send -p /mnt/send/storage_snapshots/storage-2021_01_09-1301 /mnt/send/storage_snapshots/storage-2021_01_09-130120 -f /mnt/rec/btrfs_receive/storage-2021_01_09-130120.btrfssend
> At subvol /mnt/send/storage_snapshots/storage-2021_01_09-130120
> [root@bcache-test rec]# btrfs send -p /mnt/send/storage_snapshots/storage-2021_01_09-130120 /mnt/send/storage_snapshots/storage-2021_01_09-130146 -f /mnt/rec/btrfs_receive/storage-2021_01_09-130146.btrfssend
> At subvol /mnt/send/storage_snapshots/storage-2021_01_09-130146
> 
> # btrfs receive -f /mnt/rec/btrfs_receive/storage-2021_01_09-1301.btrfssend  /mnt/rec/storage_snapshots
> At subvol storage-2021_01_09-1301
> # btrfs receive -f /mnt/rec/btrfs_receive/storage-2021_01_09-130120.btrfssend  /mnt/rec/storage_snapshots
> At snapshot storage-2021_01_09-130120
> # btrfs receive -f /mnt/rec/btrfs_receive/storage-2021_01_09-130146.btrfssend /mnt/rec/storage_snapshots
> At snapshot storage-2021_01_09-130146
> 
> # rm /mnt/rec/btrfs_receive/storage-2021_01_09-1301*
> # btrfs filesystem show
> Label: 'SEND'  uuid: 61b7e45f-62a7-4b04-bc0c-ba1304548b02
> 	Total devices 1 FS bytes used 3.62GiB
> 	devid    1 size 5.00GiB used 4.52GiB path /dev/sda3
> 
> Label: 'DATA'  uuid: 95e85fa4-217c-429a-be55-833bb63e2c71
> 	Total devices 1 FS bytes used 4.99GiB
> 	devid    1 size 931.01GiB used 10.02GiB path /dev/sdd2
> 
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 

