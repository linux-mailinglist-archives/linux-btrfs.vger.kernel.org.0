Return-Path: <linux-btrfs+bounces-12837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C7A7E817
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D63AB5C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA892163B6;
	Mon,  7 Apr 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3IToI36"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197E215F53;
	Mon,  7 Apr 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046571; cv=none; b=g8pKd3TgWedCyPM7uSsduZd7ZkLy4mHsGpnjuYhoyRHdPiyL7aAY02fmJ++px0btFl2+TXl8CP73Tv2CeDkPDyAI9crPzWl2ImhROc2/a8jv4q3ey6Tp5bpC19Ak2opBfN7yPyowR5OMshWnjrimuRxuJc7uqwYvAxqQNukIJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046571; c=relaxed/simple;
	bh=5MiA6rW4LfxN1OJrXvJOkPhxtGriKKOrwlj6xmWs6gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyTlgXvPoR3t6nFwjXhsJMjE+ICqttNXb2UdWJMjlV+xaQ90BOMo9e3p8RyjbUG1BpPd/9vYjvydRm/xn+g6rDT/lAllTpzHhm08Pn0VHHaTKoyYSyjNXCXBUWmxarHHJgxCvfkDihr//aGHmgKCdEbUs+G79AsmTj/SPXeYN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3IToI36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85618C4CEDD;
	Mon,  7 Apr 2025 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744046570;
	bh=5MiA6rW4LfxN1OJrXvJOkPhxtGriKKOrwlj6xmWs6gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3IToI369m7NSrOWL13oQG3F6/buyI3A4dh4ALpCjHsdBGiSEHnKb+hnUcoDx3yyF
	 cqkGLmpXGhDCy2tRwvyFBYDejwApUfsrYU2yRo8mZ3lzbplmWl0YPZNKKJQG9RsVjr
	 UZ52ClNXrC8Oy4FcPYc07S3S57xrrOgPlPvxePPAWnggAlLNVw1ADcuJkYquMk5qxN
	 G74smJ/yS1YDRV2MQpj3rDO0l2AAjdVcQZa4k41UIHoQ5QFQPJeIjr6pr+x9ljHagK
	 FQ9JrA6wrvG4AsbLHqYcAjiUW6cXA1jJ881q2LQI2eHYmIUMcWTNpCudaZVu/fpq58
	 LjvTK5fIpngLQ==
Date: Mon, 7 Apr 2025 10:22:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH v5 4/6] fstests: common/sysfs: add new file sysfs and
 helpers
Message-ID: <20250407172249.GA6274@frogsfrogsfrogs>
References: <cover.1743996408.git.anand.jain@oracle.com>
 <ae857de1a41a1b2946c6ca83165308a13c043bba.1743996408.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae857de1a41a1b2946c6ca83165308a13c043bba.1743996408.git.anand.jain@oracle.com>

On Mon, Apr 07, 2025 at 11:48:18AM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()`
> to verify whether a sysfs attribute rejects invalid input arguments
> during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/sysfs | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 common/sysfs
> 
> diff --git a/common/sysfs b/common/sysfs
> new file mode 100644
> index 000000000000..9f2d77c6b1f5
> --- /dev/null
> +++ b/common/sysfs
> @@ -0,0 +1,141 @@
> +##/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# Common/sysfs file for the sysfs related helper functions.
> +
> +# Test for the existence of a policy at /sys/fs/$FSTYP/$DEV/$ATTR
> +#
> +# All arguments are necessary, and in this order:
> +#  - dev: device name, e.g. $SCRATCH_DEV
> +#  - attr: path name under /sys/fs/$FSTYP/$dev
> +#  - policy: policy within /sys/fs/$FSTYP/$dev
> +#
> +# Usage example:
> +#   _has_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
> +_has_fs_sysfs_attr_policy()
> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +
> +	if [ ! -b "$dev" -o -z "$attr" -o -z "$policy" ]; then
> +		_fail \
> +	     "Usage: _has_fs_sysfs_attr_policy <mounted_device> <attr> <policy>"
> +	fi

Shouldn't this return 1 if the parameters are not fully specified?

> +
> +	local dname=$(_fs_sysfs_dname $dev)
> +	test -e /sys/fs/${FSTYP}/${dname}/${attr}

What is the point of testing path existence here if the function doesn't
actually change its behavior?

> +
> +	cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
> +}
> +
> +# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
> +# and value in it contains $policy
> +# All arguments are necessary, and in this order:
> +#  - dev: device name, e.g. $SCRATCH_DEV
> +#  - attr: path name under /sys/fs/$FSTYP/$dev
> +#  - policy: mentioned in /sys/fs/$FSTYP/$dev/$attr
> +#
> +# Usage example:
> +#   _require_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
> +_require_fs_sysfs_attr_policy()
> +{
> +	_has_fs_sysfs_attr_policy "$@" && return
> +
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local dname=$(_fs_sysfs_dname $dev)
> +
> +	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr} ${policy}"
> +}
> +
> +_set_sysfs_policy()
> +{
> +	local dev=$1
> +	local attr=$2
> +	shift
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $dev $attr ${policy}
> +
> +	case "$FSTYP" in
> +	btrfs)
> +		_get_fs_sysfs_attr $dev $attr | grep -q "[${policy}]"
> +		if [[ $? != 0 ]]; then
> +			echo "Setting sysfs $attr $policy failed"
> +		fi
> +		;;
> +	*)
> +		_fail \
> +"sysfs syntax verification for '${attr}' '${policy}' for '${FSTYP}' is not implemented"
> +		;;
> +	esac
> +}
> +
> +_set_sysfs_policy_must_fail()
> +{
> +	local dev=$1
> +	local attr=$2
> +	shift
> +	shift
> +	local policy=$@
> +
> +	_set_fs_sysfs_attr $dev $attr ${policy} | _filter_sysfs_error \
> +							   | tee -a $seqres.full
> +}
> +
> +# Verify sysfs attribute rejects invalid input.
> +# Usage syntax:
> +#   _verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
> +# Examples:
> +#   _verify_sysfs_syntax $TEST_DEV read_policy pid
> +#   _verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
> +# Note:
> +#  Process must call . ./common/filter
> +_verify_sysfs_syntax()
> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local value=$4
> +
> +	# Do this in the test case so that we know its prerequisites.
> +	# '_require_fs_sysfs_attr_policy $TEST_DEV $attr $policy'

But it's commented out ... ?

--D

> +
> +	# Test policy specified wrongly. Must fail.
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy t'"
> +	_set_sysfs_policy_must_fail $dev $attr "' '"
> +	_set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
> +	_set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
> +	_set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
> +	_set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
> +	_set_sysfs_policy_must_fail $dev $attr "'${policy} '"
> +	_set_sysfs_policy_must_fail $dev $attr _${policy}
> +	_set_sysfs_policy_must_fail $dev $attr ${policy}_
> +	_set_sysfs_policy_must_fail $dev $attr _${policy}_
> +	_set_sysfs_policy_must_fail $dev $attr ${policy}:
> +	# Test policy longer than 32 chars fails stable.
> +	_set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
> +
> +	# Test policy specified correctly. Must pass.
> +	_set_sysfs_policy $dev $attr $policy
> +
> +	# If the policy has no value return
> +	if [[ -z $value ]]; then
> +		return
> +	fi
> +
> +	# Test value specified wrongly. Must fail.
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
> +	_set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
> +
> +	# Test policy and value all specified correctly. Must pass.
> +	_set_sysfs_policy $dev $attr $policy:$value
> +}
> -- 
> 2.47.0
> 
> 

