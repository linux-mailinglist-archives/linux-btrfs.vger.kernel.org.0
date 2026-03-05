Return-Path: <linux-btrfs+bounces-22258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePmUDbLEqWm2EQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22258-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 19:00:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0221216B45
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF6473020868
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E63D5674;
	Thu,  5 Mar 2026 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXKT4SuO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F8262FD0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733610; cv=none; b=MXJb5L6vQxPeDf2eqYKH5MoFiKKTj2XWSo0qFGy7ywWdlUcJVdNAEHciJs1fCxYq8GMAknFfbGXa/2+pCMmA3f3pt4eusaqiTaN4o6atHeUsBXTM2gV4+Vs0dIu2YzcxhGh5aXvMGUepdmv1ehpJRTSbPaLY+xji5wzhlV0hTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733610; c=relaxed/simple;
	bh=uMPF7NJYBZDsP90YmZ/IguqwypeE+FmQn6puNufL4tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/Z/WA7Q8/ARujLMsKWIJIL2vbVobvkZk8Rx9UfGg2nfHJM2/4Hs0ICBIvdmLKcbeUmGQTYGb4HDHnvsO5FiWoEmRl+MacQKea1w3GTZm8WDHPgrIUivwodifiSVe5vbUItSMyPLeAvwz0z+bHE4t2zjaq+IfnDrvodMd/PcgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXKT4SuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BEFC2BC9E
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772733610;
	bh=uMPF7NJYBZDsP90YmZ/IguqwypeE+FmQn6puNufL4tU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pXKT4SuORemaO7WjZ4f+aIk0aFCsJ4lUEnTXbwTSeengevi5KqUayDv+ovPJAGEF5
	 GVw8lSUwioY8Cs2S2Us2Bw3TqI5cBG/UN7/F7/aoq5NCSZ/rMtckYqlRdaCvKfUBNX
	 uAWRx0/FxqBkK6AWtxV5hnFurk7UG62I/nCq+e2wwC5L1UC4yLaH3rIs9q/AfzS+6Z
	 NHRsryUPnah/9aWfU5/NMCLszuHp3hC9tNH+vjd4Kp526vDM6RKc58Uu3fnhGEcFUR
	 IQRL/FC+BwWxl0gSYYxGqk5cCsDY3fSEHvoSEy6NKZ2BiE3LOQK4K6qTleC/4EgMYr
	 Tvx1NGQkj+SIQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso4225217a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2026 10:00:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5hDj7nKIfRwS1IdaeHmhM2tmjaeVa4nw5R72E6QJI8MhkO39KxJwir06B6RPApKDbWFAFiCu9j8Ak3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFyyU1djwbXhd9MQdK3uTvAbPrwOxXGlICoP+sklEaU0eCLnL
	DyJQWjrmhhjKtTxOR8uVDsdl7G80o1XER7B6q+qQiAw9G3JlQPS5iuu6sQmS7K1NBjf7Jqwzyx/
	V2fZYE1+xTzkNM6XgIJZ6Br3BbT2Evrc=
X-Received: by 2002:a17:907:6d0c:b0:b8f:a85c:95c5 with SMTP id
 a640c23a62f3a-b93f14dffb0mr421679666b.37.1772733608773; Thu, 05 Mar 2026
 10:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1e2690efeb8570651894567d80511144424fb5e.1772106022.git.fdmanana@suse.com>
 <20260305175643.GB1172981@zen.localdomain>
