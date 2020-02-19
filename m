Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA547164921
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBSPs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 10:48:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39712 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgBSPs5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 10:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582127335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DT7aFJAh23dHoZpH0eLd5kmPeKKGcbZd8iNss+Inec=;
        b=ejWULTSCPCcvl1GUH9uQ6qDLp7h5GKIm5JLR8LTW4XE8n96HM1wYbm0OfXyDyFlKmAaBK/
        A4KVeoWHkPRTgZDpWOvrXuaw+6pGofg13HycSEPGNROPt5Xyr0c1DjSep7+DC0uGR6JUXl
        MaWKzloEForXoa9UQ9u9CMX9RGC4mKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-0x49lKaEOk2Jw0exjjmdQA-1; Wed, 19 Feb 2020 10:48:53 -0500
X-MC-Unique: 0x49lKaEOk2Jw0exjjmdQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51ED51034B3B;
        Wed, 19 Feb 2020 15:48:52 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D51075C112;
        Wed, 19 Feb 2020 15:48:51 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:48:50 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH][v2] xfstests: add a option to run xfstests under a cgroup
Message-ID: <20200219154850.GF24157@bfoster>
References: <20200218152712.3750130-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218152712.3750130-1-josef@toxicpanda.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 18, 2020 at 10:27:12AM -0500, Josef Bacik wrote:
> I want to add some extended statistic gathering for xfstests, but it's
> tricky to isolate xfstests from the rest of the host applications.  The
> most straightforward way to do this is to run every test inside of it's
> own cgroup.  From there we can monitor the activity of tasks in the
> specific cgroup using BPF.
> 
> The support for this is pretty simple, allow users to pass -C <cgroup
> name>.  We will create the path if it doesn't already exist, and
> validate we can add things to cgroup.procs.  If we cannot it'll be
> disabled, otherwise we will use this when we do _run_seq by echo'ing the
> bash pid into cgroup.procs, which will cause any children to run under
> that cgroup.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Changed it from a local.config option to a command line option.
> - Export CGROUP2_PATH for everything, utilize that path when generating our
>   cgroup for the scripts to run in.
> 
>  check          | 24 +++++++++++++++++++++++-
>  common/cgroup2 |  2 --
>  common/config  |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/check b/check
> index 2e148e57..df33628e 100755
> --- a/check
> +++ b/check
> @@ -72,6 +72,7 @@ check options
>      --large-fs		optimise scratch device for large filesystems
>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
> +    -C cgroup_name	run all the tests in the specified cgroup name
>  
>  testlist options
>      -g group[,group...]	include tests from these groups
> @@ -101,6 +102,10 @@ excluded from the list of tests to run from that test dir.
>  external_file argument is a path to a single file containing a list of tests
>  to exclude in the form of <test dir>/<test name>.
>  
> +cgroup_name is just a plain name, or a path relative to the root cgroup path.
> +If CGROUP2_PATH does not point at where cgroup2 is mounted then adjust it
> +accordingly.
> +
>  examples:
>   check xfs/001
>   check -g quick
> @@ -307,6 +312,7 @@ while [ $# -gt 0 ]; do
>  		;;
>  	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
>  	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> +	-C)	CGROUP=$2 ; shift ;;
>  
>  	-*)	usage ;;
>  	*)	# not an argument, we've got tests now.
> @@ -509,11 +515,24 @@ _expunge_test()
>  OOM_SCORE_ADJ="/proc/self/oom_score_adj"
>  test -w ${OOM_SCORE_ADJ} && echo -1000 > ${OOM_SCORE_ADJ}
>  
> +# Initialize the cgroup path if it doesn't already exist
> +if [ ! -z "$CGROUP" ]; then
> +	CGROUP=${CGROUP2_PATH}/${CGROUP}
> +	mkdir -p ${CGROUP}
> +
> +	# If we can't write to cgroup.procs then unset cgroup
> +	test -w ${CGROUP}/cgroup.procs || unset CGROUP
> +fi
> +

Do we need to fix up generic/563 to use this new $CGROUP value, when
set? That test explicitly moves tasks to new/temporary groups, but looks
like it resets back to the top-level CGROUP2_PATH group. I'm not sure
how much that really matters since presumably the next test should move
back into $CGROUP. Otherwise this looks reasonable enough to me.

Brian

>  # ...and make the tests themselves somewhat more attractive to it, so that if
>  # the system runs out of memory it'll be the test that gets killed and not the
>  # test framework.
>  _run_seq() {
> -	bash -c "test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
> +	_extra="test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ};"
> +	if [ ! -z "$CGROUP" ]; then
> +		_extra+="echo $$ > ${CGROUP}/cgroup.procs;"
> +	fi
> +	bash -c "${_extra} exec ./$seq"
>  }
>  
>  _detect_kmemleak
> @@ -615,6 +634,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
>  	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
>  	fi
> +	if [ ! -z "$CGROUP" ]; then
> +	  echo "CGROUP        -- ${CGROUP}"
> +	fi
>  	echo
>  	needwrap=true
>  
> diff --git a/common/cgroup2 b/common/cgroup2
> index 8833c9c8..554bd238 100644
> --- a/common/cgroup2
> +++ b/common/cgroup2
> @@ -1,7 +1,5 @@
>  # cgroup2 specific common functions
>  
> -export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
> -
>  _require_cgroup2()
>  {
>  	if [ `findmnt -d backward -n -o FSTYPE -f ${CGROUP2_PATH}` != "cgroup2" ]; then
> diff --git a/common/config b/common/config
> index 9a9c7760..0eaf35c3 100644
> --- a/common/config
> +++ b/common/config
> @@ -259,6 +259,7 @@ case "$HOSTOS" in
>  	export E2FSCK_PROG=$(type -P e2fsck)
>  	export TUNE2FS_PROG=$(type -P tune2fs)
>  	export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
> +	export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
>          ;;
>  esac
>  
> -- 
> 2.24.1
> 

