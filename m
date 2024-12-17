Return-Path: <linux-btrfs+bounces-10456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E99F4585
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B31188DC71
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9731D61A7;
	Tue, 17 Dec 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="a/HEOrM7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DB15624D;
	Tue, 17 Dec 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421994; cv=none; b=tTbl0RpmbgKR3ZzWXUDKGlyHNeIoIciN8ImcBnY8UvVz4DHp5k3tbaZ7quhgiyrZzvwCYvocwAxiSJYzIlNlSIE7jqQfY8Gt1moA/epPWFCKihRiHGw7+Ubz16Wsdd39wUT0DeZOApeboN7lsiW8blIkodTagnDrYH7vIYosJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421994; c=relaxed/simple;
	bh=7F9c4Qc7gWzXNsJMtOAJeXJcojjdSMLKv12+z11OSd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFQ+f7vY/w/j6rJUmdJ93CMmWFlLBc/yZ+Ib62/tYb2PXqzbCEFeU0h0f8dI5hDAyXq3N84U+d2jdNI5ujYTYxulJNsjWZf6jEq1qcoHfvEsQxqTegXg4MQSdNFlZoKNwOWe9SRLrUa4NEzdAzOH0f92yB/z76sSEfj4V4Be9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=a/HEOrM7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734421984; x=1735026784; i=quwenruo.btrfs@gmx.com;
	bh=CghUtTzQq+Qw5iU0lJlVTPpMBOdeLpGzonJrXaCNT10=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a/HEOrM7ko8ngRC33jY98mT+wpP9nnwnTBxnK7rzhTLNu0oSIbyJA40dgQ7tqSlq
	 p8KmIKVIlp63iSIDe+oVR7016O4Xdkdz3aFE3CcUSh3pBlRLVvcCufdt8ix/Hyhym
	 h/8naNp1zPUucFxLx5H7upT+8BFu+Rot0I6ntxuorvkEv780OwAYXuO6hxCIQ3C9R
	 5kjEe2OvfiDHGPfN47aFNA5hLiphKsHpxGOzQsPtAT3pPWeBT3ER062L+rS4Ybovq
	 3cjdQXt8weU4BhMki36dsIkrFXqBM/oIs/Te9viSldy/CehRKNvtRG0UR9M/fYLxr
	 kJdMy7zQGyXN4AvT9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0Fxf-1tl38q2Dyh-00vuFj; Tue, 17
 Dec 2024 08:53:04 +0100
