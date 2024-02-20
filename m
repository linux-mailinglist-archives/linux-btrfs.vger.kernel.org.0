Return-Path: <linux-btrfs+bounces-2553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4EC85B2DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 07:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4BA283E30
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6375822D;
	Tue, 20 Feb 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="eFuNooYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3058207
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410266; cv=none; b=IO24b1MC+rWSCAsfxFtWLA5qD9rx5GN7BwbGSrTqp9YNidgwL/2jCrgekb1c7I0b+8d4I1D3e2Dy+BpnwPm3YgltXihn//CpXUPj2F9pMkwYHrCeF5GE36YCjg9nBMB/kFiY8TAJXgPG9L1u7Witq18P/zZ8gDW1LtBQU4YVvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410266; c=relaxed/simple;
	bh=1Wyi0LBJ8mgeT8J99X6yXkeUMnOeKS9YaiGRSVuelio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kD8v2FTfgeder43u3VDL1mIVztCw3vK/Tpqpb3l/f3D4OsEd/4v2S++Vl+AeQIgDDHhxVv1lQ5EQhP49xEd/9Q7c7kPeOUzi7OJ+qBy+lCAh64qMHsRUN94F+g8Z+pxTkqrWSQAl0d7yaX9XJY+jf4/Oqi8vW6nrcboUFryM3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=eFuNooYa; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+KvRXelUnkN43BTuze9cAe0mtCzNoaFWCLjwXBHeIh8=; b=eFuNooYaKQ5dx403dPsrqpob/s
	WZv2VaiOgDRpSTnlQYFW82ytYZI42T8rlGCckE+HaXXrsS3afXCT2isOTEqJLJIqXMpj5UMOsCOX2
	j3Vr7hVyvTekzzdf/XME4JbZoh23lKtZzNqRZ06qf/9MHpwmPkqgSpPthnWeMJkgB/2U=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1rcJjM-00AEp2-0A;
	Tue, 20 Feb 2024 06:35:52 +0000
Message-ID: <fe30ce0e-7307-4867-b71e-61d26d0afdc8@inix.me>
Date: Tue, 20 Feb 2024 11:54:10 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
 <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
 <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me>
 <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
 <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com>
 <762c0677-56d9-4a02-bfc2-581b9f3309c9@inix.me>
 <CAL3q7H7-iO_CqR5PPaqTM2GdpsNtV2-EeSU=mxOwE2++Ggg1EA@mail.gmail.com>
 <e1ca1af6-7222-4f33-870b-a5e1acea2315@inix.me>
 <CAL3q7H6VL3O9J3Xu62x=UoknoNB9mZE+3GBDPiuja5OPtyPCZQ@mail.gmail.com>
From: Dorai Ashok S A <dash.btrfs@inix.me>
In-Reply-To: <CAL3q7H6VL3O9J3Xu62x=UoknoNB9mZE+3GBDPiuja5OPtyPCZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: dash.btrfs@inix.me


 >>  >> One surprise is, for any change to the disk file, such as I 
could just
 >>  >> do `touch thin-disk` and it will still be a large send stream.
 >>  >>
 >> ..snip..
 >>  >>
 >>  >> # btrfs send -p 5.s 6.s | wc -c | numfmt --to=iec
 >>  >> At subvol 6.s
 >>  >> 2.4G
 >>  >>
 >>  > I just noticed an hour ago about one such case triggered by that use
 >> case.
 >>  >
 >
 > For this particular case, here's the patch:
 >
 > 
https://lore.kernel.org/linux-btrfs/2888e22ef71003ad9dff455c7f4fb990b8077548.1708260967.git.fdmanana@suse.com/
 >

The patch resolves it. The incremental send stream for the disk file are 
now normal and correspond to the changes made.

[ 6.7.4 without patch ]

$ uname -a
Linux fedora 6.7.4-200.fc39.x86_64 ...
$ sudo ./test.sh
...

File fiemap in the second snapshot:
/mnt/sdh/mysnap2/foobar:
  EXT: FILE-OFFSET        BLOCK-RANGE       TOTAL FLAGS
    0: [0..255]:          26624..26879        256   0x0
    1: [256..1048575]:    hole             1048320
    2: [1048576..1310719]: 216320..478463   262144   0x0
    3: [1310720..1572863]: 544000..806143   262144   0x0
    4: [1572864..1835007]: 871680..1133823  262144   0x0
    5: [1835008..2097151]: 1199360..1461503 262144   0x1

Space used by the file: 513M


[ 6.8-rc5 with patch ]

$ uname -a
Linux fedora 6.8.0-rc5 ...
$ sudo ./test.sh
...

File fiemap in the second snapshot:
/mnt/sdh/mysnap2/foobar:
  EXT: FILE-OFFSET        BLOCK-RANGE      TOTAL FLAGS
    0: [0..255]:          26624..26879       256   0x0
    1: [256..1048575]:    hole             1048320
    2: [1048576..1048831]: 26880..27135       256   0x1
    3: [1048832..2097151]: hole             1048320

Space used by the file: 256K


Also, I am able fix existing files by adding an extra block (not a hole) 
using `dd`, such as,

   dd if=/dev/urandom of=thin-disk seek=$(stat --format=%s thin-disk) 
bs=1 count=1

This seems to ensure the disk file doesn't cause large incremental send 
streams.

Thanks for the patch and everything so far. I could get our solution 
working.

Regards,
-Ashok.