In-Reply-To: <20260305175643.GB1172981@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 5 Mar 2026 17:59:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6cR_utsRReNbZLL6x2KgZvLeSaLL8JDuzayOH=hU4jkw@mail.gmail.com>
X-Gm-Features: AaiRm53hMdJ4KUTQ0RSs-Yi9CyKEVeklFJJg29iA-RbpRylP5mDxz_-hoE9hbOg
Message-ID: <CAL3q7H6cR_utsRReNbZLL6x2KgZvLeSaLL8JDuzayOH=hU4jkw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test create a bunch of files with name hash collision
To: Boris Burkov <boris@bur.io>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A0221216B45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22258-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 5:56=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Feb 26, 2026 at 02:34:37PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we create a high number of files with a name that results =
in
> > a hash collision, the filesystem is not turned to RO due to a transacti=
on
> > abort. This could be exploited by malicious users to disrupt a system.
> >
> > This exercies a bug fixed by the following kernel patch:
> >
> >  "btrfs: fix transaction abort on file creation due to name hash collis=
ion"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Looks good, thanks. One non-blocking question inline.
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  tests/btrfs/346     | 95 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/346.out |  3 ++
> >  2 files changed, 98 insertions(+)
> >  create mode 100755 tests/btrfs/346
> >  create mode 100644 tests/btrfs/346.out
> >
> > diff --git a/tests/btrfs/346 b/tests/btrfs/346
> > new file mode 100755
> > index 00000000..ef301ef7
> > --- /dev/null
> > +++ b/tests/btrfs/346
> > @@ -0,0 +1,95 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> > +#
> > +# FS QA Test 346
> > +#
> > +# Test that if we create a high number of files with a name that resul=
ts in a
> > +# hash collision, the filesystem is not turned to RO due to a transact=
ion abort.
> > +# This could be exploited by malicious users to disrupt a system.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick subvol
> > +
> > +_require_scratch
> > +_require_btrfs_support_sectorsize 4096
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: fix transaction abort on file creation due to name hash c=
ollision"
> > +
> > +# Use a 4K node/leaf size to make the test faster and require less fil=
e names
> > +# that trigger a crc32c hash collision.
> > +_scratch_mkfs -n 4K >> $seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +# List of names that result in the same crc32c hash for btrfs.
>
> How did you generate these? Is it slow/costly?

By brute force. There's btrfs-crc.c in btrfs-progs for that, I
slightly changed it to allow for brute forcing with random lengths
rather than fixed lengths and with more ascii characters ($, _, -,
etc).

> It could be interesting to include a mode to "generate more", in which
> case the test could be generalized to other fileystems directory
> hashing, or to generate more names if needed. With a fixed nodesize and
> btrfs, I don't see a need, though.

That takes a lot of time to generate, that's why I used a hardcoded list.
It took about 4 hours to generate these names, using 12 processes in parall=
el.

Thanks.