Message-ID: <eaa00690-2dd6-4db1-bbce-2872189adc58@gmx.com>
Date: Tue, 17 Dec 2024 18:23:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: fix argument passing to _run_fsstress and
 _run_fsstress_bg
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZKY8fkiCC0PxJI7jb8DHrA9GKLy8UAlSK/oMD2XaaiyHHj8I/F5
 9zQ3XjTOU+yP50swWqzjv+R3HS7BHn28Yi+B4yEZEcFlmovsXQAZXvA3yaiK5maMgXB+3ii
 Od8LKoGfoMSYTkKiNe+7o8KirhVsHAOJmFrLm2jqUU+MiVBCYqka/UtSMf88ZpCx0VWgnKQ
 THFY7DUX5ZntkZwQxIxuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gM32Hl1sCaA=;JpSH5xrrZSI6v73NA8NIAYbMuRl
 s0FKRzh+l8xgOZj9cuisOqh1NM7heKnDipEBIO/UKFBI9wIsuKbevXHFMjE+QWCiHOBwcFdiR
 9XMG+4a6ZQ068nxhUB6Q1eMO9ZmBca3zREZVBCqQMqE3nPs3hTn4LLJTGCFMjof7v+4YVYuJ3
 hwq3H5LCDTP8OW3jglOoWd3v35WZH4qW4yJI1w6DcxDTwiemhX0vKXm8j0KSvpQYpniCMb+y5
 MKC5FOnA4zAeBzvUNGGHo+uKhpsilcEc48twXOIMy8xnaniqDNFn0pM/f4ddNulPOLBjCrOnV
 wkWshPnNmkJyzNUgp/WiWVxoYJFmbgrWm8CuRgteqRUya/x4qgwVSfVDlyc/i/fPOuMDYAXgy
 POtieNdbvlzOMS52lBmeH3WkkZwC11sQclLboDK2mjjjz/pkBPOUQCpx17MVVq7pH4W9g+WKS
 SDARyIfLYTArN+0PGJ15qp2PN6or1dRVmZLeJaYA6xBpD0ov0C43e47Jtc/SKPv/K9z4p0sgv
 xGA/jzQj7FbfNHNt0JtML49FF/jJG6El3qGy9yL6xdPJJWMk8dgXldjnRUNpNwZ/+AGsvVQv+
 TjH0j7MhBb6iNSV6n5w8Z3qsarPxJKWAjGt9UlP5WSg2dWUP+t9UG7EDLkjnU1Ez9aN2QTMP+
 IqqAkNKKT+DKShiIQV6wtnu3Jsv/KwKcTAUk+lFEMpuR1oAOP280AIQzdKRp5n+gM/ciQ6iMc
 v6GjN44EeHiEqZ9rCZtKw7QA0mFMMqevvvYo0gTPvJxYkv5OD8+wqOFBjk8Q9Wf+jeaXlNjVR
 Nmtfm+RxJZONNYPOObL0X25mk9IiHvYJz984TI1M14XfbwyWxS+80mLcvx8pxUATnPXh7B8S2
 cn+n1WQLbc8OHzcF4/oyJ1r7UUVIxh+9s+PUMOYyPGrGccdCidI56kLrirKJTroeKri5arsFo
 sH8IbPmXYDCIdsOsdWIMKHa0TqCahpf7PhkwaGtargCFhS/qsEtF4teRVbq8nDb4qHfPChNBS
 5wVNu0yVrHN60fZru83qRgLLUSa+HK9gq/h27Kc48ilHgkRmtVL2CrdLGWmi8Iq5AMbGge5/r
 Pfwc1GdpYpFWpI6F+lJLZ2GVxVlGmG



=E5=9C=A8 2024/12/11 04:02, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> After commit 8973af00ec21 ("fstests: cleanup fsstress process management=
")
> test cases btrfs/007 and btrfs/284 started to fail. For example:
>
>    $ ./check btrfs/007
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 S=
MP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
>    btrfs/007 1s ... [failed, exit status 1]- output mismatch (see /home/=
fdmanana/git/hub/xfstests/results//btrfs/007.out.bad)
>        --- tests/btrfs/007.out	2020-06-10 19:29:03.810518987 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad	20=
24-12-10 16:09:56.345937619 +0000
>        @@ -1,3 +1,4 @@
>         QA output created by 007
>         *** test send / receive
>        -*** done
>        +failed: '2097152000 200'
>        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/007.full for=
 details)
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/007.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad'  to see the e=
ntire diff)
>    Ran: btrfs/007
>
> The problem comes from _run_fsstress and _run_fsstress_bg using $*, whic=
h
> splits the string argument for the -x command used by btrfs/007, so that
> fsstress gets the argument for -x as simply:
>
>     "btrfs"
>
> Instead of:
>
>     "btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"
>
> Fix this by using "$@" instead of $*.
>
> Fixes: 8973af00ec21 ("fstests: cleanup fsstress process management")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   common/rc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 1b2e4508..f4fff59b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -78,13 +78,13 @@ _kill_fsstress()
>   _run_fsstress_bg()
>   {
>   	cp -f $FSSTRESS_PROG $_FSSTRESS_PROG
> -	$_FSSTRESS_PROG $FSSTRESS_AVOID $* >> $seqres.full 2>&1 &
> +	$_FSSTRESS_PROG $FSSTRESS_AVOID "$@" >> $seqres.full 2>&1 &
>   	_FSSTRESS_PID=3D$!
>   }
>
>   _run_fsstress()
>   {
> -	_run_fsstress_bg $*
> +	_run_fsstress_bg "$@"
>   	_wait_for_fsstress
>   	return $?
>   }


