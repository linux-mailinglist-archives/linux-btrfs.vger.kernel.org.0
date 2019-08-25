Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BAD9C28A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 10:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfHYIOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 04:14:17 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43682 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYIOR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 04:14:17 -0400
Received: by mail-lj1-f178.google.com with SMTP id h15so12373847ljg.10
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2019 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aETKOLk9zZQ8WiGUHKIjrlBMIsb4F9GdTE2AoIPDrfI=;
        b=Kju/9MfBlPuqgnllj9J3MfRMrWGE/Ees6tQm/u7KZ8AVrac1wtYxaq6CcQ3jC0tUcE
         ajdq0BuNRAGUTWYmS57VGci914Vgk1ou6v5qL13dHxfQb4PFa2I+pAjVts1Xz/aunwJB
         j+6BMZZM5b+KuSqM9L+KqSZV3OhM1Qh0IX5XvE1BTYpthN3i0cAIzeAaTmbcN7f+SLl8
         +J9rjH+44pPZHO/KUn2C93rPFQC0MrLSmsbaXkQ9g/qkCZ2IFtmakd+XDK23cuf0nWMP
         Xb+B7OECHWxQD5DEsz8UZnvsF9+pPo6INfzfcS+4A0QwGWwonmYcaiLZGn7NDPJ0EMyL
         S0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aETKOLk9zZQ8WiGUHKIjrlBMIsb4F9GdTE2AoIPDrfI=;
        b=OeNQby8s2Rr/N/wsWENwQj7QR9RImULDbY37BD26mH80hx8skoEvXFHmDeYZy+LbUv
         v4NMD2n2Cwfdf/LNsBRhObFsYjJ1k3G0UFSSxuEW2oU7a3a6pp12CQpj1lNNJZdOeLer
         UBY/IpRTJPWddEjfQSTlQQwitX9kQCDpN9FoWHdLAvl83Yc9+gdw7TdiMsmBe81Ssz+x
         3LzKOvIff7YWNnHep4MrSwVYEsGLfqyoNEnDvu3hDoBuJqC1L+fDLxoyRgc+NkiNTp8t
         /rbxF6Vey7T+w2rj8Zec7OSGZ8PfoFVlsfeSOLjJOuHx4lmjNgItmbw0g6grCOMEPtt1
         wMcg==
X-Gm-Message-State: APjAAAXLf+wuO43/ZpmfevK+KVKzQfc/XTZPfRFiqEeYujvAWgXW6vm0
        R9Yjmh5SC1xlQvn4/VuvkSYkMqvE
X-Google-Smtp-Source: APXvYqwa4Ghd9MOCPwpSPD7KB2ae+n/8skBr9BuBFkKAMh7s+PJ8EunNLDz8Cb0iwJ1P1GsENXE2MA==
X-Received: by 2002:a2e:8651:: with SMTP id i17mr7602928ljj.136.1566720854304;
        Sun, 25 Aug 2019 01:14:14 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-20.nat.spd-mgts.ru. [109.252.55.20])
        by smtp.gmail.com with ESMTPSA id y14sm41329lfh.64.2019.08.25.01.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 01:14:13 -0700 (PDT)
Subject: Re: shared extents, but no snapshots or reflinks
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRij3ENFW3Gam+-JThg8LhewdpHKzJSfgcR-OPnvrSL=Q@mail.gmail.com>
 <CAJCQCtQZ-BH3vHaV6canyi+HA_Q2Ny_QryKFLtddyR7YME4dzQ@mail.gmail.com>
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
Message-ID: <c5a80940-463b-ee5f-6c70-e13156c8e1ec@gmail.com>
Date:   Sun, 25 Aug 2019 11:14:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQZ-BH3vHaV6canyi+HA_Q2Ny_QryKFLtddyR7YME4dzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.08.2019 6:19, Chris Murphy пишет:
> On Thu, Aug 22, 2019 at 8:38 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> There have previously been snapshots, typically prior to doing system
>> updates. Is this an example of extents being pinned due to snapshots,
>> and then extents updated and are now "stuck"? I'm kinda surprised, in
>> that I'd expect most programs, especially RPM, are writing out new
>> files entirely, then deleting obsolete files, then renaming. But...
>> this suggests something is doing partial overwrites of file extents
>> rather than replacements.
> 
> It's databases. Databases are updating their files with block
> overwrites, btrfs COWs them. And if there's a snapshot that exists
> while COW happens, partial extents get pinned. This affects the
> firefox database files, and also RPM's. It's a small effect on my
> system, but it's a curious issue in particular if the files were much
> larger.
> 
> 

What exactly "pinned" means, why it happens and when it goes away?

Comparing situation with and without shared extents - when you simply
delete snapshot, it disappears:


-       item 12 key (257 ROOT_ITEM 7) itemoff 13188 itemsize 439
-               generation 7 root_dirid 256 bytenr 30670848 level 0 refs 1
-               lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x1(RDONLY)
-               uuid 5357e159-c577-d34b-8e0e-815767568a89
-               parent_uuid 1dfec531-ef6e-4d2e-a93b-2a4e4c0e4682
-               ctransid 6 otransid 7 stransid 0 rtransid 0
-               ctime 1566719522.371361184 (2019-08-25 10:52:02)
-               otime 1566719541.289249684 (2019-08-25 10:52:21)
-               drop key (0 UNKNOWN.0 0) level 0
-       item 13 key (257 ROOT_BACKREF 5) itemoff 13166 itemsize 22
-               root backref key dirid 258 sequence 2 name snap


but when there was shared extent (caused by partial overwrite) it is stuck:

-       item 12 key (257 ROOT_ITEM 7) itemoff 13188 itemsize 439
-               generation 7 root_dirid 256 bytenr 30670848 level 0 refs 1
-               lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x1(RDONLY)
+       item 11 key (257 ROOT_ITEM 7) itemoff 13210 itemsize 439
+               generation 7 root_dirid 256 bytenr 30670848 level 0 refs 0
+               lastsnap 7 byte_limit 0 bytes_used 16384 flags
0x1000000000001(RDONLY)


Now the undecoded flag is

/*
 * Internal in-memory flag that a subvolume has been marked for deletion but
 * still visible as a directory
 */
#define BTRFS_ROOT_SUBVOL_DEAD          (1ULL << 48)

but it does not agree with comment - this flag is not "in memory", it is
persistent (output above is from inspect-internal after filesystem is
unmounted).

So when this dead subvolume is going to be removed? This can cause quite
real memory leak if it is stuck as long as original extent reference
remains.
