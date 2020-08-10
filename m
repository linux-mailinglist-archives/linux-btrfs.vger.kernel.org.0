Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1322402FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHJHvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 03:51:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgHJHvu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88AEBABD2;
        Mon, 10 Aug 2020 07:52:08 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
Subject: Re: raid10 corruption while removing failing disk
To:     Martin Steigerwald <martin@lichtvoll.de>,
        =?UTF-8?Q?Agust=c3=adn_Dall=ca=bcAlba?= <agustin@dallalba.com.ar>,
        linux-btrfs@vger.kernel.org
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
 <ac06df32-0c18-c17c-64c9-45a04fc82057@suse.com> <16328609.DpnNoz7ane@merkaba>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <376677b3-0e2f-3c53-c706-4362738e6d3f@suse.com>
Date:   Mon, 10 Aug 2020 10:51:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16328609.DpnNoz7ane@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.20 г. 10:38 ч., Martin Steigerwald wrote:
> Hi Nikolay.
> 
> Nikolay Borisov - 10.08.20, 09:22:14 CEST:
>> On 10.08.20 г. 10:03 ч., Agustín DallʼAlba wrote:
> […]
>>> # uname -a
>>> Linux susanita 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34
>>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>
>> This is a vendor kernel so you should ideally seek support through the
>> vendor. This kernel is not even an LTS so it's not entirely clear
>> which patches have/have not been backported. With btrfs it's
>> advisable too use the latest stable kernel as each release brings bug
>> fixes or at the very least (because always using the latest is not
>> feasible) at least stick to a supported long-term stable kernel  -
>> i.e 4.14, 4.19 or 5.4 (preferably 5.4)
> 
> The interesting thing with this recommendation is that it to some part 
> equals:
> 
> Do not use distro / vendor kernels.

On the contrary - it means to use kernels which have support for btrfs.
Namely - Suse distributes kernels with btrfs + have developers who are
familiar with the state of btrfs on their kernel. So if someone hits a
problem on a Suse kernel  - they should report this to Suse and not the
upstream mailing list. Suse's (or any other vendor for that matter)
needn't look anything like the upstream kernel. Same thing with Fedora
or Ubuntu. Since time is limited I (as an upstream developer) would
prefer to spend my time where it would have the most impact - upstream
and not spend possibly hours looking at some custom kernel.

> 
> Consequently vendors shall *just* exclude BTRFS from being shipped?

No, vendors should verify that what they are offering is stable and when
they diverge from upstream should provide support. Fedora for example
spent the time to test btrfs for their use cases + they have the support
from some of the developers to fix issues they find because they
themselves don't have the development expertise (yet) to deal with
btrfs. Furthermore I *think* fedora is sticking to using unadorned
upstream kernels (don't quote me on this, I have never used fedora).


> 
> At one point in BTRFS development, I'd expect BTRFS to be stable enough 
> to be shipped in distro kernels, like XFS, Ext4 and other filesystems.
> 
> For me it appears to be. I used it on 5.8 stable kernel on this laptop, 
> but on another laptop and on two server virtual machines I used the 
> standard Devuan 3 aka Debian 10 kernel (4.19). Without issues so far.
> 
> I am just raising this, cause I would believe that at one point it time 
> it is important to say: It is *okay* to use vendor kernels. Still 
> probably ask your vendor for support first, but it is basically *okay* to 
> use them. On the other hand, regarding Debian, I'd expect I could reach 
> way more experts regarding BTRFS issues on this mailing list than I 
> would find in the Debian kernel team. So I'd probably still ask here 
> first.

Sure, but what guarantees that Debian (or any other distro) have
backported whatever patches are necessary too reach certain stability?
Upstream is a moving target and we (at Suse at least) always target an
upstream-first policy so most effort is spent there.

> 
> What would need to happen for it to be okay to use vendor kernels? Is 
> there a minimum LTS version where you would say it would be okay?
> 
> I am challenging this standard recommendation here, cause I am not sure 
> whether for recent distribution releases it would still be accurate or 
> helpful. At some point BTRFS got to be as stable as XFS or Ext4 I would 
> think. Again, for me it is.
> 
> I have no idea why Ubuntu opted to use a non LTS kernel – especially as 
> 4.15 is pretty old and so does not sound to come from a supported Ubuntu 
> release unless it is some Ubuntu LTS release, but then I'd expect a LTS 
> kernel to be used –, but "-111" indicates they added a lot of patches by 
> now. So maybe they provide some kind of LTS support themselves.

All those are valid assumptions - however without direct experience with
the Ubuntu kernel it's not entirely clear how accurate they are. Hence
my recommendation to address Ubuntu kernel people because they should
know best.

> 
> Best,
> 
