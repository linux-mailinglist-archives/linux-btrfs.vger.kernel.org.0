Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49A337692
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfFFO0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 10:26:44 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:48778 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFO0o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 10:26:44 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id DD71C142BC3; Thu,  6 Jun 2019 15:26:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1559831202;
        bh=/4s6zncn5HHNPVXo/h8mKJD3pZyHyUVRJNjYSl73I+4=;
        h=To:From:Subject:Date:From;
        b=OUbMtA+oqVJkax7SWZREJA84WTCiLVQ60HNh4O3hIUnMSBMZSLWzn0XKpzpZB4Jqk
         LUV2IdGSybF0+ZK4H4bvJUzc0ZciIkYiZ1rOvJK28NtLNgEZTnF5/WczvHocG5zLgb
         4SH14iDuRXz5IlOk41qT3DtDUSyF9a9NpnlM8lFXEZTVv3WGLX7STdITw2P72xtrDM
         4Wa9XCvan5l53RoOj/kYPbGnzBABNguxJj5Vu88AcTVKQjs2U7a9IOtTj84w3dDp4W
         L5cDi/5ODI+/olFSaSPHkQN0MkHVjRkXGv6dLD5kJaW+2bOtunqpd7G3/DrKQKWKR3
         xF0JSgdDLs5+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 80929142BC2
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 15:26:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1559831202;
        bh=/4s6zncn5HHNPVXo/h8mKJD3pZyHyUVRJNjYSl73I+4=;
        h=To:From:Subject:Date:From;
        b=OUbMtA+oqVJkax7SWZREJA84WTCiLVQ60HNh4O3hIUnMSBMZSLWzn0XKpzpZB4Jqk
         LUV2IdGSybF0+ZK4H4bvJUzc0ZciIkYiZ1rOvJK28NtLNgEZTnF5/WczvHocG5zLgb
         4SH14iDuRXz5IlOk41qT3DtDUSyF9a9NpnlM8lFXEZTVv3WGLX7STdITw2P72xtrDM
         4Wa9XCvan5l53RoOj/kYPbGnzBABNguxJj5Vu88AcTVKQjs2U7a9IOtTj84w3dDp4W
         L5cDi/5ODI+/olFSaSPHkQN0MkHVjRkXGv6dLD5kJaW+2bOtunqpd7G3/DrKQKWKR3
         xF0JSgdDLs5+Q==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 4CBA26B0C4
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 15:26:42 +0100 (BST)
To:     linux-btrfs@vger.kernel.org
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Scrub resume failure
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <932d9793-96b4-fd54-ae97-62c3b54b0f7e@cobb.uk.net>
Date:   Thu, 6 Jun 2019 15:26:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a btrfs filesystem which I want to scrub. This is a multi-TB
filesystem and will take well over 24 hours to scrub.

Unfortunately, the scrub turns out to be quite intrusive into the system
(even when making sure it is very low priority for ionice and nice).
Operations on other disks run excessively slowly, causing timeouts on
important actions like mail delivery (causing bounces).

So, I break it up. I run it for some interval (hours), with the
time-critical services stopped. Then I cancel the scrub and let mail
delivery run for a while. Then I stop mail again and resume the scrub
for another interval, etc.

This works and solves the mail bounce problem.

However, after a few cancel/resume cycles, the scrub terminates. No
errors are reported but one of the resumes will just immediately
terminate claiming the scrub is done. It isn't. Nowhere near.

The disk being scrubbed is in use during all this. It doesn't get a
heavy load but it is my main backup disk and various backups happen,
some of them involving snapshots being created and deleted.

Glancing at the use of the ioctl in the btrfs-progs code, I assume the
resume is using the last_physical from the last run as the start for the
next. Does that break if the filesystem has changed and that is no
longer a used block or something? If so, I think that makes resume useless.

If this is not expected behaviour I will do more work to analyse and
reproduce.

Graham
