Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B002E183
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfD2LnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 07:43:13 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:39553 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfD2LnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 07:43:13 -0400
Received: by mail-it1-f181.google.com with SMTP id t200so3095999itf.4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IlFgVHrx0n7diXroXfSqsprU74XmPY1eUh0uSM7orcI=;
        b=Rh5Gp6ujOaqA8uTiTMO27AeNkEJ+xyVaTJSNaeC8Kbx7CxV/pNDsLzWmtJNZDEfm4H
         NvCJnelzeQ4ePLqPgJnH+su+Ml4A+ieSuw0NZjh2kOhA8DGC6QKtX6/1EWR5JIktGLz1
         qMYCQtH0BemF2Ab3S3VqoVVx9jZSaROy0quxbfyh5pJGsgO3visFW2l7U4PW9RFCRXDx
         YSpJSXohwSp6YNz8Hy0ik6ibGFYxsa8AkZ9kWG6hnGYc0jKVL07TCtDBkiqfgkc0En7L
         hRF/vUTf6KlzPWAj+5GwCt73S8xE/N30Xyn8toHU8aglqEDXDVNQuO/x8Svc+KUgTcnS
         AhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IlFgVHrx0n7diXroXfSqsprU74XmPY1eUh0uSM7orcI=;
        b=J1G5gjdchS0D270nRlBuKDgra/1DtL6GLNCVfW9gZmDutAdBpwf0cAy8gisl9/6uKK
         H8I9hLGUKnCkMn2revsq9NtBYFrkwIAdM6QmDzQPQu0xiSmYRFfveMlQmDRPZaGUvpr7
         NBq343iKVeTOlm/G86IW3BbVENYgqq8Ub0cfPeXWRVOyX/BT8d88nk9wMUHpFEpiJ/t1
         G3eGzpmWaOzNxhcmyxjudaPk02UBxKSC58UBS4JbMqhyhH/tkYyumRkAFfZIwDOYLw2k
         VG6VPNcdO86bRsT9VJ3mUaeLbqrRDRpxX1YQHZj8Ytv3sJjBZDpBjkDzd4dCtzG0mS3R
         jIwA==
X-Gm-Message-State: APjAAAWjw989HkQLLrEPua4j0KY9rglgG1aw9l9UCLRnB2Hw+HvK1+Kx
        58IWlFEjt6wdib7pItOh5FgndNgXFI0=
X-Google-Smtp-Source: APXvYqztCQ4ubvnlDDOQ2RTGsPNsjPDFa0TC9flJGgNXyUc2SiPKpdBIjqT66Z+rdlUjCpzArr9T+Q==
X-Received: by 2002:a24:d45:: with SMTP id 66mr19421002itx.9.1556538191813;
        Mon, 29 Apr 2019 04:43:11 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id j5sm9031104ita.16.2019.04.29.04.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:43:11 -0700 (PDT)
Subject: Re: Migration to BTRFS
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Hendrik Friedel <hendrik@friedels.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <emb78b630a-c045-4f12-8945-66a237852402@ryzen>
 <0f1a1f40-c951-05dc-f9fd-d6de5884f782@gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <e27cc7ee-4256-0ccc-a9f1-79cd6898e927@gmail.com>
Date:   Mon, 29 Apr 2019 07:43:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0f1a1f40-c951-05dc-f9fd-d6de5884f782@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-04-28 16:14, Andrei Borzenkov wrote:
> 28.04.2019 22:35, Hendrik Friedel пишет:
>> Hello,
>>
>> I intend to move to BTRFS and of course I have some data already.
>> I currently have several single 4TB drives and I would like to move the
>> Data onto new drives (2*8TB). I need no raid, as I prefer a backup.
>> Nevertheless, having raid nice for availability. So why not in the end.
>> I currently use ~6TB, so it may work, but I would be able to remove the
>> redundancy later.
>>
>> So, if I understand correctly, today I want
>> -m raid1 -d raid1
>>
>> whereas later, I want
>> -m raid1 -d single
>>
>> What is very important to me is, that with one failing drive, I have no
>> risk of losing the whole filesystem, but only losing the affected drive.
>> Is that possible with both of these variants?
>>
> 
> With "single" data profile you won't lose filesystem, but you will
> irretrievably lose any data on the missing drive. Also "single" profile
> does not support auto-healing (repairing of bad copy from good copy). If
> this is acceptable to you, then yes, both variants will do what you want.
Actually, it's a bit worse than this potentially.  You may lose 
individual files if you lose one disk with the proposed setup, but you 
may also lose _parts_ of individual files, especially if you have lots 
of large (>1-5GB in size) files.  And on top of this, finding what data 
went missing will essentially require trying to read every byte of every 
file in the volume.
> 
>> Is it possible to move between the two (doing a balance, of course?
> 
> Yes as long as you have sufficient free space for target profile.
> 
>> Any other thoughts/recommendations?
>>
> 
> As of today there is no provision for automatic mounting of incomplete
> multi-device btrfs in degraded mode. Actually, with systemd it is flat
> impossible to mount incomplete btrfs because standard framework only
> proceeds to mount it after all devices have been seen. As long as you do
> not use systemd in initramfs you may be able to boot by passing suitable
> root mount flags on kernel command line.
> 

