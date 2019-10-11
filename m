Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D0D4755
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJKSRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 14:17:38 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42257 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfJKSRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 14:17:38 -0400
Received: by mail-lf1-f51.google.com with SMTP id c195so7675395lfg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6PcaEb4rav6tBZodvsI/7/IKhIHCX0Nsj4xZikoGob8=;
        b=P11hfVB/tmIRDh9mnvrHwLZNoD446UZqFM3MHPYc/usHp/beRfN0F8fFFdhAG7EAvX
         HNHFsyQA+DazG5euVrZL1IB9VmCABIQ/x9N7DHxaeVdJp2u6JBxTcTLHhm1pjKauN5zl
         FmsQjI5yRteFR/vRd+hsaoWirVb7LLTizC0ElpxCeBWYwqu8VWWy4KzUU3u2oYrmyv+q
         uOvSZlOKMltdw0czXydfKoUz4yqe6EuPVlfGopBFAMiTVjQ535uq0jLda23X/C46Ju/i
         U4ypmwtDqo5P7Q8fgvmvaDfoLnsgbSw2wq/qJMC5/bn+wYPQ+d0mQ2mT2JeCQhki67xN
         XxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6PcaEb4rav6tBZodvsI/7/IKhIHCX0Nsj4xZikoGob8=;
        b=tRh5IW2B0NeJChtmk0jFGeXexqVhQVDJomHti0z/nY28ShvkiwEoT5blSZ07Lkh2RE
         7qdkFWNmv5Fg81rfpkaRaEV3zDCGpdZZGMrPCcX2nTBJl8MSkvJLUvqNGUGZJUPwkxYO
         KA3J+3bfin3RbxqcaokNA5RPway6us2k0S5eiTM+/Ey6TDuyzACRVTstw/9TfkgwsjCb
         emiE9aLSJKC0uX/432q9Xy+j5omXV/PuTaKxJlhAwLiBCjO2H7+JTKWp1MEuzGAmxpN2
         BslnXCKXICwj6ORyROKO0Cmc2Oy5WFz3KnpgKdyjH31TYwU6jB3KHZDFnR6w/Io5GstT
         Aguw==
X-Gm-Message-State: APjAAAW1YHuoGhPXfiDgUDlXx+TyLKSGqUx3nxAWQhkNPM5jnVNPr9w4
        fgumhZ42aqs3LYrmZeN0nqCP6M49IHE=
X-Google-Smtp-Source: APXvYqxu10NtzElHqvt204qd+l9zIIoV8QIvWrqOfbP1oeVmbg+BJwEMrjerIDLl8vLpqy4rzmio6w==
X-Received: by 2002:a19:f018:: with SMTP id p24mr9660256lfc.51.1570817854490;
        Fri, 11 Oct 2019 11:17:34 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-228.nat.spd-mgts.ru. [109.252.90.228])
        by smtp.gmail.com with ESMTPSA id u21sm2308309lje.92.2019.10.11.11.17.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:17:33 -0700 (PDT)
Subject: Re: rsync -ax and subvolumes
To:     linux-btrfs@vger.kernel.org
References: <20191010172011.GA3392@tik.uni-stuttgart.de>
 <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
 <20191011061544.GB3648@tik.uni-stuttgart.de>
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
Message-ID: <7c4ea74b-3c28-16d6-49c0-977c11b18577@gmail.com>
Date:   Fri, 11 Oct 2019 21:17:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011061544.GB3648@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

11.10.2019 9:15, Ulli Horlacher пишет:
> On Thu 2019-10-10 (20:47), Kai Krakow wrote:
> 
>> Actually, you could also just bind-mount into /mnt/btrfs, bind-mounts
>> won't inherit other mounts but will still see pure subvolumes.
> 
> Next problem:
> 
> root@ptm1:~# sysinfo 
> System:        Linux ptm1 4.4.180-94.100-default x86_64
> Distribution:  SUSE Linux Enterprise Server 12 SP3
> 
> root@ptm1:~# mount | grep sda
> /dev/sda2 on / type btrfs (rw,relatime,space_cache,subvolid=453,subvol=/@/.snapshots/128/snapshot)
> /dev/sda2 on /.snapshots type btrfs (rw,relatime,space_cache,subvolid=270,subvol=/@/.snapshots)
> /dev/sda2 on /opt type btrfs (rw,relatime,space_cache,subvolid=259,subvol=/@/opt)
> /dev/sda2 on /var/log type btrfs (rw,relatime,space_cache,subvolid=264,subvol=/@/var/log)
> /dev/sda2 on /srv type btrfs (rw,relatime,space_cache,subvolid=260,subvol=/@/srv)
> /dev/sda2 on /var/tmp type btrfs (rw,relatime,space_cache,subvolid=267,subvol=/@/var/tmp)
> /dev/sda2 on /var/spool type btrfs (rw,relatime,space_cache,subvolid=266,subvol=/@/var/spool)
> /dev/sda2 on /usr/local type btrfs (rw,relatime,space_cache,subvolid=262,subvol=/@/usr/local)
> /dev/sda2 on /var/opt type btrfs (rw,relatime,space_cache,subvolid=265,subvol=/@/var/opt)
> /dev/sda2 on /home type btrfs (rw,relatime,space_cache,subvolid=258,subvol=/@/home)
> /dev/sda2 on /var/lib/machines type btrfs (rw,relatime,space_cache,subvolid=1235,subvol=/@/var/lib/machines)
> /dev/sda2 on /tmp type btrfs (rw,relatime,space_cache,subvolid=261,subvol=/@/tmp)
> /dev/sda2 on /var/crash type btrfs (rw,relatime,space_cache,subvolid=263,subvol=/@/var/crash)
> 
> root@ptm1:~# mount -o bind / /mnt/tmp
> 
> root@ptm1:~# find /opt | wc -l
> 564
> 
> root@ptm1:~# find /mnt/tmp/opt | wc -l
> 1
> 

Of course. /opt is mount point. You will need to replicate the same
mount hierarchy under /mnt/tmp.
