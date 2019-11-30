Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75AD10DE5C
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 18:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK3RCg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 12:02:36 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46204 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfK3RCf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 12:02:35 -0500
Received: by mail-lj1-f174.google.com with SMTP id e9so35118698ljp.13
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2019 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdDasl11I206vbEj3Lh+xBmdQy35rIaArfvj3Vm4FXM=;
        b=dzjwzVu7lO05ttCFn95DPEX8nwxuOUWT1aLsJpreuxNBJi2ttaT3txw4P+5NdgesnE
         5PJapmOveHMFq4h+ClZtGVSXewz+7olzdb2XRnYI/u3C3cLDM3sz3PMU4u3Sjg30zTZ1
         pORGKTNTva1IpBMb5af5PpSFVM43E+TmSEgekxsb2tn8LkGQICewCAACDxn2jYDkOMZU
         dEODFAhNfIayBAIOnDmVdn4Klcu7x/3oKvATU7cgsbtCGaeYJ44HvGEejl9pMBhqOFaj
         8DI/phu6TYpMzvLx/cV+K4lzUp4iJKc4YX781MwAz2y5xBzgPvA+T6QrkBqvvJ9Zk5or
         o+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdDasl11I206vbEj3Lh+xBmdQy35rIaArfvj3Vm4FXM=;
        b=IeYCPCRnaZo9yQY6BqlWzjTn2U9vzhIXEfHtJvQykaVlHJSDaoUXjGaPZaRjA8EfCg
         Vxx0mUksJB4q7p4SM0s2Tr7dKSEX9PI0CpeR9KeWEXQm/tiNMDlpdsGuM3tlQC9MZQcV
         vTB5v3ABgS3yuv41SBFV/ssEnJkDJ4//kXwwq/4oCWrC0eOShud46GhZ9GGd6a7y4yeP
         G+mNITBovM2o1VqRa5TVFYZS30joccUhqq5gcFfD6/6hdg+c+CA0WdfywQpPMLGXcK5R
         qXLIIl1y0VGMpkczdJn2stZYDru+81bZl2TuNoEX/lM2YBj+wrvXaeCo0ysOny2sqtIP
         wsMA==
X-Gm-Message-State: APjAAAWVksWvmlJi0jWF3Yko19J3FaRCEjTpeIisiOThVAJAO1giqlOg
        i7Xj/xwxE68TX6OqlTD/dHyzRBdX
X-Google-Smtp-Source: APXvYqzOguYimHHyjY5cjS5DxQpLPd3DcnahXK2BkEmDOF2vOZZPidhyvo2AsksO4DD3+Og2fyKQGg==
X-Received: by 2002:a2e:9684:: with SMTP id q4mr3782028lji.242.1575133352676;
        Sat, 30 Nov 2019 09:02:32 -0800 (PST)
Received: from [192.168.1.6] ([109.252.90.228])
        by smtp.gmail.com with ESMTPSA id q17sm11861741lfn.43.2019.11.30.09.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 09:02:31 -0800 (PST)
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com>
 <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
 <6bc5b69e-188e-a7b2-e695-bd1bcb6a9ba3@gmail.com>
 <CAJCQCtQxR4Xnikz7vVxOX-gzU6aWzu5eHeG95HOKsx40ziTGLg@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <8a86c7ef-39ab-7c35-f39b-e05ab7543a11@gmail.com>
Date:   Sat, 30 Nov 2019 20:02:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQxR4Xnikz7vVxOX-gzU6aWzu5eHeG95HOKsx40ziTGLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.11.2019 19:31, Chris Murphy пишет:
> On Sat, Nov 30, 2019 at 12:31 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> 30.11.2019 00:11, Chris Murphy пишет:
>>> On Fri, Nov 29, 2019 at 1:50 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>>>
>>>> 27.11.2019 02:53, Chris Murphy пишет:
>>>>>
>>>>> The storage is one CD-ROM drive and one SSD drive. That's it. So I
>>>>> don't know why there's hd2 and hd3, it seems like GRUB is confused
>>>>> about how many drives there are, but that pre-dates this problem.
>>>>>
>>>>
>>>> grub enumerates what EFI provides. What "lsefi" in grub says?
>>>
>>> https://photos.app.goo.gl/pBxLJNdbzz6J9Vo56
>>>
>>
>> These are vendor media device paths handles that are children of (some)
>> disk partitions. GRUB already tries to skip such handles:
>>
>>
>>         /* Ghosts proudly presented by Apple.  */
>>         if (GRUB_EFI_DEVICE_PATH_TYPE (dp) == GRUB_EFI_MEDIA_DEVICE_PATH_TYPE
>>             && GRUB_EFI_DEVICE_PATH_SUBTYPE (dp)
>>             == GRUB_EFI_VENDOR_MEDIA_DEVICE_PATH_SUBTYPE)
>>           {
>>             grub_efi_vendor_device_path_t *vendor =
>> (grub_efi_vendor_device_path_t *) dp;
>>             const struct grub_efi_guid apple = GRUB_EFI_VENDOR_APPLE_GUID;
>>
>>             if (vendor->header.length == sizeof (*vendor)
>>                 && grub_memcmp (&vendor->vendor_guid, &apple,
>>                                 sizeof (vendor->vendor_guid)) == 0
>>                 && find_parent_device (devices, d))
>>               continue;
>>           }
>>
>> but these have different GUID. Google search comes with something
>> hinting on Apple still (like
>> https://www.macos86.it/topic/1136-asus-x202e-hm76-vs-n56vb-hm76/page/2/?tab=comments#comment-31186).
>>    Device paths look like
>>
>> PciRoot(0x0)\Pci(0x1F,0x2)\Sata(0x0,0xFFFF,0x0)\HD(4,GPT,A640EF60-F7E9-4945-81A9-B04CCE53EE97,0x176F4800,0x482FC88)\VenMedia(BE74FCF7-0B7C-49F3-9147-01F4042E6842,4F20CFA89785973FAAF730597BFC41BA)
>>
>> where vendor GUID is BE74FCF7-0B7C-49F3-9147-01F4042E6842
>>
>> So we have hard disk, then partition as child and then this vendor media
>> as child of partition.
>>
>> This should certainly be reported to grub list. What system is it - is
>> it Apple?
> 
> Yes. Macbook Pro 8,2 (2011). I'll report the phantom device problem to
> grub-devel@
> 
> But still an open question is what's the instigator or secondary
> factor because this wasn't happening before adding an unused but
> already existing partition as a 2nd Btrfs device.

GRUB is normally using hints - grub-install (and grub-mkconfig) tries to 
guess firmware device name. At boot time grub tries to access hinted 
device first, if it succeeds, it does not try anything else. With second 
btrfs partition grub needs to find second device at boot time so it now 
probes everything and hits those vendor media devices.

At least this explains what you see as well as ...

> Last time this
> happened, all I did was remove the 2nd device and the problem went
> away.

... this.

If you go in grub shell in this state (without errors), do you see those 
ghost devices?

> I'm ready to try that again (remove the 2nd device) and see if
> the problem goes away, but has enough information been collected about
> the present state?
> 
> 

If you are reasonably sure that all errors are related to those phantom 
devices - I would say yes, the reason for these phantom devices to exist 
is already clear.