>
> > +declare -a names=3D(
> > +     'foobar'
> > +     '%a8tYkxfGMLWRGr55QSeQc4PBNH9PCLIvR6jZnkDtUUru1t@RouaUe_L:@xGkbO3=
nCwvLNYeK9vhE628gss:T$yZjZ5l-Nbd6CbC$M=3DhqE-ujhJICXyIxBvYrIU9-TDC'
> > +     'AQci3EUB%shMsg-N%frgU:02ByLs=3DIPJU0OpgiWit5nexSyxZDncY6WB:=3DzK=
Zuk5Zy0DD$Ua78%MelgBuMqaHGyKsJUFf9s=3DUW80PcJmKctb46KveLSiUtNmqrMiL9-Y0I_l5=
Fnam04CGIg=3D8@U:Z'
> > +     'CvVqJpJzueKcuA$wqwePfyu7VxuWNN3ho$p0zi2H8QFYK$7YlEqOhhb%:hHgjhIj=
W5vnqWHKNP4'
> > +     'ET:vk@rFU4tsvMB0$C_p=3DxQHaYZjvoF%-BTc%wkFW8yaDAPcCYoR%x$FH5O:'
> > +     'HwTon%v7SGSP4FE08jBwwiu5aot2CFKXHTeEAa@38fUcNGOWvE@Mz6WBeDH_Vooa=
Z6AgsXPkVGwy9l@@ZbNXabUU9csiWrrOp0MWUdfi$EZ3w9GkIqtz7I_eOsByOkBOO'
> > +     'Ij%2VlFGXSuPvxJGf5UWy6O@1svxGha%b@=3D%wjkq:CIgE6u7eJOjmQY5qTtxE2=
Rjbis9@us'
> > +     'KBkjG5%9R8K9sOG8UTnAYjxLNAvBmvV5vz3IiZaPmKuLYO03-6asI9lJ_j4@6Xo$=
KZicaLWJ3Pv8XEwVeUPMwbHYWwbx0pYvNlGMO9F:ZhHAwyctnGy%_eujl%WPd4U2BI7qooOSr85=
J-C2V$LfY'
> > +     'NcRfDfuUQ2=3DzP8K3CCF5dFcpfiOm6mwenShsAb_F%n6GAGC7fT2JFFn:c35X-3=
aYwoq7jNX5$ZJ6hI3wnZs$7KgGi7wjulffhHNUxAT0fRRLF39vJ@NvaEMxsMO'
> > +     'Oj42AQAEzRoTxa5OuSKIr=3DA_lwGMy132v4g3Pdq1GvUG9874YseIFQ6QU'
> > +     'Ono7avN5GjC:_6dBJ_'
> > +     'WHmN2gnmaN-9dVDy4aWo:yNGFzz8qsJyJhWEWcud7$QzN2D9R0efIWWEdu5kwWr7=
3NZm4=3D@CoCDxrrZnRITr-kGtU_cfW2:%2_am'
> > +     'WiFnuTEhAG9FEC6zopQmj-A-$LDQ0T3WULz%ox3UZAPybSV6v1Z$b4L_XBi4M4BM=
BtJZpz93r9xafpB77r:lbwvitWRyo$odnAUYlYMmU4RvgnNd--e=3DI5hiEjGLETTtaScWlQp8m=
YsBovZwM2k'
> > +     'XKyH=3DOsOAF3p%uziGF_ZVr$ivrvhVgD@1u%5RtrV-gl_vqAwHkK@x7YwlxX3qT=
6WKKQ%PR56NrUBU2dOAOAdzr2=3D5nJuKPM-T-$ZpQfCL7phxQbUcb:BZOTPaFExc-qK-gDRCDW=
2'
> > +     'd3uUR6OFEwZr%ns1XH_@tbxA@cCPmbBRLdyh7p6V45H$P2$F%w0RqrD3M0g8aGvW=
poTFMiBdOTJXjD:JF7=3Dh9a_43xBywYAP%r$SPZi%zDg%ql-KvkdUCtF9OLaQlxmd'
> > +     'ePTpbnit%hyNm@WELlpKzNZYOzOTf8EQ$sEfkMy1VOfIUu3coyvIr13-Y7Sv5v-I=
vax2Go_GQRFMU1b3362nktT9WOJf3SpT%z8sZmM3gvYQBDgmKI%%RM-G7hyrhgYflOw%z::ZRcv=
5O:lDCFm'
> > +     'evqk743Y@dvZAiG5J05L_ROFV@$2%rVWJ2%3nxV72-W7$e$-SK3tuSHA2mBt$qlo=
C5jwNx33GmQUjD%akhBPu=3DVJ5g$xhlZiaFtTrjeeM5x7dt4cHpX0cZkmfImndYzGmvwQG:$eu=
FYmXn$_2rA9mKZ'
> > +     'gkgUtnihWXsZQTEkrMAWIxir09k3t7jk_IK25t1:cy1XWN0GGqC%FrySdcmU7M8M=
uPO_ppkLw3=3DDfr0UuBAL4%GFk2$Ma10V1jDRGJje%Xx9EV2ERaWKtjpwiZwh0gCSJsj5UL7CR=
8RtW5opCVFKGGy8Cky'
> > +     'hNgsG_8lNRik3PvphqPm0yEH3P%%fYG:kQLY=3D6O-61Wa6nrV_WVGR6TLB09vHO=
v%g4VQRP8Gzx7VXUY1qvZyS'
> > +     'isA7JVzN12xCxVPJZ_qoLm-pTBuhjjHMvV7o=3DF:EaClfYNyFGlsfw-Kf%uxdqW=
-kwk1sPl2vhbjyHU1A6$hz'
> > +     'kiJ_fgcdZFDiOptjgH5PN9-PSyLO4fbk_:u5_2tz35lV_iXiJ6cx7pwjTtKy-XGa=
Q5IefmpJ4N_ZqGsqCsKuqOOBgf9LkUdffHet@Wu'
> > +     'lvwtxyhE9:%Q3UxeHiViUyNzJsy:fm38pg_b6s25JvdhOAT=3D1s0$pG25x=3DLZ=
2rlHTszj=3DgN6M4zHZYr_qrB49i=3DpA--@WqWLIuX7o1S_SfS@2FSiUZN'
> > +     'rC24cw3UBDZ=3D5qJBUMs9e$=3DS4Y94ni%Z8639vnrGp=3D0Hv4z3dNFL0fBLmQ=
40=3DEYIY:Z=3DSLc@QLMSt2zsss2ZXrP7j4=3D'
> > +     'uwGl2s-fFrf@GqS=3DDQqq2I0LJSsOmM%xzTjS:lzXguE3wChdMoHYtLRKPvfaPO=
ZF2fER@j53evbKa7R%A7r4%YEkD=3DkicJe@SFiGtXHbKe4gCgPAYbnVn'
> > +     'UG37U6KKua2bgc:IHzRs7BnB6FD:2Mt5Cc5NdlsW%$1tyvnfz7S27FvNkroXwAW:=
mBZLA1@qa9WnDbHCDmQmfPMC9z-Eq6QT0jhhPpqyymaD:R02ghwYo%yx7SAaaq-:x33LYpei$5g=
8DMl3C'
> > +     'y2vjek0FE1PDJC0qpfnN:x8k2wCFZ9xiUF2ege=3DJnP98R%wxjKkdfEiLWvQzmn=
W'
> > +     '8-HCSgH5B%K7P8_jaVtQhBXpBk:pE-$P7ts58U0J@iR9YZntMPl7j$s62yAJO@_9=
eanFPS54b=3DUTw$94C-t=3DHLxT8n6o9P=3DQnIxq-f1=3DNe2dvhe6WbjEQtc'
> > +     'YPPh:IFt2mtR6XWSmjHptXL_hbSYu8bMw-JP8@PNyaFkdNFsk$M=3DxfL6LDKCDM=
-mSyGA_2MBwZ8Dr4=3DR1D%7-mCaaKGxb990jzaagRktDTyp'
> > +     '9hD2ApKa_t_7x-a@GCG28kY:7$M@5udI1myQ$x5udtggvagmCQcq9QXWRC5hoB0o=
-_zHQUqZI5rMcz_kbMgvN5jr63LeYA4Cj-c6F5Ugmx6DgVf@2Jqm%MafecpgooqreJ53P-QTS'
> > +)
> > +
> > +# Now create files with all those names in the same parent directory.
> > +# It should not fail since a 4K leaf has enough space for them.
> > +for name in "${names[@]}"; do
> > +     touch $SCRATCH_MNT/$name
> > +done
> > +
> > +# Now add one more file name that causes a crc32c hash collision.
> > +# This should fail, but it should not cause a transaction abort and tu=
rn the
> > +# filesystem into RO mode (which could be exploited by malicious users=
).
> > +touch $SCRATCH_MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt=
' \
> > +      >> $seqres.full 2>&1
> > +[ $? -eq 0 ] && echo "should not have been able to create file"
> > +
> > +# Check that we are able to create another file, with a name that does=
 not cause
