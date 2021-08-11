Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8BA3E89C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 07:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhHKFed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 01:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhHKFec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 01:34:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB21BC061765
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 22:34:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa17so1660479pjb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 22:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sZleWE8QQ4j8+94Hp2OTg6Fa6Zn81fVtka/n4Y46vZo=;
        b=fM+V1abn5/0+ij10oQfA3UWQI4r56mm81D0wcMtWmgYKCavMmByU3JuMm7esQbAY6M
         wv1qX7/dvs6gyEC/pKNI1Kix/or6pk4XNbjjT7uNvWuqj4Qog9N5EWTLSjh4jnG3sh4H
         oBvVh6+w3gnH2u1MtM7MRdsNnEjIj8GPW4mez1lBZghsJsVJqU5Wa2BEAs3fCFg2OthN
         X0Ua95JsWnKmDIhtdvmJL8GcKeQLdoZp60wriYtdJY5SrLkBCClA1Si4Rswu/iYSZaR7
         fG0IEyc0ErmnXKk/4qynQKtpKip/Ye+2bTRyouw5cZu65kqym3quyZgLTXoSiabk7/ze
         izKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sZleWE8QQ4j8+94Hp2OTg6Fa6Zn81fVtka/n4Y46vZo=;
        b=b9cVkLqv/X33jEFTY2yx3lugnlaL/oeI/CM3KK4dMyEzPkTU1B/kdepzDxE7vRQs3e
         XWhrtD8uoq/EwiuhpgV/X1T1cp1z/Ot8GkLww3kajdtyimAmngLaDW20TG3Z8tZj1kF3
         AYjhQAaUYWOYCIlhQZiRxOBvu3liubrb3lnzyVveae0fRzDITSOGdc2iaewHAzSJ3vRd
         xWzoPKVyo0e07UhCUN9KjPVFyaVAsLDo7FPNskSdrW5XAwdoc4soSU8aRPyIuMTblQ3N
         hK/QpMmkAPXyK6qaWCSspzm8WZR4W7QqTIQHMV9t/bvftWOdb8prwlSfwILNthhDz33B
         DT4A==
X-Gm-Message-State: AOAM532rzIiEPwOR/jTBi6otz5Iiq/hrWXNxqRYYbg6FAn71kuPncw6F
        Rv07+Ct7IuZfxniWbeOhXWI=
X-Google-Smtp-Source: ABdhPJyyGqLas3FXxrfk/oUFXqL6HZ3X2qtLjLk6OXzc/kAbv0R60Y6e9/jEeMaxoLv0k/O9/cxthA==
X-Received: by 2002:a17:902:ee55:b029:12d:5cde:62ab with SMTP id 21-20020a170902ee55b029012d5cde62abmr1329913plo.83.1628660049000;
        Tue, 10 Aug 2021 22:34:09 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id n33sm26659655pfv.96.2021.08.10.22.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 22:34:08 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
Date:   Tue, 10 Aug 2021 22:34:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/21 22:24, Qu Wenruo wrote:
>
>
> On 2021/8/11 下午1:22, Konstantin Svist wrote:
>> On 8/10/21 16:54, Qu Wenruo wrote:
>>>
>>> Oh, that btrfs-map-logical is requiring unnecessary trees to continue.
>>>
>>> Can you re-compile btrfs-progs with the attached patch?
>>> Then the re-compiled btrfs-map-logical should work without problem.
>>
>>
>>
>> Awesome, that worked to map the sector & mount the partition.. but I
>> still can't access subvol_root, where the recent data is:
>
> Is subvol_root a subvolume?
>
> If so, you can try to mount the subvolume using subvolume id.
>
> But in that case, it would be not much different than using
> btrfs-restore with "-r" option. 


Yes it is.

# mount -oro,rescue=all,subvol=subvol_root /dev/sdb3 /mnt/
mount: /mnt: can't read superblock on /dev/sdb3.

dmesg has the same errors, though..

Anything else I can do?

