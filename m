Return-Path: <linux-btrfs+bounces-211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628B67F1F60
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 22:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C8DB218CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10638F99;
	Mon, 20 Nov 2023 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317CCB
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 13:42:14 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EDEFDC1A56;
	Mon, 20 Nov 2023 21:42:13 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 06339C2850;
	Mon, 20 Nov 2023 21:42:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700516533; a=rsa-sha256;
	cv=none;
	b=mpL4tqJT45ySIfKxXZbEzzZ1a6cuKuKgO0PS6oCsLU9JEj9kkXwnImpNLT6LjkihUF+HF7
	FaD1g3nHVUeSxY9G4QE4uSWdCHe8XyYj0GHqkLrdea3gfawYJGGrv11AmXQuyg5EA9L6Gr
	L+zK8jxOfsUTeQSvjA15lKR0HInlBy+r9C+56BgHSbKy1DD1PwZvmSzvhwvLBrIfUjgwVU
	Qpjz+rweloyFlxuqB9yWeIrJdOS8LfF0Jb7AYtiL4m9Hb45AmrMp7Ub0Ir8pLn9k5/ZW4j
	PTTUMEYXcUERaf1LuToAX4ekmOY3/1YGD+sCk/sJmJJiH16lR33yzyzCSSrVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700516533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gurHv0y2HjzUZN41tkdAmAsjtFWK+WtturOVElT+kM=;
	b=XeOcTykPAZuWVZolWYrvTmKDv1cHlY4SfMYus1QLCMN/1h4O70naZJwTpqIqaxgByDp3ia
	DLhJhJQHmVgg+YmEvZ2ITW2RtioV2HVVLkdlwVxBm7NRl5D9WJAZlQOOCCaxrGzjbXUgkZ
	hNjT7U+/PPL1EHZS+IA4EmGIVeGrV94LgGzZ+8VId6hg+/d7jizamku4CIll/dVfsSQ5pM
	1h/J2zAHwHgEy8CiJnkrFh45PIe8oA3meTDUGU9Y5wyK8be5fBRmpkFdCbX6cbOsh+0L4D
	+iCrYVcujIcZNq0FEam/OxaH5SIVwF3xQB3HoMuivghqNepKpm7BrvlVPH51OA==
ARC-Authentication-Results: i=1;
	rspamd-55bcb54c45-4htpw;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Hook-Tank: 6915aa6106c6b97a_1700516533554_671479697
X-MC-Loop-Signature: 1700516533554:2668184088
X-MC-Ingress-Time: 1700516533554
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.122.31.6 (trex/6.9.2);
	Mon, 20 Nov 2023 21:42:13 +0000
Received: from p5b0ed26e.dip0.t-ipconnect.de ([91.14.210.110]:50214 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1r5C1u-0002cL-30;
	Mon, 20 Nov 2023 21:42:11 +0000
Message-ID: <c9177935a9ec6bc1b51ba43b84984b8ad2b524be.camel@scientia.org>
Subject: Re: checksum errors but files are readable and no disk errors
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Mon, 20 Nov 2023 22:42:05 +0100
In-Reply-To: <398d34db-e8a6-4116-af6c-ef325944a7d7@inwind.it>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
	 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
	 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
	 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
	 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
	 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
	 <15a0b5f85425163e39edb7f2c5d9878a847754e7.camel@scientia.org>
	 <31ab3d6b-5a15-4cec-8ad8-b928c6502b9c@inwind.it>
	 <e713409c7a72e0b2f8ccca5a99b71115df0a694b.camel@scientia.org>
	 <398d34db-e8a6-4116-af6c-ef325944a7d7@inwind.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey.


On Sun, 2023-11-19 at 12:24 +0100, Goffredo Baroncelli wrote:
> How you can understand if:
> - the data mismatch due to cosmic ray, or
> - the data mismatch due to incomplete write

Not at all... but the question is: Does that even matter?

*If* it's actually the case, that correctness of csums cannot be
guaranteed *only* in the case of a crash (is it?) then it doesn't
matter unless on actually has a crash (which may be even never the
case).

And for all other cases, i.e. when there is no crash, but still invalid
csum, we would be able to notice any silent data corruption (especially
broken memory seems often the reason and btrfs a good checker for that
;-) ).
So if the above assumption is true, nodatacow + csums would give us
protection for all kinds of corruption, except when we have a crash.


No, what if we do have a crash?
Data and csum will likely not match, yes.
But again: So what? Even without the non-matching csum we couldn't be
sure that the data is valid.


>=20
> This thread born by the fact that in case of directio, it is
> impossible to guarantee that csum are correct.

Admittedly I've jumped on the train when I saw that csum and nodatacow
was discussion O:-)

>  Now we are discussing
> to add another set of cases to made the csum less reliable.

I don't see how it would become less reliable.
If we'd optionally(!) allow csums for nodatacow, nothing would change
in the datacow case... and csums wouldn't be made less reliable for the
nodatacow case either, as currently there are no csums at all.

It would seem to me that the opposite is the case: we get more
reliability for the nodatacow case - except for that one case when
there is a crash.

But even in case of a crash we don't loose reliability, cause even
without the csum we'd have no clue whether the data was fully written,
partially or not at all.
So even there we'd only improve things by giving an indicator that data
*might* be corrupt (which includes of course the possibility of a false
positive).


> However I understood your point: allow a set of cases were the user
> may
> allow to lost data (which may be lost anyway); after a crash the
> system should be able to do a scrub for the last written data and
> recompute the csum were possible.

So is there any chance to actually get this as a feature?

I.e. allow people to do nodatacow but have it *not* to imply nodatasum?
People should still be able to do nodatacow AND nodatasum (and it could
even be made the default).
But it would be nice to have nodatacow+datasum as an option... + some
way[0] to "fix" EIO blocks, that result from a crash.


> I think that there is a generic complexity due to the fact that now
> the system is able to write data when it want. With a change like
> we are discussing, the system should collect all the write and before
> updating the disk, it has to log what is updating.

You mean collect all data, just to do the csum-"correcting"[1]
scrub=C2=A0faster?


Thanks,
Chris.


[0] A good tool, would perhaps allow a user to inspect the blocks that
would currently give EIO and decide whether they're broken or whether
the csum should be simply-reset (under the assumption the data is
correct). "inspection" here could be as simple as an easy way to find
out which files reference an affected block so that the user can (if
desired) check if they look sound.

[1] We shouldn't call it correcting csums, since we cannot know whether
the data is even correct. It's more a csum "re-setting".

