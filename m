Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE316A2EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXJpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 04:45:17 -0500
Received: from mail.render-wahnsinn.de ([176.9.37.177]:32816 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXJpR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 04:45:17 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 04:45:16 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 506247C330
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 10:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1582537175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DOWv6eli4jN1Y3vktXMQWxYpq5Uy0lOvzBvMArtjqiA=;
        b=KEtZofM9eOd+jjTtgfoz0t8xmn7cNwBS6HpMxwYrWaglDMJui/UXhhLk8VfwVqfucgezKa
        n6Y/Mu5uiiO8Ir1ZsQoxUuUyuM5VQ3zltNztjcfbpHVTut1RHRQZ5gaf0qevrKGMZ7lJ58
        d02m36Q9JfGoUOpHJSM6AHyrXPMrVMxMfYM9WDTWXJrW/DK6yLXjm90s+hs6aM32FHhFDX
        KOUQWeaR7tOHFckSid4xFmgGRN4hz2SeRIqwKyZ1r45cI6jkrL1fF/UVH5ZVH4VR2vQMeN
        s7Kn7BhQo9b+o50fCgQt01C3ahf5miPSy7iIxkFJYT/ljZkG6vyHgDwdIBcPNQ==
Message-ID: <e476b0aec351754b3cd72ed7d9135a6900f57554.camel@render-wahnsinn.de>
Subject: scrub resume after suspend not working
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 24 Feb 2020 10:39:25 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys. 

I have a backup server which is running a BTRFS raid10. This server is
in the bedroom. So I have it set to suspend at night because of the
noise, and then a systemd timer which resumes it at 07:00 a.m the next
morning.

As part of the suspend/resume script i issue a btrfs cancel before
suspending and a btrfs scrub resume when the server wakes up again.

I've noticed however that after a suspend the btrfs scrub resume
doesn't seem to work properly. It just never finishes, even if the
original estimate (before the resume) was roughly about 20hours, which
it should have finished in one or two days.

After waking up from a suspend, the btrfs scrub resume does indeed
"resume" but it seems to have forgotten it's progress. It "looks" as
though it just started over. 

Is this expected behavior or is it a bug?


I'm running Debian Buster with backported Kernel 5.4.0 and btrfs
version 5.4.1


