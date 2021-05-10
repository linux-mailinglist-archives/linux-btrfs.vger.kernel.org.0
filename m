Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A402C3797B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhEJT2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 15:28:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhEJT2f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 15:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C607AAD22;
        Mon, 10 May 2021 19:27:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CEE94DB228; Mon, 10 May 2021 21:25:00 +0200 (CEST)
Date:   Mon, 10 May 2021 21:25:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Sidong Yang <realwakka@gmail.com>
Subject: Re: Btrfs progs release 5.11.1
Message-ID: <20210510192500.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Sidong Yang <realwakka@gmail.com>
References: <20210324192858.19011-1-dsterba@suse.com>
 <CAL3q7H6tRX9C9RYCCaE+PxBcVwht168Kb-m+YVSy2abctuQhWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6tRX9C9RYCCaE+PxBcVwht168Kb-m+YVSy2abctuQhWg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 04:45:10PM +0100, Filipe Manana wrote:
> Btw, due to the new output, this path now makes btrfs/177 from fstests fail:
> 
> btrfs/177 5s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad)
>     --- tests/btrfs/177.out 2020-06-10 19:29:03.822519250 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/177.out.bad
> 2021-04-26 16:25:37.708323523 +0100
>     @@ -1,4 +1,4 @@
>      QA output created by 177
>     -Resize 'SCRATCH_MNT' of '3221225472'
>     +Resize device id 1 (SCRATCH_DEV) from 1.00GiB to 0.00B
>      Text file busy
>     -Resize 'SCRATCH_MNT' of '1073741824'
>     +Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 0.00B

So this this will need an output filter.
