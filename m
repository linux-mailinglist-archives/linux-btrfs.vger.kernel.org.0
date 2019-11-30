Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12C10DD18
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 09:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfK3IMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 03:12:35 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:32981 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfK3IMf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 03:12:35 -0500
Received: from venice.bhome ([84.220.25.30])
        by smtp-31.iol.local with ESMTPA
        id axrkiFK00iFL3axrki6nFl; Sat, 30 Nov 2019 09:12:32 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1575101552; bh=pYVofLvDzJcEyQck0BiG5klhKIn4aas6FvgBUOcro7E=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SwpbdM2hmcpZ9bNlfgF8jSO0czgh9OxMCJlR5y3LcagsLynZrTbqh5b8wJz4+sW5w
         Fj+fWZWKFs2PC+f0qV5ZhA1Hk0bfJdhWkXYm+J9dujheyOv2+kZvb4lEymiTzPyTRF
         MchCSKVdGaIRmWgXG0eWIAbG+vpo/UXpeeu5ZZP6vNCbfpgaWTmyd62kL6m6iDSyBI
         EggYlioOUlD5bhTfOiFrOgi7/1crE4mhbbgyKxnl7FgW98yBR1xzCwAvFKNdZPNr8S
         zGXj+rX/2+1mmboLSZYv/UTd5eEU3846WmmW8oAnNvTtEnaqQitZnP1IR/hLJZeWmY
         G4ooCN6U7X3aw==
X-CNFS-Analysis: v=2.3 cv=J77UEzvS c=1 sm=1 tr=0
 a=zfQl08sXljvZd6EmK9/AFg==:117 a=zfQl08sXljvZd6EmK9/AFg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=EWzy1JFkAAAA:20
 a=FgGwSqtrznFWIYmEnAUA:9 a=QEXdDO2ut3YA:10 a=SwgnqPuqv7PglqJc3hzP:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Reply-To: kreijack@inwind.it
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
 <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
 <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
 <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it>
 <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
 <0ce1c050-d90c-1351-ff56-4edc054463a4@inwind.it>
 <CAJCQCtQSgTG=r0+i=M7nKgz5ncqcfEkZmQci5Kk12PmDVzgmbg@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <7aed9b06-b6e9-abef-0241-f542ffffdfc7@inwind.it>
Date:   Sat, 30 Nov 2019 09:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQSgTG=r0+i=M7nKgz5ncqcfEkZmQci5Kk12PmDVzgmbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNo2w8ujxegpYBoGyZsc6dwuPj3/wcfmMPF+SzHfEh8BkqzuE+k3oRKa+ZccyL9SFuaLUvSBKeMZGRRcYCX/u87jUd5hb4Uuj5CmD6XqyIhTr1agVDrL
 o1P7Zl7tVEhV6JgBW4fNH+nyWL8+SVm2lyeNKDnJi01KdCQCSSIE8CtkSOHcQtO3xNMKBv1P9z7aM24u4LDwBPi2Ux6qGnMw6s8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/11/2019 22.17, Chris Murphy wrote:
> On Fri, Nov 29, 2019 at 12:54 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>> Could you be so kindly to share the picture of the loading of the kernel/initramdisk ? Something like:
>>
>> grub> set debug=all
>> grub> initrd /boot/initrd....
>>
>> I hope that the errors come quickly. I don't think that we need the pictuers of all the download. It would be sufficient the pictures until the first (or better second) error....
> 
> I paged through it for minutes, hundreds of pages and never found any
> errors. But these are the first pages. This might actually be some
> kind of search, not load of the kernel, because I pressed tab to
> autocomplete. But it didn't autocomplete it immediately started
> spitting out debug pages.
> 
> https://photos.app.goo.gl/kpa7dJ9spAy29yj26
> 
> Is it possible to redirect grub debug output to a FAT file?

It is possible to redirect to a serial console ..
Did the machine has a serial port ?
> 
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
