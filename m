Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F9B49BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfIQIot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 04:44:49 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:50701 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfIQIot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 04:44:49 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 04:44:48 EDT
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id 0CFFE20BBCB; Tue, 17 Sep 2019 10:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1568709064;
        bh=I5oaN5TAGEsbEDIIgg9L/aXXWJNqNuIChdsTPTUBw2g=;
        h=To:Subject:Date:From:Cc:From;
        b=lWAyIBaXbppABnDidEdOJTmgmTHFNB9cndohan34AMB4cgzILjzo2tlMGnHLA7R1I
         SD3KrV20vSPoPG+syYZ0f/6CnU/1KRFve3Zd076D0Sh26q6aCjx2kI0/dHWUGW9zM2
         BGuHHHDsCrwuZTerECCHCFT4d4/AZUJiKctMdxoY=
To:     linux-btrfs@vger.kernel.org
Subject: Subpagesize-blocksize: Allow I/O on blocks whose size is less than  page size
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Sep 2019 10:31:04 +0200
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     Chandan Rajendra <chandan@linux.vnet.ibm.com>
Message-ID: <5e481d4f4f323226a2c81caf5e2f78ae@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
What happened to the subpagesize-blocksize patchset? It seems to be 
untouched since 3 years.
I'm currently stuck on Fedora ppc64le because it ships with a 64k page 
size, but I need it to be 4k in order to be able to chroot into foreign 
architectures (like x86_64) with qemu-user.

If I try to mount my btrfs partition with a kernel with page size set to 
4k I get the following error:

sectorsize 65536 not supported yet, only support 4094

I didn't try the patchset, because it doesn't support compression and my 
whole fs is compressed.

It looked like an awesome work, why didn't it get merged?

Bests,
Niccolo'
