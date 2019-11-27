Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC33410AA8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 07:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfK0GHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 01:07:21 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:42982 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfK0GHV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 01:07:21 -0500
Received: from venice.bhome ([94.37.221.184])
        by smtp-35.iol.local with ESMTPA
        id ZqTui7ZVc4KqMZqTuiJTn3; Wed, 27 Nov 2019 07:07:18 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1574834838; bh=+KHMw1Nu8/6NTyEHT5nt3vxFDvsqEX3QEKsJDFfT3Y0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sjLwwhTV1VAPdZWVvh4IOaG2OqDF6u0NIfHnAxI8nAkClXoak6ywor/NN5vMCfEiw
         zdVTkagO/ZHOt1RKS2HmGSTpM9PeW/tlnjBIUd+3AOyfTuwfcJIRlJwNUJZRqnL9N1
         1vMWnFphYJl47upjla5pgb/8RlK8p0cfjBUsBp5DbLOieaxHsMRNTuK8jK8O+Ugnsl
         soSiiwrwc8mTenVN9R+VZXyv6tXl9uxy6ndNh1rv2cZz7k5JE3eSNqwIXXxFEBSiJ+
         IXxVUlSeZYyDwLX99d8IP2/QsuYPqaTYfSVrRENBl+1oBO4Q0tLzrpjJQ96S/U3Fay
         YprCsotqdm3JA==
X-CNFS-Analysis: v=2.3 cv=UdUvt5aN c=1 sm=1 tr=0
 a=effWHHp4iGaMry7csNPTyg==:117 a=effWHHp4iGaMry7csNPTyg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=lZFbU4aQAAAA:8
 a=_5mgACltAAAA:20 a=GICLybgeAAAA:20 a=wixdtKU-VwprNg2LVhMA:9
 a=QEXdDO2ut3YA:10 a=yKZbCDypxrTF-tGext6c:22
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
Date:   Wed, 27 Nov 2019 07:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO8s0fhKqchzmmyuozG7pCBApTq1WoYEgl8p4EQR2MfKVmZg99m+fNUzA/5c0QCUBG85uE3ffcwQ5owACnWcP/dIQv+4rNfrqvuTTCoYamoY9aZEkRZF
 eCotUCDnbDn6Pk+pogfDI5K00lKOq1Ve/gV8Vrhc5M94yOU1aKYHHvPZXArB0PL1+mVrTcwYF6UQuICaLX1kSkS4VfqCqn6UhdQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/11/2019 02.35, Chris Murphy wrote:
> On Tue, Nov 26, 2019 at 4:53 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> On Tue, Nov 26, 2019 at 2:11 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>>
>>> I think that the errors is due to the "rescan" logic (see grub commit [1]). Could you try a more recent grub (2.04 instead of 2.02) ?
>>
>> Yes Fedora Rawhide has 2.04 in it, so I'll give that a shot next time
>> I rebuild this particular laptop, which should be relatively soon; or
>> even maybe I can reproduce this problem in a VM with two virtio
>> devices.
> 
> I was able to just update to the Fedora 2.04-4.fc32 packages. It's not
> upstream's but it's a quick and dirty way to give it a shot. Turns
> out, the same errors happen, although the line number for efidisk.c
> has changed:
> https://photos.app.goo.gl/aKWRYhJkkJRDtC1W7
> 
> For grins, I dropped to a grub prompt, and issued ls and get a different result:
> https://photos.app.goo.gl/MvL9QZa6zGsiktAf9

Looking at the second picture, it seems that grub had problem to access the disk 0..3 not only when is doing a btrfs activity.
No problem accessing hd4 and hd5*

Could you enable the debug, doing

	set pager=1
	set debug=all

?

> 
> Also for what it's worth, the Btrfs in question is on hd5,gpt4 and
> hd5gpt5 - same physical device, different partitions.
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
