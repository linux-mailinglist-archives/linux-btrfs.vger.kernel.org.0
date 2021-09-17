Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69C640FDBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhIQQTD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhIQQS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 12:18:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD83C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Sep 2021 09:17:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d21so16018623wra.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Sep 2021 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9Nfe4APPTX1QoUtj1tGRylB1tOcERZkK1WH6qYVp1vQ=;
        b=c3sHFKJyhS+TRRzvoilOHMPgTQ04oVsW16v4nLaJfNNBRzKDJXA89BPXkeecE8yafc
         clmcYkzXPW8ftIfA7/1EQfrHvTCWQEQV15j2oyTV+UnxXNIbihGprt8N63jzQ3gi49oI
         PVbL6+mzIIn8wtWkRG7VhvJMhi9RQ0Kj0vJpY3ec7ask6b/1rhX3/c8Fl2aUm134uAJn
         43LpDlYjrlRuXi/crZiP/Jz8LzMF+bCrhtDWpodOqxKMLEkNzlbvAvs21IulhVwkTVMB
         Cvqg1m5Xpa2lWaT/1DWvhDMpLyy5FsuaR/e6Ic3qLBOr71X44m4AVdNQjQAC54ugRFvi
         I82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9Nfe4APPTX1QoUtj1tGRylB1tOcERZkK1WH6qYVp1vQ=;
        b=dLppYJUvEDka5V+OSJ3rRhm3KYbyI8ZH6ZTQt+wvtpWqFVSPCp/Ug4RwfnJtVdoC+8
         kMqkT715bWOhyApMkOrVhpvD6Y6iqNHooZht3l6ibeuAt2iIxGnWrHF4sdtYmqQpRm3i
         i6YaaWDz1whhVa0xlDRWTw2ZyTsa25U2GdEa2dekhOHQ+YB/O/Iuo+jViKdRIkckAur7
         GpM0neygUaMI1Sv8iE6Uf1WXOUj9yExLwXosjM2qM/ddtvJuV1P6v/kBvx06hU+fUFQl
         xEAbd3gty53cdIS5m6eVnoFK2GkxDmpN0KXSebQAkKu1DBEcccB4uThL+XtsNVg6TvjD
         Ks4w==
X-Gm-Message-State: AOAM5311t1jvxPmLgO97xX+nLXZ6GeLs8AijqeiX6HIdlAIZmPNZwstC
        jHKk0GOM1dT+RyZMvO1xhf6bZsRkB40=
X-Google-Smtp-Source: ABdhPJw/GBHSk2aRMz5vV3HjviHbEcUwSto0doghzjvbYAXdGG/J8yYOOUEWE2aeEfmM3HWrCzKQGQ==
X-Received: by 2002:adf:e806:: with SMTP id o6mr12662500wrm.239.1631895455493;
        Fri, 17 Sep 2021 09:17:35 -0700 (PDT)
Received: from [10.13.40.210] ([195.228.146.246])
        by smtp.googlemail.com with ESMTPSA id g143sm11253276wme.16.2021.09.17.09.17.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 09:17:34 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   mailcimbi <mailcimbi@gmail.com>
Subject: Unable to mount btrfs subvol with a new kernel
Message-ID: <9c56dfca-2551-22a8-e6eb-86f0614bc5a8@gmail.com>
Date:   Fri, 17 Sep 2021 18:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear List,

I have two btrfs subvol in my fileset. I can mount it with lubuntu 18.04 
but unable to mount with a newer version. Also unable to mount it when I 
upgrade to the latest 18.04. By the way upgrading to 20.04 (using the 
older kernel after upgrading to the latest 18.04) and starting it with 
an older kernel it is working.

I can reproduce it. Starting with lubuntu 21.04 live cd: unable to 
mount. Starting with lubuntu 18.04.2 live cd: I can mount it.

Here are the results:
lubuntu 18.04
root@lubuntu:~# uname -a
Linux lubuntu 4.18.0-15-generic #16~18.04.1-Ubuntu SMP Thu Feb 7 
14:06:04 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
mounted btrfs with live cd
root@lubuntu:~# mount -t btrfs -o rw,subvol=@ /dev/sda3 /mnt
/dev/sda3        28G   14G   12G  55% /mnt
root@lubuntu:~# mount -t btrfs -o rw,subvol=@home /dev/sda3 /mnt/home
/dev/sda3        28G   14G   12G  55% /mnt/home
root@lubuntu:~# btrfs version
btrfs-progs v4.15.1


lubuntu 20.04
root@lubuntu:~# uname -a
Linux lubuntu 5.4.0-42-generic #46-Ubuntu SMP Fri Jul 10 00:24:02 UTC 
2020 x86_64 x86_64 x86_64 GNU/Linux
root@lubuntu:~# mount -t btrfs -o rw,subvol=@ /dev/sda3 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda3, 
missing codepage or helper program, or other error.
root@lubuntu:~# btrfs version
btrfs-progs v5.10.1

 From the log it seems there is/are corrupt leaf(s)
[ 3231.406914] BTRFS critical (device sda3): corrupt leaf: 
block=1045233664 slot=17 extent bytenr=20209664 len=8192 invalid 
generation, have 895434752 expect (0, 3790778]
[ 3231.406922] BTRFS error (device sda3): block=1045233664 read time 
tree block corruption detected
[ 3231.406971] BTRFS error (device sda3): failed to read block groups: -5
[ 3231.409566] BTRFS error (device sda3): open_ctree failed


Do you have an idea how to solve it. When I try to check the subvols 
with btrfs check all seems to be fine in 18.04.

Thank you in advance.
Miklos
