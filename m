Return-Path: <linux-btrfs+bounces-15338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30FAFD679
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 20:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB176482139
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87E2DECB4;
	Tue,  8 Jul 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="apBFbMGB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1C1E22FC
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999558; cv=none; b=a7YE9kTYmysnE/8Wtnut/lkOWniEFVOZBxDYpZCJ7Z8BUKnDw2xc0sVRsT8c5mcy5krX6J5cXfxS4WSEGDmGZOoGtfW1xv19xidOpoVYO0bVmBp9Xcjd2lWXCvFd/8d84WazfaWor7KhM2mkpC+7CTdPjC9Wh2zxl2V9fNYKpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999558; c=relaxed/simple;
	bh=O1GcTiIi/oWvVrYOvUmB5bjT3cWL6oGGPmNHOi/KSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umlGN53k2H1RBDww9zp6c0AnNb4R/2S9oa/HzpjSCibhEv8aI9OS7+NEfu/BIwmHcYW9f9cMjxeaIY/VrMyp+VgIj+KlkDuiDMePUOrlKGS5nOUSktgA7yspVgpJ1yzcVcnjPAdtFUqhlapbOlH4BlSv0ssIm5nbEzyFqjLIVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=apBFbMGB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237f5c7f4d7so6791925ad.2
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751999556; x=1752604356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG1Wx6OUZ9cQBjqvnO/QEWRp1+n48srDtYVZJzr7dSU=;
        b=apBFbMGB//ztyDe0OTLIySD6nWBigzg6u21pe9kABNcjUVkigTBDqDwIkNDD7YdPy8
         cIOyBUNPLTBB49x8OPMlopbVx2zzL9cy1kJ2b0fSOG8DfR1cbBK85KJHrZZcA//Sqxm7
         syhIJDpFt8TsV7OQdemvqy/kQDvZ7x/VWwETmrbOTxPF7JWfO0sbZTNZPbBeurXJEu9u
         wBqL6QdOMDym1/pK/evEbBefXExykl8kZnYR8/OucfreD9WfcGbIgFp0rvqF2yT1XxVl
         78D3EIvK7ImxqtB2styUH/hrVaYie4YLc6cBIXkmiU/xmpjE5pcBTK4WfJRdx2x2XsQT
         XRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999556; x=1752604356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG1Wx6OUZ9cQBjqvnO/QEWRp1+n48srDtYVZJzr7dSU=;
        b=Wh84OSvaZJ5Xo8dVZeC3Ep4yQngqxSSrRvqbJoGL0W2jXx2NaRpgaSdQ2Hy3FzeXXI
         uP/M52dSV9lkRIw5xUaVbmItF+3vrjeQlC/fldc2OQcDHhUCcMC2QAX9dzedGnJhR52C
         b33svXV58qMgeubevEB98CM8KxfcG2sZZ9r3mHW+muB20lKTtgkTMPPAGDORQvlbZZL4
         gSWJSJ2yz82AFa70S7rUwthFKbVZ47slm47GedJFRNZuSBx8rsHWsKdaBd3CHM246zv9
         t3kSGLj+vsMyozxo1m1aXmJfPtij04j6tWT9Flx66DHPEIBBQ4Cjbp1QkVpbJ/QHgg2H
         Utdw==
X-Forwarded-Encrypted: i=1; AJvYcCVikAuiwE/DWu0FcC9odguHYx2TWL7P2om9IrK9Q1bvZ7Brz5Nassj7PWTReJ/+7p0yiMy8XVc9rOODag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3j4NbusZkgYbmJY9v3WZgahkB9XL6rNrUlLGW3hp1tq1cDGP
	/LJrdEHXZq7R4FNTuvHjlle5QWbfKBXLnUarI2NTbC1kgiJvFwPRABdBj23YF2pO2t8iGIei1+5
	ZqWAVwPIdFZMueAuCXmdPXHu+1VPM/zqJE6Mf14sxxQ==
