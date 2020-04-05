Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B184019EC28
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDEOvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 10:51:31 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:58248 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgDEOva (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Apr 2020 10:51:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 2B89226E05E3;
        Sun,  5 Apr 2020 16:51:28 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g1zko7_PMvce; Sun,  5 Apr 2020 16:51:25 +0200 (CEST)
Received: from latitude (x4e373139.dyn.telefonica.de [78.55.49.57])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Sun,  5 Apr 2020 16:51:25 +0200 (CEST)
Date:   Sun, 5 Apr 2020 16:51:21 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: unexpected truncated files
Message-ID: <20200405145121.GA952734@latitude>
References: <20200404193846.GA432065@latitude>
 <CAL3q7H4xya8EuBhGsX4gs8V6xdNWpJhjhJj0-KdUJhMnDjHjXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3q7H4xya8EuBhGsX4gs8V6xdNWpJhjhJj0-KdUJhMnDjHjXQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020 Apr 04, Filipe Manana wrote:
> On Sat, Apr 4, 2020 at 8:52 PM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> >
> > While testing with the current 5.7 development kernel, I've encountered
> > some strange behaviour. I'm using Gentoo linux, and during updating the
> > system I got some unexpected errors. It looked like some files were
> > missing. Some investigations showed me, that files from shortly
> > installed packages were truncated to zero. So for example the config
> > files for apache webserver were affected. I've reinstalled apache,
> > verified that the config was ok and continued the system update with the
> > next package. After this, the apache config files were truncated again.
> > I've found several files from different packages that were affed too,
> > but only text files (configs, cmake-files, headers). Files which were
> > writen, are truncated by some other write operation to the filesystem.
> >
> > I'm not sure, if this is really caused by btrfs, but it's the most
> > obvious candidate. After switching back to 5.6-kernel, the truncation
> > stopped und I was able to (re-)install the packages without any trouble.
> >
> > Has anyone ideas what could cause this behaviour?
> 
> It's likely due to file cloning.
> 
> I found this out yesterday but hadn't sent a patch yet, was waiting
> for monday morning.
> I've just sent the patch to the list:
> https://patchwork.kernel.org/patch/11474453/
> 
> Since you are only getting this with small files, it's likely the
> cloning of inline extents causing it, due to some changes in 5.7 that
> changed the file size update logic.
> 
> Can you try it?
> 
> Thanks.

Yes, this was it. Installing the second package for triggering the
truncation was a coincidence. Installing the first package (appache
here) and rebooting triggered the error reliable. With portage (the package
manager from Gentoo) everything is compiled and installed to a a
location on /tmp. After this, the content is copied to the target
location and seems to be done with cloning. With your patch the problem
doesn't occur anymore.

-- 
Regards,
  Johannes Hirte

