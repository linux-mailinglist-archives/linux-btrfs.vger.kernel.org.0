Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52CE519CAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347223AbiEDKSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiEDKSc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 06:18:32 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [IPv6:2a10:3781:1891:64::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4911172
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 03:14:56 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id ED7A482E88
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 12:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651659294;
        bh=lPV6sfNfH+GUojqcvpd0riByCms52e5voXjej58rGOY=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=Tq+HLqfbsfocxSrCBng+WGDW1MDSEjwqYSmmzd49IbHLR+d+EJSiyQe+fRE4ylUb/
         uxzdHwdO4lBl2eBWd59X4S+R3YBuS03Ws18ikncVFGACcKXAeVNi4pjaqmzV1/743x
         Q2MBa34LA4vFmawA/qgcFC4+UopBBkd/QmqT1caSBBv9/rHo3SZyqoByS6BqEH8Sow
         U+AsjIJthFJZPG9wZT4p1CAcHJloLkKPwTjCu1RjtiDTS+rdazD0x1a2FkF3LNmyEV
         1t0Jm+l1XER82RNZlQIbwsbn5BUzSLCtHvf6R5uPDenjO3IFLztMrIAdOOMxEh7yyb
         6xWbqCDUEUerA==
Date:   Wed, 4 May 2022 12:14:54 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-Id: <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
In-Reply-To: <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
        <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
        <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
        <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
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

On Wed, 4 May 2022 13:07:14 +0300
Nikolay Borisov <nborisov@suse.com> wrote:

> > The wiki explains how to repair an array, but when the array is the
> > root fs you will have a problem.
> > 
> > So, what should I do when the / fs is degraded?
> 
> In case of btrfs raid1 if you managed to mount the array degraded
> it's possible to add another device to the array and then run a
> balance operation so that you end up with 2 copies of your data. I.e
> I don't see a problem? Have I misunderstood you?

I fear you did. I cannot mount it -o degraded, I have no working system!

I need fysical access to the system to repair it, contrary to an md
system, the latter will simply start as 'Degraded Array' even when I'm
abroad...

-- 
richard lucassen
https://contact.xaq.nl/
