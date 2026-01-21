Return-Path: <linux-btrfs+bounces-20870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MEQJChFcWlrfwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20870-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:29:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD65E0D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9FF94E57FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970232FA2A;
	Wed, 21 Jan 2026 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GX6qgFQG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1780426D37
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030902; cv=none; b=Dd9/RoPbvEsFil5XzeaPNd3E3XImSdga23fliVjlclaMmyWCVsPi06U3VVzUuP4UPD7vTSdppwVJruqjwBRbT97EeQdyvOEhVW5OlnGflbuf1GQeiq8lxAdpWjeWqblgu0XTHVM3uMqXViDRQj+uerP7VUHzyDZYczb/prfYD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030902; c=relaxed/simple;
	bh=x4q9nQdRL8K9YKL4MzUDQhW3gdSnZJphGDGgxGIEIug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+OlWRIedc+e6vC4clIhKEfjK+e8b57T08oUpmsOb7YKGM8Ci+n0Kr6UD3EtOPaCr8AJRWdEuJOj9z4GWRIWYjYnXGQ+ZmMsJ9aHGQHUNxM2JxwtkDDTQmrIbiJC+4VBJPK5WQ7fmFXbzlh7tixb7acM8WsSAqf/MO58DdyhAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GX6qgFQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D16C19424
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769030901;
	bh=x4q9nQdRL8K9YKL4MzUDQhW3gdSnZJphGDGgxGIEIug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GX6qgFQGe50sMCRvz9CMB1NAR8AxRNNLCUNhOLSaO1lDFKZs9xjq1W8/KbAsHA6Jk
	 tPBX9a0nyX/X4MRWZhSbBVtWoLg5Sec4/AeiwNSh9VvznWsBa70191QyUQNnMOX51V
	 /ElOGiB79bOAxaJym4GVpzVjlwuF66V9FQTWdJRge4IPN8B4HPWZzQV+0bjH3KY0g6
	 MOV817nCprtwUW8hJy2GwDa7iqm2psr9XAkjcYvf0RRO8cnIkJR7AA5TeRAAf5I3CF
	 FUsGxrC5roawmY4kBkRpXLXB8VI5KWXDJf1IAKhtoGb0hbLr/pfGBss1ZN8IWwYL2W
	 FjAklc0YvLDMA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-655ae329d6bso539441a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 13:28:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1NXjm+A1Us1TYvmhd7YY9xlCXZrNrfY0KYJQXJd6xgwo9I7RM8N7Wmo8dLsyAayiT5jHIKc0wj8dlNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOLTCc7tXkMgAJLKOERD4djxmDRgo9iM2bX2uq0WheX011WCd
	Fh76gVFsMN+CVY0arHfgX/NqoTBsdKXUTNB6c3pz2jKyFMS3IIJtI9/6MKzEMVkBXEit2wG9jli
	LCGzXwegJOuxpVkcC/dCRCu7uACVfjZQ=
X-Received: by 2002:a17:906:c147:b0:b87:2c88:ce40 with SMTP id
 a640c23a62f3a-b8796a55942mr1778224766b.27.1769030900429; Wed, 21 Jan 2026
 13:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768714131.git.wqu@suse.com> <86b8394ca75b3e8ac35b08e8ee8b4617d5f44331.1768714131.git.wqu@suse.com>
 <CAL3q7H6dBONyBSO08RjH_K3fWHOLFwQ7aRQrGMUTh9xebn_eZw@mail.gmail.com> <452070b2-ba54-4136-b45a-fe385cb5a73c@gmx.com>
In-Reply-To: <452070b2-ba54-4136-b45a-fe385cb5a73c@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Jan 2026 21:27:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H78cuBHLLOiLCrZHYwhCXTkuLtCCAM5M4=-67Ev9jUmng@mail.gmail.com>
X-Gm-Features: AZwV_Qi0ymVlCvI1irH8I1DGdvKF4PcY2tJJ3Q7_cywTP657KE7RgYbhdEbjUEU
Message-ID: <CAL3q7H78cuBHLLOiLCrZHYwhCXTkuLtCCAM5M4=-67Ev9jUmng@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: tests: remove invalid file extent map tests
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-20870-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,gmx.com:email]
X-Rspamd-Queue-Id: 4FCD65E0D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 9:05=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2026/1/22 03:39, Filipe Manana =E5=86=99=E9=81=93:
> > On Sun, Jan 18, 2026 at 5:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> In the inode self tests, there are several problems:
> >>
> >> - Several invalid cases that will be rejected by tree-checkers
> >
> > by tree-checkers -> by the tree-checker
> >
> > Also missing punctuation at the end of the sentence, and this is a
> > pattern in every first sentence below too.
>
> It's an item of a list, not a full sentence.
>
> Remove the "that" part, the item is just "Several invalid cases", why
> you want to put a punctuation for something that is not a full sentence?

The way it's formatted suggests it's a full sentence.
Leave a blank line between that and the rest to make it clear it's not
a sentence.
If everything is stuck together without spacing, it's confusing.

>
> For a lot cases, we just want to express some short values/items without
> a full sentence, and there is no subject-verb-object at all.
> Thus I don't think we want to put a punctuation for everything.
>
> [...]
> >>    */
> >>   static void setup_file_extents(struct btrfs_root *root, u32 sectorsi=
ze)
> >>   {
> >> @@ -100,40 +103,49 @@ static void setup_file_extents(struct btrfs_root=
 *root, u32 sectorsize)
> >>          u64 offset =3D 0;
> >>
> >>          /*
> >> +        * Start 0, length 6, inlined.
> >> +        *
> >>           * Tree-checker has strict limits on inline extents that they=
 can only
> >>           * exist at file offset 0, thus we can only have one inline f=
ile extent
> >>           * at most.
> >>           */
> >> +       ASSERT(offset =3D=3D 0);
> >
> > Err, what's the point? We have just assigned 0 to offset right above.
>
> Already explained in the commit message:
>
> - Super hard to modify sequence in setup_file_extents()
>    If some unfortunate person, just like me, needs to modify
>    setup_file_extents(), good luck not screwing up the file offset.
>
> If one has to add/remove some file extent items just like this patch,
> @offset will be changed and good luck counting it manually.
>
> The ASSERT() is an explicit way to tell what's the current offset.

As I said before, there's no need for the asserts because the comments
you added, right above each assert, already keep telling us the
current offset, so it's not like we get easily lost, far from that.

If we need to change the tests and mess up, then I'd rather have the
test fail gracefully rather than an assert, as the latter requires a
reboot which is annoying.


>
> >
> >>          insert_extent(root, offset, 6, 6, 0, 0, 0, BTRFS_FILE_EXTENT_=
INLINE, 0,
> >>                        slot);
> >>          slot++;
> >>          offset =3D sectorsize;
> >>
> >> -       /* Now another hole */
> >> -       insert_extent(root, offset, 4, 4, 0, 0, 0, BTRFS_FILE_EXTENT_R=
EG, 0,
> >> -                     slot);
> >> +       /* Start 1 * blocksize, length 1 * blocksize, regular */
> >
> > End sentence with punctuation (done in most other comments below).
> >
> >> +       ASSERT(offset =3D=3D 1 * sectorsize);
> >
> > Same here, we just assigned sectorsize to offset right above.
>
> The same as explained.
>
> It's easy to grab the offset for the first one or two items, then please
> tell me the offset in a quick glance for the last few items.
>
> Thanks,
> Qu
>

