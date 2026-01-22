Return-Path: <linux-btrfs+bounces-20917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPnFOqODcmkrlwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20917-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 21:08:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69F6D560
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD77D300BBBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52708395715;
	Thu, 22 Jan 2026 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/lWqrLz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B139570B
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112471; cv=pass; b=NIPdeeqrLnSerqOitPE+y+UX3t6nw59oOJHiRm4tGKMIKTXh39a/s9vD7cTPYm9Airnjknj55Arwyzfi/E0FnCWKdy7arIejDN3R+xeFGoEn8Abyg+bRHvqGJJ2j7UvXkUe4aJbP/NgFd04U9VhZnOl8bleJnN4CL/Cgsvz2YKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112471; c=relaxed/simple;
	bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQWZ6SNRIEzXFgXz3SYDDO7JlE5nFj+xuDD+GFdSm2jOTfjcqK5afY+r8TuIjjC2WuEJJKoSaFzBcrRVNRqkYwMCk157taiLMMzcorIitxwPRDRQ/bJnm7AzF683r4muF9ogeStwIRspPumE/r7IWo1q0jRd4pzDLjYHfE4cnqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/lWqrLz; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b88593aa4dcso41145666b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 12:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112459; cv=none;
        d=google.com; s=arc-20240605;
        b=dXpKQZmHKtZQjBpVWhYEKY8geVo/Vk9Ra0D+HA1DUAuqrhxfnj0UTw3253DVZwkN1d
         9C/+ooS3eEnVIAWADaZZrmPwOuSI7cSoHb2/KNT0VBvB0e1/0nskG4bBpLddNY8QAJkm
         IN7tcuWgiorSaJcPY1kX9OK6G7c941DuwWK2JRQdl2SVLCmqrzWLVh9tIM9J0khWrumx
         9O7RQlpUdXUFqttAGsHyY1RRyxhkSnJoHY9DZReA5/1D00nDiCMxG6SanLTHfsf0Iumx
         RcZAW3iFzO8SlY/Wq40ts+NnqGiBlSgS2vvrk2xSDYLtIwPkEOYmv3u5vf6YI5Y9cZdr
         HTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        fh=C0MnBxK0yEsevjv1uuiS9iWKj15Suq2B9ffPjWcs5uk=;
        b=ZPxO2uFdQhAsU+gNP7CKHLMhbBEOnqt14A2T/n7K9QNGkiTrtvNWWce2qBfJyP3tTU
         mUfd8ZUNqPA39DI8kBOZzeOaMvaoqrWGeqzFgXTLlX/uvcQtAUqazG46SW/RpixmhZhR
         MXoIQfYlhUEzta1ZmmwlXi371/xVUel9IK2sWrqRaUHXgj/gIIGcNeCmG24kkCQaHNa7
         l5AuRcD9CNIN3/iDWJqkoYI8RxnSp8gkEERHKGf6biQletyrutNvpLJQeM+0jl3kZ826
         YI6xzFJt21Cs6oDz8qgGSRzkny9eg65wYOZj792w+4GmXJWMas3amxZAVtXYJHmqQdiB
         iBCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112459; x=1769717259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        b=X/lWqrLz2bQ6qvlxMp7/4e7A3KNMkcvHPGvJrXvIoIFpAaXIC/J52gb0mTswrvGFCP
         qSSVd1czapsgBn9o4IwsRwvrzkDyZFQx/Q7wv1QR4ekmsTMySm+kz1F5NgHYxohKdeQW
         9UBy+879Kpi1tgCxNhjuYt8DS45VfiBkOyHJO/2HCOK97WnN26k3ENKaWBrgHO+JG8UL
         BEq6qWIJt7oQcNqg684IBIHDoze+DmC0pRYl6PWRXWVulbGGtM+GXeZOX3icPwGLoZvy
         F8yBwJU6ABDv/T7C8paHIdvH8dD98D8xBTj2IE6kxogY0Puri6AgRf99EEFaozcudOgy
         Dzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112459; x=1769717259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        b=QAAK0Q/VuEIhV4wHzlGhMOicgDw6LmB4ur05iExi9bWIthC26Rxp1ROh9GWCYIgeo6
         ZA20i0abW2PzEzBrpsmp4NTrHejGm0S7fQmm/jGO4GMp9Do6x/k0/BZZWRf5qKE5nqzf
         Ob+AR1bUhQbQdaOdBYxuPtNkzSMpXWqz3KihghkF9RaSOKOxuS/A7J/TBKj6sVrECpq8
         lQ5DUb7GLTAVTOoEHt319TcZW0DR+vHCXdHy9sAlBK3DhduxIxBjNnCXskme2f4ZqXoG
         Ey8BXHuPbZ7hs4j/tl4tzShXo4VZZ5BklavyQoi68BslOM6wC8pVj50nMgdKscqhkpEt
         3mmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0lIHGYGyD94+ax3ODKNZiWdRuXp8WzJwcUCeWk7ccZBazRGpFls2BA/DsFrXwFGx9VIvCQUAg7MCg2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqq2RH7bN8tNOxz4bqjHiqsFoL2p01g/rn0EW2aLH5F1nvNwX
	52qOS9DHdSenlqnyGqaSndpM5bp6cEj46cGx4uIwwpcTT40VfppMceqB0YFfvJ1dpCPDRKbbJdU
	H7Zg7JJ9PxZqf8QP1HffzXiEfQ8TA0Kk=
X-Gm-Gg: AZuq6aKyTc1q/vsZuuSUf/gjdaoCqZp1CMnNd4bdv8HFraMZBdExTpjuUm1IFoJgLr6
	VZUV9AU6yjQ1Notn9IAt8y0D6bWM3xzaLi/i+WFmnvhpwyGYEbaj8RfzpnroD91lKrWDY6VeqdN
	QUDQP0AwkuAQJKPBUezyZ3R/D7xbNzrvt43VPQgGQuyTTNNwrWDJ9YLDt0ALaqfcih92vABNQnP
	nVyoBm1rqIZGwVJaAKSQXK9M0aJzOQWz8k57BeFA1Wy1hmbIS9yoTh42YYp04GTMCSt08iROH9l
	FfIQuUaDiIEMkCplqIW63j8tGcy/yKIoVI2htA/O
X-Received: by 2002:a17:907:70a:b0:b84:42e5:2b7e with SMTP id
 a640c23a62f3a-b885ae682a6mr30056466b.51.1769112458391; Thu, 22 Jan 2026
 12:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
In-Reply-To: <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 Jan 2026 21:07:27 +0100
X-Gm-Features: AZwV_Qj-Pre4XZbhvcFXr13YDWLuhkhhzBZFRQumTLtcoMVU1rOesRZLphknff4
Message-ID: <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20917-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CF69F6D560
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
...
> > Actually they are not in the same fs, upper and lower are coming from
> > different fs', so when trying to mount I get the fallback to
> > `uuid=3Dnull`. A quick hack circumventing this check makes the mount wo=
rk.
> >
> > If you think this is the best way to solve this issue (rather than
> > following the VFS helper path for instance),
>
> That's up to you if you want to solve the "all lower layers on same fs"
> or want to also allow lower layers on different fs.
> The former could be solved by relaxing the ovl rules.
>
> > please let me know how can
> > I safely lift this restriction, like maybe adding a new flag for this?
>
> I think the attached patch should work for you and should not
> break anything.
>
> It's only sanity tested and will need to write tests to verify it.
>

Andre,

I tested the patch and it looks good on my side.
If you want me to queue this patch for 7.0,
please let me know if it addresses your use case.

Thanks,
Amir.

