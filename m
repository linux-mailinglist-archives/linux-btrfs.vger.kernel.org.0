Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166E66143E
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2019 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfGGHhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jul 2019 03:37:55 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:44053 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGGHhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Jul 2019 03:37:54 -0400
Received: by mail-lj1-f180.google.com with SMTP id k18so12875247ljc.11
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jul 2019 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YPBJ8K1QU84gWTOfhSufYs1Vf+1VUmMcDsGlikOSYdE=;
        b=EcRG+ZmGAmZklF8E3Lh+Mw3dZzZGFWDaGlozcf0NHjG+F1W0CV8AKid/VYsl9lU8Ip
         IwAFtM4Z0K6vF97DZL30p6Sq4RO+kaonvCwsrFdTsvScCzGHffdNIHtxL685s0BYVTUE
         1bU15hbGO3vZTDA/xTKtlnm3Q+9aC1eYvuWzGs7C9Zbj9A0Q4fL4hfwuhE5j9VXGaKTc
         WYClJlNFdzzvPoMVJdNV/EuOahbcLJQsoUZq4MQQyw1/8NvRLdIBpSk9FvnfpVLwefqf
         L29EAQgcujjA3bIS96BmcVyuH1xKG1SjJ0Vx0cDIEtAF/sUw7z4xLPba4yANxCzz2+WN
         WlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YPBJ8K1QU84gWTOfhSufYs1Vf+1VUmMcDsGlikOSYdE=;
        b=cwbBjIgvsQb6QSYrvseJxk1rf/2kN//8XeMkWeNNTL6CBFBvhv+cHq1TN9sTGJQWbS
         rho1G1YNnynRQqIoQPwlEGowNku3TcOm/q3mBEb4tf1acCUKXnQUShCuSsgIL+2nYKMr
         MmhsRLZK5rVr9uniuptOv5SAWR/ipV+oaUu0E9VKYNxpVStwhjlIjRUZlB1K+3dlsI7U
         4FhHqEtv4UJqYI4p9/vsWq5C4zDJQINjYQ2qqiSKYXnTQlKAIl7BoJvP9w8G72uTOnUc
         PbdjB/YBdx8IN/gPh+o0V7HlWOcyFZ5nJX1zMIsh541jvHYJQDfhbc4LBhn5KHFXCqSd
         eHQQ==
X-Gm-Message-State: APjAAAWP2CqohScHmGDur+j1K/xe/j2ImOad4oXA/q/IGhDkUTjpsTOB
        90d0KQ3/uX/l2uOvgur3bK22QaHa
X-Google-Smtp-Source: APXvYqzNDDNLUV+/8+z1N+dQjwVhoAVbzWMuXXULEXe9EagQpC21AzTh52DTzoAyeDzuywNeH1liZQ==
X-Received: by 2002:a2e:834e:: with SMTP id l14mr4781156ljh.158.1562485072422;
        Sun, 07 Jul 2019 00:37:52 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-59.nat.spd-mgts.ru. [109.252.55.59])
        by smtp.gmail.com with ESMTPSA id y15sm2183669lfg.43.2019.07.07.00.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 00:37:50 -0700 (PDT)
Subject: Re: find snapshot parent?
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
 <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
 <20190706204339.GB13656@tik.uni-stuttgart.de>
 <774d3e3d-bf1a-a3a1-b21c-45a3a353e5bc@suse.com>
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
Message-ID: <ffa57dd3-51c8-66f8-a53e-be28df79e0d3@gmail.com>
Date:   Sun, 7 Jul 2019 10:37:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <774d3e3d-bf1a-a3a1-b21c-45a3a353e5bc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

07.07.2019 9:43, Nikolay Borisov пишет:
> 
> 
> On 6.07.19 г. 23:43 ч., Ulli Horlacher wrote:
>> On Sat 2019-07-06 (19:57), Nikolay Borisov wrote:
>>
>>>> And how can I see whether /test/tmp/xx/ss1 is a snapshot at all?
>>>> Do all snapshots have a "Parent UUID" and regular subvolumes not?
>>>
>>> Indeed, only snapshots have a Parent UUID.
>>
>> Not all:
>>
>> root@xerus:/test# btrfs subvolume snapshot -r /test /test/ss1
>> Create a readonly snapshot of '/test' in '/test/ss1'
>>
>> root@xerus:/test# btrfs subvolume show /test/ss1
>> /test/ss1
>>         Name:                   ss1
>>         UUID:                   02bd07bc-0bab-3442-96be-40790e1ba9be
>>         Parent UUID:            -
>>         Received UUID:          -
>>         Creation time:          2019-07-06 22:37:37 +0200
>>         Subvolume ID:           1036
>>         Generation:             9824
>>         Gen at creation:        9824
>>         Parent ID:              5
>>         Top level ID:           5
>>         Flags:                  readonly
>>         Snapshot(s):
>>
>> root@xerus:/test# btrfs subvolume show /test
>> /test is toplevel subvolume
> 
> This is really odd, looking at create_pending_snapshot the codes : 
> 
> memcpy(new_root_item->parent_uuid, root->root_item.uuid,                                      
>                         BTRFS_UUID_SIZE);  
> 
> And that's not conditional on whether the snapshot is read only or not. 
> So everytime we creata a snapshot it ought to be receiving the parent's 
> subvolume UUID in its parent_uuid field.

Does top level subvolume of btrfs have subvolume UUID at all? How can
one display it? None of "btrfs subvolume" commands show it.

> And indeed testing with latest misc-next kernel: 
> 
> root@ubuntu-virtual:~# btrfs subvol create /media/scratch/subvol10 
> Create subvolume '/media/scratch/subvol10'
> 
> root@ubuntu-virtual:~# btrfs subvol snapshot /media/scratch/subvol10/ /media/scratch/snap-subvol10
> Create a snapshot of '/media/scratch/subvol10/' in '/media/scratch/snap-subvol10'
> 

/media/scratch/subvol10 is not top level subvolume.
