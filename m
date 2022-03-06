Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A4C4CE7FC
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 02:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiCFBBF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 20:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiCFBBE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 20:01:04 -0500
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A82340FB
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 17:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
        ; s=alpha; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sSXlPoPUGSF1zuIkDG/raRi+kX3nhznVJgV1uVMTWDE=; b=Pe2hAtuLAQCRHm0jTV4Ui/ZtSB
        shdnyd1duXBm2xHq06DB4bJojSfUEcrC+or2Q/4+xZpG3Amn912W8aVWKzOrcmj/YU7lAq/tg24Xt
        pUd6O0/pmLn/QhV571PHLb2MxkpQwTMZGTTdWh8P7BxSudbuTCGwGnkuwp3EDHCtNs6mZWO71zuJQ
        mWz6pGNOPv2y/TUlr/mjmytIWkaksWudR0pZrDwX39J4U1vHf83Hl/EQrSJRDSHsEfu8zzMdt+y4U
        6mEpfxODjRNBBt2rWQYRLcpkl4JFQcAOe7w3pPsnnzNo+e/91VJJwByiIowuvVPdQDdXm/UiPwW5A
        tTDHY4Jg==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
        (envelope-from <andy@strugglers.net>)
        id 1nQfFr-0002Jp-HI
        for linux-btrfs@vger.kernel.org; Sun, 06 Mar 2022 01:00:11 +0000
Date:   Sun, 6 Mar 2022 01:00:11 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: status page status - dedupe
Message-ID: <20220306010011.m66pgmvpvetnthok@bitfolk.com>
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
 <YiP5l4Rq9AOuiIKt@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiP5l4Rq9AOuiIKt@hungrycats.org>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL:  http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On Sat, Mar 05, 2022 at 07:00:23PM -0500, Zygo Blaxell wrote:
> bees, duperemove, btrfs-dedupe, and solstice use the safe dedupe ioctl,
> and provide no option to do otherwise.

Is there some issue with combining offline dedupe and compression in
that it undoes all the benefits of the compression? I'm sorry, I
don't know the details and may have got the wrong impression but I
thought I had read here recently that there was negative interaction
here still.

Thanks,
Andy
