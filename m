Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3931F387
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 02:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSBLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 20:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhBSBLD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 20:11:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFFCC061756
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 17:10:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j12so2756422pfj.12
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=49Bzl/Rksl1aOmlAgXLC8OdYTUcW/2yvs4S03TDO7bU=;
        b=Joqy2WqRyJiIZEOvfvBTPQzEZU3Dy6PvnRr5edAfrWPXVr4WXGSuct0pKc6EPJ8Dq6
         KMTDuhdO0CI7BrmijO9hu9QKhXjBTuuyNH7+g++7ZShK2K68lAg2qcxiIpaiuWfTmpxE
         Unen4ORWwxldRM7DCSPJpsNUXxz4iUJZA3JVXYlNXiGbH6h3A4GwYP0oINvNN4ZvbkJt
         SC9bV4+fuUkEfH3gvt6PkqyBkRpvrVroz3pONsD+2Fw4GlyGFDOrHcDWTE9aBRkiEoa3
         C6/WLOFhrbsZwbqpnTnjlaOX3oNZsIVtJiWjOBzHUmFK+/hh9oi+GsTmx4Dswl1dOO6k
         63Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=49Bzl/Rksl1aOmlAgXLC8OdYTUcW/2yvs4S03TDO7bU=;
        b=sjIPlI3TpMJTLup4cbCY97f5Y9+d62cUWnJ37Y4Pc+wNwfuAfYgZ23kMgdXUrcQoZf
         //NzjUmZQ0PePoIP1TCeBX176D3cYfhRThLY/KyIlL32+mpz37sShe9dnXe6Lz6FckzS
         BmcCPx0rw1CYpYFO89IzgupYKiytDPrOEYwT9JN0xNup9hN4dRVSyWA8lzrQk4OwyS8/
         HBEebrP6aU7agVUAhaEQNKKdOF9POfv8YB368I06TcSDvpPEGsdwJ30d2r3elP9ro51/
         6ToAL4+gPySXKPgIZWtsdfNBaB0w4iDZhQGPa5ezOCYXy2xLmOm4KILVZXirdioNm2Qm
         CLgg==
X-Gm-Message-State: AOAM531cmyUn4ykqDnvLAVzfd49qbHoDFwG8dn84pqrEq41UphBSrxVz
        m0/kTfDOEp9DrtDZTaN6BGrUgWcheJ0=
X-Google-Smtp-Source: ABdhPJyp+HF2Qbn0SRQjYnIWi0o1paF5Tj5S7saZuc82hRzXnIXvlG3BsSj/QbOpqhjb3RicPJSWeg==
X-Received: by 2002:aa7:87d5:0:b029:1ec:da11:3033 with SMTP id i21-20020aa787d50000b02901ecda113033mr6888583pfo.53.1613697022740;
        Thu, 18 Feb 2021 17:10:22 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f30:4900:7285:c2ff:fe89:df61])
        by smtp.gmail.com with ESMTPSA id e125sm7647972pfh.175.2021.02.18.17.10.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 17:10:22 -0800 (PST)
Received: from localhost.local ([::1] helo=ddawson.local)
        by ddawson.local with esmtp (Exim 4.94)
        (envelope-from <danielcdawson@gmail.com>)
        id 1lCuJD-0017PF-Ls
        for linux-btrfs@vger.kernel.org; Thu, 18 Feb 2021 17:10:15 -0800
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
 <CAJCQCtQGyHJjPwmKxwxCBptfeb0jgdgyEXF=qvGf-1HBDvX1=w@mail.gmail.com>
From:   Daniel Dawson <danielcdawson@gmail.com>
Subject: Re: corrupt leaf, unexpected item end, unmountable
Message-ID: <80058635-0bd9-05cc-2f5e-b4986a065be3@gmail.com>
Date:   Thu, 18 Feb 2021 17:10:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQGyHJjPwmKxwxCBptfeb0jgdgyEXF=qvGf-1HBDvX1=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/18/21 3:57 PM, Chris Murphy wrote:
> metadata raid6 as well?

Yes.

> What replacement command(s) are you using?

For this drive, it was "btrfs replace start -r 3 /dev/sda3 /"

> What device is devid 3?=20
It would normally be sdc3. I'll address the confusion below.
> 16315=3D0x3fbb, 16283=3D0x3f9b, 16315^16283 =3D 32 or 0x20
> 11111110111011
> 11111110011011
>         ^
>
> Do a RAM test for as long as you can tolerate it, or it finds the
> defect. Sometimes they show up quickly, other times days.
I didn't think of a flipped bit. Thanks.
>>         devid    0 size 457.64GiB used 39.53GiB path /dev/sdc3
>>         devid    1 size 457.64GiB used 39.56GiB path /dev/sda3
>>         devid    2 size 457.64GiB used 39.56GiB path /dev/sdb3
>>         devid    4 size 457.64GiB used 39.53GiB path /dev/sdd3
>
> This is confusing. devid 3 is claimed to be missing, but fi show isn't
> showing any missing devices. If none of sd[abcd] are devid 3, then
> what dev node is devid 3 and where is it?
It looks to me like btrfs is temporarily assigning devid 0 to the new
device being used as a replacement. That is what I observed before; once
the replace operation was complete, it went back to the normal number.
Since the replacement didn't finish this time, sdc3 is still devid 0.
> But yeah you're probably best off not trying to fix this file system
> until the memory is sorted out.
Right. I'll get on that soon and see if anything pops up. Thanks for the
help so far.

