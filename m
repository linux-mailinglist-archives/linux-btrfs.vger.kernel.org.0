Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE13CD648
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbhGSNVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 09:21:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38383 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237189AbhGSNVm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 09:21:42 -0400
Received: from callcc.thunk.org (50-201-95-250-static.hfc.comcastbusiness.net [50.201.95.250])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16JE2FUh032214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 10:02:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EEA5D4202F5; Mon, 19 Jul 2021 10:02:14 -0400 (EDT)
Date:   Mon, 19 Jul 2021 10:02:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <YPWF5iqB0fOYZd9K@mit.edu>
References: <20210719071337.217501-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719071337.217501-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
> This patch will allow fstests to run custom hooks before and after each
> test case.

Nice!   This is better than what I had been doing which was to set:

export LOGGER_PROG=/usr/local/lib/gce-logger

... and then parse the passed message to be logged for "run xfstests
$seqnum", and which only worked to hook the start of each test.

> diff --git a/README.hooks b/README.hooks
> new file mode 100644
> index 00000000..be92a7d7
> --- /dev/null
> +++ b/README.hooks
> @@ -0,0 +1,72 @@
> +To run extra commands before and after each test case, there is the
> +'hooks/start.hook' and 'hooks/end.hook' files for such usage.
> +
> +Some notes for those two hooks:
> +
> +- Both hook files needs to be executable
> +  Or they will just be ignored

Minor nit: I'd reword this as:

- The hook script must be executable or it
  will be ignored.

> diff --git a/check b/check
> index bb7e030c..f24906f5 100755
> --- a/check
> +++ b/check
> @@ -846,6 +846,10 @@ function run_section()
>  		# to be reported for each test
>  		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>  
> +		# Remove previous $seqres.full before start hook
> +		rm -f $seqres.full
> +
> +		_run_start_hook

I wonder if it would be useful to have the start hook have a way to
signal that a particular test should be skipped.  This might allow for
various programatic tests that could be inserted by the test runner
framework.

(E.g., this is the 5.4 kernel, we know this test is guaranteed to
fail, so tell check to skip the test)

	      	      	       	    	- Ted
