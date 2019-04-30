Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E622AEF2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 05:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfD3D1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 23:27:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37143 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbfD3D1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 23:27:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id h126so9661717lfh.4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6IJb+AmRMIyBP/FTV9wgDbOUIfWEZEAkqH0LEaJcg4=;
        b=jAl8ZH/vYdHhEzIcWFtGwNVE1dspYe7cVlzMKS1EqnzayTMLJDAnwBhFAexMvrx2BR
         Afk/cnDCHGgoVZHPAmt3BMPWbhCOvZy9UEuKKzMlrowJ6NuResDoVdidnPJgLoPTebM2
         n+rtDpHN/PUf+y0MTGuBeicIDZ5mY92uuVyUhcBTzMStx45FGSabnItFbVzqbB4OpZLh
         DkmMAo8a2T+GE/QBFPtMwH9zUH6FXvxUdDzx32dIvVOqGwmo9KZBhJYB2W9JT9yHIB2S
         o21emDgSjZtZgEQ7xcPdiTv7PwII7VvaSpS6+PNyWV4h6AqaNenS1q8pjqvmWKIcnQr3
         ehIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P6IJb+AmRMIyBP/FTV9wgDbOUIfWEZEAkqH0LEaJcg4=;
        b=bo6DxBNMB1dQ70dmXAbe8Ak5CHaipxSXrRgJmrknLhLda+4KxMZsorpL5mp9cVOSUx
         c1X/j767XdlcAFA5yBz10R44dHOX6D2qYKjRFGOTLiM17NPGI1expzf6z4+ra2G4d+ct
         aeouM36/RBFl+jdJgbz/I8W0KIrPVddGIfxiFj9DxP900JETejVfVT49ljHXbH3ocgXv
         1LEGCcmH5XKsdyhzj4oPnt3x19balMDW3bketilkosWnnVHlmRD1avOfOJyztsYJigDM
         gCM62/iarwlRPWQ5poxJ+21H5F1KRXpoiO4+lepluXQUNZMB+Ou/+1WwzeMXrIN/HQMW
         J6eg==
X-Gm-Message-State: APjAAAW9ON5Y3pdfJWQyWy5O3W4udI1TTiZKslLN8c9g/AmeP3CdFPHU
        kKxS081Wb/hxAMPmlz6Cq6y/tHYrkP4=
X-Google-Smtp-Source: APXvYqyb5rqk7aCBxlhyQv3yMpKFMCofqpLlq8Vdit5N35/3uB+/wYGgE6OcmyeRfjsSElsfabo7GA==
X-Received: by 2002:a19:ed04:: with SMTP id y4mr8982436lfy.165.1556594834683;
        Mon, 29 Apr 2019 20:27:14 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-193.nat.spd-mgts.ru. [109.252.90.193])
        by smtp.gmail.com with ESMTPSA id c24sm558941ljj.46.2019.04.29.20.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 20:27:12 -0700 (PDT)
Subject: Re: Migration to BTRFS
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Hendrik Friedel <hendrik@friedels.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <emb78b630a-c045-4f12-8945-66a237852402@ryzen>
 <0f1a1f40-c951-05dc-f9fd-d6de5884f782@gmail.com>
 <e27cc7ee-4256-0ccc-a9f1-79cd6898e927@gmail.com>
 <em12ddda3f-4221-4678-aa1c-0854489007e1@ryzen>
 <595b60f2-2a93-2078-93f2-e5952aac1fa3@gmail.com>
 <831d651a-5aa3-e98c-8520-05dd5f55e26d@gmail.com>
 <0e500a74-496c-b6c9-6282-9a73e67c7a5c@gmail.com>
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
Message-ID: <1e5afb75-1917-ae21-1c5f-dc84672098f5@gmail.com>
Date:   Tue, 30 Apr 2019 06:27:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0e500a74-496c-b6c9-6282-9a73e67c7a5c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

29.04.2019 21:25, Austin S. Hemmelgarn пишет:
> On 2019-04-29 13:31, Andrei Borzenkov wrote:
>> 29.04.2019 20:20, Austin S. Hemmelgarn пишет:
>>>
>>>>>> As of today there is no provision for automatic mounting of
>>>>>> incomplete
>>>>>> multi-device btrfs in degraded mode. Actually, with systemd it is
>>>>>> flat
>>>>>> impossible to mount incomplete btrfs because standard framework only
>>>>>> proceeds to mount it after all devices have been seen.
>>>> Do you talk about the mount during boot or about mounting in general?
>>> Both,
>>
>> Sorry for chiming in, but the quoted part was mine, and I was speaking
>> about automatic mount during boot. Manual mount using "mount" command
>> after boot is of course possible (and does not involve systemd in any
>> way). There is systemd-mount tool which will likely have the same issue.
>>
> Based on my own experience, it still has issues in some cases, even if
> mounted manually.  In the past, I've had systemd _unmount_ degraded
> BTRFS volumes I had just manually mounted because it thought they
> shouldn't be mounted (because devices were missing, therefore the device
> ready ioctl was returning false).  Only ever seems to happen for volumes
> in `/etc/fstab` or managed as native mount units, but still an issue.
> 

Ah, OK, that's true and has been plaguing systemd users for quite some
time. It should be fixed in current systemd which hopefully no more
decides to unmount filesystem even when it believes underlying device is
not present. Here is initial commit:

commit 628c89cc68ab96fce2de7ebba5933725d147aecc
Author: Lennart Poettering <lennart@poettering.net>
Date:   Fri Feb 27 21:55:08 2015 +0100

    core: rework device state logic

    This change introduces a new state "tentative" for device units. Device
    units are considered "plugged" when udev announced them, "dead" when
    they are not available in the kernel, and "tentative" when they are
    referenced in /proc/self/mountinfo or /proc/swaps but not (yet)
    announced via udev.

    This should fix a race when device nodes (like loop devices) are created
    and immediately mounted. Previously, systemd might end up seeing the
    mount unit before the device, and would thus pull down the mount because
    its BindTo dependency on the device would not be fulfilled.

