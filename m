Return-Path: <linux-btrfs+bounces-20933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN6FJAjhcmkTrAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20933-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 03:46:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A26FCA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 03:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEB78300DD77
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383003644A4;
	Fri, 23 Jan 2026 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="owAXnWC7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7130BF78
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136377; cv=none; b=N28O/gM6cvg0EaVdkah+pmJQPZyKFHkH92oJHAiNkzcP7JwH7D4srgwa5D36HCrMUR1XeZrZaQ/p3k8QPTGjcchYujxng4eeGbY8PH1XuqGD+FU4EDLoeSfJMrsHrbfVwOezlhdYZnpWJTX9Ws+o3O8xHMt4rVevKYZoeneXuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136377; c=relaxed/simple;
	bh=LnxfWfv2tcuf9qquh1GZbN6iIIAOwUJLXPtRV2gVOSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py3K80wHzo+PRh0ZyxoU85lxqD0PnGc/pyF6avLdiuMCyCGwj04nKCAOrFdafOIaOmOwcnx9kMIg4Iy7QeA8I35q6gWqampI93ElauzQW+71xLCFX7Stw0tovdKA97tR9wbGsrco8engJlIHuo4ib9qPmtxHA6sDd+9CYX0ayIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=owAXnWC7; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4dy2P066lGzG6nbP8;
	Fri, 23 Jan 2026 10:45:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1769136357; bh=LnxfWfv2tcuf9qquh1GZbN6iIIAOwUJLXPtRV2gVOSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=owAXnWC7IfM6qiP6rA9viWvXPfQOkX/6vukgUYlNmAwVIVQLOLvEcb3EjHs1YhNcg
	 homzvzTA6RSHd17Ndgb36TUtmSdnsiMcFZ3SkOw6IRcbFJuT0PfUFeaDshSV5yIdWV
	 TUyAluvNb8EDdA6mi/TTqmONZoyt6z1cQEAGnXQY=
From: jinbaohong <jinbaohong@synology.com>
To: fdmanana@kernel.org
Cc: dsterba@suse.com,
	jinbaohong@synology.com,
	linux-btrfs@vger.kernel.org,
	robbieko@synology.com
Subject: Re: [PATCH v2] btrfs: fix transaction commit blocking during trim of unallocated space
Date: Fri, 23 Jan 2026 02:45:55 +0000
Message-Id: <20260123024555.525434-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAL3q7H69QyeobkY-+YO9JsCKfrQ1EYeZN0fVOFFkkC5fXh90SQ@mail.gmail.com>
References: <CAL3q7H69QyeobkY-+YO9JsCKfrQ1EYeZN0fVOFFkkC5fXh90SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20933-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jinbaohong@synology.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[synology.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,synology.com:mid,synology.com:dkim]
X-Rspamd-Queue-Id: 535A26FCA0
X-Rspamd-Action: no action

> > > @@ -6564,21 +6681,12 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_in=
fo, struct fstrim_range *range)=0D
> > >                         "failed to trim %llu block group(s), last err=
or %d",=0D
> > >                         bg_failed, bg_ret);=0D
> > >=0D
> > > -       mutex_lock(&fs_devices->device_list_mutex);=0D
> > > -       list_for_each_entry(device, &fs_devices->devices, dev_list) {=
=0D
> > > -               if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_st=
ate))=0D
> > > -                       continue;=0D
> > > -=0D
> > > -               ret =3D btrfs_trim_free_extents(device, &group_trimme=
d);=0D
> > > -=0D
> > > -               trimmed +=3D group_trimmed;=0D
> > > -               if (ret) {=0D
> > > -                       dev_failed++;=0D
> > > -                       dev_ret =3D ret;=0D
> > > -                       break;=0D
> > > -               }=0D
> > > +       ret =3D btrfs_trim_free_extents(fs_info, &group_trimmed);=0D
> > > +       trimmed +=3D group_trimmed;=0D
> > > +       if (ret) {=0D
> > > +               dev_failed++;=0D
> > > +               dev_ret =3D ret;=0D
> =0D
> Oh wait, there's a difference here from what we had before.=0D
> =0D
> Before this patch, every time we failed to trim a device, we would=0D
> increment the counter and continue to the next device.=0D
> But now after this patch once we get a failure with one device, we=0D
> don't continue with the rest (and the dev_failed counter is always 1).=0D
> =0D
> =0D
> =0D
> =0D
> > >         }=0D
> > > -       mutex_unlock(&fs_devices->device_list_mutex);=0D
> > >=0D
> > >         if (dev_failed)=0D
> > >                 btrfs_warn(fs_info,=0D
> > > --=0D
> > > 2.34.1=0D
=0D
Hi Filipe,=0D
=0D
I think the original behavior is actually preserved here.=0D
The original code has a `break;` when a device fails, so=0D
it also stops processing remaining devices on the first=0D
failure, and `dev_failed` is always at most 1.=0D
=0D
The new code preserves this same behavior -=0D
btrfs_trim_free_extents() returns immediately on error,=0D
and the caller increments `dev_failed` once.=0D
=0D
That said, do you think we should change this behavior so=0D
that trimming continues with the remaining devices even=0D
after a failure?=0D
=0D
Thanks for the review.=0D

Disclaimer: The contents of this e-mail message and any attachments are con=
fidential and are intended solely for addressee. The information may also b=
e legally privileged. This transmission is sent in trust, for the sole purp=
ose of delivery to the intended recipient. If you have received this transm=
ission in error, any use, reproduction or dissemination of this transmissio=
n is strictly prohibited. If you are not the intended recipient, please imm=
ediately notify the sender by reply e-mail or phone and delete this message=
 and its attachments, if any.

