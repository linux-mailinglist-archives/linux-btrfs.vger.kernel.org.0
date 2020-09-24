Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383F0277384
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgIXOCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOCX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 10:02:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB309C0613CE
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 07:02:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so3314583qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QoeDdC7R68hYwESv+u7/uxBkvoFtYKlhZgSd1kHJXPk=;
        b=nYOZMwTztbhVXsZX1SGlzuNcDs9yoaLu227zPLgqPIC28TWE0pMHlWl8Z0LBSDv7EU
         OX+7r4Woxuly+TNYQNACXjyoKaeg72us0x9HMn+EcjNKq7DLcGv89Y2jBYuMAhHV85Cn
         wAjj1M1cV3J1KfPO0Iufqx0IHU5A3tqSfzwynABMKTtTpq0KyWSd0TfSp6+++kjTag92
         FEW75z/+Z1of69X0wyTNqVTIooLuINaRD9MBwtmiR1f1VBlk6ooA6ilNNB/cT9RK+KFx
         zhFQ3idzpL3zGNOI4uKyobfTQ8rKr/0MmBQxQatgJq/pbv4vAkcIre096FAtWqwVaOLE
         64eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QoeDdC7R68hYwESv+u7/uxBkvoFtYKlhZgSd1kHJXPk=;
        b=Uf5lJYQWpCCgJTQOt8KTiHlWcC6OakjNDIwz6SLBq9oI7TiJ8ncDcNWm2gy+6lFPLM
         DKKC2PG958ZOA+X/f8xfSR1SmZPSwhPqW/z1NoBWtiA6GHeCxfHS9hLrTSQ0nPfOFLWC
         j9b5xAP5HOa53loQs/l+KJc0ORe0toUYDfKfRnLs8MIRworlhMisgaE0BKEmoxLZEzde
         s2P3r3HjYOr5GdxgHbWi5ILm4tRl7A5d3Uk1JWQfeyhZvax4VX1CN4+BqVaA8y8tQEKq
         Do486Hk7Bpw4oFC4vVcR3RdrNpjroy1bzzEBfM9snLCOIKC87nul86ZVCOrsTNA/WJ0+
         z3fA==
X-Gm-Message-State: AOAM532IrX0xsIBTeKLnJx9SStQakyvOBAh267Ps1Xn1okjYpJggwWBq
        Z+x0kH0nzPR9RKW+Acb3bocmpA==
X-Google-Smtp-Source: ABdhPJwa3E4LADarlMbPcUbUEApo3HrkriSPDBnZdBrLR+4bd7owSiUYdvm2anVB8FDVAn/J8T6Haw==
X-Received: by 2002:a37:78b:: with SMTP id 133mr4823247qkh.107.1600956141877;
        Thu, 24 Sep 2020 07:02:21 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 15sm2023078qka.96.2020.09.24.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 07:02:20 -0700 (PDT)
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
 <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
 <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
 <20200924112513.GT6756@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a6766b76-a1fd-4011-5290-11406bc2923e@toxicpanda.com>
Date:   Thu, 24 Sep 2020 10:02:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200924112513.GT6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 7:25 AM, David Sterba wrote:
> On Wed, Sep 23, 2020 at 09:42:17AM -0400, Josef Bacik wrote:
>> On 9/23/20 12:42 AM, Anand Jain wrote:
>>> On 22/9/20 9:08 pm, Josef Bacik wrote:
>>>> On 9/22/20 8:33 AM, Anand Jain wrote:
> 
>> Yeah I mean we do something in btrfs_init_dev_replace(), like when we search for
>> the key, we double check to make sure we don't have a devid ==
>> BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key.  If we do we
>> return -EIO and bail out of the mount.  Thanks,
> 
>  From user perspective, then do what? Or do we treat this with minimal
> efforts to provide a sane fallback and error handling just to pass
> fuzzers (like in many other cases)?
> 

That's a question for fsck.  I don't want to spend a lot of time chasing 
imaginary cases that fuzzers come up with, I just want them to fail as quickly 
as possible so we can move on with our lives.

If this happened in the real world then it would be because we either

1) Lost the replace item somehow?
2) Got a random corruption that changed the devid to 0

I think for #1 it's impossible to detect really, unless you can tell which 
device was being replaced somehow?  I'm not sure  how you would do that, I'm not 
familiar enough with the replace code to see if we could figure that out.

For #2 it should be straightforward, as long as we can determine that we really 
weren't doing a device replace, then we just change the devid to 1 or something 
and carry on with life?  Thanks,

Josef
