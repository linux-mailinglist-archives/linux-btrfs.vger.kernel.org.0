Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE484A90AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 23:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbiBCW1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 17:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiBCW1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 17:27:55 -0500
X-Greylist: delayed 21402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Feb 2022 14:27:54 PST
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA2C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
        ; s=alpha; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=be8pdCxU3ZUtnFGZV7KS+0bEpKmfAcOJqNiSvdNdJBw=; b=1/UhPfA9XGIgplDMKD5+2/Sm1L
        WaGc+CObrtVaI4QFWSftH7U9PmSr8ZqV2FRjc1ejDsoDaqFwxmYfXxdxcSx3LOIT8SQlvXRmBlErn
        PkwaDMyASc48ffgo5WxXlWC3iHT9S67B/uU7YMrM2GMQERyF1R95/vzncuNh5aena7gBj0i8I8Vf1
        rBzQMmceYLbZmNY7+wvOmfvlsPmiQ0vsp2/KMRpgxgW1P0iO93xsMCYDVkQRfsO9S+oYG+SryFpWv
        IxjimSrphdiSJuzUfreSp1V/d0hGslvQ+Era5DzaZ1HtF1O3/gIu//PG6SpsvKlb9mXBoTCABB2CA
        pscWUkcw==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
        (envelope-from <andy@strugglers.net>)
        id 1nFka1-0003uN-3n; Thu, 03 Feb 2022 22:27:53 +0000
Date:   Thu, 3 Feb 2022 22:27:52 +0000
From:   Andy Smith <andy@strugglers.net>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: "Too many links (31)" issue
Message-ID: <20220203222752.7x4nq4y6wgi6anfi@bitfolk.com>
References: <20220203163108.ipdv3yxbe7eb6vc4@bitfolk.com>
 <20220203221506.212e72e8@gecko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203221506.212e72e8@gecko>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Lukas,

On Thu, Feb 03, 2022 at 10:15:06PM +0000, Lukas Straub wrote:
> On Thu, 3 Feb 2022 16:31:08 +0000
> Andy Smith <andy@strugglers.net> wrote:
> > I searched around on this topic and found hits from 10 years ago
> > about maximum hardlinks per directory and being dependent upon
> > length of file path. Is that still relevant today?
> > 
> > [...]
> > 
> > Is there anything I can do to get this working?
> 
> Hello, Have you tried the "extended_iref" mount option? 

During my searching I did see mention of it, but as far as I could
see this is a mkfs feature not a mount option, and it's default on
now anyway. So I already have it don't I? (how to check enabled
filesystem features?)

Anyway, it is not recognised as a mount option.

Cheers,
Andy
