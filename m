Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583BC41CC02
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbhI2SkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 14:40:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44886 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbhI2SkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 14:40:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC4521FE14;
        Wed, 29 Sep 2021 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632940714;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9aMuW62mCdd1ndohFxkQoHbusoXGRNJcGoLUBAuPaLo=;
        b=BTXiBGPRfdADcdnC3n6PDqAAceHGMFgwrS1a0TzgcZtYiynKOw9Kncj5aWxHjgSTgi25jd
        YGof1Vh7EnjkL7ZMgvcBOCdhMm2txoPfF63WXNJ1cQH4qjb1hL09ElsU4UOayDTIdcP8aB
        B7OGyfUpxSXcoqkKstHqEFc/WwzrHPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632940714;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9aMuW62mCdd1ndohFxkQoHbusoXGRNJcGoLUBAuPaLo=;
        b=kmqTpTzNuMZ1bYBCmc18WZU1Zsoe/lovw9O2hDKeKdJqGb1cUvwPhTMTnMRxLXhcUF6ZKk
        tSXT1GANYFW0AOBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A4B37A3B81;
        Wed, 29 Sep 2021 18:38:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 26BFEDA7A9; Wed, 29 Sep 2021 20:38:18 +0200 (CEST)
Date:   Wed, 29 Sep 2021 20:38:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
Message-ID: <20210929183817.GQ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
 <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 09:59:15AM +0300, Nikolay Borisov wrote:
> On 29.09.21 г. 2:03, Anand Jain wrote:
> > On 28/09/2021 20:37, Nikolay Borisov wrote:
> >> Currently btrfs-progs will happily enumerate any device which has a
> >> btrfs filesystem on it. For the majority of use cases that's fine and
> >> there haven't been any problems with that.
> > 
> >> However, there was a recent
> >> report
> > 
> >  Could you point to the report or if it is internal?
> 
> Internal
> 
> > 
> >  Kernel message has the process of name for the device scan.
> >  We don't have to fix the btrfs-progs end if it is not doing it.
> > 
> >> that in multipath scenario when running "btrfs fi show" after a
> >> path flap 
> > 
> >  It is better to use 'btrfs fi show -m' it provides kernel perspective.
> 
> [146822.972653] BTRFS warning: duplicate device /dev/sdd devid 1
> generation 8 scanned by systemd-udevd (6254)
> 
> [146823.060984] BTRFS info (device dm-0): devid 1 device path
> /dev/mapper/3600140501cc1f49e5364f0093869c763 changed to /dev/dm-0
> scanned by systemd-udevd (6266)
> 
> [146823.075084] BTRFS info (device dm-0): devid 1 device path /dev/dm-0
> changed to /dev/mapper/3600140501cc1f49e5364f0093869c763 scanned by
> systemd-udevd (6266)
> 
> 
> btrfs fi show -m is actually consistent with always showing the mapper
> device.
> 
> > 
> >  What do you mean by path flap here? Do you mean a device-path in a
> > multi-path config disappeared forever or failed temporarily?
> 
> flap means going up and down.

Please use a more verbose description like

  "a path can flap (go up and down)"
