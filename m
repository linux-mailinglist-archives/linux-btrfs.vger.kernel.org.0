Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9F18DE2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 06:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCUFkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Mar 2020 01:40:55 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34698 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCUFky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 01:40:54 -0400
Received: by mail-lf1-f45.google.com with SMTP id i1so5490610lfo.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 22:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/BWYav3tVjustkq9d3DEhnzRYo92RlCeY2F9zrABggA=;
        b=UkO+GeN7ZB5guE4uD9nrAUkvKrfySUUVDhGRai/II9AOKp2nZ0E8gs4r9RURwkWPOU
         fjFPjBjore63ix2nKPvBPVbmt4s9zXF4SPWcYe5RhnADNlVBKeFWgU0UuIsr0KvOisg0
         Wog2l7rcUSy5YXmTmL7aL3vot3vhCdnfbw85nfGXNk6npcTZ5WrCAnEt1D+U5poblx8D
         UlFR/YCzFqmdHXyz8yZpuLQtX0rSzWd0fjrEibKS9d4U3oew0dU1dBgMCEgArB3KSKoM
         /MIyUckyNi4PdDbtzZZ4H1yuODfbiN/uU263RGRNCnjuzgEtWJnjxA4u9WHDB5onV/6X
         yz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/BWYav3tVjustkq9d3DEhnzRYo92RlCeY2F9zrABggA=;
        b=oo+XfrCejB8+uhjsT5PjbA3GUZdXQk5yR4ojc98JkEYL2S2ldmuZWavduTBfzJPLig
         lGFHoPQPT5KaOHHJ3BIan9BQ5qgzJsP6MbCpTcy43i/GRRlXxGJj+Bn82zWX0Uups9om
         M2RLN0a0fhUwU6DhtRr5FWnTFr7NvuFIh0HkDCxgiAPz1cHLV+Q42kbT0B2NOeSCzSsY
         dA6kMO9CV0J9dmutiFxZ2zDxLTyUaBuIMfDgYP4Llap0mfRGo225+y15jFClPjhp8mXp
         CkABnXnCXu1iM3Mp1ifqhSYjUJ93yiFxkN39CZie4f7vlGPVrimVLHxc4RsqgRicBMFO
         Cofg==
X-Gm-Message-State: ANhLgQ3gfiKgd59H41SuW+zialayEZ7uw/0XgHmxL1hoKSkZbYPCU/RJ
        xrdxWMmBOgJfdOAgAPO+oX1HeKC/
X-Google-Smtp-Source: ADFU+vumOxq56FVNjO91R6/UfC3jF+wnbMCBBVO8Tw6s/4VqTxvhCW7wrrolMPqAcuKdWGHxo9ivoQ==
X-Received: by 2002:a19:84c7:: with SMTP id g190mr236910lfd.204.1584769252653;
        Fri, 20 Mar 2020 22:40:52 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:e281:7ca7:8ec9:2456:f2b7? ([2a00:1370:812d:e281:7ca7:8ec9:2456:f2b7])
        by smtp.gmail.com with ESMTPSA id x16sm4539243lji.37.2020.03.20.22.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 22:40:51 -0700 (PDT)
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
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
Message-ID: <bd70e1fc-5e5b-672b-cc7c-0cd9b8b31e4a@gmail.com>
Date:   Sat, 21 Mar 2020 08:40:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200321032911.GR13306@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

21.03.2020 06:29, Zygo Blaxell пишет:
> On Fri, Mar 20, 2020 at 06:56:38PM +0100, Goffredo Baroncelli wrote:
>> Hi all,
>>
>> for a btrfs filesystem, how an user can understand which is the {data,mmetadata,system} [raid] profile in use ? E.g. the next chunk which profile will have ?
> 
> It's the profile used by the highest-numbered block group for the
> allocation type (one for data, one for metadata/system).

Is "highest-numbered" block group always the last one created? Can block
group numbers wrap around?

Recently someone reported that after conversion block groups with old
profile remained and this probably explains it - conversion races with
new allocation.

>> So the question is: the next chunk which profile will have ?
>> Is there any way to understand what will happens ?

Well, from that explanation it is not possible using standard tools -
one needs to crawl btrfs internals to find out the "last" block group.
