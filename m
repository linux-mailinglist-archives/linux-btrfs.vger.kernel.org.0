Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C134D14C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhC2Ng5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC2Ngo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 09:36:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF42C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 06:36:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i9so12367569qka.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fWbDAscTVTfpswhaf1qJuRXabVZ+yACdmvThz6hTL2o=;
        b=gErvYs9Ktw6YOsvdb0939aFdvm8HlnZaUGzHGL9ftRDWWok7XrAVOR/p4nX05B4wMd
         4zbi47Lw5jx6iamPL5QRICSc7xu1BjofkB1+LQSUVxIFF99Ymh7ttcyfLqGrTWYaFXS5
         5XWwqg3sgUsYgb5c5cPhwik+d3HsX1lEwaAgNtYmAmtczOTrrI8TbwDToETONc5MOKPL
         l9YXgUq8DHexCSROA775RyoAona75xh5xpiGYDdU5uhuSHIqUfw76/n2lN5gtyeCAnmi
         KAXqghBjV8NJ+wXBPiPBk+MYsWybkUNAMq70kVCHgP60gBw9DP52ml5gg5Y/TZWqTnWB
         V1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWbDAscTVTfpswhaf1qJuRXabVZ+yACdmvThz6hTL2o=;
        b=Pm2cr45DHq0aKHq8Fz57d6t9ZWvIy8O1S0CrN6Vi9zZUYxVR9CxuBHVV4/UghGnVF2
         r3yoBeqTQ7aReXER12zDvezL2Vy8TnA6pMaG10Z4vxyzmpRRGFDO1WFemNwkqh54fZUk
         bZWC04nX9hva2XzhOfmhLY9o5x/cAyvi52EuHT+HqPi1b/8d0uunMpqVulzoBgsrNN71
         GU/okudczWj1Kj5CTkDaQZ4PjO67Q0+VfEzv3rE1LzhREFPUTrdpNs2V1/shiO4eWZmi
         VEJoTCgmV4Fe8pf+jN6tr8Dz+gDJwoTcjLIIfuMpdc/ArSoREyleoVD3D3TTc0Acn25A
         p0kQ==
X-Gm-Message-State: AOAM5334/LcDi6DSfaxDbMRWiwf4QXcAlhsCAMPUxzR55Q6aHoZcrMkr
        qkoT+hoHnsiO9zvWXtPSOSiaZqIvembeBCwG
X-Google-Smtp-Source: ABdhPJyHFqKjptjGYCgO8joCpWY5qJEbsrbXTxftM0yseFenrF0thuDiefVXcFn7AmVCntXNNl1VdQ==
X-Received: by 2002:ae9:eb4d:: with SMTP id b74mr25853799qkg.45.1617025002948;
        Mon, 29 Mar 2021 06:36:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i25sm12965853qka.38.2021.03.29.06.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:36:42 -0700 (PDT)
Subject: Re: Aw: Re: Re: Help needed with filesystem errors: parent transid
 verify failed
To:     B A <chris.std@web.de>, Chris Murphy <lists@colorremedies.com>,
        btrfs kernel mailing list <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com>
 <trinity-10b6732b-bd13-45e0-b795-66e3c9a869c4-1617003257785@3c-app-webde-bap09>
 <CAJCQCtSp1cmA6iVmRfRXrxzo7pUA8eSUGwzuifbZkS=p0deO0Q@mail.gmail.com>
 <trinity-a06881cd-b3d5-4055-b151-f8ad46e425e1-1617007367803@3c-app-webde-bap09>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0fd32582-2e87-c446-c312-9c1d9f4a3fdd@toxicpanda.com>
Date:   Mon, 29 Mar 2021 09:36:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <trinity-a06881cd-b3d5-4055-b151-f8ad46e425e1-1617007367803@3c-app-webde-bap09>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/29/21 4:42 AM, B A wrote:
>> Gesendet: Montag, 29. März 2021 um 08:09 Uhr
>> Von: "Chris Murphy" <lists@colorremedies.com>
>> An: "B A" <chris.std@web.de>, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
>> Cc: "Qu Wenruo" <quwenruo.btrfs@gmx.com>, "Josef Bacik" <josef@toxicpanda.com>
>> Betreff: Re: Re: Help needed with filesystem errors: parent transid verify failed
>> […]
>>
>> What do you get for:
>>
>> btrfs insp dump-s -f /dev/dm-0
> 
> See attached file "btrfs_insp_dump-s_-f.txt"
> 

I'm on PTO this week so I'll be a little less responsive, but thankfully this is 
just the extent tree.  First thing is to make sure you've backed everything up, 
and then you should be able to just do btrfs check --repair and it should fix it 
for you.

However I've noticed some failure cases where it won't fix transid errors 
sometimes because it errors out trying to read the things.  If that happens just 
let me know, I have a private branch with fsck changes to address this class of 
problems and I can point you at that.  I'd rather wait to make sure the normal 
fsck won't work first tho, just in case.  Thanks,

Josef
