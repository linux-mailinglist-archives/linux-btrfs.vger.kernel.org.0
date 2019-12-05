Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA844114778
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 20:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfLETJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 14:09:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfLETJh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 14:09:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93A1EAD3A;
        Thu,  5 Dec 2019 19:09:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01242DA733; Thu,  5 Dec 2019 20:09:28 +0100 (CET)
Date:   Thu, 5 Dec 2019 20:09:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Fedja Beader <fedja@protonmail.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs scrub's dmesg log is fairly incomplete (rate-limiting?)
Message-ID: <20191205190926.GY2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Fedja Beader <fedja@protonmail.ch>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <vUErpfAvw9qUQBdsnjSDPapkhGqQEiGTOQKkj-wi4gVFVTgR-GoTF2UhvaLFuX-IHk7jNXX9D4mOwa7rjXSGJ6wpUZjg4YKO7YCY7Bm5FUU=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vUErpfAvw9qUQBdsnjSDPapkhGqQEiGTOQKkj-wi4gVFVTgR-GoTF2UhvaLFuX-IHk7jNXX9D4mOwa7rjXSGJ6wpUZjg4YKO7YCY7Bm5FUU=@protonmail.ch>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 01, 2019 at 09:52:13PM +0000, Fedja Beader wrote:
> I had a broken hard-disk from which ddrescue recovered all but about
> 1600MB of data. As a result, the copy of it had roughly 50000
> uncorrectable errors as reported after scrub.
> 
> I have saved the dmesg log recorded during this scrub, parsed logical
> numbers out of it and finaly used "btrfs inspect-internal
> logical-resolve" to obtain a list of files.
> 
> However, after manually removing or restoring those files, the
> subsequent run of "btrfs scrub" still produced >45000 uncorrectable
> errors. Indeed, the reported files that were again obtained with the
> above method, are damaged (input/output error on cat > /dev/null).
> 
> It was suggested that rate-limiting could be the cause of this. I then
> recompiled the kernel with the (the, as in 4.9.24 there is only one
> occurance of it in btrfs_printk) "if (__ratelimit..." conditional
> commented out, rebooted and disabled dmesg ratelimiting with sysctl
> kernel.printk_ratelimit=0. Then again ran scrub.
> 
> The result of this scrub was 41000 uncorrectable errors. However,
> after manually repairing all the problems and re-running scrub, 39000
> uncorrectable errors still remain.
> 
> Is there more rate-limiting going on? If so, how do I disable it?

That's indeed caused by ratelimiting. There are __ratelimit calls
specific to the scrub error messages (called in
scrub_handle_errored_block, scrub_print_warning). You can remove the
ratelimiting and get the flood of the messages for processing.

The dmesg messages are more or less supposed to point out to a handful
of problems like a few damaged blocks, for 40k messages it would be
really a lot. The ratelimiting can happen also internally when printk
decides that it throws away the messages (though I know it's trying not
to).
