Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27BF467CC5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 18:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382413AbhLCRs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 12:48:59 -0500
Received: from multitrading.dk ([92.246.25.51]:59782 "EHLO multitrading.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343541AbhLCRs7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 12:48:59 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 12:48:58 EST
Received: (qmail 89115 invoked from network); 3 Dec 2021 17:38:51 -0000
Received: from multitrading.dk (HELO ?10.0.3.10?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 3 Dec 2021 17:38:51 -0000
Date:   Fri, 3 Dec 2021 18:38:51 +0100
From:   Jens Bauer <jens@gpio.dk>
To:     linux-btrfs@vger.kernel.org
Message-ID: <20211203183851411249.580fb47d@gpio.dk>
Subject: Re-using identical COW entries ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Organization: GPIO
X-Mailer: GyazMail version 1.5.21
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

Thinking about hashing and checksumming, I was wondering ...

Does BTRFS re-use identical COW entries ?
-Eg. if I'm compiling the same sources over and over, producing the same binaries over and over ...
Then the binaries would be deleted, then written again, deleted, ... repeat.

If deletion of unused entries would be just a bit that's set/cleared (which it's probably not, for safety), then 
a COW entry could be re-used quickly (making writes faster).

It would of course require that the COW entry is not modified since last time (but if it was, it would have a different hash/checksum anyway).

Reason for thinking this way, is because I just copied 1.9 TB backup onto a disk-image which is on a BTRFS volume; the disk image uses 1.7TB space so far (and I'm incrementally updating that backup) and I know I have several identical files. Using a disk-image, because seen from Linux, it's a non-native file format.


Love
Jens
