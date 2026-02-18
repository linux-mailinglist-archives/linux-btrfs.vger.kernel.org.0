Return-Path: <linux-btrfs+bounces-21747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DYqAryolWlVTAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21747-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 12:55:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B63156256
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 12:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 534D5300A260
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96630F93D;
	Wed, 18 Feb 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFjewtGf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C930F7F1
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415707; cv=none; b=D6PLMetKnTwGEWagpZfLs2oZ7KiWfoRnAZILNxiv84H/KiyFAX4N3RN7w2oc4i3vW4qjClPcMP2rCoMtMRVhWMcMuOAcO6rokYldunn/rtWMtf0iBjmPpXjn28XUFyUo2UUzzYzCdMSsy+2JZlQ7u8S1DjP+1nPVrCDrdCi/gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415707; c=relaxed/simple;
	bh=H3SbFsGBc6s0nvtC/pddpr4/mSC3Ksm9lju7J0UROZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLBJCs4XLH8y0FggDRP/RRTjardeA0VxJl0H4RmJpIh4l7MzmgQwyzNxKAPFkpzAeQBz0RGzzgK+LL28yNnV//Ss7f+iH930J7HuBzwLu5/O27uXKy83ECpdl+GFO9qS4PWXNW6FXHyJ9CjsUU0Z5fjYfLldgetMS8Ja93Bpa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFjewtGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B853C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771415707;
	bh=H3SbFsGBc6s0nvtC/pddpr4/mSC3Ksm9lju7J0UROZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KFjewtGfvWg7xEYM9BsRSmPIKXd62wgQpQqzADFwDNQpUMuXMz60yHVi9WJDoqFKw
	 z/iavmD+WDWnq9DhhGyLGd9zIF5JzMil80Enmb5YWKTiQ9Btdg64RB220vhNFzDoYo
	 oxc8v+SzlYAv1qs7qVgfA/D2C8B42QCS2IPQ/8/dySHSTYfIOFnSXEEj2ir2sMlr0r
	 pYAsgEEoXhiOMwt/7WlHHXs4eJp9BPMPY0sh+pLxz8L+3GxHtIlmvZiG8eVL5L8j4B
	 XAZOoTic4OXgW5ywFQ/IB6MkBp0WVntpfUHmhuzic2hqDtvsd6qiSs18/8JoPp8iER
	 B9Obx0MiANqcA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f86167d39so686980366b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 03:55:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4DBmM1V5EDEc0AA3ItCw39or2y+pbU2/1cxxXcI+c81p0o5O40zCInji0WUIETKFBiDHwx70Wr+a+yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZSt6B3TWR5ZxhAODcAwesRVWEDDYW9wclFmoy24Fsni05Uck
	gnL2q+xZZVBt1XnhzXN6IBA9GQQ6XreUX3/JjK8vm8uL3opOkM/BMMQ1WgsE9lkouqOz+xQNv1C
	BjPVR1vc37l/1f/2JXU54OfVB0ww5l0w=
X-Received: by 2002:a17:906:9f92:b0:b8f:87a9:27b1 with SMTP id
 a640c23a62f3a-b903daa5c44mr93423766b.3.1771415706091; Wed, 18 Feb 2026
 03:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216002806.3831884-1-mssola@mssola.com>
In-Reply-To: <20260216002806.3831884-1-mssola@mssola.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Feb 2026 11:54:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4xgLyn5pSToEVj8MiqD4bohDwRYOMPeirqKQgCQ=pzfw@mail.gmail.com>
X-Gm-Features: AaiRm50hARIKWmGDci402arraTpO22AIjkg2PEf6Sb4onsMF23L4j8kb-6e-Hvc
Message-ID: <CAL3q7H4xgLyn5pSToEVj8MiqD4bohDwRYOMPeirqKQgCQ=pzfw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: report filesystem shutdown via fserror
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21747-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 29B63156256
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:01=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <mssol=
a@mssola.com> wrote:
>
> Commit 347b7042fb26 ("Merge patch series "fs: generic file IO error
> reporting"") has introduced a common framework for reporting errors to
> fsnotify in a standard way.
>
> One of the functions being introduced is 'fserror_report_shutdown' that,
> when combined with the experimental support for shutdown in btrfs, it
> means that user-space can also easily detect whenever a btrfs filesystem
> has been marked as shutdown.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Once the for-next branch is based on the next kernel rc that includes
the new function, I can push the patch there.

Thanks.

> ---
> Note that the for-next branch does not include the mentioned commit. I've
> built and tested this patch on top of current Linus' tree.
>
>  fs/btrfs/fs.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 3de3b517810e..92fcebf5766e 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -33,6 +33,7 @@
>  #include "async-thread.h"
>  #include "block-rsv.h"
>  #include "messages.h"
> +#include <linux/fserror.h>
>
>  struct inode;
>  struct super_block;
> @@ -1199,8 +1200,10 @@ static inline void btrfs_force_shutdown(struct btr=
fs_fs_info *fs_info)
>          * So here we only mark the fs error without flipping it RO.
>          */
>         WRITE_ONCE(fs_info->fs_error, -EIO);
> -       if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info=
->fs_state))
> +       if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info=
->fs_state)) {
>                 btrfs_crit(fs_info, "emergency shutdown");
> +               fserror_report_shutdown(fs_info->sb, GFP_KERNEL);
> +       }
>  }
>
>  /*
> --
> 2.53.0
>

