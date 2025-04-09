Return-Path: <linux-btrfs+bounces-12910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4ECA821FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6B3462FE6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3F25DAE3;
	Wed,  9 Apr 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b38jAnl2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B725D91A
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194129; cv=none; b=aZqnGgaBpdhoWI5p2C7iewRkcBscJA7RLa4Rqtun/0gjWq3aK9Hxvgm+VOH/b7BliyhcBbmj2Br7vJlVmUA6j4vVneKkcp09fWxoF9SBwdAXYNSr3tcknbpVmEekKCONwxTrePU35sHkaReOAnu7PyKGeZMjguv09/F+Xsqn1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194129; c=relaxed/simple;
	bh=Z9VexToz3nnp1JDveeL9jqmixKmDtFR4TwslIbZ/nBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW4mjfxL9zK83U0qGpN/zewRQ40B5X+kDtB8AC3Za0CNooxbMy0NMh7Si87GUDBAat/ZMAyoogNEb1IMFJ4eBvvxDXH5TvoQe9MR3ukuAoE9M6rzXqD8osw7e9o6+7tMG1awVoB9E8f15noCo+AWsYc0ska76h9pRmKE70uOBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b38jAnl2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+m2i/iot7yXQKtdJqxZABg1r8ZEYHkst+29VFgjEFE=;
	b=b38jAnl2TOBsAv693WpeF4Uff7QYJhZp1cqc+OE43sYWHFhP8gUkErQAWxF20tOcMogJSa
	ofR1uA3Wit29vGFnZOH2gmmylHayfQkR0ayzFRr98QqD5XCMPVM66lBpPyj8UlvN6dcj8E
	N00V7/e0xxrQ11XJArSpmyqvosA2XKk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-fACl3derMmuDplQ6L_rdRw-1; Wed, 09 Apr 2025 06:22:05 -0400
X-MC-Unique: fACl3derMmuDplQ6L_rdRw-1
X-Mimecast-MFC-AGG-ID: fACl3derMmuDplQ6L_rdRw_1744194124
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7398d70abbfso9155903b3a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 03:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194124; x=1744798924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+m2i/iot7yXQKtdJqxZABg1r8ZEYHkst+29VFgjEFE=;
        b=F9h1sBzi0cCvGM4eXiSt6AF3reyYWMhyAOxX4K2h6gBUVUXnPL7bABUFoXtuJN4b+8
         j+ygwSCrSowDoBf67TCNG6foVKPk1ky3FhILB0rzlZ8EkSZX6Pz1BCHY5isqsNsgjMAl
         jjhkdnfdFR/uVSMXvp4FjLYoX5ZCLjq6IJVaUNrn4WKd7o/88/1YhDZNzHW2d+V4rJ2x
         +936FYJkgygPTBUl1s/ObYgeoju8Y+fo3Z0UjGdvxFu34mUU20ASnwiRnlyAowWn7ZD5
         CDmQKl5DPSHCvKZw5Vk4OJXJ6Z2LOi5H7Ecgc0A8JabSyLXXbykur8xKVJ3Y5KcYAQlc
         e+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAiHZRgcanYCzO27P6mdkydtHCLmEuw8DvfYHqFrIg2/7+32Gj1KDTkq/CBLkcMLM8U4dUzKNQlVYQ9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5rxj/isvfeznxATuzq6A1EEn0y3AHli2Phu2Z0AuugXtJeMh
	9vfdD/mEMY1PUNIo1HkE4rRRzP47Gj9FWqj/At6LauNvs6o2d2r5FfKjorIWmID6JfAZSgAhUrt
	mY186ceEp/QarlndI4PZ9gvmYNIRfcAB5EWEQR7bGSnzjA5tM1FknrqhaxSnn
X-Gm-Gg: ASbGnct9oeDEowjinV5ib+p+e81UiifLupKQPwYnzJb0e/ixm1ZIAgqm1SWsh68VINK
	ihhGLQ21mNlega/zGI9GzvnPwVE6V7V8cqnLrrupPiEHhzmBu/uiIPUxXNg2LEWDBxJ56QHND67
	0JIsKjSi+Ct0T9LaCG1k91uTpRbvQ2PwYV4aZhWJMPDgZOa4K6YbI6FNUSKFPwUHBWbvbmJNdHW
	uQlrghRd5Kv4KY5bOIfEvXvxg0cpUtMHNmdJZHcSnT3eRHeB4WEdg4EptL/4bzJPSiDXDsVOSHv
	xkE6eLezZyMMObTBaSsM7tL+1fiXkUN3fxIltuCN8DVFn/EzWfkU
X-Received: by 2002:a05:6a00:22cd:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-73bae4929eamr3217489b3a.3.1744194123790;
        Wed, 09 Apr 2025 03:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoDfu+ZzZqe3WtTFV94/EyNEg2vjFHg5Cu6poDHKBuYa7KT1JnR1u5MVOwp3qYbch9BoWTeA==
X-Received: by 2002:a05:6a00:22cd:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-73bae4929eamr3217456b3a.3.1744194123272;
        Wed, 09 Apr 2025 03:22:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d487e1sm960380b3a.54.2025.04.09.03.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:22:02 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:21:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 4/6] fstests: common/sysfs: add new file sysfs and
 helpers
Message-ID: <20250409102159.567xsmwrjfkqqb4k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <10810a81ce8a15a95d3b4653f65ef2b0d57c442b.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10810a81ce8a15a95d3b4653f65ef2b0d57c442b.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:16PM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()`
> to verify whether a sysfs attribute rejects invalid input arguments
> during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/sysfs | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 common/sysfs
> 
> diff --git a/common/sysfs b/common/sysfs
> new file mode 100644
> index 000000000000..16d4b482f9e9
> --- /dev/null
> +++ b/common/sysfs
> @@ -0,0 +1,145 @@
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
> +	if ! test -e /sys/fs/${FSTYP}/${dname}/${attr}; then
> +		return 1
> +	fi
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
> +#  Testcase must include
> +#      . ./common/filter
> +# Prerequisite checks are kept outside this function
> +# to make them clear to the test case, rather than hiding
> +# them deep inside another function.
> +#      _require_fs_sysfs_attr_policy $TEST_DEV $attr $policy
> +_verify_sysfs_syntax()
> +{
> +	local dev=$1
> +	local attr=$2
> +	local policy=$3
> +	local value=$4
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


