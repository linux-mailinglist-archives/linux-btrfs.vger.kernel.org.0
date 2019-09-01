Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA963A485C
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfIAIEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Sep 2019 04:04:04 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35480 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfIAIEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Sep 2019 04:04:04 -0400
Received: by mail-lf1-f51.google.com with SMTP id w6so2886106lfl.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Sep 2019 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDosGgKK4joTK6iWKxk/nond9/QLBPK/1+VElx1Va6w=;
        b=omM/RUQkgwBl3eRYae5EkRG3+cmFwKDKLV0RoxnFpHbH3LlpnzqnBNY8w6QJBWFMFk
         hSVevOskXX5dZ+cQZcQBBnGWfBCZqRgmOAIHcJU00aHbvFl7JPcv/MI9eP/j6PcneACj
         +CTkZrHT8n1krPUnqVICE4WYdpLpsAX1salZnq2Xxx5FbjaelILZk5R4/L0oQ9hTPEdn
         IJxNyjT4b9LqhqtFBW19Wm+n2d3H6qSiaCAykYzwONLlVlzmnzn7OjYdp1kZdc4f+o4K
         JveDT1TGy1SiYM4mkPF7cRPF/cDnMkW4Vrf899ZeE6OpCrm39B5QbaK0kgBy6HZATn3k
         Lugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WDosGgKK4joTK6iWKxk/nond9/QLBPK/1+VElx1Va6w=;
        b=T1BvGvcWOHfG0ZwrOmxgSqfbVQBbAP50mq1HlnjEgeQFjHhJZ5ixNOYwu3IJbXSPy1
         8Yhgbt+KaxPmyXgib31fDF6FIHWkYa0lhHJvAWQmIf0qw17kaWihun5gtuAJcFBPszZw
         pzvjIDkM5+JC3aYdm4FuysdvXL1lCPKrSPwTt2sCDtpibVjbGw0VujeVHighTMGiFc/L
         6ejuW5fRwJPueqP5INdkH0XE0N0H358n20pg8MFxV5QageMdzbc1fx6SKgGtXjuwRpXv
         c+dzNZduN8iJM0JHiMBDCUbdaXRI1wkDIQBIi21RLVfdCnWi+Zz1LgMO03Qys8Yc7Ul9
         NLRQ==
X-Gm-Message-State: APjAAAXlWNTRI7hqaZrxl08HimgKmfyo4x5fIzCvRi541o1TtqOaf6SK
        k4hRW+EECWrSZJgYE6KBg2usfNtX
X-Google-Smtp-Source: APXvYqwvpg3nDYaFrOUBPkAjcv7BJcA9lt9NNOPo0emJH1o1pJsHhxANS4W3OLEBg+jJiQ1eenQRMw==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr9050564lfc.28.1567325041844;
        Sun, 01 Sep 2019 01:04:01 -0700 (PDT)
Received: from [192.168.1.2] (109-252-54-49.nat.spd-mgts.ru. [109.252.54.49])
        by smtp.gmail.com with ESMTPSA id b5sm1349402lfo.33.2019.09.01.01.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 01:04:00 -0700 (PDT)
Subject: Re: Spare Volume Features
To:     Sean Greenslade <sean@seangreenslade.com>,
        linux-btrfs@vger.kernel.org
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
 <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
 <20190901032855.GA5604@coach>
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
Message-ID: <6590a3f4-891d-2b22-ed43-4d2def43f290@gmail.com>
Date:   Sun, 1 Sep 2019 11:03:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901032855.GA5604@coach>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

01.09.2019 6:28, Sean Greenslade пишет:
> 
> I decided to do a bit of experimentation to test this theory. The
> primary goal was to see if a filesystem could suffer a failed disk and
> have that disk removed and rebalanced among the remaining disks without
> the filesystem losing data or going read-only. Tested on kernel
> 5.2.5-arch1-1-ARCH, progs: v5.2.1.
> 
> I was actually quite impressed. When I ripped one of the block devices
> out from under btrfs, the kernel started spewing tons of BTRFS errors,
> but seemed to keep on trucking. I didn't leave it in this state for too
> long, but I was reading, writing, and syncing the fs without issue.
> After performing a btrfs device delete <MISSING_DEVID>, the filesystem
> rebalanced and stopped reporting errors.

How many devices did filesystem have? What profiles did original
filesystem use and what profiles were present after deleting device?
Just to be sure there was no silent downgrade from raid1 to dup or
single as example.


> Looks like this may be a viable
> strategy for high-availability filesystems assuming you have adequate
> monitoring in place to catch the disk failures quickly. I personally
> wouldn't want to fully automate the disk deletion, but it's certainly
> possible.
> 

This would be valid strategy if we could tell btrfs to reserve enough
spare space; but even this is not enough, every allocation btrfs does
must be done so that enough spare space remains to reconstruct every
other missing chunk.

Actually I now ask myself - what happens when btrfs sees unusable disk
sector(s) in some chunk? Will it automatically reconstruct content of
this chunk somewhere else? If not, what is an option besides full device
replacement?
