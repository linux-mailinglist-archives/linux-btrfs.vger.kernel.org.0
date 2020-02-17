Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB98161814
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBQQia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 11:38:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728935AbgBQQia (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 11:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581957508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xrwhq1ZkGCeVkJgDZm7aKusobjUIkFeIngZsha42Tis=;
        b=RI32SMksS/ILz45ayWKb+ZwFz0soyoy5uDAg5wb938UgfQ1LBN6QvQS/p0WovgTGw/tZ1i
        EJZf0CsoZjHAVv6ViuFHZTn5A+DiZwFW1XA+S6ZC3ZgfQUEKhVoNJJ9zKi4z5hCYIDIOKT
        ikKG7R1UkW5LU3X+cc0Tb3MIO7AaMMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-ldWIcyuXNe-cg-HbNDBypQ-1; Mon, 17 Feb 2020 11:38:25 -0500
X-MC-Unique: ldWIcyuXNe-cg-HbNDBypQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7034E800D5A;
        Mon, 17 Feb 2020 16:38:24 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA7732CC39;
        Mon, 17 Feb 2020 16:38:23 +0000 (UTC)
Date:   Mon, 17 Feb 2020 11:38:21 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] xfstests: add a CGROUP configuration option
Message-ID: <20200217163821.GB6633@bfoster>
References: <20200214203431.24506-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214203431.24506-1-josef@toxicpanda.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 03:34:31PM -0500, Josef Bacik wrote:
> I want to add some extended statistic gathering for xfstests, but it's
> tricky to isolate xfstests from the rest of the host applications.  The
> most straightforward way to do this is to run every test inside of it's
> own cgroup.  From there we can monitor the activity of tasks in the
> specific cgroup using BPF.
> 

I'm curious what kind of info you're looking for from tests..

> The support for this is pretty simple, allow users to specify
> CGROUP=/path/to/cgroup.  We will create the path if it doesn't already
> exist, and validate we can add things to cgroup.procs.  If we cannot
> it'll be disabled, otherwise we will use this when we do _run_seq by
> echo'ing the bash pid into cgroup.procs, which will cause any children
> to run under that cgroup.
> 

Seems reasonable, but is there any opportunity to combine this with what
we have in common/cgroup2? It's not clear to me if this cares about
cgroup v1 or v2, but perhaps the cgroup2 checks could be built on top of
a generic CGROUP var? I'm also wondering if we'd want to change runtime
behavior purely based on the existence of the path as opposed to some
kind of separate knob (in the event some future test requires the path
for some reason without wanting to enable this mechanism).

Brian

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  README |  3 +++
>  check  | 17 ++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 593c1052..722dc170 100644
> --- a/README
> +++ b/README
> @@ -102,6 +102,9 @@ Preparing system for tests:
>               - set USE_KMEMLEAK=yes to scan for memory leaks in the kernel
>                 after every test, if the kernel supports kmemleak.
>               - set KEEP_DMESG=yes to keep dmesg log after test
> +             - set CGROUP=/path/to/cgroup to create a cgroup to run tests inside
> +               of.  The main check will run outside of the cgroup, only the test
> +               itself and any child processes will run under the cgroup.
>  
>          - or add a case to the switch in common/config assigning
>            these variables based on the hostname of your test
> diff --git a/check b/check
> index 2e148e57..07a0e251 100755
> --- a/check
> +++ b/check
> @@ -509,11 +509,23 @@ _expunge_test()
>  OOM_SCORE_ADJ="/proc/self/oom_score_adj"
>  test -w ${OOM_SCORE_ADJ} && echo -1000 > ${OOM_SCORE_ADJ}
>  
> +# Initialize the cgroup path if it doesn't already exist
> +if [ ! -z "$CGROUP" ]; then
> +	mkdir -p ${CGROUP}
> +
> +	# If we can't write to cgroup.procs then unset cgroup
> +	test -w ${CGROUP}/cgroup.procs || unset CGROUP
> +fi
> +
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
> @@ -615,6 +627,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
>  	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
>  	fi
> +	if [ ! -z "$CGROUP" ]; then
> +	  echo "CGROUP        -- ${CGROUP}"
> +	fi
>  	echo
>  	needwrap=true
>  
> -- 
> 2.24.1
> 

