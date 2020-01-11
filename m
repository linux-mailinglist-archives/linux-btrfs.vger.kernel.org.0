Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4F137C34
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 08:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgAKHm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 02:42:58 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36839 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgAKHm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 02:42:57 -0500
Received: by mail-lf1-f51.google.com with SMTP id n12so3214260lfe.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 23:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eOUJcQpN9hHFQ4SRYTGrdC++BB/djopfW6ChrJELniA=;
        b=acmcq09pyR4XTF2VpqHwTBy2sseR4+1ncl7dDprtxdgIkrRKQwtwFDwJvlaMDvnbHb
         hGO94SJQxSmsu45wL8mUr1bfkjGemRAnZjAguLV21XkeddNpDM48ba+oGImgm6zTvh9l
         r2ksYjnICmaqX46RoyX+GL+h/t5jjpwdxgnMwN/Lil3aEdg+9x/O4ZqPOkO5Wu9KJuUx
         zrRpLW//VvLQ/BWH0uDVYvAOWElT5yjo0CIviHyQPg+5vuLt1LEo0cn2gH4c5ozdeVlM
         IrI7/ag7LrFIb2RVn+gizhbcsyfrb7anUweo9yXtkVLoBv8aMHwchXyMBt88Btbzb0xw
         TCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eOUJcQpN9hHFQ4SRYTGrdC++BB/djopfW6ChrJELniA=;
        b=J9+iU5H6mIzGu34Yg6/KUAJJHxIQaIlWoRxJ2dDxsmXmyFTMHYLjoYuLLAiHjwvlAx
         nPN5jtxSG6mGzH09uSWKwp8ae5eHKxwc+4yt5PEPx5RhfDtP25Ild0vq3evNCfQXtwxf
         sv7S5QQwXf+K3Ua3jEWNCwCJrlu9lkKKDDWDYPDMZ54bdylX7Ph26BaBvmV2e10KhcOJ
         lG/fDmYsiBdzVHJHWqHJ83Y04Q1nOQLANwY6lGt0my1BUSCWGYmBLLcaUzjv1g1RDOZJ
         yppJWQZ3yb162x7+53JkmF5jN8SsECKSGuHhn7v1r4ocV9V37RuKr6rEFEgIccSQo9Yc
         Jn4w==
X-Gm-Message-State: APjAAAVyfriZLrkA3JKuwvKwc5p9el/+9ha0AN461SIUgQmOW1x4o/xq
        /bInA71dLRpR55h0GDslTtj2HGambzg=
X-Google-Smtp-Source: APXvYqzEZ5yD+9zw7V4pokRzE71w290Rm5E6ZlSQ+UYw9d041iBhmypS7YIRzx8tVX/km1M3CHKzog==
X-Received: by 2002:a19:dc1e:: with SMTP id t30mr4778734lfg.34.1578728575427;
        Fri, 10 Jan 2020 23:42:55 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:af15:a51e:b905:dd2b:45cf? ([2a00:1370:812d:af15:a51e:b905:dd2b:45cf])
        by smtp.gmail.com with ESMTPSA id k5sm2236692lfd.86.2020.01.10.23.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 23:42:54 -0800 (PST)
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
To:     Philip Seeger <philip@philip-seeger.de>,
        linux-btrfs@vger.kernel.org
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
 <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
 <2a9bf923-e7b9-9d82-5f1d-bbdfc192978e@suse.com>
 <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
 <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
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
Message-ID: <9b6d7519-cffb-2cfa-5e77-b514817b5f0a@gmail.com>
Date:   Sat, 11 Jan 2020 10:42:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

10.01.2020 02:50, Philip Seeger пишет:
>> On 2020-01-09 13:04, Nikolay Borisov wrote:
>>> It seems there are other error codes which are
>>> also ignored but can signify errors e.g. STS_NEXUS/STS_TRANSPORT.
> 
> Speaking of other errors also being ignored.
> 
> I just saw this on a different system:
> 
> BTRFS warning (device sdd1): csum failed root 5 ino 263 off 5869793280
> csum 0xeee8ab75 expected csum 0x1fc62249 mirror 1
> 
> Is BTRFS trying to tell me that the file with inode number 263 is
> corrupt (checksum mismatch)?
> I did indeed read (copy) that file earlier so it sounds like BTRFS
> calculated its checksum to verify it and it didn't match the stored
> checksum.
> 

On one mirror piece. It likely got correct data from another piece.

> The error counters returned by "dev stats" all stayed at 0 (even after
> scrubbing). This is (was) a single filesystem, no RAID.
> 

This is not device-level error. btrfs got data from block device without
error. That content of data was wrong does not necessarily mean block
device problem.

> Suppose this was an important file, should I be worried now?
> 

You have mirror and btrfs got correct data from another device
(otherwise you were not able to read file at all). Of course you should
be worried why one copy of data was not correct.

> If this was a checksum error, why does the stats command keep saying
> that zero errors have been detected?

Again - there was no error *reading* data from block device. Is
corruption_errs also zero?
