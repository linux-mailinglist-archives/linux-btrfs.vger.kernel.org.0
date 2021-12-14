Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8A474CBB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 21:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhLNUl2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 15:41:28 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:45341 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237681AbhLNUlZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 15:41:25 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xEbym6Bneg9rVxEbymb4B1; Tue, 14 Dec 2021 21:41:23 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639514483; bh=9lZjsFpySmOBoDRps+RBOy/dPsgDYjIKXslZ4Y5NwgU=;
        h=From;
        b=rZhVIVtfbquJVR/d2nuTf9WL992AF8JehTCZf1HO1qvIUV/o+yRq/Q8ed1H9Fi5QZ
         YkKQ+gVBxDiol/a4g56LKfcq5sCh7MZArl6qEsriAPwKJPGErl4JNLLnUlqbeQGjtY
         zC+9pdqnsdaAt2tJXGUQ9+X2w7BgJ/qsnhCrOEWPsswbz71KOk4nkk46EU/Ftm3nR7
         4JOkzTXwaRGRjsZfOKGPVc1EVKhH6T6kdrbmm9DbK6mlNfOZ8orzfsZPROIYhPt3lo
         itJ35jdog/o+8a2bsPEnhAjQNnlG7BdtK/AyT4Uxu+tcAb718NDjbM72Zbjrg3+zef
         tnGrcoWwdpKZQ==
X-CNFS-Analysis: v=2.4 cv=T8hJ89GQ c=1 sm=1 tr=0 ts=61b90173 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=8YGpo9N-opDnXBGvkPAA:9 a=QEXdDO2ut3YA:10
Message-ID: <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
Date:   Tue, 14 Dec 2021 21:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain> <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org> <Ybj/0ITsCQTBLkQF@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Ybj/0ITsCQTBLkQF@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNRTcwzd/K/5ZIzq/nnvpXkDP+nUeknjVqqDP7Zz5YzxDfVHSR58U1g6QTxzm/v283XXd8+ZRNs1PeCREt8a1Udb0xdLsoDoJOfNeUIampiNdXnCW/ga
 OgC22nH2uuuia1IYcrB48IxelGlxvrONNu8WJ6MTCp4wKcItWOrrAYqNLswBJEa3wTUYYVCZ+UKhh+NxAfsnNKeOtvIfW8NoFZDDxFokFAU4WO4PglOmZM5q
 C0YFh+ifh9grkqVFwidrCSafWdHB/opYAVjPW3zSCAd889xVj2nu5xEnvvFbpNiAJ0ZqdaSlTq500fgO+pdQaR+vbXqgbTlo9fw4e2B+khQgg8kK15Q8XnuZ
 ygK4/KMI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/14/21 21:34, Josef Bacik wrote:
> On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
>> On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:

>>
>> I don't have a strong preference for either sysfs or ioctl, nor am I
>> opposed to simply implementing both.  I'll let someone who does have
>> such a preference make their case.
> 
> I think echo'ing a name into sysfs is better than bits for sure.  However I want
> the ability to set the device properties via a btrfs-progs command offline so I
> can setup the storage and then mount the file system.  I want
> 
> 1) The sysfs interface so you can change things on the fly.  This stays
>     persistent of course, so the way it works is perfect.
> 
> 2) The btrfs-progs command sets it on offline devices.  If you point it at a
>     live mounted fs it can simply use the sysfs thing to do it live.

#2 is currently not implemented. However I think that we should do.

The problem is that we need to update both:

- the superblock		(simple)
- the dev_item item		(not so simple...)

What about using only bits from the superblock to store this property ?

> 
> Does this seem reasonable?  Thanks,
> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