> > +# a crc32c hash collision.
> > +echo -n "hello world" > $SCRATCH_MNT/baz
> > +
> > +# Unmount and mount again, verify file baz exists and with the right c=
ontent.
> > +_scratch_cycle_mount
> > +echo "File baz content: $(cat $SCRATCH_MNT/baz)"
> > +
> > +# Now try to create a subvolume with the same name that causes a hash =
collision.
> > +# It should fail, but it shouldn't trigger a transaction abort and tur=
ns the
> > +# filesystem to RO mode. Subvolume creation takes a different code pat=
h.
> > +$BTRFS_UTIL_PROG subvolume create \
> > +     $SCRATCH_MNT/'W6tIm-VK2@BGC@IBfcgg6j_p:pxp_QUqtWpGD5Ok_GmijKOJJt'=
 \
> > +             >> $seqres.full 2>&1
> > +[ $? -eq 0 ] && echo "should not have been able to subvolume"
> > +
> > +# Check that we are able to create another file, with a name that does=
 not cause
> > +# a crc32c hash collision.
> > +echo -n "yada yada" > $SCRATCH_MNT/xyz
> > +
> > +# Unmount and mount again, verify file xyz exists and with the right c=
ontent.
> > +_scratch_cycle_mount
> > +echo "File xyz content: $(cat $SCRATCH_MNT/xyz)"
> > +
> > +_exit 0
> > diff --git a/tests/btrfs/346.out b/tests/btrfs/346.out
> > new file mode 100644
> > index 00000000..e1b82cbd
> > --- /dev/null
> > +++ b/tests/btrfs/346.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 346
> > +File baz content: hello world
> > +File xyz content: yada yada
> > --
> > 2.47.2
> >

