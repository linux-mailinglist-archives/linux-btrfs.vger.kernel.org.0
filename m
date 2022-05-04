Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935E519D46
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348211AbiEDKrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 06:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbiEDKrn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 06:47:43 -0400
X-Greylist: delayed 1076 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 03:44:06 PDT
Received: from mail.bitfolk.com (mail.bitfolk.com [IPv6:2001:ba8:1f1:f019::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16F289A3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
        ; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=myhWUZKhcwVYQlWtYwkDuZGqceLqg/fTdZVVok4vJ8M=; b=mkNKo5ROqend1vwtkKNGH97Bfp
        99B0OtgCB1/n+Mk+hseStZtKWJRvsrT8mZlA62/4U1nWKvnqkE3SILI/oWZXFWjjCEpMsiEjn5WkV
        hfEG8AkWFN0ms8QeFRmsxF52djjyry/fWX3VTXvHPws+fj++DK8I0XxaL8AVV9QVgK0EDh+iHuZga
        LzgY68QWuEteg9YnjF9+OXw1tnrGsFtnC7NCtUK+nOXf6K9WbkzWQ/PWYW3zKJqWKZtmpX40FHUTF
        YseG3sXa0pV0Ugy0oh3wJ+a9+rLael7AAASjAvydkJZlxqNWjONBk/kuW9elrL5n+ERj+oSn4yjZc
        4+L4zrwQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
        (envelope-from <andy@strugglers.net>)
        id 1nmCCv-0004nT-0d
        for linux-btrfs@vger.kernel.org; Wed, 04 May 2022 10:26:09 +0000
Date:   Wed, 4 May 2022 10:26:08 +0000
From:   Andy Smith <andy@strugglers.net>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-ID: <20220504102608.u4oublhjagp5h5hm@bitfolk.com>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
 <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
 <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
 <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
 <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
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

Hi Richard,

On Wed, May 04, 2022 at 12:14:54PM +0200, richard lucassen wrote:
> I fear you did. I cannot mount it -o degraded, I have no working system!

You can pause at the grub menu and edit the current boot selection
to have the additional kernel command line parameter:

    rootflags=degraded

That has the same effect as "Mount -o degraded …" or putting
"degraded" in the fstab options.

Cheers,
Andy

-- 
https://bitfolk.com/ -- No-nonsense VPS hosting
