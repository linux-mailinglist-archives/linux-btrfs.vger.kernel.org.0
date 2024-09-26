Return-Path: <linux-btrfs+bounces-8262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC4987524
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC29D286E3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8146136349;
	Thu, 26 Sep 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRfLUbpj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8572E3F7;
	Thu, 26 Sep 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359795; cv=none; b=McBrToEVsYbWGQMGGX45ELPT7a8cIlyVayEyjSO6JmOpnFp3cV8r6/Sq7RPp31czooHfA9+Kwqofvm3qSVcz2m2dHvrUtfSAhivNpSvkZnACF+Eu9loK3KQkVgMohv8ypUUNkgS5kAcO5MXkWaq/6qyQHx4CsU19V/XIe/ZYomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359795; c=relaxed/simple;
	bh=5OVs4ZtVDZXTUxQ1wNV9IUGz0njANUUAWYK3Ofzc3t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WItglpRNIgoZGCOf+ltotd1kwTEx4yonHmHwroRjqabMDFjfdSEcpUUsQin082KaqCJ9TNp+hDdcUg+r56rQZHgMUcuUbxem8HNb8xP/yCcqrcTtAlNQqnYOTwNyUCBhvQXLJXrIStW/cwr/GuNMN9PQ4BRHDHpogdSpzlyQEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRfLUbpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D220C4CEC5;
	Thu, 26 Sep 2024 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727359795;
	bh=5OVs4ZtVDZXTUxQ1wNV9IUGz0njANUUAWYK3Ofzc3t0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZRfLUbpj9eCyQEnVOsyqEXZtD1QAfN6gxdhH67cZkxrjSlpT0I/YHyTxGQO2BMguD
	 9y4cdaDxdKMYwo1D8u25MQrwcXjVSr06wpvHgvA9clStDTFYTftUeI6q+aUDtDUvDT
	 4fe4O494p3j5lH3evkSCle7f9L/m6Ete614MKJRrXr7IuCQPSbx6Z3x88mQHarcOI6
	 O9UvTmWYK3LWtPd6B3kYjVo768hMbjSUIg+p7gf+EdFBhI023/ZeQydAbSbKf4wWdL
	 RNEG2a4iuT0DF6jac9WeAbKhU10MTwkUPnoP4Q6Dq1A8Nl7QnXKdGai1dwzbxXTVru
	 zfSfhBHmsl/oQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a910860e4dcso144339066b.3;
        Thu, 26 Sep 2024 07:09:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVt0alVAvcn3KN1ec9v4nAmi830Wo69EhQL3k7lMhuByr9oI/GNrzYkWI+iEGLMGmgh7i9InfwVUwNlXA==@vger.kernel.org, AJvYcCXyWSlfarkEcbghSgw7J1qk2X/+6Far/foEDYK04REzNAkEA9Wnxwc0DZ/ERZmWtNZz2zW2B6UojI8lKvEs@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4O6T03TPheUFzOsIroq0xQkPMQSF6lMwbXilrOJ+uxsd6rpt
	VqmlRVDfOLAb4cMFtqjrGwwguMAKjGc+HaUFdjKpzaeR49YFiDfghTGjnBA4I4PA/RrQptX1zlC
	OeJ1sQVodjM83UaW8irWw5Qrbf/c=
X-Google-Smtp-Source: AGHT+IHVYHgCtMU8Ncq5nGgrW2FgX2HXxYfeEtIMmlkNIVx7IYe8fceuUDV7JqHRDxjYyHwn+wK+pBMzYsb+C5RKlU8=
X-Received: by 2002:a17:907:7f8d:b0:a8d:11c2:2b4 with SMTP id
 a640c23a62f3a-a93a06768aamr635811266b.56.1727359793924; Thu, 26 Sep 2024
 07:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5vV1MLODuCHr1p4Dx6tMGOMeqxDnTGMsDz290kw8Vsew@mail.gmail.com>
 <20240926135729.4578-1-riyandhiman14@gmail.com>
In-Reply-To: <20240926135729.4578-1-riyandhiman14@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 15:09:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4prrKHKP_Ls-eYhiHtp4x84+d2W189eV4R+KF4V89yGA@mail.gmail.com>
Message-ID: <CAL3q7H4prrKHKP_Ls-eYhiHtp4x84+d2W189eV4R+KF4V89yGA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add missing NULL check in btrfs_free_tree_block()
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:57=E2=80=AFPM Riyan Dhiman <riyandhiman14@gmail.c=
om> wrote:
>
> > If that happens we want it to be noisy so that it gets reported and we
> > look at it.
> > Letting a NULL pointer dereference happen is one way of getting our att=
ention.
> >
> > O more gentle and explicit way would be to have a:    ASSERT(bg !=3D NU=
LL);
>
> I am wondering whether it would be better to have an ASSERT statement her=
e, as you
> suggested, or use a BUG_ON instead.

Please no, we're trying to get rid of all BUG_ON()s in the code base,
and replace them either with proper error handling or an ASSERT, or
both sometimes since CONFIG_BTRFS_ASSERT is not enabled by default in
some distros (we say in kconfig that it's meant only for developers).

>
> I haven't personally encountered a null pointer dereference issue in a li=
ve kernel
> environment, so I'm not sure how the kernel behaves in such a scenario. H=
owever, it
> seems wrong to leave it unhandled as it currently is.

Just add a:

if (WARN_ON(!bg)) {
    btrfs_abort_transaction(trans, -ENOENT);
    btrfs_err(fs_info, "block group not found for extent buffer %llu
generation %llu root %llu transaction %llu",
                   buf->start, btrfs_header_generation(buf), root_id,
trans->transid);
    return -ENOENT;
}

Thanks.

>
> Regards,
> Riyan Dhiman

