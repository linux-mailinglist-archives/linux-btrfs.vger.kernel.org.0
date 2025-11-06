Return-Path: <linux-btrfs+bounces-18790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9FC3DA9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 935384E5900
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B69304BDB;
	Thu,  6 Nov 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr31QAM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71B2BFC8F
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469127; cv=none; b=UVldq8xOHGAd/VhfgH7RRzV7G30yEpPQBvBgPaxMd5P3+Z3dQl4ug/UkKFpbhNbCMSDblAN6rqNbBT2syoGAf5M6KFO8oDjZ/Hx2hGcmgBtSygk3Km20NkFQT9/7gmo5IpOORU17w4ZC+52fwNDRIxBUQ4lY7L+zDtLvGT3B7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469127; c=relaxed/simple;
	bh=Kj7L/JoteussUtrMuiOUkeUCz1231nsiaY//CCih+oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezbexWOYpEjW/tXm1nxSIkUp9a9S/bWtRpAJ734expU98+QDCMBzx0UTQ7y8eTEPjxl8ilKKs4QJcjwO1mGLbZjb4wgxCXgOqnU2xw9sLpvYy9TXRSb+3g/tekiWeXKm/SpvEvf1vPb0O6cEVF47KzEHdoXdMaFZnDWc31VsCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr31QAM+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b725ead5800so20498066b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 14:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469124; x=1763073924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUfz41rKuREMh0nHSJBfGEW+5nz2bBYW7luVm/UbHa0=;
        b=Lr31QAM+VooQSWmqA7pb+2xw5ZBEr+9WcZn9eRqaFc6iQJFG9Qfd+X7hVEuerWcz0F
         RpjZpoWMpddfVfhsXy9hlGh81Is3UqZFTEnWY/oQ6Rxs45dzd+OlI31dLBnhtq+oz855
         r5fn9wTI4aOHliHRRq8sstRQGo/AsvE5emPMO/tS/enR3+3mbuKRUSbNa9rPF45lLOEZ
         SQx9dFoaNv7qhs7CQr4FLAsndJXkW1XGOYXJG3nTkf2IETc8h4R+OU7ZP9MS7qDBO608
         t5WGuuoSWVGLzdckBNl8F94kMdATCdA8YvuGR0RdT3bC97J/gNq0iKRyOooUGhGZzh4N
         xP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469124; x=1763073924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pUfz41rKuREMh0nHSJBfGEW+5nz2bBYW7luVm/UbHa0=;
        b=MlF48xw4RpTOR+Kj9hdwMSmIGJVD9nnS40qc1MIy3McYcfXkxRDiYSF19rYNqCRetQ
         CzcpUqkV1NgoXwh+AOMvv8ghZPINjvYGqrWvaGdK1DTXfzLdqcKF8WOSB6I3sd47ksfG
         8oyFcbV6aUO8YZrq51I/6FaF+NFiXBJEUfMe6pnb/ukzndPy49S4T3wJ2/PALtm8yezU
         buuKPDx4bUd/9aAg2iNCOVFr0N7OP+84ziKOegFl04TJ10hm9jVQOrOZqaOAHra/jrz3
         q9aZWwb3T5ycHlhbdqL9qqFJhkgAntGSeF2Pdfzl9L9WREbTtQoeN7yjly/mdsyO1gYw
         xDqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9GSTx0rxtxx9cNXrrPLcKcYJIa8mU+DwWF3gI07CkbY0jp7h+7wPi+3ng9lrygm5/78p2xpsr/1zC+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywil4RMkxaG9N1pgURXZ/uhi/DSyu1xVZQWIGjKmrbLq3PpuoB7
	fk3gYMm3jkPscSFB3PY6qRNhHWKd8UXXsFUmqiMMwXaJ4b8mTRYUJt8tDwrQ+oSyUVAdV9dUXUt
	xndniLHSD1vHYc561WSibuB7xXsUZKy4=
X-Gm-Gg: ASbGncssNlelQSt7auX0/y2EAntmZJ/c9kTzU58Jyfp5whmdQuoP30sk4ZzXNglQQGW
	ELL94z8LfRUEV36I83khTQxORzQp/w9f2SCqGANRoNxZRsLA7HO98UHEkHcTLgJMtvINkM4ZD6R
	pk2FY8FY1q69vxwjmoOOs+CdJPjQ3nhCeJ/ClMTe176RbPfcz1gxcmL4TD4NUVwBE0Q7vD2xskz
	aeekiO0UM5mXRhZQX0S5O461FchwYrB9zw7cBSagQO+01JSDQSfZxTKPEkUdZc/x2fWXmiiWbsG
	c8wI2TJp/TraPx4=
X-Google-Smtp-Source: AGHT+IE1qNQeM6UNmSBXesdkr02iweAms7ORTPSsp7nud8TCG87j4H4bFwSZ+4tnLWx7vun6NeNBh10cXoufvTHgCHU=
X-Received: by 2002:a17:907:3d90:b0:b6d:608c:838b with SMTP id
 a640c23a62f3a-b72c0e4edfamr91970966b.45.1762469123485; Thu, 06 Nov 2025
 14:45:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106180103.923856-1-mjguzik@gmail.com> <20251106180103.923856-2-mjguzik@gmail.com>
In-Reply-To: <20251106180103.923856-2-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 23:45:11 +0100
X-Gm-Features: AWmQ_bnCIam01HvuU8t32Sb1QrZNB96FnlFfUeac_QERoZe-IxToAZP5arZqIJ0
Message-ID: <CAGudoHFs7-mRfjuMQ8skA23Gg7uxCSGqJgXnyrcKz-ZBv8ALCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fs: speed up path lookup with cheaper MAY_EXEC checks
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 7:01=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 4050942ab52f..da27dd536058 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1135,6 +1135,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>                 error =3D -EIO;
>         if (!error) {
>                 fsnotify_xattr(dentry);
> +               inode_recalc_fast_may_exec(inode);
>                 security_inode_post_set_acl(dentry, acl_name, kacl);
>         }
>

I just some found I missed some spots which need to call
inode_recalc_fast_may_exec().

I plugged them locally, but now I have to chew on whether this is
worth the potential bugs.

Preferably there would be magic catching all changes to i_mode and
acls requiring inode_recalc_fast_may_exec() is called before the inode
gets unlocked.

I'm going to play with implementing inode_permission_may_setattr which
starts with explicitly checking for i_mode being available for
everyone and no acls being present, maybe that's already almost
entirety of the speed up with no woes like the above to worry about.

