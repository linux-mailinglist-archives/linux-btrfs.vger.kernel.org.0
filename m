Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF6F2403AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHJI5S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 10 Aug 2020 04:57:18 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:50771 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgHJI5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 04:57:18 -0400
X-Greylist: delayed 4747 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Aug 2020 04:57:16 EDT
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 2545E13338A;
        Mon, 10 Aug 2020 10:57:15 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     =?utf-8?B?QWd1c3TDrW4gRGFsbMq8QWxiYQ==?= <agustin@dallalba.com.ar>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: raid10 corruption while removing failing disk
Date:   Mon, 10 Aug 2020 10:57:14 +0200
Message-ID: <2125350.iAHHoZBEP4@merkaba>
In-Reply-To: <376677b3-0e2f-3c53-c706-4362738e6d3f@suse.com>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar> <16328609.DpnNoz7ane@merkaba> <376677b3-0e2f-3c53-c706-4362738e6d3f@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay Borisov - 10.08.20, 09:51:47 CEST:
> On 10.08.20 г. 10:38 ч., Martin Steigerwald wrote:
> > Hi Nikolay.
> > 
> > Nikolay Borisov - 10.08.20, 09:22:14 CEST:
> >> On 10.08.20 г. 10:03 ч., Agustín DallʼAlba wrote:
> > […]
> > 
> >>> # uname -a
> >>> Linux susanita 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9
> >>> 20:32:34
> >>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> >> 
> >> This is a vendor kernel so you should ideally seek support through
> >> the vendor. This kernel is not even an LTS so it's not entirely
> >> clear which patches have/have not been backported. With btrfs it's
> >> advisable too use the latest stable kernel as each release brings
> >> bug fixes or at the very least (because always using the latest is
> >> not feasible) at least stick to a supported long-term stable
> >> kernel  - i.e 4.14, 4.19 or 5.4 (preferably 5.4)
> > 
> > The interesting thing with this recommendation is that it to some
> > part equals:
> > 
> > Do not use distro / vendor kernels.
> 
> On the contrary - it means to use kernels which have support for
> btrfs. Namely - Suse distributes kernels with btrfs + have developers
> who are familiar with the state of btrfs on their kernel. So if
> someone hits a problem on a Suse kernel  - they should report this to
> Suse and not the upstream mailing list. Suse's (or any other vendor
> for that matter) needn't look anything like the upstream kernel. Same
> thing with Fedora or Ubuntu. Since time is limited I (as an upstream
> developer) would prefer to spend my time where it would have the most
> impact - upstream and not spend possibly hours looking at some custom
> kernel.

While I get your argument and I bet SUSE support for BTRFS has improved 
a lot, I also still remember that SUSE supported BTRFS in SLES while it 
was still being unstable. With SLES 11 SP 2/3, not sure from memory 
which one it was, I had 2 GiB free in a BTRFS file system, yet got "no 
space left on device" with no ability to delete a file, remove a snapshot 
or do anything else about this, except to add a new virtual disk to 
BTRFS, delete something then. All of this happened cause the standard 
settings for Snapper created a huge lot of snapshots. I do not know how 
much for sure, but I made sure I had quite some free space as I 
installed SLES, knowing of free space related issues back then. All I 
did to trigger the failure condition was to install some OpenLDAP to do 
some example solutions for a training of mine and letting it sit over 
night. Next morning no remove desktop login anymore due to the out of 
space issue.

So my firm statement here is: SUSE used an instable version of BTRFS on 
this older SLES release. In my trainings I recommend at least SLES 12, 
preferably SLES 15 for BTRFS usage, preferable with latest service pack. 
I cannot prove it anymore, without installing such a VM again, cause I 
do not have that VM image anymore. But I remember what I have seen. With 
SLES 11 SP2/3 BTRFS was not really ready for production use – that was 
at least my experience.

So I still wonder: When is BTRFS in upstream to be considered stable 
enough to be used in distro kernels, at least when they are based on LTS 
kernels and updated to their latest releases regularly? I believe it 
would or should be by now. Or otherwise asked: Since which upstream LTS 
kernel can BTRFS be considered stable enough for *production use*?

My last issues had been around Linux 4.4 or 4.5. Since 4.6 I personally 
have no issues anymore… but what is upstream developers idea on this?

[…]
> > What would need to happen for it to be okay to use vendor kernels?
> > Is
> > there a minimum LTS version where you would say it would be okay?
> > 
> > I am challenging this standard recommendation here, cause I am not
> > sure whether for recent distribution releases it would still be
> > accurate or helpful. At some point BTRFS got to be as stable as XFS
> > or Ext4 I would think. Again, for me it is.
> > 
> > I have no idea why Ubuntu opted to use a non LTS kernel – especially
> > as 4.15 is pretty old and so does not sound to come from a
> > supported Ubuntu release unless it is some Ubuntu LTS release, but
> > then I'd expect a LTS kernel to be used –, but "-111" indicates
> > they added a lot of patches by now. So maybe they provide some kind
> > of LTS support themselves.
> All those are valid assumptions - however without direct experience
> with the Ubuntu kernel it's not entirely clear how accurate they are.
> Hence my recommendation to address Ubuntu kernel people because they
> should know best.

Fair enough. I get the recommendation to test against upstream kernel.

At the same you helped Agustín already with an idea that the Ubuntu 
kernel team may not have been aware of.

So I am still challenging any notion that people should not write to 
this list when they have trouble, even when they use some recent enough 
distribution kernel. My question though still is: What would be recent 
enough? 4.19, 5.4, 4.6, 5.7? When would upstream consider it to be 
recent enough to ask here?

At the same time of course you are free not to respond to a mail, in 
case you consider it too much trouble or time needed…

Ciao,
-- 
Martin


