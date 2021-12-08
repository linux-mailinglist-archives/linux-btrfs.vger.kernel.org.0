Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892F946D994
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhLHRZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 12:25:25 -0500
Received: from campbell-lange.net ([178.79.140.51]:48566 "EHLO
        campbell-lange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhLHRZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 12:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=campbell-lange.net; s=it; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tlArAMc2plRWILWapz9nbQurV4Noh0wtMNccedX5uKE=; b=izTHCYoXXIim1RXvDpPGhs3dEK
        ZAKUlDP0zMOp9JpUluVaJD6VKoxW3RtGyCpn9n31kkvjt6h8KFD1uzkIb46K1t657LfRicSZ4WgPw
        QCH5p8ucE2oX1VSdIl+To5n/cm0Iv7gXCW0PuVYyZFhXLJsKzjDLXNBCFsVojyDzcolM=;
Received: from [217.138.52.158] (helo=rory-t470s)
        by campbell-lange.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rory@campbell-lange.net>)
        id 1mv0db-0002xd-PT; Wed, 08 Dec 2021 17:21:51 +0000
Received: from rory by rory-t470s with local (Exim 4.94.2)
        (envelope-from <rory@rory-t470s>)
        id 1mv0db-000KlL-C6; Wed, 08 Dec 2021 17:21:51 +0000
Date:   Wed, 8 Dec 2021 17:21:51 +0000
From:   Rory Campbell-Lange <rory@campbell-lange.net>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: trouble replacing second disk from pair
Message-ID: <YbDpr5mlHhGhHGwd@campbell-lange.net>
References: <YbCnrqxHJxYPATj9@campbell-lange.net>
 <20211208180955.170c6138@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208180955.170c6138@nvm>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/12/21, Roman Mamedov (rm@romanrm.net) wrote:
> On Wed, 8 Dec 2021 12:40:14 +0000
> Rory Campbell-Lange <rory@campbell-lange.net> wrote:
> 
> > We're trying to upgrade the disks in a btrfs pair, and I have successfully replaced one of them using btrfs replace. I presently have 
> > 
> > Label: 'btrfs-bkp'  uuid: da90602a-b98e-4f0b-959a-ce431ac0cdfa
> > 	Total devices 2 FS bytes used 700.29GiB
> > 	devid    2 size 2.73TiB used 1.73TiB path /dev/mapper/cdisk4
> > 	devid    3 size 2.73TiB used 1.75TiB path /dev/mapper/cdisk2
> > 
> > I'd like to get rid of cdisk2 and replace it with a new disk.
> > 
> > However I'm unable to mount cdisk4 (the new disk) in degraded mode to allow me to similarly replace cdisk2 as I previously did for cdisk3. Is this because some of the data in only on cdisk2? If so I'd be grateful to 
> > know how to ensure the two disks have the same data and to allow cdisk2 to be replaced.
> 
> Looks like you need to ensure everything is RAID1 first:
> 
>   btrfs balance start -dconvert=raid1,soft /bkp
>   btrfs balance start -mconvert=raid1,soft /bkp
>   btrfs balance start -sconvert=raid1,soft /bkp
> 
> It might warn you about operating on system chunks, but I believe this still
> needs to be done. 

I wasn't able to run system chunks (-s) on btrfs 4.20.1-2 (debian) without
forcing it:

    ERROR: Refusing to explicitly operate on system chunks.
    Pass --force if you really want to do that.

Happily everything worked fine after running the data and metadata balances.

Thanks very much indeed for the advice.

Rory
