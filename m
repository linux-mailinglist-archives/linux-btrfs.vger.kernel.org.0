Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6133419E76C
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgDDTqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 15:46:32 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:54472 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgDDTqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 15:46:32 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Apr 2020 15:46:31 EDT
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 09F8526D8E87
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Apr 2020 21:38:53 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VMnir62_KxfN for <linux-btrfs@vger.kernel.org>;
        Sat,  4 Apr 2020 21:38:51 +0200 (CEST)
Received: from latitude (x4d0b1289.dyn.telefonica.de [77.11.18.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Apr 2020 21:38:51 +0200 (CEST)
Date:   Sat, 4 Apr 2020 21:38:46 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: unexpected truncated files
Message-ID: <20200404193846.GA432065@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing with the current 5.7 development kernel, I've encountered
some strange behaviour. I'm using Gentoo linux, and during updating the
system I got some unexpected errors. It looked like some files were
missing. Some investigations showed me, that files from shortly
installed packages were truncated to zero. So for example the config
files for apache webserver were affected. I've reinstalled apache,
verified that the config was ok and continued the system update with the
next package. After this, the apache config files were truncated again.
I've found several files from different packages that were affed too,
but only text files (configs, cmake-files, headers). Files which were
writen, are truncated by some other write operation to the filesystem.

I'm not sure, if this is really caused by btrfs, but it's the most
obvious candidate. After switching back to 5.6-kernel, the truncation
stopped und I was able to (re-)install the packages without any trouble.

Has anyone ideas what could cause this behaviour?

-- 
Regards,
  Johannes Hirte