X-Gm-Gg: ASbGncuyexafgmCXL1O0XQeArkSAeHOXi4dnuG/PSVI+7dbQmxj5ZELJ4Wo3fkd7APs
	b3qClk4H3D1ixNSbVnD5QcKA8y3K5PWPGn6rP08M9TwbvNbL9aVHfMPmQy1zpobR46GYO/AfnPU
	aJsFMPSkFp+S649T5Wz2XRUHbB5M1z7367gm6/enYcxaKj
X-Google-Smtp-Source: AGHT+IGjquqT49t3mk9uGsBdWrji9vx+SHIhp2vhXIPomfvzssP2TLOXJlJDWqiYxr3KiEgZnyLCabCV7oJzVVEChrA=
X-Received: by 2002:a17:90b:3e44:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31aaccd7e36mr9067045a91.7.1751999556030; Tue, 08 Jul 2025
 11:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619192748.3602122-1-csander@purestorage.com>
 <20250619192748.3602122-4-csander@purestorage.com> <c83a2cb6-3486-4977-9e1e-abda015a4dad@kernel.dk>
 <CADUfDZr6A51QxVWw2hJF6_FZW7QYoUHwH-JtNEgmkAefMiUjqQ@mail.gmail.com> <76ea020f-7f57-42d5-9f86-b21f732be603@kernel.dk>
In-Reply-To: <76ea020f-7f57-42d5-9f86-b21f732be603@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Jul 2025 14:32:24 -0400
X-Gm-Features: Ac12FXyEbJh8A-70IJqk1u3VgKtVIrMS8nYA9UhDEjT4t4zZd9AHBYP8tZeznMI
Message-ID: <CADUfDZppvPG9iZg6ED0ZUW_ms1EnNUJwwYyAJ7eCTWsJqa417w@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 2:17=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 7/2/25 1:51 PM, Caleb Sander Mateos wrote:
> > On Tue, Jul 1, 2025 at 3:06?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >>> @@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io=
_uring_cmd *cmd, unsigned int issue
> >>>       loff_t pos;
> >>>       struct kiocb kiocb;
> >>>       struct extent_state *cached_state =3D NULL;
> >>>       u64 start, lockend;
> >>>       void __user *sqe_addr;
> >>> -     struct btrfs_uring_encoded_data *data =3D io_uring_cmd_get_asyn=
c_data(cmd)->op_data;
> >>> +     struct io_btrfs_cmd *bc =3D io_uring_cmd_to_pdu(cmd, struct io_=
btrfs_cmd);
> >>> +     struct btrfs_uring_encoded_data *data =3D NULL;
> >>> +
> >>> +     if (cmd->flags & IORING_URING_CMD_REISSUE)
> >>> +             data =3D bc->data;
> >>
> >> Can this be a btrfs io_btrfs_cmd specific flag? Doesn't seem like it
> >> would need to be io_uring wide.
> >
> > Maybe. But where are you thinking it would be stored? I don't think
> > io_uring_cmd's pdu field would work because it's not initialized
> > before the first call to ->uring_cmd(). That's the whole reason I
> > needed to add a flag to tell whether this was the first call to
> > ->uring_cmd() or a subsequent one.
> > I also put the flag in the uring_cmd layer because that's where
> > op_data was defined. Even though btrfs is the only current user of
> > op_data, it seems like it was intended as a generic mechanism that
> > other ->uring_cmd() implementations might want to use. It seems like
> > the same argument would apply to this flag.
> > Thoughts?
>
> It's probably fine as-is, it was just some quick reading of it.
>
> I'd like to stage this up so we can get it done for 6.17. Can you
> respind with the other minor comments addressed? And then we can attempt
> to work this out with the btrfs side.

Sure, I can definitely incorporate the refactoring suggestion. Will
try to resend the patch series today.

Best,
Caleb

