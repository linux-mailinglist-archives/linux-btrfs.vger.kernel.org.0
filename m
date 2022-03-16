Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7134DB6B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 17:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbiCPQxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357689AbiCPQxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 12:53:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5E237BCF
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 09:52:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o6so3948617ljp.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QtT03o6DUM9YqlkzdjNndBLvQngfLyuCDpwUBX4Aw1k=;
        b=oNNX2Mv9tjWt6gFjOmkX9+ahFmKKdT/Gp26bSVLSHQLibtIYps4OHx9/N77QQ3FfkL
         5rAMQGE3zp2dxJN/G9+heeSx18D/wsIw8bzpUg0bjfbM5JeNCVZ6yi0731ZsK2izeNt0
         Iwm3ZwtIP6jxOKVcQJLbaxzl2eXe4bkWNCT6PCn83u8N7YATf9tkmt6aZtIQMro3hMYJ
         h+ANad3ukwDWrWiVf5BUqfuR5PK66UwU4/Gj5ykd4s2xg7fVeog3w0Ymb+38h2O9/Uz5
         d4d1eCYtRFJtBJ5aXqtHkfp/247BtwmwqgnDBvY+zbmbYWtyp39KAEDAbLSbf1pB6gj5
         lttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QtT03o6DUM9YqlkzdjNndBLvQngfLyuCDpwUBX4Aw1k=;
        b=NkT2nPvFMPazQ/tClmvH3y1TicIJIsP2+WIByvoi6raA553jH9wTVNZRlyRaT3x6Ma
         y5XfBEfHAisM+EJgrZOX0V2/K39OlY2WSmPu4d16DG1YIubhqSV9Q4WKUJdtNxBxK/UO
         VE/dsKVAR6FtBqpINpwV7WafK7uZuxzfng02SPYmHh3bUFqseVWQCO7SKBqqj5R/mqNE
         QtYD3lYN3FWMYElWx3rosmkj002sqCAlHKudMF2SbRAqFv1Jyy4t9W7kXrJddIyDRJfo
         J8Ow2bpT9qJJL/LXk8Ec1oiPRF1pMqO98UXSEqOmmEBHBPaV5EPxJ58isP+XXDuZP56Y
         T6EQ==
X-Gm-Message-State: AOAM531L45PM7hbpUtEqcavxOM/AlSKgtENpITgRcnrAQ3rOIEEfCoCj
        Qm7m5PABkXrd3bHx4S19DCg=
X-Google-Smtp-Source: ABdhPJz9CHv9GmTW9vpZs6Heu7YiutTUrJLVUP36QFXq9H57XH/F6l0sRQzLey+pOghQEQQZja5o/A==
X-Received: by 2002:a2e:7c16:0:b0:244:be33:9718 with SMTP id x22-20020a2e7c16000000b00244be339718mr270063ljc.467.1647449521560;
        Wed, 16 Mar 2022 09:52:01 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d? ([2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d])
        by smtp.gmail.com with ESMTPSA id u8-20020a196008000000b004487a7a4afasm221272lfb.41.2022.03.16.09.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:52:01 -0700 (PDT)
Message-ID: <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
Date:   Wed, 16 Mar 2022 19:52:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Content-Language: en-US
To:     Phillip Susi <phill@thesusis.net>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <87ee34cnaq.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.03.2022 23:02, Phillip Susi wrote:
> 
> Jan Ziak <0xe2.0x9a.0x9b@gmail.com> writes:
> 
>> The actual disk usage of a file in a copy-on-write filesystem can be
>> much larger than sb.st_size obtained via fstat(fd, &sb) if, for
>> example, a program performs many (millions) single-byte file changes
>> using write(fd, buf, 1) to distinct/random offsets in the file.
> 
> How?  I mean if you write to part of the file a new block is written
> somewhere else but the original one is then freed, so the overall size
> should not change.  Just because all of the blocks of the file are not
> contiguous does not mean that the file has more of them, and making them
> contiguous does not reduce the number of them.
> 

btrfs does not manage space in fixed size blocks. You describe behavior
of WAFL.

btrfs manages space in variable size extents. If you change 999 bytes in
1000 bytes extent, original extent remains allocated because 1 byte is
still referenced. So actual space consumption is now 1999 bytes.
