Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335262F9981
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 06:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbhARFuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 00:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbhARFuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 00:50:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D575C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 21:49:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so22273330lfc.11
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jan 2021 21:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M9a09kXBu50H5e7NMDxOOdvoPm4NH5M9b2BIh2UL+N4=;
        b=Q650esZrCwtfSVf19uxgJ5N9j88o3C51NFWr3ChqPbmAGqR+PO9S0RRoObL1seIShG
         WDkVT6FRQzRT9wmKaXk2/y97Unvlgve+bz7RryR13R6YHyHwNCdlkKeW7boi33KdwcC2
         q9TX0Vcke8flGzQaUlH5IpQ/fB65HMUtbXxBv29bB/heYv05QU17CoihW9bnoVYY2JUG
         L+kpuWmiTwY4n39laFn7KxMfT2NKAgSBirIddw2b2N7jHeE6wqnpFerm+28lBG2KPgEf
         kP3rJ8cqAXOz3lIqWCv+G3QOOEJjJjre+7aIM/J7NfChNoTDZ9mXQ6r8dTkjCLHR6jPa
         j8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M9a09kXBu50H5e7NMDxOOdvoPm4NH5M9b2BIh2UL+N4=;
        b=gC70csEDpgzjN+iRTE+gjesBZt6549qjuGRfcB/uhhCVyjSdxgl1YkydIuaIvm80kD
         HoSUznONvdgHqBcZp6QxsncF61+5Ea1wkZUbGskfZC0wDaXDA40l6OWWOUQhOKROGStZ
         ohjgYSmixNUzels6t0FwEjOvCqzisFMwNJ0VdGRTynvoSJ8wml9bOGp8SoHiY3xKlTfN
         rwATZxGtzqjs/O0IXyNh6kr6bZCF/tKjSWPxBiYBzH0X2YAJOJXsR5iRkWo97GUJWdEn
         /q9+sPsLUu8ib+UamIagxB7H3kFFiVH36rDYK8uCcuDEfw1RJMUYn9xANBK++39+kVqo
         rntQ==
X-Gm-Message-State: AOAM53087wwhxbkKuf10DxE1sd4qsTzqf+s0FXiL/BQIuDgKnoAQ04PO
        rXIb7x5Vw4Mp/aDdamHmS0dOvvsSQNc=
X-Google-Smtp-Source: ABdhPJwVXESArBfN9C7Gc2vTJrVagSFJ7D48gcXY5mhqSQLbBgEC4tH5os6EYE+4fesMayG2uViWWA==
X-Received: by 2002:a19:9d8:: with SMTP id 207mr10984273lfj.581.1610948959898;
        Sun, 17 Jan 2021 21:49:19 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id 126sm1784920lfm.203.2021.01.17.21.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 21:49:19 -0800 (PST)
Subject: Re: received uuid not set btrfs send/receive
To:     Anders Halman <anders.halman@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
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
Message-ID: <688feaf7-23f1-c19b-8911-ce1069f6a56a@gmail.com>
Date:   Mon, 18 Jan 2021 08:49:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <95f9479d-2217-768e-f866-ae42509c3b2c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

17.01.2021 21:49, Anders Halman пишет:
> Hello,
> 
> I try to backup my laptop over an unreliable slow internet connection to
> a even slower Raspberry Pi.
> 
> To bootstrap the backup I used the following:
> 
> # local
> btrfs send root.send.ro | pigz | split --verbose -d -b 1G
> rsync -aHAXxv --numeric-ids --partial --progress -e "ssh -T -o
> Compression=no -x" x* remote-host:/mnt/backup/btrfs-backup/
> 
> # remote
> cat x* > split.gz
> pigz -d split.gz
> btrfs receive -f split
> 

This command is missing argument.

> worked nicely.

It is impossible, you did not tell "btrfs receive" where to store
incoming data.

bor@bor-Latitude-E5450:~/src/btrfs-progs$ btrfs receive
btrfs receive: exactly 1 argument expected, 0 given

> But I don't understand why the "received uuid" on the
> remote site in blank.

Where is it blank? Show commands you used to check it.

> I tried it locally with smaller volumes and it worked.
> 
> The 'split' file contains the correct uuid, but it is not set (remote).
> 
> remote$ btrfs receive --dump -f split | head
> subvol          ./root.send.ro uuid=99a34963-3506-7e4c-a82d-93e337191684
> transid=1232187
> 
> local$ sudo btrfs sub show root.send.ro| grep -i uuid:
>     UUID:             99a34963-3506-7e4c-a82d-93e337191684
> 
> 
> Questions:
> 
> - Is there a way to set the "received uuid"?
> - Is it a matter of btrfs-progs version difference?
> - What whould be a better approach?
> 
> 
> Thank you
> 
> 
> ----
> 
> # local
> 
> root@fos ~$ uname -a
> Linux fos 5.9.16-200.fc33.x86_64 #1 SMP Mon Dec 21 14:08:22 UTC 2020
> x86_64 x86_64 x86_64 GNU/Linux
> 
> root@fos ~$   btrfs --version
> btrfs-progs v5.9
> 
> root@fos ~$   btrfs fi show
> Label: 'DATA'  uuid: b6e675b3-84e3-4869-b858-218c5f0ac5ad
>     Total devices 1 FS bytes used 402.17GiB
>     devid    1 size 464.27GiB used 414.06GiB path
> /dev/mapper/luks-e4e69cfa-faae-4af8-93f5-7b21b25ab4e6
> 
> root@fos ~$   btrfs fi df /btrfs-root/
> Data, single: total=404.00GiB, used=397.80GiB
> System, DUP: total=32.00MiB, used=64.00KiB
> Metadata, DUP: total=5.00GiB, used=4.38GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> # remote
> root@pih:~# uname -a
> Linux pih 5.4.72+ #1356 Thu Oct 22 13:56:00 BST 2020 armv6l GNU/Linux
> 
> root@pih:~#   btrfs --version
> btrfs-progs v4.20.1
> 
> root@pih:~#   btrfs fi show
> Label: 'DATA'  uuid: 6be1e09c-d1a5-469d-932b-a8d1c339afae
>     Total devices 1 FS bytes used 377.57GiB
>     devid    2 size 931.51GiB used 383.06GiB path
> /dev/mapper/luks_open_backup0
> 
> root@pih:~#   btrfs fi df /mnt/backup
> Data, single: total=375.00GiB, used=374.25GiB
> System, DUP: total=32.00MiB, used=64.00KiB
> Metadata, DUP: total=4.00GiB, used=3.32GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> dmesg is empty for the time of import/btrfs receive.

