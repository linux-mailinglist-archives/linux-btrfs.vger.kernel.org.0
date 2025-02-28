Return-Path: <linux-btrfs+bounces-11932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEAA49226
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 08:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F383AC483
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC841C84C3;
	Fri, 28 Feb 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UWrvOQqE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC91C700F
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727637; cv=none; b=qPjDNLprgy9aH43erEqcbvQlskxHV9m6HZy1RKcwRoeWDvpLJSAnYUvD/qHpBsIgkMNUPxQTf4tSCKZ0FOMrLui4GivqsCvJELtQwNC3amY31682ovRUVTj+T9Sy45bi5AiOyD4UAjMZievsc7WWYJfisi55Y2vvZbCYkRRsvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727637; c=relaxed/simple;
	bh=OXaRp4idgcRdJx0qDoj8i90oCscA5SqQ9u7Mn4MPzwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa95jXKYuIcwJFn7avjVI8o9Doc8MtEVdZhYtCZ01KDoA+qFC2ehDympBuhLzvcpNzC7m4fjulm+BCdwLgRaTqI7L2bhGeZeyN+86cq3tkZ8RHIrwGEtiZk68U6lTJKD4QFTSdnBPXiL6Hzcwxc6vzUk8+TP5P3925U+1R/fK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UWrvOQqE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so2809787a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 23:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740727633; x=1741332433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfdNaB0E7fgmIJmDaEv9xRcyfj8vJkDTlr4miGhmJ1s=;
        b=UWrvOQqEJQOAboP8Df7TAyKhcxXrW4PFVYWt5k7HutjJFwm0kxyME1MUzLbSQnkDd3
         XhOgjwkNV0qjw8oywFPL88Ikj+zCVW5yEiO6sUQcvvNFr8116D2E/jFP0DLysHfnec/q
         AVCx90EHRYU3jGUVZ8CBeE8oUlqhvdWA/ruRI2MAbHVPglSTB646owrtrVcgqrHCrhB3
         17743nHfhPs7uoyWR1G2w9rEA3uoPVaFMpiub/ZaQu/oX0NqnjmJ0CBA8tz/MXU2hFZx
         b8kz6W1ICqicIkqycDW/V4jqUjeNi3l8CFiZanIpak9GeHYBfidm5hhVozrq0CDxgGjB
         8TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740727633; x=1741332433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfdNaB0E7fgmIJmDaEv9xRcyfj8vJkDTlr4miGhmJ1s=;
        b=iUv9vHEdHUNVwUv5jj0hx6PZk/6wn3TksAEXhb+PmbkpHCJSknC+uhbct7MQCFaASv
         nv6bDe5FeRw6y5JYTGfCDjpSLk5R0hjWhDPovkaopWMWhdubQ/IT2U+oUCDyJzKFv4z2
         AuCk7o9AUPfDrMv8mUkZgcF/4pVwVw4EFgOqaiKDHIZpnAe6NF6phFEse+gj7aAvkzrL
         ZkVpvJEKQuKebR5vFopnC2orXFhrnPSeVa9cxmrY/wU2Nm88nrBfGBCmHV6rs+YRx4Kz
         rHkV/mukrWW3y6p5iwzALhCLkFkwROCfCRuWS72T5BSZ5C2wBwniEZpRC2EStXn3xaqO
         +m/g==
X-Forwarded-Encrypted: i=1; AJvYcCVER7slqrQoXP1UeF9+Q1BBbzvDiJrFzMQDgOdCSM/UlJf7tJwAeXk32l70vLElViuzAKbrgMWYjo+hnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCDIPhKRbt/LUL0c/+XgNGuESZY3ndSHs/+LHM5tw36ZdHzAV
	39pWMjRpErFeJ6attFEJ3O2K1/5DVOrJ9JiaJmbDPIbAWy6gHb+CcDfsnYrzI3ePIgyA/KDvnvl
	Sh2FmyXjRzIuI+L/iL8C23lMXz7meH+07mv7Rqg==
