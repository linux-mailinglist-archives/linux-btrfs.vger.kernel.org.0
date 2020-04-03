Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1C19DC99
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404212AbgDCRUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 13:20:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgDCRUw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 13:20:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 862ABADAA;
        Fri,  3 Apr 2020 17:20:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F944DA727; Fri,  3 Apr 2020 19:20:16 +0200 (CEST)
Date:   Fri, 3 Apr 2020 19:20:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: Introduce expand_command() to inject
 aruguments more accurately
Message-ID: <20200403172016.GI5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200330070232.50146-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330070232.50146-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 03:02:32PM +0800, Qu Wenruo wrote:
> +# Temporary command array for building real command
> +declare -a cmd_array

This gets declared only once when the script is sourced but there are
numerous calls to 'unset cmd_array'. How does this interact?

The functions are called in the same shell level so this will unset and
destroy the cmd_array, so it can't work after first use of eg.
run_check. So there's some shell magic because this seems to work.

> +expand_command()
> +{
> +	local command_index
> +	local ins
> +	local spec
> +
> +	ins=$(_get_spec_ins "$@")
> +	spec=$(($ins-1))
> +	spec=$(_cmd_spec "${@:$spec}")
> +
> +	if [ "$1" = 'root_helper' ] && _is_target_command "$2" ; then
> +		command_index=2
> +	elif _is_target_command "$1"  ; then
> +		command_index=1
> +	else
> +		# Since we iterate from offset 1, this never get hit,
> +		# thus we won't insert $INSTRUMENT
> +		command_index=0
> +	fi
> +
> +	for ((i = 1; i <= $#; i++ )); do
> +		if [ $i -eq $command_index -a ! -z "$INSTRUMENT" ]; then
> +			cmd_array+=("$INSTRUMENT")

This inserts the contents of INSTRUMENT as one value, that won't work
eg. for INSTRUMENT='valgrind --tool=memcheck' or any extra parameters
passed to valgrind or whatever other tool we'd like to use.

> +		fi
> +		if [ $i -eq $ins -a ! -z "$spec" ]; then
> +			cmd_array+=("$spec")
> +		fi
> +		cmd_array+=("${!i}")
> +
> +	done
> +}
> +
>  # Argument passing magic:
>  # the command passed to run_* helpers is inspected, if there's 'btrfs command'
>  # found and there are defined additional arguments, they're inserted just after
> @@ -145,49 +202,28 @@ _cmd_spec()
>  
>  run_check()
>  {
> -	local spec
> -	local ins
> +	expand_command "$@"

The cmd_array should be reset before it's used to build a new command,
not after.
 
> +	echo "====== RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
> +	if [[ $TEST_LOG =~ tty ]]; then echo "CMD: ${cmd_array[@]}" > /dev/tty; fi
>  
> -	ins=$(_get_spec_ins "$@")
> -	spec=$(($ins-1))
> -	spec=$(_cmd_spec "${@:$spec}")
> -	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
> -	echo "====== RUN CHECK $@" >> "$RESULTS" 2>&1
> -	if [[ $TEST_LOG =~ tty ]]; then echo "CMD: $@" > /dev/tty; fi
> -
> -	# If the command is `root_helper` or mount/umount, don't call INSTRUMENT
> -	# as most profiling tool like valgrind can't handle setuid/setgid/setcap
> -	# which mount normally has.
> -	# And since mount/umount is only called with run_check(), we don't need
> -	# to do the same check on other run_*() functions.
> -	if [ "$1" = 'root_helper' -o "$1" = 'mount' -o "$1" = 'umount' ]; then
> -		"$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
> -	else
> -		$INSTRUMENT "$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
> -	fi
> +	"${cmd_array[@]}" >> "$RESULTS" 2>&1 || _fail "failed: ${cmd_array[@]}"
> +	unset cmd_array 
