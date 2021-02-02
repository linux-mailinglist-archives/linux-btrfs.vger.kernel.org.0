Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24330CC16
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 20:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBBToC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 14:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbhBBTnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 14:43:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB46C0613ED
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Feb 2021 11:42:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b2so29744570lfq.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Feb 2021 11:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p3Xr610RDv8QV8Dg7yv8HYS7O7Vmeyoz7TqmRLgXZtg=;
        b=V7McgZuysTZi6z0yo5rkMOn0etpZkIbV2H8R3DbQeHgs2ye7OqI9x98uOjqfb8SBC0
         r8G18++6GlvYgYgAoOltOQxefSEr3GBLHMOaBJlsywXuNX8EGspCCjPKsxJvkJ4nZ/XQ
         lqjAsFYYQsYgXFvt0dXEZQDQUL6CGYphx7ZTC4HLgYRImpaDZwGYpmvMWCJBltjRUntr
         XCBHKFHcmO3OWhZ3+EEH15Mho22Sn/72hnTuy/q2IveOQLdZanFhWMIjeEEg6W/beLq7
         lq1sbNRMhS6qN17P6RLxbCqIsKRNEF5ZFzB4Qgkle0OvwNZHrEY9iYJ9hGeaiIOlgKq6
         coGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p3Xr610RDv8QV8Dg7yv8HYS7O7Vmeyoz7TqmRLgXZtg=;
        b=g5qKVHlL/nbPr2fDQACNu8UZyu0MvyXw2UFG7v/LkzzlSkOFf/b/ZGoL5Eun01czHB
         AbOkgp9F0I4L/zZ+zyplwddoCm1EYT6/UXnRVhLBrYrCzWVWalac0bVFBn9SpMgwfNiF
         UI/BznwCoXvsgK96Z4QVnHw+3qD2iU98rGKYCcOXdK9SQ/c/oV/0d+yPwuetVpftA3ly
         xotwuuQOPRl83sTHxdjliPVSbWKkeIhwuOtBQ7hjhQjHu/vwhtP4oDWoRA81oy+BCXW4
         eU7bDvPUmcvsvpsc5xnAr/C+z54hUNRBBB5TdXiyv6EKVrv8evc+qiBZdsLzH7fn7oZx
         wYsw==
X-Gm-Message-State: AOAM531mWxSp81qKqVE20c4bWx0Wn6D3GN29iiVsF21yaIfaElqlJTWW
        ixKe5PIywBiaWhyf8VaSPkcaZJhqxTw=
X-Google-Smtp-Source: ABdhPJwAfcxVhCfqD8ByUiaH6i4RsDCSkA04Vgnnlwu79VYa9z5+BmI/O6wdmYUN233pK7qDnc+qKQ==
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr12864256lfr.398.1612294947684;
        Tue, 02 Feb 2021 11:42:27 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:52ff:d394:f21a:e2e7:51d3? ([2a00:1370:812d:52ff:d394:f21a:e2e7:51d3])
        by smtp.gmail.com with ESMTPSA id 196sm3407306lfj.219.2021.02.02.11.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 11:42:26 -0800 (PST)
Subject: Re: is back and forth incremental send/receive supported/stable?
To:     Chris Murphy <lists@colorremedies.com>,
        Hugo Mills <hugo@carfax.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
 <20210129192058.GN4090@savella.carfax.org.uk>
 <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
 <20210201104609.GO4090@savella.carfax.org.uk>
 <CAJCQCtTVLcYAwDUTeJTP2TWTzdCTbqnnNmNDrz78_Wse-dMFHw@mail.gmail.com>
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
Message-ID: <ac9645bf-c0b8-9e56-77c7-3564cedbe554@gmail.com>
Date:   Tue, 2 Feb 2021 22:42:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTVLcYAwDUTeJTP2TWTzdCTbqnnNmNDrz78_Wse-dMFHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

02.02.2021 00:53, Chris Murphy пишет:
> It needs testing but I think -c option can work for this case, because
> the parent on both source and destination are identical, even if the
> new destination (the old source) has an unexpected received subvolume
> uuid.
> 

Incremental send requires base snapshot. It is given either as -p option
or "btrfs send" tries to find "best" base snapshot among those given by
-c. This works only if both target snapshot and (some) snapshots given
by -c are created from the same subvolume. So "btrfs send -c foo bar" is
entirely equivalent to "btrfs send -p foo bar" as long as both foo and
bar have the same parent subvolume.

> At least for me, it worked once and I didn't explore it further. I
> also don't know if it'll set received uuid, such that subsequent send
> can use -p instead of -c.
> 

On receive side "btrfs receive" will always set received_uuid to
snapshot given as "btrfs send" argument. The question is whether receive
side will be able to find base (parent) snapshot. As far as I can tell,
"btrfs receive" will first search for subvolume with matching
received_uuid and if nothing is found it will repeat searching for
subvolume with matching uuid. "btrfs send" will send received_uuid
instead of uuid if it is set.

Which means that in case

btrfs subvolume snapshot -r source base
btrfs send base
btrfs subvolume snapshot -r source diff
btrfs send -p base diff

you should be able to reverse replication by doing on destination

btrfs subvolume snapshot diff new-source

this creates writable clone of replication snapshot that will be used to
actually store data. You cannot use replication snapshot itself because
you need its uuid and it must remain read-only

btrfs subvolume snapshot -r new-source diff2
btrfs send -p diff diff2

This should find "diff" on source that has uuid matching received_uuid
of "diff" on destination.

The key here is to not attempt to directly use snapshots involved in
replication. They must remain immutable.

> -c generally still confuses me... in particular multiple instances of -c
> 


Well, it allows you to optimize transfer. if you know that large amount
of data in subvolume foo is reflinked to data in subvolume bar, you can use

btrfs send -c bar foo

and instead of sending (duplicate copy) of data in foo "btrfs receive"
will reflink it from bar on destination. Consider

tw:/mnt/src # btrfs subvolume create source
Create subvolume './source'
tw:/mnt/src # btrfs subvolume create clone
Create subvolume './clone'
tw:/mnt/src # dd if=/dev/urandom of=clone/cln bs=8k count=2
2+0 records in
2+0 records out
16384 bytes (16 kB, 16 KiB) copied, 0.000495937 s, 33.0 MB/s
tw:/mnt/src # btrfs sub snap -r source source-base
Create a readonly snapshot of 'source' in './source-base'
tw:/mnt/src # btrfs sub snap -r clone clone-base
Create a readonly snapshot of 'clone' in './clone-base'
tw:/mnt/src # btrfs send source-base/ | btrfs receive ../dst
At subvol source-base/
At subvol source-base
tw:/mnt/src # btrfs send clone-base/ | btrfs receive ../dst
At subvol clone-base/
At subvol clone-base
tw:/mnt/src # cp --reflink=always clone/cln source
tw:/mnt/src # btrfs sub snap -r source source-diff
Create a readonly snapshot of 'source' in './source-diff'
tw:/mnt/src # btrfs send -p source-base source-diff | btrfs receive --dump
At subvol source-diff
...
write           ./source-diff/cln               offset=0 len=16384
...
tw:/mnt/src # btrfs send -p source-base -c clone-base source-diff |
btrfs receive --dump
At subvol source-diff
...
clone           ./source-diff/cln               offset=0 len=16384
from=./source-diff/cln clone_offset=0
...
tw:/mnt/src #

Ignore weird clone from= in "btrfs receive --dump". It should have
printed clone uuid instead (it does not really have name at this point).
