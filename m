Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126E2C19A5
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2019 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfI2Vor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Sep 2019 17:44:47 -0400
Received: from mail.render-wahnsinn.de ([176.9.37.177]:38942 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbfI2Vor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Sep 2019 17:44:47 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Sep 2019 17:44:46 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with robert.krig@render-wahnsinn.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1569793138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=46F22UjIa9NoWDGGNTTOQ8C3YAdBkeA7ckXVsje82KM=;
        b=SRgqhycgPEJJg//HDQ8Ij7dUgOHgB/lc7/GQGdt2YlT3GgMLXFZpnQhjHqEV88MMg4WYOo
        4lI1fzfa+/KSUI3PkmZKtHyJyfqcwlOSZIzdV8S9gVDYs9XfOp6GPKHBXSp9QUD0yY81t0
        ITquuPb4prmCP0Lh4F5/yi1bfLTHKsgBwhqqiSYagj9PsVjU9eGmQmc7WQ/FADM7pbm81W
        ramysS2DBWm9N9GYlb7TVAngrU0O1AALXLtku+tSeRhaCZYSrF+bApDuOzLOnwh7OHzJQk
        bduKjwat39wLDK1v2rxkQY+SzABb+SPi41M1sCGIg+osjARWO9Hpyin0mtxpVQ==
Message-ID: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
Subject: BTRFS Raid5 error during Scrub.
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Sun, 29 Sep 2019 23:38:55 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=render-wahnsinn.de; s=dkim; t=1569793138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=46F22UjIa9NoWDGGNTTOQ8C3YAdBkeA7ckXVsje82KM=;
        b=QVNlrdnTwHwDI7Ylmifqk6nfZCnJ882rAyyCVBqDSSShWJgJ7Be6CvW6iuufjinsvK+u3A
        4L7f9+PNTKoKjAc2l9db21LEW20znOpE6/gcy1rnvjbEH1VDebvZHBOSqJVsdWC6Rh04ih
        yxWBw2KGpyN/eOGh6+2JgfJN751s5Wp4O5CTTjnW8N1KAjYfw0AS6jdJmCFaa8Vu76CDeX
        8q1zQsyyfKsdcClFv73TXKOqvsAu3IaTmeQVP87yDpULYlh1cNts/ZKZO5F7860U/SVLoe
        G/fdv8E/AGrPMrRm6XiIGvbEjlgB3SVwejHX5Hqt5RBp+4u9vTOFjIC1BStknA==
ARC-Seal: i=1; s=dkim; d=render-wahnsinn.de; t=1569793138; a=rsa-sha256;
        cv=none;
        b=az+8hcFVFv6xrdoZ72nDhMlErfKUQYLg9ugy7yJ+ZeT/MEaqDU/+9ME2dAtq8muwJj+zjy
        2XxACI7S0fqUKgn0/CqmADP1KtTnm14BfczHBWU1Bv82BMbddIN0ezoRdB19y63Tz5O+EC
        q0r1VT7RTvsaIxA4mpQQK5tW2WMQwhK8sKwlixjMykdORkvCT+Pkrfarsjs6NLLiIl7Pw8
        Dp2ZfdpM6Pj36t3Gc/p+Fpy8XpVM/GNTYuzgMtVIhGKI77Qag47VsOAXFok1T5deeqyVw8
        1syQ25JR36uV+IdgveTDzvxrEgexZ9ySVmEFixDJ18q/ekSIAMx2MAZKHTExBw==
ARC-Authentication-Results: i=1;
        mail.render-wahnsinn.de;
        auth=pass smtp.mailfrom=robert.krig@render-wahnsinn.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys. First off, I've got backups so no worries there. I'm just
trying to understand what's happening and which files are affected.
I've got a scrub running and the kernel dmesg buffer spit out the
following:

BTRFS warning (device sda): checksum/header error at logical
48781340082176 on dev /dev/sdb, physical 5651115966464: metadata leaf
(level 0) in tree 7
BTRFS warning (device sda): checksum/header error at logical
48781340082176 on dev /dev/sdb, physical 5651115966464: metadata leaf
(level 0) in tree 7
BTRFS error (device sda): bdev /dev/sdb errs: wr 0, rd 0, flush 0,
corrupt 0, gen 1
BTRFS error (device sda): unable to fixup (regular) error at logical
48781340082176 on dev /dev/sdb
BTRFS warning (device sda): checksum/header error at logical
48781340082176 on dev /dev/sdc, physical 5651115966464: metadata leaf
(level 0) in tree 7
BTRFS warning (device sda): checksum/header error at logical
48781340082176 on dev /dev/sdc, physical 5651115966464: metadata leaf
(level 0) in tree 7
BTRFS error (device sda): bdev /dev/sdc errs: wr 0, rd 0, flush 0,
corrupt 0, gen 1
BTRFS error (device sda): unable to fixup (regular) error at logical
48781340082176 on dev /dev/sdc

Is there any way I can find out which files are affected so that I can
just restore them from a backup? 

I'm running Debian Buster with Kernel 5.2.
Btrfs-progs v4.20.1


Let me know if you need any further info.

