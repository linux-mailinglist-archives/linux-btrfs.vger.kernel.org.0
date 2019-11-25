Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE7108F5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfKYN7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 08:59:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:45140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727655AbfKYN7Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 08:59:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA532AEA7;
        Mon, 25 Nov 2019 13:59:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67CB2DA898; Mon, 25 Nov 2019 14:59:10 +0100 (CET)
Date:   Mon, 25 Nov 2019 14:59:10 +0100
From:   David Sterba <dsterba@suse.cz>
To:     kbuild test robot <lkp@intel.com>
Cc:     Dennis Zhou <dennis@kernel.org>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/22] btrfs: keep track of cleanliness of the bitmap
Message-ID: <20191125135910.GD2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kbuild test robot <lkp@intel.com>,
        Dennis Zhou <dennis@kernel.org>, kbuild-all@lists.01.org,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <06410c758182c36e3af04249721ded50d8f2c62f.1574282259.git.dennis@kernel.org>
 <201911230623.j5g9qeNZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911230623.j5g9qeNZ%lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 23, 2019 at 08:17:13AM +0800, kbuild test robot wrote:
> Hi Dennis,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on kdave/for-next]
> [cannot apply to v5.4-rc8 next-20191122]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Dennis-Zhou/btrfs-async-discard-support/20191121-230429
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!

That does not point to a particular line, but there's

+	/* If we ended in the middle of a bitmap, reset the trimming flag. */
+	if (end % (BITS_PER_BITMAP * ctl->unit))
+		reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));

added and its "u64 % (unsigned long * int)" that could be the cause.
