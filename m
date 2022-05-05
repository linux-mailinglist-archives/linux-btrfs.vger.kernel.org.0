Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4B51CA9F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358341AbiEEUeV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiEEUeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 16:34:20 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E05EDEB
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 13:30:38 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 61A0D7F80D
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 22:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651782636;
        bh=4qoOF/HAC5TGXaQBCvRjoJnn/Fz7WRuG3BE4jo3Tof4=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=UwTGgRgL9+rqh7ptWNQcrTTuvZo47MmZq0mRlWcTzv07pUOvGlzlTnUwi1A0LCVtL
         MBwGASFVQIsX2zl03z4864GDg5EwzSnjo8EVclz3NfRVw0EtIGHbHAu+zHfCxU+v2k
         sRrR+J6nqcJLJqx4S5MAYl3cL9zKwXZAbr6r3Yxb7HAfT36rude3qjPVcc1itluSwT
         L+XVZcucheiiJcj+H0DmrDnlpFcTjsmVPZR/XynHD1EoJaHNIIXCzcfJJw2tQ73zcA
         wWncV6imnKD7t/QVf44nc2NnLrj5h5q6jg0kfKxLB5bRYLjtz9QMPSVkjK1yGLe7NA
         X6q/z1FeyTjTA==
Date:   Thu, 5 May 2022 22:30:35 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-Id: <20220505223035.897276af866f761c7a46b7d9@lucassen.org>
In-Reply-To: <09b97c23-5933-7814-9cd9-72e95b0ffadd@suse.com>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
        <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
        <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
        <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
        <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
        <42d841fc-d4ee-37e1-470f-4ac5c821afc7@gmail.com>
        <20220504213349.b49135a060ec1d8111794db1@lucassen.org>
        <09b97c23-5933-7814-9cd9-72e95b0ffadd@suse.com>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 5 May 2022 11:27:36 +0300
Nikolay Borisov <nborisov@suse.com> wrote:

> >> No, it will not. Some script(s), as part of startup sequence, will
> >> decide that array can be started even though it is degraded and
> >> force it to be started. Nothing in principle prevents your
> >> distribution from adding scripts to mount btrfs in degraded mode
> >> in this case. Those scripts are not part of btrfs, so you should
> >> report it to your distribution.
> > 
> > Ok thnx! Would it damage btrfs if I add a permanent
> > "rootflags=degraded" to the kernel?
> 
> The flag itself won't have any repercussions on stability but if your 
> only remaining disk crashes while you are in degraded mode, because
> your other disk is already gone then you might lose data.

Ok, but that goes for md devices as well. Under md I can add a "spare"
disk, using btrfs just simply add a third disk.

I will do some more testing this week. Thnx for your support!

R.

-- 
richard lucassen
https://contact.xaq.nl/
