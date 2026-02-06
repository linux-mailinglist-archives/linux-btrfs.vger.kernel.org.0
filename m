Return-Path: <linux-btrfs+bounces-21454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBfeM2t/hmmVOAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21454-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 00:55:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D8810431A
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 00:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F84C302F248
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 23:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D583C314A6B;
	Fri,  6 Feb 2026 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FLphiC75"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABA2FD7A3
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770422115; cv=pass; b=MZ251Fy3CP4RCY6/hHTfaYZ8LR5Ia1BwD6ps6sgyLIwQQ7LJeJxo8e61huPc6jrLVp84P2dBzbGm1559pXPNVbHXmLMf2VogyqnPu9f+UHuVE4WZ+SsIm00YhkH/egJMLhHSLyuN7FdeNqW8nycK6YHDhlgHpGIt/pt6uFWZZeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770422115; c=relaxed/simple;
	bh=Ofh3a60iePuK7CqwLhCiGN+4LsJYVk33zQSNoRR9YWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBBFCKRR799gPLc1XSamBGPZYOqmJ9WTIl0eYTMjJ7XlQeMQfHCwv50JZJGj0eDA76KB4sMm3x3QAQGKTJ7gHRH3XI8wYGylZvVXMIagfHY1UYgsNdU8cVazGnNhO920syf7wYl0Baw3EqvRtDUnmDp5KHse+82Om2pgdOSRhZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FLphiC75; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4362cdf1d82so896882f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Feb 2026 15:55:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770422113; cv=none;
        d=google.com; s=arc-20240605;
        b=GahC0t38Su8iJzvWg1xhDtRTORw9R/o+seshgFfuxEqP3r+AKT4bYDP1l6WdS2viwb
         jiMOdt2YdWwR/qgR8Yu4Q8LeEdysSk3FmtOoQCU2pOYsfrZ2pYxgKHHy5QX8Kh8Sw/0a
         D87QR7d5vJJGYiIZBuHJGoqYADP0vyaffHEL/Hw9P8X1hIGIhSJgofGvcx0dqsKjNrlg
         5unyz2c0kkE2AiRL7Z/GUKCen+nJ74LjNRGKRWchvDbyEPiXQlUoGT8xid79YP+C2pW0
         Ok1Jew0rcvAUZg3121SiwlQMJ7ZcL5sDgnR/0bbbnlCmKbY884/8V4iE00IGugpJua9H
         akwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ofh3a60iePuK7CqwLhCiGN+4LsJYVk33zQSNoRR9YWY=;
        fh=07+sbBwMPSURdSqs1Xgf4RqKqEpzQUhdHjqEYo+sh80=;
        b=Hf9QoX2f6+H78e9fhV4PDD/hpl4mEPnnGt+tkD0ROOy8pPrdDZhdnvvpadRVWKROl7
         rkA/4CYZP47DUTjIiznDio1T7S+RoJRfNKOZR0aNfmYFaCe8sdh9lcMoxe06EbIBc3gb
         Mdlq/PZIxEzuXUls0gAsG14KkMAI2m6s3feOsi5Aa1+dGTB0TIGYYG4wZVYM8u3fcePM
         AUzYLquKj1jWDMP2dzc/dsgOdqadjFGRNQKWDJOYEH0OkHuWmZmSZtBPapuQm+cSXt6Z
         dA+swBHoR340/aqNY7GA17VFzJ6IHYaCDkT2xsZM4bld6W81BdinqB7HFmR8MZsdAwjY
         LcDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770422113; x=1771026913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofh3a60iePuK7CqwLhCiGN+4LsJYVk33zQSNoRR9YWY=;
        b=FLphiC7550nBl/9fq4rBD1M023AnSGBBnqL7rkTTEjEB/gAC2/tz4aktT+dGGEpMDH
         D6Er24btpNE/7N5R+ddVZ79EXulE0owqsl/MRBO4kmVRz8eJx5PSXBgE+m7WWae4xZMr
         kqFTOyfaBis/vI3iCPp5VIsSUh/rECvr04CsTxLDAo5qt2LAz6JAsCR7zc8LrfhIbpBG
         rn5zySUeMWXp4n1lqRR3mdi+aq81NcoXqGrctBXWBaw1uMG7LSn8r6yVro7TWa4eAY56
         Tr+IiRYvtAwwu1g4r0O8AUZem19F7ao6OZRoMx6M8qxEv33y+r7d6aVoVWfQEzSYBeeL
         5P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770422113; x=1771026913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ofh3a60iePuK7CqwLhCiGN+4LsJYVk33zQSNoRR9YWY=;
        b=MFf2nstkunTTnbIluDO7Zz3tEfP8tPKvFbb0Y1Bbc02z7qHVsC4OLeGmAZ2FbtiReK
         X2Sz226g3J+Swe+IeIblS02OPYuxTmhiQ1OSTBMHNQ02nsp21jXfkzMfda55sHS4Ti6K
         BA6VZ8J2Szd0JcVaqmG2mU34Hxn5zp8Ntawg9PLV8BX2kQ7pmmeHIsN6lOFWM8JoTTvm
         0IYxDbmbOurPKKNsz0W4Bq8EN1lBuofc2sT48YldBp3JzOpn2jenN+kGY0LNgaN27wOQ
         DkAMUrNoliebnZNYOQxq8UR9n17RlPIvnooxCjpDpL7LAPNc4YfYRn3re2h6EIWd7ktt
         dRbg==
