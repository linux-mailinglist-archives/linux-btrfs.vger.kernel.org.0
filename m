Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B358748581D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbiAESXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 13:23:37 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:47713 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242862AbiAESXf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 13:23:35 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-36.iol.local with ESMTPA
        id 5AwgnaeWKeQ4z5AwgnHAzn; Wed, 05 Jan 2022 19:23:34 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1641407014; bh=JgTUp5BpBwcFv/jCyDAbaQx9zdyPSq2tJF57rGDFhNM=;
        h=From;
        b=OLF7/RCWzj2C/UU0Ac7ioUc8MxSPNcutDKBlrr4Z37mcSvRDTrDB35xHT1fMiK5bH
         e3fpDmgGEB7b9wHXU9MtFLKWhXP1dY57cMkZJAeu5t2Cc8+D6pWP5HkpHYjL9x/zFN
         XAHPcx1XBf5a2C4tqD9khmTxmOlL2I9izSLZZmysXe7Y8AUCgf5uMuDNkvfapDBotH
         qwP1v9WqRz/U//0RPT2+sst05bEHEaFGsZhfzadapcz9K+CW2sbKZSYiO5uRSJawAo
         Ap63Rq5Q1J8OX7zC5F3v7X3Gi004OxRCq+CXY2dpLXUkK3zU5TLeV0AwCF/4SoQVb1
         6ud6srz2SK3HQ==
X-CNFS-Analysis: v=2.4 cv=WK+64lgR c=1 sm=1 tr=0 ts=61d5e226 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=crjxBLSnH2_21MHUEJgA:9 a=QEXdDO2ut3YA:10
Message-ID: <d4132584-faef-713e-aa7f-542257de3cfd@libero.it>
Date:   Wed, 5 Jan 2022 19:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH][TRIVIAL] btrfs-progs: Allow autodetect_object_types() to
 handle the link.
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
 <YdXaZP27ALM6KJ9G@zen>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YdXaZP27ALM6KJ9G@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPFAeQ8VpsKaDLSdAek4V3YWbIlMTv3T2aN6stN90A+yKVfdjE+djONpvW2ep3Edl0pcD7vdpKlX21v7UYeHbBlwApMi2521KoRqRFHmMrlcE3MZxLtj
 y4encxdRQRpBTI44vGuWH2f91L8i+uFKmKa964JzrgyEF3Zf6o8jXGDq4orvBDRuARFLWV+0lKal/A80BkGrsR7EVLWORB/Pn2PVlLGD6a2/JnJM31qJOnqk
 ZtnhqZ6Oc7PK02oE/9kROA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/01/2022 18.50, Boris Burkov wrote:
> On Wed, Jan 05, 2022 at 02:32:58PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
[...]
> 
> I took a look at the original lstat and it doesn't seem super strongly
> motivated. It is used to detect a subvolume object (ino==256) so I don't
> see why we would hate to have property get/set work on a symlink to a
> subvol.

It is not so simple: think about a case where the symlink points to a
subvolume of *another* filesystem.

Now, "btrfs prop get" returns the property (e.g. the label) of the *underlining*
filesystem. If we change statl to stat, it still return the property of the
underlining filesystem, thinking that it is a subvolume (of a foreign filesystem).

If fact I added an exception of that rule, because if we pass a block device, we
don't consider the underling filesystem, but the filesystem contained in the block
device. But there is a precedence in get/set label.

Anyway, symlink created some confusion, and I bet that in btrfs there are areas
with incoherence around symlink between the pointed object and the underling
filesystem.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
