Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D7133F1F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgAHKTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 05:19:25 -0500
Received: from mail.render-wahnsinn.de ([176.9.37.177]:37756 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHKTZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 05:19:25 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 05:19:24 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 729505EF39
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2020 11:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1578478409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/cvzA73xrwbGhu8WUY9qrKkSAqDYFcVoLdkCcELnA9o=;
        b=FcDtG4aakqTFSyJnCCuDrbwWigaQHMDC7LW++jqxAtgpqlhp+EIOGTcZ63oACKrYDLUGMv
        2waUlvALgWTKI+MFmX4F/6EmB+g8XthAajmsivYrcmn62AEUdz7oVqnDWCE5XslGzVoVai
        ZnYwu+BgRspM+nK1FP5jIpD08sFokcyP3VCdECA/XW445Vfb1rr2e9qHpcT1123X6rBJge
        NjwMGtCDrF/RoRsBWydSPt6pGqe2kpfxdf36VWX4EFrYU7w5XyaUDuFs633qZEbl37+WXE
        eOsb7rHgrMrNdAUS36u+H6icYyEXxc7LLicADSPXhjnq/5yo3XsbUm9TjEuMBg==
Message-ID: <b2ccde6952d0fa67c9948a21cd3ac8eddcdb3970.camel@render-wahnsinn.de>
Subject: How long should a btrfs scrub with RAID5/6 take?
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Wed, 08 Jan 2020 11:13:18 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I've got a server where I have 4x8TB Disks in a BTRFS RAID5
(metadata and systemdata as RAID1) configuration.

It's just a backup server with data I can always recreate. 
This server is in the bedroom, so I send it to sleep/suspend when I go
to bed and then wake it up in the morning. 

Since a scrub takes days on such a setup, I issue a btrfs scrub resume
whenever the server wakes up again.

btrfs scrub status shows me that the total data to scrub is 18.67TB,
but it's already scrubbed 36.60TB. Is there any way I can calculate how
much more data is going to be scrubbed? 4x8TB is 32TB, so we're passed
that, but I'm guessing this also has to do with parity data as well.

