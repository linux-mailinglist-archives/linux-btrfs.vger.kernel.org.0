Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D81230CC2D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 20:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhBBTqH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 14:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbhBBTph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 14:45:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC2C061351
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Feb 2021 11:44:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i187so29701947lfd.4
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Feb 2021 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXX3Sc4UdMTsOVQNNphDoVg0KoBTFvLdc/t+ymRygbc=;
        b=YtqD7qFjEBlG96KvaEMcKDILXFmjiLVs8SKcjMyqoTUtnyHlBqQ9Trqhr4ix5IKDH6
         UgBe5lPbUk+GHJx6df0Rx+AHMdM2CtXU3l5vD2f84/Bj+mdCo1fgWKe1OQeCL6YF7lp9
         6trAZNz7X8fqDDcXUtBDg4ukzlkIajPBL/JPBdjeJYY91yi+x++Ml5+pUPyo79elbiaH
         8mUbnPnAjnWza3EshvLfDG/qjXsquODgCMF7gGaBwjyTL66O6nvAB89W9ffgD0xehT+c
         x7QhWLwc7d3JqcgWjzNWzypV+H7L73iWe6s23bwY2TsUUrN06J2FrhGtWgOLVk7TEFn0
         b7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXX3Sc4UdMTsOVQNNphDoVg0KoBTFvLdc/t+ymRygbc=;
        b=fJZTpSa2VQPjAoLRj9B2DTJSZiZZX9eQGGY7b/IdHdYNQF+GO/9n34f1cAGTEqUW2S
         FDMsYQFdjzTBc4f62nPInPnJ/3shUHsisR3OsR0+Q2C9JmUgQ+7MdLlbBVaUyWD062ly
         bCtOkNUUtBAhSd8XMQFkDfh01Cu+sywNJRodJvTekT5aSfCKjX1dFlpgro/0HvGjOCPM
         7BkOqdnRK3hwtGxgQElp59cWZNNx7dPr9jHIY+c85ypAGLLvRU02zpadyZXUwuiYEe28
         6IuZcVgOmckFSceQSOXsfhHtbRcnUdW+dlfMtfoYrDsHwoQD3xdD3meVv12WR1N4P1Pt
         NQ5g==
X-Gm-Message-State: AOAM533vY9s/xctYb3ivC4+QlKYZQLTub0GTAbsBrFP/0K2mAUue7+Bj
        PktmjNIfQ9mmSZEVhzLCaNOqjBhVcdI=
X-Google-Smtp-Source: ABdhPJx/EOGuA284rp00t+jPahU/TRibif1GScCqfezv+o8+sY9/iSiUWT4Vn9gB30doWZNWSMaxMg==
X-Received: by 2002:a19:c20b:: with SMTP id l11mr12191506lfc.261.1612295067397;
        Tue, 02 Feb 2021 11:44:27 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:52ff:d394:f21a:e2e7:51d3? ([2a00:1370:812d:52ff:d394:f21a:e2e7:51d3])
        by smtp.gmail.com with ESMTPSA id v21sm4445676ljk.122.2021.02.02.11.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 11:44:26 -0800 (PST)
Subject: Re: is back and forth incremental send/receive supported/stable?
To:     Hugo Mills <hugo@carfax.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
 <20210129192058.GN4090@savella.carfax.org.uk>
 <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
 <20210201104609.GO4090@savella.carfax.org.uk>
 <d73ee44738fc69df8aa3f9a5d3c04c5a88e2731a.camel@scientia.net>
 <20210202075334.GP4090@savella.carfax.org.uk>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <40f7d870-8d51-1b74-0f80-949272daa6b2@gmail.com>
Date:   Tue, 2 Feb 2021 22:44:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202075334.GP4090@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

02.02.2021 10:53, Hugo Mills пишет:
> On Mon, Feb 01, 2021 at 11:51:06PM +0100, Christoph Anton Mitterer wrote:
>> On Mon, 2021-02-01 at 10:46 +0000, Hugo Mills wrote:
>>>    It'll fail *obviously*. I'm not sure how graceful it is. :)
>>
>> Okay that doesn't sound like it was very trustworthy... :-/
>>
>> Especially this from the manpage:
>>        You must not specify clone sources unless you guarantee that these
>>        snapshots are exactly in the same state on both sides—both for the
>>        sender and the receiver.
>>
>> I mean what should the user ever be able to guarantee... respectively
>> what's meant with above?
>>
>> If the tools or any option combination thereof would allow one to
>> create corrupted send/received shapthots, then there's not much a user
>> can do.
>> If this sentence just means that the user mustn't have manually hacked
>> some UUIDs or so... well then I guess that's anyway clear and the
>> sentence is just confusing.
> 
>    It means that (a) the snapshots should exist, and (b) you shouldn't
> use the tools to make any of them read-write, make modifications, and
> make them read-only again. (and (c), as you say, don't modify the
> UUIDs).
> 

There was patch that cleared received_uuid if snapshot was made
read-write. Not sure what happened to it.
