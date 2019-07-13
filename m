Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9A679E2
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGMLKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 07:10:55 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:37514 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 07:10:54 -0400
Received: by mail-lf1-f52.google.com with SMTP id c9so8084943lfh.4
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJZy/FwstH4LD3hAIh1o7zKr2TebA21ef84URdeVbcA=;
        b=CWAxYsNTW1MNagZ7aQ6WmPZy8jeYx0iGMoSyY6EXdImLqZH0k34cXiNqzBAi0SqxYA
         phEPyUst0PZZ6uQWjopl1WQrwBEwQcKREDjzd2MGolA1XL8h3cCgV0dAaE6QvRPMTxb6
         UognLdcAz7t3K9O1t2IFXtpKslx4TuAIeGhY5sRaGVTlYyv3sSbQgPRws5su2UMzs7wA
         XYjio1f/59Y2sWKKGNs40Yft6HmqgINjj+OTwiWOKH+TfJaXppsWA8+CeOlMUi9UBjGq
         C8JHPcyIPWmhHj6atVpcIPek+Co8CURc+EtLJm4+7jY2DTnSc1XFcYjG6vPWc0+bnId4
         i5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iJZy/FwstH4LD3hAIh1o7zKr2TebA21ef84URdeVbcA=;
        b=UgR93YBXfXPALLO1oFVC5IT8pIWGDRBBANrPMAll1tOznpvfEteXQQVFYdNELnyew3
         wVS6GLurg9BhD+XasGksNW9i4pDXop/CocdtnUtorqbEYr4nncur+hPxe6q0irOlqO05
         21J/HIqk5Ic7z6LssxYV1BR835ghSZJoibnawf7eVYTit27nwpCEhVbNfjd3Th2F9ujA
         i9cxYW7sWfL/2vZMCDgy8NW5ZrAZczLxgqVa9IUMu9vNckFWkoT8dX6Z90uj6qmoauTF
         21yWjM1W/Wndof6pqQ6sbbWIE1rh/wxMfU4q2pBhzVU19n9jYKIHHXyt96ELZaJCCYjd
         r+mg==
X-Gm-Message-State: APjAAAU9sOq+DF6/lJtykW1fHAiqwkKvpFzj6xmysMXPhLW1OprWjQrB
        1p5XJ8Yen4k8aE8EQk8INBurzvbj1Cs=
X-Google-Smtp-Source: APXvYqwGsgtUcq4yU4ZlN7ldYEGODvnGQiknpdnnDm5t/y77r0d1II3NrCnkpWhTV67yKfY1KypmXA==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr6986700lft.79.1563016252711;
        Sat, 13 Jul 2019 04:10:52 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id u27sm1474986lfn.87.2019.07.13.04.10.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 04:10:51 -0700 (PDT)
Subject: Re: find subvolume directories
To:     linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
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
Message-ID: <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
Date:   Sat, 13 Jul 2019 14:10:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713082759.GB16856@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

13.07.2019 11:27, Ulli Horlacher пишет:
> On Sat 2019-07-13 (06:59), Andrei Borzenkov wrote:
>> 13.07.2019 2:17, Ulli Horlacher ?8H5B:
>>
>>> I need to find (all) subvolume directories.
> 
>> That is just coincidence because @/.snapshot subvolume is mounted on
>> /.snapshot. It could also be mounted under /var/lib/snapper (insert your
>> path here).
> 
> Yes, this is the problem for me!
> 
> 
>>> But what if a btrfs filesystem does not have a toplevel /@/ directory, but
>>> anything else, like /this/is/my/top/directory ?
>>>
>>
>> btrfs does not have "top level directory" beyond single /.
> 
> I used the wrong naming.
> I have meant "top level directory beyond /"
> 
> 
>> It is entirely up to the user who creates it how subvolumes are named and
>> structured. You can well have /foo, /bar, /baz mounted as /, /var and
>> /home.
> 
> And how can I find them in my mounted filesystem?
> THIS is my problem.

I am not sure what problem you are trying to solve, but you can use list
of current mounts to build path to each subvolume (as long as it is
either below one of mounted subvolumes or explicitly mounted).

> As I wrote: "find / -inum 256" is too slow.
> 
> 

