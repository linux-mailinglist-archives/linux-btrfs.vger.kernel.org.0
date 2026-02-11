Return-Path: <linux-btrfs+bounces-21629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICotOG2gjGmPrgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21629-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 16:29:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68129125AC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5954D3024A3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6B2E6CA5;
	Wed, 11 Feb 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Za3RmX8b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6ERQ+4A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECB7081A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823777; cv=none; b=MEd3UCQVTX4Oq0LbV1IyfjeL/UfrA6koep6RR0lZhInBY8xiwpkk9Vqd7mfDjY76eLYwMxyLj0Hsx2hnCxqYbq3a7BJheU91KsVaiUau5GnnQFFyXKeDxf87uX1/ihSMbQ53nPJdpk5S+xj4kSgHQh55TGJ3hR5VkEimShaWx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823777; c=relaxed/simple;
	bh=b64Xf2zMu8Hzoy98Z5bfuIchMV2mBnZdtWtUVUOjN1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Fi0yTYeNvFfpZ/7RWuk+BdET+xjmU2m/hTxt5bIu5Iss2FIDZV3IcKU7uOalv96AUpNxivIcOTOmnnD/LfkbKsIF3Ysj8okBJmpcpFyr97J0L+RyYwi6FSmDbHemqwGsfAJv3h5EuVPaqVX7rYE7ugSiWH4AhHoIdkEhHWKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Za3RmX8b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6ERQ+4A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770823774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkZ0GRM5BgRNWScOudCv1dn4NmDkxX3Pikw1Zb7kdI4=;
	b=Za3RmX8bHtuVL6tnJTJ8hj4KR/qMWTSNiz7byaw0O5Je+gKdc91OCCR4Uqt23Rt85yxqB0
	G8XbTqZv0wPcHP7onmQqJQk1TIi/1tsKhENDECfKFsBm4sFWHn3HHD1rFE4WBY6c1D8+bA
	rIzzYTBH5LtIKR/NtswsvYLlZK5bGpQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-X9ZdFVflM4SrurGeBbwzdg-1; Wed, 11 Feb 2026 10:29:33 -0500
X-MC-Unique: X9ZdFVflM4SrurGeBbwzdg-1
X-Mimecast-MFC-AGG-ID: X9ZdFVflM4SrurGeBbwzdg_1770823773
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad60525deso105004045ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770823772; x=1771428572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkZ0GRM5BgRNWScOudCv1dn4NmDkxX3Pikw1Zb7kdI4=;
        b=T6ERQ+4AaOdAr+XvXqjxGDNDdrvwPfNNHyQtbS1M+QjwfujXTV9SQlvWMHUXKtJeZH
         IbJgSCAk3AEqdyMWkffKTCB1EqJaKbHNpAPrnUBVfKhHa91YoLz2/V7wzfVvu+q/393V
         0chltElA3Jl7C/JDcSFepk1ny+S3LaZEx2H6oQDNPuYoqj4r+/+IJS6UMbnpV+Dz7HtC
         f1gQ8UosbJFXr9pIIzyiqGXOsX009AVcYhztFnB8Jfv+Inh2aZaGSjWKHTvySQwWTDVF
         eDy8NMNleSxErH4lk/Qsx00YHJ9UJcQCx78c/OPVTxn1fL2StbOo+bQzjWhdy7iqhMbB
         PREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770823772; x=1771428572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkZ0GRM5BgRNWScOudCv1dn4NmDkxX3Pikw1Zb7kdI4=;
        b=uRMAm5iKJqz0y+U3OAHB2p1pi8DVXC5IutPc9NkZOalXTuZZFgk0ZoLimhIZiA9DTw
         pqRChlu7IVWSJivvEwMM8JJnQM3we4F4HZ7SyU0I5CwBtzDJq5mqT/eytxt1yMFSVwlv
         h0E8WvzHheNKTZoymMDAjSvV5qNU9ev1VTnTR7HiQVQJxb4dHSOs05+TODawDHHu2lzS
         6C6WQYMS8b41cwWQ1hkaGTujlsovUZkYsuw+spxYrFfa3xIA4hlWcFhSArfFXfa4XqZF
         eBs/t0ALIM/y1mxGuDJ9OVuPFUSfbEgOi2NV3Nm0/jq7fkT9XG1n+xFGLh+Iaq3uB9l3
         k7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW9kals/eosSquFWzZhmX8tG/kPKyoymcBRonHM5kjIZ2QDxARIDlvtXoFFXCmN8E1VxJCq0E+Ev2E6CA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56Z+bkG197OQ+3Qm8S7nUrEVZONgPdaN1eEAtftzNr8LcmVl7
	iF79EHKkbAFbgamV2oyxHuE1DuUj/54XJvI/NAVR934Qb5IFMn35506dzyM+3Apx5ijUSKRZNQj
	Izr6XuMjrOuX7uUQ1dI9rFoXoS3MB37J7fWFaM5o6zprEeJRW+WVasluDYnXs6lw5