X-Gm-Message-State: AOJu0YzT16KvCsPXZl3WUtar/PqVL6X8q6UX2+wouOcZg6/n0o4pOrpU
	EnnhPyM+S0TeKqraNl1d9bjBD2s99TBcqLNpjGuqc6zzXEgF1PYQuJt97aemZly8fdry/HirmYC
	IyOhEnYo1nlK/DjNP5FfDb55Q0wPZvRxGCAl5De4c/w==
X-Gm-Gg: AZuq6aI1B25WySSvXxy504kVPd9FU7czGbdZkQgPL9V/LHMmW9o4NcV3cEHZTA1k/0k
	9o1a+SUu/XX1W7gmeh8F6kKdD43LVwJKMy3RWVbBAW3wauiIlcM+N00n2MWcCXLrIzfb0+uMQSu
	2GbAIYAoyeAAcVaPzZzaVspW6M2di8SclvXBcuLuCpYg9NN0wwfkfYll5IqW9jpBc4ETmhUNMur
	WfIQmKSUwuZaJVhi8O8eSHgzuhWb2XVdY07tWInN0VMnr6HYQUQ9smScf7voeIoGfHA4vhEwAvJ
	GLwMDB+68ps2Uq++33pXyG1tBzWlKJ3wm3012TO7MR4pKvjRa8jmSBmW13ZE+QhCazr2
X-Received: by 2002:a05:6000:1ac7:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-4362934c4famr7048774f8f.33.1770422113076; Fri, 06 Feb 2026
 15:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg-Je-bgan3m1+45qcSxfRF=d1pmkkhSRmZ9FnovSqvD113BA@mail.gmail.com>
In-Reply-To: <CAEg-Je-bgan3m1+45qcSxfRF=d1pmkkhSRmZ9FnovSqvD113BA@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Sat, 7 Feb 2026 00:55:02 +0100
X-Gm-Features: AZwV_QhdE8lg7FzDTseZwKUwpYE2CjiPUK_cyl3ErGC4fiIa8bh8P379l3ISwwo
Message-ID: <CAPjX3FcMJwsXP7PMLHY-VjNxHEtK+AWU7BLfAhqDBVDs7PLC3A@mail.gmail.com>
Subject: Re: Btrfs encryption support progress?
To: Neal Gompa <neal@gompa.dev>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21454-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 28D8810431A
X-Rspamd-Action: no action

Hi Neal,

I've posted the latest iteration for review today. You can find it here:

https://lore.kernel.org/linux-btrfs/20260206182336.1397715-1-neelx@suse.com=
/

Have a look or give it a spin and let me know what you think :-)

Cheers,
Daniel

On Thu, 5 Feb 2026 at 21:00, Neal Gompa <neal@gompa.dev> wrote:
>
> Hey folks,
>
> I see that the preparatory patches for fscrypt support landed in 6.19,
> but I didn't see any refresh of the rest of the patch set for
> review/submission. Any idea when that's coming?
>
> Thanks in advance and best regards,
> Neal
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!

