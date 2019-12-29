Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6912CB4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 00:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfL2XFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 18:05:03 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:35006 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2XFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 18:05:03 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Dec 2019 18:05:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577660701;
        s=strato-dkim-0002; d=nezwerg.de;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=3MQUfjvx/XwYIHWOxe0LdPuWebQyY0SZN54lao6MEKs=;
        b=eMHGvd3KzWOKJ+kquFIHctXHlFf0Yis7rITTClendzsF8vQwo8OkVhx+WUN9GsF+Wn
        cBpscQtYe2nSQkmxWSy9eshCAekN4eyQ/HOlFmHqSNFO0zAzPiFYUVUX4ic35460Jlz5
        EPMKJyYVx/HEAmPIB+8Y2xVPknDwiIkR6eWlfPo/7WsBdA4nnlhegEVedKL0bKj0tmoM
        OkitEeUo4bwSf845seDtsa3xY5jJrkr/o0Me9sxXDmPBHvi0lD+byLfwTLaejM3VQgyi
        cGj0LjMGWtQMYhR/D6v3sV0B92khgx+GPib4bETTmeFGoU2RkXk4atqdqDVuFpDjdorH
        BCTg==
X-RZG-AUTH: ":IGUXYWCmfuWscPL1D1JO6dFpyf1vPb4ynTLEQ3AnwxYpaMfYGxWjqjPE6tdStKZqMqKJww=="
X-RZG-CLASS-ID: mo00
Received: from mail
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id z06983vBTMwwB9p
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <linux-btrfs@vger.kernel.org>;
        Sun, 29 Dec 2019 23:58:58 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   Alexander Veit <list@nezwerg.de>
Subject: Intregrity of files restored with btrfs restore
Message-ID: <7fe8e3e1-ebea-7c61-cf3b-a0e0c6493577@nezwerg.de>
Date:   Sun, 29 Dec 2019 23:58:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs restore has recovered files from a crashed partition.  The command
used was

btrfs restore -m -v /dev/sdX /dst/path/

without further options like -i etc.

Are the recovered files consistent in the sense that if the file was
committed to disk and was not open during the crash, then the content of
the file would be the same as before the crash, and that damage to files
during the crash (e.g. by random writes) would result in the file not
being recovered by btrfs restore?

I could not find a clear statement about this in the man page or the
btrfs wiki.

# uname -a
Linux healer 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07) x86_64
GNU/Linux

# btrfs --version
btrfs-progs v5.4

The btrfs file system had been created in a system with a Linux 4.19.72
kernel.

-- 
Thanks in advance,
Alex
