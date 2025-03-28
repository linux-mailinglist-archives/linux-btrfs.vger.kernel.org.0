Return-Path: <linux-btrfs+bounces-12640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E1A7422E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 03:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3F117A729
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1B1C6FE3;
	Fri, 28 Mar 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUKN/fnB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9122094
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743127404; cv=none; b=I0vdrIVZ8dP9wqdsgMsokabcG4bBJBnRt6vHXHWKSvTmimGvj0w6wXqY0G+rZp8Vv4FHZxyZ9Fwv+W6JATomaAskVNRLk63vJjnjjfiFAYcIVlV0oGFFOvNRidv4XUOsOyA6HFVnslpnNgL+VcJSGSX///dV7IStnqTaBnZCq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743127404; c=relaxed/simple;
	bh=+FaoxccULD80hXFy2TIAkbECCTekfpEB10VSbOfabzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQZjuyf2PgAM0uJg3TskVRIzW4cG7oz2eYMMPwENmGsQJf2X3QsDYfbPSe6s5JxQxW25P2NiOSheAnjTXipyEfzkXuF4bYzb/LmeA4hh6rhpT/BbgqEKNcN2N+6Nat1jVmANmK1YUkvU+enid9cjsixkddRWpCIvlVGr6hKC628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUKN/fnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743127401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBHwFq2gjGhY0d56mKvAIH5z5Nhu5VUsEyCQhwLlONI=;
	b=eUKN/fnBJAh2waaukD+RXz6v8BDan0wpVlteFDyx6osJtHTLkMUJ+c8TQVU5YORCw6ycOg
	HcfI0IMqPQZR6Ci2qNpCWK4x8YHXBPDitV7wQPNGnVjzbYt32NHKmcLLNje7Nb2uVAY3nx
	HMFEHu/fVyDEKpwEYQfnNPhpyPCG840=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-KpjEWuyGMBmpI1SPs7xypg-1; Thu, 27 Mar 2025 22:03:19 -0400
X-MC-Unique: KpjEWuyGMBmpI1SPs7xypg-1
X-Mimecast-MFC-AGG-ID: KpjEWuyGMBmpI1SPs7xypg_1743127398
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2262051205aso23434745ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 19:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743127398; x=1743732198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBHwFq2gjGhY0d56mKvAIH5z5Nhu5VUsEyCQhwLlONI=;
        b=t19g+inWEbke/OUHvJTjKLxnGnUYrxt9nicBCHTa+8u2T6cK0avmq/VwHxIgg3o2Xr
         WaAVM7MxbZkO/+8JgFJhehEDVCpvL5PYG4pyoX3UzkgxwYo5D4FQzxV80VLYG7dI3wE8
         TAAJ6RSp3IH6PjEBmDNvmX/9sHvwoJQI6UgH5IETn9o6gRHHC2A8FGgWHx4dAEbO6t/F
         +di3pTO37b/4/hG5XpZc51kdFePIygiitVVEIF66PQj+DsOVxIyAQE3JfhMX7datQjSe
         uIdLIZFpwkGO8TUcG9gvvGrerxFBJiR81C75ADNwmqGr5baMaIbz5nBw8O6Mg0MyR41E
         7fgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUrnm/c3c/Z51V0UrGJhQCTj++/dDw+Y2xqiy9YK78cH5LkZebNqXRkGHbgK/yPzzvkLETpU2weL89iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzgt49S6vF2hxw7VUH/bnk6h62git7zN65Osm69nkdYhhibVa
	0IAeRWQ8eu+gb+0nOA5bG8pXR1Rpcyuajspelg3mse/mKRdS42v3AjP7Cb+lNrxrcH1/rY64g5i
	hniikQi08IWWUb1mqFv4owGP3V8dYzTorfV9TvGQCZ4gTf1zUU9jOh5idD93Q
