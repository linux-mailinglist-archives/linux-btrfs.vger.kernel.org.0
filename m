Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9BFFA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3SWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Apr 2019 14:22:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41118 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Apr 2019 14:22:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so11480670lfd.8
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Apr 2019 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SqsXprMqUoSpGsiqlsHn4DlKSPq+tO84KXMhEk+Q5rU=;
        b=gMVGMM33TRl4bhaXia9qOYmZbYo7DqEOXwNu1NxiCei+C+LlJhx6aSbQFtTFxjxu4L
         7Z/ywC4ucGa+5lXeIeFi3AmNiPG55ZI8tdyWMyha4oDLPdCjx557TZRRYgFiH0n8EaX7
         MDkkWYeuteXf3J1r6XG3n45zIzntNkbbB6Hb7wGWIkUiMVt2y/b1yICIKcp4hFNLQ+Bt
         ATJGUzMRr5Veyywh0R1jkL8AyZgvfvpDJ81r20EQty9hAcpVNaCr2jHQMTQ9as4a8S+6
         0vpUfzMsqM2Ktiw28bGQBCo7f5OkAzfcG5/Uvsv2E5HxAX8Pv3p55dQ2Jvm1dMq5CDAD
         F+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SqsXprMqUoSpGsiqlsHn4DlKSPq+tO84KXMhEk+Q5rU=;
        b=ttfBJZj7Ge2gO7UrclxVJkqMOt7k72MD3J0v2k18AeWCyYNum/lbqt8RZ3z0WWTS3q
         znoDFEhgBb71aIKiX2CUbte+lILP8fqXEIdXuCnmSv9U4BmZEsk4Ifn4ZQe541l4JFzA
         J1H0aijitydi2VzSbxIvXoIc7m5/1lw4IKdO8EzPzMazZWF+EI/ho3ZLpAHlqqYgpsgr
         NH1fmi4dXMbQXyUP+ZO1P1rBKtRfouoLejFCsJSnvE92TdimFMqnuSK5kPPE2VXNA6kB
         Ku9EePoIP27B6vn0tyMtmw0wKmI58Cs6ooPf5T5iDZo53+ODd772cU6rqbQUbZKk4f/b
         jGgg==
X-Gm-Message-State: APjAAAUPQJhhJ3hGk9E4s1BzUiYqJSncThoOuIrPUVue1LUwb87rzFtC
        YBdYtnr6RWXVLXvjadNPzApJveDYSck=
X-Google-Smtp-Source: APXvYqz19C2gG0f5bDWAkBfpLdnewLylK2A/ingJCe9sUNblADoE04Ri9qr9VfhwRrVmzjpIZun6Ew==
X-Received: by 2002:a19:7702:: with SMTP id s2mr357869lfc.102.1556648569835;
        Tue, 30 Apr 2019 11:22:49 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-193.nat.spd-mgts.ru. [109.252.90.193])
        by smtp.gmail.com with ESMTPSA id z6sm1501459ljb.56.2019.04.30.11.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:22:48 -0700 (PDT)
Subject: Re: recommended way to allow mounting of degraded array at boot
To:     Chris Murphy <lists@colorremedies.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Alberto Bursi <alberto.bursi@outlook.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM0PR03MB413128509989947DE4AA7DEF92380@AM0PR03MB4131.eurprd03.prod.outlook.com>
 <5e02c6d3-9024-10fa-51f0-629ff5e604fe@gmail.com>
 <CAA91j0UGPKgqu_TYKQdfnAxe5pfLLvkVaaUNgUZmEh10MrWJ+w@mail.gmail.com>
 <CAJCQCtS2tgsV92uqKXExwXr_wc2apVYYCQc8ahep15RKwayzfw@mail.gmail.com>
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
Message-ID: <4e756e9b-90a0-6ebb-212b-0eafd604380c@gmail.com>
Date:   Tue, 30 Apr 2019 21:22:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS2tgsV92uqKXExwXr_wc2apVYYCQc8ahep15RKwayzfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.04.2019 10:38, Chris Murphy пишет:
> On Mon, Apr 29, 2019 at 5:57 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> On Mon, Apr 29, 2019 at 2:38 PM Austin S. Hemmelgarn
>> <ahferroin7@gmail.com> wrote:
>>
>>> * If you're doing this on a system using systemd, it actually doesn't do
>>> what you are trying to do.  Systemd will refuse to mount the volume if
>>> all the constituent devices aren't present,
>>>
>>
>> It is not quite correct. systemd will not even attempt to mount
>> incomplete btrfs because it will wait for all devices (including
>> missing ones) to appear before proceeding to mount it. And if this
>> check is disabled, it will actually just call mount.btrfs, it will
>> certainly not "refuse" to do anything. So the following may work
>>
>> - disable udev rule calls "btrfs device ready"  (it actually calls
>> internal variant, but it does not matter).
>> - replace mount.btrfs with your own script that tries to mount btrfs
>> and if it fails tries to mount it degraded.
> 
> Yeah what I don't like about this udev rule is the indefinite hang. I
> don't know enough about udev, whether it can support a timeout? If the

This has nothing to do with udev. udev simply assigns properties to
device nodes and announces them to subscribers. One subscriber is
systemd which implements timeout logic.

> missing devices haven't appeared in 30 seconds, good chance they won't
> appear, and then either fail at this rule or continue on with the
> mount attempt (which then fails). But either way, the user gets to a
> prompt, and can troubleshoot the problem from there rather than being
> stuck with force poweroff being the only alternative.
> 

That is exactly what happens for non-root mount points (except default
timeout is 90 seconds). For root mounts it is really up to initramfs
implementations. dracut sets infinite timeout indeed with rather terse
commit message

commit 8ee18253644a812184c60e31d7ee3d3f6d8f45c0
Author: Harald Hoyer <harald@redhat.com>
Date:   Tue Mar 4 13:46:14 2014 +0100

    dracut: don't let devices timeout

    https://bugzilla.redhat.com/show_bug.cgi?id=949697

Current dracut provides rd.timeout to override it.

