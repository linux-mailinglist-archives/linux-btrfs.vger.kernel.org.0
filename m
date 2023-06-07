Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403B8726ABD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjFGUUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjFGUT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:19:57 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 13:19:36 PDT
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B02710
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:19:36 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 9FFDE1239A0; Wed,  7 Jun 2023 16:12:08 -0400 (EDT)
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: rollback to a snapshot
Date:   Wed, 07 Jun 2023 16:08:45 -0400
In-reply-to: <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Message-ID: <87zg5b821z.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Bernd Lentes <bernd.lentes@helmholtz-muenchen.de> writes:

> Could you propose a setup here which does not use top level subvolumes ?
> I found it very frustrating that everyone says "BTRFS is great, you can do snapshots and easily rollback".
> Because in reality rollback is not easy. How can i avoid to use top level subvolumes ?
> I have some Suse boxes which seem to have a correct default setup. But when i install e.g. an Ubuntu box
> i really don't know how to setup BTRFS manually.
> There was a great Wiki (https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Main_Page.html),
> but now it's outdated. Is there something new ?

The last time I installed Ubuntu on btrfs, the installer automatically
created a top level subvolume named @ and actually installed the system
in that subvolume, then configured grub to tell the kernel to mount the
root btrfs volume with the flag subvol="@" so that the system would boot
normally.  Then you just mount the real root of the filesystem somewhere
else and make a snapshot of the @ subvolume.  When you want to roll
back, you just rename @ to something else, and either rename or create a
new writable snapshot from your previous snapshot and name it @, then
reboot.

