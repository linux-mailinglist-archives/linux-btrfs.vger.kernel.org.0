Return-Path: <linux-btrfs+bounces-1031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C118174F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C66B20A8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA204FF7D;
	Mon, 18 Dec 2023 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf55mon5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447A3D55D
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702912418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIMwQayTocIbXXFB3cUqn/KkHxtVXnjHRr7rf/O91JQ=;
	b=Cf55mon5IR9EplSa3z/fGR7MEtgELG/ADCdGVtVllemtpSwJtkHd1Bk8iqdX4FSuBuDNdV
	8F1GLihonCdxAa4FhRNFAPTrY/4vrIBBS02YycefXxpysjby9+B6QC2ooPpTJXx+4qEfh9
	boP+MEzy6WRbUTHf91Ym9FOtmyS46AA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-AAzmrDX_PsqPvqe0YWxGDA-1; Mon,
 18 Dec 2023 10:13:33 -0500
X-MC-Unique: AAzmrDX_PsqPvqe0YWxGDA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E2DF1C3B648;
	Mon, 18 Dec 2023 15:13:32 +0000 (UTC)
Received: from localhost (unknown [10.39.195.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B3531492BC8;
	Mon, 18 Dec 2023 15:13:31 +0000 (UTC)
Date: Mon, 18 Dec 2023 10:13:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/5] virtio_blk: cleanup zoned device probing
Message-ID: <20231218151330.GD12768@fedora>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="On1+GVONns+1Tsy+"
Content-Disposition: inline
In-Reply-To: <20231217165359.604246-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


--On1+GVONns+1Tsy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 05:53:55PM +0100, Christoph Hellwig wrote:
> Move reading and checking the zoned model from virtblk_probe_zoned_device
> into the caller, leaving only the code to perform the actual setup for
> host managed zoned devices in virtblk_probe_zoned_device.
>=20
> This allows to share the model reading and sharing between builds with
> and without CONFIG_BLK_DEV_ZONED, and improve it for the
> !CONFIG_BLK_DEV_ZONED case.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 50 +++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--On1+GVONns+1Tsy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWAYZoACgkQnKSrs4Gr
c8ghLggAkEix1k19H0+c3tEJu1E4EkpJgKqmkCFOamfXYjdMpZVQ2JUrrJra8skh
+jn6R4S856v7Gq+lQBNU9/9y8U20DnbyRMRWTj6+PUM/4Gl1jeEoqBMsa4Nnp0eO
5DU3brD2tHdYNth+52xs7kEUw4NK1nYMhiZll1jDXtUTPJFkUKlc7hKxH8pmkFbK
hJRXzMDWQjo68HqPajZN2QcHndBeUxQbbc2RnlgglFRb8coXAy5R9A4thpi98CQl
or40ftC6n7KNJxSCPDTOlUTQyh+ILbMVSrde4ApNmhmKlHSJiQHa4N/whdBVzdHc
CGaO9fv06GfH0SrPsfvGTTLlVCj2og==
=1h9j
-----END PGP SIGNATURE-----

--On1+GVONns+1Tsy+--


