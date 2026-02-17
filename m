Return-Path: <linux-btrfs+bounces-21707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJqrKblslGkEDwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21707-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 14:27:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05E14C8E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 14:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7919E302AF2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0436AB7F;
	Tue, 17 Feb 2026 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NESqdyBD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E12DF6E9
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334834; cv=pass; b=XxQ0vPz8l6vhPJV/QdStAKaxLAjL/meiNJA13eyxY9fYjCk0At0P2Glx1ZYCuKU3kRjA0FiwsU3eonMjPq8xWL4xHcfPh5bHmRDX0GzQwDiRJbz7vRcCD4E67OsS0SJX8S3KIyReCTTatwAcPeEK0XZ+zFOk6qVjXpxDvgAw4u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334834; c=relaxed/simple;
	bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkmojxwH8pWPY042ulab9I2oWAc1VsiS41uTRsGhDCCH5o4W8ARltyBF8Ha+HOoiQ3VRCWnb/ZZpQifKmHVOL7dU95VhF5vhunVuKzvhvzqQTfOgOA6jMU7lVoD/l3MQKagxDCiMn8lYCgSmeSLyTs2bSBAlYRW4EDz3b8tku/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NESqdyBD; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43638a3330dso3325381f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 05:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771334832; cv=none;
        d=google.com; s=arc-20240605;
        b=ItynMGoldFlNQDwRS1szN5qM778y9btLuj1vOuxSsc9mln/GZY5CrMoop1dN26Kpw1
         af51eh6b2OyM5DKR+bmoAiomEgJyIKRdmRxih6plnVS3lQMU3/T3cmdm3Qa9je16N5kr
         6h8aMddFNjAxr9RaMePy2fQdIls371AZ95rJ6UxX8Q9r3Ce7A8uziHVCyKGl1GduZHhV
         Xuv2eO3YzMy4/VKSd46TrL22PFAAr4HRWpNAtvktIx+yq59JF/AidPc/2XhH3jV13giF
         tC0/A/5Fuzt1m49wFNDXLsXlr+s+YoShysvzZhbKeGcnQltQvGeHY6UQqbOqUVRmtbwa
         BIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
        fh=IJqw0jwfch6qzPR2cBu33nZIkefiaMcknGKQyojXAtU=;
        b=g3wr23c3WKYTzNSpvPaLR+AqJfdtLme4/v7H56gFCQhPt4zpx02OBBLSXkPCCv/X6A
         xGONRqizbNTrAdruOKYmOlKJyIxYTZlHqo1/0wMpJl+4dFWduFPlpmJgWVT8dmxIt+4t
         zqV01h52emQDoFuKRvUvINcu9NhqAF1/VcejLi1LTI0vnpqxpT2gzEICaWbE82WIKOqD
         S5rMEsqRsrqw+iBnTP7hbvljQiLubn4qkgmWDNWSmZ78KLd+EDcMvIy9X0pvIa8SJyt6
         kmi28J1LuXTcvGtwY7hdBJlG4EPC9dHhTo0BsvrtO78sWV/AhKqrbfYgfYz1ZBVkUaWg
         VX5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334832; x=1771939632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
        b=NESqdyBDUBdPzO/qTCuoUo6jqKEfI7dWKzhf7admbKHUKEfVT7l3Y/+4l75auvfuSn
         Po9rOlOXCrb6ujJO2eQLx7mFUdB8V1ZLgFtUhgrpr0o1H8K2uog8fRkRRpt5owyAo7Ct
         NhdF4lVBH2KDsPHy6plc2KC6aSjjeT7ozckKC/obumO5z9/d2eFMy0dECxfQjJPvIR+i
         Cz8VJ+Z9462OqiO+yhhiuO5rLthG7GHKlxe1ZFWM6zVWGVcKI0E42ZLSSdoWj1SnVdtC
         A535K9oHwDb6IGhOFzICsIE32/Gv5USdcYDp9DpoMpCa4InLCRiWN64HChvK6OM9+Anv
         bmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334832; x=1771939632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
        b=SOfQHnCpqPeCgfS5h9kKrcrvXSzDfS4DZJVzyI4j2D+kx20yN10FAgAZ3Gu40weyQ6
         7R4419h4dAXFHPGXnZ/e7W0PGH7se4IP7jEa1whVWmMy7pkLShrZMqHGZ/9DdR7iiQZl
         7BgM2hBMwyNVhcigmscwwibj5XGp1wVbJfvt1Uz/kwJCzndn9ewA3619wGiLDAe50v/m
         4uyefXxPRf5eqUvpRvIyI3o5TeDdmCcvlo0zejXwCJIhMKx62zxs/Hw4pgA+ICYnDfRA
         VZdTLHlSXTguXpgG413rd29SVID9KUbUhf9rnq0dPp2TdLt7w21BDXK3L/DkDnaPxSm+
         MggQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm/Xumb76Zue8ZTuT8vM45FN0sU175+Xmfd7/SqZp3Uz5vpKklZHuWjq32FQ+kSS+yByoFxdhlb9nqog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzoc5LqbdGWLDKFxPJRjI6cMydErH5QHGKQx3weLmsd/2rYPlO
	U+CoUlQqrR0WbrrEVu/9p/nay5ZCB/BJ03e9WbrCW3xjZFHA9pVt3biIY0TNCMITibVL3muPd+3
	2TluWKkkK+rHTdUdcqLBwXlnxmGvLxlI=
