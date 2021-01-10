Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFC2F05DF
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 08:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbhAJHzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 02:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbhAJHzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 02:55:43 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57774C061786
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jan 2021 23:55:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m25so33267202lfc.11
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jan 2021 23:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IBzenC9f2sWtjRe3ACtPFvcwmoYxZAAAT3CLjDJsB8k=;
        b=RF9+EyqjLG0mDVp0B6hVtMpZxMz7rlz5BhnzHZp6WMlc4cWB7+Cz3jajMnTcgZky9l
         GiVpNrr2SNXIVbTydXJAzxVvkwJ4CW1isgsOOiKi53TZSamMZpinbPrBLLP3Q1FpKIto
         ddgJCHjAqcORpO3gc0VK43qRTbN0vJdYtIBmcDqeyoDT1rnroV5T4G3gFyhzsahXlREy
         iqUjLYQ+0gz3ZnQhdTNCGrOJlzxNZuL5zQiWUH+6seqDezc8s3j0TNlvhwQsgBuSOVOb
         QFb5c5CA4AHgBa8InK0BXVG3Gwv8Thj7YgnEz2h8xGD9k+4R6CQQeCr5UK3HPr7DzjmP
         5lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IBzenC9f2sWtjRe3ACtPFvcwmoYxZAAAT3CLjDJsB8k=;
        b=maeRVazJgkqBnSQCxsupNQCForKym2PC/xQJ9IGJZrqNRdEpq3bXJgUuuV/sUAAbrZ
         CNNqJjelpQ1MaTUVfzBzlxZkdD/pZzm+WmU0jR1izX2EkqAPO3XCBAFVzO34wnvFXXH1
         3xQDvNEooeunR67e62xF3A/dW4kylTuZhkBZbtaX/tatD+lkVmIPAJY2nJziPm6v1m1X
         Hga9HE5zJEQ2o5HuZIthXDN0SVanMUh6YNA8MH88wNnfyJ5fa4E9+lIrlZACHTIiOiTr
         CZ67qGkfazmrYtc9J/csGmS2gPCYemmzpWq+eOlf3gM8Y1hzEBcLI4KvqE5xoLmpWJVz
         coQA==
X-Gm-Message-State: AOAM531A4M0GakioCM+M/QEhtEUJD+EMOZzrZiMR20IMdk5XX0/RtXm0
        8DJcFPo/zUWpR9/9TZRujREMIdwEwJM=
X-Google-Smtp-Source: ABdhPJy5pEGp4O0tt54S+pzygG3rdWQoW5sO70oMRm8PELyoZd+woCdw69vqgPcPxd/rDBGoWlobDw==
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr5422885lfs.529.1610265300647;
        Sat, 09 Jan 2021 23:55:00 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id k11sm2944219lji.95.2021.01.09.23.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 23:55:00 -0800 (PST)
Subject: Re: cloning a btrfs drive with send and receive: clone is bigger than
 the original?
To:     Cedric.dewijs@eclipso.eu
Cc:     linux-btrfs@vger.kernel.org
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
 <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
 <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
 <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
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
Message-ID: <3ac5e61c-a6ca-dfd0-e4db-a02569657ff3@gmail.com>
Date:   Sun, 10 Jan 2021 10:54:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

10.01.2021 10:41, Cedric.dewijs@eclipso.eu пишет:
> I've tested some more.
> 
> Repeatedly sending the difference between two consecutive snapshots creates a structure on the target drive where all the snapshots share data. So 10 snapshots of 10 files of 100MB takes up 1GB, as expected.
> 
> Repeatedly sending the difference between the first snapshot and each next snapshot creates a structure on the target drive where the snapshots are independent, so they don't share any data.

How should "btrfs receive" know that in

btrfs send -p base snap1 | btrfs receive
btrfs send -p base snap2 | btrfs receive

snap1 and snap2 are related? By definition "btrfs send -p base" computes
difference to base snapshot and btrfs receive applies this difference to
replica of base snapshot. btrfs receive cannot reuse replica of snap1
because send stream does not contain any information about it.


> How can that be avoided?
> 

You can specify additional clone sources (btrfs send -p base -c snap1
snap2) but in your example the most efficient is to send delta between
two consecutive snapshots.

> Script (version that sends the difference between the first snapshot and each current snapshot):
> # cat ~/btrfs-send-test.sh 
> #!/bin/bash
> 
> btrfs subvolume delete /mnt/send/storage
> btrfs subvolume delete /mnt/send/snapshots/*
> btrfs subvolume delete /mnt/send/snapshots/
> btrfs subvolume delete /mnt/rec/diff
> btrfs subvolume delete /mnt/rec/snapshots/*
> btrfs subvolume delete /mnt/rec/snapshots/
> sync
> btrfs subvolume create /mnt/send/storage
> btrfs subvolume create /mnt/send/snapshots/
> btrfs subvolume create /mnt/rec/diff
> btrfs subvolume create /mnt/rec/snapshots
> 
> btrfs subvolume snapshot -r /mnt/send/storage/ /mnt/send/snapshots/0
> btrfs send /mnt/send/snapshots/0 | btrfs receive /mnt/rec/snapshots
> 
> onelesscounter=0
> counter=1
> while [ $counter -le 10 ]
> do
> 	dd if=/dev/urandom of=/mnt/send/storage/file$( printf %03d "$counter" ).bin bs=1M count=100
> 	md5sum /mnt/send/storage/file$( printf %03d "$counter" ).bin >> /mnt/send/storage/md5sums.txt
> 	btrfs subvolume snapshot -r /mnt/send/storage /mnt/send/snapshots/$counter
> 	btrfs send -p /mnt/send/snapshots/0 /mnt/send/snapshots/$counter -f /mnt/rec/diff/$counter
> 	#btrfs send -p /mnt/send/snapshots/$onelesscounter /mnt/send/snapshots/$counter -f /mnt/rec/diff/$counter 
> 	btrfs receive -f /mnt/rec/diff/$counter /mnt/rec/snapshots
> 	((counter++))
> 	((onelesscounter++))
> done
> echo All done
> 
> # df -h
> /dev/sda3       5.0G 1007M  3.6G  22% /mnt/send
> /dev/sdd2       932G   11G  919G   2% /mnt/rec
> 
> # ls -lh /mtn/rec/diff
> total 5.4G
> -rw------- 1 root root  101M Jan 10 09:17 1
> -rw------- 1 root root 1001M Jan 10 09:19 10
> -rw------- 1 root root  201M Jan 10 09:17 2
> -rw------- 1 root root  301M Jan 10 09:17 3
> -rw------- 1 root root  401M Jan 10 09:17 4
> -rw------- 1 root root  501M Jan 10 09:17 5
> -rw------- 1 root root  601M Jan 10 09:18 6
> -rw------- 1 root root  701M Jan 10 09:18 7
> -rw------- 1 root root  801M Jan 10 09:18 8
> -rw------- 1 root root  901M Jan 10 09:18 9
> 
> #rm /mtn/rec/diff/*
> #sync
> 
> # df -h
> /dev/sda3       5.0G 1007M  3.6G  22% /mnt/send
> /dev/sdd2       932G  5.4G  924G   1% /mnt/rec  <= all data is individually stored in the snapshots?
> 
> 
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 

