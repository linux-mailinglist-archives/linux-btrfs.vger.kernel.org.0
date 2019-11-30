Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710E310DCF3
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfK3HbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 02:31:10 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39535 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3HbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 02:31:10 -0500
Received: by mail-lj1-f176.google.com with SMTP id e10so25027165ljj.6
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1KjoDBZ5kCz6P5aER0x6Zi5O++wMp9kmRRyR7Mivsi0=;
        b=Rl08sJCH8Wywi2nFzFapY3LFA3Li3k5f+/a8F1NZstFSo5zmcOEZ9/FCA4dAT8WfHI
         DwR8lj7ZU17sS8Gg3jLOXpYMpnuHjZ9pJW2rb9AcGq9G7kVC27eRsi4H1+pznLBAtKco
         HAlJfAFBndz52/pymX5Anw45hMSrKpulDezqoDQz8kBAhMHUXqws+xHTjgwAccTMMjQL
         mBr1gzG0/0e0WECTc/uYfTXU/OfGysk+/rDhWq3DNzIrcK4mVDCysqDZ3Btgx+yso0kX
         ooxa9QqVPMhL9GzWfoGnB5YSLkuz0BOwZmUJXuFv0JOUe7hI7KNBR4vxnXzNjbx5orgv
         h3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1KjoDBZ5kCz6P5aER0x6Zi5O++wMp9kmRRyR7Mivsi0=;
        b=YyNZSxNHFpWtCAuyaNDb38SO0MOrIBK7TB0Xl6XZAZhLiIii8Dqaxp1MeksuqMNbwR
         YUAZeFytFNhsx4qokE9XUmxL7GY6MkhpYLSla4vdQxB/bIV59a1Itk0piPDLnM8V/cEy
         CDTsj3ftI8vtCVK79uVnf9MjP32i5u4W+2BMVY9xhZ4f/NHsl3tC4TSoHRqVwWvha3SA
         kIvnbHy/xm0bxKxZyoIa8+pV6GGDNsDKgN2PV88SMrwcw5BAX+clCJq/t2jhGDVV0Zs+
         xCBzW2I2bZ6HBuvjWBw4pOXHAukvXLQF7lQUo1kxR9SmeOloo1WvhcHBPu7Zy8D7aSiC
         Joxw==
X-Gm-Message-State: APjAAAUA0hL3rUmsJHzg+t1qce8uwzf4CU9Mpd3mTk+A71+8WWkcvuRP
        hneACN8GOMrrDBxs7PF3kdSm61Z2
X-Google-Smtp-Source: APXvYqxKTJmXg8ngelt6jtZA36I5uTGkLKPlCvX1B+4+EDADKBKdz/0QNTOFwlVUzVBEG4oAj/6Xng==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr39261172ljj.41.1575099066562;
        Fri, 29 Nov 2019 23:31:06 -0800 (PST)
Received: from [192.168.1.6] ([109.252.90.228])
        by smtp.gmail.com with ESMTPSA id t2sm2141600ljk.65.2019.11.29.23.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 23:31:05 -0800 (PST)
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com>
 <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <6bc5b69e-188e-a7b2-e695-bd1bcb6a9ba3@gmail.com>
Date:   Sat, 30 Nov 2019 10:31:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.11.2019 00:11, Chris Murphy пишет:
> On Fri, Nov 29, 2019 at 1:50 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> 27.11.2019 02:53, Chris Murphy пишет:
>>>
>>> The storage is one CD-ROM drive and one SSD drive. That's it. So I
>>> don't know why there's hd2 and hd3, it seems like GRUB is confused
>>> about how many drives there are, but that pre-dates this problem.
>>>
>>
>> grub enumerates what EFI provides. What "lsefi" in grub says?
> 
> https://photos.app.goo.gl/pBxLJNdbzz6J9Vo56
> 

These are vendor media device paths handles that are children of (some) 
disk partitions. GRUB already tries to skip such handles:


       /* Ghosts proudly presented by Apple.  */
       if (GRUB_EFI_DEVICE_PATH_TYPE (dp) == GRUB_EFI_MEDIA_DEVICE_PATH_TYPE
           && GRUB_EFI_DEVICE_PATH_SUBTYPE (dp)
           == GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE)
         {
           grub_efi_vendor_device_path_t *vendor = 
(grub_efi_vendor_device_path_t *) dp;
           const struct grub_efi_guid apple = GRUB_EFI_VENDOR_APPLE_GUID;

           if (vendor->header.length == sizeof (*vendor)
               && grub_memcmp (&vendor->vendor_guid, &apple,
                               sizeof (vendor->vendor_guid)) == 0
               && find_parent_device (devices, d))
             continue;
         }

but these have different GUID. Google search comes with something 
hinting on Apple still (like 
https://www.macos86.it/topic/1136-asus-x202e-hm76-vs-n56vb-hm76/page/2/?tab=comments#comment-31186). 
  Device paths look like

PciRoot(0x0)\Pci(0x1F,0x2)\Sata(0x0,0xFFFF,0x0)\HD(4,GPT,A640EF60-F7E9-4945-81A9-B04CCE53EE97,0x176F4800,0x482FC88)\VenMedia(BE74FCF7-0B7C-49F3-9147-01F4042E6842,4F20CFA89785973FAAF730597BFC41BA)

where vendor GUID is BE74FCF7-0B7C-49F3-9147-01F4042E6842

So we have hard disk, then partition as child and then this vendor media 
as child of partition.

This should certainly be reported to grub list. What system is it - is 
it Apple?
