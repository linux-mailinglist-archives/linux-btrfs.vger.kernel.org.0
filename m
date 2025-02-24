Return-Path: <linux-btrfs+bounces-11738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D973A41DE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EA81892DF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9087A25A32D;
	Mon, 24 Feb 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GORymXAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A1853
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396932; cv=none; b=IDWWo3RxJ4ESl0Ga4jDPV4rOUFNJh+C6P26jGfJ/49cFNs53tQwGZM1UXI1pyXvO8SREs/QL1r2KW4wmRuYf4PZqE+3dnzT82Zxr3cvlJKQYsIVreYOCLdUf+KFLSambxlIy9fcezjpzHMHVOvX3Jzdx4UbkJeA0bDp72iQ8GhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396932; c=relaxed/simple;
	bh=jQosy1bXjrJFgjx+wuaVHn8Y3i81H/NnN0F7bWghnB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWBMKy5uVNWots6TPrK9mWenn0g7kr5ejBeABkuxbKioTiQQSEu6jwMgGA1eIk2GxpmBl1dymFeFMH5zhakrGfYOuACuRjCAHGfVbVQK5lKsArOUauIdnhwguUfeGwHgDQOigZXdvAnlyOLVNUrYk970PsB5M0JD6mlZM5RxcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GORymXAr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb9709b5b5so793485366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740396929; x=1741001729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmpNiakh06ybxmvbDLsHxsqnrSMGDtLMGDVU1UBhgIE=;
        b=GORymXAr9WotA12LPlPSaZ5aLFQzsG3mFXU8JhgqxiZrMByaeelHRn2Dy3ZdIAPJvL
         qYVDWD9hgDBNq8RlcXBbrh0VBRooZIhLWSN4mGlTzK6aju3u/QtoHcTqoeqvi/PPASrT
         Db+DlTaGSsfW8uJOsofxW6Xje209zyaN3FfaLS9YwcAnzzikNCJjcFfHrpRpnADat3i3
         u/gLNsqu9LWkXY4S6+RvjsZhi0jkVAEah0BNxP4EYslgvuz25uQwwoBPuGzXUdLlkRln
         Zx5J1BVydwuEk9ovIdCb5HpTVjE/NDxqdw2ksLwKObXZuHfNqBhPyFxKZRFahepjXjzQ
         +rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740396929; x=1741001729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmpNiakh06ybxmvbDLsHxsqnrSMGDtLMGDVU1UBhgIE=;
        b=t9tRukMZC5wJ0n0aJ2ipSb8x4zlg6JfnY0W0N4GnTUg5ndwIajVStpfqcL4ne0FVsg
         7EATR6td3eeP6Dqf0LJRadApwfw0oZTD1y+/nsxX/51foLkEl3LJup2jBkNrTZp6IQDC
         snHgjU4NtiEoPnsNCOEC2YnIEAvF2/rfsbG9KOAiC5e3P238/Hsf6q5XrLwhAw2XWQyC
         Rs5CHAl8upU0epLPsxk6WekrklTypNXHTkk3bA/SujF3+Uyu6GKqgkvGn3VTQ7HB38Gn
         n6qMeph4tGL9mZjczo2MRw6lnufLxdG+Vaq+xKs1Z9wEc7mZLstgi+Inh4YlIYSbBmwc
         W+aQ==
X-Gm-Message-State: AOJu0YwcENcJ4vdoHhxdjkf2jwgA55Muc1gDMcBXznfjTyB7lPTKiGfL
	d8kLEp5GRSNHqqo3k8wUbKXwztXLj1aCdPh/0QbVkdpzQ7e5Ei4v0W8IYiI2rwyxO8DKlINff65
	h8xuErUJa70P/5vLcDwVtX1cx4+01hcFx3RT7gA==
X-Gm-Gg: ASbGncut23swtJ0/sWiwg6jWtC6jNnXvNxA6Ght643AiMLvCDeCIO75WySl/ltUxmJG
	uDh6thk3p7IIx0EqrWPNTmcFS5JSdZBjYXGGAfqmoAXHoKweiEC41NxPt7zGIeVvxQMBsbr6UL2
	GKHjPoYw==
X-Google-Smtp-Source: AGHT+IF54y3z+Anjv5F+EAIBnst7HBc0nfhlGzvwCcSau34xgnCF/gvVlQoLI2YZ4LaFYiPOZVbTJMU88YnRRxMMWTs=
X-Received: by 2002:a17:907:9496:b0:ab7:1012:3ccb with SMTP id
 a640c23a62f3a-abc09a2c4afmr1333086566b.14.1740396928962; Mon, 24 Feb 2025
 03:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250224111014.2276072-1-neelx@suse.com>
In-Reply-To: <20250224111014.2276072-1-neelx@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 24 Feb 2025 12:35:17 +0100
X-Gm-Features: AWEUYZk0_-6A7DLi2N-OjaXHMgceqXD2JtWGX5niI2392NDy5SvdysS-mesTlzU
Message-ID: <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is enabled
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 12:10, Daniel Vacek <neelx@suse.com> wrote:
>
> When SELinux is enabled this test fails unable to receive a file with
> security label attribute:
>
>     --- tests/btrfs/314.out
>     +++ results//btrfs/314.out.bad
>     @@ -17,5 +17,6 @@
>      At subvol TEST_DIR/314/tempfsid_mnt/snap1
>      Receive SCRATCH_MNT
>      At subvol snap1
>     +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
>      Send:      42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
>     -Recv:      42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>     +Recv:      d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>     ...
>
> Setting the security label file attribute fails due to the default mount
> option implied by fstests:
>
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
>
> See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
>
> fstests by default mount test and scratch devices with forced SELinux
> context to get rid of the additional file attributes when SELinux is
> enabled. When a test mounts additional devices from the pool, it may need
> to honor this option to keep on par. Otherwise failures may be expected.
>
> Moreover this test is perfectly fine labeling the files so let's just
> disable the forced context for this one.

And of course I forgot to remove this sentence. Please, remove it if
you decide to merge this fix.

> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  tests/btrfs/314 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41..29111ece 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -38,7 +38,7 @@ send_receive_tempfsid()
>         # Use first 2 devices from the SCRATCH_DEV_POOL
>         mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>         _scratch_mount
> -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>
>         $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>         _btrfs subvolume snapshot -r ${src} ${src}/snap1
> --
> 2.48.1
>

