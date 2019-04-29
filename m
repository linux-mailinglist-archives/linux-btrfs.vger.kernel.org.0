Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F60E169
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfD2Lgk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 07:36:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39532 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfD2Lgj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 07:36:39 -0400
Received: by mail-it1-f193.google.com with SMTP id t200so3071259itf.4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SfbR/2WWOr0M7sK3cOu6m7ioEvvsGJEmPj29vQ+x4/M=;
        b=Cfxju/JLKZcuj+lx4nZcmlWOH508Tq+O5iFyiqTAch0CX+xfnEVtfL9iNInyn36Nl0
         dw2+9xAN1IvMAGKh/5K7iqEfXbwexHOG41h3jp5jssRu0D1PLrUB8hsa1yCUjud6cT1n
         jIlhgKGp85WZdjh5bS3pmZloLiykGXLBD9bLaZEs7YId1RFnAioe+dnCagdRcmIIrpFg
         wR6dVd6Yvq0ARtJ9Ks7bWrOGcWiDUu0ULmb8bzWsLGNUw9aL20oylLx6S/5t9NHQdiXC
         sQYUEnqBx0yq6oSlWo+VnUeE/EDu+o+kIoatexjKnNhq5ESxCio9WzWmGdTNf9ounAL0
         9OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SfbR/2WWOr0M7sK3cOu6m7ioEvvsGJEmPj29vQ+x4/M=;
        b=noT/E+XXU1lVYE3qG71ZV5L6zkYXBZgW5WOatBgDBjuoAzgUuMIxcOj1A5LQElccrv
         NLyH9UYTQ3Qx23ji531kXkCOrxk8pRTyD4rc1wL2uDu6QCd4P2cmvV7cBIxZhPDFuizj
         r/+dxD0V/mt69by6n+GUABVjTXXx6vRZisFY7Qsxhd76H+22UUS86C90MT3m87xkHDLq
         Sch1Tcjf+ywhbVjlEf00SrMMg1QLbsUYWdG8m2dpM+uPAWcMXiGn8YIzH/X/DG5sW3/q
         PBp2HWBkFTxsLOZbTsZFe3N347TWNILgiIDFXrQDpoB5yZ8eXw0+Brv5l45dqh32SpR+
         65gA==
X-Gm-Message-State: APjAAAX5109ZQYYcT2csLQV60y24Tc5NYq7hNhjAhgGEaPr3tgV2iGtE
        tLerWgTbE2dWgR+sMAQ8D5ua3fO3z6I=
X-Google-Smtp-Source: APXvYqy3khgP+f0KbdeWd8aDji80moCzmTp09YTbHazleyujLk5JBhslHlrDrEuyS/5YNpMAdgxlMA==
X-Received: by 2002:a02:9685:: with SMTP id w5mr1038072jai.131.1556537798705;
        Mon, 29 Apr 2019 04:36:38 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id h5sm1959521itb.5.2019.04.29.04.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:36:37 -0700 (PDT)
Subject: Re: recommended way to allow mounting of degraded array at boot
To:     Alberto Bursi <alberto.bursi@outlook.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM0PR03MB413128509989947DE4AA7DEF92380@AM0PR03MB4131.eurprd03.prod.outlook.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <5e02c6d3-9024-10fa-51f0-629ff5e604fe@gmail.com>
Date:   Mon, 29 Apr 2019 07:36:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AM0PR03MB413128509989947DE4AA7DEF92380@AM0PR03MB4131.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-04-28 12:18, Alberto Bursi wrote:
> I am looking for a way to mimic mdadm's behaviour and have btrfs mount
> a degraded array on boot as long as it's not broken (specific use case:
> RAID1 with a single disk missing/dead)
> 
> So far the only thing I could think of (and I've seen suggested
> elsewhere) is to add the "degraded" mount option
> in kernel command line and in /etc/fstab.
> 
> But on the wiki I read that this is a bad idea because of what they call
> "Incomplete chunk conversion" issue [1]
> 
> that says I can only mount it degraded (when it is actually missing a
> disk) rw ONE TIME and then the filesystem would go ro.
> 
> Is that still a thing? Are there other ways of doing what I want?
Yes, but it only matters if a couple of specific conditions are met:

* You have exactly two disks in the healthy filesystem.
* Exactly one of those two disks is missing.
* The filesystem has to allocate a new chunk when you are writing data 
to it.

That last condition is almost impossible to be certain about, so you 
really only need to pay attention to the first two points.

Now, that said, having 'degraded' as part of your standard options is 
less than ideal for multiple reasons:

* It makes it very easy to not actually notice that one of your storage 
devices is having issues.  Unless you're paying attention to the kernel 
logs, or you have _something_ that's validating observed hardware state 
against known correct state, your only indication that something is 
wrong will be reduced performance.  MD, LVM, and even ZFS have easy to 
use notification mechanisms that can trivially be configured to let you 
know if a disk is missing or misbehaving, but BTRFS just doesn't have 
any equivalent right now.
* It indirectly encourages running volumes in degraded mode under 
otherwise normal system operation, which is risky because it's largely 
untested (and is also just a bad idea, independent of what your storage 
stack looks like).
* If you're doing this on a system using systemd, it actually doesn't do 
what you are trying to do.  Systemd will refuse to mount the volume if 
all the constituent devices aren't present, so you're going to fail to 
mount with or without the 'degraded' mount option if you have a disk 
missing.

Unfortunately though, there's not really any other option currently to 
do this with BTRFS unless you script something yourself (not 
particularly hard with traditional init systems, but somewhat difficult 
with systemd because of the aforementioned issue).
