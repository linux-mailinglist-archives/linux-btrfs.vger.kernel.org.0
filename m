Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7518513E8E
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2019 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEEJJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 May 2019 05:09:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39939 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEEJJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 May 2019 05:09:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id d15so8598494ljc.7
        for <linux-btrfs@vger.kernel.org>; Sun, 05 May 2019 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDN8RO9jRZIsVbXM35Vp9lXJ9l9NhlZAY8sX+Bgh4qM=;
        b=izhW7CRpCN7gbvcvb+oMjpZzglT5AhceNLE3x/txeN5iB4AplcFHuEze6dsBOARVg0
         D8s5pdmFgpp2PWpb5ZTCxWKhgmxM8HiIcuPW9OiS1OWdrgUueHQxBN8GvUjH7zT5lZ+H
         mP/XjeDJCmvPmOndwQgU19+R2g6KqCtdU8LQyyTkLK5HDLHkenyKb2OuMSfsY23Rsr4Q
         8c+xgVRqkXhZTvv0xjRFpQ5uxAG+rH2OTVO+Ej/R44XI4dHHSHd1fJuoKH5Ngrh6P4dZ
         S+a16ChlxuDZ0iQbUZdOom/nKuNYucesLX6keytATy/c0pCKTqhn0XoPzaqjUoRjWERG
         Wg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WDN8RO9jRZIsVbXM35Vp9lXJ9l9NhlZAY8sX+Bgh4qM=;
        b=Ut0azFN+H3jnXy85HZWHO/ffNCThkt2bYDyis6CzS7ZQ2CCfURA07fso/cPDGI31s7
         m2VxVNlZJaFVCNYhE2GYH3XgDOiPFoplW3/O0yLVjuzlyMCvo3BL+1F2EIY6ti1/Dyd/
         dkajIyrZzj72Q0NfM/gDQvEqgKGKxibsIRTcR9n8BXkwZk39PbcongahX0f/iXjT+koz
         t5aJM4HSaTOd8kQLbudNufe/mNm3yMK7RTcRtvFj1g3nFuqptBQxMd0qKis8jouAEy+O
         7OueX+wKXDNuV9KTDWN1fFjT1LGar34mD4jXlF+cj+fWwdyio4UN4M745y4H4mdEIzQk
         e4hg==
X-Gm-Message-State: APjAAAXpmM05N+vFCzTS/mM++ZcTybGG9TsSbG5Ai21Zg+2EZumDeyZN
        sO9PGZx+Ds5SSMqpBhGyDkf6tU0Y
X-Google-Smtp-Source: APXvYqw2PLtXloePi9nzFaI/gaVlKU4NTCuNVdOM60axcKBH6lqBVUZF0Oc85NP0A5qvW383YV7p5Q==
X-Received: by 2002:a2e:7503:: with SMTP id q3mr10146239ljc.190.1557047339782;
        Sun, 05 May 2019 02:08:59 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-193.nat.spd-mgts.ru. [109.252.90.193])
        by smtp.gmail.com with ESMTPSA id h24sm1395679ljk.10.2019.05.05.02.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 02:08:58 -0700 (PDT)
Subject: Re: Hibernation into swap file
To:     Maksim Fomin <maxim@fomin.one>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
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
Message-ID: <596643ce-64f8-121f-3319-676e58d700e7@gmail.com>
Date:   Sun, 5 May 2019 12:08:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

05.05.2019 10:50, Maksim Fomin пишет:
> Good day.
> 
> Since 5.0 btrfs supports swap files. Does it support hibernation into
> a swap file?
> 
> With kernel version 5.0.10 (archlinux) and btrfs-progs 4.20.2
> (unlikely to be relevant, but still) when I try to hibernate with
> systemctl or by directly manipulating '/sys/power/resume' and
> '/sys/power/resume_offset', the kernel logs:
> 
> PM: Cannot find swap device, try swapon -a PM: Cannot get swap
> writer
> 

How exactly do you compute resume_offset? What are exact commands you
ise to initiate hibernation? systemctl will likely not work anyway as
systemd is using FIEMAP which returns logical offset of file extents in
btrfs address space, not physical offset on containing device. You will
need to jump from extent vaddr to device offset manually.

> After digging into this issue I suspect that currently btrfs does not
> support hibernation into swap file (or does it?). Furthermore, I
> suspect that kernel mechanism of accessing swap file via
> 'resume_offset' is unreliable in btrfs case because it is more likely
> (comparing to other fs) to move files across filesystem which
> invalidates swap file offset, so the whole idea is dubious. So,
> 
> 1) does btrfs supports hibernation into swap file? 2) is there
> mechanism to lock swap file?
> 

btrfs performs some checks before allowing file as swap and it also
implicitly locks it during swap usage. Note that btrfs will disable
snapshots of subvolume with swapfile.

File also must be using single allocation profile. There is no way to
force allocation profile for individual file I am aware of in case
filesytem defaults to something else. Also for multi-device btrfs I am
not aware of any way to force allocation of file on specific physical
device, and this is required to use file as swap on btrfs. So you are
likely restricted to single device single data profile.

Finally you are not allowed to mount any filesystem read-write (or
replay any pending log/journal) before doing resume. Does btrfs support
"true" read-only mount, which is guaranteed to not change filesystem
state in any way?

