Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C373E8662
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhHJXVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 19:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhHJXVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 19:21:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E3C061765
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 16:21:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso1593109pjy.5
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tf7tCf9Nvqz/LeCOEFo2sn88tOnwSoNDCWsCe4vuvYg=;
        b=QgyFOmr9DE0AkrKH1uEIZ8k1E3lyAbMMSLu7KLNzxje3pabX4GaehMe5nZJpmp7YT4
         EwIANmSwzUJDbthjwfrUL6L0C/g+ELd5DxBFLg49wIRyK6EIXfV8iSHgeOC8XsyEPk5Q
         cqoHJ+DpLQw7spme/VXYzlwHzCRKZSl39ioS0wlBXRYEyvIjG8fmMNRQcjT+7op7ZR35
         mAOcrIEYj4D+cxCU5yPBmuvYjEX6rN3c9Zt423KfVFj6STnhnIVZHbOWdlN81yN+1GAf
         XAtEZttdERI/i1plnts1yg3+oRUBeuqGgDNJXoe9fzwEkA2r8bPkBiEvK8dQDon1c6vE
         uRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tf7tCf9Nvqz/LeCOEFo2sn88tOnwSoNDCWsCe4vuvYg=;
        b=f9l0NvWFClR0v8kNseD6utSOoinWbfYkRLNgt5zxPHFn9v4ahsHC2KcJIXi7r0/pOo
         buG12IHXxi/4JPNmjdy/Qqs9tgi7Uhcz200jJLCGi87LxnmZCuFUPlGAdm8EBNhT9hwE
         a2M2HXGhCJav38auXQtuGY1XAMaC+xm1vUC1Tt4m7qTQC6qJDLAsItPr7G94W7u+DrHv
         GFEZQmHvk2HDcytvHD+3TqQhzeB4V04VMMZ52wiQBZRwAkrgooLuL1Pj3OfZAmcdgbpq
         aVTrim7+CmXoQa2t5m5huTy8Aly221eO0gT79AImWk2hTcHay/ZxtxlaVZT7jXjN0i4/
         Vufg==
X-Gm-Message-State: AOAM532L6vaOqZyjlgiCJlW7wEyLQNirco8Yy+hnW7NaqfaLvPHLV7Gw
        1dW8C3FqByj6MaIIL7Ky/dE=
X-Google-Smtp-Source: ABdhPJyPxsSOG2lVwLzw4xTkaWGSnH+AnJHWo/JjgHJe744DSYSAimkpAzSxnRKmvAAPKTuNUSUIGA==
X-Received: by 2002:a17:902:7682:b029:12d:3a69:c6cb with SMTP id m2-20020a1709027682b029012d3a69c6cbmr1714940pll.65.1628637674410;
        Tue, 10 Aug 2021 16:21:14 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id y9sm29508026pgr.10.2021.08.10.16.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 16:21:13 -0700 (PDT)
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
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
Date:   Tue, 10 Aug 2021 16:21:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/21 15:24, Qu Wenruo wrote:
>
> On 2021/8/11 上午12:12, Konstantin Svist wrote:
>>
>>>> I don't know how to do that (corrupt the extent tree)
>>>
>>> There is the more detailed version:
>>> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf597299a@gmx.com/
>>>
>>
>>
>> So, here's what I get:
>>
>>
>> # btrfs ins dump-tree -t root /dev/sdb3 |grep -A5 'item 0 key
>> (EXTENT_TREE'
>>
>>      item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
>>          generation 166932 root_dirid 0 bytenr 786939904 level 2 refs 1
>>          lastsnap 0 byte_limit 0 bytes_used 50708480 flags 0x0(none)
>>          uuid 00000000-0000-0000-0000-000000000000
>>          drop key (0 UNKNOWN.0 0) level 0
>>      item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
>>
>>
>> # btrfs-map-logical -l 786939904 /dev/sdb3
>>
>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
>> bad tree block 952483840, bytenr mismatch, want=952483840, have=0
>> ERROR: failed to read block groups: Input/output error
>> Open ctree failed
>>
>>
>>
>> Sooooo.. now what..?
>>
> With v5.11 or newer kernel, mount it with "-o rescue=all,ro".


Sorry, I guess that wasn't clear: that error above is what I get while
trying to corrupt the extent tree as per your guide.


That said, my kernel is 5.13.* (without your patch) and this mount
command still fails as before


