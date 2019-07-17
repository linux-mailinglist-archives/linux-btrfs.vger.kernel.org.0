Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8346C081
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbfGQRj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 13:39:57 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:32845 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQRj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 13:39:57 -0400
Received: by mail-lj1-f169.google.com with SMTP id h10so24498695ljg.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NeNXUvtCc5I8ixRn+JTf+boCAb5RvHWXUKmcsD6VmWc=;
        b=BaE139BPMs7iHhhU9/b5ofiGZk2nmVt1mu2jd/CZVqUIr+D93HA6CBNoPFrCRjKceW
         vpGl5kZhxwhB560Yj8bm7HwBLKDUczAHbvjo7b9IstgQSP6s2NJ95DK0MxBGDmpc1Ip9
         P6sSPHG5/6QfEkRkWpFmU/oDE2PMj13TT1DsZ6jCDDfGoHeQyJg1NJfO0s0qTxgJWvAY
         1LpBSQjvZLIeR5Fh4hYseW40T8XnP/huatjEqQ1KdU7ImaV1u6gwVbojtngTa7RPzGSW
         5rTz4vM5QX8rMgSBWwTZhOQhgdV4yqanlT3WdcLost7nkNYfnt03Z3exVGUZUVAE5URx
         dNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NeNXUvtCc5I8ixRn+JTf+boCAb5RvHWXUKmcsD6VmWc=;
        b=go9WaBD8iRovk/Rfwh7Wkw+xVg+zWxFp3j4ztnSyLYXVYptnIM121huuv+67+z4SXp
         T/5ihGnSkRGBOdr6mL52DU3qADSH/dkJi2+HUgfBvOWg1UcvPbSCn6nA7+rf9OTpTlgT
         TzAFR9GRHuyMdoInkBbnTYkEzgeDJIFI1LvO36CYA+0JbTGlP0zNVmfTrxhYZpbbR+PS
         kNvgu0r6iX+uektI7k4Rk8acyGLhOYysmAPTmImxItCoPSkvQQaTrJvwlVkQP57s6fc+
         6wOoUUDc5MjmGGLlwuk84pOottkDu2xflFjQt+MO/hGlDdcnlX0zPlXSm2/V8nU9hzEy
         X2vg==
X-Gm-Message-State: APjAAAV+nYTLH2s4/3YM8q83TNOKGZzsDQM2Nqim48l4VdPhpavl4fj0
        66soJM74iwDX3a6KHl+EOMhQsHzgExw=
X-Google-Smtp-Source: APXvYqx19ww/lOLqZsAQYtNvyUM2s+gc5htTVjsfmSAI0RWgOhe7S09E9guFHSh/Bc1qaH8R9oaGhg==
X-Received: by 2002:a2e:8ed2:: with SMTP id e18mr21491152ljl.235.1563385195492;
        Wed, 17 Jul 2019 10:39:55 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id e87sm5199633ljf.54.2019.07.17.10.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 10:39:54 -0700 (PDT)
Subject: Re: how do I know a subvolume is a snapshot?
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <eff513b1-a77c-cd5f-5af7-87eae73cff6a@suse.com>
 <20190717091100.GC3462@tik.uni-stuttgart.de>
 <b2410ac6-34f9-f459-8301-c70fcbe6159e@suse.com>
 <CAA91j0U1QBruk+JPE4+FZwuKNOz+YeiQOaeM58Viu6iSCYc99g@mail.gmail.com>
 <18c3652a-ee3d-a56f-7ebf-1be92d112426@suse.com>
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
Message-ID: <8394b9da-f334-3e6c-83c2-3225ae0733b9@gmail.com>
Date:   Wed, 17 Jul 2019 20:39:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <18c3652a-ee3d-a56f-7ebf-1be92d112426@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

17.07.2019 14:19, Nikolay Borisov пишет:
> 
> This is really odd... So this indeed seems to be a userspace problem. 


Of course it is user space problem.

commit 0a0a03554aaf56a6e7245e74fa7d8b3c53f1c20f
Author: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Date:   Fri Mar 23 17:16:49 2018 +0900

    btrfs-progs: mkfs: add uuid and otime to ROOT_ITEM of, FS_TREE

    Currently, the top-level subvolume lacks the UUID. As a result, both
    non-snapshot subvolume and snapshot of top-level subvolume do not have
    Parent UUID and cannot be distinguisued. Therefore "fi show" of
    top-level lists all the subvolumes which lacks the UUID in
    "Snapshot(s)" filed.  Also, it lacks the otime information.

    Fix this by adding the UUID and otime at the mkfs time.  As a
    consequence, snapshots of top-level subvolume now have a Parent UUID and
    UUID tree will create an entry for top-level subvolume at mount time.
    This should not cause the problem for current kernel, but user program
    which relies on the empty Parent UUID may be affected by this change.


What about the question - is there tool to fix existing filesystem by
adding this information?
