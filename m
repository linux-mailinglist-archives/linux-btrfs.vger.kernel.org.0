Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BE12402E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgHJHiO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 10 Aug 2020 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJHiO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:38:14 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69FDC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 00:38:13 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 8CE8C1332EE;
        Mon, 10 Aug 2020 09:38:08 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     =?utf-8?B?QWd1c3TDrW4gRGFsbMq8QWxiYQ==?= <agustin@dallalba.com.ar>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: raid10 corruption while removing failing disk
Date:   Mon, 10 Aug 2020 09:38:07 +0200
Message-ID: <16328609.DpnNoz7ane@merkaba>
In-Reply-To: <ac06df32-0c18-c17c-64c9-45a04fc82057@suse.com>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar> <ac06df32-0c18-c17c-64c9-45a04fc82057@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay.

Nikolay Borisov - 10.08.20, 09:22:14 CEST:
> On 10.08.20 г. 10:03 ч., Agustín DallʼAlba wrote:
[…]
> > # uname -a
> > Linux susanita 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34
> > UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> This is a vendor kernel so you should ideally seek support through the
> vendor. This kernel is not even an LTS so it's not entirely clear
> which patches have/have not been backported. With btrfs it's
> advisable too use the latest stable kernel as each release brings bug
> fixes or at the very least (because always using the latest is not
> feasible) at least stick to a supported long-term stable kernel  -
> i.e 4.14, 4.19 or 5.4 (preferably 5.4)

The interesting thing with this recommendation is that it to some part 
equals:

Do not use distro / vendor kernels.

Consequently vendors shall *just* exclude BTRFS from being shipped?

At one point in BTRFS development, I'd expect BTRFS to be stable enough 
to be shipped in distro kernels, like XFS, Ext4 and other filesystems.

For me it appears to be. I used it on 5.8 stable kernel on this laptop, 
but on another laptop and on two server virtual machines I used the 
standard Devuan 3 aka Debian 10 kernel (4.19). Without issues so far.

I am just raising this, cause I would believe that at one point it time 
it is important to say: It is *okay* to use vendor kernels. Still 
probably ask your vendor for support first, but it is basically *okay* to 
use them. On the other hand, regarding Debian, I'd expect I could reach 
way more experts regarding BTRFS issues on this mailing list than I 
would find in the Debian kernel team. So I'd probably still ask here 
first.

What would need to happen for it to be okay to use vendor kernels? Is 
there a minimum LTS version where you would say it would be okay?

I am challenging this standard recommendation here, cause I am not sure 
whether for recent distribution releases it would still be accurate or 
helpful. At some point BTRFS got to be as stable as XFS or Ext4 I would 
think. Again, for me it is.

I have no idea why Ubuntu opted to use a non LTS kernel – especially as 
4.15 is pretty old and so does not sound to come from a supported Ubuntu 
release unless it is some Ubuntu LTS release, but then I'd expect a LTS 
kernel to be used –, but "-111" indicates they added a lot of patches by 
now. So maybe they provide some kind of LTS support themselves.

Best,
-- 
Martin


