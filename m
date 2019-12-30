Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4953912CB6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfL3AXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 19:23:40 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:25050 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfL3AXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 19:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577665418;
        s=strato-dkim-0002; d=nezwerg.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=n4KSwI2r9zpViu3qST9leGckagmDphi6Hjr+W7trJus=;
        b=YdyXZkURUId81MVQPmXSLi6rN2neBEnFpNyyf0WBfZW6Bg5SPOUtZ8N1YCGu+37L2u
        XF/jmDLUljcEVwWB7v/5N9bbCNT15LolEUTxXMEoOUu2sM/zkO3ABNGEsq5SuQ3AzsJn
        HXPttYobnxi+7OB8ionog+PW0oYSwH0NSiciqJMed5G1F+YlMkvid7qATMs3QwdXjK49
        CcbvcgO3E9FcCHJYd8jTGkBO86VNrjJoqbYFetwmiqJew9tYpPLye14sBNSmACGKGaB2
        yPAyKT9RnrQW/kcUvJzrxZrTD4KwXxlyD8YG9/dJpiFjzi2wDZC/Osa3mXFhwzyQfIU3
        AjAA==
X-RZG-AUTH: ":IGUXYWCmfuWscPL1D1JO6dFpyf1vPb4ynTLEQ3AnwxYpaMfYGxWjqjPE6tdStKZqMqKJww=="
X-RZG-CLASS-ID: mo00
Received: from mail
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id z06983vBU0NcBML
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 30 Dec 2019 01:23:38 +0100 (CET)
Subject: Re: Intregrity of files restored with btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
 <CAJCQCtQQkWmwcCYtUGMNwFUDB-yKiMwZzTBShK0MTRJX9kNxYQ@mail.gmail.com>
From:   Alexander Veit <list@nezwerg.de>
Message-ID: <5ca14b59-9dd7-6de4-aae8-3779e3e02171@nezwerg.de>
Date:   Mon, 30 Dec 2019 01:23:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQQkWmwcCYtUGMNwFUDB-yKiMwZzTBShK0MTRJX9kNxYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 30.12.2019 um 00:20 schrieb Chris Murphy:
> In theory they're fine. But in practice it depends on how the
> application is updating those files. It's possible the updates are
> part of separate transactions, so some of the files may be updated and
> other files not updated, depending on when the crash happened. But
> since there are no overwrites in Btrfs (so long as the files haven't
> had chattr +C set), and if the hardware is honoring barriers,  what
> should be true with a crash is that a restore recovers the most recent
> fully committed version of that file.
> ...

This sounds good. All files on the 6TB partition should have been writen
long before the crash (it's a backup disk that had been transfered to an
external enclosure that failed while reading).

5 files and 5 directories could not be recovered, but this is tolerable
for me.

-- 
Thank you very much,
Alex
