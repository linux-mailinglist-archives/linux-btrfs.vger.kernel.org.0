Return-Path: <linux-btrfs+bounces-22139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E9JGSFkpWmx+wUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22139-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:19:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5601D64FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E828301D6BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F3375AD2;
	Mon,  2 Mar 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0+iF6sU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152434FF46
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446652; cv=none; b=c+efz4AdinrFMWMwT76YEOUM25BUMdnYYSEi428PG5YcswpK3yEcLxzmRTuXAPrML2xGAcv/JZLDb0mqgUF2egzXd7TIXJse5ytpK15ZNdL2clWSb3kIvPCgTdKZlhmefKp5VNINVVRLIix5tGdwg4PXzl/l2oQ5SmMWGBlJhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446652; c=relaxed/simple;
	bh=IFYH/xJ2o6ds8cbdyVmtcZsaep3EQC1FlwNvF+OFFRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuX96QmU7x4npiLvVsTl8+koC96I0Sy2qjdFc0QvqLuGWGRYO6+aoMEGnnuKnm2pQOvFN246g6x5CGUgljNBDmDOs6O27RsluACkbbzQRC+F3muIphHEOC+1Ct0/HCZHcX8njEV9xWSvIFzx/ljpn9LbSZXdcroYWDKSqlw4Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0+iF6sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7818C19423
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446651;
	bh=IFYH/xJ2o6ds8cbdyVmtcZsaep3EQC1FlwNvF+OFFRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F0+iF6sUQtfiEHRLEHe+XnsrKH/hrHIB+SKO0z6DXGnk5DRjAQ+gfyIMkWNrep2hI
	 A/ih3Ec7nk2isIgt9eRYXSKizRR8QnrxZ3JpcudQU2Bg5KYzJwj/ORC0IEoP2F0/T2
	 WwBxljp9l9S7o+KrAvHatrNHcsNklMJdmTotIzYJ9aEzJRDcxUQQ7aUXyvEGAE2kMD
	 ODjiuX53KwpvJdSMhWW7MuxY3Lam6NTMOvXJAAjYjyeE2ckEVU0x5Dygax7G2G6yn6
	 d6yhlusE3kqY3hrCU57wIUSpI1CdQJDUaLf1F8zZrTdb0f90OtBjoWCgpPyLvHFsQQ
	 NJC/la7tunA/w==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso8116577a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 02:17:31 -0800 (PST)
X-Gm-Message-State: AOJu0YxuSVAhwdJKHVhkshbDgqRv3QAoj/4AjyLo355NlgOwzT4/xLN3
	67FgCa/2QWMlz8lrPNRS+NzMei4/PCUM6kg1bl2Is2zk4MLeo0abOpq5kL0KO6zc/0NszHe+Qy4
	WjH1pFHqExZKtEZ27HbWqV5HGOuGLYkk=
X-Received: by 2002:a17:907:7ba6:b0:b93:8275:793e with SMTP id
 a640c23a62f3a-b93827584b9mr567935866b.16.1772446650189; Mon, 02 Mar 2026
 02:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301121704.45115-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260301121704.45115-1-shinichiro.kawasaki@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Mar 2026 10:16:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7KgBd7cKMSWLdu2pe-f8SRPCjOhPCvyHrVYDnjsDTr7A@mail.gmail.com>
X-Gm-Features: AaiRm505-Lt64WNWfeYuG_TJl371QwrPJRc7n8jHJXMQnazZyXKh1QswRGIsuJw
Message-ID: <CAL3q7H7KgBd7cKMSWLdu2pe-f8SRPCjOhPCvyHrVYDnjsDTr7A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22139-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CD5601D64FE
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 12:17=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> When create_space_info_sub_group() allocates elements of
> space_info->sub_group[], kobject_init_and_add() is called for each
> element via btrfs_sysfs_add_space_info_type(). However, when
> check_removing_space_info() frees these elements, it does not call
> btrfs_sysfs_remove_space_info() on them. As a result, kobject_put() is
> not called and the associated kobj->name objects are leaked.
>
> This memory leak is reproduced by running the blktests test case
> zbd/009 on kernels built with CONFIG_DEBUG_KMEMLEAK. The kmemleak
> feature reports the following error:
>
> unreferenced object 0xffff888112877d40 (size 16):
>   comm "mount", pid 1244, jiffies 4294996972
>   hex dump (first 16 bytes):
>     64 61 74 61 2d 72 65 6c 6f 63 00 c4 c6 a7 cb 7f  data-reloc......
>   backtrace (crc 53ffde4d):
>     __kmalloc_node_track_caller_noprof+0x619/0x870
>     kstrdup+0x42/0xc0
>     kobject_set_name_vargs+0x44/0x110
>     kobject_init_and_add+0xcf/0x150
>     btrfs_sysfs_add_space_info_type+0xfc/0x210 [btrfs]
>     create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>     create_space_info+0x211/0x320 [btrfs]
>     btrfs_init_space_info+0x15a/0x1b0 [btrfs]
>     open_ctree+0x33c7/0x4a50 [btrfs]
>     btrfs_get_tree.cold+0x9f/0x1ee [btrfs]
>     vfs_get_tree+0x87/0x2f0
>     vfs_cmd_create+0xbd/0x280
>     __do_sys_fsconfig+0x3df/0x990
>     do_syscall_64+0x136/0x1540
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> To avoid the leak, call btrfs_sysfs_remove_space_info() instead of
> kfree() for the elements.
>
> Fixes: f92ee31e031c ("btrfs: introduce btrfs_space_info sub-group")
> Closes: https://lore.kernel.org/linux-block/b9488881-f18d-4f47-91a5-3c9bf=
63955a5@wdc.com/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c284f48cfae4..35e65e277f53 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4548,7 +4548,7 @@ static void check_removing_space_info(struct btrfs_=
space_info *space_info)
>                 for (int i =3D 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++=
) {
>                         if (space_info->sub_group[i]) {
>                                 check_removing_space_info(space_info->sub=
_group[i]);
> -                               kfree(space_info->sub_group[i]);
> +                               btrfs_sysfs_remove_space_info(space_info-=
>sub_group[i]);

This doesn't feel right.

The kfree() should still be there, we just need to call
btrfs_sysfs_remove_space_info() before the kfree.
Otherwise how do you release the memory for the sub group we allocated
with kzalloc_obj() in create_space_info_sub_group()?

>                                 space_info->sub_group[i] =3D NULL;
>                         }
>                 }
> --
> 2.53.0
>
>

