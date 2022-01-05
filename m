Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8E484FE7
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiAEJTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 04:19:51 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:60012 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238799AbiAEJTu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 04:19:50 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-36.iol.local with ESMTPA
        id 52SRnTkg2eQ4z52SRnDdjS; Wed, 05 Jan 2022 10:19:48 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1641374388; bh=o/9tuIWHP0QAQ8rALKsePH8feHNsybVQQnZgRQo95w8=;
        h=From;
        b=dAFfjTinkdri3m/j06p4IIVURYC7FoKalqiwsQ7SMSUIrWpmlK+hipvNXPUowCp4z
         SGpKbizE2gt5wtNvomCEgUxcUcTIl822I+neIVqa3fgtimWZWjMpbjbMy4FBxcUiyJ
         4QBq38MO3HHuNEGX/5+wNiQ3inRJnL9Y4iqV/9IOPRNq/bwwCPyXWr+K5rtQT2q3nn
         hWZYlvAhjwR4OEpOln6ZYgJ3lq8uki7EmGn0RqhxMtY63Ww5ArpJZ7khJBy7xC2CaV
         XCH+ldD4oXIj2LzjtbRwhh0fZgZNFhQRoYlycN6vhLJ1s+CPfL97iVRplWqNBBO2FS
         ismcRKuYQTi2g==
X-CNFS-Analysis: v=2.4 cv=WK+64lgR c=1 sm=1 tr=0 ts=61d562b4 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=0lOFetO7kJ6Uyi1PW4gA:9 a=QEXdDO2ut3YA:10
Message-ID: <f0db6390-3f6b-1b20-0049-be010695c764@libero.it>
Date:   Wed, 5 Jan 2022 10:19:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/2] btrfs-progs: new "allocation_hint" property.
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1639766708.git.kreijack@inwind.it>
 <21fcdf5d4186555b743190e62ad3011c08aaad9b.1639766708.git.kreijack@inwind.it>
 <YdUChLjZz80FS5u4@zen>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YdUChLjZz80FS5u4@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIi1IsNFjRrsClLScB8EzYY6pbxaq5456Blrl/LRuycHRmKeGSVpvJtKXUA2zhgpvyUd6N7GONGD/Gasb09y/EQJ4Y6jLw853Z5q/6tllipFaNCLVUZr
 UlSVXM4X0b1YFk4fscUAXwsa+WJTV8/68pOtzPbdWU9p4SV1PnqLZ9B+kvTxpao1X+7jqrAODdUMT2GMSDV1ZL9Fpc44viyXp4sucDRm6ZpwaZhXt2x4N1vL
 cFC5P7qyztzBFD/T6xB5w9y+n4S68ELFEtK809LN1Y5dfIxIqMM9nEJBaVtsqet3PUNmKmzWnuF8sIJlO/DtNZ5e+efe8jqorz3igab7qIYL+UGNVYJiMtKr
 NmkoNxSh3v1mn6cs+qx07y7r+QjUSw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/5/22 03:29, Boris Burkov wrote:
> On Fri, Dec 17, 2021 at 07:47:04PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Handle the property allocation_hint of a btrfs device. Below
>> an example of use:
>>
>> $ # set a new value
>> $ sudo btrfs property set /dev/vde allocation_hint DATA_ONLY
> 
> I applied this patchset to the master branch of
> git://github.com/kdave/btrfs-progs.git
> and this command failed with something like "not a btrfs object".
> 
> However, it worked fine as:
> $ sudo btrfs property set -t device /dev/DEV allocation_hint DATA_ONLY
> 
> I can't think of a reason I would hit this error and you wouldn't, since
> that check is relatively old, but figured I would mention it.

It seems that you missed the "failing command". However my guess is that this command fails on the LVM/DM devices, which often are link to the real devices.

Further investigation is needed.

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