X-Gm-Gg: AZuq6aIj5pvV/7FN/yIdZdZlX/906AhBiTWQWNEBV3IYkI1n4VIEH3z9eAsYPom4lhu
	sYEWZs3S5kNproNH07f8oESlPZgvAAyHtS6BnXI59AgCpWD3FUS9V/HlDlbNb050d62HvCZs0Gm
	zA7hDjKWGl6piIF7AGfyc6MLvJEv34ShtQ2P/z2wx4dfy6kDWJ3TaNxKEpXg5/p95RuvnnN76OL
	/Jx2VYKNwVWGs3EbesiRFcRgoLFfTBKCTQ3wHZSL3Ry4x3M3yOR58rd9VgaM2LzcXw1JuOEm+zk
	JW3Jx/0T
X-Received: by 2002:a05:6000:40df:b0:436:8058:452 with SMTP id
 ffacd0b85a97d-4379dba36d1mr20165444f8f.44.1771334831515; Tue, 17 Feb 2026
 05:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com> <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com> <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
 <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
 <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
 <05c37282-715e-4334-82e6-aea3241f15eb@igalia.com> <CAOQ4uxgzK7qYDFWYT62jH_zq8JkLGussD5ro4cKDqSNQqBiVUA@mail.gmail.com>
 <8bec19de-6e6e-418a-a256-5918bd835d98@igalia.com>
In-Reply-To: <8bec19de-6e6e-418a-a256-5918bd835d98@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Feb 2026 14:26:59 +0100
X-Gm-Features: AaiRm50wzuTW2-Y09oQNfhcaN_Xf9kQsFW2GVozychJKf87k4BKo6-ETNYdwiV0
Message-ID: <CAOQ4uxhpB-D+DaCVZ6-uZGM8WnsZ9Bkxdd4+f_EkvYnQ8xpvqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21707-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A05E14C8E4
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 4:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 06/02/2026 10:12, Amir Goldstein escreveu:
> > On Thu, Feb 5, 2026 at 9:34=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@=
igalia.com> wrote:
> >>
> >> Anyhow, I see that we are now too close to the merge window, and from =
my
> >> side we can delay this for 7.1 and merge it when it gets 100% clear th=
at
> >> this is the solution that we are looking for.
> >>
> >
> > I pushed this patch to overlayfs-next branch.
> > It is an internal logic change in overlayfs that does not conflict with
> > other code, so there should not be a problem to send a PR on the
> > second half of the 7.0 merge window if this is useful.
> >
> > I think that the change itself makes sense because there was never
> > a justification for the strict rule of both upper/lower on the same fs
> > for uuid=3Doff, but I am still not going to send it without knowing tha=
t
> > someone finds this useful for their workload.
> >
>
> Hi Amir,
>
> I can confirm that this is useful for my workload. After correctly
> setting this flag for every mount, everything is working good and we can
> bypass the random UUID issues. Thank you for your help!

OK, PR sent.

Thanks,
Amir.

