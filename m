Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A0719A160
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgCaVz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 17:55:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45188 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgCaVz6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 17:55:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id o26so11024726pgc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Mar 2020 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=IPRLk5gJqNq8IG3YL5e3UlvfFgT4WXNL3zmWBfRMTnM=;
        b=ZXTZhXC0i8OsBM67RZxaQNTA+NaU5OEhlKE7aD641L3mnauoR5StqasK1Z4At43MSo
         B4VIiYH0M9Cksi3NeczPsTSqALb41aEr0q15ajaT3OnGFFBNQde8qtfQt5VG0tkjkZqi
         apsAF/osoZj2WZOH8Jhzatroa3/H18ZmiKasO4CkmPk3YlQEHE20GgydR2qofoX3ujNo
         DdV36sgqZWqrofNUf+EQ5NS2VW6OM1Qxcrip/nbj6CTvdAfbQrUNJYbGH/HgMtRNXIBo
         edZ1ECrORHOfwwFrRC9j23hXLjL7mo7fk5njq8wXsATjjNZyYG8o87VncNnQ0SFdB0az
         R0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IPRLk5gJqNq8IG3YL5e3UlvfFgT4WXNL3zmWBfRMTnM=;
        b=l2cFQlaL3tTQNj9aB3PUFcfZMkU5LxpB6JPQn2faLN7/cuf2o6Nft8mKWjQictSt+7
         a4+yQRACH2mB9tnAaniIRCASl9QzX2Gvy9VTi2tPiNUavIg58TlCEWQPzC/yk8soX9+i
         6TPDIk5Ajt5xA+qmqretBMPFutHdNKklTg1bk7en75XcKoEG8mmIy+VBD8wS1sOKCF5z
         58yoRckIPkKGK1mPjpwBbaMP1b5aWrm91/c3rNKlch2akRDf5/fPfnpVOVmix8fSOhP/
         oy5Zep6000noaefApxDG9O5aSIedQ6sX8S4yUPFO2XFkGe1iW+tdP4kVxgpdJCRSgZmN
         IqZg==
X-Gm-Message-State: ANhLgQ2Jx3PqnIDbNTj9i2etZbB9GoxeIkc2YWwWb/GPpggkIV/ObV2y
        MUE5CN5GbRwFYajXker9Qof+Mbws
X-Google-Smtp-Source: ADFU+vtK0O7ft/ngi3ldWijwCd/tVwznUxMt0F68rdR2dOZ6H5Yrdhe5D/1Z3pbcx16Ua8OqMdjMEA==
X-Received: by 2002:a65:568a:: with SMTP id v10mr20240400pgs.215.1585691756116;
        Tue, 31 Mar 2020 14:55:56 -0700 (PDT)
Received: from [192.168.178.53] (61-68-113-75.tpgi.com.au. [61.68.113.75])
        by smtp.gmail.com with ESMTPSA id gx22sm71767pjb.21.2020.03.31.14.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 14:55:55 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
References: <20200318211157.11090-1-kreijack@libero.it>
 <91df2f66-ea8a-c369-9f03-b826dbbe1481@libero.it>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <4edd6cd0-077c-c49f-defe-bfe0b8b8a440@gmail.com>
Date:   Wed, 1 Apr 2020 08:55:52 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <91df2f66-ea8a-c369-9f03-b826dbbe1481@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes I do!

Please push/pressure to get this patch reviewed!

BR,
D.Pointer


On 26/3/20 7:12 am, Goffredo Baroncelli wrote:
> PING,
>
> does someone find interest on this kind of patch ?
>
> BR
> G.Baroncelli
>
> On 3/18/20 10:11 PM, Goffredo Baroncelli wrote:
>>
>> Hi all,
>>
>> this patch adds support for the raid5/6 profiles in the command
>> 'btrfs filesystem usage'.
>>
>> Until now the problem was that the value r_{data,metadata}_used is not
>> easy to get for a RAID5/6, because it depends by the number of disks.
>> And in a filesystem it is possible to have several raid5/6 chunks with a
>> different number of disks.
>>
>> In order to bypass this issue, I reworked the code to get rid of these
>> values where possible and to use the l_{data,metadata}_used ones.
>> Notably the biggest differences is in how the free space estimation
>> is computed. Before it was:
>>
>>     free_estimated = (r_data_chunks - r_data_used) / data_ratio;
>>
>> After it is:
>>
>>     free_estimated = l_data_chunks - l_data_used;
>>
>> which give the same results when there is no mixed raid level, but a
>> better result in the other case. I have to point out that before in the
>> code there was a comment that said the opposite.
>>
>> The other place where the r_{data,metadata}_used are use is for the
>> "Used:" field. For this case I estimated these values using the
>> following formula (only for raid5/6 profiles):
>>
>>     r_data_used += (double)r_data_chunks * l_data_used /
>>                                 l_data_chunks;
>>
>> Note that this is not fully accurate. Eg. suppose to have two raid5 
>> chunks,
>> the first one with 3 disks, the second one with 4 disks, and that each
>> chunk is 1GB.
>> r_data_chunks_r56, l_data_used_r56, l_data_chunks_r56 are completely 
>> defined,
>> but real r_data_used is completely different in these two cases:
>> - the first chunk is full and the second one id empty
>> - the first chunk is full empty and the second one is full
>> However now this error affect only the "Used:" field.
>>
>>
>> So now if you run btrfs fi us in a raid6 filesystem you get:
>>
>> $ sudo btrfs fi us /
>> Overall:
>>      Device size:          40.00GiB
>>      Device allocated:           8.28GiB
>>      Device unallocated:          31.72GiB
>>      Device missing:             0.00B
>>      Used:               5.00GiB
>>      Free (estimated):          17.36GiB    (min: 17.36GiB)
>>      Data ratio:                  2.00
>>      Metadata ratio:              0.00
>>      Global reserve:           3.25MiB    (used: 0.00B)
>>
>> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
>> [...]
>>
>> Instead before:
>>
>> $ sudo btrfs fi us /
>> WARNING: RAID56 detected, not implemented
>> WARNING: RAID56 detected, not implemented
>> WARNING: RAID56 detected, not implemented
>> Overall:
>>      Device size:          40.00GiB
>>      Device allocated:             0.00B
>>      Device unallocated:          40.00GiB
>>      Device missing:             0.00B
>>      Used:                 0.00B
>>      Free (estimated):             0.00B    (min: 8.00EiB)
>>      Data ratio:                  0.00
>>      Metadata ratio:              0.00
>>      Global reserve:           3.25MiB    (used: 0.00B)
>>
>> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
>> [...]
>>
>>
>> I want to point out that this patch should be compatible with my
>> previous patches set (the ones related to the new ioctl
>> BTRFS_IOC_GET_CHUNK_INFO). If both are merged we will have a 'btrfs 
>> fi us'
>> commands with full support a raid5/6 filesystem without needing root
>> capability.
>>
>> Comments are welcome.
>> BR
>> G.Baroncelli
>>
>
>
