Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2094176522
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCBUhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 15:37:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgCBUhN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 15:37:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B67AAC4A;
        Mon,  2 Mar 2020 20:37:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1D91DA7AA; Mon,  2 Mar 2020 21:36:49 +0100 (CET)
Date:   Mon, 2 Mar 2020 21:36:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        wqu@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] progs: mkfs-tests: Skip test if truncate failed with
 EFBIG
Message-ID: <20200302203649.GA2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200224180534.15279-1-marcos@mpdesouza.com>
 <20200302200716.GW2902@twin.jikos.cz>
 <20200302203006.GA22707@hephaestus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302203006.GA22707@hephaestus>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 05:30:06PM -0300, Marcos Paulo de Souza wrote:
> On Mon, Mar 02, 2020 at 09:07:16PM +0100, David Sterba wrote:
> > On Mon, Feb 24, 2020 at 03:05:34PM -0300, Marcos Paulo de Souza wrote:
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > 
> > > The truncate command can fail in some platforms like PPC32[1] because it
> > > can't create files up to 6E in size. Skip the test if this was the
> > > problem why truncate failed.
> > > 
> > > [1]: https://github.com/kdave/btrfs-progs/issues/192
> > 
> > Issue: #192
> 
> David, can you please drop this patch and use the attached one instead? This one
> has been tested by the user who reported the issue in bug 192.
> 
> Thanks,
>   Marcos
> > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Added to devel, thanks.

> >From 52b96ac75c2f8876f1ed9424cef92a4557306009 Mon Sep 17 00:00:00 2001
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> Date: Sat, 15 Feb 2020 19:47:12 -0300
> Subject: [PATCH] progs: mkfs-tests: Skip test if truncate failed with EFBIG
> 
> The truncate command can fail in some platform like PPC32[1] because it
> can't create files up to 6E in size. Skip the test if this was the
> problem why truncate failed.
> 
> [1]: https://github.com/kdave/btrfs-progs/issues/192
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tests/mkfs-tests/018-multidevice-overflow/test.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/mkfs-tests/018-multidevice-overflow/test.sh b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> index 6c2f4dba..b8e2b18d 100755
> --- a/tests/mkfs-tests/018-multidevice-overflow/test.sh
> +++ b/tests/mkfs-tests/018-multidevice-overflow/test.sh
> @@ -14,7 +14,17 @@ prepare_test_dev
>  run_check_mkfs_test_dev
>  run_check_mount_test_dev
>  
> -run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img1"
> +# truncate can fail with EFBIG if the OS cannot created a 6E file
> +stdout=$($SUDO_HELPER truncate -s 6E "$TEST_MNT/img1" 2>&1)

So this is reading and parsing stdout, but not using the standard
helpers that also log the commands. The stdout approach probably works
but I'd still like to avoid using plain $(...)

> +ret=$?
> +
> +if [ $ret -ne 0 ]; then
> +	if [[ "$stdout" == *"File too large"* ]]; then
> +		_not_run "Current kernel could not create a 6E file"
> +	fi
> +	_fail "Truncate command failed: $ret"
> +fi
> +
>  run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img2"
>  run_check $SUDO_HELPER truncate -s 6E "$TEST_MNT/img3"
>  
> -- 
> 2.25.0
> 