X-Gm-Gg: AZuq6aK4lRDSujN6Ik8ydEBgcZpq/1byA/8EBbcRwpVER6rv964AS4qWK3qjrmvmmWQ
	YrlOdmJ/eIkoEKayay0myadFepFw+jEiL9eksCozqaJJTZRDwr+QELRK9WPO+qF43Gtkxp7K7G7
	70ihSE6E6yBhGZxOcu3fxUnPvO+c+KCsK2izl2TM8ieJiDfq4w9cVvspvX7CiYsvq276nke88oL
	ZGU6Byr27UOVk3yJhHXpCHnpGhHC5U92AlVE5Lt9o7lPxOI8Hk0O35buDAc2OoGcpcbJcLYT8up
	Vlh3W1vchX7neQJEByiknwLqRW+hRV3eZ2Mq2jV9NLrot1CwOQ59X6q48y7JOBV5NU0tClwQXVj
	nifsmfOtXm0qVW5a9YSlDJK5nbLPdcU6YWchJuoe/PNA5wsivM0G+Jj/ZBkF2Hw==
X-Received: by 2002:a17:903:46cc:b0:2aa:e1f0:5495 with SMTP id d9443c01a7336-2ab2acb68c9mr22395555ad.45.1770823772496;
        Wed, 11 Feb 2026 07:29:32 -0800 (PST)
X-Received: by 2002:a17:903:46cc:b0:2aa:e1f0:5495 with SMTP id d9443c01a7336-2ab2acb68c9mr22395395ad.45.1770823772110;
        Wed, 11 Feb 2026 07:29:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29998b74sm28624615ad.84.2026.02.11.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:29:31 -0800 (PST)
Date: Wed, 11 Feb 2026 23:29:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260211152926.goznos4fsehl6xip@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
 <20260210155123.GA3552@lst.de>
 <676f3219-c4f8-430f-b479-904cbb64d6b6@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676f3219-c4f8-430f-b479-904cbb64d6b6@wdc.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21629-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid]
X-Rspamd-Queue-Id: 68129125AC8
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 03:58:06PM +0000, Johannes Thumshirn wrote:
> On 2/10/26 4:52 PM, Christoph Hellwig wrote:
> > On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> >> diff --git a/tests/generic/783 b/tests/generic/783
> >> new file mode 100755
> >> index 000000000000..f996d78803a1
> >> --- /dev/null
> >> +++ b/tests/generic/783
> > What tree is this against?  generic/783 has already been added to
> > xfstests in Nov 2025.
> 
> Apparently I haven't re-based in a while, should be generic/788 with 
> today's master.

Please always rebase on for-next branch, or you can use a large number temporarily
(e.g. generic/999) to avoid conflict, I'll give it a proper number when I merge it.

Thanks,
Zorro

> 
> 
> >> +if [ "$FSTYP" = btrfs ]; then
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> > Can we please finally clean up all this mess with a
> > _fixed_by_fs_commit <fstype> <commitid> helper?
> >
> >
> Maybe but that's a different topic.
> 


