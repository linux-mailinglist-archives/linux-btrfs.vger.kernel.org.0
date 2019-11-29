Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D08E10DAA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 21:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK2Uuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 15:50:46 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:40618 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfK2Uuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 15:50:46 -0500
Received: by mail-lj1-f179.google.com with SMTP id s22so14214688ljs.7
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C2CcxtAV03AZfVwwFoJpchwMbF1w3hMp5EhRkOQPwSU=;
        b=ZhzpVTQsyufyJ1vcEHynVkEiUwxdShATgIJJKDTPpli3HTPjEfURL6GXbbz/uPXNtN
         6yL8Me83Hs4n6LSq77oa2quN1CpkCScwXXc1s1E0Vhgrcfs/LM5l4Um03krSBO4DHege
         EB7lg7MX6rWblkROnJhFI8xeoFfJp2XXKSRawR90Ue75tLbZ07XZCRQ6MU2R7jStppXs
         VCxenhu2K1wzoNHTJeBgABX1v7zDcEUmlTUiEiJkOtVfYmjsntmwNXFP6PhyOWnW7gpA
         zc1iE5q/05IQFC7KBZiRtO7mUCZK1PityXqwmyPgicK3haBdEET55wJiR8qlhagWT/o+
         +W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C2CcxtAV03AZfVwwFoJpchwMbF1w3hMp5EhRkOQPwSU=;
        b=n73peoN+JUd+Eh5mfYiP3dUUxNgN3mCLv+CM8T7ywneJipPNOzoDyKfmAnj+h9H/Gy
         oh8wXJfVgPLF8rSByYQzzSmRcF1PEPBrvcHEesh4cFDhluNirGiLrFpugon6PMPLfm6f
         0xhF2NQ46Tx1lyvDVf//Euf0m8KR51DYXB5KrRRQvCB+aXkEfkCE8ummZ6KMPxd5t1no
         OJoGNcLKpFTZMpByaU75hSHcAnGpMLrzH4UhVgsZdblOYFcYEwR0cdbZaMpX1UqFFXY9
         He3Mz2YojXav74cCtv2mKCB0oAOakCcNeND2PVm4NeHEkJiHLH+q8iXWObLpgpkta4Ru
         VZFQ==
X-Gm-Message-State: APjAAAVGOZdc289m4inb4xISuSiSA+eCofg8/Us4SyBX38bSF26YDzLp
        SCwsVWA/soQoO3s+zcOwUBHGTsxk
X-Google-Smtp-Source: APXvYqw+K8iCA+dh+gdkYTQEfb+19nBEoXCH7xutpQN4Vid06gSPIGGNoJBXjA6ywKhncMzaCM+cIw==
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr4667570ljc.76.1575060644222;
        Fri, 29 Nov 2019 12:50:44 -0800 (PST)
Received: from [192.168.1.6] ([109.252.90.228])
        by smtp.gmail.com with ESMTPSA id f3sm10859597lfl.58.2019.11.29.12.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 12:50:43 -0800 (PST)
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com>
Date:   Fri, 29 Nov 2019 23:50:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

27.11.2019 02:53, Chris Murphy пишет:
> 
> The storage is one CD-ROM drive and one SSD drive. That's it. So I
> don't know why there's hd2 and hd3, it seems like GRUB is confused
> about how many drives there are, but that pre-dates this problem.
> 

grub enumerates what EFI provides. What "lsefi" in grub says?
