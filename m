Return-Path: <linux-btrfs+bounces-12691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD7A76734
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855673AAD90
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0E212FAC;
	Mon, 31 Mar 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7tJ3TY+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFEB211A3C
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429496; cv=none; b=ISzPESH8dgN48GsOELuYrLkb/z7xte0wfnwetC1tn6NhvsDlNbWqf+KQ8qvSysWrYblWfhs2quWdZ33QMsTxulJIg4Wh59m4nAhStz1dlVlAuPJuQGiDZpzfSq3Gs7plZxvVy/H4racE8OsmVwpy5yuL0fcjdLFB2L/nIUT657o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429496; c=relaxed/simple;
	bh=+rOuPaFObrtDvL9HVo8feMX3GcclwEbP2gjnrZ7qXhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFUQSrJkJbk55eQSeUZXuUamFe+jbH43r11KGpEIcA23BODoPct/tboH9i0078cRPBr7roIMgE+XgJo7lOnEI9npka5HRJcbSRchb0YoYibA58fIfv00nQfxYl41rSbY7xECLADLvIZ65ZbMTy3uUrpJwmX6NR1+CTIGXF99DPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7tJ3TY+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oE1TLdj9H6ruj8gi6AXVEgu+xed4rdbeVMi1cdaqlo=;
	b=Y7tJ3TY+CCQl8H/ZYgYXCkEFYlY4yBQbfwn1O1WaSgX07fsqvT0/Kcgr2YcCMcr+Qxuhnp
	Mtur7wKn2Y+0uDF4mEEXxSQW/22OAYO+2GV1dotsVx8Yy7bjxKXR6pgOTmOF+VFevCkdwW
	KAf5nLjUGdXL5OE4XNNIvFL7DErDJCg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-5RyKGbknO_eB4H-DNvYlMA-1; Mon, 31 Mar 2025 09:58:11 -0400
X-MC-Unique: 5RyKGbknO_eB4H-DNvYlMA-1
X-Mimecast-MFC-AGG-ID: 5RyKGbknO_eB4H-DNvYlMA_1743429490
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso12778246a91.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 06:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429490; x=1744034290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oE1TLdj9H6ruj8gi6AXVEgu+xed4rdbeVMi1cdaqlo=;
        b=g5dQEL0Su6FNN5R1x4VAjTohH6V0WnbgbNQx/kLcSn21o+IlH8F7tfLxakSxnRZZWj
         sUgogo02nT3Qn2ofsGNgrn3hx2mPpk8dbsMYh2eIT5iFlqdZCgdsnDsz6Pk0CtjgwVXy
         J2fiCX7heuKbC1VnSlcMnn+Pkf4Ne+f9dlaLRC0yyJfRH3Pe5THF7ha2qp/qETcPfYrC
         kkbSnph134DQETAQA+2jdpLkiUrROYdDcQL9VKl2u82DOU4L5HLuJzAMeKSOGBw7Vp1W
         YbPq9ucHChj/D4+Js/z8AOJevVEnYBHf6iejf6d32BPdf+aNzs86CFDGNaar+NLwpTtk
         2PQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuCQ4Blh3BAGmqdHH02WNY+GcMeIE1OzN4GLQh1IdEb5bTFB8IgNrIjHX06ORBjjgalFDu+0FeTIRSCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8efReQxe21DH3KjlnIJsYnkVAL32Bs8qAjBRVdxLgalWkALdd
	3NQTR7txuNrbOtodQe5qsAbgpBqYoHaS1KOXh7P+0LtDDzYg7IFPDX0ZNWTvul0NYhPY/GYlSHq
	9K470epMLiKlziphcIQMtR0RGeKtBBzXYHMQw/2Md0zGxAUUHXObZfJPgJk4XqnBU4+o0lKg=
