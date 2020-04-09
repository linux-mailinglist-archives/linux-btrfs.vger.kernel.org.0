Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A871A378A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgDIPwm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 11:52:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:51916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgDIPwm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 11:52:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94812AF19;
        Thu,  9 Apr 2020 15:52:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F312ADA70B; Thu,  9 Apr 2020 17:52:04 +0200 (CEST)
Date:   Thu, 9 Apr 2020 17:52:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs-progs: tests: Filter output for
 run_check_stdout
Message-ID: <20200409155204.GD5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200407071845.29428-1-wqu@suse.com>
 <20200407071845.29428-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407071845.29428-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 03:18:44PM +0800, Qu Wenruo wrote:
> Since run_check_stdout() can insert INSTRUMENT for all btrfs related
> programs, which could easily pollute the stdout, any caller of
> run_check_stdout() should do proper filter.
> 
> The following callers are affected:
> - misc/004
>   Filter the output of "btrfs ins min-dev-size"
> 
> - misc/009
> - misc/013
> - misc/024
>   They are all calling "btrfs ins rootid", so introduce get_subvolid()
>   function to grab the subvolid properly.
> 
> - misc/031
>   Loose the filter for "btrfs qgroup show". No need for "tail -n 1".
> 
> So we still have the same coverage, but now these tests won't cause
> false alert if we insert INSTRUMENT for all btrfs commands.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/common                                  | 13 ++++++++++++
>  tests/misc-tests/004-shrink-fs/test.sh        | 11 ++++++++--
>  .../009-subvolume-sync-must-wait/test.sh      |  2 +-
>  .../013-subvolume-sync-crash/test.sh          |  2 +-
>  .../024-inspect-internal-rootid/test.sh       | 21 +++++++------------
>  .../031-qgroup-parent-child-relation/test.sh  |  4 ++--
>  6 files changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/common b/tests/common
> index 71661e950db0..f8fc3cfd8b4f 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -169,6 +169,9 @@ run_check()
>  
>  # same as run_check but the stderr+stdout output is duplicated on stdout and
>  # can be processed further
> +#
> +# NOTE: If this function is called on btrfs related command, caller should
> +#	filter the output, as INSTRUMENT can easily pollute the output.
>  run_check_stdout()
>  {
>  	local spec
> @@ -636,6 +639,16 @@ check_min_kernel_version()
>  	return 0
>  }
>  
> +# Get subvolume id for specified path
> +get_subvolid()
> +{
> +	# run_check_stdout may have INSTRUMENT pollating the output,
> +	# need to filter the output.
> +	run_check_stdout "$TOP/btrfs" inspect-internal rootid "$1" | \
> +		grep -e "^[[:digit:]]\+$"

This does not seem much better, now it's specific to the commands and
calling the commands directly in new tests will make it fail.

If we find another command where the extra output must be filtered,
another helper. The instrument-tool specific filtering is IMHO fixed in
one place and future proof.

I want to avoid adding yet another test coding style exception like "for
inspect-internal you must use this helper", we have already enough like
new tests not using the mount/umount helpers or opencoding other
existing helpers.

My idea is to let people write tests in a natural way and adapt the
instrumentation tools as we know what problems they could cause.
