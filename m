Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428E52E81D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 20:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLaTnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 14:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLaTnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 14:43:03 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279AEC061573
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 11:42:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l11so45914896lfg.0
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 11:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ys9f4ClpJL8HAcQlauKh3PDFZfSJYAi99SUSEOzYtRM=;
        b=Tc2ndKRC8axW3OTIHkxsPwVf5IRqhAxCo6lfSmQjR72GtceMIM/H5y0o1HYPkLMDcs
         oPKE2BCZsdssNv09+7Qmy04nn30jcQ6kKig8xe2tv5ROCsI3HIJqmBPkEJpZN6AR9rXm
         zC8sDzwn4wGFPTxDGC467UjqJGnjsqf3lmvKku0E8bYGB+gkZFEHGiUxJYF6Ay5LtSfX
         mJFTgKZgJPwfOIYv6qFINjwBXAHDM7Dg6ezXDMvkPu1MFYAP8dITs9mJCgNwcRSIgDuU
         dICodIKlYJRFT5Btj5zEMabfIt5dxfEDV/iXnmKACcPBfeA/pLpOhCx0q7BDKDmu+VCZ
         +4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ys9f4ClpJL8HAcQlauKh3PDFZfSJYAi99SUSEOzYtRM=;
        b=swzqTO2iO8R5Zq7wL1qqr6efzMRBDG6yd8HL1CQJSsRXNHjG0WVr4mwrhZsNxDf+Bb
         JCy7ZHkqzuC18gxGaPPsnUr5dj9ra+d/WId4nlGVx7+w1RynV5WMYT3yS/Qs8rNHRVz9
         +0LLzhW92bDpmu62A0mB5IF/UECJCKj2f/kLOnf4OeNXCHAWRIe6OCOFnwuaYFBynLAY
         DwX3tgSkYja5lApF7lcB8CKQ2Y2B405IBO4AthCRchuYVWVEOJwMY27WYf/fKaSo8w+R
         605HqhnZx4EmAcCLs8CpTdlZUOs8M8oa2ZqODU9C1Gb+nksBljCMk22XonRBrPA2gpY9
         3JOg==
X-Gm-Message-State: AOAM533WY/j067EQTlP8Awdi0n8oZYr/vbHiGZQbm3jKczq6Zao+DzvU
        sliojjBt5V/u6ciu0hLNj8NeaXI/E5Q=
X-Google-Smtp-Source: ABdhPJxx13XVk64xvnPO+3ud+yF3yg74lB368M139cNQr4YAX7U5DMpyS69JCceEAW0TgbP8nY9cqw==
X-Received: by 2002:a05:6512:248:: with SMTP id b8mr27060510lfo.371.1609443741557;
        Thu, 31 Dec 2020 11:42:21 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id j2sm6303790lfe.213.2020.12.31.11.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 11:42:21 -0800 (PST)
Subject: Re: hierarchical, tree-like structure of snapshots
To:     john terragon <jterragon@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
 <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
 <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org>
 <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
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
Message-ID: <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
Date:   Thu, 31 Dec 2020 22:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

31.12.2020 21:19, john terragon пишет:
> On Thu, Dec 31, 2020 at 6:28 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> 
>>
>> I think your confusion is that you are thinking of these as a tree.
>> There is no tree, each subvol is an equal peer in the filesystem.
>>
>> "send -p A B" just walks over subvol A and B and sends a diff of the
>> parts of B not in A.  You can pick any subvol with -p as long as it's
>> read-only and present on the receiving side.  Obviously it's much more
>> efficient if the two subvols have a lot of shared extents (e.g. because
>> B and A were both snapshots made at different times of some other subvol
>> C), but this is not required.
> 
> Can you really use ANY subvol to use with -p. Because if I
> 
> 1) create a subvol X
> 2) create a subvol W with the exact same content of X (but created
> independently)

How exactly you create subvolume with the same content? There are many
possible interpretations.

> 3) do a RO snap X_RO of X
> 4) do a RO snap W_RO of W
> 5) send W_RO to the other FS

Show actual command please.

> 6) send -p W_RO X_RO to the other FS
> 

Again show full command please. Which include also receive command.

> I get this:
> 
> At subvol X_RO
> At snapshot X_RO
> ERROR: chown o257-1648413-0 failed: No such file or directory
> 

You get where? On source, on destination?

> any idea?
> 