X-Gm-Gg: ASbGnctp15Gd4cJ5L+LB1vhbkm+6ZBczgNQHjvZ9oQgCIenLtHJGvssZMHUEkkDfJ1k
	pdXLevyu+hf1v3GW8za4hWc/cpPKmlyS3o/nz30SWtm6bmf4tRdzCvPE/IuqefcX6EIlQjCI/Hh
	HIsfHA8AyHU06vavDXRV99bdaR32Qh0D7CsZmi9BshH4Oc7hWDtiJafqphCBU/JccnmjLvluGe/
	U6wE/b4nF6YmugIG5u8wifzmmidXnzFxyZG/pRU0tXoCZ0ghBJRkqWQ5/kvK0Q3BDKpwJDHctyX
	2CUmZgzt+HtPTMuIs1/tJ1I6A8eB5hxnj0R4QF+IpEkzdYEWqGxEOBc1
X-Received: by 2002:a05:6a20:d704:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-2009f5fe919mr15452740637.11.1743429490104;
        Mon, 31 Mar 2025 06:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLJn+w/48xdvA1YFN4RLDTbtq9vdfPtO0aFMbqwk5He6AQGi8updCsACvWlqw8GifWy5XI0g==
X-Received: by 2002:a05:6a20:d704:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-2009f5fe919mr15452704637.11.1743429489778;
        Mon, 31 Mar 2025 06:58:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6a1719sm6367321a12.32.2025.03.31.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:58:09 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:58:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 3/5] fstests: common/rc: add sysfs argument
 verification helpers
Message-ID: <20250331135805.knlyocgvo7lyahux@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <4c40bdaf996d9b04c2bd8423815d52d930ee32a2.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c40bdaf996d9b04c2bd8423815d52d930ee32a2.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:21PM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
> whether a sysfs attribute rejects invalid input arguments during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/sysfs | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 common/sysfs
> 
> diff --git a/common/sysfs b/common/sysfs
> new file mode 100644
> index 000000000000..1362a1261dfc
> --- /dev/null
> +++ b/common/sysfs
> @@ -0,0 +1,142 @@
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
> +
> +	local dname=$(_fs_sysfs_dname $dev)
> +	test -e /sys/fs/${FSTYP}/${dname}/${attr}
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
> +set_sysfs_policy()
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
> +set_sysfs_policy_must_fail()
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
> +#   verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
> +# Examples:
> +#   verify_sysfs_syntax $TEST_DEV read_policy pid
> +#   verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
> +# Note:
> +#  Process must call . ./common/filter
> +verify_sysfs_syntax()

Wait a moment, we generally has "_" for common helpers (is there any exception you
can find in common/ ?).

So better to add rename this function as _verify_sysfs_syntax.

Same to above two functions, please rename them to:
_set_sysfs_policy, _set_sysfs_policy_must_fail,

> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local value=$4
> +
> +	# Do this in the test case so that we know its prerequisites.
> +	# '_require_fs_sysfs_attr_policy $TEST_DEV $attr $policy'
> +
> +	# Test policy specified wrongly. Must fail.
> +	set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy t'"
> +	set_sysfs_policy_must_fail $dev $attr "' '"
> +	set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
> +	set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
> +	set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
> +	set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
> +	set_sysfs_policy_must_fail $dev $attr "'${policy} '"
> +	set_sysfs_policy_must_fail $dev $attr _${policy}
> +	set_sysfs_policy_must_fail $dev $attr ${policy}_
> +	set_sysfs_policy_must_fail $dev $attr _${policy}_
> +	set_sysfs_policy_must_fail $dev $attr ${policy}:
> +	# Test policy longer than 32 chars fails stable.
> +	set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
> +
> +	# Test policy specified correctly. Must pass.
> +	set_sysfs_policy $dev $attr $policy
> +
> +	# If the policy has no value return
> +	if [[ -z $value ]]; then
> +		return
> +	fi
> +
> +	# Test value specified wrongly. Must fail.
> +	set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
> +	set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
> +
> +	# Test policy and value all specified correctly. Must pass.
> +	set_sysfs_policy $dev $attr $policy:$value
> +}
> +
> -- 
> 2.47.0
> 
> 


