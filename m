Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921C72E7E85
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 08:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLaHGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 02:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgLaHGE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 02:06:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC576C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 23:05:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b26so42402484lff.9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 23:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4fpSilCE56xzD2k2hG4qxJAE0Ew8IVEO9lQrCJJuQr0=;
        b=LMqfKKnFqeJH55LpOIuImslaHxKmWCNd32JuTQZonQ6GqoHXcqKkvEBGBC0pU9Bq20
         XzLabR+3XwS2a1RiQOIGF+mkvPCQdxdik7QwKvOystD+517NwOjw15NpkRZVYRGonb4Y
         FCiVtBXurbla6NeLZV/wDhEGF3Z/4IEyTKo9w/QnW1tZutmf8A4qsnJ0xcOKbMTlwuY8
         571+3IcCCuOLh8njuh85bL6+EkTmVdnx80BXcN0BANR6XyF/lDBZIdMxTr8ufdsqP2OR
         m3WvMxqHtDjvUhx6YIm0P2W8uRB3OaZ9tZFspor3DxKHLCauAye/Dizq77ny1k67JeOc
         JiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4fpSilCE56xzD2k2hG4qxJAE0Ew8IVEO9lQrCJJuQr0=;
        b=IvUiAe/1rE8CPkysCV/ahKfZQPJlkbSPgK/DLaYTxDcWTRS+Q/TrR83ZQ2lIL8ACQ6
         f/RZhVvQDTMRNbuGPiugAF5ScYjMkcChZMmsPlBORD1qVFzsE7jmbsUzmZd4Vflx9SlI
         HayIXr/4wixpM/F0P1buVArTKwxJoFxY1Zot/OtctV/m+k5UB/cD+jbq5FJXlbS+MFSL
         x7YGKxR2k8DsRmC4jvCewJuyUr4W/oWRNoFVUFRLt7jESp3x0ikOwPF3AxAcIiHynlBg
         TCVwNen6OOlJI3RHwqGca8Pj4v8JeiswvLN7mT+rPtzo8m8Z4X/bq43ZTj91IX3KkbOE
         +E/g==
X-Gm-Message-State: AOAM531DPoOufiZkxIx7qzlZbGgp1zK8lkpFQLNlGPDS0nWe5Va6HEyf
        adobTpBYW9NGfhDZAm2CkO04F5sVdVVDyg==
X-Google-Smtp-Source: ABdhPJxHdIptcYJ+SYul0Fjz0hyJHWNmlvG1Oe4w+G2vDbjkCEnE9ELhtwDLv+ApLXyf/09tnk+nLw==
X-Received: by 2002:a19:c6c2:: with SMTP id w185mr23537833lff.354.1609398322301;
        Wed, 30 Dec 2020 23:05:22 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id v5sm7506786ljj.135.2020.12.30.23.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 23:05:21 -0800 (PST)
Subject: Re: hierarchical, tree-like structure of snapshots
To:     john terragon <jterragon@gmail.com>, sys <system@lechevalier.se>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
 <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
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
Message-ID: <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
Date:   Thu, 31 Dec 2020 10:05:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.12.2020 20:39, john terragon пишет:
> On Wed, Dec 30, 2020 at 6:24 PM sys <system@lechevalier.se> wrote:
>>
>>
>>
> [...]
>> You should simply make a 'read-write' snapshot (Y-rw) of the 'read-only'
>> snapshot (Y) that is part of your backup/send scheme. Do not modify
>> read-only snapshots to be rw.
>>
> 
> OK, but then could I use Y as parent of the rw snapshot, let's call it
> W, in a send?

No

> So I would have this tree where Y is still the root.
> 
> Y-W
>  \
>   Z-X
> 
> Can I do a send -p Y W ?

No. All subvolumes used in send/receive must be read-only. And they must
remain read-only from the moment they are created - we have seen quite a
lot of reports when users removed read-only property from subvolume used
in the past as send source, modified it, set as read-only again and
tried to continue replication. This resulted in complete mess on receive
side. Also if you try to modify destination snapshots it will break at
some point.

The general rule - everything used for replication must remain
read-only. If you want to use any snapshot that is part of replication
you clone it and use its clone.

> Because I thought it was other way around, that is I do a readonly
> snapshot W of Y and that will be the base for incrementally sending
> the future modified Y to another  FS (provided of course W is already
> there).
> 

If you want to capture changes in W since it was cloned from Y you
create another read-only snapshot of W and use it.

btrfs subvolume snapshot -r W V
btrfs send -p Y V

It is possible that btrfs implementation is optimized for sequential
snapshots from the same subvolume so the send stream size will be
larger. I am not familiar with these low level details. From the naïve
end-user point of view there should be no difference between

btrfs subvolume snapshot -r W R1
btrfs send R1
modify W
btrfs subvolume snapshot -r W R2
btrfs send -p R1 R2

and

btrfs send R1
btrfs subvolume snapshot R1 W
modify W
btrfs subvolume snapshot -r W R2
btrfs send -p R1 R2