X-Gm-Gg: ASbGnct8gZHdaWoopaR6TmspcEno4BWU9A3tjAlCLjxkzjWGzd4P2VkRzGzm0rXHovr
	gVh+nthvnofa1RuoazzIplNSerxVqM3zxFkosDLOT33oG7rps1aln2AVaW60KPm/ScAEfCv+6mz
	o388TVii7UBxfeCtFvQukm3IayQJw0UwX2WauhosjDVPaqDHOU7QO6QfaZE/RDaZuYM6+tCbg3H
	2V05XWiG2LKcq2famVlE/2u9SoDGRimOrx/6gCipxfFY7yNwlrahI+OU5Qn6yd6WC+gEE0uwR29
	u98JXWiWCfiwn7UdJo+YzsrY2oaWq87qlpRpzhe04r/WMQGWaNP5gBrR
X-Received: by 2002:a17:903:1a05:b0:224:78e:4ebe with SMTP id d9443c01a7336-228049491f3mr84635215ad.33.1743127397784;
        Thu, 27 Mar 2025 19:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7itjdAoNJ8IydE9HEZHRSihBRgsHorYPQLqQWscsLjtT+Hkqfg9IRVoMEh6cayb7D0mUWzg==
X-Received: by 2002:a17:903:1a05:b0:224:78e:4ebe with SMTP id d9443c01a7336-228049491f3mr84634775ad.33.1743127397275;
        Thu, 27 Mar 2025 19:03:17 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf131sm6683365ad.134.2025.03.27.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 19:03:16 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:03:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250328
Message-ID: <20250328020312.psokbxpz5untmeey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250328012637.23744-1-anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328012637.23744-1-anand.jain@oracle.com>

On Fri, Mar 28, 2025 at 09:26:24AM +0800, Anand Jain wrote:
> Zorro,
> 
> Please pull this branch, which includes test cases for sysfs syntax
> verification of btrfs read policy and chunk size. v4 has been on the
> mailing list for a month now, along with fix from Filipe and Zoned
> testcase from Johannes.
> 
> Please note that the commit:
>  "fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch"
> 
> has the changes discussed with Naohiro, including his review-by tag,
> (which is missing in your patches-in-queue branch).
> 
> Test case number for above commit is changed to btrfs/335 following
> the integration of the sysfs patches.
> 
> Thank you.
> 
> The following changes since commit d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe:
> 
>   common/rc: explicitly test for engine availability in _require_fio (2025-03-17 00:43:12 +0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/asj/fstests/tree/staged-20250328 
> 
> for you to fetch changes up to 208a7f874df38bf873137d00634783422965a7ab:
> 
>   fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch (2025-03-28 08:25:55 +0800)
> 
> ----------------------------------------------------------------
> Anand Jain (5):
>       fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>       fstests: filter: helper for sysfs error filtering
>       fstests: common/rc: add sysfs argument verification helpers
>       fstests: btrfs: testcase for sysfs policy syntax verification
>       fstests: btrfs: testcase for sysfs chunk_size attribute validation

Hi Anand, these 5 patches don't have any RVBs or ACKs. Do you miss that?
Although you can ack patches by yourself, but these patches are from you,
maintainers would better not push their own patches directly without any
RVBs. So please let someone review and ack them at first.

> 
> Filipe Manana (1):
>       btrfs/058: fix test to actually have an open tmpfile during the send operation
> 
> Johannes Thumshirn (1):
>       fstests: btrfs: zoned: verify RAID conversion with write pointer mismatch

I'm going to merge these two patches to the release of this week, and give them
regression test at first.

Thanks,
Zorro

> 
>  common/filter       |   9 ++++
>  common/rc           |   3 +-
>  common/sysfs        | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/058     |  28 +++++++++--
>  tests/btrfs/329     |  19 +++++++
>  tests/btrfs/329.out |  19 +++++++
>  tests/btrfs/334     |  19 +++++++
>  tests/btrfs/334.out |  14 ++++++
>  tests/btrfs/335     |  62 +++++++++++++++++++++++
>  tests/btrfs/335.out |   7 +++
>  10 files changed, 317 insertions(+), 5 deletions(-)
>  create mode 100644 common/sysfs
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
>  create mode 100755 tests/btrfs/334
>  create mode 100644 tests/btrfs/334.out
>  create mode 100755 tests/btrfs/335
>  create mode 100644 tests/btrfs/335.out
> 


