Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6634B8D5
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 19:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhC0SQn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhC0SQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 14:16:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24BC0613B1
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 11:16:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c4so8620630qkg.3
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Mar 2021 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=lwaNHvDPscEU9S8NwxRnBrwLNFg6uL8GgPdrW1JUVyM=;
        b=J2CnecPLgzYF0BJIiXl3IekleLOEurPQxfLqEdDNlLEdv42VLSy4935CQKRUyETyby
         n2PBmLlTBnwWHx3SSwF/eigtKRpyQcGwG6sz1azMzTAthrAm0pT0kaffRvaWUD+vEflA
         99yy+taF+yZz8D9pB/daxVwQW7dSMer00+CoKcApVmNuKDAcCb5RfWObCbLLduHG5ea6
         YUtsICcCD6iUq+czDT5GaJRpofdXITqeIxqZJOa7VlCgtGJ0BPT1hlp4/Ei/YX85eva0
         LYZq70GALXgcN5/2GR17VJ6kDHXZAVCqyF58ZKjRbcj649LQBHzJfiHN6xXxc8Xz/IIJ
         ovcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lwaNHvDPscEU9S8NwxRnBrwLNFg6uL8GgPdrW1JUVyM=;
        b=WGzwlJyscK+rj9Kcy341D3MLGFJtzRm11uZxCF78Sxz2W6OwU0a2j+iSdMUYbIRqLe
         IqI2AzDRJQdZSTK8gyrNyjoXO52EcBpNMxU1VTFu5F0q6BevkvotYPpk9nptdiWBjunM
         frqOqIDzKdqA2hXDo11dBDEwhceHwIlGbIC6cHQ+vwhkdn18T6H5soHrtJG+o1vJQcDE
         FLfRdV8IUG3mPCEwSeJPTY9afwHYH9GdGUjqr0grPUAbIMJADFYpXwx15LoM59qsD00S
         IN77lrjYCcw6vhI/PginIzsX0ngYdGojlFF9TriJWKQB1OnP0RpjJ0xn1djwpdqObqMN
         elBg==
X-Gm-Message-State: AOAM533UFVOPW27yUu0tT0e+ciAlC5IT8qs6bnCEer7zW6raYe2nqT8n
        Y3rk3QB3NYcm11pcwcN2TZ5KPzJETag=
X-Google-Smtp-Source: ABdhPJzdnAK1bSRZfvmHCdvoKg7ipZbZrkQ8DlRrj83Wb4mA9bKupLiaTqimRTTp6poZ56r1B3pn7w==
X-Received: by 2002:a37:2795:: with SMTP id n143mr18212081qkn.292.1616868988764;
        Sat, 27 Mar 2021 11:16:28 -0700 (PDT)
Received: from MacbookPro.local (c-73-249-174-88.hsd1.nh.comcast.net. [73.249.174.88])
        by smtp.gmail.com with ESMTPSA id 17sm7633929qty.27.2021.03.27.11.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 11:16:28 -0700 (PDT)
Subject: Re: APFS and BTRFS
To:     Forza <forza@tnonline.net>, "Eu, acc" <accensi@gmail.com>,
        dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <7ead4392-f4c2-2a5b-c104-ae8be585d49e@gmail.com>
 <20210322222257.GC7604@twin.jikos.cz>
 <CAA+gEba91br_M6qERcwL5no=DdMSw3QA7iNwf8OGwskX=9Z6_g@mail.gmail.com>
 <8aaa32e2-c9bf-ef48-b6ac-1b04b26ab415@gmail.com>
 <43aa98ff-edfb-fba8-1bbb-2c497fbbe89e@tnonline.net>
From:   Forrest Aldrich <forrie@gmail.com>
Message-ID: <085b131d-58ce-bfe3-16d9-e02bc3d01ba4@gmail.com>
Date:   Sat, 27 Mar 2021 14:16:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <43aa98ff-edfb-fba8-1bbb-2c497fbbe89e@tnonline.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm taking data from the 18TB drive and placing it onto the USB-drive 
array I built (slower) -- it's on a USB 3.0 bus, off a raspberry pi, so 
very limited in terms of what I can do for that. It's a hackup job I'm 
building for longer term storage.  The real bottleneck is the USB3.x bus 
and the USB-based disks I have striped together -- yes, i know it's a 
hack :)



On 3/27/21 2:13 PM, Forza wrote:
>
> On 2021-03-23 00:19, Forrest Aldrich wrote:
>> I have apfs-fuse running, but it is read-only.
>>
>> I wanted to avoid the pain of replicating a large disk from USB3 to 
>> USB3 by converting the filesystem, which I expected wouldn't be 
>> possible.  So now I am just replicating it, which will take days to 
>> accomplish.
>>
> Have you considered taking the disks out of the USB enclosure and 
> putting them directly on the SATA controller? It could be faster.
>
>
> ~Forza