X-Gm-Gg: ASbGncuzIbiYfuXEVPzdbwtf5CXqwadOnptIN1PBxxsOkzfYDAeMjo2SDYK42XpALbA
	kpu9YNRZMsbDB+Im/Kr3te+pfJDUl0h4gzLn6RxkQxzCo5ZOCevIVNGt3Hb/FBzWUs6BGYLf2XS
	LIpppaRg==
X-Google-Smtp-Source: AGHT+IEHZLuLqzLU6YdSbwrSc2pWAVvyIXo9LRUSqmihktMu9s8+x868QHVGvuWQwKCXqHeHI81dd93VpPypCBDhMZI=
X-Received: by 2002:a17:906:f59d:b0:ab7:a5f2:ed22 with SMTP id
 a640c23a62f3a-abf25fa0374mr268651566b.1.1740727633443; Thu, 27 Feb 2025
 23:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250224111014.2276072-1-neelx@suse.com>
 <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com> <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
In-Reply-To: <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 28 Feb 2025 08:27:02 +0100
X-Gm-Features: AQ5f1JptISSwH9o8Im_GI3JkMuHyJ2I1tTf4FzdUl7ZNwowAMjXGr77skWSlxfo
Message-ID: <CAPjX3FcY7uc5mP8z5VMDS0tfrVP87O0q6jQkXY3OAq9stWvfCg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 at 07:10, Anand Jain <anand.jain@oracle.com> wrote:
>
> On 24/2/25 19:35, Daniel Vacek wrote:
> > On Mon, 24 Feb 2025 at 12:10, Daniel Vacek <neelx@suse.com> wrote:
> >>
> >> When SELinux is enabled this test fails unable to receive a file with
> >> security label attribute:
> >>
> >>      --- tests/btrfs/314.out
> >>      +++ results//btrfs/314.out.bad
> >>      @@ -17,5 +17,6 @@
> >>       At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >>       Receive SCRATCH_MNT
> >>       At subvol snap1
> >>      +ERROR: lsetxattr foo security.selinux=3Dunconfined_u:object_r:un=
labeled_t:s0 failed: Operation not supported
> >>       Send:      42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfs=
id_mnt/foo
> >>      -Recv:      42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/f=
oo
> >>      +Recv:      d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/f=
oo
> >>      ...
> >>
>
> It=E2=80=99s actually good that the Btrfs receive failed because the send=
 had
> an unlabeled security context=E2=80=94kind of a validation, even though i=
t
> wasn=E2=80=99t intentional. The fix here fits the objective of the test c=
ase.

It's the other way around. Send (missing the mount option) had the
label (as expected) which was refused by the receive side due to the
explicit context mount option. That's how SELinux is designed.

> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> >> Setting the security label file attribute fails due to the default mou=
nt
> >> option implied by fstests:
> >>
> >> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdb /mn=
t/scratch
> >>
> >> See commit 3839d299 ("xfstests: mount xfs with a context when selinux =
is on")
> >>
> >> fstests by default mount test and scratch devices with forced SELinux
> >> context to get rid of the additional file attributes when SELinux is
> >> enabled. When a test mounts additional devices from the pool, it may n=
eed
> >> to honor this option to keep on par. Otherwise failures may be expecte=
d.
> >>
> >> Moreover this test is perfectly fine labeling the files so let's just
> >> disable the forced context for this one.
> >
> > And of course I forgot to remove this sentence. Please, remove it if
> > you decide to merge this fix.
>
> Fixed the changelog and pushed it (for-next).
>
> Thanks, Anand
>
>
>
> >
> >> Signed-off-by: Daniel Vacek <neelx@suse.com>
> >> ---
> >>   tests/btrfs/314 | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> >> index 76dccc41..29111ece 100755
> >> --- a/tests/btrfs/314
> >> +++ b/tests/btrfs/314
> >> @@ -38,7 +38,7 @@ send_receive_tempfsid()
> >>          # Use first 2 devices from the SCRATCH_DEV_POOL
> >>          mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >>          _scratch_mount
> >> -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >> +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${t=
empfsid_mnt}
> >>
> >>          $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter=
_xfs_io
> >>          _btrfs subvolume snapshot -r ${src} ${src}/snap1
> >> --
> >> 2.48.1
> >>
>

