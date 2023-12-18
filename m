Return-Path: <linux-btrfs+bounces-1032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E8817507
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C848E1C23D3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E93D57D;
	Mon, 18 Dec 2023 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKgjjNi8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976203787D
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702912528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izS/IC0DmM7mAVkkRJhi5lj7qvWeAq5t5HTYJWiY8a8=;
	b=XKgjjNi8xMn2Z1uCoStHFsvaJerrFJjrWONvbbZloFiOKEHCKYvoAqNwPdaU5YYfx3xV8n
	mVZCnjGYv4Zdco7B/vRPg19UTojjnIIKRDUyQXopMr425FmHAqHPNikwAuLOghX7MZLN5U
	81DNUCXy8P/yu5UqGTMppPhWkrqDhPI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-7vC1SDkKNxiRJCk_pwFISA-1; Mon, 18 Dec 2023 10:15:24 -0500
X-MC-Unique: 7vC1SDkKNxiRJCk_pwFISA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07FE487A380;
	Mon, 18 Dec 2023 15:15:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CED3C15968;
	Mon, 18 Dec 2023 15:15:23 +0000 (UTC)
Date: Mon, 18 Dec 2023 10:15:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/5] virtio_blk: remove the broken zone revalidation
 support
Message-ID: <20231218151522.GE12768@fedora>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4eVxO+z2jfATvVXq"
Content-Disposition: inline
In-Reply-To: <20231217165359.604246-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--4eVxO+z2jfATvVXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 05:53:56PM +0100, Christoph Hellwig wrote:
> virtblk_revalidate_zones is called unconditionally from
> virtblk_config_changed_work from the virtio config_changed callback.
>=20
> virtblk_revalidate_zones is a bit odd in that it re-clears the zoned
> state for host aware or non-zoned devices, which isn't needed unless the
> zoned mode changed - but a zone mode change to a host managed model isn't
> handled at all, and virtio_blk also doesn't handle any other config
> change except for a capacity change is handled (and even if it was
> the upper layers above virtio_blk wouldn't handle it very well).
>=20
> But even the useful case of a size change that would add or remove
> zones isn't handled properly as blk_revalidate_disk_zones expects the
> device capacity to cover all zones, but the capacity is only updated
> after virtblk_revalidate_zones.
>=20
> As this code appears to be entirely untested and is getting in the way
> remove it for now, but it can be readded in a fixed version with
> proper test coverage if needed.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 26 --------------------------
>  1 file changed, 26 deletions(-)

Fair enough.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4eVxO+z2jfATvVXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWAYgoACgkQnKSrs4Gr
c8j5vwf6AvyDGx3q65J+QlDbrJwPqdAlJ2qDdjwPYSEIgUmM+viNseFP/3psEz2K
7bz3oZ0XXwQatvou0SAiQE8KeXitxdlYFTgJGCtnkyxzaBPZzdfSerjifJNpZhYY
5XC8qXs4ZnecdqeGnEkUS+E4DOlZWL/n4VXz3V0fJAgezdOWZe8u8kkQjy4rcFXl
+UqpzgXjuXfTykIPkc0Ij4JFG8uuPCkkQdzTG4o4FcTQbtgS8i41Mp/4Ty1ft3B8
PZTUAwJ8uEnRTwyLvTujtBinZOKg7EuosEoRjZJLIT0QwZFJGHJ4DxUyWwpy+Jso
E9s7jtYaaslUg+4xTvCIUaaGuRBVkg==
=W7fu
-----END PGP SIGNATURE-----

--4eVxO+z2jfATvVXq--


