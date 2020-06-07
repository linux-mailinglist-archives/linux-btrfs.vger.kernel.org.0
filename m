Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05B81F0FED
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgFGVEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGVEp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Jun 2020 17:04:45 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 Jun 2020 14:04:44 PDT
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87BC08C5C3
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 14:04:44 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 937125FA9B;
        Sun,  7 Jun 2020 22:56:06 +0200 (CEST)
Date:   Sun, 7 Jun 2020 13:56:06 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Walter Feddern <Walter.Feddern@exactearth.com>
cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Help with repairing BTRFS system root volume
In-Reply-To: <YTXPR0101MB1902BC1A12C18F9670DA3EBFF9840@YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.22.395.2006071353410.13291@trent.utfs.org>
References: <YTXPR0101MB1902BC1A12C18F9670DA3EBFF9840@YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 7 Jun 2020, Walter Feddern wrote:
> I have a system that is running opensuse (42.3), that will now only mount its root file system in read only mode.
> I know this is an old opensuse, which means old kernel and btrfs version, but it was required by a third party to run a specific software package. 
> This is a VMware virtual machine, which gives me the luxury of making a clone and performing repair attempts on the clone.

This being a virtual system, did you attempt to attach the disk to a more 
recent Linux system, and see if it's able to mount/repair the file system? 

In there you could also setup networking to get more precise strack traces 
instead of OCR :)

Good luck,
C.
-- 
BOFH excuse #282:

High altitude condensation from U.S.A.F prototype aircraft has contaminated the primary subnet mask. Turn off your computer for 9 days to avoid damaging it.
