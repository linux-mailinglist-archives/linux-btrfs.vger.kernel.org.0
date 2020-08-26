Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA9252825
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 09:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHZHFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgHZHFI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 03:05:08 -0400
Received: from oker.escape.de (oker.escape.de [IPv6:2a00:1030:1004:107::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1B0C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:05:07 -0700 (PDT)
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.15.2/8.15.2/$Revision: 1.90 $) with ESMTPS id 07Q755XN013747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 09:05:05 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.15.2/8.15.2/Submit) with UUCP id 07Q755Bb013746
        for linux-btrfs@vger.kernel.org; Wed, 26 Aug 2020 09:05:05 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id 07Q74L8u027382
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 09:04:21 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id 07Q74LLc027379;
        Wed, 26 Aug 2020 09:04:21 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     <linux-btrfs@vger.kernel.org>
Subject: Re: Link count for directories
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
        <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
        <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
        <20200824222306.GA26736@angband.pl>
        <5062163c-47ff-f811-7b37-e74e1ef47265@suse.com>
        <A61FAA28-DE0C-42BD-8074-756765C5557E@fb.com>
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   26 Aug 2020 09:04:21 +0200
In-Reply-To: <A61FAA28-DE0C-42BD-8074-756765C5557E@fb.com>; from "Chris Mason" on Tue, 25 Aug 2020 09:46:02 -0400
Message-ID: <ygfd03dkhvu.fsf@tehran.isnogud.escape.de>
Lines:  36
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Mason <clm@fb.com> writes:

> > Wrong, ext4 and xfs do  maintain the count.
> 
> Correct, at least until they hit 65536.

For ext4 the limit is actually 65000 links.  For directories, nlink is
set to 1 if an additional sub-directory is created (and stays at 1
even if you remove directories), while for other file you get EMLNK.

In xfs there seems to be no limit (dirs and other files, I have seen
more than 200000 for both) and btrfs has a limit of 65535 links on
non-directories.

> Find certainly paid attention, but from an optimization point of
> view, dtype in directory entries is dramatically more helpful.

1. dtype is not in POSIX.  OTOH, I seem to remember that POSIX states
   st_link == 1 for directories or otherwise it has the traditional
   value of 2 + sub-directory count.  However, I cannot find this
   anymore.  Is that correct and can anyone give me a pointer?

2. If you just want to find all directories you only need stat(2) on a
   directory and if it has st_nlink == 2 you don't need to read all
   directory entries (with or without dtype).  So this optimization is
   possible with the traditional link count of directories but not
   with dtype.

> I'd want to see big wins from applications before adding this
> into btrfs.

I would expect noticable but not big wins.  However, I'd like adding
this to btrfs just because it looks nicer.  Since ls (and readdir)
gives you the . and .. links they should be counted in the usual way.

urs
